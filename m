Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04E3690C9
	for <lists+bpf@lfdr.de>; Fri, 23 Apr 2021 13:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbhDWLF7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 23 Apr 2021 07:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhDWLF6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 23 Apr 2021 07:05:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619175922;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tU71HJ9a16XxEOcyk9gr3EIn1rS0Q/y86aLDvKigw/U=;
        b=RU03UsgW3fEO8PchtSMaWUmkeZ+w+3bVlfC8/vy8N+yNdXNoK4N8jWYRFznLy+grj3HOey
        t8lJNV+ezMxwmjBPKLLMEWByD4eXMelYsZFZ52dXGAMUh8re0nXnQcRoAvW0G2gvNDhDoo
        17TZor6t5A0VE8sn3H75EVcWtc0v4nw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-bR8sCtKhNsWTi7Z3CtDxWw-1; Fri, 23 Apr 2021 07:05:20 -0400
X-MC-Unique: bR8sCtKhNsWTi7Z3CtDxWw-1
Received: by mail-ej1-f72.google.com with SMTP id o25-20020a1709061d59b029037c94676df5so8287287ejh.7
        for <bpf@vger.kernel.org>; Fri, 23 Apr 2021 04:05:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=tU71HJ9a16XxEOcyk9gr3EIn1rS0Q/y86aLDvKigw/U=;
        b=aVXNGtzCO25Xrdvwi0J4cennZS1HqBOtKhxIVQFMRbdW/zJrbYB28NLMMjQk1YWT3H
         x2eMozEkFwj9Mp3894BquLn2dk8sHpWLf3ekaUr6x8X+Wjyv3PL6c3cGD+B+TfYKP3FK
         2+K6/OAgZf6XGr1OQpKMRd0njGh7uJi2EJmvGqX06Sq1nEX99PU+hTHu0236Hv6GCSA2
         1U1c8SNfTmyvjur549VSWfgomUMwjeDmBbhnjKvheaAPutLHgWXvzICTMbhKuelnKndO
         0RWul9WxrW1S1p3bdr70l/O5Jj2OwEztNYnSnsy97t6OQJPPMzg8tUeKILDze1CRAVm0
         6FrQ==
X-Gm-Message-State: AOAM532RlVaJPn0ZBVGeUksRLyoi201sS4DW/tOFbbLMNcZX+QsKO9Fb
        fo4pyS9hvSZT0crMFmp7VvvIsD0gT+qT0JYQvix0iDxseWF/bvH/+EN7MT/jbTTFN6T0faLKskd
        jGI/vv8CHYwkU
X-Received: by 2002:a17:906:f8cd:: with SMTP id lh13mr3555273ejb.387.1619175919384;
        Fri, 23 Apr 2021 04:05:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0j5s13g+AXEBAelkMkVfD/IFdrSngCBlCH+7O5wgayqscrs4HoHrUZ0OuSAf4NtRQhjv3DQ==
X-Received: by 2002:a17:906:f8cd:: with SMTP id lh13mr3555259ejb.387.1619175919246;
        Fri, 23 Apr 2021 04:05:19 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id e20sm3752294ejy.66.2021.04.23.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 04:05:18 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D7214180675; Fri, 23 Apr 2021 13:05:17 +0200 (CEST)
Subject: [PATCH RFC bpf-next 2/4] dev: add rcu_read_lock_bh_held() as a valid
 check when getting a RCU dev ref
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>
Date:   Fri, 23 Apr 2021 13:05:17 +0200
Message-ID: <161917591778.102337.1084869564077259501.stgit@toke.dk>
In-Reply-To: <161917591559.102337.3558507780042453425.stgit@toke.dk>
References: <161917591559.102337.3558507780042453425.stgit@toke.dk>
User-Agent: StGit/1.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

Some of the XDP helpers (in particular, xdp_do_redirect()) will get a
struct net_device reference using dev_get_by_index_rcu(). These are called
from a NAPI poll context, which means the RCU reference liveness is ensured
by local_bh_disable(). Add rcu_read_lock_bh_held() as a condition to the
RCU list traversal in dev_get_by_index_rcu() so lockdep understands that
the dereferences are safe from *both* an rcu_read_lock() *and* with
local_bh_disable().

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/dev.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b4c67a5be606..a7b8e3289f7c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1002,7 +1002,7 @@ struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex)
 	struct net_device *dev;
 	struct hlist_head *head = dev_index_hash(net, ifindex);
 
-	hlist_for_each_entry_rcu(dev, head, index_hlist)
+	hlist_for_each_entry_rcu(dev, head, index_hlist, rcu_read_lock_bh_held())
 		if (dev->ifindex == ifindex)
 			return dev;
 

