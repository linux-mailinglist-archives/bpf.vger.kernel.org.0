Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248E32C7267
	for <lists+bpf@lfdr.de>; Sat, 28 Nov 2020 23:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389809AbgK1VuG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 28 Nov 2020 16:50:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:22158 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgK0Tt7 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Nov 2020 14:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606506555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=9qJpD7PFdKgMu/xcOXN6q7idq5UlxcE8KGC0MQOhIgM=;
        b=Z0x1nYQ6DOuy6i+yrUVQdJWYfD7WJKdtAimESkHFtSMkKAJ16YlMbtRcqQcXyez1PwCfDW
        g/L5IegymVtC+/w9WBmZifz5haZU3QX951nkUs0Evw/GLL5li2zZYe89DFNiW8XHhVBfU2
        hIJA2m0B/KpgU6hzcAoC1rx1DyB7Exk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-JlpAzB5zMDyBJlOkvFsmhw-1; Fri, 27 Nov 2020 14:27:42 -0500
X-MC-Unique: JlpAzB5zMDyBJlOkvFsmhw-1
Received: by mail-qt1-f197.google.com with SMTP id w88so3775336qtd.4
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2020 11:27:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9qJpD7PFdKgMu/xcOXN6q7idq5UlxcE8KGC0MQOhIgM=;
        b=ciZEb6xJ98yS+3uBnFg+1YR8Wn6XLnYBFA/Pu3c/dSrEO21zhv/CP+mlpkaMitnNVk
         Hw1C5OlLX2U4/PZLnrwH5c+MR7O5YYqmFNCKBS9WQP0UfR4dFkVJswzUx+ZBvt2heuvd
         O0IiCZYdejZfikOCHGJksClVXuwZPWxISTTA3Vf9DQjhJVfaf+5mzGKzHXvNRDLnaanJ
         XPUPOzBaqtLPUbuA/y8sZ6oKwyl3KjQNLxjyPm+evB6yi/7FW9RoCC6z2Tg1BvXbA5Mo
         bzKR1jRD195qJJgCl/QC2q5Y8J4xEc35QG5LkFkUrrjZsGPUSq+DO+42YDE67ez1BF3Q
         o0Bw==
X-Gm-Message-State: AOAM530X2/7Ctk09i6XdNVZa1wFSVw6978kmy+rcNU1hDYNohYeBdQRY
        E9pwZhKYlCc/+VUCNBl38UcOSMLW2g1XzemQG3Hn+cpwTiHLgUhvHOoqxUTRLQIUcWmdl0ysgM9
        KXcVlXD/GbeBp
X-Received: by 2002:ad4:5544:: with SMTP id v4mr9383585qvy.43.1606505261709;
        Fri, 27 Nov 2020 11:27:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxuNWhcU9Ar3O10Wn0TX41HHp7RN7H86NAdJD2PtPOP28EoXt8oYhhMF7eDA1G5lCwZpeGCiA==
X-Received: by 2002:ad4:5544:: with SMTP id v4mr9383569qvy.43.1606505261511;
        Fri, 27 Nov 2020 11:27:41 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w54sm7395471qtb.0.2020.11.27.11.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:27:40 -0800 (PST)
From:   trix@redhat.com
To:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@chromium.org,
        rostedt@goodmis.org, mingo@redhat.com, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] bpf: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 11:27:34 -0800
Message-Id: <20201127192734.2865832-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 include/trace/events/xdp.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/xdp.h b/include/trace/events/xdp.h
index cd24e8a59529..65ffedf8386f 100644
--- a/include/trace/events/xdp.h
+++ b/include/trace/events/xdp.h
@@ -146,13 +146,13 @@ DEFINE_EVENT(xdp_redirect_template, xdp_redirect_err,
 );
 
 #define _trace_xdp_redirect(dev, xdp, to)		\
-	 trace_xdp_redirect(dev, xdp, NULL, 0, NULL, to);
+	 trace_xdp_redirect(dev, xdp, NULL, 0, NULL, to)
 
 #define _trace_xdp_redirect_err(dev, xdp, to, err)	\
 	 trace_xdp_redirect_err(dev, xdp, NULL, err, NULL, to);
 
 #define _trace_xdp_redirect_map(dev, xdp, to, map, index)		\
-	 trace_xdp_redirect(dev, xdp, to, 0, map, index);
+	 trace_xdp_redirect(dev, xdp, to, 0, map, index)
 
 #define _trace_xdp_redirect_map_err(dev, xdp, to, map, index, err)	\
 	 trace_xdp_redirect_err(dev, xdp, to, err, map, index);
-- 
2.18.4

