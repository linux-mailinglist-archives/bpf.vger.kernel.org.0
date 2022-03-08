Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24DF04D22D5
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 21:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbiCHUsk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 15:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244448AbiCHUsj (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 15:48:39 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D058FDF41
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 12:47:38 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 228IorHZ030510
        for <bpf@vger.kernel.org>; Tue, 8 Mar 2022 12:47:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=29OGnNJCP4cDlHAD95BVRdARGtq8y3oBALdZZ2U3NN0=;
 b=TQTFqXtzXUmrd4R+nLFfEamWQUGhKgXOl8OePpqh/WoyOkV4iK35Ir0j+LYhedZHATnJ
 pfJrpULw7AlDdzNYNyp9ZWcUwDFXeM9R7n37sITF5TclqWBj4ZefK2aHoZhw+8o0bj/z
 cn+82yNQWAQ5R9pN32yWkNHhawXhFUCfQac= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by m0089730.ppops.net (PPS) with ESMTPS id 3emrgr1nf0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 12:47:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgMeYdLTR9c4TB8IjBYsBN0nQcqjUW+YWR7KtJ+T9MkidnToRYhJ+sJtM6GK8UxyaOPUi9Ymt5g+heoyPAuTxItbQD8TXxKupe6PW5kw4WtBNZLGGtSgVG3ucMEeUFgIMk+zYt/Dt7LJmROakXYLKjmDQdL1fkryVmaPAu8pY6ut642CLrFj6goXm8zPENxnKG4O2Qi1vA/s1tB1QVK/HaR7xmSMhDrpUMTDvHlD1ztgMTfq4tvqnIZabBUvgp5wH2R0swQ0NxS3KlwDj8KOi1vViLMsHywXk6TjM5K1H3/zhNSZtHKfbC3P0bFjUSBsg8cDIJLsMxPxmyCDADVfcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29OGnNJCP4cDlHAD95BVRdARGtq8y3oBALdZZ2U3NN0=;
 b=eZgOLQTg9+ZxU8GREJ4uu5D7PIMPmpFFaBSn1i+xbZU5tW4FMG8sQtpV4soxO4V1VJh+39w/Ygi+EEkj6jvdHr9r++R4X+QuT5p3dTsiRAS/iFHmCxBobRi4CT0xM0M/Rd4mDLn7MYRpradrK0bJRcguqWrs4GwK0xyWE/v+MLXlSQgbCtvRxJfYHIJDBdl0XfuGq5vWJhpMbXzIxvg8GQT4GIPzodRsFlaJ/4wVvu9MBWaxJtoKgg/gdaMyssuwc3ADd6VbZHr398hXWfFuSBqOt+3tp+uSnXlVBsJyLi3lYD87kpkoIKiircSaTA1PWY+PrxbIgCxRtY5EtGXpvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4732.namprd15.prod.outlook.com (2603:10b6:303:10d::15)
 by BN6PR15MB1217.namprd15.prod.outlook.com (2603:10b6:404:e8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Tue, 8 Mar
 2022 20:47:34 +0000
Received: from MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def]) by MW4PR15MB4732.namprd15.prod.outlook.com
 ([fe80::94b7:4b41:35e4:4def%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 20:47:33 +0000
From:   Mykola Lysenko <mykolal@fb.com>
To:     "sunyucong@gmail.com" <sunyucong@gmail.com>
CC:     Mykola Lysenko <mykolal@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH v3 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Topic: [PATCH v3 bpf-next] Improve BPF test stability (related to perf
 events and scheduling)
Thread-Index: AQHYLnxiZfEZocnpPEGc3tnOIrk6Fay19pMAgAAH7IA=
Date:   Tue, 8 Mar 2022 20:47:33 +0000
Message-ID: <716A2758-404F-4C3B-857C-95879248D31D@fb.com>
References: <20220302212735.3412041-1-mykolal@fb.com>
 <CAJygYd1X+aYQ1u96bwU+a5wDzADDGMH7f202nq00xZMr+YRScg@mail.gmail.com>
In-Reply-To: <CAJygYd1X+aYQ1u96bwU+a5wDzADDGMH7f202nq00xZMr+YRScg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a0b28a0-ce5b-4df1-238b-08da0144df0b
x-ms-traffictypediagnostic: BN6PR15MB1217:EE_
x-microsoft-antispam-prvs: <BN6PR15MB12177BA430A7A846AEA92047C0099@BN6PR15MB1217.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: um4mcg4kG/gcIbl1ALmtiEE+p/OFj2sg4VLXBfGvv/U6OAhg+r3t1CSVcNT7nrZY9AZ/4G0vsLN1AQR4tKwSy5zH4zgKOi6Avv6PievFxJmNBtFJ3JzMIR97k9VoNqDexiuQ1CtVSUXplCcnaD0imbY4KxYR9IER/ND9PrOn1+H1teMG8wyPAfw6s8oWcbmtPEskiujrt0PjXq/rMefYHX+1lLmCMG59d+qrkeJeOwE0fuC5qsxJIGh4vo17Vj4J6tsGWYDSb7RzK2uIjjdV3Ax9Hu75EyUVsGuXRSZiBrjfD81xDiuxYdAduQMgfhg6taJtFpKxgVINiqdBE8IV88xexSRNa0UpJO2iJzSMd2k52ewPRY/XXD9G86thaGAzQh76pA4o2SnevqrKI2nwrxEXon1mwepzIK1U0D8X3G9HMSQ1Ak6buw8J6BGO0w51g9SgyXLu0+wWmKnyVQUfSMUvT7ZmZoqmxlHH7xUfCEr7QVTJ5zQKxQUUYy1mcc/FUQfV3apWicb9MmbUFH07phgaWj86oRahpcp+Pb+93a92Gd3iR80bgvfit4sZmxg8OU8KQjOajhAVT/3xJQD/eMAFXAf9KBgA2V2rc6zowZ6HInUod/MScCYU5zCXneOGGMME0D07lQ+75lF60W2PDU/Gi4y9JaX9LZvucc7Pg8PPIbRjYKlnJ1TQwDzh7JO1Wxk/OCLLb/NHZvh8YBIAKFKDfhCc4XFEJZsEO21+xdLOdevnKbOUgN3+iNcFdPcU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4732.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(6486002)(38070700005)(33656002)(316002)(6512007)(53546011)(54906003)(36756003)(6916009)(6506007)(71200400001)(76116006)(508600001)(2616005)(5660300002)(66446008)(66476007)(186003)(86362001)(83380400001)(64756008)(66556008)(8676002)(4326008)(66946007)(38100700002)(2906002)(122000001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cb5xrg51HLxwf+yuUMtPLEodOyjzjmu7eCctYnbOKw7lpLaigGkPst20U+2F?=
 =?us-ascii?Q?jrNgpwea7XinTlsya40afkTy/w38QXAVXD+Ytn8hSdVzhr2Z4p0EXSJc+I9+?=
 =?us-ascii?Q?y/g9ckO/qDxFUU57cZllTc2SM4jUUNUq+M5tpHl61J84uLymgPKyPzrKaCKg?=
 =?us-ascii?Q?yAwB9RVGqp49Nab7+IW4YvmLl41Gd9TkX5WK0PLNmSSk3GWODPFHsE/IKUfP?=
 =?us-ascii?Q?58R4wK8qTmXjmVWMjUgz2txfoqpSnCDgRJPPqnFqVacNa4010c08PWbIlsiF?=
 =?us-ascii?Q?zX+W0HgV3W7TlkW+MOiZrdBp1sb1Zq9MISHX9ntMh+xxTgbiEqHeNFmez4fY?=
 =?us-ascii?Q?8X04KelsppM2s1s8C0zrf3pOOwsJ2nZR8rIXARQYAQE4x8EW3FrAtI21zmXq?=
 =?us-ascii?Q?ILuPiw8q65E4Iri4G0dTKRAVa9zpG4kXm+1CRlktYCj0Xwl/tmnLmsjmvYGS?=
 =?us-ascii?Q?gnSpqZEf60UDUQZeibZtSjntQ5+pasxfaHM9SXGOUkP+/UNmsfVrH76ZLYru?=
 =?us-ascii?Q?vnNDhr4d8iJfBccXWcxCugxEg87GH/byC99bfHyH/fulIMAJ16+n67zPajQ+?=
 =?us-ascii?Q?poDhgh3tGkSkTvnwTl9PhejqLvBWgC/WRRDtQGqqKuU4FH27xfob7cZJ3O4y?=
 =?us-ascii?Q?C28xFDpEFIAu+jkwyVAWE5En6he/OfeYiEzDpmvUh4jJedUnDaU8wuEmAkDZ?=
 =?us-ascii?Q?YKgmaB7ROoKYwlObL3pb9KZwP+KJiXg7FlZ9sQSUQvrD/PPZxUTkvt3Z9VUK?=
 =?us-ascii?Q?kgkuijJEVCWjufax0ezwcl1D74bzYOOR3kUFKsJkHsaMxLujRNX12bLZ8uMT?=
 =?us-ascii?Q?8TB+7EOZyUfb4Bfu5u3xQaVhboIK4Kfv23trOpm9zjOs4uc/+n6INFyQj5wF?=
 =?us-ascii?Q?6gMMs9ymCYsq2SIeJcqLBCCNvbw0PsT3CoQL9cBkguN/V7G+ltUxYHNiFsi8?=
 =?us-ascii?Q?jPT/ULQWJ7HERlczw7LxthSigJHXq81VDzPU8yIk44iauBV2ZcThLzCvG1h1?=
 =?us-ascii?Q?8ACc/p8yAylt3mRc7cC+GjNFpIxvaWnjOJXOsjcHO62w8TIjtLcHEbcj4kCP?=
 =?us-ascii?Q?CIRGzmTeiees4iKielck3Fu5rAXpCUV2f4L5T1GuJT2ELHI5KnIlGi6t/bEZ?=
 =?us-ascii?Q?DtinI0pYnmJGGdTRUHf/P8cfSKLYFLYoKI5jsb5f4jq2TOP/tfS5MKFrqu6T?=
 =?us-ascii?Q?c6cxBMoJ/LAp5Vw5nrylj6rcs8Wj+GQmMKPfRARcQi/eVGSAlQMRhGGCowVl?=
 =?us-ascii?Q?zPfWtSJcyrTE8gJp8TJ7LyCtCKPGkMB5KTWdWhvXrsTr0AJLM7STOrdVsbDU?=
 =?us-ascii?Q?Gpy7I/zUGtWQnX+LzoNLcIBdwfvC0CqwknKJhM3AJwQhsp89hqLn8ne4IWMi?=
 =?us-ascii?Q?U9648ZnhxJhDv/4tgvSqViphD62N5AnAixayi1MAB1PzO6E40faUadjWKPh1?=
 =?us-ascii?Q?PG2hzAuWcKFSh0w8zeCo4VsTYv5x9CMA4IvGgq+v8BZL6liSdeu2xTSI+GOR?=
 =?us-ascii?Q?5ZN0YhmgBJMa+JzGzxYCqg7KcPwBUpoD2UNeQOryo6lfMJ0PPtLC2ZjD0NPx?=
 =?us-ascii?Q?4AfjrSEl0NFwPOjB6Ok8TzxD6VuKM3sxr+cq/9vLN00dvR9HNO2KwBMO8W0J?=
 =?us-ascii?Q?cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4614089431B6724A8CAE9D623598755C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4732.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a0b28a0-ce5b-4df1-238b-08da0144df0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 20:47:33.6862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kRwRxd3Kz55R8D0lvse3ImFjwvdPne/SVHpPH5xdqHIguQ3oarESi5xl8hmPFsc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1217
X-Proofpoint-GUID: Uby5X7hB7Y_AZSPvIU_LH2qFkgc7CT0o
X-Proofpoint-ORIG-GUID: Uby5X7hB7Y_AZSPvIU_LH2qFkgc7CT0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_08,2022-03-04_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Mar 8, 2022, at 12:19 PM, sunyucong@gmail.com wrote:
> 
> On Wed, Mar 2, 2022 at 3:53 PM Mykola Lysenko <mykolal@fb.com> wrote:
>> 
>> In send_signal, replace sleep with dummy cpu intensive computation
>> to increase probability of child process being scheduled. Add few
>> more asserts.
>> 
>> In find_vma, reduce sample_freq as higher values may be rejected in
>> some qemu setups, remove usleep and increase length of cpu intensive
>> computation.
>> 
>> In bpf_cookie, perf_link and perf_branches, reduce sample_freq as
>> higher values may be rejected in some qemu setups
>> 
>> Signed-off-by: Mykola Lysenko <mykolal@fb.com>
>> Acked-by: Yonghong Song <yhs@fb.com>
>> ---
>> .../selftests/bpf/prog_tests/bpf_cookie.c       |  2 +-
>> .../testing/selftests/bpf/prog_tests/find_vma.c | 13 ++++++++++---
>> .../selftests/bpf/prog_tests/perf_branches.c    |  4 ++--
>> .../selftests/bpf/prog_tests/perf_link.c        |  2 +-
>> .../selftests/bpf/prog_tests/send_signal.c      | 17 ++++++++++-------
>> .../selftests/bpf/progs/test_send_signal_kern.c |  2 +-
>> 6 files changed, 25 insertions(+), 15 deletions(-)
>> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>> index cd10df6cd0fc..0612e79a9281 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_cookie.c
>> @@ -199,7 +199,7 @@ static void pe_subtest(struct test_bpf_cookie *skel)
>>        attr.type = PERF_TYPE_SOFTWARE;
>>        attr.config = PERF_COUNT_SW_CPU_CLOCK;
>>        attr.freq = 1;
>> -       attr.sample_freq = 4000;
>> +       attr.sample_freq = 1000;
>>        pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
>>        if (!ASSERT_GE(pfd, 0, "perf_fd"))
>>                goto cleanup;
>> diff --git a/tools/testing/selftests/bpf/prog_tests/find_vma.c b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>> index b74b3c0c555a..7cf4feb6464c 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/find_vma.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/find_vma.c
>> @@ -30,12 +30,20 @@ static int open_pe(void)
>>        attr.type = PERF_TYPE_HARDWARE;
>>        attr.config = PERF_COUNT_HW_CPU_CYCLES;
>>        attr.freq = 1;
>> -       attr.sample_freq = 4000;
>> +       attr.sample_freq = 1000;
> 
> I think It's actually better to modify sysctl.
> perf_event_max_sample_rate through test_progs, I had a patch do that
> before, but Andrii didn't apply it. (I've forgotten why) , but this is
> a recurring issue when running in VM in parallel mode.

I thought about this. But why to do it if sample_freq = 1000 is enough for our tests to function?

> 
>>        pfd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
>> 
>>        return pfd >= 0 ? pfd : -errno;
>> }

