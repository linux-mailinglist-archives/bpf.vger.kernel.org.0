Return-Path: <bpf+bounces-28163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F368B6467
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 519041F225F1
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD40181BB4;
	Mon, 29 Apr 2024 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HwxHVYeq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3049181BA9
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425429; cv=none; b=UQ7vEmKfnW7WuFhMD0bXofeDCBiUSuKVBfNlqeUh1bWPRqSQxzdXIRyEGvUFlzTiIn+C9z8zt5mg/CT/I0zsHFQkhZ7AGtGSJb3sSucjXr4I5O0LW4DdXZb/3vHcyKqAXSRJRdr2SuXKs1p/l5jlbak2R7JqoAWbsxsJNtV8tEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425429; c=relaxed/simple;
	bh=QpneGsS5xLwrLk76g8+2FJyca/F1tAokwb0GQ19cNWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tZazJLMvLH0O/unKQdmxxsMBla/JL/BsAFrxE1ytAPpunsgdPXvAuKyCu2Gm2tKCSBODFDYZ4EXe+Tj42SSlAllL4y+VM7uHegqIMnmO7HTK0L2e4Yd4MirOjZdJPkb84JcDtBplZWaGmtQ4VWXhc/Na8pHy/xdK8yceT5GkXTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HwxHVYeq; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-1e2a5cb5455so56882835ad.2
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 14:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714425427; x=1715030227; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=avCJDlp1VkIP7aHgM5yB5eXzNTlvQ7rraDx7708EcNI=;
        b=HwxHVYeqJhDX8xMBi4h+KryOcfmNVZdyLU3lzVUmhSKHuzHX1OSd7Ujj1t3domX8pE
         dSsKr9w1UFzlaaj2CLI+7XSlCB5lCoChlXoN6hqBFwHRqMUK8jLQ9NN9iXd+bOPNgCKV
         jF1v9EozL6HHQWKbjsz1Ah6jz7PR4+PnCNpgj1VS2XKPJRPfyA1JKip5CFv9cxDxchuE
         fRmS/KPz/WcMdnobScF2Ht+eT7psQQWgQWHEQy2HuqQvCvYWGWAuLqYjklID66LVAKOR
         w1ciujTDhuXhwX+JSowArwnyuOdOpCTwhbLNg9hbhTQdHMPrL3NHs6t9myI3i1fMa2Js
         t+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714425427; x=1715030227;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avCJDlp1VkIP7aHgM5yB5eXzNTlvQ7rraDx7708EcNI=;
        b=t03ZKCZmYiCHaHkLeUVV7umnCac5WecGZU0BAAHLJRcxclppqOlFiprOsviJjvYj5X
         Xy9bG66VG4PdmHOIEl7wWgGNU+3BDcaBVsjhIc8Lgti19Q/NFwHZOngnbdJWfdz34g6T
         yIbEKaNeB6vOK2CNBDozpk0u2OLAFkiDbXsAqPFQ495DW9ahqfKtUmPDMAL5xmXBc0Ev
         Vt5fofsMjPZtOgdHo6d3CTxZkRC8Z2t+0noxAKRPNQHsORWed4Ex+I1+ZHSTNrfwiQf4
         +P32JvBvW4oYc4TYF3mud5Tb2/9Ah962FSENWXkIUuewjRaH12APN93EQGWsRUMNFWLp
         JdEw==
X-Gm-Message-State: AOJu0Yz3bgRsHBLklZ5KLef9ZdozZD69xEncRs+yAozC30Soy57XmIGU
	UDK6cwyLPnzI+qcTHOwgylq0m/Op9V7CfJ3oASKCDTfclSwwe+bKNxJs46Y/g0DktQ==
X-Google-Smtp-Source: AGHT+IFKEsYqVuvqsG3JOXovNSsFr9oqVZvMbKQBxJeId5xufI1uIms9M10ndQyqAei8VCLwg7/akMI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:903:2291:b0:1e8:6d8b:5fee with SMTP id
 b17-20020a170903229100b001e86d8b5feemr35925plh.5.1714425427015; Mon, 29 Apr
 2024 14:17:07 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:17:05 -0700
In-Reply-To: <7c5553d33d0796a22ffa3d4c7e1791e7f033d43d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240426231621.2716876-1-sdf@google.com> <20240426231621.2716876-2-sdf@google.com>
 <7c5553d33d0796a22ffa3d4c7e1791e7f033d43d.camel@gmail.com>
Message-ID: <ZjAOUc3kG6VKQMW6@google.com>
Subject: Re: [PATCH bpf 1/3] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
 enforcement in BPF_LINK_CREATE
From: Stanislav Fomichev <sdf@google.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org, 
	haoluo@google.com, jolsa@kernel.org, 
	syzbot+838346b979830606c854@syzkaller.appspotmail.com
Content-Type: text/plain; charset="utf-8"

On 04/29, Eduard Zingerman wrote:
> On Fri, 2024-04-26 at 16:16 -0700, Stanislav Fomichev wrote:
> > bpf_prog_attach uses attach_type_to_prog_type to enforce proper
> > attach type for BPF_PROG_TYPE_CGROUP_SKB. link_create uses
> > bpf_prog_get and relies on bpf_prog_attach_check_attach_type
> > to properly verify prog_type <> attach_type association.
> > 
> > Add missing attach_type enforcement for the link_create case.
> > Otherwise, it's currently possible to attach cgroup_skb prog
> > types to other cgroup hooks.
> > 
> > Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")
> > Link: https://lore.kernel.org/bpf/0000000000004792a90615a1dde0@google.com/
> > Reported-by: syzbot+838346b979830606c854@syzkaller.appspotmail.com
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---
> 
> I've spent some time comparing:
> - syscall.c:bpf_prog_attach()
> - syscall.c:link_create()
> - syscall.c:bpf_prog_attach_check_attach_type()
> - syscall.c:attach_type_to_prog_type()
> - verifier.c:check_return_code()
> 
> And it looks like BPF_PROG_TYPE_CGROUP_SKB is the only thing with
> missing attach type checks.
> 
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[..]
 
> (The interplay between the above functions seems a bit messy,
>  but I don't have good suggestions for refactoring at the moment.
>  It appears that bpf_prog_attach_check_attach_type() could be simplified
>  if prog->enforce_expected_attach_type would be set more aggressively and
> 
> 	if (prog->enforce_expected_attach_type &&
> 	    prog->expected_attach_type != attach_type)
> 		return -EINVAL;
> 
>  moved as a top-level check outside of the switch.
>  Also BPF_PROG_TYPE_SCHED_CLS case could be removed as it is handled
>  by default branch. But these are larger changes).

Fully agree on this one. Now that we have some tests around that part,
we can probably try to simplify it a bit. Those small differences with
link_create vs prog_attach are a bit hard to follow.

Thanks for the review!

