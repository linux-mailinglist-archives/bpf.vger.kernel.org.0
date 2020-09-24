Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE67127695B
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 08:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbgIXGvv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 02:51:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726961AbgIXGvv (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 24 Sep 2020 02:51:51 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 08O6hBNe031496;
        Wed, 23 Sep 2020 23:51:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=rqwQT8++vD12eJn7/eqHOG2yva1qrGo+eEaGhGvXMe0=;
 b=SJvVLONAnAXlSB522vABRXb81QRh5ZCdfon9ZFaxwH2PI36dpr4BZsc6sSWhFNgWsEBg
 UjE3gx8tYTGKhyYbjV31xGA6J2omVQyAFBUqJDPqIErE21fv4f3g7QJuvjTHccoShdaW
 n7r09FCOIZ3qvsRfITlwEuIcJwA/JVEDKBY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 33qsp7g5m7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 23 Sep 2020 23:51:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 23 Sep 2020 23:51:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcRbHNrEWEKS1XSbskHF1ahSBV/25pdBYvzmek0kdgyKW4coAYTt18FFcKjynXT+6BIcqeFa4lJPPTVgr2ixtOKqsVXhtfU55FXk+IVf//WUU2xAhnmCBzMtG2vkTdPeBtLw1EyridHm1ZXm3sJ5MaQC7V5+kGOrUYNhrgjpMWFMo63lwPtlXY2Po1S3aqhChG4YTXaOuKNd7ozYY2cEgM2A9hdq0ZhUDn3keqGf64Zqs91pJq5CBa9TuKBeFT2wz9hLv16CuZvnKjb3Qhg0UcLr0ZqFEEP1gSYxIEPsXzI0h1XhnKf2lOkiG2XnKQeMF/E3sqjjOsjw0V+n4EEaGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqwQT8++vD12eJn7/eqHOG2yva1qrGo+eEaGhGvXMe0=;
 b=dq7AwEZoqdY6qVFruxI9kPPoPppmYSzMzf7msjcLURHUMteOXCRV5pMl7BzalJkGOzxmEj537tVTWcouhlQ9rHGLNA9YhKOFISlC3LU46UOuegfTMS6DuksYJr+k8S8W+7kZNZrxe4jKOVJQAXkFykIB4lcTb7/bJLrcg20HanuzQBIAXapmJB1GrkCa/26ja875TmZKtrwKmcMytzseSq7TmJMm1d23f7plE8MRxfS+8nI2KhcTsyt7nzZivNr3Cy8qmGNAfH5S2laErsb8w2qmGepbtLWRTvZsy08wkO6Qb5TUkmBGb33me7jv+9Q0DyeEIBB1BLuR4jeMSAHxdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rqwQT8++vD12eJn7/eqHOG2yva1qrGo+eEaGhGvXMe0=;
 b=W7rR15vx+zrPQlHV5hhHaNYVe2JGj/4VauqDn048v9yT10t2s7Ka0HT1fLrUNgIh5gVnmBL4N4KbpAj9IEtA2s5Ag1ehP7xW9rBPhgMvcPST36kDgcmFKa+nxq5m5nXtednB4XcbsdO+BGisqs8fCw/HIDmbuOsOBUcOi/K/V3k=
Received: from BYAPR15MB2999.namprd15.prod.outlook.com (2603:10b6:a03:fa::12)
 by BYAPR15MB4119.namprd15.prod.outlook.com (2603:10b6:a02:cd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21; Thu, 24 Sep
 2020 06:51:36 +0000
Received: from BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1400:be2f:8b3d:8f4d]) by BYAPR15MB2999.namprd15.prod.outlook.com
 ([fe80::1400:be2f:8b3d:8f4d%7]) with mapi id 15.20.3412.020; Thu, 24 Sep 2020
 06:51:36 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        "Andrii Nakryiko" <andriin@fb.com>
Subject: Re: splat in stacktrace_build_id_nmi
Thread-Topic: splat in stacktrace_build_id_nmi
Thread-Index: AQHWkhoVH0DJL6W8yU6nS49+Lx1rKql3WhWA
Date:   Thu, 24 Sep 2020 06:51:36 +0000
Message-ID: <DDE61951-6DB3-4DCD-8F25-21E44D4A50E3@fb.com>
References: <CAADnVQKyRVtFd9OnFpcc4_4qpeT1j0yNt4mB8D1E7gc14F8mRQ@mail.gmail.com>
In-Reply-To: <CAADnVQKyRVtFd9OnFpcc4_4qpeT1j0yNt4mB8D1E7gc14F8mRQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.1)
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
x-originating-ip: [2620:10d:c090:400::5:cb37]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f316ec0-6870-4b9f-69da-08d8605647f4
x-ms-traffictypediagnostic: BYAPR15MB4119:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR15MB41197BFA7D16BEC40A908A05B3390@BYAPR15MB4119.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5zIxy0w7v2klUYeL9FPP6EHzDr+8+FxWGN88kZXUDd5FU643PAhc/O8/XtyOYL07ToayAaHDw1gB79mTddjxMkVoxI/fAm0kxFEQ/MFLSaNjWC1irGLzOz8op648FbyhF0su/hIFaQ+qgTIi70aiQcDD0Qc598rL80IXdtFQMee4EeirGoX9cF+l9SKEqWdZ9KoI9t7Zs03K+9geBIEhp6iZfOV2QyfLRMFQd4nZ8233CcYHXoTPZXyjWW3IXWOFJFO9eWZ+BZDa0vTSisal05lO4YvV/LO1RKzHYyBKgajeP3JMfaT3nKOy/791CH07DT2rl75JWW51ck62XFRYTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB2999.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(366004)(136003)(346002)(376002)(66556008)(66446008)(66946007)(76116006)(316002)(91956017)(54906003)(71200400001)(8676002)(5660300002)(8936002)(86362001)(66476007)(478600001)(6916009)(4326008)(64756008)(36756003)(33656002)(7116003)(83380400001)(2616005)(6506007)(53546011)(6512007)(6486002)(2906002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ka4lI5GV4rfvAljj8Kq4B6mnV9n5tWKm1aeN/7JOPl3wuN75+xLHrZPSLygi2XOBX6mFlVUeTh0HKLUz0gfiej7+Sqy1mGtb0z0PzSUP7PKPMZRPKAMGZVFV6JOpri0TrT0D8hBR5/6tan4/J9nEB1pByQpTX/cOPK98uvXBVT2cUNDfU/R3dnLh1eDoVKn8Tk/LRVgS1G6+0qZYbtU2P2VVqWeOfb39f7mY1IFCnDPms48Gf4R0R4IaRq+1kJY6xQoaZVO9pxzxye2x4Eu+coyj4St6Hi8r0SG5jVpdbOg3Xzz/Afam9fXHHHZr5NVahLoluupzgCZaRf8fNkePtR19Iab4BqHwN8QLGGu7RPquuvgc91Cn/YJ34aGHinkiaHd4SXgCXH1PEjctVoJR2mJ31TdUOQeb77MMKfiYx0k02S2j8OyautbKKbqYtxWRPrwP7ar7WIs1VOpZfENU5M0TgIJ+YOqdnmhduScxPwWId7zzCiN+SzNuUs2xgF8filxn1X+MIzErwPOICwecghSu/eRaGpNyVHP26wFQXjIB0JAJJXaVkfKseGC9N49K2aTHTS/e9Bnd2uj4gqAEpkBAZPFkKelr3URVSnJp90fYDxixq1Xq5Y4ulmShYq0Qx3EkxiekzfkqorkPbm4ZFVTmxMaAFMTlicxd85FrNcp7sMsizNodrmB1YPenfh5T
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1717846567BDAB40AC8A6971DECD9B0E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB2999.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f316ec0-6870-4b9f-69da-08d8605647f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2020 06:51:36.2629
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZvnAyOT8uQbKawFfFLVihhkkrjvyOPx1+tf3g4XzBc2tW1k0DABikJXeqv+YRdiWFJIOKs7kAJ3f3rINzacbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4119
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_02:2020-09-24,2020-09-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 mlxlogscore=996 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009240052
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 23, 2020, at 7:26 PM, Alexei Starovoitov <alexei.starovoitov@gmail=
.com> wrote:
>=20
> Hi Song,
>=20
> the latest bpf-next has 100% reproducible splat:
> test_progs -t stacktrace_build_id_nmi

After a couple hours of building kernel and rebooting (this cannot=20
run on qemu...), I realized I cannot repro this reliably. :( It=20
happened once on one kernel, but not anymore, event on the same kernel.=20

From the trace, it looks like an A-A deadlock. But I think it is a=20
false alert.=20

> [   18.984806]
> [   18.984807] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   18.984807] WARNING: inconsistent lock state
> [   18.984808] 5.9.0-rc6-01771-g1466de1330e1 #2967 Not tainted
> [   18.984809] --------------------------------
> [   18.984809] inconsistent {INITIAL USE} -> {IN-NMI} usage.
> [   18.984810] test_progs/1990 [HC2[2]:SC0[0]:HE0:SE1] takes:
> [   18.984810] ffffe8ffffc219c0 (&head->lock){....}-{2:2}, at:
> __pcpu_freelist_pop+0xe3/0x180
> [   18.984813] {INITIAL USE} state was registered at:
> [   18.984814]   lock_acquire+0x175/0x7c0
> [   18.984814]   _raw_spin_lock+0x2c/0x40
> [   18.984815]   __pcpu_freelist_pop+0xe3/0x180
> [   18.984815]   pcpu_freelist_pop+0x31/0x40
> [   18.984816]   htab_map_alloc+0xbbf/0xf40

Here, we access head->lock in htab_map_alloc.=20

> [   18.984816]   __do_sys_bpf+0x5aa/0x3ed0
> [   18.984817]   do_syscall_64+0x2d/0x40
> [   18.984818]   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   18.984818] irq event stamp: 12
> [   18.984819] hardirqs last  enabled at (11): [<ffffffff816953d4>]
> get_page_from_freelist+0x1314/0x6190
> [   18.984820] hardirqs last disabled at (12): [<ffffffff837e527d>]
> irqentry_enter+0x1d/0x50
> [   18.984821] softirqs last  enabled at (0): [<ffffffff8111011c>]
> copy_process+0x147c/0x5c10
> [   18.984821] softirqs last disabled at (0): [<0000000000000000>] 0x0
> [   18.984822]
> [   18.984822] other info that might help us debug this:
> [   18.984823]  Possible unsafe locking scenario:
> [   18.984823]
> [   18.984824]        CPU0
> [   18.984824]        ----
> [   18.984824]   lock(&head->lock);
> [   18.984826]   <Interrupt>
> [   18.984826]     lock(&head->lock);
> [   18.984827]
> [   18.984828]  *** DEADLOCK ***
> [   18.984828]
> [   18.984829] 2 locks held by test_progs/1990:
> [   18.984829]  #0: ffff8881f52958e8 (&mm->mmap_lock#2){++++}-{3:3},
> at: do_user_addr_fault+0x1cd/0x821
> [   18.984832]  #1: ffff8881f6e39e20 (&cpuctx_lock){-...}-{2:2}, at:
> perf_event_task_tick+0x12b/0xc90
> [   18.984835]
> [   18.984835] stack backtrace:
> [   18.984836] CPU: 0 PID: 1990 Comm: test_progs Not tainted
> 5.9.0-rc6-01771-g1466de1330e1 #2967
> [   18.984837] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> BIOS 1.11.0-2.el7 04/01/2014
> [   18.984837] Call Trace:
> [   18.984838]  <NMI>
> [   18.984838]  dump_stack+0x9a/0xd0
> [   18.984839]  lock_acquire+0x5c9/0x7c0
> [   18.984839]  ? lock_release+0x6f0/0x6f0
> [   18.984840]  ? __pcpu_freelist_pop+0xe3/0x180
> [   18.984840]  _raw_spin_lock+0x2c/0x40
> [   18.984841]  ? __pcpu_freelist_pop+0xe3/0x180
> [   18.984841]  __pcpu_freelist_pop+0xe3/0x180
> [   18.984842]  pcpu_freelist_pop+0x17/0x40
> [   18.984842]  ? lock_release+0x6f0/0x6f0
> [   18.984843]  __bpf_get_stackid+0x534/0xaf0

Then in NMI, we do __bpf_get_stackid(). So the deadlock happens when
__bpf_get_stackid() is called when NMI interrupts htab_map_alloc()
of the same map. This should never happen, because we only use=20
__bpf_get_stackid() after the map is allocated.=20


Without a reliable repro, it will be really hard for me to pin point=20
the commit that introduced this. I guess I will need your .config=20
and/or test machine for further debugging.=20

Thanks,
Song

[...]

