Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F40B313AFAE
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2020 17:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgANQnG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jan 2020 11:43:06 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:22866 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726379AbgANQnE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Jan 2020 11:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579020183;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=gDOl5oOf2cpVq2YFw06OX+4Yf7QXZq+3GEoWn2wy/eA=;
        b=fgoTbixrXviBKpif+lOBdDX492LW7sQGGwpGf4M5MAaPgxikqrzR/TPfVJ/hREp8h6aLzA
        6Gx3NEr9d5UuMbSh95dVpKD4sqhaWgr5f6D02/e0W2PVJplVi+c8t+cMHh4HnLDRah+y4x
        syoyOzR3QVwL3O+RGeb8/Ipug6mcgrw=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-LA1t9d5jNwGjQeTzX0Ug_g-1; Tue, 14 Jan 2020 11:43:00 -0500
X-MC-Unique: LA1t9d5jNwGjQeTzX0Ug_g-1
Received: by mail-lj1-f200.google.com with SMTP id o9so3138514ljc.6
        for <bpf@vger.kernel.org>; Tue, 14 Jan 2020 08:43:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gDOl5oOf2cpVq2YFw06OX+4Yf7QXZq+3GEoWn2wy/eA=;
        b=ek9c/DlanR9xJLOuM2m2rLeiSEVAsNKyDnNuhcgPyloNS7E6byW58SY5NSaFBsRf+f
         S+Wb2fGgGqUYnfuBA7ZTve5GskTKNkG3SjRQmZq7TAGm/kKWg/l3sufvqYoB/i4bM4X4
         SkXyO40l9hpDOuNk5TMY5PgeGWzyuqDBxSX5uSHRZB5uImFJ2tYpVtp6pPGb5auZEcU4
         25kEuTDxAMZRwYgYDudxp/1Hs77DSrGdk5Trhi7vCPZ0bRWFlleh1LCY5WU3GF/Wpj9t
         t6WcOn/3TUaHopXW67WoV0NRJR+iu/SZjUtHFW9lFd+88V/47VhSIhlzXV4Iu1tcu/oL
         bNSA==
X-Gm-Message-State: APjAAAVdkvPjo8sU54Kr6azQOExx4li11uClmCZw4kWD9xCXceBoQB1B
        rkK2+yFg/kiNLbaRVYF3MUxf6GA+lVEyMyviSvwpHCfqZ7gnSJbUqWZNxDOTm82rqFfJ/m8Dkyf
        05PBHuMbN83O5
X-Received: by 2002:a05:6512:40e:: with SMTP id u14mr2277056lfk.161.1579020179185;
        Tue, 14 Jan 2020 08:42:59 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfpQ0TbloNrejHB7aTPs3vqYhNyYGz8aXpQBBk+AqMb7yu1+Uh487I+uLHWk7n92xlo/xlbg==
X-Received: by 2002:a05:6512:40e:: with SMTP id u14mr2277015lfk.161.1579020177990;
        Tue, 14 Jan 2020 08:42:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id d20sm7773851ljg.95.2020.01.14.08.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 08:42:57 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7BB4B1804D6; Tue, 14 Jan 2020 17:42:56 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next] libbpf: Fix include of bpf_helpers.h when libbpf is installed on system
Date:   Tue, 14 Jan 2020 17:42:50 +0100
Message-Id: <20200114164250.922192-1-toke@redhat.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The change to use angled includes for bpf_helper_defs.h breaks compilation
against libbpf when it is installed in the include path, since the file is
installed in the bpf/ subdirectory of $INCLUDE_PATH. Fix this by adding the
bpf/ prefix to the #include directive.

Fixes: 6910d7d3867a ("selftests/bpf: Ensure bpf_helper_defs.h are taken from selftests dir")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Not actually sure this fix works for all the cases you originally tried to
fix with the referred commit; please check. Also, could we please stop breaking
libbpf builds? :)

 tools/lib/bpf/bpf_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 050bb7bf5be6..fa43d649e7a2 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -2,7 +2,7 @@
 #ifndef __BPF_HELPERS__
 #define __BPF_HELPERS__
 
-#include <bpf_helper_defs.h>
+#include <bpf/bpf_helper_defs.h>
 
 #define __uint(name, val) int (*name)[val]
 #define __type(name, val) typeof(val) *name
-- 
2.24.1

