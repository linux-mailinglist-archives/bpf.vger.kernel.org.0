Return-Path: <bpf+bounces-10307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8827A4E2D
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 18:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11E5C2816A6
	for <lists+bpf@lfdr.de>; Mon, 18 Sep 2023 16:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5258523740;
	Mon, 18 Sep 2023 16:06:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBD41D686
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 16:06:53 +0000 (UTC)
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C42B2D42
	for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:06:47 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 38308e7fff4ca-2bfea381255so37284011fa.3
        for <bpf@vger.kernel.org>; Mon, 18 Sep 2023 09:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695053205; x=1695658005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWLbZ1J0oeUlS0QBC3LOMF2rfKN6MrliiLEkPfiun10=;
        b=OVZd0AGJaBh7AmWJ+ZE/PYG5u0oil6BFKksvf2l+T5UKJfN5ZYr7LbwwJD0YgdsbqG
         VQDWQTTHKfNGIyUczEHH7POKEA/yf36GiKW+J0VIHZ8Bcon5Do9eUe1cCygf4+rKp0K3
         /6tYosjlSIf26p5q/pE+GfY2HO+zWaITREFYKsceUWcGg18dPpENEcxgLoUSGQ5IHrwb
         688bf4XLwamCrBw7ruWqlKT6vDfmOckywdmUhvyFCleTz0kD5QJv/5nkhG6dPnlpoGjb
         WLn/tWzSn6nBgz8OMquzeCxoItPTNQGUDz0mQ5efzgGvEH2qliih5fsvwZ9+Vb/Koe18
         G2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053205; x=1695658005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWLbZ1J0oeUlS0QBC3LOMF2rfKN6MrliiLEkPfiun10=;
        b=e0pHHMNPeioAL6lzmqKc1RtCOZqmV5jitvEh9H5Y7IuD/a+LNj5W9Z5ypz2/F25ZkC
         t7KsL3fAA0UE2LxdiKDLkopCn5c0EFxTxdsZDw4yFBXyy9Zhon3rlHlRJtQeXnoCNv3O
         vWp//I6cis9u3nVUuhP13JinnLRDU4nsXFETxBpa5Mry4V05Lst4//W0A8wPW1kdwdjR
         P5FlE0Zzn5BP/Py/w4KGM7fwBYQiAy3NniuZxqK8PzX7omdwEEULywzJzyqdqA1mxiI9
         Fb1EQAjf07WWgxUn53ST4oI7rorKYLxGYvNb3yIMTge4I8ciqIDshycujBr+dwJAoXLH
         dg+w==
X-Gm-Message-State: AOJu0YyDJtsKjyTifM2rym6Prrer/fn8owcrVoGQ4jtFkLXRFbFAbxFh
	WjbtzvF5zhRh1lmZzQSamIH+adzn7YHzvQ==
X-Google-Smtp-Source: AGHT+IFGZzuVgpOzjT+QEt1YLmcP1fk7iBZXUwlC0/Soo2Om0V0LGTdLXDmQs75mDcOc7LEvADMLKw==
X-Received: by 2002:a05:6512:3150:b0:503:4c3:c67d with SMTP id s16-20020a056512315000b0050304c3c67dmr3924834lfi.21.1695052355315;
        Mon, 18 Sep 2023 08:52:35 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id br13-20020a170906d14d00b0099cf9bf4c98sm6718919ejb.8.2023.09.18.08.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 08:52:35 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH bpf-next v2 1/3] selftests/bpf: Print log buffer for exceptions test only on failure
Date: Mon, 18 Sep 2023 17:52:31 +0200
Message-ID: <20230918155233.297024-2-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918155233.297024-1-memxor@gmail.com>
References: <20230918155233.297024-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440; i=memxor@gmail.com; h=from:subject; bh=oHvLk0ZHhNY+L7Ri8crRqUByZW+W4S/TRihF1kQbWZ4=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlCHIa68qPVyIcWw95cm+Qf50mRMtCOeMoIpeaU jCwVNvFr96JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQhyGgAKCRBM4MiGSL8R yrvMEACbNYE+XIIY2psVobAp7Jq00IF1//D0Z3HR2Ey/H/3oSyySfVWZBXDdGOiHWaS+srxfx/L +xNCRMZNjrqLkMhZRTjCCM5zgl6Wr+mtIBPvICkmK1Jc1n/ni5nWAx0Me29uwxyCMdTCuuv6koW vr0/6P6XjDlzNDNNpfp0GwolRHpSJNzunIrdbmCgcipJC9e8zlGVbu+m3aGqMLFdYNm0peDNhs1 uFYR/GmIwvY+ElkdndTPZRgtJkiO5Cj5Yiw/uTYRYNOMm3ZuE9Nj8Jm3Z5CVNsMOSzGmch5TIXG /UkispHOmzko/dKQaHjnIqK06vJY+EeAXOzfhC1269AOqgP4eE5+TpTARMtXbw7J+n7N2JSnKm3 PDc8FFnUF7HqAFRrS0VCottARFOplMOUxhXwRPXyk6FGfSoUdEqgxk1JeRvQl9T5JmYfCmYQbVh tsHvsf5MelsLda2WWZEyC5uy7r8OpFCu6CSG2HtYM4d772cD3Veh+/Ix/LILsjwQrrUnjf6XBM4 hNoen8qwVOIxKvz+Lu/w5CUKqAepACsUqqfgej1WFOb81qKslyLYHHPuDbMoope1E0amZ5CZa6k iuZjFcqyOtNUHnzZ7+BmXqd08FMj0SgqxYyuUeAVaAPs8EMzSxTZ2uCiMtl2W5/v0Pf8TFX2DEk HCGP329+HvxrODA==
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


