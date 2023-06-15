Return-Path: <bpf+bounces-2615-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5636D731227
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 10:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D062816E3
	for <lists+bpf@lfdr.de>; Thu, 15 Jun 2023 08:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070E553B7;
	Thu, 15 Jun 2023 08:29:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C23FFF
	for <bpf@vger.kernel.org>; Thu, 15 Jun 2023 08:29:16 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A2B1A3;
	Thu, 15 Jun 2023 01:29:15 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so13627805e9.1;
        Thu, 15 Jun 2023 01:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686817754; x=1689409754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2f0dDJiEZZl0yPR6M2e6BW/dOqeTYvAhdR5MjdgHXe8=;
        b=JwIzNEegDRa8snUrff8XAvi2MrcO99+jQdRb8A4tBrDW4MLDo+DoLhpg2bCIdrA5v2
         yrdwJXstaatYEyU5PPE8tE6FCPAublG5yFw3O+47lad6YST5Kctq/J/RDl+dO67aEEmd
         QZ28fEmNFMn9OzgKoMPkR/Q9jbth8ilO6PdBVJ+kvTrdICf0jsBhodukHbwSP2+1mMav
         Z7sGSYdbWncaU4kr7M3keIcPtwNqn+m+D/gVu9iybCJEz0CVc1if/7ayE+zZ+Bo0JUZJ
         NMqHUtKaK3iQc1RLfKAEEbWdIe9RkPKJ/gg99znGx+uqhs+eu/1CJnPumabJcYJh/vY4
         1+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686817754; x=1689409754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f0dDJiEZZl0yPR6M2e6BW/dOqeTYvAhdR5MjdgHXe8=;
        b=gug9kPKJIwEuRdSq7Gw/YAV3p2JJPfWrzcV7k258QGdUA6QJEzk7j/isd1gaqAuUrp
         QwC27Hppw/zceNRK/VJuQk+NgF7OLypl0UhLQWl7Q0ur1hLP9rucZ4V4aRlb7GKseYD3
         rGVr8qeHMjHlOTkFAdqtbe1Pq9lr1bRrB1DdHVtaeEW6U/R8O7FMxbXiHtRYWeE4Wlm/
         2xrnR3EHg04rF3wgrQu5XdRS5v2ob+JpP7h+VsXvai1A7PE40uSW9r44TLbJr+5w2zJk
         sOXbPFMGu1eBTSu8eZGFbuIhLgUNZ4p2RuT3OmGs+mNoMvv7TB88Y69lsWPxoNl7uY0T
         C64A==
X-Gm-Message-State: AC+VfDzCxQ7afliNS/Jy+Dafk+aqkm6w4YVyuh6Uhx9Ftvf+4eVBmKmI
	cbmyffK4CNosOAbRxbcUm8k=
X-Google-Smtp-Source: ACHHUZ4bSe4GL4tNtPXEeKX296bgaxBCmjD0tS6FdSMjX5w8T8kMf0bwA4LIyiM89k/5tSQ0a2sXYw==
X-Received: by 2002:a7b:c7d8:0:b0:3f7:e65f:7af2 with SMTP id z24-20020a7bc7d8000000b003f7e65f7af2mr10526297wmk.39.1686817753429;
        Thu, 15 Jun 2023 01:29:13 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id f16-20020a1c6a10000000b003f60fb2addbsm19846033wmc.44.2023.06.15.01.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 01:29:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 15 Jun 2023 10:29:10 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	quentin@isovalent.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 01/10] bpf: Support ->fill_link_info for
 kprobe_multi
Message-ID: <ZIrL1szyBiYokMUy@krava>
References: <20230612151608.99661-1-laoar.shao@gmail.com>
 <20230612151608.99661-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612151608.99661-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jun 12, 2023 at 03:15:59PM +0000, Yafang Shao wrote:

SNIP

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 2bc41e6..742047c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2548,9 +2548,36 @@ static void bpf_kprobe_multi_link_dealloc(struct bpf_link *link)
>  	kfree(kmulti_link);
>  }
>  
> +static int bpf_kprobe_multi_link_fill_link_info(const struct bpf_link *link,
> +						struct bpf_link_info *info)
> +{
> +	u64 __user *uaddrs = u64_to_user_ptr(info->kprobe_multi.addrs);
> +	struct bpf_kprobe_multi_link *kmulti_link;
> +	u32 ucount = info->kprobe_multi.count;
> +
> +	if (!uaddrs ^ !ucount)
> +		return -EINVAL;
> +
> +	kmulti_link = container_of(link, struct bpf_kprobe_multi_link, link);
> +	if (!uaddrs) {
> +		info->kprobe_multi.count = kmulti_link->cnt;
> +		return 0;
> +	}
> +
> +	if (ucount < kmulti_link->cnt)
> +		return -EINVAL;
> +	info->kprobe_multi.flags = kmulti_link->fp.flags;
> +	if (!kallsyms_show_value(current_cred()))
> +		return 0;
> +	if (copy_to_user(uaddrs, kmulti_link->addrs, ucount * sizeof(u64)))
> +		return -EFAULT;
> +	return 0;
> +}
> +
>  static const struct bpf_link_ops bpf_kprobe_multi_link_lops = {
>  	.release = bpf_kprobe_multi_link_release,
>  	.dealloc = bpf_kprobe_multi_link_dealloc,
> +	.fill_link_info = bpf_kprobe_multi_link_fill_link_info,
>  };
>  
>  static void bpf_kprobe_multi_cookie_swap(void *a, void *b, int size, const void *priv)
> @@ -2890,6 +2917,7 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
>  		return err;
>  	}
>  
> +	link->fp.flags = flags;

hum this looks wrong, we can't use fprobe flags to store our flags
you should add flags to bpf_kprobe_multi_link

jirka

>  	return bpf_link_settle(&link_primer);
>  
>  error:
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index a7b5e91..23691ea 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -6438,6 +6438,11 @@ struct bpf_link_info {
>  			__s32 priority;
>  			__u32 flags;
>  		} netfilter;
> +		struct {
> +			__aligned_u64 addrs; /* in/out: addresses buffer ptr */
> +			__u32 count;
> +			__u32 flags;
> +		} kprobe_multi;
>  	};
>  } __attribute__((aligned(8)));
>  
> -- 
> 1.8.3.1
> 

