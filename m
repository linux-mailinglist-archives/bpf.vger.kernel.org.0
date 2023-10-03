Return-Path: <bpf+bounces-11292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A1E7B7085
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 4B0B628140F
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 18:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B283B7BE;
	Tue,  3 Oct 2023 18:07:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76526D2EB
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 18:07:03 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 037A083;
	Tue,  3 Oct 2023 11:07:01 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 393EHIeR001164;
	Tue, 3 Oct 2023 11:07:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=CAB6CXWAe473mqtgnI7HUHMbQd7O9jl4Q4NCiDL2p9U=;
 b=Nq6IxKZYFEto4M9BTlhNNfcq21ysvx6zTl7vRE09N3Xd4YPatIPWzysGN4FyoyaGhAUL
 lrB73ckNlceLGS7haJbxQyN9BR6W/+K3v+sECLJYLZPctx7Ulf7sYhsphP1jigZsvfJo
 JxecKKz5fwQjYiy1Y1hVDYHBBUy6yv+3I+bCBCyhnZbh6jw4Il7lgOPnsXnPlZOUpFMT
 BEk//mxh5yVNOmJodxyowZ9k0oRqu/nvFbJNXphO+ay4lv8vdX10bQx4D1F9OVjNR8Aq
 24SU+JCnAyvkfirsTiE4i42rOqnF/xBv+1eF7DO9Ahzcz3wLqb/yU4Nu/egIZZrK7Nqt 7Q== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
	by m0089730.ppops.net (PPS) with ESMTPS id 3tg7cq2780-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Oct 2023 11:07:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA++DKdx0wwAlkgJPgZbY5jC7a+oGSXiYp9KrwRL2d9XaFIIXQhDkienJ3tC78OulieUl/w0BF1TZ5X4I5eYO97Ahhk4HTlyE8N4zKEpfwLV+w3naANXJm3E6VPQNKBw18LstUdTSc2eCCJr/43btoU9GrUvnAdEbHgaqdu8pe3ihgGxjr19EqID1svbQFmAK6hckmqo8IwRfEyAdlu/4632V1G5FOzspxXJHkvZVIM0cbqWxJFSFVM/WYpogsCbUqsboILL87NnAib3YpLypyMkmj/IW5eVBqJBOss/aQfhmNSSvKapY0dmeXAY5Ri6nmnW1bPzbxm9FsOv2xDlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CAB6CXWAe473mqtgnI7HUHMbQd7O9jl4Q4NCiDL2p9U=;
 b=kfHX1Io1OyJ5hOz8aUV4gFOULdp5oF0FoTQzNWdHoxdkMG7PK1YZwDeqhV7qUEKRzr8Ybxj4b0BhEYk1EZLjnWYrOsRCdKO8Lww7vzvrorpR6J83qiBKq9NOQcQLePVmwmx5uUlOGm1zYP6x7sDSOdZtWBprDvPttFnqV5iWYAe1oatJRnP4W7V/u6BKd6eQLoYDG7sJqps7VrFXZ8HLzpfFCifpZbRyR5U5UpyXPp2Cp8/Q5fbtNPQig7uzEkyIe3U4ghSm4f3DsThTCDaHjLk9zM6oiZqJKjxuzwc3BzuyhmB6Q6Q4GNxRGb8umuZbDqQ8lhnWBkDNKveOrF5cGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SJ0PR15MB4741.namprd15.prod.outlook.com (2603:10b6:a03:37a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 3 Oct
 2023 18:06:55 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::e0e7:7606:7fef:f9de%5]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 18:06:55 +0000
From: Song Liu <songliubraving@meta.com>
To: David Vernet <void@manifault.com>
CC: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel
 Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend
	<john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@meta.com>,
        "himadrispandya@gmail.com" <himadrispandya@gmail.com>,
        "julia.lawall@inria.fr" <julia.lawall@inria.fr>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add ability to pin bpf timer to calling
 CPU
Thread-Topic: [PATCH bpf-next 1/2] bpf: Add ability to pin bpf timer to
 calling CPU
Thread-Index: AQHZ9YrG6rN4k0wE80SYLdmAMGheD7A4XaeA
Date: Tue, 3 Oct 2023 18:06:55 +0000
Message-ID: <F23E4B79-8FEB-4398-8C12-EAEACDE4AE1B@fb.com>
References: <20231002234708.331192-1-void@manifault.com>
In-Reply-To: <20231002234708.331192-1-void@manifault.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SJ0PR15MB4741:EE_
x-ms-office365-filtering-correlation-id: 35d84d3d-8664-45aa-38b3-08dbc43b8785
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 ZE9D2F7oSGMa0Q2pnxosiOorWOxjb8W3NMbzzuYOLxIvu7scIQSucB/kQzx/Dj0ODG9nZZCSYSvo+BX0wLUcmS0KPPjcHVtdehNWr4ShmudRzgnWXuP+LY4igilxVU8f4JCsfFJbopBSXhDu3SoXJUQy7ed9ENEiqGzNJYv3Nr4L/RCyTQ1g7GWzSSgVwu8lXENJA8/vEAvxi4qEWTArtytptumHaSXCu2h5ZbWg/MlF34Si0gUV7W+iiLi9t1hNxgz8oJm7ju8+oKDghXysFrWRxJzSOo8d7IWiPODSGsCp9jiHdRb5LGBsBl7UNIyU7uFsKhH0xr8aXvvA1nyk1P6T2I0hzZCTV0Ax+obJBJq740LMGrte6KyZCakl+mHjGvdDgSyVPbiX2Qm0jDAYmhwtLrq4lgQyaWm4MVPdi8mmqdXw4Zqu0Ftaq3QfOe430p/CS0oMOozmhNX4255LKdxfYNEGpPXK6x4ZSsylSJST8zGHWKFcLlj5lMQ+p5f0QQ7zrQ0wL0BC+YXXaDOzo/f3/7wZY3O7EXHWTVExKqJ7w4RY/qPSbzgFd2Hk+p3lSXOOvmBKq4MazEGnJN7mSMsO/GTICP7GSRnb0kPwBKQOWMAjJgdnEjNxFm8SYLJb
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6512007)(53546011)(6506007)(4326008)(71200400001)(8676002)(83380400001)(2906002)(76116006)(7416002)(54906003)(8936002)(6916009)(66476007)(91956017)(66946007)(5660300002)(41300700001)(66556008)(66446008)(64756008)(4744005)(316002)(9686003)(122000001)(38070700005)(86362001)(38100700002)(33656002)(36756003)(478600001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?DYuwjUlErTMz8jGCRl50dVpa+OArzFbrMjf/RG4zVy3x0HaAfyFE9NjecxTb?=
 =?us-ascii?Q?fK7tTrZZN8Rsz+NSk3V/n00DPBbqhD/uzdhH3AQ/dicJ9mncQpH0fK6P+r+u?=
 =?us-ascii?Q?TWybIclZ+OycEoRTPkuheGbX0AVkd7FOLJUNEOgA5ZmaR8EB4X7xfJplcfQV?=
 =?us-ascii?Q?LiUrbNua4k5DzGzCSQnnYMRKgus0qXRk+jj5zsBxOBsvg1YgRs+NBFJBd2Nu?=
 =?us-ascii?Q?OWsG+NhuIpv6EgSq7XcBGriE1zvVSTL4PmoVlAqm50xqg9oWYXnyEfhk9cOD?=
 =?us-ascii?Q?7n02+eoydIr8d6IgpWNtVf6wA9oO8x/ekmwbAgxf7oPgILzo4POFtrxwVKZo?=
 =?us-ascii?Q?FOQT1J1UdCO3YFESJHFkuBj2dEW7ebhEZK4PmQjJ3asA9CMauNLqdtEZPfyK?=
 =?us-ascii?Q?ISlhy49VAC7zBh0sa59vE8YabTjlfIw+lH6iPsp5NnFuPQhicQ6FMDK5DNbT?=
 =?us-ascii?Q?1+eMW0pgeCnWFAevCMDgg04abJ9Ln1KO0gkBQ/3W7pZnNDqO9bBJhfoTKp5Z?=
 =?us-ascii?Q?NWviwUBYOTCkZbQd4b9yk8Kc8ouqkujymjaw9jiEC7c1Ls30VbYXr/dJDX5M?=
 =?us-ascii?Q?rOiLtMCHPrLB88uJpj61pmtxpWV8LWnCB6yIZt0JHJA3YnUoecMXCIJRlqoA?=
 =?us-ascii?Q?eSEH1/qVS6bAO4yURskCgBw80K7WsZUEMowtIkjUwlIoOklyv60FUuQGqw6a?=
 =?us-ascii?Q?yHtWZ9dm0HtfTSSQaBfWZSOzE3AyDObvKghYs0oRr/D/2ozf3nFJdj+XMz++?=
 =?us-ascii?Q?BdVWZLKv5RvS3Vrtvk2lGyHmJ111tgHp/T/FjUjqnO5KjIztWltmF/8HN80B?=
 =?us-ascii?Q?ezPfs4V1OjVA4seDRpzWv/4FB8LiTQoe33lsL15PVIXh8VykUDyyZg7HMAIv?=
 =?us-ascii?Q?OjSpNSYNtibxup43nlzLoiALmICfgoonDWFCuMbSEZgduc0G0JmzWFAtI9Lx?=
 =?us-ascii?Q?+PAf82eU7ouJqLzh+SHkEaKMwc5XbKnmzfArmtFrz4gzvEveiMMcRhqxnfg3?=
 =?us-ascii?Q?KOwSZ/Ls04I8w2LN8SCb4I3xXFmVOF4ibdlzdQDYDyAjRngwLwmXLHXpPtFX?=
 =?us-ascii?Q?ik2ixHWadDmMSWD2OTN0j/NuIyo5qhqir2hx2qj+IbKq9JXpyAQDhKEpBiSr?=
 =?us-ascii?Q?duYDL5XCO6VrzpNgsoOzna9JagJ0TyFEkvVptoPLTsVA2UQWU6YaMAyExZBF?=
 =?us-ascii?Q?/HDvRsa5RNlH3X/GKvs18jx6/K9lKXZpjIhZsJpNaqAJXYDtmxfNq5FFlNKI?=
 =?us-ascii?Q?uc3zTOdE7WAuW0q/SA82GgtfGbJ/jKQalkijDLiWFoyD4m66q3sj7SxZWFfa?=
 =?us-ascii?Q?qI60cyk4oTnyCIO6E0KwiMCvxYR7aEYooerY+K+K85AdbWPfSQln9e55UqsD?=
 =?us-ascii?Q?5hs6GK3bU9A9jFr2JGeFK2jmaHKezSdbH8TAlqwRDZb/kEHHte5QeF1Dbz+C?=
 =?us-ascii?Q?lZUrHaBRteGGBKqwudc/V3WT6ACLtAZhzYqjGvaSokV+XQe6YjXpuBU07WeN?=
 =?us-ascii?Q?GsLP98EnJC23T3dce0TEYzaI+0Ay9CU3b2v3kgk6SNeza+1MYn5koWbxG3Yp?=
 =?us-ascii?Q?KewqZ43ouzgRWIHMEICjx/jzy+alIulSKjiiLgFG62Lk4u78wiI9fYJ9duLg?=
 =?us-ascii?Q?/WvwygKFoHD6mD7+WGa9LhE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <128AE3AC51166048AA3AD04DED4FFB35@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d84d3d-8664-45aa-38b3-08dbc43b8785
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 18:06:55.8817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UXiHKNZ9jSZ26uInTEMptQSIS8JDan5hmG3SX9RDSp2dVxCoAoniQ1ucopTZ/lXgjljHbKW5/PYmFN1quGpfSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4741
X-Proofpoint-GUID: gIiypiz8ih5v73dRDk58TJsfy8fdXKVe
X-Proofpoint-ORIG-GUID: gIiypiz8ih5v73dRDk58TJsfy8fdXKVe
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
> BPF supports creating high resolution timers using bpf_timer_* helper
> functions. Currently, only the BPF_F_TIMER_ABS flag is supported, which
> specifies that the timeout should be interpreted as absolute time. It
> would also be useful to be able to pin that timer to a core. For
> example, if you wanted to make a subset of cores run without timer
> interrupts, and only have the timer be invoked on a single core.
> 
> This patch adds support for this with a new BPF_F_TIMER_CPU_PIN flag.
> When specified, the HRTIMER_MODE_PINNED flag is passed to
> hrtimer_start(). A subsequent patch will update selftests to validate.
> 
> Signed-off-by: David Vernet <void@manifault.com>

Acked-by: Song Liu <song@kernel.org>




