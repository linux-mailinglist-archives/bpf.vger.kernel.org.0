Return-Path: <bpf+bounces-21445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC95384D5DE
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 23:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BA4B1C22772
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 22:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791F3535BD;
	Wed,  7 Feb 2024 22:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQsXdthF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3C8200DE
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 22:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707345438; cv=none; b=u/lzNWdlb6ftED6Pz+iK5v5UipPTXwOodUfW9l1ItmpCzkZO+ZlZs42DEJCkmXMVIRR3VNM/Nc+6XA8ZWPnk+2IQrCG8LJ2ktF+kNscfsHCetvf3sfn/WXfRjyOii4kcAlTY2bZPJ5NNyt6k+wSGtbc0mEa+HLsyrLhIIE8yIKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707345438; c=relaxed/simple;
	bh=5X1qsUi3skYX0+XJLWX/k8pq64P7f+cfj6l98r2VoJ8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=OPpAHnryeRi+ozdj+t2VlSH6+ILiphG4vg2m4OOoFyYk/PNE5lyRtl7nTXGgwKLIXXfmeXqsdWFeGiGXkY6DphRfs+tP2Uyk/OsM/OASKMU796Q5nQr5GouQyyxKrUQJSM+NFs12A6F7Z5nLSx/LrQioG83RIW1KhQ/U90SV+cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQsXdthF; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b267bf11so1558785276.2
        for <bpf@vger.kernel.org>; Wed, 07 Feb 2024 14:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707345435; x=1707950235; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5pESXQDW6zysG3DCALcAImBiyx5FS+UI74K+BRnd8=;
        b=dQsXdthF7lP2EUNImu/ot0FOmbNBfIXa3gz4jhwCDy48qoxUU/n06nNnBW06ewwqB2
         Svu6OZZoJqWdZdvhrh4U1QWvoNQjaRcEry0Iao/ARGbGn9axVs1PQnh9SveHx/365CPl
         HyN3yqNNXnf4x0nDTJ+s54A4JKc7G3KJrXZVGvBLkVCdBs6eJ84QdE2kwyomIX/oVJs9
         7oY5KeRaTuccN2DexDY+8Dw+l7Eq9VhlGUi9QtWJDBi3+dHE3UypRfn890j06zJ7ri2Y
         B0SgmJn68FzCicJU5Xl9ITwK3FVB0TubEQ0iuDTKO3OmEkSmq4YUk5UK05WYPIElsLSz
         FbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707345435; x=1707950235;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ay5pESXQDW6zysG3DCALcAImBiyx5FS+UI74K+BRnd8=;
        b=JZy2GtXgDXfGPr/AheeHtzVylyrWl8mWV6fF/Mssm6BH3UR2rU1SRSwiI/Xg1X4oCW
         X3Ii18R8TSfTZRpl7LcQ51DIoOemNxJqp4+58GjVXjnWelgpIG5VwGgtyWRAo1p0Ywln
         9lRsvfbRPhOmzNirYECG/wlRchfDv6xmGXqaQHgikjSE2mb8TiBYD0RMo8eMhLzKeZDh
         ZaIdK7v5+vOGi3X7KeJWfRJLlnRYoV3npj2UIkUQbTKLkzUhRVh1TX4GO39IpvU5oUN8
         m/NntdsQAKlUFF25XZ9SRbKcbeGdbjX4k16/ZyYD+Sv4l05S7CqKA+tSsDh5ILKL7QZg
         Z6RA==
X-Gm-Message-State: AOJu0YwVbhJefdVHs4FNq98FwWJi14PVS2q4EaF4GYh9AI42aEQuzzRG
	dI7PuyQ4uGfnWUo7MvR6R9LoFzgqscE5huPcyZADe+in9D95n1hihGCXTSRjhZihPH5i1k1YtDg
	h8Gm7Ng==
X-Google-Smtp-Source: AGHT+IHbtMYWuzYHXhS5ctyAMGabmYuIiNGWRGgPeLvudlMT9gVnGPPBJ5p9zHsmOiZ6Mmjxe7vYEsVc3Z5b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b420:757c:5706:d53b])
 (user=irogers job=sendgmr) by 2002:a05:6902:2205:b0:dbe:387d:a8ef with SMTP
 id dm5-20020a056902220500b00dbe387da8efmr230404ybb.1.1707345435298; Wed, 07
 Feb 2024 14:37:15 -0800 (PST)
Date: Wed,  7 Feb 2024 14:36:37 -0800
In-Reply-To: <20240207223639.3139601-1-irogers@google.com>
Message-Id: <20240207223639.3139601-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207223639.3139601-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 4/6] perf maps: Get map before returning in maps__find_next_entry
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
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
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


