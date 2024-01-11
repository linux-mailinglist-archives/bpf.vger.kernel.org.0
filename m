Return-Path: <bpf+bounces-19385-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 533AA82B6D9
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 22:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2EEAB22760
	for <lists+bpf@lfdr.de>; Thu, 11 Jan 2024 21:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D62258208;
	Thu, 11 Jan 2024 21:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="HfYzCF6k"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1D04D13A
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 21:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40BJDG4p023003
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 13:51:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id : mime-version;
 s=s2048-2021-q4; bh=oLqHYYW/6Bj2lnJqTI2a/CzXOUWS386bghZRbwzcrpw=;
 b=HfYzCF6k2oyT+/TY5569xNC40mpJ2s1afhimx4p8NrIkVwROUZDmD/i3tqOZElZ5xUCJ
 rpt4XaWSbGL2jNav2WpxVPe+CgYAOJ7XFLfhTzlbKz6FhmQVSOuInU5v2/JEg7lVzjwK
 QYw1c0Bk9A8BBOBdmjMB7Qp2eniJ6E3ZYh7RPw/LjuANhf8rVUOzDUGrZkiakIrLKz5J
 L7RlCU0y0+DsSTKbG1cKqHBC0ENQ0bd8S7DjP3vGC/sGjODgIeWV/eqK2lFm/AjMIF0P
 MVPWRPeUQggtF6P/5uoS6KHlwruWz6iZp9yac9RbDuCZQn1FFNnT8WFcxrWEZr3HP8aQ Mw== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vjp9v0xan-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <bpf@vger.kernel.org>; Thu, 11 Jan 2024 13:51:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LXkfZ+jBCP0+IMEvV0VkHDkYw2DcTF2qG9SrnJtKcUP6vNHqiAf5c3B2XucAUqq3GxnuGGGUUdU5ockvwe0CLOQJAInnmsoAlEg8uwsKX+V/9/wIehcxWI4vuZYWzsAw1/mnDYXCAjeOQVoJO4G8qfZi2LGuihnN7s/blODBucTJjMMZhEbzundFjBDFmvHUR9YVFRykfB3q1BhI0Fqm4LZkxCZovz1QPuZSCBnJL/z7thNaJVsgkqd2XwlDgoO4tm6y7uIuaI9Qz7MbaK2flWyuC+jraSWpydRlnMuRMK+BzOGEbXzLRjzEokgrLJ9h5nE9bRW3jsp1qt4TxJFFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLqHYYW/6Bj2lnJqTI2a/CzXOUWS386bghZRbwzcrpw=;
 b=aGFvclH9PbpRTSI9ob+eDQq7EkePoQQcnd7HirB658dgHcF9sqqUjLMksU39QnCyJ+NeMrG+OPvvJI5imSamRK84kZmOeI1qrVxsMT1WcH54HWe9IA0B34FpMQf7dHreATSazL4xz9A6yu9xJeMnOQ6nRXMzWhpTSTTzbiz4YrixCeMtZdjj7siu+WUtvvflPblhlOyB14KSThMWbnF0isb6kqVnHggaTvpXjctD5BZgSnl8wa8qxT8AfSVAP4lV/e9KmbRfiW1BLSb4I58FYVQtl7RkzThb/kxtRiiywPff8LWLSv6NcEZDyC/XPIjHz44/QKBNCbSi9IoZ/PoGoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA0PR15MB3997.namprd15.prod.outlook.com (2603:10b6:806:84::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Thu, 11 Jan
 2024 21:51:05 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f568:18bc:2915:d378]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f568:18bc:2915:d378%6]) with mapi id 15.20.7181.019; Thu, 11 Jan 2024
 21:51:05 +0000
From: Song Liu <songliubraving@meta.com>
To: bpf <bpf@vger.kernel.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann
	<daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
	<martin.lau@linux.dev>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jordan Rome
	<jordalgo@meta.com>, Yonghong Song <yhs@meta.com>,
        Kernel Team
	<kernel-team@meta.com>
Subject: RFC: Mark "inlined by some callers" functions in BTF 
Thread-Topic: RFC: Mark "inlined by some callers" functions in BTF 
Thread-Index: AQHaRNhGAtat6yfHPkKPOdL0scEpdw==
Date: Thu, 11 Jan 2024 21:51:05 +0000
Message-ID: <B653950A-A58F-44C0-AD9D-95370710810F@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.300.61.1.2)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA0PR15MB3997:EE_
x-ms-office365-filtering-correlation-id: f242833e-c58f-4344-2701-08dc12ef695d
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 K/d+rAGCtuJuNKoECdRIFO2kixu0S5YpySIGfmpEeTbfzBMlpnJRljvwitA3kpvML1HZCR11DM7dxUTFh9EOnVPzGTfPAD94kzGcCkDibgFh2m2y2SWE2NEUesIUtmW5UzN+UHJMI6QHU+OZzI+zKBq8KoSxJiOV942X3ZIU7ZZmbMeU961ks4Rb4aDSYVF8sz/D96RouIa6C4scdi6DwtwsTn4JALxcv+y6KXTgzpfshaT9wuPjvUTS5NHiKDg02m1XXlLqmvU+4RRdOCzG46AF1OjHWSUmE/TEQnoKDDzmmNRSHF8VdspSP26gCHgjrE26SGTsFcz4KV6B0Swl8S+m5WDKCSSUT2+p6oyCkGRZ0/fH4TPBhqCLQ2odOyQqGuIB9+JTTUwOIPHL8kuNQmUsS5hl78bJl5IldMhmVK+nZU2ZQjXnzAeM0h19oEqgiFDI3VyuiC0aEdNW51qehgGKayybh+ntqHg8yYsF6Q80MEqQ7X5rwsdhGDqoan/ZKO3ZHfIU0GXfwL/sPeZKJgW0ZP73tcY02MMPnbhd0QCcXVOkTtPNtX4lVjaDibn+EJllJmpwu6Z6+RElwJ1rDNfmgsfmFtGy9RDHS8+U5/ZeVkSrEL5xnqzFo/p3wZnzX6mTm52PVw3UsU0zQO2eL9cXafiCBe6JZDMVis6BELk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(39860400002)(136003)(346002)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(2906002)(5660300002)(478600001)(6512007)(4326008)(38070700009)(41300700001)(91956017)(6916009)(8936002)(66556008)(66476007)(54906003)(76116006)(66946007)(316002)(64756008)(66446008)(36756003)(33656002)(107886003)(71200400001)(6486002)(8676002)(9686003)(6506007)(86362001)(83380400001)(4743002)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?XjIX0CkJNMAny+DuVdZvmJM+T/zg7vp2TlS426C54iFfO5INJInCqGvDj065?=
 =?us-ascii?Q?21ZXH7jcCSep9TuiDdL04HdURWRNddRW/Qr6VwArEvlqDbXaALQpC1pyh6A5?=
 =?us-ascii?Q?5o57J4Tcwd/ko9ap8utY8zUg9YVlj+8krAeM3X5WJ3pp5CNNwTe2GsKOc6Fa?=
 =?us-ascii?Q?8uHie4SM1fPsKwb7FlMkrC2yFj5W4zQSvzDGyBs0MQfbE1YCl4yqs/9qX+UI?=
 =?us-ascii?Q?mY5VBEindv3ev1cdwVlXY4LHwZfEa8DHwMrAsSTCTsErhBQiYokMfjFg3ejw?=
 =?us-ascii?Q?+EeROiw4EQCPrY1sKOgIwA21BkMFEFffHpMQSTHnQIhVofvMmTHo0Flp0EPa?=
 =?us-ascii?Q?0Zq3HSVCKVCOFRd7hjpBBBTJokb3/859PPDzQD332FhYlbEtjOF9G/yRra/9?=
 =?us-ascii?Q?NkUZUzAHQAeLJOPkLN/J3txYIq4lUUgMoB7rXLfHY15AOzIQIJ0tmUDT9G2m?=
 =?us-ascii?Q?d7BfsxMdrZ6QxoflxCAwoCOQRpoG+gOmI+42tq2rmPNuOSEDT3bGazXV9a5f?=
 =?us-ascii?Q?SAOXBRZ9AFd2t8udyTfPFbCAlTP8bZOFs9AXX+seTiNZSkd+Ch1QC6f9nxm/?=
 =?us-ascii?Q?scO0VKWLH9aXYUqGBoBzqeHM9hAyWwBPIDAnaGW92XFd632BMH5gp7NFlNYf?=
 =?us-ascii?Q?5FRA6SijHF+S4MAyXWzVlraRJf0uAAw026qgOntzqsT+ZDOLjO8yAdrAW4xK?=
 =?us-ascii?Q?UjWtUwINeK94BLABj5fTKoFF5Po8svKQ8tlTOIl3jNrRI29ryMxNURlQ3Ykf?=
 =?us-ascii?Q?dolnvV2cCh8rh/cethl4CxBhY82QZH8U19P0SCs8JolPVoPewK0hGadPwqBk?=
 =?us-ascii?Q?+hzZ5chemeBOoHmJKYzkF16hbG9qCJqLZ7TPGx2/DKlXsJ96FQ6NZRy4wucp?=
 =?us-ascii?Q?mWJIXXDP7YC8FYEKQVL+pWl7jQ+cflo80mdgJcJ5TsQ3fybMdfPWZgjh3wuB?=
 =?us-ascii?Q?ukyK74pnYI+iCwahZIPZNfQUDkRK7T495UVXczlBaRW1IdArhdGAjwkVwRWc?=
 =?us-ascii?Q?lAiCLyydul5e8mDwLfiMAIV3mOR35o1djRn2YjAmfNORVkWW9FpnvKGikq+f?=
 =?us-ascii?Q?FpzLDZtocHZz1NQV/EEEeeuPNAPt7RpRylM2t2MySFpFbZIh093c/65GhcP8?=
 =?us-ascii?Q?7BDoOkMwgCf1Q9OxmQa/A97crhUdrbQ+HefX6jgT9r9TszoGc72QKRC0xkZN?=
 =?us-ascii?Q?CzOjKmgvgHYsNR1ez+AiMFJKFemJa25J2SwTogNw3V9GjnLHHsx67eJiHLm/?=
 =?us-ascii?Q?59se9I/QK/lh51xH6utLjQFQQ3a02IE6VE3PEY+bY1/VetNMz9BomeufVWIh?=
 =?us-ascii?Q?rJqMis/o6CPVL6Yyv92Epzwn9FpxV3Lw6Hffdxpe4mkOW+Aa8kgve0eFeyHy?=
 =?us-ascii?Q?G8y/7mVSWkN3jFDyDm/usjAiJ1L/X0GKVMHiENrWiEQjbluMP5tVukFj4VMo?=
 =?us-ascii?Q?N98JQXWeg2EJ9sU9UCYYEjD9DeDiTb0rsp5+fDRwuT34v1qYKQm6Vm2pNvMc?=
 =?us-ascii?Q?+j5xxR8CSMgbvW8VCDcIvNfb1rvfyRT6BgfTveDdxM0OVbv1oYe4h3h9bI4b?=
 =?us-ascii?Q?o0M4VH54DPFfI+OpOL3QUYdxuKL7Dt4wSJXHcskqqWiq3hKjW6VL9Jc2knAA?=
 =?us-ascii?Q?K39pvT0RKWH1hwzdbaqr6iE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14C813850117E04881D91A584423F1A9@namprd15.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f242833e-c58f-4344-2701-08dc12ef695d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2024 21:51:05.3105
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lNEN3NL3YnxP3RR+2N+pTV9AMv2A4d/Vv6vXfnArqXmmqf7yb4TfvEEOz2YXEbbHehD/4AttCS16LudCJtZuYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3997
X-Proofpoint-ORIG-GUID: jtzVY4fbpvlVH3z_156R49hzKtNLJZIW
X-Proofpoint-GUID: jtzVY4fbpvlVH3z_156R49hzKtNLJZIW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-11_13,2024-01-11_01,2023-05-22_02

The problem

Inlining can cause surprises to tracing users, especially when the tool
appears to be working. For example, with

    [root@ ~]# bpftrace -e 'kprobe:switch_mm {}'
    Attaching 1 probe...

The user may not realize switch_mm() is inlined by leave_mm(), and we are
not tracing the code path leave_mm => switch_mm. (This is x86_64, and both
functions are in arch/x86/mm/tlb.c.)

We have folks working on ideas to create offline tools to detect such
issues for critical use cases at compile time. However, I think it is
necessary to handle it at program load/attach time.


Detect "inlined by some callers" functions

This appears to be straightforward in pahole. Something like the following
should do the work:

diff --git i/btf_encoder.c w/btf_encoder.c
index fd040086827e..e546a059eb4b 100644
--- i/btf_encoder.c
+++ w/btf_encoder.c
@@ -885,6 +885,15 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct functio
        struct llvm_annotation *annot;
        const char *name;

+       if (function__inlined(fn)) {
+               /* This function is inlined by some callers. */
+       }
+
        btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto);
        name = function__name(fn);
        btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);


Mark "inlined by some callers" functions

We have a few options to mark these functions.

1. We can set struct btf_type.info.kind_flag for inlined function. Or we
   can use a bit from info.vlen.

2. We can simply not generate btf for these functions. This is similar to
   --skip_encoding_btf_inconsistent_proto.


Handle tracing inlined functions

If we go with option 1 above, we have a few options to handle program
load/attach to "inlined by some callers" functions:

a) We can reject the load/attach;
b) We can rejuct the load/attach, unless the user set a new flag;
c) We can simply print a warning, and let the load/attach work.


Please share your comments on this. Is this something we want to handle?
If so, which of these options makes more sense?

Thanks,
Song


