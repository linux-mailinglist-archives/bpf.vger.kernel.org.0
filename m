Return-Path: <bpf+bounces-17735-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6908122E8
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 00:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2CD282917
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 23:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E795977B49;
	Wed, 13 Dec 2023 23:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTYsXEK4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6292DDB;
	Wed, 13 Dec 2023 15:35:39 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3363880e9f3so1070719f8f.3;
        Wed, 13 Dec 2023 15:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702510538; x=1703115338; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CqRqQM7Nkne0d5jbHZsc0s42Asrr0JAvYd7fmpQIcNo=;
        b=CTYsXEK4rh4EzMU1I2DBq/aOWFlCITw5uRCB7TD7wlotWtkNw2u3WY/TUVdWpLb/pF
         /0glXQiKZY2rUIxJovZatPaN+SNYHwZOoISAD2HSfJxP7pHXAl9V2ctCrcxnYjkCy2Q4
         RAL/blvuN9Cb29fPvJE7yB74qoPMVjOD4lMNkCL4UDN7XAqxqJzXOBXBktrn6IHXyoiz
         pZL/jS63/Qumpl3l9IaRK+IdPBSvpt8ZiGnbYD+0se3gszpE3Uik/i64tvWaM1iqexe3
         GGP3dGQOsU70PD1U5YXO6LXupf59b3DsildTOu1+TeJafXduTJJR7ZKBZfu30uMhK5g0
         2k2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702510538; x=1703115338;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CqRqQM7Nkne0d5jbHZsc0s42Asrr0JAvYd7fmpQIcNo=;
        b=FRZgzyj8cnHeRoi5wYaiD3+8/Rg0AeG6p1Z7jbZTyAS3exy0uKtCzAypTFcMFhfyFj
         bwuLbE8Aldth2NtBII15TcSHqnhYQy6Dlr3fTL+0ZpE2BYDPbBdpEqVOVprHDMFLLRnx
         PQIOT+wezVCaqg0fI/FLL4TDDbjTFmPdj3OxqeOvf/r52h774lPfJ0l98XnStVnSOWYT
         UFyFLr3w5F+PbXnvwCFdonSb+2DeCs67kuyDToBIZO5BtBwJ1u7LSxHD/TRf1hKzWtbd
         lDjyRD1UEeCZ/ce+KCEm1ECNVd3NHcua09sRAFgydEGqcrclye8oo6U+unSCCEI6TdnU
         x9bw==
X-Gm-Message-State: AOJu0YzoXIL1akOHzXALXrXFR3cs2voDj6mVYcxpzMXaq2De88/L/mf3
	NSl0Xejd8TefTkzSq5OYyfY=
X-Google-Smtp-Source: AGHT+IFZYaNhbJPymS21X7YTc4snTWWDFyeaFYSvosZL5Wod+eRWIP3gvj9SLYBu4xipsvwix/55GA==
X-Received: by 2002:a5d:4b52:0:b0:333:2fd2:68b5 with SMTP id w18-20020a5d4b52000000b003332fd268b5mr4684464wrs.72.1702510537631;
        Wed, 13 Dec 2023 15:35:37 -0800 (PST)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d60cf000000b0033635ee4543sm4017900wrt.67.2023.12.13.15.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 15:35:37 -0800 (PST)
Message-ID: <480a5cfefc23446f7c82c5b87eef6306364132b9.camel@gmail.com>
Subject: Re: [Bug Report] bpf: incorrectly pruning runtime execution path
From: Eduard Zingerman <eddyz87@gmail.com>
To: Hao Sun <sunhao.th@gmail.com>, Andrii Nakryiko
 <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, bpf
 <bpf@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>
Date: Thu, 14 Dec 2023 01:35:26 +0200
In-Reply-To: <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
References: 
	<CACkBjsbj4y4EhqpV-ZVt645UtERJRTxfEab21jXD1ahPyzH4_g@mail.gmail.com>
	 <CAEf4BzZ0xidVCqB47XnkXcNhkPWF6_nTV7yt+_Lf0kcFEut2Mg@mail.gmail.com>
	 <CACkBjsaEQxCaZ0ERRnBXduBqdw3MXB5r7naJx_anqxi0Wa-M_Q@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-12-13 at 11:25 +0100, Hao Sun wrote:
[...]
=20
> I tried to convert the repro to a valid test case in inline asm, but seem=
s
> JSET (if r0 & 0xfffffffe goto pc+3) is currently not supported in clang-1=
7.
> Will try after clang-18 is released.
>=20
> #30 is expected to be executed, see below where everything after ";" is
> the runtime value:
>    ...
>    6: (36) if w8 >=3D 0x69 goto pc+1    ; w8 =3D 0xbe, always taken
>    ...
>   11: (45) if r0 & 0xfffffffe goto pc+3  ; r0 =3D 0x616, taken
>   ...
>   18: (56) if w8 !=3D 0xf goto pc+3     ; w8 not touched, taken
>   ...
>   23: (bf) r5 =3D r8     ; w5 =3D 0xbe
>   24: (18) r2 =3D 0x4
>   26: (7e) if w8 s>=3D w0 goto pc+5    ; non-taken
>   27: (4f) r8 |=3D r8
>   28: (0f) r8 +=3D r8
>   29: (d6) if w5 s<=3D 0x1d goto pc+2  ; non-taken
>   30: (18) r0 =3D 0x4      ; executed
>=20
> Since the verifier prunes at #26, #30 is dead and eliminated. So, #30
> is executed after manually commenting out the dead code rewrite pass.
>=20
> From my understanding, I think r0 should be marked as precise when
> first backtrack from #29, because r5 range at this point depends on w0
> as r8 and r5 share the same id at #26.

Hi Hao, Andrii,

I converted program in question to a runnable test, here is a link to
the patch adding it and disabling dead code removal:
https://gist.github.com/eddyz87/e888ad70c947f28f94146a47e33cd378

Run the test as follows:
  ./test_progs -vvv -a verifier_and/pruning_test

And inspect the retval:
  do_prog_test_run:PASS:bpf_prog_test_run 0 nsec
  run_subtest:FAIL:647 Unexpected retval: 1353935089 !=3D 4

Note that I tried this test with two functions:
- bpf_get_current_cgroup_id, with this function I get retval 2, not 4 :)
- bpf_get_prandom_u32, with this function I get a random retval each time.

What is the expectation when 'bpf_get_current_cgroup_id' is used?
That it is some known (to us) number, but verifier treats it as unknown sca=
lar?

Also, I find this portion of the verification log strange:

    ...
    13: (0f) r0 +=3D r0                     ; R0_w=3Dscalar(smin=3Dsmin32=
=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D2,
                                                        var_off=3D(0x0; 0x3=
))
    14: (2f) r4 *=3D r4                     ; R4_w=3Dscalar()
    15: (18) r3 =3D 0x1f00000034            ; R3_w=3D0x1f00000034
    17: (c4) w4 s>>=3D 29                   ; R4_w=3Dscalar(smin=3D0,smax=
=3Dumax=3D0xffffffff,smin32=3D-4,smax32=3D3,
                                                        var_off=3D(0x0; 0xf=
fffffff))
    18: (56) if w8 !=3D 0xf goto pc+3       ; R8_w=3Dscalar(smin=3D0x800000=
000000000f,smax=3D0x7fffffff0000000f,
                                                        umin=3Dsmin32=3Dumi=
n32=3D15,umax=3D0xffffffff0000000f,
                                                        smax32=3Dumax32=3D1=
5,var_off=3D(0xf; 0xffffffff00000000))
    19: (d7) r3 =3D bswap32 r3              ; R3_w=3Dscalar()
    20: (18) r2 =3D 0x1c                    ; R2=3D28
    22: (67) r4 <<=3D 2                     ; R4_w=3Dscalar(smin=3D0,smax=
=3Dumax=3D0x3fffffffc,
                                                        smax32=3D0x7ffffffc=
,umax32=3D0xfffffffc,
                                                        var_off=3D(0x0; 0x3=
fffffffc))
    23: (bf) r5 =3D r8                      ; R5_w=3Dscalar(id=3D1,smin=3D0=
x800000000000000f,
                                                        smax=3D0x7fffffff00=
00000f,
                                                        umin=3Dsmin32=3Dumi=
n32=3D15,
                                                        umax=3D0xffffffff00=
00000f,
                                                        smax32=3Dumax32=3D1=
5,
                                                        var_off=3D(0xf; 0xf=
fffffff00000000))
                                            R8=3Dscalar(id=3D1,smin=3D0x800=
000000000000f,
                                                      smax=3D0x7fffffff0000=
000f,
                                                      umin=3Dsmin32=3Dumin3=
2=3D15,
                                                      umax=3D0xffffffff0000=
000f,
                                                      smax32=3Dumax32=3D15,
                                                      var_off=3D(0xf; 0xfff=
fffff00000000))
    24: (18) r2 =3D 0x4                     ; R2_w=3D4
    26: (7e) if w8 s>=3D w0 goto pc+5
    mark_precise: frame0: last_idx 26 first_idx 22 subseq_idx -1=20
    mark_precise: frame0: regs=3Dr5,r8 stack=3D before 24: (18) r2 =3D 0x4
    ...                   ^^^^^^^^^^
                          ^^^^^^^^^^
Here w8 =3D=3D 15, w0 in range [0, 2], so the jump is being predicted,
but for some reason R0 is not among the registers that would be marked prec=
ise.

