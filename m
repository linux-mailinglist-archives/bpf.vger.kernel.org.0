Return-Path: <bpf+bounces-35678-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC05893CA4B
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 23:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882CB2810EF
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 21:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A8C143738;
	Thu, 25 Jul 2024 21:40:34 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95589D299;
	Thu, 25 Jul 2024 21:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721943634; cv=none; b=EP4Pa8aBzbN1gO5PEJWIKqqBPiaUMJ5NXGyT7NmcUXvqdKpiv4BiDND13VF8jITzc5krm9wnv/u+7/OhP1WjViFPYQV6Zeu5DSvTfE9F9bFQRBKyfLvetogN1BVw7qVEp4uNuCD4YFhFoeyl8DGLeFVtrTnHdsHDFRQ4jm5n2bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721943634; c=relaxed/simple;
	bh=zsUhcT57cABaTE2Dhuwn3+jHWxlzPZmlpOHzJ67N6JY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Px70dofvz0af7yaX7mluAk/mHnA4dp26pHdofFTfqQwmP9Bb2p908FiPhabuZvWvaGHMzqu/0bsiIktirf7EUb4vqzFyq5kd3RHbiCkPFUEbEuhXwuCUzPXtNQQuKVFVzOsmWUwNtZIXSL2urrWXdG8RpZqaoxnjIv5dTdecNwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d2b921cd1so319866b3a.1;
        Thu, 25 Jul 2024 14:40:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721943630; x=1722548430;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDvbbOukW94VU59kpeKqxI30IOdQuPf9T1C3THKEdP8=;
        b=m/thYT6hGz+maP8gWdnbNgkAPKycueqTGgQioqXCPWAMJ1gCotUq/EQ78FvCdD1O9C
         R8X9WqWM/iaUJ4VX3LiKNx/Wsq3hM4Sh+vTVBoZDqKzzKGuU9hpILMmYLsrgZ/uWV5pO
         oA2whoB4mUhGqkKTCjCNVVyC0CPAqv7IsGtLZFiErtVKeid1nobmCwO2mxz95YS8X8Q0
         WXpwcUNMjP73z/tYY9+rqZIuKQkortxQrw6IzM2/zGClek7o4vyKC31n7FZwSaQKxhAb
         GMUm8CMK+O4R2WZLijc0+Eq8fP8xlhMdmWRZwQmlnlrZ0lUBBrzwcU6M8IMYGQ0zyO64
         G74w==
X-Forwarded-Encrypted: i=1; AJvYcCVhzz7/SmAJmUBIAgSn4czz5dNjDtC+Gos9sdBiVKxEtMBg3WCH1ptud/bURuuYnWelBHDFoxmqDqvY/XE/sHpduDT4bye5
X-Gm-Message-State: AOJu0YwoSm7PcKrvJw6W4yHF4aXxcD1CA9O7gL0dqPjU2W5iydZLkX1r
	uySkT+UbrtgYBbhLIBuEU+GjaGHmmwep220mg+17nm4H+eiGmoMk9mcqxq0=
X-Google-Smtp-Source: AGHT+IHTd/TCq5gvx4v8L9r1/4HyjGmzUpLa63J/JxXnH6BlqcxkE08yossvEGt6chnW42/9kF23Yg==
X-Received: by 2002:a05:6a20:7494:b0:1c4:214c:d9ea with SMTP id adf61e73a8af0-1c47b1ce160mr4194658637.19.1721943630399;
        Thu, 25 Jul 2024 14:40:30 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:73b6:7410:eb24:cba4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead812358sm1547251b3a.132.2024.07.25.14.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 14:40:29 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH bpf] selftests/bpf: Filter out _GNU_SOURCE when compiling test_cpp
Date: Thu, 25 Jul 2024 14:40:29 -0700
Message-ID: <20240725214029.1760809-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jakub reports build failures when merging linux/master with net tree:

CXX      test_cpp
In file included from <built-in>:454:
<command line>:2:9: error: '_GNU_SOURCE' macro redefined [-Werror,-Wmacro-redefined]
    2 | #define _GNU_SOURCE
      |         ^
<built-in>:445:9: note: previous definition is here
  445 | #define _GNU_SOURCE 1

The culprit is commit cc937dad85ae ("selftests: centralize -D_GNU_SOURCE= to
CFLAGS in lib.mk") which unconditionally added -D_GNU_SOUCE to CLFAGS.
Apparently clang++ also unconditionally adds it for the C++ targets [0]
which causes a conflict. Add small change in the selftests makefile
to filter it out for test_cpp.

Not sure which tree it should go via, targeting bpf for now, but net
might be better?

0: https://stackoverflow.com/questions/11670581/why-is-gnu-source-defined-by-default-and-how-to-turn-it-off

Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index dd49c1d23a60..81d4757ecd4c 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -713,7 +713,7 @@ $(OUTPUT)/xdp_features: xdp_features.c $(OUTPUT)/network_helpers.o $(OUTPUT)/xdp
 # Make sure we are able to include and link libbpf against c++.
 $(OUTPUT)/test_cpp: test_cpp.cpp $(OUTPUT)/test_core_extern.skel.h $(BPFOBJ)
 	$(call msg,CXX,,$@)
-	$(Q)$(CXX) $(CFLAGS) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
+	$(Q)$(CXX) $(subst -D_GNU_SOURCE=,,$(CFLAGS)) $(filter %.a %.o %.cpp,$^) $(LDLIBS) -o $@
 
 # Benchmark runner
 $(OUTPUT)/bench_%.o: benchs/bench_%.c bench.h $(BPFOBJ)
-- 
2.45.2


