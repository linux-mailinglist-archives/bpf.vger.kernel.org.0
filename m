Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28C77243B8C
	for <lists+bpf@lfdr.de>; Thu, 13 Aug 2020 16:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHMO30 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Aug 2020 10:29:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50879 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726082AbgHMO3Z (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Aug 2020 10:29:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597328964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=DtGeLvx1wLTBoO7zj2vWPZCvAg2PY5suAIRCYsTk2d0=;
        b=iRDhvSQuZX8Qe439HmHxhC3x2wC7/aFCSAbum83hfpapOfO7o+cUnywRPWOoS8/85QCCMZ
        cyXQm+G7RHSJ+/bYd/CyD/ZX8AlPhDoZXySHixF5S1x5U3v0r2NDK7y3YTdvBKTT9m6nUe
        5k8MlI1RhpA/Vv8eKq9/1lSlR/yAmCo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-509-yhuN2FTLNsOULQcBKeQKxA-1; Thu, 13 Aug 2020 10:29:22 -0400
X-MC-Unique: yhuN2FTLNsOULQcBKeQKxA-1
Received: by mail-wr1-f71.google.com with SMTP id r29so2162848wrr.10
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2020 07:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DtGeLvx1wLTBoO7zj2vWPZCvAg2PY5suAIRCYsTk2d0=;
        b=F7uN2C5ET5rv6YvMVT5IILsnsnMfKZZ91+nGKV8KrmrJf9LSjVbMfRDgls4XlfHNlG
         dVTWZTw7Um6mwM9A2fBUgrMpEdo0t+KGEVxc3ZRQb8mhVzivWsk8mLX789xakv85W/2Q
         E4l2TRnNkd6o9xgHeT6jWNZkbkiTPlXPQbP/56lt+TIwd9WlbphRdaLLOIt6CvCX7Hsu
         K5cXP0JqT9eAxT5kA11pf72Xe5yIAFDmQ9igWprSlpHpFo3ZC+u2HuNWJo9QHlPiF0AH
         rhiL5dsovfboNG/oc2C+mncQa2kPLgWgBq/w+KWhOjH/k3pnibgvHYNH1rSsZhamYCcr
         7r1Q==
X-Gm-Message-State: AOAM531tU28Hm5gCUXd9yc1l8j+72/kvrZhNpcKLi9OK+TMsLVCSz+99
        GDgZfcUevhf+oALVWAhVLblxe3mjhkrXMH4vHyuzu5oXk1ciV6zxMjah2VkDuOVuys1uMjUKAzG
        Ht12I3W4TH6Al
X-Received: by 2002:a1c:a1c7:: with SMTP id k190mr4438277wme.1.1597328961230;
        Thu, 13 Aug 2020 07:29:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8+M1jAPj+ZJqG/iK2mV6QXZ1RVt0oQY1ErDa8VCJ4x0jUp2RJYJLbFnS1QJBPue9oi3VZCA==
X-Received: by 2002:a1c:a1c7:: with SMTP id k190mr4438262wme.1.1597328961025;
        Thu, 13 Aug 2020 07:29:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r22sm9828936wmh.45.2020.08.13.07.29.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 07:29:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E2F71180493; Thu, 13 Aug 2020 16:29:18 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf] libbpf: Prevent overriding errno when logging errors
Date:   Thu, 13 Aug 2020 16:29:05 +0200
Message-Id: <20200813142905.160381-1-toke@redhat.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Turns out there were a few more instances where libbpf didn't save the
errno before writing an error message, causing errno to be overridden by
the printf() return and the error disappearing if logging is enabled.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0a06124f7999..fd256440e233 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -3478,10 +3478,11 @@ bpf_object__probe_global_data(struct bpf_object *obj)
 
 	map = bpf_create_map_xattr(&map_attr);
 	if (map < 0) {
-		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		ret = -errno;
+		cp = libbpf_strerror_r(-ret, errmsg, sizeof(errmsg));
 		pr_warn("Error in %s():%s(%d). Couldn't create simple array map.\n",
-			__func__, cp, errno);
-		return -errno;
+			__func__, cp, -ret);
+		return ret;
 	}
 
 	insns[0].imm = map;
@@ -6012,9 +6013,10 @@ int bpf_program__pin_instance(struct bpf_program *prog, const char *path,
 	}
 
 	if (bpf_obj_pin(prog->instances.fds[instance], path)) {
-		cp = libbpf_strerror_r(errno, errmsg, sizeof(errmsg));
+		err = -errno;
+		cp = libbpf_strerror_r(-err, errmsg, sizeof(errmsg));
 		pr_warn("failed to pin program: %s\n", cp);
-		return -errno;
+		return err;
 	}
 	pr_debug("pinned program '%s'\n", path);
 
-- 
2.28.0

