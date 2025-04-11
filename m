Return-Path: <bpf+bounces-55796-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F9EA867FB
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 23:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5639A2970
	for <lists+bpf@lfdr.de>; Fri, 11 Apr 2025 21:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7B7298984;
	Fri, 11 Apr 2025 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o0gy2zMm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB865298988
	for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744405964; cv=none; b=SO0Jedrw3pIeMC1QMBxgdwpBza0ztiI8Hk9xIm+/zDARFMPb+J3aVK+lhwfAZDG69qVm5maG3wUU7MBz3zzQArLGjzwTgR4sA5O/ms2sM/elReB/kJjrfdB/t+mc0Afvi4Pr9pI3K6R2slXqLWAtvIiYT/E5Ct4kr/VFFCw8I0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744405964; c=relaxed/simple;
	bh=6nlXqivw5n2s2vI3iH0kICSGFjaF+JSbbOv3yESDDQ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiFN0p2GcFaiH0cQ+EnZu2Ip4sSm3R2+P/YRN14Nh0peNfMOn7xQIjwaB48c/JPS2j4ts6SG28mSMtXGOCcp9bR0RtkRYlnE60Qn1rp4YG35dWk3mK0rkSbfdIO6n5dSA2BNXWY606mZcz0y6U7VNR01o3tBaDZc5b6S/uuyabY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o0gy2zMm; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5cbd8b19bso1074a12.1
        for <bpf@vger.kernel.org>; Fri, 11 Apr 2025 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744405960; x=1745010760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5s9O/8O6xeMVl0tLPF60JEEeubmLlBJjqtBbS0i9ciQ=;
        b=o0gy2zMmuqK9BfwgMn3I5k9bTf0nRUprt9XeyjAur9+ahPXQie+WOrrNzUzj0sDZ3i
         EElr14q46QtRYlZxd0a5vfB02F2PiZCisBNImbODE0naF+k+Z++fCeOsqYYUTEUKqB6j
         WBZrL5iG1PbNkpi0QZJbRN1YB/ONArp+/MdGu1EdZXeT1Ev6dEBn88lKHfhwIM4kOfIg
         Av89OjKtLZMVJ7kVJxnwkYj2o7DwBElDQ/g+E8uf0AOPvZAywh9xLDBn5U6srs0jI3Hh
         MutSbVTvWAsLBFQ5Zet5Hjiwce3E5mt68o9Mzcwhzj4uJ4R5+x+8Idg5rA5Jr3rSJ05J
         jMpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744405960; x=1745010760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5s9O/8O6xeMVl0tLPF60JEEeubmLlBJjqtBbS0i9ciQ=;
        b=iNy+fqVKW7mEKl3lgVD6+DOd3UHCavYUTRCSUZHqxDBZghXDz+okpVqaQ4he5GIUwF
         B2HG2/b6dflrDE8TPJZgUWHbelCcaHzN3MKubZDdRr+Af1uowXFeo6ddTw0R7xDUxHjs
         WXUTtotgc4iqQcfoaVDTYE/7be4CpSOYTE2DsxM7isGUIEQoEYSklipp1ILXtHzIYR6W
         ErEKdZxkPmI0vpQ1O0RszbZoOqm+dXzG5y7qK/b7kWCSAkmEZfQxLP+nClBfMJ31FYIR
         M8s45N96Rua8UHeE9M3p62NqbcuK5R9PdVJ7Fr4hTrxIwuQigKu000lSCnFuE837OqqO
         lHmg==
X-Forwarded-Encrypted: i=1; AJvYcCXcLGx96KfIebmP091yEeh611qXjhHVHQ04vaDhwCkrEO6zIJXx9MdweUMjgcnUWEAM2yg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1y9A7frDg6m+ZnKPFb9TShXOx4RG0khLRqQgg1mjxZTm+cQe/
	9S0tqwDKjnluCVqZbiL6OhJ5n5Jd693mHPNzdpEVqEUOVL1RCiBogeEIU2zBYpzS2VqSgYBpqZI
	mQlHSDZk7uaJQ8NsoaLAyx3+8tOYIi6uLfnQAYeoDDyfKoYDLcgxW
X-Gm-Gg: ASbGnct2YEkVH4r5mBRsD0CwxoXmPDIAWOOGU3/ECP5V8pMThsHE6A4BVUd8+uaReo+
	+Rezk8RPOA3hkH23FvUuUEzqOPnBfN5BET4JmGPOxnfuuW5YxYTolU9bBVH+mGSVPJhY/Y81upM
	Y2qliuVCC2+3Y0sRoXII047w==
X-Google-Smtp-Source: AGHT+IG84lvI3gcXlEPRkJRlkOu8tneyZgmJwr3mqViY4ItysXFcNimZTO7gtwpNKCM01C6d/tdsOPRrFemjcCrBnfs=
X-Received: by 2002:aa7:cfd6:0:b0:5ec:13d0:4505 with SMTP id
 4fb4d7f45d1cf-5f3ea1e2b1dmr6826a12.5.1744405959793; Fri, 11 Apr 2025 14:12:39
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331082251.3171276-1-xin@zytor.com> <20250331082251.3171276-11-xin@zytor.com>
 <Z_hTI8ywa3rTxFaz@google.com>
In-Reply-To: <Z_hTI8ywa3rTxFaz@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Fri, 11 Apr 2025 14:12:27 -0700
X-Gm-Features: ATxdqUHkE9VKKw2s7zj6-Bzo7sFhtVG2VPQmJwr2UovOBmetGvqQ1ElvaKggsjw
Message-ID: <CALMp9eRJkzA2YXf1Dfxt3ONP+P9aTA=WPraOPJPJ6C6j677+6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v1 10/15] KVM: VMX: Use WRMSRNS or its immediate form
 when available
To: Sean Christopherson <seanjc@google.com>
Cc: "Xin Li (Intel)" <xin@zytor.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-edac@vger.kernel.org, 
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, jgross@suse.com, 
	andrew.cooper3@citrix.com, peterz@infradead.org, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, wei.liu@kernel.org, ajay.kaher@broadcom.com, 
	alexey.amakhalov@broadcom.com, bcm-kernel-feedback-list@broadcom.com, 
	tony.luck@intel.com, pbonzini@redhat.com, vkuznets@redhat.com, 
	luto@kernel.org, boris.ostrovsky@oracle.com, kys@microsoft.com, 
	haiyangz@microsoft.com, decui@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 4:24=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Mon, Mar 31, 2025, Xin Li (Intel) wrote:
> > Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> > ---
> >  arch/x86/include/asm/msr-index.h |  6 ++++++
> >  arch/x86/kvm/vmx/vmenter.S       | 28 ++++++++++++++++++++++++----
> >  2 files changed, 30 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/ms=
r-index.h
> > index e6134ef2263d..04244c3ba374 100644
> > --- a/arch/x86/include/asm/msr-index.h
> > +++ b/arch/x86/include/asm/msr-index.h
> > @@ -1226,4 +1226,10 @@
> >                                               * a #GP
> >                                               */
> >
> > +/* Instruction opcode for WRMSRNS supported in binutils >=3D 2.40 */
> > +#define ASM_WRMSRNS          _ASM_BYTES(0x0f,0x01,0xc6)
> > +
> > +/* Instruction opcode for the immediate form RDMSR/WRMSRNS */
> > +#define ASM_WRMSRNS_RAX              _ASM_BYTES(0xc4,0xe7,0x7a,0xf6,0x=
c0)
> > +
> >  #endif /* _ASM_X86_MSR_INDEX_H */
> > diff --git a/arch/x86/kvm/vmx/vmenter.S b/arch/x86/kvm/vmx/vmenter.S
> > index f6986dee6f8c..9fae43723c44 100644
> > --- a/arch/x86/kvm/vmx/vmenter.S
> > +++ b/arch/x86/kvm/vmx/vmenter.S
> > @@ -64,6 +64,29 @@
> >       RET
> >  .endm
> >
> > +/*
> > + * Write EAX to MSR_IA32_SPEC_CTRL.
> > + *
> > + * Choose the best WRMSR instruction based on availability.
> > + *
> > + * Replace with 'wrmsrns' and 'wrmsrns %rax, $MSR_IA32_SPEC_CTRL' once=
 binutils support them.
> > + */
> > +.macro WRITE_EAX_TO_MSR_IA32_SPEC_CTRL
> > +     ALTERNATIVE_2 __stringify(mov $MSR_IA32_SPEC_CTRL, %ecx;         =
       \
> > +                               xor %edx, %edx;                        =
       \
> > +                               mov %edi, %eax;                        =
       \
> > +                               ds wrmsr),                             =
       \
> > +                   __stringify(mov $MSR_IA32_SPEC_CTRL, %ecx;         =
       \
> > +                               xor %edx, %edx;                        =
       \
> > +                               mov %edi, %eax;                        =
       \
> > +                               ASM_WRMSRNS),                          =
       \
> > +                   X86_FEATURE_WRMSRNS,                               =
       \
> > +                   __stringify(xor %_ASM_AX, %_ASM_AX;                =
       \
> > +                               mov %edi, %eax;                        =
       \
> > +                               ASM_WRMSRNS_RAX; .long MSR_IA32_SPEC_CT=
RL),   \
> > +                   X86_FEATURE_MSR_IMM
> > +.endm
>
> This is quite hideous.  I have no objection to optimizing __vmx_vcpu_run(=
), but
> I would much prefer that a macro like this live in generic code, and that=
 it be
> generic.  It should be easy enough to provide an assembly friendly equiva=
lent to
> __native_wrmsr_constant().

Surely, any CPU that has WRMSRNS also supports "Virtualize
IA32_SPEC_CTRL," right? Shouldn't we be using that feature rather than
swapping host and guest values with some form of WRMSR?

> > +
> >  .section .noinstr.text, "ax"
> >
> >  /**
> > @@ -123,10 +146,7 @@ SYM_FUNC_START(__vmx_vcpu_run)
> >       movl PER_CPU_VAR(x86_spec_ctrl_current), %esi
> >       cmp %edi, %esi
> >       je .Lspec_ctrl_done
> > -     mov $MSR_IA32_SPEC_CTRL, %ecx
> > -     xor %edx, %edx
> > -     mov %edi, %eax
> > -     wrmsr
> > +     WRITE_EAX_TO_MSR_IA32_SPEC_CTRL
> >
> >  .Lspec_ctrl_done:
> >
> > --
> > 2.49.0
> >
>

