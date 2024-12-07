Return-Path: <bpf+bounces-46344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FE19E7D8F
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 01:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101F918868A5
	for <lists+bpf@lfdr.de>; Sat,  7 Dec 2024 00:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030664A32;
	Sat,  7 Dec 2024 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jXmbjNnt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8040323D;
	Sat,  7 Dec 2024 00:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733531823; cv=none; b=k7LQGpb//avDVEXDh0DFXUG2o4zFyIMVmNq01Rq7n5dkjRbxHYAFO3xpy/43wvSGUU7kT8jFT/xub2vawkrxRfVdGhvf8w9OlmCHwf8OXSn8ZNHOYfYzlvt9utgSzhxuafSdI9FozhlI1wKcqnLGRKdLOdtbd0CemM31+6Xdf6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733531823; c=relaxed/simple;
	bh=4v/g6p9bm5VE9Uqc0MZZdMVYArqzj8HxOKi4sN82eUI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P++0Rw0f8TAOZIBJQiOGEVLx+of9S4lRLU/xx7l1yxrlgOwFFf+18K5bsMDKtwfFOnaLHmaBfY1VYc3S3jM4J3cbitzAIBrVBB7DrpeCShzmuiH7uUuDIvY2vQ4pGuL4rB7MiXNTrjpTCaj0G58HSc9eZOAeYw8CcQD9DLZUTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jXmbjNnt; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso322541f8f.2;
        Fri, 06 Dec 2024 16:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733531820; x=1734136620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MRtBz9IVDwZq/k8TTptrZHd1V9qsQPyT+qMfRgVRflE=;
        b=jXmbjNntQbYk7Nt9O5+fGIjdbpR0AgyJ21ohBxSCEcOAPSlyxQVKRtxMzdfWL5cuJv
         B/SPlYYXO0hgPnzu+zXFpuc0jUY1YmH9CYw3aACCs2VBaDjpu6KyA8ovojGVr5VduJFk
         jH/eOQ+lFIWMmkt2aF1WmzGzM0yob1jd8i5UfwpKA1rgpneQatduImf9dV5742R72jUR
         s/09MSePWGdmBwXdEt7l8rjpHnNSPSIYy81R4524MNWkZvZz/lZNz5ytETMpB/DBuFb6
         3uOW9vXFkFsXQlMdmC8qngsIYLg6mATaUim1UHHeWe98I+q2sTFxmBe2V5ccmDJMOn4j
         p/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733531820; x=1734136620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MRtBz9IVDwZq/k8TTptrZHd1V9qsQPyT+qMfRgVRflE=;
        b=i4RdW6h3cPcpo0+Iv/ipPqM8RtHEl7aX7ZqsnzypyB6+n9L+nSV78fUcZ68OttAJ9Y
         45mwTk1+2RfBTLHilLYmyRFc3iPElzTS2F7pmNvhwvSNyxFJUk12zoPM07saV1Popfa6
         FN1ewCQfTRtDOzsIvmCVV0Rj536Ti7LP2F8uicSRzO8oMk7N2CTRWTjTORDanW/Iliei
         VhgyK6DbNhbn4w9O1D+xyQK7sj5yEeWuHK4cUamHazGddbYsguvV8MfRzJnNZaZP8l25
         ky3J4qknyOCfh+Q/Nw7ioCsiuNfm6LwvcEiDFxCwdwSDaUeyO3J72cGEAUibxOTXYQ83
         bAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV4WvOTDtLw6TW4VeXbj9BJOBTNw33tJrSgfGWppcC2JeU67kxKLizpgou2t0q22r1Nvrp4fz1iVvhSzx+@vger.kernel.org, AJvYcCWEIRSulvI6tTWLXYp1UV4K9SacAskYvkwBbpxjMW6j6ZWUnNqixZdLtx91WptIGan4wZ4/YVqkkA86gyHVi7W3ovPt@vger.kernel.org, AJvYcCXfNdkad2T8Jel7FDEMee2FLU6JiI3TWBnHEt+WkEFsG+l4I+c2BTownmQ4fV4uY3LSUG0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi92exHZSizSFlF6ky4FCYMvueissWa4Q6LqMyvBigmm7psGPV
	OyAzwSy8zEHSLrtwnsNNqlk59x2AygmZblAsky5kYRD3ugJ0Y90O
X-Gm-Gg: ASbGncvH4MyimvxqwWHwQIujO7w+KKoELWaVZ0Y2yrCs7MKYufbTJv///zKSXFXbtwb
	f4Go/VSZiFvp79GYWyhdNNNMBl0F2DKE4Jh28CejYfkUI5oaB6T4NIoLQ+Nk+7ffgOgt56mK4kS
	0Esxln3U1W+psc6g/BMe8WIFC4dVKnAuO9b+MSMUt6SzCakpjBGbGDdY9xwV9jQG0dIHMXeuGol
	eXEsUwKRJdTJDdDKfSkBzzW79W7GGWeOYUuTxwOT+YfMMT5W3UzpnLYJ8w=
X-Google-Smtp-Source: AGHT+IHw9aQbBADSr5fU8WMK/7f3LcmY1FUeT/tHdWPZC+W5EhlCLK222wEuL6CyqafKGnlFtP3rkw==
X-Received: by 2002:a05:6000:470c:b0:385:f909:eb2c with SMTP id ffacd0b85a97d-3862b3ce0e8mr4205449f8f.38.1733531819788;
        Fri, 06 Dec 2024 16:36:59 -0800 (PST)
Received: from krava (85-193-35-130.rib.o2.cz. [85.193.35.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3862e3fe716sm2377173f8f.7.2024.12.06.16.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 16:36:59 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Sat, 7 Dec 2024 01:36:57 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	mingo@kernel.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, liaochang1@huawei.com,
	kernel-team@meta.com
Subject: Re: [PATCH perf/core 4/4] uprobes: reuse return_instances between
 multiple uretprobes within task
Message-ID: <Z1OYqdCZXXbNGEE8@krava>
References: <20241206002417.3295533-1-andrii@kernel.org>
 <20241206002417.3295533-5-andrii@kernel.org>
 <Z1MFBVRuUnuYKo8c@krava>
 <CAEf4BzaESrHfAXZrN0VbjQvxLJ0ij0ujKpsp2T6iQtbisYPa=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaESrHfAXZrN0VbjQvxLJ0ij0ujKpsp2T6iQtbisYPa=A@mail.gmail.com>

On Fri, Dec 06, 2024 at 10:00:16AM -0800, Andrii Nakryiko wrote:
> On Fri, Dec 6, 2024 at 6:07 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Dec 05, 2024 at 04:24:17PM -0800, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > +static void free_ret_instance(struct uprobe_task *utask,
> > > +                           struct return_instance *ri, bool cleanup_hprobe)
> > > +{
> > > +     unsigned seq;
> > > +
> > >       if (cleanup_hprobe) {
> > >               enum hprobe_state hstate;
> > >
> > > @@ -1897,8 +1923,22 @@ static void free_ret_instance(struct return_instance *ri, bool cleanup_hprobe)
> > >               hprobe_finalize(&ri->hprobe, hstate);
> > >       }
> > >
> > > -     kfree(ri->extra_consumers);
> > > -     kfree_rcu(ri, rcu);
> > > +     /*
> > > +      * At this point return_instance is unlinked from utask's
> > > +      * return_instances list and this has become visible to ri_timer().
> > > +      * If seqcount now indicates that ri_timer's return instance
> > > +      * processing loop isn't active, we can return ri into the pool of
> > > +      * to-be-reused return instances for future uretprobes. If ri_timer()
> > > +      * happens to be running right now, though, we fallback to safety and
> > > +      * just perform RCU-delated freeing of ri.
> > > +      */
> > > +     if (raw_seqcount_try_begin(&utask->ri_seqcount, seq)) {
> > > +             /* immediate reuse of ri without RCU GP is OK */
> > > +             ri_pool_push(utask, ri);
> >
> > should the push be limitted somehow? I wonder you could make uprobes/consumers
> > setup that would allocate/push many of ri instances that would not be freed
> > until the process exits?
> 
> So I'm just relying on the existing MAX_URETPROBE_DEPTH limit that is
> enforced by prepare_uretprobe anyways. But yes, we can have up to 64
> instances in ri_pool.
> 
> I did consider cleaning this up from ri_timer() (that would be a nice
> properly, because ri_timer fires after 100ms of inactivity), and my
> initial version did use lockless llist for that, but there is a bit of
> a problem: llist doesn't support popping single iter from the list
> (you can only atomically take *all* of the items) in lockless way. So
> my implementation had to swap the entire list, take one element out of
> it, and then put N - 1 items back. Which, when there are deep chains
> of uretprobes, would be quite an unnecessary CPU overhead. And I
> clearly didn't want to add locking anywhere in this hot path, of
> course.
> 
> So I figured that at the absolute worst case we'll just keep
> MAX_URETPROBE_DEPTH items in ri_pool until the task dies. That's not
> that much memory for a small subset of tasks on the system.
> 
> One more idea I explored and rejected was to limit the size of ri_pool
> to something smaller than MAX_URETPROBE_DEPTH, say just 16. But then
> there is a corner case of high-frequency long chain of uretprobes up
> to 64 depth, then returning through all of them, and then going into
> the same set of functions again, up to 64. So depth oscillates between
> 0 and full 64. In this case this ri_pool will be causing allocation
> for the majority of those invocations, completely defeating the
> purpose.
> 
> So, in the end, it felt like 64 cached instances (worst case, if we
> actually ever reached such a deep chain) would be acceptable.
> Especially that commonly I wouldn't expect more than 3-4, actually.
> 
> WDYT?

ah ok, there's MAX_URETPROBE_DEPTH limit for task, 64 should be fine

thanks,
jirka

> 
> >
> > jirka
> >
> > > +     } else {
> > > +             /* we might be racing with ri_timer(), so play it safe */
> > > +             ri_free(ri);
> > > +     }
> > >  }
> > >
> > >  /*
> 
> [...]

