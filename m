Return-Path: <bpf+bounces-3650-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE4E74106B
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 13:52:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED84A280E19
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B22BE74;
	Wed, 28 Jun 2023 11:52:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CE9BE47
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 11:52:13 +0000 (UTC)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B174FF
	for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 04:52:12 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b7f223994fso34125135ad.3
        for <bpf@vger.kernel.org>; Wed, 28 Jun 2023 04:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687953131; x=1690545131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLlpd+9cq+iVzEW7RWjKZweEWG5U9g9cyOtRfBdjXm0=;
        b=grmGUCqDbelAoaeDKc9z6xfMNrAPgN0B4GziQ5WrBQTzhv4RYYWwXbkTtyRNiZK9/7
         75OPLcFDVHxMAdsjZ+7UNud61else7/4X01+mhQS9q/m656zK7DWnTj0OxC5o6OVHQge
         ijtMBcNBKCY0iqi+U7Ss7bmdMt5bIFKEvYvNGOlLh8ngcI8JGhD1oe01Jc/YjDci/XS8
         JgmNCsNRAWjGc9PpKO1XtChiKQi8w9jihTAwaCEz86ti+PCgd7sPqdC+m0b4qucP3TrF
         67jioTlZQu+XUMEMBn5feGbgyVkC4+pFe4yEWwoSdOUk61SNz5mNCi3EDqxuCGC73Pkh
         qMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687953131; x=1690545131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLlpd+9cq+iVzEW7RWjKZweEWG5U9g9cyOtRfBdjXm0=;
        b=SR8FD5d6ZlJkssFD1lsgak7+kEXmE3kDrrHoM7ag4cQTHBT7Gd9xqHlw4cFMPnkusF
         P46mpLc+ixnvNe1eaIxTp84FKt1OwShAKNVj0UcZlvAT2iJad8YPsAUXPd+dVf1Q62NJ
         7i/4zt7iQKOVqGZAiVe1BUsDDgvnlirbOrMVCjV3Qwb3hPxzARwCFeS4PsOjr3L96KGE
         za7HDKdOF6cqJvAM8t+PL6DN1cEMaVb7e359oFl1sv0IHHdufr10352Ht1sBmdPXkrzn
         HNlf/JfORTKFHqWwwqWvMQOuqfYRTk5YuHZ217/rK2t/sDy1U+q3yiOX+vTAtA4p0L1r
         WTXg==
X-Gm-Message-State: AC+VfDxSpUM6+Y6llRW9/vGSdONwWPP3CF+cW3eERf47PoyibAhRuAnr
	IdmUQqwCFSF0Qgg34SHhA4E=
X-Google-Smtp-Source: ACHHUZ4RFlcbd/wOCqbjqAQt3FukodJmDAx60kgQzYYEc/NwSlm5P6CgNjSSFDVlFr8Gap/x+npWLA==
X-Received: by 2002:a17:902:ce88:b0:1b6:68bb:6ad0 with SMTP id f8-20020a170902ce8800b001b668bb6ad0mr16921772plg.55.1687953131331;
        Wed, 28 Jun 2023 04:52:11 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac02:b79:5400:4ff:fe7d:3e26])
        by smtp.gmail.com with ESMTPSA id jf5-20020a170903268500b001b7eeffbdbfsm6607133plb.261.2023.06.28.04.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 04:52:10 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kafai@fb.com,
	songliubraving@fb.com,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 2/2] bpf: Fix an error in verifying a field in a union
Date: Wed, 28 Jun 2023 11:52:05 +0000
Message-Id: <20230628115205.248395-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230628115205.248395-1-laoar.shao@gmail.com>
References: <20230628115205.248395-1-laoar.shao@gmail.com>
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
index e0a493230727..8ad27b16bc8b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6366,7 +6366,7 @@ static int btf_struct_walk(struct bpf_verifier_log *log, const struct btf *btf,
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


