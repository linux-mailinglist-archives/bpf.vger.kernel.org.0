Return-Path: <bpf+bounces-44069-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFFB89BD6FD
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 21:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC8283F19
	for <lists+bpf@lfdr.de>; Tue,  5 Nov 2024 20:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89EE214410;
	Tue,  5 Nov 2024 20:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1K+wimr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A271FF7C5
	for <bpf@vger.kernel.org>; Tue,  5 Nov 2024 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838401; cv=none; b=ouGO8rAfsjcPQEYR58iPrVSGhcqOwgqgLmeFEkpohkq93DGvAev3xmb3kHVfgclx72dsU440mbqfmvaUce4bWVZ7VsQOWmyH0ljxNc47DQgBNdoybcztABXICUSikmHSMSRntfDtwcakGUPd52GuccBgwpY3vce3eC7mYiOCi/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838401; c=relaxed/simple;
	bh=J8cnoj9JRkPSTCOIkKbR92Yw189pMrMOtXckUiYKcm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dq9dceF/L2DYiutkrdq7lrHbZ6vDajzq04ThEYFNB9rEaZS66N4EasvHzMPzhM/CN4Q25MbjMbAimp4a3cTTLEmYI6frWg+bphjdgy5UtYAnp6jOmSsQ1QikkDabnNhchyz5/THLz3mGTbsBoSpEyRUdqdKhXa2mA5s0QDQX8OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1K+wimr; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so5277867f8f.3
        for <bpf@vger.kernel.org>; Tue, 05 Nov 2024 12:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730838398; x=1731443198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VMwnoCfpMfFy6vuI6Gtdn0WlzqQ1tHDhgaLZe6my7AY=;
        b=Z1K+wimrrKP300vL7NSUz0IBbgMovnPOzNXWRNSBn7P87mqXA81WauG44kCizlDkqG
         pb7GdK36GVhvvZZy74ifdMndBLdkglwM0bEXcCuyF1Ptyo4j0QHorPm/+JNjaAPAKKuK
         tPzsHt+ZpgYxXUqpIaW8GL18mbz+llO1vu0vB2MZUAsM2xUzkJ9AMW3m0hZ8IeY8bcpe
         GYm5UrGDJ4DpCAdCCBDPg5fgY3EGKnladtR6HbZLABcDCZs7IUeoVhK+Wzw77tz6oTx8
         si7uTTGBh2pItunNLqfcXoxZSX6sYrn6oCXZaap3rmMd+MSuwlldfTTRojhu+UT6WSNz
         kbZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838398; x=1731443198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMwnoCfpMfFy6vuI6Gtdn0WlzqQ1tHDhgaLZe6my7AY=;
        b=FAMMC9zFzu1GaYIjNMYSxr2gS/DXY+x3einiiBjIoLhOFyXtFsj0clnDFGizPIsz7r
         hGBMsfRh744AK3AwDyNJzhOBE+Z60YywGfYBtamIai8mYof4mtzggfM/Obm94K9g9VwN
         KytN5oN0vGKfHdJMYQFQLYEnM+H3uJDA9R9mtZdaNGQqqH7DxqtGaf0ayKN5ItokONcl
         xg9u3gKQgIofmjDZaPHAY+u0PmzYaP86GnUltqq4X6FV4Qy/Bx5wp+ZkMEgqGFEQDwIS
         433nc9rNWMTX5dHP8quAMd/FPhj/X0fFNgOyN8vFrJTZ2fpr9kHLCzMKTI0KQKkEsk0F
         f1+w==
X-Gm-Message-State: AOJu0Yy9fu7/xi/DWOvAP3v609DJ+w8M4eWlMEaiaZYYo51ApL4cR9V5
	J/H7aYzWGuvpdBx8AbhuQBSfzvNNVzjAzdf4vA912d1ElGGiK0LWne+mpbcn0k6brQj3tIhxKEC
	13iUzD9gkyas9sf9ujQX5XZ6VZXE=
X-Google-Smtp-Source: AGHT+IHKHACeqLPaaiE6LDjeAV1wpbl3T4/k7w41asROFdvQxP28JJqP6EXJ8O8PRZLEt/d9T33ddaY1u2n521JzvtY=
X-Received: by 2002:a5d:59a7:0:b0:37d:4376:6e1d with SMTP id
 ffacd0b85a97d-381c7ac45b8mr16965908f8f.41.1730838397462; Tue, 05 Nov 2024
 12:26:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241104193455.3241859-1-yonghong.song@linux.dev>
 <20241104193515.3243315-1-yonghong.song@linux.dev> <CAADnVQL3MkDgZykq1H3NhJio8gZDnf3+kXXw7AQ36uT8yw5UfQ@mail.gmail.com>
 <a34f5be8-8cf9-4659-badd-32c387cefe29@linux.dev>
In-Reply-To: <a34f5be8-8cf9-4659-badd-32c387cefe29@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 5 Nov 2024 12:26:26 -0800
Message-ID: <CAADnVQJzV_eRaNMzYP5Fj-FsSNx7-1-f0yXjtXSpeOqr9tBVAg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 04/10] bpf: Check potential private stack
 recursion for progs with async callback
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kernel Team <kernel-team@fb.com>, Martin KaFai Lau <martin.lau@kernel.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 4, 2024 at 7:37=E2=80=AFPM Yonghong Song <yonghong.song@linux.d=
ev> wrote:
>
>
> On 11/4/24 6:51 PM, Alexei Starovoitov wrote:
> > On Mon, Nov 4, 2024 at 11:38=E2=80=AFAM Yonghong Song <yonghong.song@li=
nux.dev> wrote:
> >> In previous patch, tracing progs are enabled for private stack since
> >> recursion checking ensures there exists no nested same bpf prog run on
> >> the same cpu.
> >>
> >> But it is still possible for nested bpf subprog run on the same cpu
> >> if the same subprog is called in both main prog and async callback,
> >> or in different async callbacks. For example,
> >>    main_prog
> >>     bpf_timer_set_callback(timer, timer_cb);
> >>     call sub1
> >>    sub1
> >>     ...
> >>    time_cb
> >>     call sub1
> >>
> >> In the above case, nested subprog run for sub1 is possible with one in
> >> process context and the other in softirq context. If this is the case,
> >> the verifier will disable private stack for this bpf prog.
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   include/linux/bpf_verifier.h |  2 ++
> >>   kernel/bpf/verifier.c        | 42 +++++++++++++++++++++++++++++++---=
--
> >>   2 files changed, 39 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier=
.h
> >> index 0622c11a7e19..e921589abc72 100644
> >> --- a/include/linux/bpf_verifier.h
> >> +++ b/include/linux/bpf_verifier.h
> >> @@ -669,6 +669,8 @@ struct bpf_subprog_info {
> >>          /* true if bpf_fastcall stack region is used by functions tha=
t can't be inlined */
> >>          bool keep_fastcall_stack: 1;
> >>          bool use_priv_stack: 1;
> >> +       bool visited_with_priv_stack_accum: 1;
> >> +       bool visited_with_priv_stack: 1;
> >>
> >>          u8 arg_cnt;
> >>          struct bpf_subprog_arg_info args[MAX_BPF_FUNC_REG_ARGS];
> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 406195c433ea..e01b3f0fd314 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -6118,8 +6118,12 @@ static int check_max_stack_depth_subprog(struct=
 bpf_verifier_env *env, int idx,
> >>                                          idx, subprog_depth);
> >>                                  return -EACCES;
> >>                          }
> >> -                       if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE=
)
> >> +                       if (subprog_depth >=3D BPF_PRIV_STACK_MIN_SIZE=
) {
> >>                                  subprog[idx].use_priv_stack =3D true;
> >> +                               subprog[idx].visited_with_priv_stack =
=3D true;
> >> +                       }
> >> +               } else {
> >> +                       subprog[idx].visited_with_priv_stack =3D true;
> > See suggestion for patch 3.
> > It's cleaner to rewrite with a single visited_with_priv_stack =3D true;=
 statement.
>
> Ack.
>
> >
> >>                  }
> >>          }
> >>   continue_func:
> >> @@ -6220,10 +6224,12 @@ static int check_max_stack_depth_subprog(struc=
t bpf_verifier_env *env, int idx,
> >>   static int check_max_stack_depth(struct bpf_verifier_env *env)
> >>   {
> >>          struct bpf_subprog_info *si =3D env->subprog_info;
> >> +       enum priv_stack_mode orig_priv_stack_supported;
> >>          enum priv_stack_mode priv_stack_supported;
> >>          int ret, subtree_depth =3D 0, depth_frame;
> >>
> >>          priv_stack_supported =3D bpf_enable_priv_stack(env->prog);
> >> +       orig_priv_stack_supported =3D priv_stack_supported;
> >>
> >>          if (priv_stack_supported !=3D NO_PRIV_STACK) {
> >>                  for (int i =3D 0; i < env->subprog_cnt; i++) {
> >> @@ -6240,13 +6246,39 @@ static int check_max_stack_depth(struct bpf_ve=
rifier_env *env)
> >>                                                              priv_stac=
k_supported);
> >>                          if (ret < 0)
> >>                                  return ret;
> >> +
> >> +                       if (priv_stack_supported !=3D NO_PRIV_STACK) {
> >> +                               for (int j =3D 0; j < env->subprog_cnt=
; j++) {
> >> +                                       if (si[j].visited_with_priv_st=
ack_accum &&
> >> +                                           si[j].visited_with_priv_st=
ack) {
> >> +                                               /* si[j] is visited by=
 both main/async subprog
> >> +                                                * and another async s=
ubprog.
> >> +                                                */
> >> +                                               priv_stack_supported =
=3D NO_PRIV_STACK;
> >> +                                               break;
> >> +                                       }
> >> +                                       if (!si[j].visited_with_priv_s=
tack_accum)
> >> +                                               si[j].visited_with_pri=
v_stack_accum =3D
> >> +                                                       si[j].visited_=
with_priv_stack;
> >> +                               }
> >> +                       }
> >> +                       if (priv_stack_supported !=3D NO_PRIV_STACK) {
> >> +                               for (int j =3D 0; j < env->subprog_cnt=
; j++)
> >> +                                       si[j].visited_with_priv_stack =
=3D false;
> >> +                       }
> > I cannot understand what this algorithm is doing.
> > What is the meaning of visited_with_priv_stack_accum ?
>
> The following is an example to show how the algorithm works.
> Let us say we have prog like
>     main_prog0  si[0]
>       sub1      si[1]
>       sub2      si[2]
>     async1      si[3]
>       sub4      si[4]
>       sub2      si[2]
>     async2      si[5]
>       sub4      si[4]
>       sub5      si[6]
>
>
> Total 9 subprograms.
>
> after iteration 1 (main_prog0)
>     visited_with_priv_stack_accum: si[i] =3D false for i =3D 0 ... 9
>     visited_with_priv_stack: si[0] =3D si[1] =3D si[2] =3D true, others f=
alse
>
>     for all i, visited_with_priv_stack_accum[i] and visited_with_priv_sta=
ck[i]
>     is false, so main_prog0 can use priv stack.
>
>     visited_with_priv_stack_accum: si[0] =3D si[1] =3D si[2] =3D true; ot=
hers false
>     visited_with_priv_stack cleared with false.
>
> after iteration 2 (async1)
>     visited_with_priv_stack_accum: si[0] =3D si[1] =3D si[2] =3D true; ot=
hers false
>     visited_with_priv_stack: si[2] =3D si[3] =3D si[4] =3D true, others f=
alse
>
>     Here, si[2] appears in both visited_with_priv_stack_accum and
>     visited_with_priv_stack, so async1 cannot have priv stack.
>
>     In my algorithm, I flipped the whole thing to no_priv_stack, which is
>     too conservative. We should just skip async1 and continues.
>
>     Let us say, we say async1 not having priv stack while main_prog0 has.
>
>     /* the same as end of iteration 1 */
>     visited_with_priv_stack_accum: si[0] =3D si[1] =3D si[2] =3D true; ot=
hers false
>     visited_with_priv_stack cleared with false.
>
> after iteration 3 (async2)
>     visited_with_priv_stack_accum: si[0] =3D si[1] =3D si[2] =3D true; ot=
hers false
>     visited_with_priv_stack: si[4] =3D si[5] =3D si[6] =3D true;
>
>     there are no conflict, so async2 can use private stack.
>
>
> If we only have one bit in bpf_subprog_info, for a async tree,
> if marking a subprog to be true and later we found there is a conflict in
> async tree and we need make the whole async subprogs not eligible for pri=
v stack,
> then it will be hard to undo previous markings.
>
> So visited_with_priv_stack_accum is to accumulate "true" results from
> main_prog/async's.

I see. I think it works, but feels complicated.
It feels it should be possible to do without extra flags. Like
check_max_stack_depth_subprog() will know whether it was called
to verify async_cb or not.
So it's just a matter of adding single 'if' to it:
if (subprog[idx].use_priv_stack && checking_async_cb)
   /* reset to false due to potential recursion */
   subprog[idx].use_priv_stack =3D false;

check_max_stack_depth() starts with i=3D=3D0,
so reachable and eligible subprogs will be marked with use_priv_stack.
Then check_max_stack_depth_subprog() will be called again
to verify async. If it sees the mark it's a bad case.
what am I missing?

