Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB4E403C59
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbhIHPO1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Sep 2021 11:14:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:2016 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348450AbhIHPO1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Sep 2021 11:14:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188ExRcF028129;
        Wed, 8 Sep 2021 15:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Mfnb10LqWp12WFibwKRXlVZgJJcXiYQzQsgxc5YAGog=;
 b=U0/GDWWXVWDfdrw9edNpKzHjwnbClJlOHYKPTDHuaLynCXJiqoWwO0LbVNxJTX3/1VWf
 mby4A1XL76jxt42FF/W3jsGac4x+xPdiYG1y5q1MQUjDn5KCzB/oma67mldWDBmgr3V5
 hvr9cOjuTJVETG5WbHdBGv2DudY2/q6bdfovKhOR06ZUkPreLH6K7TK62aBtGWTpU410
 8JnMdB/kjta1ndWKiMkswx6ZIMCDDE+58oIfZUz8Zll9SVNGULAt2oyZGXKXg79MUuFY
 8x7i8sluVsY3UTlblmeBL7jNoLw+1w/C1HGVThKJBchEwQ7zUoi5PI8Ji6jzIzr1nIyf PA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Mfnb10LqWp12WFibwKRXlVZgJJcXiYQzQsgxc5YAGog=;
 b=u3W0WavwmFvGmZFWuwix+XjfQ9rOO4a4U3j75WM5Kg9qFoM56WAyBhQyOLKa1qY9VbkK
 HQxnW+AsWGOOecpacCFVDvsx7CRpcGbM5VtjocIlp+mxt/UWVFPI3sAGmjYnm8wDVBWg
 9zc+RXXd+ammDyiYGIW/rlDCAWLfYzDm7L+f3lx281WcecbavUEW/2fTHMpsAlBUzmi/
 gaWXX7txbTO52IG2hgsbMP0QFVRmbfK4YhMeBpioZk13/SBFCWtkvNTJV+aZfZcXpSy1
 kE2gYP59qfsTo+5rwgdfuyF5Z3RDAKKTlGXEppY0DMOoxnyLHXdsvx5Kjz11uWHm+1jK Jg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd44u1rk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 15:12:55 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 188FCoIr122745;
        Wed, 8 Sep 2021 15:12:53 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by userp3030.oracle.com with ESMTP id 3axcq1hcm0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 15:12:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B2ks3aDhHmbRUFt2jaiGtuqy3b0wcth3Svp4ClRYDeOLfRNFKUCXrj76GDwjcBHwNkvflzrACAXSksjtVbVIs9kzPd02cSQmxRi0wP9w7YUd5sZitcUvULHHdGfCbdlzUMBKEKaBFBWw9dxlYwMnvw8h6tzr7GJFH9yQhouyjJ1MebJtRC13018X1Ial3LKC6YXk4XPTQEie9SG/LCfM1z3KnfmohwSr196Q7uAllEq6g5SvDM6crcJgVNkMX+oIvIjBqrAiWpHoZVtbqeOgyLF4CL/ijqcALCQeKNfvzd/4R3w1b/5opLoR3Fdsc7lES3/nBpDkmg+5iW2bQxK1ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=Mfnb10LqWp12WFibwKRXlVZgJJcXiYQzQsgxc5YAGog=;
 b=b9V4BjPxWZf7ewJOr5uLzlOmZfFenju1Qt5sedTf+j+05MYA+B77xFciBAgNFBAiRw6gEqIMpC510ACZ3486xHz5mlntIAKEviWXBRyZkpVQyJC66bAW1la4ugMYhSDsI0wqcMUEyiQtq3nkdFYZjOF1AhqWxccNw9rmcz2fUEqaGMbthptQ++gUX7rB3opR+YDz6wbB2vSCvrdImjpo8K/bMCjItp6Ye3grgWb0yZ3rk9SHvIolsHZE05QU9NOpNUQU2n8ewxLEz6ft6jAY0ZxvHek22kt+piZL1PCOozDBHpidrcdtfhGvFOrw/p0FjLxpYwYRCM41QzI+9SnegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mfnb10LqWp12WFibwKRXlVZgJJcXiYQzQsgxc5YAGog=;
 b=hUHawiOtF+WIZy3S1lqLTIo9651umdSczotN00Qgq/AG9wrEfe0kxaaisI/N8QFarQDEcvdey1z+9Rn/wUVqLvbA2aAgLICjx/ATBszbq14O2HXsBvZPVMTryLlZBGAouSOd1DW1UwvBy6qe616fiGhUvXtPJRthA9wNGpvO4aA=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM5PR10MB1515.namprd10.prod.outlook.com (2603:10b6:3:11::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 15:12:39 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 15:12:39 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Luigi Rizzo <lrizzo@google.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Michel Lespinasse <walken@google.com>,
        Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Thread-Topic: [PATCH mm/bpf v2] mm: bpf: add find_vma_no_check() without
 lockdep_assert on mm->mmap_lock
Thread-Index: AQHXpGw9DgXD+GNr6U6ppzcLTIluVquaDuuAgAAaBwCAAAYWgIAAB/aAgAAICwA=
Date:   Wed, 8 Sep 2021 15:12:38 +0000
Message-ID: <20210908151230.m2zyslt4qrufm4bv@revolver>
References: <20210908044427.3632119-1-yhs@fb.com>
 <ebcddf07-f329-05fa-8fdc-b2b9d6b0127b@iogearbox.net>
 <20210908135326.GZ1200268@ziepe.ca>
 <YTjFcek5B3ltYtG3@hirez.programming.kicks-ass.net>
 <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
In-Reply-To: <CAMOZA0+FofdYMivrBR14snb6Xo_i6BV7gVX1dGCtJa=ue3VqEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 138106ed-bdef-4539-509f-08d972db18f5
x-ms-traffictypediagnostic: DM5PR10MB1515:
x-microsoft-antispam-prvs: <DM5PR10MB151511C17D9481CB5A4CABE2FDD49@DM5PR10MB1515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J6mzr+6Ay/LvgIGpYPdgg5WO/a6CvgBXnZL0gOQm2UwZ83Mqjm5PwKvKjqt7ByxcwA1I2JhxUtHyALWxZoWixiuJnIROUhz5M4D2y3dX7kd71u68xduuldX+/g9vPK3TzJ9WWNXNK1W44IiqpWla/18tJv8fB77raeabn8rbF3NWPNbIt3Tm1X2YbSiNsjNtqHfOGh5JhcaRM20hq4jm5I2BOfZxTFtxpQW8aTLlK2uPhvxgwIgcHCJ+BnRSJUSisJrrKYmlmeX/mYl0PVcUObLjy2mACLWhlpqqNaDuzbTl58M2u3nfzZj9Nrxnj4LHGmx9yXQH3lkVYcVa4AflDyOYRvfQglAaWXyJe5yI+XcWx8hvNSCp6UhXAa80gwk6582scm0TA/aVuwUB0lT8p/FB13g+sWDog8hKaArVHIyW6QnlaGksuerCwbvaEZV5bV4uFEtwuWFjGWP3ZoTDwL95h22L2lT/R8BzocyztxUTSdpSR9UEvjapj6xgGEr26m/VKk7tJqngidvpZMG7ff68X16082ZLFfQIUy7popNpnhKqIClFBoNJsxcrQD+kwPXVhxVYcVoYf0kdHsfeyALf1uxKolmG9w2afqlUnT6qNPwKgnvpob3vznYQWWkl8iUThxZ68qV0dumFQEqC06/NA3i1hbKRDwErsGs9pjs/nIZA5cjuy7w2LK/7EmTMW0rAn6oFIx/E/8NKHsd5hA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(136003)(396003)(366004)(376002)(346002)(39860400002)(66946007)(91956017)(8676002)(66476007)(76116006)(64756008)(66446008)(66556008)(8936002)(316002)(44832011)(54906003)(186003)(33716001)(1076003)(5660300002)(6916009)(6506007)(53546011)(26005)(71200400001)(6486002)(83380400001)(38100700002)(7416002)(9686003)(6512007)(122000001)(4326008)(86362001)(2906002)(478600001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tjblvM7TWuyDzQiqPprT3uI0RTEqvAqYW7QZLt5+F/7NWZjfGs5+tjsx8vcX?=
 =?us-ascii?Q?k+xink1O1IN0+K3hlscw4+3rOjaYJajoz6mw8lwHYWpvWFXdp5nmETwhg8m8?=
 =?us-ascii?Q?6g9kbJ26VdPlqrT9Wtl3Cy3SzM4qT0Qb1YfEKQLR2gBEVBUq9WvcljvZ6PLj?=
 =?us-ascii?Q?QlECf882wZ1eULKKPp8VU0PRdDjZv11iX3Mm0doGgBGbA9zShe3ZnwfPjCE4?=
 =?us-ascii?Q?rKO3yL2HSSIwDY7tRcfsvT8Je5gstMoDBZP8HoWfzrxr/X2b3dfEbRFjMDnV?=
 =?us-ascii?Q?yATc81PnNIDR808zkPY+107EwDId98RTQtP8BkeZEofTjo7N+s/xIU60aitB?=
 =?us-ascii?Q?HFJIy0eDGLueaJ766e2qF1QO7Q/lxivBsdopZKWyo72QO35rPZLkmzOV1U5O?=
 =?us-ascii?Q?Z9DjHpSetypbCMdjKjXRhD0/+fZd0LODqm0FtYuNiHBKPJzqgB+TxCo4NREK?=
 =?us-ascii?Q?BXuQp2MD9m46/DdAJhhna76W+0YbhPLX497jngm4zll2CUJmZgFEMJjTSWFy?=
 =?us-ascii?Q?hjJvFoE2VMo3i6rAIMgOP9Ig0NaN4ijjFDVFkd2w9L7B7DXB/6MW3yHdFONt?=
 =?us-ascii?Q?eJ/94GYiO7vXGSo7HBZhh/0F+DZHNoWXYTGzMjEn9NFmNTttkep0jKIYAxOw?=
 =?us-ascii?Q?4V0g11niMUePf/FyxUFaNtAB/S2kTlrDgDFao2ummpQDXJHgyX6brOtZYG8g?=
 =?us-ascii?Q?ti52EnYFYIGWtWZQs9Ul2tD1F9ZCC8SmF0NCrkhDMGD5o6QWmm83fmcEgyRP?=
 =?us-ascii?Q?TfQq2+SQtzXlHfesqgU7emnz5u9F+inCSvTnGRNHmST8AbdcVDScoPzmW/xy?=
 =?us-ascii?Q?ZZcdhh0mgA1D0mFsmYRn5o5aGHQarXuiyqOIqpeiMlLXzlWq6PhbTA4lBgV/?=
 =?us-ascii?Q?s2ARn4xG4goL0dfVOOKP+N9njuF9p87O94OaWGmTREUP+SYIMWpPzMclNgC6?=
 =?us-ascii?Q?NVBDj3tUXsHdz4e6KODOSb/gOgkMMZBti5q5sgBsQo3WQI8iEd6aYcm+yHsc?=
 =?us-ascii?Q?MVtGSr3oPGKWawAlXusT2ljibhnGBC0ujcaAGJh1F9AQWErogG5RLeme8pCD?=
 =?us-ascii?Q?ETJ3VM+gVJ5Am/mSKs1Y3/aAG+EdEe5gyzihsMnGF+1JyzuNRX3qxi3q+q4h?=
 =?us-ascii?Q?FZgUFVfzBBdpUrSuOKNIkR5QcfAI7CilOensqfuDh12YPsqte3W5HJdJnsvw?=
 =?us-ascii?Q?oTVwk9UbiQmAyzULeMRZSzAP5WGvwHXrc9e7Nj5srGlINHEEMUrCIy74fG1k?=
 =?us-ascii?Q?anD5/q6T7imCEKStcUkvumoEm4XtxJYA7++2e3s86nkxaFaXlJcpfORD33m3?=
 =?us-ascii?Q?JdsjcqEBlTVArzncRBfwuZcr?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EE50EA0F5FF2D4EABCBBDA292AA4C6D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 138106ed-bdef-4539-509f-08d972db18f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 15:12:39.0386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HqxgrbC0ggfJIYaAJkfzKASHC/GImJz/smazXXJAckgy1bSVG1HQBFhGaGjRLg+Ui8yKRmva7RiKEkqh5FLV5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1515
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080095
X-Proofpoint-GUID: FjHZXxO6ELH5fkeRfPhtPtFdf-K0zV1t
X-Proofpoint-ORIG-GUID: FjHZXxO6ELH5fkeRfPhtPtFdf-K0zV1t
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

* Luigi Rizzo <lrizzo@google.com> [210908 10:44]:
> On Wed, Sep 8, 2021 at 4:16 PM Peter Zijlstra <peterz@infradead.org> wrot=
e:
> >
> > On Wed, Sep 08, 2021 at 10:53:26AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 08, 2021 at 02:20:17PM +0200, Daniel Borkmann wrote:
> > >
> > > > > The warning is due to commit 5b78ed24e8ec("mm/pagemap: add mmap_a=
ssert_locked() annotations to find_vma*()")
> > > > > which added mmap_assert_locked() in find_vma() function. The mmap=
_assert_locked() function
> > > > > asserts that mm->mmap_lock needs to be held. But this is not the =
case for
> > > > > bpf_get_stack() or bpf_get_stackid() helper (kernel/bpf/stackmap.=
c), which
> > > > > uses mmap_read_trylock_non_owner() instead. Since mm->mmap_lock i=
s not held
> > > > > in bpf_get_stack[id]() use case, the above warning is emitted dur=
ing test run.
> ...
> > > > Luigi / Liam / Andrew, if the below looks reasonable to you, any ob=
jections to route the
> > > > fix with your ACKs via bpf tree to Linus (or strong preference via =
-mm fixes)?
> > >
> > > Michel added this remark along with the mmap_read_trylock_non_owner:
> > >
> > >     It's still not ideal that bpf/stackmap subverts the lock ownershi=
p in this
> > >     way.  Thanks to Peter Zijlstra for suggesting this API as the lea=
st-ugly
> > >     way of addressing this in the short term.
> > >
> > > Subverting lockdep and then adding more and more core MM APIs to
> > > support this seems quite a bit more ugly than originally expected.
> > >
> > > Michel's original idea to split out the lockdep abuse and put it only
> > > in BPF is probably better. Obtain the mmap_read_trylock normally as
> > > owner and then release ownership only before triggering the work. At
> > > least lockdep will continue to work properly for the find_vma.
> >
> > The only right solution to all of this is the below. That function
> > downright subverts all the locking rules we have. Spreading the hacks
> > any further than that one function is absolutely unacceptable.
>=20
> I'd be inclined to agree that we should not introduce hacks around
> locking rules. I don't know enough about the constraints of
> bpf/stackmap, how much of a performance penalty do we pay with Peter's
> patch,
> and ow often one is expected to call this function ?
>=20
> cheers
> luigi

The hack already exists.  The symptom of the larger issue is that
lockdep now catches the hack when using find_vma().

If Peter's solution is acceptable to the bpf folks, then we can go ahead
and drop the option of using the non_owner variant - which would be
best.  Otherwise the hack around the locking rule still exists as long
as the find_vma() interface isn't used.

Thanks,
Liam=
