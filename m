Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29DE3B337A
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbhFXQIo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:08:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47949 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230296AbhFXQIk (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624550780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ESlzoBrCtV1p5Bz5L61JWXgmG5edOzrWTpf13f6lwsQ=;
        b=Y+2T2xE46Swz6ibryGYKTYGEUvoWDzLyE3fGyM9K570YA4DAOnNuNyM5ogxTpazGxxKfBg
        shVVC7ImaSV7e5o2AnIfczT+cHEVHowVqmQbCh9+5houI1s2mrTq5yBUQTmt1JYvqxxWRX
        WrSBV2a6XCkM/lObgdgLUlz8V3CSmrQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-rCUnMlmIN7uY29pn-iii4g-1; Thu, 24 Jun 2021 12:06:19 -0400
X-MC-Unique: rCUnMlmIN7uY29pn-iii4g-1
Received: by mail-ej1-f71.google.com with SMTP id c13-20020a17090603cdb029049617c6be8eso2169025eja.19
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:06:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ESlzoBrCtV1p5Bz5L61JWXgmG5edOzrWTpf13f6lwsQ=;
        b=JiQy0XztSpBeVhftkT8XhaHhHooNpvpSK6hm/BFNTlGv2se2a9z/Z9bUKonls5vCF/
         8Vx0cYu5/FAM7lGkruVWboll6GF79XYXi4kd3m/q/JPV+5pLPh/Blt5O3eoqsssptjOk
         oxFjCf7YMAU3gvbHCJkurSbZ3wGyJbSJ0icZ4NtELjJna5eHVqRJVHm9ElI15UHwmn2T
         AhqEUxUaq9OEpsGY7Ohc1kLBFIxbE6NJ2Ao6UAGBkJ91YsOV0Mw+AQC3bED5cG2zHyzY
         VPkP2bIzTf6KZTlP10DnzPFASOOHU1xx7X/R2eKqtxuU9rkPBu8v12Gno8rb6d26yg1H
         YxOg==
X-Gm-Message-State: AOAM532k9I7PH3M3XET0Q1JX5FFBYeIs/LnTdzjfcWLXLx1zCJFzRr4R
        tRtuB7tCcPnu8neCJh/izu4tmSMPZlG+oOT2WpImh5WN8wTpz6YVvcj13xAzX4gXo0fL3hrqJc4
        r8orMmWcLAucb
X-Received: by 2002:a05:6402:510d:: with SMTP id m13mr8088949edd.179.1624550778324;
        Thu, 24 Jun 2021 09:06:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxldU8NMGgCkkQX3pZfpalJnCIJrXi/RaF7X+X+ZKboqWU5Yi+tdklycvF1YBs+a+ixBoc+Og==
X-Received: by 2002:a05:6402:510d:: with SMTP id m13mr8088919edd.179.1624550778193;
        Thu, 24 Jun 2021 09:06:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id y10sm2043535edc.66.2021.06.24.09.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:06:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2DB06180732; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v5 01/19] rcu: Create an unrcu_pointer() to remove __rcu from a pointer
Date:   Thu, 24 Jun 2021 18:05:51 +0200
Message-Id: <20210624160609.292325-2-toke@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210624160609.292325-1-toke@redhat.com>
References: <20210624160609.292325-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The xchg() and cmpxchg() functions are sometimes used to carry out RCU
updates.  Unfortunately, this can result in sparse warnings for both
the old-value and new-value arguments, as well as for the return value.
The arguments can be dealt with using RCU_INITIALIZER():

        old_p = xchg(&p, RCU_INITIALIZER(new_p));

But a sparse warning still remains due to assigning the __rcu pointer
returned from xchg to the (most likely) non-__rcu pointer old_p.

This commit therefore provides an unrcu_pointer() macro that strips
the __rcu.  This macro can be used as follows:

        old_p = unrcu_pointer(xchg(&p, RCU_INITIALIZER(new_p)));

Reported-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/rcupdate.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 9455476c5ba2..d7895b81264e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -363,6 +363,20 @@ static inline void rcu_preempt_sleep_check(void) { }
 #define rcu_check_sparse(p, space)
 #endif /* #else #ifdef __CHECKER__ */
 
+/**
+ * unrcu_pointer - mark a pointer as not being RCU protected
+ * @p: pointer needing to lose its __rcu property
+ *
+ * Converts @p from an __rcu pointer to a __kernel pointer.
+ * This allows an __rcu pointer to be used with xchg() and friends.
+ */
+#define unrcu_pointer(p)						\
+({									\
+	typeof(*p) *_________p1 = (typeof(*p) *__force)(p);		\
+	rcu_check_sparse(p, __rcu); 					\
+	((typeof(*p) __force __kernel *)(_________p1)); 		\
+})
+
 #define __rcu_access_pointer(p, space) \
 ({ \
 	typeof(*p) *_________p1 = (typeof(*p) *__force)READ_ONCE(p); \
-- 
2.32.0

