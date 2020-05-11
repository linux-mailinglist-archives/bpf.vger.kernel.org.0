Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248161CE328
	for <lists+bpf@lfdr.de>; Mon, 11 May 2020 20:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731288AbgEKSwv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 May 2020 14:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731278AbgEKSwr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 May 2020 14:52:47 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE9DC05BD09
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 11:52:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id n5so5640198wmd.0
        for <bpf@vger.kernel.org>; Mon, 11 May 2020 11:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8DCoKl1/gaqXVRh80rwnARoKd5SOhiqEFIXtMsss+EA=;
        b=FlFimMQ4dwBCND13Ajh3hU0NuJDBawAeO05LF7vpA8j3al3FVrgYlo4OnNFPEgqt5a
         rpwziA7n1HQTLEV4nuNK6IZTkwP7cVEh/1bPcBNeGrl85ubUduAmE3tc+SN0JMVlnEAL
         MywBnnypSDXU6gew0k2pgPRTz4nZ5oOU9XCVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8DCoKl1/gaqXVRh80rwnARoKd5SOhiqEFIXtMsss+EA=;
        b=S+Xn22YreOsM8dSFMp/hlSan41OFvx9iGKKhCRx06lBJIS4YIYWseAhB/FJLmMfB13
         d4gLGWQBVXum9aJJK/dMfxTia/77/BnOK2F0TkS71SMaKLAnZyqzsxW0vP5yGs/k6geh
         +j3MypCg3llZMt0gsEDf8dJI7htblisqKrQwUiZLVT2AfLsCVdbql25HHP4cEp5/lEqY
         SVcLwMDgmR98p55dN6TxjVwu6ReECMIeZamz2/Ap+XVl5jX31OGEyHL1Y0aDY+9YDxA6
         HUDLwj1wKzLNX5XeoOVBuyPZj7IE2gNGN1zaQGbXsogBJYWpTultTVSKSDFODoeKcV+b
         KDhg==
X-Gm-Message-State: AGi0PuZZALjSr9svFyBDySHGEEJuhVJGujYhe2RGaOKXq/tGluzuUFj/
        28pSuQ+Sd1eRqlUssK4OGFyy4w==
X-Google-Smtp-Source: APiQypJaYfNdpTusfsYnSZWh9YYqSd9y8kMv59m0ysOfP2XEySo1vBXmOHoY3SKwFAco7TEMB5a6iw==
X-Received: by 2002:a05:600c:2041:: with SMTP id p1mr2895620wmg.152.1589223165214;
        Mon, 11 May 2020 11:52:45 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id m3sm3344768wrn.96.2020.05.11.11.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 11:52:44 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     dccp@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Gerrit Renker <gerrit@erg.abdn.ac.uk>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v2 16/17] selftests/bpf: Rename test_sk_lookup_kern.c to test_ref_track_kern.c
Date:   Mon, 11 May 2020 20:52:17 +0200
Message-Id: <20200511185218.1422406-17-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.3
In-Reply-To: <20200511185218.1422406-1-jakub@cloudflare.com>
References: <20200511185218.1422406-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Name the BPF C file after the test case that uses it.

This frees up "test_sk_lookup" namespace for BPF sk_lookup program tests
introduced by the following patch.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/bpf/prog_tests/reference_tracking.c     | 2 +-
 .../bpf/progs/{test_sk_lookup_kern.c => test_ref_track_kern.c}  | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename tools/testing/selftests/bpf/progs/{test_sk_lookup_kern.c => test_ref_track_kern.c} (100%)

diff --git a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
index fc0d7f4f02cf..106ca8bb2a8f 100644
--- a/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
+++ b/tools/testing/selftests/bpf/prog_tests/reference_tracking.c
@@ -3,7 +3,7 @@
 
 void test_reference_tracking(void)
 {
-	const char *file = "test_sk_lookup_kern.o";
+	const char *file = "test_ref_track_kern.o";
 	const char *obj_name = "ref_track";
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
 		.object_name = obj_name,
diff --git a/tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c b/tools/testing/selftests/bpf/progs/test_ref_track_kern.c
similarity index 100%
rename from tools/testing/selftests/bpf/progs/test_sk_lookup_kern.c
rename to tools/testing/selftests/bpf/progs/test_ref_track_kern.c
-- 
2.25.3

