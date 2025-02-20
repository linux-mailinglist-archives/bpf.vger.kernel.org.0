Return-Path: <bpf+bounces-52088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0692A3DEFE
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 16:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B889189E70B
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 15:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7695A1FCCE4;
	Thu, 20 Feb 2025 15:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mu3uddHX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com [209.85.208.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A04B1F8916
	for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066147; cv=none; b=Ka689CpmZJDW5GQTUBrk1EcGr5dCRZtaCssJsMPzmo+2uJQNrtMq10Rncu0hcdni36mG6FfVUw8arVJvzuJYkc6eTVr1dH3p6WHkPqOq4iLji9KBCaPtq6/yPOFcsNEDj8liZEJFQR+sYPSO8sWPazsd4ydSL249MeToL0Kmnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066147; c=relaxed/simple;
	bh=lJqVTPXS/PMus/mkPkkwae2uKdpP4+cvQNUmJy8DQxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h5+0rB1T8C5k+eR6otvRUfY+nr23jJUz4pv5Uvq6LN172LKrF/PqOqKpod2qlazDa/e7WYgQ7npHpyF/edHgqij41h1LAX/b0ec3nSylw5u+bsRMEjhpzciF+4Utcpt4pTXPlXvWmY8UdxECQ6KMax5quJb6WiH5l7LpswA1Ejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mu3uddHX; arc=none smtp.client-ip=209.85.208.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f68.google.com with SMTP id 4fb4d7f45d1cf-5e02eba02e8so1453865a12.0
        for <bpf@vger.kernel.org>; Thu, 20 Feb 2025 07:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740066143; x=1740670943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/qUrw1u5qyEWxYSnWHHVvrAqgvx2DQyUbjXCyDtvoW4=;
        b=Mu3uddHXDq0s4FgU2AsHjll5AMjBTeMnvpe73mxa2McMRzbkeqPYCVuliAJJ8Vx7kf
         GzhC7VmCqSxkUjOCm7uhkwvHLFfGyEwcJvDF5+EJcSnqLju3pg5uBQeLlfDn3Zj/9Eqs
         jIWUpFXU1fsTHT7ED8bH00yNN9KxT/skCNEaDFPog3DCrMbIY6fUO68Rbho6RURLlv16
         gPJ3NDGxBF+Ki3Z/g0vmKGJTiXRzu6Z3+6wuYZlXIaWfXahUH5A2tYheZJ4eaVye98tA
         8T3fy7LjhbrxAgJ+ELhMwmZZ0Sp/+c8mfFLMqBUfksFkp2lhm3y1WAPhKUGJdqG8uEqd
         JuoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740066143; x=1740670943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/qUrw1u5qyEWxYSnWHHVvrAqgvx2DQyUbjXCyDtvoW4=;
        b=pNH9NblgkiiTSyAw4KSRRjq9R0whtNuJLA5T6iApAlhEGjbFlJ5J6c4grF0Z/r5C3E
         sk8GO4VCcx6tTzVcP6KY7xXGPplcKIX0cSZbIadxOl5Ls93/qoiey8toKJ0DGHb56Zx5
         JvXGtg0t/N/d6NlivEfBmvD/Zn5qkQblUDVN3zdGWDep1CXYX4M+b3an59Tw1MAayQTR
         XAB3rINwYar30XkiNIwy8+w9TOIoH3jsQvUHfOIclzzcdOc5X8Rk2O8OK2e0U1SZlszR
         6gP2Yo0vP9jvn5nkJBxdGdENJ+p/4WKO7VZGkU2RtR75SixdhX0X1xrYC0WJyKM5VeFM
         OKrQ==
X-Gm-Message-State: AOJu0Yxrdb4WapcI3YfwyZYN9aEBHp04hVg0rDZsE8y9sPV2cngkqI2I
	YEjzdag1H79ZIV5okxIIkbGIvx9/RI+n9vws/XsUNWJCzEOSEMWPhIS2bozzKRBKp6JW4SKqIvy
	iHy+ku5zhhJDUkyUgPmY9LgpjPpY=
X-Gm-Gg: ASbGncsMK7KTrz2bzkUZfWoTUyxOGH+fccob2mDKgQ9/fYvDwbSzIo25T5RkJ01WZkr
	BI+lvgo+6WAlIHge87XyTvm/JumBp9DY9l0xeqxd86Sk27b+YLs/W15TM0eLwEOpgWNRIBmgxO1
	O8b90eTp4Spa36JAs6MQ==
X-Google-Smtp-Source: AGHT+IESvZ8AERUz6J4T4gAJXeDCxC7PhJoQ0xtpHh6zog4MrO05Kn3zoJ7K9okPwvcbt7IMaKF/fffJPmzon27T1mg=
X-Received: by 2002:a05:6402:3509:b0:5de:3c29:e835 with SMTP id
 4fb4d7f45d1cf-5e089f3088emr8463258a12.29.1740066141932; Thu, 20 Feb 2025
 07:42:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219125117.1956939-1-memxor@gmail.com> <20250219125117.1956939-3-memxor@gmail.com>
 <a6c6f04bb895c817c0ae06ba8a7f5b05ec3cad2e.camel@gmail.com>
In-Reply-To: <a6c6f04bb895c817c0ae06ba8a7f5b05ec3cad2e.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 20 Feb 2025 16:41:45 +0100
X-Gm-Features: AWEUYZkk2x5jpiwYhqMwo_MPOlD6ghDjIxiTNvBZCIQOQX1YVqgXdK8OjDbLIus
Message-ID: <CAP01T77ZnEFV-NE7QAdVcLu5nP4uM0hn_kYd8X0vWuek3feEtQ@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v1 2/2] selftests/bpf: Add selftest for
 bpf_dynptr_slice_rdwr r0 handling
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Feb 2025 at 21:34, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2025-02-19 at 04:51 -0800, Kumar Kartikeya Dwivedi wrote:
> > Ensure that once we get the return value and write to a stack slot it
> > may potentially alias, we don't get confused about the state of the
> > stack. Without the fix in the previous patch, we will assume the load
> > from r8 into r0 before will always be from a map value, but in the case
> > where the returned value is the passed in buffer, we're writing to fp-8
> > and will overwrite the map value stored there.
> >
> > Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > ---
> >  .../testing/selftests/bpf/progs/dynptr_fail.c | 45 +++++++++++++++++++
> >  1 file changed, 45 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > index bd8f15229f5c..4584bf53c5f8 100644
> > --- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > +++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
> > @@ -1735,3 +1735,48 @@ int test_dynptr_reg_type(void *ctx)
> >       global_call_bpf_dynptr((const struct bpf_dynptr *)current);
> >       return 0;
> >  }
> > +
> > +SEC("?tc")
> > +__failure __msg("R8 invalid mem access 'scalar'") __log_level(2)
> > +int dynptr_slice_rdwr_overwrite(struct __sk_buff *ctx)
> > +{
> > +     asm volatile (
>
> Nit: having a few comments with equivalent C code would help
>      understand this test case.

Ack.

>
> > +             "r6 = %[array_map4] ll;                 \
> > +              r9 = r1;                               \
> > +              r1 = r6;                               \
> > +              r2 = r10;                              \
> > +              r2 += -8;                              \
> > +              call %[bpf_map_lookup_elem];           \
> > +              if r0 == 0 goto rjmp1;                 \
> > +              *(u64 *)(r10 - 8) = r0;                \
> > +              r8 = r0;                               \
> > +              r1 = r9;                               \
> > +              r2 = 0;                                \
> > +              r3 = r10;                              \
> > +              r3 += -24;                             \
> > +              call %[bpf_dynptr_from_skb];           \
> > +              r1 = r10;                              \
> > +              r1 += -24;                             \
> > +              r2 = 0;                                \
> > +              r3 = r10;                              \
> > +              r3 += -8;                              \
> > +              r4 = 8;                                \
> > +              call %[bpf_dynptr_slice_rdwr];         \
> > +              if r0 == 0 goto rjmp1;                 \
> > +              r1 = 0;                                \
> > +              *(u64 *)(r10 - 8) = r8;                \
> > +              *(u64 *)(r0 + 0) = r1;                 \
> > +              r8 = *(u64 *)(r10 - 8);                \
> > +              r0 = *(u64 *)(r8 + 0);                 \
> > +     rjmp1:                                          \
>
> Note: 'rjmp1' would be a global label.
>       An alternative would be to either use 'goto 1f' and label '1:',
>       or use the '%=' counter: 'goto rjmp1_%=', 'rjmp_%=:'.
>       These would make label names unique for this inline assembly block.
>       See https://gcc.gnu.org/onlinedocs/gcc/Extended-Asm.html#Special-format-strings ,
>       And https://sourceware.org/binutils/docs/as/Symbol-Names.html .
>

Thanks for the tip, will fix.

> > +              r0 = 0;                                \
> > +              "
> > +             :
> > +             : __imm(bpf_map_lookup_elem),
> > +               __imm(bpf_dynptr_from_skb),
> > +               __imm(bpf_dynptr_slice_rdwr),
> > +               __imm_addr(array_map4)
> > +             : __clobber_all
> > +     );
> > +     return 0;
> > +}
>
>

