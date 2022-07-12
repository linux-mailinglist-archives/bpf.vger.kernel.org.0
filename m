Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2B857286E
	for <lists+bpf@lfdr.de>; Tue, 12 Jul 2022 23:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiGLVVb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 12 Jul 2022 17:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiGLVVa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 12 Jul 2022 17:21:30 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EC0BE0F7
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 14:21:29 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 37389240027
        for <bpf@vger.kernel.org>; Tue, 12 Jul 2022 23:21:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1657660887; bh=2ByGZq/fhkdoiqooLmyUaYsZgZpEuyn5cNl3uS2tzoE=;
        h=From:To:Cc:Subject:Date:From;
        b=eOrorIVmiRIApeKiJd+E2CMD4f3//gSc0ngpx3de4g0CoB7TZjcdQ1pKpwO6AdbWm
         DAZVEq3t3FAQqhgoFxl1vyvnWSaFgT4YbyNWIthwnOTZDq0RnG3aDn9BFXnKvPgz44
         XrGYSCQydR9PqUI1QulCkAoUiHaLaG1EvTydJ/Tl+/GIpJ6DsC+Z121GOj5XJQGiTO
         Da7qvr5NxxDqCnkqzTCwQ4ReCT/Fkb8uj6MFRYSfcNq19CS0nxBKJKOmZNQtFc8jox
         bryS/eG6sisQVX7zFVrAXWt6AjB4+ZbxF85/9zVBQRT+G3wvSa8t4fwBqWo623QSHh
         aDz/GMpgyYE7A==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4LjDFy2z53z6tmX;
        Tue, 12 Jul 2022 23:21:25 +0200 (CEST)
From:   =?UTF-8?q?Daniel=20M=C3=BCller?= <deso@posteo.net>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     mykolal@fb.com
Subject: [PATCH bpf-next 0/3] Maintain selftest configuration in-tree
Date:   Tue, 12 Jul 2022 21:21:21 +0000
Message-Id: <20220712212124.3180314-1-deso@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

The patch set is structed in such a way that we first integrate the first set of
configurations [0], then we add the difference to the second one [1], and lastly
we adjust the vmtest.sh script to pick up the local configuration instead of
reaching out to GitHub.

[0] https://github.com/libbpf/libbpf/tree/20f03302350a4143825cedcbd210c4d7112c1898/travis-ci/vmtest/configs
[1] https://github.com/kernel-patches/vmtest/tree/831ee8eb72ddb7e03babb8f7e050d52a451237aa/travis-ci/vmtest/configs

Daniel Müller (3):
  selftests/bpf: Copy over libbpf configs
  selftests/bpf: Integrate vmtest configs
  selftests/bpf: Adjust vmtest.sh to use local kernel configuration

 .../bpf/configs/allowlist/ALLOWLIST-4.9.0     |    8 +
 .../bpf/configs/allowlist/ALLOWLIST-5.5.0     |   55 +
 .../selftests/bpf/configs/config-latest.s390x | 2711 +++++++++++++++
 .../bpf/configs/config-latest.x86_64          | 3073 +++++++++++++++++
 .../bpf/configs/denylist/DENYLIST-5.5.0       |  117 +
 .../bpf/configs/denylist/DENYLIST-latest      |   11 +
 .../configs/denylist/DENYLIST-latest.s390x    |   68 +
 tools/testing/selftests/bpf/vmtest.sh         |   28 +-
 8 files changed, 6055 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/configs/allowlist/ALLOWLIST-4.9.0
 create mode 100644 tools/testing/selftests/bpf/configs/allowlist/ALLOWLIST-5.5.0
 create mode 100644 tools/testing/selftests/bpf/configs/config-latest.s390x
 create mode 100644 tools/testing/selftests/bpf/configs/config-latest.x86_64
 create mode 100644 tools/testing/selftests/bpf/configs/denylist/DENYLIST-5.5.0
 create mode 100644 tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest
 create mode 100644 tools/testing/selftests/bpf/configs/denylist/DENYLIST-latest.s390x

-- 
2.30.2

