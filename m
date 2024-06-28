Return-Path: <bpf+bounces-33380-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4777091C8F9
	for <lists+bpf@lfdr.de>; Sat, 29 Jun 2024 00:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040BE286591
	for <lists+bpf@lfdr.de>; Fri, 28 Jun 2024 22:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC7D80C07;
	Fri, 28 Jun 2024 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tsrak5nj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04657AE5D;
	Fri, 28 Jun 2024 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612854; cv=none; b=CyOVKYJ5k1jy0cDZ+GMhQmsORK4XUCSwrElxTJTcDLLspTERIz1VheMbsGfHjwR6GLLJP/w/Iq0GlTFpHsEqHiS6yshlIfvehXkKARXUBBWyPEp2x+tE5BNC/+Hm654HeSIaXHwJSXC955lsOSxcsyNubZ/VmL+LNfdOc/SjnXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612854; c=relaxed/simple;
	bh=UryOYHRfqwcEcZIwwThwQfd3CAfjpi2BLQY5PX2Iahw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFJIyP/15454PgIuFKKxrJYCBmrdqggKjaQYfOw0lLxIWEnHdgX3vpXghLFUmQR/t0eWYZQ10uDL4q7WYxyOWr7f+NgiK8/+NPQTBo3YaakLvWCZfnIs0oW0/NGA+lEx0wc9KPXkh3UuNImRSXJE7sy9wZKhtWHAuYFCVpbK6dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tsrak5nj; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-711b1512aeaso816329a12.3;
        Fri, 28 Jun 2024 15:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719612852; x=1720217652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NG/zAGwOMU7QiFsKf3DVczTFTidF/ku76yZcjdSekbs=;
        b=Tsrak5njCi0iVSCr1yw/sckmI5S7LlKLOn0u1bpSJeZummvWW8hawtZ0mV3F1g6IDV
         J/pHCD/jmBRefKGQ1Yzt4umeCziFbB1oBjnMYPArmdNW6huZFmVc43Q4s/UL98j1LYum
         ghgi8Jl4mCTld6P67KV9Ood8t95yMRed/cxrI5MZANv3RuuYCCYL9QB1SGnLX2uSBZv7
         OwqaYoemI7cUN0tmV4LGp/drm/hMAilVS7LN1EGWHe6iZLhlen2N02tyRVkuKtkMzoSs
         vdSsapEPtIsJ8v9Sytrl2Y5GNhbFIGtRPXzeerzgooZvX+blhlLAetTHWGarno1YDIuV
         eNJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719612852; x=1720217652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NG/zAGwOMU7QiFsKf3DVczTFTidF/ku76yZcjdSekbs=;
        b=MI20xv5DYVPoDwPq5YKuC7I+fxsYsnyTotk/ZDOamTrYUQ4ls3oehZNeps6MSAewqr
         3WE+7jMZ7iy82o9e+yw8am40zxy1khSbojzHV93fNGJlRPmb7sKgsXGBm6qkQdrCiaLx
         6I4Fu3KEg6B/sJl4ywUqLG2S9W2N+VuTJSvC1AtqDNzqVBu3GF1UjMUx2fv+3vAvRzv8
         suU+3yto74lpwtR2o5AbHmzaK38D6FMq656Dvc+DKMdjqgFrB836Fwi9m2T4iJMMGz0F
         emG+WST3hG0gpNrtPMSbkrqj5rjGuSZU44aTlwUgXgzWKnEjJ+IC4tG0LT7Ak6L50+2A
         SbrA==
X-Forwarded-Encrypted: i=1; AJvYcCXeYKgoC7mJhNMxzOag1zcNVuWf5th9kMRPvXS2harpImqVMLEDkWW9Rth38J3hOnS1qchgZaXBKUkbq690rIE9IA2Z+df3HfD389wChPTf6sK7iA+zJEo8JoENyafcOXWb
X-Gm-Message-State: AOJu0YxeeoUa1l8GAiI6p7etncG5krwZxL3/94v25sWmXzOQJLR9Wo6P
	7phaA9Z1KaBzC/L9oztdeJPs7nyp4f/KhM7bdM4O1nLMyWfuXgjr
X-Google-Smtp-Source: AGHT+IG06LEYrzDPjN/VFMJR+p9b0ziDdCaGqHxCPwJAKdwZ5f9gNybXlc7TzGsVkJ0PT+ErKTV3oA==
X-Received: by 2002:a05:6a20:9681:b0:1aa:6167:b6d6 with SMTP id adf61e73a8af0-1bcf462105emr18535309637.42.1719612851761;
        Fri, 28 Jun 2024 15:14:11 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-708045aac85sm2182868b3a.174.2024.06.28.15.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 15:14:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 28 Jun 2024 12:14:10 -1000
From: Tejun Heo <tj@kernel.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	David Vernet <void@manifault.com>
Subject: Re: [PATCH sched_ext/for-6.11 1/2] sched_ext: Implement DSQ iterator
Message-ID: <Zn81srqbHfKBC7zZ@slm.duckdns.org>
References: <Zn4BupVa65CVayqQ@slm.duckdns.org>
 <CAADnVQ+h2W88nWnj_frPa24vYmE+yebHYaT6mronRnDYvC+JLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAADnVQ+h2W88nWnj_frPa24vYmE+yebHYaT6mronRnDYvC+JLQ@mail.gmail.com>

Hello,

On Thu, Jun 27, 2024 at 06:11:48PM -0700, Alexei Starovoitov wrote:
> > +struct bpf_iter_scx_dsq_kern {
> > +       struct scx_dsq_node             cursor;
> > +       struct scx_dispatch_q           *dsq;
> > +       u32                             dsq_seq;
> > +       u32                             flags;
> > +} __attribute__((aligned(8)));
> > +
> > +struct bpf_iter_scx_dsq {
> > +       u64                             __opaque[12];
> > +} __attribute__((aligned(8)));
> 
> I think this is a bit too much to put on the prog stack.
> Folks are working on increasing this limit and moving
> the stack into "divided stack", so it won't be an issue eventually,
> but let's find a way to reduce it.

Yeah, it is kinda big. Do you have some idea on where the boundary between
okay and too big would fall on?

> It seems to me scx_dsq_node has a bunch of fields,
> but if I'm reading the code correctly this patch is
> only using cursor.list part of it ?

Great point. Cursors used to have to go on the rbtrees too but that's no
longer the case, so I should be able to drop the rbnode which should help
reducing the size substantially. I'll see what I can do.

> Another alternative is to use bpf_mem_alloc() like we do
> in bpf_iter_css_task and others?

This might be okay but given that this can be used pretty frequently (e.g.
every scheduling event) and it *seems* possible to reduce its size
substantially, I'd like to keep it on stack if possible.

> > +__bpf_kfunc int bpf_iter_scx_dsq_new(struct bpf_iter_scx_dsq *it, u64 dsq_id,
> > +                                    u64 flags)
> > +{
> > +       struct bpf_iter_scx_dsq_kern *kit = (void *)it;
> > +
> > +       BUILD_BUG_ON(sizeof(struct bpf_iter_scx_dsq_kern) >
> > +                    sizeof(struct bpf_iter_scx_dsq));
> > +       BUILD_BUG_ON(__alignof__(struct bpf_iter_scx_dsq_kern) !=
> > +                    __alignof__(struct bpf_iter_scx_dsq));
> > +
> > +       if (flags & ~__SCX_DSQ_ITER_ALL_FLAGS)
> > +               return -EINVAL;
> > +
> > +       kit->dsq = find_non_local_dsq(dsq_id);
> > +       if (!kit->dsq)
> > +               return -ENOENT;
> > +
> > +       INIT_LIST_HEAD(&kit->cursor.list);
> > +       RB_CLEAR_NODE(&kit->cursor.priq);
> > +       kit->cursor.flags = SCX_TASK_DSQ_CURSOR;
> 
> Are these two assignments really necessary?
> Something inside nldsq_next_task() is using that?
> 
> > +       kit->dsq_seq = READ_ONCE(kit->dsq->seq);
> > +       kit->flags = flags;

I'm a bit confused whether you're referring to the statements above or
below, but AFAICS, they're all used except for kit->cursor.priq.

- SCX_TASK_DSQ_CURSOR assignment is what tells nldsq_next_task() that the
  node is a cursor, not a real task, and thus should be skipped for internal
  iterations.

- kit->dsq_seq is used by bpf_iter_scx_dsq_next() to ignore tasks that are
  queued after the iteration has started. This, among other things,
  guarantees that p->scx.dsq_vtime increases monotonically throughout
  iteration.

- kit->flags carries SCX_DSQ_ITER_REV which tells bpf_iter_scx_dsq_next()
  the direction of the iteration.

Thanks.

-- 
tejun

