Return-Path: <bpf+bounces-34724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D19A49303EB
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 07:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04F2A1C21F2F
	for <lists+bpf@lfdr.de>; Sat, 13 Jul 2024 05:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821CF2110E;
	Sat, 13 Jul 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR8n9vtf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E8E1EB56
	for <bpf@vger.kernel.org>; Sat, 13 Jul 2024 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720850175; cv=none; b=tjwNWpSYj2YBU7I9FrC/YBwUOujKnfaBbusQ3Duug6jX3DKhYvPOoUEYKmdTU/DExzBNCHPtjd6Xrac1OedCZ3+eY0/OhLugcjIZwNjWIsINTJdE05PdLwXc8xJugNgaFZCFthlm8JJWrkBB+7ncku2qycbUlQkVM9amqDzomWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720850175; c=relaxed/simple;
	bh=jzyPpnI8x/qny/EVzq23oGH3cquN78qbTC80vaq2Ibs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UEzTwGeC/WKdRB+OnAQIDUdeY9nigaP80qYAytp3c6lUvc/xGhh+hP6geaW7pYmFPZndZwNytgz3piHwgbwfqaP2m3QcZzn0vCHDwsAqm3/3BEHGmaFw0CQwxBj0By76/Oxy++6aA6XjJC1vTfy8e0WTwwOXx4pfHCAOQKmx1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR8n9vtf; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-659f781270dso30120837b3.1
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 22:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720850172; x=1721454972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fcoN9+1wr+uoawgJ6ob2uuCcwpksqbQY6J9j1AFa1kk=;
        b=UR8n9vtf9nrAX3saGxQWQc4wnisVOQnAyC9PBNucnqX6ZxWEetGP6y77SYzC3m+pxv
         yidTR9xKZGcXuWWbBU+55y7uMQtHd96a1KQIvaAK/mVRXVUNr0pxzPoHta/faSfEBjkB
         uRPH406LHQ9Un2grnwZdFqEGKzAgmP4l7qido4CrwZXFCtF3aD9G0+lYqke/1tO9/AR7
         C0Y1SQlqxqnIUL1aqBTktLzrEZ2VNdeJkKBHF2KbSeenw5sS/KLEzgtyrqOTGCOZLyda
         mHzyoOcxDCuGc0rh4LLPkwA3zAbVZuV1xgDqPlDViT/Tx7wCApGGtzIv3ofeLIyGG3td
         x/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720850172; x=1721454972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fcoN9+1wr+uoawgJ6ob2uuCcwpksqbQY6J9j1AFa1kk=;
        b=WEyJ95zGACD+tuUkZRzDdJSAEW2YLJq9aQy257Q1ys9e2hPU3xSRTkRRa6ENKb7NG8
         LN1ic6kxhYljL4gVIgZumOFMSWrbRRAK4wJY3BtTDOyHe5zrpgs6HoNZ7CJPWlb0plql
         EZ/3Jfx0Tkt8bC3bumb+1LWGYEiaqUWgBkVn99AZVgAwQ206iiIah4LUFTEBfoU+mmOa
         rDLvqZdMQM1auBH5TyYYp3MC1oHwJnew9ckut2j7mwO3pOIDITClOJWvtY/uMwG9Wl/9
         ZQSn9/cAyIIsZ2HZRffDdYulTUHlZ+DpAYmDpN5R/e+ZExEWSJoDWzcJDxvneBDxtSnS
         1uxA==
X-Gm-Message-State: AOJu0YxL6l9DigpS5yWzVsfepMTu2yK2W7r8XWdYyPeNyOQgLRyJNlQx
	xfKLfWP7YqB72faXoWrjo8UzVqJb2FJx3+EdZkMAo625wr78ItGsF/E7MdCe
X-Google-Smtp-Source: AGHT+IFjFfDdTk+Kzl41wJoDVsfQRhiLoC+x3Hv3wxysePh6DwPAerokNMUrjuudP78eYfroALfNfA==
X-Received: by 2002:a81:b80d:0:b0:62f:fc49:57bd with SMTP id 00721157ae682-65df70e8598mr36513737b3.3.1720850172380;
        Fri, 12 Jul 2024 22:56:12 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1e:9d09:4e82:b45e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-65fc445165dsm761927b3.105.2024.07.12.22.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 22:56:11 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 0/4] monitor network traffic for flaky test cases
Date: Fri, 12 Jul 2024 22:55:48 -0700
Message-Id: <20240713055552.2482367-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Run tcpdump in the background for flaky test cases related to network
features.

We have some flaky test cases that are difficult to debug without
knowing what the traffic looks like. With the log printed by tcpdump,
the CI log may help developers to fix these flaky test cases.

This patch set monitors a few test cases. Recently, they have been
showing flaky behavior. If these test cases fail, they will report a
traffic log.

At the beginning and the end of a traffic log, there are additional
traffic packets used for synchronization between the test cases and
the tcpdump process. These packets consist of UDP packets sent to
127.0.0.241:4321 and ICMP unreachable messages for this
destination. For instance, the first two and the last two packets
serve as synchronization packets in the following log.

    15:04:08.586368 lo    In  IP 127.0.0.1.58904 > 127.0.0.241.4321: UDP, length 5
    15:04:08.586435 lo    In  IP 127.0.0.241 > 127.0.0.1: ICMP 127.0.0.241 udp port 4321 unreachable, length 41
    15:04:08.704526 lo    In  IP6 ::1.52053 > ::1.45070: UDP, length 8
    15:04:08.722785 lo    In  IP 127.0.0.1.51863 > 127.0.0.241.4321: UDP, length 15
    15:04:08.722856 lo    In  IP 127.0.0.241 > 127.0.0.1: ICMP 127.0.0.241 udp port 4321 unreachable, length 51 

The IP address 127.0.0.241 is used for synchronization, so the
loopback interface "lo" should be up in the network namespace where
the test is being conducted. While not ideal, this should suffice for
testing purposes.

The following block is an example that monitors the network traffic of
a test case. This test is running in the network namespace
"testns". You can pass NULL to traffic_monitor_start() if the entire
test, from traffic_monitor_start() to traffic_monitor_stop(), is
running in the same namespace.

    struct tmonitor_ctx *tmon;
    
    ...
    tmon = traffic_monitor_start("testns");
    ASSERT_TRUE(tmon, "traffic_monitor_start");
    
    ... test ...
    
    /* Report the traffic log only if there is one or more errors. */
    if (env.subtest_state->error_cnt)
        traffic_monitor_report(tmon);
    traffic_monitor_stop(tmon);

traffic_monitor_start() may fail, but we just ignore it since the
failure doesn't affect the following test.  This tracking feature
takes another 60ms for each test with qemu on my test environment.

Kui-Feng Lee (4):
  selftests/bpf: Add traffic monitor functions.
  selftests/bpf: Monitor traffic for tc_redirect/tc_redirect_dtime.
  selftests/bpf: Monitor traffic for sockmap_listen.
  selftests/bpf: Monitor traffic for select_reuseport.

 tools/testing/selftests/bpf/network_helpers.c | 244 ++++++++++++++++++
 tools/testing/selftests/bpf/network_helpers.h |   5 +
 .../bpf/prog_tests/select_reuseport.c         |   9 +
 .../selftests/bpf/prog_tests/sockmap_listen.c |  10 +
 .../selftests/bpf/prog_tests/tc_redirect.c    |   7 +
 5 files changed, 275 insertions(+)

-- 
2.34.1


