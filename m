Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE896308A0
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 02:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231381AbiKSBpc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 20:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbiKSBpF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 20:45:05 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B970C75BC
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 17:06:15 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2AIND3Yn002489
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 17:06:14 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=gDpeFiTMQx2jJj9XTGXprOuBt4cXcXvjN37MwvwSnbs=;
 b=HrAp79W6ylqh2NLuk5IS9zUbFAxzgEVWSJWNwmqb2BYrlzSYQUMCJHqK22nNmCF6N85E
 a0xZ2WcGhZOVWa+bCElPWw+dgf/1YStwiMK7TunXaLNCXYegW4S6x7Kit/ZCiiHgMQ2o
 fGqXLMJZYg8jTpf6YATY0H3wS4D39aPoUnHGyJSNRcnRSNVj4IDUhkZiX/Q95Rc6xGq9
 sTGD/Bl5P9JKfggrLZHC+m3fQklDaZn+TFONZHHCuNeTiaFGNSozmwAXV8h6tWtJ1cV1
 TcGeFH7OyTfnVtN1eWxjJrVuqcvU4BnGISZmuIJCOFoyNZODcGIDQBR9fMgY+7fBTGQe fA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kx1abqw8x-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 17:06:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6TjXpDHnMZgs4UTmGaRdOtC6jt5+QewqYIxkJbZxL3KfEL6i1v9FBjLSGRCRMeEEUQYLUUdymFd/ErjPddjax1NGSEIJQJeF9+bPAirV80b5yuhCP4+jLQDTC1AvtE9Y75jmd3TM3W9eVRXK0JpFKcuIs+zoHvhoUWvBv1vFeiSWz2dbQ0rztoW1ucRRcABR6ZM+aoyL81UIi2S4GbGVaJ9K6reveRTBFIsN8M0Zn+8DL5C3NTN1OsLYBtD59uxWZqh+rv6LjnOWS28XKpMvVQKaqyyk6qLeJ8xXIMM+blKO5/loqF08ud0rMyd6Q7GF/mqFRk03p2WZaPbHyLTNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDpeFiTMQx2jJj9XTGXprOuBt4cXcXvjN37MwvwSnbs=;
 b=GvkDmRaJtf8fZV1qiY8KFUYfNZfFbdd7ieQdISeu8CGi5nT+PqHRxhyE4H/U+aS7eAyiyFtmArBzNueOpjSGEgi9isNv6zV3rYE0yRMehmEBKBq8bl2uwSdS6KP/sDXRjFr8YKqE6lxCzIX4eeqB+J7EEgec2aWi8PvkNJ9zOZ58AiwXcbzSbtiBdTwyk1tn41bvbgort+W+vMOCnHZsJH3XgeP7CIv76bIGLH7KnoF52Bo/MIoqle5XZB6oCesDZ8a8R5feoQsmpC6dVKZHg3AxmjZ2t+yhg+aIyvWyMEakJ3hzV5Smdaspv4PG4wqcWvAob9bAXsKKbgczHQTDLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MN2PR15MB2878.namprd15.prod.outlook.com (2603:10b6:208:e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 19 Nov
 2022 01:06:10 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3c4d:ca9e:8db4:f7b0]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3c4d:ca9e:8db4:f7b0%3]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 01:06:10 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin Lau <kafai@meta.com>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function
 and kfunc
Thread-Topic: [PATCHv3 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function
 and kfunc
Thread-Index: AQHY+2Qj3ZAAgzp5qEStRAYmgwCJVq5FWMIAgAAWrYA=
Date:   Sat, 19 Nov 2022 01:06:09 +0000
Message-ID: <E30FFAE3-2BC8-45F5-9CBC-D7A3C7D66B74@fb.com>
References: <20221118154028.251399-1-jolsa@kernel.org>
 <20221118154028.251399-2-jolsa@kernel.org>
 <CAADnVQLLvwpAFTEwCw+ZdZGtZTrV7nFu3pXKMRW9irRYG9WJXw@mail.gmail.com>
In-Reply-To: <CAADnVQLLvwpAFTEwCw+ZdZGtZTrV7nFu3pXKMRW9irRYG9WJXw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MN2PR15MB2878:EE_
x-ms-office365-filtering-correlation-id: 02faeed1-34fa-4eff-10bf-08dac9ca3ed1
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0gJ55vOqAPbYyAFgpbKiSH+fb5/92R/x4ZLBvO6x15m2ELGKIy8QMHdDwbNY9y6ol+UoIcJANW0wSQrE0n+gHrV9HSMiKkzBqUEOxL4W/ATkXC7/YXJ7ocmAUAQAhIHyYuK900OYvDyI8elCOQS9nYDan92ndZODYDCa6Gq8bzLoPXk68dO7Ciz7TRf7tXjhp8Bice74fhbUucnRT5nw8Kpav6usu4haNwOuhU4nPPUGc944Rdo1vnwl3X+gDfqVpR1f2HZuJFY4ourjWWRTtUKMlVV/i0Wjoc4hJqv6qPa7XIe/cwz0FHa/QuEb9epuW8J3J8pf9k9wrMlKVSd3A1/qH4usJ7IGChd+8ANTnaoQLfUdB5PvYY6sHBLQzCX5TjgNwbPsUNMlBjZWsLorzlpgdF7M30KOU5MEUUjFVrHZ8Ltn84fCacWC7I+kF3Dc8q0gV2IidRlNz6ZMDGcXFvrMhauqg/4Wpr0rj13bHqQ0sHMOcD2RTr0bAZOKtROL2HeHG4wb89tYlz49em+0dJKoSmoim5I7EEvAuwX7zaQe9HZEa2bflLunKdujvcBWD9AUXIcHqpJnDI2Ixgbk0EIsBbZb+LPENTuM3gH9acJVYeKRxJCCpFRZaBU+LdBjMxTh8zBIIEBuXwXzTKY75FhbKYD8hYmotIrFHS2+UiNN3X1OaG7zu3oYj9pWe7myk0fJxr0daTEYsva5jXTrHA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(396003)(346002)(39860400002)(451199015)(6506007)(53546011)(71200400001)(38100700002)(478600001)(122000001)(83380400001)(38070700005)(6916009)(186003)(2906002)(64756008)(36756003)(8676002)(9686003)(6512007)(66556008)(66946007)(66446008)(4326008)(66476007)(33656002)(91956017)(6486002)(86362001)(76116006)(316002)(8936002)(54906003)(7416002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gVBSUq1YH0IlZWz6w8d2Ypi0OujBdR55k7TvGmm2NkZpB2IQaJdC/i+x4N4l?=
 =?us-ascii?Q?uDs09MOWaRoFFBJGSFsLCV0jEyjhi839/dVTy9qRmTN4o4aRTBUTdFeIKBi2?=
 =?us-ascii?Q?qpiWNCbnUHKmqcht8de6vEnOW0fbL4gHqfSdmneGPIQMUWXPB6sFbV4QaiUL?=
 =?us-ascii?Q?aH7paUyCmg4pMJpx55kqaEN8bHeK0TkL2hS8O1Mkkb+/gv4aCbJ8Jkt3uV3x?=
 =?us-ascii?Q?DBWNYw2oqKpkQynKPQ2Ft1+BzNqV+LlWqs23uwN5AAYJhK/ir8/ttuOergAc?=
 =?us-ascii?Q?08l5Ggy8M4q/KHTqqbT1rmVXjGkwCBQyb7g0bZ/YtSTkqoKPcqaDqc/1/9jZ?=
 =?us-ascii?Q?6N/Aa+wmtUM+tmXn7WwFDANzYR6weqJu8xGEzAfXj0tor8RbwbJGqEN7Z0xs?=
 =?us-ascii?Q?kdalkUiS0RiAdr10N7KhJbQSUMGAM0T11Ecs+cd+7QFMaT4Lx4oRZQWA4Q+8?=
 =?us-ascii?Q?SHR1HJMOi4Rl4pweorbUxvxhMdTxMDToBLPvP+mEr51RC+F/VQP9svO/ubdv?=
 =?us-ascii?Q?vYOX7hb8vJ5E7wJ6l1FtNPUs9GGHm0nOOXbtMxTfR4o9fP2dw/mqll6unUid?=
 =?us-ascii?Q?hOpYciwlRNJd/4+6j6MDW9YUp1nx++jqQrKg62JNAWReEa01z/9S/aaBX6nZ?=
 =?us-ascii?Q?z2QTbqDhOyO0son4oqVWVxl+qLOu4OzkxnzIULNC5FFOF8uJBN79c7ZnYjDi?=
 =?us-ascii?Q?cZ4Mmz8vCNcltRNCnCHGoRMK6ZlhLiRLhT6Q+BvH0RAleXqZRB9luqDCtWQQ?=
 =?us-ascii?Q?zHFbwwsBMIthO8SqRaTuAFNslBser87u3oso0y4LLDw0wG+fh3D/z6UajIye?=
 =?us-ascii?Q?NK0zUovjkoby9aZb8vdLj85PO45rXnJPNfvIODjJBfjbsLWZvnjEZHlMgMf9?=
 =?us-ascii?Q?QTXk7w167UQ5P8g8cMpovRvys8LVX0C9Y5b0WACggpnQbvWevutAa8blCqCD?=
 =?us-ascii?Q?gOfcFdab5rH4Pz15yzNPR5hSGTRSDtVt3VCUC4c3nRQZ9QFShIfgCgcslu+g?=
 =?us-ascii?Q?1Q0r7dux9wxSPj8Tf486XgvUiHmiUJ17CeB8A+3HgpANARE/lIkAafTlvafS?=
 =?us-ascii?Q?Eq1Uua6f2pe0Ak9S0AV68TZOro1QyF5Ln8fXV33wm4JDa5iqBYg1JaFLHoIs?=
 =?us-ascii?Q?JiAck92pKuYhlDI0GNWYjdz9gf+NoQtbL+zxGwdZ2xkLnECX0On8b2IxtDP4?=
 =?us-ascii?Q?NqPstAmzRQZcb7ZpOgWyObFckS4aab3E/gAQFx5Z8612fzFDWxsO6Ua/NVWr?=
 =?us-ascii?Q?DhT3RYaI5N4IjgzD+TpIx+xnudcqTVqWqMGpksMSiIAdu3Ywcn1XamvjU3+U?=
 =?us-ascii?Q?gLeP5fJqmGf3h02+81sQFOQ0zLC4fBA3Tb+ZxDp/BS57W/7kzLWDsyL4U/sI?=
 =?us-ascii?Q?Yy/U73HblW9jKh29qMbW6Mj28vhOFaYzj+1pdXUZSxI2sXhx3decv8PLE0gV?=
 =?us-ascii?Q?yfAlzW9eXdmgYaaKrBdMkIxsdbx19UWTj8bK4DfKMe6exksEhn45Zs1dyiHj?=
 =?us-ascii?Q?iWVy+Mo2IeLHmvBbJMswfEWmkrYBBx9Isc5kzSHXwWvCSbYhZzaynAPqHf09?=
 =?us-ascii?Q?Az079/BjOK6UTCtFvuuAwOdZBsaSM0fpOcf4QAcDQzBohrInFrAjSU7j5Hh7?=
 =?us-ascii?Q?zruH3eEh7UWyfRo6EVkJGYxwMatY6i4HWIFsPI/0LImh?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <83B0F9981A8E76459AFA7ADAB3BB641C@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02faeed1-34fa-4eff-10bf-08dac9ca3ed1
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 01:06:10.0655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ou3ZRpI10rbByF4by8T3x3vJtzxSxX0kM6uHaJ//sCeW0GdkVi1TbKJyytp41fLO5A9Iu6l2n8SVfDNldMwqXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2878
X-Proofpoint-GUID: 96o_-OReLaYTMBZN1KOwHV3HzP1g9HH8
X-Proofpoint-ORIG-GUID: 96o_-OReLaYTMBZN1KOwHV3HzP1g9HH8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_08,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 18, 2022, at 3:45 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> On Fri, Nov 18, 2022 at 7:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
>> 
>> Adding bpf_vma_build_id_parse function to retrieve build id from
>> passed vma object and making it available as bpf kfunc.
>> 
>> We can't use build_id_parse directly as kfunc, because we would
>> not have control over the build id buffer size provided by user.
>> 
>> Instead we are adding new bpf_vma_build_id_parse function with
>> 'build_id__sz' argument that instructs verifier to check for the
>> available space in build_id buffer.
>> 
>> This way  we check that there's  always available memory space
>> behind build_id pointer. We also check that the build_id__sz is
>> at least BUILD_ID_SIZE_MAX so we can place any buildid in.
>> 
>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>> ---
>> include/linux/bpf.h      |  4 ++++
>> kernel/bpf/verifier.c    | 26 ++++++++++++++++++++++++++
>> kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
>> 3 files changed, 61 insertions(+)
>> 
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 8b32376ce746..7648188faa2c 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2805,4 +2805,8 @@ static inline bool type_is_alloc(u32 type)
>>        return type & MEM_ALLOC;
>> }
>> 
>> +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
>> +                          unsigned char *build_id,
>> +                          size_t build_id__sz);
>> +
>> #endif /* _LINUX_BPF_H */
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 195d24316750..e20bad754a3a 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -8746,6 +8746,29 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>        return 0;
>> }
>> 
>> +BTF_ID_LIST_SINGLE(bpf_vma_build_id_parse_id, func, bpf_vma_build_id_parse)
>> +
>> +static int check_kfunc_caller(struct bpf_verifier_env *env, u32 func_id)
>> +{
>> +       struct bpf_func_state *cur;
>> +       struct bpf_insn *insn;
>> +
>> +       /* Allow bpf_vma_build_id_parse only from bpf_find_vma callback */
>> +       if (func_id == bpf_vma_build_id_parse_id[0]) {
>> +               cur = env->cur_state->frame[env->cur_state->curframe];
>> +               if (cur->callsite != BPF_MAIN_FUNC) {
>> +                       insn = &env->prog->insnsi[cur->callsite];
>> +                       if (insn->imm == BPF_FUNC_find_vma)
>> +                               return 0;
>> +               }
>> +               verbose(env, "calling bpf_vma_build_id_parse outside bpf_find_vma "
>> +                       "callback is not allowed\n");
>> +               return -1;
>> +       }
>> +
>> +       return 0;
>> +}
> 
> I understand that calling bpf_vma_build_id_parse from find_vma
> is your only use case, but put yourself in the maintainer's shoes.
> We just did an arbitrary restriction and helped a single user.
> How are we going to explain this to other users?
> Let's figure out a more generic way where this call is safe.
> Have you looked at PTR_TRUSTED approach that David is doing
> for task_struct ? Can something like this be used here?

I guess that won't work, as the vma is not refcounted. :( This is
why we have to hold mmap_lock when calling task_vma programs. 

OTOH, I would image bpf_vma_build_id_parse being quite useful for 
task_vma programs. 

Thanks,
Song
