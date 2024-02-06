Return-Path: <bpf+bounces-21265-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0224E84ACE2
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 04:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2063286B84
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 03:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5D7745CF;
	Tue,  6 Feb 2024 03:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hGJOeYPg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADF745C9
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 03:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707190406; cv=none; b=Czh2cBsZbo9ILFFPyYsn5To8Z3uDyMh7xKnr3/v/MDUhLp/lp7cxwq7ssxgJHCNsgSZyuU7TosGrf1ncoBbJjd7gft+AuRNW4a6Lq25pqyHjHAu/UeZ3Cly2OqNdBK0KrV0qyIBFTJvY22zgMR/QRcjb2iFc+OukTRkjoZIHw1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707190406; c=relaxed/simple;
	bh=37JfY9goEyfL1tils/65Mm1whb5ed6z34kDU6IWdu7c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=YC0GFrcY/taUylSDMrYmKiuXFkWAap4+XhiD69U1oChOcjg+8+7q0JR+1ERaBlZadevWIWQsr5F/0EI6zFzgXuyrO14CcYFWWOZHUufudF0lSAcmlJhav4Lmn2cRTVY1LkyRX0E0nagOxvnpSBrom1VbqhVo4Rx7c+2zJSB1zqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hGJOeYPg; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6040a34c24bso7682367b3.0
        for <bpf@vger.kernel.org>; Mon, 05 Feb 2024 19:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707190404; x=1707795204; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JuTvsdW4nPk5F0JAYEhrkK8gf2WJ2UoBgHHj4XMAB70=;
        b=hGJOeYPgTCyBI/7HrtPjmLniUplSTtlj9eWkegtnOjNlPn29YBrnwyiQ+5t9mxHfkL
         nmd63aS18V5hB3uGCE4VtS29IFMgcyVvVS6Ygme389FAli+PtUiWmKRyCRnQcMT05zlY
         NzT5k7MognKEE/uw0meK6jv4nPlzkHsGm5DYLOjY8GBFWK6LLC72vYcrK9RpgNPEWg5L
         UOswa2uBDs97pmUjsVqtAMjnwKi+8PPFtEbX8sv1e3nPkEDYj8NhB+JOLwLmeMct+LSg
         8XXeztLF6daJ55ex7I8PePBgpHVdpfmtCqu6OTBJSmlWrGL8bIBgKdiNzdWCDSTkYXxe
         FVNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707190404; x=1707795204;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuTvsdW4nPk5F0JAYEhrkK8gf2WJ2UoBgHHj4XMAB70=;
        b=Dl6n7rFK4M8JuFWiQT6neOuEB6k1/KPUbdb6hKnhQZql+DCku1IUigOrgA2CLWBLSP
         SCTN+lKo7ELkdhxcmPqLbGwrbk280TwFJ6IvmcZqPsq4rk1hC74FrU9ke/nROClQe4fA
         ZlTVGd7te1NjIfrecREgn1FTHaxURB5u25gCZenX+DOn0O6MEUCx9mjoFBCqwCLVALwM
         w68+gaxqoYH+L4dPn9+ifilGTuwARWEv4Sy4s2aBNvtVIbWt52+ZV9VnWHqChdbWwmLn
         NQEfjW/NAm6DrZ5pi1pI9FGp6DQwOm07LDB0FHrLOlu6amPpKhbLS9bvGXRFgdO/Ejvk
         h1ng==
X-Gm-Message-State: AOJu0YzlWYj7OFJWzSbl52zs6INXuaEdAAqZUxVroW22G3j0/teDtBrm
	5dzXOwm9SxjNQGBQu4Hh1+Ir/XkbcJktyKN01OvvbfdiuVD3iLHuFZLSSkZNRANotygql59rsGU
	qZUb3EQ==
X-Google-Smtp-Source: AGHT+IHWG4Pm31Chn2HrVGdfYVjuO9iSdtbPqq26e1uGOzUQ85BvKCXVDXh/eDhIrtBGVkqLv94H0oTjHw4O
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:326b:71bb:e465:6f39])
 (user=irogers job=sendgmr) by 2002:a05:690c:10c:b0:5e8:bea4:4d3b with SMTP id
 bd12-20020a05690c010c00b005e8bea44d3bmr75549ywb.6.1707190403843; Mon, 05 Feb
 2024 19:33:23 -0800 (PST)
Date: Mon,  5 Feb 2024 19:33:14 -0800
Message-Id: <20240206033320.2657716-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 0/6] maps memory improvements and fixes
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

First 6 patches from:
https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/

Ian Rogers (6):
  perf maps: Switch from rbtree to lazily sorted array for addresses
  perf maps: Get map before returning in maps__find
  perf maps: Get map before returning in maps__find_by_name
  perf maps: Get map before returning in maps__find_next_entry
  perf maps: Hide maps internals
  perf maps: Locking tidy up of nr_maps

 tools/perf/arch/x86/tests/dwarf-unwind.c |    1 +
 tools/perf/tests/maps.c                  |    3 +
 tools/perf/tests/thread-maps-share.c     |    8 +-
 tools/perf/tests/vmlinux-kallsyms.c      |   10 +-
 tools/perf/util/bpf-event.c              |    1 +
 tools/perf/util/callchain.c              |    2 +-
 tools/perf/util/event.c                  |    4 +-
 tools/perf/util/machine.c                |   34 +-
 tools/perf/util/map.c                    |    1 +
 tools/perf/util/maps.c                   | 1296 ++++++++++++++--------
 tools/perf/util/maps.h                   |   65 +-
 tools/perf/util/probe-event.c            |    1 +
 tools/perf/util/symbol-elf.c             |    4 +-
 tools/perf/util/symbol.c                 |   31 +-
 tools/perf/util/thread.c                 |    2 +-
 tools/perf/util/unwind-libunwind-local.c |    2 +-
 tools/perf/util/unwind-libunwind.c       |    7 +-
 17 files changed, 899 insertions(+), 573 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


