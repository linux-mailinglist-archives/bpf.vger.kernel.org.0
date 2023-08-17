Return-Path: <bpf+bounces-7946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9280877EEDC
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 03:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488FB281B27
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 01:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4C7397;
	Thu, 17 Aug 2023 01:54:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C1379
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 01:54:13 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB10268F
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 18:54:12 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b962c226ceso111889391fa.3
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 18:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692237250; x=1692842050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qsfWGGrfEh2PezBypiwZu1UXGi1GUB7Ozkvi2tIHzo=;
        b=SXVs1NrWT6t0RojrLmZsGMVjjPcUaVwv3UUVUl79+sHdrx/G/9DprlHce7StxofVH8
         rL8+cTMDeQbRwEw296SSAynqeSh2lORxSmih8K3/2kwWAvXrqBLT9iKUBfrUO7sM4Whh
         ZyZmGzOiiwgpOPPHHPWWkSBTtsj+KbTdOLKE56P948iLnAkZPgOni0yFsL0AMbOpLfNN
         ZglQcbYqHgPUUQkrjTZiAz+zi49Awv9O2Z6Y+Nz7fHOXAQ1TuXjYws3llPCCPRTvbByM
         oN+kywW0jIB27zKU0kjB/Kpv7JIOAeQbV2UMegBQ0Ud0CKP7GhDwU5osNkE/pj8TauiJ
         FX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692237250; x=1692842050;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qsfWGGrfEh2PezBypiwZu1UXGi1GUB7Ozkvi2tIHzo=;
        b=UaaLtyG8rOTdLWJ2I88BMFD2NDKoktuF39NYF2kGNUhtX6ZyKKpJu8sxPxIJeqI3fg
         HLza0wyC/YNsio0ZMdkuJj7GEU/H0Ikp82AOSXU/oETaOD2fbfkUOPsO9aDIi0RTSA8J
         N5+JAeUC6zQ4Yhk3ZqAECo0ImctPhwHIDemiIc5GDINra9sDJrC3BXBQ+w4JaoMsZtKU
         B1TfnT+0MNLzhK5w8FJ+A98xStj9ukG0GjZ/SXtTTS1MJJnZFi8nlRGz/CJE3MfGuLBS
         KZCCXWAy4fbg9JhFC/kRxbe1hjfeSF8BJ7jjkU9YbgX+hK1EzARpo+Izxfm6aqcbPW+/
         NRIA==
X-Gm-Message-State: AOJu0YzTJytVna08o3GRk2Z/H6DK/9CVEKgZ/UWGbT/8OTli2V7YhmzX
	zGbGC6bec1VHybwtB+n6iwSPuyNzcZP9fQPt0cQ=
X-Google-Smtp-Source: AGHT+IFjZu1lutwuCxTzPr9VXdZ+U5OX43gw8gMuyMVpy89TPGgK4F9FZC6NgNz8ZhAgkKbMQ8n+0RnnH9bmab7m01k=
X-Received: by 2002:a2e:241a:0:b0:2b9:df53:4c2a with SMTP id
 k26-20020a2e241a000000b002b9df534c2amr3065621ljk.20.1692237249814; Wed, 16
 Aug 2023 18:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814143341.3767-1-laoar.shao@gmail.com> <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev> <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
In-Reply-To: <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 16 Aug 2023 18:53:58 -0700
Message-ID: <CAADnVQJ1ddz9H4GQmegb4QMHk0cq_hXvK_r+MaLLssV7XtNY2g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Aug 14, 2023 at 7:46=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Tue, Aug 15, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.song@linu=
x.dev> wrote:
> >
> >
> >
> > On 8/14/23 7:33 AM, Yafang Shao wrote:
> > > Add a new bpf_current_capable kfunc to check whether the current task
> > > has a specific capability. In our use case, we will use it in a lsm b=
pf
> > > program to help identify if the user operation is permitted.
> > >
> > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > ---
> > >   kernel/bpf/helpers.c | 6 ++++++
> > >   1 file changed, 6 insertions(+)
> > >
> > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > index eb91cae..bbee7ea 100644
> > > --- a/kernel/bpf/helpers.c
> > > +++ b/kernel/bpf/helpers.c
> > > @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
> > >       rcu_read_unlock();
> > >   }
> > >
> > > +__bpf_kfunc bool bpf_current_capable(int cap)
> > > +{
> > > +     return has_capability(current, cap);
> > > +}
> >
> > Since you are testing against 'current' capabilities, I assume
> > that the context should be process. Otherwise, you are testing
> > against random task which does not make much sense.
>
> It is in the process context.
>
> >
> > Since you are testing against 'current' cap, and if the capability
> > for that task is stable, you do not need this kfunc.
> > You can test cap in user space and pass it into the bpf program.
> >
> > But if the cap for your process may change in the middle of
> > run, then you indeed need bpf prog to test capability in real time.
> > Is this your use case and could you describe in in more detail?
>
> After we convert the capability of our networking bpf program from
> CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
> encountered the "pointer comparison prohibited" error, because
> allow_ptr_leaks is enabled only when CAP_PERFMON is set. However, if
> we enable the CAP_PERFMON for the networking bpf program, it can run
> tracing bpf prog, perf_event bpf prog and etc, that is not expected by
> us.
>
> Hence we are planning to use a lsm bpf program to disallow it from
> running other bpf programs. In our lsm bpf program we will check the
> capability of processes, if the process has cap_net_admin, cap_bpf and
> cap_perfmon but don't have cap_sys_admin we will refuse it to run
> tracing and perf_event bpf program. While if a process has  cap_bpf
> and cap_perfmon but doesn't have cap_net_admin, that said it is a bpf
> program which wants to run trace bpf, we will allow it.
>
> We can't use lsm_cgroup because it is supported on cgroup2 only, while
> we're still using cgroup1.
>
> Another possible solution is enable allow_ptr_leaks for cap_net_admin
> as well, but after I checked the commit which introduces the cap_bpf
> and cap_perfmon [1], I think we wouldn't like to do it.

Sorry. None of these options are acceptable.

The idea of introducing a bpf_current_capable() kfunc just to work
around a deficiency in the verifier is not sound.

Next time instead of sending patch please describe the issue first.
You should have started with an email that:
        struct iphdr *iph =3D (void *)(long)skb->data + sizeof(struct ethhd=
r);

        if ((long)(iph + 1) > (long)skb->data_end)
needs cap_perfmon.

