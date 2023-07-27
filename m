Return-Path: <bpf+bounces-6074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE8D765487
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 15:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44A171C21621
	for <lists+bpf@lfdr.de>; Thu, 27 Jul 2023 13:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5B1171AB;
	Thu, 27 Jul 2023 13:07:37 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91B1171A0
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 13:07:36 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58121FFA
	for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 06:07:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-99bc0a20b54so126810466b.1
        for <bpf@vger.kernel.org>; Thu, 27 Jul 2023 06:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690463253; x=1691068053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Es+5vdN+nG4iX8j4eDeJTQusrI7sKNJPZaOiazyf0c=;
        b=I0aJ1eAVC5fwcnmQ8rzWNYl0iiV5m3XKQi6jH4fFaBqYJjBelBaxgbObzZ3J0OXdQ+
         cH6ErQC7RkvppKRpDgoBevtPkcDAcaPW2qZq7Iedz+97FUHpMqK2IqxWRfvn8IQYqgJS
         HZnLQ5UNn4PgJ6yuWYsXRHXed4fstlgO2zBXaeixJGStmeB6nAG6VCotISyR50awIB94
         /awDEcRGNgWLFyQ5iGpjrR29RIDMgukbU5EHomI2AFNULUjAw9ZqzN45YxYLwldv7IZT
         VPaqh3tq0H+5vnkZtKN2aI6hI5MIkcjhtaR9e9fUXHe7SWKNjA7ilhzE7ZzgyzB3z/cH
         uMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463253; x=1691068053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Es+5vdN+nG4iX8j4eDeJTQusrI7sKNJPZaOiazyf0c=;
        b=lpYfMmTcXNQxKD2lhTelHH5kClrEBZ4fqIGkKhHG8bt16cz/PR6KwU14+0yvGyBumQ
         xKujiYXDiASUf2iPXPh/3UxN/DyeCPyVyFHxcwOwbBoiKoGzrWkzhyw8I9G3+TSIhRXe
         1/AvAC0P+CBGZs776ObN5JE1gQ8HDkRTwa6L2ngKT4VtJmNyO4VYcJjSAvqRrXb2LzcS
         oWFJ25XreD1JJo6LzZKIEyI/BBtQl5OK5glfA/3d6QxfpHSxYVwPU6ZMvJWaex49gD4v
         Y82BdCqblEBwq1stnQNKgSB7RBd4DMbLG96pynCcicVj4IURP0AKf0XTHNQ37BySNazF
         gpbQ==
X-Gm-Message-State: ABy/qLYGOCAmcx9B/kyakVjw0HxL96rG6lyjmU6zZydBo/JsjlmAiWis
	U9ZUEziSNX3g/FYB5g9yLJE=
X-Google-Smtp-Source: APBJJlGCaK2G1ErJ4QnxLqgnfjBjha085jzCw/GBmnhRj1E1nRapJ4G4SjyGCKvvvfPu6E55oiT9Ng==
X-Received: by 2002:a17:907:a0d3:b0:993:e752:1a6a with SMTP id hw19-20020a170907a0d300b00993e7521a6amr1981285ejc.21.1690463252944;
        Thu, 27 Jul 2023 06:07:32 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id j16-20020a170906831000b00993cc1242d4sm745172ejx.151.2023.07.27.06.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:07:32 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 27 Jul 2023 15:07:29 +0200
To: Yafang Shao <laoar.shao@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
	yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	bpf@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Fix uninitialized symbol in
 bpf_perf_link_fill_kprobe()
Message-ID: <ZMJsETrHUF1X05t/@krava>
References: <20230727114309.3739-1-laoar.shao@gmail.com>
 <20230727114309.3739-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727114309.3739-2-laoar.shao@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 27, 2023 at 11:43:08AM +0000, Yafang Shao wrote:
> The patch 1b715e1b0ec5: "bpf: Support ->fill_link_info for
> perf_event" from Jul 9, 2023, leads to the following Smatch static
> checker warning:
> 
>     kernel/bpf/syscall.c:3416 bpf_perf_link_fill_kprobe()
>     error: uninitialized symbol 'type'.
> 
> That can happens when uname is NULL. So fix it by verifying the uname
> when we really need to fill it.
> 
> Fixes: 1b715e1b0ec5 ("bpf: Support ->fill_link_info for perf_event")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/bpf/85697a7e-f897-4f74-8b43-82721bebc462@kili.mountain/
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/syscall.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 7f4e8c3..ad9360d 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3376,16 +3376,16 @@ static int bpf_perf_link_fill_common(const struct perf_event *event,
>  	size_t len;
>  	int err;
>  
> -	if (!ulen ^ !uname)
> -		return -EINVAL;

would it make more sense to keep above check in place and move the
!uname change below? I'd think we want to return error in case of
wrong arguments as soon as possible

> -	if (!uname)
> -		return 0;
> -
>  	err = bpf_get_perf_event_info(event, &prog_id, fd_type, &buf,
>  				      probe_offset, probe_addr);
>  	if (err)
>  		return err;
>  
> +	if (!ulen ^ !uname)
> +		return -EINVAL;
> +	if (!uname)
> +		return 0;

and here we just return 0 if we do not store the name to provided buffer

thanks,
jirka

> +
>  	if (buf) {
>  		len = strlen(buf);
>  		err = bpf_copy_to_user(uname, buf, ulen, len);
> -- 
> 1.8.3.1
> 

