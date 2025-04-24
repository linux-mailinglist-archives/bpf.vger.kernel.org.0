Return-Path: <bpf+bounces-56645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A597A9BA29
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 23:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645B54C03B3
	for <lists+bpf@lfdr.de>; Thu, 24 Apr 2025 21:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A09F21ADCC;
	Thu, 24 Apr 2025 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg9qp7L1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507A0194A67
	for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745531470; cv=none; b=Y5uTTmkXTvvvgyWqMA87xechkjD3U2nii2jjvVO5kqFnG3jb545IR7UzchtvKPVTxEVKn9dFSZPi9O4xrbob1vHns5FHJbblHCLFuJJ0Tw4wQ1iTA/L/HWnnqyufkmx3Oyuq6MRtoHu/FBVbFfjbPkTs6+jiCmRx/bt+wf5d+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745531470; c=relaxed/simple;
	bh=iQ/06uIIhR3SWq9qWBtcTkbTzpbW9qgixaSfn9SZvPo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Z+o6sAiKFKLTHIqyMHRXlxCQD9dCYOXowyTR4gS/OZX90SXl6sltVfosp9ZLeA1p0N9yPwkZ19Su9hVHvL+H1ma5EAHTs2coXWR9vVMdIU6mh79qxjR4pgmdm4DN/n1U1vfHqVIycSHBOn9KSU65VJ3Nd69Z4FcyDRgeWdwkES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lg9qp7L1; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c9376c4bddso178226785a.3
        for <bpf@vger.kernel.org>; Thu, 24 Apr 2025 14:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745531468; x=1746136268; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hXd5/8YF2bBHQedEJV5Rp3LMWb36BqWmBBLcLTs66ts=;
        b=Lg9qp7L1Rc4wrHUh95Q9Mkul0t18cUNr41S25i3cfuY7QwnaP5SxjXJ2CzqnRtJBO8
         L8RQcXS2MtYYUe1/rQ17EBTkcL3k/tyUDfa1tAQY/Y5wBOhOdPA4ExO4Gu1S3VJsvyHF
         QUHv6OzGeGDRSlQryERB/frYXhncUIhbveyQYBZqgswtBToCpuxRQ47+M/zyUrd87sto
         CadVUzeal+czQ/o9xtZ7dgXKfl2rUicWDe/hZHuvpS39nL0nlc9bkMu7ETD266MBNn9C
         nTHPrqY4vGwSIJOED3SM1sZ7HF8If+ePRZk2GbWAsSvuuZOY5n71Cb8aWLioby1xxg0J
         oFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745531468; x=1746136268;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXd5/8YF2bBHQedEJV5Rp3LMWb36BqWmBBLcLTs66ts=;
        b=PEgYGi3EBwb0IT2jvDzcYcA4y0REamotcZdqt3ah1QP6Dd4U3gOy9nBTCVUrIF+jv7
         E1qVPaF/vzf9W8yavKKQnooullOLeCjAjecLAzfahs+Pdff/Y8hC7zTwYGFZk5TIkwfX
         rjNFq2c5rKYtsXL/9NCc7S/4jH14dP2zawliUDJ4Xi+pHKcVuMkv/OY964UVtwAL+W7r
         W69mDe/sBmsFOIEZzvJXhkxEzpkHSPrJuzhmYUxIiTdt2ft3WFt5qGTvfVWEpkmjz1ev
         VnkV1M+hfoZhOnX4SZEGb4csQtXEMe3mHJ0Ba2uQqTcd/TKM5oq/k0Sta+GEoYesQwz1
         PGDA==
X-Gm-Message-State: AOJu0YztWeiDz5Bfzya4Y6fMo2yn/nBQAG+llohcYaO5SVlI9M7mErRK
	pcgGOASvTBaHsPkKlK+YsXQC+r+/GTY/vx29B0T6LujaIaQNqApONCiwgewgKX5kOT849jssW2q
	mUQ1twukBtzaryYHb/ecRn2WpDSdiPXST
X-Gm-Gg: ASbGnctG6wN++d1LKY67/DsxDhUE2OO6ICm4s/x2GmqcnzRPYrb9USqGE4UIfP2DIer
	qifcq21M0mkMCOcwaFCUvqZuNjJmdwpCW5pIh+/R/mbEjPRVsDNdvObqjotpUBxP+79S838RC97
	FUje3oNCK02mTKuPHkNT1CBQ==
X-Google-Smtp-Source: AGHT+IHysK7j294n3TnXlMesJEeXtGnosg6w95ubh3XILaorGa55qwC6TacyBkL7JlvHOIkIyNtvSmDFW4FcRTHbuT4=
X-Received: by 2002:a05:620a:3948:b0:7c5:9c13:2858 with SMTP id
 af79cd13be357-7c96053f2admr27303785a.0.1745531467953; Thu, 24 Apr 2025
 14:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Andrei Matei <andreimatei1@gmail.com>
Date: Thu, 24 Apr 2025 17:50:57 -0400
X-Gm-Features: ATxdqUE8B95PHqoT-VUFEpkS3xy5Oprec65e5vrUpGerVduVgt0hOPi3Fo-OorI
Message-ID: <CABWLsevi-OFJ3+K2W1RcTpm8wkHPgOrqHF5TCij4HhyY=vjEVQ@mail.gmail.com>
Subject: BUG: bpf_loop with limit 0 interacts badly with dead code elimination
 causing assertion failure
To: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hello bpf,

I've hit a verifier bug that sometimes prevents the loading of a program
containing a bpf_loop(0, callback,...) - a loop executing zero times. I've
debugged and understood the issue, but I'd like to request suggestions for a
fix.

Some such programs fail to load with no good error printed in the verifier
logs, and with something like the following printed (WARN_ONCE) in the kernel
log:
verifier bug. No program starts at insn 34

I have spent a good deal of time understanding the issue; it turns out it's
superficially pretty simple. The problem is that, because the looping limit is
0, the verifier never jumps to the callback subprogram (the code in [2] simply
considers that the loop limit is reached immediately and it doesn't push the
callback for verification), and so the dead code elimination phase removes the
respective subprogram.  However, the BPF_PSEUDO_FUNC instruction (loading the
callback offset into a register) is left alone (and so it is now referencing a
dangling instruction offset). A subsequent pass over the instructions (in
jit_subprogs) gets confused by this, as it asserts that all the BPF_PSEUDO_FUNC
instructions reference offsets that actually correspond to the start of a
program (the assertion is [1]).


FWIW, a bpf_loop() with a limit of zero might seem dubious but, in our case, it
happened because we generate the BPF code (so, the limit is not always 0).

I would like to submit a patch fixing this, but I'm not sure about what the
best fix is. I suspect we can relax the assertion / have jit_subprogs()
recognize this case of a dangling BPF_PSEUDO_FUNC and ignore it. But I can't
tell very clearly what the point of this pass over the instructions in
jit_subprogs() is exactly, and what the conventions around what insn->off and
insn->imm need to be set to.

Alternatively, perhaps we could keep track of subprograms that were eliminated
because they were dead, and keep the assertion alive...

I would kindly take suggestions about what to do.

The bug can be triggered with this simple program:


#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

// A dummy function so that loop_callback, which gets eliminated, is not the
// first subprogram; the repro does not work if it is.
__attribute__((noinline))
__attribute__((optnone))
static int dummy(u32 i)
{
    return i+42;
}

static int loop_callback(__u32 index, u32 *key)
{
    return 1;
}

SEC("tracepoint")
int entrypoint(__attribute__((unused)) void* ctx) {
    u32 key = dummy(0);
    bpf_loop(0, loop_callback, &key, 0);
    return 0;
}


Any thoughts about what the fix should be?

Thanks!

- Andrei


[1] https://github.com/torvalds/linux/blob/02ddfb981de88a2c15621115dd7be2431252c568/kernel/bpf/verifier.c#L21044
[2] https://github.com/torvalds/linux/blob/02ddfb981de88a2c15621115dd7be2431252c568/kernel/bpf/verifier.c#L11440

