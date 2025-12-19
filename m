Return-Path: <bpf+bounces-77094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 58B28CCE2AF
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 02:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B94F302A761
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 01:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A45C23C4F4;
	Fri, 19 Dec 2025 01:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vqLwAh1s"
X-Original-To: bpf@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9F23536B
	for <bpf@vger.kernel.org>; Fri, 19 Dec 2025 01:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766108539; cv=none; b=KSOPeSayyGkXYuNGJ9lcJNTgZT9xrmkW6RQU2So9xRls/RA+U/RnljYZPQZXrQx0cWLJ92OfsKAaH3wQmBVg+dILcsZGqsltfPSvtqsPdPbVBAgiW42/zukoLFzaxpt8OfJiN9+wFhXcJviu0kcDMwQ84oc8TJgec8YO+SNgDsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766108539; c=relaxed/simple;
	bh=LiwKkLnWNYCMnc6GlZIfQZrcjmH/6VT2FJhPLOpoyug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VrWLLOXZ/3FkQtjG16Yt4hYY51X69To5IuzgL2UbIiKcHGyOPeOD3x2YykQyXmHsC6xqNJ+F9RLoUfr8A2Xf1Mv5nHRMtUlKRN+q/MYTPCSpEVND1znw98pVM1K7fqZ2sNAVDcxlyBe/yWdFLylLzu6QmiU4qz+nbMubtyIJ2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vqLwAh1s; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766108524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjSg1OrEXDQUrBeStG87QDXijr2CA2Ftqkeu5gy91l4=;
	b=vqLwAh1szzcflbnkRemThLxvnaAvY1F0FpmVx04/iqxEkpwJGM7/N89SQEPCaP0pNy2I+F
	yQ1XCVuag/o64Iw8/3q/hn0x60AAIyBQJhAe/iDD3mpHytyu5Gwy/2ILg9zoH204ath/Pd
	WgKgHmeAFmxmamnPHN8/jUNP6DCas5A=
From: Menglong Dong <menglong.dong@linux.dev>
To: Menglong Dong <menglong8.dong@gmail.com>,
 Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, andrii@kernel.org, davem@davemloft.net,
 dsahern@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH bpf-next v4 6/9] bpf,x86: add tracing session supporting for
 x86_64
Date: Fri, 19 Dec 2025 09:41:06 +0800
Message-ID: <9551014.CDJkKcVGEf@7940hx>
In-Reply-To:
 <CAEf4BzZOfB310d4_1eznUgkGwK5cwhZSEgc9SANJskCbctDoMQ@mail.gmail.com>
References:
 <20251217095445.218428-1-dongml2@chinatelecom.cn>
 <20251217095445.218428-7-dongml2@chinatelecom.cn>
 <CAEf4BzZOfB310d4_1eznUgkGwK5cwhZSEgc9SANJskCbctDoMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/12/19 08:55 Andrii Nakryiko <andrii.nakryiko@gmail.com> write:
> On Wed, Dec 17, 2025 at 1:55=E2=80=AFAM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Add BPF_TRACE_SESSION supporting to x86_64, including:
> >
> > 1. clear the return value in the stack before fentry to make the fentry
> >    of the fsession can only get 0 with bpf_get_func_ret(). If we can li=
mit
> >    that bpf_get_func_ret() can only be used in the
> >    "bpf_fsession_is_return() =3D=3D true" code path, we don't need do t=
his
> >    thing anymore.
>=20
> What does bpf_get_func_ret() return today for fentry? zero or just
> random garbage? If the latter, we can keep the same semantics for
> fsession on entry. Ultimately, result of bpf_get_func_ret() is
> meaningless outside of fexit/session-exit

=46or fentry, bpf_get_func_ret() is not allowed to be called. For fsession,
I think the best way is that we allow to call bpf_get_func_ret() in the
"bpf_fsession_is_return() =3D=3D true"  branch, and prohibit it in
"bpf_fsession_is_return() =3D=3D false" branch. However, we need to track
such condition in verifier, which will make things complicated. So
I think we can allow the usage of bpf_get_func_ret() in fsession and
make sure it will always get zero in the fsession-fentry for now.

Thanks!
Menglong Dong

>=20
> >
> > 2. clear all the session cookies' value in the stack. If we can make su=
re
> >    that the reading to session cookie can only be done after initialize=
 in
> >    the verifier, we don't need this anymore.
> >
> > 2. store the index of the cookie to ctx[-1] before the calling to fsess=
ion
> >
> > 3. store the "is_return" flag to ctx[-1] before the calling to fexit of
> >    the fsession.
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
> > Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> > ---
> > v4:
> > - some adjustment to the 1st patch, such as we get the fsession prog fr=
om
> >   fentry and fexit hlist
> > - remove the supporting of skipping fexit with fentry return non-zero
> >
> > v2:
> > - add session cookie support
> > - add the session stuff after return value, instead of before nr_args
> > ---
> >  arch/x86/net/bpf_jit_comp.c | 36 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 31 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> > index 8cbeefb26192..99b0223374bd 100644
> > --- a/arch/x86/net/bpf_jit_comp.c
> > +++ b/arch/x86/net/bpf_jit_comp.c
> > @@ -3086,12 +3086,17 @@ static int emit_cond_near_jump(u8 **pprog, void=
 *func, void *ip, u8 jmp_cond)
> >  static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
> >                       struct bpf_tramp_links *tl, int stack_size,
> >                       int run_ctx_off, bool save_ret,
> > -                     void *image, void *rw_image)
> > +                     void *image, void *rw_image, u64 nr_regs)
> >  {
> >         int i;
> >         u8 *prog =3D *pprog;
> >
> >         for (i =3D 0; i < tl->nr_links; i++) {
> > +               if (tl->links[i]->link.prog->call_session_cookie) {
> > +                       /* 'stack_size + 8' is the offset of nr_regs in=
 stack */
> > +                       emit_st_r0_imm64(&prog, nr_regs, stack_size + 8=
);
> > +                       nr_regs -=3D (1 << BPF_TRAMP_M_COOKIE);
>=20
> you have to rename nr_regs to something more meaningful because it's
> so weird to see some bit manipulations with *number of arguments*
>=20
> > +               }
> >                 if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
> >                                     run_ctx_off, save_ret, image, rw_im=
age))
> >                         return -EINVAL;
> > @@ -3208,8 +3213,9 @@ static int __arch_prepare_bpf_trampoline(struct b=
pf_tramp_image *im, void *rw_im
> >                                          struct bpf_tramp_links *tlinks,
> >                                          void *func_addr)
> >  {
> > -       int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
> > -       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rb=
x_off;
> > +       int i, ret, nr_regs =3D m->nr_args, cookie_cnt, stack_size =3D =
0;
> > +       int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rb=
x_off,
> > +           cookie_off;
>=20
> if it doesn't fit on a single line, just `int cookie_off;` on a
> separate line, why wrap the line?
>=20
> >         struct bpf_tramp_links *fentry =3D &tlinks[BPF_TRAMP_FENTRY];
> >         struct bpf_tramp_links *fexit =3D &tlinks[BPF_TRAMP_FEXIT];
> >         struct bpf_tramp_links *fmod_ret =3D &tlinks[BPF_TRAMP_MODIFY_R=
ETURN];
>=20
> [...]
>=20





