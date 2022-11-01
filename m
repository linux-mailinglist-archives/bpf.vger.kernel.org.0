Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9328614E76
	for <lists+bpf@lfdr.de>; Tue,  1 Nov 2022 16:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiKAPhI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Nov 2022 11:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbiKAPhH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Nov 2022 11:37:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1239818B35
        for <bpf@vger.kernel.org>; Tue,  1 Nov 2022 08:37:07 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A1D9iBc030983
        for <bpf@vger.kernel.org>; Tue, 1 Nov 2022 08:37:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : mime-version; s=s2048-2021-q4;
 bh=LLuYyT3nM1YT/yf+lyhZODNi4WSfazCLcCAdjh3xuWA=;
 b=GE7f3tVSoJHdDqS01RQZkP4OoJPYNclJVXwZ1onsRwGbe8Ei/8HizCc3W1jLROqAxc2s
 1yxdO7x5WR8xtHGpt1p3fV9QGWUuig4sBGT774sm66zHOI0KGraNFXXm5PIddR9Okyhk
 FzVeMdwME30k0kxtYWPP6u6A1wm1Roxy2rpes6jbZvQo0YEWOb45kyyB6+PyFRorDdM6
 7+HUUMWiwPORu0pC2GS6+AzT4QKabibnj81ozl6ByBMYvq/psb2CO3QyybGfZlva5jXO
 sbMrovAg4Epo7s8zQKoY4lxbOwFZh7bFdy0RHrTS62hpJTR+rZHhpcL2hUaCol2DhJtX 3g== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2173.outbound.protection.outlook.com [104.47.73.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kjn3fg83j-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Tue, 01 Nov 2022 08:37:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVc/j2ufGUzzPV/tQ19xMVY+gGQ1/b5QV/Zajp4MciPEE7+AvKoEuJ1LIrWvENVidGX/oNLY+UjiK88kRpw/CrdZGsex0z/cz4JUrL7gop5ulNOTZxHxLFqv+V5HL8ff3ss8quWRGWD56ym8ZIvcf9TDUNXHU+W2xEmpXuhdrHodmcSdKRwkNcvLJXshIAGGoPG5y0bWOnnAH6sAlJZQZx20P+hSpSxTzObyezqKplhCThe00nL9RSIUxoWI7R9KOyT1q7rKjBcDC1lTY5UrND52H7lQ2eYybxXRPJQB9NDsg6AyNL5vtZ7SWEOg8SbI9aOIAHvcoGBusJxp3oz4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LLuYyT3nM1YT/yf+lyhZODNi4WSfazCLcCAdjh3xuWA=;
 b=jwj+Ezymn2rcxEMbFs7v3csqPgeUUzEheh5SRJQoAK90tfE4NvjNhj2kFeRHzJfqIjHFpgJgpL1vNEyIRiv4C6YCB5koyLhcSgpBIGqgYgV6DVr80uLxcmvdRhKyRnZPFB/25vXTVgagO0DQpQvZZ4W2TPmbjxQnDv0FTZmwHNvOddX26aTs6kiPj6mcIJhOOAO+dtKCYCrbjBA25QgNL6PJ71CmLTRJTa47CG/VkfvL9V+1hIG7YQFsw/WLUKMZr/3aHrUu3cQAIvCtKYPvXVt3qBAN1ap/u0Tj7VxuBMltintDcprJb5tBNsORePBzcUBS48qgxpZZSNTcDavnaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB3213.namprd15.prod.outlook.com (2603:10b6:208:3d::12)
 by BN6PR15MB1908.namprd15.prod.outlook.com (2603:10b6:405:4f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 15:37:00 +0000
Received: from MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::939f:e752:d037:b8fe]) by MN2PR15MB3213.namprd15.prod.outlook.com
 ([fe80::939f:e752:d037:b8fe%7]) with mapi id 15.20.5769.021; Tue, 1 Nov 2022
 15:37:00 +0000
From:   Mykola Lysenko <mykolal@meta.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
CC:     Mykola Lysenko <mykolal@meta.com>,
        Mykola Lysenko <mykolal@meta.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        Martin Lau <kafai@meta.com>, Kernel Team <Kernel-team@fb.com>
Subject: Re: [PATCH bpf-next] selftests: fix test group SKIPPED result
Thread-Topic: [PATCH bpf-next] selftests: fix test group SKIPPED result
Thread-Index: AQHY6vaGM1jKXWJApUmeK34cLDMAa64kcuqAgAS8pICAAPVzgIAAFKIA
Date:   Tue, 1 Nov 2022 15:37:00 +0000
Message-ID: <4523359B-B8E2-4DC3-9209-CD789E772906@fb.com>
References: <20221028175530.1413351-1-cerasuolodomenico@gmail.com>
 <635c64abe004c_b1ba20850@john.notmuch>
 <DC4AB44C-734B-46BC-A9E2-9A24C56F7F9A@fb.com>
 <7cedf721-0438-ba98-1e9a-7a07985d88b1@iogearbox.net>
In-Reply-To: <7cedf721-0438-ba98-1e9a-7a07985d88b1@iogearbox.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR15MB3213:EE_|BN6PR15MB1908:EE_
x-ms-office365-filtering-correlation-id: acedd5a5-7bd1-447b-b8da-08dabc1eeb2f
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xve8MJcOVAlUHZ5r/AbUrlgLI+u2mMpDmfaPDbXhE3HmyT3fsDdRBpa+j/fMFZA8q1orZSvqiElR6VYmyUvo6s4VAZ/wtdqINhUPucJuhYq6I1pef2R6wGtw2fXyf9UrIga+zWLkMW/5AOlF+HQ3tD1GWMMzp7stI+goY0AMmG6sKD+t9Q9GksxtekWf2uMsh/eY20L0JP/GkHjTblM7kpnJreSTksmHgV/ou+p8qBu1QpHTqKRVtIRucU9SkoJbMLjlfEGLgd2dgq1yPEYJ0VUV8sCwZw9F74UBFgMTmbXdFEaqVtkJ1349QDkdiBp2Xsh0kpgTG1JwnnsBNAs6djrLghxWfDOF5ecvPxiUQ828YfOvuAqkufJmOUqX678Z5eBvHogWwEjtoHLtl1e1wU+TmV9DMhLZP1l5/WpTvzF22sSxAk/mLKA3Tk0aRNy3EhqcxSsQqMm4060/SVY9bfodqJCKaFdf+b/E/Hpz387BASRZbPyg7gQ2I9vvLVxjEjxkxqbnjZBC1qpnB3LZs99CHyH1UHMQwh+ng0LRRdQJreXUKgTl9lqvDZzniBYxMEStRFOt25ORJn9pLlJP5MjyrL+6aJNmQq0EFYc2DzkIuI+CbNx/nWsTgEWDUbrXGd0W4QhCsnAFA/x6Ohi63+UqYh0YQPAhHrPXHwOIaQuPju3AykCbMHcZ20X3BmpT4HCEQStIiWiDLDopwyJLBKzdeMjkcfDHymm79O/UEFZGeFtpGgw4iat5O0PQLOkOaK+d7L3pSSUicLPzOtArGrLkyvVn/z4uimQ5KZllHeI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB3213.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199015)(36756003)(478600001)(8936002)(33656002)(5660300002)(316002)(71200400001)(38070700005)(83380400001)(76116006)(66946007)(66446008)(64756008)(66476007)(8676002)(91956017)(4326008)(66556008)(54906003)(41300700001)(6916009)(6486002)(2906002)(9686003)(6512007)(186003)(122000001)(86362001)(6506007)(38100700002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QzW5t3ytn4D5tIIAvsY9JDgSJJQ3HpWK8M2nN5lwWWSPzdZP/riQ9WfBxz2Q?=
 =?us-ascii?Q?rfIW1s2ii2C58YXQ4RfFj7D4ixKfttHHhv3q9ZPvj9b3jaGtByl33vEUSc1n?=
 =?us-ascii?Q?FNgAMWmQzFBjWfEaC1VNLOgM04tx3T3SRQea9aGi1KyIeE/AYgM+NioBs3Cu?=
 =?us-ascii?Q?Puz+9jS2Ry6x8Pa/mUXxjpzgiY7AH0UK/ancJzw3xjmcex7iQAC2eraeiJIa?=
 =?us-ascii?Q?jZZ0Za/r6t5UczUlkpuUtLwWj9JFOnYv8wcMJNK9JcBtibNd4Jube3s0J9w2?=
 =?us-ascii?Q?42Yo6JZOvC9LYeyeeXWgi58TcbDNrsrx/S31BCekBv6WKHHnjpY14mm9+qXN?=
 =?us-ascii?Q?QFa3eQyyvbDtawWCVy3vN79Z04mct4v3ECBH0lSjOSQynVo8GuU4jqQGvShW?=
 =?us-ascii?Q?RRAFVzceLiFv8FfwFT9bXGneXNcd9h5Vodbwvzt9QDuRd/aa6YFg06Akdx/S?=
 =?us-ascii?Q?bnKykqPWx4GK2KgkI4Fv2VVCezhuwi9HBWLEFgbk4FLla1hTBrVGQadsRCk0?=
 =?us-ascii?Q?E40laHaPiasetqaeNqUlgwLnMvqeCFcHEIbRZ3lVrt602a7DaVuejy3vvkve?=
 =?us-ascii?Q?tNp/aypUN1c46bVuha8IiknXgOgrx1SgLmBXJBQmtPM1W/7v18QV1IJAydJq?=
 =?us-ascii?Q?yIsRyCEbOauqaJPsk1LItRjUfq3r3JPpkNB9HZmITUcb+1MpZCf1YUZNHmMv?=
 =?us-ascii?Q?zsctU2UzG1QjPZ6LY93NePSb7MNGA1VKE8cxeLafZ1YwWzPz7CBdJvST1PaK?=
 =?us-ascii?Q?Hjew4VU9uPHKBAB2CC2i1a5DYVwimaRtIdBNxPBorVmSu7Rk1ZPB4s3lv3Uc?=
 =?us-ascii?Q?4kXA43ga0FbaNcAkoSuP2LoRoWT4A0V/NDC4fBVWODmx0b/tk9pzUNO3e13X?=
 =?us-ascii?Q?mJ3cebSsVutBPDS3+nI1+rVhXBDesCoGQdeMmY7nQKPu6ClClvtNbaulXEAi?=
 =?us-ascii?Q?jviDXYEwzannJwLxMy1mKkJL+X83kb3nbdcr7Pqeh6tkKpKUfJjNCulVEMWI?=
 =?us-ascii?Q?CKSB9+V/ZkRderqJWHA/AWij+RrMy0o1w7PV1UNFzyc+vMT1/4wkFeMJyMtH?=
 =?us-ascii?Q?BzrL88vMKVxo1zAAopRO3BybaX8gamY50AD0gU1L7m0g6lxx5J3kVaY67xLY?=
 =?us-ascii?Q?vJuIK+R6crrgthzVtLokWjUeU0U3N48V5yCRZa0uKLPuvflqTd/sCGndoEs4?=
 =?us-ascii?Q?UCEmTzLajy8NwDmfq0+Ty8gDnwaZd2zDxBAtZBSSU2O6MiC7I6OERa3Cmegy?=
 =?us-ascii?Q?OX5uh1+wDpchg7WYNbkQAwS2JLH3D0HCHmuexU2zdk2AS0D06DN4Y/zHEJfH?=
 =?us-ascii?Q?RTWiRpBTtICKSu++xZAg81zP76fq8CmwhIkQQRtqDyxU+6Y2foe8451XqiWo?=
 =?us-ascii?Q?cJ+UeOoR6BZdhL6j9bC6H5I5ZkDSF6A6JJB4TQg/BvCFIR4YuxwxeeO5Dz9t?=
 =?us-ascii?Q?sI3bk5Nq0ikCrm4e4GHZPpBITL9wyVEQtwdHmP2ov8jqPgUW30XidfjvlNMW?=
 =?us-ascii?Q?w5+OPpYm2quXi8vwQzxq+Mdost/0vutJ8BPsSsYpEG2mo/a9GMSr6pE1g/UX?=
 =?us-ascii?Q?KQEU/8edk5hvlDriL/mfpd4uWRPXnEAxemJ3qrXFH3EFXkI6WyxY4smhYQGJ?=
 =?us-ascii?Q?2ak65E72X84VvAfP0NhCx4lkcZnhZzyv9Oy9woTqj/DG?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4AB2FAB1C4449943B84AD69CC08C3150@namprd15.prod.outlook.com>
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB3213.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acedd5a5-7bd1-447b-b8da-08dabc1eeb2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2022 15:37:00.6848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wonakR9JzW4NO5AZiDUY+MEvt7ksyNDEPClbbxhEflFc9upyrShQLbaTthIyLwqLXaI2UKBKWT7GM/QjigQfsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1908
X-Proofpoint-ORIG-GUID: r_IIqC77acx61vKNeoqOwD9x-hiCFHWr
X-Proofpoint-GUID: r_IIqC77acx61vKNeoqOwD9x-hiCFHWr
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-01_07,2022-11-01_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



> On Nov 1, 2022, at 7:23 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> 
> Hi Mykola, hi Domenico,

Thanks for the feedback Daniel! It makes sense and we will look at addressing it.

> 
> On 11/1/22 12:44 AM, Mykola Lysenko wrote:
>> Hi John,
>> Test FAILs when there is an unexpected condition during test/subtest execution, developer does not control it. Hence we propagate FAIL subtest result to be the test result, test_progs result and consequently CI result.
>> On the other hand, SKIP state is fully controlled by us. E.g. we decide when particular subtest/test should be skipped. We do not propagate SKIP state to the test_progs result. test_progs result can either be OK or FAIL. Also, SKIPPED subtest is not an indication of a problem in a test. Hence, I do not think one SKIPPED subtest should mark the whole test as SKIPPED.
>> For example, core_reloc_btfgen has 77 subtests (https://github.com/kernel-patches/bpf/actions/runs/3349035937/jobs/5548924891#step:6:4895). Some of them are skipped right now. However, most of them are passing. It is a normal state. For me, marking core_reloc_btfgen as SKIP would mean that something is not right with the whole test. Also, I do not think we are reviewing SKIP tests / subtests right now. Maybe we should. But this would be orthogonal discussion to this patch.
> 
> I think parts of the above should probably be incorporated into the below
> commit description to better explain the rationale for the change.
> 
>>> On Oct 28, 2022, at 4:24 PM, John Fastabend <john.fastabend@gmail.com> wrote:
>>> 
>>> Domenico Cerasuolo wrote:
>>>> From: Domenico Cerasuolo <dceras@meta.com>
>>>> 
>>>> When showing the result of a test group, if one
>>>> of the subtests was skipped, while still having
>>>> passing subtets, the group result was marked as
> 
> nit: subtets
> 
>>>> SKIPPED.
>>>> 
>>>> #223/1   usdt/basic:SKIP
>>>> #223/2   usdt/multispec:OK
>>>> #223     usdt:SKIP
>>>> 
>>>> With this change only if all of the subtests
>>>> were skipped the group test is marked as SKIPPED.
>>>> 
>>>> #223/1   usdt/basic:SKIP
>>>> #223/2   usdt/multispec:OK
>>>> #223     usdt:OK
>>> 
>>> I'm not sure don't you want to know that some of the tests
>>> were skipped? With this change its not knowable from output
>>> if everything passed or one passed.
>>> 
>>> I would prefer the behavior: If anything fails return
>>> FAIL, else if anything is skipped SKIP and if _everything_
>>> passes mark it OK.
>>> 
>>> My preference is to drop this change.
> 
> I guess for manual testing you could just grep for usdt and see all subtest
> results. I think changing from SKIP to OK is fine, but could we indicate e.g.
> "usdt:OK (SKIP:1/2)" to differ from "usdt:OK" where nothing had to be skipped?
> Presumably this would address John's concern, too.
> 
>>>> Signed-off-by: Domenico Cerasuolo <dceras@meta.com>
>>>> ---
>>>> tools/testing/selftests/bpf/test_progs.c | 11 +++++++++--
>>>> 1 file changed, 9 insertions(+), 2 deletions(-)
>>>> 
>>>> diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
>>>> index 0e9a47f97890..14b70393018b 100644
>>>> --- a/tools/testing/selftests/bpf/test_progs.c
>>>> +++ b/tools/testing/selftests/bpf/test_progs.c
>>>> @@ -222,6 +222,11 @@ static char *test_result(bool failed, bool skipped)
>>>> 	return failed ? "FAIL" : (skipped ? "SKIP" : "OK");
>>>> }
>>>> 
>>>> +static char *test_group_result(int tests_count, bool failed, int skipped)
>>>> +{
>>>> +	return failed ? "FAIL" : (skipped == tests_count ? "SKIP" : "OK");
>>>> +}
>>>> +
>>>> static void print_test_log(char *log_buf, size_t log_cnt)
>>>> {
>>>> 	log_buf[log_cnt] = '\0';
>>>> @@ -308,7 +313,8 @@ static void dump_test_log(const struct prog_test_def *test,
>>>> 	}
>>>> 
>>>> 	print_test_name(test->test_num, test->test_name,
>>>> -			test_result(test_failed, test_state->skip_cnt));
>>>> +			test_group_result(test_state->subtest_num,
>>>> +				test_failed, test_state->skip_cnt));
>>>> }
>>>> 
>>>> static void stdio_restore(void);
>>>> @@ -1071,7 +1077,8 @@ static void run_one_test(int test_num)
>>>> 
>>>> 	if (verbose() && env.worker_id == -1)
>>>> 		print_test_name(test_num + 1, test->test_name,
>>>> -				test_result(state->error_cnt, state->skip_cnt));
>>>> +				test_group_result(state->subtest_num,
>>>> +					state->error_cnt, state->skip_cnt));
>>>> 
>>>> 	reset_affinity();
>>>> 	restore_netns();
>>>> -- 
>>>> 2.30.2

