Return-Path: <bpf+bounces-55830-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD687A87378
	for <lists+bpf@lfdr.de>; Sun, 13 Apr 2025 21:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C00E116C1C8
	for <lists+bpf@lfdr.de>; Sun, 13 Apr 2025 19:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A922F1EA7F9;
	Sun, 13 Apr 2025 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BhnlpVey"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B17B433CB;
	Sun, 13 Apr 2025 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744571139; cv=none; b=DKeLTbAUBR+7fkVSKcEUahc3GUViKcvkS+y4zLeAgbcsKLGqNnzarPT/XSPviyXxqYXy8Qkgcw0gGNztIWb8GfBUjQRI9ZsDTlPjD6U1lUsH9g0LVcsxQLG8+BIC4IsXVAUuLI4QESQXitRGOm19/45rZ5XcfBhfHSz84U1gboQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744571139; c=relaxed/simple;
	bh=xUnKC2hZKUmPIBqtRRkzkS6vfis+UZR9gckCd7oR4K8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftmKiJAe3qtvxEVKoKenjbCdUiZ6g9LpHGMuNfYHvP4zV1MDtd/D1pX95KF1rgzURbgXZtvFVS9ubHjQ8RNpBdI7EFC/T+IiWGNEqcwxIwri8lmmOUDHnnL7IMWkN1pj7FHfItfc4xBi+R9RV/rjJmCzXq0siNf0vH0F4lOo4lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BhnlpVey; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e686d39ba2so6600808a12.2;
        Sun, 13 Apr 2025 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744571136; x=1745175936; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FFn3MVQl1YlknMdPpZVW/TuKNAh9MSgO8m58OGfYfe0=;
        b=BhnlpVeyglx58XPSlQkG//ZwTYH6JyI3mqy9UNgxidsAt1IMiaGOyRxp+dibFnF/f9
         vi/B1KdEo1jLxO+uFb/Obi34cGUXKfNOUUBmrpac95jkFIxqU08yWF7jIbpGYJZi6RkJ
         mClf3RBEFrf8kkoLETfWijnJ1qJlijIZ4FghVoBeusqIMLnZ5KPq5jbdV0B+cvoIF6cN
         3MG5K/h625KWyLj/4I6PdyciY9uO+XjnRgo4GzjbU3wAFcgYt1s9RmTGg/tt6kCfauMe
         sS919Ir57G/+WBBamFOl5yW/3mdzWOK0/7KWCMhYkoq7tBYyiWH3jcqpGWjQVojpHewT
         eXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744571136; x=1745175936;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FFn3MVQl1YlknMdPpZVW/TuKNAh9MSgO8m58OGfYfe0=;
        b=AS6BB2j5MOmw+7BvISJy/Tm6WMt9RgJ6hv3UNkDHnzaERD7qOUEP23Y5XCNsPPjOaH
         9SoeKoOC17UcTiYYMpSxH5Vt8mdR9id653/OcD5Q2kMvV3QS0O0eklJKBa5JMB76jsYq
         b/t70LPnQ3ucKpaAycwJIqIqj3w8DOGUpCMy4xM0kOGT5SftIpTFgkqCgl+Iqtt7O2JC
         nRzeuDGPiVRDsNJP+LGP4e1/iyc6lqZttIZFnyUjsyqOaNiJg1vGhcLz8RiJlj4KsjHg
         HVIgteYYbECBNKws6ZevjhNiaxmgyhgcK8eUtaxLs/cjy85gp7TVQcbBtzP/QVq0In4e
         yxCw==
X-Forwarded-Encrypted: i=1; AJvYcCV7lNZ1REzoeqChNDd+ZMmcUq1OVrX0FtFcah6FCnYzvqMnPwQp5ZrpdIVncRgAMaCqO9p6lau6zUztqX6wpojYEnuu@vger.kernel.org, AJvYcCWjh2/A1lxr6UJ5JFItuq276PXUvn6xG/ryUPI64xUCN4RVYVdbA9RPCTiOCIYNT2AfQDMuh3p1bDlhBrKM@vger.kernel.org, AJvYcCXcHjIHX1c5hjZEqYb6/RW6a6D2N828sDfc2q9M5BM4r+oGBOfMLs67Szu7OAL+S7bQaLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8aGtCsqfAOR9ulX81XBPdCdjoF/Zl2ECmWKceccslmwGglHL6
	8MJgekR9KsR0FXZHUS5vck/OUOvF1aWDziI0rQ7cDICADWNZsDSL
X-Gm-Gg: ASbGncu6ZbUELqfUmLvata9pH2CIn+CaefsDBeWBODHOr+i+JjSjBV1CJoZ9mmL8Xjg
	Et6p2S0jgyq0gFx6yye0/oEtfalTX82bqTegMncGEVtYa2iBUEYpoOWbbSZW5Q9lGtDEER0vlE1
	xpOptDA/fck5MBZkFidA9Dj+XBwYpNqPZp72+AvIAMMXfyDgkHeyPbf0V1uN/HkbiqxYKeN8fhy
	Y5Hc5PHvy0ATNnJNT6MnNdFMjErmsBLGoxts0BMEQ8qHuqhqsiHxzL0DW6qBhawqLOZNWrXesZm
	tSxVVuNty9twv2T6/laoNhGCsMf9yl0hUma5+x2Pt5LEJJCPLGkjb6In
X-Google-Smtp-Source: AGHT+IE2rlqatkj2ISFm4XV3Kag3gIMpJ+YFGxMKfNE+sdEV9FSc5wiV5XyQ+8Jv6lyEPxkR4AdsRw==
X-Received: by 2002:a05:6402:27cd:b0:5ed:3228:d005 with SMTP id 4fb4d7f45d1cf-5f36f876401mr7080158a12.6.1744571135454;
        Sun, 13 Apr 2025 12:05:35 -0700 (PDT)
Received: from krava (ip4-95-82-160-96.cust.nbox.cz. [95.82.160.96])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36f069dedsm3810613a12.41.2025.04.13.12.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 12:05:34 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sun, 13 Apr 2025 21:05:29 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: Re: [PATCHv2 perf/core 1/2] uprobes/x86: Add support to emulate nop
 instructions
Message-ID: <Z_wK-XUmQtx1xybs@krava>
References: <20250411121756.567274-1-jolsa@kernel.org>
 <CAEf4BzbvMYJf5LLxwamYpzzu=Sewzti-FR-9o4AGfU+KZu0b1Q@mail.gmail.com>
 <20250411163242.GI5322@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411163242.GI5322@redhat.com>

On Fri, Apr 11, 2025 at 06:32:43PM +0200, Oleg Nesterov wrote:
> On 04/11, Andrii Nakryiko wrote:
> >
> > > --- a/arch/x86/kernel/uprobes.c
> > > +++ b/arch/x86/kernel/uprobes.c
> > > @@ -840,6 +840,12 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> > >         insn_byte_t p;
> > >         int i;
> > >
> > > +       /* x86_nops[i]; same as jmp with .offs = 0 */
> > > +       for (i = 1; i <= ASM_NOP_MAX; ++i) {
> >
> > i <= ASM_NOP_MAX && i <= insn->length
> >
> > ?
> >
> > otherwise what prevents us from reading past the actual instruction bytes?
> 
> Well, copy_insn() just copies MAX_UINSN_BYTES into arch_uprobe.insn[].
> If, say, the 1st 11 bytes of arch_uprobe.insn (or insn->kaddr) match
> x86_nops[11] then insn->length must be 11, or insn_decode() is buggy?
> 
> > or, actually, shouldn't we just check memcmp(x86_nops[insn->length])
> > if insn->length < ASM_NOP_MAX ?

nice, did not think of that

> 
> Hmm... agreed.
> 
> Either way this check can't (doesn't even try to) detect, say,
> "rep; BYTES_NOP5", so we do not care if insn->length == 6 in this case.
> 
> Good point!

I'll run tests and send formal patch for change below

thanks,
jirka


---
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 9194695662b2..6d383839e839 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -840,6 +840,11 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	insn_byte_t p;
 	int i;
 
+	/* x86_nops[insn->length]; same as jmp with .offs = 0 */
+	if (insn->length <= ASM_NOP_MAX &&
+	    !memcmp(insn->kaddr, x86_nops[insn->length], insn->length))
+		goto setup;
+
 	switch (opc1) {
 	case 0xeb:	/* jmp 8 */
 	case 0xe9:	/* jmp 32 */

