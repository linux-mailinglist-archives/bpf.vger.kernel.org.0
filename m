Return-Path: <bpf+bounces-7349-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D47775F79
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 14:44:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 956EB281C2C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 12:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EEC5182B2;
	Wed,  9 Aug 2023 12:44:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5922216426;
	Wed,  9 Aug 2023 12:44:10 +0000 (UTC)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C7819A1;
	Wed,  9 Aug 2023 05:44:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3159b524c56so1419834f8f.1;
        Wed, 09 Aug 2023 05:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691585047; x=1692189847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VCjrbVHcQ7bS5kinDzLuJhR2NHGTBHacX2KlI+xwd4c=;
        b=jd5ln+YVJIyJjLRybfbgYETPmggclbdLFDISOlUZN+NC0/rDIaf46F+CFrBSoMrqn7
         W4I5prUyBIzdSzm6LB6DNrIiVpaYDIC7FNxj21J9YMOkglxzU7+9yM4TkdnUefGmrq5b
         TJ19pEd/zthXljhbUMM+0ihcZF42FyVLgZ03lapcE/c0SIXwjxXWFQywmGvJRZCgYGzj
         DaV+ElwDJSp588ODQmyqVh5t3lMUJ6llzvrcqXsljX6nwtNdF4uqrlcnni/SY3W0Xg5p
         cH2WHOsmPONEvZveiq0G6r0f7vUta+iSK0BTKhCL1dtyHrSiWHY3yTz7VrxgbzvuNJwz
         qR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691585047; x=1692189847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCjrbVHcQ7bS5kinDzLuJhR2NHGTBHacX2KlI+xwd4c=;
        b=JFvj/uCt33m67gTCslYCZs3GAkb1XP9/WrtxkYhJpkqvMIsrqrscefQdzSwg3o1hzD
         l+oINyXfUUVUqLAxTmqdue3HHnbkaFwsGo1s5+73drEl5+4taLZFcdo8vMEtx7LMlrEZ
         lt7a0hehv/xE80+unF/0ZSrQ5wnnG9lC6rRUcqs5Suv6QEDqLWUS6vFXkbND+eQx0ke0
         aNHmzqwNxTZyNkPGVy9kX+JYWTDyIeCc83FpSyskDeRw73K6C74w5fv84tY4cNDyT2lE
         BHNbKli7MveTJwbstEFOclPYhIfgCEmz1i6y7Loo3hvJauONYOF9cWqKOxnF4ZFl6Ig/
         UP+g==
X-Gm-Message-State: AOJu0YyQLZXQrENOimnVuQUzdC4EaBXdxwqiqhRrhHPogXxVlPCtwLyw
	Nj9OFmgaM/4x1dSzeoG3Luk=
X-Google-Smtp-Source: AGHT+IEY/EvoGx1faAWPj6K3JCjwG7TvTCKKMlb5nCA2k9/u3cN3G1icHMwp7DYEj8OcAVc5UzY1kg==
X-Received: by 2002:a5d:50c4:0:b0:317:5559:a4e with SMTP id f4-20020a5d50c4000000b0031755590a4emr1650862wrt.6.1691585047117;
        Wed, 09 Aug 2023 05:44:07 -0700 (PDT)
Received: from localhost.localdomain (c-5eea7243-74736162.cust.telenor.se. [94.234.114.67])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16811538wru.28.2023.08.09.05.44.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:44:06 -0700 (PDT)
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
	jolsa@kernel.org
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Subject: [PATCH bpf-next 00/10] seltests/xsk: various improvements to xskxceiver
Date: Wed,  9 Aug 2023 14:43:33 +0200
Message-Id: <20230809124343.12957-1-magnus.karlsson@gmail.com>
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
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
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

 tools/testing/selftests/bpf/test_xsk.sh    |  36 +-
 tools/testing/selftests/bpf/xsk_prereqs.sh |  10 +-
 tools/testing/selftests/bpf/xskxceiver.c   | 517 ++++++++++++---------
 tools/testing/selftests/bpf/xskxceiver.h   |  44 +-
 4 files changed, 353 insertions(+), 254 deletions(-)


base-commit: 2adbb7637fd1fcec93f4680ddb5ddbbd1a91aefb
--
2.34.1

