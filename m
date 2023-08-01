Return-Path: <bpf+bounces-6617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6685676BE80
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 22:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 967E41C210D8
	for <lists+bpf@lfdr.de>; Tue,  1 Aug 2023 20:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C6B024166;
	Tue,  1 Aug 2023 20:36:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26C4DC94
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 20:36:42 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B601FFE
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 13:36:40 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 371H5wvF023654
	for <bpf@vger.kernel.org>; Tue, 1 Aug 2023 13:36:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=66lP6+DoUx0vWWYrSLKyi1jcooczLlbUqeze/fBecXs=;
 b=CEjgvuN0+wk7x/askdIm0xnML3HuUxDc+LikeVz0HCfecXYg0KubovpyPQy0g7jkOLWX
 Nym5cvhFW5lvrev5nCjDzWanPADkhuwgz06lM7rDNcngUnYHv35pdb7k5cSoZ/GnVGPc
 n/0z2XCKmMHmB1+wLoeVVgH8JaO4zr3zPAk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3s6wjknqtm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <bpf@vger.kernel.org>; Tue, 01 Aug 2023 13:36:39 -0700
Received: from twshared6136.05.ash9.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 13:36:38 -0700
Received: by devbig077.ldc1.facebook.com (Postfix, from userid 158236)
	id 065EB22048677; Tue,  1 Aug 2023 13:36:33 -0700 (PDT)
From: Dave Marchevsky <davemarchevsky@fb.com>
To: <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Dave Marchevsky
	<davemarchevsky@fb.com>
Subject: [PATCH v1 bpf-next 2/7] bpf: Consider non-owning refs trusted
Date: Tue, 1 Aug 2023 13:36:25 -0700
Message-ID: <20230801203630.3581291-3-davemarchevsky@fb.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801203630.3581291-1-davemarchevsky@fb.com>
References: <20230801203630.3581291-1-davemarchevsky@fb.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: w2WSpMzzjvPbnE377q7TQbUdMNmeD_uz
X-Proofpoint-GUID: w2WSpMzzjvPbnE377q7TQbUdMNmeD_uz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_18,2023-08-01_01,2023-05-22_02
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Recent discussions around default kptr "trustedness" led to changes such
as commit 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the
verifier."). One of the conclusions of those discussions, as expressed
in code and comments in that patch, is that we'd like to move away from
'raw' PTR_TO_BTF_ID without some type flag or other register state
indicating trustedness. Although PTR_TRUSTED and PTR_UNTRUSTED flags mark
this state explicitly, the verifier currently considers trustedness
implied by other register state. For example, owning refs to graph
collection nodes must have a nonzero ref_obj_id, so they pass the
is_trusted_reg check despite having no explicit PTR_{UN}TRUSTED flag.
This patch makes trustedness of non-owning refs to graph collection
nodes explicit as well.

By definition, non-owning refs are currently trusted. Although the ref
has no control over pointee lifetime, due to non-owning ref clobbering
rules (see invalidate_non_owning_refs) dereferencing a non-owning ref is
safe in the critical section controlled by bpf_spin_lock associated with
its owning collection.

Note that the previous statement does not hold true for nodes with shared
ownership due to the use-after-free issue that this series is
addressing. True shared ownership was disabled by commit 7deca5eae833
("bpf: Disable bpf_refcount_acquire kfunc calls until race conditions are=
 fixed"),
though, so the statement holds for now. Further patches in the series wil=
l change
the trustedness state of non-owning refs before re-enabling
bpf_refcount_acquire.

Let's add NON_OWN_REF type flag to BPF_REG_TRUSTED_MODIFIERS such that a
non-owning ref reg state would pass is_trusted_reg check. Somewhat
surprisingly, this doesn't result in any change to user-visible
functionality elsewhere in the verifier: graph collection nodes are all
marked MEM_ALLOC, which tends to be handled in separate codepaths from
"raw" PTR_TO_BTF_ID. Regardless, let's be explicit here and document the
current state of things before changing it elsewhere in the series.

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
---
 include/linux/bpf_verifier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index f70f9ac884d2..b6e58dab8e27 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -745,7 +745,7 @@ static inline bool bpf_prog_check_recur(const struct =
bpf_prog *prog)
 	}
 }
=20
-#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
+#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED | NON_OWN_REF=
)
=20
 static inline bool bpf_type_has_unsafe_modifiers(u32 type)
 {
--=20
2.34.1


