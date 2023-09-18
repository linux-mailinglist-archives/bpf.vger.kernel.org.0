Return-Path: <bpf+bounces-10316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E50187A4FB8
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:51:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7C1B281AEE
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6692A23755;
	Mon, 18 Sep 2023 16:51:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2D420B03
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 16:51:00 +0000 (UTC)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0065A3
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:50:58 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2ba1e9b1fa9so77281751fa.3
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695055857; x=1695660657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWLbZ1J0oeUlS0QBC3LOMF2rfKN6MrliiLEkPfiun10=;
        b=NdxCFkyWf209AvcZKs47dhp2N8HmVcsPShcp1bPtgGCygBoWcrXkMTdcl7Ud3HIPfQ
         rdKGGfszU/8pNkls/iSGxDGdhaqcj6IMfMiwdsmSnH8eb9+EriexLeauwRvWs55F1jW7
         q6th4VpMUtLAfZXvINKL1awRf/a8e4zrf/lrU+AR9JJPIodslw9f5fzzkNfPvuLJTlqV
         +rpFZB4LT2d8gT8aFUKJPf5OG1Z0U9SjWBmun2pMHZaZ5v7FFm4QgMQOvYRPwcxt/0Zl
         age+YFzQOoUVHDWNuuC7HhAN6lXGpvacV9/qyE1b86YG68TOgXP8XeRsM6QZmFGAi36D
         ISLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695055857; x=1695660657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWLbZ1J0oeUlS0QBC3LOMF2rfKN6MrliiLEkPfiun10=;
        b=LxYt2zrQnInpGeHyxfLQsf1o7/BN9hjn4vDwn+gOnF+lw6VwmMDZ0ENzkogb1Bhbxy
         MkTbLWq6+BcyYwj0fXqNkk4MtHR4SCjfLZD7ODGdP7/mvWXHz7GyWL5AtFDxC5TRmRQ2
         4O433rWW49WVlHHgbX3TQHYbB4+SPmlvx981qWAZK4sXXasVsJXDIhkggdBN4ak8KtNZ
         YBw6icFRLCsxEhdzHao9t9WD398neMQrtQXXV5g6/jB/coTJysPaUvZ0PhQtPZ0XddVN
         JNSM9h43fTvdZwSLNOEY242uDEJTJeoPvIty9O+uxeJfTLS7BDA2Ynj8j7Wvn2AzUZYY
         s3zA==
X-Gm-Message-State: AOJu0YzdLHzpN8cWDjPQgtljN0lGe2dCop/NTpZ0v3QSNIGjQiW+XfKJ
	30o/TYhD9Yk81APRjhslAWG8eQaO9c/4Ww==
X-Google-Smtp-Source: AGHT+IG1ZOQV5T09QxeURfYnxY46S6+4ssVGNP19+FYPoXnTwf1oPUWch8iqyt+5pmzjwzhNFL57EA==
X-Received: by 2002:ac2:5dd0:0:b0:500:75e5:a2f0 with SMTP id x16-20020ac25dd0000000b0050075e5a2f0mr7702260lfq.51.1695047957533;
        Mon, 18 Sep 2023 07:39:17 -0700 (PDT)
Received: from localhost (vpn-253-124.epfl.ch. [128.179.253.124])
        by smtp.gmail.com with ESMTPSA id t16-20020a508d50000000b0053112d6a40esm1699777edt.82.2023.09.18.07.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 07:39:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v1 1/3] selftests/bpf: Print log buffer for exceptions test only on failure
Date: Mon, 18 Sep 2023 16:39:12 +0200
Message-ID: <20230918143914.292526-2-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918143914.292526-1-memxor@gmail.com>
References: <20230918143914.292526-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440; i=memxor@gmail.com; h=from:subject; bh=oHvLk0ZHhNY+L7Ri8crRqUByZW+W4S/TRihF1kQbWZ4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlCGDZ68qPVyIcWw95cm+Qf50mRMtCOeMoIpeaU jCwVNvFr96JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQhg2QAKCRBM4MiGSL8R yocEEAC6nF1AMBGImozCUvZkDtGTC58p07gCI6dNDJ4ihlviNahJdFLeJ7FMRg4tG6DiALrHw9T w00P1S2ZcCjwbNQLO04jEhVNIBVqBbH6spYtihXM01weKo9mGXEj71cyJNmY6Tgf6h5qXJkY7hM 5S3QKee0ZXa4TDdoczkRIKAf7PQXmmQ5t/uUtmoGU8t1zxnzaWhUmIa+pn/ang1it4cO/HmTYut d02EgIRw4scWLOKYFRds/mr6v8f7QaRCnR4pxlPM37JXRpTEDfMdsl1uPyW07toO1ysiHRkbHm7 6+s4LJ+cij1rPvSoKHtHqodnSriDGamuybLsseELUsw62SsdOU54XtqBG7vFqokDajjAXPTgfI4 Kmd2yhYULU2+ISpzoNWtGXbjjbTrJf3oP59hY9+M3a/l1hCDu2WsWGNa0SKQIMTb8I7IHKb8x5U KM7UEEnEXcQnlz5GULMj6Q1u8rGL6R9kRCqUWbpneTiLVdMiybqxzq2KUTNLRWFJ+hsb/z4O/HD X9fFp2MQ+IViQXgIRUXARNQbiT2rjmzDmifyLdnqjBU3LZL8PIadyg0fPn7gepNEGK1IcGVa5rd yDgnLhcizpB+Vg2852hpK8IL3RRaaFRXYzokYjmQe+Y+VUPKzREzokyh8IhdzFZNzN/5y6qedZg nVuHPLwDQhxziUg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Alexei reported seeing log messages for some test cases even though we
just wanted to match the error string from the verifier. Move the
printing of the log buffer to a guarded condition so that we only print
it when we fail to match on the expected string in the log buffer,
preventing unneeded output when running the test.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Fixes: d2a93715bfb0 ("selftests/bpf: Add tests for BPF exceptions")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/exceptions.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/exceptions.c b/tools/testing/selftests/bpf/prog_tests/exceptions.c
index 5663e427dc00..516f4a13013c 100644
--- a/tools/testing/selftests/bpf/prog_tests/exceptions.c
+++ b/tools/testing/selftests/bpf/prog_tests/exceptions.c
@@ -103,9 +103,10 @@ static void test_exceptions_success(void)
 			goto done;						  \
 		}								  \
 		if (load_ret != 0) {						  \
-			printf("%s\n", log_buf);				  \
-			if (!ASSERT_OK_PTR(strstr(log_buf, msg), "strstr"))	  \
+			if (!ASSERT_OK_PTR(strstr(log_buf, msg), "strstr")) {	  \
+				printf("%s\n", log_buf);			  \
 				goto done;					  \
+			}							  \
 		}								  \
 		if (!load_ret && attach_err) {					  \
 			if (!ASSERT_ERR_PTR(link = bpf_program__attach(prog), "attach err")) \
-- 
2.41.0


