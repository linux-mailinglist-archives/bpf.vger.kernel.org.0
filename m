Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9096D7736F
	for <lists+bpf@lfdr.de>; Fri, 26 Jul 2019 23:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfGZV2U (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Jul 2019 17:28:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38468 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727476AbfGZV2U (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Jul 2019 17:28:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id f5so16523019pgu.5
        for <bpf@vger.kernel.org>; Fri, 26 Jul 2019 14:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fomichev-me.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+z7GOTmT3nNgKC279a8ACROVHWGzWXxrdH8l/jHT3m0=;
        b=dfnglxIX5OjNlpmG1N11VkmIjJmPc4py8gPeqZG7SeqK+Ggtjz8el1QhSSWSwy4CiW
         APou4pPA1qWnTFzT/WcJK4gbAglLnZf/E/XRTHiVAQT1qx1tLbcVCN2IW+kIE34EgVQ0
         pI/Wou0mxvZ8CdfQj9xcKmc9LW5bm+75pcFsqnygR4c2ji6loRsu0XhISQm1xOBmr5AQ
         riKBcqGSJ3wXbmX0WkBsNk2ESZSc0ZOdljS15Oqi14X1kbp4hM3BYN7mARRzmEegkaRG
         g6oq7UFVgpKO5rw2cRys81c9hECP32198yeYQnaqEiMsPhDMsDmKnXeBdrLVlA20iSwg
         INjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+z7GOTmT3nNgKC279a8ACROVHWGzWXxrdH8l/jHT3m0=;
        b=pa+ezDziVnpyTu2GQbqLh+4hsGPM4Beg/uYt0wYS9hX3I2z+/HU7+HpD5WeuZgocKb
         b7dw1jYl9CfYFPtXWl42GC+zc9v5cKslsrz7woRKFO4Y75jak03PNw1WfGNzx5De98c2
         nsRqp2OiYoHGbIneSnGBLEtc9n+aDz0MSwRmf78nT4Xzwd1CnsVpWhFybFOO0q0abPtb
         CpDTVRySoTSym6QX3VcUkXwmFGJzBjiJSu6fwkB6LXdIAQ2eMn1fFdUma6Vgxv7dCVTh
         OQBc1YflPLn6F5QqtzUBB/yU3y96E1R0XvVqUY/PuEkYH2L9KRDe2tpe+1WLraJED5a+
         /yUQ==
X-Gm-Message-State: APjAAAUmcxUnkqolVY0aIYK4h28IKHSfvwvepFb6IX+1ZOlqDJDiOjNv
        AfDo+0BywTqvMxpQluOiCGNbq/p8
X-Google-Smtp-Source: APXvYqwtzGX+2PfYSt224WPJM4zPXeFd7Zlsy3vH1nvn/GL9oXPV+mMKveijM/0q5d0SdlMgeF6itw==
X-Received: by 2002:a63:5f09:: with SMTP id t9mr59942983pgb.351.1564176499249;
        Fri, 26 Jul 2019 14:28:19 -0700 (PDT)
Received: from localhost ([2601:646:8f00:18d9:d0fa:7a4b:764f:de48])
        by smtp.gmail.com with ESMTPSA id 185sm54366553pfd.125.2019.07.26.14.28.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 26 Jul 2019 14:28:18 -0700 (PDT)
Date:   Fri, 26 Jul 2019 14:28:18 -0700
From:   Stanislav Fomichev <sdf@fomichev.me>
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org, ast@fb.com,
        daniel@iogearbox.net, andrii.nakryiko@gmail.com, kernel-team@fb.com
Subject: Re: [PATCH bpf-next 4/9] libbpf: add libbpf_swap_print to get
 previous print func
Message-ID: <20190726212818.GC24397@mini-arch>
References: <20190726203747.1124677-1-andriin@fb.com>
 <20190726203747.1124677-5-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726203747.1124677-5-andriin@fb.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/26, Andrii Nakryiko wrote:
> libbpf_swap_print allows to restore previously set print function.
> This is useful when running many independent test with one default print
> function, but overriding log verbosity for particular subset of tests.
Can we change the return type of libbpf_set_print instead and return
the old function from it? Will it break ABI?

> Signed-off-by: Andrii Nakryiko <andriin@fb.com>
> ---
>  tools/lib/bpf/libbpf.c   | 8 ++++++++
>  tools/lib/bpf/libbpf.h   | 1 +
>  tools/lib/bpf/libbpf.map | 5 +++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8741c39adb1c..0c254b6c9685 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -79,6 +79,14 @@ void libbpf_set_print(libbpf_print_fn_t fn)
>  	__libbpf_pr = fn;
>  }
>  
> +libbpf_print_fn_t libbpf_swap_print(libbpf_print_fn_t fn)
> +{
> +	libbpf_print_fn_t old_print_fn = __libbpf_pr;
> +
> +	__libbpf_pr = fn;
> +	return old_print_fn;
> +}
> +
>  __printf(2, 3)
>  void libbpf_print(enum libbpf_print_level level, const char *format, ...)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 5cbf459ece0b..4e0aa893571f 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -58,6 +58,7 @@ typedef int (*libbpf_print_fn_t)(enum libbpf_print_level level,
>  				 const char *, va_list ap);
>  
>  LIBBPF_API void libbpf_set_print(libbpf_print_fn_t fn);
> +LIBBPF_API libbpf_print_fn_t libbpf_swap_print(libbpf_print_fn_t fn);
>  
>  /* Hide internal to user */
>  struct bpf_object;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index f9d316e873d8..e211c38ddc43 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -184,3 +184,8 @@ LIBBPF_0.0.4 {
>  		perf_buffer__new_raw;
>  		perf_buffer__poll;
>  } LIBBPF_0.0.3;
> +
> +LIBBPF_0.0.5 {
> +	global:
> +		libbpf_swap_print;
> +} LIBBPF_0.0.4;
> -- 
> 2.17.1
> 
