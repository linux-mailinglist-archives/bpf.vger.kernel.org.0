Return-Path: <bpf+bounces-71048-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FCDBE0A2F
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 22:31:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 858754EA291
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 20:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FFD301468;
	Wed, 15 Oct 2025 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxRvVhU2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE291F12F4
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760560313; cv=none; b=jkvXpKrxla2C/GCB9GDvQNyeEh6FdaSBxcSvRAKsJpp8x/25BA43X9uBH1UfpC9wGTpulWOWWaXOMa/zS2mUrwFh8GDaiaoW7GYGWH2t1jhpscoq4jIuoq6yjG69Lm5KxUKzrbazgR2GsXtTycXbo49qHe/0lF2vglk1/qF0ZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760560313; c=relaxed/simple;
	bh=g+/3LdZS7d2c7U3RTwRlpjpaJ2rJBJLd1PGLt5thrMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m6HY8B0WvlX4jOJA/UXwUFXfpKJcW+qwrmbNa9jaKRcoRA1Hg14YvLXtZkV5wsu8wuQ0VUQL+38HwGiGmdAOs/yMvEJ6z4vyIXWQlcgeU5pSvadd/rm+5wW5XtVwRwAdHxNuSHnSBmwiZb7QeVCXSnGHH2JgGZDY+tF0bUU3TrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RxRvVhU2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so35279a91.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 13:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760560311; x=1761165111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hrOVM0ADSpyB0gR4d/KwQN8noiDNPpJTxa+Jo+31FI=;
        b=RxRvVhU2G6TsXxfDJeJ9YJWBHxCdBj61RX8Uj4UEw+KShye5CbM33uZvWP1SLX3BWy
         guvdV0z5vx4CbNDqDHOZ1lenn3qVCPy4kt+JCHuBoLq7D5ZwrMqKsSbNoImL4R1PBiy+
         jr7Jrq1jILIIteAD5Cz40Bp3ONHatRDU8tL1paUc2rkKdOtosM/xBcd47iigjM8x9ZX0
         xy67LS6tllyogvx6yadCqckO8ZoxlwgS13GSjhTre1dWMvdsGe+90yRyU4Zk5VNcNkor
         T2l6n00wXgkJoOx1jQOu76Pcv9oeQBas3PoXDgLgzO6lDBRPLaIicpEw/VMLHJGk5B/m
         z89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760560311; x=1761165111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hrOVM0ADSpyB0gR4d/KwQN8noiDNPpJTxa+Jo+31FI=;
        b=SKuOogapZPauPywUUhjrMRMUgf2Ft+fK4vdRcUBjJD+xAQjCMOG95ZM9seZtyDRrwA
         MzjzzFUasly79QRcqyhHR1vsnXKJoeM5V7a2btgcweKZ3U+a9V0HTa0CHYqi+HcIxk3w
         IDRMFWqkjem4xNgPs3MYs68pFGDvSXkOBFc4nUPy3SOdxeIzUrAH8oP7QW75BWONn6JE
         PVEt0cLii6NWKXObBN8kKk4TuIScHvCA6hMrgPjvw2EANN5Z3ekGz2nkgfagSQpXHQlI
         UHIahnIF8yeYXCstEPVoAJ4BL4unSUO6HzVM619eNz9ZcPdjrLIiu9HVJC59nkQQDLnk
         erdQ==
X-Gm-Message-State: AOJu0YzfbKESlV5T4ixvRc4mZ66li8DAfC0/llZh/YYhjZ1huys4NQov
	3mIRyKARnm7bzTeCtkhAX31ECIZG+12oYXcTj0nQdH+WJxXfXJW4VmbnU5RS/+NVUUXfNpWEIGM
	mqZORSE8CU9GZPvGvObPlOSIh5/R7ztk=
X-Gm-Gg: ASbGncv9yOCE0Czo187izdi/SlLt2BCxF7o30PlUi3daZxqQvIeMpEJ+lWM5bk2ORBo
	ml6sTO4N9OShhBsIiviJyZRHPxHRKQRaio6OzKEIILaYoat7LE0ntJb9dCXTyXNVXAT6HiD7ZC9
	BgCDTtPNOwTiyusYGqh/ML9rND2bW2/uw4vCbDqVD9dWOzVGGD4QrGzczeknryIz0o8VUFem/QT
	gjHGTukwn4Lp/EpFCTyHMUahnq0A+6BI3uPMZGkXmimSIxX596d9g2YuYozXgsBuCBwNsvRLW+K
X-Google-Smtp-Source: AGHT+IFEyDBVY7px4eR9yf+7M+gTWMgtrk6ZnXrUSxWXoheEdol3X1GggT3nVX5OS1ncPqQOxXOYBbxJV+2sBIzCR04=
X-Received: by 2002:a17:90b:1b4c:b0:327:9e88:7714 with SMTP id
 98e67ed59e1d1-33b513ebf89mr42475863a91.37.1760560310919; Wed, 15 Oct 2025
 13:31:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014051639.1996331-1-yonghong.song@linux.dev>
 <CAEf4BzaNATrMLU6SpbFAJn8er+0ouGg1Q8RRv589=opgZ8QM5A@mail.gmail.com> <93fc2f1c-c5d3-4260-9a83-1a7300ff73cc@linux.dev>
In-Reply-To: <93fc2f1c-c5d3-4260-9a83-1a7300ff73cc@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 15 Oct 2025 13:31:36 -0700
X-Gm-Features: AS18NWDOar2SR-Dqm5nQTOlE-dk6GLXs5M8Z_xT14Skg1IRF9MsNHlrLgHg123g
Message-ID: <CAEf4BzYuK5faqPD+YRmPf5+T16BJKsM4E=BRTQcLUJxkq8=qPA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix selftest verif_scale_strobemeta
 failure with llvm22
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 12:56=E2=80=AFPM Yonghong Song <yonghong.song@linux=
.dev> wrote:
>
>
>
> On 10/15/25 9:45 AM, Andrii Nakryiko wrote:
> > On Mon, Oct 13, 2025 at 10:16=E2=80=AFPM Yonghong Song <yonghong.song@l=
inux.dev> wrote:
> >> With latest llvm22, I hit the verif_scale_strobemeta selftest failure
> >> below:
> >>    $ ./test_progs -n 618
> >>    libbpf: prog 'on_event': BPF program load failed: -E2BIG
> >>    libbpf: prog 'on_event': -- BEGIN PROG LOAD LOG --
> >>    BPF program is too large. Processed 1000001 insn
> >>    verification time 7019091 usec
> >>    stack depth 488
> >>    processed 1000001 insns (limit 1000000) max_states_per_insn 28 tota=
l_states 33927 peak_states 12813 mark_read 0
> >>    -- END PROG LOAD LOG --
> >>    libbpf: prog 'on_event': failed to load: -E2BIG
> >>    libbpf: failed to load object 'strobemeta.bpf.o'
> >>    scale_test:FAIL:expect_success unexpected error: -7 (errno 7)
> >>    #618     verif_scale_strobemeta:FAIL
> >>
> >> But if I increase the verificaiton insn limit from 1M to 10M, the abov=
e
> >> test_progs run actually will succeed. The below is the result from ver=
istat:
> >>    $ ./veristat strobemeta.bpf.o
> >>    Processing 'strobemeta.bpf.o'...
> >>    File              Program   Verdict  Duration (us)    Insns  States=
  Program size  Jited size
> >>    ----------------  --------  -------  -------------  -------  ------=
  ------------  ----------
> >>    strobemeta.bpf.o  on_event  success       90250893  9777685  358230=
         15954       80794
> >>    ----------------  --------  -------  -------------  -------  ------=
  ------------  ----------
> >>    Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.
> >>
> >> Further debugging shows the llvm commit [1] is responsible for the ver=
ificaiton
> >> failure as it tries to convert certain switch statement to if-conditio=
n. Such
> >> change may cause different transformation compared to original switch =
statement.
> >>
> >> In bpf program strobemeta.c case, the initial llvm ir for read_int_var=
() function is
> >>    define internal void @read_int_var(ptr noundef %0, i64 noundef %1, =
ptr noundef %2,
> >>        ptr noundef %3, ptr noundef %4) #2 !dbg !535 {
> >>      %6 =3D alloca ptr, align 8
> >>      %7 =3D alloca i64, align 8
> >>      %8 =3D alloca ptr, align 8
> >>      %9 =3D alloca ptr, align 8
> >>      %10 =3D alloca ptr, align 8
> >>      %11 =3D alloca ptr, align 8
> >>      %12 =3D alloca i32, align 4
> >>      ...
> >>      %20 =3D icmp ne ptr %19, null, !dbg !561
> >>      br i1 %20, label %22, label %21, !dbg !562
> >>
> >>    21:                                               ; preds =3D %5
> >>      store i32 1, ptr %12, align 4
> >>      br label %48, !dbg !563
> >>
> >>    22:
> >>      %23 =3D load ptr, ptr %9, align 8, !dbg !564
> >>      ...
> >>
> >>    47:                                               ; preds =3D %38, =
%22
> >>      store i32 0, ptr %12, align 4, !dbg !588
> >>      br label %48, !dbg !588
> >>
> >>    48:                                               ; preds =3D %47, =
%21
> >>      call void @llvm.lifetime.end.p0(ptr %11) #4, !dbg !588
> >>      %49 =3D load i32, ptr %12, align 4
> >>      switch i32 %49, label %51 [
> >>        i32 0, label %50
> >>        i32 1, label %50
> >>      ]
> >>
> >>    50:                                               ; preds =3D %48, =
%48
> >>      ret void, !dbg !589
> >>
> >>    51:                                               ; preds =3D %48
> >>      unreachable
> >>    }
> >>
> >> Note that the above 'switch' statement is added by clang frontend.
> >> Without [1], the switch statement will survive until SelectionDag,
> >> so the switch statement acts like a 'barrier' and prevents some
> >> transformation involved with both 'before' and 'after' the switch stat=
ement.
> >>
> >> But with [1], the switch statement will be removed during middle end
> >> optimization and later middle end passes (esp. after inlining) have mo=
re
> >> freedom to reorder the code.
> >>
> >> The following is the related source code:
> >>
> >>    static void *calc_location(struct strobe_value_loc *loc, void *tls_=
base):
> >>          bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
> >>          /* if pointer has (void *)-1 value, then TLS wasn't initializ=
ed yet */
> >>          return tls_ptr && tls_ptr !=3D (void *)-1
> >>                  ? tls_ptr + tls_index.offset
> >>                  : NULL;
> >>
> >>    In read_int_var() func, we have:
> >>          void *location =3D calc_location(&cfg->int_locs[idx], tls_bas=
e);
> >>          if (!location)
> >>                  return;
> >>
> >>          bpf_probe_read_user(value, sizeof(struct strobe_value_generic=
), location);
> >>          ...
> >>
> >> The static func calc_location() is called inside read_int_var(). The a=
sm code
> >> without [1]:
> >>       77: .123....89 (85) call bpf_probe_read_user#112
> >>       78: ........89 (79) r1 =3D *(u64 *)(r10 -368)
> >>       79: .1......89 (79) r2 =3D *(u64 *)(r10 -8)
> >>       80: .12.....89 (bf) r3 =3D r2
> >>       81: .123....89 (0f) r3 +=3D r1
> >>       82: ..23....89 (07) r2 +=3D 1
> >>       83: ..23....89 (79) r4 =3D *(u64 *)(r10 -464)
> >>       84: ..234...89 (a5) if r2 < 0x2 goto pc+13
> >>       85: ...34...89 (15) if r3 =3D=3D 0x0 goto pc+12
> >>       86: ...3....89 (bf) r1 =3D r10
> >>       87: .1.3....89 (07) r1 +=3D -400
> >>       88: .1.3....89 (b4) w2 =3D 16
> >> In this case, 'r2 < 0x2' and 'r3 =3D=3D 0x0' go to null 'locaiton' pla=
ce,
> >> so the verifier actually prefers to do verification first at 'r1 =3D r=
10' etc.
> >>
> >> The asm code with [1]:
> >>      119: .123....89 (85) call bpf_probe_read_user#112
> >>      120: ........89 (79) r1 =3D *(u64 *)(r10 -368)
> >>      121: .1......89 (79) r2 =3D *(u64 *)(r10 -8)
> >>      122: .12.....89 (bf) r3 =3D r2
> >>      123: .123....89 (0f) r3 +=3D r1
> >>      124: ..23....89 (07) r2 +=3D -1
> >>      125: ..23....89 (a5) if r2 < 0xfffffffe goto pc+6
> >>      126: ........89 (05) goto pc+17
> >>      ...
> >>      144: ........89 (b4) w1 =3D 0
> >>      145: .1......89 (6b) *(u16 *)(r8 +80) =3D r1
> >> In this case, if 'r2 < 0xfffffffe' is true, the control will go to
> >> non-null 'location' branch, so 'goto pc+17' will actually go to
> >> null 'location' branch. This seems causing tremendous amount of
> >> verificaiton state.
> >>
> >> To fix the issue, rewrite the following code
> >>    return tls_ptr && tls_ptr !=3D (void *)-1
> >>                  ? tls_ptr + tls_index.offset
> >>                  : NULL;
> >> to if/then statement and hopefully these explicit if/then statements
> >> are sticky during middle-end optimizations.
> > this is so fragile and non-obvious... Just looking at the patch, it's
> > an equivalent transformation, so as a user I'd have no clue that doing
> > something like that can even matter...
>
> You are correct. The llvm generate different codes due to compiler intern=
al
> changes, and in this case the change caused the verification failure.
>
> >
> > Have you tried adding likely() around non-NULL case? Does it change
> > generated code, while leaving ternary as is?
>
> I tried the following:
>
> diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/testi=
ng/selftests/bpf/progs/strobemeta.h
> index a5c74d31a244..6c0ec8794d3e 100644
> --- a/tools/testing/selftests/bpf/progs/strobemeta.h
> +++ b/tools/testing/selftests/bpf/progs/strobemeta.h
> @@ -346,13 +346,12 @@ static void read_int_var(struct strobemeta_cfg *cfg=
,
>                           struct strobemeta_payload *data)
>   {
>          void *location =3D calc_location(&cfg->int_locs[idx], tls_base);
> -       if (!location)
> -               return;
> -
> -       bpf_probe_read_user(value, sizeof(struct strobe_value_generic), l=
ocation);
> -       data->int_vals[idx] =3D value->val;
> -       if (value->header.len)
> -               data->int_vals_set_mask |=3D (1 << idx);
> +       if (likely(location)) {
> +               bpf_probe_read_user(value, sizeof(struct strobe_value_gen=
eric), location);
> +               data->int_vals[idx] =3D value->val;
> +               if (value->header.len)
> +                       data->int_vals_set_mask |=3D (1 << idx);
> +       }
>   }
>
>
> and the verification still failed (exceeding 1000000 insns).

I was thinking to add likely like so:

return likely(tls_ptr && tls_ptr !=3D (void *)-1) ? tls_ptr +
tls_index.offset : NULL;


and then hope that Clang will prioritize leaving non-NULL code path as
linear as possible

>
> I think that we can leave patch for a while. I will do some investigation
> in llvm side to see whether I can come up with some heuristics to benefit
> verifier in terms of verified insns.
>
> >
> >> Test with llvm20 and llvm21 as well and all strobemeta related selftes=
ts
> >> are passed.
> >>
> >>    [1] https://github.com/llvm/llvm-project/pull/161000
> >>
> >> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> >> ---
> >>   tools/testing/selftests/bpf/progs/strobemeta.h | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> NOTE: I will also check whether we can make changes in llvm to automat=
ically
> >>   adjust branch statements to minimize verification insns/states.
> >>
> >> diff --git a/tools/testing/selftests/bpf/progs/strobemeta.h b/tools/te=
sting/selftests/bpf/progs/strobemeta.h
> >> index a5c74d31a244..6e1918deaf26 100644
> >> --- a/tools/testing/selftests/bpf/progs/strobemeta.h
> >> +++ b/tools/testing/selftests/bpf/progs/strobemeta.h
> >> @@ -330,9 +330,9 @@ static void *calc_location(struct strobe_value_loc=
 *loc, void *tls_base)
> >>          }
> >>          bpf_probe_read_user(&tls_ptr, sizeof(void *), dtv);
> >>          /* if pointer has (void *)-1 value, then TLS wasn't initializ=
ed yet */
> >> -       return tls_ptr && tls_ptr !=3D (void *)-1
> >> -               ? tls_ptr + tls_index.offset
> >> -               : NULL;
> >> +       if (!tls_ptr || tls_ptr =3D=3D (void *)-1)
> >> +               return NULL;
> >> +       return tls_ptr + tls_index.offset;
> >>   }
> >>
> >>   #ifdef SUBPROGS
> >> --
> >> 2.47.3
> >>
>

