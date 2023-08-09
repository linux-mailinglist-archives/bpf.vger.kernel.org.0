Return-Path: <bpf+bounces-7344-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC7B775E0C
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 13:44:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337CD281BC3
	for <lists+bpf@lfdr.de>; Wed,  9 Aug 2023 11:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246BF17FFB;
	Wed,  9 Aug 2023 11:43:55 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0716F17744
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 11:43:55 +0000 (UTC)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E425310C
	for <bpf@vger.kernel.org>; Wed,  9 Aug 2023 04:43:53 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-4fe463420fbso10463713e87.3
        for <bpf@vger.kernel.org>; Wed, 09 Aug 2023 04:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691581431; x=1692186231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jt4MD6otCHDvVVH7w0i/nPhgzdFoqeKcIRFnJUhleg=;
        b=Us5lsvwiycgZ7xp39wPhWyfudOhB5/uAWqZdmj29rGH5IwCa3NpZewmDCYfIQI8/mQ
         aKv7HchVsY9sIsvOEGkNYq7zCgbmx970JIrGk4N72sK5GVVXvosBxfDVrRke2YfxJ/ou
         Gb6wR6IZY720cCxCRqk+pRksSLPQ2WjShNdfW9AiAACLVrwYJyVdDpN2Cv9HlddEZFiN
         lLoVTkDW8gl3b440o7488FJPnRCZJNFzf3W/I8ikWBhPCiTT285++jXmIIwpcKjcWpGf
         MAvxa0EKycclUCSWspPB+4YDxlZIMc2tJECBrM5EgPHi+TSuRbLUBnui6vrZN8we1+hF
         VXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691581431; x=1692186231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jt4MD6otCHDvVVH7w0i/nPhgzdFoqeKcIRFnJUhleg=;
        b=MM+lp8F3Uxva4i0+AEewRYE7K7P6JwzYWEgQnuQo+DyU0vtq76zqqScd9x+43e8xhB
         draRvTpFif/gOFwZeN6LK3C0uGz/S+k9Edglx6HXLGwa1OL+JSfsdvHxah8dIlpZc1w0
         gosUg3D5kbxzLTfJ/Xzh8IyIBM0uvXZh+l2EQ7/T8+283UXyRKMAGuzMbAEYxsHxoLgz
         90C1QKzlE0PyklVLwUu9rLU6RzPO5T67jMH65VDAoIJrZqsoPRaxgQxJgCH4XSPsuACv
         rZvWZ52W/hcg+IL599J4zZx3SJDbyYzkMt5zaIF8tzMohriCoyc21wUcZbL6rQAQC+nZ
         SssQ==
X-Gm-Message-State: AOJu0YyIxnRL2DZJZFuU0ZYC1Ym4ug91PMSXhNpNn7Hyx8OZXtGMoSgd
	T4hGx+qAHhSpVqaJniQGwy2j86wLE6pDTq4vUCA=
X-Google-Smtp-Source: AGHT+IE0WecKzYMrC2QgJMkfDJg4SbP1JM9o280v3cw0rgr+Titv36CadEHu6n5QRIOO6WZ1Ftj9pg==
X-Received: by 2002:ac2:5b5e:0:b0:4f8:d385:41bd with SMTP id i30-20020ac25b5e000000b004f8d38541bdmr1742016lfp.8.1691581431239;
        Wed, 09 Aug 2023 04:43:51 -0700 (PDT)
Received: from localhost ([2405:201:6014:dae3:1f3a:4dfc:39ef:546b])
        by smtp.gmail.com with ESMTPSA id n15-20020aa7d04f000000b0052227c4384esm7939959edo.34.2023.08.09.04.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 04:43:50 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Dave Marchevsky <davemarchevsky@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next v2 11/14] bpf: Fix kfunc callback register type handling
Date: Wed,  9 Aug 2023 17:11:13 +0530
Message-ID: <20230809114116.3216687-12-memxor@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809114116.3216687-1-memxor@gmail.com>
References: <20230809114116.3216687-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1178; i=memxor@gmail.com; h=from:subject; bh=uTfZBPCaLcBY2DK9GK066GGX6NJIOUwA5y0+iLSaY0g=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBk03rJNTDeBWOVkqE3t7JYDz6fgJ52iTv0wJ7AB Gd+DWN3kRSJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZNN6yQAKCRBM4MiGSL8R yqWlD/9F9Yg72IeQPAroj38ptxQd0jHcyKk3MHdSwDVx9av/xz+/EcM+x9+YcRoQrCEmpqVvxep NtxP3h3EYK86Z4Svogq5sFSMJNkvULv/KDuOQz9g2Y4Jno4RlJdJcJmwqAxTVihynTAtvhejnwV 77LbPdUnwGJfmGPw0Ug3+twYhx5sTOAZRmu7ij+gB7o3vQhAau+JLJ6cIg7etSlqLSHHrr42OXH zEkOdaV6xvP4hICWwJrVcNPOweIzvQ6QNDgHObAAcfUAyDRl4Fj8VzlcWN+4RuQG57zMbA4ucyo P4+gRtk2ygjmvJd7NKWCVhJY2BUU+hBGM4eEcjeN6hGoR4a2ZaVF0Dkojw3oY5mLUEWIVjM/n4T ZEXwz1V5ODJE4EqLXVFSAppr9J3HM5l4CmdvptbQCYmWOkQxboHKt0SDQ9W/rxjjWzmAZH/WJPH y/kX0nf/v4g2Jn9z3zPykw11awaQYV0iHiZdV++bQUDyhYyWP9cC7oqnO+iPvw/y52DiDuWq40I azMLZKrMvMV218Om428Lu/d2rZNM2Ug6rERB5k0FuT9KOVqu1UGfcfqBnfkFX4aba7TD8yR3/14 VZhs78ancKNvXzdSpDJY6vDFFZOH+dX0TZPe1NrZjSxsZc6O6iQffXVX9o0SWiozmdate7h6ltK AKR1p1J+CDeuGNA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The kfunc code to handle KF_ARG_PTR_TO_CALLBACK does not check the reg
type before using reg->subprogno. This can accidently permit invalid
pointers from being passed into callback helpers (e.g. silently from
different paths). Likewise, reg->subprogno from the per-register type
union may not be meaningful either. We need to reject any other type
except PTR_TO_FUNC.

Cc: Dave Marchevsky <davemarchevsky@fb.com>
Fixes: 5d92ddc3de1b ("bpf: Add callback validation to kfunc verifier logic")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/verifier.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 13db1fa4163c..1c9a7a6ef906 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11334,6 +11334,10 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
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


