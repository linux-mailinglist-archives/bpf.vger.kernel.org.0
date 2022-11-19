Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8195630C60
	for <lists+bpf@lfdr.de>; Sat, 19 Nov 2022 07:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiKSGNk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 19 Nov 2022 01:13:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiKSGNi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 19 Nov 2022 01:13:38 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B89615723
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 22:13:32 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AJ4nrWi003341
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 22:13:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=cvDtEax3CS7K0O5Fuu0wqsJXOis5BksjHqrsVM85qCo=;
 b=XfAa3wiXb1gitLIhPMZr7gDsz+oRBagL1R3aHA/uqXjnuQadvyPcfIK+26ATMOtiRt6g
 b+NR05EulEQIsRD0cJz9J+YFzcU6eqjTDYR9WvMsPUaG3+rMTViltTPe8fKBlb52v2tG
 Zc7TZT6ktMceFHs0tg+p9dNoUK0GfNaBUDIlyHBhl49haqlU7UJUzRmWPOFjxHkhZ1Hh
 K5NvweXZrfNjTeUAhXEfDDJK8Y1BwUhzM4Edg+rm/m/HLQp81vxGqhNf1D6yF+Jm9MSu
 kUgk2ZOv5Dfw4rDhPbAqZvyG+dS6S+tH4ZCZdPLI3p7m/OvSsiUwk3siyT73fUqFsigb Ow== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kxrex0a6g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 18 Nov 2022 22:13:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kxnLZclb0KSMf5mf/o9JrPxUQSgsYFLw0b03z46LD1fCiDkuckof5XEs1D4V+jtLSFOPFX4IAyk65TXydYdYA9UynrZBemeuqJDHnmTJvSN5wsKSbyYVCB6iu+F8aNFzHBXsgkzrrCO4vNod9yERlGQNz35JxYPhb31tABm1lOh1tcgUG6smu3PXsp4Bt4GzBil0l2Tr/BwTJF3h5QiMS1gLu4hiCz9xt9kj/MGAvWJqES6jz3/dAO6U0YhB1mflupDe1bg8CY/0jku3tZlggJOEenhWNYm8gokwsfxP5LBoRcva/ef+SfM9I76EZF9C3C3NmV4cK2NMTiPEgNK2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cvDtEax3CS7K0O5Fuu0wqsJXOis5BksjHqrsVM85qCo=;
 b=HJVpWi/XnGeM/WKwkZblgNwioxnghFJEkzg2RVm/vY2eCPqK+AU/AtXp0Y8NKGY8Ck0oUOSEc1vJrpwmQwAmECTgo6CTPUxba6aML1s0RB/ljMTJ5pyoWLuTE+Q9Yi+HW2jGhNw6KHH61mAcx4WAsKiIc6DgfD97HeH66egjaN+fJFPsIoJtKTEEKYa2GG84rNPCP414hopNQ+XHetnTMeGYsPV3Vfb7pupn3fXVepiJrTaziicr0LHfEGoJ5SIKMSlEVwqlSWQQJMKo41VOgutRdyK07c5LIc98f6Xmo7iQQTxZrKjC7H/QdQRWha2y2EC8jQZ6qxHFcB+N4x7B2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by MWHPR15MB1472.namprd15.prod.outlook.com (2603:10b6:300:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Sat, 19 Nov
 2022 06:13:28 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3c4d:ca9e:8db4:f7b0]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::3c4d:ca9e:8db4:f7b0%3]) with mapi id 15.20.5834.009; Sat, 19 Nov 2022
 06:13:27 +0000
From:   Song Liu <songliubraving@meta.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     Song Liu <songliubraving@meta.com>, Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Martin Lau <kafai@meta.com>, Yonghong Song <yhs@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, David Vernet <void@manifault.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCHv3 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function
 and kfunc
Thread-Topic: [PATCHv3 bpf-next 1/2] bpf: Add bpf_vma_build_id_parse function
 and kfunc
Thread-Index: AQHY+2Qj3ZAAgzp5qEStRAYmgwCJVq5FWMIAgAAWrYCAABYZgIAAP8EA
Date:   Sat, 19 Nov 2022 06:13:27 +0000
Message-ID: <F64318AA-9BED-47E1-82B2-5739DE4F7540@fb.com>
References: <20221118154028.251399-1-jolsa@kernel.org>
 <20221118154028.251399-2-jolsa@kernel.org>
 <CAADnVQLLvwpAFTEwCw+ZdZGtZTrV7nFu3pXKMRW9irRYG9WJXw@mail.gmail.com>
 <E30FFAE3-2BC8-45F5-9CBC-D7A3C7D66B74@fb.com>
 <CAADnVQK7d-=_GWT++wvrXG9tB=hOEdFgc9Ejh76y4ZLDKd5-Rg@mail.gmail.com>
In-Reply-To: <CAADnVQK7d-=_GWT++wvrXG9tB=hOEdFgc9Ejh76y4ZLDKd5-Rg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_|MWHPR15MB1472:EE_
x-ms-office365-filtering-correlation-id: 4f4f8763-06b3-4f39-d9bc-08dac9f52c3b
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rGkpsAqCcA0t4gSUn9VbliSRFkukjc23Mqy5x6z7lMxC/jc+WKl/C+OgRJCe5hZT2ZoX55mrlWC8brPUtCc1OFAHqZq8aKBJXOmoGI4ZRSSV+cBTHCDPuxfIVVKP/gXMG27EMv5UhddrRajJgTwwRASCXPpy7AV2iUvCKX5k74bmDQX4HlrNvKrL39tYl2Bvwm14wT4ncwOxymQM2NJTfmq+ok2xIgOZ6zy+DFFzwsekKOHv9u5yoxp94ip9dlkgpHcMLp8QmFeUeil/zCEvMFuA0ZV4vulzR1+v56y0qFPdxpWaP0LW+/r38F8V0LrCDQVfZD66eA+8vxynJ4TEXxq/r3mbuWfOikYtRC8By1P7PWr7ZgEODCsAliwdYOihpT0eCuxhVG4IeVsxFDwmL8wigy1UzYufljDdZv6MdhN0rkeMusJBnxqfRf1QfCuxMmogQscTB53cWUj2wnvIvquh+wfQXyMeMJz76086fMQG7NaJDxuSXfdlyNcauZ8fvFRQKKH78d2Vm+8iH0owvCEqLF1XfP7clGo2CU2yYerKrUnmkVpu5ccsOf2orw1pvvgPfNx7Q3YeBMG1+KbWWqVa5EELa8KKRHR/F5de4GC1bFHfL1L3kndhP2NM7Va7dwq7Qnnw4o8qQwiX5lnv0TcXMpV784dqPQS8xwLbIrOu/fvrrB4CHSY+Nku/U6i39ZunDM0ZcwKXBOPypV/LMQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(451199015)(478600001)(6486002)(71200400001)(54906003)(6916009)(53546011)(6506007)(38070700005)(66476007)(76116006)(6512007)(66946007)(8676002)(4326008)(36756003)(9686003)(7416002)(66556008)(64756008)(91956017)(5660300002)(8936002)(2906002)(186003)(41300700001)(66446008)(316002)(83380400001)(33656002)(86362001)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?7663SoQPUGlQjla5nbTwEhX3ebjoIm21EDOxsip5mUZpDO7VAkHtjHDycqJV?=
 =?us-ascii?Q?5fezjpWSqF24lsp84BwO5qLq/x4hHZA76APiyvzEaVde0sGOxRVEYDzTOMcz?=
 =?us-ascii?Q?ZcEcQy3G0XDwmMEGCOb3F9cKTERzTIN0bQxywgmSCthxbA+8vqqd/vqPQXIq?=
 =?us-ascii?Q?78O+HtQ08gYd6+Cy0Vr3TC+Wks6EN6sNouBv370ihW1XOhkMR/naA7hU8mdJ?=
 =?us-ascii?Q?N44Lacgm01cp/wu6VVoltjZcZqTp2yE757eAsOvKTr/cVUrlCN4mUaC+eW5g?=
 =?us-ascii?Q?WEZCGyZf3uDIsSuG9SWYfDPP9Qo663irQ0Bt2o0KZnm0OExaRDyKKPYt+kDg?=
 =?us-ascii?Q?Pzin8BMiObT1gDLpEIr5FywrVr27jxNEvv4kDVMdlETVMpb5EuKV2dL/zWj1?=
 =?us-ascii?Q?Z6t8xaGk1y85pdtar1xU1IVj+ftcPFxwL5CYql5drCDoQ3NQwMJvCssushj0?=
 =?us-ascii?Q?sjDYkdTiKWORElruhE5pXgBb2gtKtraKuYFrwjrYGy4YROVbmwAuNHj0sqIg?=
 =?us-ascii?Q?NQEgT+5B2jkqnEn4Fdb5trlZrxkkUv0YI1UkPUYe22pG0A8DGAl2KsDXfWfl?=
 =?us-ascii?Q?xLVcKKOxXBsb4qt2bL/85h7TaDuPq46Y04nojEgRK/KG/nu1IxHWCI0R+uPW?=
 =?us-ascii?Q?1q80rnraG9a7cHV9AvH70W1KPiFb0akv15dUL6hC9QgIfJqYM8I22a8RGDqm?=
 =?us-ascii?Q?0TcZqOS8coj5b6AQKJuSM/Tff9T4kgYDLKdLTbNj+dEkeYSozj0HFwoJupHp?=
 =?us-ascii?Q?+Fv39XqAm3QMUpxmoz3miK7rvKVFFkc41nky2hh/O/HaPXUGJfRNPF8J3Om7?=
 =?us-ascii?Q?KfIM+MHG6VJlE9j7GS1vH8PV5A4i7tctpAw1eQwRPQ7/5Gcke5iPxig83c+6?=
 =?us-ascii?Q?eG/d66JdeISL/J3/nci6V4IcrXUVVajvMiT4esL/Le+x2JIk/b285uXHTKWU?=
 =?us-ascii?Q?e5Acaueg3aGMxR+MEESaw0tV5OpNdNpwEPczhfoHehZINepAzl+PtsIRaLo3?=
 =?us-ascii?Q?0QkXNaf5vDervCjtAO2n9QJ7eXhF1VHj1LqUJhesJZvfQklDIM+/ppHb5U4G?=
 =?us-ascii?Q?A2Wc0uYoZFSqCzAVKn5yVSfuwSMfFvr25W6ajvDh0xoDPgP6/FXhCcv/Xn23?=
 =?us-ascii?Q?RBSFhGCe4JbV6JrrKtWW2kSNzrJwr2SRn0k2llWfZlSuKZZpNA9vmVKXGo/b?=
 =?us-ascii?Q?epjuHXUfSMBFeN9CyJYBM6JV5md516LvQO1fQqR87OAMrsrSArRS+wRpZtcs?=
 =?us-ascii?Q?D+LxmqInSlEUurSYpgfRXp6dDJ87safToIqGQIFnqpgmjCuyvWgwEvRTGOin?=
 =?us-ascii?Q?AqjtDYLrTMi3u8Ar0GnEOHFUgeQk+5vfDtZ2afQL/2Kk9hAtQhqECvGkXzUD?=
 =?us-ascii?Q?qBic5PVxRvaS0mJaDPzd4R/b1sQyxIbP1T3IyoPtbM5hwsmkMJUAes/X9+R5?=
 =?us-ascii?Q?R9D4C4QDizVM3Bc7LNC3C/BggrdVrH6uqem+bEZNhSEFbGG7TfMQkJAZtcS7?=
 =?us-ascii?Q?pcSrKAYzJtNRH0HFR+l5sPdfZ6+AyP6J9X3cTsR6oCX7svGQ4yqvXQk7s59X?=
 =?us-ascii?Q?W3BVFTdYv/7bCS1DGJ6o0BvUbX5/2mfy498qvQA1I8jcqm0NB1Y7faQLfxbc?=
 =?us-ascii?Q?/4rI6vRp+LvK1Y2xnj1teWcAQkp4R4QL0Oy/6m66OoJT?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6E0A70C2115B704AB98DDA8E80B2650A@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f4f8763-06b3-4f39-d9bc-08dac9f52c3b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2022 06:13:27.2324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 03ZOmxJN2khZzRcu81wVxEaEIU/DsCuiTx3EW61fH3gNKaUqE3qKGWrDHf6JCnoc1UiZxVsTp5o1KShQPPyqVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1472
X-Proofpoint-GUID: M26WFsqzRLw4Q-xZq2Mga1Ad6Wy4pCQZ
X-Proofpoint-ORIG-GUID: M26WFsqzRLw4Q-xZq2Mga1Ad6Wy4pCQZ
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



> On Nov 18, 2022, at 6:25 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> On Fri, Nov 18, 2022 at 5:06 PM Song Liu <songliubraving@meta.com> wrote:
>> 
>> 
>> 
>>> On Nov 18, 2022, at 3:45 PM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>>> 
>>> On Fri, Nov 18, 2022 at 7:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
>>>> 
>>>> Adding bpf_vma_build_id_parse function to retrieve build id from
>>>> passed vma object and making it available as bpf kfunc.
>>>> 
>>>> We can't use build_id_parse directly as kfunc, because we would
>>>> not have control over the build id buffer size provided by user.
>>>> 
>>>> Instead we are adding new bpf_vma_build_id_parse function with
>>>> 'build_id__sz' argument that instructs verifier to check for the
>>>> available space in build_id buffer.
>>>> 
>>>> This way  we check that there's  always available memory space
>>>> behind build_id pointer. We also check that the build_id__sz is
>>>> at least BUILD_ID_SIZE_MAX so we can place any buildid in.
>>>> 
>>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>>> ---
>>>> include/linux/bpf.h      |  4 ++++
>>>> kernel/bpf/verifier.c    | 26 ++++++++++++++++++++++++++
>>>> kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
>>>> 3 files changed, 61 insertions(+)
>>>> 
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index 8b32376ce746..7648188faa2c 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -2805,4 +2805,8 @@ static inline bool type_is_alloc(u32 type)
>>>>       return type & MEM_ALLOC;
>>>> }
>>>> 
>>>> +int bpf_vma_build_id_parse(struct vm_area_struct *vma,
>>>> +                          unsigned char *build_id,
>>>> +                          size_t build_id__sz);
>>>> +
>>>> #endif /* _LINUX_BPF_H */
>>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>>> index 195d24316750..e20bad754a3a 100644
>>>> --- a/kernel/bpf/verifier.c
>>>> +++ b/kernel/bpf/verifier.c
>>>> @@ -8746,6 +8746,29 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
>>>>       return 0;
>>>> }
>>>> 
>>>> +BTF_ID_LIST_SINGLE(bpf_vma_build_id_parse_id, func, bpf_vma_build_id_parse)
>>>> +
>>>> +static int check_kfunc_caller(struct bpf_verifier_env *env, u32 func_id)
>>>> +{
>>>> +       struct bpf_func_state *cur;
>>>> +       struct bpf_insn *insn;
>>>> +
>>>> +       /* Allow bpf_vma_build_id_parse only from bpf_find_vma callback */
>>>> +       if (func_id == bpf_vma_build_id_parse_id[0]) {
>>>> +               cur = env->cur_state->frame[env->cur_state->curframe];
>>>> +               if (cur->callsite != BPF_MAIN_FUNC) {
>>>> +                       insn = &env->prog->insnsi[cur->callsite];
>>>> +                       if (insn->imm == BPF_FUNC_find_vma)
>>>> +                               return 0;
>>>> +               }
>>>> +               verbose(env, "calling bpf_vma_build_id_parse outside bpf_find_vma "
>>>> +                       "callback is not allowed\n");
>>>> +               return -1;
>>>> +       }
>>>> +
>>>> +       return 0;
>>>> +}
>>> 
>>> I understand that calling bpf_vma_build_id_parse from find_vma
>>> is your only use case, but put yourself in the maintainer's shoes.
>>> We just did an arbitrary restriction and helped a single user.
>>> How are we going to explain this to other users?
>>> Let's figure out a more generic way where this call is safe.
>>> Have you looked at PTR_TRUSTED approach that David is doing
>>> for task_struct ? Can something like this be used here?
>> 
>> I guess that won't work, as the vma is not refcounted. :( This is
>> why we have to hold mmap_lock when calling task_vma programs.
>> 
>> OTOH, I would image bpf_vma_build_id_parse being quite useful for
>> task_vma programs.
> 
> Of course we cannot increment non-existing refcnt in vma :)
> I meant that PTR_TRUSTED part of the concept. The kfunc
> bpf_vma_build_id_parse(struct vm_area_struct *vma, ...)
> should have KF_TRUSTED_ARGS flag
> and it will be the job of the verifier to pass a trusted vma pointer.
> Meaning that the verifier needs to guarantee that
> the pointer is safe to operate on.
> That's what I was explaining to Kumar and David earlier
> about KF_TRUSTED_ARGS semantics.
> 
> PTR_TRUSTED doesn't mean that the pointer is refcnted.
> It means that it won't disappear and we can safely pass it
> to kfunc or helpers.
> For bpf_find_vma we can mark vma pointer PTR_TRUSTED on entry
> into callback bpf prog and the prog will be able to pass it
> to bpf_vma_build_id_parse() kfunc as long as the prog doesn't
> add any offset to it.
> The implementation of bpf_find_vma() guarantees that vma ptr
> passed into callback_fn is valid.
> So it's exactly PTR_TRUSTED.
> 
> Similarly task_vma programs will be receiving PTR_TRUSTED pointers too
> and will be able to call bpf_vma_build_id_parse() kfunc as well.
> Any place where we can guarantee the safety of the pointer
> we should be marking it as PTR_TRUSTED.
> 
> David's series start with marking all tp_btf arguments as PTR_TRUSTED.
> Doing this for iterators, bpf_find_vma callback
> will be a continuation of PTR_TRUSTED logic.

I see. So PTR_TRUSTED task_struct is an refcounted task_struct; 
while PTR_TRUSTED vm_area_struct is a vma with its mm_struct locked. 
That makes perfect sense. 

Thanks for the explanation!

Song


