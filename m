Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4F075A17A4
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 19:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbiHYRE5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 13:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241817AbiHYRE4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 13:04:56 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C17E57554;
        Thu, 25 Aug 2022 10:04:54 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27PGTH1u017385;
        Thu, 25 Aug 2022 10:04:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=/Vwg4o9Jv3ZugA1p+UrFza9IJywOpIcwLnr/r6u09Pg=;
 b=qvTmM5RXElY9Fdtsde6teZ/QJSZZwXXWLXcB0n601qypLOZOc0gjagnliORaA938CUGz
 PvhYG9di3E86zMRbNBGEBIxgh9MShJABbeRAyDM1KtkXkr7KM6ifFVpnajnT9wc2ut2U
 hX5bG6+VpuBWTJPWngmkzXcpDQyn/JEADRI= 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2047.outbound.protection.outlook.com [104.47.73.47])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j5ab0vkf9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 Aug 2022 10:04:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFEvOUCpmsLiTaEP6O0rFlN2sAASKLK4Ab7Cz2DHLCZplzG/ZyMERLb4afguPJ3HZlc7urMVi3AcrIt/YTdlRieBArA/hP/Q/Qwpyb4YhIWoArQ+gXC51AkUkT5RyZTfCkjL1kuL+YZJcXXxZc5b40wr+zAX7W5vgIfM6GH3RCCBJxvW46dn/trjqqOB7+tSQbYdlBGKzZQxqDLqks/F+uANaSnrpaO3Y2mlGWvXH73ynI7QdooLteO3bxr+v8jr667Do4k0Cmz5QyHdUUO7XljT3db5uzeu91Mhy6uLuI2sutOHCTMqth7X7NhSf9vpwQk2+K35rgryEI6FJzYkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Vwg4o9Jv3ZugA1p+UrFza9IJywOpIcwLnr/r6u09Pg=;
 b=Bq/C+8wjIoXJIL821Ar5YnlnuqX/xtTJWGc5G/q4vDkIYczj1wv7Ks1enFwuE7oPGz0RzQakU8sRZ0p1SyOMvBnpKf7Zs/utXQYe+1tV0viY9yhzZ0TNDzDJNvguTnxP2weKnEHyEWOPXVqkyn8FGqPfkynTq7F1x7R/SsV24V98o8d1w/TloqAzBCXOUGvm/TYk+9F3yk2XIn5mbTwKPtrakErObi5M0KEEe2clDxPEIMjaoZ9BVnvZ5Dgufg6EBghWzE4IfUi5mNwtETG/4uqX0SykY4ZwRhJ/yq2+KQv4YaS81NZBFP/I42BVPbbHTsJaHcDEC2NZ2EJDA9DGDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 17:04:50 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::c488:891f:57b:d5da%9]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 17:04:50 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Namhyung Kim <namhyung@kernel.org>
CC:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
Thread-Topic: [PATCH bpf-next] bpf: Add bpf_read_raw_record() helper
Thread-Index: AQHYtzPeWFYcAGzsN0Wstq4jJDfNwK29Dl6AgAAHSgCAAHG2gIACUc4AgAAB/YA=
Date:   Thu, 25 Aug 2022 17:04:50 +0000
Message-ID: <E6872BF2-8DB9-4D42-957B-E57EAE28AA65@fb.com>
References: <20220823210354.1407473-1-namhyung@kernel.org>
 <95708205-66EA-4622-A580-FD234E6CE2DA@fb.com>
 <CAM9d7cgxP6+R2BkVZfRAVvFUaJcknu8wAvKa_b1TBnTdKKiQvw@mail.gmail.com>
 <6305b7e7c7709_6d4fc20869@john.notmuch>
 <CAM9d7chYaeHvEkq2zCKeA6FiO0wfC2LCGc-1Sj=KdS8oU-2iFw@mail.gmail.com>
In-Reply-To: <CAM9d7chYaeHvEkq2zCKeA6FiO0wfC2LCGc-1Sj=KdS8oU-2iFw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 595f0084-dea1-4b3b-e988-08da86bbec3c
x-ms-traffictypediagnostic: SA1PR15MB5109:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yswPMZVOz763VonSM1hzd6OnKHXKwxqBbIL6K1uQHK6sE6v9pPSRgZji8gGr9T0jkgOBlJMeY7K2TlF1DXeWbnzE2YcIXswEStGPZk7XiSaoLjxyjj5bkZGymfxQP/oRnrQJ99YfLhxZyTGnnxrALxGfl0KAFHlS9htaaN+3g34vaGfOlLLcQhyfSIU3P2/oetCGVoXeZLoep7VjzQ/eVJbMUuhD/FBnxRwsRk4S5irukSh41MV2g6rB+BrF1vnnkZIJvFyH56/tN1zvFcxXTUDFUiVp+GWLS7fTVJhy5ZckEIaINjo92GL8EmWDfHRR8TEFXdJImGkETZRRhBpc2fxuDMlHJETZxVrrWrvE2d6ccNPHWk0dtvGRgOFlNU6sJmZIA4l19tYAX4UgL2hKVXsQm1ZpTwXaiodk4akfDPKihk1qLcDxkWBjLuOfUlpKeJZVolnnjHT+0BJqVi2Pb8+4mBwtG+bL0yj1HDL5LlnTL3jPk3jkKSCB5Y2JvVizkGSIGbF2DYl2/2m686U7YH+R09m6Y1woDiJWGFNJK3Cl55xDVCVZpTN2oMKTms6L9fUpV0A3qnDCEcNElKMrvukFwbCoI9Tos5X51qQL91c7TADl0Mi9X7ETBbaM3/lwuhW+BG9uBoEcumyEM5AvhMZ88MZdWMRHvV5D+bJYvlUYwiIgkQ0AwJC8v8cpiQUOc762TRzEya4TGuaSpK6bYuHflpdjuvJYjjEAC2P305uZWvAQAC5rfaTHnYaxsPd/x+lhqVzK/mhbwcI+jKQUhOMyKfAnxiKIXF9My832BN0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(5660300002)(66476007)(64756008)(36756003)(54906003)(2906002)(316002)(6506007)(38070700005)(2616005)(6916009)(186003)(71200400001)(66946007)(76116006)(91956017)(38100700002)(66556008)(6486002)(4326008)(66446008)(8936002)(122000001)(8676002)(53546011)(4744005)(478600001)(41300700001)(7416002)(86362001)(33656002)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Urme1epbFNOwKDtU04/HeEmntg6ApYtIWRfc0yU+LALHS/TNCxsLJGpw3orR?=
 =?us-ascii?Q?KENXCEYo4EHzlcQ/hd3vcLIkZe3dK9ocTknr23S7JxkIz9WxObHSEkp+fHGl?=
 =?us-ascii?Q?ruwUE9DZkq5+9nuupeWTDo1QWg3eZJPN3KHRLM9bzpBvilj3yWtBVDjVZUp+?=
 =?us-ascii?Q?r3QDNPjBTBfte3F/yYcq9gkV8v1QaedgL1bfObHmp+K2v6lkjqpyv9RmN5nA?=
 =?us-ascii?Q?AGH9ZZrygBAAYfLJWlEXKLAFlll/4hgI3QBtMRdlVNtTjNOxjkTx04cfxSaT?=
 =?us-ascii?Q?UaxDIYnCs+DrOb0p+gnR3dOgpTyY2iSG1OFLp9ajrne2/bUjPF7G772MfFI0?=
 =?us-ascii?Q?wyuej1f9WH5p1NQdi7xyWXwgEXaX/1yoOBvDUJ/UKc7TlwvHh3e76ql88aB2?=
 =?us-ascii?Q?ZZiuX0dBZJTHQtN91gAWGlMqimnO43tUTbTLz/A0h9E+avaWUAsyeYExsjgD?=
 =?us-ascii?Q?4s5vnDtutBcrTifBieMWvcZTVrLx86DTwpWGlRB5XXGuHOAxmlmevH3CrhDo?=
 =?us-ascii?Q?7hmNP896B9h8dp3AGCjkk7TEeRCvYJdmQimOorzI5dsTcqGopHqjzwoQXDdq?=
 =?us-ascii?Q?gs+gRES2FxNveJWJiYRPqkQNG62xffehbc/XR1ltdVdxh1rBQxHlHFWvEVSX?=
 =?us-ascii?Q?+m5XdcdnNA6kkg3Y9Ck1nn/8vNXlRFGmRLqMhOo8tV3QpvI2LfKXDmSLEgI0?=
 =?us-ascii?Q?sLCQ4GGwKJrS07EFx/YICvezhR6sKR+aklCjko4icbk295cjwVKkk+Jyp97l?=
 =?us-ascii?Q?Z4PO4mMehF6xm8kpm14NI1GiJP8K3dWN7n6oy+DcC/ynG6h/r2A62CoMoxMp?=
 =?us-ascii?Q?VTFrpPvbodRc2lf62OhvzUTf67WQsC+RYu/8TNBwZQy8xYxp8IuZiARYLDVb?=
 =?us-ascii?Q?fjJgPgurtb6V/50XCbqYI/1QroFNrYOCG5bJpDX2IYm/EUs8mwc+FO+qqPC6?=
 =?us-ascii?Q?SVsVs+pkpHNX8sL5Ozv60cJfarrR5uY2r5mfZVLYFGTuPMcJB9oGkjq7EZ4k?=
 =?us-ascii?Q?ecm4GvF+lqByXwPr373X/K92xrUYBh5gQ9AWgWASI74NtMa7MI8XBGd6TMqY?=
 =?us-ascii?Q?E1P55I++m/o9lz8ez9Zp5ZQ+Q2T/hq92ZmFAevsPeg6ZiZcG2a1cvQOh80gb?=
 =?us-ascii?Q?udKbafRn5ArQqJ0gGZ7tlNgJsRPvb2u7QIGYsYRaL5ethPxVeoVefghRRuVO?=
 =?us-ascii?Q?CItkX/9HPhFx8lIswSHMBNq9rrMQwv2rwgnQk2LTiYbsUH3MGnW64BTWvGa8?=
 =?us-ascii?Q?0i5XUvmJH5ea4SneOp8pXUL9CErfikB/rbqzIo9Ylx0Z9hSFwgDluNV1Jej2?=
 =?us-ascii?Q?/hwiLZ8sa6CfsyrpD6E0V78yNQe9F9OQCMMKi3gcl9QvxRXo0vQncYgjMHJ8?=
 =?us-ascii?Q?aL3wPk8n0/eQE6nrilpjY4ep0rcGzAJFzFACdbaA5hY7z3+/+qmC0Ocg59k0?=
 =?us-ascii?Q?7z5AzN+Cd8uGhMnJ1DBemzm1NTIX9Qei6l00vWUpt+Zbx2/g/sR9kMKb8jxw?=
 =?us-ascii?Q?Op4vVwxsvPq/2AvM+riBRBRFB3LnPPFkWhxIsv329I4hhJSuK5OqL/i6ynhq?=
 =?us-ascii?Q?I4Scaob9BUCYeUetC3NmuqbiukJ5guGKyfNvOlvGvblA+XctXfq9CrOOurhX?=
 =?us-ascii?Q?Qp4zZ3OkbgxJPSEDh+adPEE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E874DA3735D8D4AA55B2A349DD23E65@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 595f0084-dea1-4b3b-e988-08da86bbec3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2022 17:04:50.6611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IXjULnuIIiheRVSje+l/g/UaY6PDYSPzau4dt0Fcyx7mcFS0ifxiJHtDpm8Vom4dE7qGeH4mUwTSPSmGTHF0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5109
X-Proofpoint-ORIG-GUID: AorL7GvYis29l9WDObIh3tuxOPpGewLD
X-Proofpoint-GUID: AorL7GvYis29l9WDObIh3tuxOPpGewLD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-25_08,2022-08-25_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Aug 25, 2022, at 9:57 AM, Namhyung Kim <namhyung@kernel.org> wrote:
> 
> On Tue, Aug 23, 2022 at 10:32 PM John Fastabend
> <john.fastabend@gmail.com> wrote:
>> Namhyung Kim wrote:
>>> Ok, now I think that I can use a bpf-output sw event.  It would need
>>> another BPF program to write data to the event and the test program
>>> can read it from BPF using this helper. :)
>> 
>> Ah good idea. Feel free to carry my ACK to the v2 with the test.
> 
> Hmm.. it seems not to work because
> 1. bpf_output sw event doesn't have the overflow mechanism and it
>   doesn't call the bpf program.
> 2. even if I added it, it couldn't run due to the recursion protection by
>   bpf_prog_active.

How about we enable some raw record for a software event? Something not 
controlled by BPF?

If this doesn't work, a self test that only runs on some hardware is also
helpful. 

Thanks,
Song

