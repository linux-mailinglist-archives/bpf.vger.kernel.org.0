Return-Path: <bpf+bounces-11305-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E97667B723A
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 94F4C281556
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D6F3D39C;
	Tue,  3 Oct 2023 20:05:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C9E3D965
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:05:35 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C778AAC
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 13:05:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59f67676065so18839497b3.0
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696363531; x=1696968331; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh+n8bfd+fHj2PxoCINgvh14gMdSrVtFDRZkzUjMD80=;
        b=r9229aUppDM5a8GSXDn6L7UCUzPPKwmSCYxDImQzgyy0fKwU86aePbAB2OHlPsQvVm
         UHjbtrvi/Yl/Im9Reom3+FPuTjLt0pjMa2DTbKovAG3zFajyz38N+BbkPTIGCR+HAmJB
         BI/8qa/z5/DLf0WzSkpVM1l5JFX/xMLpWSUsDhKfDqeJjxDKUwbdUMNd3sEPOU0hSOze
         IA3CTyRMmB2ZF2W69MfC/luRCs9awHjqjYFbv4HlV+t0Zvp635MHa8Us8gAKxjxM+xHA
         Hrc7WmbfZntdIfTYY0T1bKmi52keSU80apHCfU6gW/Nc7B+0mmAg/I9uPKRebrxhZcgA
         V0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363531; x=1696968331;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hh+n8bfd+fHj2PxoCINgvh14gMdSrVtFDRZkzUjMD80=;
        b=g3ikvDc0U4D7R55XyyKTCgxwjvYCYac/RdagCus/tNPeoZ1/bIZE3Vg/fuBmT60PRl
         jyesp0lnfgEbjcpZejGZgRhC0QAVY9kfnaAmIfbPi0X/DOUNQfQ1FmS7BQ5e5OMlHilz
         n6plArMCwruNQ9c9YyaLoBIKbjghMhBa7x+N7avWq9z6+HX0k5nIn+gTSTugRNLRLTkP
         EuFBgUO1QXks9W7NTglkwWU+hlXYd4LbmUNAhdUIrxhf9PNnRDCesZc4KNyf6tUKqE4P
         ishkK4YqpvIdAf4Wb9xISeUVkKDpAYfMR5uKAfhXEsAyCCcETuOGbFsGDA5Q1iZFgCZ7
         bDdQ==
X-Gm-Message-State: AOJu0YxpYkI4eUxZtf+nPRn7kPAs3s2XPEsOlQoEH2ykqFATKJ7omMNU
	exH6P5DnG9ZnWuQz3ZcR0qZetaH4T2GvsgBxWl6GOTvUwsE+EIKGNwuwCE0qApdLTJdqw6BU3ff
	7xNCLN0MSWcQKx/P4lUJPz9boXsTP15Ed6wJYa8hetsIIbD6ljg==
X-Google-Smtp-Source: AGHT+IHTQgMe8sMfvHu6NgAk1AoxlPxP/xK+lhLViG2zt8Eyi6GlaOmftpMsUU9ommqz85SWCvaco5k=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:ca4d:0:b0:59b:e81f:62ab with SMTP id
 y13-20020a81ca4d000000b0059be81f62abmr12027ywk.7.1696363530546; Tue, 03 Oct
 2023 13:05:30 -0700 (PDT)
Date: Tue,  3 Oct 2023 13:05:15 -0700
In-Reply-To: <20231003200522.1914523-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003200522.1914523-4-sdf@google.com>
Subject: [PATCH bpf-next v3 03/10] tools: ynl: print xsk-features from the sample
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Regenerate the userspace specs and print xsk-features bitmask.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/samples/netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index b828225daad0..da7c2848f773 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -44,6 +44,12 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 			printf(" %s", netdev_xdp_rx_metadata_str(1 << i));
 	}
 
+	printf(" xsk-features (%llx):", d->xsk_features);
+	for (int i = 0; d->xsk_features > 1U << i; i++) {
+		if (d->xsk_features & (1U << i))
+			printf(" %s", netdev_xsk_flags_str(1 << i));
+	}
+
 	printf(" xdp-zc-max-segs=%u", d->xdp_zc_max_segs);
 
 	name = netdev_op_str(op);
-- 
2.42.0.582.g8ccd20d70d-goog


