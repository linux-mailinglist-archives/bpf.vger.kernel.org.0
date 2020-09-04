Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB9C25DF88
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 18:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIDQPF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 12:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgIDQPD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 12:15:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35807C061245
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 09:15:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id s13so6553437wmh.4
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 09:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d3xRWn3b8mYhu8abwt/w5QeihTHMhGtZlZ6eOGG8jao=;
        b=soLpylM+G5lceY4YjLGYt0Wlob2CwAzKkn2LWznJLmnEXQlRMyN+2QrjK9Demg2FcN
         5vbKbWmNfpTs81yNioLoWtaE/0cLZR5guKiVAOrfHypyCQGQMeria0dg0GVJKIRXq3iF
         hE8S5FVVXFiSkHTCyb3sF/EUFt5HKLERCbhZeITvIBlePIpdYtWgEoGXcioPnsZvGxpA
         4en8/39BipwIpHGeFk55nsm2g/a0vz9i6CAH6CkQ972Pas7TdILu5Ibzqx1jzQE8d2OG
         zt2TJUaRffzXBJHYW1TJyIOIGyxbXoWspox+EROi1A6Aknm7eq7iE8PPu2jO9SWpmJwd
         7DzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d3xRWn3b8mYhu8abwt/w5QeihTHMhGtZlZ6eOGG8jao=;
        b=ZewQ9zRIClazpmD3vt+XEoHS8gUdA/7yf3njzkfRd0n6skHvR720bJajKqMQ+UEEq1
         icU3OD6OwVljaGkrTpuCus2ARidFb/I2Ti4TeKKC4QlUvSTCWkkkFkPegnw+UbEd3nFl
         JEIADwvGYghovkB9Mck2XGWXGfTkdl8T5yPBeem50+RhtaYgiMgLcQ/Sr+1aigGwLSuz
         uljX76MH6OhTiLGv33O6/VqOx0mtqUIniupNuarLQSl7P1osGeeYVAiIZdiGAHChaqS3
         eAgUYIVlKIOyGDSBh6cLwcahg/aNHjwMGaCo6/ZFgBBkCbtcRExi1O+tAb2FO25k5Tsp
         FsUg==
X-Gm-Message-State: AOAM532EX4sJZFTCzDuHrSFThixBnmeJejclHsP8pU6/WnsyenrT+QSN
        Gw/+tUt4N4T0Nrx+neNR+WWu6EPWc958AaC3
X-Google-Smtp-Source: ABdhPJyQHeolU2KSmDmNpwz9DpvdYKhn1IgLswRepB9dgrvh8nE7melSUojbQiqwhax/SqkrJf9E1A==
X-Received: by 2002:a1c:e0d4:: with SMTP id x203mr8990199wmg.91.1599236101923;
        Fri, 04 Sep 2020 09:15:01 -0700 (PDT)
Received: from localhost.localdomain ([194.35.117.187])
        by smtp.gmail.com with ESMTPSA id p1sm28859352wma.0.2020.09.04.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 09:15:01 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 1/3] tools: bpftool: fix formatting in bpftool-link documentation
Date:   Fri,  4 Sep 2020 17:14:52 +0100
Message-Id: <20200904161454.31135-2-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200904161454.31135-1-quentin@isovalent.com>
References: <20200904161454.31135-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Fix a formatting error in the documentation for bpftool-link, so that
the man page can build correctly.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/bpf/bpftool/Documentation/bpftool-link.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Documentation/bpftool-link.rst b/tools/bpf/bpftool/Documentation/bpftool-link.rst
index 4a52e7a93339..dc7693b5e606 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-link.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-link.rst
@@ -21,7 +21,7 @@ LINK COMMANDS
 
 |	**bpftool** **link { show | list }** [*LINK*]
 |	**bpftool** **link pin** *LINK* *FILE*
-|	**bpftool** **link detach *LINK*
+|	**bpftool** **link detach** *LINK*
 |	**bpftool** **link help**
 |
 |	*LINK* := { **id** *LINK_ID* | **pinned** *FILE* }
-- 
2.20.1

