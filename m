Return-Path: <bpf+bounces-62759-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F12AFE17E
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 09:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C09EF3BDD0A
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8397F275844;
	Wed,  9 Jul 2025 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="Fyx0jAOV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000F3272E5A
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 07:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046680; cv=none; b=t3FeG6icVDxSuJZ0i8vXoDdhHPhTGP5ojAAza50QqLONx13N9g4X1BGZVoDkCjC9RohCySVIs0xJuALTP7eyAUNl3fYRrbMaAMYnRECgYKUWTYDvNMUPnBIIS6NQI7cmoX2vFvXr8yWsTEdHJlCdXs/N1Cjc+xkb0o3BNPptZTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046680; c=relaxed/simple;
	bh=9OPmNg1Ke93Fs8SkZKBisFI6U+uVxoHqsm9QDX67Rgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQUc5j2nF5T/7tyWFr8Y9LeUIjGp7T5j2sRhXD1/sG/lVaYkN3uBykI4lpxq30qJvJjqYDTMUs23yDunjMzIevvATgRnr90Yoey0Ruyj/j+XN8rIqefxlUr/wo+TUffxLdSty4oF7LeOREmrECR0iyoCUtBap6Dbp+CvGTx8RYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=Fyx0jAOV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so8399051a12.3
        for <bpf@vger.kernel.org>; Wed, 09 Jul 2025 00:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1752046675; x=1752651475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7AF17i32IwMLY62AXSip2mxJYEDMY02Ret/Hrjg5ZK0=;
        b=Fyx0jAOVtP481WsWBZ5NWcYpPL1fT5ZKqKrZq+LAj+HgBJf945INpeqp56yXMTt9BI
         1eE9321Nax0+yrQnBRuLuX384KLwGUk6XIEy9adBSzXKf+tGIFjiN/uRiRBdzouYiHnM
         ZqnTu4cQNzotKyKcUHeaImmmetjzNbVlzQtq+r7UDGMN6AuxbtzZQEGEtQaQLD6xFdOB
         mEGrJdrpxT0NLzlM7ZjgqlGsUQVNgRh1EoZ4mQJfs4xByBRUu5IzeehyDSSuLUl4mdEt
         XgBN7nNkfWDPUra62kCWaPl94JtN+PGIVnZKKT+YTh5KAV7PRbINNxTZZOXlPF7D7tLx
         0grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752046675; x=1752651475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AF17i32IwMLY62AXSip2mxJYEDMY02Ret/Hrjg5ZK0=;
        b=SxCKJXKlznJqfuxL9/juUQBJwdtBC6Mrv9NCeSvUIBrIEYZh8jKrgEOJKRQg32mRJb
         KAAkQFcC+cLJPsZLrsn5lMQQHAYo8g1CTqa0hClhj2vKsfaO/N7508yc0tptGLpv3zV9
         h/wDFdPrK5x/+fdXwzccq5jsBxK14fnyGLj8EAmY7UM8+lMqv2Wu9GlScbfHunsvEJQi
         1f9IUdEhjYjug/+mWLGcZ3sS/+b6biF6OM8E6svAq9uMSMe7jiKcO92uIy87Bc1eRNam
         EHLSrPg9WTzRpLwrBeknUlvJAuGgTsCn7jyiJulE2dFo8R3484J+yIL7J9m3HU5Web7M
         f54w==
X-Gm-Message-State: AOJu0YzMdW/MZutfhueNG/iUxZ5D93LBETtTLyDoiWFhRrysAaw+Lk2U
	knfl5TlassKETh/3iksVOQhmmgYePBROWsm4AbTNZ1RZT3yU7DX5jNQg5AnIyC7LeKQ=
X-Gm-Gg: ASbGncuvnVC7Z1QXhhk3E5OxeL5V9zWS0QsrPy9b2bo55VXesis2IrsMc3W2Z4VaXE9
	VSu/tH5Gb0DvzZ5qv3hLEOBlmbMyv+5eH3+TZpfh3vPkMFU83XFhMxU5cZcMqmTjBhqxqSrm6f4
	nXqcRUUaPqhl/RreX8VsdBKqQ9GRiV8xPspZWdZ7lcRTW6WKW7mtmRVTd2k2zygR78f4BUg3imW
	Hc8onNeYbhiMNPkx2/qCVeE0VkFteor6sUu12Zr8luCflLHm8XEC1cMgHJZeVJ3KXcUtkVF7fyd
	cBuhRf1O5P5+gAkShWDtoOK0j/dxwQe+YWcACPbrHR0Aak0cj/xm3DiFzpTaVUMsyKt+2L2Od5P
	vE+lz6vN1z84nmbgExA==
X-Google-Smtp-Source: AGHT+IGKNKwRhwXTcmwtGN+5HGqX7L50fvavD2PabeX9y+OqiZC5bMINAl/BO5b4T2iWDRdBG72Lbw==
X-Received: by 2002:a17:907:3f9c:b0:ae0:cccd:3e7d with SMTP id a640c23a62f3a-ae6cf73f3f5mr147273866b.33.1752046674928;
        Wed, 09 Jul 2025 00:37:54 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6b02f68sm1054983366b.117.2025.07.09.00.37.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 00:37:54 -0700 (PDT)
Message-ID: <f382be0d-6f30-443e-b161-d1d172dcd801@blackwall.org>
Date: Wed, 9 Jul 2025 10:37:51 +0300
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 7/7] netkit: Remove location field in
 netkit_link
To: Tao Chen <chen.dylane@linux.dev>, daniel@iogearbox.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, horms@kernel.org, willemb@google.com,
 jakub@cloudflare.com, pablo@netfilter.org, kadlec@netfilter.org,
 hawk@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org
References: <20250709030802.850175-1-chen.dylane@linux.dev>
 <20250709030802.850175-8-chen.dylane@linux.dev>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250709030802.850175-8-chen.dylane@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/9/25 06:08, Tao Chen wrote:
> Use attach_type in bpf_link to replace the location field, and
> remove location field in netkit_link.
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  drivers/net/netkit.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 5928c99eac7..492be60f2e7 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c
> @@ -32,7 +32,6 @@ struct netkit {
>  struct netkit_link {
>  	struct bpf_link link;
>  	struct net_device *dev;
> -	u32 location;
>  };
>  
>  static __always_inline int
> @@ -733,8 +732,8 @@ static void netkit_link_fdinfo(const struct bpf_link *link, struct seq_file *seq
>  
>  	seq_printf(seq, "ifindex:\t%u\n", ifindex);
>  	seq_printf(seq, "attach_type:\t%u (%s)\n",
> -		   nkl->location,
> -		   nkl->location == BPF_NETKIT_PRIMARY ? "primary" : "peer");
> +		   link->attach_type,
> +		   link->attach_type == BPF_NETKIT_PRIMARY ? "primary" : "peer");
>  }
>  
>  static int netkit_link_fill_info(const struct bpf_link *link,
> @@ -749,7 +748,7 @@ static int netkit_link_fill_info(const struct bpf_link *link,
>  	rtnl_unlock();
>  
>  	info->netkit.ifindex = ifindex;
> -	info->netkit.attach_type = nkl->location;
> +	info->netkit.attach_type = link->attach_type;
>  	return 0;
>  }
>  
> @@ -776,7 +775,6 @@ static int netkit_link_init(struct netkit_link *nkl,
>  {
>  	bpf_link_init(&nkl->link, BPF_LINK_TYPE_NETKIT,
>  		      &netkit_link_lops, prog, attr->link_create.attach_type);
> -	nkl->location = attr->link_create.attach_type;
>  	nkl->dev = dev;
>  	return bpf_link_prime(&nkl->link, link_primer);
>  }

LGTM for netkit,
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


