Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB560610243
	for <lists+bpf@lfdr.de>; Thu, 27 Oct 2022 22:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbiJ0UA4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Oct 2022 16:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236823AbiJ0UAd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Oct 2022 16:00:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FA010FF0
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 13:00:28 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36ba0287319so23552687b3.3
        for <bpf@vger.kernel.org>; Thu, 27 Oct 2022 13:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RP55M8cA5M2RXo8rOon2JD5KhcZkcbkmc4ixPrmMem4=;
        b=hjkhJabFkn0xjp3ooIiT6qUbyMYEDUSI2QuChlBbDXQQ5HNfNN8+I+bFe8j2cBJgoZ
         oRPArOxcW/M864tAkzcPY671i8RDYxN32TcbY0cIcLB2IwIWfm6AVePXM2FVjeCo0b2R
         Bx4Eqgyb9+H6iWLZjDlytBat4d6JouHpsFYU3tmCifz24e6LWempBi7DjILFIksvBAt1
         omEbPEMyso4TjhRN6ebWSGvztHkBG22SVWdgcyWjYlPZhUKir1TIeop1Iduzc2g3Lz+g
         s+cQkgUSf4zaL0tQ6quMUjRUaiqlq0sr3IkqoAEnSu6XW6aIbWEUJ1Ys/3cTE8RapL1T
         L9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RP55M8cA5M2RXo8rOon2JD5KhcZkcbkmc4ixPrmMem4=;
        b=Ul7Q4estKNcqzSCEh+mEpyBZRk1Cb2guin4ylyx12iUyJ77DKb+bWERpUsNtSS/kc5
         0hJoOq5hIT4OvPjXBBXeGnF0w8RNi8+V0I7iUIoeIFwhlJf1YHm5oiEd1ehd6+Jlvayd
         GAx6sMh2s8VsmQtYzN/IciWDNTrJlLR6Bj70TMFD1nLPmqAWRtjW1xkHqVIpHucmTfhe
         i2tlEA+NpcPft3mLGeq4HpRZAQg1f+72Or+ZgUxXO9ffR3OW77MKuifpD7Oest6JqbJg
         jOGwSu8TZJpgc2FlO/AdMKAzEizXBJPf8CNYztY1oYJ0x0SIciyEVjrEHUuBeu+thzMD
         RUCw==
X-Gm-Message-State: ACrzQf05cv8qQUNbaSnu9T+Vtj8gVDFZ6F2FwiaqNK5fS/2/J8n8YcB7
        r4JYchxrbSpNJVxvOXTch8SPQGVqIpS7PPaVJdmnCvv6iINnFwXfbqra101cBLutYo/BeKy7eZS
        WAhfUY75xISPUUZYPpmOtK9ktOuewZzA6RczA234Y8dHOMPQIVQ==
X-Google-Smtp-Source: AMsMyM77QeyllYbofvOa5Xukf+6LO5LkGydr8MQ+Mrn0YajmX3NrsZDFSyNNTfTCbD+ZFdb3Hxi/bY0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:10a:b0:6af:b884:840e with SMTP id
 o10-20020a056902010a00b006afb884840emr46744379ybh.330.1666900827359; Thu, 27
 Oct 2022 13:00:27 -0700 (PDT)
Date:   Thu, 27 Oct 2022 13:00:17 -0700
In-Reply-To: <20221027200019.4106375-1-sdf@google.com>
Mime-Version: 1.0
References: <20221027200019.4106375-1-sdf@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221027200019.4106375-4-sdf@google.com>
Subject: [RFC bpf-next 3/5] libbpf: Pass prog_ifindex via bpf_object_open_opts
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow passing prog_ifindex to BPF_PROG_LOAD. This patch is
not XDP metadata specific but it's here because we (ab)use
prog_ifindex as "target metadata" device during loading.
We can figure out proper UAPI story if we decide to go forward
with the kfunc approach.

Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>
Cc: xdp-hints@xdp-project.net
Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/lib/bpf/libbpf.c | 1 +
 tools/lib/bpf/libbpf.h | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 5d7819edf074..61bc37006fe4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -7190,6 +7190,7 @@ static int bpf_object_init_progs(struct bpf_object *obj, const struct bpf_object
 
 		prog->type = prog->sec_def->prog_type;
 		prog->expected_attach_type = prog->sec_def->expected_attach_type;
+		prog->prog_ifindex = opts->prog_ifindex;
 
 		/* sec_def can have custom callback which should be called
 		 * after bpf_program is initialized to adjust its properties
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index eee883f007f9..4a40b7623099 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -170,9 +170,13 @@ struct bpf_object_open_opts {
 	 */
 	__u32 kernel_log_level;
 
+	/* Optional ifindex of netdev for offload purposes.
+	 */
+	int prog_ifindex;
+
 	size_t :0;
 };
-#define bpf_object_open_opts__last_field kernel_log_level
+#define bpf_object_open_opts__last_field prog_ifindex
 
 LIBBPF_API struct bpf_object *bpf_object__open(const char *path);
 
-- 
2.38.1.273.g43a17bfeac-goog

