Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3D02A8B5A
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 01:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732297AbgKFAUS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 19:20:18 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:4204 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731860AbgKFAUS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 19:20:18 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A604cbj029758;
        Thu, 5 Nov 2020 16:20:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=sbBPoXfM2+iUCqyUQ5IkgYoixwCXJwJXtlys9xwh+sY=;
 b=Mf/NtwHFZsa5M52Sb4hnhZv7GxiwPOyywSimv9BWKiZ4cLQhZtqs8Q5YOc4GiO2QQFQw
 cZuqbzUPXWSvSjZZUV1lYr0K8r/Ge/Iwz6yI7yiQ5A9lwVswNTvwAQowePNgGSUDlXIr
 2GzF7tNEEvzQIcYerz5yJ/hKZ2LkLpT3a+I= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34mr9b95cj-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 16:20:02 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 16:20:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fr1D3cEnSTrRjHjAFaVhP5YEQIBPvAc51AYEKZgLtWfbVn004SPfpMZcRBMbmxH4NutPSmbQsaJ+ocbkY7zeuN8HoF6bO1b24G3GQwt9TYvne/mDNZ0LccgsA5bgSkAmwd7xbzCSOezwL1RFUFv3Xle8JvJmPKKE03h9RrzWzq1nItWm3ORVUA+ewTNdaN79bFoSYAQN0gfCtmXTUm5b/xPjEwhoTLlomf+q9wRISWI8nS7ShiZbATQS5b1Zckk9pmqR5oGgI4CGjc9lal8tiNpQyGpnJuyBFLDsmG4HFiD7YetLLI6WNf1y/98InVYYgE8Ga3s7dnuu0EVwbJSQjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbBPoXfM2+iUCqyUQ5IkgYoixwCXJwJXtlys9xwh+sY=;
 b=LdoYUKF/0hq654pFWLMgRRwnJX4FuTMl03LEU0STEcjW3fLs4r0nXZNNKcJgxcSPV7PW0aKN1uLI9oiqr+3NBEQzlotEZwTKbb3+VWWk6VK0vC+2Q+dEnfb4AUJHopY2I+tGu7O5vzDGC3zLy5jIz4di86j1A22+R/axN+Xqsfh1OgunDC1rLNlAr1I+lXc9ZuspNNDdKwJmFdqYjc0dmJNyQhsWCu1Uf4fmJNKwCIwN0B0jJdXOoFqWLpML8/FseSQvQItk6/xaOZJQABjnbYKLbXK+XzjQ9KhRD95Su/uDjCyf1eNHfDSi194+1aTzG9LmBz3SZui20Nt0Pfvh4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbBPoXfM2+iUCqyUQ5IkgYoixwCXJwJXtlys9xwh+sY=;
 b=T5h5Lw9WbuwGa4ihQG+jYBuicmWNiZx/6swg6qpTtvDYOAsEGS4U22HdV6MDqn2ACaa2LSC6i/4dQfHEQOka8A9pcifSyTUg06c2/SbO3cIEEKYRZilq3qa9ywZLkyAcd7gjUhlCY/j4lZyvpI50ScqfG9OkPF7wH60j5CxrdFc=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2647.namprd15.prod.outlook.com (2603:10b6:a03:153::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 00:19:58 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Fri, 6 Nov 2020
 00:19:58 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
CC:     bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf v4 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
Thread-Topic: [PATCH bpf v4 2/2] selftest/bpf: Test bpf_probe_read_user_str()
 strips trailing bytes after NUL
Thread-Index: AQHWs9C69mAIq+GkoU68WQgbMwtx0am6PXwA
Date:   Fri, 6 Nov 2020 00:19:58 +0000
Message-ID: <1DBB9750-9262-4E2A-AE5E-59533C25B90E@fb.com>
References: <cover.1604620776.git.dxu@dxuuu.xyz>
 <8b8c8f51aff8fabac4425da9b0054b4c976c944b.1604620776.git.dxu@dxuuu.xyz>
In-Reply-To: <8b8c8f51aff8fabac4425da9b0054b4c976c944b.1604620776.git.dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: dxuuu.xyz; dkim=none (message not signed)
 header.d=none;dxuuu.xyz; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb4d4d21-1258-44f3-aade-08d881e9b1ea
x-ms-traffictypediagnostic: BYAPR15MB2647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB264712DACB0BA653FE470D7AB3ED0@BYAPR15MB2647.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1002;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uhfDtAmpGOIegBTicfbwFQWBKLxoPEaEupAeL3lf5P1lQdOmbNWlxjh+yFQXN9BOhgJffU881P617luSo0Ji/TMO0qmAb386q8skZQdd7oH+jYMtiHv7Ilrzdn2WN25KqHQUgEmQHFJqdKdvobMiOdzZrxoeVmdNVHTyUtZiCan3CynWmbGMo5rppLDkLdGGeCpgwU2lG8qam1BthRY1/XRA/nFMhpzvkjgB5Z4/G4KnyjChDc8Iibc51oIjMscJZecrjxsoWqd+5HioJFIT4hppHzVGz72DOQNZZ04NLfd6TY5Oaz/FMVEE61pNeXFhjP5bd4jDEdWfxc+2NzVLiQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(36756003)(478600001)(2906002)(5660300002)(186003)(316002)(71200400001)(4326008)(54906003)(2616005)(4744005)(53546011)(6506007)(66476007)(6916009)(8936002)(64756008)(6486002)(76116006)(66446008)(66946007)(86362001)(66556008)(8676002)(91956017)(6512007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6Fy2i/SXA62Af5fA2zzUCdJ/YgZT9psEOuaJPEvDvMSPqip4840gz4uCiizlOqaSKhVvAHJ0PNgswwDTDL2i+FZ2M5G6RKMh753j0gw401ZuDjmm6Wgmqfh102bOriqobeOeaQBtCGI1aKs1xwFZq2dj3rTQ/neQjgq9iZ9TMsLkzo2zssPb7H5llxDZ1TRqrFDveME2LI2diUNlB1x/Cfej5YDuFI9GiljbD2qTH/DB9pIEKm0Bp85vXnLt9DmgPLY3ev/lRAwDqsDxTyrbSiN6LrPUvdLkG0Pisyz9hld7AI/Xn5I9qMm31TbD++dHFAgCoKTj5DHeJKtWF8t/Aszw6eramT0AE5B2Q6jnyA9F1Xp0zhTcbcd1PpZRxBXy5iJSzDP6a5IXhdXnehzv9W2yi311WGdNDtabPZVTrtjb9RVOVbkMq8y84J1b+1I0ANkVdMoxCxp3EvAtBqCnvu5iujCKy4LIYf2/IMtJgk/+SfhAsy6zxedsK6HNli2fjLCuCdwYSAJPkjGQU02MBB2Rel4CpKQL0zyN3wUwV/lzj9iC7Fcnkm5HE2AexLwqf4jzlBep5KtBGdIFRsfUriAGvv0QnLpIaha4smcolBlTfwBTAPTG7z0DoiVQi/9dHHXD6iOj+vVsJ7Jx8aeJqluF7vqrNxTXAEdztc7w2ZXnbf3X1ChBf484f+/W5aQ/
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7059CBC219DC6446821C027701C5711C@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4d4d21-1258-44f3-aade-08d881e9b1ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 00:19:58.4435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: asgruiEuA2cx3Y2P/geoNHzJamggN/V2FXM94Xk4JPSKtdOR2NTv+O28KsxAWJXxqYqThijZge3k0aHwfWir9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2647
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_16:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=636
 suspectscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050158
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 5, 2020, at 4:06 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
>=20
> Previously, bpf_probe_read_user_str() could potentially overcopy the
> trailing bytes after the NUL due to how do_strncpy_from_user() does the
> copy in long-sized strides. The issue has been fixed in the previous
> commit.
>=20
> This commit adds a selftest that ensures we don't regress
> bpf_probe_read_user_str() again.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>

LGTM!

Acked-by: Song Liu <songliubraving@fb.com>

[...]

