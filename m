Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293ED6C14ED
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 15:38:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjCTOiB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 10:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjCTOiA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 10:38:00 -0400
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F827480
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 07:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=eHeAeK4+9D07K6vksSUgXp+IEWn25O17u+IQ/sSz6zE=; b=iDW1DR+YGlwt+9gISnaIUUHvhM
        Go3nCf9U7UYuxaabyqouCA+5EnUxmzFaBl6aFclV5atLUKaZy7XyeiV8KGtz6RdZu+rmoDzVvyUBC
        LUWcm1aC1flxxYvx+WrIE3kBOhriv0UeslXYeteUZCLzxm+eXXOuLrkXgjfiSNN+rTs76fCUA0Hrf
        OmAMRB54UNb0SQb7bIqbf8gR157fOKxqLt6QWq5gz4wU3uN056hHawyfg2/za45CbzfMNp95vR78E
        0MqKdq9v1nLDnA6zyB8dQZf4GEa9Ouc7hN/C0uTd3WAPtL+9ziSxTUVtzswbQJhfzUqPHctRzIDcJ
        0YxvceqA==;
Received: from [81.6.34.132] (helo=localhost)
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1peGdi-000NBy-U4; Mon, 20 Mar 2023 15:37:34 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Stephen Haynes <sh@synk.net>,
        Lefteris Alexakis <lefteris.alexakis@kpn.com>
Subject: [PATCH bpf] bpf: Adjust insufficient default bpf_jit_limit
Date:   Mon, 20 Mar 2023 15:37:25 +0100
Message-Id: <20230320143725.8394-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26849/Mon Mar 20 08:24:18 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We've seen recent AWS EKS (Kubernetes) user reports like the following:

  After upgrading EKS nodes from v20230203 to v20230217 on our 1.24 EKS
  clusters after a few days a number of the nodes have containers stuck
  in ContainerCreating state or liveness/readiness probes reporting the
  following error:

    Readiness probe errored: rpc error: code = Unknown desc = failed to
    exec in container: failed to start exec "4a11039f730203ffc003b7[...]":
    OCI runtime exec failed: exec failed: unable to start container process:
    unable to init seccomp: error loading seccomp filter into kernel:
    error loading seccomp filter: errno 524: unknown

  However, we had not been seeing this issue on previous AMIs and it only
  started to occur on v20230217 (following the upgrade from kernel 5.4 to
  5.10) with no other changes to the underlying cluster or workloads.

  We tried the suggestions from that issue (sysctl net.core.bpf_jit_limit=452534528)
  which helped to immediately allow containers to be created and probes to
  execute but after approximately a day the issue returned and the value
  returned by cat /proc/vmallocinfo | grep bpf_jit | awk '{s+=$2} END {print s}'
  was steadily increasing.

I tested bpf tree to observe bpf_jit_charge_modmem, bpf_jit_uncharge_modmem
their sizes passed in as well as bpf_jit_current under tcpdump BPF filter,
seccomp BPF and native (e)BPF programs, and the behavior all looks sane
and expected, that is nothing "leaking" from an upstream perspective.

The bpf_jit_limit knob was originally added in order to avoid a situation
where unprivileged applications loading BPF programs (e.g. seccomp BPF
policies) consuming all the module memory space via BPF JIT such that loading
of kernel modules would be prevented. The default limit was defined back in
2018 and while good enough back then, we are generally seeing far more BPF
consumers today.

Adjust the limit for the BPF JIT pool from originally 1/4 to now 1/2 of the
module memory space to better reflect today's needs and avoid more users
running into potentially hard to debug issues.

Fixes: fdadd04931c2 ("bpf: fix bpf_jit_limit knob for PAGE_SIZE >= 64K")
Reported-by: Stephen Haynes <sh@synk.net>
Reported-by: Lefteris Alexakis <lefteris.alexakis@kpn.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://github.com/awslabs/amazon-eks-ami/issues/1179
Link: https://github.com/awslabs/amazon-eks-ami/issues/1219
---
 kernel/bpf/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index b297e9f60ca1..e2d256c82072 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -972,7 +972,7 @@ static int __init bpf_jit_charge_init(void)
 {
 	/* Only used as heuristic here to derive limit. */
 	bpf_jit_limit_max = bpf_jit_alloc_exec_limit();
-	bpf_jit_limit = min_t(u64, round_up(bpf_jit_limit_max >> 2,
+	bpf_jit_limit = min_t(u64, round_up(bpf_jit_limit_max >> 1,
 					    PAGE_SIZE), LONG_MAX);
 	return 0;
 }
-- 
2.27.0

