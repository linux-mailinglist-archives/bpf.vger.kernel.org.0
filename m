Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299C263AB62
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 15:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbiK1Ond (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Nov 2022 09:43:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232616AbiK1OnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Nov 2022 09:43:11 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4226AF3D;
        Mon, 28 Nov 2022 06:43:09 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NLShl3G7Cz9xGXF;
        Mon, 28 Nov 2022 22:36:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP1 (Coremail) with SMTP id LxC2BwC3oG3iyIRjL9qiAA--.42928S2;
        Mon, 28 Nov 2022 15:42:49 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     paul@paul-moore.com, casey@schaufler-ca.com, omosnace@redhat.com,
        john.johansen@canonical.com, kpsingh@kernel.org
Cc:     bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v2 0/2] lsm: Improve LSM hooks documentation
Date:   Mon, 28 Nov 2022 15:42:38 +0100
Message-Id: <20221128144240.210110-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwC3oG3iyIRjL9qiAA--.42928S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4DXw43JF45WF1DAw4UXFb_yoW8XF47pa
        yrGw45JryrAr1xurs3Kw48A3yFyFWrGF1DJrW7Grn5urWjyr1Fkr4Skw1Fgas8CF9xKa4q
        qF12vry5urnrA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcV
        CF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jzQ6JUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBF1jj4X7EgABsT
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

The recent discussion about return values from LSM hooks, available here:

https://lore.kernel.org/bpf/20221115175652.3836811-1-roberto.sassu@huaweicloud.com/

motivated revisiting the documentation in include/linux/lsm_hooks.h, to
ensure that it is complete and accurate. It was also a good occasion to fix
discovered formatting issues.

Changelog:

v1 (security: Ensure LSMs return expected values):
- A positive value, not only 1 can cause cap_set_admin to be set when
  calling __vm_enough_memory() (reported by Paul)
- Improve description of the vm_enough_memory hook
- Remove documentation of the sb_add_mnt_opt hook, as it was removed
  (reported by Paul)
- Add more periods in the parameters description
- Adjust mmap_addr and mmap_file semicolon
- Move description of gfp parameter of xfrm_policy_alloc_security together
  with the others
- Add missing return value description for binder_transaction,
  binder_transfer_binder, binder_transfer_file, quotactl and quota_on
- Improve return value description for sb_eat_lsm_opts, sb_show_options,
  dentry_init_security, dentry_create_files_as and sctp_assoc_established

Roberto Sassu (2):
  lsm: Clarify documentation of vm_enough_memory hook
  lsm: Add/fix return values in lsm_hooks.h and fix formatting

 include/linux/lsm_hooks.h | 227 ++++++++++++++++++++++++--------------
 1 file changed, 143 insertions(+), 84 deletions(-)

-- 
2.25.1

