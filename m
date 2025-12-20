Return-Path: <bpf+bounces-77241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC02CD2B63
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 10:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28BEC3013EAB
	for <lists+bpf@lfdr.de>; Sat, 20 Dec 2025 09:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B2429E113;
	Sat, 20 Dec 2025 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aUfj1HTV"
X-Original-To: bpf@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0669F2A1BB
	for <bpf@vger.kernel.org>; Sat, 20 Dec 2025 09:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766221292; cv=none; b=QdLs02HljWrzZGDgKoSqORVXa9W5bg5nuUtTqtfKd7+TpF+B/G39nNUAX47XFJ7lOQQqA2k/7sh95CeVuWCau4jWUv8ODrsii6IA2JRdHJG6tTC9IyEsk7r67KbnFzRXpQB9nAO8Tt8qrZKefCiUQiN1HS90YQGIcr16htTE/1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766221292; c=relaxed/simple;
	bh=4d+O9OuZ4RRNCWdOVZ0WRa+EtjazEcsVoEBPPFfY6zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DtTLPUI/amYhvFlHamXZqqfjmYevnKuxfEB4l/XmiQfZ7ZBJQdw+WLrMkkK9ulQVi9ls4dItRwwkeJlnM106Q5sFdei7W0A0C5Jf++TukzdxOTU2eUKHD/xjDOhMW9YgglC4LPBVvJqMTw9h6TrDL1sXGqjRZYdOVPuj6hzPgoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aUfj1HTV; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766221287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR8YAfzmmuv6Sn9sLH28S4YXG3HmYocRCaop46ntYtM=;
	b=aUfj1HTVKbxAWoFKoFpJ3kIxoY+ntKqEQ2fy/+eA1MtuV/ycA0jvGrhKAbiuDLwz5mrBHB
	LUzbgAptu8kvzMQVzjuSexV7Zt988XqydaxraPo8T9Xbu4JczIHxA0fzxPLPRFbb/N3kET
	MMdf9vP+JUFvdBx3WOAEY3/EWqCCeCk=
From: Menglong Dong <menglong.dong@linux.dev>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 andrii@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/9] bpf: tracing session supporting
Date: Sat, 20 Dec 2025 17:01:06 +0800
Message-ID: <6114986.MhkbZ0Pkbq@7950hx>
In-Reply-To: <2393471.ElGaqSPkdT@7950hx>
References:
 <20251217095445.218428-1-dongml2@chinatelecom.cn>
 <CAEf4BzYm3=zzmCRg3zr1F99sBkxEZ_pDgjtKMBurb9LGu6JJKQ@mail.gmail.com>
 <2393471.ElGaqSPkdT@7950hx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/20 09:12, Menglong Dong wrote:
> On 2025/12/20 00:55, Andrii Nakryiko wrote:
> > On Thu, Dec 18, 2025 at 5:18=E2=80=AFPM Menglong Dong <menglong.dong@li=
nux.dev> wrote:
> > >
> > > On 2025/12/19 08:55 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> > > > On Wed, Dec 17, 2025 at 1:54=E2=80=AFAM Menglong Dong <menglong8.do=
ng@gmail.com> wrote:
> > > > >
> > > > > Hi, all.
> > > > >
> > > > > In this version, I combined Alexei and Andrii's advice, which mak=
es the
> > > > > architecture specific code much simpler.
> > > > >
> > > > > Sometimes, we need to hook both the entry and exit of a function =
with
> > > > > TRACING. Therefore, we need define a FENTRY and a FEXIT for the t=
arget
> > > > > function, which is not convenient.
> > > > >
> > > > > Therefore, we add a tracing session support for TRACING. Generally
> > > > > speaking, it's similar to kprobe session, which can hook both the=
 entry
> > > > > and exit of a function with a single BPF program. Session cookie =
is also
> > > > > supported with the kfunc bpf_fsession_cookie(). In order to limit=
 the
> > > > > stack usage, we limit the maximum number of cookies to 4.
> > > > >
> > > > > The kfunc bpf_fsession_is_return() and bpf_fsession_cookie() are =
both
> > > > > inlined in the verifier.
> > > >
> > > > We have generic bpf_session_is_return() and bpf_session_cookie() (t=
hat
> > > > currently works for ksession), can't you just implement them for the
> > > > newly added program type instead of adding type-specific kfuncs?
> > >
> > > Hi, Andrii. I tried and found that it's a little hard to reuse them. =
The
> > > bpf_session_is_return() and bpf_session_cookie() are defined as kfunc=
, which
> > > makes we can't implement different functions for different attach typ=
e, like
> > > what bpf helper does.
> >=20
> > Are you sure? We certainly support kfunc implementation specialization
> > for sleepable vs non-sleepable BPF programs. Check specialize_kfunc()
> > in verifier.c
>=20
> Ah, I remember it now. We do can use different kfunc version
> for different case in specialize_kfunc().
>=20
> >=20
> > >
> > > The way we store "is_return" and "cookie" in fsession is different wi=
th
> > > ksession. For ksession, it store the "is_return" in struct bpf_sessio=
n_run_ctx.
> > > Even if we move the "nr_regs" from stack to struct bpf_tramp_run_ctx,
> > > it's still hard to reuse the bpf_session_is_return() or bpf_session_c=
ookie(),
> > > as the way of storing the "is_return" and "cookie" in fsession and ks=
ession
> > > is different, and it's a little difficult and complex to unify them.
> >=20
> > I'm not saying we should unify the implementation, you have to
> > implement different version of logically the same kfunc, of course.
>=20
> I see. The problem now is that the prototype of bpf_session_cookie()
> or bpf_session_is_return() don't satisfy our need. For bpf_session_cookie=
(),
> we at least need the context to be the argument. However, both
> of them don't have any function argument. After all, the prototype of
> different version of logically the same kfunc should be the same.

Hi, Andrii. I see that you want to make the API consistent between
ksession and fsession, which is more friendly for the user.

After my analysis, I think we have following approach:
1. change the function prototype of bpf_session_cookie and bpf_session_is_r=
eturn
to:
    bool bpf_session_is_return(void *ctx);
    bool bpf_session_cookie(void *ctx);
And we do the fix up in specialize_kfunc(), which I think is the easiest
way. The defect is that it will break existing users.

2. We define a fixup_kfunc_call_early() and call it in add_subprog_and_kfun=
c.
In the fixup_kfunc_call_early(), we will change the target kfunc(which is i=
nsn->imm)
from bpf_session_cookie() to bpf_fsession_cookie(). For the bpf_session_coo=
kie(),
we make its prototype to:
    __bpf_kfunc __u64 *bpf_session_cookie(void *ctx__ign)
Therefore, it won't break the existing users. For the ksession that uses the
old prototype, it can pass the verifier too. Following is a demo patch of t=
his
approach. In this way, we can allow a extension in the prototype for a kfunc
in the feature too.

What do you think?

Thanks!
Menglong Dong

>patch<

+static int fixup_kfunc_call_early(struct bpf_verifier_env *env, struct bpf=
_insn *insn)
+{
+       struct bpf_prog *prog =3D env->prog;
+
+       if (prog->expected_attach_type =3D=3D BPF_TRACE_FSESSION) {
+               if (insn->imm =3D=3D special_kfunc_list[KF_bpf_session_cook=
ie])
+                       insn->imm =3D special_kfunc_list[KF_bpf_fsession_co=
okie];
+               else if (insn->imm =3D=3D special_kfunc_list[KF_bpf_session=
_is_return])
+                       insn->imm =3D special_kfunc_list[KF_bpf_fsession_is=
_return];
+       }
+
+       return 0;
+}

@@ -3489,10 +3490,12 @@ static int add_subprog_and_kfunc(struct bpf_verifie=
r_env *env)
                        return -EPERM;
                }
=20
=2D               if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn))
+               if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn)) {
                        ret =3D add_subprog(env, i + insn->imm + 1);
=2D               else
=2D                       ret =3D add_kfunc_call(env, insn->imm, insn->off);
+               } else {
+                       ret =3D fixup_kfunc_call_early(env, insn);
+                       ret =3D ret ?: add_kfunc_call(env, insn->imm, insn-=
>off);
+               }

@@ -3316,7 +3321,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_c=
tx *ctx)
=20
 __bpf_kfunc_start_defs();
=20
=2D__bpf_kfunc bool bpf_session_is_return(void)
+__bpf_kfunc bool bpf_session_is_return(void *ctx__ign)
 {
        struct bpf_session_run_ctx *session_ctx;
=20
@@ -3324,7 +3329,7 @@ __bpf_kfunc bool bpf_session_is_return(void)
        return session_ctx->is_return;
 }
=20
=2D__bpf_kfunc __u64 *bpf_session_cookie(void)
+__bpf_kfunc __u64 *bpf_session_cookie(void *ctx__ign)
 {
        struct bpf_session_run_ctx *session_ctx;

>=20
> I think it's not a good idea to modify the prototype of existing kfunc,
> can we?
>=20
> >=20
> > >
> > > What's more, we will lose the advantage of inline bpf_fsession_is_ret=
urn
> > > and bpf_fsession_cookie in verifier.
> > >
> >=20
> > I'd double check that either. BPF verifier and JIT do know program
> > type, so you can pick how to inline
> > bpf_session_is_return()/bpf_session_cookie() based on that.
>=20
> Yeah, we can inline it depend on the program type if we can solve
> the prototype problem.
>=20
> Thanks!
> Menglong Dong
>=20
>=20
> >=20
> > > I'll check more to see if there is a more simple way to reuse them.
> > >
> > > Thanks!
> > > Menglong Dong
> > >
> > > >
> [...]
> > >
> > >
> > >
> > >
>=20
>=20
>=20
>=20
>=20





