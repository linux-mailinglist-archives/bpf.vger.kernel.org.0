Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0B4525954
	for <lists+bpf@lfdr.de>; Fri, 13 May 2022 03:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244317AbiEMBWo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 21:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351943AbiEMBWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 21:22:41 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF521B152
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:40 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24CNMMKN023307
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lQmCkwPQVqujht18gkgc5bHZJJpoqUQTn/pVU8kz10E=;
 b=GNGXgnm5Xt5/E5I8hohjy+uyKNeJ0X6SJZINTkvJ2GIfDFn/Ow0BdhAvVpJ3AXYSj+Ba
 6dbQrRC2KUtMscrwJrC53yhxq4GAszBXfEYi4QFYmuDOsxl7DG267r1jh6DCJL8sDyq5
 uGomzOFFFA5NIonkqFEa+i5I2tzSGwBYWbE= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2177.outbound.protection.outlook.com [104.47.59.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3g17vytvss-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 18:22:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlrSGTGA03L5QMVvzRF4y5rJs13TjyCvhPvmaRtQHupHodg8lFO1onxfLknTv9EBk/MWJI0lP37WX9vNQxqfBAz41cwP7PJ5QLnU+Hv8sNmB8uRvmRYcc4nXvOAOsSIwv7jdp2ifjiLfmpv8UhS7FAv0FPfmMhoTPj3OU4eD4+85+a9pjWD3TIfmDFJZSRcBK7+I6+w+D9GMtAT7OFhxnou/0qqIPwoDIL0WdufnnjuLQ3itYD8ursRy73apgjXqosu5+CY+R3oa31U8knwnTrY6o9jOysCopflTdZ0fsI4FsPQ18GRkw1BTqyMWuXICO5e9RyzHL8ppPB6wPA/s3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lQmCkwPQVqujht18gkgc5bHZJJpoqUQTn/pVU8kz10E=;
 b=WU1tX6c6KKI+s9yQJ63Tzmliu1AFY81nwN3UAHB1Xz43zQEJ8g8jxPpZ0etiRseD/by4I+U4jy/BFoA0iVxVvl5Mgma+IWRAXgf+vqJ1Qe/TETy9SJL60+gqNIx+xW+ijqOX+yVRGxWbWJwofaEACP1HHGMUwtxBFzkGX09DkLPX7EEYluBn4m2Nbj1JzGZc+wyuseDNATQec2UvH5oAhfTJx8J778Mb96FD7T6MbUGo5YkQmF1VunPNmlPMu+/C1aaFZGZpDC7Fran7GbHRWO1PBAOl/IGBMZvIpm43ooL0OU+VJUna5IzovebVY9QWkWvNVkdfCq0H5pLUdQCerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by DM5PR15MB1610.namprd15.prod.outlook.com (2603:10b6:3:127::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 01:22:38 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5227.023; Fri, 13 May 2022
 01:22:37 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next v3 3/5] bpf: allow sleepable uprobe programs to
 attach
Thread-Topic: [PATCH bpf-next v3 3/5] bpf: allow sleepable uprobe programs to
 attach
Thread-Index: AQHYZmfub4Q7c0nCgU+gOIXpXZW04g==
Date:   Fri, 13 May 2022 01:22:37 +0000
Message-ID: <7a75cad55074dc230c2ecb451336d02ed7d79d6a.1652404870.git.delyank@fb.com>
References: <cover.1652404870.git.delyank@fb.com>
In-Reply-To: <cover.1652404870.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ab66256-bfde-4388-17ce-08da347f10f2
x-ms-traffictypediagnostic: DM5PR15MB1610:EE_
x-microsoft-antispam-prvs: <DM5PR15MB1610D3E9076F17B8542CBC1EC1CA9@DM5PR15MB1610.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GjG3+MzZrjb9JHM+5tdgDLWulloQTJcG6ZuHaQAT1uf92R41exsbJoMrOaPTBaplUzPwiRjRNcmN+c8T5zumMFiuxZhE46t7ni9ovSPvBjosvOGeSdsN1jP6LgFkT1dR3pXpBZRt/FW7U2A8GeT12AlaAJFFeLsH3pFxnOI5Yc6nQ9bl3x9c8YNTplnj03TGno/VYQK3OOMWpol88HnIzv3Rep1W7qxKksh/T2bphs+lW1zkTLJ1gQi61lb1jy+lW4Rob3RhUQ+11rWFhfte0lCkISrLK7cZ5N442xkH1WliyV1DOqyr4NIIbohsl7dUE12KvTwAygy89p/punLnHnalqcP0Zx1uIiu2WC07ZJYj6uLKi2615ycPBLbvYjTgu91Rf5avnO+bpDrI3KdADDu2AY9yk0gGfhUR7tIaGeKl6YZ3iXOwv7jvmnbqLy6aXG31jYJoB3zfk19Pyw8jJmnsbGjfb+IAAtv+Iudp1a2JMd/Ofr8MzCCWS7eccN/KkKHJczu5WL7z3OJ5B7TKNlox7iSMOq5SZRcHMtkgbxuj9FBFw6V6hkJt9HWMbAKHYJ9KZF2FfvI13hczyk8rl1BHVoCro7UBpPcnPwq/BgJ2uapiZV2pOrs9k+IBWT93l+5WrQFWRWkkKkiA5Kb4IadrHAlhWjNR0WrXD2msHvQHGJexJKn2y4IxsTXMFcyg61la7XoBGqrwZXGLpWy0oA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(110136005)(2906002)(66446008)(6512007)(5660300002)(38100700002)(38070700005)(8936002)(508600001)(91956017)(2616005)(76116006)(66556008)(66946007)(66476007)(36756003)(186003)(316002)(8676002)(86362001)(71200400001)(6506007)(122000001)(6486002)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?A0QU0bTiva8r7oFeTLDaKLcNubhAXnywTgWQAsFIVzthYsl1mlSBw2fCDz?=
 =?iso-8859-1?Q?69HyC9OIR+tTSbXdaS06jZfc/m/gH8w3l/aNKC89mJ3uDhUKPC/caOW1s6?=
 =?iso-8859-1?Q?IHpusejdxPlsIeSfgfHvGCvmGfPh/3DK3qJZqQ025oiZ0GF7QA1GSi/UDO?=
 =?iso-8859-1?Q?bDsZRuhLT3nXyIkk6ZMTMX2kcjdDcCZvfla18tYUx+QrMf3RnjVUrSany8?=
 =?iso-8859-1?Q?bTvYPmj8/aaaTp03Uj0Ipe3XHiIh2bsxZ1QdZgcCUdmhBVbaLoT5vITVfN?=
 =?iso-8859-1?Q?LUMs1XMp6aW1uQ8aYVafkw0X0mpPeF9p/6E6GPVMmtXjZlgSR3qbSEXSzK?=
 =?iso-8859-1?Q?bbhwSwN9dz1xGKd5fAqmNis/sNtDUhWub4574h3LXE5dNyvu0H+1pa42oS?=
 =?iso-8859-1?Q?kOvLBCvcLKu2Xz1P6BOrx4YE3l2XNWT2v/miC1X9eFQrdAO4pk6bsGfeNG?=
 =?iso-8859-1?Q?6Ec8mQ2J8U9kOvMf+EHI6EGnjGHzmeQen2aZcw2o1OVTJ2wZwIPsFPB7c+?=
 =?iso-8859-1?Q?sJtDpRf9IGRIV2jkOs64ooAh9Dci30AKvLOxFTZfKTbk8iWNR0p6S3YAn3?=
 =?iso-8859-1?Q?fmiCO7mFUWSYsinFtPrFCp7vba2HGQxRHklewmLmdNCHptumR8ECZU5P/A?=
 =?iso-8859-1?Q?odhDwc5hPEuCdOonHuDa7o1kDDGmQx1aYDH9ZAYG3iznCOeek52KeyTWsy?=
 =?iso-8859-1?Q?lj9AA+ld2oECPNgrjjLudcU1HFb6haXionD8LD0xrDFe6JkCKkTtMlQOMn?=
 =?iso-8859-1?Q?ArrZgu7cJQ1kLKVwyUnW1APLhpdKJ0tJrcgZCE9/y7LIUGzmOImGABipx+?=
 =?iso-8859-1?Q?NsT4Mxcl5qmR37wiEfYAL0R/cFmqMxt2la2XNkKZ7fvXKNXaj4y4z338bd?=
 =?iso-8859-1?Q?y0DLfcYLIl4lyZOnYGAnpr9lfn85WBlkov8zxMOkS4sjfa9AU3SiDgWKni?=
 =?iso-8859-1?Q?bB8R917I39WSdlwq6N37BRKLJ138whs1fqNX8LIbmWl8rrS/Z1okAvsu6C?=
 =?iso-8859-1?Q?Ht9NNG9ewU2o+Fp6/zPpNGUoMjikcJ/DttVMs1BJETzuTFZFeAU/JcZvXW?=
 =?iso-8859-1?Q?vmZJVZ1yPGCcRep8HCjB99ju+LyEGEUn9UoJGguqa8s4q3eXV42WYFxlDO?=
 =?iso-8859-1?Q?c/tyzEInhmdbCmIU7d33m7ykFXYjMlbU7OqsjzBUKwhQ9d9N9NTOcWP9HF?=
 =?iso-8859-1?Q?xCmQwE7Dmm/aP3lu64UjociNWb/SmE5hRYMsgr5OancPCDDzKlAZvbZzic?=
 =?iso-8859-1?Q?WCofkZDOJqaKJYha5pRYZsg+MFRVK7mEpP0BaCfXAYv7E3nVfKShVqgchX?=
 =?iso-8859-1?Q?C28vD48ci4uN5Mjwb+r7ueKSfnjDpdQ5xNxsy86VQ/0OfSmL0GXhNfyZ1X?=
 =?iso-8859-1?Q?5T80MExSguQvb0JaT8xybOjE016uOV2y2qgyejvIJ9C6274ip1X2Plb+ch?=
 =?iso-8859-1?Q?euyx8iTfctm4dLdePuAbxSc7K2r5ZwmwC0w7ZH32QW5H/2TV1+0s6rNQ8C?=
 =?iso-8859-1?Q?JXZwGTez6QmlvhU+z9yRonRfBO0WUWrTEoKP/InDHzH/LLy+xPLqfGzclM?=
 =?iso-8859-1?Q?Zc7pajTY+WTCj4/YZXm5dpqwhTszUCKlUrprra6AdIH4Mx8tY66eU7YJDr?=
 =?iso-8859-1?Q?CWrsKx4lPdYoJsRmxC74QCXwROZ6YhqQuJ+9H2lGjlcav36EdxjHwoQtds?=
 =?iso-8859-1?Q?d+wgaQguJmbRuuhWZzLyCW5yMOzhtjMUfNOUT3Xs8PnTfiydy1KZtMLnaF?=
 =?iso-8859-1?Q?CT1KTFfkb5kq1Mee/NKQLrSPpc2GujEp2EWjn3nL9xkfGZVH51Et3V3nxa?=
 =?iso-8859-1?Q?sUnwNqHoGN/O3U4TYSI0CdgMILhW7VSF8vo07NFG2cJNm4wf0Zyy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ab66256-bfde-4388-17ce-08da347f10f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 01:22:37.5670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oj9Y9oDi4c8Hsl1hL8sJjxVek+r7L6LbOkDsALYVP9TPWLnAeH/5YfoHtt34bEYe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1610
X-Proofpoint-ORIG-GUID: HBARcu89p2_Oc_kaBa5fCWeL_3GmYYgQ
X-Proofpoint-GUID: HBARcu89p2_Oc_kaBa5fCWeL_3GmYYgQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-12_19,2022-05-12_01,2022-02-23_01
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
index 05c1b6656824..ed446ce5ad79 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14583,8 +14583,8 @@ static int check_attach_btf_id(struct bpf_verifier_=
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
2.35.3
