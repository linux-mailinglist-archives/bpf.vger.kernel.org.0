Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3EB37DA6
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 21:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727731AbfFFTxt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 15:53:49 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58728 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727047AbfFFTxt (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 15:53:49 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x56Jn8lV017149;
        Thu, 6 Jun 2019 12:53:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=mHkPmKD/FxUShckoCuTSy5fmE4KzeRaEM1SI9dqQF9A=;
 b=DvbzhHnVaPkyARPutuVjxcuGBI9Th+vmigZN1jCxR94Knx/LuYQl1StNgnxq0Ips0a6c
 cafnEMn7PTCkOGmdEn+n8tOHYf7D5uvSFfhbGN7NYPnxB4IUlubQaoNQuScNLpOZclV3
 pfIMg7sPkFiswDmVHCzqwSMLcISgwaKVgac= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 2sy71g0m7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jun 2019 12:53:28 -0700
Received: from ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) by
 ash-exhub103.TheFacebook.com (2620:10d:c0a8:82::c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Jun 2019 12:53:27 -0700
Received: from ash-exhub202.TheFacebook.com (2620:10d:c0a8:83::6) by
 ash-exopmbx101.TheFacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Jun 2019 12:53:27 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Jun 2019 12:53:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHkPmKD/FxUShckoCuTSy5fmE4KzeRaEM1SI9dqQF9A=;
 b=iPYwgz64sZ5U1Aq597Cz8GzHr2I6InFoB3SsKsbVDyga5B0xFP1RG0wRey8eqgrMlhYex9Jq53JiHO0WkuP6IJOG22kwtkGU3nmJ4guDPy4lbc9e/kgtfNUps7S+PDLrNUaXP5yRIt0g3e9SPcaDC7w/OEVM9f7SZIH0tS/DWT8=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3091.namprd15.prod.outlook.com (20.178.221.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 19:53:25 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::251b:ff54:1c67:4e5f]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::251b:ff54:1c67:4e5f%7]) with mapi id 15.20.1943.018; Thu, 6 Jun 2019
 19:53:25 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Alexei Starovoitov <ast@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use
 bpf_get_current_cgroup_id() helper
Thread-Topic: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use
 bpf_get_current_cgroup_id() helper
Thread-Index: AQHVHJn5xFnlIJGy00O8LdScbBruEqaOh76AgAB+MYCAAAPXgA==
Date:   Thu, 6 Jun 2019 19:53:25 +0000
Message-ID: <20190606195317.GA22965@tower.DHCP.thefacebook.com>
References: <20190606185911.4089151-1-guro@fb.com>
 <20190606190752.GA28743@tower.DHCP.thefacebook.com>
 <a604b9eb-4e39-c4ec-0868-bac360bc2fb4@iogearbox.net>
In-Reply-To: <a604b9eb-4e39-c4ec-0868-bac360bc2fb4@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR1601CA0003.namprd16.prod.outlook.com
 (2603:10b6:300:da::13) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::d13]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9d8d0dca-6e25-491e-8516-08d6eab8a2ed
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB3091;
x-ms-traffictypediagnostic: BN8PR15MB3091:
x-microsoft-antispam-prvs: <BN8PR15MB30912D0C32B8E5B6F0C5EF99BE170@BN8PR15MB3091.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(39860400002)(136003)(346002)(396003)(54094003)(199004)(189003)(102836004)(33656002)(9686003)(6506007)(386003)(53546011)(6512007)(478600001)(73956011)(53936002)(66946007)(66476007)(66556008)(64756008)(66446008)(6246003)(14454004)(4326008)(7736002)(305945005)(6486002)(6436002)(25786009)(81156014)(81166006)(8676002)(8936002)(76176011)(68736007)(52116002)(229853002)(54906003)(99286004)(86362001)(2906002)(446003)(256004)(11346002)(186003)(486006)(476003)(46003)(1076003)(6916009)(5660300002)(316002)(71200400001)(71190400001)(6116002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3091;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7aVdQhVrbLJWhidndTt7yvPiOqLspKeumR8b9TjJvP1r+qMlm2gLHj6/FY0L1vRK6wi/+CdVzTR1l089e5FeP/jL1z44bA8vQWPJ8Mh3ABqm39ePg/ROCATjjZg6fg0TrTtcYqVxOLvoGz1nvMxbtJ+IssZfKdrTLcqsXMRsh0tQ0xJ/OpeihR8qIH4uwS6Q/e4mSU8SCo85+9GK/yL3Gdlayl5/f7qKu5N8554N2aXZNY6GSRs6qSZ1CxoykELU+/R5eZEM3pppgzeaizZcAUCCWl5TVJKKm/lIh4kdv8LH1mKXJU9KHALWMNs/3AmMKzZmXe370YrjWjzpdbZJHhrA0fo7H39qS839NxJZEcTLjcVNKasYwb9qHKhG3oEwhG1ewZUq0nVpi/iIlDHaMaAghd24QCp3DhUEcwO8ahI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ADAE58DE5AB08F4982D94507975F0950@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8d0dca-6e25-491e-8516-08d6eab8a2ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 19:53:25.1039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3091
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=722 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060133
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 06, 2019 at 09:39:35PM +0200, Daniel Borkmann wrote:
> On 06/06/2019 09:08 PM, Roman Gushchin wrote:
> > On Thu, Jun 06, 2019 at 11:59:11AM -0700, Roman Gushchin wrote:
> >> Currently bpf_get_current_cgroup_id() is not supported for
> >> CGROUP_SKB programs. An attempt to load such a program generates an
> >> error like this:
> >>     libbpf:
> >>     0: (b7) r6 =3D 0
> >>     ...
> >>     8: (63) *(u32 *)(r10 -28) =3D r6
> >>     9: (85) call bpf_get_current_cgroup_id#80
> >>     unknown func bpf_get_current_cgroup_id#80
> >>
> >> There are no particular reasons for denying it,
> >> and we have some use cases where it might be useful.
> >=20
> > Ah, sorry, it's not so simple, as we probably need to take
> > the cgroup pointer from the socket, not from current.
> >=20
> > So the implementation of the helper should be different
> > for this type of programs.
> >=20
> > So I wonder if it's better to introduce a new helper
> > bpf_get_sock_cgroup_id()?
> >=20
> > What do you think?
>=20
> We do have bpf_skb_cgroup_id(), did you give that a try?

It also isn't supported for CGROUP_SKB, but other than that looks
exactly what I need.

Thank you for pointing at it!
