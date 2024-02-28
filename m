Return-Path: <bpf+bounces-22845-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BF186A874
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 07:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC49282623
	for <lists+bpf@lfdr.de>; Wed, 28 Feb 2024 06:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C7022EF9;
	Wed, 28 Feb 2024 06:40:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3851222612;
	Wed, 28 Feb 2024 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102412; cv=none; b=rBTcLCmWcVqea9QMahd4J4NpeLkp45H5o8C74S/kL+SUIKvwiwRYRnsZcvunc4rHWsmVA/n3caoTCWVBMSqW6J8PvX7L0oGjZVhWe+7Xc7dhn6M0uvuDSmBk1cHwY0te5VFMVrhiOtYyAjekUgjdyJOvXdke7p9+rfQ2wkfUMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102412; c=relaxed/simple;
	bh=xiWevfT9cchx2Vdiysrx4aisTABSvKEIDUCCaMlWVP0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fnE+XdscED0fL3vk0ME4AWDFv2/10c0pW52p1Q1SpMQooFGKcr38rn2Wb1rug7tXBnt9dzLYJjX0sd9iuEAyq0u0wS30tWFzLhtSUfTS+R8bRLneZaSs5TAR65aSRE6fiYhgPzI0tPibtkYQpzWdwz+6ZkN58/ny3lHeO7s3MbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so4248341a12.1;
        Tue, 27 Feb 2024 22:40:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709102410; x=1709707210;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sdhe1qiqnH1mmfeicE2lvag9ei+5O0VGdCXulH5OX0w=;
        b=rdTfjJ3+rdqTQgoq7ksnPNX7lqqN3oNGYl8xthLypwqsLekOwsS83OF+aA3YAa/WLf
         0AD9bvj70opaRY1zEZtjqRfBO6sEOFdpE3r5K46Q9cXWJjCos25D8N4yKwSumP8dIiqZ
         cfmsom8qzOxyZnD1JTf5ABxaBc/wd0uWPtx+QQW0eEhW0+q66oB6X3WT9FrMmnkYZv8E
         L2lWeCzocdGNR0m6djT4QEczKEqOJV6x0KfemOogfpWk7bcfwKHaHNJZfdxbUA9k+HPo
         tLblbTs0ATKpINJ4HvQ/RkP6NJ85OBUj0ATk+eUED2JRrGSPvmGh/NCrhxdoUbGcvXBA
         rBpA==
X-Forwarded-Encrypted: i=1; AJvYcCVW9ZzezROmMOoW/qbH4azGBS8dNwy90+BF9BRI5xExcTyGlMCMV0e4dC4ZWqJD9nV0CNJ64YAneG4/iwHv/SjkmhUamaefVLpxHvO3oOcq1F+GmV9xm/AqmKwIxWywAK4NyCuz4yI7G2gdybGnOhKWwPXOWsQwV1Nugt5yjAQZLC7Gow==
X-Gm-Message-State: AOJu0Yzu1YHpwZtRbiIlAvzZf1O2Bimc002OyXuYYs+hPVbjnFmzhscL
	MmSjpfaqfz7iV8U0JhwIuXguXyWgcdKOzL9bSl0JWJCU8nbZEY/HCsR0R0lWtAh3AZNKj2Mzsk0
	oNuty5AN1DaYNdnPaG3K3djyJfBk=
X-Google-Smtp-Source: AGHT+IFz8gp9rU+LHPN9fpzTEh8XtPMVHKqepBklImKyp7e2bW4iFRgm2xMAL1bD9iLQiSCH08KZ/0xHUwm70IBu4Eo=
X-Received: by 2002:a17:90a:5214:b0:299:2db9:1ad4 with SMTP id
 v20-20020a17090a521400b002992db91ad4mr9005915pjh.40.1709102410283; Tue, 27
 Feb 2024 22:40:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214063708.972376-1-irogers@google.com> <20240214063708.972376-5-irogers@google.com>
 <CAM9d7cjuv2VAVfGM6qQEMYO--WvgPvAvmnF73QrS_PzGzCF32w@mail.gmail.com>
 <CAP-5=fUUSpHUUAc3jvJkPAUuuJAiSAO4mjCxa9qUppnqk76wWg@mail.gmail.com>
 <CAM9d7chXtmfaC73ykiwn+RqJmy5jZFWFaV_QNs10c_Td+zmLBQ@mail.gmail.com>
 <Zd41Nltnoen0cPYX@x1> <CAP-5=fWv25WgY82ZY3V1erUvCb+jdhLd_d91p4akjqFgynvAgg@mail.gmail.com>
In-Reply-To: <CAP-5=fWv25WgY82ZY3V1erUvCb+jdhLd_d91p4akjqFgynvAgg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 27 Feb 2024 22:39:58 -0800
Message-ID: <CAM9d7cjJTf_yed9nwXZkBPr6u6NH5n+V+u0m6Zgsc1JBy_LdyA@mail.gmail.com>
Subject: Re: [PATCH v1 4/6] perf threads: Move threads to its own files
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 1:42=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> On Tue, Feb 27, 2024 at 11:17=E2=80=AFAM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Tue, Feb 27, 2024 at 09:31:33AM -0800, Namhyung Kim wrote:
> > > I can see some other differences like machine__findnew_thread()
> > > which I think is due to the locking change.  Maybe we can fix the
> > > problem before moving the code and let the code move simple.
> >
> > I was going to suggest that, agreed.
> >
> > We may start doing a refactoring, then find a bug, at that point we
> > first fix the problem them go back to refactoring.
>
> Sure I do this all the time. Your typical complaint on the v+1 patch
> set is to move the bug fixes to the front of the changes. On the v+2
> patch set the bug fixes get applied but not the rest of the patch
> series, etc.
>
> Here we are refactoring code for an rb-tree implementation of threads
> and worrying about its correctness. There's no indication it's not
> correct, it is largely copy and paste, there is also good evidence in
> the locking disciple it is more correct. The next patch deletes that
> implementation, replacing it with a hash table. Were I not trying to
> break things apart I could squash those 2 patches together, but I've
> tried to do the right thing. Now we're trying to micro correct, break
> apart, etc. a state that gets deleted. A reviewer could equally
> criticise this being 2 changes rather than 1, and the cognitive load
> of having to look at code that gets deleted. At some point it is a
> judgement call, and I think this patch is actually the right size. I
> think what is missing here is some motivation in the commit message to
> the findnew refactoring and so I'll add that.

I'm not against your approach and actually appreciate your effort
to split rb-tree refactoring and hash table introduction.  What I'm
asking is just to separate out the code moving.  I think you can do
whatever you want in the current file.  Once you have the final code
you can move it to its own file exactly the same.  When I look at this
commit, say a few years later, I won't expect a commit that says
moving something to a new file has other changes.

Thanks,
Namhyung

