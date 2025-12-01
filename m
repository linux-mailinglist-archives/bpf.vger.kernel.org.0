Return-Path: <bpf+bounces-75800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D9574C973BF
	for <lists+bpf@lfdr.de>; Mon, 01 Dec 2025 13:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ECFAA3433F9
	for <lists+bpf@lfdr.de>; Mon,  1 Dec 2025 12:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB0130C36B;
	Mon,  1 Dec 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="CqRsitSh"
X-Original-To: bpf@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4260730BB8E
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 12:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591862; cv=none; b=GUpZDoRuXCY1rz90YMmA2jU04NRP/N/2l4iSruTYAH6NIOZNzpdiTZGhvv9T7YW4MLfPsGXvTT9Z4YAfV7DoiG+XmHKmxIhK59rdQr5whpfxZYW6MqufuN5j2ZDLhHVbIPeAmmlE0URfbuIoNdlJbwGAjyX/muZNERLXujV62LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591862; c=relaxed/simple;
	bh=/+W6BnRm41PwQfr1i6QnKDnTOxqcyEQ40SOEI/y9Gs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GDld6AriSwyRXUj0w6If5euaPbVOe2PdMZGvpLKM5X4lNZ/jx1axDCDNa0t7vTIkc2HkuV37LdiBY+e2qQK+2NPH+AKr+nvVhQCYMddoqL9nnXGmsA0Xn0B+JpNGCsdiF8pyKaXFqeh00I8O+37AgG3VBtUGnPlmmlRehRaJ3EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=CqRsitSh; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E58783F2B2
	for <bpf@vger.kernel.org>; Mon,  1 Dec 2025 12:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1764591850;
	bh=7Mkjq1bUgfEqWcPG7pP9ef/rURS8Z4bqcdLjGL4dulQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=CqRsitShdbyq4BaFNbk5LYhFfkw+KdYHgiTUfbewSpUa/bNSTTZAfow7OZG5lQmkT
	 fRgAN69KoAMiEjlZm9PvUzgatw5o5D0JC6EO+raKIy5djzXd/pgCuSlKkkqtygZdDt
	 uGVgK68GRjAotxGkngqUWAeMyY9aGX+1HWZkHqC0xLgwycYp1wOMp28ohZxY4GRNSp
	 XIKU63edJuKwsFTdF04JcvdiaRoRyIIosVXSxbO/hr+af1/cVUjARsDDO/j9Y3qSxq
	 nKJUlnTeh7TuVvpRm3Fl6fF3ponG6poypDlvhUkOTTtbNp+y82P2DnKRnf5M4pkEJd
	 wfgrk35UJJTQ7vSa0klK1SeYsNJsUDh4RTsoxamXhILkcmFxg52lsM5fn0n96nPnNn
	 mpZiD4PW7uRlTpIxyJ1ksCY58/X7CRLR6Dt84aNLt5AiPlrPdXBdDlbmh8r4iAcwf+
	 stJaQO5xKcU+bXVy4UJoTc7q9dXa1eT27kRcRmfIIhmgKiT9peR4hwS7ddj3bPuFtg
	 E9wm8J59zLSGI1FakvwNNFcLgK0tvd611TttK4bWsD+2bdyJ60iT2Ev6wyXeVzY950
	 0tqi+75fnfTE1N7L/YT7E7HxIUDUcE+/TmYs7M/hhsYz0hXQ1DGkUJJBMPToUb4VSl
	 xZGCx825qmT7rIESYOELuUP8=
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b735eea0bddso352280966b.2
        for <bpf@vger.kernel.org>; Mon, 01 Dec 2025 04:24:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591850; x=1765196650;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Mkjq1bUgfEqWcPG7pP9ef/rURS8Z4bqcdLjGL4dulQ=;
        b=BcniOPar5KHMfYm9G8ZW2gL4biAu99FxVoOwzOUCSrHuCMjcoTgMxR9Q/lq8f+y714
         HRlJFYfCaGvFCrF2VXI5PIXeutuoMFQmYFs1UuZc9JeM9GucJaWIJ3D5ktPMPo31xG4A
         KLyx5HmbOdNLInCw5hSkYzvqslCktH+gWL3HC0vzDznVvwZu09UTkedUbfBqhUGNU29S
         RNhk6QvbsvPh+N07ZbvzP71lotbGIY/tG1K3SjLGhprFyzIT0+ARtFo4gCN1bxHlQJ8C
         J6bbSxaBBfy5uEZfNjNHNh8zLZuROedyXY7fdQK49vbIkbKOMU7gQy36WA70E++5CobV
         2BaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3aTQW2m9vuYftgGgVU+rXhDkzjBmLkMWA0I/nTVaFN4V0twP5/cHUHB0WW1R+0mOvicg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuX4XhC73LW5rGwJRS+EsvcJSoHjZvmcZ34c5G77FsyF5cXKiq
	brtnmqWeakNcPOkuFQNQjYW84LJyS8MiWn6dWvyiBXDZYPbX+J0cufW6RZM3aOiZuI9YUxWBxIL
	2FQlYtVfvaA2tyXKJi8x3Bdf0LwN8kEjS5mRDjIf69g/bKjyjU6mD1ULPvT2NuCnWdLXSiw==
X-Gm-Gg: ASbGnctwRmNpja12B/LzE0O93cjo4Y4Dv6XUU9Qv4kx6fh20Al6a3L+9WvkUUDEB/Oq
	xBQmvSibvkY+k0dO5od7nrubxZG7plmmOFk90e/FnP0lLgYC9sKcF9ApPDX81dyE4qE85FWxJxa
	ox+A/A7Fw5wYw9U8hpmZAD4jupDSSpAtHIEUQvBYXDymu6nGAfnYWXZsjUfwu+t4n89JgGjpiqw
	CtMZgC1vUcQD45ycSYwve1HvjwduzLWQrRs4qe9d2mVI/Oe5SaqGJ4YG+soJt7z2Hd9mwrM6Jln
	9vPEnMelS9oAmBKawKn9X/9LmUsgdoa4PW/uc6L1wsstcYFO3Wa8VmFqxX/GGerBJBOeK5aSY2l
	w0wXudJ/d0TAmNSOt5u/4e14HXfrrqURy4u94Tyx6GwBcLrwi+ikr3T0WsqHLnHWlgsI5DZuv1o
	wZj67qY7T2r0silSP/7KqPqMse
X-Received: by 2002:a17:907:9812:b0:b73:398c:c5a7 with SMTP id a640c23a62f3a-b7671847649mr3675877866b.41.1764591850306;
        Mon, 01 Dec 2025 04:24:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB6mTSXIUXj7rWz03oA7m7S8ohwwSd/s14P0xUJXb50kip7lK8odKTbRY9H9EdRDRcT1PoSA==
X-Received: by 2002:a17:907:9812:b0:b73:398c:c5a7 with SMTP id a640c23a62f3a-b7671847649mr3675874266b.41.1764591849812;
        Mon, 01 Dec 2025 04:24:09 -0800 (PST)
Received: from amikhalitsyn.lan (p200300cf5749de007c66abd95f8bdeba.dip0.t-ipconnect.de. [2003:cf:5749:de00:7c66:abd9:5f8b:deba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64750a6ea36sm12307884a12.2.2025.12.01.04.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 04:24:09 -0800 (PST)
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
	Tycho Andersen <tycho@tycho.pizza>,
	Andrei Vagin <avagin@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>
Subject: [PATCH v1 0/6] seccomp: support nested listeners
Date: Mon,  1 Dec 2025 13:23:57 +0100
Message-ID: <20251201122406.105045-1-aleksandr.mikhalitsyn@canonical.com>
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
v1: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners.v1
current: https://github.com/mihalicyn/linux/commits/seccomp.mult.listeners

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
 kernel/seccomp.c                              |  99 +++++++++--
 tools/include/uapi/linux/seccomp.h            |  13 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c | 162 ++++++++++++++++++
 6 files changed, 269 insertions(+), 27 deletions(-)

-- 
2.43.0


