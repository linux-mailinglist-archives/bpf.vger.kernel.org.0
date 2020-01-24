Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA4D41483DE
	for <lists+bpf@lfdr.de>; Fri, 24 Jan 2020 12:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404134AbgAXL36 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jan 2020 06:29:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52230 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391847AbgAXL36 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jan 2020 06:29:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so1345097wmc.2
        for <bpf@vger.kernel.org>; Fri, 24 Jan 2020 03:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=smQgb7OTV4+v464Eh5cc5iALcZWmuJ7KE4TsJ4XSwN0=;
        b=iljVGTV1W2UYOROZJjXL2BxExKTYltjH3RaXZgCT13fFOm+Nx1p1W/EGg/MHPiN123
         Y/fZoxx0KKrnFOrhiFtN23VntLi2zzgiJv8qGtINNs6LfVaD6TObjxAWKjjZjHKldcjL
         6oghRAaotdWG00W3x+PMzNjFhFogTKlxzTHpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=smQgb7OTV4+v464Eh5cc5iALcZWmuJ7KE4TsJ4XSwN0=;
        b=J6aqmRfHuPnlL+xL2VyAYCNd4iT3Fj9BjZeoIzC9dzRyG537GA5z65HnUyGe1kNsHb
         z0bs3sWAzefiKL62hqaFi0+CR1/mUNrI9/Iw48lZEyVPHo9eiWIi6ohxEhUrsI+4qgTf
         l6WfR81B4mwGxJiHLyK8hkakk3YShxBV+iB+fsucWayMk6AjcJALUaTpf+UqAIxzJAFU
         qGOiik2NGfFybJO6zXLZ244n4+DDaSSBdr+EgI37YlEzW5UjpBdEjakVG+ROHSp/lCJv
         UE0ejjYjoDK/+G7/z9FhteWHOsPcOeKLGAm4raSS/xkC1Wsm6JFhoS6TbOgIsJB6tlP5
         BVTw==
X-Gm-Message-State: APjAAAUYoxGpZ94Bm59ErRFlbESirALLr+ooLMiaBGOV7O2usCCNhhcn
        Atm4ZnKkV3OgW/d0eeopjJLUOg==
X-Google-Smtp-Source: APXvYqzBfQGrlE8ATwQ4rMxw2LQnHJD+IP5+yBioiZsrDvhY5hZKhMjpzp6Bd8H8znTSi5coAdlQTg==
X-Received: by 2002:a7b:cb91:: with SMTP id m17mr2777626wmi.146.1579865395785;
        Fri, 24 Jan 2020 03:29:55 -0800 (PST)
Received: from antares.lan (3.a.c.b.c.e.9.a.8.e.c.d.e.4.1.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:614e:dce8:a9ec:bca3])
        by smtp.gmail.com with ESMTPSA id n189sm6808688wme.33.2020.01.24.03.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 03:29:55 -0800 (PST)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>
Cc:     Lorenz Bauer <lmb@cloudflare.com>, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 3/4] selftests: bpf: make reuseport test output more legible
Date:   Fri, 24 Jan 2020 11:27:53 +0000
Message-Id: <20200124112754.19664-4-lmb@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124112754.19664-1-lmb@cloudflare.com>
References: <20200123165934.9584-1-lmb@cloudflare.com>
 <20200124112754.19664-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Include the name of the mismatching result in human readable format
when reporting an error. The new output looks like the following:

  unexpected result
   result: [1, 0, 0, 0, 0, 0]
  expected: [0, 0, 0, 0, 0, 0]
  mismatch on DROP_ERR_INNER_MAP (bpf_prog_linum:153)
  check_results:FAIL:382

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 .../bpf/prog_tests/select_reuseport.c         | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
index 2c37ae7dc214..e7e56929751c 100644
--- a/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
+++ b/tools/testing/selftests/bpf/prog_tests/select_reuseport.c
@@ -316,6 +316,26 @@ static void check_data(int type, sa_family_t family, const struct cmd *cmd,
 		       expected.len, result.len, get_linum());
 }
 
+static const char *result_to_str(enum result res)
+{
+	switch (res) {
+	case DROP_ERR_INNER_MAP:
+		return "DROP_ERR_INNER_MAP";
+	case DROP_ERR_SKB_DATA:
+		return "DROP_ERR_SKB_DATA";
+	case DROP_ERR_SK_SELECT_REUSEPORT:
+		return "DROP_ERR_SK_SELECT_REUSEPORT";
+	case DROP_MISC:
+		return "DROP_MISC";
+	case PASS:
+		return "PASS";
+	case PASS_ERR_SK_SELECT_REUSEPORT:
+		return "PASS_ERR_SK_SELECT_REUSEPORT";
+	default:
+		return "UNKNOWN";
+	}
+}
+
 static void check_results(void)
 {
 	__u32 results[NR_RESULTS];
@@ -351,10 +371,10 @@ static void check_results(void)
 		printf(", %u", expected_results[i]);
 	printf("]\n");
 
-	RET_IF(expected_results[broken] != results[broken],
-	       "unexpected result",
-	       "expected_results[%u] != results[%u] bpf_prog_linum:%ld\n",
-	       broken, broken, get_linum());
+	printf("mismatch on %s (bpf_prog_linum:%ld)\n", result_to_str(broken),
+	       get_linum());
+
+	CHECK_FAIL(true);
 }
 
 static int send_data(int type, sa_family_t family, void *data, size_t len,
-- 
2.20.1

