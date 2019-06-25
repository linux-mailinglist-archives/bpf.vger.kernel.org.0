Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EDFA155458
	for <lists+bpf@lfdr.de>; Tue, 25 Jun 2019 18:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfFYQW2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jun 2019 12:22:28 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:21444 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726740AbfFYQW2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 25 Jun 2019 12:22:28 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.27/8.16.0.27) with SMTP id x5PGM5eU007735;
        Tue, 25 Jun 2019 09:22:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=YCML5necUsfJNPIv51NOFAaiSXK3LP1y7lW5gOB0Lho=;
 b=cWAgHtwRlKs30MBUPIDNnAiw0t3TMR2+94ITaocFqL46fd17hIKhXxYddcNzFl/xxTd7
 Muo/LuSlLAjn7HKSALLAGsuzCZhkk27Q9LOyitmgJvdLjb6XG2kGN9/ZmnoZ5vo9Unt9
 e/64q7IJH8Q9lmsQ2QIHlcr/+AtasWZiJi4= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by m0001303.ppops.net with ESMTP id 2tbpv801r0-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 25 Jun 2019 09:22:06 -0700
Received: from prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) by
 prn-hub06.TheFacebook.com (2620:10d:c081:35::130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 25 Jun 2019 09:22:04 -0700
Received: from prn-hub06.TheFacebook.com (2620:10d:c081:35::130) by
 prn-mbx06.TheFacebook.com (2620:10d:c081:6::20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Tue, 25 Jun 2019 09:22:03 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Tue, 25 Jun 2019 09:22:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YCML5necUsfJNPIv51NOFAaiSXK3LP1y7lW5gOB0Lho=;
 b=ITvEI3G1mw5ubRMK/7B/951u60wJuAZUQtwn2Tfc7ECsFC6llW26UEhNYOdn7cMrsLcrTVRXuC4uAhOCw/tMyZtQ+XvIDHCajauT1EH0+N7e1g3qSPDsPpNNIMzXWicF+pL1Gg0ibC/uGzlU3nUWOpUGnoKWjQutlUkZE7roW3Q=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB2899.namprd15.prod.outlook.com (20.178.219.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Tue, 25 Jun 2019 16:22:01 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::e594:155f:a43:92ad]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::e594:155f:a43:92ad%6]) with mapi id 15.20.2008.014; Tue, 25 Jun 2019
 16:22:01 +0000
From:   Roman Gushchin <guro@fb.com>
To:     Alexei Starovoitov <ast@fb.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Tejun Heo <tj@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: fix cgroup bpf release synchronization
Thread-Topic: [PATCH bpf-next] bpf: fix cgroup bpf release synchronization
Thread-Index: AQHVKjTees07LGtTbkiqSncwtVU7j6aqJZyA//+T1wCAAs2vgIAACKoA
Date:   Tue, 25 Jun 2019 16:22:00 +0000
Message-ID: <20190625162156.GA6128@tower.DHCP.thefacebook.com>
References: <20190624023051.4168487-1-guro@fb.com>
 <91017042-1b59-6110-dfdd-13cfbbec1ae1@fb.com>
 <20190624040211.GA10696@castle.dhcp.thefacebook.com>
 <6eedf3b7-d2db-7348-5969-d57376483961@fb.com>
In-Reply-To: <6eedf3b7-d2db-7348-5969-d57376483961@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:a03:80::28) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:200::40d1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7011730a-8bf0-4d98-7106-08d6f9894064
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB2899;
x-ms-traffictypediagnostic: BN8PR15MB2899:
x-microsoft-antispam-prvs: <BN8PR15MB2899D17D42A0110D3F8976A1BEE30@BN8PR15MB2899.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 0079056367
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(376002)(366004)(346002)(396003)(39860400002)(199004)(189003)(8676002)(81156014)(1076003)(53546011)(386003)(73956011)(6506007)(66446008)(66556008)(14444005)(66946007)(66476007)(64756008)(486006)(68736007)(81166006)(102836004)(54906003)(6246003)(478600001)(5024004)(11346002)(14454004)(476003)(446003)(46003)(33656002)(256004)(186003)(229853002)(71190400001)(86362001)(53936002)(6116002)(8936002)(6436002)(6512007)(9686003)(2906002)(316002)(25786009)(6486002)(5660300002)(6636002)(71200400001)(99286004)(7736002)(4326008)(305945005)(52116002)(6862004)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB2899;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: twCspLYAbz5yftZ+TT3RjsraGCjHASdlTPTIO4HTziK7OTQ7nzDch1iHC7pa6F9aBGqvwowQg6BWV8JbWixA+qefOTfOdDkFKt1IwB8mdWysvyPL2RsY5MReVs+3S6bscCRDGenfSvQa6hoU9XJ11gA21pdguEyqqsqYTd4vpnRWCw/uqf27kewNFLhijg50Q+wuI05hWFSWxUcpxKWtevDgtRtRXJUg3EBb719Qt0plv6BaTdYZPWLvK3D0zAqS51fsgoQ/7Gvgj9faQbTXqbCb7Z+hDYdgfzF67oq7x6dvgTwurhSNsUWZABe/0DABYmkhP8FafDbfnUUapiJGAMoeWz3FDD+ShA/CPJY2uSZhR38Wcns2vtsXUYu1bgiYk4+2FR0mV/jlB/mKXn8IDYklbNOBI5GQwq8ewtq7yfs=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB2F728A85C5834B8B7D15A3F538B8A1@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7011730a-8bf0-4d98-7106-08d6f9894064
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2019 16:22:00.8632
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2899
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-25_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=869 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906250124
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 25, 2019 at 08:50:55AM -0700, Alexei Starovoitov wrote:
> On 6/23/19 9:02 PM, Roman Gushchin wrote:
> > On Sun, Jun 23, 2019 at 08:29:21PM -0700, Alexei Starovoitov wrote:
> >> On 6/23/19 7:30 PM, Roman Gushchin wrote:
> >>> Since commit 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf
> >>> from cgroup itself"), cgroup_bpf release occurs asynchronously
> >>> (from a worker context), and before the release of the cgroup itself.
> >>>
> >>> This introduced a previously non-existing race between the release
> >>> and update paths. E.g. if a leaf's cgroup_bpf is released and a new
> >>> bpf program is attached to the one of ancestor cgroups at the same
> >>> time. The race may result in double-free and other memory corruptions=
.
> >>>
> >>> To fix the problem, let's protect the body of cgroup_bpf_release()
> >>> with cgroup_mutex, as it was effectively previously, when all this
> >>> code was called from the cgroup release path with cgroup mutex held.
> >>>
> >>> Also make sure, that we don't leave already freed pointers to the
> >>> effective prog arrays. Otherwise, they can be released again by
> >>> the update path. It wasn't necessary before, because previously
> >>> the update path couldn't see such a cgroup, as cgroup_bpf and cgroup
> >>> itself were released together.
> >>
> >> I thought dying cgroup won't have any children cgroups ?
> >=20
> > It's not completely true, a dying cgroup can't have living children.
> >=20
> >> It should have been empty with no tasks inside it?
> >=20
> > Right.
> >=20
> >> Only some resources are still held?
> >=20
> > Right.
> >=20
> >> mutex and zero init are highly suspicious.
> >> It feels that cgroup_bpf_release is called too early.
> >=20
> > An alternative solution is to bump the refcounter on
> > every update path, and explicitly skip de-bpf'ed cgroups.
> >=20
> >>
> >> Thinking from another angle... if child cgroups can still attach then
> >> this bpf_release is broken.
> >=20
> > Hm, what do you mean under attach? It's not possible to attach
> > a new prog, but if a prog is attached to a parent cgroup,
> > a pointer can spill through "effective" array.
> >=20
> > But I agree, it's broken. Update path should ignore such
> > cgroups (cgroups, which cgroup_bpf was released). I'll take a look.
> >=20
> >> The code should be
> >> calling __cgroup_bpf_detach() one by one to make sure
> >> update_effective_progs() is called, since descendant are still
> >> sort-of alive and can attach?
> >=20
> > Not sure I get you. Dying cgroup is a leaf cgroup.
> >=20
> >>
> >> My money is on 'too early'.
> >> May be cgroup is not dying ?
> >> Just cgroup_sk_free() is called on the last socket and
> >> this auto-detach logic got triggered incorrectly?
> >=20
> > So, once again, what's my picture:
> >=20
> > A
> > A/B
> > A/B/C
> >=20
> > cpu1:                               cpu2:
> > rmdir C                             attach new prog to A
> > C got dying                         update A, update B, update C...
> > C's cgroup_bpf is released          C's effective progs is replaced wit=
h new one
> >                                      old is double freed
> >=20
> > It looks like it can be reproduced without any sockets.
>=20
> I see.
> Does it mean that css_for_each_descendant walks dying cgroups ?

Yes.

> I guess the fix then is to avoid walking them in update_effective_progs ?
>=20

Yes, this is close to what I'm testing now. We basically need to skip cgrou=
ps,
which bpf refcounter is 0 (and in atomic mode). These cgroups can't invoke =
bpf
programs, so there is no point in updates.
