Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F85762B71C
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 11:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiKPKCg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 05:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKPKCf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 05:02:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FDCC25
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 02:02:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8948661B9C
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 10:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3B0C433D6;
        Wed, 16 Nov 2022 10:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668592953;
        bh=5iAf6c9r3N/huWln9fi3xBqRtxYCXBkJrYG4Y1Xh+D8=;
        h=From:To:Cc:Subject:Date:From;
        b=l7F8qpdSCvc19GrA1H98t0fFTTM1Gi2qcR3u6D1/xhTfzfopWLRpjbm+5RLqlnfH0
         Z8oGzfEY/vDi1TqPdWSCslgi1Hnu2eKANPZ6Hyl/FrSmR81xNvqRs0s2dQi45lyc9D
         4AgPHTcRAAAImlAms9nCa+UECP9mBDExbJWHd9fBGIMMPRIcXLCxG5qUvZ2Ww2NcWM
         DKllTRUHkCFk5Z2ho4ofo/5incSmMAa8/OdhHNbrPnkjldSN6YKX3tONKnBrMTw9eD
         85TKupRs9UzzchdHwNv/N1k6Dj+zfe4oHJ86aH0WAiv9U2W/qWfG+bhS9qhylpX3sB
         2og+V27X7alLQ==
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: [PATCH bpf 1/2] selftests/bpf: Filter out default_idle from kprobe_multi bench
Date:   Wed, 16 Nov 2022 11:02:27 +0100
Message-Id: <20221116100228.2064612-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei hit following rcu warning when running prog_test -j.

  [  128.049567] WARNING: suspicious RCU usage
  [  128.049569] 6.1.0-rc2 #912 Tainted: G           O
  ...
  [  128.050944]  kprobe_multi_link_handler+0x6c/0x1d0
  [  128.050947]  ? kprobe_multi_link_handler+0x42/0x1d0
  [  128.050950]  ? __cpuidle_text_start+0x8/0x8
  [  128.050952]  ? __cpuidle_text_start+0x8/0x8
  [  128.050958]  fprobe_handler.part.1+0xac/0x150
  [  128.050964]  0xffffffffa02130c8
  [  128.050991]  ? default_idle+0x5/0x20
  [  128.050998]  default_idle+0x5/0x20

It's caused by bench test attaching kprobe_multi link to default_idle
function, which is not executed in rcu safe context so the kprobe
handler on top of it will trigger the rcu warning.

Filtering out default_idle function from the bench test.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
index d457a55ff408..b43928967515 100644
--- a/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
+++ b/tools/testing/selftests/bpf/prog_tests/kprobe_multi_test.c
@@ -358,10 +358,12 @@ static int get_syms(char ***symsp, size_t *cntp)
 		 * We attach to almost all kernel functions and some of them
 		 * will cause 'suspicious RCU usage' when fprobe is attached
 		 * to them. Filter out the current culprits - arch_cpu_idle
-		 * and rcu_* functions.
+		 * default_idle and rcu_* functions.
 		 */
 		if (!strcmp(name, "arch_cpu_idle"))
 			continue;
+		if (!strcmp(name, "default_idle"))
+			continue;
 		if (!strncmp(name, "rcu_", 4))
 			continue;
 		if (!strcmp(name, "bpf_dispatcher_xdp_func"))
-- 
2.38.1

