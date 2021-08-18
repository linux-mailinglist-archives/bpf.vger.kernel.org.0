Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699BC3F0982
	for <lists+bpf@lfdr.de>; Wed, 18 Aug 2021 18:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhHRQrW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 18 Aug 2021 12:47:22 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:19532 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231553AbhHRQrU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 18 Aug 2021 12:47:20 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17IGhmZW021888;
        Wed, 18 Aug 2021 09:46:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5xhsGA82iucfNlwBPz9n6Pv1ZVmQ30eqBi/ctgvQhh0=;
 b=KBi7VsvvLg/jVJ3uERgwJTs6HWp67NXJlzUZW4epyPuj9r61dv3jfczjovW/+IUNVqIq
 bcSJjLar6whyGLvRFduXoEcnIA4PPKy2IzczxCgdRxnMilEh66g3b64vaV17O/+jqIvm
 4YiWj181p/wsHhCN73LDm3h4eEWd2cky/Rg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3agpvq4qqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Aug 2021 09:46:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 18 Aug 2021 09:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jZdpg3c7UZVqY7EfKcBJwNi8CmbS/JXBkWUFXOuA8b40m9Hv1sDaXJa0/IiNO2Z2E7hD36vMKB31dWRpvn31dWwX0DXaIRWextGNA9xRlzaCwZUC90vFiHmXd9r2aQvQ5G/aHfNpamKP4H6Rv/milodpkJAA7H8ESVdRtst5oqwwDp+JgIvlTnmDc2zMymIgpBwYDU/IIQt7PAcjJB7Rg79RQ3eTS7ZHvHp7BBi7yGnYoFR7hCqTQev2xtuyoUT5qKRzcECchdb1BhUrDK/bXYuiCkiZpCatRrPz1KJe6Oe9OnaESc2wbgN1JDizWIGF63k0bSYk+fpm/VNJNB/YXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xhsGA82iucfNlwBPz9n6Pv1ZVmQ30eqBi/ctgvQhh0=;
 b=Lu9tRe1p6cCLINQCCqi7YpmmYqk+fSEPUZuxJDHo45JtkSxEEn2xo5OdFpViuHYeOPubdbQDXz7MCZAY2yReREA8BQvtFCYN8htmJvuXRI+FXRbCftJojp9BEB1PU2BHGVkBnXsCpB3WaVtHpUp3Pco/Ib2N1gJSHa/1408AtwZ4ZATcci7GZKeaJIYHXpz0XzOxb13uy+jyxsdhVYEyfkC4F1CdblTg8GBxnYlEVc3yPsYn+yxS3dsJcmuV+vh8OLPVarVCQjkyCvug+texaVas4XisqTd8RfFAHWQQjaaaZs0F2RTBcIC85lEkNJmXBTvp8fCnRQGvEgB17NecUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5093.namprd15.prod.outlook.com (2603:10b6:806:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Wed, 18 Aug
 2021 16:46:32 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610%4]) with mapi id 15.20.4415.024; Wed, 18 Aug 2021
 16:46:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "acme@kernel.org" <acme@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Kernel Team <Kernel-team@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Like Xu" <like.xu@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: Re: [RFC] bpf: lbr: enable reading LBR from tracing bpf programs
Thread-Topic: [RFC] bpf: lbr: enable reading LBR from tracing bpf programs
Thread-Index: AQHXk9CX6/TyfH2Y/US67JUy/V0E76t4+50AgAB99AA=
Date:   Wed, 18 Aug 2021 16:46:32 +0000
Message-ID: <962EDD5A-1B35-4C7F-A0A1-3EBC32EE63AB@fb.com>
References: <20210818012937.2522409-1-songliubraving@fb.com>
 <YRzPwClswwxHXVHe@hirez.programming.kicks-ass.net>
In-Reply-To: <YRzPwClswwxHXVHe@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f226e77-f388-4ff5-d2f0-08d96267bc36
x-ms-traffictypediagnostic: SA1PR15MB5093:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5093B840AB7B54DFCBC46928B3FF9@SA1PR15MB5093.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gOFp3Vhsq9QFdX5PTPADxoVFElK5oDdnyEMG7cuYrX8UmX0j95R54ooc3v75en//rDOYXCDLSHaR+bfiAl/fRoilAT9vPb5a+v3NuS9V7qxq8q4yrnIlzk2+YyGT25lCwjvqw6CUvSg6KyqpdISrOdwDlGiAtN6fXutVgDGdz68RW5KLS19putlsQu1h5PdfmWxz7LTsV8gmGBvlSoPSx4VqpvWquTwKLdEf7t5c4DcoesEhJDGS0XEzTdOHh61WRB8iuLGjQwgrF+u7xJFANDtQ1LT4CxsZLNDYD7JY4Ua2/USb2BxkO5yFPhIxE4pcxk0OC4+t6xzyZC1WTG5aqPxdJSsEnwUj8s0Hq/IpG3YtIgBNLJptOKuYgwGeJo0fZv9MRXAzvGZxpUU0xPTKutyahWD5xM20BaHhWETQl2cswX1Z2VeAzOeSRiyc3o5xUch+4PEmwYa79lICrr23P4h4mOTsDM5U62k00HABYBI57dD3okLr3sg+EhddyImt6lXcvKzHSlL8t0p+nDnr2rOBiRAxwrzXqnn4FvHAP50wHg2eloIICNc2McTi/t/b4DrE7eL8iqvuSI6SGciAOpkSDq9xRfneRo3XETWlpL1Xkluafx49hYpiyj2fTbfOREDSqxh/SYkTmn2i7uN1CQkjV+UJiC4HNdX/fDplglI/HxmKVXBVpPn9bWxK2mM31VqoXZCRWWEtlhk0FJnkkfua0ckZJINGZ+e9FJBFj+s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(5660300002)(66946007)(186003)(76116006)(6506007)(91956017)(66476007)(66556008)(66446008)(8936002)(2906002)(64756008)(53546011)(8676002)(2616005)(122000001)(38100700002)(38070700005)(6512007)(316002)(83380400001)(33656002)(6916009)(54906003)(86362001)(71200400001)(6486002)(36756003)(508600001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EX72C7RB7j3y6G2B+6ZKTzh9AEWhEtie03s5tyA2JTHjPvUy91ZA/lmlXD3N?=
 =?us-ascii?Q?7JCZ7e3fo363MCRIWt8A6J8Vk8yZ6oJ+R4dtQlIqmx2jjIISm5T3AvKEAduu?=
 =?us-ascii?Q?TA2Jm/c4Ut3AJLCdWGNYFexP1L038e1CL8BmiQmG04tM1mW5NhAY+aer64Iq?=
 =?us-ascii?Q?NVysAoXF3pFug0tVN10ulKMKIKvlG8oMmDHtblLvLey1/12AVX4pKLcL6Cz7?=
 =?us-ascii?Q?Rw0gP4RW0sYN5mG4lECYnyESgpNDKNWZRjsdQ6beMCApanjimzqdR/5ZKl6s?=
 =?us-ascii?Q?Lo0Cw64sjcC7FZEwwLXq7V5zdT7i4tXoiSrK7FVTaLV8TKIb57il0yxR2c0g?=
 =?us-ascii?Q?8XIadt34PK3fQE6ixsV2D6cnIS+earAhwwzLmbiegPvCBcku94cSSj0R5TgM?=
 =?us-ascii?Q?Xz6TtDXETz0c/uOSIxqGgWQmBENKXEE+YHGbQ3dyXtUjTLpL8CNRBAFj9wAt?=
 =?us-ascii?Q?53sOJc5bD1Mbv8ioBg7vTV92A46rYp0yGWezjszHZMEpFZRVLfr2qffukSiO?=
 =?us-ascii?Q?Sfwhvf6ycqEZkgjTbUwKARQicGSRZedTJCqKYGL34eJEzpgRYSyTI+05Rtxe?=
 =?us-ascii?Q?cTBH46eL8i9vqCucw4fURIB5RDrQJPYJPciTudhfmH0rl6G11Frl0DpGLP57?=
 =?us-ascii?Q?H2Q+bWDc96MJ3w9zM3DsiO+BmjBmojxbgO2EMwJjTP5sNb49cb3kS42DoXGZ?=
 =?us-ascii?Q?9UIuDfsivHo3be4bs/QMdsQEkDjF5I4wKQtE8KB04jm8T0ZrLUUpJcNASvSj?=
 =?us-ascii?Q?OhMJSLkHLfoMjkGQi7DTL7MBHEKnjns8tKye3PtRTBbJZ0b0hiQYL8PXIpxb?=
 =?us-ascii?Q?dhfQ4fHcPfEJeWoaiTt7paTl/gcSjQiosjdnPoosF3uSmFyQXDVWHm7MMHB3?=
 =?us-ascii?Q?M8G5YkWkm/Ut8gTvYG/3PGWDtSvYbXZwnJmrYAC2ZeAxmY+B6C/vOXhaCEke?=
 =?us-ascii?Q?nr0coA+e0VksYGJKSS7xfQrgHCruOjDyuEMju6TVp8ECXUOOT3vkKLhT9Z9E?=
 =?us-ascii?Q?rSBxAqGSxIAzGG3t+FBWeQk5+YH11CsW+7nZ7kAMtrq0YAwHjorhx4Ay0zvD?=
 =?us-ascii?Q?EAzRQUlwpiF7WCIsyAbP7f9VyMFztaaLH7e8BOe0SGZTqNsg4wxK3KvUT7/M?=
 =?us-ascii?Q?0CTmgcDzJpup0qBEOmPp8pbj3adL1CvicSmv3UT4RgOjPFdD67FMxBhbWq0n?=
 =?us-ascii?Q?aHlgDTZtllEWVolYqekdFqQ/9Ck5bBbNVufqfu+R6Dzyp5enfYgm65YldUbW?=
 =?us-ascii?Q?NV8ynpeREP+FGG0ckKhUm1k9Y+SMWeMZoyiTNRQ5whFDahL2DKustuF7ke7s?=
 =?us-ascii?Q?2qGmOR8bu/MfNah1PS5WobZae3VD2QFmzooAN01tr+Rfts0TC3TRosmu0SV7?=
 =?us-ascii?Q?2gdtiVA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <295115F76CB0EC4290BEFCB50090C15E@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f226e77-f388-4ff5-d2f0-08d96267bc36
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2021 16:46:32.7194
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N83iesazeFrbDdb2P4bcdDLotJmt4G91I44NOXB1pfySld//r055r0oGPoIDvoCoVJqsmGbx08kKQJO++bYZMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5093
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: BdZu-nmyALN4b3a1-B_8UcoDaMr7gcQJ
X-Proofpoint-GUID: BdZu-nmyALN4b3a1-B_8UcoDaMr7gcQJ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-18_06:2021-08-17,2021-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108180105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter,

Thanks for you quick response!

> On Aug 18, 2021, at 2:15 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Tue, Aug 17, 2021 at 06:29:37PM -0700, Song Liu wrote:
>> The typical way to access LBR is via hardware perf_event. For CPUs with
>> FREEZE_LBRS_ON_PMI support, PMI could capture reliable LBR. On the other
>> hand, LBR could also be useful in non-PMI scenario. For example, in
>> kretprobe or bpf fexit program, LBR could provide a lot of information
>> on what happened with the function.
>>=20
>> In this RFC, we try to enable LBR for BPF program. This works like:
>>  1. Create a hardware perf_event with PERF_SAMPLE_BRANCH_* on each CPU;
>>  2. Call a new bpf helper (bpf_get_branch_trace) from the BPF program;
>>  3. Before calling this bpf program, the kernel stops LBR on local CPU,
>>     make a copy of LBR, and resumes LBR;
>>  4. In the bpf program, the helper access the copy from #3.
>>=20
>> Please see tools/testing/selftests/bpf/[progs|prog_tests]/get_call_trace=
.c
>> for a detailed example. Not that, this process is far from ideal, but it
>> allows quick prototype of this feature.
>>=20
>> AFAICT, the biggest challenge here is that we are now sharing LBR in PMI
>> and out of PMI, which could trigger some interesting race conditions.
>> However, if we allow some level of missed/corrupted samples, this should
>> still be very useful.
>>=20
>> Please share your thoughts and comments on this. Thanks in advance!
>=20
>> +int bpf_branch_record_read(void)
>> +{
>> +	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
>> +
>> +	intel_pmu_lbr_disable_all();
>> +	intel_pmu_lbr_read();
>> +	memcpy(this_cpu_ptr(&bpf_lbr_entries), cpuc->lbr_entries,
>> +	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
>> +	*this_cpu_ptr(&bpf_lbr_cnt) =3D x86_pmu.lbr_nr;
>> +	intel_pmu_lbr_enable_all(false);
>> +	return 0;
>> +}
>=20
> Urgghhh.. I so really hate BPF specials like this.

I don't really like this design either. But it does show that LBR can be
very useful in non-PMI scenario.=20

> Also, the PMI race
> you describe is because you're doing abysmal layer violations. If you'd
> have used perf_pmu_disable() that wouldn't have been a problem.

Do you mean instead of disable/enable lbr, we disable/enable the whole=20
pmu?=20

>=20
> I'd much rather see a generic 'fake/inject' PMI facility, something that
> works across the board and isn't tied to x86/intel.

How would that work? Do we have a function to trigger PMI from software,=20
and then gather the LBR data after the PMI? This does sound like a much
cleaner solution. Where can I find code examples that fake/inject PMI?

There is another limitation right now: we need to enable LBR with a=20
hardware perf event (cycles, etc.). However, unless we use the event for=20
something else, it wastes a hardware counter. So I was thinking to allow
software event, i.e. dummy event, to enable LBR. Does this idea sound=20
sane to you?

Thanks,
Song
