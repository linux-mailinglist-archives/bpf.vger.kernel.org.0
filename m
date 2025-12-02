Return-Path: <bpf+bounces-75873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 76579C9B5F6
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 12:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 95577345FDF
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 11:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B2330FC1C;
	Tue,  2 Dec 2025 11:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Yfiy3qnw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CE228BAB1
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 11:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676338; cv=none; b=HKpqwl7CzUC5v8SQ15foEIz5CUPWguIFjVT75JuQazZgpkx53w8TUgoiQsChJwesbFMqmb8CO1SaxPJ1PR4G05Zs/DvZmECZoNmkbS3X+e13XBfKQXvAlhDNa/mgI/IuxiiJajRw9NiNTNofyUXWB/X02yL5acJNfeFtSkcbYjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676338; c=relaxed/simple;
	bh=RZiMVeuMpFtsxH0FT6sSt415Si5xUzm3G12T/hIkpi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fgu704jvTmWRHVMz6jbtesHp0zMH8UD2BxSd/gZ8eXHyMoRDJvYCpuMZOmbSxE0f9PS8Xt6Cpmzm0YMDwiezfrY6OsqRRBlShAxw8utJrL88N1mZjLW4C1j7ZM8pLqPS22wUNM+2x7gWGEatx+D0PljtC36IU1SQZtZ5ij23onA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Yfiy3qnw; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 02D393F66E
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 11:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764676333;
	bh=JIEUjuYaaXoiZWfV9sg4WJ4d4l0iSxZy3vnXjkSudlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=Yfiy3qnwNIzb+I6kCjuK4Q3zRPzsuO3/py4KWHIbiGTp6tlwLduBR3mbRFrNQU8sS
	 GaS4LyGVA+PsnkS2WGcYwTGWE6dKk3by2gsKdIF5ldltOGSH9d4SiG1OxkWqMcnfkn
	 bWq1z43Bsupghy1WQv7n/p7GCYRD13i/z0ywiVQtMgOrnSk8ENewixMKkZmxdS7PxY
	 d8+UchkzbpZLGJ+LsLLRLH7iQ6coI5Y7QHEo3oTAvSem7yGvEAZJahOes756KtXTkC
	 XLmc9Phf/zxo3i4PJufTVZbSJpGjLBk1FetQjwRdPSmywM6QSX58u+pQQRaxHPT5eS
	 AK4CH8j7IcwD23S4N5rBf1ApzvJLdI6Gsu4eA4UHlVkZKScyyzqHAZ+yAycIkAqeA0
	 k29AxWsNW9nTtknkNT5kI0LTyg6vFNLFIBjEvv8IZ9ha/8po4kt36ueoaLmcgNeT5A
	 g5X5XyPtuXgrhEEfBc7wogmB353cmJfUr6Mi7Ln+/i9XN+wJ986zfPHoY+LPm2hnLZ
	 PmjFVF4tDzLltXHU9ZFwkyoFZaK+LHk7gr+a2NUf0KPDBWBjs9pq6hN4hwrdKGiLtX
	 iEyjf0lfF+Jfqt1KU0RFUDSuYo5kJ+xrY8JgC0qwP+Jr+rZCu0FYiLY7zR7lBJGtgo
	 4nS38Hv2WFase5vDnYhSiPLY=
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-640bae7d83aso7226675a12.2
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 03:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764676331; x=1765281131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JIEUjuYaaXoiZWfV9sg4WJ4d4l0iSxZy3vnXjkSudlI=;
        b=iDgBUui2G0hq1pvdb3e1GiGH2xohwHHKwVeEdnzRb9Sf9CdK2JJp86nnBCVn4pK4Q9
         wECZ8wL3shq4AAE5qNncfq6pjD+G6HSr5mNEqxhs50dfeK3W3K5AtTq1EA48RLfQReax
         LtFME+3HaYjMVsrtyQJB2khvf3H30GB6y8tddQtAaGuxhPvxMwq+zvCMoEx15gbnqz7J
         wE70iRS6tZ7Y8GX+YVlgePCfjLq9CcMt+vv8jdsBTZ+7lIIuvZv1uNczjS3wsCK5FKCb
         uAC46iIJ4URNIk5HiIJPjTTsHY5p5gs664VLuxryUbaatx+oiNdbRQrChCtqVaJWiTjf
         FozA==
X-Forwarded-Encrypted: i=1; AJvYcCWnSlI4cxp7TNcW+VeyN7wd6evCTTNSCNZh/71+AEHL6+gL+g/J8oQIqLzhbhl94mM8vf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdW4M/iF9QegruaCbPVypNBVqaGnhc5NprrKpL1ZUuZxSzfmll
	2qZZXNv653ZEUsC8ugfR/osEkOFEGqshhhvHVaP3KwZQ0sTUoL1eHdhCJPFdAS+lbwLa9WgZql0
	Lm2Nyyq9XzkHqF8DtHgw/pI1e/k2AKT6ht++zeD0AxO+B0NIIm3zgy+HgvJl8zh2nBlfmRg==
X-Gm-Gg: ASbGnctHWZrd/t/OTY9jYEvr7tQ1HlrJrtLq0CKkQP+rOLZk2Syg9Jwk9RfxTg1TW3W
	pWOeiIEiCmOYyI8ywZEzXY3+L0PJMqX3GLtYMEVFgQF9wWBASCrZuODTrhDDSqUo4IOqp4SROrH
	jbpyQaAKmuJ5LADATf7fhOoy/wF5GPJ0pVrl4ZhsZXkFFwzD6VZhOd/cij7L/jeHqdwPrrWrwlw
	L/TUC5MxnLAR+6C4qqBN22XmiGalXVVZOc91timDYWECKBH2glJFIBzmPdNhyScxJLYmo3NbguJ
	YDL2ysnFMP04Q1OwFkwzQafdp1jGBfDuit22MU2QEORfSPNF7m49O68sqIkgRyxto8wtGm+UsEV
	nbUhXRQfsf1DCAealmxE/WG43c5xneopmNxqUXMOzUjjZKhmPTXVVimg8sKfa9xDM4k3rQqNhzC
	rcIwQjH4meuJEsbEamUB3HS/4=
X-Received: by 2002:a05:6402:1467:b0:647:8d63:d8b4 with SMTP id 4fb4d7f45d1cf-6478d63d985mr1389528a12.6.1764676331234;
        Tue, 02 Dec 2025 03:52:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnMiVlmki0ogqB/rjjKmxYW241m0D9+1e4z7ydsRRIt5eGoAPCv4LFWTLrYgGpg63kI73JFw==
X-Received: by 2002:a05:6402:1467:b0:647:8d63:d8b4 with SMTP id 4fb4d7f45d1cf-6478d63d985mr1389506a12.6.1764676330801;
        Tue, 02 Dec 2025 03:52:10 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5702200011ee99ed0f378a51.dip0.t-ipconnect.de. [2003:cf:5702:2000:11ee:99ed:f37:8a51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647510519efsm15206765a12.29.2025.12.02.03.52.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 03:52:10 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kees@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>,
	Will Drewry <wad@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <shuah@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>
Subject: [PATCH v2 0/6] seccomp: support nested listeners
Date: Tue,  2 Dec 2025 12:51:52 +0100
Message-ID: <20251202115200.110646-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Dear friends,

this patch series adds support for nested seccomp listeners. It allows container
runtimes and other sandboxing software to install seccomp listeners on top of
existing ones, which is useful for nested LXC containers and other similar use-cases.

I decided to go with conservative approach and limit the maximum number of nested listeners
to 8 per seccomp filter chain (MAX_LISTENERS_PER_PATH). This is done to avoid dynamic memory
allocations in the very hot __seccomp_filter() function, where we use a preallocated static
array on the stack to track matched listeners. 8 nested listeners should be enough for
almost any practical scenarios.

Expecting potential discussions around this patch series, I'm going to present a talk
at LPC 2025 about the design and implementation details of this feature [1].

Git tree (based on for-next/seccomp):
v2: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners.v2
current: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners

Changelog for version 2:
- add some explanatory comments
- add RWB tags from Tycho Andersen (thanks, Tycho! ;) )
- CC-ed Aleksa as he might be interested in this stuff too

Links to previous versions:
v1: https://lore.kernel.org/all/20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com
tree: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners.v1

Link: https://lpc.events/event/19/contributions/2241/ [1]

Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Will Drewry <wad@chromium.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Aleksa Sarai <cyphar@cyphar.com>
Cc: Tycho Andersen <tycho@tycho.pizza>
Cc: Andrei Vagin <avagin@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Stéphane Graber <stgraber@stgraber.org>


Alexander Mikhalitsyn (6):
  seccomp: remove unused argument from seccomp_do_user_notification
  seccomp: prepare seccomp_run_filters() to support more than one
    listener
  seccomp: limit number of listeners in seccomp tree
  seccomp: handle multiple listeners case
  seccomp: relax has_duplicate_listeners check
  tools/testing/selftests/seccomp: test nested listeners

 .../userspace-api/seccomp_filter.rst          |   6 +
 include/linux/seccomp.h                       |   3 +-
 include/uapi/linux/seccomp.h                  |  13 +-
 kernel/seccomp.c                              | 116 +++++++++++--
 tools/include/uapi/linux/seccomp.h            |  13 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 162 ++++++++++++++++++
 6 files changed, 286 insertions(+), 27 deletions(-)

-- 
2.43.0


