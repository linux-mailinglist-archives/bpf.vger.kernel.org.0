Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC0D654D08
	for <lists+bpf@lfdr.de>; Fri, 23 Dec 2022 08:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235946AbiLWHxj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Dec 2022 02:53:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiLWHxi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 23 Dec 2022 02:53:38 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D59D31EDF;
        Thu, 22 Dec 2022 23:53:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u28so1249292edd.10;
        Thu, 22 Dec 2022 23:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8WKoOMPsmNwyEfgMM+9XAivDWwN5pCyQ5XhkIU1BGH4=;
        b=kcHZylwZirfcKWkwvdrtVgDTcsDUqU50o7awL9XBQ7nfteDUXq3p9DO3n8HKhglVK6
         tnVG/rwgBR0tO4fGtRV8WPvOYZX0jMmU5bjtmQ2kwdB3DMYVl9tWeff4Qp5RxHjJePL8
         awO8a/upMKNKWaQqekOje2rQVXreaPTDlHLAe3ZfYiXCKOhffyH4An7NUTMvN3Lt7LZS
         28tqOvOjWiPTd26N47r8EiIvUg8mgSyRxQ2Ncn4y5EB+DOwVVdM+HFY97aoKzZPXAbyd
         KU84P/BpOt4RFURxBnkvP5Qznozqkcjqehk0HvqwqbRxGpBMvcuzgeM4IspYENCGjjwh
         hSlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8WKoOMPsmNwyEfgMM+9XAivDWwN5pCyQ5XhkIU1BGH4=;
        b=U08FG6fTdBwayQX+8mQo2RAUkhedK/JNqeYk3lQ36mpBe4ags9vcjW0ruJpF32148R
         gEvxwOtbOh64vSJyEXDN3gKwHMhzXq2aoWA7k03if7LWmQrESuaa+7VGo5bTeoH2i3Y7
         DYQwSV/6Jr53jKIAJBq8Fd/S/Vs6YtIXM/hMYFpqfkR7HGbTkh+bgj9cgZsuIfHVchcV
         dKsKEsL3IE/Zc2JL7DoClNx0LXmePgHH8RGYO5+NFV6UpJ7hl70BB90T3VAjHQwvnoAt
         BptqWiXz4IScZVlz4fSzuewL4U1RlLc7A0skEqOf2ko2qTRP4hi4IhlGJX6MrFE1i+Zb
         VxFw==
X-Gm-Message-State: AFqh2kqoiIm//7ek3+7rSfVy1nGqE3qlZORKZtaCM0/oMe1+rkHjyq+F
        Wo3wDjnbTg43oITM0O5Lkrs=
X-Google-Smtp-Source: AMrXdXsCi64Chzl267PLU056ZrjMyCU/JJgj17w+RqHuxyhtFz74b19GEI8h62OB6dQUtTFJV8UFSw==
X-Received: by 2002:aa7:d513:0:b0:462:9baa:7507 with SMTP id y19-20020aa7d513000000b004629baa7507mr7488843edq.8.1671782015874;
        Thu, 22 Dec 2022 23:53:35 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id h26-20020a0564020e9a00b004822681a671sm303648eda.37.2022.12.22.23.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 23:53:35 -0800 (PST)
From:   Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date:   Fri, 23 Dec 2022 08:53:33 +0100
To:     Namhyung Kim <namhyung@kernel.org>
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
Subject: Re: [PATCH bpf-next 1/2] bpf/perf: Call perf_prepare_sample() before
 bpf_prog_run()
Message-ID: <Y6VefZAWVzwmkfjd@krava>
References: <20221220220144.4016213-1-namhyung@kernel.org>
 <20221220220144.4016213-2-namhyung@kernel.org>
 <Y6RTy29ULXp8WJ/Q@hirez.programming.kicks-ass.net>
 <2d164a5f-2885-2a6e-581a-2673ca0b1b81@iogearbox.net>
 <CAM9d7cj=iuxhLndNMBMeff6Ayp2hLfdz+6CHsZL7g213aWbUYQ@mail.gmail.com>
 <Y6S7BcblAHO4nQTf@hirez.programming.kicks-ass.net>
 <CAM9d7chi6ijPEwkTbmLJGz+_fQFvnFxwc44M-g93ym2-ZPN9tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chi6ijPEwkTbmLJGz+_fQFvnFxwc44M-g93ym2-ZPN9tw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 22, 2022 at 02:25:49PM -0800, Namhyung Kim wrote:
> On Thu, Dec 22, 2022 at 12:16 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Dec 22, 2022 at 09:34:42AM -0800, Namhyung Kim wrote:
> >
> > > Sorry about that.  Let me rephrase it like below:
> > >
> > > With bpf_cast_to_kern_ctx(), BPF programs attached to a perf event
> > > can access perf sample data directly from the ctx.
> >
> > This is the bpf_prog_run() in bpf_overflow_handler(), right?
> 
> Yes.
> 
> >
> > > But the perf sample
> > > data is not fully prepared at this point, and some fields can have invalid
> > > uninitialized values.  So it needs to call perf_prepare_sample() before
> > > calling the BPF overflow handler.
> >
> > It never was, why is it a problem now?
> 
> BPF used to allow selected fields only like period and addr, and they
> are initialized always by perf_sample_data_init().  This is relaxed
> by the bpf_cast_to_kern_ctx() and it can easily access arbitrary
> fields of perf_sample_data now.
> 
> The background of this change is to use BPF as a filter for perf
> event samples.  The code is there already and returning 0 from
> BPF can drop perf samples.  With access to more sample data,
> it'd make more educated decisions.
> 
> For example, I got some requests to limit perf samples in a
> selected region of address (code or data).  Or it can collect
> samples only if some hardware specific information is set in
> the raw data like in AMD IBS.  We can easily extend it to other
> sample info based on users' needs.
> 
> >
> > > But just calling perf_prepare_sample() can be costly when the BPF
> >
> > So you potentially call it twice now, how's that useful?
> 
> Right.  I think we can check data->sample_flags in
> perf_prepare_sample() to minimize the duplicate work.
> It already does it for some fields, but misses others.

we used to have __PERF_SAMPLE_CALLCHAIN_EARLY to avoid extra perf_callchain,
could we add some flag like __PERF_SAMPLE_INIT_EARLY to avoid double call to
perf_prepare_sample?

jirka 

> 
> Thanks,
> Namhyung
