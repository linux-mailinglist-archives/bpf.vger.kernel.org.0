Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5AD3690CA
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhDWLF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 07:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21957 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229961AbhDWLF7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Apr 2021 07:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619175922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NrCDxRbYZCigGpcjiW65eSzoXxIQrnv7V+nogAQLaR8=;
        b=bJw+P6qfEV7ObkdYc7Dj6C6qMCZP98/7+MAruJ24rrnJB259wvWwBZCH5FX/Nb/IiYTM5Q
        ukU2YghaC0D/3sxt+92NJpWt6NPGdKAZL7jOpdqnS2ZGzXlnexyCWgrQCHL4xPCY2qIghZ
        Ub6N+8EV6ojkP9V8XsT15ZfOB0mXj04=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-zjD42UzZPMCBTthOjYPhBg-1; Fri, 23 Apr 2021 07:05:20 -0400
X-MC-Unique: zjD42UzZPMCBTthOjYPhBg-1
Received: by mail-ed1-f71.google.com with SMTP id y10-20020a50f1ca0000b0290382d654f75eso18404937edl.1
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 04:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NrCDxRbYZCigGpcjiW65eSzoXxIQrnv7V+nogAQLaR8=;
        b=k9v9N9jDYGJrhVwUXya6zgrXGZnvUc2fme0jOySEP+4zZsfSWl0CcXjeQzwcodoOJd
         tD783qVnc0R5I/KLtQovQaTCGqeEbZ1rWOX1+3rllDWgA1DdQCxFvL+/TKCMNRSmTQvs
         Gvbh6ru4OG2uBba2C3I7UQWVN9z2nKublSvO6XSYS6F/xJsBJJ3UV7MzT260SmsZVbhY
         V06aVF54UlgakcTA/dUyILYAXabAxRjKqCUePQuwohewMNS8xjUnONFBthZfzxJT8NBJ
         4/Rj28LFmykesyq/selOC62OSe4V6MTEQFHrAP4n3S7Mmf5J5xG8Ny8ifsGxpSOVdCIS
         VgEw==
X-Gm-Message-State: AOAM531IrIRIcvUXxrbxkgRS0Lmg5RBLi0KT0Id1Rgp1pHf6wmWbuQIo
        rsjmlRQph8GlQIDyWrOEM18L7b2zZuj4knbUgFkquca90PbapsaBl+TLrnBPHUVzFAlgUdmlu5f
        hYUrfwyp/5pqf
X-Received: by 2002:a05:6402:78d:: with SMTP id d13mr3725185edy.277.1619175919583;
        Fri, 23 Apr 2021 04:05:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7pIUuP2KdS5bS5B9w13P79WLAurnXHNN70WZ7Z2HnP7r6Nj5YH8Z7IZJ2pOwi892hSsxMbA==
X-Received: by 2002:a05:6402:78d:: with SMTP id d13mr3725127edy.277.1619175918961;
        Fri, 23 Apr 2021 04:05:18 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id by27sm3642620ejc.47.2021.04.23.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 04:05:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id BDCE8180676; Fri, 23 Apr 2021 13:05:16 +0200 (CEST)
Subject: [PATCH RFC bpf-next 1/4] rcu: Create an unrcu_pointer() to remove
 __rcu from a pointer
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Fri, 23 Apr 2021 13:05:16 +0200
Message-ID: <161917591669.102337.2073449001446955820.stgit@toke.dk>
In-Reply-To: <161917591559.102337.3558507780042453425.stgit@toke.dk>
References: <161917591559.102337.3558507780042453425.stgit@toke.dk>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Paul E. McKenney <paulmck@kernel.org>

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
 include/linux/rcupdate.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index bd04f722714f..49f368c5d4ec 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -362,6 +362,20 @@ static inline void rcu_preempt_sleep_check(void) { }
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

