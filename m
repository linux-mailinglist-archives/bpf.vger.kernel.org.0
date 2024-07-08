Return-Path: <bpf+bounces-34120-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E892A887
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 19:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8542D1C210B0
	for <lists+bpf@lfdr.de>; Mon,  8 Jul 2024 17:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08581494C9;
	Mon,  8 Jul 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhDAgjtZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B706145B06;
	Mon,  8 Jul 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720461402; cv=none; b=gvzyTfcg1V18tRRzmk42a07805hS55/jcEgg5km47/6+cUHa7tlH60XsPjrDrguPK/XTWwO6y2y1lSXCQ8p7nxDB2DyHSJ67vtf0Tgso4QoKc1D8IculFqQy7xkoGW7xB/TOthyLIAUz89cdh4yksmqrB/LAie5o0q9CYXC7w1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720461402; c=relaxed/simple;
	bh=a5uFJUtH4OkYhEdl/GavGOnWi0ZPk2fro1NJbGdOyOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE+itXtXzdMO+Mmv7MhXWSJiaEJZ7jQiBc0VN3jR89diizPWwH3k8ofi1JPX1k7ZoqkfBnMcMOFmKk+z/PHtvC3MCH4AhJodq1s8+W+oovpZ/ZGdzu6eTb+DqrEHqm3B2HXG3Slkvx21IoZQ5yPhpUxWO9mwfe/ro1PAXIZrwn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhDAgjtZ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70b05260c39so2231990b3a.0;
        Mon, 08 Jul 2024 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720461400; x=1721066200; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meYvuoSEnds9gjDjxTxQoAi0/56WetasMc7SJVzufQs=;
        b=XhDAgjtZec9DK8gd8MKwesQo7iu/GqnoY4al2fLh56r6grwJcmYFfG43p2Ot0R2t6W
         csS+0dAFFD52TVoz5aGpWjMqYC7cvAi02V+u7fGtjh1yPWyimUM+XjMnNp3XWcF6LQA4
         pgdX1puivzGq9QLwC9Vfy/bESb0dNKKDI17wSZKZxplleLl4+iYryjQi9K73B2uBi1t/
         n0Wz0KtyQAe5graEzhKw10YZdNJjb/k9ht8zRRCUjyKxu7cqiVRrEkdPJBpiQoTq3YSy
         T5ipACJlPsWBY+oXyMPFPqyvl35mINB32GliuMU2lC3wfRfZsgk8gTg3XE32pSfcvIs7
         PjjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720461400; x=1721066200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meYvuoSEnds9gjDjxTxQoAi0/56WetasMc7SJVzufQs=;
        b=Tvgfdv52cI/7J5CFTMHtIxed0RZQVzM7kFnEmmiRIAoNMOk8aKAayt7aNWlbuM+PgW
         EXwUppZbXN7WGf3RmVhuiKLPK3ridY2eqgZAVjUwXPKPEry5hUZfPlk8dJRFW9hQDJQX
         BmC2rilXV4AwPYnIpSvstSIY1ZSTSJ6gAkOUIManHY8n7KKvOXQqtqo/+WVLiAOPNBmk
         vpcDK+lv+arEMToiX+3UK9GE+7tGIOa216PVpGx7QFDird58it2dOKzx+q5eI0u8A3aM
         mVMaYuG5jiROxT6Bh9khUjigdLV5NSRKkP9YSNI6DmltHQTIFiEeBRbay9trqZtYzHRh
         8sEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoMkvcC1UDi9TMeWFHR+LqHzL3PUFFfSyet+2lawOHTMAVXBqefzZeEzpDgpt0QXTtN8n8vcJwcA/m/md1pPzOmqUUVbpbPz96Q6Y0uVIKS9cQFiC/NFhDLJCG0VCw3hT7+HrDfrj5
X-Gm-Message-State: AOJu0YwvpFtfTyXDQfhCV2ceXW+6giylcEfvhMWUMvXwyItX5ZOGPFc4
	r4qTn0doZNWkKEzxjJ5CMOhxnRTipI3xFEe0ul9F1+9Ds3/MbOFyNPn+FPOF2TuHpNWHGo9wvMi
	CBi8SMJOR1NQ0sdrj7v45MNhWGBg=
X-Google-Smtp-Source: AGHT+IG1l1ohGcr3Whs1MOU6XENBpea2bUC+EVJsVlcKArTp0Dva0czQCF3+5WuKhp9lChnWtAcTCcSKMNyTN2dylMM=
X-Received: by 2002:a05:6a00:124a:b0:70a:fdd8:51f2 with SMTP id
 d2e1a72fcca58-70b43566035mr625092b3a.15.1720461400241; Mon, 08 Jul 2024
 10:56:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701223935.3783951-1-andrii@kernel.org> <20240701223935.3783951-6-andrii@kernel.org>
 <20240707124846.GA11914@redhat.com>
In-Reply-To: <20240707124846.GA11914@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 8 Jul 2024 10:56:28 -0700
Message-ID: <CAEf4BzbH_SoxsgPEDZ72oZ7zSdEPvV99C20494bQaOmn8Z=QCQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] uprobes: move offset and ref_ctr_offset into uprobe_consumer
To: Oleg Nesterov <oleg@redhat.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, bpf@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	clm@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 7, 2024 at 5:50=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wrot=
e:
>
> On 07/01, Andrii Nakryiko wrote:
> >
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -42,6 +42,11 @@ struct uprobe_consumer {
> >                               enum uprobe_filter_ctx ctx,
> >                               struct mm_struct *mm);
> >
> > +     /* associated file offset of this probe */
> > +     loff_t offset;
> > +     /* associated refctr file offset of this probe, or zero */
> > +     loff_t ref_ctr_offset;
> > +     /* for internal uprobe infra use, consumers shouldn't touch field=
s below */
> >       struct uprobe_consumer *next;
>
>
> Well, I don't really like this patch either...
>
> If nothing else because all the consumers in uprobe->consumers list
> must have the same offset/ref_ctr_offset.

You are thinking from a per-uprobe's perspective. But during
attachment you are attaching multiple consumers at different locations
within a given inode (and that matches for consumers are already
doing, they remember those offsets in their own structs), so each
consumer has a different offset.

Again, I'm just saying that I'm codifying what uprobe users already do
and simplifying the interface (otherwise we'd need another set of
callbacks or some new struct just to pass those
offsets/ref_ctr_offset).

But we can put all that on hold if Peter's approach works well enough.
My goal is to have faster uprobes, not to land *my* patches.

>
> -------------------------------------------------------------------------=
-
> But I agree, the ugly uprobe_register_refctr() must die, we need a single
> function
>
>         int uprobe_register(inode, offset, ref_ctr_offset, consumer);
>
> This change is trivial.
>
> -------------------------------------------------------------------------=
-
> And speaking of cleanups, I think another change makes sense:
>
>         -       int uprobe_register(...);
>         +       struct uprobe* uprobe_register(...);
>
> so that uprobe_register() returns uprobe or ERR_PTR.
>
>         -       void uprobe_unregister(inode, offset, consumer);
>         +       void uprobe_unregister(uprobe, consumer);
>
> this way unregister() doesn't need the extra find_uprobe() + put_uprobe()=
.
> The same for uprobe_apply().

I'm achieving this by keeping uprobe pointer inside uprobe_consumer
(and not requiring callers to keep explicit track of that)

>
> The necessary changes in kernel/trace/trace_uprobe.c are trivial, we just
> need to change struct trace_uprobe
>
>         -       struct inode                    *inode;
>         +       struct uprobe                   *uprobe;
>
> and fix the compilation errors.
>
>
> As for kernel/trace/bpf_trace.c, I guess struct bpf_uprobe  needs the new
> ->uprobe member, we can't kill bpf_uprobe->offset because of
> bpf_uprobe_multi_link_fill_link_info(), but I think this is not that bad.
>
> What do you think?

I'd add an uprobe field to uprobe_consumer, tbh, and keep callers
simpler (less aware of uprobe existence in principle). Even if we
don't do batch register/unregister APIs.

>
> Oleg.
>

