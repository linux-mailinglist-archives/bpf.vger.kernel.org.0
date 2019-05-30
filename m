Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E98243029F
	for <lists+bpf@lfdr.de>; Thu, 30 May 2019 21:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbfE3TKb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 May 2019 15:10:31 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55172 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbfE3TKa (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 30 May 2019 15:10:30 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UJ58h0019479;
        Thu, 30 May 2019 12:10:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=VRen7c/KD+OSxY9FEuTOgvlcbFyWrmNDZVQHLjK+txg=;
 b=bPHEfLP2MC4mBc8BiOKYfxLdB0G4YQNYvJIetaj1mDD05s/uB0mke7gy5XUpjH3F78o9
 FpyHAWib3uYgYSMLeHh4otjeVmT2/0YkgzU6Cyig9tFTYGv6ce3XZqke0erqbiI3mJiu
 sF8ntotUNoJChSApc9FRWVSUuNViwx64cBI= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2stjfc8mja-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 12:10:09 -0700
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 30 May 2019 12:09:36 -0700
Received: from prn-hub01.TheFacebook.com (2620:10d:c081:35::125) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 30 May 2019 12:09:36 -0700
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 30 May 2019 12:09:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRen7c/KD+OSxY9FEuTOgvlcbFyWrmNDZVQHLjK+txg=;
 b=gpl1vcPmITNPgOweTXA7XJ0IKG+OEvXlwgDJ7YXvglHYZF8j3NPEW3/x/e4LIJF0UcfKHpZA2Z1wuwo4Kc4leRz0jXEdRRygLbxctQnqa/0batRjVU4kJ5LKm5ju7Zv3lO3k39lm2vnEyGgUsU/OziV6P5/I8o8klj7d3qgwI44=
Received: from BYAPR15MB2631.namprd15.prod.outlook.com (20.179.156.24) by
 BYAPR15MB2504.namprd15.prod.outlook.com (52.135.199.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.21; Thu, 30 May 2019 19:09:32 +0000
Received: from BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a]) by BYAPR15MB2631.namprd15.prod.outlook.com
 ([fe80::d4f6:b485:69ee:fd9a%7]) with mapi id 15.20.1922.021; Thu, 30 May 2019
 19:09:32 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Song Liu <liu.song.a23@gmail.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Kernel Team <Kernel-team@fb.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next 5/5] bpf: move memory size checks to
 bpf_map_charge_init()
Thread-Topic: [PATCH bpf-next 5/5] bpf: move memory size checks to
 bpf_map_charge_init()
Thread-Index: AQHVFoO9Zt82W3qTWkWW4/aoFdXajqaEBd6AgAADg4A=
Date:   Thu, 30 May 2019 19:09:32 +0000
Message-ID: <20190530190928.GD4855@tower.DHCP.thefacebook.com>
References: <20190530010359.2499670-1-guro@fb.com>
 <20190530010359.2499670-6-guro@fb.com>
 <CAPhsuW5QDXBRAbm=80EoWgYoB-=tvxnTrsbfuR2bCowDsh8xvA@mail.gmail.com>
In-Reply-To: <CAPhsuW5QDXBRAbm=80EoWgYoB-=tvxnTrsbfuR2bCowDsh8xvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0040.namprd07.prod.outlook.com
 (2603:10b6:a03:60::17) To BYAPR15MB2631.namprd15.prod.outlook.com
 (2603:10b6:a03:152::24)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::6fcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31d99c94-71e6-4484-1a94-08d6e53258b2
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR15MB2504;
x-ms-traffictypediagnostic: BYAPR15MB2504:
x-microsoft-antispam-prvs: <BYAPR15MB25040861DEFD65BE95E2D230BE180@BYAPR15MB2504.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(39860400002)(136003)(346002)(376002)(189003)(199004)(102836004)(478600001)(7736002)(52116002)(316002)(5660300002)(99286004)(66946007)(66446008)(14454004)(66476007)(6916009)(54906003)(1076003)(305945005)(6506007)(53546011)(8936002)(386003)(8676002)(486006)(71200400001)(71190400001)(86362001)(68736007)(4744005)(6116002)(64756008)(76176011)(81156014)(81166006)(73956011)(66556008)(6436002)(25786009)(6246003)(2906002)(4326008)(11346002)(229853002)(186003)(6512007)(46003)(6486002)(53936002)(33656002)(256004)(9686003)(446003)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR15MB2504;H:BYAPR15MB2631.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: BvMWdKYmkwkzRxQjZnFOwZ6lzhSIGvoGA8JPkV9zOrOZ4bLlWcizI4+/7jdV2iqtDd6BbNGcndpybVIJjw9dcDsoPAFww6aDmE9cR3YiEG/rHrM2aK21lKFN/Iin5DIne1ssuMG2DDjtt7VBTUCgYc3j8gaeapVOPoXRAkrvQ5jlQRB9ygMlYCxv0j1bjUUMe94VakacMTZnq48sDuOTHDikOmdOdBkO1DMPMUkATgQ/42CcEWOA4FO9ewklcffyLqszKWgVtx3NpXyOsUCZvjq0gK90TL4H/vb4SYow3X7R9huVqrfPZMw9KW0Pa4+w2lwOo3yP41zg2qMHVGjaFOZzeQDRFV91Wf66Vb5rl+SZb9WWKhwqYjmS3xYfTfQ4H5BlezpyNac9jWnNui6t2Rz3emimr7qsp4fImidyI4k=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CC01526B819E214094F97395869D81AF@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d99c94-71e6-4484-1a94-08d6e53258b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 19:09:32.1794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2504
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=974 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905300134
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 30, 2019 at 11:56:55AM -0700, Song Liu wrote:
> On Wed, May 29, 2019 at 6:05 PM Roman Gushchin <guro@fb.com> wrote:
> >
> > Most bpf map types doing similar checks and bytes to pages
> > conversion during memory allocation and charging.
> >
> > Let's unify these checks by moving them into bpf_map_charge_init().
> >
> > Signed-off-by: Roman Gushchin <guro@fb.com>
>=20
> Nice, I was thinking about similar issues while reading patches
> 3/5 and 4/5. I really like this simplification.
>=20
> Acked-by: Song Liu <songliubraving@fb.com>

Thank you for the review, Song!
