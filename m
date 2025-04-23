Return-Path: <bpf+bounces-56495-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F20C1A98EDC
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 17:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54A64166DBE
	for <lists+bpf@lfdr.de>; Wed, 23 Apr 2025 14:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B500280CFF;
	Wed, 23 Apr 2025 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGFVzsLy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697F1EFFB9;
	Wed, 23 Apr 2025 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420306; cv=none; b=oJmMal772DTpxjqZbWmP8+Jb7MPj4Dt//JPeWvsUy/9qv6IjEq29VmoBr1Gl+m2eMWEUQSx6mwLj2NeQ7FMKCr/AtDIsnFidC26SU8C7RgZhr+vv3Gk88MNrrp54L2aQJgMYeUMJQ37cWaZ8U4U5mITD82/tlUdDwyIJJA92uzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420306; c=relaxed/simple;
	bh=S9fJcvN3L33t0a+klGiBwL7ACNHFHNTiJqEXaJkndG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7cjRYXYxqli2BmQ1cJqI2qKH/e/E8KPqGPc8edwSGq0lVk5otftrolpmppOcRfWSvoBjpiFDKyHFleO1iMGV0Rg6B/4wdDoc6aCBvPurN00wRaLyRBGiQF4qLbVQq8VGJTWk+TBY13rbyXXcK4p8cf1NzHJEZvLKbEwL/qvu9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGFVzsLy; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-736e52948ebso7564964b3a.1;
        Wed, 23 Apr 2025 07:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745420304; x=1746025104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vLD77K+IQ6FNynLlqqQHt03UspZbexlwLay+vuX9rbM=;
        b=YGFVzsLy2+hHINsFWoQNdYO6rpu8+RfzutOf3mtbQ3mINtF3BzTORrEHeyxmTMxmDx
         WLUT21Q/NhztJHZ+zY1p4e9eBIgFuJ6i09ODCFe1IiKwv99p1VlXTAtx23BWiIFJMc5/
         Utev1du037Wyd1iazSUmcrU25dozpiPaz6iP9rFWjC4c0req6TGQtJDcJ+VPojxGZ3Dj
         DI7s5Opjy9r8w9b29Vftyy9dw2f5ujJAiEDafGGyBdxzP+EKHcHUUOT3ES8YAofDwIdA
         l24ws/ckylejXmt//9Uj7p5IV61J84/uxfBzInHPgvLtfUZe4xWTXFzKyRiLNqoWG5Ad
         BJSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745420304; x=1746025104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vLD77K+IQ6FNynLlqqQHt03UspZbexlwLay+vuX9rbM=;
        b=NcJroAtJmzgC7ItKT+JxhTaxEmtmkTw8u7VqstywZh3rlCl+rUbkzOLm67mU18DAUf
         IehYbefESSMytW8vLclGV1wF7tmckiuT/LUPasP59qgqY3Q5POWAZrq9RzOvlaT4KfO6
         KBY1gF6EbohTnw6Ryrj0CLdPEz39Hmq6YePKkhGp2JfrqZJhwSu9/g0H8S5P9rKE5ISO
         tzekcwQCfdh8N2XjxNZB3hC9SAnOxIQRHmkPowS3odJOeDMuyHIPCJ0D7F7HES0meoYv
         HPIPxPpZ2bxj+r7Wfl/KKfoj+KsXDyzKgoZheFBX1A2Jj2ckvKMppJFWOevmYgkL3iRk
         h9tA==
X-Forwarded-Encrypted: i=1; AJvYcCW+h6w+Lfcp2TxAhiozIk/YOZndqM56Z8NNdek30B74xvawzmBnUWwVfFWPbuDYkYTek04=@vger.kernel.org, AJvYcCWyHT8dA6rJeQDZ33E4lgOTpnvuNcJ0E5CPSpt+X8mu27yOvpGomfRRnLFeX0bhZM3gto3Nr/CYib3ECfQI@vger.kernel.org
X-Gm-Message-State: AOJu0YxPslqMZWsjZiAHn8XLAFq+yzo9E+P8cK3CG0D2F6mF78V3T6Re
	ngO20KzsRNhXJnvze3wxgagDuFqQyQplLla84fynZbtyCsNX8qvk
X-Gm-Gg: ASbGncuGakADJW5Yg0uv1s1DxAB0qmJ+W5DLHKNY0VoW3psZ4BkeijaRe9bm7XUaQDQ
	fJymCRKkWaXlUNRJQpb6qtBaon9ZjvisiKRqNQhGfYw5Fr6LoWkdDvhiCCKTN3w98CiZTDcMjBN
	CETY+WxSp8h4cNnmbVnrlX6eFIqKX2z3CpdUiM+9HM2gxUAfQ0DZoduNipp8ChklARA37/vD0z7
	0leeE7+Tpv83FTXZL/xSKrrRm/An18KzzFhgqspz+crIxaIGcSaj7pXRyewWlusasaXuHl2OE9Y
	CqNkK18Dv0PkpMhFd+b6Tptj679azQxDD6t68H2y57+2OS2vzPexzu8fG7QADq/Pvn25wsmFx+4
	VRhXIaHLEEDmZfg==
X-Google-Smtp-Source: AGHT+IFSNwQZbifBFQc13g8bLkeY60199V6rDOLstNyaA0GOx2N/nOcxCZ1CS2lkiG3aLTdTEzVvtw==
X-Received: by 2002:a05:6a20:9f90:b0:1fe:4225:f84b with SMTP id adf61e73a8af0-203cbd55921mr31464930637.38.1745420303742;
        Wed, 23 Apr 2025 07:58:23 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f0e:fb30:933:3ee4:f75:4ee9? ([2001:ee0:4f0e:fb30:933:3ee4:f75:4ee9])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfae97dasm10558954b3a.162.2025.04.23.07.58.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Apr 2025 07:58:23 -0700 (PDT)
Message-ID: <6ed8452b-f370-4443-94ce-f7d65cd51a9e@gmail.com>
Date: Wed, 23 Apr 2025 21:58:16 +0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] xsk: respect the offsets when copying frags
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250423101047.31402-1-minhquangbui99@gmail.com>
 <aAj8DfHJ_XZxrDSJ@mini-arch>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <aAj8DfHJ_XZxrDSJ@mini-arch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/23/25 21:41, Stanislav Fomichev wrote:
> On 04/23, Bui Quang Minh wrote:
>> Add the missing offsets when copying frags in xdp_copy_frags_from_zc().
> Can you please share more about how you've hit this problem?
> I don't see the caller of this function (xdp_build_skb_from_zc)
> being used at all.
>
> Alexander, do you have plans to use it? Or should we remove it for now?
Hi,

I've been playing around to add support for zerocopy XDP socket with 
multi buffer mergeable buffer in virtio-net (this TODO: 
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/tree/drivers/net/virtio_net.c#n1312). 
In that case, I'll have a XDP buff with frags. When we have XDP_PASS 
return, I need to convert the XDP buff with frags to skb with frags, so 
I think the helper is quite helpful. I used it and got packet dropped 
due to checksum error. Debugging the problem, I've found out this issue 
which makes the skb's frag data incorrect.

Thanks,
Quang Minh.

