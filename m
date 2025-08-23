Return-Path: <bpf+bounces-66332-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DA6B325D8
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 02:33:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C966625700
	for <lists+bpf@lfdr.de>; Sat, 23 Aug 2025 00:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F9414386D;
	Sat, 23 Aug 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AFKzAvbM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D89D4594A
	for <bpf@vger.kernel.org>; Sat, 23 Aug 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755909153; cv=none; b=N6aSv9pw+mChJ/VJ7Ib/dyxE0CM1LXVqE7dUk0gwA9KC+woHchZd4XfBpB2ycw4qTZAfjt9TuxeYRqsfBAG8xe7+R5bHRu4H5YTdVWCdr0EaQj/oxFicl6sVBGiKTwfdrW9yF6SikRHjx65aza/TkAXHpQuLy4ElVy8bDjxzJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755909153; c=relaxed/simple;
	bh=Dc3cNk44/tRuM2VojGcEzzSNDOPpGyR342/mBE8AYFI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=oZPZIc+ZmfC238cvQ3DhfsovZhBR1uTiZ+uslO/ghxIBYhIA6Cn+ZLXpxI42QXzK7qZlTKI/JTCss/DHct/p/+lepWy5Sr/HQGc6bnpztnQ4oDpSzjUU6uKdr/ZefBOP8mT96veIFKuZwMeD0RSwBLVhyqrSIfG3JUhX+1q1z8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AFKzAvbM; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-246088fc25cso26835305ad.1
        for <bpf@vger.kernel.org>; Fri, 22 Aug 2025 17:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755909151; x=1756513951; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yQAl8xl/b+1jpLH9+IEKeJpo3s5Nx0HvpydTDpQfd4s=;
        b=AFKzAvbMV3/4suLV56f+kW8wYB1GVQHgU+Ic5MKMWY8F0+Ysh2UEpr0Z4aq994HiHG
         bQQsdVq95iqYzBAcMryylwTYgc/QzQblMpmiDl60qe6qnic7btottAsBe2AK7HIjEpgR
         +RndbXGfCyMYw88aZ3ItGtIM6d7WwmLbFob/RR1tfK05Br6mV52UaTpoQpLBixncaUGM
         WNieaeHSXI5dDV+TmHajrpd2xKqILpHFhTCzEHIEgWZm7Zj9M7jr86XM+BS+t2Xf4axd
         qgOwwz5XCGBlL57kWPNum4OhC8k35QNZiYvHlof/ALUQLVnVPRxCBICDD0iEPwJIJJac
         TGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755909151; x=1756513951;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yQAl8xl/b+1jpLH9+IEKeJpo3s5Nx0HvpydTDpQfd4s=;
        b=hWFCcwLuOQlQdDhvQjAD19SkNAs5LoWHR6nD53clSt4LFbvsdRB4D/M9ZbO8HM6Rys
         XHYzqrG6nQ+dromNMyZ9h6hy4c82fVkKy4F8CGZdoTuzAkG604RqmHZpmFP3SjK0i055
         +n3Gej+f4F2suyT8Nd9fWu42bXe1RUC99P+UdLJqCcmwmcxUTIPEZt+y7pv9cV1rZLLp
         qxkBp1bxOF8S6zscODIw6vDp3dMqVtQliF0ItXSG4yHhSYeaRkDkV/G0sz51R1efNlYk
         Rhfq6xnjjJWlJhK4LSov3T5oBGFZ75nW/wOp6PIWtXBorwywfxzswRmzDqBrL0YvkhPA
         DKWw==
X-Forwarded-Encrypted: i=1; AJvYcCUD4iu/SI3C/n66VV40To5kdK8msT8pa4nu6jT9a/J227hJHcQhXnls818Nj2IbW0o+HW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvGsZXTNBBPz8ZFzVKWxfGhvwO6Ly3elz3HecQK3rHMge706mT
	Ah5b0PQTK/vvvlp30kqpbgXkVUWFWWMei5V6i+wZ8EdbA+J4NxUXmfzuUS1s5Fk1EQqTGjSFXNy
	GoA1qP7Reww==
X-Google-Smtp-Source: AGHT+IHRINNwvyZt4lXIFjt25RkSON9R8J4szK9janrxGyoVx2sOxv0HYEXd2hph/CfK/OG2Ux3zgjtJdVez
X-Received: from plbme5.prod.google.com ([2002:a17:902:fc45:b0:242:fe10:6c5f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e892:b0:243:8f:6db5
 with SMTP id d9443c01a7336-2462ee0baa0mr79386145ad.6.1755909150886; Fri, 22
 Aug 2025 17:32:30 -0700 (PDT)
Date: Fri, 22 Aug 2025 17:31:57 -0700
In-Reply-To: <20250823003216.733941-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250823003216.733941-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250823003216.733941-2-irogers@google.com>
Subject: [PATCH v5 01/19] perf build: Remove libtracefs configuration
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Aditya Gupta <adityag@linux.ibm.com>, 
	"Steinar H. Gunderson" <sesse@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	Changbin Du <changbin.du@huawei.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	James Clark <james.clark@linaro.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Li Huafei <lihuafei1@huawei.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>, 
	Chaitanya S Prakash <chaitanyas.prakash@arm.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, llvm@lists.linux.dev, 
	Song Liu <song@kernel.org>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

libtracefs isn't used by perf but not having it installed causes build
warnings. Given the library isn't used, there is no need for the
configuration or warnings so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 5a5832ee7b53..7bc2341295c3 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1181,20 +1181,6 @@ ifneq ($(NO_LIBTRACEEVENT),1)
   else
     $(error ERROR: libtraceevent is missing. Please install libtraceevent-dev/libtraceevent-devel and/or set LIBTRACEEVENT_DIR or build with NO_LIBTRACEEVENT=1)
   endif
-
-  ifeq ($(feature-libtracefs), 1)
-    CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs)
-    LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
-    EXTLIBS += $(shell $(PKG_CONFIG) --libs-only-l libtracefs)
-    LIBTRACEFS_VERSION := $(shell $(PKG_CONFIG) --modversion libtracefs).0.0
-    LIBTRACEFS_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEFS_VERSION)))
-    LIBTRACEFS_VERSION_CPP := $(shell expr $(LIBTRACEFS_VERSION_1) \* 255 \* 255 + $(LIBTRACEFS_VERSION_2) \* 255 + $(LIBTRACEFS_VERSION_3))
-    CFLAGS += -DLIBTRACEFS_VERSION=$(LIBTRACEFS_VERSION_CPP)
-  else
-    $(warning libtracefs is missing. Please install libtracefs-dev/libtracefs-devel)
-  endif
 endif
 
 # Among the variables below, these:
-- 
2.51.0.rc2.233.g662b1ed5c5-goog


