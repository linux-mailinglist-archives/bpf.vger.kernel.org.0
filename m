Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2835F1042
	for <lists+bpf@lfdr.de>; Fri, 30 Sep 2022 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiI3QuV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 30 Sep 2022 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiI3QuU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 30 Sep 2022 12:50:20 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D3CA2A6
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 09:50:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sd10so10278313ejc.2
        for <bpf@vger.kernel.org>; Fri, 30 Sep 2022 09:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TXmbbsssZ+72n59nGkn0OCOS8BwGPkuzgw55ockvPdM=;
        b=ZGQRUqgHUnMBzhjgQg0RLQAH/JUbIumq8idcWh0M1as0rtk5p5YN7Zmwbv8We/KmIQ
         FqBMptTV++eLqXWMFceAq2CbRd7q5rL1IhpJDVAYX+Yv66CSA5jveTRW/kh9hldMbb/6
         t2bFi/cUvWBjTgmr2PPkFnDcUguP9ZNq5q2b2VgPpihPYVdTBZ0WLoks55q48W4UeeGj
         yzV+jiqU3FIgpQNv9Fi12jRWie3k60Xw619Ok5oPphWW5Npi3E3fcMMldxluTL6QsBl0
         Xd3qR0on4c59nLTrEHmCpuVs4JGsyxhQpnzBwjpDR4CFMQ/6OHZftjdV5jIxla5L0/BW
         Uqig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TXmbbsssZ+72n59nGkn0OCOS8BwGPkuzgw55ockvPdM=;
        b=cUsuLUJ317SHHqgXJ6JZpHpHNQFULGaw759m0+xvMv4H/takBdeg6XdwQv5a9BwCMF
         WGoqlfWwrSq1BTiQXSM2osfrgRpE9D6P3640tok5KXaWhJtTF9tGZbMpWSioLwmGN9Vn
         b3Elhz60M3WYVj3elyu0Z7j4TbOcE2EYix8EFVqDI3b1a7QvnWWFLdgf7pBs0yPGSJ5M
         adzeUid34F3IyevYeQ9tgHCtMAxxHJnVwKW4nVVhSK/5z0HXq+eEuW2Vpc2tVm8FQe/Y
         ishJYQLfjfHJWJmgkGjKboIHvvv9NOnAVk7HZmXlj3DNMLXMvAT+TPzPw0F0fvxzWqpB
         WEhw==
X-Gm-Message-State: ACrzQf1Cid0waYMVGqTyzO2dZgFqD1Ze6SrtPQMiYO7LO2Us2GKgD3eV
        5SJ1Aw+7Cc6NX5f/5EObCvcGPK6LhDtAfg==
X-Google-Smtp-Source: AMsMyM5Q++9fwJr8sIMYTNVsTHxzsAEkMFGs2DcZ1PZ+RKhdmONDijwgIjHRmW2Ict7Z1H8QzsXfjA==
X-Received: by 2002:a17:907:7d8d:b0:781:fd6b:4545 with SMTP id oz13-20020a1709077d8d00b00781fd6b4545mr7179237ejc.117.1664556617127;
        Fri, 30 Sep 2022 09:50:17 -0700 (PDT)
Received: from badger.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906304700b0073d9630cbafsm1395021ejd.126.2022.09.30.09.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:50:16 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com
Cc:     Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next 1/2] bpftool: fix newline for struct with padding only fields
Date:   Fri, 30 Sep 2022 19:49:17 +0300
Message-Id: <20220930164918.342310-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930164918.342310-1-eddyz87@gmail.com>
References: <20220930164918.342310-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

An update for `bpftool btf dump file ... format c`.
Add a missing newline print for structures that consist of
anonymous-only padding fields. E.g. here is struct bpf_timer from
vmlinux.h before this patch:

 struct bpf_timer {
 	long: 64;
	long: 64;};

And after this patch:

 struct bpf_dynptr {
 	long: 64;
	long: 64;
 };

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/btf_dump.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
index 4221f73a74d0..ebbba19ac122 100644
--- a/tools/lib/bpf/btf_dump.c
+++ b/tools/lib/bpf/btf_dump.c
@@ -852,7 +852,7 @@ static int chip_away_bits(int total, int at_most)
 	return total % at_most ? : at_most;
 }
 
-static void btf_dump_emit_bit_padding(const struct btf_dump *d,
+static bool btf_dump_emit_bit_padding(const struct btf_dump *d,
 				      int cur_off, int m_off, int m_bit_sz,
 				      int align, int lvl)
 {
@@ -861,10 +861,10 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
 
 	if (off_diff <= 0)
 		/* no gap */
-		return;
+		return false;
 	if (m_bit_sz == 0 && off_diff < align * 8)
 		/* natural padding will take care of a gap */
-		return;
+		return false;
 
 	while (off_diff > 0) {
 		const char *pad_type;
@@ -886,6 +886,8 @@ static void btf_dump_emit_bit_padding(const struct btf_dump *d,
 		btf_dump_printf(d, "\n%s%s: %d;", pfx(lvl), pad_type, pad_bits);
 		off_diff -= pad_bits;
 	}
+
+	return true;
 }
 
 static void btf_dump_emit_struct_fwd(struct btf_dump *d, __u32 id,
@@ -906,6 +908,7 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 	bool is_struct = btf_is_struct(t);
 	int align, i, packed, off = 0;
 	__u16 vlen = btf_vlen(t);
+	bool padding_added = false;
 
 	packed = is_struct ? btf_is_struct_packed(d->btf, id, t) : 0;
 
@@ -940,11 +943,11 @@ static void btf_dump_emit_struct_def(struct btf_dump *d,
 	/* pad at the end, if necessary */
 	if (is_struct) {
 		align = packed ? 1 : btf__align_of(d->btf, id);
-		btf_dump_emit_bit_padding(d, off, t->size * 8, 0, align,
-					  lvl + 1);
+		padding_added = btf_dump_emit_bit_padding(d, off, t->size * 8, 0, align,
+							  lvl + 1);
 	}
 
-	if (vlen)
+	if (vlen || padding_added)
 		btf_dump_printf(d, "\n");
 	btf_dump_printf(d, "%s}", pfx(lvl));
 	if (packed)
-- 
2.37.3

