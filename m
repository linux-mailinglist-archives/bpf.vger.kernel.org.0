Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA3462EB73
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 02:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbiKRB5W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 20:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233315AbiKRB5V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 20:57:21 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9627162047
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:20 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 140so3538325pfz.6
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 17:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+/EQMQ6v6vKQC+cnMv4I7AqJLmOpRFAqknb2KaBufw=;
        b=LNa78Aq9MbBJgVxfmkGrKaV3fQhSRdExX7XxIxXCwcfrouD7h0Fn6sa32iLALdSaJf
         jP3v2vyJ9h7CVd44SJ0HSLM2WoSc9yy0wSeNbyX+u2y0SdTFX4IxwMHNjwRurmj4ui8T
         5RlcOfU64EUCord8vJJ3oJK7j+6TH2CnwbLbrwYaKdxuhBDn07gghTpZQlhQ0hBNqOg5
         BCC/VECIwclkXSl7Tl1CZoVyzcOQRYG1c0Lp1xHLV82+u09t6N2ulFWUbmeAl3vznJMr
         1/SOyX7JTCTCi5jo0bkInJH5xDft4XxnAeEB6O6tRlSA+eJhLdLELfsrPQsI5E31z9Lr
         XMAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+/EQMQ6v6vKQC+cnMv4I7AqJLmOpRFAqknb2KaBufw=;
        b=3fSjOfFjLkQ+igB0IDWUQXYzYGBCO+qxjQ0CrvYQ6HSqPZsiMLz0jBQXsqaa7DeH8C
         icw1Vcvi9lAwRIWYcZh/5m4K1E/15UMwLiYZbj6EhPdcuBPfzpWzm7Qx2m6Bbd/I44lv
         4YsSG34z1oqt5o04XOffqGss0X8K2hcXTginHcpA1mShImiDfwgnQplsZ/trCgPnnWlp
         f46/y3NV/GwWuf0CW+ok7pVI1KO7ntGyWgiZHnkICKwuyJVUdVNqcMOCDiKJDFZbTVmt
         +uFEJlyI2Riu0bI1mD+bAh0qWO3vG/Q+0L7Kv3b2qGJXZ1xawz7lxIW3ZJXkre9kHmdx
         V0nA==
X-Gm-Message-State: ANoB5pltVdC6Rclfk8sxkfhwJH3LtlVS5CvRTPxivMfkdDLUNTpfD7rO
        1FbIzRYwupQvdpomziLIYXM6E2kRGbM=
X-Google-Smtp-Source: AA0mqf6fsMxKQioWAUd516Om9ljJPoxVNeKeB7zysxTqGthKnmZOfHfs2tD4YnSbvz3xjXGwTKKzoA==
X-Received: by 2002:a62:1c95:0:b0:571:baf8:8945 with SMTP id c143-20020a621c95000000b00571baf88945mr5552876pfc.83.1668736639784;
        Thu, 17 Nov 2022 17:57:19 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id 185-20020a6214c2000000b005618189b0ffsm1840363pfu.104.2022.11.17.17.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:57:19 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v10 18/24] bpf: Add comments for map BTF matching requirement for bpf_list_head
Date:   Fri, 18 Nov 2022 07:26:08 +0530
Message-Id: <20221118015614.2013203-19-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118015614.2013203-1-memxor@gmail.com>
References: <20221118015614.2013203-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3823; i=memxor@gmail.com; h=from:subject; bh=8EB7pnYAGpY+fX6VZEMfDdMfcD0meo1AzSNti6SYLes=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjduXPHYID5GqJxo610atLK42sAOvTsiYCIccpKjAs EXQBal+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3blzwAKCRBM4MiGSL8Ryj78D/ 0SmynlTWWxSjK9lEOgpHynqIs55uHI1G+qSembCIap8LUarHg+f/vDxOBF5Nw4a5FfY4lqEKM7qxNL eHaJKi8VL+fbrFcA3CFftuNg6lx4l8HB4F5puvvcYxZtT6Zumf4LVje/6pIgaF3yp96fFhYaQs5cln VGZB8BExQSvE2HA+YyVKSBMY44sOfUJf+yr1PZX4YXpvXQkOnMjH1KrDh4CFt5BqNBnimpI0wxDHsL DXkTdM0znrEwmYTPzMGqxdjONfNoBF2x1FKWKxAuhe75ciEMoY4DKffi2pHaBpE7M9VzITNYym16ht KIqEnj9VcmahVW8r22EeqUgF3WXgfWSDir0UYjVyOUz1T3bjih5l8DYlLfXGcsmPWPXX7vPFEPcdlL KWhKArI2p7rMj+39qKkRWeoXT2oRWkeP5i9OA9ucUK5oyT3fpkR6PP6gXdXpcu+veMFezlIOlakmby vqrsw9yWQWH3kfKqtwtXH6UqOlSp5nioVusIyVmNHRbJbKbxbQxtePU3EBGCpuDNHkFKzX76W45QZ0 CllrnoQi3w2eEBeHjwiMOOV7206xVGSu5qVxslX7NB7FUmSpeJogQumVX7cLhK8hla1uQZuJfrzNUi j/GoU80ieQd7lHYtedrP2GYkKVGE1N+pzztfsoyIZwqmXMBS2FmTHOKCAj3g==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The old behavior of bpf_map_meta_equal was that it compared timer_off
to be equal (but not spin_lock_off, because that was not allowed), and
did memcmp of kptr_off_tab.

Now, we memcmp the btf_record of two bpf_map structs, which has all
fields.

We preserve backwards compat as we kzalloc the array, so if only spin
lock and timer exist in map, we only compare offset while the rest of
unused members in the btf_field struct are zeroed out.

In case of kptr, btf and everything else is of vmlinux or module, so as
long type is same it will match, since kernel btf, module, dtor pointer
will be same across maps.

Now with list_head in the mix, things are a bit complicated. We
implicitly add a requirement that both BTFs are same, because struct
btf_field_list_head has btf and value_rec members.

We obviously shouldn't force BTFs to be equal by default, as that breaks
backwards compatibility.

Currently it is only implicitly required due to list_head matching
struct btf and value_rec member. value_rec points back into a btf_record
stashed in the map BTF (btf member of btf_field_list_head). So that
pointer and btf member has to match exactly.

Document all these subtle details so that things don't break in the
future when touching this code.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/btf.c        |  3 +++
 kernel/bpf/map_in_map.c |  5 +++++
 kernel/bpf/syscall.c    | 14 ++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 4dcda4ae48c1..f7d5fab61535 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3648,6 +3648,9 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		return NULL;
 
 	cnt = ret;
+	/* This needs to be kzalloc to zero out padding and unused fields, see
+	 * comment in btf_record_equal.
+	 */
 	rec = kzalloc(offsetof(struct btf_record, fields[cnt]), GFP_KERNEL | __GFP_NOWARN);
 	if (!rec)
 		return ERR_PTR(-ENOMEM);
diff --git a/kernel/bpf/map_in_map.c b/kernel/bpf/map_in_map.c
index 7cce2047c6ef..38136ec4e095 100644
--- a/kernel/bpf/map_in_map.c
+++ b/kernel/bpf/map_in_map.c
@@ -68,6 +68,11 @@ struct bpf_map *bpf_map_meta_alloc(int inner_map_ufd)
 		}
 		inner_map_meta->field_offs = field_offs;
 	}
+	/* Note: We must use the same BTF, as we also used btf_record_dup above
+	 * which relies on BTF being same for both maps, as some members like
+	 * record->fields.list_head have pointers like value_rec pointing into
+	 * inner_map->btf.
+	 */
 	if (inner_map->btf) {
 		btf_get(inner_map->btf);
 		inner_map_meta->btf = inner_map->btf;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6140cbc3ed8a..35972afb6850 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -611,6 +611,20 @@ bool btf_record_equal(const struct btf_record *rec_a, const struct btf_record *r
 	if (rec_a->cnt != rec_b->cnt)
 		return false;
 	size = offsetof(struct btf_record, fields[rec_a->cnt]);
+	/* btf_parse_fields uses kzalloc to allocate a btf_record, so unused
+	 * members are zeroed out. So memcmp is safe to do without worrying
+	 * about padding/unused fields.
+	 *
+	 * While spin_lock, timer, and kptr have no relation to map BTF,
+	 * list_head metadata is specific to map BTF, the btf and value_rec
+	 * members in particular. btf is the map BTF, while value_rec points to
+	 * btf_record in that map BTF.
+	 *
+	 * So while by default, we don't rely on the map BTF (which the records
+	 * were parsed from) matching for both records, which is not backwards
+	 * compatible, in case list_head is part of it, we implicitly rely on
+	 * that by way of depending on memcmp succeeding for it.
+	 */
 	return !memcmp(rec_a, rec_b, size);
 }
 
-- 
2.38.1

