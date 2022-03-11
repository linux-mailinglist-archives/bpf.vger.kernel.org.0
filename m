Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B514D5662
	for <lists+bpf@lfdr.de>; Fri, 11 Mar 2022 01:12:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239798AbiCKANb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 19:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238512AbiCKANa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 19:13:30 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E7B62F5
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:12:26 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22AJQ4rx020300
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:12:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=4MWhU/WX5BiQ5dXo2Orb2E48CSjV8N3nspX05zjbIzA=;
 b=QWBTtahEBGaF9o0sluJNOMpmwyWaOjQm5zUZPChmfKJO6Tp/Q2RTqOpFelAvQvCNvgX0
 BD3XIZGj74CFoJlH0IySW8mbqHV31Sdi9EYUHSOGijoblhifJTzmi0jb8vskkgGJSA9c
 BRA2vXxgGUmngSUh74YV7NDp1GUzDK/GT40= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3eqqfssuyt-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 16:12:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+Lokg/yaSDwMUma6ThSP2YzODvuEt5QuP8KPoHiDRvxZgzZPEFfjkSttiChwZj7DGMwp+rdkn7qGoQ5BdbrO0d6zBhY7O/Q6yaZSRGPeu+giVW59rtl/SOSMhdBnsTjmS401a4a/G0OqciNcnZ0+bSOvOhSKPlQ/cCn/Cyp8u1MCB+V9/KswV3zTOnl0me9rpVURM+CMLalXma2ZSLiMhVUI/9wZY8ks408dLouzjYTKha9If3wrNObqhYznEJB4trFt/aGnNjfSR/YXguxtTkXqF64Q1Zy/iDcozUl49MSY2wOz00Tmm8WmfLVmtAbsEh+1dNyT8wzIsHiqR9vmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4MWhU/WX5BiQ5dXo2Orb2E48CSjV8N3nspX05zjbIzA=;
 b=jnb1WOUeZ48WDYikiR1Fm7OYvm2sK/Wpca3DadWRpGNcc1YbzqWGOgeujIuJMLwxyb5Rj3sOQa8BEj2VODXEmQgcTJRxuBvEdLP4/8X+6WcJ2hs1OkNR0zjzOC64H6Hcq+su/ZUq3jNi3NO5tQBZYlAf8EP8EiCena5/uZ8x9ScWGiSqiBwHi5Rw6gRhYPR+Ue1eVmh5erFi5LtOlplZSrexWwB62+oMrdeN6uJMXfCkkwRFmaseXeKu3jwlvbXwOuKkYWeh4gPqrEBMct2laYNMOAj40l5j3y5n7weH6ei454c5OFBguBFO0djPPJx8ADhyAN5jJSprffQVD/yetA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by SJ0PR15MB4201.namprd15.prod.outlook.com (2603:10b6:a03:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 11 Mar
 2022 00:12:12 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::90c1:20f8:4fc6:d7a3%6]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 00:12:12 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 5/5] selftests/bpf: test subskeleton functionality
Thread-Topic: [PATCH bpf-next v2 5/5] selftests/bpf: test subskeleton
 functionality
Thread-Index: AQHYNNynKBOOrW4LI0Oh4u2OfVdj+w==
Date:   Fri, 11 Mar 2022 00:12:11 +0000
Message-ID: <f262f63b36d00d4a77d1166bcaffe7684b6ebbee.1646957399.git.delyank@fb.com>
References: <cover.1646957399.git.delyank@fb.com>
In-Reply-To: <cover.1646957399.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec8f6196-652c-49db-c809-08da02f3ca47
x-ms-traffictypediagnostic: SJ0PR15MB4201:EE_
x-microsoft-antispam-prvs: <SJ0PR15MB420148A1AF009B0E05B0C261C10C9@SJ0PR15MB4201.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MM/k0U2svTOH88ZIhJVkyBpDhQ2p7irgVIjmjFtPeli8wqXJtTJW6q3ORiYHR67MVjDbjJWRIYgkGBWDEIcrxvZHyHW8m54Flod8RLdE/joTdMEM/f0a7eFiEXEtZZgTo+Hkd4/pdr4vOWzxw+YDiw+L05uNowXja4u3Zjl0OzLKPmNCMG2d0MPSIqfe9hAr4RJ+FGZeX8KKWWwn40zMDmh1a+InWfTgmHtYDfBLL0ZYiPN4tw9l9RkZ+6cJT3vfewnpWG2mReN7z1Oan7tKcl/6W/jUJ5vMfxp8w0fYO6yZZ96qnH0/0RvLSE4omZ+HlEow2A4YYaqjqS4J0mHZJLAWFER3wRfaAZsqHpiv3kOHQDxXZ3PmYXe9vDvjqc2La9ib3TjtGXmFMEspm1j4zFCbhKZO1rJ4pyb8bGhni0ISEzkQzZAJlKOF4QjwlWujKv8ityFMVkVVBL7NtRcdXaQSHE5s9loSK/wda6qtaEphPp+BYsOmkUrdEq+NnbroM75vGkU/vzu9RHsbQPVrI8qvWfyQl5jn29GJJf33+Kaky/hK5EcQJIhnuhsjQeqD7DOl/WXoE1Hcnj2N4gbk6+/4MoFhUlLKovSfIcKqKornSOjdIez1BIzlBdueTfXwi7Ly+Tcpjta0QadrvfJksdY7CJcXwQQ+UG6M7t3dUD3Hy26PhJHqKmz7GCmTaBv4f7FGqOLyOe79Yn3c1EmqoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(122000001)(8676002)(86362001)(316002)(6486002)(38070700005)(66556008)(83380400001)(66946007)(186003)(64756008)(66476007)(2616005)(66446008)(76116006)(91956017)(36756003)(8936002)(2906002)(5660300002)(6506007)(6512007)(508600001)(71200400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EXHYe6t/kyCNaZzpJ9O6mbJMm36HYW4uQL8vPXQjTjqzyYwvFxod8A18uV?=
 =?iso-8859-1?Q?Zd/lZuX98o1QPsdusvrjP4EvpNebArZGxpmjfLgSSDv/IvrGb3+Vf3vlfZ?=
 =?iso-8859-1?Q?wUfsPlslS1ena168fw+989LV7r/siGoL4l6jJW6GqjPCZp+wuW/R1ASEf8?=
 =?iso-8859-1?Q?IAGFsgUYxiPptFmvzkZMf3dOd7/gPEfvgG4BcElJ0XY8VFeeOhDpEvIcRn?=
 =?iso-8859-1?Q?InqcgILExFaNAAP8j4EzNPi9hi69Bvgk0OsGmFrrA6MOGec0HmQ3wpvE30?=
 =?iso-8859-1?Q?1yImowLyDB+z4BcaMvOvBhdizg3drX/b14FJESMjHUaMRR+xJhory/gC0z?=
 =?iso-8859-1?Q?AbK0RW9IhWo497bYDwVbFyPnRyJ9w+I5UEe32XPDjnW8NEQY7r4MOLQm0F?=
 =?iso-8859-1?Q?XYctxW3GVlJHN5KSjKOc9dYcO6KXLeR+WcSgWwZaLifDQqI2QYCBbiccfj?=
 =?iso-8859-1?Q?lDSVfNisBqpfP/d64L9grjW23P4C+T31uzMGv2pcpfX8wbCQZKRl5VYu0z?=
 =?iso-8859-1?Q?LeMh7Wz5HiXzvdEoNGDN1A3onmnShoIKQWHIYFPHkLup/27Hagqj+G48j9?=
 =?iso-8859-1?Q?A4iSP/ZOSfK0Fm2Pc8vfJS9REaznPrhlmy+EeDLCvr02qd/j7+nw4WFJxp?=
 =?iso-8859-1?Q?7YMwoCzXlJvc0+LhjLAobQo9j5OjoPNRdNXKafwQF2xuGBcy8DbVJT1u/y?=
 =?iso-8859-1?Q?36zCSGdTMS7DmVJVGS+3ikl76/IcU3BEvFqzWXhU5CpPsti6+NTcF9baml?=
 =?iso-8859-1?Q?XDR8UQlvBmkCsorMqpYrHFyB5MLVO0cclhYFI+sL2VgG/YksyugYAapRS6?=
 =?iso-8859-1?Q?Ixypcw/TmNbfe8khth7eR3tj0uDr/VA5Cys8p7IrkUpARxijGRe6Msrkl/?=
 =?iso-8859-1?Q?19/Afk2p301nbS523n/XPzZJGNvXkz7+a5HcBWG2Psf+3mV0qi0IuUB8XZ?=
 =?iso-8859-1?Q?3s90XojXrCrLBECmDYFY43psljqCIuFKGQqv+0g6Foonuhppr+hPQCsHR7?=
 =?iso-8859-1?Q?JaT5cwCEjhNF3sDQ8xjvZy++tNS9g4ABPKjLfzIkOTiBhvRrNWLWWhnu/1?=
 =?iso-8859-1?Q?5+OtJnF1c1Q8QeDl5u8gtXRmHHFLYN5+MHsop4jVpWqtNd5wzu6ICi2+sk?=
 =?iso-8859-1?Q?pNYmfT2oEamjO9EF8Rm0c7a6ihcYVIC79MZT4TX/a0f13AY2cSeEIJHZDn?=
 =?iso-8859-1?Q?f2RTiQIq82kpXAnmnmPX0wM/nnfB8qJiJ83hZTpH9YG5CxyZJSp+P/mjAC?=
 =?iso-8859-1?Q?q5/YpWVM86kFhfZV0yZ2rZNq6CeEIWnIjv8roIBFo1AQkZ3BuyVFc/CHab?=
 =?iso-8859-1?Q?ZfSqA0ubJC90ZOtTKvsLIy8HPASv2GA+p9ZxSUfdctNwYEJlDr5RF8p1v0?=
 =?iso-8859-1?Q?UyDw70LUd2fUaDO8qmBSvfVuyNLo86srpGERi6QMs18hIQeb/u/CjRegGO?=
 =?iso-8859-1?Q?j0RAYFmMZxdkv8DdrPDdE798m2byTX11L1ZB+C2xHFrH5rhDeqgaqCdYT0?=
 =?iso-8859-1?Q?Gg6m0U2QepdHdEvGX/L0qHJNaeB7RE+E3qp+9RJHdcdy5EXO2NjJyF2zoR?=
 =?iso-8859-1?Q?vWFtIoWsP5ZQz5gUVkt9iELfR1o2OmQEOtKcVOZXpBgDr0lD8FxfY/UFVt?=
 =?iso-8859-1?Q?JoqAtdIFXA00bNeaVinGDzJocxI5Pkq05+FRQnSjf+Yuu8ItsqsTl8ig?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec8f6196-652c-49db-c809-08da02f3ca47
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 00:12:11.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwROJ/ZV4YIy5UJIRxNtfx/JVni4+a+UMlJYH0T15CwIAawS/s79k1vxq8keblXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4201
X-Proofpoint-GUID: C1bIicOLiFgA9pm3Q8wGxyr3mirp4qoK
X-Proofpoint-ORIG-GUID: C1bIicOLiFgA9pm3Q8wGxyr3mirp4qoK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-10_09,2022-03-09_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This patch changes the selftests/bpf Makefile to  also generate
a subskel.h for every skel.h it would have normally generated.

Separately, it also introduces a new subskeleton test which tests
library objects, externs, weak symbols, kconfigs, and user maps.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 tools/testing/selftests/bpf/.gitignore        |  1 +
 tools/testing/selftests/bpf/Makefile          | 10 ++-
 .../selftests/bpf/prog_tests/subskeleton.c    | 83 +++++++++++++++++++
 .../selftests/bpf/progs/test_subskeleton.c    | 23 +++++
 .../bpf/progs/test_subskeleton_lib.c          | 56 +++++++++++++
 .../bpf/progs/test_subskeleton_lib2.c         | 16 ++++
 6 files changed, 188 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib.=
c
 create mode 100644 tools/testing/selftests/bpf/progs/test_subskeleton_lib2=
.c

diff --git a/tools/testing/selftests/bpf/.gitignore b/tools/testing/selftes=
ts/bpf/.gitignore
index a7eead8820a0..595565eb68c0 100644
--- a/tools/testing/selftests/bpf/.gitignore
+++ b/tools/testing/selftests/bpf/.gitignore
@@ -31,6 +31,7 @@ test_tcp_check_syncookie_user
 test_sysctl
 xdping
 test_cpp
+*.subskel.h
 *.skel.h
 *.lskel.h
 /no_alu32
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests=
/bpf/Makefile
index fe12b4f5fe20..9f7b22faedd6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -328,6 +328,12 @@ SKEL_BLACKLIST :=3D btf__% test_pinning_invalid.c test=
_sk_assign.c
 LINKED_SKELS :=3D test_static_linked.skel.h linked_funcs.skel.h		\
 		linked_vars.skel.h linked_maps.skel.h
=20
+# In the subskeleton case, we want the test_subskeleton_lib.subskel.h file
+# but that's created as a side-effect of the skel.h generation.
+LINKED_SKELS +=3D test_subskeleton.skel.h test_subskeleton_lib.skel.h
+test_subskeleton.skel.h-deps :=3D test_subskeleton_lib2.o test_subskeleton=
_lib.o test_subskeleton.o
+test_subskeleton_lib.skel.h-deps :=3D test_subskeleton_lib2.o test_subskel=
eton_lib.o
+
 LSKELS :=3D kfunc_call_test.c fentry_test.c fexit_test.c fexit_sleep.c \
 	test_ringbuf.c atomics.c trace_printk.c trace_vprintk.c \
 	map_ptr_kern.c core_kern.c core_kern_overflow.c
@@ -404,6 +410,7 @@ $(TRUNNER_BPF_SKELS): %.skel.h: %.o $(BPFTOOL) | $(TRUN=
NER_OUTPUT)
 	$(Q)$$(BPFTOOL) gen object $$(<:.o=3D.linked3.o) $$(<:.o=3D.linked2.o)
 	$(Q)diff $$(<:.o=3D.linked2.o) $$(<:.o=3D.linked3.o)
 	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<:.o=
=3D)) > $$@
+	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=3D.linked3.o) name $$(notdir $$(<=
:.o=3D)) > $$(@:.skel.h=3D.subskel.h)
=20
 $(TRUNNER_BPF_LSKELS): %.lskel.h: %.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
@@ -421,6 +428,7 @@ $(TRUNNER_BPF_SKELS_LINKED): $(TRUNNER_BPF_OBJS) $(BPFT=
OOL) | $(TRUNNER_OUTPUT)
 	$(Q)diff $$(@:.skel.h=3D.linked2.o) $$(@:.skel.h=3D.linked3.o)
 	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
 	$(Q)$$(BPFTOOL) gen skeleton $$(@:.skel.h=3D.linked3.o) name $$(notdir $$=
(@:.skel.h=3D)) > $$@
+	$(Q)$$(BPFTOOL) gen subskeleton $$(@:.skel.h=3D.linked3.o) name $$(notdir=
 $$(@:.skel.h=3D)) > $$(@:.skel.h=3D.subskel.h)
 endif
=20
 # ensure we set up tests.h header generation rule just once
@@ -557,6 +565,6 @@ $(OUTPUT)/bench: $(OUTPUT)/bench.o \
 EXTRA_CLEAN :=3D $(TEST_CUSTOM_PROGS) $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)	\
 	prog_tests/tests.h map_tests/tests.h verifier/tests.h		\
 	feature bpftool							\
-	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h no_alu32 bpf_gcc bpf_testmo=
d.ko)
+	$(addprefix $(OUTPUT)/,*.o *.skel.h *.lskel.h *.subskel.h no_alu32 bpf_gc=
c bpf_testmod.ko)
=20
 .PHONY: docs docs-clean
diff --git a/tools/testing/selftests/bpf/prog_tests/subskeleton.c b/tools/t=
esting/selftests/bpf/prog_tests/subskeleton.c
new file mode 100644
index 000000000000..9cbe17281f17
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/subskeleton.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <test_progs.h>
+#include "test_subskeleton.skel.h"
+#include "test_subskeleton_lib.subskel.h"
+
+void subskeleton_lib_setup(struct bpf_object *obj)
+{
+	struct test_subskeleton_lib *lib =3D test_subskeleton_lib__open(obj);
+
+	if (!ASSERT_OK_PTR(lib, "open subskeleton"))
+		goto out;
+
+	*lib->rodata.var1 =3D 1;
+	*lib->data.var2 =3D 2;
+	lib->bss.var3->var3_1 =3D 3;
+	lib->bss.var3->var3_2 =3D 4;
+
+out:
+	test_subskeleton_lib__destroy(lib);
+}
+
+int subskeleton_lib_subresult(struct bpf_object *obj)
+{
+	struct test_subskeleton_lib *lib =3D test_subskeleton_lib__open(obj);
+	int result;
+
+	if (!ASSERT_OK_PTR(lib, "open subskeleton")) {
+		result =3D -EINVAL;
+		goto out;
+	}
+
+	result =3D *lib->bss.libout1;
+	ASSERT_EQ(result, 1 + 2 + 3 + 4 + 5 + 6, "lib subresult");
+
+	ASSERT_OK_PTR(lib->progs.lib_perf_handler, "lib_perf_handler");
+	ASSERT_STREQ(bpf_program__name(lib->progs.lib_perf_handler),
+		     "lib_perf_handler", "program name");
+
+	ASSERT_OK_PTR(lib->maps.map1, "map1");
+	ASSERT_STREQ(bpf_map__name(lib->maps.map1), "map1", "map name");
+
+	ASSERT_EQ(*lib->data.var5, 5, "__weak var5");
+	ASSERT_EQ(*lib->data.var6, 6, "extern var6");
+	ASSERT_TRUE(*lib->kconfig.CONFIG_BPF_SYSCALL, "CONFIG_BPF_SYSCALL");
+
+out:
+	test_subskeleton_lib__destroy(lib);
+	return result;
+}
+
+void test_subskeleton(void)
+{
+	int err, result;
+	struct test_subskeleton *skel;
+
+	skel =3D test_subskeleton__open();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+
+	skel->rodata->rovar1 =3D 10;
+	skel->rodata->var1 =3D 1;
+	subskeleton_lib_setup(skel->obj);
+
+	err =3D test_subskeleton__load(skel);
+	if (!ASSERT_OK(err, "skel_load"))
+		goto cleanup;
+
+
+	err =3D test_subskeleton__attach(skel);
+	if (!ASSERT_OK(err, "skel_attach"))
+		goto cleanup;
+
+	/* trigger tracepoint */
+	usleep(1);
+
+	result =3D subskeleton_lib_subresult(skel->obj) * 10;
+	ASSERT_EQ(skel->bss->out1, result, "unexpected calculation");
+
+cleanup:
+	test_subskeleton__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton.c b/tools/t=
esting/selftests/bpf/progs/test_subskeleton.c
new file mode 100644
index 000000000000..5bd5452b41cd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subskeleton.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* volatile to force a read, compiler may assume 0 otherwise */
+const volatile int rovar1;
+int out1;
+
+/* Override weak symbol in test_subskeleton_lib */
+int var5 =3D 5;
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
diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c b/too=
ls/testing/selftests/bpf/progs/test_subskeleton_lib.c
new file mode 100644
index 000000000000..665338006e33
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subskeleton_lib.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <stdbool.h>
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+/* volatile to force a read */
+const volatile int var1;
+volatile int var2 =3D 1;
+struct {
+	int var3_1;
+	__s64 var3_2;
+} var3;
+int libout1;
+
+extern volatile bool CONFIG_BPF_SYSCALL __kconfig;
+
+int var4[4];
+
+__weak int var5 SEC(".data");
+extern int var6;
+int (*fn_ptr)(void);
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 16);
+} map1 SEC(".maps");
+
+extern struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 16);
+} map2 SEC(".maps");
+
+int lib_routine(void)
+{
+	__u32 key =3D 1, value =3D 2;
+
+	(void) CONFIG_BPF_SYSCALL;
+	bpf_map_update_elem(&map2, &key, &value, BPF_ANY);
+
+	libout1 =3D var1 + var2 + var3.var3_1 + var3.var3_2 + var5 + var6;
+	return libout1;
+}
+
+SEC("perf_event")
+int lib_perf_handler(struct pt_regs *ctx)
+{
+	return 0;
+}
+
+char LICENSE[] SEC("license") =3D "GPL";
diff --git a/tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c b/to=
ols/testing/selftests/bpf/progs/test_subskeleton_lib2.c
new file mode 100644
index 000000000000..cbff92674b76
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_subskeleton_lib2.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_HASH);
+	__type(key, __u32);
+	__type(value, __u32);
+	__uint(max_entries, 16);
+} map2 SEC(".maps");
+
+int var6 =3D 6;
+
+char LICENSE[] SEC("license") =3D "GPL";
--=20
2.34.1
