Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80FE437CF3
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 21:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfFFTI0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 15:08:26 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34090 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727961AbfFFTI0 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 15:08:26 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56J7ZB0016262;
        Thu, 6 Jun 2019 12:08:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=85C9p4zsuluVa4tF/7FTTB0+egDRB0eOy0gOcUdvjFo=;
 b=bheIXqApmlvDlL7H0t50rkAjI22WZCLo5nzF5i2DrnFmmGpGUXqV0nrNnvQwmzNoeudb
 7E88p6hL7+oBvB4rmFD1iPR88igV74YH6iv6bBsyDcYFRRfL2fcSX5samdtbLTNnDT8Q
 QQadyW5zyZZcSCzJYjMMl8LcB12FT1G6kKM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2sy7yar61v-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jun 2019 12:08:04 -0700
Received: from ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Jun 2019 12:08:02 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Jun 2019 12:08:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85C9p4zsuluVa4tF/7FTTB0+egDRB0eOy0gOcUdvjFo=;
 b=kJsw4bAOFr3h6KTFSnBHfr7ggXB1OXtrbJvRFMLWH4ko6CS0ThY8NvssMycKwjMplHHFQPGuNfb7stTDc/OQ9myy1bBNjyZxNsYafaZvgCMB2DL2+in48Q0KYOOTVff+s1JulGbKaFybIZE+Ak8JCuPFLcLIvRuA3Vh29wWH+us=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2657.namprd15.prod.outlook.com (20.179.138.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Thu, 6 Jun 2019 19:08:00 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::251b:ff54:1c67:4e5f]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::251b:ff54:1c67:4e5f%7]) with mapi id 15.20.1943.018; Thu, 6 Jun 2019
 19:08:00 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
CC:     Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use
 bpf_get_current_cgroup_id() helper
Thread-Topic: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use
 bpf_get_current_cgroup_id() helper
Thread-Index: AQHVHJn5xFnlIJGy00O8LdScbBruEqaO/RaA
Date:   Thu, 6 Jun 2019 19:08:00 +0000
Message-ID: <20190606190752.GA28743@tower.DHCP.thefacebook.com>
References: <20190606185911.4089151-1-guro@fb.com>
In-Reply-To: <20190606185911.4089151-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR19CA0072.namprd19.prod.outlook.com
 (2603:10b6:300:94::34) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:aba7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afd23bf9-0c5b-4cdb-47bb-08d6eab24b07
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB2657;
x-ms-traffictypediagnostic: BN8PR15MB2657:
x-microsoft-antispam-prvs: <BN8PR15MB26579313A097ECB739774AC6BE170@BN8PR15MB2657.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39860400002)(136003)(366004)(346002)(396003)(199004)(54094003)(189003)(6486002)(6436002)(86362001)(186003)(9686003)(6512007)(8936002)(25786009)(5660300002)(478600001)(6246003)(6506007)(7736002)(66946007)(229853002)(46003)(386003)(68736007)(102836004)(11346002)(71190400001)(476003)(53936002)(446003)(71200400001)(1076003)(14454004)(256004)(4744005)(2906002)(64756008)(81166006)(73956011)(6116002)(81156014)(4326008)(316002)(110136005)(33656002)(8676002)(99286004)(305945005)(2501003)(76176011)(486006)(54906003)(66556008)(66446008)(52116002)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2657;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: C7y89wBLiqkfwJBVnQbNvBbaWCql3r4ndxLz9LSdcpen/xjUrSoNGTgVayFsuN+5y0nfwzf0o8IkAlItLpKMycGw49l/O5HZtfX60LYAFz/GhOAJE752m8cgUooiuOGpkkGVskCycARFF3P2r3RSFYiv9mDSy9T8NWPISJ8lSoauxI0Um5qH6f9Dp0P3MsU4uZzW8G8TyX/qB2bOxPDAUqweHHKVopCnhUYOScBsgr5QkoQSwLgY+wSOOrCHE3ojfK7Sz/d0ws2kv4RMjANfb3AeDtYR0dwGEn4sPCyeVGEJEG260R2QGmvrkki6TJ7Y44T+VWThjEOnARm0QlYewN+Pkcp3DDt2tT5fbtHFlgS/DyI8HdOWW9dErmVSGAcnHzhUeL37Zno2ABouLG2QQEhV9htvpcE7kEAybA2HlbM=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3ABAF4E2EE5B3242850320709B05A5AF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: afd23bf9-0c5b-4cdb-47bb-08d6eab24b07
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 19:08:00.7288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2657
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=806 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060127
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 06, 2019 at 11:59:11AM -0700, Roman Gushchin wrote:
> Currently bpf_get_current_cgroup_id() is not supported for
> CGROUP_SKB programs. An attempt to load such a program generates an
> error like this:
>     libbpf:
>     0: (b7) r6 =3D 0
>     ...
>     8: (63) *(u32 *)(r10 -28) =3D r6
>     9: (85) call bpf_get_current_cgroup_id#80
>     unknown func bpf_get_current_cgroup_id#80
>=20
> There are no particular reasons for denying it,
> and we have some use cases where it might be useful.

Ah, sorry, it's not so simple, as we probably need to take
the cgroup pointer from the socket, not from current.

So the implementation of the helper should be different
for this type of programs.

So I wonder if it's better to introduce a new helper
bpf_get_sock_cgroup_id()?

What do you think?

Thanks!
