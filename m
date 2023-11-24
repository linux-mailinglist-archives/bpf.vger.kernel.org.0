Return-Path: <bpf+bounces-15821-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C399B7F7811
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 16:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77ED8281D06
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 15:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 027B13173D;
	Fri, 24 Nov 2023 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qam3F906"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7061BC1
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 07:44:00 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1cfaaa79766so3171925ad.3
        for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 07:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700840640; x=1701445440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=meBAQ3i5bzteTDjsadEVqP3IdyNZUBxruoeAMf+7W4k=;
        b=qam3F906LMRyLWAhhlGWfMRMmxHneO5O/2B11kLv9M99EnjJsSBqlyeT6HrIQG2ZDi
         XYNegTrx04O1mZE+NHyQngFQsXa/HUPrlynIF1aOHzQQKIo8TcJzp1K6GqoHqzsnz1g2
         m+QEr1ilS5wPIJanPxwRPhRksHsUz9EQ+XY/8xH38V2ZCKo2UdT79w5lLlDOm5kpjsTQ
         2Uwjv2wbpZM4DL96f8EgAwuUcrXJq3WZarkgyPWHywtxZlSP6oDcCco3WpQsxEPAkByd
         LO1mluHnyFntGE4yBztOSXI1DV8U5qxGTgdCiePbHxRi0wJxOiNDo1TxyJRUXBjhs1AQ
         HclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840640; x=1701445440;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=meBAQ3i5bzteTDjsadEVqP3IdyNZUBxruoeAMf+7W4k=;
        b=PukDa/M8w7v+WxD/vWUFqEkHqzTwALoSH9x2E1giU9L+rhxWoSbg2nLFto9vNg0Gp0
         ZW6PrlPg5SfiwdM2p/TeF/rn1uQLfJc+UAhFPTn/ee+Grnye8URgXorjOncLT8jG0O7m
         3C+njZv/dINc987Q82+swkY4kOyUowyrGsFNkq8GXFbjSQZsAyEuawNKHb5giv+CTKDY
         WmWBFtWUl/jQadQYlQFMEn79a+a6ObyfOq3M6JKbu8ImezMXaV+Crh/GElrDoz8PjU0n
         YJzkwpEOZrx0CazZyQx/61a3TR2ENHi1aoYGDjyjYbzlHJ3Lj8naPiQWBEVUXG3DQztJ
         INfQ==
X-Gm-Message-State: AOJu0Yyi85CagV0ZezwfK3CnzLQaSwcBH2pnGRuBIiSsZ5VZpZxYZ5W2
	EnFnB9YI+iNqDTFwS78xNAlk0Q==
X-Google-Smtp-Source: AGHT+IEI/gV9/wjUMlivgVIkBGWHfGfGb1pfZNnDlb9nUwelvrY0VHUqAQAEdEhIc9BPVn6KNayM2w==
X-Received: by 2002:a17:902:e752:b0:1cf:6aae:5998 with SMTP id p18-20020a170902e75200b001cf6aae5998mr4296165plf.0.1700840638351;
        Fri, 24 Nov 2023 07:43:58 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001cf9eac2d3asm1919743pll.118.2023.11.24.07.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:43:57 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	linux-kselftest@vger.kernel.org,
	bpf@vger.kernel.org,
	llvm@lists.linux.dev,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 4/5] selftests: tc-testing: cleanup on Ctrl-C
Date: Fri, 24 Nov 2023 12:42:47 -0300
Message-Id: <20231124154248.315470-5-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231124154248.315470-1-pctammela@mojatatu.com>
References: <20231124154248.315470-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup net namespaces and other resources if we get a SIGINT (Ctrl-C).
As user visible resources are allocated on a per test basis, it's only
required to catch this condition when (possibly) running tests.

So far calling post_suite is enough to free up anything that might
linger.

A missing keyword replacement for nsPlugin is also included.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py | 2 +-
 tools/testing/selftests/tc-testing/tdc.py                 | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
index dc7a0597cf44..77b1106b8388 100644
--- a/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
+++ b/tools/testing/selftests/tc-testing/plugin-lib/nsPlugin.py
@@ -78,7 +78,7 @@ class SubPlugin(TdcPlugin):
             print('{}.post_suite'.format(self.sub_class))
 
         # Make sure we don't leak resources
-        cmd = "$IP -a netns del"
+        cmd = self._replace_keywords("$IP -a netns del")
 
         if self.args.verbose > 3:
             print('_exec_cmd:  command "{}"'.format(cmd))
diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index c5ec861687b6..caeacc691587 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -1018,7 +1018,11 @@ def main():
     if args.verbose > 2:
         print('args is {}'.format(args))
 
-    set_operation_mode(pm, parser, args, remaining)
+    try:
+        set_operation_mode(pm, parser, args, remaining)
+    except KeyboardInterrupt:
+        # Cleanup on Ctrl-C
+        pm.call_post_suite(None)
 
 if __name__ == "__main__":
     main()
-- 
2.40.1


