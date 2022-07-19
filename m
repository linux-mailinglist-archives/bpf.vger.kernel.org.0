Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CEB57A5FC
	for <lists+bpf@lfdr.de>; Tue, 19 Jul 2022 20:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238422AbiGSSC6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Jul 2022 14:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232554AbiGSSC6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Jul 2022 14:02:58 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA92952E40
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 11:02:56 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id CCE9B240042
        for <bpf@vger.kernel.org>; Tue, 19 Jul 2022 20:02:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1658253773; bh=cmk838BfIwyXBH5poyH53QofFLLANLjelriMduj1gck=;
        h=From:To:Cc:Subject:Date:From;
        b=T/TMgsKk2biUF+4lL3EDRc6rRDGyjRwIdCY+qbui8vcAQMTvhuhQJyLY+y4zHr65N
         xn55oRMq06Yf59SGir112IU6e01v+241tZt6PCyUqMqkIQ4c+OaeApif1dIElH/FEw
         6FLKWF1ub1KBnrspEFd/baJP5WORNpkmKzE+uyUnL6vZWqhsw1p2uAqzGrVWAI/oUm
         hL0AR4k05nPoySUYmhThF8pTJ019HTVxGBDwFKLtJVvVOmvNfNFN1f0yxCX27bkt1j
         AKEJXwWURuOetTrDlqgJhe/GrybKjvGryyIeJwO8kdvsy8xsiG8SmSOxqp5v6Tv6TV
         ImkpU7i5IC6lw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LnRWc6vk5z9rxH;
        Tue, 19 Jul 2022 20:02:52 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     mykolal@fb.com
Subject: [PATCH bpf-next v2 0/3] Maintain selftest configuration in-tree
Date:   Tue, 19 Jul 2022 18:02:48 +0000
Message-Id: <20220719180251.836588-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BPF selftests mandate certain kernel configuration options to be present in
order to pass. Currently the "reference" config files containing these options
are hosted in a separate repository [0]. From there they are picked up by the
BPF continuous integration system as well as the in-tree vmtest.sh helper
script, which allows for running tests in a VM-based setup locally.

But it gets worse, as "BPF CI" is really two CI systems: one for libbpf
(mentioned above) and one for the bpf-next kernel repository (or more precisely:
family of repositories, as bpf-rc is using the system). As such, we have an
additional -- and slightly divergent -- copy of these configurations.

This patch set proposes the merging of said configurations into this repository.
Doing so provides several benefits:
1) the vmtest.sh script is now self-contained, no longer requiring to pull
   configurations over the network
2) we can have a single copy of these configurations, eliminating the
   maintenance burden of keeping two versions in-sync
3) the kernel tree is the place where most development happens, so it is the
   most natural to adjust configurations as changes are proposed there, as
   opposed to out-of-tree, where they would always remain an afterthought

The patch set is structed in such a way that we first integrate the external
configuration [0] and then adjust the vmtest.sh script to pick up the local
configuration instead of reaching out to GitHub.

[0] https://github.com/libbpf/libbpf/tree/20f03302350a4143825cedcbd210c4d7112c1898/travis-ci/vmtest/configs

---
Changelog:
v1 -> v2:
- minimized imported kernel configs and made them build on top of existing
  tools/testing/selftests/bpf/config
  - moved them directly into tools/testing/selftests/bpf/
- sorted and cleaned up tools/testing/selftests/bpf/config
- removed "selftests/bpf: Integrate vmtest configs" from patch set
- removed 4.9 & 5.5 configs

Daniel Müller (3):
  selftests/bpf: Sort configuration
  selftests/bpf: Copy over libbpf configs
  selftests/bpf: Adjust vmtest.sh to use local kernel configuration

 tools/testing/selftests/bpf/DENYLIST       |   6 +
 tools/testing/selftests/bpf/DENYLIST.s390x |  67 ++++++
 tools/testing/selftests/bpf/config         | 101 ++++-----
 tools/testing/selftests/bpf/config.s390x   | 154 +++++++++++++
 tools/testing/selftests/bpf/config.x86_64  | 251 +++++++++++++++++++++
 tools/testing/selftests/bpf/vmtest.sh      |  51 +++--
 6 files changed, 561 insertions(+), 69 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/DENYLIST
 create mode 100644 tools/testing/selftests/bpf/DENYLIST.s390x
 create mode 100644 tools/testing/selftests/bpf/config.s390x
 create mode 100644 tools/testing/selftests/bpf/config.x86_64

-- 
2.30.2

