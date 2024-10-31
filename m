Return-Path: <bpf+bounces-43664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C489B81D9
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 18:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEBF31F222CF
	for <lists+bpf@lfdr.de>; Thu, 31 Oct 2024 17:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7681C9B95;
	Thu, 31 Oct 2024 17:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JvM4hdRn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081971C9B78
	for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730397254; cv=none; b=GH3Azg8V6p8lnxuwVGzkSvz7f0hZgco90ZkGRzgk+GA0SlACN6yvx27Qj+Y4IVuBI7dczqd4frP9wgwYbYiiGqFFUb7vBmQ8UQtlLESKs37axA7He2/JHY/AD5Q9VQ5hlRVmlV8C7Ct10wqB7fMrCGjmmAU8703ntht0vaXikGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730397254; c=relaxed/simple;
	bh=U/34euNLadQNiLeHmBJte311qUfQZpxY1O9kISbzIhE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBR/F+ArzqafcfyoML7f7V2vwyvtf2S1xkzPYyUPsB2AhR3UMK5HEdS3WTDmLAZNAcdZdiFF0WvCLPno7Aru98mRnBwqVJfFJ2bMmK2obWubhuqPFqIZj69ty5Ji4Jmu1+OO5f5HWL1J0h+gcFqi5vw0rpyOs7Y6Kqtep7i1vgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JvM4hdRn; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b14077ec5aso210961685a.1
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2024 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1730397251; x=1731002051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QrmRsjBiBqT1aqhPDvwP9gjJpnd2yC+ukx4+6jRT+64=;
        b=JvM4hdRngdFBsD4ayCz+0NMJxsb7vhR/GNQlctG1Rxgaez+QVR1kZoNfjbP77kKyK2
         j3lgW9spDG2k1FktM2z5qnqE3AB32qPk0ZAOCEiX63N5Awpzs5jX+gJvmWFKGdK01ss6
         VSm8aOzgEtDlFgFJzRrRD+uVB648al00JXLgZKpZCy0Zag1WQGBl+DZOehL082fx8Ukf
         ++gXzAMlkU4tR8QClyvLw8hpziuzzZaMaJvx45npYMRdyL+5LifPH2yLgp7Zex5BN5uW
         Ucjk+F0XH127Mmc1xK1AsAp6TFY3OQdS6qp5/HOsu3YeR/mjrZiG2LCxtgHZcO9G8xnT
         wWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730397251; x=1731002051;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrmRsjBiBqT1aqhPDvwP9gjJpnd2yC+ukx4+6jRT+64=;
        b=ej3GHXQe+80Fs+Ce37AckjIV1k5O1dZNNKd+7pwb1CfeEw7kZlNC9Pd4xJDNx8ctxQ
         pKCS5/daP4kZ+4PYSiiFJy9MHJma1jTYdrNxRuN+c5XC2SVYZ2NXWGEz7wtiBKdsHY04
         J2ORzu3xuy7mflAZgDje2DES3rxoyt4UldbwN1oVyZ4lvWUcQMq7TxTyUYq/qvehUN2p
         axadH4FAb4abhLKWkA6Os5ddxHh1+LL5K/mHuW7fsf9Lh4eOaLgqDzJlSOoAhpmM7wdh
         WuqEpg6Mmn+9ubU68Cd5nabLe4T8CYbDh8R+4uYEgfx3rCKXTAk/Rv1UCVBGq4/yRiew
         0buQ==
X-Gm-Message-State: AOJu0Yzd7CyX7oe4Pd+4FOMdtofH6Bvy6Ict+T+myD9+7IOEj0iN2nkK
	H+eVdXV0SM3vkaM323916h42PP1SQLZpI9LvBYKHecu1q95aEo7m2tOUT7fqs332gak8cnke6CO
	I
X-Google-Smtp-Source: AGHT+IHKk1Q9ZDoUk2fCpaAv9YrbGfdrFIH/ZMmxvj+9uoGptQZtCRrMHnRNKGTMKuZk34xqKKG1iQ==
X-Received: by 2002:a05:620a:1a8a:b0:7b1:3fbc:c092 with SMTP id af79cd13be357-7b2f3d47cf4mr478519985a.32.1730397250823;
        Thu, 31 Oct 2024 10:54:10 -0700 (PDT)
Received: from [10.200.188.87] ([130.44.212.152])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b2f3a11765sm91295785a.69.2024.10.31.10.54.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 10:54:10 -0700 (PDT)
Message-ID: <befbf29c-ef81-420a-bcde-3056d02869e9@bytedance.com>
Date: Thu, 31 Oct 2024 10:54:07 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Add sk_is_inet check in tls_sw_has_ctx_tx/rx
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: bpf@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net, ast@kernel.org,
 cong.wang@bytedance.com
References: <20241029202830.3121552-1-zijianzhang@bytedance.com>
 <ZyFquswggZxKCYGH@mini-arch>
 <abc69614-869d-42d8-be8e-b4573029611b@bytedance.com>
 <ZyF8LA6v9iAuxNXi@mini-arch>
 <08853817-921b-4595-a7d5-67007bf21500@bytedance.com>
 <ZyJS5UCJu1YlsrJr@mini-arch>
 <0e609f5d-ebee-46f8-b3c6-69672495b4a4@bytedance.com>
 <ZyOy1lbttxzP87KQ@mini-arch>
Content-Language: en-US
From: Zijian Zhang <zijianzhang@bytedance.com>
In-Reply-To: <ZyOy1lbttxzP87KQ@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/31/24 9:39 AM, Stanislav Fomichev wrote:
> On 10/30, Zijian Zhang wrote:
>> On 10/30/24 8:38 AM, Stanislav Fomichev wrote:
>>
>> Thanks for the Ack and reviewing!
>>
>> In order to make it more accurate, I added inet_test_bit(IS_ICSK, sk)
>> check in version2. I just found that sk_is_inet only cannot assure
>> inet_csk is valid. For example, udp_sock does not have inet_connection_sock.
> 
> Instead of testing IS_ICSK bit, will inet_csk_has_ulp helper work?

Nice catch, while testing IS_ICSK bit is sufficient, inet_csk_has_ulp is
a stricter check. I am good with either approach.

