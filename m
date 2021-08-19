Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 716783F1FCE
	for <lists+bpf@lfdr.de>; Thu, 19 Aug 2021 20:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbhHSSW4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Aug 2021 14:22:56 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:51470 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232909AbhHSSWz (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 19 Aug 2021 14:22:55 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17JIDdv6010476;
        Thu, 19 Aug 2021 11:22:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=3ZztgNwf8gvLLSEt8aFnMpGoEoCgDaM2r/P2dmETFi0=;
 b=omabw0jnSxG9QYhRUqkRBDQE94Vkww15ygtcMdNxQ22F2YJi4iJpcTVHDM0WdmSWlHDp
 qZ/SQu5C81irbI216xMQc6WW2rnOm62MmMmuxi0a1WjYaprsYKYYoaDBeuuJ0/Q4zN+e
 oG/YNUlBy7OzY3db0PV7e6GLYoeOObC1+II= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3agynmanj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 19 Aug 2021 11:22:09 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 19 Aug 2021 11:22:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KRh0kAZ6QeOhBmaUyycFvU5XytdJ6M8jL9HkK/MhpowVsOcXHAmPJy2uVUfiRLfChJco2c9vH3Fz70wfr9TQO/OAzA5H4JB7EL30M++o0o82I9ybFE2t3iEjRKWX6F8dZI6Ga/iowPo8/sq89lR94wyUxsy9JmFxKQABQbQrVcDNnWNyTU5DADemvTvAJl0nY9AN1nHaH8IPKNdpJB/2V3SpcDj5pbSW7UbspVSXUDCaQczQDlwtGHoqXTv4ZMIP6FWaB78v6wO/JlmNzRYP6M2NsuXdvf+iDFpv6Kue0U/T91dZSSACRG/2sPe2eo3PQBxhmQAHn+6NQqDj2JCn8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ZztgNwf8gvLLSEt8aFnMpGoEoCgDaM2r/P2dmETFi0=;
 b=kXJH55H+zxvhkPSO79rAA024yL/iLFrf0fTFOCWysvJ6y0/u5DNxBhfSfYkjjI+hLLVN9x9rIDZySyOIrKcU3gu3CTJd+afbpVlz0UnC3YNgZZ8nctej3YhqMU2mjTIx4S+sx0x205C8eFtIbNaZ4S+a+z4D9MZl8CI0R/a7GvrpuTnobvcPpZk4g8PorcoL4utcmMO4MzbV6gI0TpDPOTE42ibOpCTYkQ1ZTIN6/Hx10yCDzycwKEWuG4DcxixV7ZrBKH4N5xnP8PU46rW7hqb0eRAgUuk6JaaOjcAjdHaLX9zd3OxiRMTJDOKQ1GRtwYpHLc4vpxJU9sD8ekb8Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5094.namprd15.prod.outlook.com (2603:10b6:806:1dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Thu, 19 Aug
 2021 18:22:07 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::1959:3036:1185:a610%4]) with mapi id 15.20.4436.019; Thu, 19 Aug 2021
 18:22:07 +0000
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
Thread-Index: AQHXk9CX6/TyfH2Y/US67JUy/V0E76t4+50AgAB99ACAAUGPAIAAULcAgAAWb4CAAARTAA==
Date:   Thu, 19 Aug 2021 18:22:07 +0000
Message-ID: <A5F7CF90-27F9-476C-B87C-CAD2A6BE5DA4@fb.com>
References: <20210818012937.2522409-1-songliubraving@fb.com>
 <YRzPwClswwxHXVHe@hirez.programming.kicks-ass.net>
 <962EDD5A-1B35-4C7F-A0A1-3EBC32EE63AB@fb.com>
 <YR5HJkPyaM3TWkkl@hirez.programming.kicks-ass.net>
 <AB509D87-67C6-4B7F-AEFB-2324845C310C@fb.com>
 <YR6dreGQSe4oQFBr@hirez.programming.kicks-ass.net>
In-Reply-To: <YR6dreGQSe4oQFBr@hirez.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 62b8afaf-796b-41a4-8df2-08d9633e40e0
x-ms-traffictypediagnostic: SA1PR15MB5094:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA1PR15MB5094195817B8ED22BBC58E79B3C09@SA1PR15MB5094.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kyqw0Q0xZSHW3bb8RCRe6wU2ins8Hk+fZwBw/kXt9Yom2zMI3jNMPU/fVXUr60GZlMmY19FSuyEiv7YiJBu0lGOYxvNlBEPwrGHBjtmo7dL1T8hUPUC+yVNvg7rCNKq3hOJ+kKmTFpQSNmmLTt73jH8E6RFp0Fz7/M+1C1lcBMgr0upGAA2EgnRZU65yGpq1V4kefYGrU+Y8UR2GV2AXuWdq9zlWAcvjZlGr7THbQdOH/+HAjF2AM+aSTgzx3FAZndS3i5EW6SLTDz1RKzTklulULotqbf1EDzTgqYB/V8/PL3GXuO1BKpjIJEockvftXMEfedIW9Hzx0oG9dpqAgw0PG+1+ZSJuvSKoRKyaRYeMPdME3qIRiO9OrUhGHqI17bGg+/v4XM6AqE1BjIHga09jK+MbQcAiutZV/wsF7yu8QVv3RPbaGO2XGbWSjgXcOPtSKnAWHdoTi56abyaiXqTwZnFIzYgN3Smo9E5ZcZEEknrtrC+MKV6sW9qg813m4A2QugWjcpWan+7grzadwTIKiBQoqQ0H49IlxqHadieR6KEWeQeTgFRgx0AW7FHYr5YqsJQDwPi5ns1a99boLnAMtPkIJf8lPkPnuHxrF7VSj19hK1WB/9kTjVrQ8jojXpGU7Q6Iuhp2KUhEoNfT9KNrKJTHLKMBkDPiyrkfr56d+VfrH0GwleNrOzw74HbJFuIJcydKpi7bqKdHi1JRKKJrisHre/227MAFTYu2QX1/MgZSt4dRyuKzWUVVYaiLagJo3tIhgLQ+GeLCQQoczQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(91956017)(66476007)(6512007)(6916009)(8936002)(122000001)(2906002)(316002)(2616005)(33656002)(86362001)(38100700002)(83380400001)(5660300002)(71200400001)(53546011)(54906003)(6506007)(4326008)(36756003)(66946007)(6486002)(508600001)(66556008)(38070700005)(66446008)(64756008)(76116006)(186003)(21314003)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NDJfW87piOFo13VaHKI5e/FOoKJO7DGftqAkeKLzqWNq+Qx19Hzs8iX/V8C2?=
 =?us-ascii?Q?2ZPUj2fW9HWG1ww3qT5+I0FqETNOykzbROuNj5UkEhxONXxqKOfkcdwtbmym?=
 =?us-ascii?Q?2ZQ3803idjK23Y8C1DABb67y2Gmy4HpJVNlwcWnggtDvjqWEnQYjEUKtUNWg?=
 =?us-ascii?Q?my8kE4XwWveVvYVDfAgty2vcXh3nFcrUhkmyzNjxRi1XMVeiHjBBpIke4sg1?=
 =?us-ascii?Q?Blugzcz1XT4hNHUkHFOr8jjVpDPthq+6gMTmNKTZZriDxOyBs/hmMFE3ae8j?=
 =?us-ascii?Q?Kj8zTNQB3+QvEdnJRGU81xj/DL50BX4FDwh7FRdiwdHqgs0rmHXaLzeMeHe6?=
 =?us-ascii?Q?fNcLfvmqE23hADtdeEJISbeApJh8MMDAQ2Cs+Hd8lEKllotCcSk57/f0tMxT?=
 =?us-ascii?Q?u2/UcYavRQWZt17i/S1u8+KS+BSs/52YSSXkQ0t2sCxXKm9YK9ZlTh8L6l9H?=
 =?us-ascii?Q?r+/8tJbio30RhdGb2lN3wEQmG1AayqN5PcIx4JjEhS06BTf+6IstZFUS65e/?=
 =?us-ascii?Q?FhqgWTVHH2S7Ix4+Ibxtzc9BUgq8lrdnAJmcL6N3UqLiw2kAxM3Ri2rzfvhy?=
 =?us-ascii?Q?BuftEI1CUdzezT+RXqJjMkaQKTE4E/xW4h7bmMcTS3sQcxreXz9WO2LVOs2b?=
 =?us-ascii?Q?d0D/Ys63ymZAm5CrFSaImhWeWRkVZREZq5Fycu3rKC6kZKaIJIwyQnwlHtWN?=
 =?us-ascii?Q?xEjX1DlGHd/6uLOe8MkGX5SUAfzbWt1abRpWGbHU1fUNFUZY0vP+iPQbMRVW?=
 =?us-ascii?Q?B7yV1E/QPmkdb/ecBd/xFl61Eun5cW0ctileOvPELherpyaIybrAvPxWOm72?=
 =?us-ascii?Q?+VUVqWrAAcmzOPcYTTBrxDMBNcNIB8FgznvEnaqzGWO1mtrlOm8dAU1bAvxC?=
 =?us-ascii?Q?0E0YeKaB6aZ6RobrQPr8U1+ptW89NFY/32YTw7ZOZrooLdMvZWTc5Ym1Y3MP?=
 =?us-ascii?Q?isQ3lyj5vy8UZZ8U9+p2BIsX6MEipuOaf4J/vf/bCfV7GRjnGBH5+v2KxpGk?=
 =?us-ascii?Q?T3AsflQyLlSNcqulDqCS1dX3l46b1wF7uPh0tUSkA51d6gQeuJ4vjcTrRGMW?=
 =?us-ascii?Q?XWzjzSmd4IYGOjgmuMbSKVCHHwAZujXjQiiGgBp/lczh51zDa5qvX0IvcGSk?=
 =?us-ascii?Q?CAevBNR2HR8e/pMYIGpEXDNj4OT/jayEqS6UC1YEbj94PnCH5np9Hdc0E3X+?=
 =?us-ascii?Q?rndjOTSSfFKNx7evVVqc3UfDvo5LpAAIZhQWifqi3Ta2L+25Oaz/HBLSwePX?=
 =?us-ascii?Q?SIrNbFuK3pgoWKp5aJkBzOtKL1lZ1Z/IJ5VBMHUbK6GdlhHFjvWKzzyNDSrN?=
 =?us-ascii?Q?pFWU/LHjRq3cMvhuAEGJsfalmtTcELVSiSbR+ruFvRYSG8tQx3pbNiWT94y1?=
 =?us-ascii?Q?pZ8Mf1s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FADDD390550C9441BC820D0B8BDEC72F@namprd15.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b8afaf-796b-41a4-8df2-08d9633e40e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2021 18:22:07.6175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 53UPSQ7qMP7vvn6b4QdS4S9sacXD70VknKgXhektHzFemKczgSTnaRm3+lmC1soaDtac44dNQ3xzMentAZ4qvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5094
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: iq2fXDJ_6mA7BqY3E3azx3nMO-T8pt7r
X-Proofpoint-ORIG-GUID: iq2fXDJ_6mA7BqY3E3azx3nMO-T8pt7r
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-19_06:2021-08-17,2021-08-19 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 adultscore=0 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108190107
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Peter,=20

> On Aug 19, 2021, at 11:06 AM, Peter Zijlstra <peterz@infradead.org> wrote=
:
>=20
> On Thu, Aug 19, 2021 at 04:46:20PM +0000, Song Liu wrote:
>>> void perf_inject_event(struct perf_event *event, struct pt_regs *regs)
>>> {
>>> 	struct perf_sample_data data;
>>> 	struct pmu *pmu =3D event->pmu;
>>> 	unsigned long flags;
>>>=20
>>> 	local_irq_save(flags);
>>> 	perf_pmu_disable(pmu);
>>>=20
>>> 	perf_sample_data_init(&data, 0, 0);
>>> 	/*
>>> 	 * XXX or a variant with more _ that starts at the overflow
>>> 	 * handler...
>>> 	 */
>>> 	__perf_event_overflow(event, 0, &data, regs);
>>>=20
>>> 	perf_pmu_enable(pmu);
>>> 	local_irq_restore(flags);
>>> }
>>>=20
>>> But please consider carefully, I haven't...
>>=20
>> Hmm... This is a little weird to me.=20
>> IIUC, we need to call perf_inject_event() after the software event, say
>> a kretprobe, triggers. So it gonna look like:
>>=20
>>  1. kretprobe trigger;
>>  2. handler calls perf_inject_event();
>>  3. PMI kicks in, and saves LBR;
>=20
> This doesn't actually happen. I overlooked the fact that we need the PMI
> to fill out @data for us.
>=20
>>  4. after the PMI, consumer of LBR uses the saved data;
>=20
> Normal overflow handler will have data->br_stack set, but I now realize
> that the 'psuedo' code above will not get that. We need to somehow get
> the arch bits involved; again :/
>=20
>> However, given perf_inject_event() disables PMU, we can just save the LB=
R
>> right there? And it should be a lot easier? Something like:
>>=20
>>  1. kretprobe triggers;
>>  2. handler calls perf_snapshot_lbr();
>>     2.1 perf_pmu_disable(pmu);
>>     2.2 saves LBR=20
>>     2.3 perf_pmu_enable(pmu);
>>  3. consumer of LBR uses the saved data;
>>=20
>> What is the downside of this approach?=20
>=20
> It would be perf_snapshot_branch_stack() and would require a new
> (optional) pmu::method to set up the branch stack.

I guess it would look like:

diff --git i/include/linux/perf_event.h w/include/linux/perf_event.h
index fe156a8170aa3..af379b7f18050 100644
--- i/include/linux/perf_event.h
+++ w/include/linux/perf_event.h
@@ -514,6 +514,9 @@ struct pmu {
         * Check period value for PERF_EVENT_IOC_PERIOD ioctl.
         */
        int (*check_period)             (struct perf_event *event, u64 valu=
e); /* optional */
+
+       int (*snapshot_branch_stack)    (struct perf_event *event, /* TBD, =
maybe struct
+                                                                     perf_=
output_handle? */);
 };

 enum perf_addr_filter_action_t {
diff --git i/kernel/events/core.c w/kernel/events/core.c
index 2d1e63dd97f23..14aa5f7bccf1f 100644
--- i/kernel/events/core.c
+++ w/kernel/events/core.c
@@ -1207,6 +1207,19 @@ void perf_pmu_enable(struct pmu *pmu)
                pmu->pmu_enable(pmu);
 }

+int perf_snapshot_branch_stack(struct perf_event *event)
+{
+       struct pmu *pmu =3D event->pmu;
+       int ret;
+
+       if (!pmu->snapshot_branch_stack)
+               return -EOPNOTSUPP;
+       perf_pmu_disable(pmu);
+       ret =3D pmu->snapshot_branch_stack(event, ...);
+       perf_pmu_enable(pmu);
+       return 0;
+}
+
 static DEFINE_PER_CPU(struct list_head, active_ctx_list);

>=20
> And if we're going to be adding new pmu::methods then I figure one that
> does the whole sample state might be more useful.

What do you mean by "whole sample state"? To integrate with exiting
perf_sample_data, like perf_output_sample()?

Thanks,
Song=
