Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8B65A83B2
	for <lists+bpf@lfdr.de>; Wed, 31 Aug 2022 18:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiHaQ5C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 31 Aug 2022 12:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232346AbiHaQ4q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 31 Aug 2022 12:56:46 -0400
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F783A6C73;
        Wed, 31 Aug 2022 09:56:40 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4MHqv50vc7z9xrp5;
        Thu,  1 Sep 2022 00:51:13 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBX0lxfkg9jJXIRAA--.5993S7;
        Wed, 31 Aug 2022 17:56:11 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, mykolal@fb.com,
        dhowells@redhat.com, jarkko@kernel.org, rostedt@goodmis.org,
        mingo@redhat.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, shuah@kernel.org
Cc:     bpf@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        deso@posteo.net, memxor@gmail.com,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v15 05/12] KEYS: Move KEY_LOOKUP_ to include/linux/key.h and define KEY_LOOKUP_ALL
Date:   Wed, 31 Aug 2022 18:54:38 +0200
Message-Id: <20220831165445.1071641-6-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220831165445.1071641-1-roberto.sassu@huaweicloud.com>
References: <20220831165445.1071641-1-roberto.sassu@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBX0lxfkg9jJXIRAA--.5993S7
X-Coremail-Antispam: 1UD129KBjvJXoW7urW3JFW3Xr43XF4UZry7Jrb_yoW8Zw1rpF
        WDG3W8KryUCry2g34kGanFy3WfK39xGr17JFZ0gwn09F4Fq3y8tr1xKF47uF1YyrW5ury2
        qr429F4Uuw1DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUPlb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262
        kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s02
        6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
        v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
        c7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aV
        AFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07j7GYLUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBF1jj357FAAAsn
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for the patch that introduces the bpf_lookup_user_key() eBPF
kfunc, move KEY_LOOKUP_ definitions to include/linux/key.h, to be able to
validate the kfunc parameters. Add them to enum key_lookup_flag, so that
all the current ones and the ones defined in the future are automatically
exported through BTF and available to eBPF programs.

Also, add KEY_LOOKUP_ALL to the enum, to facilitate checking whether a
variable contains only defined flags.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: KP Singh <kpsingh@kernel.org>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 include/linux/key.h      | 6 ++++++
 security/keys/internal.h | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index 7febc4881363..d84171f90cbd 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -88,6 +88,12 @@ enum key_need_perm {
 	KEY_DEFER_PERM_CHECK,	/* Special: permission check is deferred */
 };
 
+enum key_lookup_flag {
+	KEY_LOOKUP_CREATE = 0x01,	/* Create special keyrings if they don't exist */
+	KEY_LOOKUP_PARTIAL = 0x02,	/* Permit partially constructed keys to be found */
+	KEY_LOOKUP_ALL = (KEY_LOOKUP_CREATE | KEY_LOOKUP_PARTIAL), /* OR of previous flags */
+};
+
 struct seq_file;
 struct user_struct;
 struct signal_struct;
diff --git a/security/keys/internal.h b/security/keys/internal.h
index 9b9cf3b6fcbb..3c1e7122076b 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -165,8 +165,6 @@ extern struct key *request_key_and_link(struct key_type *type,
 
 extern bool lookup_user_key_possessed(const struct key *key,
 				      const struct key_match_data *match_data);
-#define KEY_LOOKUP_CREATE	0x01
-#define KEY_LOOKUP_PARTIAL	0x02
 
 extern long join_session_keyring(const char *name);
 extern void key_change_session_keyring(struct callback_head *twork);
-- 
2.25.1

