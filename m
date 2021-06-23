Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A43B2290
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 23:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbhFWVkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 17:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWVkP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Jun 2021 17:40:15 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B27C061574;
        Wed, 23 Jun 2021 14:37:57 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 9B26BC6459; Wed, 23 Jun 2021 22:37:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mess.org; s=2020;
        t=1624484274; bh=5bSB3kmpUKEJJoBtGPXTTqqjbJ+on9c7qoVfISkOcvY=;
        h=From:To:Subject:Date:From;
        b=X7qMHWcTqr/Kv+awYva64N0vetEoGBf6PZulHPcR0jv5Hh3q07Z1Rm4DVwGZyRnCP
         vhVUYSJs8YcKUYjDpqAVvF6iGqlEtYGPUT8cHsK2v5zoMRg4jQTyR6Q9ZO45zdktSv
         Gu9GpefzyFYOSvoK7B10N6GjXGUTGTJIykhZAguTY6TpN9ETnYE7CgO4oPKlUz/H+o
         bGal7Umy2xfLEIjLgjC3lK/j935xDTjRQsx/awdYogIYzWcv7QvfqWoNi/96JMf0Xo
         n4Svi7uRco1rFt145Hf5PULtPH6G4t/VFZgq5OBFtw5weO/LSKSVNHI3GJAQa38QUJ
         Fgjzppy+fT/aw==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org
Subject: [PATCH] media: bpf: do not copy more entries than user space requested
Date:   Wed, 23 Jun 2021 22:37:54 +0100
Message-Id: <20210623213754.632-1-sean@mess.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The syscall bpf(BPF_PROG_QUERY, &attr) should the prog_cnt field to see
how many entries user space provided and return ENOSPC if there are
more programs than that. Before this patch, this is not checked and
ENOSPC is never returned.

Note that one lirc device is limited to 64 bpf programs, and user space
I'm aware of -- ir-keytable -- always gives enough space for 64 entries
already. However, we should not copy program ids than are requested.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/bpf-lirc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index 3fe3edd80876..afae0afe3f81 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -326,7 +326,8 @@ int lirc_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 	}
 
 	if (attr->query.prog_cnt != 0 && prog_ids && cnt)
-		ret = bpf_prog_array_copy_to_user(progs, prog_ids, cnt);
+		ret = bpf_prog_array_copy_to_user(progs, prog_ids,
+						  attr->query.prog_cnt);
 
 unlock:
 	mutex_unlock(&ir_raw_handler_lock);
-- 
2.31.1

