Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE4F11D4B1
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2019 18:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbfLLR6A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Dec 2019 12:58:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:7890 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730033AbfLLR57 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Dec 2019 12:57:59 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id xBCHv0cq014028;
        Thu, 12 Dec 2019 09:57:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5oNJ1TmIGwqLOZXznOQLF0UahCOBW7CvnGAfsYAFhUc=;
 b=Z08WbcsCKU9GTZ9eF+DzmrCcj7+7/KQvUSHQOKSJUPjnxgM882wY6NC5+TVzeUbyQK/3
 +dprRD0tM4vvP0jptYt/5GS5HDoamqAd2awMdB0BKro9gshF8KpHGVjHIGIkbzxgGy+o
 /Mezerhf07yRzM3LdAl/YRK1CwKzXYHxJn8= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0089730.ppops.net with ESMTP id 2wuke1j1b8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 12 Dec 2019 09:57:47 -0800
Received: from prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 12 Dec 2019 09:57:46 -0800
Received: from prn-hub04.TheFacebook.com (2620:10d:c081:35::128) by
 prn-mbx07.TheFacebook.com (2620:10d:c081:6::21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 12 Dec 2019 09:57:46 -0800
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 12 Dec 2019 09:57:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E/yFVtSeNaJ9uJoiCoBb96xkMzwqcmNgzUmh06EC2nes4fo8suzDG6Lfreqr2KwRTgbMsiefYCTItD+tmDTIMc/Ov75VvHzNzOj1kxhyk2R8Zt+Gu6PVzyFL1M0Wnn+N8H6MGZBHP/EhtjXC1PFwXSa4Wzc78fuTEEnME67Q53KICKrw3n6G2JPS2FE1tJ/PhM6x1mJeMdiaadWhj6BbmzvmCkYBz1BjFdvukVi0gEG6/dAqCUMLtyjZQyRKe4aFPPm7Sosy0PdZ/lxz2U4t1z+IDhSQdt9WzvLlDxpWFQIkfHXV+MsOo8jlqj0mLKR6GohusSVmvWdMwzaeCzicuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oNJ1TmIGwqLOZXznOQLF0UahCOBW7CvnGAfsYAFhUc=;
 b=aK/hIF+amObSxKO3uKozv7oddaiRGMbFZ5asn7eFVAcxxZBpJ6cLa79eYIHJ8CeUHooTgg2BNxQwP/pjO2z6OShkNi9qyCJYHFMTnJG7WsbVcVOJ2WekIyZv/TAf55K7jj0OK1Bfqj2cpxvh8Si24wombQLWeu7zqnWfkxVDX0jbYcKYsPAeMyH58yKeao0ak+tG3nY3oJOhs/1HqYMe3fvPJzPE2Pt5ePNU4ZdBnC1Fwsem0FdGPI0GYFuv92NVjVd/njfLoKusnJc9ign9h0AST0XO7OBYKZa18N5LLJ9kxcTpgxHa8QyztHiDddXUKYI23bLvxesOuq3E3djpSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5oNJ1TmIGwqLOZXznOQLF0UahCOBW7CvnGAfsYAFhUc=;
 b=HW+tod8OTBaHZ8e+mG9BD9cmxszudu8bfGhA9KuD2beaCKdCkhI9P/OVw6b6QJrpReaivun1PHxCFQF8mAG5nPWFicLCehKIj4tBI10otrbPG2A7KFDs/9mcl6bjvuCVF2X29ebFJNFmXTVvlwCqk80soG3VyRINzJrtQ7vh6GE=
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (20.179.21.76) by
 MN2PR15MB3245.namprd15.prod.outlook.com (20.179.23.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Thu, 12 Dec 2019 17:57:44 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::6d1e:f2f7:d36:a42f%4]) with mapi id 15.20.2538.017; Thu, 12 Dec 2019
 17:57:44 +0000
From:   Martin Lau <kafai@fb.com>
To:     Andrey Ignatov <rdna@fb.com>
CC:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [Potential Spoof] [PATCH bpf-next 2/5] bpf: Remove unused
 new_flags in hierarchy_allows_attach()
Thread-Topic: [Potential Spoof] [PATCH bpf-next 2/5] bpf: Remove unused
 new_flags in hierarchy_allows_attach()
Thread-Index: AQHVr8uFMD3Hq0Oq6E2/LVwO21LNGae2y7MA
Date:   Thu, 12 Dec 2019 17:57:44 +0000
Message-ID: <20191212175740.lvuuy4ybv34wecwh@kafai-mbp>
References: <cover.1576031228.git.rdna@fb.com>
 <9af0bcb75cadcace11e6add2fabe27ed4ab3dec5.1576031228.git.rdna@fb.com>
In-Reply-To: <9af0bcb75cadcace11e6add2fabe27ed4ab3dec5.1576031228.git.rdna@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO2PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:104:7::24) To MN2PR15MB3213.namprd15.prod.outlook.com
 (2603:10b6:208:3d::12)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::97ef]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18e272a1-cecc-4ff2-882a-08d77f2cca21
x-ms-traffictypediagnostic: MN2PR15MB3245:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR15MB3245D4DC7EBB0432DFB620E9D5550@MN2PR15MB3245.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0249EFCB0B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(396003)(136003)(376002)(346002)(39860400002)(366004)(189003)(199004)(81166006)(8936002)(6506007)(8676002)(4326008)(5660300002)(86362001)(1076003)(316002)(6636002)(558084003)(81156014)(186003)(2906002)(52116002)(33716001)(66946007)(9686003)(6486002)(6512007)(478600001)(71200400001)(6862004)(64756008)(66556008)(66476007)(66446008)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:MN2PR15MB3245;H:MN2PR15MB3213.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AeqggytaWGjdc/Q7Hg091XVrZWPlvIw439WpNDPAyzngY/4SAi7qEMYGQqGrOoE9zi1KacUPlWeRdIzEkpnfGh8QeXh8039Pwdsxe66yfu091dXC9ZdisFyTPH5tZlA+YHDE8wTL5Ms6L3Ffp3RwWkHhymxZSL3Dy9p2/lfKgXGKIy6LxM0Czs9+PmRC98/N3nKel3OsmgqknE/MsxVEFMVzUzbrtJwsVKzomN18pcB3osZis4aVybbohZipkTZO16A48BIEKwxYb2HOpPYbmWW3JtJfs8p6zDBJmCTBV+GrmzuKuGrb3tB3iK1tfxAEqe4+FF3EbcTkIoPqsHxSOmr77fKiYHiLiluoL0vpjJr90Kl3138iaNhXU48Vt1jwxrvBpcwI2hqNuPIAYtAfV0kXvqs/l+3Qr+Fz7/jpoi7wF+mBAmvSfg+Jjz8TWqtW
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E0C1CDBE5E45D6479A86ABF6D0014977@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e272a1-cecc-4ff2-882a-08d77f2cca21
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 17:57:44.4427
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XRW9w85uqB08FVX4vxr8jf0IUWmClkC72jqkpx9zool9C+0tgz6zJSOEGIO61nMJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3245
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_05:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 suspectscore=0 adultscore=0 clxscore=1015 spamscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=309
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912120140
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Dec 10, 2019 at 06:33:28PM -0800, Andrey Ignatov wrote:
> new_flags is unused, remove it.
Acked-by: Martin KaFai Lau <kafai@fb.com>
