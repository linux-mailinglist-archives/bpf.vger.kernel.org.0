Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9F175ECF8E
	for <lists+bpf@lfdr.de>; Tue, 27 Sep 2022 23:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbiI0VvO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Sep 2022 17:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbiI0Vuo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Sep 2022 17:50:44 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8276E8DBB;
        Tue, 27 Sep 2022 14:50:39 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RHMqO0010696;
        Tue, 27 Sep 2022 14:50:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=URketSHuotzh4ZQm0dJBbMSoanl3P7/+rGz5JeBMy2Q=;
 b=QqlsD5Fz3XVSCJutqOSKyHtlESQUSimJWjJmTyilvfLmkvrKQaWF+iUtnwk8qnxyQxH6
 ptsz7GIbJcQiZLsbrflsgzfoGqd7rV71sO8PrzJ8/+fqL2A0nDqfrLghIUB7eVnag9nI
 1A/0TJYe1fA6+9USm1U5C1gKK+csIXkHrgk= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3juwhvdmaf-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 27 Sep 2022 14:50:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQmZnSmY2oI4SmB9Vh5nO9Xz3m/Z21jiYQr8kcFzIEZe0Ucabt1YGgfgfgr5xvWBE9t+da/q6YjxqBGcWGnV8eQDKMmam47rnDt14WQqsa4oqJyApPu8DxGrvRBHv4ZGHinCzvR1obMoXYr1i9ay9Dulx0gwGpYwHHpz87bXqIjlhB17v0W+qbiHr2mRZaVdQK02X58ciXVjwzqzZNVcSs0mTWvUm8SZgRBookxL959jB0YZCW189vIEoIiHWoK7Ta7gbjw3HYsxD4SuES0CKC2yE4/sYdtEaCwSZPJUQASaaYrSOl2jEBCi6vVFXrN8/310gmgpFaEmW6jLqQmxBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=URketSHuotzh4ZQm0dJBbMSoanl3P7/+rGz5JeBMy2Q=;
 b=IAZkEti6hWm6nUuJkhL45Qn6/+3xpHmzpzZOkqOkeD99wJiXIpKz862NbSUe00Z6he/pygRJqSZgt7vwwdGN9qbahWvE8QUrMeMpHW9RJ3ex3JZq7h6qauA7GvySh1gY6pio1jvK7xGu/zkL4j+zlpSWW+2BkP949v/QF/wobGtnB4gh+SQ1p8obwii7aXJdzlAt3WrgTMaP9xv+cUNzBcmHqT8hoYy/95+jeR1euM5ytFX3f9co8pUwhn6jgEWikMUPvWKxdqpb9jtKWgeNVTKyJmqj+fwMLEh+hhaT0elBs9OceyqurUzpxA3/TXne2wv9sxI7skeQ+MOrYpyVTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB4627.namprd15.prod.outlook.com (2603:10b6:806:19e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 21:50:36 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::d70d:8cce:bb1:e537%7]) with mapi id 15.20.5654.025; Tue, 27 Sep 2022
 21:50:36 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Jiri Olsa <jolsa@kernel.org>
CC:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Daniel Xu <dxu@dxuuu.xyz>
Subject: Re: [PATCH -tip] bpf: Check flags for branch stack in
 bpf_read_branch_records helper
Thread-Topic: [PATCH -tip] bpf: Check flags for branch stack in
 bpf_read_branch_records helper
Thread-Index: AQHY0rBcg4dF4W5wg0q61WgUTBhZS63z0JqAgAAAXgA=
Date:   Tue, 27 Sep 2022 21:50:36 +0000
Message-ID: <CE965785-D811-4E37-8EFB-0FCF79F69A04@fb.com>
References: <20220927203259.590950-1-jolsa@kernel.org>
 <A702994E-0649-4B05-970D-9CB8694E86F7@fb.com>
In-Reply-To: <A702994E-0649-4B05-970D-9CB8694E86F7@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|SA1PR15MB4627:EE_
x-ms-office365-filtering-correlation-id: 17e97f38-51f1-44b0-b492-08daa0d24fce
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2f9ocWP9nc34+xPxpiiaNIxw5tCodssCZ61MLT/JFI7IRgiTh2zH+CiGIaOVs4DhHk376FDyg20TbSnEpiSlsuSKX6rGgdDuWrzWmpbJV7vavGhYbu/0r9s1Y3niphrk5KrH0KRYTiwV+oTMspLtw935H/6vGpDLNZvLbXNQCdW7EPJ/zCeU+yq4WzlWQCcwjieBhwQy5Cot0aXGU72S7myl5NqfEe863Z2U0KRoLYcT9X8sJilkJusev83JuSze24z3h2P5ccoXqdkPH5NQx7RXYwzgT7mGdClDwW5xCMfd4LCMAnf0t4kdS1Qg07TpvztXeQ5VWyjpKsxDL0Qu3ywzYJpUMKJf1R+XkpR+TkgnW38N0Zyq8fzPOQebqbVNlz0ttZvDUSZ5RCtNTEnIJ/bKhVfhE7b5xDwfLatSvEh4bpICJPNNU3qqgPe8Xe0yBzPAd8sA/+Q3/HAWThWFUIpoX+Pmg5r4KnQqFFUy/fXGcGmmOcvk7DYg+ZXI2H/7Iy9OFm1EwR+lS0ue6D1w5388+cZVdCNCriyty6q4BlEIGHQWrdL7IwhKuOihyCj83M/ggLcMskn7tYdLIcMGZNwuqDUm0LVFAgp30/7thOC/Fqrd0Ei1EpFHBuJxH0PcFhPC/sFPtYtQrod5v8HvKLKy2/Wityq2604DrZz9wcNT9OwvVNv2wVoWqqag/j+vLh+xWv0wVxtg6cUjzX24YAul3XA94UbpL8MmdH4EBzN62G1SJF986PR73P4UMKG8n3ul6xDm9uEx6nZWaE6njO1ayEkDYeh0hHhPJvSTDo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(39860400002)(366004)(136003)(376002)(451199015)(122000001)(5660300002)(36756003)(2616005)(33656002)(2906002)(186003)(8936002)(7416002)(66446008)(66476007)(66556008)(41300700001)(6512007)(86362001)(66946007)(76116006)(38070700005)(8676002)(64756008)(83380400001)(6916009)(6506007)(54906003)(316002)(53546011)(91956017)(478600001)(4326008)(6486002)(71200400001)(38100700002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gLC6xPwWDiQroKrD6kpoPhi7effaRiaIoEVzQJxvgAcdvRIoo5Yslk46u0xn?=
 =?us-ascii?Q?SeRrUmNUPdJKriqD5t1cmH8erLrGrup1jArLYhwQ6VIXA0+dg/3VdiUdqa0Z?=
 =?us-ascii?Q?PrlV+iz5w0yXpwk+2djakpy8YAFBhg8Q0yPYPdUwp1EZyd9nhIaoxXycYQvK?=
 =?us-ascii?Q?wcT2rEG22bsg+qaCpr9NYtuxJjJz2vpCgWYFdcst7Uqibu7cOdioV9w5n5BD?=
 =?us-ascii?Q?iShSeO0NeIscH3KcsNKKDAoc4L8qosKxWF8GKIRaWNFf/MOO4D1LMdYsd8Qh?=
 =?us-ascii?Q?VG9iGCiHSJnfjDNHi/zXqNrmQFk1LSCEEKYkbspFJkx+c3Jpe5WHMtPg6Rly?=
 =?us-ascii?Q?i/jgYzjZD+h95k9WsFNmCJDYXxF7r5Vy82V2x5pwOYzHYASPD/En3vISt2zb?=
 =?us-ascii?Q?0w8d8sKTAsMirmR+PhmsxXWJ7P0n//vILS5FxPB4blgi4IeRwpoNb9fnLvo/?=
 =?us-ascii?Q?kIhHS/tqQ2R0Qr+b1C1Zxt7bj2i6Bvnif550j6863kSQmP0KoJkSBh4qeYZp?=
 =?us-ascii?Q?iQ50MN54omUw/kMkGGajlqPOFpd8pgysZIhtnJpCGFxT27tN8kWmaarhwVjn?=
 =?us-ascii?Q?x8sezPFkvXT+R0opA/44uKPsVYwYRc7UrxX/fYZK/QWJ2VZV4uWVF4OHUj7O?=
 =?us-ascii?Q?2wVhpW+wYyhJ0VNhw6lk1BXm3o8daGHhYL+l9RdVvj7hyzcOuaJGmpjTKlvC?=
 =?us-ascii?Q?PiHTuNDxbrPRhxLO5XsMSVGVzz29PBeh4RSZ8bsv7kwrvYMuVeXm799NmWS1?=
 =?us-ascii?Q?G1Vg5Yn0kZ6SMEWNG0E6pwl64xi3rZjmx3SxDKRhiKpW5oL/RK9EOIRFjFT/?=
 =?us-ascii?Q?jHQI+vnjqQjW+eSaKNm967NjDbpI/6yiplgjVBRRZmx7PSLsK7fX0xFhjnlq?=
 =?us-ascii?Q?WjQ2mawhYncSg44O2FcI0CMktdUtC1EKsXCeJo+CqwRCAfQ6slT316ZXY+mv?=
 =?us-ascii?Q?kJMDCcuc+TAxQEroaLRhMwRDhcya8aGpdcqiUTMDX8jrovjIX3jbJmDM5kCm?=
 =?us-ascii?Q?6avCjKzV4o7whEIUFnVPGVgzPuKfl/DKYdgghrJlsehRprTaDLRuRfNYRBPq?=
 =?us-ascii?Q?8QoaIl7NQ70FXuhelzGJQF+wxIIKspGhxC2j5to42VFz4joDw6IuUANqzKFo?=
 =?us-ascii?Q?yfS3KVz2Wfu0j35xcktHOz0tKtpyPiDeL11gEkvXpRHEF2rczeAafAGBguH/?=
 =?us-ascii?Q?G0kYQMKXgl1i9EhSfY7K6xItME8q0RmQrNybzqjm7h0/FBoFpnotwtMHkA6u?=
 =?us-ascii?Q?Oya2IkGPLh71TvrArKt8AA62K809wEJGWgq+hrdPW3nQ3sinoVOas0dVMlo8?=
 =?us-ascii?Q?1uDP7AtRCuGzwErt7aHYYRNmfL/8SZ4W5l/iOHwGzNYhV3UTQVe6pKwqczNs?=
 =?us-ascii?Q?kTDiXUQ8nXNXNblYbhYYyPzb7sDPqQ9+wHNsekEZFo+DnWSIEhvEVZ+iLaWP?=
 =?us-ascii?Q?XcDHjjwVYE/SuU63t79puTzh4YO/LkntDyZFswJDxixKtlpFjMR88VH7EIt8?=
 =?us-ascii?Q?scxHoD5jv7n3qyphivrYDvA2RexcVVleT9tc7yFtZK59c0ecjYvQyhl6JJhR?=
 =?us-ascii?Q?NQsG+x0GsWB9R3Wd5CcASUX3FgdJ2bu2BLcwm/oUq47YmkUnr/ITKk0l6QFM?=
 =?us-ascii?Q?cLRy7xJev6XswzizYkbZDMk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D4565F071CF92E48A4F8F4C7D76DBFC8@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e97f38-51f1-44b0-b492-08daa0d24fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2022 21:50:36.8713
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WOrsBRlt5pEk4jG5k+X6/LGk2R2rVk1fdSuuKYzCZ6PTTFmFanTYN9FGzBX/u6J1os7eLEOaAwKieSXQ4zRvkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4627
X-Proofpoint-GUID: xEqzZvIgLyXGDT0yoPW_gnipS50NretL
X-Proofpoint-ORIG-GUID: xEqzZvIgLyXGDT0yoPW_gnipS50NretL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_11,2022-09-27_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Sep 27, 2022, at 2:49 PM, Song Liu <songliubraving@fb.com> wrote:
> 
> 
> 
>> On Sep 27, 2022, at 1:32 PM, Jiri Olsa <jolsa@kernel.org> wrote:
>> 
>> Recent commit [1] changed branch stack data indication from
>> br_stack pointer to sample_flags in perf_sample_data struct.
>> 
>> We need to check sample_flags for PERF_SAMPLE_BRANCH_STACK
>> bit for valid branch stack data.
>> 
>> [1] a9a931e26668 ("perf: Use sample_flags for branch stack")
>> 
>> Cc: Kan Liang <kan.liang@linux.intel.com>
>> Fixes: a9a931e26668 ("perf: Use sample_flags for branch stack")
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Acked-by: Song Liu <song@kernel.org>

> 
> Thanks for the fix! I noticed the issue last week, but haven't
> got time to look into it. 
> 
> Song
> 
>> ---
>> NOTE sending on top of tip/master because [1] is not
>>    merged in bpf-next/master yet
>> 
>> kernel/trace/bpf_trace.c | 3 +++
>> 1 file changed, 3 insertions(+)
>> 
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 68e5cdd24cef..1fcd1234607e 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -1507,6 +1507,9 @@ BPF_CALL_4(bpf_read_branch_records, struct bpf_perf_event_data_kern *, ctx,
>> 	if (unlikely(flags & ~BPF_F_GET_BRANCH_RECORDS_SIZE))
>> 		return -EINVAL;
>> 
>> +	if (unlikely(!(ctx->data->sample_flags & PERF_SAMPLE_BRANCH_STACK)))
>> +		return -ENOENT;
>> +
>> 	if (unlikely(!br_stack))
>> 		return -ENOENT;
>> 
>> -- 
>> 2.37.3

