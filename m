Return-Path: <bpf+bounces-111-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 941736F8095
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 12:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278AB280FB5
	for <lists+bpf@lfdr.de>; Fri,  5 May 2023 10:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5E179E6;
	Fri,  5 May 2023 10:11:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F23FC7
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 10:11:31 +0000 (UTC)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A740013864
	for <bpf@vger.kernel.org>; Fri,  5 May 2023 03:11:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-306f9df5269so1048315f8f.3
        for <bpf@vger.kernel.org>; Fri, 05 May 2023 03:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1683281488; x=1685873488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rizyxIXJOlFW2tozEO22jhd9OD3mttiffgTobk9xT1o=;
        b=Du8jND/qWPzd/0/IJy0ay4son5WxE/yh+fKQjFzUZXufA9MB0hx639paeq6YU2DIe2
         Qx3nuAMOJj0cTbs7yp38mjdI+oIpSqjIyhTpBofQ3c8UA9CbFSH2klJM9I0tN8b1zv/g
         QWnvr1qckWTu9bEC3WcOK12hrW+oXzD8cYjyoEnSD0RsXc9Vl+spiG73vPolu+dw7LZk
         2th2d3IulPKri4pA6hP6/uB1Nuo2r2rCur+pxRrvyUZT8NWUw1RmFLeaKHOIjkssbGfa
         tw3oQ7dcgwEFNw8/ssLYOLy2W9lpMsSDyXFXZcJK9U/96hgYIBit9l8WzsDX0ZmAqyWv
         WQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683281488; x=1685873488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rizyxIXJOlFW2tozEO22jhd9OD3mttiffgTobk9xT1o=;
        b=I6PQib0karCKYhvcRJjbre4t4I5goSRdDUTm2ZZdMam93V9F/szgaBQYUMhju2V2w1
         qp9Z7AgE0y2XH0Ri5lD+hnHJ7ZyXYpT7GCO0yB6M3Zrv1xvcTp05pjWpPaP9vVBgUvj1
         BPoVSMI1o6/qOGyF5pmba7QURyRUN3m+Yj10N6ExdB7BVefmfZfIheeaKsVtsJ7OGjJV
         W9kJhtxXzRVbv86gVov0imGDGYts73qTwWFjp79g2kIyxBLBabmwbsc2aujWB2/xqRWK
         iQNFLsiLMzc18lIfuIpLotwO0l/p1XjFB3JKhoN2z+V5WlRjfA8AMYgYYC3XjE1V8xIG
         fBLw==
X-Gm-Message-State: AC+VfDyZ+taS30ar5TDMX+T45POhnXhpeqTH2CWAmfTPFkOcAcaRAc9r
	5QJVQ9rONX4cVUnNR/ZduBavnsg3AMcIALUSNJMQ9Tz4
X-Google-Smtp-Source: ACHHUZ5+nFCYQ0mFym1WG2CR05cM9zDreWbTHOEijUPcGa4b3bFZvusskLJn1Ja9k09Cvt8p9Mq3nQ==
X-Received: by 2002:a5d:4d89:0:b0:301:81f8:765f with SMTP id b9-20020a5d4d89000000b0030181f8765fmr994437wru.38.1683281488111;
        Fri, 05 May 2023 03:11:28 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:247b:b092:5664:1862? ([2a02:8011:e80c:0:247b:b092:5664:1862])
        by smtp.gmail.com with ESMTPSA id j8-20020a5d5648000000b003062cdc6ac5sm1881422wrw.89.2023.05.05.03.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 03:11:27 -0700 (PDT)
Message-ID: <2da44d24-74ae-a564-1764-afccf395eeec@isovalent.com>
Date: Fri, 5 May 2023 11:11:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] bpftool: Support bpffs mountpoint as pin path
 for prog loadall
Content-Language: en-GB
To: Pengcheng Yang <yangpc@wangsu.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@google.com>
Cc: bpf@vger.kernel.org
References: <1683197138-1894-1-git-send-email-yangpc@wangsu.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <1683197138-1894-1-git-send-email-yangpc@wangsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

2023-05-04 18:45 UTC+0800 ~ Pengcheng Yang <yangpc@wangsu.com>
> Currently, when using prog loadall, if the pin path is a bpffs
> mountpoint, bpffs will be repeatedly mounted to the parent directory
> of the bpffs mountpoint path.
> 
> For example,
>     $ bpftool prog loadall test.o /sys/fs/bpf
> currently bpffs will be repeatedly mounted to /sys/fs.
> 
> Signed-off-by: Pengcheng Yang <yangpc@wangsu.com>
> ---
>  tools/bpf/bpftool/common.c | 9 ++++++---
>  tools/bpf/bpftool/iter.c   | 2 +-
>  tools/bpf/bpftool/main.h   | 2 +-
>  tools/bpf/bpftool/prog.c   | 2 +-
>  4 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 5a73ccf14332..880fcb45f89f 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -68,7 +68,7 @@ void p_info(const char *fmt, ...)
>  	va_end(ap);
>  }
>  
> -static bool is_bpffs(char *path)
> +static bool is_bpffs(const char *path)
>  {
>  	struct statfs st_fs;
>  
> @@ -244,13 +244,16 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
>  	return fd;
>  }
>  
> -int mount_bpffs_for_pin(const char *name)
> +int mount_bpffs_for_pin(const char *name, bool is_dir)
>  {
>  	char err_str[ERR_MAX_LEN];
>  	char *file;
>  	char *dir;
>  	int err = 0;
>  
> +	if (is_dir && is_bpffs(name))
> +		return err;
> +
>  	file = malloc(strlen(name) + 1);
>  	if (!file) {
>  		p_err("mem alloc failed");
> @@ -286,7 +289,7 @@ int do_pin_fd(int fd, const char *name)
>  {
>  	int err;
>  
> -	err = mount_bpffs_for_pin(name);
> +	err = mount_bpffs_for_pin(name, false);
>  	if (err)
>  		return err;
>  
> diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
> index 9a1d2365a297..6b0e5202ca7a 100644
> --- a/tools/bpf/bpftool/iter.c
> +++ b/tools/bpf/bpftool/iter.c
> @@ -76,7 +76,7 @@ static int do_pin(int argc, char **argv)
>  		goto close_obj;
>  	}
>  
> -	err = mount_bpffs_for_pin(path);
> +	err = mount_bpffs_for_pin(path, false);
>  	if (err)
>  		goto close_link;
>  
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0ef373cef4c7..665f23f68066 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -142,7 +142,7 @@ const char *get_fd_type_name(enum bpf_obj_type type);
>  char *get_fdinfo(int fd, const char *key);
>  int open_obj_pinned(const char *path, bool quiet);
>  int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
> -int mount_bpffs_for_pin(const char *name);
> +int mount_bpffs_for_pin(const char *name, bool is_dir);
>  int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
>  int do_pin_fd(int fd, const char *name);
>  
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index afbe3ec342c8..473ec01c00d6 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1747,7 +1747,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  		goto err_close_obj;
>  	}
>  
> -	err = mount_bpffs_for_pin(pinfile);
> +	err = mount_bpffs_for_pin(pinfile, !first_prog_only);
>  	if (err)
>  		goto err_close_obj;
>  

Thanks! Makes sense to pass down is_dir, given that the directory does
not always exist at this stage so we can't just fstat(name) to check the
type in mount_bpffs_for_pin().

Note that you missed an occurrence of mount_bpffs_for_pin() in
struct_ops.c, recently added in commit 0232b7889786 ("bpftool: Register
struct_ops with a link."), please fix it.

I realise that even if we pass a directory name, we try to mount the
bpffs on the parent directory. We should clean this up in the future and
only mount on the provided directory in this case, but this might
require creating the directory first (it does not always exist at this
stage).

Thanks,
Quentin

