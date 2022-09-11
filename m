Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D435B4CB1
	for <lists+bpf@lfdr.de>; Sun, 11 Sep 2022 10:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiIKIq2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 11 Sep 2022 04:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiIKIq1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 11 Sep 2022 04:46:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431323207C
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:46:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nc14so13687520ejc.4
        for <bpf@vger.kernel.org>; Sun, 11 Sep 2022 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=PxBIDlOz/oNNEmNNYrXSw2RO4vH4JKthBQ66hiIBTxw=;
        b=KWMW/7/XpOgmRjDVVKc10iVmH3hbsocWBHpv0dO+nriso3MJdn+f9FaajmELYRnPes
         WVF9mgQ+1HTNOM1SQoEIk8d+A8/mMrLj0MYDar/NL40EqphmWOD6rKEOAznoGPHW0Wyj
         nJZ43Oh4Bh75TPC3mV5JjwZ4SKQ76QtlLMGYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PxBIDlOz/oNNEmNNYrXSw2RO4vH4JKthBQ66hiIBTxw=;
        b=2RXdYkE5WSbfz/CzTt6Q/XERMZvB+H9J9jCyZ52McHq9uGdLNhDBNB3uj0dAyTrNt/
         OpZgNfBgAt4aPQ/Dpyg6yqwSqt7nePEZlvLZEq6MNShPNZgr5YgVnH9Q1cJoRMpfzhCc
         cYAsfDNssxQ/BYT6M/+Sq5aX3xdH0X4zpkC/XNhY8Os/OBKIZbsspomdTgNhRGl6+FP7
         4SpP1H7mJqseM1L6V/a78RmcApC6TJf/HYjjXkIW/nBO8FD/UEfECi/a/TEpslxotIV/
         EehbMVzWOVsE6JzQYTB9z1v3hb2QysvJVHI38a0xy+WrT+vegf1hZl87MT8ZEsCKxnA0
         g09Q==
X-Gm-Message-State: ACgBeo08pgo5Fesu5Kc6GKy4B+7lgeO7sDr4+DIJV8VNaZaEYcGCWWKA
        hpCe/nsCxQhMbGAyipUXxHyfbQiR6SAwniiDreKMvHMXBb5wjzuK7QcH1ZVsGupm7bBY2KxsqaS
        zCJv4bcJpCvOX5zv97N3pnkdCz3joSH+GKDBunzE+v/31w314MrTfRzPhNTBmMWlFidoCkzm91Z
        Q=
X-Google-Smtp-Source: AA6agR5D+joSmhtU3dTKsQZpZdQEfHyY6hHxnY7QezbKXNygiFSfqp0zNLS1Vt5DKkK/IYgMuDz2VA==
X-Received: by 2002:a17:906:fd8a:b0:75d:c79a:47c8 with SMTP id xa10-20020a170906fd8a00b0075dc79a47c8mr14694815ejb.389.1662885983510;
        Sun, 11 Sep 2022 01:46:23 -0700 (PDT)
Received: from localhost.localdomain ([141.226.162.95])
        by smtp.gmail.com with ESMTPSA id q10-20020a170906360a00b007309a570bacsm2713591ejb.176.2022.09.11.01.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 01:46:23 -0700 (PDT)
From:   Shmulik Ladkani <shmulik@metanetworks.com>
X-Google-Original-From: Shmulik Ladkani <shmulik.ladkani@gmail.com>
To:     bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: [PATCH v6 bpf-next 1/4] bpf: Export 'bpf_dynptr_get_data, bpf_dynptr_get_size' helpers
Date:   Sun, 11 Sep 2022 11:46:06 +0300
Message-Id: <20220911084609.102519-2-shmulik.ladkani@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220911084609.102519-1-shmulik.ladkani@gmail.com>
References: <20220911084609.102519-1-shmulik.ladkani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This allows kernel code dealing with dynptrs obtain dynptr's available
size and current (w. proper offset) data pointer.

Signed-off-by: Shmulik Ladkani <shmulik.ladkani@gmail.com>
---
v5:
- fix bpf_dynptr_get_data's incorrect usage of bpf_dynptr_kern's size
  spotted by Joanne Koong <joannelkoong@gmail.com>
v6:
- Simplify bpf_dynptr_get_data's interface and make it inline
  suggested by John Fastabend <john.fastabend@gmail.com>
---
 include/linux/bpf.h  | 6 ++++++
 kernel/bpf/helpers.c | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 48ae05099f36..e0844f45022f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2631,6 +2631,12 @@ void bpf_dynptr_init(struct bpf_dynptr_kern *ptr, void *data,
 		     enum bpf_dynptr_type type, u32 offset, u32 size);
 void bpf_dynptr_set_null(struct bpf_dynptr_kern *ptr);
 int bpf_dynptr_check_size(u32 size);
+u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr);
+
+static inline void *bpf_dynptr_get_data(struct bpf_dynptr_kern *ptr)
+{
+	return ptr->data ? ptr->data + ptr->offset : NULL;
+}
 
 #ifdef CONFIG_BPF_LSM
 void bpf_cgroup_atype_get(u32 attach_btf_id, int cgroup_atype);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index fc08035f14ed..824864ac82d1 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1408,7 +1408,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
 	ptr->size |= type << DYNPTR_TYPE_SHIFT;
 }
 
-static u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
+u32 bpf_dynptr_get_size(struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_SIZE_MASK;
 }
-- 
2.37.3

