Return-Path: <bpf+bounces-55677-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035ABA84B2D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9E02460E18
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C156128FFD1;
	Thu, 10 Apr 2025 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wrfCGtSk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f74.google.com (mail-ot1-f74.google.com [209.85.210.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F32284B22
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306614; cv=none; b=pwINketeDbh+cDyz6E0BCSugsiUYbx0VXNtbRYR2JE/mExGKA7hJ/MvBFmas8sB9Sy1MG7efZPU/Dh8E3EvPCddTCgkdEehYtZ6aWnbQyt+kT+K2Eg9GqtfLO2Drh5XCc8CtNyxL9j0HVmTgbeq9OZMlKb/T/h0MQKfUjaonZfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306614; c=relaxed/simple;
	bh=gTyDhZCTno1IXSRzvLwzt6dqW5aQfNugAfWRkxe3950=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=haV4t+tiDTv/tkGUTZNqfcTZSwyjGZAZOI+1zRmhBH0ODi908WD07YjqA0HwN3F+ZIIh2ZWomZqtvGxD6zk2EXelYW2AyVu/IAUHSFEByaSsop50tfqdA5aVbg+pd8B1+d3VvsS9uK8eNd6zmmZcTaIz1/DPS9BfXyevtjveJ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wrfCGtSk; arc=none smtp.client-ip=209.85.210.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-ot1-f74.google.com with SMTP id 46e09a7af769-72b881599f6so947010a34.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306611; x=1744911411; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mcWxwltoH9XL7Cxrn6JcmLq/7/2rEiSHhwmo34ZV4XA=;
        b=wrfCGtSkpVXOCy9LNU5qJnoqOFo76dEsZoCYSSsgBpC1dpfneeR5z4pE7K+KPhh3ll
         MHZ8J7nyVjYBBeMiWxDRuufnzYag4msPZ7RYrFzXL+90eJl+LO0ZBwKlwilcBbCoY9eh
         GzXcdZ4ALVxMXjaMrOv9zgFb7l9ZUMyqcshqG310188/fXC/CVQpJBntZUm7+fFLpE3c
         FMoSlICKFsPUfBlxqlTmfRCfQ6FLBfbDJliw42YwMFWABRU7VrQTivAJKoFmYBw/0pk3
         dYxi5BdFk9KjKhteBmsErcxyRYt4Vw9tprgcJhIldvtLjalWtNB5Ba/DpnAfKej5E9lu
         eWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306611; x=1744911411;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mcWxwltoH9XL7Cxrn6JcmLq/7/2rEiSHhwmo34ZV4XA=;
        b=ZYweMW1k46Jub1Fdr+YJkwCocWpgbGf3qFl1ojIa3cy7u10xedax4Latqw9EBsoWsz
         uhhPR2Hm3ABZEqi2rXuy1zRLUQveh1NQCIxUpGVusgsbLF1D7WiRy5PzD8ogoFA34I46
         hSlNV65W8kdhRxB9azqXidViTUPelbCRxIFhMnHBFqyZcbmCv7Mn9lR+GuP6mUAXbpUw
         Vi+904q6ZK6NWAW65G2l0w3WPVAuX4+eyWYDiF5XYwFIYj4Ck7XR3qPNeuTcbjnNhVcS
         FIes9IlPrjNlj7eqIyENlD/rzi9VWuHetDY9ZNuHzBWSkykDCNENHckHdl9Ccy6SJgAw
         vjTw==
X-Forwarded-Encrypted: i=1; AJvYcCUCT6728mR6d3tQdhAN+aQReBoywDE8nB5DjTrKSoVc3eo2wKVMSyUJNVQv5a99Vxz+UJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxslemVF92dNR5MbCgS6o6uNJXW1paghKu7b2r7RAQJS8TXs4AT
	42ei3ZZejW1G5kS+OG0ztD9izoEbeBp/L+y27ldioZYtPWgfX2eqZE8S20gl3/zQxOhZG+mfyHf
	f9HC7Tg==
X-Google-Smtp-Source: AGHT+IHulExf+Mv/Q1ZS+sBiHCCJIKDXZ9ldVCWeUBFQHANG4wq6xirGW1Tq6sYLc1Mhwf3q7i7XpglcaFSp
X-Received: from oabfl6.prod.google.com ([2002:a05:6870:4946:b0:2bc:6ad3:5671])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6830:25c3:b0:727:3e60:b44b
 with SMTP id 46e09a7af769-72e7bae6f1bmr2044467a34.14.1744306611665; Thu, 10
 Apr 2025 10:36:51 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:23 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-5-irogers@google.com>
Subject: [PATCH v2 04/12] perf target: Separate parse_uid into its own function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Howard Chu <howardchu95@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Levi Yun <yeoreum.yun@arm.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dominique Martinet <asmadeus@codewreck.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Allow parse_uid to be called without a struct target. Rather than have
two errors, remove TARGET_ERRNO__USER_NOT_FOUND and use
TARGET_ERRNO__INVALID_UID as the handling is identical.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/target.c | 22 ++++++++++++----------
 tools/perf/util/target.h |  3 ++-
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/target.c b/tools/perf/util/target.c
index 0f383418e3df..f3ad59ccfa99 100644
--- a/tools/perf/util/target.c
+++ b/tools/perf/util/target.c
@@ -94,15 +94,13 @@ enum target_errno target__validate(struct target *target)
 	return ret;
 }
 
-enum target_errno target__parse_uid(struct target *target)
+uid_t parse_uid(const char *str)
 {
 	struct passwd pwd, *result;
 	char buf[1024];
-	const char *str = target->uid_str;
 
-	target->uid = UINT_MAX;
 	if (str == NULL)
-		return TARGET_ERRNO__SUCCESS;
+		return UINT_MAX;
 
 	/* Try user name first */
 	getpwnam_r(str, &pwd, buf, sizeof(buf), &result);
@@ -115,16 +113,22 @@ enum target_errno target__parse_uid(struct target *target)
 		int uid = strtol(str, &endptr, 10);
 
 		if (*endptr != '\0')
-			return TARGET_ERRNO__INVALID_UID;
+			return UINT_MAX;
 
 		getpwuid_r(uid, &pwd, buf, sizeof(buf), &result);
 
 		if (result == NULL)
-			return TARGET_ERRNO__USER_NOT_FOUND;
+			return UINT_MAX;
 	}
 
-	target->uid = result->pw_uid;
-	return TARGET_ERRNO__SUCCESS;
+	return result->pw_uid;
+}
+
+enum target_errno target__parse_uid(struct target *target)
+{
+	target->uid = parse_uid(target->uid_str);
+
+	return target->uid != UINT_MAX ? TARGET_ERRNO__SUCCESS : TARGET_ERRNO__INVALID_UID;
 }
 
 /*
@@ -142,7 +146,6 @@ static const char *target__error_str[] = {
 	"BPF switch overriding UID",
 	"BPF switch overriding THREAD",
 	"Invalid User: %s",
-	"Problems obtaining information for user %s",
 };
 
 int target__strerror(struct target *target, int errnum,
@@ -171,7 +174,6 @@ int target__strerror(struct target *target, int errnum,
 		break;
 
 	case TARGET_ERRNO__INVALID_UID:
-	case TARGET_ERRNO__USER_NOT_FOUND:
 		snprintf(buf, buflen, msg, target->uid_str);
 		break;
 
diff --git a/tools/perf/util/target.h b/tools/perf/util/target.h
index 2ee2cc30340f..e082bda990fb 100644
--- a/tools/perf/util/target.h
+++ b/tools/perf/util/target.h
@@ -48,12 +48,13 @@ enum target_errno {
 
 	/* for target__parse_uid() */
 	TARGET_ERRNO__INVALID_UID,
-	TARGET_ERRNO__USER_NOT_FOUND,
 
 	__TARGET_ERRNO__END,
 };
 
 enum target_errno target__validate(struct target *target);
+
+uid_t parse_uid(const char *str);
 enum target_errno target__parse_uid(struct target *target);
 
 int target__strerror(struct target *target, int errnum, char *buf, size_t buflen);
-- 
2.49.0.604.gff1f9ca942-goog


