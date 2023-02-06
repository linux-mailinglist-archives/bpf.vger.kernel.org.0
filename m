Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7DBA68BB7D
	for <lists+bpf@lfdr.de>; Mon,  6 Feb 2023 12:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBFL2O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 6 Feb 2023 06:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjBFL2N (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 6 Feb 2023 06:28:13 -0500
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540F518162;
        Mon,  6 Feb 2023 03:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1675682882;
        bh=m8lE4c/d0lvFPxY+CJ5u1aKGsJRsL83fBiMpukDEoQs=;
        h=From:To:Cc:Subject:Date;
        b=OeTA8scCOayel03cSxS8hrqzqH+OpxuHnq17tUPvBZn//gadZkNdp/cpyxuDPPF8m
         tk/lzsndZCZFA7nGk6Yn1im85cvXBzy2rncNG+lUeGu01lTDFio8emQtMw40ImYPsQ
         SLx6Ys6xecGD/kd6tSct3nxOMyLvgMCBnSPd1LyE=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc1-0.qq.com (NewEsmtp) with SMTP
        id 6FAA900C; Mon, 06 Feb 2023 19:27:58 +0800
X-QQ-mid: xmsmtpt1675682878t3f71k036
Message-ID: <tencent_9E0636426959DE97692A50AF79A3D9888B08@qq.com>
X-QQ-XMAILINFO: MOZWoti2yOjRjo6wOkCbZUP9njBujRx4QFk19T5afRKTAYFz+sO/9SegPTNRLO
         vCg9XniA80NDoMpF6yV0bJEZTmBg70O/oppDr768J5tdnPyujlfxI4nrFW2j8CmkZleFLjql7cNo
         I1m/lPug4nCUUbMSZ0WuOBeaAE3+38//PVR5ZYrCnTbo0NDfLBTGzlWOrs2vcCPPcU+8K639s59P
         qrNLDsyVef95fo0wiv+vWTs6ycc5zCw2Vx5GYH8i0DAa6/eCE8ldRi6Z8Y6zLaOFXwVRtasIhuJO
         JzENlwDseFpvJQypCqt8Z7JyigKqriKJiOXAXcNsiNfm8T77QvbagirHYHP4MTZi5TtqSDOh8JwD
         agH2R0RUx5aaNj5mkLqvpNkfo+IGyPPF4msL6YgvogRiIrXe29ZA3uruuOHlihjghDIwJc/qZ7bG
         ToHK4FQzcGxRe1SvDM9bsi9g/dABhBb8+wyftOWwJnS50wwXgJnRafd6MKgecitv4k67ahv2bAGi
         EZlH3t4zPGkZd8jBuhoZj51cnWboSWaHWjLHP76Zlj7i4+4YsFBTkwAxTWAXQVVCpAvIe/CTAPx9
         qAr6wp3muKQAsso3LB0F7Sra18bOmLzKJ3G8fVig8gus32Uc3Z76sWETWsAns0vr3anCMzPu1Cq/
         5LW0ol30Wfof82qJVLvM4sgxgyMfgFsqBB2RtrKiBBMfVzcZcs1HiND/dAra0b/nAlyZBsXLAD5j
         cLtGotImv0G1Qg4ewtCLf30Z/xNr/yU1zmkI48Yg/43DmQtR+JUYNuL7+nMzMav1cp+Vp+chJ0MI
         aKuPRc0e0m9oh68KTRFusHqniUj/6tEDKj9kYwWEhsWYI25oLSFrMwsHU1DqRH1o6SjdaG5MGMLF
         iPGBZpLT+rBKP3ntQ7x6BI3kNutr0CxRxr77hBN/TNkgiv6kuESAWOHR9EYI5n0fcscoWc6j3LMs
         xYYDLkLNW4I5Oymv8TEgiu+BMsjAoBPAkoHQHamiKKm7wiJmL37A==
From:   Rong Tao <rtoax@foxmail.com>
To:     ast@kernel.org
Cc:     Rong Tao <rongtao@cestc.cn>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and
        Tools)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH bpf-next] samples: bpf: Add macro SYSCALL() for aarch64
Date:   Mon,  6 Feb 2023 19:27:57 +0800
X-OQ-MSGID: <20230206112757.18550-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Rong Tao <rongtao@cestc.cn>

kernel arm64/kernel/sys.c macro __SYSCALL() adds a prefix __arm64_, we
should support it for aarch64. The following is the output of the bpftrace
script:

    $ sudo bpftrace -l | grep sys_write
    ...
    kprobe:__arm64_sys_write
    kprobe:__arm64_sys_writev
    ...

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 samples/bpf/trace_common.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/bpf/trace_common.h b/samples/bpf/trace_common.h
index 8cb5400aed1f..fafc699af0a3 100644
--- a/samples/bpf/trace_common.h
+++ b/samples/bpf/trace_common.h
@@ -6,6 +6,8 @@
 #define SYSCALL(SYS) "__x64_" __stringify(SYS)
 #elif defined(__s390x__)
 #define SYSCALL(SYS) "__s390x_" __stringify(SYS)
+#elif defined(__aarch64__)
+#define SYSCALL(SYS) "__arm64_" __stringify(SYS)
 #else
 #define SYSCALL(SYS)  __stringify(SYS)
 #endif
-- 
2.39.1

