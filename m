Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A43AE3FCB9C
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 18:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240108AbhHaQmS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 12:42:18 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:28992 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240105AbhHaQmR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 12:42:17 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VGfK0d013267;
        Tue, 31 Aug 2021 09:41:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=+euT3+TyrxbpGTnIOsG2ZElv8eu+CZspSZGw1jzEkf4=;
 b=o+M2hsArxcYChBa2vOtQ7dvPZcpxUqKM8efZoLPgItqPzAmuCat/3femWbJIMBfJrX30
 +TOjZY2d2+8Asna7O0heS+qG4zoRAYFqYxNWquumzng1TzK77TLkeDJbr0vIAvx9ibSK
 IKzCP4duLLGEDqtzjDikBPDDaUEJ02JQbdY= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3as5pgpbjs-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 31 Aug 2021 09:41:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 31 Aug 2021 09:41:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frHHY99xI1J5B7LrxhRjtD3i+UWbi47e5cgergL6/Q0jAvplD9UPrr0Xegy9L+kal3p4vjFp481S2EiIoJS6ch2bvvaRktUtYxPvcUMwmGeENVtLORxT2MyzWC+5vjn0NuY5yrISgUlpYDu9M3FuZIvZrO3ELEREjNOiecwbbPVckd0UT8jGcz4a74zz1ckjjhLwDtKJfexkqi775NRE4evJNfb0gVkvvyhqjesJHcEWlC3Qyl1nXMQTuNc+iNrO1zeZ+Uncar18/yqzV2nWbIBIl4gNXi6OgGiQnU4w3umsl68ZPrGzc00XsKF7ZSU+8XeBQAyywIdGCU8CI3OErA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+euT3+TyrxbpGTnIOsG2ZElv8eu+CZspSZGw1jzEkf4=;
 b=bDGCrSETgUEkkqQ0yRp9+Fd3lLF4U8T/MpJAZxlTXhtxPiuUOLYzGW6FRU/xR4LO1D+9t5jz1IU0CROWk1jgGobPFOd4Xp4vnzVvW43OGYg9BbVCXVemIk079qko/8ZhrXwSj2ISFw/BhNi4RLiZQ0gTLS5S2m9cB4iyBb/DjlipP1uS1bAmfM9GpZfP5E/8eum5IYt/jg8W4+T3BM1nKfG1mR/GIxz9OiDCjAITgo6n+RfyW4pd91zqM9ynM5s8GdVZoBEplyMYupGxGnF6QxZa73LsGCPor8e/zjX24AYnr0opxQ/ECMrst4CxP5InCdCYUj5QUaGYT22OUCTExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5080.namprd15.prod.outlook.com (2603:10b6:806:1df::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.20; Tue, 31 Aug
 2021 16:41:01 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 16:41:01 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kajoljain <kjain@linux.ibm.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v3 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Thread-Topic: [PATCH v3 bpf-next 2/3] bpf: introduce helper
 bpf_get_branch_snapshot
Thread-Index: AQHXnefQHoOSP4aCd0m/09RPZ9UWQauNvuuAgAATPIA=
Date:   Tue, 31 Aug 2021 16:41:01 +0000
Message-ID: <26B5B18A-EC0B-4661-BE6F-E5D96DCDE0B9@fb.com>
References: <20210830214106.4142056-1-songliubraving@fb.com>
 <20210830214106.4142056-3-songliubraving@fb.com>
 <YS5LexDSokkcOJ7O@hirez.programming.kicks-ass.net>
In-Reply-To: <YS5LexDSokkcOJ7O@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb6e1917-4a62-47c1-4faa-08d96c9e1e16
x-ms-traffictypediagnostic: SA1PR15MB5080:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5080D6BFD01E847660EE7FCAB3CC9@SA1PR15MB5080.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yDq6DcvZc/VTgPqAZRdjMe97Q0do/Oefrg6zM207o+qdSIFZvKGxz2EWw0SY0GomuA3jGprLLGBs9yXGnRX1ltkfO0rfYcrrVZiW5knkwkvOpcAXVp+MxkUbnvvEeaHUV5fDvVdFdNqU0qyPdIVEAXCgOaS7I48YSM58xxEBwakWHgbtQ1pn4DEy640C4yxU4TtzFd1KY2KBK9BpNt5RzbfgeXxBaceNc4mqIaz1BXsu3kJ0n+gMfrDjEeZ0nC6DKnO0y4cRKyF9RgcgHrzaKtpnoJU/dugBdyqWB1ljCEKA52fCZUZAiU1DdsbqDqIJi4eoL4g3m3kq334PWJKtnIk1EyhzQUUJV23zlZRURbqr8xMEoohGwae/aAvclv7JmkX3Yk197VqEhA660fKuSWNouD1A05RLxhog2qCJkKABpBlXTzMWz3KeWcuYAbiAX2/lv48XO8pmlQ/6o8CsGwWThreyuYhAKD1QO4CFzRgiBuYDOaWKl3Ip3TB7wB+I8w7GQm8ulq7MzJdTLn68vVz/HAC4YaCuzNQB6r4knitpoaIwu2+AYlIvSjnPBNyOr5bph+KnSxDyYGJRvadmcu+vjGd3ffqv4DAgxwA/s8KwtjK2CiaT0exIAEgtXNrUiOihDP1eCLF9UfDMM+Id6mCMSTsudYOTuwBrCY2RWoVthkrnvvq6jhz3eLoXvAbLySb9+/0cjmTje/gZ0ZE8GrbrPBHEsaBZM89yh1YFyK+UXVJGl4ayOX4bZ3L21YId
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(71200400001)(53546011)(8936002)(6506007)(508600001)(2906002)(2616005)(66446008)(4326008)(316002)(122000001)(64756008)(36756003)(76116006)(66946007)(6916009)(186003)(38070700005)(6486002)(91956017)(86362001)(83380400001)(5660300002)(33656002)(66476007)(38100700002)(8676002)(66556008)(54906003)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5OQL5a4pvzTcI9Ven4JrkUjFuz+svyzRwLAOAK+1re1WjD1m/NhlVu1gCJ1F?=
 =?us-ascii?Q?/nIGCo1wepSZeTRopc32WK5hl9pXHvM9y2pXUOyNO3BoKC5G5JX1y3AFrapU?=
 =?us-ascii?Q?Q468JD/zt1PBv3kvcnwnZFXVwloE3epIxvJvyyfILmsGAWDhhXpyjdr32gGx?=
 =?us-ascii?Q?JANbIfUNwSm6wCfoIrMI0OoDJ14WpzqKFpRKwTRMNbKKIXen7dnJ3HCFZMwB?=
 =?us-ascii?Q?wbb8fhblaAkFzNqgrhaJA1F/hDNEyOfA3lOedAQzHSGmRxcEJv7ITUpGymeE?=
 =?us-ascii?Q?SEXF4C8xMlOVn5BmviypFKe1OM4CjUT/pnMWVsGW3D3YrC9V2nPmghyC1NpV?=
 =?us-ascii?Q?KeMCayZJXqe60mQpfyL63KhF+lC6WSCQE/OKl9rGU+UHNdEySYjPc3NF+qEy?=
 =?us-ascii?Q?fOs7UqSzqoal873boyNE3IhVwu8hywhRfimKDYyfcFLAmw1JFvcWZeV4neRj?=
 =?us-ascii?Q?DnfhJCn6EYUZqBM6lJ3o45cqSazHROc1QEBFS9kqKFfuMfGIlxMbgmfPMf1z?=
 =?us-ascii?Q?wy4dSOtNnUcfeUb2fVX3Vk2B1u7Ru4jD0u2TCJ7UqE4nnzrcQENLDl6gAstj?=
 =?us-ascii?Q?AERFdaHV4AheMlNeMOq0M0S0nhC73/pKk8fASdIESPw55yaL3JafKUvS/tLL?=
 =?us-ascii?Q?Znz0GGGEvBTh1Pw4lCsqW40gZX1C3QhlvGPG9TmbDvaEcOxPQWQaqP0Upne/?=
 =?us-ascii?Q?yJv+/juU3rm1At8btKQHdeiWPyDoAqXrPQfgBPzXnrSFHElJBsxNiSS/G9EI?=
 =?us-ascii?Q?0KEEX0PL30axT7h+D0cQ6mJ6elv5nbvr2LwNq3dsxS5VrmwNnROIXHpBP06C?=
 =?us-ascii?Q?8POe3NFM71KnKqaYYA2E7uvzOLfgbIoAlz9B4YsY+EY8Ry/E+t/lBehL09u7?=
 =?us-ascii?Q?bQCM4yivzKnojj5PRqAA66Q/gTLPFVKOCz9AU1Ys2eGXNxZeW+nHNFtYIQrp?=
 =?us-ascii?Q?IwAqJnpKP3P/dHWYL4PRNhVECnmGlOa7pESsRYfqUegVA2m1aZgaosZQXXZ2?=
 =?us-ascii?Q?wOkYefwaCR3onm95j+rSO3ZDR/j57KToEyYxECqpkq59OhwgIfen5O5mml5q?=
 =?us-ascii?Q?vwMpUnKoFzEU4013rfZtwl7dNUxUqzc9v/akMdz1HFuAX03X2TOoRHtv/gDo?=
 =?us-ascii?Q?QVyqG7UpyHFnoqPSC4QHNthwwZ9cZHKC0ulduxJpsR4ybu7incera9WsftRe?=
 =?us-ascii?Q?6sKz6fbn00NORJopl74eAC7sopbuYZCxsY12q4vStPmszRd1pjqDprPPrmvr?=
 =?us-ascii?Q?Pp/1g+0i/UttSqbtVcrBugO3TrIbt+bGhNr9dSJgkLTBXYy9rYSWJColvII/?=
 =?us-ascii?Q?TfiNYOCcQuw8Fnmnl7ALj1ejE6Xz5z5yv2IB3MbaCUDRTzjd7zEni47oAyAt?=
 =?us-ascii?Q?7h3bdy8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9BEFD4D418EC44CBF05BE023C95D696@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb6e1917-4a62-47c1-4faa-08d96c9e1e16
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 16:41:01.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: voLNFz60AjfA2X/QWkCd0hSybUU590hTeLhawx8CyENaZN9/2O39ntsWytuehqom3Q8Zz5t9Q2ox45Ei4K+sIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5080
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: C-K7MGFbVEbIgKjIVfeu2WQP-hkrX7FS
X-Proofpoint-GUID: C-K7MGFbVEbIgKjIVfeu2WQP-hkrX7FS
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_08:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310090
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 31, 2021, at 8:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Mon, Aug 30, 2021 at 02:41:05PM -0700, Song Liu wrote:
> 
>> @@ -564,6 +565,18 @@ static void notrace inc_misses_counter(struct bpf_prog *prog)
>> u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
>> 	__acquires(RCU)
>> {
> 	preempt_disable_notrace();
> 
>> +#ifdef CONFIG_PERF_EVENTS
>> +	/* Calling migrate_disable costs two entries in the LBR. To save
>> +	 * some entries, we call perf_snapshot_branch_stack before
>> +	 * migrate_disable to save some entries. This is OK because we
>> +	 * care about the branch trace before entering the BPF program.
>> +	 * If migrate happens exactly here, there isn't much we can do to
>> +	 * preserve the data.
>> +	 */
>> +	if (prog->call_get_branch)
>> +		static_call(perf_snapshot_branch_stack)(
>> +			this_cpu_ptr(&bpf_perf_branch_snapshot));
> 
> Here the comment is accurate, but if you recall the calling context
> requirements of perf_snapshot_branch_stack from the last patch, you'll
> see it requires you have at the very least preemption disabled, which
> you just violated.

> 
> I think you'll find that (on x86 at least) the suggested
> preempt_disable_notrace() incurs no additional branches.
> 
> Still, there is the next point to consider...
> 
>> +#endif
>> 	rcu_read_lock();
>> 	migrate_disable();
> 
> 	preempt_enable_notrace();

Do we want preempt_enable_notrace() after migrate_disable()? It feels a 
little weird to me.

> 
>> 	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
> 
>> @@ -1863,9 +1892,23 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
>> 	preempt_enable();
>> }
>> 
>> +DEFINE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snapshot);
>> +
>> static __always_inline
>> void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>> {
>> +#ifdef CONFIG_PERF_EVENTS
>> +	/* Calling migrate_disable costs two entries in the LBR. To save
>> +	 * some entries, we call perf_snapshot_branch_stack before
>> +	 * migrate_disable to save some entries. This is OK because we
>> +	 * care about the branch trace before entering the BPF program.
>> +	 * If migrate happens exactly here, there isn't much we can do to
>> +	 * preserve the data.
>> +	 */
>> +	if (prog->call_get_branch)
>> +		static_call(perf_snapshot_branch_stack)(
>> +			this_cpu_ptr(&bpf_perf_branch_snapshot));
>> +#endif
>> 	cant_sleep();
> 
> In the face of ^^^^^^ the comment makes no sense. Still, what are the
> nesting rules for __bpf_trace_run() and __bpf_prog_enter() ? I'm
> thinking the trace one can nest inside an occurence of prog, at which
> point you have pieces.

I think broken LBR records is something we cannot really avoid in case 
of nesting. OTOH, these should be rare cases and will not hurt the results
in most the use cases. 

I should probably tighten the rules in verifier to only apply it for 
__bpf_prog_enter (where we have the primary use case). We can enable it
for other program types when there are other use cases. 

Thanks,
Song

