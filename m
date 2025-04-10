Return-Path: <bpf+bounces-55680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 320C8A84B31
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C74AB3A49A7
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D1028A400;
	Thu, 10 Apr 2025 17:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yPri3aqD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EF72900B2
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306620; cv=none; b=ShbJbBXZyNU7e8BuOuwW/u4vBmBO2eVem7atlVn2oxAhA6wuTsg6rWPYzaEfGz2Ho4WigHs3zWo/zWNr21EvCKU5BEh67V5FlRxX0y7OAZVrUO4iLbzhS+XSc0Zj4h3DMuxUuur+PGCI8+RLMshVWrpBpXjKAM1LaZFOpR9W3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306620; c=relaxed/simple;
	bh=wJHIkRUIijzHQJBAsZiYEC1oHduXPch9ZBc0/MkA4lo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=uJyPK/UTJW+jUvBH0jSJYfFkG7WoDnBLIgkYKQMGlmwv4ac5aGPnGuKu0RUuRRxTCY+ac7VLr/qFJ0E9peI/aoaq8vy5snLvcNPN0grNITv07URFYg1SNrHuXPwnoghAG/zP01p6wCWwIjpz6hygHhgq21OUCw8HOIvZ+wEtv1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yPri3aqD; arc=none smtp.client-ip=209.85.210.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-72e26093f05so399775a34.2
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306618; x=1744911418; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JBDFVNGJcg1Y5m+EPEDSUnPka56smnza49QJdWAufsI=;
        b=yPri3aqDj2yB7C68rY2E/Edl2CJEzflgF6Yf01m6snkij8wIqZVxr+MUbXAyRO3h1H
         tQQQAeWMOZHyHin1JQ1aFvH6Z3plMFC0SmhEv+1O/qu8KWIMgm+47jcbyMaq9bcVgYOs
         vq1899GiD7ziTxe/j8tN86MpUtWU4MdevnNm4hyimVYoLDpQ5LrlnOsg4aoYRhFPVMZ8
         lFpyvvtwlMBiq6q368mAByuPLk98krUIgyaFomKoIDKZ3jpvbMIw71H1eANF1af3+Kwc
         CkjWFWE37Frdg1hmL1uF9X/R1Dd1Cr3ho7M7do57NXBzFzn3mO/SWgwubCoFeiBl1Ml/
         xZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306618; x=1744911418;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBDFVNGJcg1Y5m+EPEDSUnPka56smnza49QJdWAufsI=;
        b=sBphi2kJgjP0n2AJ41WX+23LMbEVCCjLf2qQo7tvJwmZIxyA66WoDkaQS3mvI1O+yt
         G+I86Fcb24AH0iwAg+Aynjg2W7STggK0b5vCKtjPq6BRMD/sFDd6bcZ2dIk7wUr0PhPo
         Di/Z2f+zlUM9iLE/FCx8A+cqggXY0CAzQ8hy7HlQwwR1zZ/cky7BiGm/O0OYj5ZdFQPx
         Rl4IFqEQb1e2mEVdMizwWXGSE/ImbVUo0ghrgAKCXzoI0Fc82S7vfHNFWVr5/Xjj2xqz
         UkX5fwtEhoLCZeYXuz80REPk8fG7dht0/UjbIvuCNbrG/z7ZOlSZjMm2ZLKKYPji7dl8
         IvIg==
X-Forwarded-Encrypted: i=1; AJvYcCUxFi8TrU6ovziGNYN9NGinZkJxCobdJTZMiTQ3MOkXB+tgp0NNZVjp3hXdlzwblw/lHy4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKfLyEhLXzplS70suB3FWTgGgpZzIRYarFPodKReDRWg+MIuYs
	PpD7+6E22MONx+XF9s/k/lGu+IFXKCuuOgh2zeTD8Uicf4kSiGcaSyD9XTf/Mw2NrBAsfmuEHRQ
	4wQACKA==
X-Google-Smtp-Source: AGHT+IGIJT3nBwE7M1dGVt30ERQq3AjXXnVx4s5MM+wszH3uXona+1qYuAeQPVpntfIHhto8vkCtb9wcOwoq
X-Received: from oabvp10.prod.google.com ([2002:a05:6871:a00a:b0:2c1:5f7a:eba8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:4102:b0:29e:684d:2739
 with SMTP id 586e51a60fabf-2d0b38e1c47mr2153869fac.32.1744306617846; Thu, 10
 Apr 2025 10:36:57 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:26 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-8-irogers@google.com>
Subject: [PATCH v2 07/12] perf tests record: Add basic uid filtering test
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

Based on the system-wide test with changes around how failure is
handled as BPF permissions are a bigger issue than perf event
paranoia.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 05d91a663fda..308916f9c292 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -231,6 +231,31 @@ test_cgroup() {
   echo "Cgroup sampling test [Success]"
 }
 
+test_uid() {
+  echo "Uid sampling test"
+  if ! perf record -aB --synth=no --uid "$(id -u)" -o "${perfdata}" ${testprog} \
+    > "${script_output}" 2>&1
+  then
+    if grep -q "libbpf.*EPERM" "${script_output}"
+    then
+      echo "Uid sampling [Skipped permissions]"
+      return
+    else
+      echo "Uid sampling [Failed to record]"
+      err=1
+      # cat "${script_output}"
+      return
+    fi
+  fi
+  if ! perf report -i "${perfdata}" -q | grep -q "${testsym}"
+  then
+    echo "Uid sampling [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Uid sampling test [Success]"
+}
+
 test_leader_sampling() {
   echo "Basic leader sampling test"
   if ! perf record -o "${perfdata}" -e "{cycles,cycles}:Su" -- \
@@ -324,6 +349,7 @@ test_system_wide
 test_workload
 test_branch_counter
 test_cgroup
+test_uid
 test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
-- 
2.49.0.604.gff1f9ca942-goog


