Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59FD513A73
	for <lists+bpf@lfdr.de>; Thu, 28 Apr 2022 18:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiD1Q5V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Apr 2022 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbiD1Q5V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Apr 2022 12:57:21 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F30DAAB6D
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:06 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23SG7fRI026890
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=AL1HM9U6MG4YVTMT475SBuv5DdeCESkypH4OVb/bYEs=;
 b=eYO7KlZLDeimj9yFk0PxCfWj8Pb24bGpz9IchJvrh0kndD5e1YSu/r26ZGZq9gZ16snA
 x4SOR0gB+SwVBBARrcYDEcfypBUacTh054cfCRlFkhzmkcPEgwasq9CQm0lAZJxV+euG
 9zbT22QF9Uifx9ht7GqzT3MvBeT4VJi9kPA= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fqm5r40rn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 28 Apr 2022 09:54:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jChH7dHQTNfmLHJFLVFj+kKxpNgAPRFKWBZsKcOolQdeQPki5nKyor9BlN8mkj8n8cU6EwNRP5dK6pRvuLFUHRF8q/yV0eDHxnXQFZB9Lw8L5BEolrue9UYFRFbS0MB8NH8Y6WucntFc5nQxnPZAWlWakZtf/P2SbVAnN3qWy00KoVLKGycGQLFsbavyIMktd5aWX+6ipN4aFd8dgLR7l6bbPv1c61f8dAOtfImIeGty10BLhOmI/D6IU1xZ6X5UaQL1bCcHZopLw2D2kyBgaF5nGb3WVm56ajnyl/tWGE5EsJLX+XcW0xmjiHcg2aunGeY4X7k2xjFJBfK8SBrOKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AL1HM9U6MG4YVTMT475SBuv5DdeCESkypH4OVb/bYEs=;
 b=FU3fShi7GfY4QDRlVsExIuexTYruvFpHT4M5TcAeEMT4saGNXgGUEQ8kq4uQV1wnAO/RcQaTNXsTwieWR8y+IB5Gwe8Gf4jA3IihgBxtgvOrEZRlmNBmB0I5T1YSWkLxMhjMQPqH05EK+q0Ugzne7R5/SZ703QlplwIFfIShPpkjmKZc7O2elgzqcId+y0Xk9X9Kxfj3fhlAPVtUGnBBvykfRnbyGKRQlN3PRTW/G/4bPLQaHD8jeghlo/Xgjk2c1cMR9A0aZq2Ma9c4bbbKtGDVJsP8nlm4rbSFYJuAkpZw9K4jKo0KM6D0qs/nUbvP7ERa/I0etmsX9sSglYVjag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by CY4PR15MB1607.namprd15.prod.outlook.com (2603:10b6:903:12e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 16:54:02 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.020; Thu, 28 Apr 2022
 16:54:02 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [PATCH bpf-next 3/5] bpf: allow sleepable uprobe programs to attach
Thread-Topic: [PATCH bpf-next 3/5] bpf: allow sleepable uprobe programs to
 attach
Thread-Index: AQHYWyCQmbX4YN66pkSH451skVb66Q==
Date:   Thu, 28 Apr 2022 16:54:02 +0000
Message-ID: <9bae67335d76cfffadf9777be79c32c0f1deb897.1651103126.git.delyank@fb.com>
References: <cover.1651103126.git.delyank@fb.com>
In-Reply-To: <cover.1651103126.git.delyank@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dc90f5c4-0d34-4f9b-19d1-08da2937b2e8
x-ms-traffictypediagnostic: CY4PR15MB1607:EE_
x-microsoft-antispam-prvs: <CY4PR15MB16071993C83D77646F01F785C1FD9@CY4PR15MB1607.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UtsU9x+sbppgRxAf1wvEBmiY8sLqWLtXbk7d3Py8JaSXUTma70a1njBwLe0Lt2UB8CAfzIlBUxmL+abIJAs+Q18OTsF0xEs3CJ3/FgrKUZLXVtDM56u3CZgL1MyLTlj57KSySf3c8jsfv8M+xEa8ovkkRRYmgRaxwXBPYs9CrmghBZxR0qgKQ40YODYr6WA9kSPY0LrQ4DNA5EUm4BpdOCeWmvtb3s+CpBbYwADk0HWtEqdl2cIfQkz39wTbpyJ7EmXl7PdNymqwkMYpLqkOn7isC9pPpy06fZdBLO4zOiBTRXPxJY7sLP4p82HCq+IKwT8smdHOQKqTXFMh6XUNzzaYfnAXmH8qz5kfXQATiDKUMhDVIgxqU+M0IGxW1wWECOc6pUpHN8aC8UDoMRvUXSY0h++YhSN+iBZm4ch+PIdchb2n/D+/WEnrVLgj6vXU7ZNN1sVME9ucA5hdCjKLW4nubzGb053kOKV892Cb0udEl8x3tVbysPqdjXPKVmMXMnL3LftNMN0Dxg22y3lpLrm4jKoQxaJeYTNG5G7mzJTyPdFIKKPxQBcLAI3szEnhIX7DV8mXT/93pX4mU7yMCx0qMnJ1axFeGbxP0YFn2c3mlE64WQ7JcQFZpuN8VJ/aoWCnAA6nzvR5rOEVFzMIp0zSfbCA53EqFePdWsDPbHnY4pyA0h0nuxLXcseIqbN/iYNPV7+oflHgNL+Dp8K8Eg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(2906002)(5660300002)(66556008)(36756003)(76116006)(186003)(66476007)(316002)(83380400001)(66446008)(8676002)(64756008)(8936002)(110136005)(2616005)(71200400001)(86362001)(6486002)(508600001)(38070700005)(38100700002)(122000001)(26005)(6512007)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ehnFIvWllY7KqZy9ujNQxBuyllKiC6JSDju+DJKuhSAuPDJ6IH0UWefa5z?=
 =?iso-8859-1?Q?utsJbVmxyUxZxc5wGki6DTT/zMgFtBZdGX7Yt/HIk4U9MGXNM6PqlHDlJ4?=
 =?iso-8859-1?Q?fBxm+JIL0agivPv3T4xQNZzODBKKX9JJiGz1/zpndTG1Imoa+LkDafZ/OS?=
 =?iso-8859-1?Q?V1N5lsfYa0dA6ldhh4mfj2oHFeDscHVaqj0VlcqOrZ+V0x5wrlreZs3XYj?=
 =?iso-8859-1?Q?O62ovIr3EWxHquNNdNg/l3YFwP0epDUsPRcztTcPBKejg44Q+qOEgJ9nzv?=
 =?iso-8859-1?Q?rIH1lSQO2ljWWlZc5J3UgkQVhwglmwbpBkDBSV6y7UaaBxO2DeDtziMrxS?=
 =?iso-8859-1?Q?1hu6lv3a/vk4MGHO6d29cEstk2RId71EjC1vtUkkxUGqqimX3YEzcNjJud?=
 =?iso-8859-1?Q?cD4eyxppxPJx2DNVTzQ2Y/IbV4UDkyjGArigEQ6F6hH93aTPRuBGe6zICN?=
 =?iso-8859-1?Q?mVLj6Srz/QehFhzRiBrEQE7xGWpld5A8kTm/QMP1YZ5SBAjzdpuiz53FIC?=
 =?iso-8859-1?Q?0wXC92MaMOk3HJUht6AjDfJ8QOZ9OWIF0P9tMv8q4RzIWMcShnCSMjCXG9?=
 =?iso-8859-1?Q?i88NUMJV/B4nFTY8yOSK93G1tTjnFV665m8zuo266/gbLiLr8dQRKoZTdE?=
 =?iso-8859-1?Q?Tu+LvYGDAayykJ4fjyy3hUbsGsDvFEY9Bk/BcmZ0GN0wIHu/wnAvoP0GaG?=
 =?iso-8859-1?Q?p53vaxEld36yP2ekjFnXUGWk79hVxMCCz9uW8DhbRWmziMNFHqzVNH5w9z?=
 =?iso-8859-1?Q?PtIa5t6TTYKZEvVlxbFKHxAKh6xM/FG6NEm63NMhXv43OOoYv30gUXwi5H?=
 =?iso-8859-1?Q?JOaBuTVdEinhCwPRF9jCQK9vvPX5ddpygIQHQq4qH1r2ei+TS3wt0wMPqW?=
 =?iso-8859-1?Q?4vWSu2D2rZk4t8kSt8jD0Oam0vAfWYmJaFNaF2tgFi8Tv3GTX4Ibp5qTwo?=
 =?iso-8859-1?Q?VKdFphiaPHbpBL0IBqdIXWv/IPulN/mg944gsfqpXzOc+hIpFZLzljZbex?=
 =?iso-8859-1?Q?dw9B8U3IsBMbACLE0AxuRTFsKc8prauO1liv6xVupCzL/y4LcxLxTiv98E?=
 =?iso-8859-1?Q?m8OHLqpDecdzrKTCyYDLYcci15sj3+95UaTjbGJjztNR2ZjZH0/J7xJCGQ?=
 =?iso-8859-1?Q?D9NuOJOdWHY2pbA/e0//MzM+BBGAMkSzsVNn1vKgET8xlTowew8/zvNAls?=
 =?iso-8859-1?Q?I6iEYvqkp/F9SlK7hZ9pnS7laJOIAJ1h08/Q0uzhIalL0lLLlmPipty9c1?=
 =?iso-8859-1?Q?IGUYHA9qegIK5bp+j70Xp4oknmXSriOUxSaY59GJj+eRDcFNi8tdbky4F/?=
 =?iso-8859-1?Q?igsP958Nb02kzhTBgJ3p/46Hh4MF3NFKJDh+rp8s+hX7xoOsrVuTQtzg/7?=
 =?iso-8859-1?Q?ONu2n7nC6ZuPcKsd9mKy36RNmToK41zgl/iWlwHBv1jt9frmH+4E8f3Sep?=
 =?iso-8859-1?Q?ObKaqN0exC6u1c3ua+NdTeoSITzlMczrbngxTJX3EfqjU8wJ3CQhp+bbMz?=
 =?iso-8859-1?Q?/vNHH73thPh0XbNToZX0zJx3oROJgoG0QxYKtJJB5xh8wnU0pCsn58jv6w?=
 =?iso-8859-1?Q?1LfnnFtB31Rni2Poe4yX8xmxBE70bQW+5oNQ2CSiF91Te8USbM/ZIKDNOV?=
 =?iso-8859-1?Q?dd+x53SbKdNxw6luRqOXhsXoExfsHRODxHJznxw1cT+rqNWEhCU/5Ad/Xv?=
 =?iso-8859-1?Q?Yky+mC2RvZNqagTCHOzq5vhqfpqD2GbFiIYlI7kOO32CM8zWjIcYEHVQVZ?=
 =?iso-8859-1?Q?ADWOpI4KZIcjckdwx6flHUED2WVo+NGVpzSKw0RsHZL4aVZuT6u5EsTdHb?=
 =?iso-8859-1?Q?lPTOqreLfQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc90f5c4-0d34-4f9b-19d1-08da2937b2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 16:54:02.7373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lOFgPt2BXSlPwEwUbHkogzZ2lqBY6ia0dApbZDSrzOjA1Janyqk5J1fdn5OlAdOB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1607
X-Proofpoint-GUID: JaooaKt1KyZzbaNyt-rVo1eaPoVCQWKm
X-Proofpoint-ORIG-GUID: JaooaKt1KyZzbaNyt-rVo1eaPoVCQWKm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-28_02,2022-04-28_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
 kernel/bpf/syscall.c  | 8 ++++++++
 kernel/bpf/verifier.c | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e9e3e49c0eb7..3ce923f489d7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3009,6 +3009,14 @@ static int bpf_perf_link_attach(const union bpf_attr=
 *attr, struct bpf_prog *pro
 	}

 	event =3D perf_file->private_data;
+	if (prog->aux->sleepable) {
+		if (!event->tp_event || (event->tp_event->flags & TRACE_EVENT_FL_UPROBE)=
 =3D=3D 0) {
+			err =3D -EINVAL;
+			bpf_link_cleanup(&link_primer);
+			goto out_put_file;
+		}
+	}
+
 	err =3D perf_event_set_bpf_prog(event, prog, attr->link_create.perf_event=
.bpf_cookie);
 	if (err) {
 		bpf_link_cleanup(&link_primer);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 71827d14724a..c6258118dd75 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -14313,8 +14313,8 @@ static int check_attach_btf_id(struct bpf_verifier_=
env *env)
 	}

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

--
2.35.1=
