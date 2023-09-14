Return-Path: <bpf+bounces-9983-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9758E79FEF6
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 10:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC614B20B84
	for <lists+bpf@lfdr.de>; Thu, 14 Sep 2023 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC96622F1C;
	Thu, 14 Sep 2023 08:49:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF451CFA9;
	Thu, 14 Sep 2023 08:49:27 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1707A98;
	Thu, 14 Sep 2023 01:49:27 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-404724ec0dcso897755e9.1;
        Thu, 14 Sep 2023 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694681365; x=1695286165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yV6KphSkDoRKxKiln+aTSA4TnEwvlc6D8JOYcDBHbts=;
        b=QX+rHfJ7Mv3zkcuHvtUTaLMeCrk8uRPzNkpAfrhCf0EtEk78FzHEznlfrG5MD3JPMP
         PcWn/v4fqAO1C9B6jWl7obNwXaH3u58tdOkkABs2p82KMIV/xrnczuWPD+z2MEG6sFxT
         xC3DF5vafCazUGKbcb+3YO2K/cleTUU7wDJNfqO3YdUo/Ue078s1EaiHbSuQMLIqWhDJ
         4ybjecTTRgMXtvBdZ1Eo2+OlIcxmTLPavZZwwQs6WkulDIyxdN+jT1moq+U22OFOzyyu
         hXFIvOeJ6j0cwpUUbdg8cQsbRzOuRzJ6bvjV4XHi++/oGiiOSP7C2O2u3Up5XOkB0/Op
         kWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681365; x=1695286165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yV6KphSkDoRKxKiln+aTSA4TnEwvlc6D8JOYcDBHbts=;
        b=lwt+yWcEmscJFl/TgdC4NXx3J1R//Z/ey8tx9sMOTSnoukx5/7BGllf+0MkLjXOp3N
         xxgCw5+63HHDeGe3NdXZMZrsVkJOGSbU6PukQg37M72DuSdy9ol+xNV4m38/CZrERTb+
         UTwDZynh8hPT3syydU3ASXgBgOn3amTy03WILyeRJIvVwUWHjVf8DcYL2f9avlmB8WaQ
         xX2At7BwtYge1cN50EwN6vVNabXnT6TlDJM2yj6TgaBn3UTRDKlRiHCtTWda+2ALExcN
         dUjfDRHDHQSjdA2qOZJnmd/c2M3TtrX+yjcXxD/ay7jOtEjm0EjrcnH+AJt94us1tXSi
         wujw==
X-Gm-Message-State: AOJu0Yze3uJse5ZoJ3sDT0iuuP0rrjkyhkae0RNMQ12+jB71eo5GjFm/
	SuC3lz0sBczmVXdvAlJE4Yg=
X-Google-Smtp-Source: AGHT+IFcrtI1Z5EYCxXg+CZipWSNYTWJ+itzEClwgDKcyjJgWGDUONZNmZPuwTLj/LdiZ30fCR4vMQ==
X-Received: by 2002:a05:600c:34c7:b0:3fe:d637:7b25 with SMTP id d7-20020a05600c34c700b003fed6377b25mr4156854wmq.0.1694681365063;
        Thu, 14 Sep 2023 01:49:25 -0700 (PDT)
Received: from localhost.localdomain (h-176-10-144-222.NA.cust.bahnhof.se. [176.10.144.222])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c294c00b003fee777fd84sm1321099wmd.41.2023.09.14.01.49.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2023 01:49:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 00/10] seltests/xsk: various improvements to xskxceiver
Date: Thu, 14 Sep 2023 10:48:47 +0200
Message-ID: <20230914084900.492-1-magnus.karlsson@gmail.com>
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

v3 -> v4:
* Fixed another spelling error in patch #9 [Maciej]
* Only allow the actual strings for the -m command [Maciej]
* Move some code from patch #7 to #3 [Maciej]

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
 tools/testing/selftests/bpf/xskxceiver.c   | 535 ++++++++++++---------
 tools/testing/selftests/bpf/xskxceiver.h   |  44 +-
 4 files changed, 368 insertions(+), 261 deletions(-)


base-commit: 558c50cc3b135e00c9ed15df4c9159e84166f94c
--
2.42.0

