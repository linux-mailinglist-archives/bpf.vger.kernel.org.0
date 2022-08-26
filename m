Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331455A2F3E
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbiHZSsV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344241AbiHZSsE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:48:04 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3467BB514C;
        Fri, 26 Aug 2022 11:45:03 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIP68I028198;
        Fri, 26 Aug 2022 11:45:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=oRX89eJu6h8IWRTTEj+ty43CE1Csyl7WeAxSCNypqAg=;
 b=Vky+4cUxQngYvJHA7ydmfs1vcUGDHRNI5aJHdDqzWbROmPsSfsxX6pZKn9gQ33avVl1p
 VU0r7DIWpMXlzMULYxDHjqBw0yUvAXxn5M4qAS8rXPLwbRoFky63KENuNydxF9ptSWbO
 TiTGNyMdEelwyi3hPfZsY3oG7CRTBVDxeX0= 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6myh55m5-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 11:45:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AK/ICEuCKRkoU1xGB/V983UxokvsKd5aXY4/ZN9+zjQmuQOzmVcfrWdjQqfaBh75L9alvvAnbvPyMSE/O2fRTlaL+rI4ZnzUNlLy1NuzkPf3coIzzXVo7rkc2eTiwPK/lpINaTfKwFOoOCB9IIgq/8YL3DPsnAzU9/Xi7ncbAlxAdVngFVuNwCilGkEEFsHHX2zkT/EXLWezJOvl8BfBpumNku6e3fskBJ/mrt/Q6mbjW2QgGOrYCx/gPigPz+0Quy/ec7fWsmYOO35AQSkvUlwugN+nDjPDYx/3yhy9VJqP1eFOU/7SnNg8Ba1pTxzqHY8geYCLdzq0ZDkR4vtxwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRX89eJu6h8IWRTTEj+ty43CE1Csyl7WeAxSCNypqAg=;
 b=ebwSEBmGPF8Xu3sA3ubkipdFaU0Fkx/yzyvFfVFnRDV2YKJFPtiKErZ6Hh9Pt4vI4th9MgYinggDlOn0KVe4MYccxzVpDem25e0LtdIWBWVIbH+VU9+VXxAW/6IZEB8dQmaQq8Zz0lYBXI7Vj7b+AWUQYtI8zffM5rDDTJSQxwEVxqTN84pfVKGOTLpx4lkVyFFqifipQ5LsXSz/6+3qC6KYmm+K9nx2nHWazpSouNrGXustZRY/RdCFCDrBfORaB6cEZipnmruinGnPjtxuc9FFJe9abHNLcqaP2CT/4gxE3eoKVNJqSpppmrBe39Bu6atcKCv87lnuPjAU1RNZ4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BYAPR15MB3191.namprd15.prod.outlook.com (2603:10b6:a03:107::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:44:58 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 18:44:58 +0000
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
Thread-Index: AQHYtzPeWFYcAGzsN0Wstq4jJDfNwK3AJloAgAAJpYCAAA9aAIAAO0MAgAAulQCAAAilAIAAsuMAgAAazgCAAAnxgA==
Date:   Fri, 26 Aug 2022 18:44:58 +0000
Message-ID: <FCC75F8E-4C2F-42A4-B582-9BE3BB87E15A@fb.com>
References: <20220823210354.1407473-1-namhyung@kernel.org>
 <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com>
 <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com>
 <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
 <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
 <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com>
 <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com>
In-Reply-To: <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8135152f-0eef-429e-5791-08da879313a6
x-ms-traffictypediagnostic: BYAPR15MB3191:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wv0w98bvpG+nYgrXQeG1LpxkSMptsS7ZB3Q3mDIc2LMR/P+sX1SqjENDIac9vfiFMSQ8GcroFGeFYEOt4BKCXxAW+TqM9XkGchD6HaxtazeI/lx+KA4BIJqa/gFHD8LoKf9VrRhYSJHaeuo4X3OdmCmzcLivTlH4XC7jOPFq+/2P108zOUVq3uN1M12bd7PMdF7LVaJqxDuk2VFSgcIGRHoWsWTkKgoS1A9nFsKqy6jdoH3qg7+sRiSf2JClBnRqz6WDKBpnnVKza9ih/KfV+ACxZYTB/bb6HRjDPqbCwhDtdmOLJQVhheERsiN45ajZ4JdGGEUdorMXcDf4pZ1dp43/kZ8kC1DS/ka5rCvN7unjBKFF97yyCe/BvPY/OsiNM4J9EMtqxnrq8N3Cdv8fFrfsOjBU5LpHYSiPKtGOt2iY3Z7oLyRQ7rSRwrwoRG1xri7vBiGv0lL3B01mWcNWA4SVd5/fXZrHrQNRaVCo0KXt8mXpOuvEQ/Iy0iEMgLQYQQ8ViK8pBBpQwYkJBFaEmhOF6ICKnWnremuzd2Q/NiidjgpNMr9W/AIP7bI9RzTR5luiNxdZnQWp2eg2j4qfONosKCtkVLWVvHP9ST8zXCsdStFD7uTvd1zxwASi5N8V0R3hmiynUfjdDy1MuCmNYyX7cy3+oe4rCjdefi1/BaJSu30jNoHv66hHv/YwaQvob4ab4qPa0w7cWYzt9lDFLAuNvCCvGP2bTiFdtMoUkODQUARb14DaeoV4+/kijHCpt6+yZ2QuTqUiaQP8WaUXuFbG4I35bgPpE2XTBsN0+Sc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(366004)(396003)(346002)(39860400002)(186003)(2616005)(41300700001)(6512007)(71200400001)(6506007)(6486002)(122000001)(38070700005)(86362001)(478600001)(53546011)(38100700002)(83380400001)(6916009)(8676002)(66946007)(66556008)(66446008)(91956017)(66476007)(4326008)(64756008)(54906003)(5660300002)(76116006)(33656002)(316002)(8936002)(7416002)(36756003)(2906002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Dedg7hGjNkbDXDInjRy6m1Z7hi+Pr1WTwQ0mvCMsTupV8UP7DNNt4LjmyKOT?=
 =?us-ascii?Q?Q1wQ9OPEJ+xAEpUTgw4UBtitpEpdQ4Vr4pkhHFIKCG95Gp+NOC2un7l/JMsu?=
 =?us-ascii?Q?Bs/zTWfKIA30Tl9J71kHgrT29/0mn+dwZE0C96PHNw/Ptu6mmie4w02zD1GT?=
 =?us-ascii?Q?YbNol/lNHuN22kKi1rBbiG7XHUpDi4JZ/Q8AV3uOOaWV8BhCUjRZT8mixo/E?=
 =?us-ascii?Q?JIAHhol+GJTlg+orHkWcy05wy4bBx4QZtbJnk+GiSA28s161fgxBZ7jeDIAt?=
 =?us-ascii?Q?93+998YYSvDwy84EpmV9j08qTDdsgjWUJnANNkudGXu/RgTVPdAHUpiDGB/Q?=
 =?us-ascii?Q?idm1m8GI77UGhutI5ttv5GNb3UxZJfdudGR60GuO/Vaj+mQsxlB5ihFMwUWz?=
 =?us-ascii?Q?VRoL0UDSPoD3H9zotkYe3fVYDJAEZmeHpSRLhw2SVprh9epjnoE7e6EC03Ph?=
 =?us-ascii?Q?1mY1Pf9noXqQCoSveyx1tkIqksFolxteJAgqqHekvVkNUn5wFpRktO3es5MT?=
 =?us-ascii?Q?cCyAG4G+36vWSUsy6y0Q4DUWu6vqbmEP0ZbBaulPzDGF43RjVeASv04izCf0?=
 =?us-ascii?Q?9fCtCw8xFuI9XHJdn5UNXeUwk7Bn1EIpCuRlvDcekVFQ2ge9+49e64RY1/r9?=
 =?us-ascii?Q?/C7mwZICOVd3JoMDx8sxg5qqspVkaR4jR04DcfUusfF2QVdXvkNCGv/G0FQ2?=
 =?us-ascii?Q?n1dpF73yggmrQGk8PPT6x1cJQJzHQJa/74UB9pt73loGwvS7O+op+pjS+Rfx?=
 =?us-ascii?Q?mkF06D8rWgXEidW9xykGXXltAW55JFE/RHCWYzvwxbHbzPQkbtF8svfxRmHn?=
 =?us-ascii?Q?6mr5SYP9xKdXoHodX9UqQdidIySh6T+4+3db++AXp1c7wTOAwvBuljXk2fTF?=
 =?us-ascii?Q?0YFcIn2TpfusuTPX/Ez06v4y6Ap5WSQQKNVHn0UWfg59sLb3m6ad36jAlOvC?=
 =?us-ascii?Q?zQBCoQGDr5YtM6+KzY3Z5kYFcbvfd9U1ng246hfgBFC3xTE4Be0jZx0x94e0?=
 =?us-ascii?Q?Q/tE/LMgXwNPt2Jfl3olUCazMHckbnnhLq6+oLYFSfuMPEaAeZ1cQcNP1II5?=
 =?us-ascii?Q?31+V5znv/FUue8IYTuD3eHhhxCKEi+Iy5F2AJKe6RGeJgzzSqJxtKkgKl7e9?=
 =?us-ascii?Q?3MUHskTG8E3pJUw4gIiP8cjV/LpiWHmGuozFRaRXQO8EFZUzlGBgkMS1wi9O?=
 =?us-ascii?Q?D0MdKRKaSU/1upiZVPL74pXU5I26kx2cZKV1l3RM9J5aR1N0h+z8GCgCOKeX?=
 =?us-ascii?Q?vDQRGCrsbCESo/SV+KXYfz0NOZL84DVoRe4pxSRA+lf97hY4PGjn2qFWiIN1?=
 =?us-ascii?Q?mQKrDdUZeBHK9PjmZTuXl1rYE927VdTElK+a66r4FZKqPmqi9KFqBI3eu3Bp?=
 =?us-ascii?Q?EvT7ILqm5Oz7Zv7iYtxfzJ6AcTdtfla+UniMychW6jkj1N34GR6UAECCi089?=
 =?us-ascii?Q?ga3dJ7aQ3mHBMY1inFYf6wpgL+b/Rq173F4lALIc0YiZgHFt2Wkkmmpv2lOA?=
 =?us-ascii?Q?8ZCQ1zzGFSnQ3Rp8YVpabCuOvP1ug0GY6OF8wkUYfTE34Thr2SjhhrcCtFgv?=
 =?us-ascii?Q?DwymNhafYwTd25TzefFc/IpTZ/gabiDYMPcqo5I5veXQy3jm/6UNYTf+Aj+b?=
 =?us-ascii?Q?FGYITd6p5KGHpbo2LxnO5Zs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B392E81C237820498469EF8A68A8E473@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8135152f-0eef-429e-5791-08da879313a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 18:44:58.5488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WtIU6JsQDCfdwH0SIPM7xrIFnw/w5dn6MaViBAAxZJoXNwr2fs2cAtuLlXDj4QzmZi8jY9HXrR7li+9ua50xAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3191
X-Proofpoint-GUID: MeZ0K8s-1LtWzQY5LZPU4SDPjc-dVZlT
X-Proofpoint-ORIG-GUID: MeZ0K8s-1LtWzQY5LZPU4SDPjc-dVZlT
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



> On Aug 26, 2022, at 11:09 AM, Song Liu <songliubraving@fb.com> wrote:
> 
> 
> 
>> On Aug 26, 2022, at 9:33 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>> 
>> On Thu, Aug 25, 2022 at 10:53 PM Song Liu <song@kernel.org> wrote:
>>> 
>>> On Thu, Aug 25, 2022 at 10:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>> 
>>>> On Thu, Aug 25, 2022 at 7:35 PM Song Liu <songliubraving@fb.com> wrote:
>>>>> Actually, since we are on this, can we make it more generic, and handle
>>>>> all possible PERF_SAMPLE_* (in enum perf_event_sample_format)? Something
>>>>> like:
>>>>> 
>>>>> long bpf_perf_event_read_sample(void *ctx, void *buf, u64 size, u64 flags);
>>>>> 
>>>>> WDYT Namhyung?
>>>> 
>>>> Do you mean reading the whole sample data at once?
>>>> Then it needs to parse the sample data format properly
>>>> which is non trivial due to a number of variable length
>>>> fields like callchains and branch stack, etc.
>>>> 
>>>> Also I'm afraid I might need event configuration info
>>>> other than sample data like attr.type, attr.config,
>>>> attr.sample_type and so on.
>>>> 
>>>> Hmm.. maybe we can add it to the ctx directly like ctx.attr_type?
>>> 
>>> The user should have access to the perf_event_attr used to
>>> create the event. This is also available in ctx->event->attr.
>> 
>> Do you mean from BPF?  I'd like to have a generic BPF program
>> that can handle various filtering according to the command line
>> arguments.  I'm not sure but it might do something differently
>> for each event based on the attr settings.
> 
> Yeah, we can access perf_event_attr from BPF program. Note that
> the ctx for perf_event bpf program is struct bpf_perf_event_data_kern:
> 
> SEC("perf_event")
> int perf_e(struct bpf_perf_event_data_kern *ctx)
> {	
> 	...
> }
> 
> struct bpf_perf_event_data_kern {
>        bpf_user_pt_regs_t *regs;
>        struct perf_sample_data *data;
>        struct perf_event *event;
> };
> 
> Alternatively, we can also have bpf user space configure the BPF 
> program via a few knobs. 
> 
> And actually, we can just read ctx->data and get the raw record, 
> right..?

Played with this for a little bit. ctx->data appears to be not 
reliable sometimes. I guess (not 100% sure) this is because we 
call bpf program before event->orig_overflow_handler. We can 
probably add a flag to specify we want to call orig_overflow_handler
first. 

Thanks,
Song


