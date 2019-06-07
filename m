Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED7538207
	for <lists+bpf@lfdr.de>; Fri,  7 Jun 2019 02:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfFGAKB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 20:10:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41376 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726343AbfFGAKB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 20:10:01 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5708n8T003840;
        Thu, 6 Jun 2019 17:09:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=D8z6kDvituKzMrSIoAkpd1Isn/lr7fvLl5ffOvBqD1A=;
 b=XR1gdxQzMJ0BJRhbZLKr5R1n6qPbKo1qXmK9ixa72vO1EgUv0+85E92NjCBVnulBbK0X
 wOGzn1ey38/Zxm8gyweWgsuhua145ddj2UU/GsPKMzBBVEhl0QsaXcP7H1YdHXQKKIDD
 jBK9wfUUf3HBOMbrLzA2x0v435u6Ask8N1c= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2sy072u0bj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Jun 2019 17:09:46 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-hub04.TheFacebook.com (2620:10d:c081:35::128) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 6 Jun 2019 17:09:45 -0700
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Jun 2019 17:09:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8z6kDvituKzMrSIoAkpd1Isn/lr7fvLl5ffOvBqD1A=;
 b=NMkr6aIHbQu8oOJcQtSYXgc2xwbmjG8qLUfwJYYZWetPJ6v9hEgj6i0GL+B8wbd3t1eM+XnuNgTM+b4YoifHnRaSbDVbjOGae6RRG67WDqC8Zhx39x9FqPTCsRyyELez8uWvxS0QlLdHyyi6zbQkOZU4AL8BLgITWtvSsBdDBZE=
Received: from DM6PR15MB2635.namprd15.prod.outlook.com (20.179.161.152) by
 DM6PR15MB3339.namprd15.prod.outlook.com (20.179.50.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1943.22; Fri, 7 Jun 2019 00:09:43 +0000
Received: from DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::5022:93e0:dd8b:b1a1]) by DM6PR15MB2635.namprd15.prod.outlook.com
 ([fe80::5022:93e0:dd8b:b1a1%7]) with mapi id 15.20.1965.011; Fri, 7 Jun 2019
 00:09:43 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use
 bpf_skb_cgroup_id() helper
Thread-Topic: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use
 bpf_skb_cgroup_id() helper
Thread-Index: AQHVHKa6xHw8ltBwiEqcWIquD5GBU6aPTrAAgAACnAA=
Date:   Fri, 7 Jun 2019 00:09:43 +0000
Message-ID: <20190607000937.GA13090@tower.DHCP.thefacebook.com>
References: <20190606203012.130071-1-guro@fb.com>
 <a9a8d1ec-f0ce-6cde-31f1-9003c6b2c64a@iogearbox.net>
In-Reply-To: <a9a8d1ec-f0ce-6cde-31f1-9003c6b2c64a@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::15) To DM6PR15MB2635.namprd15.prod.outlook.com
 (2603:10b6:5:1a6::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::1:6fb0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0010b288-d406-45de-694f-08d6eadc715b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM6PR15MB3339;
x-ms-traffictypediagnostic: DM6PR15MB3339:
x-microsoft-antispam-prvs: <DM6PR15MB3339E2ECB8F93143E08BE88CBE100@DM6PR15MB3339.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(136003)(366004)(39860400002)(376002)(346002)(199004)(189003)(476003)(305945005)(486006)(86362001)(68736007)(6916009)(33656002)(7736002)(4744005)(53936002)(478600001)(102836004)(4326008)(6506007)(53546011)(386003)(2906002)(5660300002)(71190400001)(71200400001)(14454004)(6116002)(76176011)(52116002)(446003)(11346002)(6246003)(81156014)(81166006)(186003)(8936002)(25786009)(1076003)(9686003)(6512007)(8676002)(256004)(54906003)(66476007)(66946007)(66446008)(64756008)(66556008)(73956011)(6486002)(99286004)(6436002)(229853002)(316002)(46003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB3339;H:DM6PR15MB2635.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ghxUHXBocrI8MWSACNnYTSVIOxzydbtfPnH5vvcS1TsllqfebV/7uuYaQKe87eJAQwqFSNDP0DeB2gCYhIayVhD6/Z+QT8/H+ajIJgcBAuoRs7nIilD48ue9SG6a2eawjfdRlRuKxDtfsjMark9/7mKlSYRvx54EbsNTXpImqOxhL/c7TGtbFnXZWqHlltO8w7mvu+u+SZzY3LwRfzGc1Kf/p0nDQf7feyC9dsZvpwL9atQjTHSOzAQXai83QWKqz8dh0tVSJcxY/+JM3rX0QSXHE5aFsproocSGVStRkvE2sdl9aSXLtOShWVBROlRVQiCge+drwMEKMmUHcf9zzCACXJHF59HtNPLKPG7iaL5lCuG8o+PCynZ0Tl2bTvsvNkVtt8bsWOQzoEaRW5vYU6Sxv4SPUgrmZr/Avf05wU8=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0025DAEFE979994581EA351CEBA3494E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0010b288-d406-45de-694f-08d6eadc715b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 00:09:43.7683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3339
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_16:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=935 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906070000
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jun 07, 2019 at 02:00:20AM +0200, Daniel Borkmann wrote:
> On 06/06/2019 10:30 PM, Roman Gushchin wrote:
> > Currently bpf_skb_cgroup_id() is not supported for CGROUP_SKB
> > programs. An attempt to load such a program generates an error
> > like this:
> >=20
> >     libbpf:
> >     0: (b7) r6 =3D 0
> >     ...
> >     9: (85) call bpf_skb_cgroup_id#79
> >     unknown func bpf_skb_cgroup_id#79
> >=20
> > There are no particular reasons for denying it, and we have some
> > use cases where it might be useful.
> >=20
> > So let's add it to the list of allowed helpers.
> >=20
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: Alexei Starovoitov <ast@kernel.org>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
>=20
> Applied, thanks!

Thank you, Daniel!
