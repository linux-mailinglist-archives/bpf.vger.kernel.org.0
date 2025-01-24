Return-Path: <bpf+bounces-49674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC5BA1BA33
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 17:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 223C5188E03B
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2025 16:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428CB18A6AC;
	Fri, 24 Jan 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOSjDbGE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE65156649
	for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735573; cv=none; b=M98mOaYaKhYphSRbbb0a4dZ0PGHZtSj28nrTsKGnm335ggddeRIkMFzXyFnJa8t7pcPTU7+1kWF2w1CJvlIKsb3uOvlXMn0WsOaNsLKwP2c+x1uEGYdqgdxX6ME1kXYoPnFWodGUfXfonXzVrHvUzm9WH1ikhtKUVgDQu+NhR/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735573; c=relaxed/simple;
	bh=IATn8mC3DXu/flWpBsJpjElv+njkEBxKZkcQOnpAO/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PC2RX3BByEN7hx1Fs/HyyFnunOcTpxOxpSWzJGNwU4RN25u6Cprite2ImZn4czWcdjUgBzB2Q4BkUB6dt7iOMf1vfVTpg31yJJqItcwwfyQ0WwthkPNeJxS+qXRjvzODyOBR+GJd7x6M9cTWebsQ+oWFfsHWITamhIfNzNhpNRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOSjDbGE; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43618283dedso23721765e9.3
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2025 08:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737735570; x=1738340370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNR0wfwWw2NvuxW//J+U2O39wON41Rz22Q6b6kB+bsc=;
        b=SOSjDbGEEW5vozPRA0OGYc9h/DXOzzKYkKVRao45YhgpjsuysUU1I1YYuPlO5zJQmX
         0csdOQrj6VWJFTEEYRKVo1qJSKvb/FDsLHnFELWH4zaRQLsXDd5jRpx4wL+nYsRsDYlB
         3oR8FHgfUCnb4Z5zcmljk1R9Mbv0hcOAxfgCpvc4wSNemQ+Ewzli69Bm/JAu6Bpoxgpp
         hBP5jWqfgh1pPslWjdBy8MsMmA8rsLb9+O7usDwiBOJf0RSRzb8j2C18WG/deRZiJn0b
         tp5ugHuhK+s9z53pb6QcgeK59XT8Qsg1zeu5QfY2is3lPHIt6L90OnindpcYMNW+/Vq7
         7a0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737735570; x=1738340370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNR0wfwWw2NvuxW//J+U2O39wON41Rz22Q6b6kB+bsc=;
        b=L+ugp5ac3Mx3thvBm2GCwRtM0V3DVqk4rI7tEqQn1L+8CkmVQET161/SA8vV/kYOe+
         W2YglOcob3mNIFKHqhmrRLJgFN+IbWyPl7M6YXidzZZ4Bhi+tVCS/q3IDqEOWI6pzG+E
         iThYyPH6CD822WcXuPfX/gWdm8QGlDwJ41qPnNEKueGQW19kpCzii3xXaNzotBrd0qyB
         AWALtFUIxMwKT8+ZbowvBfA17WMNDNtbSngiI7ZjnTIKAduGWXW/NhTeabBE9dlXEFsr
         ikl+8HmgstcWgefkdbgJhV07V+2XbuuuI3qUymbubgemJAWeQdKT+9IRC0g8GpyjIlLW
         giZg==
X-Forwarded-Encrypted: i=1; AJvYcCX7dqUpkCFfYo2U9FfOhRJDiypJ0ZctZv9qe4yxCDCzD5jPtCbfBOd4DVSF0izRCCiwFKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvSAWfZcq5WKLTURgVaNeYk5TaRiS8yvkqlrpu7Qv5txgZmuiP
	geaV7NrSFm8SJlXpO6BYW6o7E+JgVzvSUO9tAZGbd7Dqs4YxAmI0YbbnyDTKgdUVCZ/Neayhyce
	TZL8HrjI1+QZj5Syj/dqqORU7nap5zlZ5
X-Gm-Gg: ASbGncthrOq/BXeq/A+7rzqyCqjCjysLPnJm78vrLRttvzK0aBmn/4AGwxG64DfjGPx
	jadf1nHq81tv0y2ECXcnRcEYnjY9ZDzQ6xtiZe1RYv8qGEt6A+9G+pLRc4iqf4wnHqqLGiJ+D0h
	c5z99xNsswNmVb+jhEZw==
X-Google-Smtp-Source: AGHT+IGOb6vxlLhCXj3f0QNMkNMirtLON3mv0I3V7/RpuR3QBVza6e72NbwXufk1OxktCL3DsOr51N7We/tuyEmJXjM=
X-Received: by 2002:a05:600c:468e:b0:436:5165:f1ec with SMTP id
 5b1f17b1804b1-4389143145bmr300411335e9.30.1737735570033; Fri, 24 Jan 2025
 08:19:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124035655.78899-1-alexei.starovoitov@gmail.com>
 <Z5OgvePdlqRoKMyx@casper.infradead.org> <e5c1eed1-3ea2-4452-a871-3308c90e932b@suse.cz>
In-Reply-To: <e5c1eed1-3ea2-4452-a871-3308c90e932b@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Jan 2025 08:19:19 -0800
X-Gm-Features: AWEUYZmIlUPeQ03O6WtaTxXnXJkoadEdcYJvYlAh1Eej_BfMfLgZY0nrYIf9WPs
Message-ID: <CAADnVQJhU3EYp3fWYcTFtZobJUAaWRQmjjBSw5te9OpUaM8TNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 0/6] bpf, mm: Introduce try_alloc_pages()
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Sebastian Sewior <bigeasy@linutronix.de>, Steven Rostedt <rostedt@goodmis.org>, 
	Hou Tao <houtao1@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@suse.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>, Marco Elver <elver@google.com>, 
	Andrey Konovalov <andreyknvl@gmail.com>, Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 24, 2025 at 6:19=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> wr=
ote:
>
> On 1/24/25 15:16, Matthew Wilcox wrote:
> > On Thu, Jan 23, 2025 at 07:56:49PM -0800, Alexei Starovoitov wrote:
> >> - Considered using __GFP_COMP in try_alloc_pages to simplify
> >>   free_pages_nolock a bit, but then decided to make it work
> >>   for all types of pages, since free_pages_nolock() is used by
> >>   stackdepot and currently it's using non-compound order 2.
> >>   I felt it's best to leave it as-is and make free_pages_nolock()
> >>   support all pages.
> >
> > We're trying to eliminate non-use of __GFP_COMP.  Because people don't
> > use __GFP_COMP, there's a security check that we can't turn on.  Would
> > you reconsider this change you made?
>
> This means changing stackdepot to use __GFP_COMP. Which would be a good
> thing on its own. But if you consider if off-topic to your series, I can
> look at it.

Ohh. I wasn't aware of that.
I can certainly add __GFP_COMP to try_alloc_pages() and
will check stackdepot too.
I spotted this line:
VM_BUG_ON_PAGE(compound && compound_order(page) !=3D order, page);
that line alone was a good enough reason to use __GFP_COMP,
but since it's debug only I could only guess where the future lies.

Should it be something like:

if (WARN_ON(compound && compound_order(page) !=3D order))
 order =3D compound_order(page);

since proceeding with the wrong order is certain to crash.
?

