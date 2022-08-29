Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E575A43A6
	for <lists+bpf@lfdr.de>; Mon, 29 Aug 2022 09:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiH2HVD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Aug 2022 03:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2HVC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Aug 2022 03:21:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42F12AE3B;
        Mon, 29 Aug 2022 00:20:59 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27SLLEkV004415;
        Mon, 29 Aug 2022 00:20:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=iq0my71+Lmc6ocLkTO4TD3mVzuenBYVNlSDlBufnsf4=;
 b=TRTr0iKW3OA12/3Hn7NR0fxZsQ1d1vyb1u1w//ha7OZnP/P59gTYzWKQ8w1LHuNRpHH9
 /CWKN5XYrj3tCEBNf25w1SS9a5czF/CcWp9ghI5/04/3ac3xYcq/NAlBj1B1YDf6lrsC
 wdVPmr3JZRvr2n7AhohHup1UZxLMXmfvzJ0= 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2040.outbound.protection.outlook.com [104.47.51.40])
        by m0089730.ppops.net (PPS) with ESMTPS id 3j7es8fnjk-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Aug 2022 00:20:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqFU5HWMcF5xEyZ79yZky08cIM8OsHHpAK085x4Xe13NmHlkw9kVCgKNrBSrjS4xYtcRBS0DHfv+XYlA/mteo7MMNFVW23xvqUDHJT4FEz+aRbKpD+wfxbsluuKcwvtfh7j7M7gJ68BlldZYuliYmQ4sDj0S1ZsXIXDdvoZ559Nf5jdH/pOQMLVegqhqXx1+osWV+Xxbzo5OEuUngNJG6PsB09twTNBJN7R0R5nIML20MHUG+BlD4ovXjkGJf3N8ijb2syoxW5XSgHisz4ANFiWbiyJaHucDnGH/jVU6geUeOAeC/ktZZ/qQroc8wzGLctbWGF+dASukiBiZCVKFwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iq0my71+Lmc6ocLkTO4TD3mVzuenBYVNlSDlBufnsf4=;
 b=fsdNNehby1xPLCF5z7JwNDRS/2UuTiJgJnQBy2vsqKwoCTNItq88yicg9D7ROr8iTyJaEfMxVtSM5vOlXkJB37n+KltDoPBker/RuqV+9kT38PrLkFX87mHyrtDpMtrKk6RBAYy02jL1BnQ3IWfcme+bqX0a4T8CBf6BGHTs/TDOZ/66+gvKiDInRPBi8ug90ZDS2miMf41Xcw1slqoBM3eKF4f1mMtAtjZUXlOpEImFizeULvA2giGc9Sh7yY7m2G8zO7G/QrfE7Fy3dPLd2K4RUVx47PyHX7rUY53SbsK3E7bQ8W9RKEj//P87o5tWDsqoL5rR02RN4UFNwVV/og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SN7PR15MB4222.namprd15.prod.outlook.com (2603:10b6:806:101::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Mon, 29 Aug
 2022 07:20:56 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 07:20:56 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     Song Liu <song@kernel.org>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
Thread-Topic: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
Thread-Index: AQHYtzPeWFYcAGzsN0Wstq4jJDfNwK3AJloAgAAJpYCAAA9aAIAAO0MAgAAulQCAAAilAIAAsuMAgAAazgCAAAnxgIAADKuAgAAYuoCAAAP0AIAAA5MAgACW0gCAAzQjgA==
Date:   Mon, 29 Aug 2022 07:20:56 +0000
Message-ID: <4E6CFFD5-7048-4F64-8F16-70DD6D081ACF@fb.com>
References: <20220823210354.1407473-1-namhyung@kernel.org>
 <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com>
 <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com>
 <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
 <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
 <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com>
 <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com>
 <FCC75F8E-4C2F-42A4-B582-9BE3BB87E15A@fb.com>
 <CAM9d7cj6YNTL+u38PZjhPF2Qg_BYiJ1NMmDkPDx3N3Xe+ZTbyA@mail.gmail.com>
 <FD49F694-10FA-4346-8303-E1E185C3E6E4@fb.com>
 <CAM9d7cjj0X90=NsvdwaLMGCDVkMJBLAGF_q-+Eqj6b44OAnzoQ@mail.gmail.com>
 <1CA3FC40-BC8D-4836-B3E7-0EB196DE6E66@fb.com>
 <CAM9d7cg-X6iobbmx3HzCz4H2c20peBVGPt3yf9m3WbqLb5H90A@mail.gmail.com>
In-Reply-To: <CAM9d7cg-X6iobbmx3HzCz4H2c20peBVGPt3yf9m3WbqLb5H90A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 385458e5-7095-49aa-5e67-08da898f03ec
x-ms-traffictypediagnostic: SN7PR15MB4222:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CvgLxOTPSwIsK9K790g5+2EAzXop+l9D30IW3sz1f2k67avOLDxYzTx6Z5eYN5TCaag27NPLZQflA5M9rnDpdjXP7hH08QkTjgxWzue7ft57AKEJbfNVFF5piXA8JrxcV9+TgMG+C9bckuKYH7hYNRzOqL4hVQ48IKph4ak17xfhiQNSCMTwHbLvl2b1NkTBo5Oo44SXE3JO3/q4iXgf/g/zsMniSLwBjfTBGwGciaiDnXvuTm1cHaifasMITWc0tLm4njggtpgxRKUB43+QSiqITxYO4bpGjez+J/1EbTT+l3F+1kz4avxmnca5HeSH4G0fJmijEhJTTw9t+h4nKbMtnUNfVdmZ1GB8xqXizzTgw6x7Pr0Io/GBc00Adm3t+wdkVjyhaD6T1XkcAKEErkzT0jHKoPBhI9pTjmqQy3mfGKWjRZLt8NXz39tQqWmB6noVyf4q7ES8G6IzMz2hWdJuSa6+Vnn0ZAypUuKICSPlj++pVJHaDJkIjsBZVvexmQAeaj2fBHRtppb9LWzxbCbaRmOtgo+q/6NgqNn0+wYC7/QpoPHLbVkdYZ+A/96vdGk9KW5HAZSpGUe8u5+7iQ/TDXt2w46Dcj8SPzn13GHywPCe/6I3it5P2hkD6Cq23xdOR8DdbJ+oM1OjHga4sBemUIdHuAyVCkeYKjSEjxyro+0iJoLYtGOrsixBvh3mDp7AmqCNACBwwx5w7oig5ZjxkT+Kim/FOK0A92U++pOtWRLBgMaqzqwNGRa3HJxHqmhFl+ccl7rAT6bheyJeYs2NBDYQ2gP78CaJzk8ApryjA5moAK5QzFEcXtNFmMo3S74+PN6oOxWks8YkveGnEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39860400002)(376002)(396003)(366004)(6506007)(122000001)(38100700002)(2906002)(53546011)(2616005)(83380400001)(33656002)(6512007)(186003)(54906003)(6486002)(86362001)(8676002)(4326008)(64756008)(66476007)(91956017)(66556008)(76116006)(66446008)(66946007)(71200400001)(316002)(966005)(6916009)(38070700005)(36756003)(7416002)(41300700001)(8936002)(478600001)(5660300002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UTyTdyWQ7rkVZnYxR28ajgCf6U4k880J8kNcmWYZ8x+aF2nXzgprfj5u5KBS?=
 =?us-ascii?Q?y4F/W6ILzqXvPORrmYRbaoa7VxmoFqshhZfUMdj/ZLJhBZDB98oqWge9ftMw?=
 =?us-ascii?Q?TZswA7s5+8RKCIIecM/SIAMTiK1hvmHKa1rp9ucYMHBlHQkOkCpLtNXPkYmD?=
 =?us-ascii?Q?NCamJIx0DWIaQ/H/AAnpeOyI0AaQKUYPenjNkgcJDew0ejP5sd32S30bMsXi?=
 =?us-ascii?Q?nEehSrRWoJJqee9ymJFDvZswduvyrNz/r2MupEZpvpZg9mwPdT7BzHXJU+Dc?=
 =?us-ascii?Q?imc9WHiYaSbOIajWZcIILFa9w9YFtq8GpIMGt1Av6UIren7FYymd4kqiUWFC?=
 =?us-ascii?Q?tKlbNUM3qxJtuKqcDAYxz7TUABrGGWltD4l0eWwuimysj+JneLkUIb/P0oo6?=
 =?us-ascii?Q?/SrVvutLCeekX8WLOCGXa8Aa3fOh8FXDHsGRP+ioP3ZKb106dFL0yxF3lyPI?=
 =?us-ascii?Q?xt7EQodE/BxIbQBtSV1RGpXVThStS+M9NfkliyiJpRkujSV4aDD67/mZzIrs?=
 =?us-ascii?Q?qGTQUZ7htFhIOPWaJpSXj3iqe5fJ2rb4E5UcKgO5bZPLUXD4OQBnLP+vm86v?=
 =?us-ascii?Q?tILeD0FQHIN4K6/Kb501HMh5YzsNI8i8HVTz0huy8JGJu7VdVp8EF3uVV1qZ?=
 =?us-ascii?Q?ghXYCSKEP1ddzO8WHhywqs8KRWatbwEhxZ+OwkXYnO+aeUIzrxisZD2tVh5Z?=
 =?us-ascii?Q?PFOFiAy40W7rhT0SdYcswIr3aWLOv4hgm2JowTPuCzw0QhOFmCKd+rG+xWhd?=
 =?us-ascii?Q?nPV7D0Nls8dLf+WdSPbdbz6Cqhj4uhAqpRVF5Cl86Iz8S/vfX+yN2+tgePO+?=
 =?us-ascii?Q?nw13fRGid5eG3ODqzYNuImvaq6zhvkC3Uane/l1p+qJ1L9rLFFJ58KNkg8BU?=
 =?us-ascii?Q?QKNKhc0bjRzu70LNa4un2jdS/JGuica5J4RTRMN+FOAdubTesc4z2BkO/Rok?=
 =?us-ascii?Q?BYpiZ/ycyKXbNvkKB7Pj6sEnjXwbXDEePxrozAMA5RCVVIkkeAtllvHruw8G?=
 =?us-ascii?Q?wFEX9XG+H5uRjWoasUiziWqLf+dxYwdm0xK8wIASxspP84z21N+RMHZ9RaZ6?=
 =?us-ascii?Q?yFEutCQk5nuadwcIj+38TGkju6Ul5XFBzhgbMnFzZqzVu8ycLP1n/xRHDtaR?=
 =?us-ascii?Q?UEQI1cn3jSs3MHfmxDdgyk2VD1y9NAKYKEKi5ayF2kYzpY0qn21QzDuH3c13?=
 =?us-ascii?Q?OS1Wx8qEkDUH2GFkLCRviD1u13mIroCtUP8elaBV+aJKcJbLgE5ZUGKzr7LU?=
 =?us-ascii?Q?oz7IubITX9sw9RgYG1sZwUDu2jBcrHJxknBpAMBx9A27RKK1ssVcMtknmUVR?=
 =?us-ascii?Q?jbZDEpfJXfesK4ElG3v1ZeWLOItj4aKhaXDq9nMl1BqihT9uzxtCKZs7XoB/?=
 =?us-ascii?Q?+mVx75zNBR+TIHnHAgUn/iddUvpR2ZtqBirbdBTh5R0Eyc0fH70oMsIbPLVU?=
 =?us-ascii?Q?OQ/dBdPqoTYZGCj8P+M8CQCdtw5jrzaHj8O1XXgoRA3E0W0TdOGzwmQZZ6to?=
 =?us-ascii?Q?WK3UZ4HN0D96HACKCIqSjkeUqRvfBLPtMvQBwjxMQphrj2jWPlj+zhGhb7LH?=
 =?us-ascii?Q?fSY0vDfbJvYXvw1eOUwfn1gyETg3SUV1tjr1muzPJkPJ7vqeVt6Y9zFP3/IT?=
 =?us-ascii?Q?54ESfQKmJ9S8LVubLXN7K6s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3C5A29DB973AD6448557D80D80697B58@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385458e5-7095-49aa-5e67-08da898f03ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 07:20:56.4872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ig+fSAH/ner5o0/wliYVb0JR6eVq6ljd/klexdzYam0Vl0rq5Y137kk1Y2dc+VmnWiVwjK/Ki4GP2XUS91zq6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4222
X-Proofpoint-ORIG-GUID: KJvgAUWRgP7HWkbFWT7_cNkaxfPnFwaf
X-Proofpoint-GUID: KJvgAUWRgP7HWkbFWT7_cNkaxfPnFwaf
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-29_03,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 26, 2022, at 11:25 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> On Fri, Aug 26, 2022 at 2:26 PM Song Liu <songliubraving@fb.com> wrote:
>> 
>> 
>> 
>>> On Aug 26, 2022, at 2:12 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>>> 
>>> On Fri, Aug 26, 2022 at 1:59 PM Song Liu <songliubraving@fb.com> wrote:
>>>> 
>>>> 
>>>> 
>>>>> On Aug 26, 2022, at 12:30 PM, Namhyung Kim <namhyung@kernel.org> wrote:
>>>>> 
>>>>> On Fri, Aug 26, 2022 at 11:45 AM Song Liu <songliubraving@fb.com> wrote:
>>>>> 
>>>>>>> And actually, we can just read ctx->data and get the raw record,
>>>>>>> right..?
>>>>>> 
>>>>>> Played with this for a little bit. ctx->data appears to be not
>>>>>> reliable sometimes. I guess (not 100% sure) this is because we
>>>>>> call bpf program before event->orig_overflow_handler. We can
>>>>>> probably add a flag to specify we want to call orig_overflow_handler
>>>>>> first.
>>>>> 
>>>>> I'm not sure.  The sample_data should be provided by the caller
>>>>> of perf_event_overflow.  So I guess the bpf program should see
>>>>> a valid ctx->data.
>>>> 
>>>> Let's dig into this. Maybe we need some small changes in
>>>> pe_prog_convert_ctx_access.
>>> 
>>> Sure, can you explain the problem in detail and share your program?
>> 
>> I push the code to
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/song/linux.git/log/?h=test-perf-event
>> 
>> The code is in tools/bpf/perf-test/.
>> 
>> The problem is we cannot get reliable print of data->cpu_entry in
>> /sys/kernel/tracing/trace.
> 
> Ah, right.  I've realized that the sample data is passed before full
> initialized.  Please see perf_sample_data_init().  The other members
> are initialized right before written to the ring buffer in the
> orig_overflow_handler (__perf_event_output).
> 
> That explains why pe_prog_convert_ctx_access() handles
> data and period specially.  We need to handle it first.

Thanks for confirming this. I guess we will need a helper (or kfunc) 
for the raw data. 

Shall we make it more generic that we can get other PERF_SAMPLE_*? 

Thanks,
Song



