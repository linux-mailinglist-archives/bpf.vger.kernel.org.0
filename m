Return-Path: <bpf+bounces-45509-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9439D69D2
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA1AB21973
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2024 15:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41B043AD2;
	Sat, 23 Nov 2024 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0JAxPc8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A3444384;
	Sat, 23 Nov 2024 15:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377460; cv=none; b=hglcRdaxlHXtYCzoZvZiaTSm4Zwhk0sT31WipvD7XtjKN8E6CDrfUxoczZplEpemtsoILRnQLmppFcbzJGKbwkoROvZNuX40TW1vnLXk7LZHwn5dWy47xGAYuLMYwKq6cQbsrBL1V6Dd5mQAuZPchTFtze4mOtsEEFUe7JkpdcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377460; c=relaxed/simple;
	bh=hwWmkgrcAPGWl+ptMm1tghlsH4kqOvd4DTCxLptzDFk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=jYtBgmoXUvrDLxfCw+O46F9CSZuoAt68jbX5JSV+Lb8batGgsIaLTkWiRuiimQoH4YVP3OcaZ3qxFMFhsXtdhW6yuRrcQG4fxe0C3B+LZhgkrvhXVFhkbz5tP8hYPezW2oM78DWZbPgA9tR3PmEWhXkscsM+FWSlLKFvxul+LwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0JAxPc8; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-724f41d520cso327734b3a.1;
        Sat, 23 Nov 2024 07:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732377458; x=1732982258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7GR/93q8vbl1Y02szPjwXhKCJRJHqZnIo22AIrKeYk=;
        b=W0JAxPc8jW4/y03ClGxaLgtyeymOx/qCFxQlV3LMRfgvF6oIZn0rfnoEvLLeG4znHz
         p5XZt9OoBFDM7ktZFbecSkqZgrKvwSw6YrWXCtGEnaYpHjn0SgEJNu5OhMHxj2n9RV7N
         gJbTgcU0OSbrRLdqaCpjWxWepBZWMkjzHjgRovN/1RzI8J0HBbHMZU6iQZC4ng1SCYhR
         FWCKporArBWWsmoGwbQmKzjdBo268Oyg7V4oN1yeoKaHxVtfOVAi2ZdXcwokTmYbjj79
         TDj9nkNV6xRtzgc97AX7g4Dd2fPIqAj7vOo1ZD8Ly1WKTsy1tknbI1Xr+hSe9ZGDaKHF
         jyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732377458; x=1732982258;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B7GR/93q8vbl1Y02szPjwXhKCJRJHqZnIo22AIrKeYk=;
        b=tc2GUTjoej6uo+PQpsfdgBcHol+dLI2/P7xNMkxfJocxFglXGxjxmQBweaZ+/T7YrA
         3yaWxSu6Rn/5fpL22KRIvPtObLTBGkWC/PX8QdWBbytIEcZHI4BrxXnnAU4IRKIXlKOl
         X4N5Sp19dIQPlxqqLydcLClkRQnbfasJFJT3wOdRt9ADfQtGiqdLHz8NqWjikt/4Q1ZP
         6+/hCD+JLW6iB81zwLib9NiEvRHq7WdhdpCdxOwmz6pL5/byNLcwGpK/APmOxMuQJ4vZ
         ba3wvQ4TJHKsGtmiwDbxwB/28Fdojb0HWTuFLUJsN6eM0rOSuIE+0HMa8Up23B9w5SKP
         Ugbg==
X-Forwarded-Encrypted: i=1; AJvYcCV8JeC8F0oqzI5o5XOPq5tDeaceXlMysF9i/BwQ6n9BD/SeW3QtVYZOzbkaho3HAjbRkhStKWzZFYdq53K8@vger.kernel.org, AJvYcCVzbxMmr95F35fsLC5JyODeYD52Q8JdUQKOn0+N0NHkYCtiOBKmZVyLN0kyQXlYCkm0aNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm14QlX0Vv32RJOUtuaeq4LCScnKbLxne4sC9qyEgd4ysa7tVK
	CI5nPH6+wY0izp9FTQZcj8gKTS8si55r6JrqxESdYi8b/Bi/7314WSje1g==
X-Gm-Gg: ASbGncvwwh6g2DlyvNHM5WAUBu8Ur+zAZwBDxD+Nkh3ccHfbqYkE0eJZVLZG5re0QJQ
	ErR3+XsNOeC4F3fFIZE+w7Tk4Pm8wJg6HRB4ox/tF6Pel1bZxv+QC3BExrj5YXIf4/4pVHJYKTw
	54TLrH/YnAJSB2KbsWWgWz/lF+uCl+E7J+Fh3cW/WQVeq/lL1Eh5dFumZzEkERgX9+p4gcYzcEZ
	S1vMw3YabL42M5Zi0lQ2Z5Ji/WD4iZeT+8LokHkjrSUFm+LKbE=
X-Google-Smtp-Source: AGHT+IFMJCfOvYOEF4yxWvSC12dnHHtF5pdzV67OyIXKQZXcx/OHeGlHJ4q3kn0LfBDukmlj77ZR/Q==
X-Received: by 2002:a05:6a00:10c8:b0:71e:47a2:676 with SMTP id d2e1a72fcca58-724df5d58ffmr9258267b3a.6.1732377456687;
        Sat, 23 Nov 2024 07:57:36 -0800 (PST)
Received: from localhost ([98.97.42.159])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de5762bfsm3505538b3a.184.2024.11.23.07.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 07:57:35 -0800 (PST)
Date: Sat, 23 Nov 2024 07:57:32 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev, 
 bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <6741fb6c516cc_c6be20839@john.notmuch>
In-Reply-To: <4f6c74e0-dd22-8460-96fa-f408291a3ef8@loongson.cn>
References: <20241119065230.19157-1-yangtiezhu@loongson.cn>
 <673fd322ce3ac_1118208b3@john.notmuch>
 <4f6c74e0-dd22-8460-96fa-f408291a3ef8@loongson.cn>
Subject: Re: [PATCH] LoongArch: BPF: Sign-extend return values
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tiezhu Yang wrote:
> On 11/22/2024 08:41 AM, John Fastabend wrote:
> > Tiezhu Yang wrote:
> >> (1) Description of Problem:
> >>
> >> When testing BPF JIT with the latest compiler toolchains on LoongArch,
> >> there exist some strange failed test cases, dmesg shows something like
> >> this:
> >>
> >>   # dmesg -t | grep FAIL | head -1
> >>   ... ret -3 != -3 (0xfffffffd != 0xfffffffd)FAIL ...
> 
> ...
> 
> >>
> >> (5) Final Solution:
> >>
> >> Keep a5 zero-extended, but explicitly sign-extend a0 (which is used
> >> outside BPF land). Because libbpf currently defines the return value
> >> of an ebpf program as a 32-bit unsigned integer, just use addi.w to
> >> extend bit 31 into bits 63 through 32 of a5 to a0. This is similar
> >> with commit 2f1b0d3d7331 ("riscv, bpf: Sign-extend return values").
> >>
> >> Fixes: 5dc615520c4d ("LoongArch: Add BPF JIT support")
> >> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> >> ---
> >>  arch/loongarch/net/bpf_jit.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> >> index 7dbefd4ba210..dd350cba1252 100644
> >> --- a/arch/loongarch/net/bpf_jit.c
> >> +++ b/arch/loongarch/net/bpf_jit.c
> >> @@ -179,7 +179,7 @@ static void __build_epilogue(struct jit_ctx *ctx, bool is_tail_call)
> >>
> >>  	if (!is_tail_call) {
> >>  		/* Set return value */
> >> -		move_reg(ctx, LOONGARCH_GPR_A0, regmap[BPF_REG_0]);
> >> +		emit_insn(ctx, addiw, LOONGARCH_GPR_A0, regmap[BPF_REG_0], 0);
> >
> > Not overly familiar with this JIT but just to check this wont be used
> > for BPF 2 BPF calls correct?
> 
> I am not sure I understand your comment correctly, but with and without
> this patch, the LoongArch JIT uses a5 as a dedicated register for BPF
> return values, a5 is kept as zero-extended for bpf2bpf, just make a0
> (which is used outside BPF land) as sign-extend, all of the test cases
> in test_bpf.ko passed with "echo 1 > /proc/sys/net/core/bpf_jit_enable".
> 
> Thanks,
> Tiezhu
> 

Got it.

Acked-by: John Fastabend <john.fastabend@gmail.com>

