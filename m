Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A323FB9C1
	for <lists+bpf@lfdr.de>; Mon, 30 Aug 2021 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237947AbhH3QH2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Aug 2021 12:07:28 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:18620 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237836AbhH3QH1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 30 Aug 2021 12:07:27 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17UG16ps014376;
        Mon, 30 Aug 2021 09:06:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=2nF9C4gudbblU6yEgNahnRX7vEYa25jKuPvdqksoV84=;
 b=iplknsnU41Vp4C92MwZb2RNHw3fvX9Ud2R2Wzyx4zlgaHaHeMraeUTIjL7DzkKi4QAGj
 meFGDWwJIZ20aubaK7sqKIWkQ4I25WNT5L8mU0lH8G6kkEEmRoSTlrGDVJaZWX586nmC
 nCJB12AVOctISQUFopI7ME65moAfKpNx7ww= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aqmt2t5fa-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 30 Aug 2021 09:06:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 30 Aug 2021 09:06:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dS8sWB0aN37lt4+GmP3GJwN2D/T6h+hkMoAKe/QrUFnvci5utALaRN9WMs6uBq/zZjaVuuPjWC2F9V7s8Ok5hdgwd/jqI2gyCzuR/jzKmJsVXPi0EZihrVomsprELBiDrIBFU7RdiUIqflqaDoxOqWgaAzEnfV492m8mQZ5Rco3EPQgiA366UYKutVyJWraVzkpPviG1i1cX+tp8tyEbFJWjkbVkENUdOy/xR7yB8tAC8BA3njgxMgaj2DAFwDA1SriB1BDPIF/KmWm4KaaZNWZJcM/KdK1xpJbZM1oRksjx8AG5kdIfFkULNneKNlTtJX6kzCoibF6VPiluDsn0Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2nF9C4gudbblU6yEgNahnRX7vEYa25jKuPvdqksoV84=;
 b=fCAnJDWlwDfjsitZ7oMWZvU/wwnMd9/88ZcfXY7P/LYTLOJDbgQlwh81M5Vm+67Grx0isF7EB1xgfU7f2cAT2rUIKrfGhVovQX/oJY9J5YOzvVmJXwSIODHiDuarXfGnVCQ7v4g4C3YaF71jx2qGtIFNdhvUF6uXlTbu/HQ5qCzQ7Q+lk1FxdZtElQJodNI9F7nxbcfsiBOH4h5gAVnhSwILewrwukppl+sLTFhpwwn/j67Jm6POnNTQtRM1OIpMbb3SzEMtuA4s1K2ScvsWMq2X9OBiNkXDahUA2D9Etuj2wpT2g5oGgLFDnLwp6a3WP8/XFuqgKJ5fF8sHMYVgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5094.namprd15.prod.outlook.com (2603:10b6:806:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Mon, 30 Aug
 2021 16:06:30 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::7d66:9b36:b482:af0f%6]) with mapi id 15.20.4457.024; Mon, 30 Aug 2021
 16:06:30 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        kajoljain <kjain@linux.ibm.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Topic: [PATCH v2 bpf-next 1/3] perf: enable branch record for software
 events
Thread-Index: AQHXmsebo1O8tvcQbk6YyjOXJsK0SquL4jMAgABaOYA=
Date:   Mon, 30 Aug 2021 16:06:30 +0000
Message-ID: <FBD95188-A9A3-4D0C-ACCD-650BAE772879@fb.com>
References: <20210826221306.2280066-1-songliubraving@fb.com>
 <20210826221306.2280066-2-songliubraving@fb.com>
 <20210830104334.GJ4353@worktop.programming.kicks-ass.net>
In-Reply-To: <20210830104334.GJ4353@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3333bba2-b615-488e-63ee-08d96bd02162
x-ms-traffictypediagnostic: SA1PR15MB5094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5094FB3AF23D9073789F5388B3CB9@SA1PR15MB5094.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +zUaH9AnIYWuhik7sJfYPnrw5oGLD023pq78h86B5yozHRZ1qjdEYLz2y3IjBadcdsr2TaEYT5rzQ6weETRYUTWCWB+D6Iylz54dXF7GhH99g+PsCZXD/NYVpYDawQxBtHb9ikkpD45E8+2QGIoJ+W3WtQ6JPc8q1pTqyJ8CJKsgwdiDNrmyqEatuCTTzd74X7kfNNKWftkB7eKA8PTDHHyVnHVeLaSjk7TIXGcc/HkyUrHcpDSYj+BPverNgrRuLXKZEBWmmEQuO60y7bTNYzV7/4CtF28xbGS37ZqqwifoSD3RVwq2a6+RRhwNbfiFydDpTP3dIY6i5B0uT1NOTTrXyvEgdPKsyk9qaMkiyAF+T/eyWjgyvjUKk/5bfr/NV5+QF9YUV+ql2lop11rVB25abZDlAufqArhIHm/nxSzKNkBiNzgsLGB1hmUgyyGXTbXqnaI8mIuEXQxqiB1c8pMlsqD9ErmnHj4A1FL60e7hmgf0cJzn/1lJydJ2oTEmfFyvsVBEpHRH3tLKclpAnPGM325/UPUsvwAow1ngOiOmpviPjAvXQM8TmxOt16b7qkjOjlm+WzmsB4VO1ixAHVG4pJgvpBCNA46q1YPBoUWd16W6hBzRXY3YuvBmsA/q5XDsz13n3OzSc71AV5V7vMLZ2OcGJwha/ygqMcSGJSrR3DEEpJGkKDqDyUUAiZ33l9yzlqsxMOLoEnNwI3432GST5kUrDjJMHm6xcuMxVXc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(4326008)(316002)(6512007)(2906002)(66556008)(66476007)(66946007)(66446008)(508600001)(6486002)(83380400001)(2616005)(186003)(8676002)(36756003)(91956017)(76116006)(64756008)(38070700005)(8936002)(6506007)(53546011)(5660300002)(6916009)(38100700002)(86362001)(54906003)(122000001)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?A0VHn8qjlAdmuRjfFV3UEinDOJzA/vy0DRcNaz976dSASEVykanuM4Wxw8Up?=
 =?us-ascii?Q?8skMLUE6FgYJ2JWCrlyHNBW6e0uf+EamO1Ywiv562Gj4rRoTK19jm5xh3/LY?=
 =?us-ascii?Q?VbJH7WDnGl6lOWC9EkdB/Z4ZiCHWOhklMp/JB51u7TpZa2MwsI3VaMAU4AcY?=
 =?us-ascii?Q?OPtUC6vAYJH/SVL9uZQa+2N8jUsuEIi5Q7X65p9VtJilNO1EOp8mbirq4Cal?=
 =?us-ascii?Q?Dmq33UHXtdF9aJ6in7XNa2Ypyu6mdCEFYSik0Yqn5li7qTc2XKBRLBQn3+eU?=
 =?us-ascii?Q?u3wn2g0CQJK/JZqVi82wacymX5L78Cq4glz0b5E5FZJsQK1vGAtyRt8Z9MkQ?=
 =?us-ascii?Q?x0xrNptNQKmQEF7z/utjzLs9mFu/5KALskIMgOKIYtmL8dNgnQX2WVXZMady?=
 =?us-ascii?Q?sHWb6vWnrOq15LWwadSZ31VJnnjz500HhBjlT9Yi6jWrnSezLDLjMAejc2T+?=
 =?us-ascii?Q?Fwb1LjGbY2PwI6C8N5D12SbRt22HLa7S1nyLkxHCFekXWREN4272ABm/fum0?=
 =?us-ascii?Q?FVF5CpbfxE0POvxtQXqmSWZLjPPBKU4OjVNstLB6FosVdR63av1DPH0+ImiM?=
 =?us-ascii?Q?UA1i+MfLK/8oWhfMaIGCqu62wAWNvzzPsNjexdIdd5nZ3lNwez44k3SKwPxj?=
 =?us-ascii?Q?erSsUN7YHTrbV0QT89ypgzSSHwbn7GwWF7EnOamsUFe87JGQBz7dxee8TT2Q?=
 =?us-ascii?Q?wZ3dY5xM4qKUvbN2vxgHC8xNNJOmzhJeguB6xgruOFGrpcS6hXBtlV1vAaUT?=
 =?us-ascii?Q?uCJ3diET2fnRte2yffVAakKSPyAaNJa5Ohx9AQUi6ZVzj3Vth4jSBk7TKSdd?=
 =?us-ascii?Q?wlxHOVgPkpPh2ENAvmjhf1DdnfRyehuPMu57RHgynfoT26MQWR7delSCQHPH?=
 =?us-ascii?Q?qfZV50jJeu47YmGd9j0/GcvM8XAIdPMn63aALph7oPMKPGG3NOv6Qpp+p3M5?=
 =?us-ascii?Q?AI4HyKyG2n8qrEEbgDIOBB+EkONh21WgB6ecD2xM23WwBjztJdP15HnYAu32?=
 =?us-ascii?Q?T28AUVXut6R2M1B+5HccA3zubGKu31VT2F/XXM+5xLtT66FiSnJIy6/E0Ue1?=
 =?us-ascii?Q?FC0auVoaeJ5B9VgvZSwyC09WDK9EPLag+onB7GHS6yrqJAAJecuvHCsKSvzl?=
 =?us-ascii?Q?AQg1tYgyvn0ODF8T/tWKJQp/nwclA7lYPFpDs0wKwGD2GoY0DGOSPfE5Rvsl?=
 =?us-ascii?Q?0QKGMym66XdXHUix5ShEgPZJ2yUwnN/oZDp/7e+2eFkbsQz1WUbNbyhBR9ju?=
 =?us-ascii?Q?+j3Na/oSjfBGJDbYbAUSQnxpcQW8BbCcK/ewysdlZP567A9Ye2kp5Dz2weJC?=
 =?us-ascii?Q?8GB++V4me6To1kLmT1F9eJF0XkfnPZ2oPa+owbJXBR1P5S4mcvioYk3aTMil?=
 =?us-ascii?Q?Xg6LMRE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <00601C4CE3AC2148B600DA5463E99FCF@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3333bba2-b615-488e-63ee-08d96bd02162
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2021 16:06:30.5877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 09wvzYGtTIM30VLXerpJ/Xbja0lvT5NQo+C5uH+JyiZPRK6ajCVAzq96yMS2xvRf24Ge8NTI/I77BjC5XTvSjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5094
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 3r-YGwFDIRvxqDmxfI4CA7WCn4V6mmyc
X-Proofpoint-GUID: 3r-YGwFDIRvxqDmxfI4CA7WCn4V6mmyc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-30_05:2021-08-30,2021-08-30 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108300111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 30, 2021, at 3:43 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> 
> On Thu, Aug 26, 2021 at 03:13:04PM -0700, Song Liu wrote:
> 
>> Some data on intel_pmu_lbr_disable_all() and perf_pmu_disable().
>> 
>> With this patch, when fexit program triggers, intel_pmu_lbr_disable_all is
>> used to stop the LBR, and the LBR is stopped after 6 extra branch records
>> (see the full trace below). If we replace intel_pmu_lbr_disable_all in
>> intel_pmu_snapshot_branch_stack() with perf_pmu_disable, the LBR is stopped
>> after 19 extra branch records. This is still acceptable for systems with 32
>> LBR entries. But for systems with fewer entries, all the entries before
>> fexit are flushed. Therefore, I suggest we take the short cut and stop LBR
>> asap.
>> 
>> 
>> LBR snapshot captured when we use intel_pmu_lbr_disable_all():
>> 
>> ID: 0 from intel_pmu_lbr_disable_all.part.10+37 to intel_pmu_lbr_disable_all.part.10+72
>> ID: 1 from intel_pmu_lbr_disable_all.part.10+33 to intel_pmu_lbr_disable_all.part.10+37
>> ID: 2 from intel_pmu_snapshot_branch_stack+51 to intel_pmu_lbr_disable_all.part.10+0
>> ID: 3 from __bpf_prog_enter+53 to intel_pmu_snapshot_branch_stack+0
>> ID: 4 from __bpf_prog_enter+8 to __bpf_prog_enter+38
>> ID: 5 from __brk_limit+473903158 to __bpf_prog_enter+0
>> ID: 6 from bpf_fexit_loop_test1+22 to __brk_limit+473903139
>> ID: 7 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
>> ID: 8 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
>> ID: 9 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
>> 
>> 
>> LBR snapshot captured when we use perf_pmu_disable():
>> 
>> ID: 0 from intel_pmu_lbr_disable_all+58 to intel_pmu_lbr_disable_all+93
>> ID: 1 from intel_pmu_lbr_disable_all+54 to intel_pmu_lbr_disable_all+58
>> ID: 2 from intel_pmu_disable_all+15 to intel_pmu_lbr_disable_all+0
>> ID: 3 from intel_pmu_pebs_disable_all+30 to intel_pmu_disable_all+15
>> ID: 4 from intel_pmu_disable_all+10 to intel_pmu_pebs_disable_all+0
>> ID: 5 from __intel_pmu_disable_all+49 to intel_pmu_disable_all+10
>> ID: 6 from intel_pmu_disable_all+5 to __intel_pmu_disable_all+0
>> ID: 7 from x86_pmu_disable+61 to intel_pmu_disable_all+0
>> ID: 8 from x86_pmu_disable+38 to x86_pmu_disable+41
>> ID: 9 from __x86_indirect_thunk_rax+16 to x86_pmu_disable+0
>> ID: 10 from __x86_indirect_thunk_rax+0 to __x86_indirect_thunk_rax+12
>> ID: 11 from perf_pmu_disable.part.122+4 to __x86_indirect_thunk_rax+0
>> ID: 12 from perf_pmu_disable+23 to perf_pmu_disable.part.122+0
>> ID: 13 from intel_pmu_snapshot_branch_stack+45 to perf_pmu_disable+0
>> ID: 14 from x86_get_pmu+35 to intel_pmu_snapshot_branch_stack+39
>> ID: 15 from intel_pmu_snapshot_branch_stack+34 to x86_get_pmu+0
>> ID: 16 from __bpf_prog_enter+53 to intel_pmu_snapshot_branch_stack+0
>> ID: 17 from __bpf_prog_enter+8 to __bpf_prog_enter+38
>> ID: 18 from __brk_limit+478056502 to __bpf_prog_enter+0
>> ID: 19 from bpf_fexit_loop_test1+22 to __brk_limit+478056483
>> ID: 20 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
>> ID: 21 from bpf_fexit_loop_test1+20 to bpf_fexit_loop_test1+13
> 
> Well, if you're willing to do something like:
> 
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index ac6fd2dabf6a2..a29649e7241cc 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -6283,8 +6283,11 @@ __init int intel_pmu_init(void)
>> 			x86_pmu.lbr_nr = 0;
>> 	}
>> 
>> -	if (x86_pmu.lbr_nr)
>> +	if (x86_pmu.lbr_nr) {
>> 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
> 
> 		if (x86_pmu.disable_all == intel_pmu_disable_all)
> 
>> +		static_call_update(perf_snapshot_branch_stack,
>> +				   intel_pmu_snapshot_branch_stack);
>> +	}
>> 
>> 	intel_pmu_check_extra_regs(x86_pmu.extra_regs);
>> 
>> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
>> index 9e6d6eaeb4cb6..7d4fe1d6e79ff 100644
>> --- a/arch/x86/events/intel/lbr.c
>> +++ b/arch/x86/events/intel/lbr.c
>> @@ -1862,3 +1862,16 @@ EXPORT_SYMBOL_GPL(x86_perf_get_lbr);
>> struct event_constraint vlbr_constraint =
>> 	__EVENT_CONSTRAINT(INTEL_FIXED_VLBR_EVENT, (1ULL << INTEL_PMC_IDX_FIXED_VLBR),
>> 			  FIXED_EVENT_FLAGS, 1, 0, PERF_X86_EVENT_LBR_SELECT);
>> +
>> +int intel_pmu_snapshot_branch_stack(struct perf_branch_snapshot *br_snapshot)
>> +{
>> +	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
>> +
>> +	intel_pmu_lbr_disable_all();
>> +	intel_pmu_lbr_read();
>> +	memcpy(br_snapshot->entries, cpuc->lbr_entries,
>> +	       sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
>> +	br_snapshot->nr = x86_pmu.lbr_nr;
>> +	intel_pmu_lbr_enable_all(false);
>> +	return 0;
>> +}
> 
> Then the above can assume perfmon > v2 and we can either inline
> __intel_pmu_disable_all() or simply do the
> wrmsrl(MSR_CORE_PERF_GLOBAL_CTRL).

I think can do perfmon > v2 only. 

> 
> One thing that needs checking, intel_pmu_disable_all() also clears
> MSR_IA32_PEBS_ENABLE, is that really needed if we just want to inhibit
> PMIs ? That is, will the PEBS machinery still trigger PMI if GLOBAL_CTRL
> == 0 ?

Actually, can we do something like:

static void intel_pmu_disable_all(void)
{
        intel_pmu_lbr_disable_all();   /* moved to the beginning */
        __intel_pmu_disable_all();
        intel_pmu_pebs_disable_all();
}

int intel_pmu_snapshot_branch_stack(struct perf_branch_snapshot *br_snapshot)
{
        struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);

	
        intel_pmu_disable_all();   /* call full pmu_disable */
        intel_pmu_lbr_read();
        memcpy(br_snapshot->entries, cpuc->lbr_entries,
               sizeof(struct perf_branch_entry) * x86_pmu.lbr_nr);
        br_snapshot->nr = x86_pmu.lbr_nr;

        intel_pmu_enable_all(false);
        return 0;
}

In this way, we still call intel_pmu_disable_all(), but since LBR is disabled 
at the beginning of it, we would not flush too many LBR entries. 

Thanks,
Song
