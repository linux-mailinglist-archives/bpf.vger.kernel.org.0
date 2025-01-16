Return-Path: <bpf+bounces-49020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B97A1315A
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 03:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B09165B9A
	for <lists+bpf@lfdr.de>; Thu, 16 Jan 2025 02:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEF078F59;
	Thu, 16 Jan 2025 02:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzl4rEvM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAC35967
	for <bpf@vger.kernel.org>; Thu, 16 Jan 2025 02:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736994373; cv=none; b=PA38mbPUZjZ0SaIjTzaa0SjjLzbFEP+o+8vDFPLfMhSf/Ix3t70eRAQTuUuCGHmmj5wKDBBVOZKJRf9UyyvkdTdO7oq6WCH/4sn7VNMWbAtbJCaKdcIfU1FLX4gcjMswGy04RGbPxtNfe3R6HUQHimjEIU+AeMXE2yZphkz/vLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736994373; c=relaxed/simple;
	bh=z4/glDnKhgBk+A7cz++cm3ROM8wxsgT4LNL2en8+hUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ccE4n8OqxB8pwXfCsX0peGcVrFXrnMxZHbPadlPIDpQN5v75SLHyL5tPmi0aWFCImzKvWp3+e5wIJ+i/rhXoJjVLeP96sMrC/DdhmV40isLhyYtPmVhSLi1uza3g0IqHNB77ZUW9eOKc4B/Xlpot/HW4+wR3UOUrkqQvoub7lSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gzl4rEvM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43622267b2eso3365435e9.0
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 18:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736994370; x=1737599170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuDz3cqpq2JwZVFqTGS7uN/iiFiI7lTqmYWc56DBkkY=;
        b=Gzl4rEvM5xJBKJEI3rVt32PZDi0KifUI2IfOJx39i4d1TRbTlIevxyvwK1mHghZ3yN
         MNgwTQhxSGvwBlD1v43gwl5WenqfP2Ty0FeGfoowgAeuyBnep51FpZeSxpnZOdFgrdeQ
         2VapM4mruY1pfJV4zeT/kkRj4zb41h86apiguy+G1O7145nOtBpGnjWQT7nqlFcCLp6B
         T9aBmZJ6AmPzG5CYnhO5j45MpMR1jnwR4rvGmC5g9r/G29RvaQwJiV+zgySubSac9a7X
         pIyhrObKO0Ld2jalu8s541G2q/Bft1V6SUgdpw93VlDzLvwqdhtsX+zNpYmGyKQTs0Sc
         WZqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736994370; x=1737599170;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yuDz3cqpq2JwZVFqTGS7uN/iiFiI7lTqmYWc56DBkkY=;
        b=ayUndOb8yeRF6eEQVBpyqjQ9sfaluBS198mdr5EGh7075nMVsn5GKqYc1GKtNUyKDx
         zmAHQjBdeSkz1U24m5cWSzwPJYqO2bRUF54vxFKjocl5C4tv6k7fS1ILQoPXlmtZo6W+
         ytw4uLaLOEXJ85sVcrMwxOxB9SoABHt5yp7OpS8tc+Xy7n2hDy5diPwdLqg4LSqaDdu7
         68xwWHUPtGmVoB1+HxCwZUwDcBM95T+1pKOgSZHDifzSxvCn38D2MSzCOXDFiclrW8tm
         ZKmatkjhgOUH4HuQQ7H5PL5VeH2jcxMFPeUuc7aWo267PhKzrpjwS5ssubFsSKy3Rh7Z
         B2vw==
X-Gm-Message-State: AOJu0YyNXUruVC/DrhrU8I5+/skY2UOCGbH8G7pnGMKP6vGZ6Aqz4s7A
	RRU6cJT4Spto+H1ZqlZ0oYv6W2w+NX4t9oarWKh2NO8h/8Q6JFwXZOm85ERL5n426fwf2Sh/JHt
	Ae+MsabRQVnn5kIJ7jLe+2gEfz2Y=
X-Gm-Gg: ASbGnctjtKuGJFRBxo82KhtcFv31xFK7x3EjYVfEEySrpeavBqNWrB0Ke6GuV9rphIL
	wtgTOfAkyt8yJ8bMCm9IIMSQ5cfv6DsStks1wBGg90WMEjSzWkrR/Hg==
X-Google-Smtp-Source: AGHT+IGH6xM/zfyALs2+uixuQYyWMWcPvMFUh5nV5Qea2Z4UuleMluZuXRFH7J4w1LDQOsbZbqQmqtZgFBXpe+5ooPY=
X-Received: by 2002:a7b:c4c9:0:b0:436:f960:3428 with SMTP id
 5b1f17b1804b1-436f96034b3mr153099105e9.29.1736994370093; Wed, 15 Jan 2025
 18:26:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115021746.34691-1-alexei.starovoitov@gmail.com>
 <20250115021746.34691-8-alexei.starovoitov@gmail.com> <7418e422-ecd3-40c9-bf65-dd9b2fcebfa6@suse.cz>
In-Reply-To: <7418e422-ecd3-40c9-bf65-dd9b2fcebfa6@suse.cz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 15 Jan 2025 18:25:57 -0800
X-Gm-Features: AbW1kvbQOEX3Qz6gXFpg6QqzpKx8RcnbVv6I2lTLaS9ygpZ7hE19tTNbo6e89FI
Message-ID: <CAADnVQKF7byotZ2ffz6oKcWBB5UwyOKpTVhL8T6cfJ+y20Sp=A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 7/7] bpf: Use try_alloc_pages() to allocate
 pages for bpf needs.
To: Vlastimil Babka <vbabka@suse.cz>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Peter Zijlstra <peterz@infradead.org>, Sebastian Sewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jann Horn <jannh@google.com>, Tejun Heo <tj@kernel.org>, 
	linux-mm <linux-mm@kvack.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 10:03=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> w=
rote:
>
> On 1/15/25 03:17, Alexei Starovoitov wrote:
> > From: Alexei Starovoitov <ast@kernel.org>
> >
> > Use try_alloc_pages() and free_pages_nolock()
> >
> > Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> > ---
> >  kernel/bpf/syscall.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> > index 0daf098e3207..8bcf48e31a5a 100644
> > --- a/kernel/bpf/syscall.c
> > +++ b/kernel/bpf/syscall.c
> > @@ -582,14 +582,14 @@ int bpf_map_alloc_pages(const struct bpf_map *map=
, gfp_t gfp, int nid,
>
> This makes the gfp parameter unused? And the callers are passing GFP_KERN=
EL
> anyway? Isn't try_alloc_pages() rather useful for some context that did n=
ot
> even try to allocate until now, but now it could?

Correct. gfp arg is unused and currently it's only called
from sleepable bpf kfunc with GFP_KERNEL.
I have more patches on top that change all that:
remove gfp argument, etc.
Just didn't send them as part of this set, since it's all bpf internal
stuff.

