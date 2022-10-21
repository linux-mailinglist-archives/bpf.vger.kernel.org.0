Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F79D608088
	for <lists+bpf@lfdr.de>; Fri, 21 Oct 2022 23:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJUVHu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiJUVHr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 17:07:47 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DB472A389E
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:07:46 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id fw14so3448492pjb.3
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 14:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K6Zpojz0feLMZOeQeP0g59JppFIP23gOWz8BjgwVmK4=;
        b=HQaBDBpAieJdxxwGRx128yrDMWayiULJ9hxUvpMbkURAX5nrs5FYgL/NM+AJtLRfKd
         wzvuyjT16HGKWjyU6DWuZrcyFrTunpvby/bOTook2cAh8CNwcjJk82UlOsmBL6lhFC6g
         gbO4CoqOrV77+BPxP81IU5k33JrxzkCtazKixtHRRo0kzE41YaBjCNnwZGc5lQ417ir+
         Lu3DIFiu9H81dCFd6+ZZZ39dWVb0XsFtye7SF2WhiyasTxGuC0ifi8ldBh8qfM6n5b0p
         /I+QuYZrLuRD8mPtY23of7fJF76AdpZ2H3r2I2e/seiLbAfIl4mSitQRpT1riqcR8i4I
         e6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6Zpojz0feLMZOeQeP0g59JppFIP23gOWz8BjgwVmK4=;
        b=a5WhCHnovjMOg5JuLAT9RIKnc72Cp0jJ2j/1KRjxoSP03mjRKZJvwHeaAFOYbziAfb
         pxM4o8c8gYg0zY1FMEn58CONGVgrKROrR0VOnMSqo8vLxzvHGAt1sXoZktUawlWA/dbx
         1+LiQ58k+n6OQz/LwR5adr3Ql3FJFOSQ79V3AeGsW6j92yDLOKamG9VJ8Jl9NwgE2nWH
         B3nC+268mAhFuUHGhYn+V48r8dGT64qujvF7rVpz6OFEDvnMwVn6d9n3e+pIJ03ohUCs
         2eJgETqoWzSWkGBOWZugyUoB7QNdc4FedT4/ylnPvv7jPtroIMYS2w4HBd8wBQxKXljT
         ZPIA==
X-Gm-Message-State: ACrzQf3pHGM5zkrLojvwT+XS4JqMNJgA+q6QaDjSvY3rxDyh5Zn0posu
        /+8DDLU1AcdKFypYFGksxaA=
X-Google-Smtp-Source: AMsMyM76hddSDTuEFBGKPvTyOXY1mua2HtMKj3kQ6eE1JT2ktUucIeE4bI2WkahrFR1gKdRlfgLgPQ==
X-Received: by 2002:a17:902:d491:b0:185:499d:cc04 with SMTP id c17-20020a170902d49100b00185499dcc04mr20730399plg.22.1666386466076;
        Fri, 21 Oct 2022 14:07:46 -0700 (PDT)
Received: from localhost (fwdproxy-prn-119.fbsv.net. [2a03:2880:ff:77::face:b00c])
        by smtp.gmail.com with ESMTPSA id n11-20020a170903404b00b0017849a2b56asm5333886pla.46.2022.10.21.14.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 14:07:45 -0700 (PDT)
From:   Manu Bretelle <chantr4@gmail.com>
To:     chantr4@gmail.com, bpf@vger.kernel.org, andrii@kernel.org,
        mykolal@fb.com, daniel@iogearbox.net, martin.lau@linux.dev,
        yhs@fb.com
Subject: [PATCH bpf-next 3/4] selftests/bpf: Update vmtests.sh to support aarch64
Date:   Fri, 21 Oct 2022 14:07:00 -0700
Message-Id: <20221021210701.728135-4-chantr4@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221021210701.728135-1-chantr4@gmail.com>
References: <20221021210701.728135-1-chantr4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add handling of aarch64 when setting QEMU options and provide the right
path to aarch64 kernel image.

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/vmtest.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
index a29aa05ebb3e..316a56d680f2 100755
--- a/tools/testing/selftests/bpf/vmtest.sh
+++ b/tools/testing/selftests/bpf/vmtest.sh
@@ -21,6 +21,12 @@ x86_64)
 	QEMU_FLAGS=(-cpu host -smp 8)
 	BZIMAGE="arch/x86/boot/bzImage"
 	;;
+aarch64)
+	QEMU_BINARY=qemu-system-aarch64
+	QEMU_CONSOLE="ttyAMA0,115200"
+	QEMU_FLAGS=(-M virt,gic-version=3 -cpu host -smp 8)
+	BZIMAGE="arch/arm64/boot/Image"
+	;;
 *)
 	echo "Unsupported architecture"
 	exit 1
-- 
2.30.2

