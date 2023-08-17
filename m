Return-Path: <bpf+bounces-8006-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B2177FD30
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 19:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55C91C20ADA
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 17:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32970171D2;
	Thu, 17 Aug 2023 17:45:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0752614AA6
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 17:45:49 +0000 (UTC)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E34C1
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 10:45:48 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2bb8a12e819so743541fa.1
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 10:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692294346; x=1692899146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+0PjpjBem4tkXjUVL0tJEr9DCwUlrp7qlIci8BlYFM=;
        b=mUWmp5lPipafPgIH4DPIrC6z79o8D7PXLKYWtSfLRWBRnuLB0UoBDe3eWTi/BKxJ0V
         etCAf9e4eoDkappuBbChyWVrKgSuVWu5ljozTbxtU8D8YcoibDLrszWL06UHFz3/U3Mj
         NnR4eNBaA9/anPgpy1wl9PV33+cnFtkAVgYN+PrIMNvOLK6N1s5SHI9n4cVyBN6Qvk22
         6IbdMbIRpc8PU9sI+7e8lF/3ynkBfRB53KUk3IZ7UwVs+2bAkUKxg9qakB/CBUO79p2Y
         Jg2xeK0FbkatvzCqMY2h+PK03dfVukCu7Ynt9Nu0YsOP5WddtyqfGyH5/HB78nZ0ipoc
         vrzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692294346; x=1692899146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+0PjpjBem4tkXjUVL0tJEr9DCwUlrp7qlIci8BlYFM=;
        b=JuURxVoB8GuX/F6LO1ynCKuETwwtKpKLtjAm8C4uj9+I6mYYCTYRW0Easnyp+QcznQ
         KuBx97Q6hqN4uErN5jqBx5eg9YanI+FOJ4Gnvc1cFA7/Hf5GCczuDWD2hvs9YOsslogp
         HbxNvdv/OxTcyUnpdzyFkY4bu3HwKX2r1I7f7aPEl3AUxOJTdW5/FWTLFk4PlpBfvaSf
         4Fr4Om+8XHocGU9MUEurZFcSR/CHgmqyS+PFGVvulPoxM4GuwkrjTRAMlRTI0AWRxojR
         nNEx3iRA9v75wJD5fftgEaoKsFSvpxfjGyQb3d+qCyBe3BdI2YKJPHCgfId15xUkWcZz
         EbAQ==
X-Gm-Message-State: AOJu0YzydGLFEb04aBY1YbBd0tz12uSMZqIrTeYCvUq23cGz5aPp+Xw4
	teoPHaQqhMoOxSHFqX237wHFTslxOwhRpFQ0kW8b7h1V
X-Google-Smtp-Source: AGHT+IHZlhst2ZuDOXmnZtBB/h9ZYqh2bHrTeupVRjkh8JvC0jpFosb5FbMMXKIdlaPkUann7yiMHlfM8V13fCWkK4c=
X-Received: by 2002:a2e:9d46:0:b0:2b9:aa4d:3719 with SMTP id
 y6-20020a2e9d46000000b002b9aa4d3719mr50955ljj.12.1692294346059; Thu, 17 Aug
 2023 10:45:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814143341.3767-1-laoar.shao@gmail.com> <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev> <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
 <CAADnVQJ1ddz9H4GQmegb4QMHk0cq_hXvK_r+MaLLssV7XtNY2g@mail.gmail.com>
 <CALOAHbDO-mdehzkojC_ZHnfoty=RrEr2ehYT7-qj1mzSpw-6aA@mail.gmail.com>
 <CAADnVQ+Nmspr7Si+pxWn8zkE7hX-7s93ugwC+94aXSy4uQ9vBg@mail.gmail.com>
 <CALOAHbDF=h9Piyx3BERNjK7Y_n6+qPefDvs+pFyZb5H2SmCkhQ@mail.gmail.com> <91d1017f-0c08-6db7-8696-63bd95c2b8a0@iogearbox.net>
In-Reply-To: <91d1017f-0c08-6db7-8696-63bd95c2b8a0@iogearbox.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Aug 2023 10:45:34 -0700
Message-ID: <CAADnVQLid7QvukhnqRoY2VVFi1tCfkPFsMGUUeHDtCgf0SAJCg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/2] bpf: Add bpf_current_capable kfunc
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Yafang Shao <laoar.shao@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 8:30=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> On 8/17/23 9:09 AM, Yafang Shao wrote:
> > On Thu, Aug 17, 2023 at 11:31=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> >> On Wed, Aug 16, 2023 at 7:31=E2=80=AFPM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> >>> On Thu, Aug 17, 2023 at 9:54=E2=80=AFAM Alexei Starovoitov
> >>> <alexei.starovoitov@gmail.com> wrote:
> >>>> On Mon, Aug 14, 2023 at 7:46=E2=80=AFPM Yafang Shao <laoar.shao@gmai=
l.com> wrote:
> >>>>> On Tue, Aug 15, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.son=
g@linux.dev> wrote:
> >>>>>> On 8/14/23 7:33 AM, Yafang Shao wrote:
> >>>>>>> Add a new bpf_current_capable kfunc to check whether the current =
task
> >>>>>>> has a specific capability. In our use case, we will use it in a l=
sm bpf
> >>>>>>> program to help identify if the user operation is permitted.
> >>>>>>>
> >>>>>>> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> >>>>>>> ---
> >>>>>>>    kernel/bpf/helpers.c | 6 ++++++
> >>>>>>>    1 file changed, 6 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >>>>>>> index eb91cae..bbee7ea 100644
> >>>>>>> --- a/kernel/bpf/helpers.c
> >>>>>>> +++ b/kernel/bpf/helpers.c
> >>>>>>> @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(void)
> >>>>>>>        rcu_read_unlock();
> >>>>>>>    }
> >>>>>>>
> >>>>>>> +__bpf_kfunc bool bpf_current_capable(int cap)
> >>>>>>> +{
> >>>>>>> +     return has_capability(current, cap);
> >>>>>>> +}
> >>>>>>
> >>>>>> Since you are testing against 'current' capabilities, I assume
> >>>>>> that the context should be process. Otherwise, you are testing
> >>>>>> against random task which does not make much sense.
> >>>>>
> >>>>> It is in the process context.
> >>>>>
> >>>>>> Since you are testing against 'current' cap, and if the capability
> >>>>>> for that task is stable, you do not need this kfunc.
> >>>>>> You can test cap in user space and pass it into the bpf program.
> >>>>>>
> >>>>>> But if the cap for your process may change in the middle of
> >>>>>> run, then you indeed need bpf prog to test capability in real time=
.
> >>>>>> Is this your use case and could you describe in in more detail?
> >>>>>
> >>>>> After we convert the capability of our networking bpf program from
> >>>>> CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
> >>>>> encountered the "pointer comparison prohibited" error, because
> >>>>> allow_ptr_leaks is enabled only when CAP_PERFMON is set. However, i=
f
> >>>>> we enable the CAP_PERFMON for the networking bpf program, it can ru=
n
> >>>>> tracing bpf prog, perf_event bpf prog and etc, that is not expected=
 by
> >>>>> us.
> >>>>>
> >>>>> Hence we are planning to use a lsm bpf program to disallow it from
> >>>>> running other bpf programs. In our lsm bpf program we will check th=
e
> >>>>> capability of processes, if the process has cap_net_admin, cap_bpf =
and
> >>>>> cap_perfmon but don't have cap_sys_admin we will refuse it to run
> >>>>> tracing and perf_event bpf program. While if a process has  cap_bpf
> >>>>> and cap_perfmon but doesn't have cap_net_admin, that said it is a b=
pf
> >>>>> program which wants to run trace bpf, we will allow it.
> >>>>>
> >>>>> We can't use lsm_cgroup because it is supported on cgroup2 only, wh=
ile
> >>>>> we're still using cgroup1.
> >>>>>
> >>>>> Another possible solution is enable allow_ptr_leaks for cap_net_adm=
in
> >>>>> as well, but after I checked the commit which introduces the cap_bp=
f
> >>>>> and cap_perfmon [1], I think we wouldn't like to do it.
> >>>>
> >>>> Sorry. None of these options are acceptable.
> >>>>
> >>>> The idea of introducing a bpf_current_capable() kfunc just to work
> >>>> around a deficiency in the verifier is not sound.
> >>>
> >>> So what should we do then?
> >>> Just enabling the cap_perfmon for it? That does not sound as well ...
> >>
> >> Yonghong already pointed out upthread that
> >> comparison of two packet pointers is not a pointer leak.
> >> See this code:
> >>          } else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn-=
>src_reg],
> >>                                             this_branch, other_branch)=
 &&
> >>                     is_pointer_value(env, insn->dst_reg)) {
> >>                  verbose(env, "R%d pointer comparison prohibited\n",
> >>                          insn->dst_reg);
> >>                  return -EACCES;
> >>          }
> >>
> >> It's not clear why it doesn't address your case.
> >
> > It can address the issue.
> > It seems we should do the code change below.
>
> I presume in your actual program you also access the IP header (otherwise=
 it
> would be quite useless), and as you mentioned above, you would like this =
to be
> accessible for just CAP_BPF + CAP_NET_ADMIN. The CAP_PERFMON restriction =
is
> there for a reason, that is, to be on same cap level as tracing programs =
as you
> could craft Spectre v1 style access. It's not a deficiency.

Probably not. To mount v1 style attack the load of data_end needs to
be attacker controlled which isn't the case here.

