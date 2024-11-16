Return-Path: <bpf+bounces-45031-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB219D010B
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 22:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B1142868B0
	for <lists+bpf@lfdr.de>; Sat, 16 Nov 2024 21:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0511AE017;
	Sat, 16 Nov 2024 21:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JsiC1pjU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC391ADFF9;
	Sat, 16 Nov 2024 21:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731793326; cv=none; b=TPyrZGyUIOh6DGftRK7apXvlzF73ZSyRv+SyiN970Zjq2L+mOmBQrLNlqqgwzz51RkMqMFfcx8wjxv9IISyNWXzMjSHreNEahLm/JPl9NvVIB7J7uWjC/7F7GFnphCepKn40eU9UfDcevB3k6R6YBgwn4hswzxn6huuvBTtx7nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731793326; c=relaxed/simple;
	bh=i2USsnFVNJ3yJ83s/t4hpgTlFuH7rdSRhCxwmfVqYbg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIjkq7WAZaNZzIPCh3YSBkfa/ZsfDsTeyyPdLw8k8L3J6EXa9VAyTW02ZcgWHI5IaO/76ut52sZhwTeyHvtZk8YtB0djXgRd/KI7rShJpAUVm49YNxhmiDD3/yg+arr2dzYeaST6iHd/ZOcSoXLJp/wW6OZ92taXXVmgDfXzTBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JsiC1pjU; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539fb49c64aso905239e87.0;
        Sat, 16 Nov 2024 13:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731793322; x=1732398122; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zVkmmiHYaiCxGZCG3PiWmLMWMPQCbalvenNrACUCVZE=;
        b=JsiC1pjUvnwbuDSKOEautCBtFrYgJY220d5HOmJqHUna5ax47M4gS4JIfQubMCyGqZ
         yLTX7xyl8LZsNpNf1WMwKr2xuQiMR8HbcLnSvkU8/Jp/SdFppYwXKkYhVkz3fAeYWPQo
         iMbGRR8/yGfShkYg/8DPmuu5/3bZvKHgq9mbiDRfBUqARK7EqKSzXiFObA97LHyQcQkH
         bR5iQPHvgKHpOBvOAspTs3oM7cOiuj+5RQg2x56pkaWaXQ8wsF1zu/nq9GoTVr6i6G2+
         47NNZNDClX+r+KhVmFFeartAE1vVVuhuz6XDJ5Vr1EbvAuI2m4uF4s/O6MCu9EGxo4GY
         G41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731793322; x=1732398122;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVkmmiHYaiCxGZCG3PiWmLMWMPQCbalvenNrACUCVZE=;
        b=q+A9wbB7Kv0qAV+MmdUDXDqgLKJkhIwM14yv2/qIh1+ade2q+6ckpc7Z5jxqHzia6B
         QM7daI61K7Gweb1b5ea/EubHZweiHkc3vRaYr1CLQSVXLdf9E2ljVwr15J8ZnkFD/qHC
         pjn/jrgPhOp77Wg8lxGbK+bbvvfGZQSRVHT/92odf/JIKlqZHsEmU6vb0hR3yQf2WIg6
         a8Y583zTJEru+HW/l3NH9f3v2L/YtTFyvivJxAHrhh1Dnv/WZ6P028v5ObjIvxtPNuH7
         gQ9EZ6LwdOpxBPsRW3v0/s6YxC9boY5XrryCo9mN+NJyTF2C/bAJI8P9/nxo+GgqJynu
         u6AQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHHdtoJSmov7H2fI7OJXPahKJIDWRkM6wz06cMHv2fl0KXTXaqjCks44Rnj7yjHsWgvfM=@vger.kernel.org, AJvYcCWxqIuGbZ1Y0skabI4aGy6UuvQd6cT+bRf+Q4BZNiJG2Poc+7UHZzy2ETpkhkAw3asYicDHmr7idI8HJk0/o9d+wC9Z@vger.kernel.org, AJvYcCX23ymOfkPSjOQGP+iNNVkYgEWwnCaPn9JJ+9nDAqH43wR8up8YHWCKJVeeQ0KnEao1xA2dP9XNIPwEEUPV@vger.kernel.org
X-Gm-Message-State: AOJu0YyugIMdSuqA/nvZ+61pcPhimSEKvHBbCa9D0VRr+STrFFyEnFR9
	TrYk4EvJ3zO4AYOuuFYBsRBNtlqVhwevnWzCvt6tpCIiW7VDEDTgfmTVRA==
X-Google-Smtp-Source: AGHT+IEx+sjpiLuEB/YXjDUEyc3zwRdrfh5+6jQNnxRpTDzseZO2xnR2KSQrkHXyb4HuCa57zjqxdQ==
X-Received: by 2002:a05:6512:1193:b0:538:9e36:7b6a with SMTP id 2adb3069b0e04-53dab2a9eebmr4612070e87.32.1731793321985;
        Sat, 16 Nov 2024 13:42:01 -0800 (PST)
Received: from krava (85-193-35-167.rib.o2.cz. [85.193.35.167])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e0861d8sm347989566b.191.2024.11.16.13.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 13:42:01 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 16 Nov 2024 22:41:58 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC perf/core 03/11] uprobes: Add len argument to
 uprobe_write_opcode
Message-ID: <ZzkRpk9eZ0kLMGdl@krava>
References: <20241105133405.2703607-1-jolsa@kernel.org>
 <20241105133405.2703607-4-jolsa@kernel.org>
 <CAEf4BzbM+warM65tnYampngqOGzQ-FS7frH88Hayx7veMjpjZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbM+warM65tnYampngqOGzQ-FS7frH88Hayx7veMjpjZA@mail.gmail.com>

On Thu, Nov 14, 2024 at 03:41:03PM -0800, Andrii Nakryiko wrote:
> On Tue, Nov 5, 2024 at 5:34 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding len argument to uprobe_write_opcode as preparation
> > fo writing longer instructions in following changes.
> 
> typo: for
> 
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/uprobes.h |  3 ++-
> >  kernel/events/uprobes.c | 14 ++++++++------
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index 28068f9fcdc1..7d23a4fee6f4 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -181,7 +181,8 @@ extern bool is_swbp_insn(uprobe_opcode_t *insn);
> >  extern bool is_trap_insn(uprobe_opcode_t *insn);
> >  extern unsigned long uprobe_get_swbp_addr(struct pt_regs *regs);
> >  extern unsigned long uprobe_get_trap_addr(struct pt_regs *regs);
> > -extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr, uprobe_opcode_t);
> > +extern int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > +                              unsigned long vaddr, uprobe_opcode_t *insn, int len);
> 
> is len in sizeof(uprobe_opcode_t) units or in bytes? it would be good
> to make this clearer
> 
> it feels like passing `void *` for insns would be better, tbh...

good catch, it's meant as bytes, uprobe_opcode_t is u8 on x86, but other archs
treat it differently, void * might solve that in this function, will check

thanks,
jirka

> 
> 
> 
> >  extern struct uprobe *uprobe_register(struct inode *inode, loff_t offset, loff_t ref_ctr_offset, struct uprobe_consumer *uc);
> >  extern int uprobe_apply(struct uprobe *uprobe, struct uprobe_consumer *uc, bool);
> >  extern void uprobe_unregister_nosync(struct uprobe *uprobe, struct uprobe_consumer *uc);
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index e9308649bba3..3e275717789b 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -471,7 +471,7 @@ static int update_ref_ctr(struct uprobe *uprobe, struct mm_struct *mm,
> >   * Return 0 (success) or a negative errno.
> >   */
> >  int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> > -                       unsigned long vaddr, uprobe_opcode_t opcode)
> > +                       unsigned long vaddr, uprobe_opcode_t *insn, int len)
> >  {
> >         struct uprobe *uprobe;
> >         struct page *old_page, *new_page;
> > @@ -480,7 +480,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >         bool orig_page_huge = false;
> >         unsigned int gup_flags = FOLL_FORCE;
> >
> > -       is_register = is_swbp_insn(&opcode);
> > +       is_register = is_swbp_insn(insn);
> >         uprobe = container_of(auprobe, struct uprobe, arch);
> >
> >  retry:
> > @@ -491,7 +491,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >         if (IS_ERR(old_page))
> >                 return PTR_ERR(old_page);
> >
> > -       ret = verify_opcode(old_page, vaddr, &opcode);
> > +       ret = verify_opcode(old_page, vaddr, insn);
> >         if (ret <= 0)
> >                 goto put_old;
> >
> > @@ -525,7 +525,7 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >
> >         __SetPageUptodate(new_page);
> >         copy_highpage(new_page, old_page);
> > -       copy_to_page(new_page, vaddr, &opcode, UPROBE_SWBP_INSN_SIZE);
> > +       copy_to_page(new_page, vaddr, insn, len);
> >
> >         if (!is_register) {
> >                 struct page *orig_page;
> > @@ -582,7 +582,9 @@ int uprobe_write_opcode(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >   */
> >  int __weak set_swbp(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
> >  {
> > -       return uprobe_write_opcode(auprobe, mm, vaddr, UPROBE_SWBP_INSN);
> > +       uprobe_opcode_t insn = UPROBE_SWBP_INSN;
> > +
> > +       return uprobe_write_opcode(auprobe, mm, vaddr, &insn, UPROBE_SWBP_INSN_SIZE);
> >  }
> >
> >  /**
> > @@ -598,7 +600,7 @@ int __weak
> >  set_orig_insn(struct arch_uprobe *auprobe, struct mm_struct *mm, unsigned long vaddr)
> >  {
> >         return uprobe_write_opcode(auprobe, mm, vaddr,
> > -                       *(uprobe_opcode_t *)&auprobe->insn);
> > +                       (uprobe_opcode_t *)&auprobe->insn, UPROBE_SWBP_INSN_SIZE);
> >  }
> >
> >  /* uprobe should have guaranteed positive refcount */
> > --
> > 2.47.0
> >

