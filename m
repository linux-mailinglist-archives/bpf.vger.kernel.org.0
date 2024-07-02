Return-Path: <bpf+bounces-33575-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B894691EBD7
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 02:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCDAE1C21498
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 00:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF534D512;
	Tue,  2 Jul 2024 00:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H+hovAB9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDBBB646
	for <bpf@vger.kernel.org>; Tue,  2 Jul 2024 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719880318; cv=none; b=m9Sv/Le5c6Ifd4lE+E6W2nbmpHZeQ62SIhsw8G0J4OXAqL44/3gclx8Zh6IaFaRGKa+Hr49VL9XqyO7CvIGjL0LMbgw/uFUPE2ZmYr7+rJlxOFL5Rqc/Jq41RtMHI1P9f1FZjwoDnjV1TdHG/6uV1wEyJR+ed0Z+nejcgpfeFmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719880318; c=relaxed/simple;
	bh=tuIr8daztUffBxMysv/Ni9m7oku3MmIrvzulU2hwKqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tejoZUfdH7pzE128iHRMahT18N0cJH8GOd5grelud5tmyOBn+qO08AXMIv0L+1NAoqAxmVs4h40rWswFjdJKnHbDxrvdGhE+1ZeLFt36r+x+OaN/eREePffh4dZGww4Rbp1i04EmAhANBvTlVqv0bNe3XqTQN6HgjsV0nSNwNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H+hovAB9; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7066a4a611dso2227544b3a.3
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2024 17:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719880316; x=1720485116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/FpDLaEzE1lljeRie/Afz6xbRimtXLow8YQVYOVBA6A=;
        b=H+hovAB9VhzpsuuH65skFEWqfNRbwAxsIxmJWedHQqoEnp5691Q2eh3kff6BTv1yTl
         Fhio8rzopf+lEM116AKMQudNJ8qqghqzN9bv9dkql/9ZtG6so+5KPBryA9iEDU4iTrwm
         OZnt23epH/a3z4iAOjvTE8f5owidUuUpKGQIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719880316; x=1720485116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/FpDLaEzE1lljeRie/Afz6xbRimtXLow8YQVYOVBA6A=;
        b=iEg+T24WczUvWTQaPy7PZIKhYCE1W+sqg6bvX2m2qN+2c3P23RRQY9YU5Y7g1FHuqS
         qu3lsyudvbJzijJ9yGLo9H7H0rLxvcZPzBDfEHJWbPx6eziPmXYVgpUf4xInSrUaBAwQ
         fQUQj0eV9B7/sp78QoD23w5fL0mp1h9R/OXP0FaoF156wneuwH8VH9SuyKqQFUHmWZb7
         Ev6d2rYVNHIUZz3zMpDmifYH5CmD4ARrFodcotZ0HgFRNH/D21fsnk3XfD4Q3asgSe54
         FZYyTZCarGCfA2j/5VC5O3VpKvWw2Inkq1PZ5DoyCgIEwmeVh3UCNVzZfp7caMYhJyBW
         cE6A==
X-Forwarded-Encrypted: i=1; AJvYcCWBvuymmRe9PDY3Reu3w9NOgenBzywlPnlMV7oEtRK6HJqm7o2X5LaknWiI/a3IQr/7AZNEMkrl3nBluLQT5d6ktzBf
X-Gm-Message-State: AOJu0YzJiECb4aNTZImMhzeqfOtCv3Rra4E684yWj9P8ehd1EUKP2L6Q
	Cxn4v1q7rZqi0+LbaU5f1jtJxnePrzAGHC7N6rDH3Lxzz7XjdI5ngTvwrH+01w==
X-Google-Smtp-Source: AGHT+IFLRDi1tgcxluuyy6MucQB92UjRtW1NsdKok1qL6I3tRLejI1fWQmK25lIP8GCyrsm32C6yww==
X-Received: by 2002:a05:6a00:4fd4:b0:706:8cc6:7471 with SMTP id d2e1a72fcca58-70aaaf453eemr6697122b3a.34.1719880316252;
        Mon, 01 Jul 2024 17:31:56 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:32ea:b45d:f22f:94c0])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-70803ecf8d8sm7168419b3a.112.2024.07.01.17.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 17:31:55 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Arnaldo Carvalho de Melo <acme@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 2/3] tools build: Avoid circular .fixdep-in.o.cmd issues
Date: Mon,  1 Jul 2024 17:29:16 -0700
Message-ID: <20240702003119.3641219-3-briannorris@chromium.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240702003119.3641219-1-briannorris@chromium.org>
References: <20240702003119.3641219-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'fixdep' tool is used to post-process dependency files for various
reasons, and it runs after every object file generation command. This
even includes 'fixdep' itself.

In Kbuild, this isn't actually a problem, because it uses a single
command to generate fixdep (a compile-and-link command on fixdep.c), and
afterward runs the fixdep command on the accompanying .fixdep.cmd file.

In tools/ builds (which notably is maintained separately from Kbuild),
fixdep is generated in several phases:

 1. fixdep.c -> fixdep-in.o
 2. fixdep-in.o -> fixdep

Thus, fixdep is not available in the post-processing for step 1, and
instead, we generate .cmd files that look like:

  ## from tools/objtool/libsubcmd/.fixdep.o.cmd
  # cannot find fixdep (/path/to/linux/tools/objtool/libsubcmd//fixdep)
  [...]

These invalid .cmd files are benign in some respects, but cause problems
in others (such as the linked reports).

Because the tools/ build system is rather complicated in its own right
(and pointedly different than Kbuild), I choose to simply open-code the
rule for building fixdep, and avoid the recursive-make indirection that
produces the problem in the first place.

Link: https://lore.kernel.org/all/Zk-C5Eg84yt6_nml@google.com/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 tools/build/Makefile | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index 17cdf01e29a0..fea3cf647f5b 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -43,12 +43,5 @@ ifneq ($(wildcard $(TMP_O)),)
 	$(Q)$(MAKE) -C feature OUTPUT=$(TMP_O) clean >/dev/null
 endif
 
-$(OUTPUT)fixdep-in.o: FORCE
-	$(Q)$(MAKE) $(build)=fixdep
-
-$(OUTPUT)fixdep: $(OUTPUT)fixdep-in.o
-	$(QUIET_LINK)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
-
-FORCE:
-
-.PHONY: FORCE
+$(OUTPUT)fixdep: $(srctree)/tools/build/fixdep.c
+	$(QUIET_CC)$(HOSTCC) $(KBUILD_HOSTLDFLAGS) -o $@ $<
-- 
2.45.2.803.g4e1b14247a-goog


