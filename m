Return-Path: <bpf+bounces-22108-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFE1856F47
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 22:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B978B236DE
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86CF13B7AE;
	Thu, 15 Feb 2024 21:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZjfSB21p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3310912BF18
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 21:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032417; cv=none; b=YlIJKvtwHvHz8hHGDw3xw286OeGPM1oI11QH35BBDOG8duL0orDfdMYJGEDh++kHEfMdCT3r8ab/PGJABxjtudlt58JF71BG9xp+LxIuCTY4hSFfShrdjIpUPkgWfNTbIxL1k+TyGofhuCPaWmeKQtHPX4ATn2F8l9Akl9vseQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032417; c=relaxed/simple;
	bh=oX9UIv2DGzZDEww/5x3TuyFY0BWb+dpTJwQFjLrGnu0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=urqceOnf3r5zBWt9TUlYQAsce98HJe6egkPhfLWi5K6d5XOPIydgO9Uc2mnR5mx/Jv5lAB0CGXi0Ok0Edse7E9sdZlmhdaB6HgTzPkDY+JDC9zS4Pb1TU8K4RBJ+zWZHAKyn2eLOna5yAz/neLP2JDSwOmTCtQJAk44J3JRh51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZjfSB21p; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3d6ea28d46so292829866b.1
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 13:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1708032413; x=1708637213; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bcraGSBoVm/uvFQNDkSWRb05huDhJAD0L2piK4rqJO8=;
        b=ZjfSB21pbjsTQCqxmRW7Iz7KbH/cbsUIVogsglTgD8aWQ6bVJ3OUgI6D8KgYu0hLvD
         jOlEF9b3B3+Nvpks8pMJ4KEqsHVRNH3CCjD1c2F4+gHqnrLb+mbWhkj/gHFFa9I+HexA
         hSYmn0OndUgQe5xBCPeBsX7DaUkrqQf2ehcBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708032413; x=1708637213;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bcraGSBoVm/uvFQNDkSWRb05huDhJAD0L2piK4rqJO8=;
        b=YjUd/uzv1JxdrehMZoBKfm1yCqSnfqhLoMaylz/vL4qUnzuAZfv4opkAmUsB5jOKFd
         WuORrXisC7Osx0mGFkp0oKd2dhFfcFgQ5vKotIRIe+xjO9bQwDO+PSfcJmxQCt3Gl0P+
         YqVSmWHD9XYlo601GKRz6C9CnO45wSSFNP0wzUnirCK3hB97IDMQ+rEI2gyJEIEEvYQ+
         WCwSnhEHg/DoqTk2yWUMlkQ7b6GI/Fb5aI4hKPC5OJFm6urkUp5KE+cypK0CUMuo1gQ4
         84N0X/JXgyIg5/7oFhtKrwjWaIesaSOjwkuRRMH4u3er8qwQKurAqh3wGcVAnKQ0YqfQ
         ddAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu62ZcnE+kF50HWzk4Rqwb/+jOoeGpxX6i2U5mS/fy0nKGzuZPRtJlmw/k2dbyqnGq35zRoykf4UtD5HPqw6NtypH1
X-Gm-Message-State: AOJu0YxI/Sb8AWwBvAZ68JHO6kxtt5u9wjqnztxmosfZNZ+4HEI1GsFa
	JY/PgBNa584+2pbV1LGvOM/ydosiIIDcgim82ymGpDAHTPazvGGFhXgaIEyYP6CTiIgmEXOp8l2
	yuyA=
X-Google-Smtp-Source: AGHT+IHxrUr6AU7PEAqcK5TDaWquy9Ow/qHY04YT1qJ0mgyJbiMW9HNFTbo6lSR4AeZ3SLO4YKjRwQ==
X-Received: by 2002:a17:906:6617:b0:a3d:5058:50ff with SMTP id b23-20020a170906661700b00a3d505850ffmr2737176ejp.2.1708032413233;
        Thu, 15 Feb 2024 13:26:53 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id w13-20020a17090633cd00b00a3d52f8ccbesm931603eja.170.2024.02.15.13.26.52
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 13:26:52 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563b49a0f44so1720054a12.0
        for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 13:26:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUmKLCj40By/6Tntzl0eclDsdZBCPYevNY5fwUU/lQb+sJyMsQ31YueeicDlndooK6K6PJP0f5P0GxTWK7MghOIxTSm
X-Received: by 2002:a17:906:8a58:b0:a38:5443:f4e0 with SMTP id
 gx24-20020a1709068a5800b00a385443f4e0mr5270607ejc.19.1708032411978; Thu, 15
 Feb 2024 13:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
 <20240209040608.98927-5-alexei.starovoitov@gmail.com> <Zcx7lXfPxCEtNjDC@infradead.org>
 <CAADnVQKT9X1iSLXojVs1sWy4B-qEGccuk6S6u1d9GBmW9pBAeA@mail.gmail.com>
 <Zc22DluhMNk5_Zfn@infradead.org> <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
In-Reply-To: <CAADnVQJ8azcUznU6KHhwEM99NUOx8oai8EOyay4dxLM6ho8mjw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 15 Feb 2024 13:26:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whD2HMe4ja5nR6WWofUh3nLmhjoSPDvZm2-XMGjeie5Tg@mail.gmail.com>
Message-ID: <CAHk-=whD2HMe4ja5nR6WWofUh3nLmhjoSPDvZm2-XMGjeie5Tg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/20] mm: Expose vmap_pages_range() to the
 rest of the kernel.
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 12:51, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I didn't invent it. I internalized it based on the feedback received.

No. It's not up to maintainers to suggest alternatives. Sometimes it's
simply enough to explain *why* something isn't acceptable.

A plain "no" without explanation isn't sufficient. NAKs need a good
reason. But they don't need more than that.

The onus of coming up with an acceptable solution is on the person who
needs something new.

          Linus

