Return-Path: <bpf+bounces-22815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C707586A212
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 23:03:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82356288024
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 22:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22613150988;
	Tue, 27 Feb 2024 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s9gcvNa9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2514F9C2
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 22:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709071339; cv=none; b=Eqt6eYtld47yW/ZanA4+z2jIuU0mTAT/nxYhp/kIVAs8etO/quxSWR4Oa6xnaJj5UROmzdAQYmUarr3UTF2vuBrK1rIM/dvWmewtxWkPT4PjXPeJo4UwSzXKsa1QLq2VQf95iwzFN/HXAUCnClfTW77QGyi8VRYPtcVUJVsfMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709071339; c=relaxed/simple;
	bh=upLg+yhe8A2OZg6p8OFlrhH2yLDrE7BI//l8P1Vylms=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=CP7HKHw/wg43xWZd4pUguqCSN30NxmubVYnvpoafeWMvY2dGnVkVKfmzEVMzz5C8UucBScn97oMr8YNTkSOEZ3zIMVh5jlif1O5mlIFXlbXRzqXhrMSr3oBd9zwT3WPV57aSCqxGCDh48AXL1YG8itPAzdQIlVq/K49nncp9+WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s9gcvNa9; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26ce0bbso9048505276.1
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 14:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709071336; x=1709676136; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vCV6R+NKRLMYoVC59mA+bYuzdEe0EtrTOitlrlnnMsA=;
        b=s9gcvNa9lW/PIzWihQTBqJP0VhTkZpQ2bDTsbEkPcpPLqGv6NTqfIF9gX+jC0MYySl
         osPkLoPBNizf3K41BZSSLigRaSaGT1Qgn9qYm59CQODGL5LG0zYf6iSoQuyc1c5XWaTT
         TGaQukHZ1EJmX6+JatByB8EPKyCCGxF/6W4NW2krDMsZyfSS0Puzq9ziNCM9koeX4+bd
         a3m6oPYQDeFKyHAykaE2jJN3Ub+EOmpJqxC+j5xjSvgVUIi+U8m0pv6MByvY5wiwAWxH
         thikawX9Nj/Nm83tyMYSPhDXLrrW1TrwDhQ0TjXJs84drugGC6t1l/sekw811eMQguc/
         ZjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709071336; x=1709676136;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vCV6R+NKRLMYoVC59mA+bYuzdEe0EtrTOitlrlnnMsA=;
        b=AizGkOft9ltUJJpQGyQT5eMArrqVKK1hTqHBQSy9h6ihe8bNRkN+4RB4PqbohYCIia
         YIiXBwAcg5doNl0eIUIZkGSy860YRwRcaANS2xd9Yj4r/lff+7Z3mUMujKbrrNLYLAdf
         54MH36PT/iwFXN+1/6SlCQd6eQKc4b7E/rN9fHfJJLrLTh79C6ZEGSQ7xN/jTEYlNEz2
         R+DLdPRyz1BaEXogyDuIL2aqtd6gxJTZ2341c+r4HsqzddTq0q1s+S4DOzuSmKuCzqcX
         dUqmL+p7YMobaTWyd77HcXJ3LXUYuJS1B6j/n+ASKICOBT1SggVStFc2b6JtsYba2rNA
         VmdA==
X-Forwarded-Encrypted: i=1; AJvYcCX6h5cHZSTA5T4ViDP4oqHd1phym76CfoRHmbssAQSZsq6kyzYQPurGEMvPeSQ8B+7OZ3V7b+qD4ffdQUreTMaHJpT1
X-Gm-Message-State: AOJu0YxI/LgJ4SwU5XRL3P8ItYP3PiFvZ35bejG0AhGjXsHBRS7LGHCT
	lBYQwQZkrmKSyjMstumb+gqqhkVuLYFsvjvR9cuv8WMqh2RpQLnjl+ALAYws7235R0hQGrDNeNu
	B9ei7Aw==
X-Google-Smtp-Source: AGHT+IGEhA+c0sAKulaM8RvsHp0DR9xq8SYgR2yBjBN+6kuK+8Tuz+x8EH8gmVr1C3hn6lBPKxh3uS12sCNZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ff1:8af6:9e1a:6382])
 (user=irogers job=sendgmr) by 2002:a05:6902:1204:b0:dc6:cd85:bcd7 with SMTP
 id s4-20020a056902120400b00dc6cd85bcd7mr220673ybu.3.1709071335967; Tue, 27
 Feb 2024 14:02:15 -0800 (PST)
Date: Tue, 27 Feb 2024 14:01:50 -0800
In-Reply-To: <20240227220150.3876198-1-irogers@google.com>
Message-Id: <20240227220150.3876198-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240227220150.3876198-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v2 6/6] perf threads: Reduce table size from 256 to 8
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The threads data structure is an array of hashmaps, previously
rbtrees. The two levels allows for a fixed outer array where access is
guarded by rw_semaphores. Commit 91e467bc568f ("perf machine: Use
hashtable for machine threads") sized the outer table at 256 entries
to avoid future scalability problems, however, this means the threads
struct is sized at 30,720 bytes. As the hashmaps allow O(1) access for
the common find/insert/remove operations, lower the number of entries
to 8. This reduces the size overhead to 960 bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/threads.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/threads.h b/tools/perf/util/threads.h
index d03bd91a7769..da68d2223f18 100644
--- a/tools/perf/util/threads.h
+++ b/tools/perf/util/threads.h
@@ -7,7 +7,7 @@
 
 struct thread;
 
-#define THREADS__TABLE_BITS	8
+#define THREADS__TABLE_BITS	3
 #define THREADS__TABLE_SIZE	(1 << THREADS__TABLE_BITS)
 
 struct threads_table_entry {
-- 
2.44.0.rc1.240.g4c46232300-goog


