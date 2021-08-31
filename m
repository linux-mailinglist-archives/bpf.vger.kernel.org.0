Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06263FCF19
	for <lists+bpf@lfdr.de>; Tue, 31 Aug 2021 23:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbhHaVZp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Aug 2021 17:25:45 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:20366 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239889AbhHaVZo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 31 Aug 2021 17:25:44 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17VLOYki010958;
        Tue, 31 Aug 2021 14:24:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=NgjYfCUPlZ4aafdewourUXA8RpBMKOh0FmMZ8LSKhjM=;
 b=SG8F0pNcNp+s4on/lM8wyet/EKLAh8QpdV6Iu9vXXOuDs+CaNZYvMgz73Peslq5WmIUA
 Iq/KRdwe2tTnDrJsWT/12NeCLOpI6/qvvxgDkXOQKysVQpQXI7SuRINK/gbSSvj+F7LC
 cN72IlYqLRLv+LeP2JwXLEprsuMNXR/ertw= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3asscrsfqh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 31 Aug 2021 14:24:48 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 31 Aug 2021 14:24:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la29c71PEWg60C+XsbVkcGwyF0Fh6PBuSwcC8tyUg+nRVx/74gqRVbkQNRe4WJJg0Vv+HIWhQgJ2vSMgROphULEFm+zmNSMg+1bCArnJtiI+OYF42dzPdxq5tFERltllZKzxke0RL88syTPZTa9zv+HVnoKuuWuM9yASfwtPLjtedkpFfzhR7zp+MWFsQrDE/nr3cy5VuVSQQC0gJsj+4aTcbLOxYI+gUXllKqPbYEjV35hsvo0enKkaMJ0m1qimQaXQUVLmIvuzdhtZ5zKPRozacRcJ/DelqwC2QBi/sTGBGhXStwm0g3+AEx9ziN00tEdWo6IMk8IJAkJWcFh+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=NgjYfCUPlZ4aafdewourUXA8RpBMKOh0FmMZ8LSKhjM=;
 b=FZOpnRaGLYMSmvo0v3wIXcI49P/eMipkNSoPyzaWvHsAckQAVnz11OhZ98z15tmpJ01uP3hincGcRCqRMIUKxSzN07Z2a83HDfCY4lFEq9bqqfpxClUKCwdOhzhGwyGzUSq+ygtQA0qjMDREC90eLSb3URgJqbCDk41j3IFkZ38JhgkI3PmJm2+M6RydCsEdc/ykvDkqbBSQUGPydAcSZPS+VEjIemcmE661yGsflY2tadqiaUNCaVACJoP3qju/bMJ0itl7t+da34ZoHHSGmQ8iGi78HXCBkEY/0J+u4j3rj2vbEYrZ0sV1BsOTYXz7jxvr/smPqlv8kK886E6plQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5096.namprd15.prod.outlook.com (2603:10b6:806:1df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.17; Tue, 31 Aug
 2021 21:24:46 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%7]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 21:24:46 +0000
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
Thread-Index: AQHXnefQHoOSP4aCd0m/09RPZ9UWQauNvuuAgAATPICAAE9GgA==
Date:   Tue, 31 Aug 2021 21:24:46 +0000
Message-ID: <F7738B87-1CD3-40F8-9278-DC69E9AB0395@fb.com>
References: <20210830214106.4142056-1-songliubraving@fb.com>
 <20210830214106.4142056-3-songliubraving@fb.com>
 <YS5LexDSokkcOJ7O@hirez.programming.kicks-ass.net>
 <26B5B18A-EC0B-4661-BE6F-E5D96DCDE0B9@fb.com>
In-Reply-To: <26B5B18A-EC0B-4661-BE6F-E5D96DCDE0B9@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05b08b0c-c557-4239-a16e-08d96cc5c1bd
x-ms-traffictypediagnostic: SA1PR15MB5096:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5096E5170A4F3A6166B2DA89B3CC9@SA1PR15MB5096.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 09mhiN79lGatWwIfejgT3GvtMJ4wqgJntpV3PvL74rP/z62Vl3Hf1jxB0HAM5AuH+pMau/PSmTQ+inTzpZ5ycxaoZbGzFVRxfLAJZDI1Vj8cBMzBSIljVfgj8dd17r7Td7junxYAV3nvHwEZLLixQVpvBAwVaYmpRxkchdylONiCYA4zmCilsTb9YSJr4P1JI5oA2Fz1UEdQUratbJsUWDTdT2ZhB2BmNeO7TSWBG+d64Z8EW18RpReODTxx8ad8U6eo6SaJ5VOwhk+NO3Q5s2KcmkkQHk6IyKjOZIukZHreUKxmGOdGguHqsV5dWWtXH8K6CqDRQIJievdijybgQsQ4OiZVlyMME+AyVqYWi2ssAgsdGfjF5UYmixWs6dJOU6+N8uK9BjBFxOwquncLol6doP2pck2N8Ej2EIjUOWIqvwN/B9gKYV4QIMzvJqP4BJGQe3hI6BFjW1NLriFuBGPf8LFwXKW2gDbTtnPSCiJk+RuwB8eu7MSybfXTP1jqGqhyUdvrEpzXFoVA1+5FI7lIyrNsqBwTdgPYN917A3Tmoj4i696cJF1wQpyWSjEN1BhpCY2y8XnmXesM7MQFzDD1SkO8BvedWmufBkwB+ajsgWtUBsr14812OFkt6ctW73LDU4fdof/5rD6hDgMy3Wf+/pN2RcY5P3FbV7Vej4UlQJHHxtscS35G4cYvZQ6uQsW71Os6+9mQaMbGRZCw0/l5Y9xTXl2aQ00axoepPjjLKQJYlWjRPfXLJAANsinX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(54906003)(478600001)(5660300002)(6512007)(316002)(71200400001)(33656002)(86362001)(6486002)(4326008)(38070700005)(6506007)(66946007)(122000001)(83380400001)(64756008)(66446008)(66556008)(76116006)(91956017)(66476007)(186003)(6916009)(2616005)(8676002)(36756003)(8936002)(2906002)(38100700002)(53546011)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/UzjdUQ7B2W7O8GaaEX1IFS4E4VDLud6kgZNXakqFYkLvZ64x4zdOVQkCrY2?=
 =?us-ascii?Q?EmCK+yI1+RVFXWzAIXf/0y3N5x31wPMmOVPrhmZdnr4N82gs8xBzAd+oI4aH?=
 =?us-ascii?Q?MfIEDQXIL8vFQAQKw8+sU49Mmt5QPfAbNkDWiHNAuAnNUVv3DPyWzZ/jVBUx?=
 =?us-ascii?Q?Mp0s/m+im23UvZKpmadFqKnPWI6aPNMAkkqUgoKcMQc6py5rJI3pvBnT/oL1?=
 =?us-ascii?Q?E+a5ibz/XijGBY4hi8i1eKwHfE07gPiGNg3jX8MSyWC5oE2xB9a8JzCBJmzm?=
 =?us-ascii?Q?5VxBv69gp+F0n4i365fTFnOW6cE86maCQf1y5tQA0VUtM4XVm+uX1Upkk8Cq?=
 =?us-ascii?Q?wFtAGBnOX62x2gwJiBFYx9kDczNfjjxH4KsH3FRELryKBECZYD/mtIdAsV1S?=
 =?us-ascii?Q?kVZZDnNyIXPBP9OER91zKKch3Y03x3rCX0OU4l1IIMBuY+F4CUAfFE5wpSpd?=
 =?us-ascii?Q?sQ4+IQuRf5jybqNEgGKXZw7wOOg7DHv+RGp4+KRyxcY5T7F0RydUBeIYGeBn?=
 =?us-ascii?Q?342Ng5j0El9IFf6kIW7mZAFn3xMAhce43K0j89JtS1Dpwbpb5lxNu/J1VC7L?=
 =?us-ascii?Q?Ue1sEbLCviSsAMUQ+YnmlP+GIY8BkGAnpXQk1f/YCfRDAG1zV3PkbulL/BHj?=
 =?us-ascii?Q?Pbp0qW0gkzJhGT4DsExr5OMB4mcVAcWZfUz/lEgqcl8TZ0LhD9bZi0sH5r9H?=
 =?us-ascii?Q?4y9lgsta+JZj7jAyy2XzWa1OXrxy1/Wk6RCRW2WlbdZKhd7mKPzex+XuVPDa?=
 =?us-ascii?Q?j1+dxSrrbP4yPy/z7/kP4FezciJezqs/qo30YTXBNeieNGha0IdzMN/pTwzb?=
 =?us-ascii?Q?5dkGRfybO52n+Zlzpcmle/aQTGiCqjcn9pUyKcx8ALhBGdajnyZnEqerNu8D?=
 =?us-ascii?Q?fEslpTF406UXyNOV0WgjlHNDfNNzhfWURU2ZyUXcdQTCpxHccXjEU66Js2z9?=
 =?us-ascii?Q?h2ikOFGeNkYw9/3FBGnUlGUKYqJc3jyf03DlF0IRo5s4JAt7iWrJPAMK6kRX?=
 =?us-ascii?Q?yoL6X7vsFh+Zl89kYzUkYb5fat6qBlP09GlmgAcdn+By+06UQ8At87vfA8Pt?=
 =?us-ascii?Q?/C39nEF3oDU615Z5KGyZLtA4UmJJzLZPzSIAIPvShyNm53ZBA7oAubxlW5PN?=
 =?us-ascii?Q?PrFJ+Svx2fUWnvElxVut6O3lH4HRo2DCWVa7noWhXVDbKtD947ICRSw4Gbrw?=
 =?us-ascii?Q?4RFFTb76SWYOumRxS56gRV6l2KWzdf6IdgJUfkCWURVZJ7JVrNasfFsO580Q?=
 =?us-ascii?Q?9R5EOste04UMl69CTWTEqIGibwgMSj195dUh88EjsezEpTSqxGVeKrj3LgbK?=
 =?us-ascii?Q?HaXalPYRE72hcrtGndSXNapu5k9del6KqQw+xtnZE9TEsmq3zMiuvLxZDkWc?=
 =?us-ascii?Q?WihTNSQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D04E6521D1C1C24BADDCBE18C8F7D4C7@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b08b0c-c557-4239-a16e-08d96cc5c1bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 21:24:46.2282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZjYXsqCuttCOnmUNTEQOYwS3JIjJxxGR95urYw5g8EB+8LGM8hwcXyXB4rjS5SOPWHk9Ned20TRYQfhqXyHNFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5096
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: Kt0W2pr8MH1xD8klOfsqrirsIoG3Q5lH
X-Proofpoint-ORIG-GUID: Kt0W2pr8MH1xD8klOfsqrirsIoG3Q5lH
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-31_09:2021-08-31,2021-08-31 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108310117
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 31, 2021, at 9:41 AM, Song Liu <songliubraving@fb.com> wrote:
> 
> 
> 
>> On Aug 31, 2021, at 8:32 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>> 
>> On Mon, Aug 30, 2021 at 02:41:05PM -0700, Song Liu wrote:
>> 
>>> @@ -564,6 +565,18 @@ static void notrace inc_misses_counter(struct bpf_prog *prog)
>>> u64 notrace __bpf_prog_enter(struct bpf_prog *prog)
>>> 	__acquires(RCU)
>>> {
>> 	preempt_disable_notrace();
>> 
>>> +#ifdef CONFIG_PERF_EVENTS
>>> +	/* Calling migrate_disable costs two entries in the LBR. To save
>>> +	 * some entries, we call perf_snapshot_branch_stack before
>>> +	 * migrate_disable to save some entries. This is OK because we
>>> +	 * care about the branch trace before entering the BPF program.
>>> +	 * If migrate happens exactly here, there isn't much we can do to
>>> +	 * preserve the data.
>>> +	 */
>>> +	if (prog->call_get_branch)
>>> +		static_call(perf_snapshot_branch_stack)(
>>> +			this_cpu_ptr(&bpf_perf_branch_snapshot));
>> 
>> Here the comment is accurate, but if you recall the calling context
>> requirements of perf_snapshot_branch_stack from the last patch, you'll
>> see it requires you have at the very least preemption disabled, which
>> you just violated.
> 
>> 
>> I think you'll find that (on x86 at least) the suggested
>> preempt_disable_notrace() incurs no additional branches.
>> 
>> Still, there is the next point to consider...
>> 
>>> +#endif
>>> 	rcu_read_lock();
>>> 	migrate_disable();
>> 
>> 	preempt_enable_notrace();
> 
> Do we want preempt_enable_notrace() after migrate_disable()? It feels a 
> little weird to me.
> 
>> 
>>> 	if (unlikely(__this_cpu_inc_return(*(prog->active)) != 1)) {
>> 
>>> @@ -1863,9 +1892,23 @@ void bpf_put_raw_tracepoint(struct bpf_raw_event_map *btp)
>>> 	preempt_enable();
>>> }
>>> 
>>> +DEFINE_PER_CPU(struct perf_branch_snapshot, bpf_perf_branch_snapshot);
>>> +
>>> static __always_inline
>>> void __bpf_trace_run(struct bpf_prog *prog, u64 *args)
>>> {
>>> +#ifdef CONFIG_PERF_EVENTS
>>> +	/* Calling migrate_disable costs two entries in the LBR. To save
>>> +	 * some entries, we call perf_snapshot_branch_stack before
>>> +	 * migrate_disable to save some entries. This is OK because we
>>> +	 * care about the branch trace before entering the BPF program.
>>> +	 * If migrate happens exactly here, there isn't much we can do to
>>> +	 * preserve the data.
>>> +	 */
>>> +	if (prog->call_get_branch)
>>> +		static_call(perf_snapshot_branch_stack)(
>>> +			this_cpu_ptr(&bpf_perf_branch_snapshot));
>>> +#endif
>>> 	cant_sleep();
>> 
>> In the face of ^^^^^^ the comment makes no sense. Still, what are the
>> nesting rules for __bpf_trace_run() and __bpf_prog_enter() ? I'm
>> thinking the trace one can nest inside an occurence of prog, at which
>> point you have pieces.
> 
> I think broken LBR records is something we cannot really avoid in case 
> of nesting. OTOH, these should be rare cases and will not hurt the results
> in most the use cases. 
> 
> I should probably tighten the rules in verifier to only apply it for 
> __bpf_prog_enter (where we have the primary use case). We can enable it
> for other program types when there are other use cases. 

Update about some offline discussion with Alexei and Andrii. We are planning
to move static_call(perf_snapshot_branch_stack) to inside the helper 
bpf_get_branch_snapshot. This change has a few benefit:

1. No need for extra check (prog->call_get_branch) before every program (even
   when the program doesn't use the helper).

2. No need to duplicate code of different BPF program hook. 
3. BPF program always run with migrate_disable(), so it is not necessary to 
   run add extra preempt_disable_notrace. 

It does flushes a few more LBR entries. But the result seems ok:

ID: 0 from intel_pmu_lbr_disable_all+58 to intel_pmu_lbr_disable_all+93
ID: 1 from intel_pmu_lbr_disable_all+54 to intel_pmu_lbr_disable_all+58
ID: 2 from intel_pmu_snapshot_branch_stack+88 to intel_pmu_lbr_disable_all+0
ID: 3 from bpf_get_branch_snapshot+28 to intel_pmu_snapshot_branch_stack+0
ID: 4 from <bpf_tramepoline> to bpf_get_branch_snapshot+0
ID: 5 from <bpf_tramepoline> to <bpf_tramepoline>
ID: 6 from __bpf_prog_enter+34 to <bpf_tramepoline>
ID: 7 from migrate_disable+60 to __bpf_prog_enter+9
ID: 8 from __bpf_prog_enter+4 to migrate_disable+0
ID: 9 from __bpf_prog_enter+4 to __bpf_prog_enter+0
ID: 10 from bpf_fexit_loop_test1+22 to __bpf_prog_enter+0
ID: 11 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
ID: 12 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
ID: 13 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
ID: 14 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
ID: 15 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13

We can save more by inlining intel_pmu_lbr_disable_all(). But it is probably
not necessary at the moment. 

Thanks,
Song



