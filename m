Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F393F1E46
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 18:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhHSQrN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 12:47:13 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36970 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229474AbhHSQrM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Aug 2021 12:47:12 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 17JGdaoj011486;
        Thu, 19 Aug 2021 09:46:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=KKWD3ri4iirLj+Zpcnw/CAZMNdgJvEVctAzgPxUzrz8=;
 b=I3BTJ5GGthBC6uF5rAMGeRkfWv/BwWZ7vXyE9fOlA4n5xXonXBWAq7qwJarQtiZgOPNI
 6n7Vjj6nojfM674qII8PNgB2Td5lRlkZHSIMzFO0XTp1FMrZXMVmZVyH4KN7ibXqdgVf
 sBHXJdCH6yPDyq1l2ZpQn9JcIXYmXe0EL2I= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 3ahme42m23-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 Aug 2021 09:46:22 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 09:46:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f1WhAhGHd6hpco0ytxvgnpyy4HxJWUmCGMGVZIuvfyJ4tatzUrVzOF6qNstqb0iGrQpDtk2Sahy49mR6YStxCEO9+W25plAnqxtuTd7tE2CpFiupAgHcd0G/9wDK1L1aM1bW7dARbAMrcGhqAp8cZE9effn8s/6SlMWoe1GxblJZzKJFM4pbQF6Jwq80MuNmDaE/0Fk+FZoZM8Ei3wMfRRCIYZHnUWVPR7b9Mk3iqgw9x/VHtcVtJoVenRqDLomfi2v0msv62lOclXFrvUUzAwj+6i98MxDJkkRGQhEQlzwSHENs/V9tyM07TvTvrXhppv2gWAS68WPFMbcc4ys8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKWD3ri4iirLj+Zpcnw/CAZMNdgJvEVctAzgPxUzrz8=;
 b=Lc/0UiSmhEvuS81mQQWY11/xW33yq9i5Rtp7ORjNjWuujD5bimaG6gKupiEfPRWw7QEBgDXks/QMld/DPxZlEkYKtV2Andh5I8cV9XxLmUKyMtls1JqYJ5LQrgX6P/x5wZ4w9NE9af1ulfGRJOela2cq4JBF+wMuReBY7wVRVHv+bR0mS3nN3bmRfX1HFuxpiQKr3uLgoTdcS5zo7rN33FYhedkp4E7nZ9wXZVDxilvNj7zi0v/d1+e7Ph3+ldJkzvKcL58Nn+e9C7ejcdDNv+IK6+DuytpqPMNy7YdTZ1UAb71phJDBPpM2cig4KSkFro4KYZVJjEs6pSmrRwHEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 16:46:20 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610%4]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 16:46:20 +0000
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
Thread-Index: AQHXk9CX6/TyfH2Y/US67JUy/V0E76t4+50AgAB99ACAAUGPAIAAULcA
Date:   Thu, 19 Aug 2021 16:46:20 +0000
Message-ID: <AB509D87-67C6-4B7F-AEFB-2324845C310C@fb.com>
References: <20210818012937.2522409-1-songliubraving@fb.com>
 <YRzPwClswwxHXVHe@hirez.programming.kicks-ass.net>
 <962EDD5A-1B35-4C7F-A0A1-3EBC32EE63AB@fb.com>
 <YR5HJkPyaM3TWkkl@hirez.programming.kicks-ass.net>
In-Reply-To: <YR5HJkPyaM3TWkkl@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1db20c1-9500-4677-7371-08d96330df84
x-ms-traffictypediagnostic: SA1PR15MB5109:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5109B2BB6AB9190102E8B9CFB3C09@SA1PR15MB5109.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4ShVtQLWMtDtvqVZorQwdzeXOiekauwK31G3ZP05dfR5XkRHd0GrMCDhVUyhggSweFjWp1qlnduBXTGudMKi+P8DVUNFm1UKASNEDbP1vBVJqHBz9yRjHDQWEnffwCRCFa3nVdErQ2MSEnCot54x6ckyaSBVQs+XXJLxvOcrCBZtUHGGsZCi8tCynbCPlP4DYyuyEor7SNKJkL28vJxPO8AZcYyASRXnvx8aT7po4AkWLmL/8z06OUhjwmU/ij8oV6Q8h19A2M6jVu0Z61oKs/A57KzncER3IAwMQIgyy7i42VYTRf66parHmRkmTBv0w+dG3Pive3j4ZsF8oMdHcuVWXvcK01PYslW6+GT2wi8H4jhoiG6OaoqdGZDYlLVZUbcurFGb9UBzOGSe6dpsYyU+cXChsp/sUNJ9a9GVBj6cWqqPjmmCg1a+koAXpju2g8B92wrOfjNwy5sw8lO/nrAMUgjxoSOfhLfxwCslT3Hd0fj1TimcBf0ArUSLMn11+cvEpm0xEuxmrKtpPlBvtwiixvpJIUUAMNpmXDTOHDRnm+2y1w3m+mRcGm7F9mnP0XcP2WKdUgh6micW54DgieAfQtiHnrydq4zCRXRM2N9AfbKOTkVpiochztg91M7TvCSYheObkttBRbAx0b2D7t1qjMRKAsfEy4H00a/+HPh4/1QL3St+DzGBNAivIabvNttYYuPFwSwNxxb+pr5WJx/vFBikZyjwDKCVzVvKJCqp5SBgPQv8ovfAvvh9pGZOTi5VWunZ3mSOLCPakBTaXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(346002)(376002)(39860400002)(2906002)(64756008)(86362001)(66446008)(66556008)(66946007)(66476007)(122000001)(38070700005)(71200400001)(6916009)(54906003)(8936002)(36756003)(8676002)(91956017)(5660300002)(76116006)(316002)(38100700002)(478600001)(186003)(33656002)(2616005)(6512007)(4326008)(83380400001)(6486002)(53546011)(6506007)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tQ/cEH9hvDvp6f0xMU236ftmSYNmY3fZq+tsOZ4aUbkDfEyMp12kUTB2mOIc?=
 =?us-ascii?Q?SMuQyfnMs0k0+qjCe73bMlq5vKr39dNz28Cq3oYLM4gCq/vyrt40Sc9iJj5h?=
 =?us-ascii?Q?+6vB+/+FVpVs1wyTkElnaBhwDm09GLA/DQeLLrCJmaE/vYnw1sp4KhlSSB63?=
 =?us-ascii?Q?zFhywui5fJZ1UmYhcscUUTy/iXdQPNt4sgsAV+8dVPcBtrfx31m6L+nKGWeB?=
 =?us-ascii?Q?XRJQVI3DRTjPxQuPz28uCyipGrzUBGntQZHp0nmY0e3R/NIoKOQikGV7jKC1?=
 =?us-ascii?Q?fXS/GOtqTHno1bpNwNsQDI5ufEDkcUuVCW3084te0QrFNm0uaE+4726S0Jo4?=
 =?us-ascii?Q?0QYHKc05gmAZbfdHYgWBGY+Ise0irH283Xqu9Qv2DGqhDFcl71WnWuHDcp9o?=
 =?us-ascii?Q?Mxiz6CiC/QBYm4ThJg1o7aAk8IUP3zUuxXdVgs7ucsFtjba+L2x9zEOEVq3t?=
 =?us-ascii?Q?aHRdYghH6waacRAv6ipL3rJd9WyF3g9AAJYwnuxZcFzvk1aAwGNEDEa5Bky4?=
 =?us-ascii?Q?9NjA8aS5XO7OOFc11Xuea48WiBqLcStQ0BVOh9UT+d5IGLj8dsGAC4Yqo1Hf?=
 =?us-ascii?Q?QDLN1ynZJ/khN0T3XO7WrV6et6irLH5eTOwN7IRTU40ln32uLTdS1kNGBEgr?=
 =?us-ascii?Q?t8eWVmeb3V2mJ0sKAeomXQsNAoXak3B2nAB8migvtNN7XYhZnaBoDf6JZcJc?=
 =?us-ascii?Q?86gOjoQrK6CtdqBGeWXlApUafn6YJdyB6QFQgm6GRpIRrab75Tczj68eKeww?=
 =?us-ascii?Q?ADHy4guxgApYx0UKDrZrnoB2LeHn8L87HyRirn9COqs81DYwtLggbyH1RslX?=
 =?us-ascii?Q?wMyuU0cal0oKJqESrpVRZWvRyUH9VsYW3Oa8pE4fZMRy4Uh8S72Mw9Qg5bD9?=
 =?us-ascii?Q?1ZXkwcKZg86CoeHjxlIansiEGz8BU4WQo2IGg4sT0HIHVb/qiO69TTw82Qvc?=
 =?us-ascii?Q?QCrQmC+IEhkogSvq2St654RQVaqiAgeUyGj85IdoTeMqpduu3d/6sBdjXtuP?=
 =?us-ascii?Q?wvEFWl1+Hts36IC8SYWy5FQ5pUVONKT0WNgtN46ZNEW3IHi7WfW6xiLqzp5R?=
 =?us-ascii?Q?6hQBl072dd3hFH8uOtACb2TQobPmDyN4cs1TjhRYllJeQjPGnpr3vZwyG1ER?=
 =?us-ascii?Q?NRb5HnBblONfg8uXC2XiCpvUJYq2By9ma5OSqIoY/sRS0RxvgjQBqmLxv3z9?=
 =?us-ascii?Q?BwiJGYGPlHrKQG2MnQI1ArIvnAMXzrLbJc5XTNWQ5TxKRBcVnbNYNA78j50W?=
 =?us-ascii?Q?0f5dsvDDf+vpPrxf0t5wG/NlyNbkK7EWyGrTzYp+Vcg6020JPYMT+F+7FS2U?=
 =?us-ascii?Q?svnR+h8tc3R5a1vhh+zTBVS0l5bmPg4mO5NuJHgy9Y/u4xkFifjqa2/4dbpN?=
 =?us-ascii?Q?CqMubSU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5EB047D8049ECE4DB6EACB142C035AB6@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1db20c1-9500-4677-7371-08d96330df84
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 16:46:20.8697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cVTScJCof8D4IjHIpVrYXvyFBoTIfppS/TwkFNATuhjpron1bDUlaWHcDrgB2wQfW1fn5cFx6UJSwHT17L/ohg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5109
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 6DA5O8DGHB3kVqsJmyN002WoLAHZtlAm
X-Proofpoint-GUID: 6DA5O8DGHB3kVqsJmyN002WoLAHZtlAm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_06:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=799
 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2107140000 definitions=main-2108190098
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter,

Thanks for these helpful information and insights!

> On Aug 19, 2021, at 4:57 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> On Wed, Aug 18, 2021 at 04:46:32PM +0000, Song Liu wrote:
>=20
>>> Urgghhh.. I so really hate BPF specials like this.
>>=20
>> I don't really like this design either. But it does show that LBR can be
>> very useful in non-PMI scenario.=20
>>=20
>>> Also, the PMI race
>>> you describe is because you're doing abysmal layer violations. If you'd
>>> have used perf_pmu_disable() that wouldn't have been a problem.
>>=20
>> Do you mean instead of disable/enable lbr, we disable/enable the whole=20
>> pmu?=20
>=20
> Yep, that way you're serialized against PMIs. It's what all of the perf
> core does.
>=20
>>> I'd much rather see a generic 'fake/inject' PMI facility, something tha=
t
>>> works across the board and isn't tied to x86/intel.
>>=20
>> How would that work? Do we have a function to trigger PMI from software,=
=20
>> and then gather the LBR data after the PMI? This does sound like a much
>> cleaner solution. Where can I find code examples that fake/inject PMI?
>=20
> We don't yet have anything like it; but it would look a little like:
>=20
> void perf_inject_event(struct perf_event *event, struct pt_regs *regs)
> {
> 	struct perf_sample_data data;
> 	struct pmu *pmu =3D event->pmu;
> 	unsigned long flags;
>=20
> 	local_irq_save(flags);
> 	perf_pmu_disable(pmu);
>=20
> 	perf_sample_data_init(&data, 0, 0);
> 	/*
> 	 * XXX or a variant with more _ that starts at the overflow
> 	 * handler...
> 	 */
> 	__perf_event_overflow(event, 0, &data, regs);
>=20
> 	perf_pmu_enable(pmu);
> 	local_irq_restore(flags);
> }
>=20
> But please consider carefully, I haven't...

Hmm... This is a little weird to me.=20
IIUC, we need to call perf_inject_event() after the software event, say
a kretprobe, triggers. So it gonna look like:

  1. kretprobe trigger;
  2. handler calls perf_inject_event();
  3. PMI kicks in, and saves LBR;
  4. after the PMI, consumer of LBR uses the saved data;

However, given perf_inject_event() disables PMU, we can just save the LBR
right there? And it should be a lot easier? Something like:

  1. kretprobe triggers;
  2. handler calls perf_snapshot_lbr();
     2.1 perf_pmu_disable(pmu);
     2.2 saves LBR=20
     2.3 perf_pmu_enable(pmu);
  3. consumer of LBR uses the saved data;

What is the downside of this approach?=20

>=20
>> There is another limitation right now: we need to enable LBR with a=20
>> hardware perf event (cycles, etc.). However, unless we use the event for=
=20
>> something else, it wastes a hardware counter. So I was thinking to allow
>> software event, i.e. dummy event, to enable LBR. Does this idea sound=20
>> sane to you?
>=20
> We have a VLBR dummy event, but I'm not sure it does exactly as you
> want. However, we should also consider Power, which also has the branch
> stack feature.

VLBR event does look similar to the use case we have. I will take a closer
look. Thanks for the pointer!

>=20
> You can't really make a software event with LBR on, because then it
> wouldn't be a software event anymore. You'll need some hybrid like
> thing, which will be yuck and I suspect it needs arch support one way or
> the other :/

Yeah, I guess it could be a "LBR only hardware event". All it needs to do=20
is to keep LBR enabled (lbr_users++). I will try to keep the arch support
clean.=20

Thanks,
Song

