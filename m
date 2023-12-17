Return-Path: <bpf+bounces-18131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34913815F3D
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 14:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E65D9283075
	for <lists+bpf@lfdr.de>; Sun, 17 Dec 2023 13:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E607E44394;
	Sun, 17 Dec 2023 13:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AfeBzLBP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com [209.85.166.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2853F4438A;
	Sun, 17 Dec 2023 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f196.google.com with SMTP id e9e14a558f8ab-35f96476fb3so10853075ab.0;
        Sun, 17 Dec 2023 05:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702819115; x=1703423915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIG7gX50kKtmhzIyeXshzVLZolIi3kTx5IiKTBxlLu0=;
        b=AfeBzLBP3Ji4QAVi7lLUbh9DM76OXM6lmJCPMv/nq/ui33zvH/NHOAYYkUOU2adLMm
         5TtmtbZxIZmT3eCCzTEeX0QrLXZTngNvghJKdx9A3IOmePv9m8Tnm7Ogm9XcEcEtShDY
         lgjETwE497tF72SXO1S6Upyl8G4att9TP1ryfAj9/N+mFw49+wx9FuvzG7JYd2ZgekkW
         XhIh407i6PHBjZS9UFercvjiBuZVdw3OLQnbS3uS8w53pOUrrA00Pfs3kJw4jlddMRMo
         T73g8wHb2TdKJLcZPWNAf2J9CBis307DalPQ3iqKDbyhA23R0rVIi3OOA4W00xQ1JPVF
         wizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702819115; x=1703423915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vIG7gX50kKtmhzIyeXshzVLZolIi3kTx5IiKTBxlLu0=;
        b=Apj/4407NcEw7wXwuOv3pG/98AzDKtiLFWdZ5PiJPiiw47wI6o5488E1Bc91HCHgwT
         c6l9ZT8r8qNHiBNQKj9st0YjfsHeKSLrPRT4rgLjyXc8yzZ3+1semDPmg4y2S3J7/8Ia
         UH9poOJd27/e5kBdGpvFWpf3eiTgAnvkqijOIUJQ65TYAF4Za4cJLu33UWo+uhV7D4QT
         +Isf74+vqbTBmBSteLxV/kgDiktSQbCGpGiSyNEWNV18fZO5rPHiXv3Oum//E0gQ+7+t
         YdOvqnJDbjNHZe3RPsJDHcwdIBRJzyl1WkumL922XX866ZuEkCg1P4Zj1GHFa8vsPLal
         k03g==
X-Gm-Message-State: AOJu0YwViGd36lOCWnSiB/Y0iolbFFxi7EBLJ4wBuzreZ2h3xaclS7HC
	zurKVkalfQzLY2u5fxncSLo=
X-Google-Smtp-Source: AGHT+IFuYVYqCJXnlGSY0RyODewiiUKWPVJpKtwtNSLuGT8b2gpJNCbkzwTNT0Y1LI2TQsPuyAjZBA==
X-Received: by 2002:a05:6e02:1a64:b0:35d:87d4:938c with SMTP id w4-20020a056e021a6400b0035d87d4938cmr23751297ilv.15.1702819115079;
        Sun, 17 Dec 2023 05:18:35 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001d395d3df30sm1099425plw.130.2023.12.17.05.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Dec 2023 05:18:34 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	alexei.starovoitov@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <menglong8.dong@gmail.com>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Subject: [PATCH bpf-next v4 1/3] bpf: make the verifier tracks the "not equal" for regs
Date: Sun, 17 Dec 2023 21:17:14 +0800
Message-Id: <20231217131716.830290-2-menglong8.dong@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231217131716.830290-1-menglong8.dong@gmail.com>
References: <20231217131716.830290-1-menglong8.dong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can derive some new information for BPF_JNE in regs_refine_cond_op().
Take following code for example:

  /* The type of "a" is u32 */
  if (a > 0 && a < 100) {
    /* the range of the register for a is [0, 99], not [1, 99],
     * and will cause the following error:
     *
     *   invalid zero-sized read
     *
     * as a can be 0.
     */
    bpf_skb_store_bytes(skb, xx, xx, a, 0);
  }

In the code above, "a > 0" will be compiled to "jmp xxx if a == 0". In the
TRUE branch, the dst_reg will be marked as known to 0. However, in the
fallthrough(FALSE) branch, the dst_reg will not be handled, which makes
the [min, max] for a is [0, 99], not [1, 99].

For BPF_JNE, we can reduce the range of the dst reg if the src reg is a
const and is exactly the edge of the dst reg.

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
v2:
- fix a typo in the subject
- add some comments, as Eduard advised
---
 kernel/bpf/verifier.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1863826a4ac3..29c41d66ea6f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14343,7 +14343,43 @@ static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_reg_state
 		}
 		break;
 	case BPF_JNE:
-		/* we don't derive any new information for inequality yet */
+		if (!is_reg_const(reg2, is_jmp32))
+			swap(reg1, reg2);
+		if (!is_reg_const(reg2, is_jmp32))
+			break;
+
+		/* try to recompute the bound of reg1 if reg2 is a const and
+		 * is exactly the edge of reg1.
+		 */
+		val = reg_const_value(reg2, is_jmp32);
+		if (is_jmp32) {
+			/* u32_min_value is not equal to 0xffffffff at this point,
+			 * because otherwise u32_max_value is 0xffffffff as well,
+			 * in such a case both reg1 and reg2 would be constants,
+			 * jump would be predicted and reg_set_min_max() won't
+			 * be called.
+			 *
+			 * Same reasoning works for all {u,s}{min,max}{32,64} cases
+			 * below.
+			 */
+			if (reg1->u32_min_value == (u32)val)
+				reg1->u32_min_value++;
+			if (reg1->u32_max_value == (u32)val)
+				reg1->u32_max_value--;
+			if (reg1->s32_min_value == (s32)val)
+				reg1->s32_min_value++;
+			if (reg1->s32_max_value == (s32)val)
+				reg1->s32_max_value--;
+		} else {
+			if (reg1->umin_value == (u64)val)
+				reg1->umin_value++;
+			if (reg1->umax_value == (u64)val)
+				reg1->umax_value--;
+			if (reg1->smin_value == (s64)val)
+				reg1->smin_value++;
+			if (reg1->smax_value == (s64)val)
+				reg1->smax_value--;
+		}
 		break;
 	case BPF_JSET:
 		if (!is_reg_const(reg2, is_jmp32))
-- 
2.39.2


