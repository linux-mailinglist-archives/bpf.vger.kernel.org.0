Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07853C3D69
	for <lists+bpf@lfdr.de>; Sun, 11 Jul 2021 16:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233433AbhGKOvU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Jul 2021 10:51:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43880 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233427AbhGKOvU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 11 Jul 2021 10:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626014913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r4tbdpPuJ7aFid3Z3C7Kd9g0f7uB0rGzz41nOS5bFO0=;
        b=UvNNGCkukEpipJKzEDrZ+2YTllqsw12lb3bXduXVFGAA+C4pGnKzvOuWLUujy63cPuhIQu
        PpAOKZehYZbo7ytMv3lAureGI2bemM07QF9nHGszYuimKdBtDZXt39kdXa3YTZa7Geehzy
        CVuTqQL57gkOc8sXcjVQV+atT7mhYkU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-e1wS1uhUNHWV2-IHEHV3NQ-1; Sun, 11 Jul 2021 10:48:31 -0400
X-MC-Unique: e1wS1uhUNHWV2-IHEHV3NQ-1
Received: by mail-ed1-f69.google.com with SMTP id bx13-20020a0564020b4db02903a02214fad8so6187079edb.1
        for <bpf@vger.kernel.org>; Sun, 11 Jul 2021 07:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r4tbdpPuJ7aFid3Z3C7Kd9g0f7uB0rGzz41nOS5bFO0=;
        b=bp0pw20i8DLU3EDg2Q012K/vW+YlIZl0Yzm6ytAN7MvvBA6wc1lLe6wVO1xh04GVan
         FXYrd0b4qPb7g2GIQnpoWKAGkpep/YieOms8ro8o236qRBB8PJoCv3ycGgZMh6Jor94U
         bT7B8Ly8rBjH98u5ZzpfN2blkBOSvQnqoRZZXtZnzhB40XPz5yiO/cu1qA2Zrr5KgjG3
         UGQNF5oom+YCGNEHWhdlNd3VPLTMqwMfShnpVM2+L/YlS2D/rlq0heXtSiCpMKiz2k8l
         VZkzcBTrPNUak4tASTGzMtOMtxKuWIAJSAUFT0fBM+mt8H2lFcR7srx39kNgV6nSh1oP
         eAcA==
X-Gm-Message-State: AOAM5337hxl8QlxRNr+xZp7sq7bRJVV4RxtlEm+wnakeOkMvJNoo0ypN
        KNI7adT19FUQdoNs0rYKXwNjeWX+FEwvfsL/YZpE3N/ZTJTFFB4Hrq2iVwzQ4+hDopAgvD0HW65
        YHvFtX4gqVuS4
X-Received: by 2002:a17:906:d8da:: with SMTP id re26mr18411001ejb.205.1626014910088;
        Sun, 11 Jul 2021 07:48:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhWlIrGnG/YKxjM+TflGS3u4xGiFRJEL3/ELDokGJoTSPWjmkungMF93TjkIU3oeajoufgPw==
X-Received: by 2002:a17:906:d8da:: with SMTP id re26mr18410993ejb.205.1626014909988;
        Sun, 11 Jul 2021 07:48:29 -0700 (PDT)
Received: from krava ([5.171.250.127])
        by smtp.gmail.com with ESMTPSA id x13sm5082800ejv.64.2021.07.11.07.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 07:48:29 -0700 (PDT)
Date:   Sun, 11 Jul 2021 16:48:26 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCHv3 bpf-next 3/7] bpf: Add bpf_get_func_ip helper for
 tracing programs
Message-ID: <YOsEusl1MLaVJuF/@krava>
References: <20210707214751.159713-1-jolsa@kernel.org>
 <20210707214751.159713-4-jolsa@kernel.org>
 <CAEf4BzaF5Y6gbineUd-WLvbZQMSbR3v4j3zct3Qyq31OzWNnwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaF5Y6gbineUd-WLvbZQMSbR3v4j3zct3Qyq31OzWNnwA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 07, 2021 at 05:06:17PM -0700, Andrii Nakryiko wrote:
> On Wed, Jul 7, 2021 at 2:53 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > Adding bpf_get_func_ip helper for BPF_PROG_TYPE_TRACING programs,
> > specifically for all trampoline attach types.
> >
> > The trampoline's caller IP address is stored in (ctx - 8) address.
> > so there's no reason to actually call the helper, but rather fixup
> > the call instruction and return [ctx - 8] value directly (suggested
> > by Alexei).
> >
> > [fixed has_get_func_ip wrong return type]
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/uapi/linux/bpf.h       |  7 +++++
> >  kernel/bpf/verifier.c          | 53 ++++++++++++++++++++++++++++++++++
> >  kernel/trace/bpf_trace.c       | 15 ++++++++++
> >  tools/include/uapi/linux/bpf.h |  7 +++++
> >  4 files changed, 82 insertions(+)
> >
> 
> [...]
> 
> >  static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
> >                              int *insn_idx_p)
> >  {
> > @@ -6225,6 +6256,12 @@ static int check_helper_call(struct bpf_verifier_env *env, struct bpf_insn *insn
> >         if (func_id == BPF_FUNC_get_stackid || func_id == BPF_FUNC_get_stack)
> >                 env->prog->call_get_stack = true;
> >
> > +       if (func_id == BPF_FUNC_get_func_ip) {
> > +               if (has_get_func_ip(env))
> 
> from has_xxx name I'd expect it returns true/false, so this reads
> super confusing. check_get_func_ip would be a bit more consistent with
> other cases like this (still reads confusing to me, but that's ok)

ok, will change

jirka

> 
> > +                       return -ENOTSUPP;
> > +               env->prog->call_get_func_ip = true;
> > +       }
> > +
> >         if (changes_data)
> >                 clear_all_pkt_pointers(env);
> >         return 0;
> 
> [...]
> 

