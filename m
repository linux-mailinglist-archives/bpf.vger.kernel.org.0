Return-Path: <bpf+bounces-74119-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE08DC4AD60
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 02:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 398FE3B1886
	for <lists+bpf@lfdr.de>; Tue, 11 Nov 2025 01:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734C62857F0;
	Tue, 11 Nov 2025 01:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X4TlHS5+"
X-Original-To: bpf@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8821096F
	for <bpf@vger.kernel.org>; Tue, 11 Nov 2025 01:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762824539; cv=none; b=Eq/k/MA9rCeZQ6QSGSkPfg7x8x+BJ5K+s942k0SsdhJmDtaJYhZs8kFMimMNFQeJ/TdDSoBxlcl7tqBKZ/snS+ptvrpBA83DDOsTS3KpS8+IireOClVAKvDjcGRIEyyg4rQ78sCYKNp9q/dzBRbm3j/vNuvmGpoRm2ERseNSgQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762824539; c=relaxed/simple;
	bh=JniPNzR2zrzCfTZJfDvwxJryTw6qwXKnH7duhMCvPKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkGYV5WIPEkD5hi3lvTIoTArBxYx71MViafBErp880shXbdh+cNl+ApFUiDzRugZ56IhwP3YhlT4XEZPcPEmqyjHps+wzOKtBCpv3aj6lkmBp3FOLrvietUgDtD45IcXL29YFzHfoo6HdlYXrobqjvmHTRa2hUgSLBVFKj9KJX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X4TlHS5+; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762824534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkCMn6326n5t3YdXIXOy3mMQo+0cpCyiOzgcX5JM5n4=;
	b=X4TlHS5+5+xX48of/7wvV+4pRZbxJ6vbhmMX8oHZjqDozXm4cUR5/ieDih6LJeK7X4K+/r
	fKx0kjVXNlgxsIxhATRBHjECnDn/V3065eVGpNu0DDq4ilwNkir6lyWYNoaZ2nnLdHBwJO
	Ob2bzVZl7fQIwwNUj9uuHfFLyods9Ms=
From: Menglong Dong <menglong.dong@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: sjenning@redhat.com, Peter Zijlstra <peterz@infradead.org>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, X86 ML <x86@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, jiang.biao@linux.dev,
 bpf <bpf@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf,x86: do RSB balance for trampoline
Date: Tue, 11 Nov 2025 09:28:11 +0800
Message-ID: <5025905.GXAFRqVoOG@7950hx>
In-Reply-To:
 <CAADnVQKQ2Pqhb9wNjRuEP5AoGc6-MfLhQLD++gQPf3VB_rV+fQ@mail.gmail.com>
References:
 <20251104104913.689439-1-dongml2@chinatelecom.cn>
 <13884259.uLZWGnKmhe@7950hx>
 <CAADnVQKQ2Pqhb9wNjRuEP5AoGc6-MfLhQLD++gQPf3VB_rV+fQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/11/11 00:32, Alexei Starovoitov wrote:
> On Mon, Nov 10, 2025 at 3:43=E2=80=AFAM Menglong Dong <menglong.dong@linu=
x.dev> wrote:
> >
> >
> > Do you think if it is worth to implement the livepatch with
> > bpf trampoline by introduce the CONFIG_LIVEPATCH_BPF?
> > It's easy to achieve it, I have a POC for it, and the performance
> > of the livepatch increase from 99M/s to 200M/s according to
> > my bench testing.
>=20
> what do you mean exactly?

This is totally another thing, and we can talk about it later. Let
me have a simple describe here.

I mean to implement the livepatch by bpf trampoline. For now,
the livepatch is implemented with ftrace, which will break the
RSB and has more overhead in x86_64.

It can be easily implemented by replace the "origin_call" with the
address that livepatch offered.

> I don't want to add more complexity to bpf trampoline.

If you mean the arch-specification, it won't add the complexity.
Otherwise, it can make it a little more simple in x86_64 with following
patch:

=2D-- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3176,7 +3176,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im, void *rw_im
 					 void *rw_image_end, void *image,
 					 const struct btf_func_model *m, u32 flags,
 					 struct bpf_tramp_links *tlinks,
=2D					 void *func_addr)
+					 void *func_addr, void *origin_call_param)
 {
 	int i, ret, nr_regs =3D m->nr_args, stack_size =3D 0;
 	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
@@ -3280,6 +3280,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_t=
ramp_image *im, void *rw_im
 			orig_call +=3D ENDBR_INSN_SIZE;
 		orig_call +=3D X86_PATCH_SIZE;
 	}
+	orig_call =3D origin_call_param ?: orig_call;
=20
 	prog =3D rw_image;
=20
@@ -3369,15 +3370,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf=
_tramp_image *im, void *rw_im
 			LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack_size);
 		}
=20
=2D		if (flags & BPF_TRAMP_F_ORIG_STACK) {
=2D			emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, 8);
=2D			EMIT2(0xff, 0xd3); /* call *rbx */
=2D		} else {
=2D			/* call original function */
=2D			if (emit_rsb_call(&prog, orig_call, image + (prog - (u8 *)rw_image)))=
 {
=2D				ret =3D -EINVAL;
=2D				goto cleanup;
=2D			}
+		/* call original function */
+		if (emit_rsb_call(&prog, orig_call, image + (prog - (u8 *)rw_image))) {
+			ret =3D -EINVAL;
+			goto cleanup;
 		}
 		/* remember return value in a stack for bpf prog to access */
 		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);

> Improve current livepatching logic ? jmp vs call isn't special.

Some kind. According to my testing, the performance of bpf
trampoline is much better than ftrace trampoline, so if we
can implement it with bpf trampoline, the performance can be
improved. Of course, the bpf trampoline need to offer a API
to the livepatch for this propose.

Any way, let me finish the work in this patch first. After that,
I can send a RFC of the proposal.

Thanks!
Menglong Dong

>=20
> > The results above is tested with return-trunk disabled. With the
> > return-trunk enabled, the performance decrease from 58M/s to
> > 52M/s. The main performance improvement comes from the RSB,
> > and the return-trunk will always break the RSB, which makes it has
> > no improvement. The calling to per-cpu-ref get and put make
> > the bpf trampoline based livepatch has a worse performance
> > than ftrace based.
> >
> > Thanks!
> > Menglong Dong
> >
> > >
> >
> >
> >
> >
>=20
>=20





