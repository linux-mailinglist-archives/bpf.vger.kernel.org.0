Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578D35A30A3
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 22:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbiHZUwS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 16:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiHZUwR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 16:52:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B380BD3E78;
        Fri, 26 Aug 2022 13:52:16 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QKYkUP029649;
        Fri, 26 Aug 2022 13:52:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=JVyS4OpXBScoasKYtyjduaVQ7xk7I3JSh8zO1MIKxtk=;
 b=AGb8aJd5DoV/UtnC7w6VBgQN4zbr68dKBFajeHN+wknSeJ+0HcsQgUncsib0/k3rSVN3
 45YAR+TbnhZYWq2sQOG/feo56G1+Wq80yCfwPHw2vqAzzOvt1ajx9E8/arMlVPCG6LEh
 jd6Hi2OAPoOyGl9ITccSQBfk6683WLZLEu0= 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j75b5r3dg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 13:52:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PaYHTxS4VMFG5qaF9kVDIkH84FrSpp3rZHH8TaAkU1j91Nz3uB3kXs1ptf3t8WBGFpyixKHUVeT0Mx998Bi2QYyBVxxUqhyHsJNcrQIXZ6kjpUytG23rsOF8aIPnPpfwcA6DQgU6OQvJm/ON83TyVKvZYz53pgRXzj3M6z3gMR39Kydk1eS41zsAh15NqnUbcxjsuPjqwSyMSROmDXg4Afhh2cV3poBZuj5OrmO+cwfLtD4B7q9ahwbFtYDV1sYZNDwGzvSxWr7Q/1fcUeLF4qVCibsOmJEde3mq5ufye4JgXYkeZKgFo0b0i94gyXGnIb0AP07BKvBagJnXJoMHGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JVyS4OpXBScoasKYtyjduaVQ7xk7I3JSh8zO1MIKxtk=;
 b=c3Du13y6xhMXjlhjtEjr8GgE+UrSxQAJYmvo+GPcDXrSkGfEOdar0BK/vkn8UW1Ax1oFPM6ftq1XX/7genCwG4glXOU9adF5Ye/WNv2JLsHByoWxgEOM9HiUiJYeb6El2N1BuJwxAwzhcnWsW4cONb+6mcdlO+Sr90a+XIEm4vCYGINogBbUGN9TaNLzDou+SvksliWV9B3lYfB1gqJOEmTDfHwcVpDd0j+dKWhZIG7Gug/XPj8w3+Tb3gs354iC66lguRADVw1Fsg3L47pJlcbrJze+PAXmgWa4RqDU2nTdXHGX+liH1mvL8/btr7m91dAdFMfwuJV18qr8umXwkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by BN6PR15MB1201.namprd15.prod.outlook.com (2603:10b6:404:ef::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 20:52:13 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 20:52:13 +0000
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
Thread-Index: AQHYtzPeWFYcAGzsN0Wstq4jJDfNwK3AJloAgAAJpYCAAA9aAIAAO0MAgAAulQCAAAilAIAAsuMAgAAazgCAABQ9AIAAGUIA
Date:   Fri, 26 Aug 2022 20:52:13 +0000
Message-ID: <BCF27304-3F49-4B8B-B1FE-D785370BB9A5@fb.com>
References: <20220823210354.1407473-1-namhyung@kernel.org>
 <CAEf4Bzbd0-jGFCSCJu3eDxxom42xnH9Tevq0n50-AajjHb5t3g@mail.gmail.com>
 <A9E2E766-E8A2-4E2E-A661-922400D2674D@fb.com>
 <CAEf4BzbGf6FuM7VcnA7HKb33HJeJjrDuydC4h1_tCUB8sPCW2g@mail.gmail.com>
 <E215461A-01E7-4677-A404-C4439D66A7AF@fb.com>
 <CAM9d7cgigkU8quUMpScL=Xt8+WLDVXKiF5xdKiz7BbDPibSNjg@mail.gmail.com>
 <CAPhsuW5V1U_UTHQw9E80vCTeP4Jqg9Ta8B+7o3pybKB=8CGRFA@mail.gmail.com>
 <CAM9d7cjTtOkRHLOosxHN8PcbVbhTK=uLDGjw8N5=1QiTHcd6rQ@mail.gmail.com>
 <C7F3F33B-4A8E-428C-9FED-FB635955C2B1@fb.com>
 <CAM9d7cgUVg1Cv+0fs=Mc7OBTOHNJkMqWnm0SZ5R7xfm5peBNDQ@mail.gmail.com>
In-Reply-To: <CAM9d7cgUVg1Cv+0fs=Mc7OBTOHNJkMqWnm0SZ5R7xfm5peBNDQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c91b6d14-acf9-49fc-863c-08da87a4da5a
x-ms-traffictypediagnostic: BN6PR15MB1201:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /vxuFk2gyoa5PKg/5RIYwMPHN9/f0c0aiyNBbJh0DztKJv0vPrlOsRWMpigoH9q1rF7YiQJQVs+gR5YgVRSeu9Qlk6HqYVci5ts7LsAc8X385WlssBl5w2Xg0T6XQtDXEsb11CwWeC0eYls9bLHMTibUMwMD4JSUpzvaY/CQJ6xGLFFubkmhCwSl/ePBGYVfNA9zU5SSy6XvIALfp+OrtjIYLKwHwQEq+JfZeTEMFgoBbPRZAs6VVvGC+eE/6Anm1U7lETUMQGwBqHgZrQvuMUYjieQPwcdYlVqLMl89xnRK98JLpvYwfmmiPq+FbukVIzgStUMD8hb63YolnNXj42Q1bNstSJBlsEfNKlmrdXde1sh0SrBfGT8JKLx2H7IPS0tro8pYYJCNl5DVSvVLCJcawiRnmQstLFhaLQKWPzzFkE4hukwNBBmLxiKnOrl9njJp+eeK1SfxEFlBNvM21o87LDMXbd64yaOzyDPl/42rxgJaqjVSNBwGVJG+uvzI8vGFwUKOY9RaAt4MXNaXlp96Vyi56HwNAhJKU6gNAa0v1UVhfUEroN39jjRk6PEYgc1b2q2Mq9sAOKDHX/J81s2Bzlcrkb/EWY7s0w0vN5u3avaJ1a4TKhNae5c9Eu4kKb7ltybfDzQVm57RHhQ7hhZqGKSsvN3IxP2IIUK1IiYYKM/nEEV6dYfMBQ3Qdntq89PNe91mrWQzHl4oxiltjDX/MOY1+O7xm6zl05dpAxIrIuBeaU7yNNYb9SU/GgYJU/mJ3tXw5ZvOzfx+8Zz9w53IjkFCUHEoJkhqpHx4voY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(478600001)(66556008)(66946007)(76116006)(91956017)(66446008)(6916009)(64756008)(66476007)(8676002)(316002)(4326008)(54906003)(5660300002)(2906002)(7416002)(8936002)(38070700005)(38100700002)(36756003)(86362001)(33656002)(186003)(53546011)(6506007)(6512007)(6486002)(2616005)(41300700001)(71200400001)(122000001)(83380400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GDs0sdM7Ck+WLV4Z4x+zKRyrsqLQ2tHBYIm8fgB0IqsCCmA/bA6fKV92ibwS?=
 =?us-ascii?Q?xiurVNQZSrHyTOtow4XWHlNA5GPogwdMEJF0dT4ExzSOLn/KSo4YFJbpuJaU?=
 =?us-ascii?Q?tkBdSICzJ1Gf5YFr40Rfu7AwzSWS92yyQ7HrBG8X2aknw1weapes6MUuJrWS?=
 =?us-ascii?Q?tygfODWB5MxVKEP456qmV55CBOjOenNstOA77DFMVkn9ZbbWkXLlB0fho3yz?=
 =?us-ascii?Q?U3HEZeWuR+VGnl6n1IC9v8tHt2lzkQwb7PlsYhU9kt+q8qqcSKAIbFA4alDq?=
 =?us-ascii?Q?QfWvAhVMkp0mXxgAYoC9EWr6XCFncndVPze+FSQ3BLSCDQiB+8r+4UhFuR/X?=
 =?us-ascii?Q?EKMInkI7Rzagt+B95cgH3VeUUX7H/Of4Z7B75WDflCEXzBrntqFxX3h/a9tI?=
 =?us-ascii?Q?AOM+1mlxDz1SQ5PXt6YjJNdGmfRzjXkV6OR3PH8Jwy+Wce677OQJUF9K1pYY?=
 =?us-ascii?Q?lSNmn+B7rP5dDDQqTR5buJkykhkBHoGf+cz3LANuxDxi+war67thm6EojBnG?=
 =?us-ascii?Q?G314ehy46FkB7Okso5PuktpF3zVZSbAZarLTwDMVptR5rCs0FyNZaqxNGTTg?=
 =?us-ascii?Q?M8A0QeJ0yMh1TDn365OddBBNgcncA71GT2pbITKICRbgDzB6q7ShJpXgGuoL?=
 =?us-ascii?Q?vnH7Lk5+K0BmZhWOjqPBk4X06HW/xguyhmHqweP03P51QA+Yv5A8QYQ0BuuC?=
 =?us-ascii?Q?Q/5yT5mVG9Uqw7QBAyY3UGn40s3JQm1vv31/cAWRpWluLiNs4fHyckfl0Kwn?=
 =?us-ascii?Q?YAZsLEsMKJ1yZ+TGQkooNGc0wfpyJLZq4C2wjgyLJsRY+WdXUPMCdYrsnPGP?=
 =?us-ascii?Q?AMt2pVfm6b4ya4NIXye19XGvhOi6zcfMBEEPLfRxnRPW05OVy7kPFLLMnTHZ?=
 =?us-ascii?Q?/T9iM38Fr2FcIz5K7JVrrPo3m/u2Q3AWeUq0vBZwlx0tcfAtwrGKOOFOta1W?=
 =?us-ascii?Q?SG0TZIj3iL8nKTL1/XnMVaSxubmvtkhmfuyXQ0Ol0m8fmj60hIyMx64TGtmZ?=
 =?us-ascii?Q?/XtlevGajULhTuRJ2JvdzlYosqX0ikRfTmIXHTpgO2eXYjDtnk6/CTDo+SLW?=
 =?us-ascii?Q?I/87yJzkQzsiPkaQxrGHonCPT/am0gvhopp0Nfp71bRP3LSydsYzGz5B1WYh?=
 =?us-ascii?Q?qoOtu8/aGIVWmJ9M8H0sK/Nj7xoi6UqDX3w5L7cW8okbGhWCrWM0gwKGvwk2?=
 =?us-ascii?Q?kHcoHc1SidvLgpBuG0jsG7orsvzPZtzfpk1D0QEKxu+ThR1OaS5dnswg97BB?=
 =?us-ascii?Q?WWsL1ZmNmsgebq18OZy2faXYfNVhlNkCZjtUcNBgvb71gsT7ZZ1SoInb24aq?=
 =?us-ascii?Q?gI5fSbQe5Sz82ImcVrdXWjUAR7+9hoIXWDLm1fYNqY6WwouVKejaJKJM3xx8?=
 =?us-ascii?Q?9SItqB9J01JjfTfHsQNlPWHmXqLwb1PXZqJUX+aiI2+zMnoBXhtb5yW61g6Q?=
 =?us-ascii?Q?F4FWr2VpJZaSbaIFSLpguFAA3J4wSD+D2aPkctVAAAxzEi9wegmL8XvcU9eB?=
 =?us-ascii?Q?Xlad4hI6hkt4t0qn0pk0830tOYcN3C45dk9X6X96MtlQoXuvVEC3vOoyxSYo?=
 =?us-ascii?Q?DgQUrclu3IK+8UIrIX95gGkVrTdJFv2Xyn7I7anu80NYS71CxcBLzBNsaWZy?=
 =?us-ascii?Q?Z6J7H2xE2pE23ulBJarocvg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <30EF321B431B444E974DF7B8A9D3B2D4@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c91b6d14-acf9-49fc-863c-08da87a4da5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 20:52:13.3786
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlLTybxcOjUuNcEuKsvPJzlWad1+3egPxVgf6YipQRP0f1ixDrqgurh5FAEbLrA5D+GO1dqJGRyES2A6H18v1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1201
X-Proofpoint-GUID: oMCD0Ofw8ZbTLvKqKLWQ_pMKiKae2i-Q
X-Proofpoint-ORIG-GUID: oMCD0Ofw8ZbTLvKqKLWQ_pMKiKae2i-Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_12,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 26, 2022, at 12:21 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> On Fri, Aug 26, 2022 at 11:09 AM Song Liu <songliubraving@fb.com> wrote:
>> 
>> 
>> 
>>> On Aug 26, 2022, at 9:33 AM, Namhyung Kim <namhyung@kernel.org> wrote:
>>> 
>>> On Thu, Aug 25, 2022 at 10:53 PM Song Liu <song@kernel.org> wrote:
>>>> 
>>>> On Thu, Aug 25, 2022 at 10:22 PM Namhyung Kim <namhyung@kernel.org> wrote:
>>>>> 
>>>>> On Thu, Aug 25, 2022 at 7:35 PM Song Liu <songliubraving@fb.com> wrote:
>>>>>> Actually, since we are on this, can we make it more generic, and handle
>>>>>> all possible PERF_SAMPLE_* (in enum perf_event_sample_format)? Something
>>>>>> like:
>>>>>> 
>>>>>> long bpf_perf_event_read_sample(void *ctx, void *buf, u64 size, u64 flags);
>>>>>> 
>>>>>> WDYT Namhyung?
>>>>> 
>>>>> Do you mean reading the whole sample data at once?
>>>>> Then it needs to parse the sample data format properly
>>>>> which is non trivial due to a number of variable length
>>>>> fields like callchains and branch stack, etc.
>>>>> 
>>>>> Also I'm afraid I might need event configuration info
>>>>> other than sample data like attr.type, attr.config,
>>>>> attr.sample_type and so on.
>>>>> 
>>>>> Hmm.. maybe we can add it to the ctx directly like ctx.attr_type?
>>>> 
>>>> The user should have access to the perf_event_attr used to
>>>> create the event. This is also available in ctx->event->attr.
>>> 
>>> Do you mean from BPF?  I'd like to have a generic BPF program
>>> that can handle various filtering according to the command line
>>> arguments.  I'm not sure but it might do something differently
>>> for each event based on the attr settings.
>> 
>> Yeah, we can access perf_event_attr from BPF program. Note that
>> the ctx for perf_event bpf program is struct bpf_perf_event_data_kern:
>> 
>> SEC("perf_event")
>> int perf_e(struct bpf_perf_event_data_kern *ctx)
>> {
>>        ...
>> }
>> 
>> struct bpf_perf_event_data_kern {
>>        bpf_user_pt_regs_t *regs;
>>        struct perf_sample_data *data;
>>        struct perf_event *event;
>> };
> 
> I didn't know that it's allowed to access the kernel data directly.
> For some reason, I thought it should use fields in bpf_event_event_data
> only, like sample_period and addr.  And the verifier will convert the
> access to them according to pe_prog_convert_ctx_access().

We can bypass pe_prog_convert_ctx_access() with something like:

	struct perf_event *event;
	u64 config;

        bpf_probe_read_kernel(&event, sizeof(void *), &ctx->event);
        bpf_probe_read_kernel(&config, sizeof(u64), &event->attr.config);

Thanks,
Song

