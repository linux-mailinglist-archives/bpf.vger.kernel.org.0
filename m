Return-Path: <bpf+bounces-54978-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAD2A76AED
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4641F165506
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 15:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDD22153F1;
	Mon, 31 Mar 2025 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hb8he2Co"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25811E377F
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 15:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435328; cv=none; b=gcN+ZHLiq9bU5EnyRHbIUA4wjIqUMcnj4dqBmL+Bs489oVZJ9HtfbmfWoWrRY9QaMDtlyXgdpt7+BXiKwsyzqpYB4uQRc+OU68ZQaK4kNy2zTbnpzneqn6grJHvqcCLsb3TpIN5eoClJ03wgjXIQ14nfPowzWUsLYSQrGlu7VBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435328; c=relaxed/simple;
	bh=mf2ZQZcGlrZbDzDVP0+T7LZsc7c+wwjyubj2Hr6h3pM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlklbKcUc+AXyXSiIezhXEQ+RckIeRPGWwwRr2vUY+U2Nmi/N1Qlv9evKiTqLq6GPBnEFa5BKxLyXmRcJmFNPlIYE2c2APfVIjZG3/eMjk7DZniNpT0ICRLEeL9XFMt1PbXdXeNTkOWEtpibYCGVW2BJ/BL4wUfUcmVvPRGXZwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hb8he2Co; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abec8b750ebso719397266b.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 08:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743435324; x=1744040124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YO0dREAco9t7gPO+WazvaPupC7wRyoflD+tJnxLDjG0=;
        b=Hb8he2Coa/TuZCItycEKr6RJhz7Q2tu3D6kKcZiXQy+ql1CoGVJruWnNJ4O4jQkwfu
         B3eQRE1ZUAx8av809bszbO1f2HG1A3nwFlJRhxptPhhCz5GlejMK6RBWAxoLZqkSoHSR
         emZfeZkn1D319YI07/QllBbng47+Lyvqxu0xA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743435324; x=1744040124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YO0dREAco9t7gPO+WazvaPupC7wRyoflD+tJnxLDjG0=;
        b=RvyRXEl7WXskzjXql3gmty8MFBhUULz7We2x2iXa3juRAicsawxOFWcC3WnshV4yFg
         yP1gMdU4Zgz9rNusPDyE5biViJnpiwN7a9YnJi7di5tKvbOE1wP1aoDkmuZ9smspT37q
         VD81gJryZNujOibgio8QvNjGaT98MGiB4XzVq5dnJy4/zjWxY0N4IRB3omPV8u6C/ThT
         7qGdIu9FfojeTxNWs4Rsqwz1ihOmvuZj5B8jaLR7ouGN2Q9QCAbEr7tLe7MW+un5DDsO
         fVPWrDfs9eo+JVFT1BQS3aLesN5Yllxavwp4qhXw4SoYb1JZxF3LlZZLqGMqsHDuR6Cs
         r5Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU1MGx8SHvAe3oXWNj0Rrc4mNtdbHuv95skDEVyGuIBMVempcjgt8j00jeHUXwZKP0oJ6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNQv8YzyDYdOBeKcKUwwsQYOjs0qoUTDw0U366F8dq96wZ9VvV
	v0b9MGMjatCjWMtt0tkwjJJErlZ3JC3qhLfGe+s08IeBa2q+I9i8aDEPFSGmS7MmprVfT/9Xnmf
	jc0M=
X-Gm-Gg: ASbGncty+oxkWr5yMi/eEeiQM+6Co/Wfw1SdTQlQg38e260MHHhbP7+X0w3bKKO4Mw6
	yphGVcB/C0z6+KWUl0p8wTAp6gu+F88UhphtF5jZDN8MzbjPWugtod1Xu0MKppH/fM1zJGzxxas
	RPNFDkJhip5ziOX7j3blUXHgR1DdTTn3P93hMYXb6F+0sasGpQmjSMDGjclBxuTzTcD7ZHKkr1x
	w7Z9lKOcsxmeWnGAsTlSAtmzVgcJuBb+QzpTSJUCS21gvEdqQglyF7cjJuR3SDqypWCMPYD6iSw
	XnlM2fEaYUAcLYT6NeY8MV6FS/ThF2YV8RK+AMiz9MoKgIIt+U6izO2NdZyBjJIO3cUccME2SKS
	dimgjV3RrQAhsPNgcV3U=
X-Google-Smtp-Source: AGHT+IGBvHjNwZH3G61U7qY704Bv5VkM+xh4EytiW5mRk1jJnLqXBsvfETMdQ0Cb1pKt7Hg5F0wdDQ==
X-Received: by 2002:a17:906:c103:b0:ac4:3d1:e664 with SMTP id a640c23a62f3a-ac738be3ce8mr809113866b.46.1743435324077;
        Mon, 31 Mar 2025 08:35:24 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196dcf14sm634476866b.156.2025.03.31.08.35.22
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 08:35:23 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ac73723b2d5so442038366b.3
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 08:35:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqLvnurr2amPeJIALvLT2fbRP4/LEP6JbjocaN+jAZrcPaejhfNenkYWR/GCaGd7xOSNg=@vger.kernel.org
X-Received: by 2002:a17:907:3e03:b0:ac3:b115:21b8 with SMTP id
 a640c23a62f3a-ac738c21274mr750571766b.47.1743435322576; Mon, 31 Mar 2025
 08:35:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250327145159.99799-1-alexei.starovoitov@gmail.com>
 <CAHk-=wgRbk2ezu1TNewZQSrT1MCzP-xAXrcHXULMeW=RRSak5A@mail.gmail.com>
 <CAHk-=whVcfPyL3PhmSoQyRQZpYUDaKTFA+MOR9w8HCXDdQX8Uw@mail.gmail.com>
 <CAADnVQKBg0ESvDRvs_cHHrwLrpkar9bAZ9JJRnxUwe4zfGym6w@mail.gmail.com>
 <20250331071409.ycI7q6Q2@linutronix.de> <39586553-6185-4b83-b18a-3716caf2f3cf@suse.cz>
In-Reply-To: <39586553-6185-4b83-b18a-3716caf2f3cf@suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 08:35:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1jFH2Gc2Pq+-m_32BL9-CbdD7vReTJgd7Wbt2_EnH3Q@mail.gmail.com>
X-Gm-Features: AQ5f1JpPp2rq7h82rgAtWGoIctm8Ha-dBePer7BRjKEaDaPgda8D0EyYKeuC6qY
Message-ID: <CAHk-=wj1jFH2Gc2Pq+-m_32BL9-CbdD7vReTJgd7Wbt2_EnH3Q@mail.gmail.com>
Subject: Re: [GIT PULL] Introduce try_alloc_pages for 6.15
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sebastian Sewior <bigeasy@linutronix.de>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeel.butt@linux.dev>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 02:59, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Yes I was going to point out that e.g. "nmisafe_local_lock_irqsave()" seems
> rather misleading to me as this operation is not a nmisafe one?

Yeah, it's not a great name either, IO admit.

> The following attempt [2] meant there would be only a new local_trylock_t
> type, but the existing locking operations would remain the same, relying on
> _Generic() parts inside them.

Hmm. I actually like that approach.

That avoids having the misleading operation naming. IOW, you'd not
have a "localtry" when it's not a trylock, and you'd not have
"nmisafe" when it's not an operation that is actually nmi-safe.

The downside of _Generic() is that it's a bit subtle and can hide the
actual operation, but I think that in this situation that's the whole
point.

So yes, I'd vote for the "let's just introduce the new type that has
the required 'acquired' field, and then use a _Generic() model to
automatically pick the right op".

                Linus

