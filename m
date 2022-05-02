Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6BD517A76
	for <lists+bpf@lfdr.de>; Tue,  3 May 2022 01:09:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiEBXNL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 May 2022 19:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiEBXNK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 2 May 2022 19:13:10 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DEF2F386
        for <bpf@vger.kernel.org>; Mon,  2 May 2022 16:09:39 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 242LsRMZ014107
        for <bpf@vger.kernel.org>; Mon, 2 May 2022 16:09:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cOQEdGfjFBc0fQXLFHIZS2Djpy7PTKGsd2sNcXs+11A=;
 b=XHVaaNr99juL9TBA7/qYV/PS1876K8h/dgqZmWUidbhuQriPqwilC+teMp7Rm1vnlzrw
 BfwicAQ8qhGVEfTyKErErXlf5DPMpfF4lqyyms+X1LNtjkvFd1yxMf4NynVQFCsQe/BJ
 A/P2hDk4d9tGlXobBaKQJhG2plxQsu8rIjo= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2047.outbound.protection.outlook.com [104.47.56.47])
        by m0001303.ppops.net (PPS) with ESMTPS id 3fs0sucuq2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 02 May 2022 16:09:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vc486X38OgcLVeLCemoPEqy2ER0SSjFDVSh6BQDb1XkiVugAZ/cNBjXn8TWQAOVAUYpdgzCcS93fF2YuULy0+Z3U/qc5G00/ScESiKueoNGLkBoPoA6IVwErUgUXZJdxsG66GyjG9RlsEnPzrj2edOXLekKD3jNQjh55zwxz2Fu4S2o/bLvY1Gz7AA/71ENaInUf1Kvn8W+he0dSrkFKW3v5IxXknoVb3YoqFDCEYDqQU7GYYcBFCRozNkv8wqBc1GzdDQt36G7iZcYSr1pogmEzup7eMHJVC2gedxbD6p/ZKA3Ltpy56Y7S8FfUreLS8o7wj+/8aJ62BktnMKQf6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOQEdGfjFBc0fQXLFHIZS2Djpy7PTKGsd2sNcXs+11A=;
 b=WdgVpjliGnzvw6DzXrHqkOQOXV6n7ApVz6eF7Y3d3SghfCPfeKaOXbFIYtgPBH/0wU8YmMhC7rB1ll6+F+/uuHy/Dam5DVN6B7ts0x8ZOecZ8U4GrGtKS0GhC0RH+DquUH6APfAzyxrxiZIGTCg1xjATolyzPMTjtgx0eMnJzpFTLjkqI8V9TDSNdLigoVwdd6miWvGpXZ4ZDYBpYaLZF+Bv2t2ntJhDMKIXWODsbh7Pmtl7XG+Qb8gUmVDvt2JHvvqxseMjGztRw52RXGpFcW4ccjXxAJNDY2SxlFunkfvpVe3cLWJ62zh6ZcAxWPs8VJDp7m0BVNQaPFkFiTANzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MWHPR15MB1903.namprd15.prod.outlook.com (2603:10b6:301:59::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.28; Mon, 2 May
 2022 23:09:36 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%5]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 23:09:36 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v2 3/5] bpf: allow sleepable uprobe programs to
 attach
Thread-Topic: [PATCH bpf-next v2 3/5] bpf: allow sleepable uprobe programs to
 attach
Thread-Index: AQHYXnmw6LimKPj6okKMdit4AKAiIA==
Date:   Mon, 2 May 2022 23:09:35 +0000
Message-ID: <611d4629dc959f9d327693180b0d106dcefe949f.1651532419.git.delyank@fb.com>
References: <cover.1651532419.git.delyank@fb.com>
In-Reply-To: <cover.1651532419.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36ddf96c-6815-46c6-2df8-08da2c90d376
x-ms-traffictypediagnostic: MWHPR15MB1903:EE_
x-microsoft-antispam-prvs: <MWHPR15MB19034BBC0F60816E81EB3235C1C19@MWHPR15MB1903.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FJ8JIty3RU0yLHXfPRA7eDiAiJQfMx/QdB8TqDUcdEwQi+ZBnLckLPcbLspktLv65kM2A5grOFPTEPRTPMRzCa9LP1Q3fHDhiuLseAt6xWhsC19AX/FYLAU6KyzyZB3Vqe9aNSen9Q3vtyyTFKjaTeuvBWYvvkbXJEbwYV9cSvb/3ay1PPf9qHuqBXW9j9eew/jzx2fnA1PGuQpGjez+I3BozSiPLkxsfaInhHqw4yvHbv/zjVnuhilTBaST9zbJk5TwjTy7R4GBttb+lXaKEU8vut3EdTNl78ZYRXRFZ0nmSbHQ8Zps7+TI4HszrjIQdRUHS58/FKAD6xN9S1rII9ffeIhtpsjsWGstnUAsaCscorki150/TvmFjI3v/W9wlpIdgIini906k8qXwf3jLThi05SXWtHAEwq78f7+V1SN+89m+6UmxgmLNxWQwY11wN5GChKi3QAlT5imWcLhFWDXx3lFF9UYpt7nKeRJYvbBSoS5HSoxMeLD7MCJo4EInSqbLFYjb2dzLM86s5V04d7I03v7bwBzIMR4rVACfJz+BXEwrVH3Z4OSh8P91xvGjLr76edMuIxTjYEAU9fAnXOOrFfLqwu8fZCVrG/T/1bcmcd2hhYn+3JzJFMY49Iwd8olBZr2mscxrdzA4TQ2vcIZ4vfcYjRMQ5BjrTU8rlTGqkALDCqbcw1CXycVnbxuXGWRciRyC5dA62T2ZbMN9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(36756003)(6512007)(83380400001)(186003)(2906002)(66446008)(8676002)(76116006)(86362001)(5660300002)(71200400001)(66946007)(6506007)(8936002)(316002)(66476007)(66556008)(64756008)(38070700005)(6486002)(122000001)(508600001)(110136005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?vW9rPiZ7uq+l92C+Rjgy6+SPh/vAt7Q95pzA9BaaotQN4s9WObvZzVDM5u?=
 =?iso-8859-1?Q?4z3kDyU3l4eoH1pwNtI05oxRc1hFREGH/XEJ5MSQKmJyGAeq536IVqw5v9?=
 =?iso-8859-1?Q?V+LO4MYdYKFHIn7ScDxcBUy53zwp6W1nv3CxcRReDsvKMqkOMG9ScDbXzi?=
 =?iso-8859-1?Q?O37wLz9rhcyAaQLm1iZPZDLyDbooVKGz34azqZY5QvoR0B0II+xfTjGa45?=
 =?iso-8859-1?Q?5R32jiyb7DjqJg+Lekbdj5jHvH2+PKlsDyimMl9bQB3ShDPEFuuyiNi0HE?=
 =?iso-8859-1?Q?joLg/z8damXDpG3ZANzVjMNjOfIMKQQytDUIuenC1EnPgyUXtpOP1Xa/Ye?=
 =?iso-8859-1?Q?7Bzjv55X4TOFJnl1isYI0l2lZ4dK+ykqkbrxu1+HDO7nSXPLodDLrdflNZ?=
 =?iso-8859-1?Q?fRhJK66N0OAHAziVY3zuy99NLZENzS41uFVF+BFhwINm4IPYE+iDgtT5qw?=
 =?iso-8859-1?Q?rhZehDP3wDHbVqIe6sGX/K8LDnfCX4+K2eGFiLKWjS3+FdJmzauYxHV9ov?=
 =?iso-8859-1?Q?hYAOa+6JZdXKnu6BIimcH6ZujY44zTHitySKdP4UdoaTD8G46wK0EYQosY?=
 =?iso-8859-1?Q?GU2ikD09ZkBdW+C74mXw/qcnbkoEJ56lAxbVJFt+ZdDGJ8FmSMYdK/sX+u?=
 =?iso-8859-1?Q?U/yTEexNI4DS0NLcrySsg9wU0u/vAch9s4zNufZI5KmBZYiUe5lG1EvsKY?=
 =?iso-8859-1?Q?UcRYBMlnBu9J/xv+kmnoyyof3nyiCTqG4o1d2avpXW8kAzNGKBdGnm5CTy?=
 =?iso-8859-1?Q?Tc2uVrS5RWlDTyJ7kybpSfE6IXDhoc3s1WwnHCHOX2NSq2QoGHRvW3wFFA?=
 =?iso-8859-1?Q?rKUxSP3Fw9xmQin2audxSvUZrMb8g+75774t9ZmpISYQbw4653qet/6Y42?=
 =?iso-8859-1?Q?Ld90ziF4fX48Sw/Txswu6noAplmfU5AMvFLtN0gkmyxDcysNpjOA4Hpg4t?=
 =?iso-8859-1?Q?ZrZeqXpAdbcJyiNvgM67TXWHdqidgmO7xOfZIuJbJgB76RzQ39p+KryCKF?=
 =?iso-8859-1?Q?cnfnn5MvBBt3gI1wiQd/NHx3QY6/0AURDPKRUDZP553ZWzjVb5S6rJJPsE?=
 =?iso-8859-1?Q?3ma5qQLBdR5g5diVseLMCYGzergH8PR3SOrIHqXTl/Luhwxc5icmse4JsV?=
 =?iso-8859-1?Q?nBM3iSBaj6ARq2M6+CpzhV/r3b4unR1FV3e0FVapUFztwW3z6/WeajHDGb?=
 =?iso-8859-1?Q?81cH2Lq/3sf7+w5CbSbd2vAInMSrVJKjYfONYk5GKI2+ijCsSGPyXuTcWP?=
 =?iso-8859-1?Q?DXYRBgCXQqsDtYg31IDLM+MnU+HdQGkFeEwLgr+MXNkF82ni8JWSwDGcZz?=
 =?iso-8859-1?Q?LWKoRMaVclRILjpklvDkjt8OlUUlxdSVsFTgAnJ6ZigtfVYGC49149w5nj?=
 =?iso-8859-1?Q?7j1T2TqVkcJT9X5w22UpWm/LSG9nRYBfqQV/ehLZS3e7HZzQmwj2XRbMBv?=
 =?iso-8859-1?Q?pDATFrYnZUGo54UQUq5XVtf2TrZJZPRUe+QX3F7vHxCkXbkw8am6h217lC?=
 =?iso-8859-1?Q?mAqtuhKUnRqMU1bWY5FO1LkNRS3n7aBsqnS/S6gXvhdyYUrSMonWWD4vwS?=
 =?iso-8859-1?Q?xl1xLSkR2V3dwyFIw602ohVV37wZjKIHzi2O3KxwsNlLX15xRJMDQ2ZUYe?=
 =?iso-8859-1?Q?+R1pEfEgj1GuHfaz5j07JyjzylYvdSl7lRcoLBsqzkgGEoYt8PkevGbdPW?=
 =?iso-8859-1?Q?uELDl+vOslxoDsmOVNRuu3eUQhfsHx25XhGPXghbIpGoX+KTxPWdzICUrT?=
 =?iso-8859-1?Q?oPmLtjJpbvLtzMn0MJCCt62AmY6YnruguGOmfsSWVxi/QEY3L4qgj366+G?=
 =?iso-8859-1?Q?43Y8oKc69srNr6YV08uuIfPJt7ufeUNAW5FzTyVbqI1PB/UO9P3V?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ddf96c-6815-46c6-2df8-08da2c90d376
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 23:09:36.0372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: akjbHCtb8h1hZOoU+vUZl3ZwDIrWDIw6Q6CepF+oy7drsD2j9g2AY5Mo4a8kqvzJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1903
X-Proofpoint-GUID: Zoy16mtMueSGGrAulwo_-NPxBkHxmloa
X-Proofpoint-ORIG-GUID: Zoy16mtMueSGGrAulwo_-NPxBkHxmloa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-02_08,2022-05-02_03,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

uprobe and kprobe programs have the same program type, KPROBE, which is
currently not allowed to load sleepable programs.

To avoid adding a new UPROBE type, we instead allow sleepable KPROBE
programs to load and defer the is-it-actually-a-uprobe-program check
to attachment time, where we're already validating the corresponding
perf_event.

A corollary of this patch is that you can now load a sleepable kprobe
program but cannot attach it.

Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 kernel/bpf/verifier.c |  4 ++--
 kernel/events/core.c  | 16 ++++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 813f6ee80419..82b37a1a8a33 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14571,8 +14571,8 @@ static int check_attach_btf_id(struct bpf_verifier_=
env *env)
 	}
=20
 	if (prog->aux->sleepable && prog->type !=3D BPF_PROG_TYPE_TRACING &&
-	    prog->type !=3D BPF_PROG_TYPE_LSM) {
-		verbose(env, "Only fentry/fexit/fmod_ret and lsm programs can be sleepab=
le\n");
+	    prog->type !=3D BPF_PROG_TYPE_LSM && prog->type !=3D BPF_PROG_TYPE_KP=
ROBE) {
+		verbose(env, "Only fentry/fexit/fmod_ret, lsm, and kprobe/uprobe program=
s can be sleepable\n");
 		return -EINVAL;
 	}
=20
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 23bb19716ad3..bd09c4152a3b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10069,26 +10069,30 @@ static inline bool perf_event_is_tracing(struct p=
erf_event *event)
 int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *pro=
g,
 			    u64 bpf_cookie)
 {
-	bool is_kprobe, is_tracepoint, is_syscall_tp;
+	bool is_kprobe, is_uprobe, is_tracepoint, is_syscall_tp;
=20
 	if (!perf_event_is_tracing(event))
 		return perf_event_set_bpf_handler(event, prog, bpf_cookie);
=20
-	is_kprobe =3D event->tp_event->flags & TRACE_EVENT_FL_UKPROBE;
+	is_kprobe =3D event->tp_event->flags & TRACE_EVENT_FL_KPROBE;
+	is_uprobe =3D event->tp_event->flags & TRACE_EVENT_FL_UPROBE;
 	is_tracepoint =3D event->tp_event->flags & TRACE_EVENT_FL_TRACEPOINT;
 	is_syscall_tp =3D is_syscall_trace_event(event->tp_event);
-	if (!is_kprobe && !is_tracepoint && !is_syscall_tp)
+	if (!is_kprobe && !is_uprobe && !is_tracepoint && !is_syscall_tp)
 		/* bpf programs can only be attached to u/kprobe or tracepoint */
 		return -EINVAL;
=20
-	if ((is_kprobe && prog->type !=3D BPF_PROG_TYPE_KPROBE) ||
+	if (((is_kprobe || is_uprobe) && prog->type !=3D BPF_PROG_TYPE_KPROBE) ||
 	    (is_tracepoint && prog->type !=3D BPF_PROG_TYPE_TRACEPOINT) ||
 	    (is_syscall_tp && prog->type !=3D BPF_PROG_TYPE_TRACEPOINT))
 		return -EINVAL;
=20
+	if (prog->type =3D=3D BPF_PROG_TYPE_KPROBE && prog->aux->sleepable && !is=
_uprobe)
+		/* only uprobe programs are allowed to be sleepable */
+		return -EINVAL;
+
 	/* Kprobe override only works for kprobes, not uprobes. */
-	if (prog->kprobe_override &&
-	    !(event->tp_event->flags & TRACE_EVENT_FL_KPROBE))
+	if (prog->kprobe_override && !is_kprobe)
 		return -EINVAL;
=20
 	if (is_tracepoint || is_syscall_tp) {
--=20
2.35.1
