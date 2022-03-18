Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F0A4DE1A5
	for <lists+bpf@lfdr.de>; Fri, 18 Mar 2022 20:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240308AbiCRTOz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Mar 2022 15:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbiCRTOz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Mar 2022 15:14:55 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790C5137F54
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 12:13:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id p17so7708257plo.9
        for <bpf@vger.kernel.org>; Fri, 18 Mar 2022 12:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VYUxvdjowFRRcdH+uW/oT6Oggj8o1n4z1JzEnJqEwUw=;
        b=KTi5GmKjnPzwrJGri1i3E2mREzMeCewTN8krEc7yLmdKZBVsVpvhjPuYWg3sNbi3BH
         ERTv4KrdtdbU+kEkzsxP63b0G6R/9BJHsz1PuKihr5MbhaFidpe3VGw6pNySH34Z513A
         x1SifmJOz0rUrNcGX/x9LkHjjRM1xlYg+2j54gaLYa7+P9cRkNlngzdI8AkMa+/o4GWW
         hHGGDtvdVX/C7cZaUYyQnOINbRA5vHtvOSVbZqUf31EkXepe/rGTZ4Wzgm2RMce8TEH+
         hvu5qqk73zofZx2fmIUSkZM+eqKVutwRCPvBfKOPCRoNIvyZNX6exIiN3Mq9cjOtWWlx
         wQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VYUxvdjowFRRcdH+uW/oT6Oggj8o1n4z1JzEnJqEwUw=;
        b=BjSQ+Ae8Ia3a2UBAfSiWqT6vyhKyjbdBp8GbdzC/mWrkQBfMGnMO4FPTyJwV1NdRDT
         xCj6/icqnSXjoWgtrIYiHv7qvBC5Vj4MUTlhKEiqjdMYppQ14NSHNsm4Bm1h68N3YkqK
         ybH3zVp7UpCJslyzNq5SWXAvJeuUczZjwwL2aeloNtinoISIO21AU6BYQ9ua7p5fmQEQ
         v/0etizSutjmRw0ioaBwbjkbweD7oYEvEn2+I9fhqN/EZ/6O2MIeU5bYjClo5tRpgMyJ
         zgYXowz7IAfSC+hUcaU6JI+egf+DbO+FpQeg7/gcTGKbFDZFQBklB0El5Rp284xrNgEK
         2nAg==
X-Gm-Message-State: AOAM532W2F8pD7jMXxkb7hK1ox8wUR6h1JeUsjo8/kpYOtqOFfYvzIla
        7d4jJSN3YTA4X+TgzZaybTk=
X-Google-Smtp-Source: ABdhPJzbzEzrshFCMa4EwUrdJjBWzCCd+kSgl5MAoAmYIM45b7S9GFzjNqa5mZ4xiF+KHkqHwrEHEg==
X-Received: by 2002:a17:902:b490:b0:14c:da4a:deca with SMTP id y16-20020a170902b49000b0014cda4adecamr970471plr.134.1647630814842;
        Fri, 18 Mar 2022 12:13:34 -0700 (PDT)
Received: from ast-mbp ([2620:10d:c090:400::5:7e8b])
        by smtp.gmail.com with ESMTPSA id q2-20020a638c42000000b003817671cb29sm7741959pgn.41.2022.03.18.12.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Mar 2022 12:13:34 -0700 (PDT)
Date:   Fri, 18 Mar 2022 12:13:32 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for
 fentry/fexit/fmod_ret.
Message-ID: <20220318191332.7qsztafrjyu7bjtc@ast-mbp>
References: <20220316004231.1103318-1-kuifeng@fb.com>
 <20220316004231.1103318-4-kuifeng@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316004231.1103318-4-kuifeng@fb.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 15, 2022 at 05:42:30PM -0700, Kui-Feng Lee wrote:
> Add a bpf_cookie field to attach a cookie to an instance of struct
> bpf_link.  The cookie of a bpf_link will be installed when calling the
> associated program to make it available to the program.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>  arch/x86/net/bpf_jit_comp.c    |  4 ++--
>  include/linux/bpf.h            |  1 +
>  include/uapi/linux/bpf.h       |  1 +
>  kernel/bpf/syscall.c           | 11 +++++++----
>  kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  1 +
>  tools/lib/bpf/bpf.c            | 14 ++++++++++++++
>  tools/lib/bpf/bpf.h            |  1 +
>  tools/lib/bpf/libbpf.map       |  1 +
>  9 files changed, 45 insertions(+), 6 deletions(-)

please split kernel and libbpf changes into two different patches.

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index f69ce3a01385..dbbf09c84c21 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1133,6 +1133,20 @@ int bpf_raw_tracepoint_open(const char *name, int prog_fd)
>  	return libbpf_err_errno(fd);
>  }
>  
> +int bpf_raw_tracepoint_cookie_open(const char *name, int prog_fd, __u64 bpf_cookie)

lets introduce opts style to raw_tp_open instead.

> +{
> +	union bpf_attr attr;
> +	int fd;
> +
> +	memset(&attr, 0, sizeof(attr));
> +	attr.raw_tracepoint.name = ptr_to_u64(name);
> +	attr.raw_tracepoint.prog_fd = prog_fd;
> +	attr.raw_tracepoint.bpf_cookie = bpf_cookie;
> +
> +	fd = sys_bpf_fd(BPF_RAW_TRACEPOINT_OPEN, &attr, sizeof(attr));
> +	return libbpf_err_errno(fd);
> +}
> +
>  int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_load_opts *opts)
>  {
>  	const size_t attr_sz = offsetofend(union bpf_attr, btf_log_level);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 5253cb4a4c0a..23bebcdaf23b 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -477,6 +477,7 @@ LIBBPF_API int bpf_prog_query(int target_fd, enum bpf_attach_type type,
>  			      __u32 query_flags, __u32 *attach_flags,
>  			      __u32 *prog_ids, __u32 *prog_cnt);
>  LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
> +LIBBPF_API int bpf_raw_tracepoint_cookie_open(const char *name, int prog_fd, __u64 bpf_cookie);
>  LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
>  				 __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
>  				 __u64 *probe_offset, __u64 *probe_addr);
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index df1b947792c8..20f947a385fa 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -434,6 +434,7 @@ LIBBPF_0.7.0 {
>  		bpf_xdp_detach;
>  		bpf_xdp_query;
>  		bpf_xdp_query_id;
> +		bpf_raw_tracepoint_cookie_open;
>  		libbpf_probe_bpf_helper;
>  		libbpf_probe_bpf_map_type;
>  		libbpf_probe_bpf_prog_type;
> -- 
> 2.30.2
> 

-- 
