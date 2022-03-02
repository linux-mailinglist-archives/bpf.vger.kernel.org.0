Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C488E4C9B63
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 03:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbiCBCti (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Mar 2022 21:49:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235976AbiCBCti (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Mar 2022 21:49:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EE2AA034
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 18:48:55 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2221cmCd017818
        for <bpf@vger.kernel.org>; Tue, 1 Mar 2022 18:48:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=f8lPfnRiag8el5diAMmbcStYfZyYO2j2g16tDVcfMwk=;
 b=ZIc6VpV2Dj6p9/9W+jbg875dfWWeXE+6J8sH0LAgd4aZlK3nRU0TZi8j+J7HGDowIR0a
 GQ9BJu5nZc5MrueCSZjrJimflPgabRVlAeTRv5FcmZ9WWWyHKGwalClYi8XFBXcQFbi6
 9q3olb+dkyMe/eNdxaIKSwgHho0TCO/UcYE= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by m0089730.ppops.net (PPS) with ESMTPS id 3ehn5wmt5a-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Mar 2022 18:48:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUL1KbX0fawymq/8vkcZPkPWVlBFLOX5a0Sn0Bwt93zORxjeRp9UixaVKKo8zppu/10jQQK0Wlk0NDvtAU4MQrRfw2svSiMEkbBE+bQB+TC8Uy+SJ8ecAMkWpCTWSS2GFzJVTRFPfXR/Pvm1/8YfyPtV2oJW9Lhl9pr9H4yiirmHrOQ72nvvJAwg/Ax9jkF8W0z2je82ZNDfoMSkRwCTc5oX6rZcoIc75h7E0LZHw+mSSPhh1xng5CCu4jB9OWJCsVjb4CZcXOCMHpyZWdIUuQiO9DKBIyodVvlPXB4Ht/cFqCkHum7lOeTHdEhUmTsUo0VB2MS6pvpwPUC9vVSu4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8lPfnRiag8el5diAMmbcStYfZyYO2j2g16tDVcfMwk=;
 b=SZk7naYUqpnjAr0WfrVQUpuGlXfa9z1rlfc99ARGDOtVv4Qe6J52QpCErwcFDWUSCRsiz5tDZvYifPkRr7Etl2+OIMf5bfOAK8uRcJKW+yRVDuf0WCFPDrL9h6QzZS/SpCsaFbRJhocEsT5CAIjV2wZ/Ti0gk/yiUxG/ECtK8oeXu+g7BmPI4eDpPWQ26qCUKMVN14QS9hUFhAvEpJhpJEJJhmwwgh/i1csJ4EkNT3vlr91+gtwJGOPwhiQImuiO0A6Ykq5b67BvJvlU0IhNrxrrwupDQP80xoYDPrZZXOKyptzg/eOiPYvV0zJLatoEeCV1RmPfl9EbxPGIkZnwyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MW4PR15MB4441.namprd15.prod.outlook.com (2603:10b6:303:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 02:48:48 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%5]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 02:48:48 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next 4/4] selftests/bpf: test subskeleton functionality
Thread-Topic: [PATCH bpf-next 4/4] selftests/bpf: test subskeleton
 functionality
Thread-Index: AQHYLeAKFjdznAZJQ0qoqoIsaLkktQ==
Date:   Wed, 2 Mar 2022 02:48:48 +0000
Message-ID: <89a850b9c06835b839da76386ee0e4bbeaf5a37b.1646188795.git.delyank@fb.com>
References: <cover.1646188795.git.delyank@fb.com>
In-Reply-To: <cover.1646188795.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17ec22d4-690c-4c20-4160-08d9fbf72d46
x-ms-traffictypediagnostic: MW4PR15MB4441:EE_
x-microsoft-antispam-prvs: <MW4PR15MB444162B2DCAD57456EF320C7C1039@MW4PR15MB4441.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EzOjkV8pP3KLX9MYF4t5ojV+JpoOvJyo5E7nMzk1zezjIV/UUAL0sThm4UpKRUady2us5cyFKXqLOiQqswtqaGFoYa8bn32MeJ7LYi1hkjPNNx/ije8RPe5H26A/s0BZDSO9pBYkuOuv9CJqsMeGnYgOcQFAWlG9i9CictCSApcK3hWCK/7YKmhYyy0TP74HpTykukwMLLFfTPv9ZaeC7wOLzURFxPqJJWwIkjoAXrxT7kMsJksh8HzYPPBDo1p97Q6PFjrLTWMf62xIjs5q2mqw3/zkvRtE1RvKgqOlCgPP9nKyN143kxYq71VOHYbsTGWVuc6j7ZbA8uU2Ww4GQ1o9+22ysZTCTl5R/8l2fFo3UqUbpFhm9fr2Unf5INYDRQarA7OSkyrgS3zOB1WPnTVC+AALslyUEYt1wmlP5DnBH9Sz0MWZwP3NwSahvXkkKdtza4PFV3ctNfHsI3Yae8H0v7L2yyLaEvc/tdun460d40F/CrtLpffUM5I8nXbk/Pw0NoMlCw7KIVT+MPkQgiIvrG6zKN8qIWbl89FXykf3ssRatQzHRSnor5UAuOLw0pL6RGX9NpfDjEtgjRi9z130b1asdZxJN5kbl0dmiwOnXcUHdeB1sBd9hnUiGiPO9PG309OgCXSyDbudjIUq8FCfoJ9SOpbaA3/+h/aSG3tUEefIrvLJL0kf95RlUGPIwbS0hlY/TXZGiU74j0UrUQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(38100700002)(83380400001)(110136005)(122000001)(86362001)(6512007)(6506007)(66476007)(186003)(38070700005)(91956017)(36756003)(2616005)(66946007)(76116006)(66446008)(66556008)(64756008)(2906002)(8936002)(5660300002)(71200400001)(508600001)(8676002)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?wYC9QTh5gYC1mS0C/jN3PtjbBut0xq8gyzwwbi/E90JiqR0hjvsXYRqAd0?=
 =?iso-8859-1?Q?74O+6QKC3PtTXEn4aqRzIo/KwDxZHIdzfQEVd4arErWx27Cremqob4reY/?=
 =?iso-8859-1?Q?NkxBhPrioPCqu/76rNU8ZwiK48AOynjkZpYvFqLItFSKuftCyHy9TseUCG?=
 =?iso-8859-1?Q?Pl5PVecMWX5e4sRNqpuIR1HpGQtVCzmFpYQ0k2zwLtUWyZmLnpGz1pZ26N?=
 =?iso-8859-1?Q?29tU6UUrXyCOCCQ7HGEz85xG/tOzBEu4JZ7cTCAfsuBGHT3fdDWH3dkwXT?=
 =?iso-8859-1?Q?BJJSj3P/ZZVH7XHDGlzkuSYdZG+DQDIw06M0i5G7Vr1Dhd8tXZ/16a7sRF?=
 =?iso-8859-1?Q?INMn3DjrfcFUQUL9TV0DPQnKxN0zgxXO3xiXvUGyEtt7NJvzeCuPBT96Zg?=
 =?iso-8859-1?Q?G5hIqvpGAz7LHQ08WXJ3M40D9C/DYFv6UBNwrgfC1FMs3R4xnuxIsykIlS?=
 =?iso-8859-1?Q?fqsWgNAKcH09BEzS2/cW821hXexNZz3d9JC4RhR2e7LHIsHTyFUj8nYH5R?=
 =?iso-8859-1?Q?FNAiA2uPxyi3Gvxze78tMzNCNXN5GAzZSTcWOBpQ2n+zrPZ6d5h0JMdD62?=
 =?iso-8859-1?Q?v2mDlLx/g/sX420ZxYyTyzDdU4G8vjhweEWbrkvI3fE7VZduwGpKCWra5E?=
 =?iso-8859-1?Q?1Isul20b8SME3aYiHYHqC9pEWGQ+XGGTPvkHPCrq2d+gKLJloa3h3Plmji?=
 =?iso-8859-1?Q?w/WdtRVnr1ZRSEJxHoSMTMjm1eNsgfm5MWQxnei3FW5yBWUs9j3RQNpLPD?=
 =?iso-8859-1?Q?GNZMrRbux863i1tmArZFRejT056/VvytOJKPKLyxh+J1TzGD7CzcD9Bfry?=
 =?iso-8859-1?Q?3UkC0dYH+Ggh/IM5RhF7PsKozAUHnm69ZAUpwk5QV3Y/ykCMqLFF+IobCi?=
 =?iso-8859-1?Q?uR7YtNkRFcFyfLgx4dxJ6/EvptBOtQ2sMRDVQcbYM41DKQYC1i+1uS7QsK?=
 =?iso-8859-1?Q?D+Oqgcm6es3ljWsdrhK5XW3cV1zR7kA183ladHOwA2DQc2rmdA5/zYrfXs?=
 =?iso-8859-1?Q?xx2rQOrHRll/drhILpWq0oj2zgjoVwtFRWtq7Sl/+UrK5biG6VGhWZhYph?=
 =?iso-8859-1?Q?JNFZ0HE4Q36E4DdBhQzNX3Tax8MbVfo+aZSkLhoTFuzXZF5BMtvxgetJ6v?=
 =?iso-8859-1?Q?SMQLy3ctouPPoWwKlDEscK27IbtE8vdcq1G1UcjA+xRLv1sECFbKCOgB17?=
 =?iso-8859-1?Q?YlUGh8oWpeNW42oUUfWgkpIiUfFvWiN8R7r86j6IGbu1H0ezfRNP8XhVdz?=
 =?iso-8859-1?Q?GXocxwmTVwx7CFsYulBrsYhmjqNouMTgB05d6u7M6C89xoAc15dQKFizji?=
 =?iso-8859-1?Q?Z06JOcW/ntwdHx2c7z4G3PrlNBZS+zEDR9FOMp1AhbGLwaUS9jZjm9A7cg?=
 =?iso-8859-1?Q?FF34V105J986AYWnxFNNywBBtc33KVGUfi4xENKWzKppOMazNCXuZncWuZ?=
 =?iso-8859-1?Q?//tJmbZEZ2JnavjzS8Xlr51tTVhAXabcg/bkRkE1UZVeM+WSayhy+Hct7Y?=
 =?iso-8859-1?Q?R4ezQZn2FbCMoh0HZrGa7Wq/rnu6UNgw3XVm/Jo9Gkc7p1xmMTKJc7mkMx?=
 =?iso-8859-1?Q?dlxgx+yIQXnkLHdZmAqxCg2PBLE+PaKB1IolvLoqSiDa3kjcmOHav1rMwL?=
 =?iso-8859-1?Q?/S2D390KmRLVuIWbgw2IyaPCn3EV84qb34/CEIY8r1RfQnY8fZ+yqjzg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ec22d4-690c-4c20-4160-08d9fbf72d46
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2022 02:48:48.3759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fhfU2FfpMJ3UHlICg8Q6he2OYd2vmLKryuMNrYkMUQOrhJ1Kxh2ovDId1gBPUED2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4441
X-Proofpoint-GUID: aqKLqf5eAEmbRevizC1jSo2CPX44wvJ9
X-Proofpoint-ORIG-GUID: aqKLqf5eAEmbRevizC1jSo2CPX44wvJ9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 bulkscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203020010
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The new Makefile support via SUBSKELS and .skel.h-deps is a mixture
of LINKED_SKELS and LSKELS. By definition subskeletons require multiple
BPF object files to be linked together. However, generating the
subskeleton only requires the library object file and not the final
program object file.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/testing/selftests/bpf/Makefile          | 18 ++++++++-
 .../selftests/bpf/prog_tests/subskeleton.c    | 38 +++++++++++++++++++
 .../bpf/prog_tests/subskeleton_lib.c          | 29 ++++++++++++++
 .../selftests/bpf/progs/test_subskeleton.c    | 20 ++++++++++
 .../bpf/progs/test_subskeleton_lib.c          | 22 +++++++++++
 5 files changed, 125 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton_lib.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.=
c

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index fe12b4f5fe20..57da63ba790b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -326,19 +326,23 @@ endef
 SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test_sk_assign.c
=20
 LINKED_SKELS :=3D test_static_linked.skel.h linked_funcs.skel.h		\
-		linked_vars.skel.h linked_maps.skel.h
+		linked_vars.skel.h linked_maps.skel.h test_subskeleton.skel.h
+
+SUBSKELS :=3D test_subskeleton_lib.skel.h
=20
 LSKELS :=3D kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
 	map_ptr_kern.c core_kern.c core_kern_overflow.c
 # Generate both light skeleton and libbpf skeleton for these
 LSKELS_EXTRA :=3D test_ksyms_module.c test_ksyms_weak.c kfunc_call_test_su=
bprog.c
-SKEL_BLACKLIST +=3D $$(LSKELS)
+SKEL_BLACKLIST +=3D $$(LSKELS) $$(SUBSKELS)
=20
 test_static_linked.skel.h-deps :=3D test_static_linked1.o test_static_link=
ed2.o
 linked_funcs.skel.h-deps :=3D linked_funcs1.o linked_funcs2.o
 linked_vars.skel.h-deps :=3D linked_vars1.o linked_vars2.o
 linked_maps.skel.h-deps :=3D linked_maps1.o linked_maps2.o
+test_subskeleton.skel.h-deps :=3D test_subskeleton_lib.o test_subskeleton.=
o
+test_subskeleton_lib.skel.h-deps :=3D test_subskeleton_lib.o
=20
 LINKED_BPF_SRCS :=3D $(patsubst %.o,%.c,$(foreach skel,$(LINKED_SKELS),$($=
(skel)-deps)))
=20
@@ -363,6 +367,7 @@ TRUNNER_BPF_SKELS :=3D $$(patsubst %.c,$$(TRUNNER_OUTPU=
T)/%.skel.h,	\
 				 $$(filter-out $(SKEL_BLACKLIST) $(LINKED_BPF_SRCS),\
 					       $$(TRUNNER_BPF_SRCS)))
 TRUNNER_BPF_LSKELS :=3D $$(patsubst %.c,$$(TRUNNER_OUTPUT)/%.lskel.h, $$(L=
SKELS) $$(LSKELS_EXTRA))
+TRUNNER_BPF_SUBSKELS :=3D $$(addprefix $$(TRUNNER_OUTPUT)/,$(SUBSKELS))
 TRUNNER_BPF_SKELS_LINKED :=3D $$(addprefix $$(TRUNNER_OUTPUT)/,$(LINKED_SK=
ELS))
 TEST_GEN_FILES +=3D $$(TRUNNER_BPF_OBJS)
=20
@@ -405,6 +410,14 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.o $(BPFTOOL) | $(TRU=
NNER_OUTPUT)
 	$(Q)diff $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked3.o)
 	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<:.o=
=3D)) > $$@
=20
+$(TRUNNER_BPF_SUBSKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
+	$$(call msg,GEN-SUBSKEL,$(TRUNNER_BINARY),$$@)
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked1.o) $$<
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked1.o)
+	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked3.o) $$(<:.o=3D.linked2.o)
+	$(Q)diff $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked3.o)
+	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<=
:.o=3D)) > $$@
+
 $(TRUNNER_BPF_LSKELS): %.lskel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked1.o) $$<
@@ -441,6 +454,7 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_EXTRA_HDRS)				\
 		      $(TRUNNER_BPF_OBJS)				\
 		      $(TRUNNER_BPF_SKELS)				\
+		      $(TRUNNER_BPF_SUBSKELS)				\
 		      $(TRUNNER_BPF_LSKELS)				\
 		      $(TRUNNER_BPF_SKELS_LINKED)			\
 		      $$(BPFOBJ) | $(TRUNNER_OUTPUT)
diff --git a/tools/testing/selftests/bpf/prog_tests/subskeleton.c b/tools/t=
esting/selftests/bpf/prog_tests/subskeleton.c
new file mode 100644
index 000000000000..651aafc28e7f
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/subskeleton.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+
+#include <test_progs.h>
+#include "test_subskeleton.skel.h"
+
+extern void subskeleton_lib_setup(struct bpf_object *obj);
+extern int subskeleton_lib_subresult(struct bpf_object *obj);
+
+void test_subskeleton(void)
+{
+	int duration =3D 0, err, result;
+	struct test_subskeleton *skel;
+
+	skel =3D test_subskeleton__open();
+	if (CHECK(!skel, "skel_open", "failed to open skeleton\n"))
+		return;
+
+	skel->rodata->rovar1 =3D 10;
+
+	err =3D test_subskeleton__load(skel);
+	if (CHECK(err, "skel_load", "failed to load skeleton: %d\n", err))
+		goto cleanup;
+
+	subskeleton_lib_setup(skel->obj);
+
+	err =3D test_subskeleton__attach(skel);
+	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	usleep(1);
+
+	result =3D subskeleton_lib_subresult(skel->obj) * 10;
+	ASSERT_EQ(skel->bss->out1, result, "unexpected calculation");
+cleanup:
+	test_subskeleton__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/prog_tests/subskeleton_lib.c b/too=
ls/testing/selftests/bpf/prog_tests/subskeleton_lib.c
new file mode 100644
index 000000000000..f7f98b3febaf
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/subskeleton_lib.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2019 Facebook */
+
+#include <test_progs.h>
+#include <bpf/libbpf.h>
+
+#include "test_subskeleton_lib.skel.h"
+
+void subskeleton_lib_setup(struct bpf_object *obj)
+{
+	struct test_subskeleton_lib *lib =3D test_subskeleton_lib__open(obj);
+
+	ASSERT_OK_PTR(lib, "open subskeleton");
+
+	*lib->data.var1 =3D 1;
+	*lib->bss.var2 =3D 2;
+	lib->bss.var3->var3_1 =3D 3;
+	lib->bss.var3->var3_2 =3D 4;
+}
+
+int subskeleton_lib_subresult(struct bpf_object *obj)
+{
+	struct test_subskeleton_lib *lib =3D test_subskeleton_lib__open(obj);
+
+	ASSERT_OK_PTR(lib, "open subskeleton");
+
+	ASSERT_EQ(*lib->bss.libout1, 1 + 2 + 3 + 4, "lib subresult");
+	return *lib->bss.libout1;
+}
diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton.c b/tools/t=
esting/selftests/bpf/progs/test_subskeleton.c
new file mode 100644
index 000000000000..bad3970718cb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subskeleton.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+const int rovar1;
+int out1;
+
+extern int lib_routine(void);
+
+SEC("raw_tp/sys_enter")
+int handler1(const void *ctx)
+{
+	out1 =3D lib_routine() * rovar1;
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "GPL";
+int VERSION SEC("version") =3D 1;
diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c b/too=
ls/testing/selftests/bpf/progs/test_subskeleton_lib.c
new file mode 100644
index 000000000000..23c7f24997a7
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2021 Facebook */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+int var1 =3D -1;
+int var2;
+struct {
+	int var3_1;
+	__s64 var3_2;
+} var3;
+int libout1;
+
+int lib_routine(void)
+{
+	libout1 =3D  var1 + var2 + var3.var3_1 + var3.var3_2;
+	return libout1;
+}
+
+char LICENSE[] SEC("license") =3D "GPL";
+int VERSION SEC("version") =3D 1;
--=20
2.34.1
