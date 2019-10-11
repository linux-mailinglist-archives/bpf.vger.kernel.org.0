Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32452D35EA
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 02:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbfJKA26 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 20:28:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40329 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbfJKA2k (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 20:28:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id 7so8025019ljw.7
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 17:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LjUmR6syFZQTjTX+EMH7Sbgc4CwkKZT5NTkS4TQtAUc=;
        b=mnI2QbGCo1NRiFTjyOBIqf6KabxlSsnPI4hdGenxjeIyJTkSXKVt+0hJS0M5neXKLA
         QBHDyXER/DRHnVa4ubnHrlLClZtvLAtNYFdgQF3rb4NcU4bmKJ0Lz2Ufxthc/b0bJ1+Z
         kW4AWWBQ2OqryumuH+jEK+ydtLRpiEzBtnHnm7tZaq6+hU/ItTonq/Y3xqyD177deZTS
         bDH08drSrEruU6qymWOgxylscRznlSk57CIdPAwhHWK3wTFu0VdkWrvR+s6lEse6B5Go
         1vh0iAFOmgwbO1zArtb6aL2WFaJ1aR6YdgCcd9ExuDq4DEQiXiJOktqlD/av3XyosuSO
         f42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LjUmR6syFZQTjTX+EMH7Sbgc4CwkKZT5NTkS4TQtAUc=;
        b=kVk9tpiWkE56sBDZVvhcqrTt7u+/p3GdvHYjknbg6B1i3NBC3QIu9WEzoNgucb/NDx
         1z+kAoLA8Ny7g4CPcFiGamQ4FTEa1OXHM/o624YUmZdhXpYNu4I5ZJbul+DUqtIdGrKw
         CnZVXT/Ldd5a0LkpMYc/5QV/LbMfGNMbs0s2NcJrDpj6cqcRfXpCC50vCBTj7+lc9Fyb
         xTkPuOdFVWs2YqqYHVE0dlxrncAQK3bEo4Ms/uWDV0+xxaUbY2n38uKGePLRwLxE9n0f
         6FzRfLK5VYDFsuICSU9q+3pr8PPH7uAYOIoMmjI0809sT6zqKThh2r+70UcYFTZjrBeP
         s+4g==
X-Gm-Message-State: APjAAAUj6KplqtzEq6PWD7t8smsSZLlCwnL37jckmmr2moup4a40rJ3r
        LYMfW2BYnAnYoXfYSshObA4T2Q==
X-Google-Smtp-Source: APXvYqw3xBuKAwJLBbXvSMeq+H2mubLdl9QJO6loIzPi+swWT6qeo8+IJ6UrP2bxsA8AXu9fvQT6DA==
X-Received: by 2002:a2e:9cc9:: with SMTP id g9mr7896959ljj.160.1570753718464;
        Thu, 10 Oct 2019 17:28:38 -0700 (PDT)
Received: from localhost.localdomain (88-201-94-178.pool.ukrtel.net. [178.94.201.88])
        by smtp.gmail.com with ESMTPSA id 126sm2367010lfh.45.2019.10.10.17.28.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 17:28:37 -0700 (PDT)
From:   Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
To:     ast@kernel.org, daniel@iogearbox.net, yhs@fb.com,
        davem@davemloft.net, jakub.kicinski@netronome.com, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        ilias.apalodimas@linaro.org, sergei.shtylyov@cogentembedded.com,
        Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Subject: [PATCH v5 bpf-next 13/15] samples/bpf: provide C/LDFLAGS to libbpf
Date:   Fri, 11 Oct 2019 03:28:06 +0300
Message-Id: <20191011002808.28206-14-ivan.khoronzhuk@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
References: <20191011002808.28206-1-ivan.khoronzhuk@linaro.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

In order to build lib using C/LD flags of target arch, provide them
to libbpf make.

Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
---
 samples/bpf/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index a6c33496e8ca..6b161326ac67 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -248,7 +248,8 @@ clean:
 
 $(LIBBPF): FORCE
 # Fix up variables inherited from Kbuild that tools/ build system won't like
-	$(MAKE) -C $(dir $@) RM='rm -rf' LDFLAGS= srctree=$(BPF_SAMPLES_PATH)/../../ O=
+	$(MAKE) -C $(dir $@) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
+		LDFLAGS=$(TPROGS_LDFLAGS) srctree=$(BPF_SAMPLES_PATH)/../../ O=
 
 $(obj)/syscall_nrs.h:	$(obj)/syscall_nrs.s FORCE
 	$(call filechk,offsets,__SYSCALL_NRS_H__)
-- 
2.17.1

