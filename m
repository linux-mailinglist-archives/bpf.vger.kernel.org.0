Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0E6DE00B
	for <lists+bpf@lfdr.de>; Tue, 11 Apr 2023 17:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjDKPxc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Apr 2023 11:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjDKPxS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Apr 2023 11:53:18 -0400
X-Greylist: delayed 488 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Apr 2023 08:53:04 PDT
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A3D55AF
        for <bpf@vger.kernel.org>; Tue, 11 Apr 2023 08:53:03 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id DB2D710006C; Tue, 11 Apr 2023 16:44:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1681227888; bh=gJjMJGahaI4tDqMGSnFJtVV+yhLoA/zGWC6OQiONgNs=;
        h=Date:From:To:Subject:From;
        b=itG1vCnoNZM1cPwHzAQ/prPhh0o9FtCqjcBroB54pY88YIaACXthSNmc4aAlzDsbn
         mKLKdrbFbrmV7mOLUGPp5dqIXThEksK0JVCfaaewRSpFfn9v999gV7zjBnFPqMBGC6
         /9EsJRam85qWDfBTmFgMTtE4HUaUuysWKI4DopmhYFJfh08vdFsWtFXej8W6PjfEqL
         aXP37EerC23NVpAUbc3fTLGXPYeunMiwjDqZkc73AKYyIbeGVI63F0Xc45Ril37gRI
         9T78F+525ATztbGjyD3qnraZe9zhj/xXtALX9CixGcgryzX0oBgbrgM5tPxiMiZPvV
         pcJUiPK2a8GfA==
Date:   Tue, 11 Apr 2023 16:44:48 +0100
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
Subject: [PATCH] bpf: lirc program type should not require SYS_CAP_ADMIN
Message-ID: <ZDWAcN6wfeXzipHz@gofer.mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make it possible to load lirc program type with just CAP_BPF.

Signed-off-by: Sean Young <sean@mess.org>
---
 kernel/bpf/syscall.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index adc83cb82f37..19d9265270b3 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2439,7 +2439,6 @@ static bool is_net_admin_prog_type(enum bpf_prog_type prog_type)
 	case BPF_PROG_TYPE_LWT_SEG6LOCAL:
 	case BPF_PROG_TYPE_SK_SKB:
 	case BPF_PROG_TYPE_SK_MSG:
-	case BPF_PROG_TYPE_LIRC_MODE2:
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SOCK:
-- 
2.39.2

