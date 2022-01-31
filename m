Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50CBA4A5205
	for <lists+bpf@lfdr.de>; Mon, 31 Jan 2022 23:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiAaWFn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 31 Jan 2022 17:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiAaWFm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 31 Jan 2022 17:05:42 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5A1C061714
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:42 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id n32so14054211pfv.11
        for <bpf@vger.kernel.org>; Mon, 31 Jan 2022 14:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YMeC4Hp3/UlZ5o1F0WtmLn15DBc41UEux4Lq6UGhsvg=;
        b=BeN2hpU22HNDAFn+FagJx2NO+qU+6LheXbxfOm/k/4FA2IVSuhqBn5J4nUiVNEe5Bi
         FhimjPWHMyISbo5nuwTFqQA77FhttmyWHM2dCd9ic3sNX6uF5rsYEo1ou14EDJZ0HUAy
         MhWFaEumMxyra1TaKNE/VDGoCU1W/VCJb1TEQrGwkOf1WLmmNbLzj8rKF5x9N+zYKxbc
         /5JpGCNEXECF2yPFsy8B/27a7QRroVBwpQGkBenFCo2WH52xYScjmL0g9bgQcgJlXFYB
         4VVmD3WxE+XC/kr06+zRXP01ipDeN9zZd/Hah+Y82KQH4Z3ilalGCLqmolOrrCCGaDXx
         X4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YMeC4Hp3/UlZ5o1F0WtmLn15DBc41UEux4Lq6UGhsvg=;
        b=dt4JMKZ6zSYY6DJqPr0HXSkoaXgN+hQYba94j+aABr6MmzSRSdpUcI1BTHPDFIdHjL
         PWd2hRwbX1BZGB9IT7UJGdEzeUZhl5Hm8DquMfnNWEygAs6rSJagn4U4DjP0V3Ncdg5G
         YG7tbiWAB3jKI2HUCEay8RYKJmS4yfcHiTzbWfhS9QTfkDzXToZR38aJEdVqNlxJaOMI
         dCXgjdOubjHIuySepKI1PrK6U4aDqBo8G5OHILlduaUKBOg8RmaOn3de+MdPr5CehkYV
         d0vu8xTBP+CM59D9Vuk2AZH6lp5kTILYPrdK5Z+pL8WfWtbkCP5JOn7OIvzMjgnFLnbq
         Khyw==
X-Gm-Message-State: AOAM530YygrwCAS/4GsF8XnSJFr3Yubyqi7Rh8Th57iKFxWBMX0rilQ5
        B658fzIXHL9BbRUDJfBlmOQ=
X-Google-Smtp-Source: ABdhPJxe47+yVtYKeQX0jhXhmw/nTdd3PXPU61364TyrsubeNjP1HU1GLySU1Z8xB3ws+sBaL60yfQ==
X-Received: by 2002:a63:85c6:: with SMTP id u189mr18132379pgd.437.1643666742312;
        Mon, 31 Jan 2022 14:05:42 -0800 (PST)
Received: from ast-mbp.thefacebook.com ([2620:10d:c090:400::5:78b6])
        by smtp.gmail.com with ESMTPSA id c26sm28440592pgb.53.2022.01.31.14.05.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:05:42 -0800 (PST)
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     davem@davemloft.net
Cc:     daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH bpf-next 4/7] bpf: Remove unnecessary setrlimit from bpf preload.
Date:   Mon, 31 Jan 2022 14:05:25 -0800
Message-Id: <20220131220528.98088-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
References: <20220131220528.98088-1-alexei.starovoitov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Alexei Starovoitov <ast@kernel.org>

BPF programs and maps are memcg accounted. setrlimit is obsolete.
Remove its use from bpf preload.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/preload/iterators/iterators.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/bpf/preload/iterators/iterators.c b/kernel/bpf/preload/iterators/iterators.c
index 5d872a705470..2ec85fc6984f 100644
--- a/kernel/bpf/preload/iterators/iterators.c
+++ b/kernel/bpf/preload/iterators/iterators.c
@@ -37,7 +37,6 @@ static int send_link_to_kernel(struct bpf_link *link, const char *link_name)
 
 int main(int argc, char **argv)
 {
-	struct rlimit rlim = { RLIM_INFINITY, RLIM_INFINITY };
 	struct iterators_bpf *skel;
 	int err, magic;
 	int debug_fd;
@@ -55,7 +54,6 @@ int main(int argc, char **argv)
 		printf("bad start magic %d\n", magic);
 		return 1;
 	}
-	setrlimit(RLIMIT_MEMLOCK, &rlim);
 	/* libbpf opens BPF object and loads it into the kernel */
 	skel = iterators_bpf__open_and_load();
 	if (!skel) {
-- 
2.30.2

