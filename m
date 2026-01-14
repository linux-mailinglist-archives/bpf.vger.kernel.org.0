Return-Path: <bpf+bounces-78825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A12D1C357
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 04:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91BE730194CD
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 03:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E85283159;
	Wed, 14 Jan 2026 03:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1J6P7ue"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1378721FF5F
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 03:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768360135; cv=none; b=nETmWm4iV9mWjzbnUaqwoXdWtr2LbRwG/QUhiSIsrnQFwvHj265E3ooVGFhY0q6nWtg9pG0UgcOh/q0bKtRN+wzyQNiCMAbcwlOWH+14qdAOvGzjftGdfGjXl6hgbPYN6shcZCK54hARfdalE56zsqnfSoExEm9pTPCrLMtBsRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768360135; c=relaxed/simple;
	bh=F/nh4cyMkzCNcw3Pr6nQ3YVkXAKgrb3sIWLVEFPH7Xw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tmiGhN5ZSQtBz7ct2WVfSJxA3rIZPZKYLMENs+BRO9EJVv3g5UnRS5qce7BtauBnghUxSIyQDssbZTp9j47+EtuLHAhf5N+02+VP0BrCF8wMetH77tWxuKu1ivsJ25H9X2iTTKNlJkNSSczuDJr13SejXdbSh6wOYCxIQ5WEZ3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1J6P7ue; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-431048c4068so235651f8f.1
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 19:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768360132; x=1768964932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0X8Fqh+vAz722tECBmXVIQTtPvX3LiNvZYjZlN0LHVc=;
        b=a1J6P7ue9NA3YzwIFKo4D7A3WWI36sMLqrLYmfERuLZ5IHHObDEXIfUkE2SENuCbAj
         fk3zwQ0u18qAr1caIbzsPp6VP9zon95261J/wxM5ryigqpM8oR106HzVIoWNCBvvaC2W
         dPb6x05/wLRdyMyQTiKD5oSKjfZivtKyz/Hyb23zf3+0LkbLcfAR7ML9G6EoXskxeuOm
         wZ6htL6/zfycuGes7xadufN/Iele60KPLQUvV1YOieeTF9waqOfUb8TFOVmCXFNnW2hB
         9fmjNrWJuV7sk4IIpXdSlaS2uhQtBhkKak42HQeQC6BwtNhO9dsjyjLp9yQkwK7LADvb
         B6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768360132; x=1768964932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0X8Fqh+vAz722tECBmXVIQTtPvX3LiNvZYjZlN0LHVc=;
        b=Oamno093O/f8UWz4JsRSXm678G/vdFUQsS6ytqW5dkp2t8bzCx+gTXhOfly7NQby/s
         /r2yDlOciEhmtpAXCRmI2JfNyD7BxVX/VHWlbn/dDTRYhidyOAURGGSB9LU8t8dRXLV1
         KNK64Kcj3Y0E48MnVKvn8tfA0YsdLnwzly+9qKcq+FF8hPuqYyHG8UXm7M3X43XFbbzl
         S5Vnotnw6rBsMVVSMQb9bbCGL833zno794sUHaH0GmszGRg2SLDo8XEbcMTTFLks6/rX
         09orwS/yJ+bKY/dFcsm0+8O/Z6AXRVq6eTeSoxiAx4dUDota9DAs21SX7H+opUa8uiS+
         jGjg==
X-Gm-Message-State: AOJu0Yy+Ocw751HpXQoKTg3uvBihMsPApGN4Hq9uY/rfZAnQ4xvpnogJ
	ul6P+u5DjvGHI/9xRJeH1Z9n+o3w0BTP1OO5K4Arbn9imhPw+zGvc1tTYgLVfwhNyk6X8rg//x+
	Kz770iq2pucMfITVbcquj2bjjXQvULeY=
X-Gm-Gg: AY/fxX7f31ah9iBpmbjL6MX8NdJYfb2ique5d9XPxEua8tobJIJMlSZrtYBm9/VwZuA
	k5KvgHdSyxdrTzEPgpRXZL3u2cmY1NSk4Ns0IYmcsO+RO5m9eu7XQLtcjselxkdrZ/I/2NWiZ3A
	rMh1WCyQlKNa+xym7DQcK7ypPpfnUIhtn+oGAOqaSCkWbQ+6/a3pxxX43LWqmUq6NErkBxXIAOA
	TPRkruU7mKklda5BJSxDt1Gm+We+ARpzjR5my9tOmLUoSyhm6EeTQBnyB3ZBfHD4AhY/8BWVqt4
	ufNQ5VlENRfZnIBCxH3YtIWD3+Sl
X-Received: by 2002:a05:6000:1a8a:b0:430:fdc8:8bd6 with SMTP id
 ffacd0b85a97d-4342c0ff57cmr1327977f8f.31.1768360132141; Tue, 13 Jan 2026
 19:08:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260113103552.3435695-1-tangyazhou@zju.edu.cn> <20260113103552.3435695-2-tangyazhou@zju.edu.cn>
In-Reply-To: <20260113103552.3435695-2-tangyazhou@zju.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 13 Jan 2026 19:08:41 -0800
X-Gm-Features: AZwV_QhT-U19eHYwF_xFMJWHSeLVOp0PFGhI7XcDYIpZKrBjhRBhHjqMouZU_Hw
Message-ID: <CAADnVQL3gGe4iK8FZWnT3frRjAHtnNwGp8m5J8OSVcX0BCorUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Add range tracking for BPF_DIV and BPF_MOD
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>, 
	Tianci Cao <ziye@zju.edu.cn>, syzbot@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 13, 2026 at 2:36=E2=80=AFAM Yazhou Tang <tangyazhou@zju.edu.cn>=
 wrote:
>
> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> This patch implements range tracking (interval analysis) for BPF_DIV and
> BPF_MOD operations when the divisor is a constant, covering both signed
> and unsigned variants.
>
> While LLVM typically optimizes integer division and modulo by constants
> into multiplication and shift sequences, this optimization is less
> effective for the BPF target when dealing with 64-bit arithmetic.
>
> Currently, the verifier does not track bounds for scalar division or
> modulo, treating the result as "unbounded". This leads to false positive
> rejections for safe code patterns.
>
> For example, the following code (compiled with -O2):
>
> ```c
> int test(struct pt_regs *ctx) {
>     char buffer[6] =3D {1};
>     __u64 x =3D bpf_ktime_get_ns();
>     __u64 res =3D x % sizeof(buffer);
>     char value =3D buffer[res];
>     bpf_printk("res =3D %llu, val =3D %d", res, value);
>     return 0;
> }
> ```
>
> Generates a raw `BPF_MOD64` instruction:
>
> ```asm
> ;     __u64 res =3D x % sizeof(buffer);
>        1:       97 00 00 00 06 00 00 00 r0 %=3D 0x6
> ;     char value =3D buffer[res];
>        2:       18 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r1 =3D 0x=
0 ll
>        4:       0f 01 00 00 00 00 00 00 r1 +=3D r0
>        5:       91 14 00 00 00 00 00 00 r4 =3D *(s8 *)(r1 + 0x0)
> ```
>
> Without this patch, the verifier fails with "math between map_value
> pointer and register with unbounded min value is not allowed" because
> it cannot deduce that `r0` is within [0, 5].
>
> According to the BPF instruction set[1], the instruction's offset field
> (`insn->off`) is used to distinguish between signed (`off =3D=3D 1`) and
> unsigned division (`off =3D=3D 0`). Moreover, we also follow the BPF divi=
sion
> and modulo semantics (runtime behavior) to handle special cases, such as
> division by zero and signed division overflow.
>
> - UDIV: dst =3D (src !=3D 0) ? (dst / src) : 0
> - SDIV: dst =3D (src =3D=3D 0) ? 0 : ((src =3D=3D -1 && dst =3D=3D LLONG_=
MIN) ? LLONG_MIN : (dst / src))
> - UMOD: dst =3D (src !=3D 0) ? (dst % src) : dst
> - SMOD: dst =3D (src =3D=3D 0) ? dst : ((src =3D=3D -1 && dst =3D=3D LLON=
G_MIN) ? 0: (dst s% src))
>
> Here is the overview of the changes made in this patch (See the code comm=
ents
> for more details and examples):
>
> For BPF_DIV:
> 1. Main analysis:
>    - General cases and "division by zero" case: compute the new range by
>      dividing max_dividend and min_dividend by the constant divisor.
>      Use helper functions `__bpf_udiv32`, `__bpf_udiv`, `__bpf_sdiv32`,
>      and `__bpf_sdiv` to encapsulate the division logic, including handli=
ng
>      division by zero.
>    - "SIGNED_MIN / -1" case in signed division: mark the result as unboun=
ded
>      if the dividend is not a single number.
> 2. Post-processing:
>    - Domain reset: Signed analysis resets unsigned bounds to unbounded,
>      and vice versa.
>    - Width reset: 32-bit analysis resets 64-bit bounds to unbounded
>      (and vice versa) to maintain consistency.
>    - Tnum reset: reset `var_off` to unknown since precise bitwise trackin=
g
>      for division is not implemented.
>
> For BPF_MOD:
> 1. Main analysis:
>    - General case: For signed modulo, the result's sign matches the
>      dividend's sign. The result's absolute value is strictly bounded
>      by min(abs(dividend), abs(divisor) - 1).
>      Special care is taken when the divisor is SIGNED_MIN. By casting
>      to unsigned before negation and subtracting 1, we avoid signed
>      overflow and correctly calculate the maximum possible magnitude
>      (`res_max_abs` in the code).
>    - "Division by zero" case: If the divisor is zero, the destination
>      register remains unchanged (matching runtime behavior).
>    - "Small dividend" case: If the dividend is already within the possibl=
e
>      result range (e.g., [2, 5] % 10), the operation is an identity
>      function, and the register state remains unchanged.
> 2. Post-processing (if the result is changed compared to the dividend):
>    - Domain reset: Signed analysis resets unsigned bounds to unbounded,
>      and vice versa.
>    - Width reset: 32-bit analysis resets 64-bit bounds to unbounded
>      (and vice versa) to maintain consistency.
>    - Tnum reset: reset `var_off` to unknown since precise bitwise trackin=
g
>      for division is not implemented.
>
> Also updated existing selftests based on the expected BPF_DIV and
> BPF_MOD behavior.
>
> [1] https://www.kernel.org/doc/Documentation/bpf/standardization/instruct=
ion-set.rst
>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Tested-by: syzbot@syzkaller.appspotmail.com
> ---
>  kernel/bpf/verifier.c                         | 326 ++++++++++++++++++
>  .../bpf/progs/verifier_value_illegal_alu.c    |   7 +-
>  .../testing/selftests/bpf/verifier/precise.c  |   4 +-
>  3 files changed, 332 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 53635ea2e41b..f3b51751d990 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -15077,6 +15077,283 @@ static void scalar_min_max_mul(struct bpf_reg_s=
tate *dst_reg,
>         }
>  }
>
> +static u32 __bpf_udiv32(u32 a, u32 b)
> +{
> +       /* BPF div specification: x / 0 =3D 0 */
> +       if (unlikely(b =3D=3D 0))
> +               return 0;
> +       return a / b;
> +}
> +
> +static u64 __bpf_udiv(u64 a, u64 b)
> +{
> +       /* BPF div specification: x / 0 =3D 0 */
> +       if (unlikely(b =3D=3D 0))
> +               return 0;
> +       return a / b;
> +}
> +
> +static s32 __bpf_sdiv32(s32 a, s32 b)
> +{
> +       /* BPF div specification: x / 0 =3D 0 */
> +       if (unlikely(b =3D=3D 0))
> +               return 0;
> +       return a / b;
> +}
> +
> +static s64 __bpf_sdiv(s64 a, s64 b)
> +{
> +       /* BPF div specification: x / 0 =3D 0 */
> +       if (unlikely(b =3D=3D 0))
> +               return 0;
> +       return a / b;
> +}

The whole thing looks very much AI generated.
It can spit out a lot of code, but submitter (YOU) must
think it through before submitting.
In the above... 4 almost equivalent helpers don't bother you?!

and b=3D=3D0 check... isn't it obvious that might be
easier to read and less verbose to do it once before all that?

You need to step up the quality of this patchset.
AI is NOT your friend.

pw-bot: cr

