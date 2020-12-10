Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E542D635C
	for <lists+bpf@lfdr.de>; Thu, 10 Dec 2020 18:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731837AbgLJRU4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Dec 2020 12:20:56 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40808 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2403878AbgLJRT4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Dec 2020 12:19:56 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BAHAPfC010887;
        Thu, 10 Dec 2020 09:19:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YcBb4e47tlQlAcQnON2DrDPpPtwGFV2qECR8EAB516A=;
 b=cHYr21i96xHGJXC9PXRHbZbZROXB5Q4uXElykFxb4Gkezha9Eoy3K3HCp0hPrR4vFgvW
 k25KU77RbqLqfu0zj16PZPzCl9kMBgXwCxDVqF8GUY4iWEo0DPLTgVSo6LAOfjPdHFgL
 qzOsdPjhv5BuMflVpvBr631QJSEmt6IrY4c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 35bpp2rn0k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Dec 2020 09:19:03 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Dec 2020 09:19:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVXOGhkn6KfUqL4+3TdplzfwSTDz+cVBPmgWZSpyceuorTPMkm1E9Z//pi3QsAwP71oVSRlvoOm6vdcbDZ2UkFlEvThaxibwXOYwQuy+G2/vQe6xbULc9wGJRIk/OTbZLcTIF0soILBlSleZESpUyNx4lP8bdWpBHLcPVe5LfvAKLnGOw24GEuX6MYrUgUCN5IBx9r5Ihils+hw6XBHcgALDytOSYBAVMqxm3i6DEbMUvsdBsTuNl35QIwi5lkgmLtWnSmxCBi7Q+dNIsR0F5DdgBdrGBq0/8nN1u5BvQ6qNiQYdvTwnt/51fFcY6gLXte5raOSPDFht6fByGAp8rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcBb4e47tlQlAcQnON2DrDPpPtwGFV2qECR8EAB516A=;
 b=FWGpSmXCi7nJFQd6AST9B9ITsE0yZHGvJfYiTjopLXsA7/hOlZPT8bsD41aaCBPwbczAQBML6JezGFS8Y7V2qUvPApXjKMLEB3WieNJuPdq6TKcS3mfyO/o48/2DqwcqhUJ0CEulPl0gb4S3tk60ma6Q9bbehuO1zn07xUbe2z5/wC0kiPBkTBvM/utq74QUN57NQXc0dtwIc2F4Bh9dSS/9U6BdPNVAGz27XLvJxpqGbg8ZABellPQArJrs9+T0OKjF3XkH342DZ4Kf7cJftudcW9DDjYsD6wSQVn1yKdDMf9Gy112NL2vfL1Y1kR5HlPGYUX6dVqTn1Y7wUlTGgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcBb4e47tlQlAcQnON2DrDPpPtwGFV2qECR8EAB516A=;
 b=jaEJbnJlXWHU0dY9D7S6a8yYzXTSqH2vKXm849hsupvmH2MWyVrCszgOIe9YB7j/G/Rjyms+WKJD4lOPgDam4mUCH3eLPphiQqAB/e65bTY5oQhbiYesdQsvfHRfExVBT0Zfxml0o2JwdEP7AEyd9J6lL3kIw1fB4HSSglFRkZI=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.15; Thu, 10 Dec
 2020 17:19:01 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::f49e:bdbb:8cd7:bf6b%7]) with mapi id 15.20.3654.012; Thu, 10 Dec 2020
 17:19:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add a test for
 ptr_to_map_value on stack for helper access
Thread-Topic: [PATCH bpf-next v2 2/2] selftests/bpf: add a test for
 ptr_to_map_value on stack for helper access
Thread-Index: AQHWzpSGdh/+UA4GYkK3cNwMzjKt76nwk/AA
Date:   Thu, 10 Dec 2020 17:19:00 +0000
Message-ID: <430138FE-BA48-4EE2-9D83-79192FB1DAD3@fb.com>
References: <20201210013348.943623-1-yhs@fb.com>
 <20201210013350.943985-1-yhs@fb.com>
In-Reply-To: <20201210013350.943985-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
x-originating-ip: [2620:10d:c090:400::5:d023]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0fa0b52c-bff6-4c44-bb99-08d89d2fafbc
x-ms-traffictypediagnostic: BYAPR15MB4088:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB4088F9230396F69534D7A715B3CB0@BYAPR15MB4088.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ul2UAEIwM3+Vea4bYTt5l9nI42gOOaHMPsTnpWJLjnjXcykAl+XZMJF09rCJX2EbXKzp82PP1jKrs/+oqEheDUq8XN3w6Vib8YRk6ofsWcyq1B/mPOp8mL3UbbAm+aSkJdILnFOo6069kzFkV+4PASl3xDb55eYRe6ixiOqlOO+e7fYcuAXG4jSR6Bj7vEn/9J5sQjsLHUcoNWAsDTDemXy40lqHVBA1WtchlBOsJCSckpUigxXvFAtpLTV2pYsa+ospzgg7cqLhL+iYrVHWgZw8ZIAXNWnn2i3ib2f2wY/sYnhNfsyJGPvbBqUZpw0GBrBffQIQtyHpd2OtbBP2yt6OR210DZ8P/eDnG9r9m565W/qaW+Bo1UGGXDQ6arsE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(366004)(8936002)(8676002)(76116006)(508600001)(6486002)(6512007)(2906002)(6862004)(53546011)(4326008)(6506007)(6636002)(54906003)(86362001)(83380400001)(71200400001)(37006003)(186003)(2616005)(66946007)(33656002)(5660300002)(36756003)(64756008)(66476007)(66446008)(66556008)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6wY1nf2ZYLQ6M+6wryhglC2xhank49x18xVMpv1EMWOyC8pIgLZ6RugR3yVt?=
 =?us-ascii?Q?aPkJ8/c1BWFQSeDhwd0k0PHRm4pc235mJlJjNV2tKJ3i6opd3k1zF07wF7ce?=
 =?us-ascii?Q?i6lpGAg/HukYXT0xWtZD9D0sd3f30+2k7sY7RvWx8K24c885xdLbYGnB49ze?=
 =?us-ascii?Q?F6V1DcaYd7r+4fmJ2jFoCy5XxdoyxLu7jJWfU9ggbDpjWUQ0m/FMvsGeWxnB?=
 =?us-ascii?Q?9qMLM9TFOsbyYM18NnTKrNCzOKGo5jFLmeOz88Tz3RoANOrLuArqHhvHIPSe?=
 =?us-ascii?Q?Z8VHl2FGHzgZ0YkyD+/8WR+NYzPLN7kq4qmkcrpeLU1CJStu/N3k0msVhxy3?=
 =?us-ascii?Q?eqku+8LDfGb0BK0PykHRa57D9hXr2Xujscr3YRH7irFS4zJjqu+ZjhsEAp/a?=
 =?us-ascii?Q?SqncIYdqJlPG4ZaCqAZPojgFVEZXQrvEezsSyms1STR48NV72AtKYaDRQPO/?=
 =?us-ascii?Q?AJUK1U3GJwuhzVTL4D98GZXiPYkxZ8IbTNvQvzb9cKLE4etUQgsy05EUZpev?=
 =?us-ascii?Q?AsB2bh+dAi7VtDBc8X2SMVZRA+k618vTk3qks4FIYycm2kWPUpJmDpTBqV8U?=
 =?us-ascii?Q?qFkz0rYBaBmXVluUGpGb2V3KcDn4b5N2fxVKGl9XNhd/C4+rorpkiE2n+cfx?=
 =?us-ascii?Q?hqDz0IgDgFxxqH0OPcrjiCarJBv98ZZXsy36RzrCidMi7hc0vOEqn9bg9DzH?=
 =?us-ascii?Q?5y6tKwAoyHbKvv0YakAhUmTR4gWfc5AKmplrwPPyLLqgVIcut+77c6qOCSFD?=
 =?us-ascii?Q?yOjAgAfWJmoVwvZErKAHXQLZkaD5Wok71w3OwMhT2PPN5l7Ef7q+78B9sKBe?=
 =?us-ascii?Q?YWLWQ4N5Gk0K0EB1hnxil3ftOo+vflnrWOsVdD91iec1iBk/L3zDATEXKigF?=
 =?us-ascii?Q?U/AaACqpThGv4hVEy4vD1/Kl4bkI9ov0JbqGaan+OzEBamVABlqCK4vCTzPu?=
 =?us-ascii?Q?y6DO1+JoVlOiROpX2TrG7hDdpp68FXxEuF6FYIeOThbHZNSrxdJRwIUlZUQS?=
 =?us-ascii?Q?p7jPQjz2A3pnjeBnCL0+Liu7cSAE+nJjgt3tAmRQ09Kt15o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07D065D527CB174D974F243B243E6054@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa0b52c-bff6-4c44-bb99-08d89d2fafbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 17:19:00.8731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NA4sTwlwkjCoLJuNJqmoU45827wqSJra0CswF9ZJ8VOTjn82BkJRi8X3/qbd1REh0K7zaMmeAT9XtVMTSi9Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4088
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-10_06:2020-12-09,2020-12-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012100107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Dec 9, 2020, at 5:33 PM, Yonghong Song <yhs@fb.com> wrote:
>=20
> Change bpf_iter_task.c such that pointer to map_value may appear
> on the stack for bpf_seq_printf() to access. Without previous
> verifier patch, the bpf_iter test will fail.
>=20
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> tools/testing/selftests/bpf/progs/bpf_iter_task.c | 3 ++-
> tools/testing/selftests/bpf/verifier/unpriv.c     | 5 +++--
> 2 files changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_task.c b/tools/te=
sting/selftests/bpf/progs/bpf_iter_task.c
> index 4983087852a0..b7f32c160f4e 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_task.c
> @@ -11,9 +11,10 @@ int dump_task(struct bpf_iter__task *ctx)
> {
> 	struct seq_file *seq =3D ctx->meta->seq;
> 	struct task_struct *task =3D ctx->task;
> +	static char info[] =3D "    =3D=3D=3D END =3D=3D=3D";
>=20
> 	if (task =3D=3D (void *)0) {
> -		BPF_SEQ_PRINTF(seq, "    =3D=3D=3D END =3D=3D=3D\n");
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> 		return 0;
> 	}
>=20
> diff --git a/tools/testing/selftests/bpf/verifier/unpriv.c b/tools/testin=
g/selftests/bpf/verifier/unpriv.c
> index 91bb77c24a2e..a3fe0fbaed41 100644
> --- a/tools/testing/selftests/bpf/verifier/unpriv.c
> +++ b/tools/testing/selftests/bpf/verifier/unpriv.c
> @@ -108,8 +108,9 @@
> 	BPF_EXIT_INSN(),
> 	},
> 	.fixup_map_hash_8b =3D { 3 },
> -	.errstr =3D "invalid indirect read from stack off -8+0 size 8",
> -	.result =3D REJECT,
> +	.errstr_unpriv =3D "invalid indirect read from stack off -8+0 size 8",
> +	.result_unpriv =3D REJECT,
> +	.result =3D ACCEPT,
> },
> {
> 	"unpriv: mangle pointer on stack 1",
> --=20
> 2.24.1
>=20

