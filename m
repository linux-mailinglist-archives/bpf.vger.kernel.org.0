Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842CF6570F5
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 00:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiL0XTh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Dec 2022 18:19:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiL0XTh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Dec 2022 18:19:37 -0500
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA87108E;
        Tue, 27 Dec 2022 15:19:36 -0800 (PST)
Received: by mail-io1-f52.google.com with SMTP id d123so7594809iof.6;
        Tue, 27 Dec 2022 15:19:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sbupdtVdTz+LltMLzxd/HsPKuNxO8PX5O/NtDk5n+o=;
        b=RZqJxuACpKfyDtKx4S+Ww+OmEkrULVsrzlzQ3eg1j+aqpAA9fU+ElEeTjTy+oG9tvP
         9SR7EWBHpO09xh2yli31uSTPJ/tEawbcCBJGXyxriWhofkAVnovgvRL6RiayPmt2FRHb
         MPn85+AB44UebtMEy/IBtUMfUuNdjBTaNq9b4IG2JLU0mG9GovNY7Hr5XXvPLLFMk1Fo
         P11N9aZ/0aW2FiSOMn6YdZluN/hiMsV/5+2Fevy5nKzKC/WjeI8bUGd2bNVQvkmLiZl6
         e+V7BOPfVxqBUAVj9DDvopi7eKV5maSQ+0553xSteCep62sVQi107ozJaeg2lrrl14im
         MS9w==
X-Gm-Message-State: AFqh2krGaNCUgme9EncJvXPfI6JQiTeLrdehoD4lOf1Md8drwkvYaQZt
        ldkrOhuDlbMFxc1W/Cy+Vn4fNnL+xmuFkmDu+bQ=
X-Google-Smtp-Source: AMrXdXvWu2qaNnbe1MztuuHk+vRJrQb4vB+01ouuKEVjGgXmD1LD6R5ddMwKYsfrse8TCDt08znSD+UoQ/5vBFuRcQU=
X-Received: by 2002:a5e:890a:0:b0:6ec:b1cc:d237 with SMTP id
 k10-20020a5e890a000000b006ecb1ccd237mr1446959ioj.35.1672183175665; Tue, 27
 Dec 2022 15:19:35 -0800 (PST)
MIME-Version: 1.0
References: <20221220220144.4016213-1-namhyung@kernel.org> <20221220220144.4016213-2-namhyung@kernel.org>
 <Y6RTy29ULXp8WJ/Q@hirez.programming.kicks-ass.net> <2d164a5f-2885-2a6e-581a-2673ca0b1b81@iogearbox.net>
 <CAM9d7cj=iuxhLndNMBMeff6Ayp2hLfdz+6CHsZL7g213aWbUYQ@mail.gmail.com>
 <Y6S7BcblAHO4nQTf@hirez.programming.kicks-ass.net> <CAM9d7chi6ijPEwkTbmLJGz+_fQFvnFxwc44M-g93ym2-ZPN9tw@mail.gmail.com>
 <Y6VefZAWVzwmkfjd@krava>
In-Reply-To: <Y6VefZAWVzwmkfjd@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 27 Dec 2022 15:19:24 -0800
Message-ID: <CAM9d7ci9MbW_HbGbYge2iqiiEr8VPk32-5cBMViwCFsV+EmfgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf/perf: Call perf_prepare_sample() before bpf_prog_run()
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>,
        LKML <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 22, 2022 at 11:53 PM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Thu, Dec 22, 2022 at 02:25:49PM -0800, Namhyung Kim wrote:
> > On Thu, Dec 22, 2022 at 12:16 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Dec 22, 2022 at 09:34:42AM -0800, Namhyung Kim wrote:
> > >
> > > > Sorry about that.  Let me rephrase it like below:
> > > >
> > > > With bpf_cast_to_kern_ctx(), BPF programs attached to a perf event
> > > > can access perf sample data directly from the ctx.
> > >
> > > This is the bpf_prog_run() in bpf_overflow_handler(), right?
> >
> > Yes.
> >
> > >
> > > > But the perf sample
> > > > data is not fully prepared at this point, and some fields can have invalid
> > > > uninitialized values.  So it needs to call perf_prepare_sample() before
> > > > calling the BPF overflow handler.
> > >
> > > It never was, why is it a problem now?
> >
> > BPF used to allow selected fields only like period and addr, and they
> > are initialized always by perf_sample_data_init().  This is relaxed
> > by the bpf_cast_to_kern_ctx() and it can easily access arbitrary
> > fields of perf_sample_data now.
> >
> > The background of this change is to use BPF as a filter for perf
> > event samples.  The code is there already and returning 0 from
> > BPF can drop perf samples.  With access to more sample data,
> > it'd make more educated decisions.
> >
> > For example, I got some requests to limit perf samples in a
> > selected region of address (code or data).  Or it can collect
> > samples only if some hardware specific information is set in
> > the raw data like in AMD IBS.  We can easily extend it to other
> > sample info based on users' needs.
> >
> > >
> > > > But just calling perf_prepare_sample() can be costly when the BPF
> > >
> > > So you potentially call it twice now, how's that useful?
> >
> > Right.  I think we can check data->sample_flags in
> > perf_prepare_sample() to minimize the duplicate work.
> > It already does it for some fields, but misses others.
>
> we used to have __PERF_SAMPLE_CALLCHAIN_EARLY to avoid extra perf_callchain,
> could we add some flag like __PERF_SAMPLE_INIT_EARLY to avoid double call to
> perf_prepare_sample?

I think we can check if the filtered_sample_type is 0.
But it still needs to update the perf_event_header.
I think we need to save the calculated size separately.

Thanks,
Namhyung
