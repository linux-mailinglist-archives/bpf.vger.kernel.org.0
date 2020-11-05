Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E9C52A85FE
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 19:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729783AbgKESTE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 13:19:04 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62078 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgKESTD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 13:19:03 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5I9ohE017537;
        Thu, 5 Nov 2020 10:18:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Oe/UBA2R9ekVaZrc/6eiIqXDY5hhwva0tfLj5AXj/bY=;
 b=rj2LUf2L8slhbkQ/3Lk82y9DBPxCfOzGa4mu13K9yb+mlejNBoD20tdcK+wNPiaNcjE+
 Vk0WAi7UQeRy2JgSXbsO1kK/MzxVEagA0SslLEPGxcnzynstu7Rlaxd0/PDqJguybLl8
 /6pwYaDl705PFXsR4Fb3kcposdB3K92ClWY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34kg7m3cu8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 10:18:48 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 10:18:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbSkNjt5VTaNa3mRdEmQCat4hKI/fqsBB1+BhNVTNmfUWSAPGHLXJalmIUW20jFSC7105tM5jTc6oAf9ahNc6Ebd5Ozrhfxr+0Xu4RFIrZQb8dB9UYXNiQw/gjdCUeRGHC1LDyfs1qYiZA8fptMdwxpKnKYPsLlQSuvOPbKxswuo2+VXnTlKcc/g1KUNkKw+sug3Va5N/tk2bqC2NLSgOAdEhfsWfeXAxgB+vO8D9RunaX1EDfrEqTEzl+eJ5adYwxhqHzU17t89lOCQ6zTzY03JzSk1nth27FlYuswrMrNV93TsYtZqjjBULk32faCZir1gSFJYm8Oi9tK+6eEVWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe/UBA2R9ekVaZrc/6eiIqXDY5hhwva0tfLj5AXj/bY=;
 b=FQHJW7eCh13tjJFvPwPi1yvNwXu52LhxU24Wys9o+UUw1ebeEwp9LCoyiGP1smGYNU+EII3906jW8DLbnCi10StrN3MvaGwKEAfYEvWQdw0ZZx1iEcVVO6nUAU0gA5yx3vp9A9bx9FO49e1sOI+UgV2GlZpbQKt97rEnMTYpP9OXYRJe5VZFyed6trIjv6IK8SP19n5iNdQxaraTzYWqcxvgSVMHcMms5tKcN99ikoDS+Xkm60cf5U/epZTfC0om3J0dD3BAu0lYzodfXKGKjMtDLchGGRdwbLkotrXHpy7qMzrakcwALsgPUp1tSWF1dWIrkIUI75ho+vPgoEVaAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oe/UBA2R9ekVaZrc/6eiIqXDY5hhwva0tfLj5AXj/bY=;
 b=gZeQnQlIpzl3XTBSB0SwlSWyswwrx7AjumqXfC6Wf2h6W8V6fOSEIuMDwIDiMVpBfXe6wk5UrGWUfsVI5+Aw7+PQD1wYGdzEagGaCzc5pU0jLSB2lxqNbsYoHfFf1oXww05Hgi9lc3/bU3V0UqpnUFGHGnPIck9OHrmGLyGdkxg=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2568.namprd15.prod.outlook.com (2603:10b6:a03:14c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 18:18:43 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Thu, 5 Nov 2020
 18:18:43 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
CC:     bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf v2 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Thread-Topic: [PATCH bpf v2 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Thread-Index: AQHWsxsGDNyincyzREiD40J5/8I0oqm52XIAgAAAhgA=
Date:   Thu, 5 Nov 2020 18:18:43 +0000
Message-ID: <7DA54E81-F1FD-4CF7-946A-5B629B56C4A5@fb.com>
References: <cover.1604542786.git.dxu@dxuuu.xyz>
 <487a07aa911b4e822a0b931f7b33a4f67fedb6bd.1604542786.git.dxu@dxuuu.xyz>
 <CE6BCF1F-2112-40DC-87C8-91FA2D6C86FC@fb.com>
In-Reply-To: <CE6BCF1F-2112-40DC-87C8-91FA2D6C86FC@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: dxuuu.xyz; dkim=none (message not signed)
 header.d=none;dxuuu.xyz; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0233d72d-e646-480c-3cc2-08d881b73a75
x-ms-traffictypediagnostic: BYAPR15MB2568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB25684BBF0E441E599EE9402AB3EE0@BYAPR15MB2568.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SUqgRRS8l78Z/c4NXwoa9fRJeQZRLBSyscQqen8FANAifxA2D/b+WIiCq81pbws6sGqiIyqdDgPWtt72fNbIZO3lBhx2i/h9lkLx0ihil51qD0k98RUO0XjRTD1+w1znnOpaq2zmuZ/KT5HhApK/t+3QLYp3cTfni6SXs/j7ntoz3Ic4mw55LYTL1ElpOBvb1kHvFlqSrf8aOw0UCn6P2fKnYoCtiROvKqeN9zGxY69HP92++TRPqAv6eHV9WiIy5HJklZyPrHIEahp69g/ER/r/ZqAQQVTD5hCLUVWXheI3p3r+py2l4og4RcvqbqB5Pi8M3j0ZNZiOuBLAF8Gekg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(396003)(366004)(2906002)(66556008)(76116006)(8936002)(53546011)(6486002)(71200400001)(64756008)(316002)(66446008)(66476007)(66946007)(6512007)(83380400001)(91956017)(2616005)(4326008)(8676002)(186003)(54906003)(478600001)(86362001)(6506007)(5660300002)(36756003)(6916009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Ced/rNFvErdZr4UG8Ru8/THSA3BQoHEMiUv35E4VwwvxgyJxE5MvouOm3EuqVGi9rwe3H8m8ZY8w8KFcjYNrmWHy/Dj091zy1Fx8JRrGL4cibotWPq21MSb4Sv9c7jp4cxDsVs5I3PXbw4Kq16UInkZHVHrqMeHWcmcy3+PVyckHd5/l6vOqiZS7xgO2ht+WwuOv6Bd9j2Vb6P5Zwj/ygWLB1CqWGPTIMocEuprogaW0PtbMrW7ga+VcXtNdySXIsriYQDhzjoZFDDJX3fyqe5QRWXlkiL8PwSa+mNKUsIE6xX9GeZ8JOLnt8IrJZqFWP6EYEbYl/h2Dbk94u1MbN/UdPC8eYCXI9x16s3Pi6N7HmOpob3gt1Prkx4GKA6vHoET4mnLqMSelH4Uh+ceeron2esbQ+m/qZL3LARFwSg8n2Xe6DMnf6HSDVGBhby5cD7L0fbaiCtp6XvBZzWyO82U2ns3710dFh8UOT632uN+Z4rOOL5SFtlpIDGjky7uMrdxPSWlqLtpgx+gQNqQpnZ+gGYKofe1dq9scUY7F4s7SUTck7GQLbefpqyPA6bbFkO7OGSG2Hog4kUX8OWn2z2v9x2QSkYLAobLnIm7dHtMqR9ErPxzrnjxxJ7AWmfnBu8LoP9/YMXxFiMkyWooRyP5Rnn83fIom7IGoYUh+AkR2IokwV5Emky5J+21RFv42
Content-Type: text/plain; charset="us-ascii"
Content-ID: <258FD37F3A020348808839C251152AD6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0233d72d-e646-480c-3cc2-08d881b73a75
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 18:18:43.1625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TfhizBgGj0nP37p8wQ3zk87bTB5I8m53aPtEWmiXNOGnRYTqlFdAHlVxMnaRjSGaAi5cHhyf9TeCVO4ZI7qLPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2568
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_11:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011050118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 5, 2020, at 10:16 AM, Song Liu <songliubraving@fb.com> wrote:
>=20
>=20
>=20
>> On Nov 4, 2020, at 6:25 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
>>=20
>> do_strncpy_from_user() may copy some extra bytes after the NUL
>=20
> We have multiple use of "NUL" here, should be "NULL"?

Just realized strncpy_from_user.c uses "NUL", so nevermind...

>=20
>> terminator into the destination buffer. This usually does not matter for
>> normal string operations. However, when BPF programs key BPF maps with
>> strings, this matters a lot.
>>=20
>> A BPF program may read strings from user memory by calling the
>> bpf_probe_read_user_str() helper which eventually calls
>> do_strncpy_from_user(). The program can then key a map with the
>> resulting string. BPF map keys are fixed-width and string-agnostic,
>> meaning that map keys are treated as a set of bytes.
>>=20
>> The issue is when do_strncpy_from_user() overcopies bytes after the NUL
>> terminator, it can result in seemingly identical strings occupying
>> multiple slots in a BPF map. This behavior is subtle and totally
>> unexpected by the user.
>>=20
>> This commit uses the proper word-at-a-time APIs to avoid overcopying.
>>=20
>> Fixes: 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_=
{user, kernel}_str helpers")
>> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
>> ---
>> lib/strncpy_from_user.c | 9 +++++++--
>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
>> index e6d5fcc2cdf3..d084189eb05c 100644
>> --- a/lib/strncpy_from_user.c
>> +++ b/lib/strncpy_from_user.c
>> @@ -35,17 +35,22 @@ static inline long do_strncpy_from_user(char *dst, c=
onst char __user *src,
>> 		goto byte_at_a_time;
>>=20
>> 	while (max >=3D sizeof(unsigned long)) {
>> -		unsigned long c, data;
>> +		unsigned long c, data, mask, *out;
>>=20
>> 		/* Fall back to byte-at-a-time if we get a page fault */
>> 		unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time);
>>=20
>> -		*(unsigned long *)(dst+res) =3D c;
>> 		if (has_zero(c, &data, &constants)) {
>> 			data =3D prep_zero_mask(c, data, &constants);
>> 			data =3D create_zero_mask(data);
>> +			mask =3D zero_bytemask(data);
>> +			out =3D (unsigned long *)(dst+res);
>> +			*out =3D (*out & ~mask) | (c & mask);
>> 			return res + find_zero(data);
>> +		} else  {
>=20
> This else clause is not needed, as we return in the if clause.=20
>=20
>> +			*(unsigned long *)(dst+res) =3D c;
>> 		}
>> +
>> 		res +=3D sizeof(unsigned long);
>> 		max -=3D sizeof(unsigned long);
>> 	}
>> --=20
>> 2.28.0

