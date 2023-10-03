Return-Path: <bpf+bounces-11293-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB87B709D
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:15:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D4D9E2813EA
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 18:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E6733C68D;
	Tue,  3 Oct 2023 18:15:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B83B7BB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 18:15:08 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388D583;
	Tue,  3 Oct 2023 11:15:07 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 393EHVeu025241;
	Tue, 3 Oct 2023 11:15:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=/ZmvMCWwyP5yj6Kg+X41DZYGz9iVQ+64ii3zyPNlArE=;
 b=D7/CvphK4QK4YaNGHaPGfUsZvgmTKRdG9BhuiUk4Eh6ohaRUQ96pjbJa2zDxYxZ3pmEO
 A/4mBDlbX7LV91Of0/47fED/lfUNOMeiF8j9xtriAlSjkhuLol81o83bhcc+TK+P0Aaq
 vgHP7n3P0q9dn8bvbxpn2X3fScNkRQMnCRMuDKGipezh5ZmeHG/RCkbNieH7rHTnpE5+
 OzLt8dh6C11mrIaVPhkj7r13Y3/SvfBVdOkRGfxBRP31w3iMrR7zPPufcw3fPTflleHE
 sTXXGLXXnQ3KbZMDIWV+0sOKm75Vy/viA9AIOaTnWc1IOpkcw5b/97qer+a4JwebRK2G 3A== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tg7byjbq7-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Oct 2023 11:15:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JTQhuIbWP1qGEF3vfpeDQlo7AY6ablz5YVGvajHvNnkHI/3IO+X3FfwU1N8/nEgk/EAyrs4G+XR8wIFDxNr0ITK7Zdu/YRqia2Qax7Kl0DNK6V87wXwKGlC4guiW6SxUJ1HqqYj9sN5RvZJOdL5j2X0NFFN9siY0cLVd16TDBnusuc7gpybcPdUkp47mW5Fk45GQJcoHzxXDdxkws37d0SngtVbdHPX5cIqjKmkuxW92J/4Xf5CjRoDweurizuNSfSf8U8CF48NgJX3tAebgyt3m/yxIYD7EQ95hzC1+fABr4jBOvLgUiLk8fb734RIADym1mDS9SmnAd5jCH6iO7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZmvMCWwyP5yj6Kg+X41DZYGz9iVQ+64ii3zyPNlArE=;
 b=JnD28hmaTyrkd1wCFNn7mVtI2eBdHHxjtnraginTvegyMbLRbKaeHJPi6LWP6ziayW73OkxJma8fiubZjq0X4xEZi9S2JiC+MVn5NhW1UGhpE+DyFXglTtrbkOjKE34pZQZdvjder7nWOJSWyLcwY1+C9Da2+tedlsFINB8EsOghSw4l/TTLXYygRFWLhY1+wz5ZsCEIT3HWRWf1/rl4sqZq24/fJUITHpZ424QWOkRHdY6RtCml4eqLGwRolBc5DQOggcm26+m5FGe+nH5d7NICQ0SJyhnRFJgJdgS3UdCn55gVPmYz4X2v5dUBoHIVuYzcnhvJA1FG/Sj3SXfebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BLAPR15MB3844.namprd15.prod.outlook.com (2603:10b6:208:27b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Tue, 3 Oct
 2023 18:15:03 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de%5]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 18:15:03 +0000
From: Song Liu <songliubraving@meta.com>
To: David Vernet <void@manifault.com>
CC: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org"
	<andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        "yonghong.song@linux.dev"
	<yonghong.song@linux.dev>,
        "john.fastabend@gmail.com"
	<john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "himadrispandya@gmail.com" <himadrispandya@gmail.com>,
        "julia.lawall@inria.fr" <julia.lawall@inria.fr>
Subject: Re: [PATCH bpf-next 2/2] bpf/selftests: Test pinning bpf timer to a
 core
Thread-Topic: [PATCH bpf-next 2/2] bpf/selftests: Test pinning bpf timer to a
 core
Thread-Index: AQHZ9YrIU8YDncG/c0W9wNVK+zLFpLA4X+wA
Date: Tue, 3 Oct 2023 18:15:03 +0000
Message-ID: <4EC94A6E-B3C5-4D2D-BD4B-FF7C4F149FD1@fb.com>
References: <20231002234708.331192-1-void@manifault.com>
 <20231002234708.331192-2-void@manifault.com>
In-Reply-To: <20231002234708.331192-2-void@manifault.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|BLAPR15MB3844:EE_
x-ms-office365-filtering-correlation-id: dd86de2f-51e7-4466-d3e3-08dbc43caa0c
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 30HCDfv3KDwIlkHiKkWIilWZapTERmnAtVaOWNH9bvWbkl8u791r7BpOclOraL75QJeLBEOExomjFH8Gsk1spisTMIe8N6B//wE1kSd1wymv3FynQeFI2BgmSjh9dXcmvhUEVuf4zFTD8IMy2HmK/z/fa1Y9QkK7Mfgyv5XSdi2wNUQQnDMNR1vnZIPLSfh3rwg0lrZ9Ad2wrtyfvKDdW39bC0OuBu6nMx4Bbd4iCpCcRiMJ6mtLinn9lF7K1V4R1jRUJFPn0jcIkm7+YEtDgPlByG9ea3S9t6ragFPuxUFCyBV+M93sQN5rOtbVUOd6PS3f1CpG8OexYww3VRNIroKFJQ3qmk4zU9QvdmBiBS1HhBzTY75mIYn6nLuWgJSJQmHbXYyjadKAVb8Mj/+tBGb0XjdZBBEaBoSqTCr6s0eps/1QUw0E4xf74fFx/p0m/AvNKQEx3l2M5R7bzo532wGChOfxyS57GfFLMykoR8Zp22HtK8WsBfEX0lvSvezUkhIuOkNgEGqw5GRyOkgHVXEEmONv6YlPIRc6UESWQ4JEI9ce1jAmZ1x54+L0RuMdKsMjM29ECArqlKVmZLHBIrmKjJnhICcOTg0gz0Jvdnr/YKtCXH3nhN1vtANAK0Ql
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(5660300002)(2906002)(7416002)(38070700005)(38100700002)(71200400001)(9686003)(6512007)(122000001)(6506007)(53546011)(478600001)(86362001)(6486002)(33656002)(36756003)(8676002)(4326008)(8936002)(66946007)(76116006)(54906003)(64756008)(66446008)(91956017)(66476007)(6916009)(316002)(66556008)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?uRqS614t0/ilg/T+6DdMe7qdM8Bo4xHVk8derY7z2W7ZsMfyMAhK3FBkQFpl?=
 =?us-ascii?Q?1Ui7zcO3AVm6R1aoIaNlyLvF0gy+d2v3ijLZUkknWvTRDmHgdl6vOL3iSe77?=
 =?us-ascii?Q?ESgSX2RRmW+09f/lyV+/JrLYeU+jrrtOOM4ipCWAvyQ97mEtq+qmDEac1vz1?=
 =?us-ascii?Q?8KldpBn5z+nU/uWpMbqmncuq3UwzJ+Q8UrG7T4nrjShXXlxYPTwM2ncOMui9?=
 =?us-ascii?Q?fnqIRpTZ3wWucxt+uQCS3MVSMSb7ObVzZo9OIDtnntlC4a643C8zTkmkof//?=
 =?us-ascii?Q?aJeyTgMmrUmrW3zz65EKhqTFV/ElFD60N01onP/VWU0+S55lPm2t3kNpTqcF?=
 =?us-ascii?Q?JuxdWn5/Y9yVXbudBiK7fSrIKSS0B4AyeJBNb9HzuGWVZ8Y9bteDsOB1ETd2?=
 =?us-ascii?Q?+ts4mtfHTXtAjE8RLtdnuwCzVHjprQ6tbXQiLSrTDeUsTYxLuRT2QmCWFwG3?=
 =?us-ascii?Q?FIQ3rukULN3Rk90caQQRQvgYYJpml0K3VYilDQnaIqDT3vsdonFLiCFb6Arc?=
 =?us-ascii?Q?jIm8VbHRI1C1lWhH4HO6FjQ6hj74HDMLpcheMgkBY5fSjgABfF/baskRZtnK?=
 =?us-ascii?Q?EFbXgw0O7uM9mKTjvTjsGhJA4HSS0aNRvLEZDlKXNbCcx4STEOOJYPFOtz8W?=
 =?us-ascii?Q?Z36RUofZZh4nB/Gqtr2vBxlIU3J8lBH5Xx/y2LvqAh2R6c96L0RLuifPbWQ1?=
 =?us-ascii?Q?agyCoU9UUQowtxzjymQVXv5kR0QAk2HgoSQz/TVPcdFrnvMMALnSqj8ouSt7?=
 =?us-ascii?Q?816SxPpHRZSrp8chu3/sJr6jb95uJorXjrr5Ad8MvofvGd2AeKRTS4Wb8BLs?=
 =?us-ascii?Q?8bgfCmxxxHE0k1iMG6f5nxu56accvaYKbtM8EX0lmDgXh5D0GwPdxxMkoaYy?=
 =?us-ascii?Q?hUK8BI+vPF9I5IVdsVUInq2Ef/Ta8uMcRFrzvNWmkz4GXGnzia97Xa4Vee5w?=
 =?us-ascii?Q?fixGMxMyQGxJsZJGpC8Ww4o0F4J8m5vYX78NsZOLgduEjdX3UQ0GzOd4muF1?=
 =?us-ascii?Q?gBjxKcOkRNKiwQ0lvBvFX2CHmPoMxTNd816M2985gG+K88yAJnmJswfhgu72?=
 =?us-ascii?Q?jdwvOMtCwhpNzhDguLtlc5y8b3WjSx40MolSlSRgSSgeCvla+iLcbrDlaWNF?=
 =?us-ascii?Q?2GF7W3eMLg7P5fA+E04fgXQckQONZnHjIm4qEFmC3KJz8AGidvyV9JAy7dq6?=
 =?us-ascii?Q?iEquC5gkIQL+WSkA7mnNoQwN3XqBqzvHVN6QnjXOnb9hNCnq9gzv6Zz1lo2B?=
 =?us-ascii?Q?CPSoneF3+lWPw2nSVMirkeYipHNuCRD1TDi7RB0MNINwTNVLwYQK6PQSrY1u?=
 =?us-ascii?Q?59mlmq8tUMwVUKzpd/n5CtAZJAlCwagzm91LtiWlNPDsEIoKnHqfD2OeL2uy?=
 =?us-ascii?Q?3EQmMWed87rXUHX/0CuPvnUQMBnbTncqSmJcKcQJdq6/tE+JqDCc7465GpKC?=
 =?us-ascii?Q?F1RWFKhR/xsE33NMCEo09S6NItPbsgYb/F/gL2vJPPq22gRtZhhSFNcjLLkK?=
 =?us-ascii?Q?8US+4kGJ+7FZ17Z3tRNfxMstbiTEydLEMVjBCDqjNTlp55kHiLSzoV9dx3c9?=
 =?us-ascii?Q?p5amwLIMx5h7LaFJ8OZdaPTlI10s+T1uRDYTFFWCo4cQfAXc/1On1UGnqiXa?=
 =?us-ascii?Q?3rMSMX3uBjLkWVyq9ooGHys=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8875383DD23C924DAF1F7E210A93192C@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd86de2f-51e7-4466-d3e3-08dbc43caa0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 18:15:03.2680
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8UtTgANRyckHihbOTLlX8Z69yET6m8D/flmRxA27r+yQOnlSCnZwXxsTcdV7o0KdYuz9FWB9QsipzxRpUTK3Ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB3844
X-Proofpoint-GUID: VkEbUC1F2-amcQR4S8JDiLU1yVw67IEV
X-Proofpoint-ORIG-GUID: VkEbUC1F2-amcQR4S8JDiLU1yVw67IEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-03_15,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On Oct 2, 2023, at 4:47 PM, David Vernet <void@manifault.com> wrote:
> 
> Now that we support pinning a BPF timer to the current core, we should
> test it with some selftests. This patch adds two new testcases to the
> timer suite, which verifies that a BPF timer both with and without
> BPF_F_TIMER_ABS, can be pinned to the calling core with
> BPF_F_TIMER_CPU_PIN.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Song Liu <song@kernel.org>

With one nit/question below. 

> ---
> .../testing/selftests/bpf/prog_tests/timer.c  |  4 +
> tools/testing/selftests/bpf/progs/timer.c     | 75 +++++++++++++++++++
> 2 files changed, 79 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/timer.c b/tools/testing/selftests/bpf/prog_tests/timer.c
> index 290c21dbe65a..d8bc838445ec 100644
> --- a/tools/testing/selftests/bpf/prog_tests/timer.c
> +++ b/tools/testing/selftests/bpf/prog_tests/timer.c
> @@ -14,6 +14,7 @@ static int timer(struct timer *timer_skel)
> 
> ASSERT_EQ(timer_skel->data->callback_check, 52, "callback_check1");
> ASSERT_EQ(timer_skel->data->callback2_check, 52, "callback2_check1");
> + ASSERT_EQ(timer_skel->bss->pinned_callback_check, 0, "pinned_callback_check1");
> 
> prog_fd = bpf_program__fd(timer_skel->progs.test1);
> err = bpf_prog_test_run_opts(prog_fd, &topts);
> @@ -32,6 +33,9 @@ static int timer(struct timer *timer_skel)
> /* check that timer_cb3() was executed twice */
> ASSERT_EQ(timer_skel->bss->abs_data, 12, "abs_data");
> 
> + /* check that timer_cb_pinned() was executed twice */
> + ASSERT_EQ(timer_skel->bss->pinned_callback_check, 2, "pinned_callback_check");
> +
> /* check that there were no errors in timer execution */
> ASSERT_EQ(timer_skel->bss->err, 0, "err");
> 
> diff --git a/tools/testing/selftests/bpf/progs/timer.c b/tools/testing/selftests/bpf/progs/timer.c
> index 9a16d95213e1..0112b9c038b4 100644
> --- a/tools/testing/selftests/bpf/progs/timer.c
> +++ b/tools/testing/selftests/bpf/progs/timer.c
> @@ -53,12 +53,28 @@ struct {
> __type(value, struct elem);
> } abs_timer SEC(".maps");
> 
> +struct {
> + __uint(type, BPF_MAP_TYPE_ARRAY);
> + __uint(max_entries, 1);
> + __type(key, int);
> + __type(value, struct elem);
> +} soft_timer_pinned SEC(".maps");
> +
> +struct {
> + __uint(type, BPF_MAP_TYPE_ARRAY);
> + __uint(max_entries, 1);
> + __type(key, int);
> + __type(value, struct elem);
> +} abs_timer_pinned SEC(".maps");

nit: I think we can also do something like the following, but I am not 
sure whether this style is not recommended. 

diff --git i/tools/testing/selftests/bpf/progs/timer.c w/tools/testing/selftests/bpf/progs/timer.c
index 9a16d95213e1..638eeebcd6c9 100644
--- i/tools/testing/selftests/bpf/progs/timer.c
+++ w/tools/testing/selftests/bpf/progs/timer.c
@@ -51,7 +51,7 @@ struct {
        __uint(max_entries, 1);
        __type(key, int);
        __type(value, struct elem);
-} abs_timer SEC(".maps");
+} abs_timer SEC(".maps"), soft_timer_pinned SEC(".maps"), abs_timer_pinned SEC(".maps");

 __u64 bss_data;
 __u64 abs_data;




[...]

