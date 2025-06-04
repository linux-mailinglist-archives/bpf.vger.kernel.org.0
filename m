Return-Path: <bpf+bounces-59666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4C4ACE3E3
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 19:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B758C3A5149
	for <lists+bpf@lfdr.de>; Wed,  4 Jun 2025 17:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7588620297E;
	Wed,  4 Jun 2025 17:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8CecjDJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E91FCFF0
	for <bpf@vger.kernel.org>; Wed,  4 Jun 2025 17:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749059164; cv=none; b=sGrJ/aO+YwzRCji+I3TBE8VUf3hc/J3AzF244Gnr5QmUUkZSmLyc5RTs7HF3CoIkLET+svexRh8S9r96mM4VAy+LEIYKg9rFiJpkzT4qa8VDzNalOKDORk4ujq1UbUhr7glyADDDXennNJXc/GEeB63Mt1nu/JBxfcAwL8yMrG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749059164; c=relaxed/simple;
	bh=l/r16VO14AuoTPhHYx1IhtNWRI73iyFImyAUkeVPBI0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=vGJEPw1NFWeRR/3LnHO2xyAzUoBoPc3tD24hs2bk4sLm2Sop5gQRRMDAYvo8oCRY1j3lbIgiKBM4QE9kRhHjMSHt84/5TraS2ljUOoe2IfYi3xErb+fdaEyhdnIziPH/hySam4DgvRbxU5uiCSYVQpYz0VUbSyiMZwIU5thg3oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8CecjDJ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23592f5fcb0so1023035ad.3
        for <bpf@vger.kernel.org>; Wed, 04 Jun 2025 10:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749059162; x=1749663962; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8tuEWlyOsSZ3VWtxSAzfgMOdxNTH4pB9RszdQHfYhc=;
        b=B8CecjDJBA7V9MPVp3i/BqYVPL+Md/oZ9qQxEVCNQwla+WU5sjHE4QGGQv+Ajn2wfj
         OcuqPP0z9CXZOqBsOYgXHAfL/gGZ8hvjvR7HgGlo/DZZ7EvDmrmrPHZZ93/RmXwu9Z+V
         hJOzyY4NRAwWj7rR13+hYr2UeaO/fQ/XGj6MScPM40hpPiTJmTorLeeXBnx4En2WoU5L
         fHOw/hJ5rlBf76WoCS7Zm7kMeGYBqKlOVpUS2j6UkOku+aFaZ9rcff/Rku91BOrJAsfB
         NxaX67LyuHqPox2/pGB/6/lMVjOCwxhywArvW+Rz9W1w+RJr7F1Hgh93MXD/b8MALTJT
         IfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749059162; x=1749663962;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B8tuEWlyOsSZ3VWtxSAzfgMOdxNTH4pB9RszdQHfYhc=;
        b=l9Cc6WLmJ8aouCltvIa/vTHhTDTlN+fcSuQRBMeGyPKoYd9oi+5Be3/YjAohjKNwz0
         MXcSOjmUDNXcyeabpKyFMLHfjCJqrlG4rlGqX7cmEfL895g6AqcLFki1MwU7geCXhOr+
         B3YVQS5Pe6Oxnrh9/4+ksfNnARaT+R19GsCAHtwu35SOMBPsyw+tXPSuKrpuCHbX2tYg
         pUzwBBxPBVnQejhq09oT/VDyKS/lHlZzogg7bUe2DRxyFRT2d44laa1CfLc8L2LRbS6B
         zbh2l/ZxzoH9YYJTnXRh83q8M5xS40/ulDZkuKhrPtuDc77gmGwO4jB4G2PVCLRgPeqZ
         chtA==
X-Forwarded-Encrypted: i=1; AJvYcCWLVUpEEFz9pqdsPcvuINfnLUmA7/OrHV9ING/auo1sSOgu0GweoqViVSBmYXZXGJLRvls=@vger.kernel.org
X-Gm-Message-State: AOJu0YzElZofCnW25Qb7on0lzMMyzbbMm+tWQgGSh1PzUZ6AT+ilwiqP
	fBjX0sE3vWbReYIFyFyjpp3WSZWrK5tDF2jCFkmhCS9U9inRdDDJ+kZvnvdVxh/O7717NnCt8zV
	959aTYnhHoA==
X-Google-Smtp-Source: AGHT+IFUdQJpYyNZoW3LNov2nnp6DBt7iCUI1cgeGKklZf5D9ju5lKohUdpptZ+KpaNA/8E19pxOS5sBSnwz
X-Received: from pjbpa10.prod.google.com ([2002:a17:90b:264a:b0:312:dbc:f731])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:298f:b0:233:ab04:27a
 with SMTP id d9443c01a7336-235e128b23amr51021535ad.53.1749059161671; Wed, 04
 Jun 2025 10:46:01 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:45:36 -0700
In-Reply-To: <20250604174545.2853620-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604174545.2853620-1-irogers@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604174545.2853620-3-irogers@google.com>
Subject: [PATCH v4 02/10] perf target: Separate parse_uid into its own function
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Veronika Molnarova <vmolnaro@redhat.com>, Chun-Tse Shao <ctshao@google.com>, Leo Yan <leo.yan@arm.com>, 
	Hao Ge <gehao@kylinos.cn>, Howard Chu <howardchu95@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Gautam Menghani <gautam@linux.ibm.com>, 
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
2.50.0.rc0.604.gd4ff7b7c86-goog


