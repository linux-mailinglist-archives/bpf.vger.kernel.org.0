Return-Path: <bpf+bounces-26377-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00589EB24
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 08:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCBD1C22E74
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 06:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234F941206;
	Wed, 10 Apr 2024 06:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lgpzw+D6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3BB43AD1
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712731360; cv=none; b=KFgtXTSGytwv0J8Mk8BiPqpuhBPfI7fHjiADOcXO4dZ23IG/kKdBdPX6CRw65kbgDVQpXpzZQEOLh+124JXgvhz2RNRZCG971GViLLfhYXFP26vnmPk42UTcfjXJ1YDso+zozWSouEKfiirEvXL9P8aKLy/YjodmEbo4uVOwvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712731360; c=relaxed/simple;
	bh=2jzruDa3ldd8qnDLA1rJ2ZswFfOJYSB+fnUOaK4RUOE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=uREOi4nxVisRHDHDty+rx6Cxz2ggQs694tFiaFE5i0V6PvRoUu/R+wKiShMCNS6S+flgh2KYs9/GpcQyTp4u7iSkrLKQ/jvbrJd3weqIZwAg6705dnAY7omceut231XmGjHO0OBbSIofdWWO5F2FHNskypxZBvgSsuBbR9x9wr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lgpzw+D6; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so10157535276.0
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 23:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712731357; x=1713336157; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hvCMnP9B5vVSfhdt4AG7Zd6V/+C/ZwTtaug7JMpiZVI=;
        b=Lgpzw+D67wp5qiq/mrvRPEnmzreoCMUE9HZpAF4W279uWhxKd2wH4Mapx7NGweB9ec
         wlp5wvSWa6GX2Lk2R6Ux5HOIgauaiU5oVulPIHjtchBD5fvV/rKIx+QvW7f5hs/sYvDh
         7g8jf6K9Nirw5UJpqIhWOtLtgUfz3jd7Ke2cSJeyLtFzhHd6vLvBhdmADwDF9bwkOwwA
         U9o9xbkAXhh3eH/vBmlJ/zmTfde1ubO5SF2v+VisiJXdil7UbDHGuj+J9iJqGdFzUZN6
         BgHRZrBF3gm3ZqJrz4LNDs3BzA7Ilu1Wg8xZXgMNWSUpz0vrmq0u065y9sBkqf5QjilG
         Ntyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712731357; x=1713336157;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hvCMnP9B5vVSfhdt4AG7Zd6V/+C/ZwTtaug7JMpiZVI=;
        b=K49l/iI0dFMk8a84LKCrYc/zoknbxmY1bCN8aZvan9me6WWCKj5EVTZTuxew9pKxgP
         lYA1c3qJRx7IkB2OxdOfUPdmWFUvIJnxXnfubW0LM99jFoYg8iwdqT/MNRTxUmdxzEmU
         Z5CXONS3XEY25RfIUOiVSf0M3mEjlkXgUVAdQXrQsg4JcMVZeFbgxHeQWVlLvDXBcOxB
         m+gB1DXXFAKvzxmsoEvVwTvivuY3UWKdgj10MFxuVdanu9bZXfipPQxjI+xpUyxFNiMJ
         kfK00sqTthDxD59MhcQENvhZGi+0JHX0NTtsuNt+IhFvmaOIsTh7s6heuqjtPerVuJWY
         SA4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXP3P3b3TVtMTVaeZqc5j1pNUnDst4jD4WtZNwyoe+4nEWMwK22CTgOSmdsU1Ec5zHyr4MDHRFAPWODsI5uY8KPQTr0
X-Gm-Message-State: AOJu0YwwMX7mgSqRs+Ieg+PpvXhKkl5ES8AEKebfDpRV9AQWNTHI0Ry0
	AbSIkV2dg21UEAUj3P9NVDS07c5N9kCEkJNeWJ7/qub0c+dh1pzeWc6fQW6X5pgOR//66HWjFx7
	PS51Z3Q==
X-Google-Smtp-Source: AGHT+IF5Kd4tmO9YCm0rEfF3dJjKkyEjZ0qxpiMG8D20NRtAHiIO/Nib/SOo+kuMrUTiBC4VA5zfMpmYvrDQ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:18c5:d9c6:d1d6:a3ec])
 (user=irogers job=sendgmr) by 2002:a25:a407:0:b0:dcc:5a91:aee9 with SMTP id
 f7-20020a25a407000000b00dcc5a91aee9mr514589ybi.7.1712731357347; Tue, 09 Apr
 2024 23:42:37 -0700 (PDT)
Date: Tue,  9 Apr 2024 23:42:09 -0700
In-Reply-To: <20240410064214.2755936-1-irogers@google.com>
Message-Id: <20240410064214.2755936-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240410064214.2755936-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Subject: [PATCH v3 07/12] perf dsos: Remove __dsos__addnew
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Leo Yan <leo.yan@linux.dev>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Ben Gainey <ben.gainey@arm.com>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, Yanteng Si <siyanteng@loongson.cn>, 
	Yicong Yang <yangyicong@hisilicon.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Anne Macedo <retpolanne@posteo.net>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	zhaimingbing <zhaimingbing@cmss.chinamobile.com>, Li Dong <lidong@vivo.com>, 
	Paran Lee <p4ranlee@gmail.com>, elfring@users.sourceforge.net, 
	Markus Elfring <Markus.Elfring@web.de>, Yang Jihong <yangjihong1@huawei.com>, 
	Chengen Du <chengen.du@canonical.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function no longer used so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 5 -----
 tools/perf/util/dsos.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cfc10e1a6802..1495ab1cd7a0 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -341,11 +341,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	return dso;
 }
 
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
-{
-	return __dsos__addnew_id(dsos, name, NULL);
-}
-
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index c1b3979ad4bd..d1497b11d64c 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,7 +30,6 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
-- 
2.44.0.478.gd926399ef9-goog


