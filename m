Return-Path: <bpf+bounces-5209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1B4758A2A
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 343032817F8
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4202617D0;
	Wed, 19 Jul 2023 00:40:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199717CB
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:40:48 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71CFE139
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:40:47 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36IIvKnv014489;
	Tue, 18 Jul 2023 17:40:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Q0VtiNRo/kafkwsHX/Njx1bD9++QkhjdQhio7Ia4CuM=;
 b=mutWpSHmIihiy2xQNYHjEsGJTdMmTlFbzhhiE0+11wEdu9DIWTeezCz1OotfaJ6yMc9b
 PAixLVKUjDog7dbP4/5l+C+9/n+8igMrNG0b/Wxqxn+BPVYcKsFivryytTcf8rnYPWtf
 sFN9QXthKItG6TUaaSG/kXj8Qii5WKI+jjUxnS/pDbphV+NkWXwO3aIbjdmBCUPeTbEy
 s3fTV9gSFw1Z65bMurQiqXR/+cYICV+y11amuvdrmwoxqgDO/f1fUrqIjoA2JUQd3JlP
 sbhYnNaq+kRfPA4BZlWMOYcXIaneaVfNnB0a8QjCDbxpDDrfyfnwkRHOuUnJlbekR65u eA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2172.outbound.protection.outlook.com [104.47.73.172])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rwq2eyfnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Jul 2023 17:40:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZKQNDm8IiOJvVrqGd/pmHqV0RYvmoME9KkbJLg9iilLMpPRuWjHjBFdnA0fjmAMeSGfSim5NXOFkefoiolJ85ET/1eCXcOt0wZh3Gs/ze7Xlnr3TyEjvrMMrujZr3glD/OPIKfj3dNo7zA39Z30xvNQTVkuaZBPe9ojwe5mujAQVPILJqXQrsdMZzvbABktRGgxXTlW8993vtxicae3uO4PjcST+CtpDOKUDuwAu1THjokLW4l75ZioOhQs9ELnuu2cM+ebEl1wHSPcO0vBS6QrJwv+bWp89ogeQYTH/EUdzsAPEoIcWcUdRAWrc4SxBq1eG44/IjyztHNXsc44Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0VtiNRo/kafkwsHX/Njx1bD9++QkhjdQhio7Ia4CuM=;
 b=E/ktQPpt5HepP6gk2Bvi0YP0NfvZmzNVpwbjFoM+UEcJnZsjVPXyU9Rqz8Iv9EnCO7hFZpgsJmcYa4Ho9NUgOMYg9bV8pM1Ui/aU+BtzR/kNYe+dJCiJ0GUuU/Rkuzn+kBFuvRUhT00gHc3Ggaxwdvgb52XCEDi36Xc7yWnkRqD/pWkHqaCptjcTNWhAvDBHcspFTL7I91ka/NhTIHjpsRYcZv1Z4RFg5fbRGRoeMRYkdKVa/P8AtAiebEENe0NEEC9OhiMNDD3O04ebbKnEV0qrvsPKQXhRXmohz9h8KEiSX4kdFDOpv21Hx8e1UxpbJ9rAhym1qnpix2dkQIiaNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4411.namprd15.prod.outlook.com (2603:10b6:303:100::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 00:40:29 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5b9d:9c90:8ac5:6785%6]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 00:40:28 +0000
Message-ID: <94c3d585-7868-5660-70f6-9b90c0b77216@meta.com>
Date: Tue, 18 Jul 2023 17:40:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 02/15] bpf: Fix sign-extension ctx member
 accesses
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com
References: <20230713060718.388258-1-yhs@fb.com>
 <20230713060729.390027-1-yhs@fb.com>
 <a3fe0382a39a5ac462d071b5c6ca3415ade16939.camel@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <a3fe0382a39a5ac462d071b5c6ca3415ade16939.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 328c305a-4b0a-4e94-b1dc-08db87f0bfef
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HQ4YKCvLugt+50uH04B5EvgFpLu5XDD96OxYW7bfcHdZ4LQaf7fScJE0b0R429umEpsywsgJWnuM/QmI/KPlGoE7IL0AkS9Hn4OQz94I5bVVLCu4JtttQ32F6P3dI2a+7ZVBDG3PHQuk1Jzd3X6ppKNmhZCAT7zqzGp0T0mveZ47FtsCAs2Va8oBNF6aZrMhyUihv4Llkr5c8fQ9EjjOd5fIyhFybn8pcR+3UQkmKKbgSjiLp+J/8J45JMVfs0/O47HC0vGAFnFzN1zT6mknvtntp1Ehmhv/olfQxLxB0ArMFs5VxYUfNxhYUwetin8WYmbWW487qCe6nkhIE9l3sJVpDpj8fPIpcMbypkFQDc/8WtCwe7c7motnIs+bKxPzavqumkhx8B8g+bCLjswj+5+BkA9wf7fpE3AqoEmknW/lDZ2i11FIL4+ZR1d6hMqJ8hK32OdOKCdr12NIZbbf2TX50aIP4zOXiA9/6cT7foLNokxuI27NTYOaYzNwNv0tI7dYsZzWD6YGos3r6cEx5T3j/NfSck+ax8TWdHs0jfqdqFStXAkVD0kDIPGyRs5iSDJ4+CF0VCY3BJ5mfLu9fk4JOwlg2hM4xGTVrUN86Y/c+Mmc0+ULaKT0WQM6sykrCOLCczusgxZ1wFfzf12TDQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199021)(41300700001)(6512007)(8676002)(66476007)(2906002)(66946007)(8936002)(66556008)(6486002)(6666004)(54906003)(86362001)(31686004)(4326008)(316002)(36756003)(5660300002)(2616005)(53546011)(38100700002)(83380400001)(186003)(31696002)(6506007)(110136005)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?c0JBeXJia05vbUxrQ0U5d2ZpSVN0b1hNTVFNUTRFUVNjNkI2K2FoaVlBTzdQ?=
 =?utf-8?B?ZmV5enlubmkwMkt1eEh4U1RKUzV2ZzM0NDN6d0pGK1psdUpQVTNuQ28rVUQy?=
 =?utf-8?B?SkVCRTRqbWJzbWxUb0x4eVhiL1VMYU8rMnhlcUl2SnlmT00yM3hLTFdXbkVF?=
 =?utf-8?B?VG9LdXN4ZThYZlRGM1JFMUd3WkJtZTlmUzJqL0N0Ri8zZVNHYXB5eGxJcExC?=
 =?utf-8?B?Rzk3eHhVUWt0Zm95cEZGYk1POUxWZk5lZ05DY1FHZk1uZE1IdldFQW5kUTdZ?=
 =?utf-8?B?SzdBWlJERkU1OEZPeFJQVTlmTEpMeENOMVE0YU1pc2NjZUlHemV2QkhwUk9r?=
 =?utf-8?B?OHdja0J1U3k5bGVIQ2w0MDJFVDRrNUVKbWJTcVkwWis0RTRNMkpoRnlneXln?=
 =?utf-8?B?SW9FMjRjOWw4bVE1VmNWcjJrNUpLOEMvREdMRkFxcnYvcWpyb2FPc0VNYjdE?=
 =?utf-8?B?ckNYbFZpV3NrQTZuNkRpR3RYZ2xPeE9UYXo3TjBROE43a0d6K3RFT2JGdk4z?=
 =?utf-8?B?bDFVTFdYb3FwRFgyUzVjclorZjFxQ0hKaVJwUlVtaU5TZmdrRlhqY3AyRFpu?=
 =?utf-8?B?K2RpRVpMMzR6S1BqRWh2YlRidW1HN3pTcHU2NmlpeXAwclM0ajNUYVRDNUln?=
 =?utf-8?B?dHJWNFpBTXhPWnVZN20wMSt6TEM3WFMrQURobE1WVUhXVmNwMjlUMzFBbWxH?=
 =?utf-8?B?a2ZnQ1dIVHQ4MCs4QUp3NXBEWmt1MDFLczZCTUcxUi9NUzBlTm5HRVZWbnF4?=
 =?utf-8?B?cFN2bXpZb080cGY3MUx5VG1TUXVVTlkyYjlTWGJCV2UrR0pWWld3dlh1dmh4?=
 =?utf-8?B?NkdnTG9IMjRtVmJwNGlVSjM3RmU1UXY4M0ZUd0FnajNKZ2NhdlY5S25nRGp2?=
 =?utf-8?B?eFhNejJFZ0l2WTh4aGxQZmxKYlNDTnFQL0FwSkpsVGN3MWpYeGNISU9Wemtw?=
 =?utf-8?B?RlBENVVRVURKc0o5NlNYejN1RFN2NTRYNjNmNlpLT3A5Q2ZjWWRFMzBmRS9K?=
 =?utf-8?B?Ulo0clgvc0ZzRlJpV3k4ZXBOVmIzR2hRSTdiMU9oa0t3dXBEK25kaFEzKzdX?=
 =?utf-8?B?TkJtaGNSZkk4QS9jblNZaUNlSjlSRVB6QzJlOTRSV09VKzFRenRHYkdvNU1J?=
 =?utf-8?B?QkpZODhsaXFBaW1lalFoakVwUGdyZ3E3S2RlSzN6OGhDTHVibFYrNjRNVkhu?=
 =?utf-8?B?Z0F3YldzYm5WT0lTRHowbVBvTVdFcmhtU0VqWWxZekNTWUwyekRzZUY0WXkw?=
 =?utf-8?B?a09yTDhNTHdvWG5YR2Yvc1hYRm11dzlRMEVRQU9LTStkR3o1Y2I5Wis1QnZC?=
 =?utf-8?B?ZTRlMHc4VlB6cHlISkxIY2szMEdyV25Fd2pVRU83S2pheXIySTJVd0J3SXYv?=
 =?utf-8?B?M1IrUVJZMU9UVDJIUU55L05weHpQL2tjZnl5aFBXeTI1czhtaUNFNjdrU3FL?=
 =?utf-8?B?ZktTc2pGUTd4VXo4RERyRUtaTTlQWmlLcWRMeGpuN3RobElMWTdxY2pRVW93?=
 =?utf-8?B?RTRIWmoyREdJZHB1bGNqMHhOaFJtNnp4ZWJqNDFMVTZJMUMxaHdjbUdpWVR6?=
 =?utf-8?B?enNZcVJFWUt2WEc2MlpacXFIMm5jRitFK0U3bXhDejNXb0ZWVndwT3NOOUd6?=
 =?utf-8?B?NlBvYTFaZUZCSFQwdldaL1dPREI4aFBnTlFDSnRsZUNqdGJleUYwVGkxV2VO?=
 =?utf-8?B?ODlQSkJXdnlqZllZeXhmQ3NVNlVqRzg5R2kxSk40ZGU2d3JFelpIa01lYjB6?=
 =?utf-8?B?Z2xUelBreHAySUliWkdvd2NmTEsyZmxBZmxhOFJlZ2dpcU1sMlRXcjY1S2lM?=
 =?utf-8?B?K3ovUkxHdmE0dEl5MVJocjQ5amVYbzJDMjVRcUdwSHRJMmhsODFmaHFKcXFx?=
 =?utf-8?B?TjRFOExGRHlUbkUvZGVUcTFObEZEdDc3TSs4NDkyUkNMQlR4QmliQXlKMU5K?=
 =?utf-8?B?bzR1amtWMkt5MmlIQjg5LzIvL1VZdXQzM1lic1RzV0VCeCtjY1dvQnBUR0RT?=
 =?utf-8?B?UEV4RXpkTVN4dm1UeUVrSVFpU2Zlck91emM5aDhpWGlHb2ZZK0R3QjJHbEF3?=
 =?utf-8?B?SHNtMHZPTjk1QXRkTG54NGtEdmZpUWxIdS8xNmZmRWk5b2Fqem9sTGhFcllX?=
 =?utf-8?B?RUlReGZ4UlZBRXRVSXFnUnoyelFsSDB1TWhKdkYxTG01MFFuOVNQYStSWDZC?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 328c305a-4b0a-4e94-b1dc-08db87f0bfef
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 00:40:28.7082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OlZruu5IyEfXa1SjZq6BQfRG3mAvtxYlyfqI3eoyiGrcyMpZn6gl0hZgMeWeFi8N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4411
X-Proofpoint-GUID: c9bnG5WkowD6aBYEB8ZEpfct-3iPHrWs
X-Proofpoint-ORIG-GUID: c9bnG5WkowD6aBYEB8ZEpfct-3iPHrWs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-18_19,2023-07-18_01,2023-05-22_02
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/16/23 6:40 PM, Eduard Zingerman wrote:
> On Wed, 2023-07-12 at 23:07 -0700, Yonghong Song wrote:
>>> In uapi bpf.h, there are two ctx structures which contain
>>> signed members. Without cpu v4, such signed members will
>>> be loaded with unsigned load and the compiler will generate
>>> proper left and right shifts to get the proper final value.
>>>
>>> With sign-extension load, however, left/right shifts are gone,
>>> we need to ensure these signed members are properly handled,
>>> with signed loads or other means. The following are list of
>>> signed ctx members and how they are handled.
> 
> This is not a generic approach, in theory any field could
> be cast as a signed integer. Do we want to support this?
> If so, then it should be handled in convert_ctx_access()
> by generating additional sign extension instructions.

Good point. I will make change in verifier.c which is more
generic and cover more cases.

> 
>>>
>>> (1).
>>>    struct bpf_sock {
>>>       ...
>>>       __s32 rx_queue_mapping;
>>>    }
>>>
>>> The corresponding kernel fields are
>>>    struct sock_common {
>>>       ...
>>>       unsigned short          skc_rx_queue_mapping;
>>>       ...
>>>    }
>>>
>>> Current ctx rewriter uses unsigned load for the kernel field
>>> which is correct and does not need further handling.
>>>
>>> (2).
>>>    struct bpf_sockopt {
>>>       ...
>>>       __s32   level;
>>>       __s32   optname;
>>>       __s32   optlen;
>>>       __s32   retval;
>>>    }
>>> The level/optname/optlen are from struct bpf_sockopt_kern
>>>    struct bpf_sockopt_kern {
>>>       ...
>>>       s32             level;
>>>       s32             optname;
>>>       s32             optlen;
>>>       ...
>>>    }
>>> and the 'retval' is from struct bpf_cg_run_ctx
>>>    struct bpf_cg_run_ctx {
>>>       ...
>>>       int retval;
>>>    }
>>> Current the above four fields are loaded with unsigned load.
>>> Let us modify the read macro for bpf_sockopt which use
>>> the same signedness for the original insn.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   kernel/bpf/cgroup.c | 14 ++++++++------
>>>   1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
>>> index 5b2741aa0d9b..29e3606ff6f4 100644
>>> --- a/kernel/bpf/cgroup.c
>>> +++ b/kernel/bpf/cgroup.c
>>> @@ -2397,9 +2397,10 @@ static bool cg_sockopt_is_valid_access(int off, int size,
>>>   }
>>>   
>>>   #define CG_SOCKOPT_READ_FIELD(F)					\
>>> -	BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F),	\
>>> +	BPF_RAW_INSN((BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F) |	\
>>> +		      BPF_MODE(si->code) | BPF_CLASS(si->code)),	\
>>>   		    si->dst_reg, si->src_reg,				\
>>> -		    offsetof(struct bpf_sockopt_kern, F))
>>> +		    offsetof(struct bpf_sockopt_kern, F), si->imm)
>>>   
>>>   #define CG_SOCKOPT_WRITE_FIELD(F)					\
>>>   	BPF_RAW_INSN((BPF_FIELD_SIZEOF(struct bpf_sockopt_kern, F) |	\
>>> @@ -2456,7 +2457,7 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
>>>   			*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct task_struct, bpf_ctx),
>>>   					      treg, treg,
>>>   					      offsetof(struct task_struct, bpf_ctx));
>>> -			*insn++ = BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_MEM |
>>> +			*insn++ = BPF_RAW_INSN(BPF_CLASS(si->code) | BPF_MODE(si->code) |
>>>   					       BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, retval),
>>>   					       treg, si->src_reg,
>>>   					       offsetof(struct bpf_cg_run_ctx, retval),
>>> @@ -2470,9 +2471,10 @@ static u32 cg_sockopt_convert_ctx_access(enum bpf_access_type type,
>>>   			*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct task_struct, bpf_ctx),
>>>   					      si->dst_reg, si->dst_reg,
>>>   					      offsetof(struct task_struct, bpf_ctx));
>>> -			*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, retval),
>>> -					      si->dst_reg, si->dst_reg,
>>> -					      offsetof(struct bpf_cg_run_ctx, retval));
>>> +			*insn++ = BPF_RAW_INSN((BPF_FIELD_SIZEOF(struct bpf_cg_run_ctx, retval) |
>>> +						BPF_MODE(si->code) | BPF_CLASS(si->code)),
>>> +					       si->dst_reg, si->dst_reg,
>>> +					       offsetof(struct bpf_cg_run_ctx, retval), si->imm);
>>>   		}
>>>   		break;
>>>   	case offsetof(struct bpf_sockopt, optval):
> 

