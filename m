Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC69362660
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 19:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238600AbhDPRKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 13:10:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48336 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S236512AbhDPRKx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 13:10:53 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13GH8pu0028959;
        Fri, 16 Apr 2021 10:09:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yAbrLrkTJ5sL0Kh53P+rvI5yTYmK1F5matlL1KHGBfY=;
 b=hCVutviq+6VuMhFgBqfsNM2FkFMJAlCA1mrlhvcGke9+Jh5Zb0ziw9lURqjJ7PT0my5T
 Xo1oHZ+STwrNJcDQsi0VBOI7g3VsKD+dG1A6Q0fDDP2IWLIuf7vOYXNsarJ4hRpEL/I0
 qU1qxcIoV62W26zcInL9tKZz9BoCAju9EL4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37yb39he49-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 10:09:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 10:09:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvukWctfv6QRQbugL+CxBzturrOmNrMbAmV3XNffxHD2OAbfO+3jvzdaAuSfDRhqwHxoD57cQ66DE2Rbvl2xh4X4etWJWkx2nY0gBh0Own3PUfzcpYNUxjDr5tMoHsK5cicaAak4JhmmmNLeKZleDtf9f+R9BkGiWQOZB09eEYzkkUS30jYstJkGyb6c7LAl4FWPPkm9hkezG2uTZ30u3l2pFDuMLxczcm6QWiyRQOdQz7dbFoDoxW+2siQUJb0TZS3pUXHGvQEhFpnL9Xp/wAOKNG0EYd336TiPiEK4jUd3HCLa4rthRhqfvG33tEhN913QHUh9DwAw8157Mwrguw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAbrLrkTJ5sL0Kh53P+rvI5yTYmK1F5matlL1KHGBfY=;
 b=lRAArpRTWHuakFGvKy/RhLJiU7ef/lZOtsio3xMNLpiFXb5P7EnpJs0JxZRvv4DuNtUJ8XMe0sNo27eNm4QKzA/3GkqprgrvBYLfUH6j9AUrHBEUhfd07uchDj9abppb1QoUtFNAVpSS+wly2L6NCAkHVGTcZryAXfYHyF2Mz6adGq+XbLC7Ylt6IIAJHC9G29c7anxqFPIaGlN/RXtyG7u3MDCfEpk840e/2/6mt9rDcCrzViSYYbURYqzJ1uizM+4u9p1Jyobz1pVw/OHCVVbZ9iv7IJxY5Bs873eOsKXTg/IvNsdmZgUCA3lPOEqz5bJPu6abNQWlWpkr/gh2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by SJ0PR15MB4391.namprd15.prod.outlook.com (2603:10b6:a03:370::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 17:09:52 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.040; Fri, 16 Apr 2021
 17:09:52 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 2/3] bpf/selftests: add bpf_get_task_stack retval
 bounds verifier test
Thread-Topic: [PATCH bpf-next 2/3] bpf/selftests: add bpf_get_task_stack
 retval bounds verifier test
Thread-Index: AQHXMmwVC8C4ZVelyE614oJe0cDUA6q3YceA
Date:   Fri, 16 Apr 2021 17:09:51 +0000
Message-ID: <D73FEC19-29F3-45B3-937D-7CF065F2FDAD@fb.com>
References: <20210416025537.2352753-1-davemarchevsky@fb.com>
 <20210416025537.2352753-3-davemarchevsky@fb.com>
In-Reply-To: <20210416025537.2352753-3-davemarchevsky@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
x-originating-ip: [2620:10d:c090:400::5:8797]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a6c382-db91-49b0-0eee-08d900fa72ff
x-ms-traffictypediagnostic: SJ0PR15MB4391:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR15MB439188306CCCFA7D337B7B87B34C9@SJ0PR15MB4391.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 74UkjlrHqQCMZh1a7QOjhYU/qmH/u/KFW2NhAu79PsBkSU2C/kuKJMxlM9uM+VnEXfif+qrSfV4NlNYHJ1w/xwuk7GDQlelETbsq/OF21RYKNNtK1D4/oaQkBMKjuy4sT6r5D0qDBGzmucFu7uVx/2+SX69X/9YFSFY+Ruw9KymAKa9ndXsL1iUnRghjL1Rsf9YMMFpD965zkWz3YHN0LLdPXJtvqElEoeBjeF69wmcw+ePMEbXL+MnFhWyTvbjfbuDdODdKMBfpJbtXm9+xAsWGk6NqcR4D33BAOauusjeC6TRM/PnKiCBxKAYEc6bO4e8hqYIcLtmgvbTyoj/9rmekyjX0oA4EKhxyrATfeT0FMzzaMUQze9IyABNldweOEtZxD8fRMuxPqXWYZ7zt8AvknhhWGfZxbOJcEIgkCXR6W5PwvOJc8E6Zd8tf1z44rWMWqnmBH3XHNZjpVZXcEJ+kfRa169OpX7Xy3FrbiSaewLC4avXuZiHFt+vd2PEQlpY7svyWaUigl59fruX3GiBLbxca/DP/RBOOlTgIf76Fkxxnt9FfYYc1Vw6VEmSKry1gZFlrVZbu/Ju8s/41MsR0rnOqkFrIyemBvWTunmo4z1NG7btVMznUaLzTHSXiZkH1ObKlnLeACHWNppv4/HO/b/FUmv7o0w8wk/qk9QY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(366004)(396003)(136003)(39860400002)(6486002)(86362001)(33656002)(38100700002)(122000001)(83380400001)(71200400001)(6862004)(4326008)(8676002)(8936002)(6636002)(5660300002)(478600001)(54906003)(66946007)(66446008)(186003)(91956017)(66556008)(64756008)(76116006)(316002)(66476007)(53546011)(6506007)(2616005)(6512007)(36756003)(37006003)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?L5fKCG/P+1+B6K2kSvtz77D9goAOMh+Z0J9dDtGEYnYHe/vqSGIx/49Qg5vW?=
 =?us-ascii?Q?ILMhNivOpcHke5PYsSxoCS9p3a4nTTJ0Ef5/den1ca36zkzEFoCjXQyTIOFD?=
 =?us-ascii?Q?ngytMHEFbGPwyXQCrV0T/b+rYHC7YZo0TUh1RPNeiSIxcyWsj0mSPOZa9oMa?=
 =?us-ascii?Q?vPjodnEF/pzyn/Uq5WZphdZAdMIkrf3dEZNMLej7Yr68L35xg7ZzShZmkfz6?=
 =?us-ascii?Q?lqvr7TMx1GIwHjfixSwKSUWOjl0PDy00w0ZXJcR+ud5QLbz24ppDzdXvmSNp?=
 =?us-ascii?Q?Xs86V8tVm4RK/+QoL1VkTcEd7FmJ1cXb8lYYrDUpk9UAi/O5jpfXGJJfG9l9?=
 =?us-ascii?Q?VvlmAS2ra9ImCYx11VGrVpXo5/3k/KmImn8J7laKoB8ncVgRxh7gmiomX9jZ?=
 =?us-ascii?Q?iGWLiEpOoix7cvF2pvZKzCDz4DIK4DH2YxObfQe1sMeXhmJF53IwKP67TgZ6?=
 =?us-ascii?Q?vW2ndwib7L5K8CJxb+/u0jkXAJx8SlYI/HKt4NlgUfYPzCXMPz3cZ5ZYL6UV?=
 =?us-ascii?Q?hW/E2TQUEs5nmF6IoCoaAZliso0malb4y71ExRJoLid7FlaVxCwI8vpWPU+k?=
 =?us-ascii?Q?ue2zlUcAWWS04CIeMy8dGRxJuoQ1EcNJl7TCPa0gpdvwHKLXehwDSICIbXaY?=
 =?us-ascii?Q?TnCsJR72lIskOTGTx6n2Hy+xIu2rOC3vWiKoZ9VdwTR3DdyAAHJS0CpGlIc6?=
 =?us-ascii?Q?PkoX79aFS8QmoP9XkqUlDuSyxQCEtvxkbMMZPQYPZxY+4+cHRPdaI1WmeDN8?=
 =?us-ascii?Q?xF3N1wxNN0BnkUS+uSNEwanEucG7tfO4uT4eHzRk6dwNYUVJnFIjl9cPv+h1?=
 =?us-ascii?Q?ysoSuMx05Gdr2a7H1sowNzmYkAfZkjMDepF2oXM82ysj5ZgPcY9PhaKjaoP5?=
 =?us-ascii?Q?DhRs/nmUs5TLEubCFoGdKorbCzEr/+ek22K6TlSzB2wuerGWj8dWotoZWGsY?=
 =?us-ascii?Q?STktqol2VLaT6COg9p8B/3EgLD5I14ChsCiqxlV8zlP/gwtLZ+f6pO55yEMk?=
 =?us-ascii?Q?8VYq91Q/Df4CRWunqqhmDUJ2RmAjzTL0NeviSsUps1j19gDBJhMmoXcufFsi?=
 =?us-ascii?Q?x7mJR+hMTDXV9QOzhDytjiiBC9lPNkvyI6pwGJZnb+GRzl6K2X1Pfs7eLh7F?=
 =?us-ascii?Q?nLA4OOXDtZwUhLQ80JwXc62aGZ4ip59XAueBUe8xQNYBcBtiPgLo+jGjZGEc?=
 =?us-ascii?Q?gooHrRJJgF17HBdH5ujk/i/8h8Maco779BMyhnfJs/ROjZyUik9DxF3fWtT0?=
 =?us-ascii?Q?Eb0GFeX9SXz6xJmT1VfZnf+y96ZTsA5kJsuUhpxKofSY7dA5wjsYjJlARrEF?=
 =?us-ascii?Q?92JFIZ1VnjKTN9ekghuEqhn2tDFwhUec5JlNJA2w7+oSANAo9QxVBpOoT5kd?=
 =?us-ascii?Q?7cEVGYU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AF686838BDA6643B6FE0153BD592CF9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a6c382-db91-49b0-0eee-08d900fa72ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 17:09:51.9478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MA6/NoBGWBOphmRORbTKb99NopxmAnd2mUjffeXuxF643FQ0sHoJoO9NKdU10BIVk3D6cW0OvG93ar5R+A1vPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4391
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: gMuPX3h5DLchBoYOZdOVKHrzh9DGZzgz
X-Proofpoint-GUID: gMuPX3h5DLchBoYOZdOVKHrzh9DGZzgz
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_09:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160123
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 15, 2021, at 7:55 PM, Dave Marchevsky <davemarchevsky@fb.com> wrot=
e:
>=20
> Add a bpf_iter test which feeds bpf_get_task_stack's return value into
> seq_write after confirming it's positive. No attempt to bound the value
> from above is made.
>=20
> Load will fail if verifier does not refine retval range based on
> buf sz input to bpf_get_task_stack.
>=20
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> .../selftests/bpf/verifier/bpf_get_stack.c    | 43 +++++++++++++++++++
> 1 file changed, 43 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c b/tools=
/testing/selftests/bpf/verifier/bpf_get_stack.c
> index 69b048cf46d9..0e8299c043d4 100644
> --- a/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
> +++ b/tools/testing/selftests/bpf/verifier/bpf_get_stack.c
> @@ -42,3 +42,46 @@
> 	.result =3D ACCEPT,
> 	.prog_type =3D BPF_PROG_TYPE_TRACEPOINT,
> },
> +{
> +	"bpf_get_task_stack return R0 range is refined",
> +	.insns =3D {
> +	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_1, 0),
> +	BPF_LDX_MEM(BPF_DW, BPF_REG_6, BPF_REG_6, 0), // ctx->meta->seq
> +	BPF_LDX_MEM(BPF_DW, BPF_REG_7, BPF_REG_1, 8), // ctx->task
> +	BPF_LD_MAP_FD(BPF_REG_1, 0), // fixup_map_array_48b
> +	BPF_ST_MEM(BPF_DW, BPF_REG_10, -8, 0),
> +	BPF_MOV64_REG(BPF_REG_2, BPF_REG_10),
> +	BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
> +	BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_map_lookup_elem),
> +	BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 2),
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	BPF_JMP_IMM(BPF_JNE, BPF_REG_7, 0, 2),
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +
> +	BPF_MOV64_REG(BPF_REG_1, BPF_REG_7),
> +	BPF_MOV64_REG(BPF_REG_2, BPF_REG_0),
> +	BPF_MOV64_REG(BPF_REG_9, BPF_REG_0), // keep buf for seq_write
> +	BPF_MOV64_IMM(BPF_REG_3, 48),
> +	BPF_MOV64_IMM(BPF_REG_4, 0),
> +	BPF_EMIT_CALL(BPF_FUNC_get_task_stack),
> +	BPF_JMP_IMM(BPF_JSGT, BPF_REG_0, 0, 2),
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +
> +	BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
> +	BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
> +	BPF_MOV64_REG(BPF_REG_3, BPF_REG_0),
> +	BPF_EMIT_CALL(BPF_FUNC_seq_write),
> +
> +	BPF_MOV64_IMM(BPF_REG_0, 0),
> +	BPF_EXIT_INSN(),
> +	},
> +	.result =3D ACCEPT,
> +	.prog_type =3D BPF_PROG_TYPE_TRACING,
> +	.expected_attach_type =3D BPF_TRACE_ITER,
> +	.kfunc =3D "task",
> +	.runs =3D -1, // Don't run, just load
> +	.fixup_map_array_48b =3D { 3 },
> +},
> --=20
> 2.30.2
>=20

