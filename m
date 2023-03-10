Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF4A6B3966
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 10:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjCJJBT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 04:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjCJJAw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 04:00:52 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44891F601E;
        Fri, 10 Mar 2023 00:54:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PY04p6NqLz9v7H9;
        Fri, 10 Mar 2023 16:45:46 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwDnbmUy8ApkK+yFAQ--.17497S2;
        Fri, 10 Mar 2023 09:54:18 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v4 0/3] security: Always enable integrity LSM
Date:   Fri, 10 Mar 2023 09:53:58 +0100
Message-Id: <20230310085401.1964889-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDnbmUy8ApkK+yFAQ--.17497S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryrtFW7Kw13tFykGw17Jrb_yoW8XFWkpF
        nIgay5Kr48AFWS9F93Aa1fua43Ca93tryUWrZxJw18XayrC340qFZ2kw48CryDJrsYy3WS
        gr12vr1ruw1qyrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l42xK82IY
        c2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0x
        vE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAMBF1jj4ZrTwABsY
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Roberto Sassu <roberto.sassu@huawei.com>

Since the integrity (including IMA and EVM) functions are currently always
called by the LSM infrastructure, and always after all LSMs, formalize
these requirements by introducing a new LSM ordering called LSM_ORDER_LAST,
and set it for the 'integrity' LSM (patch 1).

Consequently, revert commit 92063f3ca73a ("integrity: double check
iint_cache was initialized"), as the double check becomes always verified
(patch 2), and remove 'integrity' from the list of LSMs in
security/Kconfig (patch 3).

Changelog

v3:
- Remove Signed-off-by tag by Mimi (suggested by Paul)
- Clarify that an LSM with order LSM_ORDER_FIRST or LSM_ORDER_LAST is
  always enabled if it is selected in the kernel configuration (suggested
  by Paul)

v2:
- Fix commit message in patch 1 (suggested by Mimi)
- Bump version of patch 2 (v1 -> v3) to make one patch set
- Add patch 3 (suggested by Mimi)

v1:
- Add comment for LSM_ORDER_LAST definition (suggested by Mimi)
- Add Fixes tag (suggested by Mimi)
- Do minor corrections in the commit messages (suggested by Mimi and
  Stefan)

Roberto Sassu (3):
  security: Introduce LSM_ORDER_LAST and set it for the integrity LSM
  Revert "integrity: double check iint_cache was initialized"
  security: Remove integrity from the LSM list in Kconfig

 include/linux/lsm_hooks.h |  1 +
 security/Kconfig          | 16 +++++++++-------
 security/integrity/iint.c |  9 +--------
 security/security.c       | 12 +++++++++---
 4 files changed, 20 insertions(+), 18 deletions(-)

-- 
2.25.1

