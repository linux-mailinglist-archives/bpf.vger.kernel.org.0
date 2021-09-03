Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43BD34003C2
	for <lists+bpf@lfdr.de>; Fri,  3 Sep 2021 18:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350174AbhICQ7O (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Sep 2021 12:59:14 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10412 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350181AbhICQ7M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 3 Sep 2021 12:59:12 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 183GtXhc009497;
        Fri, 3 Sep 2021 09:58:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=kTvq1P8yvMV7rGpzlZxOjUpjJVpjtLA989u/9fXGYa8=;
 b=AHM9ztowR8jdLklMzITDsWIjbV0QLkl9+is+Y4dgQdaXjpLQYeKUi31VzZikxcK0DsbO
 e/KIhpib4XNhbU3OOrBKh57B6e6AbmXKArUg0XI1/IQcwyIHb0967IkK44JKcKadxFzz
 BAFc8WPqlSHi1C1hQ4j/kQ7Kc+K5+2YicU0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3aubk05sw7-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 03 Sep 2021 09:58:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 3 Sep 2021 09:58:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VdWOc8leqrC7O6DYJcht8nGf5XT1xNo8vg9M6BoY3sbjXbuwGTv/LzGGxrsTZ1dtGAWHO3JPd1jhE6eO57j15nhWoDuJ3XLa9ktqbkdWCnkIhOiHMQLnntLnYfG/Z7+Cfev5fZmff51CLTLM/Vt/kDI2EwFRUVg63vvFjeVnZocYTxTkofEnDnDDpKSNfdCIyRhlCaOWQpcSS+L76UyELj9DrtH62+Ay7QG7mmLDmP/yBAbSfoVjhRn2vQuPZ10YFtS/ZTF+q0S+u4Bbm+MOFjGHCCWLG0XuvdkpkgBWjBatCGrXFplUzHonsfDIFoQpFzH5DS7ZR5SKm1rHpZlrhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kTvq1P8yvMV7rGpzlZxOjUpjJVpjtLA989u/9fXGYa8=;
 b=iIK7GfrX1WYkD/9oAVzd4xasqXwyq/XV+5NCCFiF+FnGrqt6wrVAqJdGHLcqSEzZZE/8Lx9qL17yQggFu3OeGN2EKM/upK4yt6bM4bAKekQfJ04AnrPrGZo9pZatCRmCbthOnUFfYplGDLENFN8HjtTfWtENOkTDxLYD5RToDH8qjYATiz5SUSnJ9e9Nzz8YotmJbwsfMNS8tzMrPZcoFYojniIloM0qWjVxxoFvfXn8eoxp1CasSvkU1X8dyxK6ekZnkZlnzahx9i6UZwaOlm0ibHkhUIplgcQ2rSYd1wmn7ZIUpV4mfN9IBPY4WiFU85oijIRyvKqkDx/oRU8KCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5078.namprd15.prod.outlook.com (2603:10b6:806:1dd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20; Fri, 3 Sep
 2021 16:58:09 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 16:58:08 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     bpf <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "kjain@linux.ibm.com" <kjain@linux.ibm.com>,
        Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Thread-Topic: [PATCH v5 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Thread-Index: AQHXoBucwnw6xFDotUqgbr6c5GY6BquR+wAAgACOhgA=
Date:   Fri, 3 Sep 2021 16:58:08 +0000
Message-ID: <3933B95E-9FFB-4A8C-8691-82AE8CD77514@fb.com>
References: <20210902165706.2812867-1-songliubraving@fb.com>
 <20210902165706.2812867-3-songliubraving@fb.com>
 <YTHcki5RLZIIGqbk@hirez.programming.kicks-ass.net>
In-Reply-To: <YTHcki5RLZIIGqbk@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6dc97563-9558-4d8e-8922-08d96efc01c0
x-ms-traffictypediagnostic: SA1PR15MB5078:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB507873319AFAC08C88F1DF15B3CF9@SA1PR15MB5078.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7sM3br7VG8xNcSHLCurtTqivwNNLxQeAWYyFmMTOb6MY2RPZVO0FTiL5h0J6+9LE/mOpQvUbknMvk2PlWJk7awUp2ukc+n0tbkoP/u2Uxf30QtL1VC+m6MDaK5AZ6V092aeGzn7Yv/3BvPa5d51b+6Yoglh2KnpJFs01DTQMIjb9deNFpr+Occilf7ZQ6SDn/ikkEh8G5u3bWDrNa+npRq9OPUfJZZuY8gCau4c62bpaSxEcRzzSNLuL+BIrjD9CyXp+kPSZakMJn0gXnxWEo5N8qhUNpTjrJDdp2wCg/A/+xrTzLRarGLCp1v1iCLyfYGxvIyedOSFKR3hQu691MKKwbMEMfwknPwVypM35OBJwgz4i2hTLg00fRZWG1GyDVvrcLW8ch00tGTJ50BsUhnozbj0/lUWdH8nMAV/eaN8ebW5fUr0974p60++fTg0GYl6LKSYaEM4/yDAteyjhDl9SAN8nDXostWhihgPtNWUf2YvTijJYH9RYpNDs478KcpKNdIhtBQbej+dh9p4TEKLuMPTKe6paLUawjjO2aOk7fo32l1KlkBoQWbk0Xi+YuBW95r8/kexj6IRC8rUUx6KGGqqCVpFZvN4K3eydKEH324h0SMT+dz46PeBblIY3ZejKr4oAlQpG+5BRMuXNBkq4T+NkhbsV7AAXz49T0mMLWe7RB/TdFQvihEifLgiX+5TuNj/adQv6keGOzGwAyzVoFutOiOJ3Sufk5LNLZB2+qaM6KnyCfu4GftTVkmAO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(6916009)(66476007)(5660300002)(38100700002)(6506007)(122000001)(38070700005)(316002)(508600001)(91956017)(76116006)(66946007)(66556008)(66446008)(64756008)(86362001)(2906002)(2616005)(33656002)(4326008)(8676002)(36756003)(6512007)(8936002)(186003)(71200400001)(6486002)(53546011)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TOrBUGNyQ493Px8HqvSkLUiGfjdAYiYMp0vfwSQ9GyR4NI1n+fPClUvSS7An?=
 =?us-ascii?Q?2wu9goMF+kQznEJA7+XljsJ9n/9p6JzoCYptDpaGKGD3yN/EeBky6mb0zU8K?=
 =?us-ascii?Q?MNUXq7gAj6KvLpAVSA8KzPtdLE7er+Y3okPbPUIwYx4tjL7LdGNSk5nIJUqK?=
 =?us-ascii?Q?vFrQ2p806YUcnmEbousy65KA8L7B5LinmniNSEziEuOAAA+qX5bFIuhecYsX?=
 =?us-ascii?Q?EGiI+hkUwhdxc5xCWt4eJMBcA0EU34UjxoBPYtanTpNVlh+x7fejwZulRNG4?=
 =?us-ascii?Q?YzQzGSklmvAWtZHlg7F9WjrCm/gPVf+yOL8qJoViNx6MGoVeNvfISX/XxVeQ?=
 =?us-ascii?Q?gClyeazD5koRBiQlFR3oF82bsVugqQQKMEVzWkLyugpxOPReR/j6iSUjtRN9?=
 =?us-ascii?Q?HAPNxZSeHLktsU1VSVAIeVBF3lhjKqTgCcFcOP8K2Lyc8OcYp61uuHP5hkKO?=
 =?us-ascii?Q?G2vtso/HpelRtSP62HvQ0tIYlfOMS26V8M76TOuc0C4NdEWLwfhu0V5VNBEh?=
 =?us-ascii?Q?3AYE+ydJP6hzyNz9gAZMaN2D/7BWqpuRi6KCVy2sbFdulXX8HX/Y83wwrrEb?=
 =?us-ascii?Q?vlqBiufY604goBPTkhyZxdQRA61uP1UFZbxyTrA9fc3XhUeBaqdStWKdCpFn?=
 =?us-ascii?Q?xpihvNakYuBWwNxjroqI52aR8Xx0m2nReg9MrVia5sSnkIzf3oNrAejYEtFc?=
 =?us-ascii?Q?ksbBlhaYCGFqFZrRQB2kejXruUFl5ZqjICLy1/8s5Tz8di7Adj1SJkg2DulP?=
 =?us-ascii?Q?Xc9XbciUfmIQHulnI64vT0N1iixjmTmVuEIwd8SPTzk7wXgrnXevtsbUWwDs?=
 =?us-ascii?Q?4wgm+Q0gkIak7pEXlrSdwNu7YJ9k5iM+A775bH/OjuV87IhI/9XJMVUVA/sV?=
 =?us-ascii?Q?8qK3l+lwix1NOcUgCe4wC7FrSk24V06J0nurq+Qh0py9w7p1a5Tf7YqxUEci?=
 =?us-ascii?Q?mVsEm0uJssXoOh5FZpG8kOelheevbBr6nGyE1veIdwaIwzeNQ9XHrrU0Q7X6?=
 =?us-ascii?Q?jQ6i+8u6xRwOAY9P0NzAB/BjDaQnREuvPTkm6DhZtzF/zyaEkBLkT/VSW0QC?=
 =?us-ascii?Q?5aJs6RVQUZzVMTL0PjK5oZwT5vYjEBaM+amKI6BkQ6Xy2QThfRW3WwOxkRg1?=
 =?us-ascii?Q?OrCGwgKX9VcNPmOfc5C4HTP4+vi/rHk1cz6gm6yQVi6RgsVmkZLQ3zG7MVEN?=
 =?us-ascii?Q?F/dkroKZ6s4zd3sapc5NeHdeuoADRgwcoqHD6aW/+J1Y8jRsFXto+56M1qMh?=
 =?us-ascii?Q?WH7mq/hSjSz/mu+SDx1cfvOei4pmZ6mC7dig348TOdvNit4wzV2cIWaTkxUZ?=
 =?us-ascii?Q?RKssBxHoBngP02573SLbT0EzEXu6dYv8ekHw4ukWP7UHZajaJvj0u5bbgo0F?=
 =?us-ascii?Q?gtM3WqU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C41E9A474116749983E4FE6CC00F5E5@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc97563-9558-4d8e-8922-08d96efc01c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2021 16:58:08.8700
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: edXALkgvVgRgHCsCgjq+UyEe3shK5SrZuTDG0V3synLiUkDj44HZGmH+ON3vUOtDNG1gJwI/hvIo+Fm8PNTV/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5078
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: VpDny3GaWG8M3MDSWMUW8eEh_YmfbXtm
X-Proofpoint-GUID: VpDny3GaWG8M3MDSWMUW8eEh_YmfbXtm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-03_07:2021-09-03,2021-09-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 suspectscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2108310000 definitions=main-2109030100
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 3, 2021, at 1:28 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Sep 02, 2021 at 09:57:05AM -0700, Song Liu wrote:
>> +BPF_CALL_3(bpf_get_branch_snapshot, void *, buf, u32, size, u64, flags)
>> +{
>> +#ifndef CONFIG_X86
>> +	return -ENOENT;
>> +#else
>> +	static const u32 br_entry_size = sizeof(struct perf_branch_entry);
>> +	u32 entry_cnt = size / br_entry_size;
>> +
>> +	if (unlikely(flags))
>> +		return -EINVAL;
>> +
>> +	if (!buf || (size % br_entry_size != 0))
>> +		return -EINVAL;
>> +
>> +	entry_cnt = static_call(perf_snapshot_branch_stack)(buf, entry_cnt);
>> +
>> +	if (!entry_cnt)
>> +		return -ENOENT;
>> +
>> +	return entry_cnt * br_entry_size;
>> +#endif
>> +}
> 
> Do we really need that CONFIG_X86 thing? Seems rather bad practise.

The ifndef will save a few cycles on architectures that do not support
branch stack. I personally don't have very strong preference on either
way. 

Thanks,
Song
