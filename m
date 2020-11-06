Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E952A8B54
	for <lists+bpf@lfdr.de>; Fri,  6 Nov 2020 01:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbgKFAQT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 Nov 2020 19:16:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53206 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732729AbgKFAQS (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 5 Nov 2020 19:16:18 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A604dCp029775;
        Thu, 5 Nov 2020 16:16:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=Twwf1bZ/gqt8fZsJXUQLmYphU/pAhqDT8z55eJCaS5s=;
 b=nbzfUTrK2H4Y3HVHWP+UrFJJLW8e1FR9A4Q/35fCzUUwr3SgNPMbF80vF4Mf/b7Hv98O
 UOtspkOQGT0bnnpuOExNg4TcqvhjKF9BKsezwxy9LhNzUXu864KDXFLYYgkFVI6kiYx1
 Pa/V5C53S43bMrkpiP+eaBd7JUczFhlhNBM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34mr9b94v8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 05 Nov 2020 16:16:02 -0800
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 5 Nov 2020 16:16:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbscs5neEBXNDNSddZTgKHp91vy6HCQsCeYw8Ju0wi0NS7CRfadte3QPusP6TGPrkd0or4dkdaYEk/y4PUuWp5rbkQ5qyzfS4sr9l4vkmiQmNlvFQIs361V0NjFzol1henHN00uYmDekl15B2xpklfCgQtPmEHqoixAPkeIjLOLf8RrBbwySD/4L2QK7vymtmPbcv/cATvW54hQCSzRpciN9eShk6NdrXcoW1kpjV8jYArDp+TeIpL6FHZ8tS/CVS2MMswGGWd/z5jrzRKib44CAO7+60aoxIpvCkcQe6A/jBk/NHjohTYkdoNkaC6NKnR/wrSAlgtCahkqVskNtIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Twwf1bZ/gqt8fZsJXUQLmYphU/pAhqDT8z55eJCaS5s=;
 b=cC1OHhyUISN/Y8pjqFj0SmpcT6PtI8oEE2mySPAz+JL1wET/Fh1y74ZRvHuDUnFdJnKGvHwROKL7nwjxmhn04ncTCriN6/TtL0XK1yForvi3VRw6J0v0yr/OUk1CWHa6cCy/Rq6ZSes8Snppm6t1LK46niCegsWxSiH5E6Erf/W1aUlpiB8+LS+s8NhbkBfrZzasy5SH05jLOd2KOJkwocZieofHdVQiCO88OGDZmyBdDCHb/RA9kkOtjSnBLLvkDjpdKWYzHqIWU+naSNDUbOEUZCyFTHEsMpmOB/aEGchLxME2LTcTxiXXLImzVhgKJzjWtzh13hoCChDh8G+LSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Twwf1bZ/gqt8fZsJXUQLmYphU/pAhqDT8z55eJCaS5s=;
 b=Vtb30AUkga7I336WPhMDi/eiey0kMt+oNIDGr8DFdvYgDgtvLDpEzc8weyIekGmmetm3iCxv/G1j5Hq607Jvawx0N92WTs/61kHhoXr5MMb0D0R9M4cuIQRmzWntR0GXjmCNW5Sx6lftdvQnxB993ZYSCEVRXD/AxqLCYM4YKZw=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB2647.namprd15.prod.outlook.com (2603:10b6:a03:153::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 00:15:58 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::7d77:205b:bbc4:4c70%6]) with mapi id 15.20.3499.030; Fri, 6 Nov 2020
 00:15:57 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Daniel Xu <dxu@dxuuu.xyz>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii.nakryiko@gmail.com" <andrii.nakryiko@gmail.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf v4 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Thread-Topic: [PATCH bpf v4 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
Thread-Index: AQHWs9C5LVaWDjXRREKJL+Ztb1AwE6m6PF2A
Date:   Fri, 6 Nov 2020 00:15:57 +0000
Message-ID: <472C44CE-2DB2-48B1-8F58-0541F877AEA7@fb.com>
References: <cover.1604620776.git.dxu@dxuuu.xyz>
 <4ff12d0c19de63e7172d25922adfb83ae7c8691f.1604620776.git.dxu@dxuuu.xyz>
In-Reply-To: <4ff12d0c19de63e7172d25922adfb83ae7c8691f.1604620776.git.dxu@dxuuu.xyz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.4)
authentication-results: dxuuu.xyz; dkim=none (message not signed)
 header.d=none;dxuuu.xyz; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:ca49]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 25cccf58-4a6b-4326-9a72-08d881e92289
x-ms-traffictypediagnostic: BYAPR15MB2647:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB26478AD63A5721CB0ED486B3B3ED0@BYAPR15MB2647.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gqVllp04ueFGNoRvE7Xh2Cl76kOqsgOTmMkyYdNj8OzDyqg3VExIuB8fyocSZEOFyJPzGkwHYpEs8NAZ+d2DPfKJvcw3eUnq4QsnR3srFNO3R0LybGpp6OPbO9aGrfFfY/iJvHRkZOIHsQIdVBNiYT1skBQ5H42YsSVQ/zT66ZZXBnwBqloYZVnE5myO9FhSlwscylb+9L/irAqkZpttwPIYb78yovAqcmZB0V/6FQeTS1OHgAg8yOqTWcKiPbyEBbuMybPmOAZDTr5CNZT7we2s0MZIH13UY8wrh/ZYAyRc2dxIcUl/9quaCLqHIL/6QvxTYL+SeNg8kCHgxZGbkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39860400002)(136003)(346002)(36756003)(478600001)(2906002)(5660300002)(186003)(316002)(71200400001)(4326008)(54906003)(2616005)(53546011)(6506007)(66476007)(6916009)(8936002)(64756008)(6486002)(76116006)(66446008)(66946007)(86362001)(66556008)(8676002)(91956017)(6512007)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: +sddDc3AC6Yd0EJVTg8FlkBo3aqQKuaQe8BHTdQeztcPgirj8XcAzqCk1pMHYkbYBZGxErZiUQyF7SocFJRjK5ob07KOAAaivSIPXetWOiOzWxVLCoRjoZ/ctgu6FOpkyIQcCsFW3MZx3LfdQTKinrEpIts3Y9OYubuTEoKbjVCXGfiGOkDM5fSzoUZUz+95PcHcPDtGziIWe3lePoOS2DLGL81cgDTSFYe2Ub3dTmP1sgJkFnoYIgWu5cocN5t07HvIZq21piXIsSRohaqHiZq6rVpwBeHcf0g97xHU5bShEYjcfmRMjcSa3esuDUCwWJbyBani8+myk30E6mKfWTY5g3Y0yq45bfXm5P5bTVUFPNur3fg4WMzooj+jQU79PtVTo9Sv2N2rCJ6rhmozTodtwHcRMA7ohrzjprMO2EPtoDeFBlfIYecDDRN06CanJWsszHUEasjJriYCwfLVM74X1+CnKXHwfjQwmf6UAEhmrk1cei9EvDIXWdLPKW2DOLQcIQEWyLp7RAEsSZuap6ykQTOeMoJZwC0IPUM4rwr3oknm+/XrULv8GIpNoT+3C2NmMvfYyeDzfctOFuV3dqa2CQdU7l4dW9JOTtxXYzWzgmSNWmmJBYFjWxBajPJceDECLlaKpyGmbgYtrW82mvj7wUXxKI39GuSX08FGVIYtz2XHGyog02Vio22wQpqD
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BBC7D29BA048AC4CA1A1F4FA615C912A@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25cccf58-4a6b-4326-9a72-08d881e92289
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 00:15:57.8522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9Lz2R8lWf8UO3o9IIhC5g2tUmspDFWXosin6vJ6X3G+Tih8gkl6Wrj1dRpxoWtQ5yhz6U9FDIiWoX+kwRguf8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2647
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-05_16:2020-11-05,2020-11-05 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=667
 suspectscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 adultscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050158
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 5, 2020, at 4:06 PM, Daniel Xu <dxu@dxuuu.xyz> wrote:
>=20
> do_strncpy_from_user() may copy some extra bytes after the NUL
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

Acked-by: Song Liu <songliubraving@fb.com>

[...]

