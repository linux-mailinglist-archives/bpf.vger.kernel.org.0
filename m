Return-Path: <bpf+bounces-4525-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B8874C087
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 05:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827691C208DF
	for <lists+bpf@lfdr.de>; Sun,  9 Jul 2023 03:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7C71C3E;
	Sun,  9 Jul 2023 02:59:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39500185D
	for <bpf@vger.kernel.org>; Sun,  9 Jul 2023 02:59:30 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49332E45
	for <bpf@vger.kernel.org>; Sat,  8 Jul 2023 19:59:29 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53482b44007so1629346a12.2
        for <bpf@vger.kernel.org>; Sat, 08 Jul 2023 19:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688871569; x=1691463569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7q7c8LyHLAJMt2B4YkHxHBPcsxHYOmrQVVgSh5G9AYg=;
        b=czOgEjcvY/3lQOE1MNYRNHkkPiy1qCqa3iBtQQjalx5UVFGMvwdRfNg/WFP8Ob8NYh
         8eimR/hoIzKbPTJFHnuzcAiZLZCZL4emKLXhQA5FC9JX1C4ledJhlVEpirGZfg4RV1WC
         ZNPCQJX9Gb2Xw1itPkUF5QK90MeyMI+FgERYJS+508B/k2BNhvvc+Kcudr+LPYUwKDR3
         NFA3RBG+0I7t5HIsB5e5Qsof44MhT9xY2FKyO7rg0zEssMSdrObx/jnOVBhDZCGNWE1x
         jhKPytsTCvPuyr6/e7EBSzEwzx4gy65CLormS1lusFPVhbpQDFqln/NsVOTiAKMQrYvj
         IXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688871569; x=1691463569;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7q7c8LyHLAJMt2B4YkHxHBPcsxHYOmrQVVgSh5G9AYg=;
        b=NBRnxEgwRHWRcupkZUt+ZSg0pmov7WPikqxjp1kenGNTTfW8poXzLewaAyVwXrR6m0
         t+BSP/vUn/0QiSmeSQ54idfg90yCOwKL8/xhk9UHUMkTsmCiM20+GJF+g3WPDjEg4jyb
         HaisnAYim2gewpLwOZyTMa0LF/cL1p0X7c82NyVCMNBG4wCVX12b/gSKSDe7gNDmNabb
         U6MH4mUUfW/55CVpk6QTVEJtAahxm2yaDdrLoPyU1O5QTTQgFdbItfrOUGZdxo7jR/Dm
         dtiPdx4llxrQBeecosXSOhloXkErDiO18JRXQXN6NAG6Wv76jhZW27sUpeBYomdc09RO
         VFEQ==
X-Gm-Message-State: ABy/qLYQAjIaAxJhBmCcz20yOcPRfXpwYzPWMPT/2cAF/WR2SIejqz+3
	aFdpVidbCz8uRbj5rvEaCb8=
X-Google-Smtp-Source: APBJJlHW3RnqHD6eonFnqVgfxr7rtmKrfWdNNda3YblhAZUpLMqIWlbSI6OfiNHbcjVPYCXTd8TuEA==
X-Received: by 2002:a17:90b:1b4b:b0:25b:b2ba:2ff4 with SMTP id nv11-20020a17090b1b4b00b0025bb2ba2ff4mr7085181pjb.17.1688871568712;
        Sat, 08 Jul 2023 19:59:28 -0700 (PDT)
Received: from vultr.guest ([2001:19f0:ac01:14bb:5400:4ff:fe80:41df])
        by smtp.gmail.com with ESMTPSA id q9-20020a17090a68c900b0024e4f169931sm3670659pjj.2.2023.07.08.19.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 19:59:28 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/3] bpf: Fix an error in verifying a field in a union
Date: Sun,  9 Jul 2023 02:59:12 +0000
Message-Id: <20230709025912.3837-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230709025912.3837-1-laoar.shao@gmail.com>
References: <20230709025912.3837-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
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
2.30.1 (Apple Git-130)


