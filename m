Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 225433B3370
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbhFXQIe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:08:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40173 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229464AbhFXQIe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:08:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624550774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUCuBp+kMAaiYhpJP43bLBOzgEXgjURSXqNOTfyeabU=;
        b=JmrPqsFgURE259U5zE8lU1miRHz0EmEWmW4zXP4xtxUJIMU2dzEbjYNQIa+3cyTWIghH7g
        luCIQYIqFLH5VjfKJ459G8BsnmLSiRKOuwAEEneMnzC8TuHZWeIfncr9YUzbmAu2kCcJ97
        M89X8KfrgxfGVOWO0QIp+FSgiQi86Y0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-T_WI8_d9N4-aseZLq_fXqQ-1; Thu, 24 Jun 2021 12:06:13 -0400
X-MC-Unique: T_WI8_d9N4-aseZLq_fXqQ-1
Received: by mail-ed1-f71.google.com with SMTP id m4-20020a0564024304b0290394d27742e4so3580132edc.10
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUCuBp+kMAaiYhpJP43bLBOzgEXgjURSXqNOTfyeabU=;
        b=iUrP6ynpCMey6/+dC6r6Q9fs8PH614JSsGS9fuXCeG648IzYNauEnUsKGNhWoOnSeN
         q8sBhvQLV9sh417YV7pRLe3YMi3R3s6hl3f4ktGRS1qTMPE9BUSEVCLVkWZf/0LcF7v1
         cX3dCVBhfEtVbzpC80FFJjp+3ABPQGRU3vVSzt99EuBfuzEfyhhX0FJ0HpToPKa+x/JR
         ilmy7vsFQnoW+Zs6MY+yfDjuPeMihpBgEJYcuDFJ6o7sqIKyRyzFTCUy56SdbF2szfvQ
         FPrB2myceGPh06aQf1AItWs1Ho716V45gYA7gVjCfHAHaYmULBltvuh/qt5h/Gb01E4N
         uUkg==
X-Gm-Message-State: AOAM530kbbVGcsrvn6grv7j04jT2UTgBq7jh6qefE9IDSH9F/FicqHuO
        up/DYf5F+3cRC9Ys9iNSmBSxZZTnOl99cF74e6nPhz1YE6JxwBSrQpI4LliP74rRdbEpZzc+AO0
        bVhiRztZMhV9d
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr6096706ejc.326.1624550771948;
        Thu, 24 Jun 2021 09:06:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz55VnSDUxxZZ06Nn0vmqQ6jiFhvp9YY16kWSNeRKwWhkFZsY6OEmU/ZAjLIAB99qnGX5fy9w==
X-Received: by 2002:a17:907:628a:: with SMTP id nd10mr6096659ejc.326.1624550771402;
        Thu, 24 Jun 2021 09:06:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ci3sm1445516ejc.0.2021.06.24.09.06.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:06:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 3FAA8180734; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v5 03/19] doc: Give XDP as example of non-obvious RCU reader/updater pairing
Date:   Thu, 24 Jun 2021 18:05:53 +0200
Message-Id: <20210624160609.292325-4-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624160609.292325-1-toke@redhat.com>
References: <20210624160609.292325-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This commit gives an example of non-obvious RCU reader/updater pairing
in the guise of the XDP feature in networking, which calls BPF programs
from network-driver NAPI (softirq) context.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Documentation/RCU/checklist.rst | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 07f6cb8f674d..01cc21f17f7b 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -236,8 +236,15 @@ over a rather long period of time, but improvements are always welcome!
 
 	Mixing things up will result in confusion and broken kernels, and
 	has even resulted in an exploitable security issue.  Therefore,
-	when using non-obvious pairs of primitives, commenting is of
-	course a must.
+	when using non-obvious pairs of primitives, commenting is
+	of course a must.  One example of non-obvious pairing is
+	the XDP feature in networking, which calls BPF programs from
+	network-driver NAPI (softirq) context.	BPF relies heavily on RCU
+	protection for its data structures, but because the BPF program
+	invocation happens entirely within a single local_bh_disable()
+	section in a NAPI poll cycle, this usage is safe.  The reason
+	that this usage is safe is that readers can use anything that
+	disables BH when updaters use call_rcu() or synchronize_rcu().
 
 8.	Although synchronize_rcu() is slower than is call_rcu(), it
 	usually results in simpler code.  So, unless update performance is
-- 
2.32.0

