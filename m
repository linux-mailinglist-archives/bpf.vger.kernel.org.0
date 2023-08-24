Return-Path: <bpf+bounces-8463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 366E2786F07
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 14:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 684A71C20DAB
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4806100CD;
	Thu, 24 Aug 2023 12:29:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C702454A;
	Thu, 24 Aug 2023 12:29:35 +0000 (UTC)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4C3171A;
	Thu, 24 Aug 2023 05:29:33 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2bcd48725dbso8445501fa.1;
        Thu, 24 Aug 2023 05:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692880172; x=1693484972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y2mgCQ/4l+k/Mag95Sx358RqULbNRiRP9ljR5yjStBE=;
        b=fTk+U4prYgdxxC8dBxPpV4RHuyO5HXHf0kIcwnod9WJ8XTaPpJfBgDBZ/Ygl+QvT1N
         pUJts8aLHKWcSOL8bJAzjn+H/t2MCLFoztOrxGl4v+1rZCvFflOidJtDdoosauoXD866
         i17bjppGFnXrDkSHi6T5qRVlb+VTcYr3ptpQK8AsPRQwcOcp62xxLx6WuuCPZDA7e9mU
         yB9u33RTVZxIwlpLoEm9+NIVvvvxg8+aJg08MpznKZaywEv/HnUCbKPZ8i7ZMV5ryU6D
         MH/5rTwSRY5km8IJKe5jA124A3ApUrkt+CSuMF+v2Gc3HcicrnQnzU+3ZGnybAEz63WE
         F6eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692880172; x=1693484972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y2mgCQ/4l+k/Mag95Sx358RqULbNRiRP9ljR5yjStBE=;
        b=KGfZ3w4s6x12hV6n3QhELkhI1WrZMD/80ReB/ZMJJohS5YEr8xSN1GiA/WD1tQQrJm
         0f0F9+SWIFp8F9voEM2Yl1idB1ZRtc2uFr6kWJcLbUYeH+pE6PI96oYRfZr6Lsz6Wtmw
         OG0HZbCRDxSmKrgRHcHgsSszbpPia5Q5LqHpPyb+mR3tclK7a7DK2pKoa6CbNZ5wHh4k
         HNkEfSqghoIZq9pkw9C72dUgSalwPX0MxW0/KQjT9jQaz4LX4YX1kliYm/CJdj+1xnMY
         M2Npdcure1s7u0a8Y/eYtyuXlIabntQYebAAmohFEwcGzcFS2vw0I0WZDk3YPkrOtTfm
         +D/g==
X-Gm-Message-State: AOJu0YwTSzguGQdxMea7KXblrlVxwyEn3ZfGCzq8tZM+/GmVDQKMH9xL
	ki0ADzTBo97fVUg/vmOp/hM=
X-Google-Smtp-Source: AGHT+IEDzwcaHZ1bipIA5p/ef6LPOB9RXACD1TKIBgsJGIUKHiJNJAy2pQfiJmau059npsz/UEGE/g==
X-Received: by 2002:a2e:b5aa:0:b0:2bc:e36a:9e32 with SMTP id f10-20020a2eb5aa000000b002bce36a9e32mr1335530ljn.5.1692880171701;
        Thu, 24 Aug 2023 05:29:31 -0700 (PDT)
Received: from localhost.localdomain ([94.234.116.52])
        by smtp.gmail.com with ESMTPSA id hn1-20020a05600ca38100b003fbe4cecc3bsm2523776wmb.16.2023.08.24.05.29.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Aug 2023 05:29:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 00/11] seltests/xsk: various improvements to xskxceiver
Date: Thu, 24 Aug 2023 14:28:42 +0200
Message-Id: <20230824122853.3494-1-magnus.karlsson@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

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

11: Introduce the environment variable XSKTEST_ETH to be able to set
    the network interface to be used.

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

Magnus Karlsson (11):
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
  selftests/xsk: introduce XSKTEST_ETH environment variable

 tools/testing/selftests/bpf/test_xsk.sh    |  60 ++-
 tools/testing/selftests/bpf/xsk_prereqs.sh |  10 +-
 tools/testing/selftests/bpf/xskxceiver.c   | 536 ++++++++++++---------
 tools/testing/selftests/bpf/xskxceiver.h   |  44 +-
 4 files changed, 377 insertions(+), 273 deletions(-)


base-commit: f3bdb54f09ab4cdbca48bf7befa8997cadd8d6a1
--
2.34.1

