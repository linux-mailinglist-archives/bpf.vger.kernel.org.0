Return-Path: <bpf+bounces-6777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D8E76DD25
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 03:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55F9281E61
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 01:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD44820E1;
	Thu,  3 Aug 2023 01:28:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A21747F;
	Thu,  3 Aug 2023 01:28:19 +0000 (UTC)
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 3647C26BA;
	Wed,  2 Aug 2023 18:28:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 3EEF1602E666B;
	Thu,  3 Aug 2023 09:28:14 +0800 (CST)
X-MD-Sfrom: kunyu@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li kunyu <kunyu@nfschina.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	song@kernel.org,
	yhs@fb.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li kunyu <kunyu@nfschina.com>
Subject: [PATCH bpf-next v2] bpf: bpf_struct_ops: Remove unnecessary initial values of variables
Date: Sat,  5 Aug 2023 01:59:29 +0800
Message-Id: <20230804175929.2867-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_24_48,
	RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

err and tlinks is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 v2:
   Remove tlinks initialization assignment.

 kernel/bpf/bpf_struct_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index d3f0a4825fa6..c05585ed1f37 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -374,9 +374,9 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 	struct bpf_struct_ops_value *uvalue, *kvalue;
 	const struct btf_member *member;
 	const struct btf_type *t = st_ops->type;
-	struct bpf_tramp_links *tlinks = NULL;
+	struct bpf_tramp_links *tlinks;
 	void *udata, *kdata;
-	int prog_fd, err = 0;
+	int prog_fd, err;
 	void *image, *image_end;
 	u32 i;
 
@@ -818,7 +818,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 	struct bpf_struct_ops_map *st_map, *old_st_map;
 	struct bpf_map *old_map;
 	struct bpf_struct_ops_link *st_link;
-	int err = 0;
+	int err;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
 	st_map = container_of(new_map, struct bpf_struct_ops_map, map);
-- 
2.18.2


