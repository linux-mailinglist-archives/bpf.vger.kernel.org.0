Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71F1A8062
	for <lists+bpf@lfdr.de>; Tue, 14 Apr 2020 16:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405187AbgDNOvB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Apr 2020 10:51:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36989 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405186AbgDNOu5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Apr 2020 10:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586875856;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=++cgNxaTJnTUqeFXINrVDsIffIgp4AONxrQaa1iE9nI=;
        b=EhMrugWFsoXcAHtn4J5oU7Ugok6qrbt9PX5IrjsSLKMfHd0HwZ/O2mK8wpLFKf6lRhIABU
        oc+I7REf5pZGpi5DVlE7lr1LvnPhnqrXJQ7QgNjOMBjrf67m71Rk6YZK/kM/DGBZjmb/f5
        aAM0AdTuVZDAizYjv4za0YWSrWc6h6c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-x4RCzUvjNaiI-bNmWzkoew-1; Tue, 14 Apr 2020 10:50:55 -0400
X-MC-Unique: x4RCzUvjNaiI-bNmWzkoew-1
Received: by mail-lj1-f197.google.com with SMTP id e6so2127546ljj.5
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2020 07:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=++cgNxaTJnTUqeFXINrVDsIffIgp4AONxrQaa1iE9nI=;
        b=istJ+DLNdTtpEOCJn5eooiWPtG8OKhIQuhq8J0pi4I3rPmVz3LEkbG2MrvMpifqTzM
         AR+oI7GjNGJixATkvNtIbdCzlFVDxT7DtwzwCau3vWTdBWPjBrfjQD/tqhh1tCS3kE1c
         HGejZQ8qYE3ixsfLQswNzdgNWvkGxRvCTZO4bMU3sUspV7rChJ/T6WJ6h3su9fjQLzk/
         xPZP1AwQgt+x3uWadbJLGhx8kViNdg6bReymrf6JAYS1phKoIDvAissfo1zhMbfMipSg
         QtY5//5+mc4T4NQTfo3VY8tJZ+JgQbtTBZi5OYVLDWxXH7gkABxq75w5SCQZii3+Igax
         stnQ==
X-Gm-Message-State: AGi0PuZOKDbPBI9nSORhOtNPyncV6WeB2fs2jlf6ZYJbn7hmfI2e3Y+M
        7sGlWBhLJOGxizGFnBmvQZIYTAIuMsv5cOOcng9Hi3rUGkXFuWxBQY1hHBAQCkS6U7NE9SKuWdN
        cS2VInoSOxnzt
X-Received: by 2002:a2e:b4cc:: with SMTP id r12mr372053ljm.50.1586875850029;
        Tue, 14 Apr 2020 07:50:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypI2Vtj0Iz7zJt3AEzJUtMYLFT0/Jahb4lbT/3ZQxqMmzznsEtgJJyut8/eJ9PFGJEucJrjWew==
X-Received: by 2002:a2e:b4cc:: with SMTP id r12mr372030ljm.50.1586875849671;
        Tue, 14 Apr 2020 07:50:49 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v30sm5781233ljd.98.2020.04.14.07.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 07:50:48 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id E64A1181586; Tue, 14 Apr 2020 16:50:46 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     daniel@iogearbox.net, ast@fb.com
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        David Ahern <dsahern@gmail.com>
Subject: [PATCH bpf 1/2] libbpf: Fix type of old_fd in bpf_xdp_set_link_opts
Date:   Tue, 14 Apr 2020 16:50:24 +0200
Message-Id: <20200414145025.182163-1-toke@redhat.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The 'old_fd' parameter used for atomic replacement of XDP programs is
supposed to be an FD, but was left as a u32 from an earlier iteration of
the patch that added it. It was converted to an int when read, so things
worked correctly even with negative values, but better change the
definition to correctly reflect the intention.

Fixes: bd5ca3ef93cd ("libbpf: Add function to set link XDP fd while specifying old program")
Reported-by: David Ahern <dsahern@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 44df1d3e7287..f1dacecb1619 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -458,7 +458,7 @@ struct xdp_link_info {
 
 struct bpf_xdp_set_link_opts {
 	size_t sz;
-	__u32 old_fd;
+	int old_fd;
 };
 #define bpf_xdp_set_link_opts__last_field old_fd
 
-- 
2.26.0

