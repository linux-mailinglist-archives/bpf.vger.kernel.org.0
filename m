Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24F9336264E
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 19:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbhDPRG5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 13:06:57 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:62264 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S235659AbhDPRG4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 13:06:56 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13GGsxmP031264;
        Fri, 16 Apr 2021 10:06:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=zlqePCkEhEVYtoFjLY32HK+Heyu0AO0owhgn/EPOGBY=;
 b=Ulyrc03ukek+ml7LezdzZLY/TekKnHanj6rmA5tgxCJtJDNl4zWUEU0r4WfWmp0zdaqM
 3bIJMIzcTMmcjs4/08Tj41lUIiLfvcbl/9vxEFKX1d0sfCBzYAz80vfhihAe/ARGvhRu
 yI6ToXTqjagmsc3YiMJ0i5zARP1+qw/ikMA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 37yb39hdbe-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 10:06:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 10:06:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KKC0Ol3UcGO7CDWHfK9XW1nICJRLFiur6TS7DeQ5PT3ZJSqf1b6H9pwjk0IkyhMM5anZBuG0PrsLWolEz+ljoXQbJpB3WFfxJU00nTPQj3cymrfpCXD3iwsw1pPCKdXzvkoAvhv1FnVnqwLIIdwsysUqPyHQh1Ch9DPnNQ2hGPuWs+7kkb+rbvF6M0p+4KB7JyMmJq0qFFojedZH8q2z2b6l82y2COcVuBJzSQVgWwzySL4glaLfb6RF6oQ1l+g9qCMc3NlEqC8ev+qwWj8vw9gNQSPWGZxSHW38WfNwasmbtWb6GSkcZe5G8PB5RjR4TJPHJ8CPHk6zf7+G2taF8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlqePCkEhEVYtoFjLY32HK+Heyu0AO0owhgn/EPOGBY=;
 b=aVAXR54OhiwdSFk1pYR8PGAIOV89x+6NXpJvCLYw5rS8uxoBdrDxpvEw3+o7nN+KytqQlfH3R8eXjBXUEEJ5WTjVmvDJWnqW8hzr/aH07/VTqblseb6MXmLF/wp0buM/0BQumLuLE1wQZIeaq9olyI2lh5v9yPBey008Eob/QIcIKYI/YKXc334370ZNMsM8kAbRgfGE+lTyUyILrcyd0II/Qv5IumCn5wPUZ5uHoVAlDzFIAeigL91lwT4nPCw7mhbwECCqUSlnvKGfhqnnX+0Z8fP1xrk1hMF1VIlK2ZleFpGi5Iw1T7nL+WjRh3C61CpvgTzDCJ+DNb/zss07bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BY5PR15MB3715.namprd15.prod.outlook.com (2603:10b6:a03:1fe::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 17:06:11 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1ce0:8b27:f740:6b60%4]) with mapi id 15.20.3933.040; Fri, 16 Apr 2021
 17:06:11 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Dave Marchevsky <davemarchevsky@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next 3/3] bpf/selftests: add bpf_get_task_stack retval
 bounds test_prog
Thread-Topic: [PATCH bpf-next 3/3] bpf/selftests: add bpf_get_task_stack
 retval bounds test_prog
Thread-Index: AQHXMmwZ2xnmUFq+1kCRhyLxl9LWQqq3YMAA
Date:   Fri, 16 Apr 2021 17:06:11 +0000
Message-ID: <7E5C38DC-DCAA-4905-A289-1C339748E3DB@fb.com>
References: <20210416025537.2352753-1-davemarchevsky@fb.com>
 <20210416025537.2352753-4-davemarchevsky@fb.com>
In-Reply-To: <20210416025537.2352753-4-davemarchevsky@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.60.0.2.21)
x-originating-ip: [2620:10d:c090:400::5:8797]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 258737d8-bb97-45d3-9fcb-08d900f9ef59
x-ms-traffictypediagnostic: BY5PR15MB3715:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR15MB3715761A5CB9B799360EF10CB34C9@BY5PR15MB3715.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:800;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2JahfL3EqHsYTM8+WEECTcO5eIj4OhlycJTtXR1CM60Hzqy7dtgFw/XYH8AUI6BtB4yqgIZOf2mm8EuBZLtuZnAy65zDDjXXxTv35gFw22km9AB/sRhK+n7KrNSut/z/lorNbAVOUWfeWdcRSkmMP5ShQieox+neKPyx6+ETUaC5WI/vRoGf24ZV1YJFf0fSL2GGI9Vj+7dqgM+WSijo6KMWQSD5SjwjUHYPRYPJ8LV+Cr+pXZ/QrtcdoxgkRlQuUoy84VVDFVGdbGQYfH0apI3H8rQae8Fmb8+6PAqquiBMXDEHOCB2R+YC0wfWkLdzLr96flFocKHwRxkitPE0n+ETVlJYpCVPxRBMH/z5XLqgs7+EoEdzmhxMfoRDLmJCV4/aGf+NvgDHJilcEkFfAQMQRaWhWhTAtQeoKhVaPPGTJF0Iglpi7jEXnUwQnUqDKmzheoMShr9lalzNIZq+A+pf19SmhYbaNMssTwdnV0jJO7T6QKcaIRPts0KjJOdmO5UlmksUzKs4iWuG0OKAwIolLYOxQcmzv1I2Lkv1liYfeUbJreNzueruL2YXVzH18fHMq4gEhlDS53KVtfXNTNkTzScjGyMjAFvMUfXfPkW3caxNzYEF9dGoJNHIbteGbGuioJTHivw187dCvQWoMTu9NtCrtMWVrFXTRLBh3r4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(39860400002)(366004)(376002)(396003)(5660300002)(54906003)(6506007)(8936002)(86362001)(2906002)(122000001)(38100700002)(6636002)(37006003)(186003)(36756003)(316002)(6486002)(6512007)(6862004)(83380400001)(4326008)(33656002)(71200400001)(2616005)(8676002)(478600001)(64756008)(66476007)(66556008)(53546011)(66446008)(66946007)(76116006)(91956017)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?9LzSOgBJc3fZRD3h1KITEZZFKdROBlx8HMcSV1ox65i2BqgMuAeQjguGY5f2?=
 =?us-ascii?Q?ckYEMc81QcrUxPdt1aQ+3epTY7OigZKr3LL9U5IFH7ZRlh9objYy93SilnJr?=
 =?us-ascii?Q?JbIZZNAEtf0+SKcwF/uqyfD5oCkh9g1SE3xdQbA9VjKG3cJIcXzZl82xeNoX?=
 =?us-ascii?Q?BEO+A5JnwkPcj2Ap1cuR64NVXaUFzWV1PM/vheMBQ4cj3rIvYZW581wxYS51?=
 =?us-ascii?Q?1RP41oDtCDx1wAbp9Imw8lpsCP6VCFDHgM0Ectmvy7wJhPkbPwiynlXKYdBF?=
 =?us-ascii?Q?1nMiqr+gg1WCMGvYrQQ0L6BgIxL3F+xm4K5NgnQzZ//vAIxcGJJIAybvUxLs?=
 =?us-ascii?Q?ra/2P1uiVE5Hn9VjyUIoRzAAPOLfPOIa6B+nQRNgbKEKTKBpEjakuqA+eJHO?=
 =?us-ascii?Q?jX6acekLfJ3rY2vXZama4iq0rdyZ8logVfN89nK+oatzv+MkfPQwl+H4VjCB?=
 =?us-ascii?Q?+j8EbFsfAhlOEUyHG/rEg8dudfXlvwMUMENpSOMaOWV44cruo6uSyQB3g6w5?=
 =?us-ascii?Q?loc806iVoaCRIo5yfYBIi1BeQP4OWWlynppRBTFiiC/BtJm7/v7GfqiH9mOe?=
 =?us-ascii?Q?JqTQopWxsn7pCZf0KzAAitkxQDYLaIUKfdawkkaNI5lhzFBrQ77nOLMa5CRM?=
 =?us-ascii?Q?x/kcE8LEmeui+XGzPXDz2OtCl9Use6EsJe2uHU1PpD+FpZPxdqaEDcjnKSqQ?=
 =?us-ascii?Q?2lb+eOXks8D8UxqiUVywGQz+Dmhv4yQ0iXUCHy0g/TT9mM2LCee1SxpYKh9P?=
 =?us-ascii?Q?+53x40JqFU8T59ExLincUc+HHCCdHkO1mGaSzGzAFTda+9m9AS9dhnST8RYY?=
 =?us-ascii?Q?5L2o7yhtT2CQApoAF45HVNL5RAySlSjjkG2IRYLr5WQ591XMGLzdKLHhSssp?=
 =?us-ascii?Q?3CsUqwiwrdj3Qb+qiCDHcKb5S9YQia/SmxvzavyOaBFJifdtuZWi0Pe99lky?=
 =?us-ascii?Q?gmQlkNTFEa33isF8Q/prjN2qDG6AscnxQrn5ESlgT3C/8ct034lMObiMbJ3q?=
 =?us-ascii?Q?kGjF+hioxL/6mVdeN/7mgJL8rfw5hCEQnsnw7ZBnYQSA9Ec9KfYWUxF5bwBB?=
 =?us-ascii?Q?+YjcioMNA/ldTNA/n62YDsj++yJBL0ns/Q8vCRP9mSOmXaKN8OFgM8S9sao6?=
 =?us-ascii?Q?mo7lj6TvC8gPtzf/13pugcqoNx95xtgTZhCrxxK8Te4v0y/S1Gz0JEh/0M1l?=
 =?us-ascii?Q?l8JvOQlObLpftNJN9AT7ND2LDXtux2nwQob22Uy6fgaCm/CRXFuzVhWJbTcP?=
 =?us-ascii?Q?c2nhaOGpq93w7uBZ+EdNczPyrslbnizwMkLz7vLgKXEJukoKXvLBiPLys8FM?=
 =?us-ascii?Q?kJYY0DmI9JHlrKdmyhO6Wv5FqUAWWbBXd6Tv7xsOlbEQO/I/eDxb5q9dluzL?=
 =?us-ascii?Q?ZJxzZto=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1DAFBB49859746438A13325FB8FA9346@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258737d8-bb97-45d3-9fcb-08d900f9ef59
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2021 17:06:11.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wbpseE0XfNdQY52W3TM6TXeSSKyuI4UzNoN9EsFD7VpsWI/8ca8VG+403YI6Kw9DvI1969TsQiuJ7Gh60w6dmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3715
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: B8Z1W80SuHJyZAJ8Sa4_vmw8u0WX1ggf
X-Proofpoint-GUID: B8Z1W80SuHJyZAJ8Sa4_vmw8u0WX1ggf
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_08:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160121
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Apr 15, 2021, at 7:55 PM, Dave Marchevsky <davemarchevsky@fb.com> wrot=
e:
>=20
> Add a libbpf test prog which feeds bpf_get_task_stack's return value
> into seq_write after confirming it's positive. No attempt to bound the
> value from above is made.
>=20
> Load will fail if verifier does not refine retval range based on buf sz
> input to bpf_get_task_stack.
>=20
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

With one nit below.=20


> ---
> .../selftests/bpf/prog_tests/bpf_iter.c       |  1 +
> .../selftests/bpf/progs/bpf_iter_task_stack.c | 22 +++++++++++++++++++
> 2 files changed, 23 insertions(+)
>=20
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/te=
sting/selftests/bpf/prog_tests/bpf_iter.c
> index 74c45d557a2b..2d3590cfb5e1 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -147,6 +147,7 @@ static void test_task_stack(void)
> 		return;
>=20
> 	do_dummy_read(skel->progs.dump_task_stack);
> +	do_dummy_read(skel->progs.get_task_user_stacks);
>=20
> 	bpf_iter_task_stack__destroy(skel);
> }
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c b/to=
ols/testing/selftests/bpf/progs/bpf_iter_task_stack.c
> index 50e59a2e142e..c60048ed226f 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task_stack.c
> @@ -35,3 +35,25 @@ int dump_task_stack(struct bpf_iter__task *ctx)
>=20
> 	return 0;
> }
> +
> +SEC("iter/task")
> +int get_task_user_stacks(struct bpf_iter__task *ctx)
> +{
> +	struct seq_file *seq =3D ctx->meta->seq;
> +	struct task_struct *task =3D ctx->task;
> +	uint64_t buf_sz =3D 0;
> +	int64_t res;
> +
> +	if (task =3D=3D (void *)0)
> +		return 0;
> +
> +	res =3D bpf_get_task_stack(task, entries,
> +			MAX_STACK_TRACE_DEPTH * SIZE_OF_ULONG, BPF_F_USER_STACK);
> +	if (res <=3D 0)
> +		return 0;
> +
> +	buf_sz +=3D res;
> +
nit: When the test fails because of missing the verifier change, a comment =
here
would help the debug effort.=20

> +	bpf_seq_write(seq, &entries, buf_sz);
> +	return 0;
> +}
> --=20
> 2.30.2
>=20

