Return-Path: <bpf+bounces-49213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 424E1A155D7
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83C6B188D970
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 17:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0441A072A;
	Fri, 17 Jan 2025 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="KJfx41QP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC191A071C
	for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737135417; cv=none; b=j6P7i+26ZDLO+vkN2u8PTXQHvK7yyKYnFoakfcjB5aFPaIJrKnlt+cAOhKaHtts2do4KTcuMRRlld4t6ZlrDKXn0klZaGWwcvQas0uNt4dtDXQPPzgarK7wYa0lZBlpzzbk6wlYtKJwmN+Cs+UsipJze2VJGhCXd0tlzGoo+Fug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737135417; c=relaxed/simple;
	bh=a96zl8g16GHY09Z4zOKis3TmpUulJ6y2yUf5Tx5WcK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVhBiC4DUl6+5KACyjzpL7MQvcuboaTEdEtOaXOvTQVhu+15TlMGtEbaX3MKdd4eG5btXtLldiQsf8wdGeL7fHBpp9kSXk8gxmzbA7TIe8OWmAXwsOxT0mcarQpjfLipiy8KDodgQoHC9ilt5lc5TVHUn2bFfmum7vHE81GO0aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=KJfx41QP; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467725245a2so24582901cf.3
        for <bpf@vger.kernel.org>; Fri, 17 Jan 2025 09:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1737135413; x=1737740213; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7Rb8h7iwsxGtB2Jxx9CB8AY9s5fwogb7DDAbIS4Jt8Q=;
        b=KJfx41QPZO0O0ZZu/A2U+yK8GhvRz+f56sN5AWxSHKF1/veCUrttmvMLqY5TMAkbGa
         2iAQVijHV/tsM2QWkLxE9VLHPUMvVKnhdpinNrKLnKx6ivCMnbNYg6ix6CsF2b39P5JB
         qRtf0iSr4c3fsXSLLYDtsWwes3W1mg3XlD7TyuhhwY91atxn/tjhLf5ttX0pbG1O59sM
         CbKZYVrm6MPAfYwEUF0H1eYLOt7YXWpBI2pkyX71zAOgO7VgGt7xmuQK9l5DGqhi3/AJ
         pjHCJn9QqHmVUKsuNYOwnOK3Hq3XMqHr9qogePCEIyLp+2yKSjrdTLK67CrWKhQNlI2S
         FXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737135413; x=1737740213;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Rb8h7iwsxGtB2Jxx9CB8AY9s5fwogb7DDAbIS4Jt8Q=;
        b=E+br5Agbe/1PbBcwRKv5oTcfQcrelr/Ilm2plIpZ2RDyECxq3RIkVa7EK7tGD/ppIB
         DxVVBs9IdVbzeZbAJSyLpSrK41wzSv4H8YdrcEPRL5D8sIC5Gc18eGlBMSrCUrv7rwNu
         7cwm8h0uCpettELYd/YnexQhFlC8o5YnWKX+8A4w04tsbwjDqMavNc2bnZD8m1FbocD8
         /YIndiBqPKeOhd+eRjpmU4UxOWtPsOw2j2C/p1HreVK8DDcsHbzfK4uX/Jg3iLoNaJO3
         tqjEYFIPa3XgIGdyKngUn2EtneJSPjcAydpyuzv1CzBs6PWu68YRFL9CzxqM/mqhpXor
         ki1A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ17wE6FFbEWBXz4lSYgMf8yr538Rpd/ZDN8v9BIFhjP6fMbAUJ8kkHMByMD+LWJ0djzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXHCVkGac7Bg/0w54S8qc1ncrieN6UbqcFAJtrkt2DIgqccjZ
	usb5j68qkGOrhEHY2x8nyvQ5UxtNIrfrGQb8YNTWLnj8IIbcNzqOPPAFAIlzNIA=
X-Gm-Gg: ASbGnct3UgaBh2KbvvPRgM6E1Gm56fZYbl5pqddYxq7wUTxP4LEep0agcXYcA6lxxfw
	quN1LhsALP1wipCC2ZX36LxSDB388DAQCR06tOqEvJ6wnkERUGqx2vO5wHHnzVLGYYSJHOXEjNo
	PigqZjw4x3YyE35Mk4n7UOGUuJdiOaL6182okFzIAYJjC8oFuedLyfaYvg8PBN/V6Y0suH11HVU
	WLdqqbB6sYLqhEl2JyuyH8mM3vsbWJyKxL541i5tSiL36YvLy0c1Hg=
X-Google-Smtp-Source: AGHT+IFP0vyEHf5uMK9mcP5ikvQCVxFQj9kliA9F6BCDOqUWAwOXEM0bkwrK3Boz183wkDpCcShmlw==
X-Received: by 2002:ac8:5fc4:0:b0:467:5734:d08b with SMTP id d75a77b69052e-46e12abc7dbmr62165531cf.31.1737135413585;
        Fri, 17 Jan 2025 09:36:53 -0800 (PST)
Received: from localhost ([2603:7000:c01:2716:f0c4:bf28:3737:7c34])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-46e102fc99asm13531981cf.29.2025.01.17.09.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 09:36:52 -0800 (PST)
Date: Fri, 17 Jan 2025 12:36:49 -0500
From: Johannes Weiner <hannes@cmpxchg.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	SeongJae Park <sj@kernel.org>,
	"open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
	linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Sebastian Sewior <bigeasy@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>,
	Tejun Heo <tj@kernel.org>, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v5 4/7] memcg: Use trylock to access memcg
 stock_lock.
Message-ID: <20250117173649.GH182896@cmpxchg.org>
References: <CAADnVQLEfjETi+L3PXwTz7i+MnT4FT1ohoAL555N_Mdhd+vqBg@mail.gmail.com>
 <20250116200736.1258733-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250116200736.1258733-1-joshua.hahnjy@gmail.com>

On Thu, Jan 16, 2025 at 12:07:28PM -0800, Joshua Hahn wrote:
> On Wed, 15 Jan 2025 18:22:28 -0800 Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> > On Wed, Jan 15, 2025 at 4:12 PM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> > > On Tue, Jan 14, 2025 at 06:17:43PM -0800, Alexei Starovoitov wrote:
> > > > @@ -1851,7 +1856,14 @@ static void refill_stock(struct mem_cgroup *memcg, unsigned int nr_pages)
> > > >  {
> > > >       unsigned long flags;
> > > >
> > > > -     local_lock_irqsave(&memcg_stock.stock_lock, flags);
> > > > +     if (!local_trylock_irqsave(&memcg_stock.stock_lock, flags)) {
> > > > +             /*
> > > > +              * In case of unlikely failure to lock percpu stock_lock
> > > > +              * uncharge memcg directly.
> > > > +              */
> > > > +             mem_cgroup_cancel_charge(memcg, nr_pages);
> > >
> > > mem_cgroup_cancel_charge() has been removed by a patch in mm-tree. Maybe
> > > we can either revive mem_cgroup_cancel_charge() or simply inline it
> > > here.
> > 
> > Ouch.
> > 
> > this one?
> > https://lore.kernel.org/all/20241211203951.764733-4-joshua.hahnjy@gmail.com/
> > 
> > Joshua,
> > 
> > could you hold on to that clean up?
> > Or leave mem_cgroup_cancel_charge() in place ?
> 
> Hi Andrew,
> 
> I think that the patch was moved into mm-stable earlier this week.
> I was wondering if it would be possible to revert the patch and
> replace it with this one below. The only difference is that I leave
> mem_cgroup_cancel_charge untouched in this version.

Let's not revert.

This is a bit of a weird function to keep around without the rest of
the transaction API. It doesn't need to be external linkage, either.

Alexei, can you please just open-code the two page_counter calls?

