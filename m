Return-Path: <bpf+bounces-7965-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBB577F0EB
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 09:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1E081C2117A
	for <lists+bpf@lfdr.de>; Thu, 17 Aug 2023 07:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065051C2D;
	Thu, 17 Aug 2023 07:10:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D171E138A
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 07:10:11 +0000 (UTC)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4485F272B
	for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 00:10:10 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76d7fcb2c71so13837385a.2
        for <bpf@vger.kernel.org>; Thu, 17 Aug 2023 00:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692256209; x=1692861009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/I0Cp8ScZZiAN6rycc6j+yX+mFbsjdXi98MyD+5G60s=;
        b=WbNOBYgIcdFDalnsxIMLXpYowKftNeYenW+m4uIMZzc6ARFdDcA4hE1Df9FNzAwzc0
         7DF8DR4xyuPxU4oloA5Gdf9BD0oRFkJllXzGi9xqhzgz98NMtJbayZWyJnXU7blAq0s+
         q0sFK/mIT7q7G/Br7zfAIEdqYiZqfh4XSTOfRujDCJ4ACvCeBqDGIvYWa/ZVrb0cMoO/
         6mPG+6s7xWSlJlsM/O2f/RHpO8Q58mKSxU8xVFW40HwTF8Y5G95vVjGGZyOe3KnqSEqm
         sXYXSJyjrHrYzOmmeHgksGMS9WwlhObl7n3v8qIsl1ZLJKFBtNK1g75qmH1BaVE4cmSN
         wp4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692256209; x=1692861009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/I0Cp8ScZZiAN6rycc6j+yX+mFbsjdXi98MyD+5G60s=;
        b=SeXRWuI3n+xe1ekFfZ+uFy1GzzmDb0sP5I6l4pYrprF/i2x6geyOO1CNm0bupslAFZ
         vMUm11UFo0juzu6nJkAaW3al3outl8yb/mHf5XjnfiX7FklDwLgfTc3kNSecT6bn+nrF
         asKT6jJTRsjHSEt9mvHcyXCyXGmQhiuNfxA+zTowFtrqotQSxURmf76O9lTtnE6YPmvH
         3rZnDcrqPy3gs5EavQ+0dH691oC0dg8WxQkNsjJ5hpVcq01ROUpSdfrCzqkmGb4G886d
         8A5IUPB5AGqstJ7OcHghUE8C/u/Ull+mRNeU5C9pIH1NBQUdxk/g4P/4UbVwsawRirfs
         FEig==
X-Gm-Message-State: AOJu0YwlFhKRKUCflbpTMEKEb0/hseS9FIPfnNZLPGMZ6DSRn/TvhL7U
	nn9pxkrh7czWzEqJzlObTrPDw+RW12SemESDckbYAllQ3nUj1aoe
X-Google-Smtp-Source: AGHT+IF2diAdcoKQ/EYTlt1/pip/E8rH1jCz48riBCUzBPSqBxdZc65DRtw9ebegbXcGWDBF7xhaGSXwMnVr3RY6Md8=
X-Received: by 2002:a0c:e20d:0:b0:647:27b1:3c83 with SMTP id
 q13-20020a0ce20d000000b0064727b13c83mr4179811qvl.8.1692256209362; Thu, 17 Aug
 2023 00:10:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230814143341.3767-1-laoar.shao@gmail.com> <20230814143341.3767-2-laoar.shao@gmail.com>
 <56dc2449-f01c-f0a7-e31b-cfe6cd157aaa@linux.dev> <CALOAHbC9cka4Ma7KWOjGtFkjshU214z9NMaYXHiOTfc7dc7=tQ@mail.gmail.com>
 <CAADnVQJ1ddz9H4GQmegb4QMHk0cq_hXvK_r+MaLLssV7XtNY2g@mail.gmail.com>
 <CALOAHbDO-mdehzkojC_ZHnfoty=RrEr2ehYT7-qj1mzSpw-6aA@mail.gmail.com> <CAADnVQ+Nmspr7Si+pxWn8zkE7hX-7s93ugwC+94aXSy4uQ9vBg@mail.gmail.com>
In-Reply-To: <CAADnVQ+Nmspr7Si+pxWn8zkE7hX-7s93ugwC+94aXSy4uQ9vBg@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 17 Aug 2023 15:09:33 +0800
Message-ID: <CALOAHbDF=h9Piyx3BERNjK7Y_n6+qPefDvs+pFyZb5H2SmCkhQ@mail.gmail.com>
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

On Thu, Aug 17, 2023 at 11:31=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Aug 16, 2023 at 7:31=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> >
> > On Thu, Aug 17, 2023 at 9:54=E2=80=AFAM Alexei Starovoitov
> > <alexei.starovoitov@gmail.com> wrote:
> > >
> > > On Mon, Aug 14, 2023 at 7:46=E2=80=AFPM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > >
> > > > On Tue, Aug 15, 2023 at 8:28=E2=80=AFAM Yonghong Song <yonghong.son=
g@linux.dev> wrote:
> > > > >
> > > > >
> > > > >
> > > > > On 8/14/23 7:33 AM, Yafang Shao wrote:
> > > > > > Add a new bpf_current_capable kfunc to check whether the curren=
t task
> > > > > > has a specific capability. In our use case, we will use it in a=
 lsm bpf
> > > > > > program to help identify if the user operation is permitted.
> > > > > >
> > > > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > > > ---
> > > > > >   kernel/bpf/helpers.c | 6 ++++++
> > > > > >   1 file changed, 6 insertions(+)
> > > > > >
> > > > > > diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > > > > > index eb91cae..bbee7ea 100644
> > > > > > --- a/kernel/bpf/helpers.c
> > > > > > +++ b/kernel/bpf/helpers.c
> > > > > > @@ -2429,6 +2429,11 @@ __bpf_kfunc void bpf_rcu_read_unlock(voi=
d)
> > > > > >       rcu_read_unlock();
> > > > > >   }
> > > > > >
> > > > > > +__bpf_kfunc bool bpf_current_capable(int cap)
> > > > > > +{
> > > > > > +     return has_capability(current, cap);
> > > > > > +}
> > > > >
> > > > > Since you are testing against 'current' capabilities, I assume
> > > > > that the context should be process. Otherwise, you are testing
> > > > > against random task which does not make much sense.
> > > >
> > > > It is in the process context.
> > > >
> > > > >
> > > > > Since you are testing against 'current' cap, and if the capabilit=
y
> > > > > for that task is stable, you do not need this kfunc.
> > > > > You can test cap in user space and pass it into the bpf program.
> > > > >
> > > > > But if the cap for your process may change in the middle of
> > > > > run, then you indeed need bpf prog to test capability in real tim=
e.
> > > > > Is this your use case and could you describe in in more detail?
> > > >
> > > > After we convert the capability of our networking bpf program from
> > > > CAP_SYS_ADMIN to CAP_BPF+CAP_NET_ADMIN to enhance the security, we
> > > > encountered the "pointer comparison prohibited" error, because
> > > > allow_ptr_leaks is enabled only when CAP_PERFMON is set. However, i=
f
> > > > we enable the CAP_PERFMON for the networking bpf program, it can ru=
n
> > > > tracing bpf prog, perf_event bpf prog and etc, that is not expected=
 by
> > > > us.
> > > >
> > > > Hence we are planning to use a lsm bpf program to disallow it from
> > > > running other bpf programs. In our lsm bpf program we will check th=
e
> > > > capability of processes, if the process has cap_net_admin, cap_bpf =
and
> > > > cap_perfmon but don't have cap_sys_admin we will refuse it to run
> > > > tracing and perf_event bpf program. While if a process has  cap_bpf
> > > > and cap_perfmon but doesn't have cap_net_admin, that said it is a b=
pf
> > > > program which wants to run trace bpf, we will allow it.
> > > >
> > > > We can't use lsm_cgroup because it is supported on cgroup2 only, wh=
ile
> > > > we're still using cgroup1.
> > > >
> > > > Another possible solution is enable allow_ptr_leaks for cap_net_adm=
in
> > > > as well, but after I checked the commit which introduces the cap_bp=
f
> > > > and cap_perfmon [1], I think we wouldn't like to do it.
> > >
> > > Sorry. None of these options are acceptable.
> > >
> > > The idea of introducing a bpf_current_capable() kfunc just to work
> > > around a deficiency in the verifier is not sound.
> >
> > So what should we do then?
> > Just enabling the cap_perfmon for it? That does not sound as well ...
>
> Yonghong already pointed out upthread that
> comparison of two packet pointers is not a pointer leak.
> See this code:
>         } else if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src=
_reg],
>                                            this_branch, other_branch) &&
>                    is_pointer_value(env, insn->dst_reg)) {
>                 verbose(env, "R%d pointer comparison prohibited\n",
>                         insn->dst_reg);
>                 return -EACCES;
>         }
>
> It's not clear why it doesn't address your case.

It can address the issue.
It seems we should do the code change below.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0b9da95..c66dc61 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13819,6 +13819,18 @@ static int check_cond_jmp_op(struct
bpf_verifier_env *env,
                return -EINVAL;
        }

+       other_branch =3D push_stack(env, *insn_idx + insn->off + 1, *insn_i=
dx,
+                                 false);
+       if (!other_branch)
+               return -EFAULT;
+
+       /* check src2 operand */
+       err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
+       if (err)
+               return err;
+
+       dst_reg =3D &regs[insn->dst_reg];
+
        if (BPF_SRC(insn->code) =3D=3D BPF_X) {
                if (insn->imm !=3D 0) {
                        verbose(env, "BPF_JMP/JMP32 uses reserved fields\n"=
);
@@ -13830,7 +13842,9 @@ static int check_cond_jmp_op(struct
bpf_verifier_env *env,
                if (err)
                        return err;

-               if (is_pointer_value(env, insn->src_reg)) {
+               if (!try_match_pkt_pointers(insn, dst_reg, &regs[insn->src_=
reg],
+                                          this_branch, other_branch) &&
+                   is_pointer_value(env, insn->src_reg)) {
                        verbose(env, "R%d pointer comparison prohibited\n",
                                insn->src_reg);
                        return -EACCES;
@@ -13843,12 +13857,6 @@ static int check_cond_jmp_op(struct
bpf_verifier_env *env,
                }
        }

-       /* check src2 operand */
-       err =3D check_reg_arg(env, insn->dst_reg, SRC_OP);
-       if (err)
-               return err;
-
-       dst_reg =3D &regs[insn->dst_reg];
        is_jmp32 =3D BPF_CLASS(insn->code) =3D=3D BPF_JMP32;

        if (BPF_SRC(insn->code) =3D=3D BPF_K) {
@@ -13920,10 +13928,6 @@ static int check_cond_jmp_op(struct
bpf_verifier_env *env,
                return 0;
        }

-       other_branch =3D push_stack(env, *insn_idx + insn->off + 1, *insn_i=
dx,
-                                 false);
-       if (!other_branch)
-               return -EFAULT;
        other_branch_regs =3D other_branch->frame[other_branch->curframe]->=
regs;

        /* detect if we are comparing against a constant value so we can ad=
just


--=20
Regards
Yafang

