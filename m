Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61FA60D719
	for <lists+bpf@lfdr.de>; Wed, 26 Oct 2022 00:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbiJYW2u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Oct 2022 18:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232673AbiJYW2s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Oct 2022 18:28:48 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA08785A7
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:47 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id y12so18326020edc.9
        for <bpf@vger.kernel.org>; Tue, 25 Oct 2022 15:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJ6mjJpQHVqvM/2ly6yDyYOtGPBKn15dyRGLuLQdpPY=;
        b=dNw6cd1RlQ/5PFpbVBmlkqJYq9b2vpk4SaxipQrjTSVnrHpESorAhYE8heA8ReA6Ig
         1xHWmbRUeHlsgLOrxDimg+VEo7AsaFVAnHSC+iXq5Zs26XRfTBThJXQcAGa711P0sdIe
         0JcEJtBIdHaBYotYfqvdc6LjwVUDiMPCeFC2Rlj7/i2waWjWY+pbik2u/gtnx8NJEzco
         nG7yF9TduSlAJ1mTyR2Bggjye4bu7/X/MmoibogihL2OM6/mM4aZ0UpcfC4E9L+7cOWr
         efrJQx4eURf9L4yzW3Q/ICHdUvHrYS6SYIDSUg2TRcnkl7LLQLJ4Oh3Hd9P7eK16u6f5
         /nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJ6mjJpQHVqvM/2ly6yDyYOtGPBKn15dyRGLuLQdpPY=;
        b=uqOsRS3+GfOObcs8jb14WenDQH42EfDRIbAWKnOkQaN+1z+QkYC9zrZKu0hq4S8e6H
         4Ve/WtnMetl2FY1eC+vtoFgD03bW2zgItPgMTlLAhboPekYsm4Wu2aZ7oi6lnulrzsnp
         WZnVY3E4EvYLVFyQxOX1Cp71bY3wy6jT06Ib3gmZR5URc1xEYAanUJbDXfR+bbCQUDPP
         FUaEmEVj5Ue9SNl1FDtG6WF5uIg210I4tVaTYWdPkMKPEm7RE5Da/gK6OMcTR5MAVMBc
         g7zehAJbBNqusSblX1oLW0fN5jPgoeO/BoxHnn9cddcu9yxxSmww8vXUzdEqK2BUQgx/
         kzFA==
X-Gm-Message-State: ACrzQf3N1ET/GZs24kst6OugQCDoWqo6WfzhJIzLtdprMsGVxKjNeFmn
        7kIOf4DUsZbyCTEb1xOrODjenVDsdqIplcrq
X-Google-Smtp-Source: AMsMyM56pJfEQYEViLvI2h/WOMoSv3s6yVaaE1r+PRyx7DLSaAhkJW251N3vqsaHkjNFFWZ0WEzP1A==
X-Received: by 2002:a05:6402:5114:b0:45d:b850:a4e2 with SMTP id m20-20020a056402511400b0045db850a4e2mr36956348edd.316.1666736925725;
        Tue, 25 Oct 2022 15:28:45 -0700 (PDT)
Received: from pluto.. (boundsly.muster.volia.net. [93.72.16.93])
        by smtp.gmail.com with ESMTPSA id ks23-20020a170906f85700b0078d175d6dc5sm1993119ejb.201.2022.10.25.15.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 15:28:45 -0700 (PDT)
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     bpf@vger.kernel.org, ast@kernel.org
Cc:     andrii@kernel.org, daniel@iogearbox.net, kernel-team@fb.com,
        yhs@fb.com, arnaldo.melo@gmail.com,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [RFC bpf-next 07/12] bpftool: Enable header guards generation
Date:   Wed, 26 Oct 2022 01:27:56 +0300
Message-Id: <20221025222802.2295103-8-eddyz87@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221025222802.2295103-1-eddyz87@gmail.com>
References: <20221025222802.2295103-1-eddyz87@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Enables header guards generation for BTF dumps in C format, e.g.
vmlinux.h would be printed as follows:

  ...
  #ifndef _UAPI_LINUX_TCP_H

  enum {
    TCP_NO_QUEUE = 0,
    TCP_RECV_QUEUE = 1,
    TCP_SEND_QUEUE = 2,
    TCP_QUEUES_NR = 3,
  };

  #endif /* _UAPI_LINUX_TCP_H */
  ...

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/bpf/bpftool/btf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 68a70ac03c80..f8e8946b61a7 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -466,7 +466,9 @@ static int dump_btf_c(const struct btf *btf,
 	struct btf_dump *d;
 	int err = 0, i;
 
-	d = btf_dump__new(btf, btf_dump_printf, NULL, NULL);
+	LIBBPF_OPTS(btf_dump_opts, opts);
+	opts.emit_header_guards = true;
+	d = btf_dump__new(btf, btf_dump_printf, NULL, &opts);
 	err = libbpf_get_error(d);
 	if (err)
 		return err;
-- 
2.34.1

