Return-Path: <bpf+bounces-15819-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA777F7808
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 16:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53FF280F82
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCF43172D;
	Fri, 24 Nov 2023 15:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="g2h4yIKc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380DE1BD5
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 07:43:51 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ce28faa92dso15672445ad.2
        for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 07:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1700840630; x=1701445430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=em900Y8e2LU3XRCCvv0FDkDi7n3dBJKfbFWfFC6kde4=;
        b=g2h4yIKcRCiGUBdbbw049JOaX8gkYOd6SQ6T99P+OMPPPXK4PkYhOiEqfOo7KGHlzG
         WG2vg4OwFs/9UM/2S6NXdXcyFTMN8cZhkXkXNG+q5LiSnfZ1J903q0oKmohrNRaJgpx1
         15brsdrt/UOXFxb0XI6isJLmSfejVR4uv5yL0DqpmoS7ZQKSrAh0nUcS3RrFpT8UDsTC
         MqNYW3jLTEHwXHl4FA4VowxpvuG6iIP5UvQfzRgmWO4aeUblNNGZy7hawGgr8boDX4RR
         r8+kdWRQvZYkhKRneamvo+WtfRV1X6bAWKOFi1AZNA0BJH3XURWAtoLZlVnbpJ0958Uz
         0xgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700840630; x=1701445430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=em900Y8e2LU3XRCCvv0FDkDi7n3dBJKfbFWfFC6kde4=;
        b=OYad3aOUK2kCegUJDSJ4ORlOGWNCPf2gMfzxmkapsBG0DFeO/xz0FkYdeyVSoeQfLd
         pfBDnq8cpQf1RiYQuZ200oPL1z8omUGdpC1252qEx2J9VZvOv/Cy7uynRWfyfyAM6TI+
         IFkk/0GglfrFfQ9DmCbycachpbVrUgT5YquN6rKHQkTcM4vOYGTXBs8SZrQfzm8FR9oD
         PswYqMSLscy8dupxMnujuWyXnhyZtv9bB5IZFLnCgyfS1B9k/S9OE+7eVYnr+11FbEQ/
         +aqp5IJduNL5uPUL9xfgP4t0TIFQZKTsIGMKZu2ULCCmpz1j9pmvHAWXUe6g1VAAvFOD
         wIMw==
X-Gm-Message-State: AOJu0YzlTo4dRWnS0LDoWdEW27K41972nwJwcpF4UelbS+Jec9Is/huA
	+qmcu03Y18mg0sSsyxENd9aWRw==
X-Google-Smtp-Source: AGHT+IG0IVo5gbTJiAwdNes86R04nbY78iq46TZ/OBOFdNhXqvu3+DDy8kv81uFwc6TOrj3smBh/nA==
X-Received: by 2002:a17:902:d303:b0:1cc:2f70:4865 with SMTP id b3-20020a170902d30300b001cc2f704865mr3218515plc.26.1700840630674;
        Fri, 24 Nov 2023 07:43:50 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id g6-20020a170902740600b001cf9eac2d3asm1919743pll.118.2023.11.24.07.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 07:43:50 -0800 (PST)
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
Subject: [PATCH net-next 2/5] selftests: tc-testing: remove unnecessary time.sleep
Date: Fri, 24 Nov 2023 12:42:45 -0300
Message-Id: <20231124154248.315470-3-pctammela@mojatatu.com>
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

This operation is redundant and it's not stabilizing nor waiting
for anything.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 tools/testing/selftests/tc-testing/tdc.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/testing/selftests/tc-testing/tdc.py b/tools/testing/selftests/tc-testing/tdc.py
index 669ec89ebfe1..c5ec861687b6 100755
--- a/tools/testing/selftests/tc-testing/tdc.py
+++ b/tools/testing/selftests/tc-testing/tdc.py
@@ -497,11 +497,6 @@ def prepare_run(pm, args, testlist):
         pm.call_post_suite(1)
         return emergency_exit_message
 
-    if args.verbose:
-        print('give test rig 2 seconds to stabilize')
-
-    time.sleep(2)
-
 def purge_run(pm, index):
     pm.call_post_suite(index)
 
-- 
2.40.1


