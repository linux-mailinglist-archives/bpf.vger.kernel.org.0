Return-Path: <bpf+bounces-9554-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B39D799155
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 23:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 692C01C20CBF
	for <lists+bpf@lfdr.de>; Fri,  8 Sep 2023 21:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB7330FA9;
	Fri,  8 Sep 2023 21:00:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C621C39
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 21:00:12 +0000 (UTC)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C175DC
	for <bpf@vger.kernel.org>; Fri,  8 Sep 2023 14:00:10 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-68bef1614e3so3389393b3a.3
        for <bpf@vger.kernel.org>; Fri, 08 Sep 2023 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694206810; x=1694811610; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bddCSM3skZGvKtQFslQ+yQF/46KHkBCwOJAZz1C1rA4=;
        b=3HS09LpDs3+AL091EPG9uwf47rNN/uwbxGIVnGN6vFNRDc2hC0aP3ZokYC81gr7EO+
         tlXhbwhrECIvdjJCzBxU6FxfjcLUR6fG0bkqxdTVolkekHJ/v1X05FU0/KjqFyniTqOf
         BNVVENwcuEOxPxq1RHkqX9DiYmCABSYtQAKlJizj5o6nofXfB+7j+o/kq56p1QgBUVt/
         Pc3yxIFRNwRCjhL1akpfNbCoQ/KJO8d1jPuZVjG8ULycI6HQ4ka5R7MmDpH+ElUbNGqS
         PCxB+BSgO2tVQw38JC4DoQZegvnv5XhiLx9cDKshR1mE+sIfYUQ5zNms/16OgENTKVMe
         mktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694206810; x=1694811610;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bddCSM3skZGvKtQFslQ+yQF/46KHkBCwOJAZz1C1rA4=;
        b=CFb01Pcly4YCMNerTD8G89Hjm/KXkR7AW2Cbb/E1I1rewX3sJovoaBwVvEX0V7avdJ
         LPyz7JzRgS7XM7ZfwwMkL23tY1sJKMHxsqT+A/bnlFOAatGZOGCfi/qtoDthUJOmoLZo
         eufsnS1NT/i37GbkQH/mZubuKafHQAuwpcRl3zSydLl00kqhF0ESsl2AtWfhF3/Xy17z
         X7l24kW4IDQbu814B1dp64FylUx8BmIZiRgLMmYvkZQMeNa5rao8njEW3bi3EyoVhEu7
         /NkWXJAoJvCZinRskZUmQQnUn5mIR5sWdeitVIjKcOMlUvd33smXptmIKZJZTKRDdTtf
         5Qeg==
X-Gm-Message-State: AOJu0YzoUwunP21kTJSpX6hkjqC8wJCIwe1O6ZEihz2R0qVTYK+fc8bR
	3eTYPUSaiM190svViLSiSvnIiAYGlhup/dLyqT9YKI5MINlCOQ9xDi2dmGF+005r42soxKEH6Ma
	A4jeh36Fj8HeW9CBtEtLmxOans0nOfd9PFGH+45Y9OfQwKRhWPg==
X-Google-Smtp-Source: AGHT+IHdNEnc3xJEy0SUWqaYeljGn5OhfMxIZN6gNHoWXhJQvuCZV6OcMMVQfjDB64yh8pskIxDpMJ4=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:1408:b0:68e:26f2:6c8 with SMTP id
 l8-20020a056a00140800b0068e26f206c8mr1398991pfu.1.1694206809720; Fri, 08 Sep
 2023 14:00:09 -0700 (PDT)
Date: Fri,  8 Sep 2023 14:00:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908210007.1469091-1-sdf@google.com>
Subject: [PATCH bpf-next 1/2] bpf: return correct -ENOBUFS from bpf_clone_redirect
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
packets") exposed the fact that bpf_clone_redirect is capable of
returning raw NET_XMIT_XXX return codes.

This is in the conflict with its UAPI doc which says the following:
"0 on success, or a negative error in case of failure."

Let's wrap dev_queue_xmit's return value (in __bpf_tx_skb) into
net_xmit_errno to make sure we correctly propagate NET_XMIT_DROP
as -ENOBUFS instead of 1.

Note, this is technically breaking existing UAPI where we used to
return 1 and now will do -ENOBUFS. The alternative is to
document that bpf_clone_redirect can return 1 for DROP and 2 for CN.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 net/core/filter.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index a094694899c9..9e297931b02f 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2129,6 +2129,9 @@ static inline int __bpf_tx_skb(struct net_device *dev, struct sk_buff *skb)
 	ret = dev_queue_xmit(skb);
 	dev_xmit_recursion_dec();
 
+	if (ret > 0)
+		ret = net_xmit_errno(ret);
+
 	return ret;
 }
 
-- 
2.42.0.283.g2d96d420d3-goog


