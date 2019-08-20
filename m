Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B668E95BA9
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 11:52:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729497AbfHTJws (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Aug 2019 05:52:48 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37350 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbfHTJws (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Aug 2019 05:52:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id z11so11695863wrt.4
        for <bpf@vger.kernel.org>; Tue, 20 Aug 2019 02:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=aI5rpFA+O+q5SGN1wlAZgaPJ7UfrHimu6B38WtNbXwI=;
        b=VDePyvDODjXxuAFEeyxCV3o077e9VEsl6W3vBBF/a/RUSNfFl0B/UkpKSK23EWRzgK
         s7QxbMBbzSzpjuc88q5jggsjc4ZJup0qNb6/jVpySYqaBpz5nMSmojQbO+tyiJ7wEyjI
         rG/v5RbKWhDm0+CBuY/eZAYQw7X6zyhzlVQYbZAH1TTmNvB4yIykl8AP7YJSXviyu0mt
         wTYVA7jWJrOryi5c7Ti0RKz2Cf1GtB/sW1/tT9aKmDET4r8eBcml8V6u7IpT4j6G6yd2
         LEvVouYHgtMIf+7YeVXaJvaCDPuJOykEJS9YkowQRw8U5VSL7tQQEkRiIGi7jHcKsUTu
         jo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aI5rpFA+O+q5SGN1wlAZgaPJ7UfrHimu6B38WtNbXwI=;
        b=CK72L/9H8T5a7cbZjtHMpXcKGNy2R9cN0itnGMWFZuwHLxgkDXNcAe4B4O3GB/TCYi
         AgCgV2Fhqo9EFLFyrj2LNc9GXwk1s9OQRrzMSE7ETdp+BbU4FCH1P6Tv++zlb5KjYVFe
         Ef90xi+PdgPccXNlRQZPeXjEYTIDKaCBLaSdwwLVa+xhAoe7hkg3nHWM2x8EaeQ3BSdI
         0r/EhuwGOn1tzAW/dVYIHLlwHITDKSehECKYrHLiPHWQVke40K4XJvqGjKSCmhpk6z7W
         fCYBWlUITUpdtfMyYgX6d5RDZTTuQD1hNxDf87w7SEfVxkmS87cyOy2kk+ogb5cssG8W
         P2rA==
X-Gm-Message-State: APjAAAVoWP++2Uk4OhCXlu3yiAO8vuAfAMsoyPcEDI26RV2+9QEZGUHY
        rHYFtOKqBsX9oEBKn5IriJRo2Q==
X-Google-Smtp-Source: APXvYqy1dwZaVsiy5v8APqXbgekVyXnzBTsjIDVemoEDzSyjcZXe31q4hP0Mk7VSNvMeuXTAgCziAw==
X-Received: by 2002:adf:e6c5:: with SMTP id y5mr31772516wrm.2.1566294766093;
        Tue, 20 Aug 2019 02:52:46 -0700 (PDT)
Received: from cbtest32.netronome.com ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id o14sm31008569wrg.64.2019.08.20.02.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2019 02:52:45 -0700 (PDT)
From:   Quentin Monnet <quentin.monnet@netronome.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Quentin Monnet <quentin.monnet@netronome.com>
Subject: [PATCH bpf-next] bpf: add BTF ids in procfs for file descriptors to BTF objects
Date:   Tue, 20 Aug 2019 10:52:33 +0100
Message-Id: <20190820095233.17097-1-quentin.monnet@netronome.com>
X-Mailer: git-send-email 2.17.1
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Implement the show_fdinfo hook for BTF FDs file operations, and make it
print the id and the size of the BTF object. This allows for a quick
retrieval of the BTF id from its FD; or it can help understanding what
type of object (BTF) the file descriptor points to.

Signed-off-by: Quentin Monnet <quentin.monnet@netronome.com>
Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
---
 kernel/bpf/btf.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 5fcc7a17eb5a..39e184f1b27c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3376,6 +3376,19 @@ void btf_type_seq_show(const struct btf *btf, u32 type_id, void *obj,
 	btf_type_ops(t)->seq_show(btf, t, type_id, obj, 0, m);
 }
 
+#ifdef CONFIG_PROC_FS
+static void bpf_btf_show_fdinfo(struct seq_file *m, struct file *filp)
+{
+	const struct btf *btf = filp->private_data;
+
+	seq_printf(m,
+		   "btf_id:\t%u\n"
+		   "data_size:\t%u\n",
+		   btf->id,
+		   btf->data_size);
+}
+#endif
+
 static int btf_release(struct inode *inode, struct file *filp)
 {
 	btf_put(filp->private_data);
@@ -3383,6 +3396,9 @@ static int btf_release(struct inode *inode, struct file *filp)
 }
 
 const struct file_operations btf_fops = {
+#ifdef CONFIG_PROC_FS
+	.show_fdinfo	= bpf_btf_show_fdinfo,
+#endif
 	.release	= btf_release,
 };
 
-- 
2.17.1

