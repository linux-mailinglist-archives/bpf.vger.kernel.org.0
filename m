Return-Path: <bpf+bounces-9609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79E41799D92
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 11:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E50C1C20852
	for <lists+bpf@lfdr.de>; Sun, 10 Sep 2023 09:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090C8258B;
	Sun, 10 Sep 2023 09:53:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD80257E
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 09:53:19 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CD0CCD
	for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 02:53:18 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-403012f276dso11748285e9.0
        for <bpf@vger.kernel.org>; Sun, 10 Sep 2023 02:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694339597; x=1694944397; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DdKEba/1b2uhxpoNEDG+0m9s/KGfS2WBVeM3powphP8=;
        b=J/isfb17iWJ2jZTspPi05z5g5seVYU7IWD6jzfD5EAAzXrnuIX1X03tA/l4m7CEr64
         GV0d/fdQKhmhgTsTof1EQcoS8Qbx1T+sZ+Zc3WNyHIXZ8L6fIdraZ4RQI/69yKH/7Skg
         a9fQy0uEZ6WtWMNrEHhRBJ6C1KpbTaaR/c6jS0FdytUZj/hkuUyOYm5Zks4KrDItOTYC
         C2BlsLZyr9Fg02Ddh8ydXVxBecd7nQLjA5gjE4b9scRW46q/DbcPfdvEbZudP+mZ3i/Q
         ZUVb1rk+0/g6VdMZqXcfv6dz9IIRLGA+jg/69GdfijAHE8se+91dlGe6nfmwO9Z4VugF
         lYUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694339597; x=1694944397;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdKEba/1b2uhxpoNEDG+0m9s/KGfS2WBVeM3powphP8=;
        b=xFKUi9Twmju79tIAf8C3S4IsoolOHYRl+HGjxBz0BMdK1GAjurh9u2SwtdRlNN6rDj
         s18hzKD82zMybAnmkns33kOqpbGwErhgqreClSnf9XsfbYFiu7xAz8mMSSzrraZDFxRc
         e2puFRw/otb+u+RZdGajq7ikgq+rHaQHc1WL8Dj0JWQFgh5tNAgczgWQJNciMDl8HrRy
         HIKLEZgv8zsCTTbJp2aMTGfhkSvTqH5shFz4Rm7z71zjRe52ysl7JyyuJ3V13uQzJNAH
         p2JAXpFfcaFx7DPJMlhRO8laQURV+rA5DXiVIXJQy7F+M3RX9n2JW7S1IL1ULK3wCBmp
         41Fw==
X-Gm-Message-State: AOJu0YyHWhRT6jmrvCAS9WE6+f7M/vqcDmOOkEEArPif+MLTMEPQBKE1
	uy8e/YbFdGZPaBtXGEWpyrThyoPrVVA=
X-Google-Smtp-Source: AGHT+IHIWgGofCPWXE2iBBcu3UkIdqGU48FYM914x7aRiBLoP81HY0m9kdAwkVl4YsUHs0VeI74rgQ==
X-Received: by 2002:a05:600c:1c87:b0:403:9b7:a720 with SMTP id k7-20020a05600c1c8700b0040309b7a720mr1101731wms.1.1694339596670;
        Sun, 10 Sep 2023 02:53:16 -0700 (PDT)
Received: from krava (ip-94-113-247-30.net.vodafone.cz. [94.113.247.30])
        by smtp.gmail.com with ESMTPSA id 21-20020a05600c229500b00402d34ea099sm9979602wmf.29.2023.09.10.02.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Sep 2023 02:53:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 10 Sep 2023 11:53:14 +0200
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, alan.maguire@oracle.com, olsajiri@gmail.com
Subject: Re: [PATCH bpf-next v2 1/3] libbpf: Resolve symbol conflicts at the
 same offset for uprobe
Message-ID: <ZP2SCuwKVRf14atN@krava>
References: <20230905151257.729192-1-hengqi.chen@gmail.com>
 <20230905151257.729192-2-hengqi.chen@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905151257.729192-2-hengqi.chen@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Sep 05, 2023 at 03:12:55PM +0000, Hengqi Chen wrote:
> Dynamic symbols in shared library may have the same name, for example:
> 
>     $ nm -D /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>     000000000009b1a0 T __pthread_rwlock_wrlock@GLIBC_2.2.5
>     000000000009b1a0 T pthread_rwlock_wrlock@@GLIBC_2.34
>     000000000009b1a0 T pthread_rwlock_wrlock@GLIBC_2.2.5
> 
>     $ readelf -W --dyn-syms /lib/x86_64-linux-gnu/libc.so.6 | grep rwlock_wrlock
>      706: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 __pthread_rwlock_wrlock@GLIBC_2.2.5
>     2568: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@@GLIBC_2.34
>     2571: 000000000009b1a0   878 FUNC    GLOBAL DEFAULT   15 pthread_rwlock_wrlock@GLIBC_2.2.5
> 
> Currently, users can't attach a uprobe to pthread_rwlock_wrlock because
> there are two symbols named pthread_rwlock_wrlock and both are global
> bind. And libbpf considers it as a conflict.
> 
> Since both of them are at the same offset we could accept one of them
> harmlessly. Note that we already does this in elf_resolve_syms_offsets.
> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/lib/bpf/elf.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index 9d0296c1726a..5c9e588b17da 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -214,7 +214,10 @@ long elf_find_func_offset(Elf *elf, const char *binary_path, const char *name)
> 
>  			if (ret > 0) {
>  				/* handle multiple matches */
> -				if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
> +				if (elf_sym_offset(sym) == ret) {
> +					/* same offset, no problem */
> +					continue;
> +				} else if (last_bind != STB_WEAK && cur_bind != STB_WEAK) {
>  					/* Only accept one non-weak bind. */
>  					pr_warn("elf: ambiguous match for '%s', '%s' in '%s'\n",
>  						sym->name, name, binary_path);
> --
> 2.34.1

