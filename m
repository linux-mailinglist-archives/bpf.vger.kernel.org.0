Return-Path: <bpf+bounces-29855-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 325878C7872
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 16:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90879284724
	for <lists+bpf@lfdr.de>; Thu, 16 May 2024 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D670A14B942;
	Thu, 16 May 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efAu2PPn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C61DFEF
	for <bpf@vger.kernel.org>; Thu, 16 May 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715870091; cv=none; b=H+LnIi+3wxHzjtUi8NU2XZaOcawPkKLtrvku5+4WIRF2d7OT69yFEtrVRj6vQ3OkJjQ/dmIdvlbZq1DJVcY9tdX9qgu0ZpaTesSIMusDBLDxI5GxOEdSWAOO2popjMH4SeBv/5nCcyAkTBm2XodF+FzmFhvOoqrZY2l3sVKucIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715870091; c=relaxed/simple;
	bh=pJFDn+iT4qO5TUPHsZPJfi9CFgcvdBDuyk0kFQ6rhjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cRO+h4s9GvCuO/eK8dzp+5tb7BBe+sxdUszTJgmoF5VEZsy35p9Zqtwgjw782PZNxG2oL6/GwWVR+RRl0c7s2YWSnw3RA8wq8Cv4GOrT06TPRwyCR4T1tn5NBRDg5ZHajB5akSIKAp+i7LT+ZQ8m8u5SgPFIJ30yfp/cq57e3QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efAu2PPn; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-a5a1054cf61so378615766b.1
        for <bpf@vger.kernel.org>; Thu, 16 May 2024 07:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715870088; x=1716474888; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HndOD39FTscPcF7i4U7v7VAr2OC09Fwbq91S9z5gMA8=;
        b=efAu2PPngQ0Fe0eMiF1L8QwZmuweXGjtHHA3TBrmaK409s4pmM/YteINGc+hp8x+6x
         nh+ICMW3EZX6cDoSPZepT+6UjGDluKImb+ah4r7scpnb8sNblS4NgkxmGad9496m5NAJ
         Iacja5zDrFqKchyExtKllj3SCo/Ul/4d2PxjkScnPxKxcdkcotOZ0fj7KVymDXdHptls
         hd/nPMBrn1iBu/v2TKmZL/OH1UjjrxD8OMTSr6md9m4gpfpmqO3ewZcYb74VxBwbS9bh
         bud6CF/LgPUxFgyefW0l5XK9XbqPZzK49iQAUYEsFZbbpdlJdH1eu4vXJZSE1mNM4GO8
         Xjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715870088; x=1716474888;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HndOD39FTscPcF7i4U7v7VAr2OC09Fwbq91S9z5gMA8=;
        b=mg1aoTg47XBGRM1DVGg4XeGgJVgPtstgJ3TJry3M0/3RSAjQ1ppyH51TVuvrhVWS3s
         uzoc6DfBLSYH9XKoIU9rjjz/dd389+ugEH0OuQnE4nOOnTgAOvHtOBBP7k2UP80vtbfq
         7iTaRIihF9oy6AsYYMdgprn71F7EiZVan+DY6kGpnN998z5cklcyD6YyNBK4sOgm+QCI
         OHRvHVE6bGCiW6eVXKRllGmPtZ8GPbQDSbh/NE7iB+SvjVHz+brVqdRCau4MOHeCreNE
         md0k5oVCzOgDEMrFW8ANTGMh4GqLY5J/JfeZSj7EIGtG+ATBMjB73/LfaNLHbzIzkr4d
         2sjA==
X-Forwarded-Encrypted: i=1; AJvYcCU7EyaWT7JXHyLN7zRRtDpZYQIiAJNy9Xv4N+tSi1zItrTAjARZMRja/hysPahEJ+uQJgC7w+OYFIGqHd8EFpdIfuxy
X-Gm-Message-State: AOJu0YzBumkOdZxeo1mQtMZQ4UcoiTR07+RGaNGHa39Wb74w58ppyDwA
	6c7M45jKamBW9/8UqWlBgbHm0zxy8u81YCcRcYZadi6z3f4lnY8oABQqqGC/Jl0u8MgVa07VWZf
	PXKwEEI0J9fOiiSzw5KM1wjasg7gMhXKH
X-Google-Smtp-Source: AGHT+IGyWSgfjd9R3fEMkc8oBQzkXK7vr2ViwYMa+hbTFE/AbXsT3kRwH+8UAG/m17wJABCHP0s+t2IZ8/dmJ26txZ4=
X-Received: by 2002:a17:906:f296:b0:a59:cb29:3fa8 with SMTP id
 a640c23a62f3a-a5a2d53adbbmr1940320166b.14.1715870088024; Thu, 16 May 2024
 07:34:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240514124052.1240266-1-sidchintamaneni@gmail.com>
 <20240514124052.1240266-2-sidchintamaneni@gmail.com> <55b6e3cc-3809-448e-9603-951dc0693c0c@google.com>
In-Reply-To: <55b6e3cc-3809-448e-9603-951dc0693c0c@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 16 May 2024 16:34:11 +0200
Message-ID: <CAP01T77yXv+trVCryMDK-9VghnRrNQpoSpp_Z-OLmQz9omHRGQ@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/2] bpf: Patch to Fix deadlocks in queue and
 stack maps
To: Barret Rhoden <brho@google.com>
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>, bpf@vger.kernel.org, 
	alexei.starovoitov@gmail.com, daniel@iogearbox.net, olsajiri@gmail.com, 
	andrii@kernel.org, yonghong.song@linux.dev, rjsu26@vt.edu, sairoop@vt.edu, 
	miloc@vt.edu, syzbot+8bdfc2c53fb2b63e1871@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 May 2024 at 16:05, Barret Rhoden <brho@google.com> wrote:
>
> On 5/14/24 08:40, Siddharth Chintamaneni wrote:
> [...]
> > +static inline int map_lock_inc(struct bpf_queue_stack *qs)
> > +{
> > +     unsigned long flags;
> > +
> > +     preempt_disable();
> > +     local_irq_save(flags);
> > +     if (unlikely(__this_cpu_inc_return(*(qs->map_locked)) != 1)) {
> > +             __this_cpu_dec(*(qs->map_locked));
> > +             local_irq_restore(flags);
> > +             preempt_enable();
> > +             return -EBUSY;
> > +     }
> > +
> > +     local_irq_restore(flags);
> > +     preempt_enable();
>
> it looks like you're taking the approach from kernel/bpf/hashtab.c to
> use a per-cpu lock before grabbing the real lock.  but in the success
> case here (where you incremented the percpu counter), you're enabling
> irqs and preemption.
>
> what happens if you get preempted right after this?  you've left the
> per-cpu bit set, but then you run on another cpu.

Great catch, that's a bug. It's not a problem when BPF programs call
this, as migration is disabled for them (but it's questionable whether
we should keep preemption enabled between map_inc/dec increasing the
chances of conflicts on the same CPU), but it's certainly a problem
from the syscall path.

>
> possible alternative: instead of splitting the overall lock into "grab
> percpu lock, then grab real lock", have a single function for both,
> similar to htab_lock_bucket().  and keep irqs and preemption off from
> the moment you start attempting the overall lock until you completely
> unlock.

+1.

>
> barret
>

