Return-Path: <bpf+bounces-73328-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 635B6C2A90C
	for <lists+bpf@lfdr.de>; Mon, 03 Nov 2025 09:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51B4D3A6D80
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87846271447;
	Mon,  3 Nov 2025 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5UL4FHT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF7D298CD7
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762158208; cv=none; b=muC0qxbAcVXBB0yaUf/qCSz7LGe+BVd5o7A8fv63/WQMNhWxLKTqxWlB5Vzox9Jnq4T16t/3cEaP3xfC9tVxixPF2c+6RHMtZ0INfhOTmkBlBZTTps/GMrq2FLbmy7YM99yiY/uATqyOcmU9QghqB9D2druTGYZ0kF2kxaRrwc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762158208; c=relaxed/simple;
	bh=KO/1hqRDGghAvPjVvchP/FOpodQDU8oF7iuifc2yRzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwux/Zmdy3E1tYdqs2xbPirbmiYSpJiWf+vzKC06cVwA5DGz8WhIHGvSgQMY673OMJGpXbmwQiZgB8s77hpiOA19Kfachfj8X9w4Xm+OqKIVczMX4xM7zsDhsfZuAyntsBkmboWbmuRVsALxkJtvHEWSsFZFp1s1WY8/yehDu6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l5UL4FHT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b713c7096f9so57976166b.3
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 00:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762158205; x=1762763005; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qzEaCNkEb8xdsXatLBxRnzGuHLO3xwK5s+ecHWat1E4=;
        b=l5UL4FHT2QFlGRlLLgDH7UhYBYDNXG5sPafJ1JjiiyGK4+Txxsi6LSbzZTSu3DP+LN
         N2l1+xG4ERDa9Ne8ur0n+K92HRUC2cXc/iNf7Z/JCPysRX5xy9m9J1Q2XEI1wiq0wBAq
         T3gkL9wTjPcXCLCoQ1EMgEt3f2zdZAtm4sKJlcv9XJ7b9trQ+lMp0aZCYoqbvVY2wyNA
         0Zu+qR4tnp/qKrnUx+YntCQlK3Wfkfgzuzw+HxjjG1XhwzhAEXQkNH7VLbCPcA5HBsPW
         NTS8uaN/OAdJT6DvSCxhUFASO8YHEwOZcZcxQdiBk+FBM5Lah/wprW8kL03glX8XZezJ
         pmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762158205; x=1762763005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qzEaCNkEb8xdsXatLBxRnzGuHLO3xwK5s+ecHWat1E4=;
        b=NoqkZPeTox8ulswHxzwJRcF13K7n/YD63fsy0KeAP1Uuqsx4aRV+IqvpIpekXguTls
         8Ss8HCnKPfW62uUaNbxh5rS3J3+Lp+JKKkff548WGYHMPBerCsfLz2K8fY5X5OuXkQ7d
         xy7VQ+7s+NOyXBViNtwBgdemd+QiXKRK9Uv7xoUZrplhNS3eEAzLLJpDeVNxQU3SI4AG
         WodhZHVQJT6lDoJGbySbFTexRzOPq8NEu/Q6GkQjvb0PlmzRYhADge7pIKL1hJVYhonb
         ZCr1P8umYe5kX9z0s6gYYFjdUSuLXEC6nq4g8O6izK298uOprRaxDbNobFHNXapqrdWQ
         2KEA==
X-Forwarded-Encrypted: i=1; AJvYcCWg0kbxE3ZOd1a8J+cva4VCc6qGqmC5dfSnp7Rpg1392789NGB3L8tIG4hZYKppm6f6bVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxta5F77Hpzs51mF0qL+Du9c33nl+Ec4HwDpc8xOTt9t7zMnmbx
	8yTtc7FSVfo10PD6DexQOpWw5y26FgigaUZdWZkFGi8FTjC3oj5Z7HlM
X-Gm-Gg: ASbGnctIvkjvwL3/7tYb9Xn50adqhn3O2Y/oC19ipylUNpMVJE3RuGC3FvVbMXDgVAt
	VfVCLbbYMDeu/5erMDXDdHSYc8dto7cYLctHMyixirtkIydHzNYdOyEKfXlnHN3SoQV17JkiVrU
	IjsKweyhLP4BD+jH/RXEA2MzwdR7r6D+7wfK7B9ywZARX1o1ONDeiSwdHz8wEYJht0cofl579TS
	2EH9JEciojPZ0c3BmMjYpJFlQN6VCoBtAFHey0DOqe6VBjWAMoAt/PhkL7j+PikDgng9o02WB7u
	b8uG8HkCn+JrWQ/see2xYBHmCyhLwG1zVJlo+JVChYdOzEIfnKsj+PBHZvCOIZy/xiBzDdMZx9a
	m8OJBYkNM1x3DmnSExGks2uhoyIWDZhEFhZZQnZtsq8SGAjeOe5bluIyu8G8pDgcIaT5Z+VTIsR
	z+ScI6ldDHI6PrFgohCDL2
X-Google-Smtp-Source: AGHT+IEwQqvW01GUFpbHhQJUuiPaqiicxGd4xoDJTlPZx1CdeXyvHdN7xPtyiQSvQ7iDsFjWvKm8Yw==
X-Received: by 2002:a17:907:720e:b0:b6a:694e:472e with SMTP id a640c23a62f3a-b70700c7b2emr1392609966b.12.1762158204533;
        Mon, 03 Nov 2025 00:23:24 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b718f8b52fdsm43470866b.18.2025.11.03.00.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 00:23:24 -0800 (PST)
Date: Mon, 3 Nov 2025 08:29:43 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Chris Mason <clm@meta.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org,
	ast@kernel.org, andrii@kernel.org, aspsk@isovalent.com,
	daniel@iogearbox.net, eddyz87@gmail.com, qmo@kernel.org,
	yonghong.song@linux.dev, martin.lau@kernel.org
Subject: Re: [PATCH v10 bpf-next 08/11] libbpf: support llvm-generated
 indirect jumps
Message-ID: <aQhn95THkx7zPlB9@mail.gmail.com>
References: <20251102205722.3266908-9-a.s.protopopov@gmail.com>
 <311fb2ea7bc0de371449e98951bf8366aa8b30be8c50c8c549e2501fc9095878@mail.kernel.org>
 <aQfPbc97GSajDCcc@mail.gmail.com>
 <4a9ba760-c9e4-4851-b971-ac929811c52a@linux.dev>
 <9fdd88c5-2984-4a88-8605-013aa4c2ea09@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fdd88c5-2984-4a88-8605-013aa4c2ea09@meta.com>

On 25/11/02 07:58PM, Chris Mason wrote:
> On 11/2/25 7:32 PM, Ihor Solodrai wrote:
> > 
> > 
> > On 11/2/25 1:38 PM, Anton Protopopov wrote:
> >> On 25/11/02 09:13PM, bot+bpf-ci@kernel.org wrote:
>                                                      ^^^^^^^^^^^^
> >>>
> >>> Does this error message print the correct offset? Since jt is a pointer
> >>> to __u64, the array access jt[i] is at byte offset "sym_off + i * 8",
> >>> not "sym_off + i". All the other error messages in create_jt_map report
> >>> byte offsets and sizes (sym_off, jt_size, sym_off + jt_size), so this
> >>> one should probably be "sym_off + i * jt_entry_size" for consistency.
> >>
> >> Is there a way to run this AI as part of any PR to
> >> kernel-patches/bpf, not only those coming from the mailing list?
> >> Maybe for a selected commit?
> > 
> > Hi Anton,
> > 
> > If you have access to an "agentic" AI coding tool that runs locally,
> > such as Claude Code, you can use our prompts repository [1] with a
> > trigger prompt like this:
> > 
> >   Current directory is the root of a Linux Kernel git repository.
> >   Using the prompt `review/review-core.md` and the prompt directory
> >   `review` do a code review of the top commit in the Linux repository.
> > 
> > The prompts expect the "agent" to be able to read and write files, and
> > execute basic commands such as grep, find, awk and similar.
> > 
> > In principle it's possible to enable the review CI job for arbitrary
> > pull requests, but the tokens are not free so we haven't considered
> > that yet.
> 
> At least for me, it really helps having the reviews on the list.  It
> gives me the chance to see what kinds of bugs AI is flagging correctly
> and where the false positives are.  I do try and fix all the bad reviews
> that people flag, so the comments here are really helpful.
> 
> This isn't meant to discourage people from running reviews locally, I'm
> happy to help get you setup.  But I also don't want to add a barrier to
> contributing code.

Thanks. In my case AI, for the most part, finds real bugs, so it looks to be
helpful and its reviews make sense on the list. If only it could dump more in
one pass, not squeese them one by one :)

> > [1] https://github.com/masoncl/review-prompts 
> > 
> >>
> >> Also, how deterministinc it is?  Will it generate different comments
> >> for a given patch for different runs?
> > 
> > The short answer is no, the answers are not deterministic.
> > 
> > However for typical/obvious bugs you might often get a comment about
> > the same issue worded differently.
> Yeah, recent changes to the prompts have made it better, but for some
> bugs it still wanders off without flagging a percentage of the time.
> 
> Also, sometimes it'll get excited about finding a bug (even if a false
> positive) and skip to the end of the review, so if a patch has multiple
> problems, we might need multiple submissions to see them.  I've been
> working on this as well, but there's still room for improvement.

After all, it just mimics how a real reviewer would behave (excited => skip)

> -chris
> 

