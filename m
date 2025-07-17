Return-Path: <bpf+bounces-63546-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91142B08305
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 04:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A43484A26C7
	for <lists+bpf@lfdr.de>; Thu, 17 Jul 2025 02:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6161DB551;
	Thu, 17 Jul 2025 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tbDn+RFm"
X-Original-To: bpf@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961301CAA79
	for <bpf@vger.kernel.org>; Thu, 17 Jul 2025 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752719943; cv=none; b=C6ufoFq2Au6DsDN1kpAuPP8zMKYF4NKAKlpsFZHV4gROy/41RGFJCTy+6AD7u7ZeHPi4C5If7UK3WxlmdQF8FYhBxTXJkbVI9HjV8LB+Jw/S5OfcADRZc0t29dJusvAINU+F6IW3MeJhAG+NCtuL4CAvQtfNpcQv9H27VG9G7/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752719943; c=relaxed/simple;
	bh=X7EU9oEee9oD4miJuStT9hSRTZ4i2ynWyxm3zI8D50c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UoKqIrHmDYd+QMELSI8+BzFVx5TIpxQOqBM5Q1bT9mWIFfq1nAXjikfDbG0+gxkdIN+On5CBkoyWrt2Gfbdn8kAM2kzgskSqWvV/ihHlvtSXPX/Xky2yeGOMQNcEzx3GMOM84cS1H2puqb4jP7w6BzxtW489H1lGkfLjAWEi0sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tbDn+RFm; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752719929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RY0ytnIDZuO0Ep0XUcgWNN7p8LAkaHqP1azq5AefPSA=;
	b=tbDn+RFmzLUpmv3Q1dhNH2K3g66MNrivL4joRJCVSBziuhYHuHWEgXG8VUxrRCn/mMyPUu
	LSOw702iIe00IAAlnPYCgXiblRtwBmZAX00yiToAEDQYRRXoCvqrT0wKuniIHRt8BOpz9R
	XojfCI4iISnHR4N4fH/bMs/dByoVNh4=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, bpf <bpf@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Subject:
 Re: multi-fentry proposal. Was: [PATCH bpf-next v2 02/18] x86,bpf: add
 bpf_global_caller for global trampoline
Date: Thu, 17 Jul 2025 10:37:41 +0800
Message-ID: <3643244.iIbC2pHGDl@7940hx>
In-Reply-To:
 <CAADnVQLpAmZG_1827HS1dDaWBGraxY6UO92=tCX6eM9ZbqEBKQ@mail.gmail.com>
References:
 <20250703121521.1874196-1-dongml2@chinatelecom.cn>
 <3364591.aeNJFYEL58@7940hx>
 <CAADnVQLpAmZG_1827HS1dDaWBGraxY6UO92=tCX6eM9ZbqEBKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Migadu-Flow: FLOW_OUT

On Thursday, July 17, 2025 10:13 AM Alexei Starovoitov <alexei.starovoitov@=
gmail.com> write:
> On Wed, Jul 16, 2025 at 6:51=E2=80=AFPM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> > On Thursday, July 17, 2025 8:59 AM Alexei Starovoitov <alexei.starovoit=
ov@gmail.com> write:
> > > On Wed, Jul 16, 2025 at 6:06=E2=80=AFAM Menglong Dong <menglong.dong@=
linux.dev> wrote:
> > > >
> > > > On Wednesday, July 16, 2025 12:35 AM Alexei Starovoitov <alexei.sta=
rovoitov@gmail.com> write:
> > > > > On Tue, Jul 15, 2025 at 1:37=E2=80=AFAM Menglong Dong <menglong.d=
ong@linux.dev> wrote:
> > > > > >
> > > > > >
> > > > > > On 7/15/25 10:25, Alexei Starovoitov wrote:
> > > > [......]
> > > > > >
> > > > > > According to my benchmark, it has ~5% overhead to save/restore
> > > > > > *5* variants when compared with *0* variant. The save/restore o=
f regs
> > > > > > is fast, but it still need 12 insn, which can produce ~6% overh=
ead.
> > > > >
> > > > > I think it's an ok trade off, because with one global trampoline
> > > > > we do not need to call rhashtable lookup before entering bpf prog.
> > > > > bpf prog will do it on demand if/when it needs to access argument=
s.
> > > > > This will compensate for a bit of lost performance due to extra s=
ave/restore.
> > > >
> > > > I don't understand here :/
> > > >
> > > > The rhashtable lookup is done at the beginning of the global trampo=
line,
> > > > which is called before we enter bpf prog. The bpf progs is stored i=
n the
> > > > kfunc_md, and we need get them from the hash table.
> > >
> > > Ahh. Right.
> > >
> > > Looking at the existing bpf trampoline... It has complicated logic
> > > to handle livepatching and tailcalls. Your global trampoline
> > > doesn't, and once that is added it's starting to feel that it will
> > > look just as complex as the current one.
> > > So I think we better repurpose what we have.
> > > Maybe we can rewrite the existing one in C too.
> >
> > You are right, the tailcalls is not handled yet. But for the livepatchi=
ng,
> > it is already handled, as we always get the origin ip from the stack
> > and call it, just like how the bpf trampoline handle the livepatching.
> > So no addition handling is needed here.
> >
> > >
> > > How about the following approach.
> > > I think we discussed something like this in the past
> > > and Jiri tried to implement something like this.
> > > Andrii reminded me recently about it.
> > >
> > > Say, we need to attach prog A to 30k functions.
> > > 10k with 2 args, 10k with 3 args, and 10k with 7 args.
> > > We can generate 3 _existing_ bpf trampolines for 2,3,7 args
> > > with hard coded prog A in there (the cookies would need to be
> > > fetched via binary search similar to kprobe-multi).
> > > The arch_prepare_bpf_trampoline() supports BPF_TRAMP_F_ORIG_STACK.
> > > So one 2-arg trampoline will work to invoke prog A in all 10k 2-arg f=
unctions.
> > > We don't need to match types, but have to compare that btf_func_model=
=2Ds
> > > are the same.
> > >
> > > Menglong, your global trampoline for 0,1,..6 args works only for x86,
> > > because btf_func_model doesn't care about sizes of args,
> > > but it's not the correct mental model to use.
> > >
> > > The above "10k with 2 args" is a simplified example.
> > > We will need an arch specific callback is_btf_func_model_equal()
> > > that will compare func models in arch specific ways.
> > > For x86-64 the number of args is all it needs.
> > > For other archs it will compare sizes and flags too.
> > > So 30k functions will be sorted into
> > > 10k with btf_func_model_1, 10k with btf_func_model_2 and so on.
> > > And the corresponding number of equivalent trampolines will be genera=
ted.
> > >
> > > Note there will be no actual BTF types. All args will be untyped and
> > > untrusted unlike current fentry.
> > > We can go further and sort 30k functions by comparing BTFs
> > > instead of btf_func_model-s, but I suspect 30k funcs will be split
> > > into several thousands of exact BTFs. At that point multi-fentry
> > > benefits are diminishing and we might as well generate 30k unique
> > > bpf trampolines for 30k functions and avoid all the complexity.
> > > So I would sort by btf_func_model compared by arch specific comparato=
r.
> > >
> > > Now say prog B needs to be attached to another 30k functions.
> > > If all 30k+30k functions are different then it's the same as
> > > the previous step.
> > > Say, prog A is attached to 10k funcs with btf_func_model_1.
> > > If prog B wants to attach to the exact same func set then we
> > > just regenerate bpf trampoline with hard coded progs A and B
> > > and reattach.
> > > If not then we need to split the set into up to 3 sets.
> > > Say, prog B wants 5k funcs, but only 1k func are common:
> > > (prog_A, 9k func with btf_func_model_1) -> bpf trampoline X
> > > (prog_A, prog_B, 1k funcs with btf_func_model_1) -> bpf trampoline Y
> > > (prog_B, 4k funcs with btf_func_model_1) -> bpf trampoline Z
> > >
> > > And so on when prog C needs to be attached.
> > > At detach time we can merge sets/trampolines,
> > > but for now we can leave it all fragmented.
> > > Unlike regular fentry progs the multi-fentry progs are not going to
> > > be attached for long time. So we can reduce the detach complexity.
> > >
> > > The nice part of the algorithm is that coexistence of fentry
> > > and multi-fentry is easy.
> > > If fentry is already attached to some function we just
> > > attach multi-fentry prog to that bpf trampoline.
> > > If multi-fentry was attached first and fentry needs to be attached,
> > > we create a regular bpf trampoline and add both progs there.
> >
> > This seems not easy, and it is exactly how I handle the
> > coexistence now:
> >
> >   https://lore.kernel.org/bpf/20250528034712.138701-16-dongml2@chinatel=
ecom.cn/
> >   https://lore.kernel.org/bpf/20250528034712.138701-17-dongml2@chinatel=
ecom.cn/
> >   https://lore.kernel.org/bpf/20250528034712.138701-18-dongml2@chinatel=
ecom.cn/
>=20
> hmm. exactly? That's very different.
> You're relying on kfunc_md for prog list.
> The above proposal doesn't need kfunc_md in the critical path.
> All progs are built into the trampolines.
>=20
> > The most difficult part is that we need a way to replace the the
> > multi-fentry with fentry for the function in the ftrace atomically. Of
> > course, we can remove the global trampoline first, and then attach
> > the bpf trampoline, which will make things much easier. But a
> > short suspend will happen for the progs in fentry-multi.
>=20
> I don't follow.
> In the above proposal fentry attach/detach is atomic.
> Prepare a new trampoline, single call to ftrace to modify_fentry().

modify_fentry() is used to operate on the same ftrace_ops. For
example, we have the bpf trampoline A, and its corresponding
ftrace_ops is opsA. Now, the image of the trampolineA is updated,
we call modify_fentry() for opsA to update the direct call of it.

When we talk about the coexistence, it means the functionA is
attached with the global trampoline B, whose ftrace_ops is
opsB. We can't call modify_fentry(trampolineA, new_addr) here,
as the opsA is not register yet. And we can't call register_fentry
too, as the functionA is already in the direct_functions when we
register opsB.

So we need a way to do such transition.

>=20
> > >
> > > The intersect and sorting by btf_func_model is not trivial,
> > > but we can hold global trampoline_mutex, so no concerns of races.
> > >
> > > Example:
> > > bpf_link_A is a set of:
> > > (prog_A, funcs X,Y with btf_func_model_1)
> > > (prog_A, funcs N,M with btf_func_model_2)
> > >
> > > To attach prog B via bpf_link_B that wants:
> > > (prog_B, funcs Y,Z with btf_func_model_1)
> > > (prog_B, funcs P,Q with btf_func_model_3)
> > >
> > > walk all existing links, intersect and split, and update the links.
> > > At the end:
> > >
> > > bpf_link_A:
> > > (prog_A, funcs X with btf_func_model_1)
> > > (prog_A, prog_B funcs Y with btf_func_model_1)
> > > (prog_A, funcs N,M with btf_func_model_2)
> > >
> > > bpf_link_B:
> > > (prog_A, prog_B funcs Y with btf_func_model_1)
> > > (prog_B, funcs Z with btf_func_model_1)
> > > (prog_B, funcs P,Q with btf_func_model_3)
> > >
> > > When link is detached: walk its own tuples, remove the prog,
> > > if nr_progs =3D=3D 0 -> detach corresponding trampoline,
> > > if nr_progs > 0 -> remove prog and regenerate trampoline.
> > >
> > > If fentry prog C needs to be attached to N it might split bpf_link_A:
> > > (prog_A, funcs X with btf_func_model_1)
> > > (prog_A, prog_B funcs Y with btf_func_model_1)
> > > (prog_A, funcs M with btf_func_model_2)
> > > (prog_A, prog_C funcs N with _fentry_)
> > >
> > > Last time we gave up on it because we discovered that
> > > overlap support was too complicated, but I cannot recall now
> > > what it was :)
> > > Maybe all of the above repeating some old mistakes.
> >
> > In my impression, this is exactly the solution of Jiri's, and this is
> > part of the discussion that I know:
> >
> >   https://lore.kernel.org/bpf/ZfKY6E8xhSgzYL1I@krava/
>=20
> Yes. It's similar, but somehow it feels simple enough now.
> The algorithms for both detach and attach fit on one page,
> and everything is uniform. There are no spaghetty of corner cases.
>=20





