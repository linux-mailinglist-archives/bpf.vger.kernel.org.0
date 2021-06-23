Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2258E3B1877
	for <lists+bpf@lfdr.de>; Wed, 23 Jun 2021 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbhFWLKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Jun 2021 07:10:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230212AbhFWLJ4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 23 Jun 2021 07:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624446459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LUCuBp+kMAaiYhpJP43bLBOzgEXgjURSXqNOTfyeabU=;
        b=VWQt80RtVNXwPvukaon6UZmYZxuttdvGqFJ6Zu83iTc/IBWMTory0foFeSTa9pFl55KvOz
        CQ15IY4CqwTkuv3R/OaQ8ZzXL9wYdlno/B42hLWe1IbH730ZK+EEX60batRMIb3Ppx6DJB
        hOgzQrfPzdJfJWhNtFtLakpguSHKfuQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-NkKyRla2O7-tdDjjLQG48w-1; Wed, 23 Jun 2021 07:07:37 -0400
X-MC-Unique: NkKyRla2O7-tdDjjLQG48w-1
Received: by mail-ed1-f70.google.com with SMTP id j19-20020aa7c4130000b029039497d5cdbeso1088774edq.15
        for <bpf@vger.kernel.org>; Wed, 23 Jun 2021 04:07:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LUCuBp+kMAaiYhpJP43bLBOzgEXgjURSXqNOTfyeabU=;
        b=Kyg9Wq2WGW15imIDHb5sTvtAi0aZ7I9t//9/A0hm9pb00Bf0B/KSLLLU4CK8vngB2H
         Ione/5uBr5Vn0iAgEnke8dGB45it85Q2+sdNsFTlfyxKIawLY5FVHX+xyacC5DcLAEbe
         /gZ7X771/ksGPob6E7jr1JEt5MByFVBQzJAkE7Qku2al5r0EXx5YIkKRGNbjXylnjJM5
         rpt2GFYiwKdj0EfgB34YQ+5P67CCz11+6l6TXSptcR0McTiGv+r0D4CSG/aIYlnFZ1kW
         GPluX33yI8DYUtL4QcCirvSrG96EY/0zrjpdOsMCn9cF+D8Md4lz6bU3c3YzUIL/GAPs
         dC/g==
X-Gm-Message-State: AOAM532figUbi3qC1h/iL+fhfNyDJuIgT+bmSzcZz4gU43OpDcLK64bv
        cOGy1sZuyiRMRz1QejPyU2izLoK3EboPDFD8XXAl+L2zznH0XewLIQMHkZSCzgIUhaQWcBrwSkG
        Oc6/P/7TyelrI
X-Received: by 2002:a05:6402:34d1:: with SMTP id w17mr9016405edc.167.1624446456599;
        Wed, 23 Jun 2021 04:07:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzryCgWTnTknnV/8acg2toeAqckr6zU4GlElUrLt6wlnzWfynQHUxYeQyBdepxK81ABJex3bg==
X-Received: by 2002:a05:6402:34d1:: with SMTP id w17mr9016360edc.167.1624446456219;
        Wed, 23 Jun 2021 04:07:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w2sm7152669ejn.118.2021.06.23.04.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 04:07:30 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0CE81180733; Wed, 23 Jun 2021 13:07:28 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v4 03/19] doc: Give XDP as example of non-obvious RCU reader/updater pairing
Date:   Wed, 23 Jun 2021 13:07:11 +0200
Message-Id: <20210623110727.221922-4-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623110727.221922-1-toke@redhat.com>
References: <20210623110727.221922-1-toke@redhat.com>
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

