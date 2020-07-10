Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E02721BC42
	for <lists+bpf@lfdr.de>; Fri, 10 Jul 2020 19:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgGJRb2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Jul 2020 13:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgGJRb1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Jul 2020 13:31:27 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34329C08C5DD
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 10:31:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id z24so7342930ljn.8
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2020 10:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyfTdRlvk48RQpqSlUdGDYUN+fsDlxTcrasOugfbANc=;
        b=x+2nod6w620w+mmkB2g/fFt25HghB479+SfBq260cDwG7PbrBne3LXAydGZcHveT5R
         Jx3xiWopndxVdjl5OXUWeURsEVQnPEHQwBux8zX30DiA8aCeVe2R/G2QamJBtK8bJ2bl
         5551VcKA31VlCqSsBES6Tw6JS1Y/zWeRy+hNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gyfTdRlvk48RQpqSlUdGDYUN+fsDlxTcrasOugfbANc=;
        b=Z5MSycJROL2LsCdeoSs1JEJ/FSpfwLM8YJ+MR4NTdSraqPsMIg13qwqPTLeq/3lJjO
         0cD6b3PXb3p9aPMHsbluoMiFmcuL6Dr2ATCdgAnVWvonmW28CTxRa9cDvmvomctIEmyu
         NsYsWui3ypQY1nIaWTU1a6N43b20fzf80Mu4RfckbtfGt6Lc83jYD018RSKHDeTX8uUy
         75/oW+ea8IOjFfRlb3y3XR34qQHlaQvhWXT0wdIwVJTelKzN3mAQCiIhGGjMKpJMf/bf
         7xa7SuXwRs5eeJT1yGJb5g1dK/USh7jQtHMuKbzPHUR82D2FXAvx79bTgPmNU/aqX19w
         cQkg==
X-Gm-Message-State: AOAM531Cl8AtYbi73dYPoe+HghP4RizjG+bjpuGZJ578E24jm27DTKbH
        4aps3X21Zn4U11K7F1GdLiN26Q4UVC++qg==
X-Google-Smtp-Source: ABdhPJwiW5/0iXpjKSrSMd+naWu3dJ131Mf9XFQks4Y1LJ9nUvZY4l5DT1BK+HgOtDZI+sWOS21KHQ==
X-Received: by 2002:a2e:8851:: with SMTP id z17mr37208115ljj.225.1594402285156;
        Fri, 10 Jul 2020 10:31:25 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id n9sm2381111lfd.60.2020.07.10.10.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:31:24 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH bpf] bpf: Shift and mask loads narrower than context field size
Date:   Fri, 10 Jul 2020 19:31:23 +0200
Message-Id: <20200710173123.427983-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When size of load from context is the same as target field size, but less
than context field size, the verifier does not emit the shift and mask
instructions for loads at non-zero offset.

This has the unexpected effect of loading the same data no matter what the
offset was. While the expected behavior would be to load zeros for offsets
that are greater than target field size.

For instance, u16 load from u32 context field backed by u16 target field at
an offset of 2 bytes results in:

  SEC("sk_reuseport/narrow_half")
  int reuseport_narrow_half(struct sk_reuseport_md *ctx)
  {
  	__u16 *half;

  	half = (__u16 *)&ctx->ip_protocol;
  	if (half[0] == 0xaaaa)
  		return SK_DROP;
  	if (half[1] == 0xbbbb)
  		return SK_DROP;
  	return SK_PASS;
  }

  int reuseport_narrow_half(struct sk_reuseport_md * ctx):
  ; int reuseport_narrow_half(struct sk_reuseport_md *ctx)
     0: (b4) w0 = 0
  ; if (half[0] == 0xaaaa)
     1: (79) r2 = *(u64 *)(r1 +8)
     2: (69) r2 = *(u16 *)(r2 +924)
  ; if (half[0] == 0xaaaa)
     3: (16) if w2 == 0xaaaa goto pc+5
  ; if (half[1] == 0xbbbb)
     4: (79) r1 = *(u64 *)(r1 +8)
     5: (69) r1 = *(u16 *)(r1 +924)
     6: (b4) w0 = 1
  ; if (half[1] == 0xbbbb)
     7: (56) if w1 != 0xbbbb goto pc+1
     8: (b4) w0 = 0
  ; }
     9: (95) exit

In this case half[0] == half[1] == sk->sk_protocol that backs the
ctx->ip_protocol field.

Fix it by shifting and masking any load from context that is narrower than
context field size (is_narrower_load = size < ctx_field_size), in addition
to loads that are narrower than target field size.

The "size < target_size" check is left in place to cover the case when a
context field is narrower than its target field, even if we might not have
such case now. (It would have to be a u32 context field backed by a u64
target field, with context fields all being 4-bytes or wider.)

Going back to the example, with the fix in place, the upper half load from
ctx->ip_protocol yields zero:

  int reuseport_narrow_half(struct sk_reuseport_md * ctx):
  ; int reuseport_narrow_half(struct sk_reuseport_md *ctx)
     0: (b4) w0 = 0
  ; if (half[0] == 0xaaaa)
     1: (79) r2 = *(u64 *)(r1 +8)
     2: (69) r2 = *(u16 *)(r2 +924)
     3: (54) w2 &= 65535
  ; if (half[0] == 0xaaaa)
     4: (16) if w2 == 0xaaaa goto pc+7
  ; if (half[1] == 0xbbbb)
     5: (79) r1 = *(u64 *)(r1 +8)
     6: (69) r1 = *(u16 *)(r1 +924)
     7: (74) w1 >>= 16
     8: (54) w1 &= 65535
     9: (b4) w0 = 1
  ; if (half[1] == 0xbbbb)
    10: (56) if w1 != 0xbbbb goto pc+1
    11: (b4) w0 = 0
  ; }
    12: (95) exit

Fixes: f96da09473b5 ("bpf: simplify narrower ctx access")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 94cead5a43e5..1c4d0e24a5a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9760,7 +9760,7 @@ static int convert_ctx_accesses(struct bpf_verifier_env *env)
 			return -EINVAL;
 		}
 
-		if (is_narrower_load && size < target_size) {
+		if (is_narrower_load || size < target_size) {
 			u8 shift = bpf_ctx_narrow_access_offset(
 				off, size, size_default) * 8;
 			if (ctx_field_size <= 4) {
-- 
2.25.4

