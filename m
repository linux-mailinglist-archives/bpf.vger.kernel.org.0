Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F364C1CBDB3
	for <lists+bpf@lfdr.de>; Sat,  9 May 2020 07:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725795AbgEIFU3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 May 2020 01:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgEIFU1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 May 2020 01:20:27 -0400
X-Greylist: delayed 1979 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 May 2020 22:20:27 PDT
Received: from omr2.cc.vt.edu (omr2.cc.ipv6.vt.edu [IPv6:2607:b400:92:8400:0:33:fb76:806e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C31CC061A0C
        for <bpf@vger.kernel.org>; Fri,  8 May 2020 22:20:27 -0700 (PDT)
Received: from mr4.cc.vt.edu (mr4.cc.vt.edu [IPv6:2607:b400:92:8300:0:7b:e2b1:6a29])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 0494lRab001204
        for <bpf@vger.kernel.org>; Sat, 9 May 2020 00:47:27 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 0494lMtc027586
        for <bpf@vger.kernel.org>; Sat, 9 May 2020 00:47:27 -0400
Received: by mail-qk1-f197.google.com with SMTP id 14so4332538qkv.16
        for <bpf@vger.kernel.org>; Fri, 08 May 2020 21:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=CieMS2rA989SLT5WdlqR3SNmJMU/gOjJ8XfYOw251Ak=;
        b=BNdRD6h1T+lLmOens0h+syQmR2Qm2loge/uIzpfS4RdCtuo1VlImfp5Z2AbdMC2VyW
         iDd7PtggQEPOOWx0+zfX8y4SXPpn+ldlTd4Y5M6AgR6uiwL8/0iWtRIfrMMAcz2t/cy0
         r+anIziX2nNXuiQlCjcsYuM1CO+L/5LQenRLcUQs0HYisMQSzm7nIoVOvrtND823mCl+
         dlW2byhUWcHk+DBLiWTTskw2Plstc/hPiLPV5R9lJIS6nD631peV4kYT0MB1EL3pG4KU
         4dL0cZZOfky+lEA6hy6SXOTVh9812Xs9gcZrjztKRVwyigw3Qv8GDDpz31KgH8PsP4+G
         9ttg==
X-Gm-Message-State: AGi0Puaxx2RULOLxdZ/aOBqTIxECjCUj0X3HAGVGrNQ6vNgCN48cdMwu
        SoO7Emz8uv9TqurxeH3XcNei6ft9xChKNmdgupDfxUZ3zHJcFuycpTBu7ylu3g2UwxABgCzO/bY
        jTigCDqv1k+VgdclJE6Ulwgg=
X-Received: by 2002:aed:2765:: with SMTP id n92mr6561188qtd.73.1588999642176;
        Fri, 08 May 2020 21:47:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypKrdwg9wFkSZEGyvIVNHrNxASjnM/WoZIv/+zUsBOK23ts64KQdieyMlQLlRE6tvAKySSZD6A==
X-Received: by 2002:aed:2765:: with SMTP id n92mr6561176qtd.73.1588999641925;
        Fri, 08 May 2020 21:47:21 -0700 (PDT)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d6sm2783247qkj.72.2020.05.08.21.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 21:47:20 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Masahiro Yamada <masahiroy@kernel.org>
cc:     Sam Ravnborg <sam@ravnborg.org>,
        "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] bpfilter: document build requirements for bpfilter_umh
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Sat, 09 May 2020 00:47:19 -0400
Message-ID: <131136.1588999639@turing-police>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It's not intuitively obvious that bpfilter_umh is a statically linked binary.
Mention the toolchain requirement in the Kconfig help, so people
have an easier time figuring out what's needed.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
index fed9290e3b41..0ec6c7958c20 100644
--- a/net/bpfilter/Kconfig
+++ b/net/bpfilter/Kconfig
@@ -13,4 +13,8 @@ config BPFILTER_UMH
 	default m
 	help
 	  This builds bpfilter kernel module with embedded user mode helper
+
+	  Note: your toolchain must support building static binaries, since
+	  rootfs isn't mounted at the time when __init functions are called
+	  and do_execv won't be able to find the elf interpreter.
 endif

