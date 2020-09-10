Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADDD264D1F
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 20:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbgIJSeu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 14:34:50 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:32788 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726480AbgIJSea (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 14:34:30 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AIT6Wt024585;
        Thu, 10 Sep 2020 11:34:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GHkyRJduJHI3gqo4axGf85ZlTYP0eocWjSqmebdftyE=;
 b=TwFbteK3EOJt2MU9ZoUWckeLoYBN5rmBMv7KjmFcXbBCtNVY1J+THO0K56cpJAvCkKFf
 rmu//7LCPSBbN6suQrBqIEN8nwDOT5LaiQ/wU/Tm3WGwVOiAWOL1nXALc7w6J8ZLrOBR
 XcQqk0sZA0nkxllBeq3O5LLUZ3Dk9jI8d/M= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 33ctxnexk9-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Sep 2020 11:34:12 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 11:34:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dfk0cfXfLiwNZzVRpbAqUHpc5lg4NMgK/Z3i+ftC5dub8Gu7qU6IMQQGJ3rUOaVpnyER3qylosBdlGsVCtjLg4/Z3f4TTFOIo5BSIUiUeWMBMgVfJvPEdD5hhbskBxtaWKCrrHBNu8LhArSygDeph9vHX9lACofZI9BeqZ3mxfTVOYT/GdMeH7Gevqs710vs3y4BOwU6DZ3aYDNxP2kW64PJ4t1GYDR/QxN9hS5izmG1MBoOOBJ5BrA/6hnHCFErREtqGxzUdRcNSD/euqYnXWTpZ04+458Xxp/ag/lZ2fS3HJQpo+Z2uS9q9lC44qiT4DsmJd6+5REuEFtQJnkKFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHkyRJduJHI3gqo4axGf85ZlTYP0eocWjSqmebdftyE=;
 b=AYt+5d+neoqxDyEX0RRI0Va8+G2lTtxCWzUv/X1jygEmURw7Kn0/fHur6AIhdHKeLYxSrbiya2CCslWHQ+HQ0kI8iOR3x4XMqXl0cIk2SKu1fFRvY1sNFGY9SeLGmuLlnEccoiQUTXJSdeQA4La75HSUwHNrK3IKkHNQjaY1Ocq1bES9aibcX5fBe5ozVQCFmbdoW23CtFY/dkybgLaLZnKAt05b1u6sFeH7or/iHTeSnhsAzAGfm37P+NQewRWC5V4ZCT+6csHHx71yYO0V4AEwPZCn2FItxER/bJu6WCkY3qMhK3UR6Wxb2d6JZcm7yVybgATGsXsLSPN1+BwFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHkyRJduJHI3gqo4axGf85ZlTYP0eocWjSqmebdftyE=;
 b=RjmJoHMoC1Cvm2+pGqooVG4YW2syRdpW0VuMSsdLexPNzl9GU1wlGoGQpAz8S8jeWPLkOzg6U/wLW1uTE3sKRLdDPlsmudRwUFA41iDG/NqMxhPloBwFCm2z+PFFUEhaLfNzTUzInM784i7PUv5q3nF0PbgoHsPfmx0K+13p/G4=
Received: from MW3PR15MB3772.namprd15.prod.outlook.com (2603:10b6:303:4c::14)
 by MW2PR1501MB2010.namprd15.prod.outlook.com (2603:10b6:302:e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Thu, 10 Sep
 2020 18:34:01 +0000
Received: from MW3PR15MB3772.namprd15.prod.outlook.com
 ([fe80::fc81:4df1:ba69:a0dd]) by MW3PR15MB3772.namprd15.prod.outlook.com
 ([fe80::fc81:4df1:ba69:a0dd%8]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 18:34:01 +0000
Subject: Re: slow sync rcu_tasks_trace
To:     <paulmck@kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
References: <CAADnVQK_AiX+S_L_A4CQWT11XyveppBbQSQgH_qWGyzu_E8Yeg@mail.gmail.com>
 <20200909113858.GF29330@paulmck-ThinkPad-P72>
 <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
 <20200909173512.GI29330@paulmck-ThinkPad-P72>
 <20200909180418.hlivoaekhkchlidw@ast-mbp.dhcp.thefacebook.com>
 <20200909193900.GK29330@paulmck-ThinkPad-P72>
 <20200909194828.urz6islrqajifukj@ast-mbp.dhcp.thefacebook.com>
 <20200909210447.GL29330@paulmck-ThinkPad-P72>
 <20200909212212.GA21795@paulmck-ThinkPad-P72>
 <20200910052727.GA4351@paulmck-ThinkPad-P72>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <619554b2-4746-635e-22f3-7f0f09d97760@fb.com>
Date:   Thu, 10 Sep 2020 11:33:58 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <20200910052727.GA4351@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:300:ee::11) To MW3PR15MB3772.namprd15.prod.outlook.com
 (2603:10b6:303:4c::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103::16b] (2620:10d:c090:400::5:84f5) by MWHPR04CA0025.namprd04.prod.outlook.com (2603:10b6:300:ee::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 18:34:00 +0000
X-Originating-IP: [2620:10d:c090:400::5:84f5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1cd124f-0071-4fd9-b89a-08d855b81660
X-MS-TrafficTypeDiagnostic: MW2PR1501MB2010:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR1501MB2010B1D669149C23F8D0816FD7270@MW2PR1501MB2010.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xa7t2BzqdHOdtnKWiid7Slxv+kPf6lkJdJ+ZWISXGesmEueLhnDRhKQCMDKuiGq7g4uT+1fIOtR/TeSHhKS+F9T0Gm6RmZg6k32vagdkhNlCrzbQt7XhAVN21RZpxIOYZbSPC0ggsJeJ453vz46zDXDQK7MqqAwPRzXEaNNFIurhFtKUaxlXcWDDIqh36AtpH9/BHRD8TwJw3xxvT551Me69wM4BcHwvLzAmEgzQqlkpX0ICVdkDzqtAIMw4RdRNfSA0/Hl9qycMzQo9fkvi/roHwsYFYTTJCiroPEntZwOlaiTlpRly/+054A/Luglt9TL3k4VhWUdYsw5RHZwATwVDfc5GlrpMpQo3fqpVdfmJuh/ILK/zEasHTdwyWJWt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3772.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(346002)(39860400002)(396003)(376002)(8676002)(66476007)(53546011)(2616005)(16526019)(478600001)(83380400001)(54906003)(66556008)(316002)(36756003)(6486002)(2906002)(6916009)(8936002)(31696002)(31686004)(7116003)(186003)(5660300002)(86362001)(4326008)(52116002)(66946007)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 9C5uPl+0VtXd+yvDAbnDTPdjo+8KZMueIMd4S4fXFSc7ZTW8F5Bg0bxYwJAD7cdhoGAIvo5sMSUrgRCTvVvP8WFUKh9WxU0Ooxq8fM12Hhd1t9t/U+U1nutFvc57W5wfV6YoaVo1tHs+ziForEgowAE452s+xSMS+wijnjTcWK44COk2YilmmY0+6HxijZSfAQCFmMN/zkA6FF5C5MTZtgtnsM87VPvyYqhLrHbyvMukFRXpSrHH6X9lc/B0XCxJJOuxpRHy2CzOzFa/HnRh9xf14YLWdVKllWmEJSlj7xQf/RgraLBRoKs6LhpILb0ZN0XcxBIdggjPnTpo6RX/GSHVq5sMv2XVkIs7PQYeXAFXYrsv5smicf159x1y2J1HsDeMGyXqoRSpAB7DrytCHlZ3MlFW6Z7ZlEzeo68slLQyuniz5XIJZvqyuukkSN959lspE3+v//gMfZYJUoZRA3CzxOOgA1Mw5oMRvMw9RQKqeGz3GH5jIf/M2AyBKusE+4/BVPhTf4Hwr02/BexsXkoNlpXCYHtwQk4gVNKyWW2k8LCVDDMzeHQfw1qPpNGGxFwzINJRQ8ybMkq7IJwWK5PNu7RUARuWWXI0pW9/wqwJWMQ7bxCuPxZSfM4SFya9Z3H0Y9tZUpcv3rKira1PAGTU8G/Oxpic3RlZv+KSvZY=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1cd124f-0071-4fd9-b89a-08d855b81660
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3772.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 18:34:01.4628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GR2B6q2LPOTMzl5fSKGoJbfchiUtWBXhk8gtCC57dtBqGWBePFBskNyWXh2bb1zR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2010
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_08:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100170
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/9/20 10:27 PM, Paul E. McKenney wrote:
> On Wed, Sep 09, 2020 at 02:22:12PM -0700, Paul E. McKenney wrote:
>> On Wed, Sep 09, 2020 at 02:04:47PM -0700, Paul E. McKenney wrote:
>>> On Wed, Sep 09, 2020 at 12:48:28PM -0700, Alexei Starovoitov wrote:
>>>> On Wed, Sep 09, 2020 at 12:39:00PM -0700, Paul E. McKenney wrote:
> 
> [ . . . ]
> 
>>>>> My plan is to try the following:
>>>>>
>>>>> 1.	Parameterize the backoff sequence so that RCU Tasks Trace
>>>>> 	uses faster rechecking than does RCU Tasks.  Experiment as
>>>>> 	needed to arrive at a good backoff value.
>>>>>
>>>>> 2.	If the tasks-list scan turns out to be a tighter bottleneck
>>>>> 	than the backoff waits, look into parallelizing this scan.
>>>>> 	(This seems unlikely, but the fact remains that RCU Tasks
>>>>> 	Trace must do a bit more work per task than RCU Tasks.)
>>>>>
>>>>> 3.	If these two approaches, still don't get the update-side
>>>>> 	latency where it needs to be, improvise.
>>>>>
>>>>> The exact path into mainline will of course depend on how far down this
>>>>> list I must go, but first to get a solution.
>>>>
>>>> I think there is a case of 4. Nothing is inside rcu_trace critical section.
>>>> I would expect single ipi would confirm that.
>>>
>>> Unless the task moves, yes.  So a single IPI should suffice in the
>>> common case.
>>
>> And what I am doing now is checking code paths.
> 
> And the following diff from a set of three patches gets my average
> RCU Tasks Trace grace-period latencies down to about 20 milliseconds,
> almost a 50x improvement from earlier today.
> 
> These are still quite rough and not yet suited for production use, but
> I will be testing.  If that goes well, I hope to send a more polished
> set of patches by end of day tomorrow, Pacific Time.  But if you get a
> chance to test them, I would value any feedback that you might have.
> 
> These patches do not require hand-tuning, they instead adjust the
> behavior according to CONFIG_TASKS_TRACE_RCU_READ_MB, which in turn
> adjusts according to CONFIG_PREEMPT_RT.  So you should get the desired
> latency reductions "out of the box", again, without tuning.

Great. Confirming improvement :)

time ./test_progs -t trampoline_count
#101 trampoline_count:OK
Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

real	0m2.897s
user	0m0.128s
sys	0m1.527s

This is without CONFIG_TASKS_TRACE_RCU_READ_MB, of course.
