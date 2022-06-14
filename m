Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C058754BE2D
	for <lists+bpf@lfdr.de>; Wed, 15 Jun 2022 01:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240106AbiFNXKz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Jun 2022 19:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240108AbiFNXKv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 14 Jun 2022 19:10:51 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8C652B0D
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:46 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25EMcqrw006248
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=VZNTSQJbvvTtEpRIh+e++fhF/w6C3GTaVRh+vwDGskA=;
 b=EzbzSXeUCQedV6h9bomitBcS8SEcbZqDGbctIe00EUsRag8JNrSIvnP4wy6Z8XSsMP+C
 ufSPiubadkcVzTcmt7piWlU8X+awwIHu0nZVYebnVJicd2kjoqbItzmDrzGTlHG0GeCw
 hpbcR34UyI5RGypAsjzfJNZ5bAZ/7YbQxc8= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gpht16dwf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 14 Jun 2022 16:10:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AQEUYzG52OJcFaBP0cz22sxBM/2l3ESg9wvGl3bn+wcq9vTKRwv7jukrKfZFH0egINjM0gZkDaZwXxk3KRaCxDP0k8WJN7Gx9MalW2pSQOSpngd1ot7FSv1XocQ/5z8Mwvr3Imck0TDUmqTf1tHADw76FELHaaqu789C+YU+YG3Ac2xSRmGhGV6ItFqG33t1MwDe2NWeQu3qBVuf1gCFQl6rzfwqr8zae9UNTUBCU7P22z0f5WwN7/W+fIDxTDJleX2drHgShyJCoj/CBQQMTOlCFjkwdb1VqbvzPrnfuzaBctaVvn/4sYZN2TuyOUyVl/0+2AgnZvZCekFB6wDAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZNTSQJbvvTtEpRIh+e++fhF/w6C3GTaVRh+vwDGskA=;
 b=X5Adqx+eWx8TqC6/6RLlF/SfZMNZ8nDqsb9xFdnvM78XJN5nhWoH6DozYl4a9rZf24xoie9qe80cwloX+zwBRETaAE2kk7wwFuxdqMZrf74zVOHZDkZr93G/DnODdbCKA3D6UKzXGy9MNFuwkwF3ShqJuem5uu2quzH+HNogx8kKJFyvCTJOoZAbSxV3b2e0bqO2tl42cwwBOqrZvuO3ZrtU8a2uWXZSeYjK21tLXoDTpKD//fbL0RU1MV1k4Kjgar1XFeFWIKUzygjXdwPcg3HMGXX0FhKY/sTf2+guQd9pJ2zPEP273P58c2QP+vB04llze9UrZNSggJcBcgNt3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by MW5PR15MB5220.namprd15.prod.outlook.com (2603:10b6:303:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 23:10:43 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::8910:e73d:9868:600b%9]) with mapi id 15.20.5332.016; Tue, 14 Jun 2022
 23:10:43 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v4 3/5] bpf: allow sleepable uprobe programs to
 attach
Thread-Topic: [PATCH bpf-next v4 3/5] bpf: allow sleepable uprobe programs to
 attach
Thread-Index: AQHYgEP56LrMDqiRekeDa7Qk18mVcg==
Date:   Tue, 14 Jun 2022 23:10:43 +0000
Message-ID: <fcd44a7cd204f372f6bb03ef794e829adeaef299.1655248076.git.delyank@fb.com>
References: <cover.1655248075.git.delyank@fb.com>
In-Reply-To: <cover.1655248075.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 48f7cb0b-22e1-465e-4d5f-08da4e5b1b8d
x-ms-traffictypediagnostic: MW5PR15MB5220:EE_
x-microsoft-antispam-prvs: <MW5PR15MB52200C34A7084DE5AF1572B5C1AA9@MW5PR15MB5220.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZRlLaWa27XK/+/WfVySwsVuNleWGi8KjHNW28jiu2/eN+WdjvyK0YzOpapt612tzTxPesFtw2CuowH1ruGGeMQEuIIQVqtHNat/5W5hf+BhHehlg7ohPctt7dh/xGxWiRRro/7anAAT6gi+qjDxj46FSOcIs9I+RMQS1WhYE7ARZA93dZSLgLYvSEEiOHbi/2bZUVuje72dU4aC2tQldXqk6wadPbrJJcFUVDkDP+2R5heUSrg2oWSAcuvapoHYbytMHN7Gm0veCmOaw9pxwzUsajUohJiL0wNzEWXPo/pyQ1ICDk85SXNVTa7Wh6JEJxu7lheVNG3y7miIU9dXJ9G43zOvxXVz+zeQ/LzSG/P9QqwNaYJi/3NUvlygQPQqScOphJCHmMn1GQUBuhcGgDRn0TFiiLp9fbtTZm96//L5F9qe9/R6YdVr8rU4EXNpk9Hz34apnYutD81X1sIhenZV6ijHaAm6ttDBbiCvfuR4fNdpPgr7V4IaYHvACSFOf5dXQSFGJ0nGAAzV023JmEecNa0NClTw5DC/jzFyzkPbvIcLKe5AI1NwhTv9pVVJm+k2XEkapvM5kmPVopVUqlFPPMkXDGfQAMd1/graQk+5YBFnFyUP3dhfwphYD/tgJ9aN4uKSnkz5ehW5orHNKFXJBAhucq77Anoz5Ymn+wbZf1IPIrFRKu+Vtg4dMlamLn4jXJaWo6jujPs8wUkSg5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(186003)(8936002)(5660300002)(122000001)(38100700002)(83380400001)(6506007)(6486002)(36756003)(508600001)(38070700005)(6512007)(71200400001)(66946007)(316002)(66476007)(2616005)(2906002)(64756008)(66446008)(76116006)(8676002)(91956017)(66556008)(86362001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0Za+tulDjfcIAN1tc/FsBG43LAXn6ZHvu+RrUJMjdcYA/slpEbV1sCdEHr?=
 =?iso-8859-1?Q?VJM0OaxvNCTEPLAwTorXwkgZdvDhcGaStduKozLOlN3E2/usBGVkkjbR7d?=
 =?iso-8859-1?Q?RtGKLTxdQuMklvpUjo+Xd5romQQUAbhkAydc2Mh1mSOAtddbC6w8c/tJ1d?=
 =?iso-8859-1?Q?4iSaXeSZYrnTPDBDXZuwNZ5bDTfWCcLyBKBqgINbcbes9fjU5qcTQFloau?=
 =?iso-8859-1?Q?jQ4H9XqR/QAI95AG7Hn2PhHVpiScPveixunc5wTDxRyIvJmvhgHe+6iWsQ?=
 =?iso-8859-1?Q?AGIRItkL4kO5wcp6+JnDK9hMrHOj8eyPVNUREDbAVJqoCSDCmsfGKyMTqX?=
 =?iso-8859-1?Q?9k4a9J5Xtl1xmUOAJB2RXx3jWlfpXHR6Ma7iM2kUtbIWVh0jQpYJs1U9Ca?=
 =?iso-8859-1?Q?Otc5mwz4zMxXgBd1EzuhUYV2uNTVxrrHrH7t7qOjNsusRDAyHtgGuuypGx?=
 =?iso-8859-1?Q?QHzG/+kZMPjWFN04S67mcQhCLluNiZI6puAToI0Y+GNwmeyDBdhL5zn/b6?=
 =?iso-8859-1?Q?bIOFSvDxpolGXF55wMnsUqV1f2uwzQJ0qrHvnzR8Jcc0r3TwjxZHjeeXxC?=
 =?iso-8859-1?Q?KOOyNCxOpJo+FExkP7PQ0kILEEz8lg+3zHw7AHyWVSv9fb/U+BLFS2qz1t?=
 =?iso-8859-1?Q?rQgrQgsDMPiUKAKIYSmMpncAypfPQ486wPX4Ar/Fu5+xLt38ywz/d3KpwF?=
 =?iso-8859-1?Q?LWGupLpqkcSD1o8id5HKBPJOB6GCfMeuMZG181fDQ0nnBWlf51rfyTgk2m?=
 =?iso-8859-1?Q?XWN9MNggL1/fwq7qI0UFO/aP2gwQccMZOihjq7G0Jq+W8L2YNS7h6UBy/Z?=
 =?iso-8859-1?Q?S459+LMWs4lQmy4uB3KGqOlPYfgX58keGkON8294cbk8unH4d932CuQkjD?=
 =?iso-8859-1?Q?+9wMxBJuKuHiBkzt/f8w8HwnA8uQW5xmxNgoQV/FFdo7pxOMyNH3t/2+1K?=
 =?iso-8859-1?Q?Yl3N9A8HiTHZsCDtZUxou7D0AWY6smUWH2XJGuTOlQtLRtfPWSk0GEU48e?=
 =?iso-8859-1?Q?aTYp81dGMzfqWvtjsn4rTgvmjKVwKuOOf28ZSC+sVPaFTdFP/LL/8T65Ea?=
 =?iso-8859-1?Q?QChxxfugAM/B27LHUgMa3NvHU7dE5v9do+ZTizo6m5Qp0SljgHXg48+BZa?=
 =?iso-8859-1?Q?7V0Rb4CEmJmB2ZPOqoBK5nOkaJZ4bNh7QR1R13bGjSJjMAn2cmHXhDVbk2?=
 =?iso-8859-1?Q?1m5y5rF4Gyuc3GlTNK4Q6jxCBebhiUoekDIK6ANvXqsSyYq52YDs6gK/3x?=
 =?iso-8859-1?Q?UfFHnTJbIE+xM6QYNfqoMzsbm7oZB8hdpKWi46RcHF1WFeAS/vchP+xQx6?=
 =?iso-8859-1?Q?1bsyRnuuCi+TSyTnqbqoeuCLY/69bfABUKxoGQTlsFLm0Wa8NFyQPMnd12?=
 =?iso-8859-1?Q?hpwaPGMZHwrDDZ/GSkIWFKT7MgoFnmwFb4G38bMrMR7iEzGFpoFxQ7Bz80?=
 =?iso-8859-1?Q?PkhOtnr00AU9tw7jlU0Im1gcagY4iRxLDwUlTi+OfMk240u4Ca5gTiNwMA?=
 =?iso-8859-1?Q?tXjPQL/XrOefhI8UBbdAeJLjZVSGPgWnT+bzw/TyN8d+uDcOXpbJwQH7aM?=
 =?iso-8859-1?Q?Qj0wlhWE1g+F4dJOk0vkhGAnMJMIYaf6AaQNVV/npVihRXmn5NF//VHa3H?=
 =?iso-8859-1?Q?NJ7HpmR/TGmpa//ldvUDohOGjHaSiRfgXrra24PTYnQnleg0I8DSoO/DGD?=
 =?iso-8859-1?Q?rSBl2o5k5d4tWBPYv2HtrpW/ovepOC6cSPgsKq+5liIgwoY9UItpa9cBLY?=
 =?iso-8859-1?Q?oc49hXu5uOzFyA0pDyPrpPmJFdVfgt7fwrmmLoQNmN5T+iNNFuzERzZOnN?=
 =?iso-8859-1?Q?qY6INeecu9nvLxceUaziUr3jSmV1sYE3b+plKLS30OykzH6ZRhkF?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f7cb0b-22e1-465e-4d5f-08da4e5b1b8d
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 23:10:43.7269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0SNOo9ii3AhpYV/IRBznKQLOqeeycfjm2Cu97FeagusG3HHTL13W1IuM7qowA/Y/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5220
X-Proofpoint-GUID: HE9qvUEyOt2qPn2Bp-6bDALoLGOYCC0J
X-Proofpoint-ORIG-GUID: HE9qvUEyOt2qPn2Bp-6bDALoLGOYCC0J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-14_10,2022-06-13_01,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

To avoid adding a new UPROBE type, instead allow sleepable KPROBE
programs to load and defer the is-it-actually-a-uprobe-program check
to attachment time, where there's already validation of the
corresponding perf_event.

A corollary of this patch is that you can now load a sleepable kprobe
program but cannot attach it.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Delyan Kratunov <delyank@fb.com>
---
 kernel/bpf/verifier.c |  4 ++--
 kernel/events/core.c  | 16 ++++++++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2d2872682278..eadc23a8452c 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14829,8 +14829,8 @@ static int check_attach_btf_id(struct bpf_verifier_=
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
index 950b25c3f210..deee6815bdd3 100644
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
2.36.1
