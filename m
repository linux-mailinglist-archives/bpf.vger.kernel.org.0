Return-Path: <bpf+bounces-37887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5749E95BD63
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1621F22135
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D9E71CEADA;
	Thu, 22 Aug 2024 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbE7+FBS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB301CCB36;
	Thu, 22 Aug 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724348151; cv=none; b=QtbiVCg7QuXNzUi15o6BgP2SgECRxblRvfitJ57bg+uIyu1EuNhSR1WpSnkuCdEqC06p9Y6eHRqJj1GbXHpFC2rpEeG79M5xOtWmU4euzNS7phxzTfQt8vkfIcbF61OYph+H2bpyTCW9E1aWA1HEbY2Aic31h5G/TkTapQhuKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724348151; c=relaxed/simple;
	bh=0cjZRWio38h6TVJuWmOEQeTFBkW78OpMzIj8gruOkJ8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhqLwbzVS2TaobNXVQjco5prMlRlERZ+sr0hi7Ul5DtXubtr6CmvIysM5prk5jOnKXqPtqvwe82H8IHlkDkwUojAnM8LGtVMRwb/5ZSxhHahIkKuRQBzujJZMdscUChnDkpUI1lwdnaWr3z7lf3UAUETUNJ1fK8Sym3Iy+fFWX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbE7+FBS; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so106775166b.1;
        Thu, 22 Aug 2024 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724348148; x=1724952948; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xkghB6aOOio8GGfQ7tQKfRPcfOy2NJ6+od2KQKax6X8=;
        b=FbE7+FBS4J3LdKnu0h00CUgDBqixEYANqQdtzJui2Lfj75+Au4savbECNReWKikBPT
         BsIUcKPeGTdR1OEdiWjoBToApgrjPV61dZf6BKF64wxGL70t+yrKMFfRlF/Gr60rhEKl
         5/xxpyq8TpEuPSxyLAUY9Eo7KR6luxDxQN7UwMBUVmw7yy66xVoXRHc//EM39fEcPsnn
         SpMjyM1TVW2VbbBgGerIxUc+W6z5jJmSxCsphtePZLLCmXiV52ewo+7WPZ8TZLEFr4DW
         DFnZSJFADlV2aXuoDa3fY6PeORQ++J3VXT/KJJyVMjfI8ZSdPwM5jT0IIk61VFilY2jY
         +Pkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724348148; x=1724952948;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkghB6aOOio8GGfQ7tQKfRPcfOy2NJ6+od2KQKax6X8=;
        b=PKWDNMHcgd8afUo0dUsMquF+/FulDDP3qKXSgGhTSIJToHQXQSe9NoycedPGZAbsIL
         cOqqiXVjjPcN6lp7i/iLL6y4J4CQksdtuSnyPRRu0btMjPqCKhTbD01pSpu2eSqWuEI1
         +eZXGzJf48BQg1qi6Vg/ocuoYRoxMkAYfs2jeox1CnrpE60fG7YjUbhCfn/pmBAyiwG4
         25yAgn9t0fhPQbgVEGIqs4BQ1xcNUkp289SKgyrGAn2rnGfgpX7IhfwfZpKPFey2HQVA
         WhJXgsQtv0KIilWXEin5fOQ7o3+9MY4ccIGgBqgCtATEie7CoI1V2cZt29WlubcWZmbt
         AelA==
X-Forwarded-Encrypted: i=1; AJvYcCVVGmYUzkyoBfnLmXeyODJnxsTNfbKmBaEsRJ78PeUWXyAmD33iQQxZH+rZY3qXw+uG7Kuy7vAMWJq0WGGo@vger.kernel.org, AJvYcCWNWlCFbyFkIOTwUBAW+qSFBb32yBxPdczlnhjrAUqqAjYvFyAR5ngeMRkwk9Twch5bm4U=@vger.kernel.org, AJvYcCXZkrCnmTeM0Uwz3KvHkNkIunHoy7jNOFvXwln3Bu2hy/M7dODksQl5ctAo3vX+FN7XzSfqoN74q2ft6FAV+2O9CCGv@vger.kernel.org
X-Gm-Message-State: AOJu0YzTvMUM02pv/YmNrx2PktWFpngrbVrXn5kzKfwmjjFnTnbhEPHT
	Mjq+lhuZBOabZIGcVHqKfG8PC+PTIyDYLXXjlBYbk9FfaFrfiStZ3oOzUA==
X-Google-Smtp-Source: AGHT+IG13gU20y3TlIQxwweTw3gebAPEJD5PFbgA33AGSYwPcKHrWQnQCve7QM97eDQ02yrRkx83NQ==
X-Received: by 2002:a17:907:96a3:b0:a86:78ef:d4ad with SMTP id a640c23a62f3a-a8678efd649mr496048566b.20.1724348147459;
        Thu, 22 Aug 2024 10:35:47 -0700 (PDT)
Received: from krava (85-193-35-108.rib.o2.cz. [85.193.35.108])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f48a77asm144168466b.180.2024.08.22.10.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 10:35:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 22 Aug 2024 19:35:45 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, peterz@infradead.org,
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	paulmck@kernel.org, willy@infradead.org, surenb@google.com,
	akpm@linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 04/13] uprobes: travers uprobe's consumer list
 locklessly under SRCU protection
Message-ID: <Zsd28aEHBLkRpUQs@krava>
References: <20240813042917.506057-1-andrii@kernel.org>
 <20240813042917.506057-5-andrii@kernel.org>
 <ZsdJuwIuJ-KFA6Rz@krava>
 <CAEf4Bzb-1na=S9+XVpEpmtDE4mJLQRywZJ6wB8JyN++2Si6Pgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzb-1na=S9+XVpEpmtDE4mJLQRywZJ6wB8JyN++2Si6Pgw@mail.gmail.com>

On Thu, Aug 22, 2024 at 09:59:29AM -0700, Andrii Nakryiko wrote:
> On Thu, Aug 22, 2024 at 7:22 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Mon, Aug 12, 2024 at 09:29:08PM -0700, Andrii Nakryiko wrote:
> >
> > SNIP
> >
> > > @@ -1125,18 +1103,31 @@ void uprobe_unregister(struct uprobe *uprobe, struct uprobe_consumer *uc)
> > >       int err;
> > >
> > >       down_write(&uprobe->register_rwsem);
> > > -     if (WARN_ON(!consumer_del(uprobe, uc))) {
> > > -             err = -ENOENT;
> > > -     } else {
> > > -             err = register_for_each_vma(uprobe, NULL);
> > > -             /* TODO : cant unregister? schedule a worker thread */
> > > -             if (unlikely(err))
> > > -                     uprobe_warn(current, "unregister, leaking uprobe");
> > > -     }
> > > +
> > > +     list_del_rcu(&uc->cons_node);
> >
> > hi,
> > I'm using this patchset as base for my changes and stumbled on this today,
> > I'm probably missing something, but should we keep the 'uprobe->consumer_rwsem'
> > lock around the list_del_rcu?
> >
> 
> Note that original code also didn't take consumer_rwsem, but rather
> kept register_rwsem (which we still use).

humm, consumer_del took consumer_rwsem, right?

jirka

> 
> There is a bit of mix of using register_rwsem and consumer_rwsem for
> working with consumer list. Code hints at this as being undesirable
> and "temporary", but you know, it's not broken :)
> 
> Anyways, my point is that we didn't change the behavior, this should
> be fine. That _rcu() in list_del_rcu() is not about lockless
> modification of the list, but rather modification in such a way as to
> keep lockless RCU-protected *readers* correct. It just does some more
> memory barrier/release operations more carefully.
> 
> > jirka
> >
> >
> > > +     err = register_for_each_vma(uprobe, NULL);
> > > +
> > >       up_write(&uprobe->register_rwsem);
> > >
> > > -     if (!err)
> > > -             put_uprobe(uprobe);
> > > +     /* TODO : cant unregister? schedule a worker thread */
> > > +     if (unlikely(err)) {
> > > +             uprobe_warn(current, "unregister, leaking uprobe");
> > > +             goto out_sync;
> > > +     }
> > > +
> > > +     put_uprobe(uprobe);
> > > +

