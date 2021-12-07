Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BD646C3C7
	for <lists+bpf@lfdr.de>; Tue,  7 Dec 2021 20:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhLGToz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Dec 2021 14:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbhLGToy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Dec 2021 14:44:54 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F90DC061574
        for <bpf@vger.kernel.org>; Tue,  7 Dec 2021 11:41:23 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id m24so3212238pgn.7
        for <bpf@vger.kernel.org>; Tue, 07 Dec 2021 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XTDTPNKbsdXuyA97GMlxL0sQMVxWBPGxjgPgjKvtoWI=;
        b=hpRzWalMVoeWytfF9eBFic5VaujhVSMVbLEx/jINLFXXj/oOFLImTWVewGjU+kQsQZ
         iq7Hh2uGULCI7qWVwDgm4qwdxpGhWkkjts+tEs5YhdC72OC6v+ut1AjJSixK6Bp7/4id
         Bf2SeW5+l7KgARj0ehu7HcdjBzys2fyit6b8sQ5bDWJ/zf10xDK4fRpupCkiuwpPvUkx
         QzRjzS5Smi3MhX49qTo1ohCtZ0OYWIWvwqLgaSkIYdd6blDPQbSDJY53XkgTFxx1xKtL
         rbf1u6547+r92pKkNFx4t1/TPHfgvAD5XCGZ6UqU5yiDa1DjZT3af2DB3xdP+Xr1GJo/
         Z3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XTDTPNKbsdXuyA97GMlxL0sQMVxWBPGxjgPgjKvtoWI=;
        b=ual+g+xWTCahW7glVtTIvIpyxkWQ8lOONpdBKZ361YnAhh428nGSSppnJ0iwn3Ko2D
         ehuNOQ67ZXSTY3s9eyH1JWvXeNEdlYeIMwtqlFhjkhAUB9KxEJsJuM+rrpUnBhcKB/VV
         4cq7RVQMu+yMNdeny01/4AVhH8ye94fBCNXWb2KWLUN73LOrPTnhrpzGRMkbJ/H3m3fz
         1JjyWpp+bSoxfwhLA/lGkl8Q/einQrqAkH6uGJYKlVQz/iReI8SvyoRZnlwkOktq4jSB
         Ft7JFljWeTVdz6Jo0RH0HDgPhRvzU0trTrZSaMs26kFH5GnXeGkz2UzpSzxH8I1vmn7c
         r67g==
X-Gm-Message-State: AOAM531mUKPbMzyKxhgmHGRJQfqEBKhdX5trmUDCYp64aKexAnSBLTaG
        UA8UkYz9UT3sXOXlVzBlri5qoFvDca4=
X-Google-Smtp-Source: ABdhPJzg0x95xnh2X/PuvgRRMqbXhts3McT2Ypx0SrCfdU48tQDfFb40mBXIFEeVxj6lVmcJmt2qjg==
X-Received: by 2002:a65:4bc8:: with SMTP id p8mr25554932pgr.119.1638906082967;
        Tue, 07 Dec 2021 11:41:22 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::209d])
        by smtp.gmail.com with ESMTPSA id q17sm583634pfu.117.2021.12.07.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 11:41:22 -0800 (PST)
Date:   Tue, 7 Dec 2021 11:41:20 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 06/11] libbpf: add per-program log buffer setter
 and getter
Message-ID: <20211207194120.2qfa5i6s43djdeqy@ast-mbp.dhcp.thefacebook.com>
References: <20211205203234.1322242-1-andrii@kernel.org>
 <20211205203234.1322242-7-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211205203234.1322242-7-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 05, 2021 at 12:32:29PM -0800, Andrii Nakryiko wrote:
>  
> +	ret = bpf_prog_load(prog->type, prog_name, license, insns, insns_cnt, &load_attr);
>  	if (ret >= 0) {
> -		if (log_buf && load_attr.log_level) {
> +		if (log_level && own_log_buf) {
>  			pr_debug("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
>  				 prog->name, log_buf);
>  		}
> @@ -6690,19 +6720,20 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
>  		goto out;
>  	}
>  
> -	if (!log_buf || errno == ENOSPC) {
> -		log_buf_size = max((size_t)BPF_LOG_BUF_SIZE,
> -				   log_buf_size << 1);
> -		free(log_buf);
> +	if (log_level == 0) {
> +		log_level = 1;
>  		goto retry_load;
>  	}

I think the new log_level semantics makes sense,
but can we do it only in one layer?
The above piece of bpf_object_load_prog_instance() will change log_level,
but then bpf_prog_load_v0_6_0() will do it again
when log_buf != NULL.
The latter will not malloc log_buf, but the former will.
Though both change log_level.
Can we somehow unify this logic and only do log_level adjustment and log_buf
alloc in bpf_object_load_prog_instance() only ?

> +	/* on ENOSPC, increase log buffer size, unless custom log_buf is specified */
> +	if (own_log_buf && errno == ENOSPC && log_buf_size < UINT_MAX / 2)
> +		goto retry_load;

The kernel allows buf_size <= UINT_MAX >> 2.
Above condition will probably get to the same value, but it's not obvious.
Maybe make it exactly as kernel?

> -	if (log_buf && log_buf[0] != '\0') {
> +	if (own_log_buf && log_buf && log_buf[0] != '\0') {
>  		pr_warn("prog '%s': -- BEGIN PROG LOAD LOG --\n%s-- END PROG LOAD LOG --\n",
>  			prog->name, log_buf);
>  	}
> @@ -6712,7 +6743,8 @@ static int bpf_object_load_prog_instance(struct bpf_object *obj, struct bpf_prog
>  	}
>  
>  out:
> -	free(log_buf);
> +	if (own_log_buf)
> +		free(log_buf);

For lksel I'm thinking to pass allocated log_buf back.
lskel has no ability to printf from inside of it, so log_buf has to be passed back.
I wonder whether it would make sense for libbpf as well?
The own_log_buf flag can be kept in bpf_program and caller can
examine the log_buf instead of doing bpf_program__set_log_buf() below...

> +int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size)
> +{
> +	if (log_size && !log_buf)
> +		return -EINVAL;
> +	if (prog->log_size > UINT_MAX)
> +		return -EINVAL;
> +	if (prog->obj->loaded)
> +		return -EBUSY;
> +
> +	prog->log_buf = log_buf;
> +	prog->log_size = log_size;
> +	return 0;
> +}

The problem with this helper is that the user would have to malloc
always even though the prog might load just fine.
But there is a chance of load failure even in production,
so the user would have to rely on libbpf printfs and override print func
or do prog_load without bpf_program__set_log_buf() and then do it again on error
or always do bpf_program__set_log_buf() with giant malloc.
All of these 3 options are not that great.
The 4th option is for libbpf to do a malloc in case of error and return it.
That's the most convenient:
err = ...prog_load(..)
if (err) // user will check what's in the log.
No need to override libbpf print, unconditionally allocated or do double load.
