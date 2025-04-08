Return-Path: <bpf+bounces-55485-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3EEA816C3
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 22:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E7293B49E7
	for <lists+bpf@lfdr.de>; Tue,  8 Apr 2025 20:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CCC92528ED;
	Tue,  8 Apr 2025 20:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJ0LmU+x"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC9B241CA3;
	Tue,  8 Apr 2025 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744143724; cv=none; b=E/8ncXEv/weVAPvzN+kWMDvf8jES9W+2fHveskWK2t0IlmPAdElDx+8t8y98UiQVsvjk51ba/rwhLA3wyQ/yeg1zBVZBG2ftTaS2Oax8u6Adyrg8BuWbg5rMCUIdx/k3Hm+OgR/nvESBMiaaOkp9Ekbj5piUU4cI6gXNIBZ4kn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744143724; c=relaxed/simple;
	bh=umrs8nf1yHNtTlHW+5uJsZQYBs+rN/lSC5eqcpjo5J0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eMm3eELzTRYauY2mcaEa6bENMLt+lPx4f7Bnqn7uXxx5zkJXzeFPx/bDqrcsW8/pa68I/2KRYLuBI8mS7TY7vT2XwbCp+Q047HrIV7xXvQL/tTWRkRYgTa0hAbGggqbxjSzBicyqtAmZCxR15+ePfDMoeYW/dStNNrFaoFzDrXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJ0LmU+x; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac29fd22163so1045235266b.3;
        Tue, 08 Apr 2025 13:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744143721; x=1744748521; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iMt1r/F2XNN27MwBAL3KuI/cRUpPDfyeHOKGNdC7QJM=;
        b=FJ0LmU+xLqk/XDKAtqt+EnVawddlAboTK/rVKSgL+kFR4Q+LPQIk4cJblGImmbSnDV
         A9X9mXJwyIlv7T+1fdRRj13kkFu7z1+iYLGKwwc0cow5rJSZkFBmyfsme1zufkBVttfv
         S0oMI+lXGsgP2VJJD4g+3IXuoHmlOQf2VnFf05SWvK+OwcKY2UIE10wB7SljVXxAnOHs
         AWjI6iszD4g8obq/AG6+wpwRjmVYn9FlUzxIdFfMuyBKOKEQyQ08TqRKlWFI2OsDCQvF
         OY0SbG2YmCtfvUhO9aMv/Q16dIja+y8dkHjQbI3lrTm7UX8DuSwdBBa48jXEEwYuwRJF
         CQlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744143721; x=1744748521;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iMt1r/F2XNN27MwBAL3KuI/cRUpPDfyeHOKGNdC7QJM=;
        b=rLJslD44c3jkG56DQx35Wn51HpxAtNxSa0vuuKdlf33FcISy1GYABbr32fEW3cvGb5
         41iYL9dz17uiFU+xWJCN0cnRjDrMex3G+Mgy3rx62XrjudH3bgeZpLKBZnmdYhXwHBwW
         oc1Z3q0JXjHwtQxHR+n3r/YJzhxUZBkFMY21FK8DpATXmtRUW5pZZZCaOvxkpKPNGN1K
         b7cwSHht2LPP/9gWtAPwgTIbH969VI71HdbBR6UgS3Mn4paGivg+iQQikmKQ2ELeZiwc
         2S1XYwRx7TAc8IHmuTHpJiOJKgQ4mF3K7CHFWpbb4wHG6aiNpELhUIJXvrZDt1G5uFLe
         v7eg==
X-Forwarded-Encrypted: i=1; AJvYcCVTrWbG3Z1FcJkdC4lG7IlKHCJzTI2cw580/7GfwS+c/tllfmpQ1JmxSU3rxksWkxxkIbU=@vger.kernel.org, AJvYcCWOZnTHJg183sn4lfctd0v37QA4fUW9QQFqkTHKRm9STAWV86AcWdYi7LcTCGjQFR5rMIhYwh+d6pm9+2JB@vger.kernel.org, AJvYcCXxaKdjHWWKSA1y1p3uvwzYKn44k7Mrcfh1+l6nc512a/H2HsBm/dx5GOpn98bfkkXlCuzSJ/pUgAz0EjuFqzompt3V@vger.kernel.org
X-Gm-Message-State: AOJu0YxoyApPVKHp85AnGFfD4pQO3CbL+4E4dFsECMPfux7mUUtwmiXZ
	gbyFUyMGeP/uXunXrB8KhZoJt2xqO1tjXmS8b0ZnxJOODRSvwlyB
X-Gm-Gg: ASbGncv7He1L1cGe2DJb5tjyVY8QgcArKVmwgxHFP21i5jTrviDcTU9nEiqlBNvBsqw
	IB0zaCyxfxlJWfL1IzxiDUi/MF+ZL6sWh+NErUFNi4/NW+aHUYi624/LAdWZDX7/2OudVCr+9yY
	AfxLF2v01/ZhZ687eULQAQ3BDELCWzElPps0E9vCpNF1mmfuL8ezFX5S0380gx7/eepW5Wp27D2
	q4pXyYSm5hnDoN/V060GlPXQozCdmCWhTviHR4junsFZ6IuovTg4nwByLUOQhyfhpUfWOPEBMGT
	OgvdI7w9qN/DdpDgr4UvHVxL+qeqT1Ksm5kYVebR7moanuIRdCU=
X-Google-Smtp-Source: AGHT+IHQON87cPPvrYmjqYx0pWOKi6qv9xnfs2gXXYPnfEV4LpZ6EgpJixyC3wJVZaC1H/fq4IyIjA==
X-Received: by 2002:a17:907:968b:b0:ac6:ff34:d046 with SMTP id a640c23a62f3a-aca9b614b22mr63937766b.2.1744143720387;
        Tue, 08 Apr 2025 13:22:00 -0700 (PDT)
Received: from krava (85-193-35-57.rib.o2.cz. [85.193.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7db5eb6e9sm787644066b.21.2025.04.08.13.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 13:21:59 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 8 Apr 2025 22:21:57 +0200
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv3 10/23] uprobes/x86: Add support to emulate nop5
 instruction
Message-ID: <Z_WFZT3rZtjts3u-@krava>
References: <20250320114200.14377-1-jolsa@kernel.org>
 <20250320114200.14377-11-jolsa@kernel.org>
 <CAEf4BzY8z8r5uGEFjtNVm0L2JBwQ1ZPP2gqgsVqheqBkPiJ-9g@mail.gmail.com>
 <Z_Ox7ibkULkJ_2Lx@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_Ox7ibkULkJ_2Lx@krava>

On Mon, Apr 07, 2025 at 01:07:26PM +0200, Jiri Olsa wrote:
> On Fri, Apr 04, 2025 at 01:33:11PM -0700, Andrii Nakryiko wrote:
> > On Thu, Mar 20, 2025 at 4:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding support to emulate nop5 as the original uprobe instruction.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  arch/x86/kernel/uprobes.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > 
> > This optimization is independent from the sys_uprobe, right? Maybe
> > send it as a stand-alone patch and let's land it sooner?
> 
> ok, will send it separately
> 
> > Also, how hard would it be to do the same for other nopX instructions?
> 
> will check, might be easy

we can't do all at the moment, nop1-nop8 are fine, but uprobe won't
attach on nop9/10/11 due unsupported prefix.. I guess insn decode
would need to be updated first

I'll send the nop5 emulation change, because of above and also I don't
see practical justification to emulate other nops

jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695662b2..6616cc9866cc 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -608,6 +608,21 @@ static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 		*sr = utask->autask.saved_scratch_register;
 	}
 }
+
+static bool emulate_nop_insn(struct arch_uprobe *auprobe)
+{
+	unsigned int i;
+
+	/*
+	 * Uprobe is only allowed to be attached on nop1 through nop8. Further nop
+	 * instructions have unsupported prefix and uprobe fails to attach on them.
+	 */
+	for (i = 1; i < 9; i++) {
+		if (!memcmp(&auprobe->insn, x86_nops[i], i))
+			return true;
+	}
+	return false;
+}
 #else /* 32-bit: */
 /*
  * No RIP-relative addressing on 32-bit
@@ -621,6 +636,10 @@ static void riprel_pre_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 static void riprel_post_xol(struct arch_uprobe *auprobe, struct pt_regs *regs)
 {
 }
+static bool emulate_nop_insn(struct arch_uprobe *auprobe)
+{
+	return false;
+}
 #endif /* CONFIG_X86_64 */
 
 struct uprobe_xol_ops {
@@ -840,6 +859,9 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	insn_byte_t p;
 	int i;
 
+	if (emulate_nop_insn(auprobe))
+		goto setup;
+
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */

