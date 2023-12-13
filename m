Return-Path: <bpf+bounces-17626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D55B80FBAC
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 01:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028891F21A8E
	for <lists+bpf@lfdr.de>; Wed, 13 Dec 2023 00:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974CA21;
	Wed, 13 Dec 2023 00:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9ivD7ZX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37612BE;
	Tue, 12 Dec 2023 16:00:52 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-a1f6433bc1eso988639966b.1;
        Tue, 12 Dec 2023 16:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702425650; x=1703030450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jaKGNb1VRd5VrDyxiTt9RbEg148bOMoqEkF4ucEMcYQ=;
        b=S9ivD7ZXIqANASyAZdAcw38OJxzPLwjVns1W12tepRBvx1QXzD1KBn5E4VPjIuy6a1
         CgCDXiUjNnq9igmTIyQ6mWdBOdleK1Zt1H/rYbFMD52P4RuRWQ5zzCbExp1oNNONNBDG
         zVgJol/ddV51NZQVXLK+MGMVU1G1yypdZxSmj1jR5b4kh132RcPftwEsu8+gg8HEMgLA
         /YkBKucoCmjArSqps+dNSdg4IkOtwaCEBWeg4aKII8xaIgviSJ3e+9wJRv5ixqCC64dJ
         rYDQ8LU57Nc9h7hbpklLNik1e6DcjGk6VC/vXWOrNG5KemRWCpdB9kFdOnAwoDeGPhi/
         4mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702425650; x=1703030450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jaKGNb1VRd5VrDyxiTt9RbEg148bOMoqEkF4ucEMcYQ=;
        b=JBt+l9gmXpAFeQ5L2mxN6Tk8VNuOlut9RbG/OZ2qflkzKSqWQlgkxhdlP7PMfFJJXr
         UTqeLlpFa+wVeMJIB7YljMAiZ1PhtzWAxYFv2l4zj2ziSp+4JoaRwNYa87iIL0eu5wzf
         fnntVD3sXJJkHlUr3ZOJuMcYR+SxKPzwT5ZHzp3oRZst/WHPZVjSWtokEhpNKPkO4ye2
         93wsL47f5QxWPiQ2rW/JpaES0fekEL+B7F3YBr6i7vZ3VGF/IJ8nUjcxNUDed/K0l4OT
         MIsU4Pra51q8MVhSCAe5/uKgICb9XDHiQZwFPrK1/gVm3yIgDLrmZuughBWaU+3tlABN
         oQAw==
X-Gm-Message-State: AOJu0Yxp2jz+3EgK01gCjWOr86HQdra1Kj+eNgoeIvnInaiLr1Y6X49p
	vZOQzIwtE4ebE19KN3JMVA3vGIxW3QXJLL+P3s0EIA8rZdk=
X-Google-Smtp-Source: AGHT+IGYW7xzpOkLwqBUER6EDcHRX9iNES/kCZd6cZhJDe/FEx9mz+yAG28v2vFhNXHxL0DlY9zccc8Lg4UK5reXTnI=
X-Received: by 2002:a17:906:101e:b0:a01:ae9a:c1d3 with SMTP id
 30-20020a170906101e00b00a01ae9ac1d3mr7424415ejm.11.1702425650293; Tue, 12 Dec
 2023 16:00:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231212131031.3088661-1-menglong8.dong@gmail.com>
In-Reply-To: <20231212131031.3088661-1-menglong8.dong@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 12 Dec 2023 16:00:38 -0800
Message-ID: <CAEf4BzavDwxD3=c6Gxo6N9OjN95Bf0bKZ0xMPGCq=nCm8jPzGg@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/2] bpf: support to trace BPF_JNE
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: andrii@kernel.org, yonghong.song@linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, kpsingh@kernel.org, sdf@google.com, haoluo@google.com, 
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 12, 2023 at 5:15=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
.com> wrote:
>
> For now, the reg bounds is not handled for BPF_JNE case, which can cause
> the failure of following case:
>
>   /* The type of "a" is u16 */
>   if (a > 0 && a < 100) {
>     /* the range of the register for a is [0, 99], not [1, 99],
>      * and will cause the following error:
>      *
>      *   invalid zero-sized read
>      *
>      * as a can be 0.
>      */
>     bpf_skb_store_bytes(skb, xx, xx, a, 0);
>   }
>
> In the code above, "a > 0" will be compiled to "jmp xxx if a =3D=3D 0". I=
n the
> TRUE branch, the dst_reg will be marked as known to 0. However, in the
> fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
> the [min, max] for a is [0, 99], not [1, 99].
>
> In the 1st patch, we reduce the range of the dst reg if the src reg is a
> const and is exactly the edge of the dst reg For BPF_JNE.
>
> In the 2nd patch, we just activate the test case for this logic in
> range_cond(), which is committed by Andrii in the
> commit 8863238993e2 ("selftests/bpf: BPF register range bounds tester").
>
> Changes since v1:
> - simplify the code in the 1st patch
> - introduce the 2nd patch for the testing
>
> Menglong Dong (2):
>   bpf: make the verifier trace the "not qeual" for regs
>   selftests/bpf: activate the OP_NE login in range_cond()
>
>  kernel/bpf/verifier.c                         | 29 ++++++++++++++++++-
>  .../selftests/bpf/prog_tests/reg_bounds.c     |  7 +----
>  2 files changed, 29 insertions(+), 7 deletions(-)
>
> --
> 2.39.2
>

+1 to all the feedback from Eduard. Besides that, please target
bpf-next tree (so, [PATH bpf-next] for subject prefix), thanks!

Also, instead of "verifier traces", I think "verifier tracks" is less
confusing wording. Tracing within the BPF ecosystem is usually used
for a completely different meaning.

Oh, and just to keep feedback in one place. In patch #2 you have a
typo in the subject "not qeual" -> "not equal".

