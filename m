Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF34562E8D7
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 23:56:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbiKQW4Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 17:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235006AbiKQW4X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 17:56:23 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4306E13E28
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:23 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id q1so3417571pgl.11
        for <bpf@vger.kernel.org>; Thu, 17 Nov 2022 14:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+/EQMQ6v6vKQC+cnMv4I7AqJLmOpRFAqknb2KaBufw=;
        b=e48V6+gU/vIThtAGOEgcwMEyDvj5XVgjRVtnEOXaIqbu33PWscy+irLA98JrLXckrh
         08EPT82TWB1iRFcIt697+rHJQ4Z0zDAgnJVGz9Ew5y5Qm0pkwg5HMsaz9p4g2H8i4vaj
         13HGhUcT2MQfilNQa2uA3zuFRh97iP++HF7IgHX/ROsKsGD8qQAvNWTAG3LfKEGUULfK
         q3imQM2uTaXHwhtjEPqvQkHSVuh7KecaeQwJ7vJjJnSrKye/8uZtTZiFkX8aDx6ZU1N6
         oHHqkhVcSrPuttWNYMCuTg05BPc7+ZTJxlpFrdKTpMP0V6Qj+EZTLlCoN7ajovmW0vU9
         3YPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+/EQMQ6v6vKQC+cnMv4I7AqJLmOpRFAqknb2KaBufw=;
        b=1mvzhi0yUYodbzvH6LYDem3G51aefzxCtXzY9NUDNhLf7ZNe2zGQBX0fvTYJlc5baf
         1c1WQK0W/LjKcNbmOoHcboe9rhYXcihkpz4wK9kgo5DuYJIdo9DqDKbNXNDaMcuZqTH4
         ijdtOLCUTMVWvTLMl/0wgsmheV0XmdJ4TXjs5+cPLD8PuUWxQEp+wCQURCxEML+BEcVR
         vJTM2zR9QFnMMOPV2/km8EWnHBufSHJfyE44XPY+60k3JmiJAxbPQVXZvCdFhlofdq3A
         giLOVYzjV16AaeR+AaqiNR6Z45pP8YLz3f9ZHXQV7HEJa/rT2CFKskcAECVU0nTcbJuT
         dwrQ==
X-Gm-Message-State: ANoB5pl02NL9ASEBgs8GJtB0uokMRIjx9TO5/R5eXrU3+9Oyn8XiVhNg
        RCEbtom+10fy1fPvwL6kjLeMsq9CV0Q=
X-Google-Smtp-Source: AA0mqf40zjE+cU9gVPNha2BtcEUkon2X3MxWzW42Phj4KT40bwPwbxWr+NBQEzsM/QHlIAMUymlVSg==
X-Received: by 2002:aa7:80d8:0:b0:56d:98e3:4df8 with SMTP id a24-20020aa780d8000000b0056d98e34df8mr4940804pfn.37.1668725782556;
        Thu, 17 Nov 2022 14:56:22 -0800 (PST)
Received: from localhost ([2409:40f4:8:955c:5484:8048:c08:7b3])
        by smtp.gmail.com with ESMTPSA id x15-20020aa78f0f000000b0056be4dbd4besm1686151pfr.111.2022.11.17.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:56:22 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>
Subject: [PATCH bpf-next v9 18/23] bpf: Add comments for map BTF matching requirement for bpf_list_head
Date:   Fri, 18 Nov 2022 04:25:05 +0530
Message-Id: <20221117225510.1676785-19-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117225510.1676785-1-memxor@gmail.com>
References: <20221117225510.1676785-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3823; i=memxor@gmail.com; h=from:subject; bh=8EB7pnYAGpY+fX6VZEMfDdMfcD0meo1AzSNti6SYLes=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjdrkcHYID5GqJxo610atLK42sAOvTsiYCIccpKjAs EXQBal+JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY3a5HAAKCRBM4MiGSL8Ryq7XEA CSVv3NffGxmL80Clwu6ZiZ4QiYc6ErHRlC7SgSwxLj1iN/2ZttRb+MOxiK5oPSgH9vyWrZnLD7q6jd VsiQXwfjXpBSbvb/T4PQZKXnoJA0HG/74CcTbABvO3XL4HSOc646Oc+0FBBCV67UrDDgl8CgEcaEfG GbbOyVTbt01I3H1SFwQGXqW2h/ei5us8EDIvsFgB9BlG+lUgSgS62694AjJU4AUUh7psNMRDh2Cp5N XIft6O1ObFJw0X6VxCMFTxVOPXZRi++7ooMoOX6XstqM6WFlIM6R/CEBEXF31G7luBMuzieSxYFHUB pWDWaSMwMOPvxgwHYfSZxe0KfmAoqEHxVS8ut9PPUhKSP6eQx4Cl+WpP/UbGs8dxBrmyTUeN3+NHWJ Xm05iE4c42/n6a9b4w3vBBKuOXzalSilwEHcrxwcMkM63zVM+hVtUGn1QWcJVoRWVXtpQX/N5O7TDQ 0ybAdAfisW6FxnWrsqvxdRE/C8cV12PRDZYbVOVtgiGDGKu9o2rLeUDNY1sxkzLt5tphwlqUvH5NZW I4Eh0lLEWliMBWPZBz2EeMh3mqNUwRLIjKTY6hDzjqNsOGNtNM3e3UT3EcxsdXfd2vvzPy5i0DGXLy ruDHnbG33T4ZqVeyiKbs5sTrJIytOo8cURcL3qnfsZW4OX5TEZ8pACiGYplg==
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

