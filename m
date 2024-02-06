Return-Path: <bpf+bounces-21269-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8D984ACEC
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 04:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68BD428749D
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 03:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E0D745F2;
	Tue,  6 Feb 2024 03:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DZ7AdCqI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81545768E5
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 03:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190417; cv=none; b=bxt65Ve/RmA+6aTUqwyur9Ir8wl7CNXIjD7DTQIQcgMLCNuPOX0QTSAzV6rJK0QxTWA5StWpuK3Rx6mP9Rjs/ER/bg1qgoiuAdLaPBWyaAoX6EaAAN/lUZM6+6AmVHHcA72NSp0D4dlimhWF/f3/Jhq6UiuBIirejfXMInITyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190417; c=relaxed/simple;
	bh=5X1qsUi3skYX0+XJLWX/k8pq64P7f+cfj6l98r2VoJ8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BlBh4MWTKM0eLOQHbnNDEJK20tdY90NPDYxUjoSF1DB7KbZ0bg3tjfjB0KyvQ2KeTes7KliNqXFjMUSJ6JcGmdLjcHLbzcuCvnr1Umm7Daq+Fcq6EyGedX9kVonuF5sa4XKSHbug/HI6ztdolmkQgERWzly4TCey/LpwCEduq0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DZ7AdCqI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6c47cf679so9008341276.0
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 19:33:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707190413; x=1707795213; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5pESXQDW6zysG3DCALcAImBiyx5FS+UI74K+BRnd8=;
        b=DZ7AdCqIW4SN2p0fFMDtzJZsQtPSR2SW8mD/U+JILSftqL8rvTaRyvTFmtXRpk77+0
         usH3CaZILv3zi/4R5iZVfOOhJxmPYOKS/vbTefJmT1DdLWWLfXGUHHoB1CuUUjgqM61D
         SqywKLyd2ja6OT/OzJHMBpUJBWGAmniBKa+5Na0NvS9OwH2jnDHH2pnR5GasxDGYA3EX
         uJZ/HkhrRS5HhPQ4xQbY3xzjSYbds2vSuM2b5+3S06KwcCTjh2iK0uKKquTq5yme3OA2
         Iw9Mm5nnfyj2nQ+4PXEmMhcnAZuDuABnUeURZj+EaZYfO7sf33krKCNFTxPrEg+RrVV6
         Wj0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190413; x=1707795213;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5pESXQDW6zysG3DCALcAImBiyx5FS+UI74K+BRnd8=;
        b=AGQI3HPnkMIAOts7QYv40gK2ezKldtDYJFfEdxhp3oXKi/J5vajt17J9WJyKWSrDr3
         l7eRyc2Ee10yHyxIwK/V9iEYTgSkZhfc37WxrsagrLZvEiI8gkiBROUHY407+KWKaaWe
         CXQrSfWwpKLYx31wGoD/tL6aqWoxXwkLlDy66CXzA43K3bmN7m/DCdTx+EDCn9pdSxSi
         s9ynN+3FEBFiN/FKOfp/1VaKOrkysLdTkyrP7T0UerWuihg0BPg1QFpheQj0u0vo6vav
         4yRbPZv1hEZ9rD65aJd+Sj2ynOu7OgKEIC33rhqkB6/GYPvw6wY5sb2xuPoI+86L134/
         jteg==
X-Gm-Message-State: AOJu0YyoBJH0qM5P11TS73FCdTKp7BSWIheLRpzwfRMuQ63Wkf0FLUBE
	YGFYQnSvKkQAKWk445Eq9pCPMesE/OXlvXnte3Yews14D3DvhZSWQFGI7UNfwqPzn+2GfseyxbK
	YJeyyLg==
X-Google-Smtp-Source: AGHT+IEVrQzvef2PB8ocQh4oMNlAgaBdn57OMhZd6HACfNXpfG2wAAU0mWAbGbzOYfUhhHLOFL/kwhqvK7Iv
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:326b:71bb:e465:6f39])
 (user=irogers job=sendgmr) by 2002:a05:6902:2785:b0:dc6:dfc6:4207 with SMTP
 id eb5-20020a056902278500b00dc6dfc64207mr113515ybb.10.1707190413407; Mon, 05
 Feb 2024 19:33:33 -0800 (PST)
Date: Mon,  5 Feb 2024 19:33:18 -0800
In-Reply-To: <20240206033320.2657716-1-irogers@google.com>
Message-Id: <20240206033320.2657716-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206033320.2657716-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 4/6] perf maps: Get map before returning in maps__find_next_entry
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, liuwenyu <liuwenyu7@huawei.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Finding a map is done under a lock, returning the map without a
reference count means it can be removed without notice and causing
uses after free. Grab a reference count to the map within the lock
region and return this. Fix up locations that need a map__put
following this.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c | 4 +++-
 tools/perf/util/maps.c    | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 7031f6fddcae..4911734411b5 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1761,8 +1761,10 @@ int machine__create_kernel_maps(struct machine *machine)
 		struct map *next = maps__find_next_entry(machine__kernel_maps(machine),
 							 machine__kernel_map(machine));
 
-		if (next)
+		if (next) {
 			machine__set_kernel_mmap(machine, start, map__start(next));
+			map__put(next);
+		}
 	}
 
 out_put:
diff --git a/tools/perf/util/maps.c b/tools/perf/util/maps.c
index f4855e2bfd6e..e577909456be 100644
--- a/tools/perf/util/maps.c
+++ b/tools/perf/util/maps.c
@@ -956,7 +956,7 @@ struct map *maps__find_next_entry(struct maps *maps, struct map *map)
 	down_read(maps__lock(maps));
 	i = maps__by_address_index(maps, map);
 	if (i < maps__nr_maps(maps))
-		result = maps__maps_by_address(maps)[i]; // TODO: map__get
+		result = map__get(maps__maps_by_address(maps)[i]);
 
 	up_read(maps__lock(maps));
 	return result;
-- 
2.43.0.594.gd9cf4e227d-goog


