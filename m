Return-Path: <bpf+bounces-32610-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC5B8910E21
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 19:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7C71F22B31
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933691B3740;
	Thu, 20 Jun 2024 17:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MEpxy4fl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5791B29BE
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 17:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903551; cv=none; b=k2pbXJr4XzpRcypGLURAVCndRy2+3KE1C1Sg+XU+kVrfaQjywFQzlaJgO9MVeGNXGPcTTGOgGiH/aba1wWLhdKBj2yt1SfBMF7liW8cONrOYfm/To3KVQE1sFx0vFwkHBDtr/gDa+moo2u8PTbXhm+//RiDLvTxBOdxFqAvLys8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903551; c=relaxed/simple;
	bh=g7WfMcaBjh6YPIh2UjnnvRHNQREoKfly02V4jb0nz9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=owAtaJ3Fkukf2kNs26OK3zcdXPQypGh1Id3lZyfHVDj4yvgUWGPnQzb747jx6in6KBO1nDgRmMFKCrU0Nf0moEF1NFrSUg1l1Gupie0jGy9sCyw5zFmXDiMjPMk3vVZKYfTR4+3DAHOOLB0VmzQJxyzNcYQsb33Rdg7JnBoCgn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MEpxy4fl; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-52bc3130ae6so1118393e87.3
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 10:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1718903547; x=1719508347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rhFHixzYRCr0Du1zLo7y9OoIpaaj9IpifQpSn+Y7skc=;
        b=MEpxy4flhOqlBTwYxgeD7FY3LQ+5CYvv+9czB+LOP829g+6265c8SjxZYU55+AO150
         5JEH0YzchKN0Vlu1WVPf9pmEEtZYyoTcLZZAfkx3QgLoiXf8VZoQgSQ5rBB8s1AKDd5f
         SE7rrbwg8q8+VR7mSagyo+nK1gSYwqcWid3h4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718903547; x=1719508347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rhFHixzYRCr0Du1zLo7y9OoIpaaj9IpifQpSn+Y7skc=;
        b=Z/vqMw9nJxURmXKE+CWgDQKzQsDfABQHtfk8QKGbh17ORqDtF7bc8YHDfGHm9HNi3s
         LMs52Se7Qo1FzRbwYlglUEg252MAyapAE7QUmNa+H0j9nbPqM+c1xpodFhjBAgPD+hOq
         yDTzmquKK0E1wpEO6TzuEgnc/7xs5l8gDRrmTmlv6vuFQNEiYZLo5fGOvIGA1x8Ewhsp
         qbvwv/G7PW1q41p2AKo3ys1oStZktSVD1aO4XpTdPDEWM3MLN+CBWYDUEzRH6EneSgD4
         qlafMu62hlqCV062N+DyXLbEioMOfmAacbLsS1Q0KYS55t67OND1AUwV0YqGVWdfZUP7
         /w2g==
X-Forwarded-Encrypted: i=1; AJvYcCWGnNojvaM/p9rYoRA29AaD6jZZJJ/CWtOTQLE40C3B+8ggaOar00NiT37G4CRpEi1XFXvwwExBi/3jGlaXff46kpd0
X-Gm-Message-State: AOJu0YzKviVaDyZXXJctD18oyF5ZknPY6fYQd3YGpQAPYJ5j4FVhdPXR
	GqF15B8VrglYX543gYPbFMmAYTAUmbkUwxYHfugHD7Ap9P04lj0dfG7LutSZRwjvUjr6lrqlAzx
	tm23pPA==
X-Google-Smtp-Source: AGHT+IGb6pxUtaJNkgn6XlaEMyR9oCGPB1BuEFB++1oiSEYwFvRO6NHkG8xYpPDZqn9p2Vxda2R05w==
X-Received: by 2002:ac2:4d84:0:b0:52b:5451:996a with SMTP id 2adb3069b0e04-52ccaa3768cmr3117769e87.31.1718903547532;
        Thu, 20 Jun 2024 10:12:27 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56dd2daasm788939466b.97.2024.06.20.10.12.27
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 10:12:27 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a63359aaaa6so163707966b.2
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 10:12:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0PgCE6qGDOZp868iUB5UimuGxvJsdYmNgsUiZy2nXJGuNhChblT4/XOyL5WcRfLueFNSREmrJbTME7rMgfYnZU7h8
X-Received: by 2002:a17:907:c24d:b0:a6f:c0e0:5512 with SMTP id
 a640c23a62f3a-a6fc0e055c5mr194825666b.23.1718903526779; Thu, 20 Jun 2024
 10:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wg8APE61e5Ddq5mwH55Eh0ZLDV4Tr+c6_gFS7g2AxnuHQ@mail.gmail.com>
 <87ed8sps71.ffs@tglx> <CAHk-=wg3RDXp2sY9EXA0JD26kdNHHBP4suXyeqJhnL_3yjG2gg@mail.gmail.com>
 <87bk3wpnzv.ffs@tglx> <CAHk-=wiKgKpNA6Dv7zoLHATweM-nEYWeXeFdS03wUQ8-V4wFxg@mail.gmail.com>
 <878qz0pcir.ffs@tglx> <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg88k=EsHyGrX9dKt10KxSygzcEGdKRYRTx9xtA_y=rqQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Jun 2024 10:11:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
Message-ID: <CAHk-=wgjbNLRtOvcmeEUtBQyJtYYAtvRTROBy9GHeF1Quszfgg@mail.gmail.com>
Subject: Re: [PATCHSET v6] sched: Implement BPF extensible scheduler class
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Tejun Heo <tj@kernel.org>, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, bristot@redhat.com, 
	vschneid@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@kernel.org, joshdon@google.com, brho@google.com, pjt@google.com, 
	derkling@google.com, haoluo@google.com, dvernet@meta.com, 
	dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com, 
	changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com, 
	andrea.righi@canonical.com, joel@joelfernandes.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 19 Jun 2024 at 22:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And scx_next_task_picked() isn't pretty - as far as I understand, it's
> because there's only a "class X picked" callback ("pick_next_task()"),
> and no way to tell other classes they weren't picked.

I guess that could be a class callback, something like this:

        p = class->pick_next_task(rq);
        if (p)
        if (p) {
-               scx_next_task_picked(rq, p, class);
+               struct sched_class *prev = last->sched_class;
+               if (class != prev && prev->switch_class)
+                       prev->switch_class(rq);
                return p;
        }

and that would be arguably much prettier. But maybe I've
mis-understood the reason for that scx_next_task_picked() thing.

Tejun?

             Linus

