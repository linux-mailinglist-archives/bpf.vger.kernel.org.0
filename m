Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46EC083E36
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 02:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbfHGATg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Aug 2019 20:19:36 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:36836 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbfHGATg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Aug 2019 20:19:36 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so64450645qkl.3
        for <bpf@vger.kernel.org>; Tue, 06 Aug 2019 17:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7ngjxHdg2v9ArnvarT9VRp5qq6SSckdhrdOnAxxdI1o=;
        b=xE9bl7CwVRr8fvh2mG2pryotdcE9m9N7kbFjDOFQ7l7JyFVvvSbQ4Wtr2wQzRCoZ7R
         MEnfUtOx4s4gtj/A6s99UozrB7+sEEPzQNFx4gSQVMv8Hle5l7yLUELa2Koiw9v4A0Nr
         pe57RG0fuYq6173I/SKDQEIPd8HXhDRdgrK0VIO32b2OTHqPgfBhmrkC3k/dj/BPKoCU
         RfhC2gZHEr1Ni9V42rqBtkcD/9XPZnOFYp2E7DJ3KNmfI4ZD1SOV2UfGDJaecXbZEAhZ
         LRNqVTOrQ7YndKKZAGgMWMoKyVnt9IXVDzEjkMH3AMDdS58etuKXweBOy6e1FKa+PsSt
         VmQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7ngjxHdg2v9ArnvarT9VRp5qq6SSckdhrdOnAxxdI1o=;
        b=s7m7XjwFNmOEhxVtCjCCeyvLItd/KKnwMh2RTH/cX44ajID3s1Jg49/YhvXZYp1Mse
         gvjc7eMAx+sk7yXs/fB0yAniA+dk8V5MZuB3QqqCRh/DOuURvdWw2Pz3BhR0LnWdyR1q
         3lcqXiEjcJIXqBkiamH4qfu8jeuaW/leeYH5z+ssWxPgQxXnrIDMJ4su3I6LLrlselgW
         zlWkhkXVg8iRNDEOaCB7lEgx5mtR6GaoWhfk6MvclqmhHMS0zDeWPOLzbz0v4ZVF/8wW
         5xMZea0fMA4kIGOrwrpfUSqVvDUP8AcQbz047gn7xrszGy7iUI+PDlUpITWjr8KFXj7p
         LSzA==
X-Gm-Message-State: APjAAAWU775bw1vk4gYq3hCJambhDGjrVPWGvnpxFwTWfeXYMh4ysyJD
        95QE7PjyI+s9+4APXAbZ3R3ogeyiRj8=
X-Google-Smtp-Source: APXvYqxgOsZQXDpdf8GOmnrQDqjd4gdTCy80voGLgh4OBPuqUYltxpcUD0vgjY6CDypHx+bsvwbhEQ==
X-Received: by 2002:a37:5d87:: with SMTP id r129mr5832636qkb.388.1565137175729;
        Tue, 06 Aug 2019 17:19:35 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id i5sm35547554qtp.20.2019.08.06.17.19.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Aug 2019 17:19:35 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf 1/2] tools: bpftool: fix error message (prog -> object)
Date:   Tue,  6 Aug 2019 17:19:22 -0700
Message-Id: <20190807001923.19483-2-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190807001923.19483-1-jakub.kicinski@netronome.com>
References: <20190807001923.19483-1-jakub.kicinski@netronome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Change an error message to work for any object being
pinned not just programs.

Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Quentin Monnet <quentin.monnet@netronome.com>
---
 tools/bpf/bpftool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
index 5215e0870bcb..c52a6ffb8949 100644
--- a/tools/bpf/bpftool/common.c
+++ b/tools/bpf/bpftool/common.c
@@ -237,7 +237,7 @@ int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
 
 	fd = get_fd_by_id(id);
 	if (fd < 0) {
-		p_err("can't get prog by id (%u): %s", id, strerror(errno));
+		p_err("can't open object by id (%u): %s", id, strerror(errno));
 		return -1;
 	}
 
-- 
2.21.0

