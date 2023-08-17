Return-Path: <bpf+bounces-7948-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00D777EF19
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 04:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247831C2029F
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 02:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEC8396;
	Thu, 17 Aug 2023 02:31:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F52736A
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 02:31:19 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F12270C
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 19:31:17 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76cd8dab98fso480376385a.3
        for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 19:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692239477; x=1692844277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d3qVT8gkowPftB3CFUs/ZRd0xXo0W0OJZOlEenWMq6Q=;
        b=hystXIIDnn/R0LipvD4kAt4VAtmx0L48n4UlosL86hPQ8x0wWo07ewRSLFfWaT3FxX
         UBzZHW1pQkj9EcIbPJqWVSfpLzYnpc8TS3MpBh8wcR8g3VjrcSRGyhZaaOdpQpJZ3uLM
         h1OGEDvWtTNsTC2mOAMOsEej6AxATPlT3827tdf3EvpQmTXrW75XGldhVJs4h9OHV8QP
         qjdlW7wVW79NRkR/mJwWP5OpbXmglITDSjZ0bgrlxXadt4qMrnzQS2krYobQNRKROWcf
         1IbHuZ79lOpUjLJSgwjwB+3rxuXCtJGgzEG3UD9o5Pa4SazBtr3hP5SZ70iAv7nl8BsH
         WsCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692239477; x=1692844277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d3qVT8gkowPftB3CFUs/ZRd0xXo0W0OJZOlEenWMq6Q=;
        b=D0QrNruHX7pXG5A62IRatyR5JcsrO0hWInrQwwksZ83PG6GQhHx2ow3vcXaGkN3rrd
         7Nlgu7xEcli3eeT5gyX+B1O0nQKbTmQhrGu9oW3cnKjuo7PCe+Ykl1DRaAyeJyKqRwOp
         X1u4LfiMx1AyAeJjiMZKJUtVq4qvby3IFGYIvjalNCymyJKQyCtjj4sasua0ctOP7W/5
         XtWholr/e2SY6kwp8OEV92YV+fAFmYs3ST4yIOMC2Rfm4zr5/fhGLaVUdZVY3Fy1hOnZ
         rsdWgtcX2oIMYIwvF8giaZbDI3d6q/qMWBMQe5hGnQ97+PdQT6SzZ9NG1Rn0ZMGGzR+1
         Rzag==
X-Gm-Message-State: AOJu0YwvSMCYcBbm9zsnFT+DFf1xVwEVg2E53RhkB7Aks4V3NQeMz/tt
	V3fynmYfoevqpajEJhFvUPWbvihLIwOW1T/hlYo=
X-Google-Smtp-Source: AGHT+IGx+SbTcoDcCXm5UvdRl6L9Sa8oTY9euUxz7U0sOsinX2HQGqmmrcVG55DVkozH2oo1R8sdY5O7X0mStm9JiHw=
X-Received: by 2002:a05:620a:3905:b0:76d:3475:2def with SMTP id
 qr5-20020a05620a390500b0076d34752defmr4613086qkn.8.1692239476842; Wed, 16 Aug
 2023 19:31:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814143341.3767-1-laoar.shao@gmail.com> <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev> <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
 <CAADnVQJ1ddz9H4GQmegb4QMHk0cq_hXvK_r+MaLLssV7XtNY2g@mail.gmail.com>
In-Reply-To: <CAADnVQJ1ddz9H4GQmegb4QMHk0cq_hXvK_r+MaLLssV7XtNY2g@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 17 Aug 2023 10:30:40 +0800
Message-ID: <CALOAHbDO-mdehzkojC_ZHnfoty=RrEr2ehYT7-qj1mzSpw-6aA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
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

On Thu, Aug 17, 2023 at 9:54=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Aug 14, 2023 at 7:46=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Tue, Aug 15, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> > >
> > >
> > >
> > > On 8/14/23 7:33 AM, Yafang Shao wrote:
> > > > Add a new bpf_current_capable kfunc to check whether the current ta=
sk
> > > > has a specific capability. In our use case, we will use it in a lsm=
 bpf
> > > > program to help identify if the user operation is permitted.
> > > >
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > >   kernel/bpf/helpers.c | 6 ++++++
> > > >   1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > index eb91cae..bbee7ea 100644
> > > > --- a/kernel/bpf/helpers.c
> > > > +++ b/kernel/bpf/helpers.c
> > > > @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
> > > >       rcu_read_unlock();
> > > >   }
> > > >
> > > > +__bpf_kfunc bool bpf_current_capable(int cap)
> > > > +{
> > > > +     return has_capability(current, cap);
> > > > +}
> > >
> > > Since you are testing against 'current' capabilities, I assume
> > > that the context should be process. Otherwise, you are testing
> > > against random task which does not make much sense.
> >
> > It is in the process context.
> >
> > >
> > > Since you are testing against 'current' cap, and if the capability
> > > for that task is stable, you do not need this kfunc.
> > > You can test cap in user space and pass it into the bpf program.
> > >
> > > But if the cap for your process may change in the middle of
> > > run, then you indeed need bpf prog to test capability in real time.
> > > Is this your use case and could you describe in in more detail?
> >
> > After we convert the capability of our networking bpf program from
> > CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
> > encountered the "pointer comparison prohibited" error, because
> > allow_ptr_leaks is enabled only when CAP_PERFMON is set. However, if
> > we enable the CAP_PERFMON for the networking bpf program, it can run
> > tracing bpf prog, perf_event bpf prog and etc, that is not expected by
> > us.
> >
> > Hence we are planning to use a lsm bpf program to disallow it from
> > running other bpf programs. In our lsm bpf program we will check the
> > capability of processes, if the process has cap_net_admin, cap_bpf and
> > cap_perfmon but don't have cap_sys_admin we will refuse it to run
> > tracing and perf_event bpf program. While if a process has  cap_bpf
> > and cap_perfmon but doesn't have cap_net_admin, that said it is a bpf
> > program which wants to run trace bpf, we will allow it.
> >
> > We can't use lsm_cgroup because it is supported on cgroup2 only, while
> > we're still using cgroup1.
> >
> > Another possible solution is enable allow_ptr_leaks for cap_net_admin
> > as well, but after I checked the commit which introduces the cap_bpf
> > and cap_perfmon [1], I think we wouldn't like to do it.
>
> Sorry. None of these options are acceptable.
>
> The idea of introducing a bpf_current_capable() kfunc just to work
> around a deficiency in the verifier is not sound.

So what should we do then?
Just enabling the cap_perfmon for it? That does not sound as well ...

>
> Next time instead of sending patch please describe the issue first.
> You should have started with an email that:
>         struct iphdr *iph =3D (void *)(long)skb->data + sizeof(struct eth=
hdr);
>
>         if ((long)(iph + 1) > (long)skb->data_end)
> needs cap_perfmon.

Got it.  Thanks for your explanation.

--=20
Regards
Yafang

