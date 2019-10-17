Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD3D6DAAA2
	for <lists+bpf@lfdr.de>; Thu, 17 Oct 2019 12:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393206AbfJQK5j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Oct 2019 06:57:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391748AbfJQK5j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Oct 2019 06:57:39 -0400
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA8A059465
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 10:57:38 +0000 (UTC)
Received: by mail-lf1-f70.google.com with SMTP id w22so443161lfe.2
        for <bpf@vger.kernel.org>; Thu, 17 Oct 2019 03:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kezZw0VFhVGBEMPCig/DPA9y2lxJvXSGmWxoBGinw5Y=;
        b=h3qHZBGGbZ5SKSKk2yFxCR1H4k75ztwnYkqiwmtXbktf7/hCoakxmDlyVrdiS3kgaG
         LhNNBLC9CI5KtdR8g6ozUpBH+rXYZCugAPimlELeeVnBTMfZaHfUDBdJntt2odIesL16
         JlaboU0UR/Y5EYI4pT9b5ic9rh4iEiHxv/XkkpGz5UzUFmbvLOex24OaecgZzgXYW81S
         Wlo1bYakw+7J3u1CspdQpFLUOb6aRrnkWZyZyaDj8n3CXuhPabe05fcsr59DHW2tifiD
         pMBouvHYlyLfmcIHFZDnh1S8NIASn/JLE2pcAn6LQU5eDTGHq+xK6frggPebzU6d8u9V
         jPxw==
X-Gm-Message-State: APjAAAWBd71P02G4ETJRb9aHAr2mcJPgckcUxXYDEnOPcHQ0N2iVjLYf
        cA9Gg+PcqZh0UgLjpR8zqNSpTDkdAVXkLJn22pmMbdE9nwI2vfSGwjCXKgOg/Nf1RVIMc/hFr7M
        OzwRdkJkCxKhN
X-Received: by 2002:a2e:9ec2:: with SMTP id h2mr1830675ljk.85.1571309857308;
        Thu, 17 Oct 2019 03:57:37 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz7h3YTZLvx8yewp5Kz0jpKYMIgckwP5kCjDQA/6jecPQ5hGooQV7FeNSpSkOwrR0C5D2X68w==
X-Received: by 2002:a2e:9ec2:: with SMTP id h2mr1830665ljk.85.1571309857121;
        Thu, 17 Oct 2019 03:57:37 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id n8sm906804lfk.21.2019.10.17.03.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 03:57:36 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 732901804C9; Thu, 17 Oct 2019 12:57:35 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH bpf] xdp: Prevent overflow in devmap_hash cost calculation for 32-bit builds
Date:   Thu, 17 Oct 2019 12:57:02 +0200
Message-Id: <20191017105702.2807093-1-toke@redhat.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Tetsuo pointed out that without an explicit cast, the cost calculation for
devmap_hash type maps could overflow on 32-bit builds. This adds the
missing cast.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/devmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a0a1153da5ae..e34fac6022eb 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -128,7 +128,7 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 
 		if (!dtab->n_buckets) /* Overflow check */
 			return -EINVAL;
-		cost += sizeof(struct hlist_head) * dtab->n_buckets;
+		cost += (u64) sizeof(struct hlist_head) * dtab->n_buckets;
 	}
 
 	/* if map size is larger than memlock limit, reject it */
-- 
2.23.0

