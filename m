Return-Path: <bpf+bounces-15563-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4197F34B8
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 18:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4921C20B67
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 17:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7715A0F2;
	Tue, 21 Nov 2023 17:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvTLYkKh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BD1199
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 09:16:20 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9beb865a40so5446947276.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700586980; x=1701191780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBk8V6n3pE8ZeaB8hGFlcC0qe5iEw87ibKdEnJawyLI=;
        b=kvTLYkKhl0yH9b0/V22rf7N9+dRVzW/HGxoW8ZOiknbvi/xDxRrMb0zoLjzMmrmwCZ
         dSVca7P16FAZQiYpvqa+tCk62CbhOfxH0ILNPUWo0WUVc5AzQI8OoZWI4rakPQlddmfX
         nPCilOP+pAAAS8f17VMmybzyW+lyaqxPpGij6/DWaZDjpaRb5R3GWCoaR85CHsrSI+Kz
         qdri/Hu1qNaucOBfH0QlxxGXKZQHpiDhEKIOeaEnIooBufnAzGTkHY0BDymN/wbAKvvW
         RZPebvlKaUiH0tuIm/lPASLetarVqQjlab3ZV0q9HXMaCQmztmK5bHFaH+Cq2i7qakoY
         HbuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700586980; x=1701191780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBk8V6n3pE8ZeaB8hGFlcC0qe5iEw87ibKdEnJawyLI=;
        b=ehr3YD8LeIuXBil6wFNCx8BwJjq4GGpPOyVv2SNBoNJMwiTIMc7OavwklTBZe5Xf9e
         yjHUhZjDSez/a5mVWyhJZDWKYFmRnhkT46RrviZomLZYbi0wiUAanT/JAt1aiukorBpe
         6gs0y4zV7OUmjiiySX/nD3EfI7H27X/yHyUi1q3hJwJqrAc9nH+9Ls7IqfrlDKQgEUsL
         1d8DUDycWIuefl7IPZ/tT8zlHk2jlHEGqdq4GCP3s/bCMKzIKRUCqFcYHyB2mipBBGKw
         SiR4UQLVyVDyjjbrX3N8CH6GH5VTNk0VHoQy7nCEk6UZ3YqT18vidn9ZDwWo/L9LDpVa
         aTiA==
X-Gm-Message-State: AOJu0YyMzm1nWyuXiRAdEP6CRxfXBFU2iSKBWijcQHXDcUsGuI5LqOny
	BpJO2AcBfU3XxKr/20EAgHkmtqhIgz/+Ht/i1g==
X-Google-Smtp-Source: AGHT+IF4VvhpzDjdvFYJ7z92hUDlD55kUUxdbApaRbRoU4Hs7i/HMC3db92OYXXpp7D7122cZOx0a49fVRQafg7C5D4=
X-Received: by 2002:a25:69ca:0:b0:da0:2757:eb7 with SMTP id
 e193-20020a2569ca000000b00da027570eb7mr11804619ybc.37.1700586979985; Tue, 21
 Nov 2023 09:16:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231113235008.127238-1-andreimatei1@gmail.com> <CAEf4BzZbXML3oWaHejXRFNAG4NM2vGpsz9axjvOX6wKxEG+ExA@mail.gmail.com>
In-Reply-To: <CAEf4BzZbXML3oWaHejXRFNAG4NM2vGpsz9axjvOX6wKxEG+ExA@mail.gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Tue, 21 Nov 2023 18:16:08 +0100
Message-ID: <CACkBjsbWdOVMs7vRXvxi0MCoOAh+skYWFN1douBjkRzeTX=wvg@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: fix tracking of stack size for var-off access
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrei Matei <andreimatei1@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, kernel-team@dataexmachina.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 1:46=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
>
> It *feels* like this stack depth update *and* growing allocated stack
> slots should happen somewhere in check_stack_access_within_bounds() or
> right after it. It shouldn't matter whether we read or write to the
> stack slot: either way that slot becomes part of the verifier state
> that we should take into account during state comparison. Eduard not
> so long ago added a change that allows reading STACK_INVALID slots, so
> it's completely valid to read something that was never written to (and
> so grow_stack_state() wasn't called for that slot, as it is
> implemented right now). So I think we should fix that.
>

Agree. The following cases are currently confusing to me.

The verifier accepts the following program, which goes from #4 to #8
and directly read the stack at runtime without any previous write:
func#0 @0
0: R1=3Dctx() R10=3Dfp0
0: (bf) r6 =3D r10                      ; R6_w=3Dfp0 R10=3Dfp0
1: (85) call bpf_get_prandom_u32#7    ; R0_w=3Dscalar()
2: (bf) r3 =3D r0                       ; R0_w=3Dscalar(id=3D1) R3_w=3Dscal=
ar(id=3D1)
3: (bf) r8 =3D r0                       ; R0_w=3Dscalar(id=3D1) R8_w=3Dscal=
ar(id=3D1)
4: (4e) if w0 & w3 goto pc+3          ; R0_w=3Dscalar(id=3D1) R3_w=3Dscalar=
(id=3D1)
5: (63) *(u32 *)(r6 -196) =3D r3        ; R3_w=3Dscalar(id=3D1) R6_w=3Dfp0
fp-200=3Dmmmm????
6: (18) r7 =3D 0x19                     ; R7=3D25
8: (61) r7 =3D *(u32 *)(r6 -200)        ; R6=3Dfp0
R7_w=3Dscalar(smin=3D0,smax=3Dumax=3D0xffffffff,var_off=3D(0x0; 0xffffffff)=
)
fp-200=3Dmmmm????
9: (95) exit

from 4 to 8: safe
verification time 358 usec
stack depth 200
processed 10 insns (limit 1000000) max_states_per_insn 0 total_states
1 peak_states 1 mark_read 1

The state is pruned, because of this:
static bool stacksafe(...)
         ....
         if (env->allow_uninit_stack &&
             old->stack[spi].slot_type[i % BPF_REG_SIZE] =3D=3D STACK_MISC)
             continue;

Yet, the sample direct read would be rejected:

func#0 @0
0: R1=3Dctx() R10=3Dfp0
0: (bf) r6 =3D r10                      ; R6_w=3Dfp0 R10=3Dfp0
1: (61) r7 =3D *(u32 *)(r6 -200)
invalid read from stack R6 off=3D-200 size=3D4

Eduard, you added support for reading uninit slots, should we also add some=
thing
like the following:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8c2d31aa3d31..aa861d2da240 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6446,7 +6446,7 @@ static int check_stack_slot_within_bounds(int off,
 {
        int min_valid_off;

-       if (t =3D=3D BPF_WRITE)
+       if (t =3D=3D BPF_WRITE || env->allow_uninit_stack)
                min_valid_off =3D -MAX_BPF_STACK;
        else
                min_valid_off =3D -state->allocated_stack;

