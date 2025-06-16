Return-Path: <bpf+bounces-60700-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85899ADA99F
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 09:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5593E18969CA
	for <lists+bpf@lfdr.de>; Mon, 16 Jun 2025 07:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68B20E007;
	Mon, 16 Jun 2025 07:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEHq1VCJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271371F5847;
	Mon, 16 Jun 2025 07:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750059630; cv=none; b=uCyK+QoTt3MzOOAJ4/jKz3fcPV0SvEKPAFEVYmcV2La8OtcoMJ+2lyA0GJH3Y2FpgS6+VjfJ4iQKdmS1O/6jAm79rxJcUMXEIxgSpEZa1yv8t7zBDYyNe7IB1FSGt+yyFre4XEAeoHp8RDSokbjUr3Y9qtKULJbN61njif1uR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750059630; c=relaxed/simple;
	bh=szFBdDj2sIHUUrCxjHdIXY/I1Ajru8RA1r6ss0d5Rs4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VDa7XIqv0i145xCywxZ+B/fEoPUzPWCf6WDLyaxWEMgYwYyHmk1lZEhVa4s5lFAFAqdgwbE1MTE641lmorgwe8iwGbuK4Abu61NOt/+bZx1chG0oPOA5xEDxets3HbbJadOtVqmSi5xu2BMIXlsFhUT5tGswAxHPXkQo6dE333M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEHq1VCJ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad883afdf0cso817909766b.0;
        Mon, 16 Jun 2025 00:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750059627; x=1750664427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mOvR6c0mUHTazKByR5RhvPy8Kr8Qgm/MB7/Zi9TDdTg=;
        b=fEHq1VCJvAPstDK3fZxaaxZQujFNbrlWNVrVMKb5Zp/ofx+8jhxzHEVxuk9YOfjcE0
         18YkUGLMrMjLMJ86psUWZ61fDZzNe2Rc+rdbUdNrVIhQi+1JV6RaFGWH5shFF9N74zwj
         7UG4keZ1ikNnwaPbmXtbhiyO2pwiqAg8YOG5fH4KxOGtJzv8+0j7VN6qbclwQH9gs8eU
         bJLOX1AMDts4pw5rH1ibt25u/wWK7McTIqZeCZqf+dSEL7fmKQD8a2QhNt0QjzRjMYpB
         SDGQymo2mpFTcrYH36IvmaHmIh+OwUj1rKUw3EPHVVcagc80vyaDO/f/i8QQEgw7cD0n
         pwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750059627; x=1750664427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOvR6c0mUHTazKByR5RhvPy8Kr8Qgm/MB7/Zi9TDdTg=;
        b=Wlgopf+798j+B1f03EBgK4qZbB7ge3ueEHTycnPEyz5Iu/Jive1uYJ9wAFPMwhAGVo
         4wWqOU5ZTG2R5oJvaiW/N5S6QLjiwkhzYCnuAvTBYXid6bsIqLrJvKvPnwgoyBZggky0
         yKIbRuLHZITAb88LzvVGOTZDYkObVgNroo075MljAA1goUo50mhyobD+dGLJ0/KNdRoz
         TC2T9sTztXfdp3r/PLucu5/XNVI6tSPBpCRujME0O9fgbE5/T0oaaEYZpLbTSTxK46dV
         urISn8YXVCae1E3yFACqClPZdSLCgcWk4rgr2x5u7IyG4fmhEgk7Ug3yayxpE+PRbcKe
         Veig==
X-Forwarded-Encrypted: i=1; AJvYcCVFsEjHX6coCwaIas60s5WNXyaYo45HY/qQT8KIhbugZ6fqdiKfWzc9n/8V5ISm7YliLvh3yWxn9Gqnzzu5ygo6mSoD@vger.kernel.org, AJvYcCWfEBE5bfnCa7w2+QoOsNKAIQTT76PeGgrN0WHOjonKZ6I+U7prRguf8MadJlQ5Bbw1CtwuH9p48biScC5H@vger.kernel.org, AJvYcCWimWnQ+PJ0tr/ykuA04zoffr9om0WX1dIxnBsuec68viK5VZdGviXZ2vjJgDZYvzm/jZA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0EeqEg8lSJl+ImWI8DtXqLxK1H0UvzvReU4hswO1XYI6+gZp/
	NvmGGqmrEdi8Ecjebt4V6HJAbEZuFFeoRdXsguiafkFp7VwEffewEyzX
X-Gm-Gg: ASbGnctblyZTeeX39ltOHoLFYOxWMPBLF2pz6ar22XPrU/XTdYIKAYF1i/qCP2yf696
	364lxkbXrwHb/TlZFQUbesrMwgkD408GU6ij3+1X5YrfdEujZgVytvgu4lBZnJva7PoFvu9u08H
	Qmn9GqiBIb9TNZdepYgReDaDx2XI1pP5LDHUoC+imxvPPazmmpxeMHDz4Da4kSY7vxQ9wSskUJM
	0d4SJy2yapajdVIfpqOHqkxgv0FDIwdnn0oQJfcbNQBDgMhY0EKtOz5GNQd1miO0LVrG538O0ow
	Jw0b/LsbJvmn1Mhx9kAH9llOD+GwvccC6Dh2hF5OH1u2ESk6
X-Google-Smtp-Source: AGHT+IFamjzkI3cSDv+FenN8bqAY65k3I0eR6rKXo+p2mfc8EAUxMtvv5sOQLx2g++3aPi2WdU4CGQ==
X-Received: by 2002:a17:906:ee8e:b0:ade:76d0:fd9c with SMTP id a640c23a62f3a-adfad31bd39mr797893766b.3.1750059627292;
        Mon, 16 Jun 2025 00:40:27 -0700 (PDT)
Received: from krava ([173.38.220.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adecd50da29sm588910666b.72.2025.06.16.00.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 00:40:26 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 16 Jun 2025 09:40:24 +0200
To: Tao Chen <chen.dylane@linux.dev>
Cc: song@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
	john.fastabend@gmail.com, sdf@fomichev.me, haoluo@google.com,
	rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Add show_fdinfo for kprobe_multi
Message-ID: <aE_KaH3DAo4-Yq7m@krava>
References: <20250615150514.418581-1-chen.dylane@linux.dev>
 <20250615150514.418581-2-chen.dylane@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250615150514.418581-2-chen.dylane@linux.dev>

On Sun, Jun 15, 2025 at 11:05:14PM +0800, Tao Chen wrote:
> Show kprobe_multi link info with fdinfo, the info as follows:
> 
> link_type:	kprobe_multi
> link_id:	3
> prog_tag:	e8225cbcc9cdffef
> prog_id:	29
> type:	kprobe_multi
> kprobe_cnt:	8
> missed:	0
> func:	bpf_fentry_test1+0x0/0x20
> cookie:	1
> func:	bpf_fentry_test2+0x0/0x20
> cookie:	7
> func:	bpf_fentry_test3+0x0/0x20
> cookie:	2
> func:	bpf_fentry_test4+0x0/0x20
> cookie:	3
> func:	bpf_fentry_test5+0x0/0x20
> cookie:	4
> func:	bpf_fentry_test6+0x0/0x20
> cookie:	5
> func:	bpf_fentry_test7+0x0/0x20
> cookie:	6
> func:	bpf_fentry_test8+0x0/0x10
> cookie:	8
> 
> Signed-off-by: Tao Chen <chen.dylane@linux.dev>
> ---
>  kernel/trace/bpf_trace.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 9a8ca8a8e2b..d060c61e4e4 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2623,10 +2623,43 @@ static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
>  	return err;
>  }
>  
> +#ifdef CONFIG_PROC_FS
> +static void bpf_kprobe_multi_show_fdinfo(const struct bpf_link *link,
> +					 struct seq_file *seq)
> +{
> +	struct bpf_kprobe_multi_link *kmulti_link;
> +	char sym[KSYM_NAME_LEN];
> +
> +	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
> +
> +	seq_printf(seq,
> +		   "type:\t%s\n"
> +		   "kprobe_cnt:\t%u\n"
> +		   "missed:\t%lu\n",
> +		   kmulti_link->flags == BPF_F_KPROBE_MULTI_RETURN ? "kretprobe_multi" :
> +					 "kprobe_multi",
> +		   kmulti_link->cnt,
> +		   kmulti_link->fp.nmissed);
> +
> +	for (int i = 0; i < kmulti_link->cnt; i++) {
> +		sprint_symbol(sym, kmulti_link->addrs[i]);

I think you could use specifier to do the translation for you,
check Documentation/core-api/printk-formats.rst:

        %pS     versatile_init+0x0/0x110 [module_name]



> +		seq_printf(seq,
> +			  "func:\t%s\n"
> +			  "cookie:\t%llu\n",
> +			  sym,
> +			  kmulti_link->cookies[i]
> +			  );

bracket should be on the previous line

jirka


> +	}
> +}
> +#endif
> +
>  static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
>  	.release = bpf_kprobe_multi_link_release,
>  	.dealloc_deferred = bpf_kprobe_multi_link_dealloc,
>  	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = bpf_kprobe_multi_show_fdinfo,
> +#endif
>  };
>  
>  static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
> -- 
> 2.48.1
> 

