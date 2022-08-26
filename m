Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8325A2DFF
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbiHZSJb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344829AbiHZSJ3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:09:29 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE82192BB;
        Fri, 26 Aug 2022 11:09:27 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QHgGoJ018852;
        Fri, 26 Aug 2022 11:09:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=Gu3nGV7C5fY7JBqQudLva1ChSel/hRFlcTDpC7VGJR0=;
 b=kPitFJaigLUTiWTNs78m3MZTg7LO/OczKyBI+td/Difl+o7yg8eMXgmBNWjwrmQKquOp
 7PJ4ODV3Sk7S+UJxPgi6amn/6D47ypnrgb+BThxbEkj+ZJeNsOdS+bQIe+dd4wSaQhnt
 ZR+CNTwR5QQLaRkj9AQkH0QiUUHAzrOko58= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6rwdbvwq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 11:09:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+zWRDvNk/AWcu7MVjTuKArzmBMe8VgqJgbxfcfLx5POwUmabdlDmL/YQ3bJBe/hR7J/pZ3zOG/zc3JmYEvLdbn8ncqBVINsDeHFenuy95NZ4BAItWO4AJ0p5DDSTC7PU/LHQ8/VP2Sp+LvleCT13xCdOIB33WSO8qBDJDyvaO0fCQBJnZNo/hS0Kc3TuyxeHLo8za3meyOT0e3VyRvvMtUoVWVgRDL3gaVM2nXBNbas2kSGYikEaT8UKtuQpd5gURIo73abSIDKA1P3kewX6bys86OrIZe5XZEzrdxhOGXZGT9bkVr+TVnUa2U3SSOkGCpV/Gz28+msNsqC1zb+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gu3nGV7C5fY7JBqQudLva1ChSel/hRFlcTDpC7VGJR0=;
 b=f9vSVtb1VCndn3x3cNSCEGfBFjj4OnS3ymkoPJoceVvUYD+63Wus8SPSoftVpRRnFJ2KtXxIbkjFmJ7Ew1rR4r5T48ZeUeUTLPwvUkE1F9ZrOgZtIgJkvjSnfqgNeWeApiVX8T5jJ3tVA5EiWlXXFx8PkPu3vZ0avzbAOLIuMFnLX6zsMZxaMyVFtZ4hRklit41Enk0ZVpWxQ3N2xfF2soeV6Aop/ohcO642M8XsXrBmD2GPodm86AEDiXrxLbtx6ecv09IV1kwWDuG5W0Z1+bNz784I1iM7j+icfL+/+3ZR6gmEY7r8pNKjBkZg5zJ0UZ2nQljDCp4Eih0EymM2UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN2PR15MB3376.namprd15.prod.outlook.com (2603:10b6:208:3d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 18:09:23 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 18:09:23 +0000
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
Thread-Index: AQHYtzPeWFYcAGzsN0Wstq4jJDfNwK3AJloAgAAJpYCAAA9aAIAAO0MAgAAulQCAAAilAIAAsuMAgAAazgA=
Date:   Fri, 26 Aug 2022 18:09:23 +0000
Message-ID: <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com>
References: <20220823210354.1407473-1-namhyung@kernel.org>
 <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com>
 <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com>
 <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
 <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
 <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7fb0380-d0ed-47f5-14fa-08da878e1aca
x-ms-traffictypediagnostic: MN2PR15MB3376:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C1B29zViZFfvQT9SfYbQl7F0lztjJ4pIqJZrdmUOuIV6Z0JTV8aOd2TaYfjURAjmL9znUbvJf0c8WKq8snSyW4nJ/13WrTsGNsw/BoFxRM0eqkeK4JmMZHP5XaKVe9BYU6r62E7CK8zPMnQaqpUQIS/fWtKsvGWpKW0IPvu3ycdUARJUcOQ9lvY3MbOV2Nt37Ns9Pb60V1ZD7Gw8HuKwFWopQw83X1gOMRk13asiIEIqP8XOSvT+HMNJAIWwDHX4q8NPiG0Y+9M0zPLk/LNyKxbszS09e3/GJqMAXttXEEwn0avb2jCE8IDbW+a6MdtIuwtnPOMC7VdbbacylW47KAdd9oH7zq5s0PHjqmUKmT6fLYtdSr3ArgsEdmgSlob/aaqZCj2vCK8MoAGR7Mg59z7w7inyI2DJj9QEZEpEZTMWeIj7qYmLGzx2ctjvYY4tj2jH+2weyE3zoMNKZAMFK1Vkyu/Prp/mGzOiXItzW4/BRWVcRa+PAM1v7B0N8thQ4rQD0lYxB43S1fEoTxzHBzRB/qIQoHWfdVflTV1HVs4D4v8cWaet61EaTFe1Y5hQIOHme7IyaBLJkb8AtNKeQeVACBiHAFiSlY+kFyqpkJTTMFuB6UhnW4q0dcO0U4u8rHGMaZOs46WM/A3jJxRzbbBYipaFjr0Ujj86zUbW6GjL2htuS0JboeiAG4wv9+EArKRycJhUtTt0OSDXWBmIFB5gYUzpvIQvfdUPbadt8EZuhOt6By2s0jA8T2jo/jrp11fMU4Hp3LiiD36QSXVIR2xpU7NG8TrP0ikRhQuYpcw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(6486002)(71200400001)(478600001)(54906003)(122000001)(6506007)(76116006)(8676002)(64756008)(66946007)(66446008)(66556008)(91956017)(66476007)(4326008)(8936002)(41300700001)(316002)(7416002)(5660300002)(6916009)(36756003)(83380400001)(6512007)(33656002)(53546011)(2906002)(2616005)(186003)(38100700002)(38070700005)(86362001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?X4PBqRbLImipUzGKWcx16fmlBpQvnvX8aeluENOdkdth2YS5Np/KOHLq4ljh?=
 =?us-ascii?Q?BMZhR+CYPuWxVnax6MlhCRVXtJx3OdrrQ3qVcu/EMDZIBaonf8l2RXJKIgTg?=
 =?us-ascii?Q?kISZqWrLStkQqrNs4eiymOZSXj5NCNkPPH59ybsT+kl8QEClRwWuOiet7FgK?=
 =?us-ascii?Q?4cLgLMAwIJ+TtvlBLQ4pu4Bzc6Rtcz0oSV69poDtI/wDieNhh1Nc2/UuW/xJ?=
 =?us-ascii?Q?/RPxXSvIiiLLgzxfc+Gk2iX3fxq4BwBZ9fNi00tVzceLybkOYTTaHMYwiLKV?=
 =?us-ascii?Q?PRFH3F2CNBvsDF0vWBDnZvr+PSbbh34Hd9eu6uJxax6nqvTfF3qyjacQQpXB?=
 =?us-ascii?Q?n/i00S2TMo6bnFmZxY8/MkP8W78ZFbpLWbXNFObISK39jmP+2v26852dGItI?=
 =?us-ascii?Q?yUV8uGFemG1YEwVbz7E26FGAUy+t1EBVVSsHUgIY/ldK6864Va46ox8W6MdE?=
 =?us-ascii?Q?OwFqYawtybdLn/Ge2hUd/weMRi3OHrl1aJgPVa3JL85mClqamzy1BS2zMvTz?=
 =?us-ascii?Q?24eKMhkDBE0xlOxHXEXrXZGsdfDhxu0zamaRtQyczlT8ewp75RhcCsedvTft?=
 =?us-ascii?Q?sZdLCa6tA/xQ+OlBfE8NWyD5TvIACVEqCC4kkOFWgD85weFC1LMO3MPpmbg8?=
 =?us-ascii?Q?e6APgdrwGtOTwV1hVi8JAg0J+noTC+6PkNCYp98hqVc31lbnig4RQYgSBwwY?=
 =?us-ascii?Q?zdvGjgdqP+WyWTDui2ZFb3R+0Y/hZs7OIjw1OsNuCW4RSBcuKWfIj+97N6qe?=
 =?us-ascii?Q?bibLbyh3nnJQeluzQwf9bOLm4nMgXRyod+xa6d/deKvJpGPMeh0sI+FOwabz?=
 =?us-ascii?Q?Nyj3L4eGlwwJNpR/xz2f7RXQKJBvpBVSzHWcugdXJl8dB8wO+BhmT188wsxP?=
 =?us-ascii?Q?6YZ6KPPIX7FClv/CXuyo+K+Z/iRfszNWSfR6tDuNVyUT3YknMAbpxMLOfO7y?=
 =?us-ascii?Q?vQUNLgByuH6LaILVb65FjAGuBxnYxq4BZSK5TYlMa90T/CT9Py2hXp/Jhl1s?=
 =?us-ascii?Q?c+KTnqhlJchnBZO0XbqgbjRUxckwIdyiY0MRmH8CHoj5qfUuJOU3FpMxB85o?=
 =?us-ascii?Q?nEHQaQP2QJkLNlqmzC8eXZEPyYkZtwH7ZbtJfkpUNpeqvwIkOMILbi/dxYzx?=
 =?us-ascii?Q?+iwMF6vY6AZoBpRKWonKMNesZ8tYc+1pJV5G9cbVzlp+EAX4HwSTmvleApHt?=
 =?us-ascii?Q?137gJl41ffJqcQXZWca5yos0xb4n67WMys2LMKeoWCoclqCJjVU/q7P5Iirz?=
 =?us-ascii?Q?tWCGiV8wEX/muMTOMc6Aqui7ceqQxnPqZBYYkoPXZwmPAh2+WBlCwc7Wvyys?=
 =?us-ascii?Q?tppKx5Jpv/0yLyrI79dJLNbJjOvrRc68AhnR1NN5Jk6NpyuBawDv5XqsOAly?=
 =?us-ascii?Q?Tb2y8ZW4Ssmvx3gRtw64lSTBtWJS1zwGM+Cgy8DcBeWTN4SLg0ujB0Fazpjw?=
 =?us-ascii?Q?zq/ycUyoD9MmDKQbl+Ddej9h+QXrV5wJT+euv1N/kFAPqi5K5MG2mhwzMnCX?=
 =?us-ascii?Q?4FoNdXAogOfXZaVqVqVBWYcdVAA7o24xKL9NtyNwNoQD/2dh0HtzpjuZbfX5?=
 =?us-ascii?Q?apCYfl7pqXEwwFSTl2xghseQvlfckGxHNBDuzuSV5tK+bwW2dZXSLsGArrx3?=
 =?us-ascii?Q?VWG+KhlJg4cEy7XfKFk4XPw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <324940FCDECC194AAD25889888829074@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7fb0380-d0ed-47f5-14fa-08da878e1aca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 18:09:23.0434
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5/i27Cbi4R4ItTNJGAHG064oqgfURzuK1ASRGbiJRjb2iEHL0s6UG7MxP/tSSBmA3AQ3gG+XvXoUUAatp5i8yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB3376
X-Proofpoint-GUID: Jlk20QM8mWV7LBNDfz4i90Vzos09WrCF
X-Proofpoint-ORIG-GUID: Jlk20QM8mWV7LBNDfz4i90Vzos09WrCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 26, 2022, at 9:33 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> On Thu, Aug 25, 2022 at 10:53 PM Song Liu <song@kernel.org> wrote:
>> 
>> On Thu, Aug 25, 2022 at 10:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>> 
>>> On Thu, Aug 25, 2022 at 7:35 PM Song Liu <songliubraving@fb.com> wrote:
>>>> Actually, since we are on this, can we make it more generic, and handle
>>>> all possible PERF_SAMPLE_* (in enum perf_event_sample_format)? Something
>>>> like:
>>>> 
>>>> long bpf_perf_event_read_sample(void *ctx, void *buf, u64 size, u64 flags);
>>>> 
>>>> WDYT Namhyung?
>>> 
>>> Do you mean reading the whole sample data at once?
>>> Then it needs to parse the sample data format properly
>>> which is non trivial due to a number of variable length
>>> fields like callchains and branch stack, etc.
>>> 
>>> Also I'm afraid I might need event configuration info
>>> other than sample data like attr.type, attr.config,
>>> attr.sample_type and so on.
>>> 
>>> Hmm.. maybe we can add it to the ctx directly like ctx.attr_type?
>> 
>> The user should have access to the perf_event_attr used to
>> create the event. This is also available in ctx->event->attr.
> 
> Do you mean from BPF?  I'd like to have a generic BPF program
> that can handle various filtering according to the command line
> arguments.  I'm not sure but it might do something differently
> for each event based on the attr settings.

Yeah, we can access perf_event_attr from BPF program. Note that
the ctx for perf_event bpf program is struct bpf_perf_event_data_kern:

SEC("perf_event")
int perf_e(struct bpf_perf_event_data_kern *ctx)
{	
	...
}

struct bpf_perf_event_data_kern {
        bpf_user_pt_regs_t *regs;
        struct perf_sample_data *data;
        struct perf_event *event;
};

Alternatively, we can also have bpf user space configure the BPF 
program via a few knobs. 

And actually, we can just read ctx->data and get the raw record, 
right..?

Thanks,
Song
