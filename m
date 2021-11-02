Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF574425A7
	for <lists+bpf@lfdr.de>; Tue,  2 Nov 2021 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhKBCgA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Nov 2021 22:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhKBCgA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Nov 2021 22:36:00 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D69C061714
        for <bpf@vger.kernel.org>; Mon,  1 Nov 2021 19:33:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f8so13654396plo.12
        for <bpf@vger.kernel.org>; Mon, 01 Nov 2021 19:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bjR1hn75qkAKpYQBOR52U3342BSmFLfpgHVpS+7ucTo=;
        b=VvEitRDdp5Juw0GPpPsdklLjuBp5d2qIvsLJnazJBopdJ8Up6N7Fd2Yn0SWjXISllm
         QBnXK+cvVRhuN/exG+dOpXVjfV075dGhV0g6nT69IXPVOU4JkGoguZGtwJH2rug7cOun
         7Uw10WQT0D/v9VQV3KhQUDY9xz/HWYMgGxHnENMlR8peQSNDCeAPGIW5vwFf7QyiBbPY
         My7v3XnhhKPZMm52cwCagtF4whMOqeAhCqHmnxB3B8XAXpQdxkGF5VBor5mekeujslXE
         GJ0/TbDoD6DlXAcpG+MIPoJl8uzY/K7RlViyFCtiexWi2YQS3Lae8cPfD6exaYftuoT6
         FTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bjR1hn75qkAKpYQBOR52U3342BSmFLfpgHVpS+7ucTo=;
        b=LzTRkUAgGxrd42WaJoO4edWqF+AEnysnW4PWDEdjN2jZE5q4gf2NcpxltBp4O29mOD
         sprwcDg1F05ALN/luXcv5iZx2gpZlXFxiEJRXrQsQcDNVtPg7ozGEw1oV6mNKq2h/6PG
         WizzSXXG1Za62qEXnmCzCAjGC7MdTkt4qd+7vvLSyoh77e1tnxkvPrVAtFSSAym7wfvp
         6r4BtURnskWExX0qOWxvrIVuCnnmysxvWfCHdrWoQ4WvKuUhXlKvtXcz7iswS5ubGuE5
         zIB1KTHE5VryMgLNLECAmOGgwhO6qlMy+lDAfjO++0l3TPaE3tYVZHfGFj/ufsF0t2fT
         a/Ig==
X-Gm-Message-State: AOAM530b0OT2LbjACarH9Z/i3qO4zQiOV5aPKjTuW3fjC/R8F9+sfsQ+
        hqC26uaJ9ad3c85p/NzqQoQ=
X-Google-Smtp-Source: ABdhPJxZzGG8NIYKqTlp5qUKucl8nDD9wapayqMCR7bZmFMtSe+HercLRmbaZZo/VX1NKaj5JOE8wQ==
X-Received: by 2002:a17:90a:600d:: with SMTP id y13mr3326529pji.84.1635820405371;
        Mon, 01 Nov 2021 19:33:25 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:400::5:880e])
        by smtp.gmail.com with ESMTPSA id fh3sm676056pjb.8.2021.11.01.19.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 19:33:24 -0700 (PDT)
Date:   Mon, 1 Nov 2021 19:33:22 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Hengqi Chen <hengqi.chen@gmail.com>
Subject: Re: [PATCH bpf-next 05/14] libbpf: unify low-level BPF_PROG_LOAD
 APIs into bpf_prog_load()
Message-ID: <20211102023322.6nelw3v7hxplq6lu@ast-mbp.dhcp.thefacebook.com>
References: <20211030045941.3514948-1-andrii@kernel.org>
 <20211030045941.3514948-6-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030045941.3514948-6-andrii@kernel.org>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 29, 2021 at 09:59:32PM -0700, Andrii Nakryiko wrote:
> -int bpf_prog_load(const char *file, enum bpf_prog_type type,
> -		  struct bpf_object **pobj, int *prog_fd)
> +COMPAT_VERSION(bpf_prog_load_deprecated, bpf_prog_load, LIBBPF_0.0.1)
> +int bpf_prog_load_deprecated(const char *file, enum bpf_prog_type type,
> +			     struct bpf_object **pobj, int *prog_fd)
..
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 43580eb47740..b895861a13c0 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -395,6 +395,8 @@ LIBBPF_0.6.0 {
>  		bpf_object__next_program;
>  		bpf_object__prev_map;
>  		bpf_object__prev_program;
> +		bpf_prog_load_deprecated;
> +		bpf_prog_load;
>  		bpf_program__insn_cnt;
>  		bpf_program__insns;
>  		btf__add_btf;

Is it really LIBBPF_0.0.1 ? or 0.6.0 ? which one is correct.
Maybe I'm misreading what COMPAT macro will do.
