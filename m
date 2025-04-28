Return-Path: <bpf+bounces-56833-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A47CA9EE5F
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 12:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C13F7A959F
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 10:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA04262FC2;
	Mon, 28 Apr 2025 10:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yb3Fzh5p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4CA21CFEC;
	Mon, 28 Apr 2025 10:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745837524; cv=none; b=TCs0ct/IwfL9braOpt1bzWaOZXtKtwAlnUkYpXd0OCgT79q0nMuTUMEL0GxQbEik3IwTcEvtdjfxeCbA91GC1FPZzVVuQHjhTY1Lb73SygJJ7xNeGBY/fJ7K2lK/++rB7n34ngf1GHzjxvmGqaywDsIdUSDXwKXDd31cDVHBXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745837524; c=relaxed/simple;
	bh=mw0D9zQX1oRSEtyFlBwwdZmRItnM/xZXA4SnPpvEEL4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EozIOrcfdSwQA0CjCRz/v0mnFxUQjtrWbokxHzwXkTAAHVwrNRoSBELFcGhi4TTQR+G8b4v4RslrFl352ed60q/ZWXn1aosED4OfeXDr1NnWpf/Ixntk0oducBIrA+4O2A1IF/hTJv8JZa5AHh9LQ69U3xnckNddDczVU8j5/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yb3Fzh5p; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac6e8cf9132so893376866b.2;
        Mon, 28 Apr 2025 03:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745837521; x=1746442321; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dDlSIXcZYsXdswkPgH/mSCPqgNz8GWfJkAS+sQHHkxU=;
        b=Yb3Fzh5peHajhSYJ08mkNjV/TyHcNutCxVJWjRFahWrvGHBXSrNrBgLaTcS0mPAjhN
         l+7znCmfOfUAtJY1+nVkvWB0dz4LzcrqPVxRQo6k1kZ3FJxTdpOrf1G7/rtj9b82IXYu
         Fera7oi1zqHifPwZtTH0yAcBR5HFo52wg69JUDrZao/Nm2ygxfqTiLkrvMnogD62gItQ
         f9c2w8FLaTegeJADK1fmht2iGtb0y1dyDF6oy9/Xr0WNBHLjVNR2m+HMvdvcm6c00zft
         7InyuZEdH0ICB+OysQWj4rf+VkRzGl8xSXFmI1VkQfwI39NkMZEtgZf/vLb8rylx7lAM
         H8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745837521; x=1746442321;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDlSIXcZYsXdswkPgH/mSCPqgNz8GWfJkAS+sQHHkxU=;
        b=MJZlUZgN35a7TznqvmFFvdN87RhylKPAViquEBesxA2I092QBQhNTEPbAWKITwm6jJ
         HEKOvNjnu2l5/g8EyovfhjH17C9G2R9VfjCcAB82o3dJsjnAOX6UVGc3t7k9Px28U7om
         V4kTe0VT5/+RccfkDiHmid2HFRu5Qof5s7nG5xsuK7gaP2GwS8DLGUJO6qpleGJszrG+
         P6fO4hkn4Xo0ideR9pSRP34EQtXLGXnvb57lCSZofmupeeRO0uyKDAkrDnpwb3oQPRO4
         uK6kEViicdp7IqcWkj+wBQ2hZf038wTzxQlQ+jlqnx3m5vZoS3aboSbu1uv6dB/M+k8O
         nVdw==
X-Forwarded-Encrypted: i=1; AJvYcCV9HIQdjs+IcrZTl4MM/ZE5mDM58m6hfcVMOfA9PxVoXNSsdEB4QfEOpQDdSWjVQgwLG1U=@vger.kernel.org, AJvYcCVCUSu/DqETLEpdXO9XlOCYhCGknWBbpBbZJbtRtSyTiVERk3Qmq4cn9jAjedO2uBiG0XdTOEChL5qeVAjm@vger.kernel.org, AJvYcCX7zLiXbKdSGxSIB9WtKTyU8ZcB5WYC4nOla7MLG5UcNTyyEWDFKQrIYEHcbhFh+6/i7Wsw68yams7xnUd6E+kdH18r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1R8kP5ArGzbJ78rQnGFTlYQjLWrmPOvdNI+ynkXHUmfyM5IVA
	cEdwNgIVyHBDazTCKtnGRlihjDG+GTorC8krkywYY1JpijrlwvKd
X-Gm-Gg: ASbGncsOZBbkdaACxK9yfoGtu9bTu0j3g3jDYZndSeJiT/N0dUhJyxMndDfXpiWvKbG
	73KvDh5gW4MbFN0/FI2NAcgNUg0ktUXQW5wUEo94tSC4pxNKd3dMsDhG0FaFk+geWIGZHXUED3F
	4MWu5Dg/M3sACwhKuPeXnFqQR8kXNGu3j7JS62GVZZ47Lf011pGFDw8spKHdn04rN9hXAQHlvjS
	IDUywt2Ivh0KG9ITob3VSpdORIhYzq1rftyWMhUl+okGd41CJEfCI8RiuavSxzOgZPAGFScLNdT
	ir2yCAEeEGKQcsvsnNJzOl8VO+g=
X-Google-Smtp-Source: AGHT+IED735y/DVouY58/CpuYdElpBSWhTf9ssVaXxwOmzb6cS/Xzk9bZkLWBVO7jdqhFWsApiu3dg==
X-Received: by 2002:a17:907:3d52:b0:ac4:2ae:c970 with SMTP id a640c23a62f3a-ace73a45d67mr899962366b.21.1745837520648;
        Mon, 28 Apr 2025 03:52:00 -0700 (PDT)
Received: from krava ([173.38.220.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6e4e7ccbsm616081566b.59.2025.04.28.03.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 03:52:00 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 28 Apr 2025 12:51:57 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 03/22] uprobes: Move ref_ctr_offset update out
 of uprobe_write_opcode
Message-ID: <aA9dzY-2V3dCpMDq@krava>
References: <20250421214423.393661-1-jolsa@kernel.org>
 <20250421214423.393661-4-jolsa@kernel.org>
 <20250427141335.GA9350@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250427141335.GA9350@redhat.com>

On Sun, Apr 27, 2025 at 04:13:35PM +0200, Oleg Nesterov wrote:
> On 04/21, Jiri Olsa wrote:
> >
> > +static int set_swbp_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
> > +{
> > +	struct mm_struct *mm = vma->vm_mm;
> > +	int err;
> > +
> > +	/* We are going to replace instruction, update ref_ctr. */
> > +	if (uprobe->ref_ctr_offset) {
> > +		err = update_ref_ctr(uprobe, mm, 1);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	err = set_swbp(&uprobe->arch, vma, vaddr);
> > +
> > +	/* Revert back reference counter if instruction update failed. */
> > +	if (err && uprobe->ref_ctr_offset)
> > +		update_ref_ctr(uprobe, mm, -1);
> > +	return err;
> >  }
> ...
> > +static int set_orig_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
> > +{
> > +	int err = set_orig_insn(&uprobe->arch, vma, vaddr);
> > +
> > +	/* Revert back reference counter even if instruction update failed. */
> > +	if (uprobe->ref_ctr_offset)
> > +		update_ref_ctr(uprobe, vma->vm_mm, -1);
> > +	return err;
> >  }
> 
> This doesn't look right even in the simplest case...
> 
> To simplify, suppose that uprobe_register() needs to change a single mm/vma
> and set_swbp() fails. In this case uprobe_register() calls uprobe_unregister()
> which will find the same vma and call set_orig_refctr(). set_orig_insn() will
> do nothing. But update_ref_ctr(uprobe, vma->vm_mm, -1) is wrong/unbalanced.
> 
> The current code updates ref_ctr after the verify_opcode() check, so it doesn't
> have this problem.

ah right :-\

could set_swbp/set_orig_insn return > 0 in case the memory was actually updated?
and we would update the refctr based on that, like:

+static int set_swbp_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
+{
+       struct mm_struct *mm = vma->vm_mm;
+       int err;
+
+       err = set_swbp(&uprobe->arch, vma, vaddr);
+       if (err > 0 && uprobe->ref_ctr_offset)
+               update_ref_ctr(uprobe, mm, 1);
+       return err;
+}

+static int set_orig_refctr(struct uprobe *uprobe, struct vm_area_struct *vma, unsigned long vaddr)
+{
+       int err = set_orig_insn(&uprobe->arch, vma, vaddr);
+
+       /* Revert back reference counter even if instruction update failed. */
+       if (err > 0 && uprobe->ref_ctr_offset)
+               update_ref_ctr(uprobe, vma->vm_mm, -1);
+       return err;
+}

but then what if update_ref_ctr fails..

> 
> -------------------------------------------------------------------------------
> OTOH, I think that the current logic is not really correct too,
> 
> 	/* Revert back reference counter if instruction update failed. */
> 	if (ret < 0 && is_register && ref_ctr_updated)
> 		update_ref_ctr(uprobe, mm, -1);
> 
> I think that "Revert back reference counter" logic should not depend on
> is_register. Otherwise we can have the unbalanced update_ref_ctr(-1) if
> uprobe_unregister() fails, then another uprobe_register() comes at the
> same address, and after that uprobe_unregister() succeeds.

sounds good to me

jirka

