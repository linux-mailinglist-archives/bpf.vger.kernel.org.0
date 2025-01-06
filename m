Return-Path: <bpf+bounces-48004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F31D5A03166
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 21:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DFB13A4E23
	for <lists+bpf@lfdr.de>; Mon,  6 Jan 2025 20:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176D81DE898;
	Mon,  6 Jan 2025 20:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoZc4vh6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE911DFE14
	for <bpf@vger.kernel.org>; Mon,  6 Jan 2025 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736195494; cv=none; b=iX3s6oHhfMn+wxMge91gfKNdMoc8+RAtBJrQSRf/kp0mVJrAeiSFU1BEQKn7HPirZU9GLBTyUV5H6j8CYHYpuVjBSNbjMT8fpp03T8pU0qx3W7BGOfAxAjJEqUE+wDgl7+m53YO/j1oBTSsFdnQkski5uNklht9URPBHz3eaDRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736195494; c=relaxed/simple;
	bh=4WCd777aGmEpIEGEVAPpZ/NB1hY8tUOSmX6vUfM8LMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DpqUvC0jDkCA+wQ1CeGlD8MWkscfG0oWkNENgy0NvUg+dRvvczxIiu4OwvpazzhmPchLmdparl0RUkTnTp6Oq4dK+hM6TMbEVTRMWalxs9xTV0fO6YcqimKCM+I1yT3Nr+4Z6KjbO9U+8lmf4RiROgnNYXyd+BRq2qCk3ihWmzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JoZc4vh6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21634338cfdso17543365ad.2
        for <bpf@vger.kernel.org>; Mon, 06 Jan 2025 12:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736195492; x=1736800292; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0aDnG39zdy3jJPIimCIqgDii1rsGnTpzBAow7WcgWy4=;
        b=JoZc4vh6P768IO8NeVRtfWH40FEQYmEhvFx3zpGKYmxmfpkTczDBHtkIlc5fsbM6Db
         nwc7fw/oiiovoX1cUO6PhDxlXN5ure0m5FLwYbR/Caj/rQDZYmXmPSzwKNInhqr0EcZm
         /A0v5dFpTz1BBnsESm3bSnSLS3EITYfb5fi1dNqZHSmXp1A6jfo/PhX3TG1F3gjQc5NN
         cJ1ZKzYRItjfKcLQCmnBJ3bWEivGDhAObpCz6lCyw+w+7oOcB7VeGkYtAwtApSfHhaym
         JyAj+mgLxNlbd7T0xpJ/A78wGzCIOs2WUMeOmIZgZIG+wDicr/e666zOpYi4mMRUAtzC
         xevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736195492; x=1736800292;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0aDnG39zdy3jJPIimCIqgDii1rsGnTpzBAow7WcgWy4=;
        b=ixUgKfEVUqsbb2Ff0UnEmV2mE/bIuXBlERGpfYyrBlPtJLtNP0Be75M07zjCRsSJBO
         GM297y4SD0pwa7R574cb1P28wsMWmSWINAuelC6AZj/9onsdXmhRgI9/eTeM1TxlFRjG
         F14u4EUwIA/cXgZ4eOyQ9WQ+u/gW0furMXvetDRBkd5OzoFBBrcYBO3vY8URoxcTJ29D
         jjj5k+lRmHGZ2B2siwwc/SRkpGQS6UASIU2LvrO+BzY1TRqKIOEegmEY3BM8Fb5cC2Np
         0tpSXD8iOTsehYMC1miXgXxWQwPrCj/V7lqXp/Dn/E2CrBaZZnCWUkH+vuYWS4yqH3hz
         FFog==
X-Forwarded-Encrypted: i=1; AJvYcCVBYvGvHG5G35Zucie02JvrNP9kaN2ZmYtXLgA2H2zQlj9g9i6SqPHXre78ZkzaN9XsNww=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD3nYcBBmhz/oXCUkJcreUNeNcHFdFe2PO0QN2pVCoZpKVPgdH
	ipOF7NRUQ4JOKFccLueVuo/0p15hsvgIYJYwSJyi+A8dCyLs0SXx
X-Gm-Gg: ASbGnctQEsx1QNMz+BhD/Qqm+OTEpQteyfeC5B16kxhccM31cPV8SbeKdZ3y0Xass2z
	Y3pBU54lZ+5lwP5LXNU7GVklS/8UEe07xFSKdRtNZLt8Oyje+uM7H7hh30nrgj4jat9ujq/ku60
	vc3PRUVlY0U0WhIpgcXdlBcGhmgwFGl6ROuXcDI8eBo+WcOaHSXxi2KW3uQUS44EhBrfKuxafsV
	1kL5ik+G40/cJEQnG64ZRVtu33X69hfE7Ns3JBMAe09AHSVKp8VKQ==
X-Google-Smtp-Source: AGHT+IGPPONiAAlwqGsZKIijjA2Fq39RUJ8mFt+Nwc+xyQ22AATWRhNolmyKoQH9A1XH49E95qRevQ==
X-Received: by 2002:a05:6a00:6f0b:b0:725:ab14:6249 with SMTP id d2e1a72fcca58-72abdd20f0emr88639603b3a.2.1736195491774;
        Mon, 06 Jan 2025 12:31:31 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad836bd9sm31952912b3a.78.2025.01.06.12.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 12:31:31 -0800 (PST)
Message-ID: <3f08fa54c29d5716982194801bfdae93c15a8c27.camel@gmail.com>
Subject: Re: [PATCH bpf v3 1/2] bpf: Account for early exit of
 bpf_tail_call() and LD_ABS
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arthur Fabre <afabre@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team@cloudflare.com
Date: Mon, 06 Jan 2025 12:31:27 -0800
In-Reply-To: <20250106171709.2832649-2-afabre@cloudflare.com>
References: <20250106171709.2832649-1-afabre@cloudflare.com>
	 <20250106171709.2832649-2-afabre@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-06 at 18:15 +0100, Arthur Fabre wrote:
> bpf_tail_call(), LD_ABS, and LD_IND can cause the current function to
> return abnormally:
> - On success, bpf_tail_call() will jump to the tail_called program, and
>   that program will return directly to the outer caller.
> - On failure, LD_ABS or LD_IND return directly to the outer caller.
>=20
> But the verifier doesn't account for these abnormal exits, so it assumes
> the instructions following a bpf_tail_call() or LD_ABS are always
> executed, and updates bounds info accordingly.
>=20
> Before BPF to BPF calls that was ok: the whole BPF program would
> terminate anyways, so it didn't matter that the verifier state didn't
> match reality.
>=20
> But if these instructions are used in a function call, the verifier will
> propagate some of this incorrect bounds info to the caller. There are at
> least two kinds of this:
> - The callee's return value in the caller.
> - References to the caller's stack passed into the caller.
>=20
> For example, loading:
>=20
>     #include <linux/bpf.h>
>     #include <bpf/bpf_helpers.h>
>=20
>     struct {
>             __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
>             __uint(max_entries, 1);
>             __uint(key_size, sizeof(__u32));
>             __uint(value_size, sizeof(__u32));
>     } tail_call_map SEC(".maps");
>=20
>     static __attribute__((noinline)) int callee(struct xdp_md *ctx)
>     {
>             bpf_tail_call(ctx, &tail_call_map, 0);
>=20
>             int ret;
>             asm volatile("%0 =3D 23" : "=3Dr"(ret));
>             return ret;
>     }
>=20
>     static SEC("xdp") int caller(struct xdp_md *ctx)
>     {
>             int res =3D callee(ctx);
>             if (res =3D=3D 23) {
>                     return XDP_PASS;
>             }
>             return XDP_DROP;
>     }
>=20
> The verifier logs:
>=20
>     func#0 @0
>     func#1 @6
>     0: R1=3Dctx() R10=3Dfp0
>     ; int res =3D callee(ctx); @ test.c:24
>     0: (85) call pc+5
>     caller:
>      R10=3Dfp0
>     callee:
>      frame1: R1=3Dctx() R10=3Dfp0
>     6: frame1: R1=3Dctx() R10=3Dfp0
>     ; bpf_tail_call(ctx, &tail_call_map, 0); @ test.c:15
>     6: (18) r2 =3D 0xffff8a9c82a75800       ; frame1: R2_w=3Dmap_ptr(map=
=3Dtail_call_map,ks=3D4,vs=3D4)
>     8: (b4) w3 =3D 0                        ; frame1: R3_w=3D0
>     9: (85) call bpf_tail_call#12
>     10: frame1:
>     ; asm volatile("%0 =3D 23" : "=3Dr"(ret)); @ test.c:18
>     10: (b7) r0 =3D 23                      ; frame1: R0_w=3D23
>     ; return ret; @ test.c:19
>     11: (95) exit
>     returning from callee:
>      frame1: R0_w=3D23 R10=3Dfp0
>     to caller at 1:
>      R0_w=3D23 R10=3Dfp0
>=20
>     from 11 to 1: R0_w=3D23 R10=3Dfp0
>     ; int res =3D callee(ctx); @ test.c:24
>     1: (bc) w1 =3D w0                       ; R0_w=3D23 R1_w=3D23
>     2: (b4) w0 =3D 2                        ; R0=3D2
>     ;  @ test.c:0
>     3: (16) if w1 =3D=3D 0x17 goto pc+1
>     3: R1=3D23
>     ; } @ test.c:29
>     5: (95) exit
>     processed 10 insns (limit 1000000) max_states_per_insn 0 total_states=
 1 peak_states 1 mark_read 1
>=20
> And tracks R0_w=3D23 from the callee through to the caller.
> This lets it completely prune the res !=3D 23 branch, skipping over
> instruction 4.
>=20
> But this isn't sound: the bpf_tail_call() could make the callee return
> before r0 =3D 23.
>=20
> Aside from pruning incorrect branches, this can also be used to read and
> write arbitrary memory by using r0 as a index.
>=20
> Make the verifier track instructions that can return abnormally as a
> branch that either exits, or falls through to the remaining
> instructions.
>=20
> This naturally checks for resource leaks, so we can remove the explicit
> checks for tail_calls and LD_ABS.
>=20
> Fixes: f4d7e40a5b71 ("bpf: introduce function calls (verification)")
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> Cc: stable@vger.kernel.org
> ---

This patch is correct as far as I can tell.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -18770,6 +18780,21 @@ static int do_check(struct bpf_verifier_env *env=
)
>  					return err;
> =20
>  				mark_reg_scratched(env, BPF_REG_0);
> +
> +				if (insn->src_reg =3D=3D 0 && insn->imm =3D=3D BPF_FUNC_tail_call) {
> +					/* Explore both cases: tail_call fails and we fallthrough,
> +					 * or it succeeds and we exit the current function.
> +					 */
> +					if (!push_stack(env, env->insn_idx + 1, env->insn_idx, false))
> +						return -ENOMEM;
> +					/* bpf_tail_call() doesn't set r0 on failure / in the fallthrough c=
ase.
> +					 * But it does on success, so we have to mark it after queueing the
> +					 * fallthrough case, but before prepare_func_exit().
> +					 */
> +					__mark_reg_unknown(env, &state->frame[state->curframe]->regs[BPF_RE=
G_0]);
> +					exit =3D BPF_EXIT_TAIL_CALL;
> +					goto process_bpf_exit_full;
> +				}

Nit: it's a bit unfortunate, that this logic is inside do_check,
     instead of check_helper_call() and check_ld_abs().
     But it makes BPF_EXIT_* propagation simpler.

>  			} else if (opcode =3D=3D BPF_JA) {
>  				if (BPF_SRC(insn->code) !=3D BPF_K ||
>  				    insn->src_reg !=3D BPF_REG_0 ||

[...]


