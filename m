Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D696688DDB
	for <lists+bpf@lfdr.de>; Fri,  3 Feb 2023 04:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjBCDSk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 22:18:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232283AbjBCDSj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 22:18:39 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C3654545;
        Thu,  2 Feb 2023 19:18:38 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id m13so3962714plx.13;
        Thu, 02 Feb 2023 19:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p1ZRhY1eH/18xy31juzI6AkvdowOs5cnS48xbXSK4K0=;
        b=IxH9dsQo0UYNYbzfyy0IXjkOnl7SKRobs7spNqCbsnIi2RR2KJqd4pvDMtDtgdh+Wd
         cDPUGlyLrVBUhUEs+04LXD34ZYH21EUD8xMqqEcdtf6kMsBcOn3wXzAQaWxaLJw2gLVH
         r03Pv4WRuelKwlZvt83D148LVT79iSUDnt3j99TX/pnCQ9epIC3KkTJTrO9omgimy6YD
         IB2DnsihTUinV163GaWUnfZAxc2b0Q5kTcmOu8NatvqZVBGBgOOpW4XnupkRyHLgC6Ai
         40n8QRyixYxoLFAB/KvJk6h+tqHd8NEjRV7PvXdMAuuyalWFHmpHn1zmZ1SeTFzVEITj
         NcDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1ZRhY1eH/18xy31juzI6AkvdowOs5cnS48xbXSK4K0=;
        b=igs0kUCHp/QB+zohV2NwO4uxLMw8O9RwcMQwZX78qKvaOHDnfxgO9QF2eidH7wYv1Y
         200C6iJTc3sClOKQr3J7okTr3RKErQ3pMyPInSj45lYTIDdX7LCDyj26w1mspVL873az
         Pjb2cn+3hel6n8RgkL8hlL6jZ0wvKwpxbFFDFBCA9NtprV9/BJfjqDi+ESek6knyJ+TW
         gInJocCFFaRwUy9mt9yTCQb9Cvrusn82EUN8olPxTLGTo0GWGtWZUJVj+UuKvsG68Ooa
         srmUm/W7uafTXwpFettviGydQ0VEa7r2BkdcD2L87H5t10B3+YVQD2lBUAnAou6I6gg2
         RFHg==
X-Gm-Message-State: AO0yUKXaqHb1JfaLj2Q0+tVTJhjDX6sDbKiKPN+cbe2f6lS7CJLASMl7
        UryQgSVTldWEZNns2dF+6K0=
X-Google-Smtp-Source: AK7set8IJZN0aIG27aYQtNaIL5/7eeF1kaRmE0qsq2d3Jc5wer2fUb8vMTEJbsXvwH3o6sQeNh1T4g==
X-Received: by 2002:a17:902:ec8c:b0:191:3098:8b with SMTP id x12-20020a170902ec8c00b001913098008bmr3809811plg.58.1675394317600;
        Thu, 02 Feb 2023 19:18:37 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.16])
        by smtp.gmail.com with ESMTPSA id a9-20020a170902ee8900b001899c2a0ae0sm416009pld.40.2023.02.02.19.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 19:18:37 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: imagedong@tencent.com
To:     andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
Subject: [PATCH bpf-next 0/2] libbpf: allow users to set kprobe/uprobe attach mode
Date:   Fri,  3 Feb 2023 11:17:40 +0800
Message-Id: <20230203031742.1730761-1-imagedong@tencent.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Menglong Dong <imagedong@tencent.com>

By default, libbpf will attach the kprobe/uprobe eBPF program in the
latest mode that supported by kernel. In this series, we add the support
to let users manually attach kprobe/uprobe in legacy or perf mode in the
1th patch.

And in the 2th patch, we add the selftests for it.

*** BLURB HERE ***

Menglong Dong (2):
  libbpf: add support to set kprobe/uprobe attach mode
  selftests/bpf: add test for legacy/perf kprobe/uprobe attach mode

 tools/lib/bpf/libbpf.c                        | 30 ++++++++-
 tools/lib/bpf/libbpf.h                        | 19 ++++++
 .../selftests/bpf/prog_tests/attach_probe.c   | 61 ++++++++++++++++++-
 .../selftests/bpf/progs/test_attach_probe.c   | 32 ++++++++++
 4 files changed, 140 insertions(+), 2 deletions(-)

-- 
2.39.0

