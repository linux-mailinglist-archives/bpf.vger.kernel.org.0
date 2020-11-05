Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A3392A85FB
	for <lists+bpf@lfdr.de>; Thu,  5 Nov 2020 19:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgKESRO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 13:17:14 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:29392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729783AbgKESRN (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 13:17:13 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A5I8cpN018703;
        Thu, 5 Nov 2020 10:16:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=HKpFi1irfI381Ue30l67UKv5l5yLNs1NFTGO4clCmKg=;
 b=LjFGWv0t9Diy+2Yn7Lkkw84deBfJxNtT/bQUQMQrJ5GyBlSlieebvUVJwLaCySWEZgwz
 hPNYpiHhpJA/Ar3Meb7O53dUgQKPt15Nxndf2beUdZ1M86zlDT4HjuMagqqC4nq3c3X4
 Hq9+mDzYgBEOf71L/GoOH2mhPyXjotkEK4k= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34kmuxa6wv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 10:16:56 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 10:16:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caIIlV09MYwOyIcqyZ884oC4mCkgMxJvJT3aGKbT6+3zhapHANKzXi6tX/isQH3Uu3zKJ2coG729KHP31aqg8Z+E7J6zyPFTZQ/Ga2x4CdaWf3F7HJTE9bRUgCmoxpe1hsr6F1ouWft2UZEjq5/F6NIhdE/MiLVd48XSofunPG8Dc5XJno/uiXoOYYF5TYQuf2pP595BWZpew9O8Fl1rAoAvC4zshXvj4GHd6+2bBXS2ESzPAp2B9+wWaj5lV2qtPmvK3o9CpA7jNIxD6EfTiI9uDPjS0lyOdbqVVKYrMxnkn/IBZtDcPE6CS+Vgga9ghQ4AVbRYgy3IH5hbGis+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKpFi1irfI381Ue30l67UKv5l5yLNs1NFTGO4clCmKg=;
 b=D/24raIubMCIubnlzw7aRDGLojKinENS3Ew1LdIfkHrLAhKUQY28Bwu4dBPR/OEnftILGHZ0kywSd4G98tHms8QD+w9dQ2GuS9KfvsSMjw4gETqNYFEqiz5Np7clCu9Z/GDXGl/x9AHuMSHB9iNNcJornmZu/ZelYafcwDWUcnjho0J7sqLZSMnMgU7iI6WygZxgmd5N3Fgc2biC21EsjMiMvnD1pGxOKDwfXR4Jt+DQxH9hnByuc28q6Zl3q63JS0/z11eTA9vz31ixxrCLT9eiiWJ29m4HsmZlHDromC1+N5rTNjPm+9Vg2osJ7ptEoLzRMtsnM1j3jd+PTJiV2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKpFi1irfI381Ue30l67UKv5l5yLNs1NFTGO4clCmKg=;
 b=LwVr8lN2YcTwJwCJZXUSO79C2t9OO8RgeTR2t98aW9NdvfXPRj+fk22C3UJshdegUKB7/FHA7lN3NRzCLsk8BH+LsrJakXUH7JAczZVryh9jLrp1hx4qu635hhU2XksplGDo3tj9V6TNISUVh7NYjBLMtYkPwv5sdAHs7oqJBBw=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2568.namprd15.prod.outlook.com (2603:10b6:a03:14c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Thu, 5 Nov
 2020 18:16:51 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Thu, 5 Nov 2020
 18:16:51 +0000
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
Thread-Index: AQHWsxsGDNyincyzREiD40J5/8I0oqm52XIA
Date:   Thu, 5 Nov 2020 18:16:51 +0000
Message-ID: <CE6BCF1F-2112-40DC-87C8-91FA2D6C86FC@fb.com>
References: <cover.1604542786.git.dxu@dxuuu.xyz>
 <487a07aa911b4e822a0b931f7b33a4f67fedb6bd.1604542786.git.dxu@dxuuu.xyz>
In-Reply-To: <487a07aa911b4e822a0b931f7b33a4f67fedb6bd.1604542786.git.dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: dxuuu.xyz; dkim=none (message not signed)
 header.d=none;dxuuu.xyz; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00d7564b-5e81-4bdb-bd7a-08d881b6f7a5
x-ms-traffictypediagnostic: BYAPR15MB2568:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB25689EAD484B992BED28EAB1B3EE0@BYAPR15MB2568.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3276;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PLfN78+UslssEn9z72LWfWPpL94WrvSfsafAXyxUEv0jdFJETH/wuPeTexmVEKpCP1WwINNOS1OypXFYsOeZPpuIAHTGoZw5qDVndj9nuIDG/IsQ2dYcHJuk76PC11GXXsqs23osFuE2r/pXnxtguSZ4s5XlLpEf9lip/k9vSPEpu4eHJs8UfsHDJYMbOIuePYf5R5cdqBzY7w4eDE0Bu1ORWyWHqs+LKnck8f8Go0COaHMKpLt1wCOVHpn0K0tvGKnKk7O5G3CbuW2xNQU4ySnKPHbQTPExj6mOnTQrhSFVHYt6KiW2ZvQxtHBj5fHnyn7KHl3tioHbeeSCZWfcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(136003)(39860400002)(396003)(366004)(2906002)(66556008)(76116006)(8936002)(53546011)(6486002)(71200400001)(64756008)(316002)(66446008)(66476007)(66946007)(6512007)(83380400001)(91956017)(2616005)(4326008)(8676002)(186003)(54906003)(478600001)(86362001)(6506007)(5660300002)(36756003)(6916009)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tPdPawKaGMGfssCWAjdr5eZFlm1N3x3rSByviYq5WIpJ1dcLh/DdDvhSi4X/mPcaYt7mDmu2HfjhHovq5gUvPwBV+rjverkqI/vJ2hD1VKQyxQk2AhqDrT8VrJc6jmyadwSkJBuXF4TQQ5WWDedaI+PiwHzP7KSWeGsgFAq4BQ+E1W6JTTMbB2mVNFoRP4jiFL5iqKnFnQND+aOoGW4Fzm/XHGS8FohcvXY+JfQGoRVxQ8jl8o3KVgwuCAyB1wLV/XJOM75LviqchuMMX8Ja4jL/5V3gUCuTBzPmfq1EDwcr/UaZZY07UX0gDu8liWs1Bx/QNqBJiSHBMU13esoiH8JRDBMdUlt/im6xCVzDk85qRDzJSXNJ5ew83bH5YAK0WUzaBQtALOf537mrUpOoncuUJg6Ga9CYI9gCqVm/wc3qsL+/86oD/x9XmRr33gIOLnO89+7NfQynfUU8OV/jdTI+g7gBptRDxy5sBvd4JvP+0++ulQYU/g6d9gJnyXu18MMosOipjnm1KviQSD1wo559YBv1iDId7P6XH3MrSbO1q/EfGfKf/Ua6t7rcfAlQzHgwTZNrGRZXKaS7SOWAGd6j1vQVTqra+s5MMSCX+bJV5seyEzjRUTVzadEHYGmMtl5//ihn7kOrBfLFL6/huNfwC/cwgTZJLrJ0J5dqHNZaQU8m6BIkYlNMLuPuaGqu
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FC80BB85421AD5409BBAFAE3FC1E21CE@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00d7564b-5e81-4bdb-bd7a-08d881b6f7a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2020 18:16:51.0591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: npZD5Zhct+WPvqjMJ/omJDXvA/zOltTmyJ19kOA3ZMIlolVgdgC4OLSiACEUH1qgyDkWB8cXbSRydqCEedWd6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2568
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_11:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011 bulkscore=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=936 priorityscore=1501 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050118
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 4, 2020, at 6:25 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
>=20
> do_strncpy_from_user() may copy some extra bytes after the NUL

We have multiple use of "NUL" here, should be "NULL"?

> terminator into the destination buffer. This usually does not matter for
> normal string operations. However, when BPF programs key BPF maps with
> strings, this matters a lot.
>=20
> A BPF program may read strings from user memory by calling the
> bpf_probe_read_user_str() helper which eventually calls
> do_strncpy_from_user(). The program can then key a map with the
> resulting string. BPF map keys are fixed-width and string-agnostic,
> meaning that map keys are treated as a set of bytes.
>=20
> The issue is when do_strncpy_from_user() overcopies bytes after the NUL
> terminator, it can result in seemingly identical strings occupying
> multiple slots in a BPF map. This behavior is subtle and totally
> unexpected by the user.
>=20
> This commit uses the proper word-at-a-time APIs to avoid overcopying.
>=20
> Fixes: 6ae08ae3dea2 ("bpf: Add probe_read_{user, kernel} and probe_read_{=
user, kernel}_str helpers")
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
> lib/strncpy_from_user.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/lib/strncpy_from_user.c b/lib/strncpy_from_user.c
> index e6d5fcc2cdf3..d084189eb05c 100644
> --- a/lib/strncpy_from_user.c
> +++ b/lib/strncpy_from_user.c
> @@ -35,17 +35,22 @@ static inline long do_strncpy_from_user(char *dst, co=
nst char __user *src,
> 		goto byte_at_a_time;
>=20
> 	while (max >=3D sizeof(unsigned long)) {
> -		unsigned long c, data;
> +		unsigned long c, data, mask, *out;
>=20
> 		/* Fall back to byte-at-a-time if we get a page fault */
> 		unsafe_get_user(c, (unsigned long __user *)(src+res), byte_at_a_time);
>=20
> -		*(unsigned long *)(dst+res) =3D c;
> 		if (has_zero(c, &data, &constants)) {
> 			data =3D prep_zero_mask(c, data, &constants);
> 			data =3D create_zero_mask(data);
> +			mask =3D zero_bytemask(data);
> +			out =3D (unsigned long *)(dst+res);
> +			*out =3D (*out & ~mask) | (c & mask);
> 			return res + find_zero(data);
> +		} else  {

This else clause is not needed, as we return in the if clause.=20

> +			*(unsigned long *)(dst+res) =3D c;
> 		}
> +
> 		res +=3D sizeof(unsigned long);
> 		max -=3D sizeof(unsigned long);
> 	}
> --=20
> 2.28.0
>=20

