Return-Path: <bpf+bounces-46975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AABF9F1C07
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 02:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DB9188E914
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 01:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AB914286;
	Sat, 14 Dec 2024 01:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b="Jzsst0pJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EB4DDA9
	for <bpf@vger.kernel.org>; Sat, 14 Dec 2024 01:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734141552; cv=none; b=f8p3Lg8b2jhBHl1SYaTwWL6kHFKr1f6qBDQGufbXxBRA2ijaLSA2+uSWO7glNFp2N8mDcADi71Qfea6XX4dD7hf7az58wi939CPc1InuoJmBZ7Cis68nkrdWUzlSKwhXA5xb2+ItcAoMPkeJtey5n2qBb3VapLALtcQfF+m8cQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734141552; c=relaxed/simple;
	bh=dr+0Ypf7HbQvRd/1kCck009L22qQ3LOFkZdnmIZGJ8g=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=N6sprRS4QPZ78ytCqS6iRRieHYWGSW4sNsb6DCyx1+GS6s/4C8qXZzMiaZ35xYQsDOazbf/IZXAMITY2KiMzZoga5auBM+wFOIVqzpK/1o5h0bIq3bn+FAmTW3HakQ6+rws/KF/wPdXJVfaWo6VIUNUHOhPz+SPG7Vlp7CP4SEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu; spf=pass smtp.mailfrom=uci.edu; dkim=pass (2048-bit key) header.d=uci.edu header.i=@uci.edu header.b=Jzsst0pJ; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uci.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uci.edu
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d92cd1e811so32800456d6.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 17:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci.edu; s=google; t=1734141549; x=1734746349; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dr+0Ypf7HbQvRd/1kCck009L22qQ3LOFkZdnmIZGJ8g=;
        b=Jzsst0pJiIpRXZhCbujR5lyfVM0tRVwhumrWmVrBoaML3NmpWov8h8B8k5AVv07MBG
         WF0VJUWLznZAaFiFJvySW9HhJ2BzQ1QylDBJMB0EneQxn0XZOpGxWlcJRG1CfRBsd0/F
         V4uBM3zjgT9hI7IH9HJVNV+D5TFbrEOZJZqgxV4Y4Qcfa5pO5Gg/jPcLvlH57NPSyloZ
         BoTm3UE/0fS144S83OYRQjsBxn5hxe4oHT4ONFibRzY4paGIsp3mw555nZB0kKJGiwvZ
         HQp1MUKaW9HslChpuka0hdjq2u75Gqn1vrWlPbnFisZ1pp30fQfjtNb6LDd5NQRjAcgK
         JWiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734141549; x=1734746349;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dr+0Ypf7HbQvRd/1kCck009L22qQ3LOFkZdnmIZGJ8g=;
        b=sPfQrQgL0f4w0KdUfFf3xy2ZEn47IQR5BCk/X2YZrJe0NQI9KW2pXJO4IUkw0FT/2W
         FSeAktOZuT7UF9MBsSn/mLpji49uRj8q622oivLU7ctQZwMm3J4zGZrDLGd8jXmdxKc/
         BISTEd4GFPSEU4sEaVHH15uDwtsqr0VXDG9ZdsZo8bIWqwCRR3bHl5iEKBpCXC5NYQpz
         Q+PMEIuazX6MSzg0hG7jaxAjJfR2w3WHP0Ib9+i6EmxbYczjrnKSbWGjUpMAkrEmGWVg
         /3wtAoLqxXfUy52frL4vdYuU6br/tS6aekyy+4N+IGrGnK4mLgC0SgwNMse4MVO0X/Xg
         zwTA==
X-Gm-Message-State: AOJu0Yx4Z3ogG2d6sPeOx5tTmoEBFgWee0TdJAPM07DpRwRvUzeA330r
	RZlHcn6LWJn3Ji1SxiQItaEZ1FINwyb0td5EgspwP3MpDkhLR2IquoMqnh+wtAqr1+FZ95+eC+l
	mPgTfYNWZCR+gxs67ufZF6gAto6iIEfbX01ABiA==
X-Gm-Gg: ASbGncv7eVNCSCd/GNMeOGR6oo6+VSFbLnHkU+Lj9RET4iVnB/PHu7ftREKFB9wkC7C
	pGZfENFwzDaMP7aygKszPNAwWuDfU+rI3snIS0Rc=
X-Google-Smtp-Source: AGHT+IFqtdbd1yJO+ey8Mo3z9Fi8zwN9QikpZVE+od/ZvhMTTGFiMYJ/1XSbvahGSp/r4UyrfNa+cRSToI1UZApz9z8=
X-Received: by 2002:a05:6214:1d2b:b0:6d8:8283:4466 with SMTP id
 6a1803df08f44-6db0f48612bmr127951256d6.18.1734141549329; Fri, 13 Dec 2024
 17:59:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Priya Bala Govindasamy <pgovind2@uci.edu>
Date: Fri, 13 Dec 2024 17:58:58 -0800
Message-ID: <CAPPBnEZpjGnsuA26Mf9kYibSaGLm=oF6=12L21X1GEQdqjLnzQ@mail.gmail.com>
Subject: [PATCH bpf-next] bpf: Avoid deadlock caused by nested kprobe and
 fentry bpf programs
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Ardalan Amiri Sani <ardalan@uci.edu>
Content-Type: text/plain; charset="UTF-8"

BPF program types like kprobe and fentry can cause deadlocks in certain
situations. If a function takes a lock and one of these bpf programs is
hooked to some point in the function's critical section, and if the
bpf program tries to call the same function and take the same lock it will
lead to deadlock. These situations have been reported in the following
bug reports.

In percpu_freelist -
Link: https://lore.kernel.org/bpf/CAADnVQLAHwsa+2C6j9+UC6ScrDaN9Fjqv1WjB1pP9AzJLhKuLQ@mail.gmail.com/T/
Link: https://lore.kernel.org/bpf/CAPPBnEYm+9zduStsZaDnq93q1jPLqO-PiKX9jy0MuL8LCXmCrQ@mail.gmail.com/T/
In bpf_lru_list -
Link: https://lore.kernel.org/bpf/CAPPBnEajj+DMfiR_WRWU5=6A7KKULdB5Rob_NJopFLWF+i9gCA@mail.gmail.com/T/
Link: https://lore.kernel.org/bpf/CAPPBnEZQDVN6VqnQXvVqGoB+ukOtHGZ9b9U0OLJJYvRoSsMY_g@mail.gmail.com/T/
Link: https://lore.kernel.org/bpf/CAPPBnEaCB1rFAYU7Wf8UxqcqOWKmRPU1Nuzk3_oLk6qXR7LBOA@mail.gmail.com/T/

Similar bugs have been reported by syzbot.
In queue_stack_maps -
Link: https://lore.kernel.org/lkml/0000000000004c3fc90615f37756@google.com/
Link: https://lore.kernel.org/all/20240418230932.2689-1-hdanton@sina.com/T/
In lpm_trie -
Link: https://lore.kernel.org/linux-kernel/00000000000035168a061a47fa38@google.com/T/
In ringbuf -
Link: https://lore.kernel.org/bpf/20240313121345.2292-1-hdanton@sina.com/T/

Prevent kprobe and fentry bpf programs from attaching to these critical
sections by removing CC_FLAGS_FTRACE for percpu_freelist.o,
bpf_lru_list.o, queue_stack_maps.o, lpm_trie.o, ringbuf.o files.

The bugs reported by syzbot are due to tracepoint bpf programs being
called in the critical sections. This patch does not aim to fix deadlocks
caused by tracepoint programs. However, it does prevent deadlocks from
occurring in similar situations due to kprobe and fentry programs.

Signed-off-by: Priya Bala Govindasamy <pgovind2@uci.edu>
---
 kernel/bpf/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 9762bdddf1de..410028633621 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -53,3 +53,9 @@ obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_iter.o
 obj-$(CONFIG_BPF_SYSCALL) += btf_relocate.o
 obj-$(CONFIG_BPF_SYSCALL) += kmem_cache_iter.o
+
+CFLAGS_REMOVE_percpu_freelist.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_bpf_lru_list.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_queue_stack_maps.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_lpm_trie.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_ringbuf.o = $(CC_FLAGS_FTRACE)
--
2.34.1

