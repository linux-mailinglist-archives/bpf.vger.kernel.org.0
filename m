Return-Path: <bpf+bounces-23123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5462D86DC50
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 08:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039E11F21C14
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 07:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C89A69E04;
	Fri,  1 Mar 2024 07:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EwkVXkq+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B569D26
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709279230; cv=none; b=u1Q8khRl+Pn2KLalY4urxlIz5b+/3L5BBc0sl8Ivr8NsZm572JvAcfGw0dSnDSlxbA15yhCs0Un8+5a3iOC9U08shjXHWdn+apiNfsorYksker3PGYUDQceJJJKe8KSUAj2kWAl6CF9iC4HQ+bj/Uaw21UFR2Wa04NBffQ1Wodw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709279230; c=relaxed/simple;
	bh=tJ5hV3qK33fMQXhssQ6GzZXnGcMVFTbMlJ9s5yCl8rw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=KVPbuc0M9VQwd05IqfkeRY3/YFKdgaIUJKeI1aE/d0sksTrAOqiylEdt+fO8GWO3xR9sqjNWEB/bzkyWru/C9EYkDCStXVnTF9YEpNBAUcbtSiYNRB2h3D+4ebpdwFPJOm0BMRw+e/Vq/H9cNyBKO8+RKSrt8P06ZDmsBVuZosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EwkVXkq+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60810219282so24547377b3.0
        for <bpf@vger.kernel.org>; Thu, 29 Feb 2024 23:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709279228; x=1709884028; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6cr3bvTQSOwUcL44V3OWG/EQ3k43z0nNlQO3ZPO+cuQ=;
        b=EwkVXkq+HbPb74rzNH68QmLtn6Ppye5ynfhaCcxaVindUJY2fnUUTxOl6phR/W9iis
         DSK1brP5QcrWwtx8RfU9RpOyBarasX8nAOqnHiMBchgWCJxQISUylYpnD5lIrHIm/K6b
         GdLrOQv4sRYp+EdxLOxb99MEoOXb/7TjaH63l4kJcyz2kXtbKVaAVPQ0mob1zHsfT/Ug
         hAMTRvHg2UluIa2p+HCZqnJeGst9UFhWVUYe1/bARNHYjI79upfvSeu7OKNSfviHR4CI
         FbDAJ8poWge5Oc70UzqbtyECHW3kttpR9aBWk+gMpICRN/P9Maa5MmWKH2nZ1Bc6Ob+X
         ZBuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709279228; x=1709884028;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6cr3bvTQSOwUcL44V3OWG/EQ3k43z0nNlQO3ZPO+cuQ=;
        b=n6AoKjd2fdclr5l0B/RGZhIax04KyEeKmrSuVBWba7XaeeWoeiAR8GI7OJnYd/Z+R1
         961ANY8y2feNI8V++yFRSvRhUnCSkY+lfWg5OW/pB3+HnGmcM16nZl53VkqPOn1f5sjK
         W7CQVqWlaIGHfZe/jpmUaHqaed3PWn/SJBnC0dEjC9JxvJAnt3tEL1eU+5tflLsMBcgW
         dE1kVpR9CapouL+2EWw/qBlpWn06OkQMqrt5XSUEBAsRmIcxB9H6flRAJDuv8jVFgx1I
         ZGmTkwDff2dhbcg0xTldqfjM5xgvmX0sygGcZOBRxJB5867lB0TISnWLhQORBwAlevcJ
         JGGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNMzM72tYs1BkdZa2/CELI4Ir8gFG+eqSSN/MsPbkVPsPe7009V32vXLaMCmUkjiIgu01YcwNpTXrGXgEcM63XFVez
X-Gm-Message-State: AOJu0YyJ5291N8SulNnsvINyKR3+lPGh6Rg/WEef7kRSA11rcXVnnlTf
	VH9Wi1B11LxuzNe+j3c6WR79Nf/5wSr6LAe9zLhS52VnB5l2pBR7ZFHo5xf8BBmYc3b260dVLzL
	tKyH7yQ==
X-Google-Smtp-Source: AGHT+IGz1E1c7M47HvG6AVrMNEVgIWHJwWURRdJYBFX7yDtVHORL5Dpa11qv+CBdBUGG0mIB6skYqMmLlkT9
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:af4b:7fc1:b7be:fcb7])
 (user=irogers job=sendgmr) by 2002:a05:690c:c92:b0:609:3bd3:31fd with SMTP id
 cm18-20020a05690c0c9200b006093bd331fdmr161226ywb.2.1709279228547; Thu, 29 Feb
 2024 23:47:08 -0800 (PST)
Date: Thu, 29 Feb 2024 23:46:39 -0800
In-Reply-To: <20240301074639.2260708-1-irogers@google.com>
Message-Id: <20240301074639.2260708-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240301074639.2260708-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 4/4] perf test: Read child test 10 times a second rather
 than 1
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Christian Brauner <brauner@kernel.org>, James Clark <james.clark@arm.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Disha Goel <disgoel@linux.ibm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Song Liu <songliubraving@fb.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make the perf test output smoother by timing out the poll of the child
process after 100ms rather than 1s.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index e05b370b1e2b..ddb2f4e38ea5 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -307,8 +307,8 @@ static int finish_test(struct child_test *child_test, int width)
 		char buf[512];
 		ssize_t len;
 
-		/* Poll to avoid excessive spinning, timeout set for 1000ms. */
-		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/1000);
+		/* Poll to avoid excessive spinning, timeout set for 100ms. */
+		poll(pfds, ARRAY_SIZE(pfds), /*timeout=*/100);
 		if (!err_done && pfds[0].revents) {
 			errno = 0;
 			len = read(err, buf, sizeof(buf) - 1);
-- 
2.44.0.278.ge034bb2e1d-goog


