Return-Path: <bpf+bounces-46961-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A9F9F1A50
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B984F188C55B
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 208231B4F1A;
	Fri, 13 Dec 2024 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWczYCLL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4DD1A4F2F
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734133940; cv=none; b=QDpKe310oBxdSRmJfAFGu7vHqEebAnFRuchqncK5CoO4AOlfO1eYnIGSs+AQ5FhIgoP6705fsF26zdFc33UFoJfV4aqfSGPFJezSwWiNAeO6lub6eugIdaUexHgSaeK5zOraqAxwkMCyvSUXdnoNb07bH+z42zgBp2TlAhtro1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734133940; c=relaxed/simple;
	bh=q0usWc2dsRHDtNuoDdaGO4tXNX842hH5rUTvxgFl7F4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j/Z87BoQ4YGSEREAzDB+pzuEKQWL4+gzGVFC+PU7WS7atbFcly6esijIeHoO9PeSw1SSBP/rdawouPWXMllAW3giSpc7YzkCt8UioSIM4wZDo/6zPgBzRVunQRDcD8HFVPVVLL6oYFuwh5TaKhSdubUqsAb8nSl98epHFkLlqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWczYCLL; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7265c18d79bso2644921b3a.3
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734133936; x=1734738736; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uUBcCfmI4qqE3jhSY+AvXmpRPPBL4NsehdqWrfiGJwo=;
        b=AWczYCLLgkQOQNj0nk0S5O7+u6Koqb8XLpKAEHxbzKDFUQRXb5XWuDKkhRetb9btCT
         meldlw/+owdiSwq17/0KVY8WT3T2aUaFqTu+w2fGaxwB+Cs4sOLcHbgNkAtplqy9Z5FN
         TdPAGvoMv6RlwoyLrinPJ7wPWqZbFZaVbVcam9s1F7cUfWfp9+hPCZJVVtDRfeXF/LVv
         ZVF0jjajmNT9NwCtyT5f17d5/NWKdrql3UDnKXCqyqUGe4UNVsYxencalyu/kP6m0h1d
         rNzUny3A4G4MzY3n+yvKh/nuNyqT1iyM38M1Zs6+/ztY4RcX1RjdBuvBbAfIZINFCOII
         qwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734133936; x=1734738736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUBcCfmI4qqE3jhSY+AvXmpRPPBL4NsehdqWrfiGJwo=;
        b=lx0an7F5Z/9SReBnF3Ta02GgcQWHHv+mJJF6AxPudqQqgpSf4QR25b/aZ88cir3M+5
         WDR8tAu4endOJenEVfVA6AS3qUU14iKM+otKJ81Uqm5nOmiMOFO5JAPb5DuOvbg1XwV8
         bzV5ZeYE9W2p+C2hqyHHzTwjywhj3xV8LA2BuuKyEgajv0KbjtXz5EFM11s6WRS1zPnG
         nDlfn+I4thTN1+JAcyKHiKLAtQxjxT9HHcQgRcGHqKYHTCwy7i4HNlttiDvFCfpepYvN
         MVUTIyVUb+c61T+pODTV6UF4q+zTf9cEcASZ5z1neV5D7sRwYLU1jmfT/shuZ+U31WrB
         BeUg==
X-Forwarded-Encrypted: i=1; AJvYcCVxldz/TrKGKejWqBVTL/q/zE1GK7Fx9txRXHWwjEADcGl5/yEE2ssO01hKssbv0JAWTDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCcVeTYDp676RRVssoEI3jAjvTxMc59iN8HOxpLzlGan0hYUqE
	9vOJXrTTWicR6Jbh0r3c7e8w1jnUF9UJsm8OaDQDSKGv/NcO5hYI
X-Gm-Gg: ASbGnctJv3n6ikFuC5DolJCr848popRT29aPuIRs9YLNi7xhir0EU2MVXUypByuaZ+r
	rcYCy89ypEiLabys592T5vSL5myLOphXpF7fhY9F40H2yycW1hgFYTAhbgmC6atxBQtdJ/K5ZuQ
	5wsVzrn8q7hOdbd6dCaEq/Yv0xYPqXGZlHvdvxxfD+FvaBZsFSZzr1DxBoHChydpi83HssOmiz+
	3u6ZmOqTYqVaGsCN9o3iL1BiKwKmV+tamLcIxqINWgrXGd7QVziRg==
X-Google-Smtp-Source: AGHT+IE0hlE21JMsYTjIoJUIOwsa1XVqJRhmtqYIhfG/gOM1Rg0NlpHwpj1rtWQFIuLgkD0xXISSdw==
X-Received: by 2002:a05:6a21:394a:b0:1e1:a671:7116 with SMTP id adf61e73a8af0-1e1dfc18058mr7732123637.4.1734133936280;
        Fri, 13 Dec 2024 15:52:16 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918baf6c0sm337861b3a.166.2024.12.13.15.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:52:15 -0800 (PST)
Message-ID: <877efce1968381b1918ce5d6fe272c0d83254f14.camel@gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Don't trust r0 bounds after BPF to BPF
 calls with abnormal returns
From: Eduard Zingerman <eddyz87@gmail.com>
To: Arthur Fabre <afabre@cloudflare.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  John Fastabend <john.fastabend@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Martin KaFai Lau	 <martin.lau@linux.dev>,
 Song Liu <song@kernel.org>, Yonghong Song	 <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev	 <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	kernel-team@cloudflare.com
Date: Fri, 13 Dec 2024 15:52:10 -0800
In-Reply-To: <20241213212717.1830565-2-afabre@cloudflare.com>
References: <20241213212717.1830565-1-afabre@cloudflare.com>
	 <20241213212717.1830565-2-afabre@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-12-13 at 22:27 +0100, Arthur Fabre wrote:
> When making BPF to BPF calls, the verifier propagates register bounds
> info for r0 from the callee to the caller.
>=20
> For example loading:
>=20
>     #include <linux/bpf.h>
>     #include <bpf/bpf_helpers.h>
>=20
>     static __attribute__((noinline)) int callee(struct xdp_md *ctx)
>     {
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
>     ; int res =3D callee(ctx); @ test.c:15
>     0: (85) call pc+5
>     caller:
>      R10=3Dfp0
>     callee:
>      frame1: R1=3Dctx() R10=3Dfp0
>     6: frame1: R1=3Dctx() R10=3Dfp0
>     ; asm volatile("%0 =3D 23" : "=3Dr"(ret)); @ test.c:9
>     6: (b7) r0 =3D 23                       ; frame1: R0_w=3D23
>     ; return ret; @ test.c:10
>     7: (95) exit
>     returning from callee:
>      frame1: R0_w=3D23 R1=3Dctx() R10=3Dfp0
>     to caller at 1:
>      R0_w=3D23 R10=3Dfp0
>=20
>     from 7 to 1: R0_w=3D23 R10=3Dfp0
>     ; int res =3D callee(ctx); @ test.c:15
>     1: (bc) w1 =3D w0                       ; R0_w=3D23 R1_w=3D23
>     2: (b4) w0 =3D 2                        ; R0_w=3D2
>     ;  @ test.c:0
>     3: (16) if w1 =3D=3D 0x17 goto pc+1
>     3: R1_w=3D23
>     ; } @ test.c:20
>     5: (95) exit
>     processed 7 insns (limit 1000000) max_states_per_insn 0 total_states =
0 peak_states 0 mark_read 0
>=20
> And correctly tracks R0_w=3D23 from the callee through to the caller.
> This lets it completely prune the res !=3D 23 branch, skipping over
> instruction 4.
>=20
> But this isn't sound if the callee can return "abnormally" before an
> exit instruction:
> - If LD_ABS or LD_IND try to access data beyond the end of the packet,
>   the callee returns 0 directly.
> - If a tail_call succeeds, the return value of the tail called program
>   will be returned directly.
> We can't know what the bounds of r0 will be.
>=20
> The verifier still incorrectly tracks the bounds of r0 in these cases. Lo=
ading:
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
> It still prunes the res !=3D 23 branch, skipping over instruction 4.
> But the tail called program can return any value.
>=20
> Aside from pruning incorrect branches, this can also be used to read and
> write arbitrary memory by using r0 as a index.
>=20
> Fixes: e411901c0b77 ("bpf: allow for tailcalls in BPF subprograms for x64=
 JIT")
> Signed-off-by: Arthur Fabre <afabre@cloudflare.com>
> Cc: stable@vger.kernel.org
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -10359,6 +10364,10 @@ static int prepare_func_exit(struct bpf_verifier=
_env *env, int *insn_idx)
>  				*insn_idx, callee->callsite);
>  			return -EFAULT;
>  		}
> +	} else if (has_abnormal_return(
> +		    &env->subprog_info[state->frame[state->curframe]->subprogno])) {
                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                                       Nit: this is 'callee'

> +		/* callee can return before exit instruction, r0 could hold anything *=
/
> +		__mark_reg_unknown(env, &caller->regs[BPF_REG_0]);
>  	} else {
>  		/* return to the caller whatever r0 had in the callee */
>  		caller->regs[BPF_REG_0] =3D *r0;
> @@ -16881,17 +16890,14 @@ static int check_cfg(struct bpf_verifier_env *e=
nv)
>  	return ret;
>  }
> =20
> +

Nit: this empty line is not needed.

[...]


