Return-Path: <bpf+bounces-9442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4310B797B8E
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 20:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7898B1C2081D
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604DA14007;
	Thu,  7 Sep 2023 18:21:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEE4134DD
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 18:21:35 +0000 (UTC)
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DA792
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 11:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1016; q=dns/txt; s=iport;
  t=1694110893; x=1695320493;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=t+/5Qg07X/8LBgMGaqOz9O2Te5xjcPHhrou4yvr4XxU=;
  b=aljP06QJ4Jntu2u7xrmQMmESq2RUzVnzxGIqquuT6iZX14KB9LZfob9C
   NsQZ4z9P9CGIRr0waI2CqIMA6I6ccTR2ETI16wRce4C5iJR+r0BAHVCTt
   AosxrRksNz9639SOKUTPHyZJUFGLJkPHwCvwkDvkJhve42n4Z64iFnemL
   k=;
X-CSE-ConnectionGUID: IKc0zQkXT9CRpi5txFVSlQ==
X-CSE-MsgGUID: Jk/Iv+OBTNiWiyZFe5bcFw==
X-IronPort-AV: E=Sophos;i="6.02,234,1688428800"; 
   d="scan'208";a="104702965"
Received: from rcdn-core-7.cisco.com ([173.37.93.143])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 09:02:13 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
	by rcdn-core-7.cisco.com (8.15.2/8.15.2) with ESMTPS id 38792AJ9027915
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 7 Sep 2023 09:02:12 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
	id 156E2CC1293; Thu,  7 Sep 2023 02:02:10 -0700 (PDT)
From: Denys Zagorui <dzagorui@cisco.com>
To: alastorze@fb.com, quentin@isovalent.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Cc: dzagorui@cisco.com, bpf@vger.kernel.org
Subject: [PATCH v2] bpftool: fix -Wcast-qual warning
Date: Thu,  7 Sep 2023 02:02:10 -0700
Message-Id: <20230907090210.968612-1-dzagorui@cisco.com>
X-Mailer: git-send-email 2.35.6
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: rcdn-core-7.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
	SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This cast was made by purpose for older libbpf where the
bpf_object_skeleton field is void * instead of const void *
to eliminate a warning (as i understand
-Wincompatible-pointer-types-discards-qualifiers) but this
cast introduces another warning (-Wcast-qual) for libbpf
where data field is const void *

It makes sense for bpftool to be in sync with libbpf from
kernel sources

Signed-off-by: Denys Zagorui <dzagorui@cisco.com>
---
 tools/bpf/bpftool/gen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 2883660d6b67..04c47745b3ea 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -1209,7 +1209,7 @@ static int do_skeleton(int argc, char **argv)
 	codegen("\
 		\n\
 									    \n\
-			s->data = (void *)%2$s__elf_bytes(&s->data_sz);	    \n\
+			s->data = %2$s__elf_bytes(&s->data_sz);		    \n\
 									    \n\
 			obj->skeleton = s;				    \n\
 			return 0;					    \n\
-- 
2.35.6


