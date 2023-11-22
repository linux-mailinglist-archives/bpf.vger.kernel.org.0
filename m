Return-Path: <bpf+bounces-15670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1457F4A3D
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 16:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77FDD281270
	for <lists+bpf@lfdr.de>; Wed, 22 Nov 2023 15:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75E24EB26;
	Wed, 22 Nov 2023 15:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="l3m0X5Z9"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E664110E;
	Wed, 22 Nov 2023 07:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=kKnoX+HyOnw1r1mDaa1wv9GN0J9jKHuPtPaSsz/q4ZQ=; b=l3m0X5Z94HbaNlDOyHc9EmfZ8B
	Em4t8OKJmEXp4Hew7DPcDCFJgTbUIkYn4uXq1/9kLi9/49ce4vyimjhaTa/o819YikdOnHkaFGHVl
	cGPNm0H+7sajv19JyGh5tRGCyzoroJn5YoCbc2WqwwT0xF2eFaeHcKjmehFo0y7au9J9FXCWHSLH1
	Trt+Ivem8UiUTUWUPCQY9aeXjQoYcEmEm1CvLchMixDLQhw65IZpjHBVDc83KxNvy78nNBdE3f3rc
	no+K7MQCckTtgjLC7Fa7JotMwy5gdZx3SX6CIvL89KeW83AgJfjgaa4xfXAuoEzv7FYKE0RMh84cA
	+8jH84Iw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5p7r-000DKO-Os; Wed, 22 Nov 2023 16:26:51 +0100
Received: from [178.197.248.19] (helo=linux.home)
	by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1r5p7r-000MIo-Fb; Wed, 22 Nov 2023 16:26:51 +0100
Subject: Re: [PATCH] bpf: add __printf() to for printf fmt strings
To: Ben Dooks <ben.dooks@codethink.co.uk>, bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20231122133656.290475-1-ben.dooks@codethink.co.uk>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ee3385e1-4b49-2d9a-df90-2b3dfc7b07d1@iogearbox.net>
Date: Wed, 22 Nov 2023 16:26:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231122133656.290475-1-ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27101/Wed Nov 22 09:40:55 2023)

On 11/22/23 2:36 PM, Ben Dooks wrote:
> The btf_seq_show() and btf_snprintf_show() take a printk format
> string so add a __printf() to these two functions. This fixes the
> following extended warnings:
> 
> kernel/bpf/btf.c:7094:29: error: function ‘btf_seq_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> kernel/bpf/btf.c:7131:9: error: function ‘btf_snprintf_show’ might be a candidate for ‘gnu_printf’ format attribute [-Werror=suggest-attribute=format]
> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   kernel/bpf/btf.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 15d71d2986d3..46c2e87c383d 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -7088,8 +7088,8 @@ static void btf_type_show(const struct btf *btf, u32 type_id, void *obj,
>   	btf_type_ops(t)->show(btf, t, type_id, obj, 0, show);
>   }
>   
> -static void btf_seq_show(struct btf_show *show, const char *fmt,
> -			 va_list args)
> +static __printf(2,0) void btf_seq_show(struct btf_show *show, const char *fmt,
> +				       va_list args)
>   {
>   	seq_vprintf((struct seq_file *)show->target, fmt, args);
>   }
> @@ -7122,7 +7122,7 @@ struct btf_show_snprintf {
>   	int len;		/* length we would have written */
>   };
>   
> -static void btf_snprintf_show(struct btf_show *show, const char *fmt,
> +static __printf(2,0) void btf_snprintf_show(struct btf_show *show, const char *fmt,
>   			      va_list args)
>   {

Looks good, only small nit is to fix up kernel-style formatting wrt spacing.

>   	struct btf_show_snprintf *ssnprintf = (struct btf_show_snprintf *)show;
> 


