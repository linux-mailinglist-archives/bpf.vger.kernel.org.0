Return-Path: <bpf+bounces-15902-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9374B7FA147
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 14:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44ADB2816CC
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 13:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89BF30321;
	Mon, 27 Nov 2023 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="xo0Ukb6m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBEE111
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 05:47:04 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-5079f6efd64so5687970e87.2
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 05:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1701092823; x=1701697623; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=clj5g57Zh839lEaRyt7CSabyzzls9mXT2R3ZlM98bAs=;
        b=xo0Ukb6mcbIt72ZbWZPN0LyZt9gHz3VwQlzOWW3++ch6F8x2N7Lfa9I5jT1BZ9qhzH
         1OeCID9a9+jsPIQ+4LC0W8efnRz2emEX8CWSNFO+nGHBJgRw6ueXtQnXR5EnUu7i3HvZ
         amiNo3x6SCCu93RnP+WEXFRrL5SO9aCBmtTIGpps8XjRaAHfdMzHU9o+cA6vY4c74rK0
         cencRXyVph1ABqWVI2Wrgyt2XzOmLsxC/XfkZBa0rAZjkDgdsXBR3epDERwXNv0liY2y
         AQpqccxJmGey5xMQxFzcNGPdSw8Mxtcsu1rdx6Jc30RTyN5jotBrdoPmn/0DusPPyYJk
         3YfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701092823; x=1701697623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clj5g57Zh839lEaRyt7CSabyzzls9mXT2R3ZlM98bAs=;
        b=wtK3VRbmO8LS4+XdxC2w2qPGC+QzLVnFW6c/8x7BVLKUie6a0P/SZuwUABoIJ0KR5D
         q2HKUgpIfTxn84zluOZjIFMC1S7wCCFp4IZMFQI7dK/0QIQpXSFQOCG6RH7YQ+Nv0MYy
         RV+W2PZhSNNsJxfLKP61jiNXzC7ioqn9CTuXEgj4K1+bOcxK5afVb1pY5/UCsqeqvZ4h
         kAFAPDmb5HQVeg4pZHG9pz/v7YNEbuqJ80abHlvL9O4bjAWun/qpOnpJZipLcriwQRKf
         gM8FSjNhO9Iniegztj6v/C7u3uw+tNiaJtuCDPOh5xoiDPA9bhAWnM9Hao5u3xff11qX
         ENIw==
X-Gm-Message-State: AOJu0YzPFAC4a7bM/vF7IyT17eXU5ZXIzvjko3oTFGrbD+QK9s9wVYFX
	O8Qh7IjdkIhRpBrrEEZ4s67SOA==
X-Google-Smtp-Source: AGHT+IFqvNt0P5RmKsKR61j5MRdvlT/98lInVwc932HdCIqMT7W40RWjdp/IrVy4x1gZjl8HnbqJ7g==
X-Received: by 2002:a05:6512:3c87:b0:507:a04c:76e8 with SMTP id h7-20020a0565123c8700b00507a04c76e8mr10952463lfv.46.1701092822791;
        Mon, 27 Nov 2023 05:47:02 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id g22-20020aa7c856000000b005489e55d95esm5258516edt.22.2023.11.27.05.47.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 05:47:02 -0800 (PST)
Message-ID: <7b0d6bbd-aed0-7321-52ee-da68dad7b811@blackwall.org>
Date: Mon, 27 Nov 2023 15:47:01 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH bpf] netkit: Reject IFLA_NETKIT_PEER_INFO in
 netkit_change_link
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20231127134311.30345-1-daniel@iogearbox.net>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20231127134311.30345-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/23 15:43, Daniel Borkmann wrote:
> The IFLA_NETKIT_PEER_INFO attribute can only be used during device
> creation, but not via changelink callback. Hence reject it there.
> 
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>   drivers/net/netkit.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 97bd6705c241..35553b16b8e2 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -851,6 +851,12 @@ static int netkit_change_link(struct net_device *dev, struct nlattr *tb[],
>   		return -EACCES;
>   	}
>   
> +	if (data[IFLA_NETKIT_PEER_INFO]) {
> +		NL_SET_ERR_MSG_ATTR(extack, data[IFLA_NETKIT_PEER_INFO],
> +				    "netkit peer info cannot be changed after device creation");
> +		return -EACCES;
> +	}
> +
>   	if (data[IFLA_NETKIT_POLICY]) {
>   		attr = data[IFLA_NETKIT_POLICY];
>   		policy = nla_get_u32(attr);

Good catch,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


