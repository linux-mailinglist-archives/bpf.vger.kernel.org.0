Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D834B37FEC
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 23:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbfFFVv6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 17:51:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48286 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727269AbfFFVv6 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jun 2019 17:51:58 -0400
Received: from pps.filterd (m0001255.ppops.net [127.0.0.1])
        by mx0b-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x56LlQDd028602;
        Thu, 6 Jun 2019 14:51:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=xxknVTU3UTjKaDI8s6FeQBp/Xa/lv8GP5Ay5mb74Kio=;
 b=Dw7p/ryc8yEG6fU+ISFZNcosT0xg5aHRMVIQsxBnMamR6jSWMCTUciZ+gxvx50gnAQKf
 idCY4Q0FeZv1MhLv3H38cKvKYtp314t2mklHFzMyAVRYSg66QsB5sJZBecfugsP6ra1u
 TxheCM1x4WoYk1RwMrhfzEQ09rGzJwbvLwo= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0b-00082601.pphosted.com with ESMTP id 2sy2kpa3ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 06 Jun 2019 14:51:35 -0700
Received: from prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) by
 prn-hub05.TheFacebook.com (2620:10d:c081:35::129) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 6 Jun 2019 14:51:34 -0700
Received: from prn-hub02.TheFacebook.com (2620:10d:c081:35::126) by
 prn-mbx08.TheFacebook.com (2620:10d:c081:6::22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Thu, 6 Jun 2019 14:51:34 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Jun 2019 14:51:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xxknVTU3UTjKaDI8s6FeQBp/Xa/lv8GP5Ay5mb74Kio=;
 b=mVx3qobzTCW1L01YzwArkiv452kPGpFTtR+qfZ8GuSrSN9FwbtRwY7pYE6FHi7R9/ytOCjSTb772WNSUg6ViNd/AwBWfRm9NBxqMjYNs79iYyVxmUYhY7MYcXkMR+QvprQWoZBLJuaCxIalGfbFKLvV02mVAhqEjzGua5t9B+Js=
Received: from MWHPR15MB1790.namprd15.prod.outlook.com (10.174.97.138) by
 MWHPR15MB1677.namprd15.prod.outlook.com (10.175.135.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.12; Thu, 6 Jun 2019 21:51:32 +0000
Received: from MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::6590:7f75:5516:3871]) by MWHPR15MB1790.namprd15.prod.outlook.com
 ([fe80::6590:7f75:5516:3871%3]) with mapi id 15.20.1943.023; Thu, 6 Jun 2019
 21:51:32 +0000
From:   Martin Lau <kafai@fb.com>
To:     Roman Gushchin <guro@fb.com>
CC:     Daniel Borkmann <daniel@iogearbox.net>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use
 bpf_skb_cgroup_id() helper
Thread-Topic: [PATCH bpf-next] bpf: allow CGROUP_SKB programs to use
 bpf_skb_cgroup_id() helper
Thread-Index: AQHVHKa+nZzu1MzqWEeIe92ClCMouqaPKrEA
Date:   Thu, 6 Jun 2019 21:51:32 +0000
Message-ID: <20190606215130.okbvt2qsdolnjivh@kafai-mbp.dhcp.thefacebook.com>
References: <20190606203012.130071-1-guro@fb.com>
In-Reply-To: <20190606203012.130071-1-guro@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:300:117::15) To MWHPR15MB1790.namprd15.prod.outlook.com
 (2603:10b6:301:53::10)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::538e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb9498e2-0be1-42cd-db3d-08d6eac9233d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MWHPR15MB1677;
x-ms-traffictypediagnostic: MWHPR15MB1677:
x-microsoft-antispam-prvs: <MWHPR15MB167755F25E6068BDB08461C8D5170@MWHPR15MB1677.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00603B7EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(136003)(39860400002)(396003)(366004)(189003)(199004)(66476007)(14454004)(66446008)(11346002)(6486002)(6436002)(6512007)(66556008)(71190400001)(52116002)(7736002)(64756008)(9686003)(46003)(5660300002)(6636002)(229853002)(4326008)(446003)(476003)(186003)(486006)(86362001)(8676002)(25786009)(1076003)(54906003)(6862004)(478600001)(68736007)(316002)(2906002)(4744005)(256004)(66946007)(73956011)(8936002)(386003)(6116002)(102836004)(53936002)(99286004)(81166006)(6246003)(71200400001)(305945005)(76176011)(6506007)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR15MB1677;H:MWHPR15MB1790.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: aDFB3qPocAwXQkBIqw/Dqt7OfRnY1aj9kTAxKS8S8QZhOtwZljVWC/SpyYZO9pO4smlv7bgMlT84VZpxK5X1H/aNLF3B5peNeG6b1t2xk9Lmg5keprRn3lJrWvEsVijujSY1hYXpJBCpyBfsKyn0jPQM/qWC388kD3AD1CtFLx9wpfUHoE8ETVhwQxtSr+15BwAYtNATeqmGRxycs3fMUcFqGCtQUeTmk6bFJRacef7X9nlblPFNBeOWFY7ifbkMWwoIm1zi4bdc558aFhKTx2PMFVcfqFSMB3AjaNnbUcwD4PI3Fv7IPlWGgXkKE6DLDoG4bJzCMY8rLLRkUTKY0n4hQGVlSgHNlrIJoOae19dkaKufa8iGjd4/EwCsR3/zkcetj7GUTRpeJe+wCf68VvUgfJbw7OKzy7r/FIqXGFI=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15E99CA08AFFCB4CBE9A88A404329798@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: bb9498e2-0be1-42cd-db3d-08d6eac9233d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2019 21:51:32.4269
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kafai@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1677
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-06_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=610 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906060147
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 06, 2019 at 01:30:12PM -0700, Roman Gushchin wrote:
> Currently bpf_skb_cgroup_id() is not supported for CGROUP_SKB
> programs. An attempt to load such a program generates an error
> like this:
>=20
>     libbpf:
>     0: (b7) r6 =3D 0
>     ...
>     9: (85) call bpf_skb_cgroup_id#79
>     unknown func bpf_skb_cgroup_id#79
>=20
> There are no particular reasons for denying it, and we have some
> use cases where it might be useful.
>=20
> So let's add it to the list of allowed helpers.
Acked-by: Martin KaFai Lau <kafai@fb.com>
