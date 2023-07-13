Return-Path: <bpf+bounces-4909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3039575168C
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 04:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E00D2281578
	for <lists+bpf@lfdr.de>; Thu, 13 Jul 2023 02:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3A74430;
	Thu, 13 Jul 2023 02:56:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BA97C
	for <bpf@vger.kernel.org>; Thu, 13 Jul 2023 02:56:55 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB459B4
	for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:56:54 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b9a2416b1cso202654a34.2
        for <bpf@vger.kernel.org>; Wed, 12 Jul 2023 19:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689217014; x=1691809014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4xN4Dq8BIfwD04p6ucKevFBUMltnw+Io8HgTJftqWtQ=;
        b=YGbWycWqlbg/GEQCBUaJiG/ZK6W7VKOKJT80b94ePWVda3IbruYgkLrV9+u5D2d2Bx
         p5N6FwOd4t5jWMrbMuoyxnXWvaZ5WqSMGFFzlDpRw2EfRzCbDgirFVyeee3OCCBptHa8
         OCdCm1+jBl9jjZkAh+Urwljk6qsbNd3TL0rRieK1H5hbj1IG0ijRmLBqK0ZVUKAVjTTw
         8hoJiInXI1d5hM+UVfFGRc0iL+Nx1Iqjzi7lymlnbfQzilzmEVi4bxXgXf5DRkWNFtJM
         lEoV8CASD/q2Ddakif47knoHw3HWPP3eRZ6G6Og3iEURhLrna57YeDd0wfgXCmgrQaZJ
         llTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689217014; x=1691809014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4xN4Dq8BIfwD04p6ucKevFBUMltnw+Io8HgTJftqWtQ=;
        b=IzTjJ59Z48HdjS5kHtDrnNmtihjlejZDQtlAldL0FiHFceBnx11Q2swA//1nb2MVS5
         p4fC72Lyx95bfxCr6Rdrs1u2vTJI3Ri0HNEPyUtB7IBdneIboNA/YzX7PGxhNEI/ptz6
         XkQiJZ/yOshrzZQYhPzXWpA+IoF3gimykbL01AYLtRiI5UqtCbZJL3VOOajhdkvI6g3A
         tomPdAMjZ8DVWnpObsBXJ2R+T1MOLIyNcMVnIdocG8jJSM78kUJy0cZ7JZRtEfOcsRLE
         uCkFskQpZbQKfAgQzdgzC82KLH2spwOvYomyoJb3TlzxmpGHyIGFCXJuSyBC4Fs7/1ef
         0f1g==
X-Gm-Message-State: ABy/qLbyxdcU9jahZf1OFcxLvALtrulZz7JWU2w2JRATtq8iqtPR9hk1
	A9SEx0AjP0IK0dbNotytcVM=
X-Google-Smtp-Source: APBJJlEaZsae7uGOPYs0WMMmi9qx0FzIFdWZ3pO6Sb2FZ25pRocW+WQcPKxzZnmlqlDYSxbxzTy58Q==
X-Received: by 2002:a05:6870:5ba5:b0:1a3:1cb3:37e9 with SMTP id em37-20020a0568705ba500b001a31cb337e9mr832532oab.4.1689217014107;
        Wed, 12 Jul 2023 19:56:54 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:a97:5400:4ff:fe81:66ad])
        by smtp.gmail.com with ESMTPSA id lr3-20020a17090b4b8300b00260a5ecd273sm4416681pjb.1.2023.07.12.19.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 19:56:53 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yhs@fb.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH v2 bpf-next 3/4] bpf: Fix an error in verifying a field in a union
Date: Thu, 13 Jul 2023 02:56:41 +0000
Message-Id: <20230713025642.27477-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230713025642.27477-1-laoar.shao@gmail.com>
References: <20230713025642.27477-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

We are utilizing BPF LSM to monitor BPF operations within our container
environment. When we add support for raw_tracepoint, it hits below
error.

; (const void *)attr->raw_tracepoint.name);
27: (79) r3 = *(u64 *)(r2 +0)
access beyond the end of member map_type (mend:4) in struct (anon) with off 0 size 8

It can be reproduced with below BPF prog.

SEC("lsm/bpf")
int BPF_PROG(bpf_audit, int cmd, union bpf_attr *attr, unsigned int size)
{
	switch (cmd) {
	case BPF_RAW_TRACEPOINT_OPEN:
		bpf_printk("raw_tracepoint is %s", attr->raw_tracepoint.name);
		break;
	default:
		break;
	}
	return 0;
}

The reason is that when accessing a field in a union, such as bpf_attr,
if the field is located within a nested struct that is not the first
member of the union, it can result in incorrect field verification.

  union bpf_attr {
      struct {
          __u32 map_type; <<<< Actually it will find that field.
          __u32 key_size;
          __u32 value_size;
         ...
      };
      ...
      struct {
          __u64 name;    <<<< We want to verify this field.
          __u32 prog_fd;
      } raw_tracepoint;
  };

Considering the potential deep nesting levels, finding a perfect
solution to address this issue has proven challenging. Therefore, I
propose a solution where we simply skip the verification process if the
field in question is located within a union.

Fixes: 7e3617a72df3 ("bpf: Add array support to btf_struct_access")
Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 kernel/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index fae6fc24a845..a542760c807a 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6368,7 +6368,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
 		 * that also allows using an array of int as a scratch
 		 * space. e.g. skb->cb[].
 		 */
-		if (off + size > mtrue_end) {
+		if (off + size > mtrue_end && !(*flag & PTR_UNTRUSTED)) {
 			bpf_log(log,
 				"access beyond the end of member %s (mend:%u) in struct %s with off %u size %u\n",
 				mname, mtrue_end, tname, off, size);
-- 
2.39.3


