Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA5D49FEAF
	for <lists+bpf@lfdr.de>; Fri, 28 Jan 2022 18:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350436AbiA1RJd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Jan 2022 12:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245716AbiA1RJd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Jan 2022 12:09:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0F4C061714
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 09:09:33 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso11464443pjv.1
        for <bpf@vger.kernel.org>; Fri, 28 Jan 2022 09:09:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MLcGg9/yYVQbc6je5hVkbZbc+AVd79IU46oLBdzC1+U=;
        b=AW/owflWMyoDtCbmH6+nZb3ZBlga+vxU4sQZQAGL+Pw+t3uFk0XuqmuwmEuOcRDKsQ
         N3TM07al1CkcdhpOZptrzq9p8HGrcJScr9bn7YdBHvfmRtYx3FCW5v6LqT8xeK6VUwt2
         shQaGOc2BpmuJNTppjkos5MS++zXaVm2gzQluQraV1PXjljPgDXgbGNR7eeRZBxBCHcZ
         N1XJzgJZOCKbFpLl3VV3T3C/n/pBRx9++vebs30k4b8QrZK5lGWgiticf1Nhbclhf51t
         mwKPJ0B6n0uoBK8+wEvC9Rrzy8E4/grbyZHWFZKF1YINRLxsYvVChBirO9TzimQvA57J
         yTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=MLcGg9/yYVQbc6je5hVkbZbc+AVd79IU46oLBdzC1+U=;
        b=5pfch6+IU4LWdH7ySKPjrXBaA4W2CwWs7QKQSoNOqu9L6U7ds/Neept5Aw4PHjxBs4
         lUIEI2NH2fhes8GJgP0ztBIxasOaNV6NuqHN4eIykMov4CZsprcBNQz8pSESFUF8EEu/
         PXDLLSuln9N/ax6ULfiyaxc42vB78u+/tN4PzpcRoNu30Cy5WufgAkrbiwoz1ImB5d+7
         LdhOy+p//phs+tyikGbVIzAkKGMoBO5USGmS9gWuR8wNEEY0N2W7qYjxLHhXC9EnadYx
         UTqorbgNyPdDcCWu982NEOEniKo13KQaHOzHtZksu/klkjBHi5TJTXjLX38ysSR+TDlv
         9JAw==
X-Gm-Message-State: AOAM530wpK93KbeNx2i4gX9GAykxLEB5gw2loLqys8gdHZ/RVjqTcNNI
        LZfoH2amNMHmrcNJKeM4EkXAUwmEILU=
X-Google-Smtp-Source: ABdhPJzLUpcrwYFZrXdTwEZzD71XO6Z78Gu3W47xHUzVkNKCx+BCem8+WUWv46F2X+HVrnbUX5LJRA==
X-Received: by 2002:a17:902:6e08:: with SMTP id u8mr9669807plk.157.1643389772745;
        Fri, 28 Jan 2022 09:09:32 -0800 (PST)
Received: from ktada-Stealth-15M-A11UEK.. ([240d:1a:2e0:8a00:c23b:8d03:ce5b:7f4e])
        by smtp.gmail.com with ESMTPSA id f9sm21927334pgf.94.2022.01.28.09.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:09:32 -0800 (PST)
Sender: KENTA TADA <kenta.tada.s@gmail.com>
From:   Kenta Tada <Kenta.Tada@sony.com>
To:     bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org,
        daniel@iogearbox.net, yhs@fb.com
Cc:     kennyyu@fb.com, Kenta Tada <Kenta.Tada@sony.com>
Subject: [PATCH bpf-next] bpf: make bpf_copy_from_user_task() gpl only
Date:   Sat, 29 Jan 2022 02:09:06 +0900
Message-Id: <20220128170906.21154-1-Kenta.Tada@sony.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

access_process_vm() is exported by EXPORT_SYMBOL_GPL().

Signed-off-by: Kenta Tada <Kenta.Tada@sony.com>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index ed2780b76cc1..4e5969fde0b3 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -695,7 +695,7 @@ BPF_CALL_5(bpf_copy_from_user_task, void *, dst, u32, size,
 
 const struct bpf_func_proto bpf_copy_from_user_task_proto = {
 	.func		= bpf_copy_from_user_task,
-	.gpl_only	= false,
+	.gpl_only	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_UNINIT_MEM,
 	.arg2_type	= ARG_CONST_SIZE_OR_ZERO,
-- 
2.32.0

