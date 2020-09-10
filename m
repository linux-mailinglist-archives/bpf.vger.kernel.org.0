Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80B61264E3B
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 21:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgIJTHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 15:07:06 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:29096 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727010AbgIJTFB (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 15:05:01 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AJ4cOE006271;
        Thu, 10 Sep 2020 12:04:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=RNBvxfp+471MdIY6vN0/KCr685VoAzWS02/3lGRJivQ=;
 b=j/TAtx9D4Wbs3zgCqoWB+kqqva1TF5jV0twAYZmVwnuXVVVHdELlDL5MjrkrQRvtLT5b
 8Fv15kYARh6A/1pFGc8xsWf4RS2QrZDi8lsiXrYNzjyfoLQUEF5ML6DW1iLmu7cL65H3
 Qy8zyrqZurbTo96MtJSXtYCaJfUreXwVFE8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33fhxuaqvm-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Sep 2020 12:04:43 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 12:04:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAzkkFkNrWXGx3mgi3igb5ZWWzi74en8+feRs20t3qbXX/VFSVINC3rahHEvPR5HTVGYUnu1V993N9dtcUrUHmZZvo8V5qCRWPgKMw0JIOnu0QKbVI9Xk5oS7AhWdNOR8W1EA8gSN1/ppYYgicZpGZv+aaNTUPiLIxKLKYCtp7gOwp8SOJ3cBSzLW4NuNxjB3nD/IT1XXokFQIh8PTXiSHyY/ES5B5s4Ug4k7Nk3zo1h/yq7wI1X+JxO7wFWmNGAKZM+okgg3YIVWpUc1snZQQkWo6GTtWIx3ifJb3XBZzXtSCY3GEwi1NNgJB3bRJ1Kz2ssNVGml4nsCi/vaYhG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNBvxfp+471MdIY6vN0/KCr685VoAzWS02/3lGRJivQ=;
 b=lcod4qQ+XXprOZE8GoQvYqx+iUhZQHpNueiNmyawRNWYpobw8WYnznDRZ6H3rJvTOQjSXqREyteSL2A9MKigEfHUKh9gwH63+OMNeRO5dPKBZjowA0i0WBz9NfBbDN2cpQyttUhUgs7rvJxmsBHm9Lo/oh9OaoHmTUvtyz/fqzpUeAAsWp9Am+o+GYSMr5W/XjBBHNWORxk3pqgKRPzkd7DhbltiVVBKuqLIyfD3QyXWKTofw+zKCNq3nrMAgh6PVTixzRSADKXX1I4PMcfzoWIoOXGLadm670Z9RdDljTPYl6iWZBhI/TCYNgIVxt4WsyEA7XAxTT/dZmzqz5X+1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNBvxfp+471MdIY6vN0/KCr685VoAzWS02/3lGRJivQ=;
 b=TUy5Bv9Zynfmz/x3V8tMJfc0xxOCxe+FUxmSM1PGu//FITbTcBnryc2RtUOEuQzKX7OICrQarVsHlJtKmV0ms43tkIcX0Wn8R01/yTjPWLhor6kcVVj12PxE07gPXmTcn4KC3wImcz3ILKSnSaMm+p6iJcVAtSKjXtBSwmt/Pfg=
Received: from MW3PR15MB3772.namprd15.prod.outlook.com (2603:10b6:303:4c::14)
 by MW2PR1501MB2153.namprd15.prod.outlook.com (2603:10b6:302:c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Thu, 10 Sep
 2020 19:04:34 +0000
Received: from MW3PR15MB3772.namprd15.prod.outlook.com
 ([fe80::fc81:4df1:ba69:a0dd]) by MW3PR15MB3772.namprd15.prod.outlook.com
 ([fe80::fc81:4df1:ba69:a0dd%8]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 19:04:34 +0000
Subject: Re: slow sync rcu_tasks_trace
To:     <paulmck@kernel.org>
CC:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>
References: <20200909113858.GF29330@paulmck-ThinkPad-P72>
 <20200909171228.dw7ra5mkmvqrvptp@ast-mbp.dhcp.thefacebook.com>
 <20200909173512.GI29330@paulmck-ThinkPad-P72>
 <20200909180418.hlivoaekhkchlidw@ast-mbp.dhcp.thefacebook.com>
 <20200909193900.GK29330@paulmck-ThinkPad-P72>
 <20200909194828.urz6islrqajifukj@ast-mbp.dhcp.thefacebook.com>
 <20200909210447.GL29330@paulmck-ThinkPad-P72>
 <20200909212212.GA21795@paulmck-ThinkPad-P72>
 <20200910052727.GA4351@paulmck-ThinkPad-P72>
 <619554b2-4746-635e-22f3-7f0f09d97760@fb.com>
 <20200910185149.GR29330@paulmck-ThinkPad-P72>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <e6d7e0c9-1ca0-ec28-c306-b3c474e83daf@fb.com>
Date:   Thu, 10 Sep 2020 12:04:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <20200910185149.GR29330@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1201CA0015.namprd12.prod.outlook.com
 (2603:10b6:301:4a::25) To MW3PR15MB3772.namprd15.prod.outlook.com
 (2603:10b6:303:4c::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103::16b] (2620:10d:c090:400::5:84f5) by MWHPR1201CA0015.namprd12.prod.outlook.com (2603:10b6:301:4a::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 19:04:33 +0000
X-Originating-IP: [2620:10d:c090:400::5:84f5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2da73347-793f-4298-a559-08d855bc5b33
X-MS-TrafficTypeDiagnostic: MW2PR1501MB2153:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR1501MB215386BDC291B8740A89DB73D7270@MW2PR1501MB2153.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIZGCerung3bTk8L/WL8vjNiSfnysVqELs++pTgziR0+ftPJQ72acIxK66V0mi/Br7YUSG5ku+FZG2u/1/5tsik6m85Q2GyMf9dA8jQZZhyaXqfHEI/yh4sA6cNjVAqTLXkiUgmN7DF0Ontlj7W4HXG3b+052XazUP8V/gZODYrpEW6grz1KNdU4ViWfqt3AaBfVcHk/nvYlREviciUyW10DSVMLEKryYU6H87Z0R9rFtbGC3qNaAqHkoTPbQwU8blxCZ48F4gG6NlgJLjnsouv+niyc563Nh94E9W6yTBD6SwwzONRe7GiPtxHOMunL7g2oEB/K/3LbP8oiOB8df7nI8RbXG+Sle9GwkG0zeWeFluSstH+Qs7EKO9GbCkKW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR15MB3772.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39860400002)(346002)(366004)(136003)(4326008)(16526019)(53546011)(8936002)(66476007)(2616005)(186003)(86362001)(52116002)(8676002)(31686004)(66946007)(83380400001)(478600001)(66556008)(31696002)(5660300002)(7116003)(36756003)(6486002)(6916009)(316002)(54906003)(2906002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: 2zGkNWPb2pJMsVXjQkGY/2fB7MpUi7akYYK3Ud1yT4e8fF01rh/PVnqnsGCoDH0N2q0O5T2mniKcHIadA6RjMq767pdSqdUEIalD0Dpj6JwvYMsIE9U/cZ459RoXGnIvxS1sQAMDe5MwY32NhwcU/ZDa0eA9TdKzu5UqrP99XP/XZYr/4BIxlTHJd7xjZlOz/89UeX3yQiY+In2ctjSqO19UJ7xbSM7wFRFTL1Lp78xeB3l40pH2tQ+BLZRw8noPKD4stVPt4OZI0bP2lS0YnJItWp/zygiz2+PAHLix8KhvL6h1qlRIoRcDedk73IVUtpwKt+g15T9wE9LO4Dv8MwZib7O0hzwKYi/0M4930Gmq2lZwxb5XEkrdnRMJ7XHJ+b2mPdDQC0hEgq+cyXop7Gqx7aoEacdTihf+AkbNbuFcdmTBXIn3B1mMLElsIvKDGnIL+rgav5JL3UpyoZZZyoPQOH+yiP/EycAN2EJ86FkbODamDEAjlqj/rPN2yceTOCTRe4Ypwl4CkKP7xlh6JytSz/k1+t82rFNg9nzbOw+PtvKhMJ36flOt7PGgg4bvATLTWcMXwJHzurENM6YU76EmwCOS5M1U1fk9rUn32ekfxHMj9UGgwLSACJThEXaI4gaMsfxMs8j/hEPo9xvFGLkvg1L13GogffU8AewtHVZXfa7BDRupxlLh7pEF1c1o
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da73347-793f-4298-a559-08d855bc5b33
X-MS-Exchange-CrossTenant-AuthSource: MW3PR15MB3772.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 19:04:34.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QSpyUUlTyD0GQMIikwnxA9qzBHZBU4k4DkG6+IhrsrOJfEMlIft6AV/M02i8uRUI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2153
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_08:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=3 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=995 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100174
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/10/20 11:51 AM, Paul E. McKenney wrote:
> On Thu, Sep 10, 2020 at 11:33:58AM -0700, Alexei Starovoitov wrote:
>> On 9/9/20 10:27 PM, Paul E. McKenney wrote:
>>> On Wed, Sep 09, 2020 at 02:22:12PM -0700, Paul E. McKenney wrote:
>>>> On Wed, Sep 09, 2020 at 02:04:47PM -0700, Paul E. McKenney wrote:
>>>>> On Wed, Sep 09, 2020 at 12:48:28PM -0700, Alexei Starovoitov wrote:
>>>>>> On Wed, Sep 09, 2020 at 12:39:00PM -0700, Paul E. McKenney wrote:
>>>
>>> [ . . . ]
>>>
>>>>>>> My plan is to try the following:
>>>>>>>
>>>>>>> 1.	Parameterize the backoff sequence so that RCU Tasks Trace
>>>>>>> 	uses faster rechecking than does RCU Tasks.  Experiment as
>>>>>>> 	needed to arrive at a good backoff value.
>>>>>>>
>>>>>>> 2.	If the tasks-list scan turns out to be a tighter bottleneck
>>>>>>> 	than the backoff waits, look into parallelizing this scan.
>>>>>>> 	(This seems unlikely, but the fact remains that RCU Tasks
>>>>>>> 	Trace must do a bit more work per task than RCU Tasks.)
>>>>>>>
>>>>>>> 3.	If these two approaches, still don't get the update-side
>>>>>>> 	latency where it needs to be, improvise.
>>>>>>>
>>>>>>> The exact path into mainline will of course depend on how far down this
>>>>>>> list I must go, but first to get a solution.
>>>>>>
>>>>>> I think there is a case of 4. Nothing is inside rcu_trace critical section.
>>>>>> I would expect single ipi would confirm that.
>>>>>
>>>>> Unless the task moves, yes.  So a single IPI should suffice in the
>>>>> common case.
>>>>
>>>> And what I am doing now is checking code paths.
>>>
>>> And the following diff from a set of three patches gets my average
>>> RCU Tasks Trace grace-period latencies down to about 20 milliseconds,
>>> almost a 50x improvement from earlier today.
>>>
>>> These are still quite rough and not yet suited for production use, but
>>> I will be testing.  If that goes well, I hope to send a more polished
>>> set of patches by end of day tomorrow, Pacific Time.  But if you get a
>>> chance to test them, I would value any feedback that you might have.
>>>
>>> These patches do not require hand-tuning, they instead adjust the
>>> behavior according to CONFIG_TASKS_TRACE_RCU_READ_MB, which in turn
>>> adjusts according to CONFIG_PREEMPT_RT.  So you should get the desired
>>> latency reductions "out of the box", again, without tuning.
>>
>> Great. Confirming improvement :)
>>
>> time ./test_progs -t trampoline_count
>> #101 trampoline_count:OK
>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
>>
>> real	0m2.897s
>> user	0m0.128s
>> sys	0m1.527s
>>
>> This is without CONFIG_TASKS_TRACE_RCU_READ_MB, of course.
> 
> Good to hear, thank you!
> 
> or is more required?  I can tweak to get more.  There is never a free
> lunch, though, and in this case the downside of further tweaking would
> be greater CPU overhead.  Alternatively, I could just as easily tweak
> it to be slower, thereby reducing the CPU overhead.
> 
> If I don't hear otherwise, I will assume that the current settings
> work fine.

Now it looks like that sync rcu_tasks_trace is not slower than 
rcu_tasks, so if it would only makes sense to accelerate both at the 
same time.
I think for now it's good.

> Of course, if people start removing thousands of BPF programs at one go,
> I suspect that it will be necessary to provide a bulk-removal operation,
> similar to some of the bulk-configuration-change operations provided by
> networking.  The idea is to have a single RCU Tasks Trace grace period
> cover all of the thousands of BPF removal operations.

bulk api won't really work for user space.
There is no good way to coordinate attaching different progs (or the 
same prog) to many different places.
