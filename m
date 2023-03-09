Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243C26B1F07
	for <lists+bpf@lfdr.de>; Thu,  9 Mar 2023 09:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjCII5b (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Mar 2023 03:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjCII5K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Mar 2023 03:57:10 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5471725;
        Thu,  9 Mar 2023 00:56:06 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4PXN8N0W56z9xrss;
        Thu,  9 Mar 2023 16:46:44 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
        by APP2 (Coremail) with SMTP id GxC2BwBHE1rqnglk6JWBAQ--.23851S2;
        Thu, 09 Mar 2023 09:55:14 +0100 (CET)
From:   Roberto Sassu <roberto.sassu@huaweicloud.com>
To:     zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v3 0/3] security: Always enable integrity LSM
Date:   Thu,  9 Mar 2023 09:54:30 +0100
Message-Id: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBHE1rqnglk6JWBAQ--.23851S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryrtFW7Kw13tFykGw17Jrb_yoW8Jw4DpF
        sFgay5Kr48AFWS9F93Aa1I9a4akFZaqryUWrZxGw18Xa4rury0qFWIyw18CryUJrsYy3WS
        gF12vr1ruw1qyrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvqb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
        n4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
        0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
        tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
        CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0x
        ZFpf9x07jxqXdUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBF1jj4pctgAAsf
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

Changelog:

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
 security/Kconfig          | 10 +++++-----
 security/integrity/iint.c |  9 +--------
 security/security.c       | 12 +++++++++---
 4 files changed, 16 insertions(+), 16 deletions(-)

-- 
2.25.1

