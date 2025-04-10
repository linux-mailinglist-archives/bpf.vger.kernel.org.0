Return-Path: <bpf+bounces-55674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F327A84B20
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 19:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B498C9A08A4
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 17:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C705E28C5DA;
	Thu, 10 Apr 2025 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fsmsCeQu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f74.google.com (mail-oo1-f74.google.com [209.85.161.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76C4204697
	for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 17:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306609; cv=none; b=cLHWfztQGHF+SRnk2iCPmOAGcbu5ocYXmpCi3a7YWHqKZm4prWOGXICUFFVvWloY73KdXUd73IZz0AB5DSNj2bpvXnMpK1wp6NyIdf1HeNdxNFvqi/L+2tJuooVKwFnXnt4/trPacuy0BJicRBmQjcHUYpPHfqSxogK3h4vfMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306609; c=relaxed/simple;
	bh=rjDVXA1e48wiJP09H+3ttLssvR00WBTP8TaXhYipl0U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sGi25EDmHq0EtPrLQCUecIOSFeDVsxe4AFxxvAm7fHFKToHiJu7e2MOeWkbH10/3jow3RZOZND9P8jQW1JqLSVw46oH52bXqAvA8vJ2E/pPztoFIwd7WKs17qTOVM1y5Yh0NqUp1WesDxt1zLK/tkEz5OWYMxgu+mxOY4Zjht10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fsmsCeQu; arc=none smtp.client-ip=209.85.161.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-oo1-f74.google.com with SMTP id 006d021491bc7-60254edaef3so815391eaf.1
        for <bpf@vger.kernel.org>; Thu, 10 Apr 2025 10:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306607; x=1744911407; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8v+NZetBaqzwnjvAKJtemj1czEgvtWJ39sNPAoy10bc=;
        b=fsmsCeQuW+2QzRFMpphZAV3Cb67pHGfYPJT+p95lWZv0dahH20S/XgS2gfjRljL9Dx
         NDjOxKdd7FeNEModHkpXazvrpw/0A5PVFE/bBMUOT70WEqQNaQVjZHPok9l9xlCJG923
         9zUiPhfVr8/c7Gh0vRGVgo6JHhL/2AzJKQUSkOQeKSN02IYwMrzG/86/JTG1I9hCun/4
         h74ibx+dfBsVV9v/eY5fuQiIdCI8n667Hhl8YzjZTJuJaKI0XtO4t1g2pUd7Dz84oegt
         0ibwcCsbBTIVuLsFatKpSfuCsWDoIIsJgcB2h3Xge/SQwY15bf1EdGY8SKonckS4UueP
         lIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306607; x=1744911407;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8v+NZetBaqzwnjvAKJtemj1czEgvtWJ39sNPAoy10bc=;
        b=OHbcditw2tgY6dPAsi2JM56gdKL6spSoaH7d6xx99V07Hv+w5nxR3rT6b614tUZ1/P
         ztYyCIeqQNn8Ixbx+H5vGnTwsAoMcZjBCO2xKGBloVaiHhUAT/7NL1xlWxtp8k8TVbG3
         t8BuiMBE5qCwSU3C7WUTJxchUVDnlV+yMoJfdsqz+3dUDz+BvqSB+G8GH+jvHshJlzXb
         ylE9D89aYGSrX+tWHUb5jIxJEJit/P4iqLYrpHSsSck7lzoiHv99d3Fh1vVCzm8QGOTJ
         YsYB7a2PCPwpH+D7YSHrpknvGWGaSO2Wi5gtIz0tuveQH6nKdkG4SmBZ9v9bfEB3zj0r
         scAw==
X-Forwarded-Encrypted: i=1; AJvYcCVgxLVWq/7ZKWGoIWdLe4J8OLqIWfeZ/1pQZ5lxQJItS2ru6GGHQl0gkBB+/ftnOXI+lZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW35jsiJf833adWHvJ8w6whbaI2Dg3Wg0cZEB2EjW4fKCN3r5W
	q9OUaH7EqkxXI51b58lKu73lNVhSiD8CILSAwx4HmUSqOOP/zplHNPWkkkzelnQhBcsfuB0z7Qp
	J0q9s9g==
X-Google-Smtp-Source: AGHT+IEwb9NbM9CUIgMKI0aGctFt6E85eoY4vwStAAMOKPWtdzhdBRq2bl9/AqJTGoTmUxudC+3nKm0UQUw6
X-Received: from oabwo9.prod.google.com ([2002:a05:6871:a989:b0:29f:d208:6db])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:6f14:b0:29e:53cc:a6c1
 with SMTP id 586e51a60fabf-2d0b3593597mr2371126fac.6.1744306606709; Thu, 10
 Apr 2025 10:36:46 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:36:20 -0700
In-Reply-To: <20250410173631.1713627-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250410173631.1713627-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250410173631.1713627-2-irogers@google.com>
Subject: [PATCH v2 01/12] perf tests record: Cleanup improvements
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

Remove the script output file. Add a trap debug message. Minor style
consistency changes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index ba8d873d3ca7..05d91a663fda 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -34,13 +34,15 @@ default_fd_limit=$(ulimit -Sn)
 min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
 
 cleanup() {
-  rm -rf "${perfdata}"
-  rm -rf "${perfdata}".old
+  rm -f "${perfdata}"
+  rm -f "${perfdata}".old
+  rm -f "${script_output}"
 
   trap - EXIT TERM INT
 }
 
 trap_cleanup() {
+  echo "Unexpected signal in ${FUNCNAME[1]}"
   cleanup
   exit 1
 }
@@ -239,7 +241,7 @@ test_leader_sampling() {
     return
   fi
   index=0
-  perf script -i "${perfdata}" > $script_output
+  perf script -i "${perfdata}" > "${script_output}"
   while IFS= read -r line
   do
     # Check if the two instruction counts are equal in each record
@@ -252,7 +254,7 @@ test_leader_sampling() {
     fi
     index=$(($index+1))
     prev_cycles=$cycles
-  done < $script_output
+  done < "${script_output}"
   echo "Basic leader sampling test [Success]"
 }
 
-- 
2.49.0.604.gff1f9ca942-goog


