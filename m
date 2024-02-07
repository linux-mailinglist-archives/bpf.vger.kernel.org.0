Return-Path: <bpf+bounces-21451-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C496C84D624
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD7E289723
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6019535B1;
	Wed,  7 Feb 2024 22:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+DzCNz9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A754D20321
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 22:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346609; cv=none; b=rW2Hqf/UYmrKWsTKt6/oSweYvneIXUUE3A6G4k+aYQndtksJttlqmRLVz+btmHm8CBssbQHTwmAF8qFd1fIZlIY3KAt5LEUG0y3RVdVsIuVO7eV6c5D4ASoSs4kjpZBGk+ch1j+J8UP1e+T230PNSbmBXLiOJCJRiG8Sp90mHuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346609; c=relaxed/simple;
	bh=OK+VTDZJJCtIWyFJN8CVHNQbxrZLtV28vR6V+z8TYBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rcAurwsFiMX+rcI1uWy0xpjwzEbvzF83GvwgFyXiucF3A+ckRWhlT/HRMz2Vl9K9MJy1uioJs8Rl1xj9Cw2rjm7IcClr4z2Z1OzNWi9JLOr7SHQIM5OtZjFE57+c31ocOd204Ks0GATbG9RFpvLodeiDZxZJxpCTHFrkcn/n/MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+DzCNz9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b401fd72bso962881f8f.3
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 14:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707346606; x=1707951406; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OK+VTDZJJCtIWyFJN8CVHNQbxrZLtV28vR6V+z8TYBI=;
        b=T+DzCNz90ikWAce5v+sCzWZUc86lOGlHCCbQ9h5ntluGcGVDXQeJb2OJdaiiCFE634
         TRht0yYrzTV8MIvwnCHKJXdT15eXIbdCE6HQcLrokK3yyeHybCCosfVgKpiImtsWdyXV
         L1nUYoR2uOJ5XVq0ueM9wH8iZJji8t7VLC0IwozVOsE8/WVd0LFc4p9xo4yVgfSgWthf
         K4uhdXsf4q4Vp5AJBuR+wSIMkFVJFbXCsjHcPDyjVoRNlFAVKj1dao4tcPOrh5p5OAIR
         ls7V3piDanrx4vMwgiQLgUuM0bUe/bAaOxlkSl2dgCC8taB8tX9TKlFxtIxNXK28VzFY
         BnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707346606; x=1707951406;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OK+VTDZJJCtIWyFJN8CVHNQbxrZLtV28vR6V+z8TYBI=;
        b=CroYU6Dd/6jWeiICR3Ej4T7N3Mq+cIiaXKJ1wAS2R1she5SFiMITtuDhkDigAmVxhf
         ZpJMk4kkgcN4TGc1Zeb1mq/TpyNepIFutXSyG7BNSF7hNjQ1axRaEgpWhDwWLkXXw5lb
         EQvcx1+zfWxEzdxOhW5T2fu8d6+h1KRHaYgBxcxSA1mBsTPkEm0DdDPYbuTf0nLw8Sxv
         +IdKwJrolEdqccqferWZRMcW0NE43x8GfqDMjj174LEMTa843dIt/hV4YcX1ev8XpjCD
         pG6ouuHc0M3Uyr1RPQCe/nQiLT+ZLfvt6aiYtyzdiJFbqSDq3XEToEWfepETUFHbIVza
         ldWw==
X-Gm-Message-State: AOJu0YyWMtD2jIA4PLDB0bZAQKxuE+O487Sgx2NbNbaJezx2lVGtnoif
	ZJSZvFcg2DKdqp5A2eae8Z13Oi/yZzKh+oldQUrHd4SplmwtURt8s97QlBlLddPNKODt9qPlXmR
	jfBwsPHTnL5ywVOn2HMN4mHMboPc=
X-Google-Smtp-Source: AGHT+IHCNtIWRNMZd8kUwATYtFPf0aFWsfLhxTpQwaWCml4oeBCSv5XTKuuJdHmIZ+hzHrmi14NWGbd0ViEfBgOsN90=
X-Received: by 2002:a5d:4452:0:b0:33a:ff90:77ca with SMTP id
 x18-20020a5d4452000000b0033aff9077camr4136333wrr.29.1707346605633; Wed, 07
 Feb 2024 14:56:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206220441.38311-1-alexei.starovoitov@gmail.com>
 <20240206220441.38311-4-alexei.starovoitov@gmail.com> <30a722f3-dbf5-4fa3-9079-6574aae4b81d@lucifer.local>
In-Reply-To: <30a722f3-dbf5-4fa3-9079-6574aae4b81d@lucifer.local>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 7 Feb 2024 14:56:34 -0800
Message-ID: <CAADnVQKqeaHyy010u0ZuXbApd3+8BEztnED37p0oC74+qGgd1w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/16] mm: Expose vmap_pages_range() to the rest
 of the kernel.
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 1:10=E2=80=AFPM Lorenzo Stoakes <lstoakes@gmail.com>=
 wrote:
>
> I don't know what conventions you bpf guys follow, but it's common courte=
sy
> in the rest of the kernel to do a get_maintainers.pl check and figure out
> who the maintainers/reviews of a part of the kernel you change are,
> and include them in your mailing list.

linux-mm and Johannes was cc-ed.

> On Tue, Feb 06, 2024 at 02:04:28PM -0800, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > The next commit will introduce bpf_arena which is a sparsely populated =
shared
> > memory region between bpf program and user space process.
> > It will function similar to vmalloc()/vm_map_ram():
> > - get_vm_area()
> > - alloc_pages()
> > - vmap_pages_range()
>
> This tells me absolutely nothing about why it is justified to expose this
> internal interface. You need to put more explanation here along the lines
> of 'we had no other means of achieving what we needed from vmalloc becaus=
e
> X, Y, Z and are absolutely convinced it poses no risk of breaking anythin=
g'.

Full motivation and details are in the cover letter and in the next commit =
as
commit log of this patch says.
Everyone subscribed to linux-mm has all patches in their mailboxes.

The commit log also mentioned that the next patch does pretty much
what vm_map_ram() does.
Any further details you're looking for?

What 'risk of breaking' are you talking about?

> I mean I see a lot of checks in vmap() that aren't in vmap_pages_range()
> for instance. We good to expose that, not only for you but for any other
> core kernel users?

I could have overlooked something. What specific checks do you have in mind=
?

