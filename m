Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB254AD825
	for <lists+bpf@lfdr.de>; Tue,  8 Feb 2022 13:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347873AbiBHMHB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 07:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346855AbiBHMG5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 07:06:57 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F82C03FEC0
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 04:06:56 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id st12so26748039ejc.4
        for <bpf@vger.kernel.org>; Tue, 08 Feb 2022 04:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iTdMXnmtGPLZRSvlL1IcNtJZpPvHU3gWUTLzYfE+SxE=;
        b=SAYY6wGOIVD0AIl6XkKbe6OEJ1zPsZEZ4paudU5iBURPJ5YLioi9K3UQxb3qp0aSAn
         U31d/hQTPa0wjQt7YkxNG2KtRAOYzB3GFkNJYy8F5atoQ6ncMfduXadUU+N8+4LnjfPs
         tbXZrMnyohTJQmA3frAxExswKsA+5wJ90T32qFTbaWBUJHisP1Fl0gB5t7hiHyWa7KU8
         8UOvrPuc5+/qdtJOnnP+AzX2TanFV5xC8JXFg3tNG6rWkHY1Iayhjej8ZQZSsEAalgGy
         Z2x1hm62Itp65O4S0KM51QV/yDyi+w7vn0+JFnwljzgtSlQqJFDPYUKsU+TEFeXfHQZt
         kOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iTdMXnmtGPLZRSvlL1IcNtJZpPvHU3gWUTLzYfE+SxE=;
        b=rKU6oOmLNE+f54VaHT38PnjPr6dqYouqfv6WE8L2tUCdqPNBwVrM3C6loQ0lsijs6H
         Z5agvGyZv0YixhoE0X+L/WYdxOzkQgWRgDhr2/mH22MUDqlYARsQ9d8+rbHqah87xfPK
         0UbHPVpjLMQ8QOdoLa6A/ZcrhY8zABsfto29Kx4m4G3zbbWesKORiVqdNVSjidggmUP7
         sdoU6z7cOEWYTffnQVyS77DV3TOlKr2M3PCr/LaKgUHn23/1h5c6kJ0/srhnigxNoP0n
         hy3k+cHFip1s1Z26k5HScfd/SEva0hf9ndryFCWTYHpVQnLH4L9fkn7/9ODCVEZeNXX+
         Bsww==
X-Gm-Message-State: AOAM531vWkMPiRuSMtNkeq+CuYHdZibySQbq6LWFLKho4q58/uNhsQyY
        Who+qxs1anxgX8ToNupbd1WV7g==
X-Google-Smtp-Source: ABdhPJwMsCI2qbWp1E5WT/ejbpHBceAKMrBZ23qpp1k9dfTOiIX3ekzZv1JnbNt8pXkn5EDuyLUUBg==
X-Received: by 2002:a17:907:62a9:: with SMTP id nd41mr3471216ejc.50.1644322015107;
        Tue, 08 Feb 2022 04:06:55 -0800 (PST)
Received: from localhost.localdomain ([149.86.77.242])
        by smtp.gmail.com with ESMTPSA id m17sm5567351edr.62.2022.02.08.04.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 04:06:54 -0800 (PST)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next v2 2/3] libbpf: Add "libbpversion" make target to print version
Date:   Tue,  8 Feb 2022 12:06:47 +0000
Message-Id: <20220208120648.49169-3-quentin@isovalent.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220208120648.49169-1-quentin@isovalent.com>
References: <20220208120648.49169-1-quentin@isovalent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a target to libbpf's Makefile to print its version number, in a
similar way to what running "make kernelversion" at the root of the
repository does.

This is to avoid re-implementing the parsing of the libbpf.map file in
case some other tools want to extract the version of the libbpf sources
they are using.

Signed-off-by: Quentin Monnet <quentin@isovalent.com>
---
 tools/lib/bpf/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index b8b37fe76006..91136623edf9 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -108,6 +108,9 @@ MAKEOVERRIDES=
 
 all:
 
+libbpfversion:
+	@echo $(LIBBPF_VERSION)
+
 export srctree OUTPUT CC LD CFLAGS V
 include $(srctree)/tools/build/Makefile.include
 
-- 
2.32.0

