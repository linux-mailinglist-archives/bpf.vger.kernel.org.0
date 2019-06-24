Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDCAD50070
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2019 06:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbfFXECp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jun 2019 00:02:45 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:10032 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725769AbfFXECp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 24 Jun 2019 00:02:45 -0400
Received: from pps.filterd (m0044008.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5O40NGh020672;
        Sun, 23 Jun 2019 21:02:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=iUKCvBpWSJdxY1Yben+FHHvoYlCUtpM7nEVQFQxBbVY=;
 b=Xwn8yF/ymnU40iHTikJb8udye0dfAhDRjxlxAyp7SmkukVzmWNQgS4swIcZyh6zqLBHK
 MHV//00AqFA1uxRdH2BGTI0sUTk9dBhOlwouvbBdscIif9bkdrYKTNMIs5fzqvK67RFA
 2wD28BuHkWHEPSRTqGyO6I7b44CEr5xdwBk= 
Received: from mail.thefacebook.com (mailout.thefacebook.com [199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2t9fmjmvqh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 23 Jun 2019 21:02:23 -0700
Received: from prn-hub03.TheFacebook.com (2620:10d:c081:35::127) by
 prn-hub03.TheFacebook.com (2620:10d:c081:35::127) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.1.1713.5; Sun, 23 Jun 2019 21:02:22 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (192.168.54.28)
 by o365-in.thefacebook.com (192.168.16.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.1.1713.5
 via Frontend Transport; Sun, 23 Jun 2019 21:02:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUKCvBpWSJdxY1Yben+FHHvoYlCUtpM7nEVQFQxBbVY=;
 b=k/PfpX9qLbPwqldIWwRyqnwb6TYusX9lQSbp4UyaG8Y/3Bu964PipklW56K8+ySkYsNnT4ctmW4IgsG0MA1DcV2NRAMLmk5OmyPfSqUESAjrpm19Ekdf7LcX/3gZuXloSSLl4jgAsfj0BFI7uckK5ibNxgtcsoQVr2XiB48A5O8=
Received: from BN8PR15MB2626.namprd15.prod.outlook.com (20.179.137.220) by
 BN8PR15MB3202.namprd15.prod.outlook.com (20.179.73.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.16; Mon, 24 Jun 2019 04:02:20 +0000
Received: from BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::e594:155f:a43:92ad]) by BN8PR15MB2626.namprd15.prod.outlook.com
 ([fe80::e594:155f:a43:92ad%6]) with mapi id 15.20.2008.014; Mon, 24 Jun 2019
 04:02:20 +0000
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
Thread-Index: AQHVKjTees07LGtTbkiqSncwtVU7j6aqJZyAgAAJMAA=
Date:   Mon, 24 Jun 2019 04:02:20 +0000
Message-ID: <20190624040211.GA10696@castle.dhcp.thefacebook.com>
References: <20190624023051.4168487-1-guro@fb.com>
 <91017042-1b59-6110-dfdd-13cfbbec1ae1@fb.com>
In-Reply-To: <91017042-1b59-6110-dfdd-13cfbbec1ae1@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:301:39::17) To BN8PR15MB2626.namprd15.prod.outlook.com
 (2603:10b6:408:c7::28)
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2620:10d:c090:180::1:4969]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83837ae1-4780-4444-d99e-08d6f858c153
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN8PR15MB3202;
x-ms-traffictypediagnostic: BN8PR15MB3202:
x-microsoft-antispam-prvs: <BN8PR15MB32028BC9EEF6D3F5F62EFD9DBEE00@BN8PR15MB3202.namprd15.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 007814487B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(136003)(366004)(396003)(346002)(376002)(189003)(199004)(71190400001)(71200400001)(53546011)(6506007)(8936002)(386003)(102836004)(81166006)(81156014)(186003)(229853002)(52116002)(6636002)(6436002)(86362001)(76176011)(33656002)(2906002)(6116002)(256004)(99286004)(6486002)(8676002)(11346002)(446003)(5024004)(14444005)(1076003)(6246003)(53936002)(73956011)(66946007)(46003)(478600001)(4326008)(54906003)(64756008)(66446008)(25786009)(6512007)(9686003)(66476007)(66556008)(7736002)(5660300002)(6862004)(316002)(68736007)(305945005)(486006)(14454004)(476003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR15MB3202;H:BN8PR15MB2626.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: fbbiu9IS8c9cjLlrrPWGb4/swivMENAbfzLWkFjkB/LRTWPtLTm52RUCQP6aNPqLNFcgyDpURK7wS4epIjNRVg1DxBIlRj0ptDQalOSSszAdVVGalt9Y0hWwNN1M3co+g5pz4ovIuIttq6f5/UoC7K7H3P08gzbXnTfW6cLAfo3afZTA8Ezq4tnWNtm9mx3sX9uFRstXrskd6IsU/kqAP9elwsnRdFwxpj7b/TtM1mtc99jbFz1Xz2jDDRZZccaHDZQnlkXNW7lx/nbxUkLrssV3ijjJ3rDBj7cgpVHuD5vuIJaG5xCtgQEOR9dRfGMRufedq83aGVzoSWgXYVVxEwg3hlabim8Omwg0r7EuEQgtolAPMEkLCFLu2igJdfMI/ZruHqz5a2DH1dS9SKw295JMvmkm+9H7YKRikkOPDXc=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DFE5A7730F46444C9CFC8429E91978C9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 83837ae1-4780-4444-d99e-08d6f858c153
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2019 04:02:20.6980
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: guro@fb.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB3202
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-24_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=898 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906240032
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 23, 2019 at 08:29:21PM -0700, Alexei Starovoitov wrote:
> On 6/23/19 7:30 PM, Roman Gushchin wrote:
> > Since commit 4bfc0bb2c60e ("bpf: decouple the lifetime of cgroup_bpf
> > from cgroup itself"), cgroup_bpf release occurs asynchronously
> > (from a worker context), and before the release of the cgroup itself.
> >=20
> > This introduced a previously non-existing race between the release
> > and update paths. E.g. if a leaf's cgroup_bpf is released and a new
> > bpf program is attached to the one of ancestor cgroups at the same
> > time. The race may result in double-free and other memory corruptions.
> >=20
> > To fix the problem, let's protect the body of cgroup_bpf_release()
> > with cgroup_mutex, as it was effectively previously, when all this
> > code was called from the cgroup release path with cgroup mutex held.
> >=20
> > Also make sure, that we don't leave already freed pointers to the
> > effective prog arrays. Otherwise, they can be released again by
> > the update path. It wasn't necessary before, because previously
> > the update path couldn't see such a cgroup, as cgroup_bpf and cgroup
> > itself were released together.
>=20
> I thought dying cgroup won't have any children cgroups ?

It's not completely true, a dying cgroup can't have living children.

> It should have been empty with no tasks inside it?

Right.

> Only some resources are still held?

Right.

> mutex and zero init are highly suspicious.
> It feels that cgroup_bpf_release is called too early.

An alternative solution is to bump the refcounter on
every update path, and explicitly skip de-bpf'ed cgroups.

>=20
> Thinking from another angle... if child cgroups can still attach then
> this bpf_release is broken.

Hm, what do you mean under attach? It's not possible to attach
a new prog, but if a prog is attached to a parent cgroup,
a pointer can spill through "effective" array.

But I agree, it's broken. Update path should ignore such
cgroups (cgroups, which cgroup_bpf was released). I'll take a look.

> The code should be
> calling __cgroup_bpf_detach() one by one to make sure
> update_effective_progs() is called, since descendant are still
> sort-of alive and can attach?

Not sure I get you. Dying cgroup is a leaf cgroup.

>=20
> My money is on 'too early'.
> May be cgroup is not dying ?
> Just cgroup_sk_free() is called on the last socket and
> this auto-detach logic got triggered incorrectly?

So, once again, what's my picture:

A
A/B
A/B/C

cpu1:                               cpu2:
rmdir C                             attach new prog to A
C got dying                         update A, update B, update C...
C's cgroup_bpf is released          C's effective progs is replaced with ne=
w one
                                    old is double freed

It looks like it can be reproduced without any sockets.

Thanks!
