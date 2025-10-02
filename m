Return-Path: <bpf+bounces-70231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 916CFBB4F4F
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 21:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24B93254F0
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A1255F28;
	Thu,  2 Oct 2025 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nd8jOs9L"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B78334BA40
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759431655; cv=none; b=Bzb2H4VEVw+geoHyPslIs1Nd5wjvK4lVaQccr11ANbByducqlsZvLQafBw9NpYmEBLA0VZQRSG0MCEUXRwnbx+dcTxGAemJ7rOEBr6G1tlQswqUmDti7hMXVY3j/fKVlJDXeYCCgLy4eKdn2DRiQTSrI8ZEVGd6gzN4y1FmuvWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759431655; c=relaxed/simple;
	bh=HdRM6QtSEu6oISwiLRqfnMz+LiKeMqQ1/pBIxbMP6TM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hPmD5hxF7bYWOzzaC6CFcKPs+lYgwwh2duhgx+7Y66dl3Pc/mRSnRE2WYLdu9YLZMZ99zQ88s+l6tQleIaTdASYSyJnni456D/EaIj8I+gq9YV+ci0JlU1GAWXU+6CBvhZm89bV0ghRydeFqRBmJfWPuAdL+/HaY7kVAuqbYQlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nd8jOs9L; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso9952475e9.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759431651; x=1760036451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6fOaFPX2oAXf2qf/MzKaSamzMn6vecX7vKZ+f0WXRk=;
        b=Nd8jOs9LmfZos29FOCxMlZejNqkZstiaNoGsS2kxj5kRpcHOM9+HMVvBxTapHaZyQ4
         01E1MSfcixlF7b/bVw4Bfhz9g4kV7eC5oE6vHs0EK0+9By2NdPXkSi1q7n3WCpMcgHPI
         B4+iMVq3bVOocKFxp/4UGdwFVFffpWMuvVhKMOo+iLBwMWAaSnYLOQNeRq+k5jjBHCn7
         iGalhbV4UVfcGkpgc1g7dixm+w/V2PZwnrYZHlESiFge1X8bo/RF6LCOgTToYh/5NKHY
         KJJaxh+VJPDdFFmVtIUriBz8TqCbemTUJjhdjtQtDCmtGCM0amGJKo3xPJrVPTYSaWeb
         ClEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759431651; x=1760036451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6fOaFPX2oAXf2qf/MzKaSamzMn6vecX7vKZ+f0WXRk=;
        b=JxnV+LDb2h1hh3XlfjBc+no4EdfKU5uSn5m6RJuhrmKjkwZ9hx4unIEVQTnJdfRm/S
         ulfpgX1BeE62oI0zFYsejAtJ/AAu8FVYrXAzsDRwZ5+oBpMHt0u7rmKcmG/zMsXTpRG5
         qVnjisDZmIbSQQ7hWtH/SOsk0VHI8NTRZvsQdwnCRe4K4gAKLk+XNmv84zZ7N6XV4gLT
         LPTwaJBy8sH9dvo3yFTcm3Jv+Z77PiFRc3ka3dy4Vv6oLcSDQcLJQz3g2ieXe5ZlkvFZ
         VOIRjrBrpPx5wHXwP5hEqQdWpVkv2rWu6h8haDIaVRyOdFYrfI097x7OARBuJnTEk6gl
         yafg==
X-Forwarded-Encrypted: i=1; AJvYcCU+R0+FUpXvG0f6X4dydhH0L5Av1C6IN+lJ+OCN4GXLD7v8uFauVg4UheM0V3LZo/8pCuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKT4WBsivWFUe1f0jsHnuPUGzdJQVvyOAwyswXeWSXMaw8QvW3
	7ELpgGYkuChxQtjrsAKpueoP9zNfm1EebFY8WI8D9QSNRQNZ69LcOt3G
X-Gm-Gg: ASbGncuZAgxIxQG4fpK7NrxMzPDNQCz2ePO4a8eyIO5kwjnMEIQBZ7q9RRmEWjLxjMk
	l2y+AKeIAI0seweNcY/IeAWt8B1HX0we4dsZUyPIT5/FEELXBlkgajAupKhllzgCDTFadoYH/Xj
	pBa2rBfz8NQbsmLLp04LwiMqFP812jp0/fQxGfxXtu2up4Pi8kc3c+mbpfiCtOpc7cxZ5RtjQfJ
	TCPulVxwF4z/BP3qweJNTqlRQKjLiaiUY5UUXXP5jEVZqcrvD9E3veVtNWDw1BEGTfQAHhjEvdc
	90fJE5Dar2ShgeFveoQihQasoTd60jQ/fya4B24U0JccXWqiIBxHytUcgKCSaecB3xin6fdf03K
	MkuZHCyzVtP7hCOPa4p9/7sA+ndk2JOwwH2Z0j4KRSc23UgYr5YWWXHXx/4zsGiWJL71wQv2GhL
	TBWjNYwT/HVwFD
X-Google-Smtp-Source: AGHT+IGaoHiZFJpX7P4fpJ5gN/YctPtIRaA4HuaLp2YmDRoVlK6rbZNidGIsWnYJjI0Td812wrRW+w==
X-Received: by 2002:a05:600c:83ca:b0:45d:5c71:769d with SMTP id 5b1f17b1804b1-46e70c5cef4mr4217145e9.8.1759431650257;
        Thu, 02 Oct 2025 12:00:50 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e6918bb06sm51107905e9.8.2025.10.02.12.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 12:00:49 -0700 (PDT)
Date: Thu, 2 Oct 2025 20:00:47 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 matttbe@kernel.org, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, kuba@kernel.org, hawk@kernel.org,
 linux@jordanrome.com, ameryhung@gmail.com, toke@redhat.com,
 houtao1@huawei.com, emil@etsalapatis.com, yatsenko@meta.com,
 isolodrai@meta.com, a.s.protopopov@gmail.com, dxu@dxuuu.xyz,
 memxor@gmail.com, vmalik@redhat.com, bigeasy@linutronix.de, tj@kernel.org,
 gregkh@linuxfoundation.org, paul@paul-moore.com,
 bboscaccy@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 mrpre@163.com, jakub@cloudflare.com, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com
Subject: Re: [PATCH] selftests/bpf: Add -Wsign-compare C compilation flag
Message-ID: <20251002200047.2b9f9ef9@pumpkin>
In-Reply-To: <e3a0d8ff-d03d-4854-bf04-8ff8265b0257@gmail.com>
References: <20250924162408.815137-1-mehdi.benhadjkhelifa@gmail.com>
	<20250926124555.009bfcd6@pumpkin>
	<e3a0d8ff-d03d-4854-bf04-8ff8265b0257@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Sep 2025 17:03:29 +0100
Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:

> On 9/26/25 12:45 PM, David Laight wrote:
> > On Wed, 24 Sep 2025 17:23:49 +0100
> > Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> wrote:
> >   
> >> -Change all the source files and the corresponding headers
> >> to having matching sign comparisons.  
> 
> Hi david,
> sorry for the late reply.
> 
> > 'Fixing' -Wsign-compare by adding loads of casts doesn't seem right.
> > The only real way is to change all the types to unsigned ones.  
> The last v3 did only do that with no casting as it was suggested by 
> David too.
> 
> > Consider the following:
> > 	int x = read(fd, buf, len);
> > 	if (x < 0)
> > 		return -1;
> > 	if (x > sizeof (struct fubar))
> > 		return -1;
> > That will generate a 'sign-compare' error, but min(x, sizeof (struct fubar))
> > doesn't generate an error because the compiler knows 'x' isn't negative.  
> 
>   Yes,-Wsign-compare does add errors with -Werror enabled in that case 
> and many other cases where the code is perfectly fine which is one of 
> it's drawbacks.
> Also I though that because of GCC/Clang heuristics 
> sometimes min() suppress the warning not because that the compiler knows 
> that x isn't negative.I'm probably wrong here.

That sentence doesn't make sense.
The statically_true() test in min() uses the 'value' tracking done by modern
versions of gcc and clang.
This means it can let signed types be promoted to unsigned ones because the
compiler knows the value isn't negative.
OTOH -Wsign-compare is a much older warning and is only based on the types.

> > A well known compiler also rejects:
> > 	unsigned char a;
> > 	unsigned int b;
> > 	if (b > a)
> > 		return;
> > because 'a' is promoted to 'signed int' before it does the check.  
> 
> In my knowledge,compilers don't necessarily reject the above code by 
> default. Since -Wall in GCC includes -Wsign-compare but -Wall in clang 
> doesn't, doing -Wall -Werror for clang compiler won't trigger an error 
> in the case above not even a warning.My changes are to make those 
> comparisons produce an error since the -Werror flag is already enabled 
> in the Makefile.

This isn't about whether -Wsign-compare is enabled or not (or even what
the option is called).
It is about whether the compiler's 'sign-compare' warning triggers for that code.
The one that detects the warning/error isn't gcc or clang but is probably
used far more than clang.

> 
> > So until the compilers start looking at the known domain of the value
> > (not just the type) I enabling -Wsign-compare' is pretty pointless.  
> 
> I agree that enabling -Wsign-compare is pretty noisy. But it does have 
> some usefulness. Take for example this code:
> 	int n = -5;
> 	for (unsigned i = 0; i < n; i++) {
>      	// ...
> 	}
> Since this is valid code by the compiler, it will allow it but n here is 
> promoted to an unsigned which converts -5 to being 4294967291 thus 
> making the loop run more than what was desired.of course,here the 
> example is much easy to follow and variables are very well set but the 
> point is that these could cause issues when hidden inside a lot of macro 
> code.

There is plenty of broken code out there.
It isn't hard to find places where explicit casts make things worse.
The problem is that, even for the above example, the -5 could come from
way earlier up the code.
If you 'fix' the warning by changing it to 'i < (unsigned)n' the code is
still just as likely to be buggy.

> 
> > As a matter of interest did you actually find any bugs?  
>
> No,I have not found any bug related to the current state of code in bpf 
> selftests but It works as a prevention mechanism for future bugs.Rather 
> than wait until something breaks in future code.

That's what I expected...

> > 	David
> >   
> 
> Thank you for your time David.I would appreciate if you suggest on how I 
> can have a useful patch on this or if I should drop this.
> Best Regards,
> Mehdi
> >   
> >>
> >> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> >> ---
> >> As suggested by the TODO, -Wsign-compare was added to the C compilation
> >> flags for the selftests/bpf/Makefile and all corresponding files in
> >> selftests and a single file under tools/lib/bpf/usdt.bpf.h have been
> >> carefully changed to account for correct sign comparisons either by
> >> explicit casting or changing the variable type.Only local variables
> >> and variables which are in limited scope have been changed in cases
> >> where it doesn't break the code.Other struct variables or global ones
> >> have left untouched to avoid other conflicts and opted to explicit
> >> casting in this case.This change will help avoid implicit type
> >> conversions and have predictable behavior.
> >>
> >> I have already compiled all bpf tests with no errors as well as the
> >> kernel and have ran all the selftests with no obvious side effects.
> >> I would like to know if it's more convinient to have all changes as
> >> a single patch like here or if it needs to be divided in some way
> >> and sent as a patch series.
> >>
> >> Best Regards,
> >> Mehdi Ben Hadj Khelifa  
> > ...  
> 


