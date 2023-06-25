Return-Path: <bpf+bounces-3383-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 018B373CDC6
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 03:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E30280F9F
	for <lists+bpf@lfdr.de>; Sun, 25 Jun 2023 01:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569A962C;
	Sun, 25 Jun 2023 01:19:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0BA7F
	for <bpf@vger.kernel.org>; Sun, 25 Jun 2023 01:19:21 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B28BEA
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:19:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f9c0abc8b1so25785135e9.1
        for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 18:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687655958; x=1690247958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YFfheJgBv8hOKGtN29y/O18Bd1ZF+XKPCoSCdp++obE=;
        b=YhBiQiuLeViPO/mKXKlLB3N5S+XGXXaJFGtxAIKEmgTeBlD1b803BwraCd8xdUrdEQ
         vd2mWD65x0FvFo5l6H+S2B4zaR8+hrZNPP07GfTTNuabmg09rCMXs66TSd6c7IsyEBbU
         y7B/uC1C0dQsvkdEiO3WbGme0Zlhp16sF40v9lYhYzT93aXm2LehIBIajQjdMHClxCXR
         bHFP+tkm+4ij6dYXSaXeP36Lm+Rf2wvIl9K0fyMygMJePzS2sOEgdIXcShTjkkd5rUqH
         aBoRyUUUftIQU8qktZowB+lryeSQYvZInbPUU7RPz7M22Ej2tbJ0kMD9jz8SKoxJmAz2
         jApg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687655958; x=1690247958;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YFfheJgBv8hOKGtN29y/O18Bd1ZF+XKPCoSCdp++obE=;
        b=Z+m4lhhadovQz/z6ocNQKblVD4magOZU0gdXO/iN7XcPhXkFrbT8mLgoQ/JI4oP+EF
         Zt2dP1C8BvJ3LncI8tJiXFiC+iiuJ2bAVDBjGVzu1UKxI4XkNE7StQL4tuHP3jkwcprA
         cNDzQAvl61KLQDFGhPrulXkImC5lFFW5g3NqdHsIMeQAW9yUBLhbdP6uzX22FEKKY3fB
         XzwARgICSY+XNzJ91iZGyyFxRCB4IAwkGz6+25iGjGsJoppO6O6GAnfqDvEFMKYyITZL
         Pp23gHfCbsHdrcRQKM2pDH/wk9qNyz9tsQbSkSuLYSUigo5iNPsS/RJRkaGsDy/Y7GBf
         QP2w==
X-Gm-Message-State: AC+VfDwbEF+CjAYNkl312sKoCyjSocBLm5y9E8DvwlNECpsk2oWXbDQw
	RpVg/V9/r3XzHd/e2HPrbIY=
X-Google-Smtp-Source: ACHHUZ4dGwYEkPX5e7HenqVOVNxYhG1tP2tUhQaobKGf6aUM2tTMcwoXpMwLXv808q09EfQC5DDLDA==
X-Received: by 2002:a1c:f317:0:b0:3f8:fc96:6bfd with SMTP id q23-20020a1cf317000000b003f8fc966bfdmr21750997wmq.17.1687655957661;
        Sat, 24 Jun 2023 18:19:17 -0700 (PDT)
Received: from krava (brn-rj-tbond05.sa.cz. [185.94.55.134])
        by smtp.gmail.com with ESMTPSA id a10-20020a1cf00a000000b003f8fb02c413sm3469887wmb.8.2023.06.24.18.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jun 2023 18:19:17 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 25 Jun 2023 03:19:13 +0200
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv2 bpf-next 01/24] bpf: Add multi uprobe link
Message-ID: <ZJeWEZu2lKw67dnS@krava>
References: <20230620083550.690426-1-jolsa@kernel.org>
 <20230620083550.690426-2-jolsa@kernel.org>
 <CAEf4BzZnn-m-5sTQEmCSyaQPNNyreE37Vu2GWtdLT=k+zR+kDA@mail.gmail.com>
 <ZJVViQEvUnMQN43b@krava>
 <CAEf4BzaQGqhO3hoGW-zvhioE=VKVpuMw5NTTvUw=sXTEoFptxA@mail.gmail.com>
 <CAADnVQKT2=MHXj4RD9TXwqnPqau94UMHgjspYGgyGpz_aUQjCg@mail.gmail.com>
 <CAEf4BzZRwsPK1mHDob4ROWjFyxaGM7vcQ7xZ8xQgEuY-7hFu_w@mail.gmail.com>
 <CAADnVQ+DVo2a6bCqzV3ipDVLEaVmiUgziM9im1ovG9S5epR5VQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+DVo2a6bCqzV3ipDVLEaVmiUgziM9im1ovG9S5epR5VQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 10:20:26AM -0700, Alexei Starovoitov wrote:
> On Fri, Jun 23, 2023 at 10:11 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Jun 23, 2023 at 9:39 AM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Fri, Jun 23, 2023 at 9:24 AM Andrii Nakryiko
> > > <andrii.nakryiko@gmail.com> wrote:
> > > >
> > > > > > > +
> > > > > > > +static int uprobe_prog_run(struct bpf_uprobe *uprobe,
> > > > > > > +                          unsigned long entry_ip,
> > > > > > > +                          struct pt_regs *regs)
> > > > > > > +{
> > > > > > > +       struct bpf_uprobe_multi_link *link = uprobe->link;
> > > > > > > +       struct bpf_uprobe_multi_run_ctx run_ctx = {
> > > > > > > +               .entry_ip = entry_ip,
> > > > > > > +       };
> > > > > > > +       struct bpf_prog *prog = link->link.prog;
> > > > > > > +       struct bpf_run_ctx *old_run_ctx;
> > > > > > > +       int err = 0;
> > > > > > > +
> > > > > > > +       might_fault();
> > > > > > > +
> > > > > > > +       rcu_read_lock_trace();
> > > > > >
> > > > > > we don't need this if uprobe is not sleepable, right? why unconditional then?
> > > > >
> > > > > I won't pretend I understand what rcu_read_lock_trace does ;-)
> > > > >
> > > > > I tried to follow bpf_prog_run_array_sleepable where it's called
> > > > > unconditionally for both sleepable and non-sleepable progs
> > > > >
> > > > > there are conditional rcu_read_un/lock calls later on
> > > > >
> > > > > I will check
> > > >
> > > > hm... Alexei can chime in here, but given here we actually are trying
> > > > to run one BPF program (not entire array of them), we do know whether
> > > > it's going to be sleepable or not. So we can avoid unnecessary
> > > > rcu_read_{lock,unlock}_trace() calls. rcu_read_lock_trace() is used
> > > > when there is going to be sleepable BPF program executed to protect
> > > > BPF maps and other resources from being freed too soon. But if we know
> > > > that we don't need sleepable, we can avoid that.
> > >
> > > We can add more checks and bool flags to avoid rcu_read_{lock,unlock}_trace(),
> > > but it will likely be slower. These calls are very fast.
> >
> > that's ok then. But seeing how we do
> >
> > rcu_read_lock_trace();
> > if (!sleepable)
> >     rcu_read_lock();
> >
> > it felt like we might as well just do
> >
> > if (sleepable)
> >     rcu_read_lock_trace();
> > else
> >     rcu_read_lock();

ok

> >
> >
> > As I mentioned, in this case we have a single bpf_prog, not a
> > bpf_prog_array, so that changes things a bit.
> 
> Ahh. It's only one prog. I missed that. Above makes sense then.
> But why is it not an array? We can attach multiple uprobes to the same
> location. Anyway that can be dealt with later.

I think we could add support for this later if it's needed

jirka

