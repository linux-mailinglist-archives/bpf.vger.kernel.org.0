Return-Path: <bpf+bounces-9837-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0113B79DCB7
	for <lists+bpf@lfdr.de>; Wed, 13 Sep 2023 01:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBA42814B3
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 23:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A38C156FB;
	Tue, 12 Sep 2023 23:32:29 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53C91429F
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 23:32:28 +0000 (UTC)
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D93910FE
	for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:28 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a640c23a62f3a-99bcc0adab4so783637166b.2
        for <bpf@vger.kernel.org>; Tue, 12 Sep 2023 16:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694561546; x=1695166346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yyChwgbbJqWqWiTpBQ2MkMj0sBFmU5FxpvJsH4ueDzs=;
        b=A1cgsnSlVlLPdI7yfXXh9AJSKrI6wRrMH1pUnUGl6i+OmGAtB/rr+86z705AIRqQWE
         IDymSGH+ssV3w8p52Pq+WtvRwlhgpmi0xxXMUJ1zMdBhAnzsWMbibJZqhOxv3VP+lgZD
         0AuTmhD5RbjbuTMEJ9gs/jJ9NS6JziAFu1Q++V6kiZu6Rc9QlnfWTcohd2Kio48Vqnte
         q17nuT9r/yXavTywUQoI8rImoPT3l2QypsXrkNsgkvC4ukUlh2jL3czLAzzSzg+9Z6cP
         R0NnKNv+J80t0T3pIJFzyK9CMHR3piSXynUW7pjbxgrKgY7RlV1rTP88tMQgVC4qRcJY
         KIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694561546; x=1695166346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yyChwgbbJqWqWiTpBQ2MkMj0sBFmU5FxpvJsH4ueDzs=;
        b=vZTN7tXWuoPmU4RZ8ft5fRRx06+3f8CAGbF8WsLqVI0ijQ3VNmnNm3e4OZDapk4Zwv
         nUrvNsnO5O5LrY6SblEVDsESm9v9/6rLmbXR4k02nrH1V5zusqAjDpzc8Hw/67Ow+zC8
         xBFu1W9vZPSebQuY1uciS1IeZu6texEke6TVp9xwFlcWrI1wPpgcxrFZ5u+okEA2So9O
         Ad3qx2QwuJ4twmlJ3vTySDvrUGl+A1qaHci/7JGYYV8WrKD+H0P2REHgcHRWTJU3hjCS
         Iyxi98ODac1UNG0etZrd13ZxVDnbldsFYhI0N2z4tbNApjRnJsRJUhW45DFSy4jScV+c
         1pTg==
X-Gm-Message-State: AOJu0YwDLg0oYGAe65ONKG6IUA3Y1L/Ox/qvS5tJ1xbgxwyKIcR1NG6O
	pNcX9ubKk2AN4iAeozlKdWETCvZyyaDm1g==
X-Google-Smtp-Source: AGHT+IFKOQwe7FmXhBVo8H5o6KulCXPmmyZ+5ROq0O+/Zz+g65oeiwl13r0JH1Nzk6BC1Y+aJ0Etpg==
X-Received: by 2002:a17:906:3290:b0:9a6:3d19:df7 with SMTP id 16-20020a170906329000b009a63d190df7mr487812ejw.17.1694561546367;
        Tue, 12 Sep 2023 16:32:26 -0700 (PDT)
Received: from localhost ([212.203.98.42])
        by smtp.gmail.com with ESMTPSA id y5-20020a1709064b0500b009a0955a7ad0sm7397065eju.128.2023.09.12.16.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 16:32:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Dave Marchevsky <davemarchevsky@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>,
	Puranjay Mohan <puranjay12@gmail.com>
Subject: [PATCH bpf-next v3 13/17] bpf: Fix kfunc callback register type handling
Date: Wed, 13 Sep 2023 01:32:10 +0200
Message-ID: <20230912233214.1518551-14-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912233214.1518551-1-memxor@gmail.com>
References: <20230912233214.1518551-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1184; i=memxor@gmail.com; h=from:subject; bh=3b0jLk4e2ZsOFf+IyG/nlx/5RtVzoTpm+030EYo5lSI=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBlAPSt/NTVp2ktFkA3+BKrZefflXbPn2kZ3dz8q hwNrfrWHeOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZQD0rQAKCRBM4MiGSL8R yklkD/9BRz3S2yjj4jo73e4p4/w31r2QkvU/QKGvvnf8U8mGn/iH8stiCORbjL5jlaAlUjm9qV+ gnmQRE1TkvPI5BNRWI9omHz2LKDUJfOwUfsDnxRwMAtFh85E4NB+2RTLjzgcmwX3ndRn5yVBcvH 51NdUcoTC8pgK5SLUxwEbV2QBCelA4G+lrEn+N/R1fd0X0rkmJbCjgiMGJhMJuretEgUbWOs2RK l73Zt48zEQyTx0T9SWruHyF/s9YYR4b75OieO5dsll54zI6xVbFaTzMt/kDW/wlFU8eck//ZUXe 39WNUlCdSM3fVXE4FPqoqj+ievfOGwRu6RiwUWsWa/p+SWrv+sa1fFOP+pTg5dEpjlgbPy+EmA4 Bd1XNyuLGIG/AVGcQqV4BLKw4Y63/xLkJDJVFakCkFNE5L3aJoUGOVvevhotmuDnToQvms2owuH anPBsL0E4+fp/NqpmmVQQG1VA1r5vAdKNyvp1iidz62laZuv/4YbDGdXSpLcouwmahnUD+SJC76 E+OsbiMtcHDGbvJo9Ngn8XNUe4bYb/4uWxKPEkSNWaYVU7B5cZHPuBP7X5/cLGWwxhDeq9Mz5Df NmfO05lcsKvI8xj+zUuDW+O6uQuxHc/C4W/nDwGuS/CDUGBywnOAuDtdaVkTvUJVOnEWraJXCxy WfFt+5pvrpUx/OA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

The kfunc code to handle KF_ARG_PTR_TO_CALLBACK does not check the reg
type before using reg->subprogno. This can accidently permit invalid
pointers from being passed into callback helpers (e.g. silently from
different paths). Likewise, reg->subprogno from the per-register type
union may not be meaningful either. We need to reject any other type
except PTR_TO_FUNC.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
Fixes: 5d92ddc3de1b ("bpf: Add callback validation to kfunc verifier logic")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 21e37e46d792..dff8c43dea0c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11407,6 +11407,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 			break;
 		}
 		case KF_ARG_PTR_TO_CALLBACK:
+			if (reg->type != PTR_TO_FUNC) {
+				verbose(env, "arg%d expected pointer to func\n", i);
+				return -EINVAL;
+			}
 			meta->subprogno = reg->subprogno;
 			break;
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
-- 
2.41.0


