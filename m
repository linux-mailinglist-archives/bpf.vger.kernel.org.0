Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 501E41E891A
	for <lists+bpf@lfdr.de>; Fri, 29 May 2020 22:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgE2Upe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 May 2020 16:45:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54026 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbgE2Upe (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 29 May 2020 16:45:34 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04TKjBlO027938;
        Fri, 29 May 2020 13:45:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=CIo4RbEFg+K3lM3011J8vN4C9rLM243R6jHPz6MYVqw=;
 b=dbzNVnJwYOuzkdLhjkCbtNM2AA9KHQkoMyMfS9PiWV1avI8x6Rc+Dw+DPFK3VdY8Vs5W
 Xgc5IPoeJTaKtWrFchdVcoT4PXaGHc4c7WmjaUQ28R/bgE/9KZRxdWWVLYGkVSWr735Q
 aMN1AAp8Vp4M6plewWX0OPUtME+jvmuLsXc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 31ag6rx6xx-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 29 May 2020 13:45:17 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 29 May 2020 13:45:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMlt40Oztz6iwUzoUwYcQyjVUp1UR4WNIuQkNjwFrosXt+94zx1Ljv0heJP/n8+yJjw6YSauw5OFp51vD2TDqV8Ak7D1ufpm0k8YmNt7yCJq5X2P27ChMj+PeqKrRoCciwi/vDy91KA+ap3HLWLH89eSAU+/maDg63SvAa1/79km3UfeAR0c3Xm3UHDGpUaMNiSlvNyGJBxcK5fzTmJHX8hi2f1IbLbEXlW8sskOKKmdkfzpTQfZqvjEcOtGpXznzuSz4XxAm4A0+1Hzhbf4cGabGXRKoCBVIUYmgRx7WIeeZHT1YfCu4ovehmXFDwJyyJf32MOLEd4Ykys8dRagOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIo4RbEFg+K3lM3011J8vN4C9rLM243R6jHPz6MYVqw=;
 b=G/T1048PIZLSD3CflvsPGoXSOC83xmyHaTlbvvMvgiWMwcoein99StRta0IykaKlW6QYcf6/S/F1FpU2Am9BW/TlajZpRopvptl8pdVPfWP7s9hSNCK5XTjbjQjt02i3aYMbPyZJh6X6yo4RIMWQJSS8e91xJVhBfncttZSEGHrktq4wH9bLD0gujJoaCGgRgYFBMutQJuZLuKeIAZJs8MCvxqitdyK+HDWJIlxIAAei5Twpz1c24OE6NMzgXq6WU7HEEjbZRoFqLyoXRqxXHklwv+f9QaBdoZuaG3UR0JTO5/zgzVOv8rn3Pdb6HoGsB+NCrFrTrYnLkbnKbP2KXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIo4RbEFg+K3lM3011J8vN4C9rLM243R6jHPz6MYVqw=;
 b=Ya/v66kmLQqrv7CC7TLmG3PPu4Df+BGl6MBJVj4NAFaB1H4BCYspIgDkcEyTN4fP/syibvddo9dBiu8/GStUYBoDoEDxsmojFn9kB2YbRUUnJMy2TdTZoXQS3gtsryPXHJXhoxxObjL4DCNxfHIUyzrMn/9lWpT8BcKqOM7VMdw=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2631.namprd15.prod.outlook.com (2603:10b6:a03:150::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Fri, 29 May
 2020 20:45:14 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::bdf1:da56:867d:f8a2%7]) with mapi id 15.20.3045.018; Fri, 29 May 2020
 20:45:13 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Yonghong Song <yhs@fb.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        "Daniel Borkmann" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH bpf-next] bpf: use strncpy_from_unsafe_strict() in
 bpf_seq_printf() helper
Thread-Topic: [PATCH bpf-next] bpf: use strncpy_from_unsafe_strict() in
 bpf_seq_printf() helper
Thread-Index: AQHWNVLlIMJWW1cfmkKNnhkJvGU9Yqi/iXSA
Date:   Fri, 29 May 2020 20:45:13 +0000
Message-ID: <DD249D2B-7F03-43A2-99D2-002D1CA742C7@fb.com>
References: <20200529004810.3352219-1-yhs@fb.com>
In-Reply-To: <20200529004810.3352219-1-yhs@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.80.23.2.2)
x-originating-ip: [2620:10d:c090:400::5:5a37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e326900-bcd3-4ea8-a725-08d804112ffb
x-ms-traffictypediagnostic: BYAPR15MB2631:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB2631936F30C0DACAE5931C6DB38F0@BYAPR15MB2631.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 04180B6720
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mautzkIEjBNal6/bqvTdAFuUuCT/Q4tCd4X+xrPgs739KiqSzcteEMMgPk9TONTpQuRWYIl+aVtpcz2FUpCMiZaWDAUOgwSGcsvj7W0URJnTeY2S7XXjaFwodKJ8A8p496CL3eKnq995cJnfNreNy10SYvOG/T+y2JekjYv5dtZNZ3e4rtQbtYwccT5kqktcRgSXS9tCVeDDeXjUOBCo1wt+Mxha/OAEQI91AkZ1yC8oPR0Vp2z88fGD9u9mWq0pbg2zGrgnH0t0scPZVEw8a7nudyZjwxQnyu5ELIYIjl40E0eyfqTZYqbIiTfHjAVrAYtteoZXUwCMbikxVF06NduvuSBcBsxq0ojdjcYoSxuofz+AjFpns63+YLd2Tx44TBHkUkPcK9XgCoVJd6PVgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(136003)(376002)(346002)(396003)(366004)(2616005)(316002)(66946007)(76116006)(8936002)(2906002)(8676002)(6486002)(478600001)(966005)(33656002)(6512007)(71200400001)(66446008)(186003)(5660300002)(86362001)(66556008)(37006003)(53546011)(6506007)(36756003)(6636002)(6862004)(66476007)(4326008)(64756008)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5csAGBwDrnujEWME9M4FE9Th9HO4PgFaCpnZOtGGuVAgWlucAFjnOC1xL+08olzY6oZkagXj0uljWDGbcaa3+8ZnGqcU7Q07qoBN0sb1bq42JyfnsVsxZfAizeK2Zq+Sqnk4YEZLw4oDG9DaVoHPsQ9JkvutKJLak3zRzCUD30J1hmz6aCsmUagqcAdtMWgh98K/AZd5Y/C5EjgZQdnMsznEj8GSpsLFz3utNIoiEYyedMorF4F2NsSY5PyLZnxhX/iwFbcyyxQi1MOrSLqKe3HnZ5lycdy4HZCV9ZuUakG83eQVF3jWjkDj8CkUF7mZKS2E+feq+zEm61xzjv49gJSYbRiqSisdexa2MMlpi5bw39NrnkeZBxMME4VMOtUygRIDHE08TetmLK80XEmNealLB/1r0JpJ6ZkT56Tj9wvBAckjgdV8guuM8adp8Q+6tBXv09pjJ1BliAngAzaaVRmPmFU1b6UgpisiBx4ompeHsZYoXYkqkv3QfUcdbjBOHiuVVY7pgcWKZwQeYCHvaw==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4A063E82CA50AA45917D19C8BA624872@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e326900-bcd3-4ea8-a725-08d804112ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2020 20:45:13.7732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aD3ERsmPvbPTOxWyg9KyJecbiR0frTak3vcdEwX6xPe+gQhgwYk9l90gVoUuc0l0WOhatu4CNEMpjZ8nuzbcew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2631
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-29_10:2020-05-28,2020-05-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0
 cotscore=-2147483648 clxscore=1011 impostorscore=0 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290152
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On May 28, 2020, at 5:48 PM, Yonghong Song <yhs@fb.com> wrote:
>=20
> In bpf_seq_printf() helper, when user specified a "%s" in the
> format string, strncpy_from_unsafe() is used to read the actual string
> to a buffer. The string could be a format string or a string in
> the kernel data structure. It is really unlikely that the string
> will reside in the user memory.
>=20
> This is different from Commit b2a5212fb634 ("bpf: Restrict bpf_trace_prin=
tk()'s %s
> usage and add %pks, %pus specifier") which still used
> strncpy_from_unsafe() for "%s" to preserve the old behavior.
>=20
> If in the future, bpf_seq_printf() indeed needs to read user
> memory, we can implement "%pus" format string.
>=20
> Based on discussion in [1], if the intent is to read kernel memory,
> strncpy_from_unsafe_strict() should be used. So this patch
> changed to use strncpy_from_unsafe_strict().
>=20
> [1]: https://lore.kernel.org/bpf/20200521152301.2587579-1-hch@lst.de/T/
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Yonghong Song <yhs@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>

I guess we should add:

Fixes: 492e639f0c22 ("bpf: Add bpf_seq_printf and bpf_seq_write helpers")=
