Return-Path: <bpf+bounces-39482-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A97973CF6
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 18:07:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E0E8B230C1
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 16:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5716D1A0706;
	Tue, 10 Sep 2024 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2oscGzwR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6460F19F480
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 16:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725984414; cv=none; b=W1UMTWvQUa85GzjC9w9QGXdCF7xvYEfk/GXn/Oogba2xaOl3i8o4hP9uX2gZxhbPWc1Tkm/0ajPKSN6PwiWwNsLkOBbNLDicGwFd5CqKUuGXF1ONqDrvrVFbwYmMJ7KTP4+xQcOJaraUGFJoH6zQw9bvVQFHYReEHROQXZT7bSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725984414; c=relaxed/simple;
	bh=9Rp+ZaWePBqTv+7CDLYdQhLyxwC0Y6Goq+cudkph1u8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYk069Rz67DiXCElnEKMqJzeLOPcyzq2geffUGB4UX13GzYsR/et1TE+haU/qox+ne2ok7yFVBiqzkpaRvCt3Jc+4RMMHa+JCKCiQVG6KYsWU1yVhQIuxnpcpqW9HsvMOdkz4J7VZPQ1ccmv7Bmq0DJgO+b01ftFOmVZCqsbYqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2oscGzwR; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so13124a12.1
        for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 09:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725984412; x=1726589212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Rp+ZaWePBqTv+7CDLYdQhLyxwC0Y6Goq+cudkph1u8=;
        b=2oscGzwR4onXmHbtOk7T7sHnwdGHNxaTaPXyKSYKb+/w/iPXbn2//jfK1OoPvhAAWQ
         kbT3m3utsrQfKXjVDv+BE3OXjkp3RVkS1bZlvWP4HLztW/Z7S9YCJfW298ag4QEb0gWA
         jRCcNY0lx9HiRUIktMboyEGdBsyfkLskNjNMs0RQyThW5rzNk9L6oXV5P+BIBB+UbQYo
         cgxsfV4Kr/kvrLzqoCGkYUmxHwYKHjvMOLJjQybOyf0T5LV7MO75rYZIz2PgyjJntZGt
         TtqphhEmEj2bwoSGVgtkKxWn9+8xUA2oz7QqkWjRoSNGMx/ZMNtQZYQ2pPcya4t1ptVm
         eraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725984412; x=1726589212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9Rp+ZaWePBqTv+7CDLYdQhLyxwC0Y6Goq+cudkph1u8=;
        b=C8/eKtLEcqoS6SEyLf+H6zXIbb440lw1wNRDNok5DxyxEBeho+/Jdk7dhZCxeRFeC+
         fNGAjQoC94DKm1LdC/RyviVrKYeK22oUTxp+yV2aRO+NGtXawf400CB6NFX4jEbWf7UI
         M1ubfy+HhKKDw67QFOJV/WgYyKrOL/Z7M5NKc69NCF4oSTUhhXtQJF6M1oVsNdqz8WiB
         wmqoKnoC4ui9N8YvyTnMesKFaVy0IYSnFfDdyFbGQtbblOyy0biHivK+qI9FrUT7Myk5
         9m+0uD7girSPVg7Ebrcg4ZjqGxrjGs2S2MhkuoE41mSpsiq3wlMMVwT7fPPr52zubn5f
         YBTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXnxwLfTVf/odQltYBDflAUlWBeG8GZU8C0YQjZkXu4rFsexUEr4FvYyu5f4weQb4TNQPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhFpkRg4V6aatc/z1ZFbJJ5nqvqxce1N0lHZa6FA7FtvubXkaX
	SUYr/5xjJSqR/hGU7rMoWxNIZgGhgTARCBMP9UbYv2WCve3r1fq9KH6yPUNL7Kc6BzibLYfhhCx
	eXVK4gqG2yMK6NGCWGVVSze3qFsTMBoJCdJPq
X-Google-Smtp-Source: AGHT+IHx0FXXNOSwDc/a2GkEEO0nN6J5e6WRL/WX5poMnRTVWbyacane/wtmnLr+FEV9BbUT65Gm5/vLnAoiz2/SvOA=
X-Received: by 2002:a05:6402:1ec4:b0:59f:9f59:9b07 with SMTP id
 4fb4d7f45d1cf-5c4029ef54amr299933a12.4.1725984410772; Tue, 10 Sep 2024
 09:06:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org>
In-Reply-To: <20240906051205.530219-1-andrii@kernel.org>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Sep 2024 18:06:12 +0200
Message-ID: <CAG48ez1+Y+ifc3HfG=E5j+g=RwtzH2TiE4mAC2TZxS52idkRZg@mail.gmail.com>
Subject: Re: [PATCH 0/2] uprobes,mm: speculative lockless VMA-to-uprobe lookup
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, surenb@google.com, akpm@linux-foundation.org, 
	linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org> =
wrote:
> Implement speculative (lockless) resolution of VMA to inode to uprobe,
> bypassing the need to take mmap_lock for reads, if possible. Patch #1 by =
Suren
> adds mm_struct helpers that help detect whether mm_struct were changed, w=
hich
> is used by uprobe logic to validate that speculative results can be trust=
ed
> after all the lookup logic results in a valid uprobe instance.

Random thought: It would be nice if you could skip the MM stuff
entirely and instead go through the GUP-fast path, but I guess going
from a uprobe-created anon page to the corresponding uprobe is hard...
but maybe if you used the anon_vma pointer as a lookup key to find the
uprobe, it could work? Though then you'd need hooks in the anon_vma
code... maybe not such a great idea.

