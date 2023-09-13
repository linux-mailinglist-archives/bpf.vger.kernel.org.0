Return-Path: <bpf+bounces-9887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDE679E5A7
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 13:03:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F076281947
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 11:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8BE1E516;
	Wed, 13 Sep 2023 11:03:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762F3F9D2;
	Wed, 13 Sep 2023 11:03:14 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A0919B6;
	Wed, 13 Sep 2023 04:03:13 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-31f85854b9eso646859f8f.0;
        Wed, 13 Sep 2023 04:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694602992; x=1695207792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IXPIs2ya3pSrdg08iN/6qvh/HZGuvMQXEGZluQz4UtI=;
        b=INX/ndZmAPEpT+Mhv0woBsCljYhBjtEYAWpd+Irpnbpt9HMVjNHhK9h3zOVc2v96N9
         z3UHZr76MdWrJ+FUwPPuSqYC2SMqPI84jxoO/T5tPZ3oRe2lGri/mC3c32dKspbloPvf
         t3MS2jAJsaq4AyYkqVRxHDY+J5oFi/U/yZ6pCa/wZw8etWKVBMAgouytz/hxKJCrbUGi
         ZA3IG3fbIZyi05JOUBRq05ZA6EqKML7pUsOiGiGORmz8yZ9Pd4D/YAqPDu7foatmyp1A
         8W0aBvWTBirjoQljSZolwvXc29EnRpx2yG4fuBWmmSeFpwHFKlkuThwqa+wDViAEGDFL
         ng8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694602992; x=1695207792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IXPIs2ya3pSrdg08iN/6qvh/HZGuvMQXEGZluQz4UtI=;
        b=LV9O7GNlroFbOda0XQX3i63TvS0dmJgOPmKEFCRx7PooKvorobqF6QEEWJl9USwiw3
         AsOaAVPEuqUDI1YmN1TREoFPIdh0pQTQznY5+CzEIh+FRt5oRdzAlCA7pbSJAaPsDPd1
         gQUOCgcuCd3T+gEhlJGwMn6rwwbHcNvxsvjGRCOkmAQoQpunZXfDPJ5VmCb4+Tm7ifQX
         7VnjhERqt/hiRnX0ZKGjsMbJc0HI5gR6GI0qM/hYQj6v4h8w+QddrYRcicoIfUHOcpxJ
         69nC/5MZ5J6nmt3TOIwLxwrPUx1fHJw/G8BlUdEUhwfSZhBcBmPYy7iuX9J0cxMWvGOj
         gSsw==
X-Gm-Message-State: AOJu0YzLFyVAhxeF1ChlgHTYwqjpoPIDhETFlRpCpV78yL4BQLqX8mRk
	+susOUsh62Tnpr/8dVnZ5yk=
X-Google-Smtp-Source: AGHT+IEYIy7NmBVyxVn5HiuygX2PoN017HQGSWODznwRYrNva57Csap/tujzPAuLLKYGPA6l0+w+Lw==
X-Received: by 2002:adf:fa8b:0:b0:317:5eb8:b1c0 with SMTP id h11-20020adffa8b000000b003175eb8b1c0mr1890291wrr.5.1694602991415;
        Wed, 13 Sep 2023 04:03:11 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id d10-20020a5d538a000000b0031c7682607asm15255289wrv.111.2023.09.13.04.03.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Sep 2023 04:03:10 -0700 (PDT)
From: Magnus Karlsson <magnus.karlsson@gmail.com>
To: magnus.karlsson@intel.com,
	bjorn@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	netdev@vger.kernel.org,
	maciej.fijalkowski@intel.com,
	bpf@vger.kernel.org,
	yhs@fb.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	przemyslaw.kitszel@intel.com
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: [PATCH bpf-next v3 00/10] seltests/xsk: various improvements to xskxceiver
Date: Wed, 13 Sep 2023 13:02:22 +0200
Message-ID: <20230913110248.30597-1-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


This patch set implements several improvements to the xsk selftests
test suite that I thought were useful while debugging the xsk
multi-buffer code and tests. The largest new feature is the ability to
be able to execute a single test instead of the whole test suite. This
required some surgery on the current code, details below.

Anatomy of the path set:

1: Print useful info on a per packet basis with the option -v

2: Add a timeout in the transmission loop too. We only used to have
   one for the Rx thread, but Tx can lock up too waiting for
   completions.

3: Add an option (-m) to only run the tests (or a single test with a
   later patch) in a single mode: skb, drv, or zc (zero-copy).

4-5: Preparatory patches to be able to specify a test to run. Need to
     define the test names in a single structure and their entry
     points, so we can use this when wanting to run a specific test.

6: Adds a command line option (-l) that lists all the tests.

7: Adds a command line option (-t) that runs a specific test instead
   of the whole test suite. Can be combined with -m to specify a
   single mode too.

8: Use ksft_print_msg() uniformly throughout the tests. It was a mix
   of printf() and ksft_print_msg() before.

9: In some places, we failed the whole test suite instead of a single
   test in certain circumstances. Fix this so only the test in
   question is failed and the rest of the test suite continues.

10: Display the available command line options with -h

v2 -> v3:
* Drop the support for environment variables. Probably not useful. [Maciej]
* Fixed spelling mistake in patch #9 [Maciej]
* Fail gracefully if unsupported mode is chosen [Maciej]
* Simplified test run loop [Maciej]

v1 -> v2:

* Introduce XSKTEST_MODE env variable to be able to set the mode to
  use [Przemyslaw]
* Introduce XSKTEST_ETH env variable to be able to set the ethernet
  interface to use by introducing a new patch (#11) [Magnus]
* Fixed spelling error in patch #5 [Przemyslaw, Maciej]
* Fixed confusing documentation in patch #10  [Przemyslaw]
* The -l option can now be used without being root [Magnus, Maciej]
* Fixed documentation error in patch #7 [Maciej]
* Added error handling to the -t option [Maciej]
* -h now displayed as an option [Maciej]

Thanks: Magnus

Magnus Karlsson (10):
  selftests/xsk: print per packet info in verbose mode
  selftests/xsk: add timeout for Tx thread
  selftests/xsk: add option to only run tests in a single mode
  selftests/xsk: move all tests to separate functions
  selftests/xsk: declare test names in struct
  selftests/xsk: add option that lists all tests
  selftests/xsk: add option to run single test
  selftests/xsk: use ksft_print_msg uniformly
  selftests/xsk: fail single test instead of all tests
  selftests/xsk: display command line options with -h

 tools/testing/selftests/bpf/test_xsk.sh    |  40 +-
 tools/testing/selftests/bpf/xsk_prereqs.sh |  10 +-
 tools/testing/selftests/bpf/xskxceiver.c   | 539 ++++++++++++---------
 tools/testing/selftests/bpf/xskxceiver.h   |  44 +-
 4 files changed, 372 insertions(+), 261 deletions(-)


base-commit: 5bbb9e1f08352a381a6e8a17b5180170b2a93685
--
2.42.0

