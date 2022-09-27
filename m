Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0B35EC810
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 17:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiI0Pge (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232460AbiI0Pfo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 11:35:44 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A14412615
        for <bpf@vger.kernel.org>; Tue, 27 Sep 2022 08:35:25 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RFXlJd022526;
        Tue, 27 Sep 2022 15:35:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2022-7-12;
 bh=cHJ/VFjVPikE1IzFMX9B+XCBvD0bjw1qr3ULRHqvuKE=;
 b=Oe8DJdoEz2InUey4AZD7TPTw4J+1Cp4SQyeSf+q2YINJZ1VIonwSjB+vPJgy0TLr8V7B
 wh4Q2W7wIoE3ukDAvHbW/aM4hVbhD4w42tjHjCDHETB/QebZKXThSufe2I9kUeuwvxxo
 CD9i3VAoW3CdPTULPgHazOPn3pm8iTrGB0U/bG2ogrKwd3UHev8WsoZztvaKJlDaH2dy
 rvya9LxkFjFh2Gmrd4toQO5GIgm75L3U5v85N9VQGQXFMVr6s2C72K2d9i1f1JFqcMqJ
 FlGn9nYT18xUmFBSEx1Kzo+KXcaHPVdi6IDkSlirnNtCTfy8JiOuLCp/MSeyVWEis8hl 9g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jstesy8f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 15:35:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28REt1MG023740;
        Tue, 27 Sep 2022 15:34:59 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpq84tbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Sep 2022 15:34:59 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28RFWWwQ018011;
        Tue, 27 Sep 2022 15:34:58 GMT
Received: from myrouter.uk.oracle.com (dhcp-10-175-188-128.vpn.oracle.com [10.175.188.128])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3jtpq84t9n-1;
        Tue, 27 Sep 2022 15:34:58 +0000
From:   Alan Maguire <alan.maguire@oracle.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf] libbpf: fix BTF deduplication for self-referential structs
Date:   Tue, 27 Sep 2022 16:34:54 +0100
Message-Id: <1664292894-21490-1-git-send-email-alan.maguire@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_06,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209270096
X-Proofpoint-GUID: baif4WxZHeGfS7_6h2PltPq9JLWyhkJZ
X-Proofpoint-ORIG-GUID: baif4WxZHeGfS7_6h2PltPq9JLWyhkJZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

BTF deduplication is not deduplicating some structures, leading to
redundant definitions in module BTF that already have identical
definitions in vmlinux BTF.

When examining module BTF, we can see that "struct sk_buff" is redefined
in module BTF. For example in module nf_reject_ipv4 we see:

[114280] STRUCT 'sk_buff' size=232 vlen=28
        '(anon)' type_id=114463 bits_offset=0
        '(anon)' type_id=114464 bits_offset=192
 	...

The rest of the fields point back at base vmlinux type ids.

The first anon field in an sk_buff is:

	union {
		struct {
			struct sk_buff * next;           /*     0     8 */
			struct sk_buff * prev;           /*     8     8 */
			union {
				struct net_device * dev; /*    16     8 */
				long unsigned int dev_scratch; /*    16     8 */
			};                               /*    16     8 */
		};

..and examining its BTF representation, we see

[114463] UNION '(anon)' size=24 vlen=4
        '(anon)' type_id=114462 bits_offset=0
        'rbnode' type_id=517 bits_offset=0
        'list' type_id=83 bits_offset=0
        'll_node' type_id=443 bits_offset=0

...which leads us to

[114462] STRUCT '(anon)' size=24 vlen=3
        'next' type_id=114279 bits_offset=0
        'prev' type_id=114279 bits_offset=64
        '(anon)' type_id=114461 bits_offset=128

...finally getting back to the sk_buff:

[114279] PTR '(anon)' type_id=114280

So perhaps self-referential structures are a problem for
deduplication?

The second union with a non-base BTF id:

	union {
		struct sock *      sk;                   /*    24     8 */
		int                ip_defrag_offset;     /*    24     4 */
	};

...points at

[114464] UNION '(anon)' size=8 vlen=2
	'sk' type_id=113826 bits_offset=0
	...

[113826] PTR '(anon)' type_id=113827

[113827] STRUCT 'sock' size=776 vlen=93
	...
        'sk_error_queue' type_id=114458 bits_offset=1536
        'sk_receive_queue' type_id=114458 bits_offset=1728
	...
        'sk_write_queue' type_id=114458 bits_offset=2880
	...
        'sk_socket' type_id=114295 bits_offset=4992
	...
	'sk_memcg' type_id=113787 bits_offset=5312
        'sk_state_change' type_id=114758 bits_offset=5376
        'sk_data_ready' type_id=114758 bits_offset=5440
        'sk_write_space' type_id=114758 bits_offset=5504
        'sk_error_report' type_id=114758 bits_offset=5568
        'sk_backlog_rcv' type_id=114292 bits_offset=5632
        'sk_validate_xmit_skb' type_id=114760 bits_offset=5696
        'sk_destruct' type_id=114758 bits_offset=5760

Again, sk_error_queue refers to a 'struct sk_buff_head':

[114458] STRUCT 'sk_buff_head' size=24 vlen=3
        '(anon)' type_id=114457 bits_offset=0
        'qlen' type_id=23 bits_offset=128
        'lock' type_id=514 bits_offset=160

...which, because it contains a struct sk_buff * reference
uses the not-deduped sk_buff above.

[114455] STRUCT '(anon)' size=16 vlen=2
        'next' type_id=114279 bits_offset=0
        'prev' type_id=114279 bits_offset=64

Ditto for sk_receive_queue, sk_write_queue, etc.

sk_memcg refers to a non-deduped struct mem_cgroup where
only one field is not in base BTF:

[113786] STRUCT 'mem_cgroup' size=4288 vlen=46
...
        'move_lock_task' type_id=113694 bits_offset=31296
...

and this is a pointer to task_struct:

[113694] PTR '(anon)' type_id=113695

[113695] STRUCT 'task_struct' size=9792 vlen=253
...
	        'last_wakee' type_id=113694 bits_offset=704
...

...so we see that the self-referential members cause problems here
too.

Looking at the code, btf_dedup_is_equiv() will check equivalence
for all member types for BTF_KIND_[STRUCT|UNION]. How will such
an equivalence check function for a pointer back to the same
structure?

With a struct, btf_dedup_struct_type() is called, and for each
candidate (hashed by name offset, member details but not type
ids), we clear the hypot_map (mapping hyothetical type
equivalences) and add a hypot_map entry mapping from the
canon_id -> cand_id in btf_dedup_is_equiv() once it looks
like a rough match.

when we delve into its members we recurse into reference types 
so should ultimately use that mapping to notice self-referential
struct equivalence.

However looking closely, btf_dedup_is_equiv() is being called from
btf_dedup_struct_type() with arguments in the wrong order:

	eq = btf_dedup_is_equiv(d, type_id, cand_id);

The candidate id should I think precede the type_id, as we see in
function signature:

static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
                              __u32 canon_id)

...and with this change the duplication disappears in the modules.

Fixes: d5caef5b56555bfa2ac0 ("btf: add BTF types deduplication algorithm")
Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
---
 tools/lib/bpf/btf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index b4d9a96..a4ee15c 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -4329,7 +4329,7 @@ static int btf_dedup_struct_type(struct btf_dedup *d, __u32 type_id)
 			continue;
 
 		btf_dedup_clear_hypot_map(d);
-		eq = btf_dedup_is_equiv(d, type_id, cand_id);
+		eq = btf_dedup_is_equiv(d, cand_id, type_id);
 		if (eq < 0)
 			return eq;
 		if (!eq)
-- 
1.8.3.1

