Return-Path: <bpf+bounces-1455-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 627C3716B8E
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 19:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16AC9281202
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 17:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C06027737;
	Tue, 30 May 2023 17:49:13 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C09827201
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 17:49:13 +0000 (UTC)
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCCE106
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 10:49:09 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UGYAcD031236;
	Tue, 30 May 2023 10:48:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=9iccsTA6mdIBPCZ9nIKfFlFeESUxB/POfmvCQTgcVeI=;
 b=S3UrAiORRLNS/KrOhS0vv/bd4snUE2ErWU3rd6R9fp44gTdc2FMJimkNgXeZic5w1DzA
 YC4xf+m7HE0Gws265BLBgjD0yrfOC3oWlmSP2Bdbs5viYs1j4Yx4GVvtpoNg1oUpvenw
 Ublb0hCOx2sqgZBc7tjVf+4Or79seLzkIJ8isF83wQrnrX/wfh5sJDr+6JZA7pfq6ZUR
 zcOMqsZaH6cwkwwhfSZWrhdJhVqiokaHLi97Ies5eRh0Hs1Bt7E+bIDZoFxtvwBIVyKF
 Fl/lV6ahaHXHVgVWm2P9tW9VarI23fZWitVxq/n5LAGB5JHASSbloDhDRK7RrM0lLzt7 yw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3qwb4x4fd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 May 2023 10:48:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvbrYqm7cpkmxCBWFX3EZoFZeoCUhlwb3bcFtafHHUgRjJFcDhdqBQKd+sXkg1S9rEYiMLJGYqdzo0fTgn9MPfGx0VYSJvVoTmGmah8e/hlzHX5jwWE/Xw0HwACYHYe+hArS2nwn9HBIUKoCZCm8t7rRs9bCPXafJOxVa1jrVL8yaL+qwTgyy+fGOe9+8xbshO5UB+hfd5pzFpUbOzqXr3Y90FpWQZ8cyilQ3fg9dl4gXiR9hao65NrhXPPr5jeCgwAYKRl2jJe2Da0n4NNcuwIU/bgmWF0lKHtD0pDkARcBxPrprzAfmTM3u5dPOfWvvUtvH34tEGq3lVd6hJLj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9iccsTA6mdIBPCZ9nIKfFlFeESUxB/POfmvCQTgcVeI=;
 b=SCCSVpVN29I3cCAVjV04eO3oNjD7B1Kls1MwDC1KFZqO+H+IbviwMTPnunB0SuXX4HOo6jEbhi+uRgAKsOoYpmadNCUV6ofTold6GrCXh4r+huPx9JMlmNV+J5tRAFfv2avEcs1/BqiPRo4TJZHgLlnbRJAwuyrMq1IFdW/wEctcvhltpWW0NTytgBr2it32ADt305dDKvGaOjYB+uR98xhmzzNXxMmoEquQ7pbl7cgsDEcpveonYpZqUjxqfsjbi5yIU4l7LDQxnhM3d+lBaeyY0Yy8q8NHx5MMuIfKRZ6FWnQhvK/fkCCePHfsb0I0wy1U90W68JqJJ+c3mEZiIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by IA1PR15MB5981.namprd15.prod.outlook.com (2603:10b6:208:44d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Tue, 30 May
 2023 17:48:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::bf7d:a453:b8d9:cf0%6]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 17:48:53 +0000
Message-ID: <f47eecae-a120-e079-b6a9-807c7480bb7b@meta.com>
Date: Tue, 30 May 2023 10:48:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add a test where map
 key_type_id with decl_tag type
Content-Language: en-US
To: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230527223132.1580338-1-yhs@fb.com>
 <20230527223137.1580717-1-yhs@fb.com>
 <607940d5dd7515f65d24cd631e3946f50c573645.camel@gmail.com>
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <607940d5dd7515f65d24cd631e3946f50c573645.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0369.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|IA1PR15MB5981:EE_
X-MS-Office365-Filtering-Correlation-Id: bcda38dd-5c2b-454f-8fc9-08db613621f0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	aAy5Y1iDqA8hHD1gDFf8IEFgPHLNBEDhvNkZApIXuHrQgfRNxKI3bXbZX2iDln0Qq8xOWZSU1LMHn9kJWUbrFfcpBKLTfRZwHOuiNAgcUo4d9Jh6CWje8283DRsaoAPyUR8Tg14g5rgTqdTZkJT1vSfH4bywjw7kQ1Ktwc91EKS36JQughyD7ysuV/k9g8rwY7YmijeEdM0b6MLbQOt3BAoXJgE8cGxpO6cUCFbfX0Q+/LUUr58XPsUDz4OExRZmzWtwUgc0U7CdOiLyE23pImNESK/Cezkly6P4XJcdFX+zmbrKZ9aJ72+PuMNfWHcBaO1JRFLRvsbigKGj9F+dH6DCJXNBCa6XxgJTOGBN60ngtrF06QITYGnVhin0ahSLXyhLAliwUaPst6vA3oiaXEjWipNYi5ZkL9oCPWT77kCrzqKSL1X6XPkMTakm/iwhe40ALBNf2d4HsS7C2ZeviIE7n173dv/R8GI8PFvmXXL4fl4M1zED83JtNJIHIPgz2XkB4mWKe23o83EQBPQql9hf7vY2xOVN+zEZWtlnFi0LkJoVFGG1gky9hunglHHNUB/UAHdv9SVg2TJcJEZd16/rIzvIPMiaMawxYlzrBhmqAQPvYrpOhi8jliPhfo3E3yHZQjb4vvqzecuUI3zX3g==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(366004)(39860400002)(451199021)(478600001)(83380400001)(5660300002)(186003)(4326008)(86362001)(8676002)(6486002)(8936002)(2906002)(316002)(41300700001)(31686004)(38100700002)(31696002)(6512007)(6506007)(66946007)(2616005)(54906003)(110136005)(66476007)(66556008)(53546011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OHpjT3VTZUlzd0tBTHJtSGJFMkxROXI5RjkzMTRmbXZFem5tOXQwb01Ob0Yr?=
 =?utf-8?B?ZU1aTS9sbmdyU2xIRlJkVjdZdDBPSmF0bTV2WStoeFhoa2EyNGdnR2JOTEEv?=
 =?utf-8?B?V1hGUDNjam84WHpVMU5mZDk4eWRIQ0pLSzdwbC94K3Z2Qm1oMmxIckxyb3lQ?=
 =?utf-8?B?YXFPMmRzMllQZjRKQkNMQW5vMEh5VFJDb29yNWtzaS9JMHRCL3RMZ2E1cmtv?=
 =?utf-8?B?Yi90N1dCWjJ3M3pyR0VNcnlPTjlOa1VzNXI3QWlWOGtkUlk2MTlLQkk0MUJ1?=
 =?utf-8?B?R1pPVXVPR2NuNzNJMWYxOHA2Y3B3MWpGeEgwa09QK0lLRTVOUHVnZFhDTkZx?=
 =?utf-8?B?WExVMk9BN0I4eWttSkZjL1lCMzlSbHA5MFEyemtSNUpBQWVlSnd5WXMwSDZs?=
 =?utf-8?B?cW5PK0hCelM2aU0wbEpnRWdzeE5xc0ZWU3FiaWxYRFR6UXBkN3crRndmM2xQ?=
 =?utf-8?B?eWpodjg1ZWZIeEhMU094RVQ4dFRXZVVSV1ExMVhWVmZlWkZUVXFTTEE0aStn?=
 =?utf-8?B?dTBSMyszTzNqQUlOTG5qNE9mTkVQdkIzKzlUWjQzZUlwMnh3S01hNUxLQngy?=
 =?utf-8?B?RWJ5S3N0RHZHb1JJSFRmVDIrVjdoUWtwQmErZ2M4TTVBZ1RYQjFSTS9ERXhq?=
 =?utf-8?B?YTh6U054Z0NxT3duYW1IMCt4VDdoNVMzUngxV0FKQUpuZUpYRnZnSGJXM2F2?=
 =?utf-8?B?MUUwdmJHb09pQmRGZEdUdTl4RVQvNG1YRnhuOXkrVks2bU1FY0pEa2dVeDcr?=
 =?utf-8?B?dGtXeXdmcXc4L1Z0WUJSMS9rTEpOVlVGWjJ5RTVoVVZMc29TZ0x6ZjdLeWQy?=
 =?utf-8?B?NC9oSzcrWUpCUVRnK1R0aHNsbHI0MGo3WjJsM1ArcDk5VkNxNStJUjNjb2Vx?=
 =?utf-8?B?MW1SKzFjZzVOUytZWFlxbGVMQ3hqUzhHZmtHSkZLc2xMRTBvaWFvYUJEaE5n?=
 =?utf-8?B?b1U2dnBXSFZmRWx1RE41bVI2dXFid0VjRzBoS0N2Yjc4MzFsOXhHbHZrcWY3?=
 =?utf-8?B?cEJCTTlRbHVVUkxsQVZNc25hNDBhRXZxc1l4bFRpb1Y5ME5INUtndU00cW5W?=
 =?utf-8?B?QTRLM0cybGJvelh4Z2NWWkRneHNmQmtEZFduSk8ycDBLRy9kK1NuRFY0VjQx?=
 =?utf-8?B?NFdSc3hidExvOGtqV2ZBUGZFRmEvM3JXQVZJVWZkb3dIajgxRjErUjZ6UHFX?=
 =?utf-8?B?ZmJ5VTVUaXhQZkhnUHNYa1o2WVFYd0M2REtoR3FtcjlUaXBxSFljSTFqUCtX?=
 =?utf-8?B?c1FaNVBPRzhxeU9lQlZvZy81MSszTWdSZTRsTkVrSkZUZ2g1b0ozVHc3L3pW?=
 =?utf-8?B?LzEwOHR1LzFQa2FNRCtLVmFvTGpObTF4bm5mTWgzTUp0aldVL1FDMEluTVgr?=
 =?utf-8?B?OFdZd0NtalRxQjFuZTdldWRZZ1BXSllkVHpXY0RTYW5HQXc4UUxHQmJ3MnFL?=
 =?utf-8?B?SVJrelBYek8vR2daQ2JUZHc5K0NCMmczRXI3WDYzN1ZsRHZTbnNlNW80cnVV?=
 =?utf-8?B?TTBoZEhpUFRSdlpZREsrcmtBWjk3eHZEcDdPcUVDaTFjU0FVRUZxZUFLM1F4?=
 =?utf-8?B?NmMvam02Nyt5VjJsQWIxa2ltR2l5MWlvZW5nOHNLQTV1R2ZwQXk3MEZEaS9L?=
 =?utf-8?B?VGV3a2FudnFLbXNPZ2pvYXd4ZTVyb1F3MWV0ckU3S2pVMTY0MTZub2NYWmpp?=
 =?utf-8?B?Mkl5Z2s3Ym5lTHR6OG9PQUFuQUgrU2E4d1VmT3hrUVVkbEh5enpzY25lV01Z?=
 =?utf-8?B?US9Kb3VtVTFCOEkrYUc3TUJ5Q28vZzFPdkhFL2ZQdUpNQWNGbHBsaDlDdzFj?=
 =?utf-8?B?Z2pVTnp0S2NvR0lVTzlYKzJkTVpsa29MVFB0SUhFVndMbDhXUzNiSk9NTk44?=
 =?utf-8?B?Wk5aNGphdnBSZmFjSlpLUXdRdEpGMFpMeEdzT0wva3poczV4b1loeklyS2tQ?=
 =?utf-8?B?b1JOK1JGNjNVakwyZTZhdFBwR1d3bFYwYS9XRmpsWlkza1gzeWpZa25ldUpK?=
 =?utf-8?B?OHNhL0o2eWk1b3hWWkd5MElpY1BGTmRUVjN1T0p6SFB2NWdsOGFvRGNIRWZv?=
 =?utf-8?B?UVI1Y2hzQ2kzV3lYRXRwYXV6ZGRWelhpTk5QbUh0YmJ5N1FEZm1YeWVKWDkv?=
 =?utf-8?B?SEtudW5EN1FHcjdzVDhkS09oQ0hMenlWbjRCQnFyeVZSSjNOczg5T1A2VVlL?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcda38dd-5c2b-454f-8fc9-08db613621f0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 17:48:53.0668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ToZUMnlxjFl0cV+SNyhtEw4s6kLalhJ4PS+CBthYzExXhFk9RmlnyOxGglu0MNDp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR15MB5981
X-Proofpoint-GUID: xpAdQeIHSpYWAc0WriOQ6JE7JqD14Hez
X-Proofpoint-ORIG-GUID: xpAdQeIHSpYWAc0WriOQ6JE7JqD14Hez
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_13,2023-05-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/29/23 8:17 AM, Eduard Zingerman wrote:
> On Sat, 2023-05-27 at 15:31 -0700, Yonghong Song wrote:
>> Add a selftest where map creation key type_id is a decl_tag
>> pointing to a struct. Without previous patch, a kernel warning will
>> appear similar to the one in the previous patch. With the previous
>> patch, the kernel warning is silenced.
> 
> Looks good to me with a nitpick:
> commit message says "map creation key type_id is a decl_tag",
> but test case uses ".key_type_id = 1" which is INT
> and ".value_type_id = 3" which is DECL_TAG.
> 
> syscall.c:map_check_btf.c applies the same check both for key and value,
> maybe make two tests?

Sounds good. Will fix the commit message and add one more test so both
key and value are covered.

> 
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/btf.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
>> index 210d643fda6c..69521e1dc330 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
>> @@ -3990,6 +3990,26 @@ static struct btf_raw_test raw_tests[] = {
>>   	.btf_load_err = true,
>>   	.err_str = "Invalid arg#1",
>>   },
>> +{
>> +	.descr = "decl_tag test #18, struct member, decl_tag as the value type",
>> +	.raw_types = {
>> +		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
>> +		BTF_STRUCT_ENC(0, 2, 8),			/* [2] */
>> +		BTF_MEMBER_ENC(NAME_TBD, 1, 0),
>> +		BTF_MEMBER_ENC(NAME_TBD, 1, 32),
>> +		BTF_DECL_TAG_ENC(NAME_TBD, 2, -1),		/* [3] */
>> +		BTF_END_RAW,
>> +	},
>> +	BTF_STR_SEC("\0m1\0m2\0tag"),
>> +	.map_type = BPF_MAP_TYPE_ARRAY,
>> +	.map_name = "tag_type_check_btf",
>> +	.key_size = sizeof(int),
>> +	.value_size = 8,
>> +	.key_type_id = 1,
>> +	.value_type_id = 3,
>> +	.max_entries = 1,
>> +	.map_create_err = true,
>> +},
>>   {
>>   	.descr = "type_tag test #1",
>>   	.raw_types = {
> 

