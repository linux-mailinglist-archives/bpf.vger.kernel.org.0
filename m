Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71726E425C
	for <lists+bpf@lfdr.de>; Mon, 17 Apr 2023 10:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjDQIRy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Apr 2023 04:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjDQIRw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Apr 2023 04:17:52 -0400
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765F526B2;
        Mon, 17 Apr 2023 01:17:51 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id E7D8610006B; Mon, 17 Apr 2023 09:17:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1681719468; bh=7vrhf8jHivfnFCYmFG2HbdBI1KmJjq7kYoSAnAQyO6E=;
        h=Date:From:To:Subject:From;
        b=jnAgdxobsyQiBO+mf1lTUJ1l5zVhvTjnfE96jSjMen+Ig9xVjqbgI/Ubnlck59ZXp
         vzKJEYsWBTXyQrm5bN3Xnvl6okOHiX7XO9BPX1staWHeOTQ0DSyu2PX0FU1KgyG5qg
         d/qAe9ZCVFPKSMmKRObAIK2YwGHRDOkJEjYRSZ99Y2RwPSExY+DdGi3S4KNP4EyOC+
         nbytIPrORFxBMRkD81whgTUHLjBTzLCZXXPC55rw8iSf2kuRwfQBntSnREQqQxTxkN
         5hMMWES2xojiQ2CKHMZ0U+GKLRwcjOLzhK7eJpEgd7fejBMwz4CFDAzBTY+3SVv99s
         OvK3PIULkQP9A==
Date:   Mon, 17 Apr 2023 09:17:48 +0100
From:   Sean Young <sean@mess.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: [PATCH v2] bpf: lirc program type should not require SYS_CAP_ADMIN
Message-ID: <ZD0ArKpwnDBJZsrE@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make it possible to load lirc program type with just CAP_BPF. There is
nothing exceptional about lirc programs that means they require
SYS_CAP_ADMIN.

In order to attach or detach a lirc program type you need permission to
open /dev/lirc0; if you have permission to do that, you can alter all
sorts of lirc receiving options. Changing the IR protocol decoder is no
different.

Right now on a typical distribution /dev/lirc devices are only
read/write by root. Ideally we would make them group read/write like
other devices so that local users can use them without becoming root.

Signed-off-by: Sean Young <sean@mess.org>
---
 kernel/bpf/syscall.c | 1 -
 1 file changed, 1 deletion(-)

v2: improved commit message

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6d575505f89c..822ebc742a6a 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2463,7 +2463,6 @@ static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
 	case BPF_PROG_TYPE_SK_SKB:
 	case BPF_PROG_TYPE_SK_MSG:
-	case BPF_PROG_TYPE_LIRC_MODE2:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SOCK:
-- 
2.39.2

