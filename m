Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BDC41AA951
	for <lists+bpf@lfdr.de>; Wed, 15 Apr 2020 16:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633818AbgDOOCK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Apr 2020 10:02:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21307 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729062AbgDOOCH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 15 Apr 2020 10:02:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586959323;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DIieFSIFXcNK3bF2pki6xVm8oWsV0b5ZkJCX9uZyw50=;
        b=htvGLJbGuKfXs67/ulj0QKKO+d27Kcoo4/lrsvlT8xE+Op/HVYlD0EE/T10RS6TkaJvaRU
        4l/3pc20Jy3FIyHGfT24usQh5NezJUnSt+OBKzqewn6Z3vja8sdHhFBwgnZFE57921NJCS
        f4yjt2rGpLQts7W/8wAX/hNRZCbz9Bg=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-Rl2o2wU-OBOwb1-WaO0z4A-1; Wed, 15 Apr 2020 10:02:02 -0400
X-MC-Unique: Rl2o2wU-OBOwb1-WaO0z4A-1
Received: by mail-lj1-f197.google.com with SMTP id e6so631491ljj.5
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 07:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DIieFSIFXcNK3bF2pki6xVm8oWsV0b5ZkJCX9uZyw50=;
        b=VDDvLVhvLdsJmH5YCsNYMPw7dFvaSOpbW2Ak4R0OeMUHhwGiv4HarVB1yR/H3A1qBy
         HZuuKYcem8zxSOEAAFs5e5Rw768jZFvMZK79Asa3LtWuXk2jk7fNH3KcXxvKdzsw6tbB
         x3CXF5z0o1VvH4c2VVU7sP2wTKSobuUoETj0x6IylyYijQsBlj2mqMau6KrJuOtCEjTw
         fwT6FJywXx6mpOm0Wj50t6gj7k1Lhtq/UmrN2cqT76q+W9JspAumfn73yz0t5ZIuP3xy
         Imjc7Y234yjsoiUuGRL+uX7KD56niYnD/5vtH/K5o+MToFNW755BR3M8eIjXqnfk5Dw2
         ZaCQ==
X-Gm-Message-State: AGi0PuZo5dD1rGRZH7HZYv8zCMWNWDlVPkuLfnJZYunIzShYlVmLcUP/
        ySLqXh0qvp8RFwvTMQsFoz1gLzvU0ljdCPUZBXJbaghwk6Bgy1/Lo4mA22biFZCzJxlbOmzCpXo
        bV7btXj/OmgAv
X-Received: by 2002:ac2:43c6:: with SMTP id u6mr3294392lfl.170.1586959320659;
        Wed, 15 Apr 2020 07:02:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQVrVF1keziwDymILwDFZQB1YR2QERfd2wejuW+1DEDbm2plwNgF7XGhJrMenNXH6bM9yzZQ==
X-Received: by 2002:ac2:43c6:: with SMTP id u6mr3294372lfl.170.1586959320382;
        Wed, 15 Apr 2020 07:02:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u3sm13345180lff.26.2020.04.15.07.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 07:01:59 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9171B181586; Wed, 15 Apr 2020 16:01:58 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Xiumei Mu <xmu@redhat.com>
Subject: [PATCH bpf] cpumap: Avoid warning when CONFIG_DEBUG_PER_CPU_MAPS is enabled
Date:   Wed, 15 Apr 2020 16:01:51 +0200
Message-Id: <20200415140151.439943-1-toke@redhat.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When the kernel is built with CONFIG_DEBUG_PER_CPU_MAPS, the cpumap code
can trigger a spurious warning if CONFIG_CPUMASK_OFFSTACK is also set. This
happens because in this configuration, NR_CPUS can be larger than
nr_cpumask_bits, so the initial check in cpu_map_alloc() is not sufficient
to guard against hitting the warning in cpumask_check().

Fix this by using the nr_cpumask_bits variable in the map creation code
instead of the NR_CPUS constant.

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Reported-by: Xiumei Mu <xmu@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/cpumap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 70f71b154fa5..23902afb3bba 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -99,8 +99,8 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
 
 	bpf_map_init_from_attr(&cmap->map, attr);
 
-	/* Pre-limit array size based on NR_CPUS, not final CPU check */
-	if (cmap->map.max_entries > NR_CPUS) {
+	/* Pre-limit array size based on nr_cpumask_bits, not final CPU check */
+	if (cmap->map.max_entries > nr_cpumask_bits) {
 		err = -E2BIG;
 		goto free_cmap;
 	}
-- 
2.26.0

