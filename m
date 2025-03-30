Return-Path: <bpf+bounces-54908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAE66A75D10
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 00:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B3C3A8B97
	for <lists+bpf@lfdr.de>; Sun, 30 Mar 2025 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2441D9A5F;
	Sun, 30 Mar 2025 22:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="E6do1gsP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B37DA6D
	for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 22:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743372514; cv=none; b=t7x/7zC9Q6TAd1hfrpYJpudl5WPAiVf9vtgyi9+KXeH407ULB4nQAYAgco3yfRz3aWhtIVE12BeHncz9m6Il6yllXuGFQLX8/9g2bnxsHvBYOtyiwEq3qMPvRR5sTZhGhbKlAnzi3/Fz/4sBZRALLuGfjF1DwJ0LLhUXy3uzJTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743372514; c=relaxed/simple;
	bh=8/up8ty56Gdo4JOnj5iSPSmEQbPaQTC9OAhfGjjhL4M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OiwUs42/pcl3i2nQg/+RIEy0q+9QatMG0Cg0BNhP0GUbyH7+je0WU7t0ySmcKucjtYzDmXEFbLVvn7jo/wUld4Yy86GoyA6RLi21P+eIpRtSudpRzjcfSRbEpwfWrDmAbOWnRxZSFQoKPf5SE0zmNRTpqYvKb1za5qzs+A11aOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=E6do1gsP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac34257295dso760552866b.2
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 15:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743372510; x=1743977310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HN6VVHsTfsHAxtBYzmbWQnn6fGWAOX8tYKcrUgnCUww=;
        b=E6do1gsPj+1sezC1Xgqt0z4Lb4kF/XHN2JbFPUPJZ/PuMnGdXGreTPlB4wax4YnCTn
         tOlt0rOXvd/Jzj9ZOYyhGyg+C5yAQ3UYW6l4eUBXfxOa6NoeKXlNjY2s1bvzOGfJtmwZ
         R3i/RzEb7wVbLvzfWJ4y9kxbsECEWYfHNQULs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743372510; x=1743977310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HN6VVHsTfsHAxtBYzmbWQnn6fGWAOX8tYKcrUgnCUww=;
        b=Uw1uji7ielzUQxZLWOuQqj4+3HHtpZlZM3ALRdCbhsLk1vPTzNaeLrTdQVPzegXwQd
         d9wGUsddrm8+dfcRYUpjRVToNQvM1RZQspxksV5Z4nSaZMIE+Y3M1a9WOZAE5FmQUlgj
         m0tQ42hp7B8kxkr9jO+vfUWC+Yj4hT6SZ/v/RINAprcJUoHCkCg/opwVWlsd3inryx1z
         W5Kb4p8CMR464L8edvN4HCsCMDrJZ4mPQBqIZnR68A83Em9A9IzdKX5/Cb09BDG/qt0A
         TAS1TvvE/4v6rTDEpfSvZuXSEXgEJTwyh+AQufSeUl6KW4V8GtR5Y8J4JK0wIn/5e2vE
         LoDQ==
X-Gm-Message-State: AOJu0YzH2yx9x5/kIQy/+tZFWilHHd1LFpWYcvPi4oPki28HVcAMSPPN
	MQmu2D1nzGvqCE13wiNTiYfC4Eofe9ckeUI6JRgtn6tmWGCcEGBSyD9A38+oNWhLU5rcKduxEGk
	fZxg=
X-Gm-Gg: ASbGncstDxBVQRA+tNUeZqI8WgrJrUcNc1E1vSfc9CWXWsNq3LB12SW6ZW/NfLYAwDZ
	fF5YEqa3LHC4PMSRZK75i8ez96w5FKBxSMwTCix9k3R9m3YdmEvXDotkF5OljYwodlkWAnFS1Br
	GLKzZYISDT+ZJ2vQmmhZI1aeJCE+501b+YMP0aXD3QUt7MheHqtsMRh0cmFHesjUT4WW06gaFIa
	nnwpjkFTNg1OaYRyOlJZUP9ZSpr1AvDDWMLD7+EYeSFVvn2DSsiTTBDafi7qjF4p7tIw2ZWydmY
	pJSFtBXi6Ot/1AiqhZi5duVxvjuf2JUQ4SHx5uilmCC5MKJzgChGgeA/YR74/VyL+FC9XeUlDve
	l3L6PnkJmoO5EikeY4B8=
X-Google-Smtp-Source: AGHT+IHhvpofdMbnZ6GeMtbtry99Y6Q6EmGnBT8xqmPTe0SaikWQXpZUfppy5VoqhxKMC8PqV4E+6g==
X-Received: by 2002:a17:906:c108:b0:ac7:1608:53df with SMTP id a640c23a62f3a-ac738bfee65mr653926066b.57.1743372509939;
        Sun, 30 Mar 2025 15:08:29 -0700 (PDT)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f04dsm535256666b.91.2025.03.30.15.08.28
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Mar 2025 15:08:28 -0700 (PDT)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e0caa151so7372515a12.0
        for <bpf@vger.kernel.org>; Sun, 30 Mar 2025 15:08:28 -0700 (PDT)
X-Received: by 2002:a17:906:d551:b0:ac7:333a:a5bb with SMTP id
 a640c23a62f3a-ac738bac9b1mr589608766b.39.1743372508372; Sun, 30 Mar 2025
 15:08:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
 <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com> <CAADnVQJBHPbq6+TQhM2kmWNBTiPoB50_fnVcwC+yLOtpjUWujA@mail.gmail.com>
In-Reply-To: <CAADnVQJBHPbq6+TQhM2kmWNBTiPoB50_fnVcwC+yLOtpjUWujA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 30 Mar 2025 15:08:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgpYOGdQ+f62nbAB4xKLRbxnuJD+2uPBmRzSWCo5XkEGA@mail.gmail.com>
X-Gm-Features: AQ5f1JrL0HE_uuGJo6f5HMFn8GluWXQ592_aB8vmPzkng5al8ToIkAF8po4Fdwg
Message-ID: <CAHk-=wgpYOGdQ+f62nbAB4xKLRbxnuJD+2uPBmRzSWCo5XkEGA@mail.gmail.com>
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Michal Hocko <mhocko@suse.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Mar 2025 at 14:30, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> But to avoid being finger pointed, I'll switch to checking alloc_flags
> first. It does seem a better trade off to avoid cache bouncing because
> of 2nd cmpxchg. Though when I wrote it this way I convinced myself and
> others that it's faster to do trylock first to avoid branch misprediction.

Yes, the really hot paths (ie core locking) do the "trylock -> read
spinning" for that reason. Then for the normal case, _only_ the
trylock is in the path, and that's the best of both worlds.

And in practice, the "do two compare-and-exchange" operations actually
does work fine, because the cacheline will generally be sticky enough
that you don't actually get many extra cachline bouncing.

So I'm not sure it matters in the end, but I did react to it.

             Linus

