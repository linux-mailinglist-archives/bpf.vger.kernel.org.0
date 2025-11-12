Return-Path: <bpf+bounces-74274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1794C51211
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 09:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC7FF3AC69C
	for <lists+bpf@lfdr.de>; Wed, 12 Nov 2025 08:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC02B665;
	Wed, 12 Nov 2025 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+4s9Xka"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9402F3C32
	for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936330; cv=none; b=hWZTJhebqF53UxX+CAzAkKlqsl1hKZDa/Lmmmy8UZiW+b1BHPETNVKeX6u7HM9pJrPYxu2jEuch3wevug5wVGIzTyiVVWnSINhGRXT02OeZNVmCmPmd4BaAeflJmVnXMEx78SNE/k5k17jfhvyxuRwf6b/t4A15a0TRV1VMxOQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936330; c=relaxed/simple;
	bh=BuVPFMENq05f/6z3zQw7snGCf3tlNXX2f/ChR+AVb2M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hDUOhBmochvyxZgSA9ndjbuJYaePXq1LRFhqvgLmpXZw1SU9Crv5CnujXUqJWwziw/NskKpgqfpSl6T77W40Unq8IEYVWj1+je8CkgasuEiqoma0EFzAW7XufZO9lsSUYM2QANTZrwX381s55PIG1Ps9Y8254c1e8jhvYESmmd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+4s9Xka; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b726a3c3214so42663966b.2
        for <bpf@vger.kernel.org>; Wed, 12 Nov 2025 00:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762936327; x=1763541127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BCrHRCHcjF57c4iDsSU8GU1LVPucGNyGGoj+cLyyFrI=;
        b=M+4s9XkacfJviboAV4voQW5IYV9hAb6/k2gtH0N/1opJ6/ZFK0P/5iqCelN//b28oB
         LFA70MSerOIkXzJyB1XJ5hi6zQv1iokxwPM1kptzyqWxWDl7+Pxf57daLeoQtYQ///qi
         NY3TZhSUwsF6FGmX4ufUkQV00lNV9yCm3ODrni7cqKAtHKqRCOIeumSyVnNM9HKO0CAy
         0+9lGPRLfs+3/H1GzStg/IwbnyDIqdSH1zyul/Ao61xcOpO/UZNNruxs0wwr1tS5vXLD
         v0aszsLW+aKHP5GAp6tDyOW6jwLwUW4SzT4+ytD6GA0WturMSAD2XXWvnPxPj8KPCfGP
         AMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762936327; x=1763541127;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BCrHRCHcjF57c4iDsSU8GU1LVPucGNyGGoj+cLyyFrI=;
        b=JZHfZG0uve2POaKmUG03GR4oRJQ4v4itUGaINmGeT6zwOAqeyc660Xj88fwy5lk+K+
         aIXtS3pZ5A6v5oUjcA6FspMK8nvogREUh7jbOU10VITcW4Jk9kW/L4dJP2inHiJk6XUD
         zMdP+B9UiFsCX8I3Z9RbtuSwTctsuh28C31oHW5FIbjpsURz65+r7gfNuy38gK4b92zW
         OtGxJ+UKfxbLW6vhSdOYLNL8fuZmwIYxBPYEwhhXHmEah4svPiYlLZJ3VWUElMFPk5x5
         le8Am+73CRCNy5TThHx/+adx4hAvsMn/v6EvTLJ/w6DN7GxjXDPmTqOrtWsAb2S8rigr
         55Ww==
X-Gm-Message-State: AOJu0YwqPmvyMtfkHzlJ1MdFxgArJ+iL/U3rKvZ0niwyfkgs7rcbnLMG
	idsMrla967yJWeLx2nZOGdzWE1BPdbrlQhcJIv0Ai3PNPUb4vqSYjId/LeG/3zJquU+h+o5PerW
	rSdT9BJDUz3ZjN9mhplc4//466MbxkFSb6DLsdsxzFgnB5wEJJK5pv1VsOnFm4aBfgY88y4+Dmm
	rUDe1kJ6XWoKjeIwTmBTBddtZuR5rd7qkYiM+fokbMftlcfSWjgHu0FZ3Vu0QKecy8HIek2w==
X-Google-Smtp-Source: AGHT+IHoXniMh49yeJNYNyxmoALutpn0/Zv1XWFu7GdNPs1oaKCdawXVfXCo9cT9H380828hlExd2zn0c3GEGl++CTju
X-Received: from ejcsn11.prod.google.com ([2002:a17:906:628b:b0:b6d:5365:c7c9])
 (user=mattbobrowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:6a16:b0:b73:246d:cf1c with SMTP id a640c23a62f3a-b7331af0e07mr215018866b.63.1762936327135;
 Wed, 12 Nov 2025 00:32:07 -0800 (PST)
Date: Wed, 12 Nov 2025 08:31:53 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112083153.3125631-1-mattbobrowski@google.com>
Subject: [PATCH bpf-next] selftests/bpf: retry bpf_map_update_elem() when
 E2BIG is returned
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, ohn Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Executing the test_maps binary on platforms with extremely high core
counts may cause intermittent assertion failures in
test_update_delete() (called via test_map_parallel()). This can occur
because bpf_map_update_elem() under some circumstances (specifically
in this case while performing bpf_map_update_elem() with BPF_NOEXIST
on a BPF_MAP_TYPE_HASH with its map_flags set to BPF_F_NO_PREALLOC)
can return an E2BIG error code i.e.

error -7 7
tools/testing/selftests/bpf/test_maps.c:#: void test_update_delete(unsigned int, void *): Assertion `err == 0' failed.
tools/testing/selftests/bpf/test_maps.c:#: void
__run_parallel(unsigned int, void (*)(unsigned int, void *), void *): Assertion `status == 0' failed.

As it turns out, is_map_full() which is called from alloc_htab_elem()
can take on a conservative approach when htab->use_percpu_counter is
true (which is the case here because the percpu_counter is used when a
BPF_MAP_TYPE_HASH is created with its map_flags set to
BPF_F_NO_PREALLOC). This conservative approach approach prioritizes
preventing over-allocation and potential issues that could arise from
possibly exceeding htab->map.max_entries in highly concurrent
environments, even if it means slightly under-utilizing the htab map's
capacity.

Given that bpf_map_update_elem() from test_update_delete() can return
E2BIG, update can_retry() such that it also accounts for the E2BIG
error code (specifically only when running with map_flags being set to
BPF_F_NO_PREALLOC). The retry loop will allow the global count
belonging to the percpu_counter to become synchronized and better
reflect the current htab map's capacity.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 tools/testing/selftests/bpf/test_maps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
index 3fae9ce46ca9..ccc5acd55ff9 100644
--- a/tools/testing/selftests/bpf/test_maps.c
+++ b/tools/testing/selftests/bpf/test_maps.c
@@ -1399,7 +1399,8 @@ static void test_map_stress(void)
 static bool can_retry(int err)
 {
 	return (err == EAGAIN || err == EBUSY ||
-		(err == ENOMEM && map_opts.map_flags == BPF_F_NO_PREALLOC));
+		((err == ENOMEM || err == E2BIG) &&
+		 map_opts.map_flags == BPF_F_NO_PREALLOC));
 }
 
 int map_update_retriable(int map_fd, const void *key, const void *value, int flags, int attempts,
-- 
2.51.2.1041.gc1ab5b90ca-goog


