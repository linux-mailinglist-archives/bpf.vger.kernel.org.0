Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA7554E4253
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 15:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235246AbiCVOwR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Mar 2022 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbiCVOwP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Mar 2022 10:52:15 -0400
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906C28594D
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 07:50:47 -0700 (PDT)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-de3f2a19c8so1911390fac.1
        for <bpf@vger.kernel.org>; Tue, 22 Mar 2022 07:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mdaverde-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYYstwn1s64pcwK5LvShx5Ry1kTzUTbuHMZkOFyWOz8=;
        b=ZjsT4c7xexfSKGND54aezvA9skGMTBZlXA87WTG7NJQRdzZluD+OHzmiuaoXloyRtp
         hLl9YFuYKFrp64iAHtzj6qtVcUyqAzCWzhCYS0RNjor9O+5RhIX1Ls4m2z9lcMwQXg6t
         PqzmhwSWnUKXponrH2tpBf+unNy16PA2JZD/8h6MjI3mnQEd68uqXqCv3LFMmIyTpw7c
         09ROx7ObSUyR5UgEnUDu42GN3RGjLuAmlW9xyGx9hyv3vAPNW+Tdv1rwaZKhveF89WCC
         +SXHw1DJUvAE12r7QEo/tQwnqS0Adq2yK6AKnB/oC5R0HGIE6FTq6uNZL5cAZFnAtTBp
         8hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XYYstwn1s64pcwK5LvShx5Ry1kTzUTbuHMZkOFyWOz8=;
        b=aYc99bIjcSfU4e8c0LV7y6Q5yBg74IMMwFePgy7nokWrnmX12nuFPu4UMKQ2R8OzQX
         3sFXp1MGrJVlI2G5GOgNbe2uuwrkRd5EBQqeHdczjMUcHW/ttLOYxs1FUua7OLGlbSai
         MdJD600j6KcWJ6zP0rLIB+l0+6BRiU9GDCERln2NQ+En9uKth4N654iH7wBHBrfHYpHX
         laLOZah/ZRrVVBZcmGj9fpeCCwqZRFP9SpLB4V95X16dx7iQhMil+ZguZAlIiUNfA6sA
         9dysKcXTHGVobHD7rlHoQgYbL6iYtPAJMKBEOlEMtE4zMHWEArxKTOe/1ZIMBNVVFzfn
         4s1A==
X-Gm-Message-State: AOAM533d8eybKMfVbJcBwmzBk7Ikzkwiq82xWdhHq8Mt3hCwRT/G0xmK
        29d1aYAO5eTFgsmmq50uduQgHg==
X-Google-Smtp-Source: ABdhPJyRj33zOTBSk65QR+/BBFJji9LHPpSAJ+IGbEKBruNYqJT7qSmMhvc8BVN+Rm/R5EY3mIagiA==
X-Received: by 2002:a05:6870:b303:b0:d6:f4d1:990d with SMTP id a3-20020a056870b30300b000d6f4d1990dmr1770423oao.53.1647960646595;
        Tue, 22 Mar 2022 07:50:46 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:1d10:5830:90b:eeed:e704:d511])
        by smtp.gmail.com with ESMTPSA id a15-20020a056870000f00b000de1ab6364dsm2223135oaa.49.2022.03.22.07.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 07:50:46 -0700 (PDT)
From:   Milan Landaverde <milan@mdaverde.com>
Cc:     milan@mdaverde.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Paul Chaignon <paul@isovalent.com>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@corigine.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next] bpf/bpftool: add unprivileged_bpf_disabled check against value of 2
Date:   Tue, 22 Mar 2022 10:49:45 -0400
Message-Id: <20220322145012.1315376-1-milan@mdaverde.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In [1], we added a kconfig knob that can set
/proc/sys/kernel/unprivileged_bpf_disabled to 2

We now check against this value in bpftool feature probe

[1] https://lore.kernel.org/bpf/74ec548079189e4e4dffaeb42b8987bb3c852eee.1620765074.git.daniel@iogearbox.net

Signed-off-by: Milan Landaverde <milan@mdaverde.com>
---
 tools/bpf/bpftool/feature.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/feature.c b/tools/bpf/bpftool/feature.c
index c2f43a5d38e0..290998c82de1 100644
--- a/tools/bpf/bpftool/feature.c
+++ b/tools/bpf/bpftool/feature.c
@@ -207,7 +207,10 @@ static void probe_unprivileged_disabled(void)
 			printf("bpf() syscall for unprivileged users is enabled\n");
 			break;
 		case 1:
-			printf("bpf() syscall restricted to privileged users\n");
+			printf("bpf() syscall restricted to privileged users (without recovery)\n");
+			break;
+		case 2:
+			printf("bpf() syscall restricted to privileged users (admin can change)\n");
 			break;
 		case -1:
 			printf("Unable to retrieve required privileges for bpf() syscall\n");
-- 
2.32.0

