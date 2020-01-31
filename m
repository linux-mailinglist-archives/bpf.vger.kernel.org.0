Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5CAF14E882
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2020 06:48:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgAaFsr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jan 2020 00:48:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40788 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgAaFsr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jan 2020 00:48:47 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so2272880plp.7
        for <bpf@vger.kernel.org>; Thu, 30 Jan 2020 21:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Vl3057//kuD9+fT1UrOBKJ8QnCjZLEsxMpDJJFXgd3s=;
        b=MsamroQmcwP3npX41vHn6Q10MRZexIesdYPH4FkZV3Gqirmkw55QHimCYffTolCqvG
         TDD3AolbjZ7EPn0KhMFaRwJ0v2YIwkbVeLkeDTJ4iIJaZA9TvrCa6F20Evlj2QXegCDY
         q+1Rrhj77I8tIEL1At2TjAMNK2YMb1h1R86G8Nc4rFWV66zTOQHiE151NLiklrvXDRb/
         cBXYYQLuLKNyhjwdp8HogJlpDaMUhGwKIckkHWySrphNraZ5y+lpT8cEXV/+CksAnaKO
         9vcrjQ3QWqAThMgk6/tNlrJI2vrONPUa2c82Rhw69UcOx9dO0lA2A7S5Ms6WkWbNWsbL
         OpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Vl3057//kuD9+fT1UrOBKJ8QnCjZLEsxMpDJJFXgd3s=;
        b=XMbwuYfp07S4SgsN+XR89lTccurGon5S9sSGNG+HyjCQvjCHgtUmbgZB1C35CIhyQs
         BINlGm39HmCVJAnvummP+aLeP+6xkfX8UHl/DFxLxkHRCrpDKD5vOQcnAo4hhAMrrqJY
         GHZrOOmYGsq53+cYNV4XIiVzGQbET/5PnXQLAMrqFTgzHhqrspGp9q/ZbOROkkft7OdM
         h8HbPNN+XoBr7DyXWFMnXd5tK3PZLqHQFXVQBSJkRhEN0/q5bJ7uk57VfENY2Yf89LAQ
         5TDcH1ar9V5s8Cn1bpFeK0iDnrksUDtoISbCqe1Ym6tRYRNeCGlT+CNUVv/0LGwpNeJN
         k7qg==
X-Gm-Message-State: APjAAAWVVYpT9ldrVTm8gpel4WF0dC5M8659dKXiVQ/l8KglHfJ+K9sm
        KDmazfM0cJorabcTbXfAoN0=
X-Google-Smtp-Source: APXvYqxKlzV/mVjPl3MBswPSZ9VFTbyqFa3vgR5UmEapcOVqcsys9Ws2ppwxNUMt8BoqiF7oqnAkvQ==
X-Received: by 2002:a17:902:341:: with SMTP id 59mr8870747pld.29.1580449726976;
        Thu, 30 Jan 2020 21:48:46 -0800 (PST)
Received: from localhost ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id fh24sm8373226pjb.24.2020.01.30.21.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 21:48:46 -0800 (PST)
Date:   Thu, 30 Jan 2020 21:48:38 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        John Fastabend <john.fastabend@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@kernel.org>
Message-ID: <5e33bfb6414eb_7c012b2399b465bcfe@john-XPS-13-9370.notmuch>
In-Reply-To: <20200131024620.2ctms6f2il6qss3q@ast-mbp>
References: <158015334199.28573.4940395881683556537.stgit@john-XPS-13-9370>
 <b26a97e0-6b02-db4b-03b3-58054bcb9b82@iogearbox.net>
 <CAADnVQ+YhgKLkVCsQeBmKWxfuT+4hiHAYte9Xnq8XpC8WedQXQ@mail.gmail.com>
 <99042fc3-0b02-73cb-56cd-fc9a4bfdf3ee@iogearbox.net>
 <5e320c9a30f64_2a332aadcd1385bc3f@john-XPS-13-9370.notmuch>
 <20200130000415.dwd7zn6wj7qlms7g@ast-mbp>
 <5e33147f55528_19152af196f745c460@john-XPS-13-9370.notmuch>
 <20200130175935.dauoijsxmbjpytjv@ast-mbp.dhcp.thefacebook.com>
 <5e336803b5773_752d2b0db487c5c06e@john-XPS-13-9370.notmuch>
 <20200131024620.2ctms6f2il6qss3q@ast-mbp>
Subject: Re: [bpf PATCH v3] bpf: verifier, do_refine_retval_range may clamp
 umin to 0 incorrectly
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov wrote:
> On Thu, Jan 30, 2020 at 03:34:27PM -0800, John Fastabend wrote:
> > 
> > diff --git a/llvm/lib/Target/BPF/BPFInstrInfo.td b/llvm/lib/Target/BPF/BPFInstrInfo.td
> > index 0f39294..a187103 100644
> > --- a/llvm/lib/Target/BPF/BPFInstrInfo.td
> > +++ b/llvm/lib/Target/BPF/BPFInstrInfo.td
> > @@ -733,7 +733,7 @@ def : Pat<(i64 (sext GPR32:$src)),
> >            (SRA_ri (SLL_ri (MOV_32_64 GPR32:$src), 32), 32)>;
> >  
> >  def : Pat<(i64 (zext GPR32:$src)),
> > -          (SRL_ri (SLL_ri (MOV_32_64 GPR32:$src), 32), 32)>;
> > +          (MOV_32_64 GPR32:$src)>;
> 
> That's good optimization and 32-bit zero-extend after mov32 is not x86
> specific. It's mandatory on all archs.
> 
> But I won't solve this problem. There are both signed and unsigned extensions
> in that program. The one that breaks is _singed_ one and it cannot be optimized
> into any other instruction by llvm.
> Hence the proposal to do pseudo insn for it and upgrade to uapi later.

Those are both coming from the llvm ir zext call with the above patch
there 56 and 57 are ommitted so there are no shifts. I'll check again
just to be sure and put the details in a patch for the backend.

> 
> llvm-objdump -S test_get_stack_rawtp.o
> ; usize = bpf_get_stack(ctx, raw_data, max_len, BPF_F_USER_STACK);
>       52:	85 00 00 00 43 00 00 00	call 67 
>       53:	b7 02 00 00 00 00 00 00	r2 = 0
>       54:	bc 08 00 00 00 00 00 00	w8 = w0
> ; 	if (usize < 0)
>       55:	bc 81 00 00 00 00 00 00	w1 = w8
>       56:	67 01 00 00 20 00 00 00	r1 <<= 32
>       57:	c7 01 00 00 20 00 00 00	r1 s>>= 32
>       58:	6d 12 1a 00 00 00 00 00	if r2 s> r1 goto +26 <LBB0_6>
> 56 and 57 are the shifts.

Agree it doesn't make much sense that the r1 s>>= 32 is signed to me
at the moment. I'll take a look in the morning. That fragment 55,56,
57 are coming from a zext in llvm though.

FWIW once the shifts are removed the next issue is coerce loses info
on the smax that it needs. Something like this is needed so that if
we have a tight smax_value we don't lose it to the mask.

@@ -2805,9 +2804,32 @@ static void coerce_reg_to_size(struct bpf_reg_state *reg, int size)
                reg->umax_value = mask;
        }
        reg->smin_value = reg->umin_value;
-       reg->smax_value = reg->umax_value;
+       if (reg->smax_value < 0 || reg->smax_value > reg->umax_value)
+               reg->smax_value = reg->umax_value;
+}
+

I'll write up the details in a patch once we iron out the LLVM zext
IR signed shift.


.John
