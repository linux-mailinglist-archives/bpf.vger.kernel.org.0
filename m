Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0007D69FCA9
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 21:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232024AbjBVUDy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 15:03:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjBVUDt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 15:03:49 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1516CA1F;
        Wed, 22 Feb 2023 12:03:47 -0800 (PST)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31MGnG5T026573;
        Wed, 22 Feb 2023 12:03:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-id :
 content-type : mime-version; s=s2048-2021-q4;
 bh=q9zmutmmeuHYxuF+N6EHUbwtvd/oCegOv0jVVWnIOcI=;
 b=G7MM5ep23FanF8cnEz+tXORJ8A5yQSBuw/yTozMjhUeX6Q/bRagJ8cZpdQFL6sMe2bep
 FyktVF4yFrOH/gAxFGng//Z1q7jqbn0SnARwyr87iFniZoUIoanf/e7TLM5Nhftdn2Jn
 rBm/vsTaIdkUaTI1BPDI2ZtcZaQI0oGVwh5nTUUFfLhp3K2+LUXfPEp6kAcrw1Qk5ABC
 KrE1PRhE0houPKANJH4zVpCMyEh6hOAory1hAvrPvPoKCPuvAB6hAw4SZo78i1nwNR+Z
 m6sjWe/08tipNAfq1mXZzb8z4UkqU4TwaObV6g1yVSufHtf4Sjgdwe/tJf98eFL/Vlb2 mQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by m0089730.ppops.net (PPS) with ESMTPS id 3nwdy9w45n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 12:03:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xx6QOwPztefT2ewRawI1iSVAw8zmj8Vrxv1deS8oL8eGL5OBYERGCULdCZ8xA7taXdIVGMSio9miFxoGVd1yhN27T2Y8Y7uAgQH4cy3dvPx/mujhea+6KVCGBdLKQhbOIPwSQxsMxhj62aBufOaGzxRWxorKIYkSnL5kuauXn4mLlvagT4lR4LlwkZarjiFnt+yG4myl5x/OMM7ARHStHjxOP1ZDwQuNFTO0GqqmA7QWgrSz9/P7+40jD2aEeKbjhbWdkgFsz7KD2b6ZkBjx9dJofMXo85ppJLMenE20VIxxMs+2zLlBRPlOc+lweJjGXscM/JLqZ6p9rkGu+cwgUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9zmutmmeuHYxuF+N6EHUbwtvd/oCegOv0jVVWnIOcI=;
 b=Jfc+/tIujEodLDGihMnELB/Rg805NKQwivp/k7Lp1+TPU/FTfuJUDMfSNtDLuk05BzgmHbH9HrecwjRmnlFNUHzKOPOM7wVjd7zJbS0tpazdsdaMz87HL65+UCJxFfhE8P6O53W0FgqM2KsghHdpX4q3Q3T1SAV+GkzYYiXjyUJ5Fj592hSuloJ9YMf473UYsT4kvXCE82q5feG6XDFHGUeLNdQY9fAcgU4QZ75Y6hZICj9HgNsqHvmVB9yAzOCgAZ5nLSuR5P1ZjWBURrtzXmOWio/7rOngVDwl8mo4XLjeIvyEKdCJg4OltO6XhYtfHPfnpdKWQ8AaLVJEWpDMnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (2603:10b6:208:3d::12)
 by PH0PR15MB4525.namprd15.prod.outlook.com (2603:10b6:510:85::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.19; Wed, 22 Feb
 2023 20:03:41 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::4bbb:c864:913d:fcd0]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::4bbb:c864:913d:fcd0%7]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 20:03:41 +0000
From:   Mykola Lysenko <mykolal@meta.com>
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
CC:     Mykola Lysenko <mykolal@meta.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Check
 __ARCH_WANT_SET_GET_RLIMIT before syscall(__NR_getrlimit)
Thread-Topic: [PATCH bpf-next 3/3] selftests/bpf: Check
 __ARCH_WANT_SET_GET_RLIMIT before syscall(__NR_getrlimit)
Thread-Index: AQHZRrSTJgL2tRTWe0K90e/fcPgSk67bQ38AgAAgkIA=
Date:   Wed, 22 Feb 2023 20:03:41 +0000
Message-ID: <D90B1D7B-8B75-4790-8D09-1106240B2377@fb.com>
References: <1677066908-15224-1-git-send-email-yangtiezhu@loongson.cn>
 <1677066908-15224-4-git-send-email-yangtiezhu@loongson.cn>
 <CAADnVQLLborN3ABxRPUhSL5jQ1XcWNM9DBfjaEbvnF9qdE_CJA@mail.gmail.com>
In-Reply-To: <CAADnVQLLborN3ABxRPUhSL5jQ1XcWNM9DBfjaEbvnF9qdE_CJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3213:EE_|PH0PR15MB4525:EE_
x-ms-office365-filtering-correlation-id: 16cfe9c8-e1dd-45fd-920f-08db150fe531
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FvBQKH3ksyPqsaHo82q0iDgbrQFgq7D8sEMwdjGmIYPi8/t/EKwLYmbNNidk2tYNNHuuhV6YwCYuH4dJ+9ANB3sbc11xA+fqyxOahpCFKrFJSaZTsuURdDp5BBtS/8b4ChcXxmJbQW3X3zK9Lbfgr+8OP+spXohz4/t/zhZvp8bI+iS0LIT3swK2X2utMhac/cwIShruQuW6rA9bOOs5TyF79C10Kbu7BLTLvYTQyb7IJ5rn0+hJ6lQLjrS8hhI+L7sORLI7zUc2ANNWS/4/q/H3WCJmEDhxpkJk3jzw7nmfRlDU4EErJA0Bg6tGMpcrD5G0u2WUE4/Uhdw6rGASCL0bYYvWDmOa9ega9ScNx8SFGF3TQcWcl7tJAZkzZI2LTHNcvryhBrnxY6a2qW6x3dmUy254V5kziR7gdB22Haklqwnx9zHVAMnsg5KzbPuWtu4Ka1e+Xb4duzaqM0xy+A6OldJ42U9R97tToVdwIdK8nbtUKTNNDGQJSNIE19oz0KAOMNAB01MEeIWmi2my4O5ye+i3uzxS+LoKlfgT97up+HddkjLY5fe7W79DtWqrMzzuiSvJkJJhGS8QmaTPrLKLU3j38KIO4YVWR9jEHGaFsoPcSNocoKINifSo0Q/FlOurC+lOnFt6ePoo7PINu5exqcMh+U8EjJJ+I4o2DnouvQDiR1OJGoPmQYtDnqIl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3213.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(451199018)(6512007)(186003)(6486002)(9686003)(966005)(53546011)(5660300002)(4326008)(76116006)(66946007)(66476007)(66446008)(6916009)(64756008)(66556008)(8676002)(36756003)(8936002)(91956017)(83380400001)(6506007)(71200400001)(478600001)(316002)(41300700001)(54906003)(38070700005)(38100700002)(86362001)(122000001)(2906002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jhweu7mSw+nk8KqEx2e+jM7KAgnnMIcSfSx6TfOoWB9cxfWgeFctH71PVZrS?=
 =?us-ascii?Q?abkv0m+yMqYpYi+sOpK8n/aX01++1Ugj5XJUMnem0nk8mblSSrCnfN8p83oN?=
 =?us-ascii?Q?5wn+SGbNR1w2efQ+42AnIXYgy2+9VSCf1pkMRDEY+qMWGxnA0gRCQ54LParN?=
 =?us-ascii?Q?quRhiQIXtV+dyU1a8MFrXKxFNX3I1BS8uCSdwD3EZqTBrdpe+NYL+JMlB/FE?=
 =?us-ascii?Q?Hs9QA1+7Sh75L7vtI4PT/iub7yECLa8SIxEQsD9utTJTpD5Nhfwz6Ot2/4H/?=
 =?us-ascii?Q?/cEXYExBfnV/EVgQuinBGJGhbzT9PKs277R6OyAF+GuvNNosJYYH5Sj5nrRG?=
 =?us-ascii?Q?6Yv2C/6KHZQDht9tazEyeioxwxeJnrQk0dxI3vuDPb7Y73r6BfpK4z/Kd0Wz?=
 =?us-ascii?Q?1NQ/mlT9wJ8wM3ZzCeO88ho3gUL93SAIUE0mOjJ5Ar/tQrpMN6PQof6Sh1X3?=
 =?us-ascii?Q?EbdTq2Kvt+AVwjkogzmb2tK5KoWLGooHAf6tuu2odzNwaiYbO495fF70W+Tf?=
 =?us-ascii?Q?stSdXAZcew/HKJlKe2JTR/wxIhdKHBu5C6lyEngjKvw5tFE45qXq3xq9EgCh?=
 =?us-ascii?Q?aw0HzPheEjlsQj9c53+MJq+/JgtqwngNHv4xqO8zhWYpmZ5dwg5+SNYXSXyf?=
 =?us-ascii?Q?qFtTd/m8jiGnr8FStTDfH3iLoxa0RCpyBSTPW4zVe3+3SgFsj1eUEIl5dWlx?=
 =?us-ascii?Q?9WrPkxRQ1GHvmI+j2Eqg5nOeFFWi2vNjGK86BITTzdL5zVLGfV1YCrRFgAkS?=
 =?us-ascii?Q?cNzqvVdZfxBUb2LQ5+7gVhFXmia2pJgsNUkGnXjuX5S6n9zYB55R36Nw39wo?=
 =?us-ascii?Q?hFD14Lqv0y+01KrR6nDj/7laoUPYR9G9MQigChSiY7YxysZkkliYM7C/Xeuy?=
 =?us-ascii?Q?9uzYph/1omjtYgYd1X9mXOg6sNznglI7n5U2a6gps1jxAuOg6QGOBMyy00oI?=
 =?us-ascii?Q?VX9yJLWQysY5smoY5m3wUXmJMt7lPIjBaVMYQ+CaE8+gEvVwAerVOAl9AWuy?=
 =?us-ascii?Q?3/D5FWmsB26KjaWE5RkigmAEIMvBGw1zFs+b9G6FkM2nxXf7INnJJOK76aUk?=
 =?us-ascii?Q?eybzG3w77gaTsIVs/uhEdTk5vujClhHY/UnGN9H9KxS9GOUioNORaCaSb55n?=
 =?us-ascii?Q?7yE21JQ2348OcLmILRTr5WgXPOWPaljnD2MlkVBDmfT+SqTdXxA92qm+rUhr?=
 =?us-ascii?Q?cYiklJpVMYjwM27KkvUwRxr9XhgQlEczftLXqo16U0ZQAdv/RK9r5LKj76iB?=
 =?us-ascii?Q?Zh3sMB4fXTw8llI+zuhZarc2AI/TdL7IoutUvM5upaF/cdOOIiHPmzHiSVJT?=
 =?us-ascii?Q?FF3Q279CjKzzzbwcnVzPCqHQvA7BIPe4Uotfjr8DPppvii++Z0yjciLVFKiM?=
 =?us-ascii?Q?uxD7wvzS1kd1FbXsZxJoCb03jgqj0R31r48hglvQNH3S7MN6ytJP323fvQ84?=
 =?us-ascii?Q?/9/fKPaUTGR65pNxcQKaJXoPvV5BDxV8EEMlLNTHJ8cdznUxiItjWlKnK+Ay?=
 =?us-ascii?Q?QFxLzPXBi7zulStSUomu3qsTmOiHfmHmi4NgHgY8TCHgN147WBjfDTkyi8h4?=
 =?us-ascii?Q?o5CLrO+u+nE4DRdxMwyVwcxFGraXYFAYYItXRawHQINIvC+cpxRSGGw6FNyL?=
 =?us-ascii?Q?J7wvR/vfo101gFLjOAv/VAE=3D?=
Content-ID: <B38601E0D90F9C418809A964C80CD820@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3213.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16cfe9c8-e1dd-45fd-920f-08db150fe531
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2023 20:03:41.6512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2VB6q/B7iIo3SQhnqBupN0s0jpix1+zChXk490mzM/oKHuTLxXFRpkHbMhLKtLbI5+yfluZYTFOsl5vIH/DYBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4525
X-Proofpoint-GUID: 692Q5OCkwN7036te_X8VDY2HP5lx87kI
X-Proofpoint-ORIG-GUID: 692Q5OCkwN7036te_X8VDY2HP5lx87kI
Content-Type: text/plain; charset="us-ascii"
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_08,2023-02-22_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Tiezhu,

You can run BPF CI tests on your patch before sending it out by following these instructions:
https://docs.kernel.org/bpf/bpf_devel_QA.html#q-how-do-i-run-bpf-ci-on-my-changes-before-sending-them-out-for-review

Thanks,
Mykola

> On Feb 22, 2023, at 10:06 AM, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
> !-------------------------------------------------------------------|
>  This Message Is From an External Sender
> 
> |-------------------------------------------------------------------!
> 
> On Wed, Feb 22, 2023 at 3:55 AM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>> 
>> __NR_getrlimit is defined only if __ARCH_WANT_SET_GET_RLIMIT is defined:
>> 
>>  #ifdef __ARCH_WANT_SET_GET_RLIMIT
>>  /* getrlimit and setrlimit are superseded with prlimit64 */
>>  #define __NR_getrlimit 163
>>  ...
>>  #endif
>> 
>> Some archs do not define __ARCH_WANT_SET_GET_RLIMIT, it should check
>> __ARCH_WANT_SET_GET_RLIMIT before syscall(__NR_getrlimit) to fix the
>> following build error:
>> 
>>    TEST-OBJ [test_progs] user_ringbuf.test.o
>>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c: In function 'kick_kernel_cb':
>>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c:593:17: error: '__NR_getrlimit' undeclared (first use in this function)
>>    593 |         syscall(__NR_getrlimit);
>>        |                 ^~~~~~~~~~~~~~
>>  tools/testing/selftests/bpf/prog_tests/user_ringbuf.c:593:17: note: each undeclared identifier is reported only once for each function it appears in
>>  make: *** [Makefile:573: tools/testing/selftests/bpf/user_ringbuf.test.o] Error 1
>>  make: Leaving directory 'tools/testing/selftests/bpf'
>> 
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>> tools/testing/selftests/bpf/prog_tests/user_ringbuf.c | 2 ++
>> 1 file changed, 2 insertions(+)
>> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>> index 3a13e10..0550307 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/user_ringbuf.c
>> @@ -590,7 +590,9 @@ static void *kick_kernel_cb(void *arg)
>>        /* Kick the kernel, causing it to drain the ring buffer and then wake
>>         * up the test thread waiting on epoll.
>>         */
>> +#ifdef __ARCH_WANT_SET_GET_RLIMIT
>>        syscall(__NR_getrlimit);
>> +#endif
> 
> This is clearly breaks user_ringbuf test on x86:
> https://github.com/kernel-patches/bpf/actions/runs/4242660318/jobs/7374845859
> 
> Please do not send patches that make selftest compile on your favorite arch.
> Make sure the patches work correctly on other archs too.

