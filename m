Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6453B3380
	for <lists+bpf@lfdr.de>; Thu, 24 Jun 2021 18:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFXQIy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Jun 2021 12:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35779 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231569AbhFXQIo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Jun 2021 12:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624550784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCA//v5U2zdeKF30MPJkPlDU8nWyKsxnTIF8PhfpTLo=;
        b=IQ2wdmJ9vgKKLCihvF70MJ/rJPJBUSaLe6XFbl3BTmJVauZLzyyxO6WRy0dUUWLu0cLw4c
        8HiA6Sdvnl5T5DpMgB8Sm/WagAsNM0aNFKvQDjd5nPa4e6M9EI5y0fEeAfali1nR51XfQl
        pQyRHno43/caGKzTttvXeCnPx8T1BsM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-n4SnMtH8OMitetuzDDtJ7g-1; Thu, 24 Jun 2021 12:06:22 -0400
X-MC-Unique: n4SnMtH8OMitetuzDDtJ7g-1
Received: by mail-ed1-f72.google.com with SMTP id v8-20020a0564023488b0290393873961f6so3593114edc.17
        for <bpf@vger.kernel.org>; Thu, 24 Jun 2021 09:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCA//v5U2zdeKF30MPJkPlDU8nWyKsxnTIF8PhfpTLo=;
        b=Y3KsterjLR3mogz7uVu0MA4OAQExmW/7lb5uz8PMYB0wJh5AhUcy7X5tCkXW+CEo+a
         xJKuuFsqkw6AJOq2hApjTGinXzlj/AK57C5eL2s7XXIqdI09MqfLgHlp1rbGvB89tfMf
         A+jevots7/BjqSX714fRgXq31uQGcXU2sYn/60K+y/X+oAp0Xs/WNTfLIy8SrvyUI9l/
         oeoJsMrcHWfwHJcdnJR5ZHdXiBwYh/fp5rFxpo/MmC5/6vgO7Y90B3gd4suUWYpW4XGs
         3KWnkjfSNWzpE8pNKMTTHoQYrD8U7MtWYta/Hyct5IGo7UBI+B1Bg3Lx5tGHaIRT23zl
         3PnA==
X-Gm-Message-State: AOAM5307MuaSfFG90wyFtPukr41PUAWSCZAffja0SsXvTEX4pX5oEerr
        bYzKr6hk3POV8QO0/YO/5Vwj3AwsrRQmbAy2w3ODwi0nTiQFjvAnL0OCkrKu5PBdii3M9YQEYS+
        THO0ep5z0RSwa
X-Received: by 2002:a17:906:680f:: with SMTP id k15mr5958332ejr.75.1624550781494;
        Thu, 24 Jun 2021 09:06:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzaQsXTowCVLdvWyPcdt8T/pD1yrSeJT5zej5tl3HbfAnh9ZWpoWQScDtHMX0OC5sfsqpPpLQ==
X-Received: by 2002:a17:906:680f:: with SMTP id k15mr5958316ejr.75.1624550781251;
        Thu, 24 Jun 2021 09:06:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id fl21sm1448600ejc.79.2021.06.24.09.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 09:06:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 345FC180733; Thu, 24 Jun 2021 18:06:10 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v5 02/19] doc: Clarify and expand RCU updaters and corresponding readers
Date:   Thu, 24 Jun 2021 18:05:52 +0200
Message-Id: <20210624160609.292325-3-toke@redhat.com>
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

This commit clarifies which primitives readers can use given that the
corresponding updaters have made a specific choice.  This commit also adds
this information for the various RCU Tasks flavors.  While in the area, it
removes a paragraph that no longer applies in any straightforward manner.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 Documentation/RCU/checklist.rst | 48 ++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 21 deletions(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index 1030119294d0..07f6cb8f674d 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -211,27 +211,33 @@ over a rather long period of time, but improvements are always welcome!
 	of the system, especially to real-time workloads running on
 	the rest of the system.
 
-7.	As of v4.20, a given kernel implements only one RCU flavor,
-	which is RCU-sched for PREEMPTION=n and RCU-preempt for PREEMPTION=y.
-	If the updater uses call_rcu() or synchronize_rcu(),
-	then the corresponding readers may use rcu_read_lock() and
-	rcu_read_unlock(), rcu_read_lock_bh() and rcu_read_unlock_bh(),
-	or any pair of primitives that disables and re-enables preemption,
-	for example, rcu_read_lock_sched() and rcu_read_unlock_sched().
-	If the updater uses synchronize_srcu() or call_srcu(),
-	then the corresponding readers must use srcu_read_lock() and
-	srcu_read_unlock(), and with the same srcu_struct.  The rules for
-	the expedited primitives are the same as for their non-expedited
-	counterparts.  Mixing things up will result in confusion and
-	broken kernels, and has even resulted in an exploitable security
-	issue.
-
-	One exception to this rule: rcu_read_lock() and rcu_read_unlock()
-	may be substituted for rcu_read_lock_bh() and rcu_read_unlock_bh()
-	in cases where local bottom halves are already known to be
-	disabled, for example, in irq or softirq context.  Commenting
-	such cases is a must, of course!  And the jury is still out on
-	whether the increased speed is worth it.
+7.	As of v4.20, a given kernel implements only one RCU flavor, which
+	is RCU-sched for PREEMPTION=n and RCU-preempt for PREEMPTION=y.
+	If the updater uses call_rcu() or synchronize_rcu(), then
+	the corresponding readers may use:  (1) rcu_read_lock() and
+	rcu_read_unlock(), (2) any pair of primitives that disables
+	and re-enables softirq, for example, rcu_read_lock_bh() and
+	rcu_read_unlock_bh(), or (3) any pair of primitives that disables
+	and re-enables preemption, for example, rcu_read_lock_sched() and
+	rcu_read_unlock_sched().  If the updater uses synchronize_srcu()
+	or call_srcu(), then the corresponding readers must use
+	srcu_read_lock() and srcu_read_unlock(), and with the same
+	srcu_struct.  The rules for the expedited RCU grace-period-wait
+	primitives are the same as for their non-expedited counterparts.
+
+	If the updater uses call_rcu_tasks() or synchronize_rcu_tasks(),
+	then the readers must refrain from executing voluntary
+	context switches, that is, from blocking.  If the updater uses
+	call_rcu_tasks_trace() or synchronize_rcu_tasks_trace(), then
+	the corresponding readers must use rcu_read_lock_trace() and
+	rcu_read_unlock_trace().  If an updater uses call_rcu_tasks_rude()
+	or synchronize_rcu_tasks_rude(), then the corresponding readers
+	must use anything that disables interrupts.
+
+	Mixing things up will result in confusion and broken kernels, and
+	has even resulted in an exploitable security issue.  Therefore,
+	when using non-obvious pairs of primitives, commenting is of
+	course a must.
 
 8.	Although synchronize_rcu() is slower than is call_rcu(), it
 	usually results in simpler code.  So, unless update performance is
-- 
2.32.0

