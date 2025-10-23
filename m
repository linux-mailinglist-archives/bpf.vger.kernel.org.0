Return-Path: <bpf+bounces-71889-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CC943C007E0
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 12:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C268B4FD8B7
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 10:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E4630BF4F;
	Thu, 23 Oct 2025 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y7eON04L"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95930B501
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761215288; cv=none; b=ooBheQm4y6WqnuFQqgmFzW3SEgqA+J56mZldAMbR7PTIaE5Vehlz/eugfP7ydS75M5z6++70BJpuGJCXi37ByJKSszM1JPpp9/RWKjqkTIqx9I6XYBRns3fB1yjIY9I+4F1ZkwqtPOZK87Em1gsv3ZDnpqP76Ztq+D9GvXrBB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761215288; c=relaxed/simple;
	bh=t2XBm2RDZ+fGSLb6wVsJDP709r8nUGdrXh7wf13qD+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nt4F5nF562FmeklzCZI6pxA4Kx1ER5vcLRcLM12luTYrSwIudiwYV8ZOeAYIBKPjXRWhvI1pIpsgPAJEqP16KE4qcajlCirViSPVYMFyGkhsyyHf/O/P0+X+ggAkJw+yBDahjMphtrR4+KdISt4DBhn5Nrckc5dbvVKF7Kg12UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y7eON04L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761215284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s5P4TVWp9LJ4R7S0ueu+xxAf+h+jyoun5/P4L5KQH2M=;
	b=Y7eON04La3cX+jRdjdLcVsEL1YsOAdvk+JImWtqylrIdIf9Z0fIZ/HTScTypsStEBI5i3L
	AX4zEL7QdZQ7sBUA9agf6/XBNJh6673JsbP4+OvwNR8Em1xHbsJtUUsAZh4OUS/e+LXcVq
	RUUDuCQKuZfBgVKgE7/RMUkgn2ucOHk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-gNpbqBC7NhavhXMGqj7-ug-1; Thu, 23 Oct 2025 06:28:03 -0400
X-MC-Unique: gNpbqBC7NhavhXMGqj7-ug-1
X-Mimecast-MFC-AGG-ID: gNpbqBC7NhavhXMGqj7-ug_1761215282
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47496b3c1dcso4549095e9.3
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 03:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761215282; x=1761820082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5P4TVWp9LJ4R7S0ueu+xxAf+h+jyoun5/P4L5KQH2M=;
        b=LX8sQ+YYh0wwOXxlbmK80lv8ybIHLpMoAQ7ms9XTuDM/o8weIZW8VTwBhIE7bJEiGF
         K0+yaH/2UwHTF46eyZoB3PSpyx4TMQoLJfkCzC0//YxS4PP5K1pa/+v8YdHLw673++Nx
         IPoH2D3cZxCRt0qVFx5RvtNqSGprKmD7gWe8qgee9bY6W5v64W2dniUPh4PIHa1rnLTu
         y83Ns+Xdstnjw5BWD/kJRaRHsz6peniBP6IEqirg2RjZJskKJeoxnxf8IBIua3JE3LIS
         CuqHfqaZNjMHnDP/w3r5v1ZlTSmHuWFj2P5FlJsvxf45TbCEJVUU5LBZJJAgf2UdqkCu
         MUmA==
X-Gm-Message-State: AOJu0YwYaMZWQDuZlB4fHDmt0f36KtAfaQ3jTUY7VDvudv1PNB9cDJIL
	JGjUSf3yeYTi/KWFRppjEw5V/vZpyYJxi907KFn91tLQ1wPUj9YbLxD9sL+fxESZ8HebM3pqfW6
	IrsDUoPuWAWZ+uudFZ4oznAotgt0e4uuuT20lQ9R8sqOuYjgeHpvB9g==
X-Gm-Gg: ASbGncsbMHK512NbuzpXUlKY3sjOriUaZjvY/PdkqvBYvnbKYxY08soAnnryIbTGF36
	JsuUxx/UDx6v8PoZTQ+lluIDCgrxmD2lMmMbfFO9MSugTVsAqoke5rMBOYr4H/KCar4CzH9b5I4
	p1WQRATH+kgY8ig3m8KvhM5SB/6NHpmzK79DwnItWQmpuUWYC/0OwyTT85PBMebvvRHPo8C8ldS
	VlygXzn0oxwaSxBWKtms8Pz5oqntZ5zZnf0AQU4Bq/tw8Rb94R5JhzI4NMf5RkbqBLZV7r0g3ET
	bY8aP0D0TQyYKeOhL56PHi8wm4X+3dWmuaOFPes7nVtadxb2sD64Z1fnw1ILWHKbYcwX57MqdrT
	Q9obLuYLGZSuV8q6+nOL4tpoVXymW5L+vCHc+6OnzPIl6V2s=
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr178952605e9.27.1761215281794;
        Thu, 23 Oct 2025 03:28:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGK+0JT31H80kEiGPKgEcv2rVY+0jgTu6VC/4TpxBhsMsHkT8KH9pFxyQO0M1ETPaItKmYWQ==
X-Received: by 2002:a05:600c:3b8d:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-471179174cfmr178952285e9.27.1761215281315;
        Thu, 23 Oct 2025 03:28:01 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494ab11bbsm56657325e9.1.2025.10.23.03.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Oct 2025 03:28:00 -0700 (PDT)
Message-ID: <412f4b9a-61bb-4ac8-9069-16a62338bd87@redhat.com>
Date: Thu, 23 Oct 2025 12:27:59 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/15] net: Implement
 netdev_nl_bind_queue_doit
To: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 razor@blackwall.org, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, dw@davidwei.uk,
 toke@redhat.com, yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20251020162355.136118-1-daniel@iogearbox.net>
 <20251020162355.136118-3-daniel@iogearbox.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251020162355.136118-3-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/20/25 6:23 PM, Daniel Borkmann wrote:
> +	if (!src_dev->dev.parent) {
> +		err = -EOPNOTSUPP;
> +		NL_SET_ERR_MSG(info->extack,
> +			       "Source device is a virtual device");
> +		goto err_unlock_src_dev;
> +	}

Is this check strictly needed? I think that if we relax it, it could be
simpler to create all-virtual selftests.

/P


