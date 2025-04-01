Return-Path: <bpf+bounces-55103-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A0DA783B3
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 22:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16AF77A443D
	for <lists+bpf@lfdr.de>; Tue,  1 Apr 2025 20:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911EA214209;
	Tue,  1 Apr 2025 20:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tn5KYiV/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F520C003;
	Tue,  1 Apr 2025 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743540963; cv=none; b=VpCVPjrH4G2/q5eJ8qMjJwUjUUfRPCkaIVoT8Dl9FNQqDjFY0T0u7TH3TDxUCOidjq8FWw6ljnlpFl/5qayznkchjs/atzh39S1Vj13WCjThZtwrgTy87IJnyd5vVvp8Gf7orTswDOiHa/gHWVVSha3MKzMtZQk1dDYak2HmIng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743540963; c=relaxed/simple;
	bh=DS7CxZqeavF4OXW2TCP88/n+hyAV3CFH3t2LSqkUNRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWu2z5nN+VT0GJ42wlmlVBvECuGcNwbeH8n+0+K39fnMcQoNy+slLZ4vfIYSjdGHgU+FFiZfVBMcAEzeF9QKKlGrYbCi922rhakEoFIkj9feNdgELjKO5e9j4leEPzWiITwMBGfDSTGMHenPQtGic8J422iefXIZ8VfgWKJ0Hto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tn5KYiV/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c1ef4ae3aso108223f8f.1;
        Tue, 01 Apr 2025 13:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743540960; x=1744145760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2NSR4UNAnB47pTdmCuqKUyvdzUoswTXZia5FOSskRM=;
        b=Tn5KYiV/hRwLqZvRhxtxv9G2tST5qE++tPtz19OSMP/I6+WhgIwVJaxgkxsyPYaYIu
         Q9gC5gRuVY727JZFP2VDQWZ7pRgK4WVUXUMv2WA5EiYgF9ajthzhabztMCaLPc2q/Qhn
         hTTXHA85YhoXjAv83r9sG8+4ob7R3j9GldVBzpcCcoZnaEVLQvurFvylebW60JQskj5t
         moCklKXYXczuAq6HOMF5wDxJ1Au/BbUKqBKal/3Pk5Bxcgm64E61dj5MQoPpj45UStwN
         8lc6sms2u5tciUTB8tGCMMmbW6rjik2U59GKTbCluXdvVB7vow7njM0p6GCiOXNMXWRd
         qRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743540960; x=1744145760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o2NSR4UNAnB47pTdmCuqKUyvdzUoswTXZia5FOSskRM=;
        b=XDYScjfayaQXPeKxvGivScxr/Nf0x/hfLwZKFXSA3Sj3pk95eUqwvPm0DhsqteyWpA
         6VFqOptPV84z+gnl+fad2lMlEOPDvntW/Hp99Jdp53l1XC0KIpLmP04mk755Sxz0eZQ1
         47L1V7hKeWGB1LkTTMCyhp1oh3A8rtULfft6gLXRF4uTImEd+uauu03dJ0Qf+tpkjQh0
         zGTl2c9zU13nZEpUY2v/XeHRC4W7TpJORv1wK/yabqMGvghD5xxCkl6o2dQqtPwCHkjQ
         kMHkQ5v2A34oiPKjYcGPZYT2tdCwdG/NGjaW25O42rkeASlaU1wd+YemhBkJn6GkK/qe
         ULUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVewa4Wq1jSVI45N+vvfIvcXiCp4xoHK9z026U5xtQQ2fsWtAClU6zrT+G7FznLHFIkq8g=@vger.kernel.org, AJvYcCWGH6iYeNING7wojztviprm0wb4srgUWlUJXUj4odZjXgG8+2ulSkfn2hZGacfZHGX+6NqfiU/toProjILy@vger.kernel.org
X-Gm-Message-State: AOJu0YwNok6cAZ11OCZ2D1X97JhpkHO94IhPXpEIF3dP5xPHg3lhztHl
	F8LC4KOlXymlrAbFhzXiHF0hrcji20c2G8DwDdA8OKXtwAPFha9TSbeLRfLAunr8hXI+KOmcEyC
	q1QUZn+Mhsb1ev13lU8/EBcvIxUw=
X-Gm-Gg: ASbGncuDK8A7uuVni/Px21w1WhO06MCvSz8j9i2F86TE5tAxY8eha5SVZJK0NrH0rCa
	AxW4DDtuzvH1rhTGiY/GW+UCJAETm1tC/os1D3+I9yqXxh40OSAJS3XEqefW2ShTjrBTn6DysDP
	vjJXB94H3xnwT3VyMaLN+se14sDnH400jzFTqtWIk6WmUbQzXQJIbK
X-Google-Smtp-Source: AGHT+IGWteUsIVF3s2AwO2YVJcKGPh17tVztW/b9zgcwXsBDEyFHs48WWvXAg9YnsBcUlm7ACPNG03OiX26srIw/ShY=
X-Received: by 2002:a05:6000:2281:b0:38d:dc03:a3d6 with SMTP id
 ffacd0b85a97d-39c27ee3659mr1375732f8f.4.1743540959557; Tue, 01 Apr 2025
 13:55:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401005134.14433-1-alexei.starovoitov@gmail.com> <84d7adee-fa83-4a8b-8476-820212dc929e@suse.cz>
In-Reply-To: <84d7adee-fa83-4a8b-8476-820212dc929e@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 1 Apr 2025 13:55:48 -0700
X-Gm-Features: AQ5f1JoPlciPWKp7Yyn3YMwfDEkIxze3Y9_VXpZscRqAW1B-ZQ_8oAVtAbF70Do
Message-ID: <CAADnVQ+5Mv7Pjb7qQxovKuiuuwYFZ+vgEWEzJuHy63BJwPY74Q@mail.gmail.com>
Subject: Re: [PATCH] locking/local_lock, mm: Replace localtry_ helpers with
 local_trylock_t type
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 1, 2025 at 7:18=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wro=
te:
>
> > with newly introduced local_trylock_t type.
> > Note that attempt to use local_trylock_irqsave() with local_lock_t
> > will cause compilation failure.
> >
> > Usage and behavior in !PREEMPT_RT:
> >
> > local_lock_t lock;                     // sizeof(lock) =3D=3D 0
>
> local_lock(&lock, ...);                 // preempt disable

changed to local_lock(&lock);

>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> Is there a chance this refactoring will make it to -rc1? It would make
> basing the further usage of the lock in mm and slab trees much easier.

+1

> But squash in the following fixups please:

Thanks a bunch. Folded.

And sent v2:
https://lore.kernel.org/bpf/20250401205245.70838-1-alexei.starovoitov@gmail=
.com/

As soon as Sebastian acks it, I can send bpf PR with these 3 fixes
and other bpf fixes.

