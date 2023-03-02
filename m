Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB306A8D25
	for <lists+bpf@lfdr.de>; Fri,  3 Mar 2023 00:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjCBXmm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Mar 2023 18:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCBXmk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Mar 2023 18:42:40 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8B458B43
        for <bpf@vger.kernel.org>; Thu,  2 Mar 2023 15:42:38 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 322N7Q9m026184;
        Thu, 2 Mar 2023 15:42:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=quhOM9/HZ12HQhtXsphhcPufFOrWIDUJKQNi99k1LZg=;
 b=n3yJf44h18ZbJaLYRY0TemiH9z2Vb5Jp1EZrJ/KyWl03o7RXnx9Na/U4q2f5Lt0n6QGQ
 zff75Fe23FlW6yoIZpY5we7cZgrJXWmxN9pqytZGljmKNn4vA1IE/xQ0gLSrbspiPos/
 zPudIs/XzjxTD6/5iLG/AVEx8H0wgf9ooN5313f9oNV84qFgI3oSPlmWAkYy89grOVdZ
 TLLSTHK//xiHnXgucqKRKp2ETbtfoyvN8L1pu76P3hO/fCQd7eptz98re8EwuXiQESP/
 yXcqCeF3Q8tsV1ZZRWS8ZOkoJaIdTWRrhph/3VSpys4gNtTksQZIgqP2TrEcnmgmqHbL Bw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3p33d08vfx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Mar 2023 15:42:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCYrmAsKqrjMd1wrr6BVA7C00xrzTc7YtTbDK9S1y9SNnVdZq94YlGZDLo2qlSF9a1U3h5aJEPsjCWFZ2sco0gkLrdZr63IpcIGhEAuWR4OBxCjZxLpMnQhU4DlErRnwvqBxI9blWvK+4xNqDgzgkV8+OuMVP7Dr+ULmSchyPGroCTUV6iadiMG3L/BY7Sq4PjhVCGb4G2fs7uFDO3QOi082zXvuP2+3iSBCGVHOQA9cT3XSpG860+Jua/zJ1YTvqh8IKGWETo0ly+CkdatgaqbDHjVjOv9F9Y9PK9UU4VdRreWEz6jYwP3PO5az5NYPmrZ8Fqb7G+CA/6FKItEdMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=quhOM9/HZ12HQhtXsphhcPufFOrWIDUJKQNi99k1LZg=;
 b=PRHFa8lWUNIdH0LWk1+rVeZD25XIsaKZ1LHGxH9sp/x8KC68SQFkq/VLLTraVMt/wvfkie2wBu88wmZGfXY5aUXOZ1nvUziZK2I0I/3vHyaJ+Fnkizzp8G/80w4/xXskus48lCqbhuVI8bhJvCirFVD2foKzoy5PNduv3r+Vcn16LGxpWZBA+OW4Klqa9LvhC+X4sHiayWZgZGmZYRlBcdJg3vvirEAmYq2fUHg4ziykIDrM51F0/sUj9pQEn6drui2ueyYo5qqG8S3FcOyxYMykuRKiQTWsAeOQvg0s1Vxy7hshzVByheK9wcIsGBLe82tiSe/fi1WGDCc0RknlqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by MN0PR15MB5347.namprd15.prod.outlook.com (2603:10b6:208:372::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Thu, 2 Mar
 2023 23:41:58 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::1fd5:ff0e:d3d2:eb81]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::1fd5:ff0e:d3d2:eb81%8]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 23:41:58 +0000
Message-ID: <1e35323c-0383-4d5a-0027-83b9e7d1e57b@meta.com>
Date:   Thu, 2 Mar 2023 18:41:55 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH bpf-next] selftests/bpf: Add -Wuninitialized flag to bpf
 prog flags
Content-Language: en-US
To:     David Vernet <void@manifault.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20230302231924.344383-1-davemarchevsky@fb.com>
 <CAADnVQJV_yQ23EeFuuHC+AvoxgVLVKZvaYkWfzhk=z3kxWHmHA@mail.gmail.com>
 <ZAExU+aiCmOt2Flp@maniforge>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <ZAExU+aiCmOt2Flp@maniforge>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0026.namprd15.prod.outlook.com
 (2603:10b6:207:17::39) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|MN0PR15MB5347:EE_
X-MS-Office365-Filtering-Correlation-Id: 686dd43a-51d6-4926-cfc3-08db1b77b67a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mQJv7OG0qWLBGNdaMYuwSQZeF0G+bEFGnVsQUkZpD+1Yb/iw3RbkjdbjYrw8+I9AtfmDBix0QLhJdq5PXQ2xfKQrTT1Eu5DNGEYSccYtX2bZkGXLaeNPC8DWUYXSOF6Qum8SzqC46cZAJniuOZkr5awJFJJFvY/SXe0hIanF2S0uSxgDiovNPn6Ix6YZ1q6TGqiQ1EXbSRgaQhJHvn0qyGhek1jJVs0zJQ5hj1ICY8VcxkSoAZhIIwC/is+/1Tey/yu/+7gorEgx4THuArF6EOdN3ZG2vSANHD9WCurC2Fmc8KVWOmQPoiT9ve3SXt23EBf66HXA5MzoP6v+N1APhrj8Ttr5kmcSC/MAjisiJCsmqQ1sxIX31SDCzdXBAobONwTzuZ6Do9XYXgei3CNxznfejkB+5lRPw4JOXcvnulyE7QEPNc85WS1X6OFZ3G7O2KUyzPd5qQDU4W+lzKq/ZqmCRr+qRT/g9sfuHhCPQbmSpo/CFkT1eN07BQjAS6H4V2afADcK3QUYh14lzQA8fCWB8QnEpHdS1WTG1YrDgxHDF/lQVu955u8kITXPtz4KHTbsDtrINlUcbqc/VaNaceUvRtNy43hsse2UfUYDmL3/9O4Ug45J7lvx+83aptwfLe26fO+KnQs5//ubJzW+8eRLv3I73vHu2+IjPuTktmrOiN81RoLtkacFglD0SvzdBULtYOUGgFdYcdCzox0dElPBxW+mWB6RsFkvaS+vfh0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199018)(86362001)(31696002)(6512007)(36756003)(8676002)(186003)(4326008)(53546011)(66476007)(66556008)(66946007)(41300700001)(8936002)(54906003)(2616005)(6486002)(110136005)(316002)(478600001)(6666004)(5660300002)(6506007)(38100700002)(83380400001)(2906002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXZoeG1TYlBZUEEwRjhRM05JRXZHVU9MaUNSb2xyUHJxR3hBVEpTcDNFSDJG?=
 =?utf-8?B?VjRwSTZqWithcG1kTndsVWNYMWhmbW04QVIyeFU5cmJhYmRaSE9xNlVGS2ov?=
 =?utf-8?B?RUxnZHlVdWxYc29pRkowMDVZUWVyQ1BCbjE5d1UvVlR2SXkzNXhBY3oyRytS?=
 =?utf-8?B?Y0JjZUkrbStVM1I2WEtIc0orNjl6SUMxMlFGdDhDaDZvc0VnTzUwN3czQlUr?=
 =?utf-8?B?SkRrUkxWT2hsRk1tclJmVHlHTFNNNllTczF3SG00dVY0QUpwemJSVkZOMG9R?=
 =?utf-8?B?Q1JVeXptRmtqdjkzYmhZTG9HRnJDanVFdTZ6L0JJTmFXY2ZJdXRhSkIwQVJs?=
 =?utf-8?B?L1ZGdGRVUEtsbHVqanlUMllMTDVCSUNzZTdGdVBtSWxNS1lGajM0TEpROFRw?=
 =?utf-8?B?TWpoaFMwaC8rSTJSZE80VXNRaVpsSENzMHh2M0cxWTlXZktNVnd1Zmdzc0lU?=
 =?utf-8?B?dUFaU01OdXpOencxb0I2VkxxT1p5RXJ1Vkh0V2NtOGZTd2tROVQ1amRsZjIy?=
 =?utf-8?B?RlpmbXRkdjBUb2RyT2NTK0JiaWJXK2xiZGpEek5MZ0w3blFQbWR3akZDMGti?=
 =?utf-8?B?QUFoOEJlZVkzVzBYQnduV0xFVDB1T0VaUDVIYnczaWd1T2lxUHljREZ0bVlF?=
 =?utf-8?B?YWlFcU55UzRsOFhkYUtZY3o3WU9vVGFZRG1WRWsvYm94SHVaOEFld0hVcEkr?=
 =?utf-8?B?VW1leE1SbS82NEhWWmdVNjEweE1ZNlpJdGM1c1c2TDRHTktMaTlpOHgwWU5x?=
 =?utf-8?B?cEgvVmZFeW9iSDR4cmZCMmpqT0lXKzN2Vk5QajJhOGgzNnBuZWNZeVhuY2lL?=
 =?utf-8?B?eUY3aDkzMElxeTlwQ2l0U0VGbDNJajJSL3NtbWxuUlY0b1Z1VjJ6Yk1LQ0V1?=
 =?utf-8?B?VmhQMTMyRnBtQ1hTTUZoaXBxTlNXUCtDWmROWmlJaGdtSmhTWnFtd2svbTdW?=
 =?utf-8?B?QlBLZXRXTUdPbTdaZGdnRFMxQzg1QUtOTDVLdUk3eGdGc1RXL0VRWWw5OXlV?=
 =?utf-8?B?b0xEZFBVclgvWFp0WTVGcElLdFRWenpJMFd0M1NLN1pvK0tuQ0VXekQ1cnZk?=
 =?utf-8?B?ME5SZGRqbU9sa1lOdVZvTGdSZnhDYlZIN2hWQVVNUzdHeU52c3dPZis1TnZt?=
 =?utf-8?B?ZTUwd1FGaFlTYnNZbW02ZDV4YmpNWUpaYzkzeWY2c0hmTndJQVllRGFrRzlX?=
 =?utf-8?B?V0Z2algxb1Z0NVBmaW9vUlUrNnhBQkdJWFl2dmV6NGNvSG9SMWViNDZHZ1Yz?=
 =?utf-8?B?WVJWZVY3eGk1S1RnZXBLKyt6ZC9hYytQWjVocHE1S2NFbDFneENwSGdQSDBQ?=
 =?utf-8?B?Rk1wQVVKWmRQRi9FYkZKdEpUaC85ZXhwRk9aQzcwQmN2OVJaN3NYTTcxUUlP?=
 =?utf-8?B?Mk5YVGwyMTQxSmExN3pnNVJZTWx0cC9ERTcwbjFrWWZyOHVtb2FUUUY1KzZU?=
 =?utf-8?B?UXl4ekl5eFZOMGYrdXhsTkRvMllMMTMzVlUrSWpXeXJWeUF0aHRIalYwanVs?=
 =?utf-8?B?WnUxRGxmLzZudGp1aUtSdFBGVGlHZkwwSGFqRGV5VHQ0c1Q0VGdNSktRb1Ju?=
 =?utf-8?B?Yi81cXBoNXJ6ZjRXY2sybE8xUkQvSWF4SmRkek9haGFwSTBlNWZTZlpnZVNw?=
 =?utf-8?B?MVlqV1E5am9TaExXY1cvOThaZ1RFaSszY0lPaEkvSkt4U3NFbkcrbSttVnoz?=
 =?utf-8?B?TzUvYmlzbXM4KzhnVm5KUEQ3MTdWSUErNDVpZ0x4alJqanBoMXAva01HMTNQ?=
 =?utf-8?B?czhOQUhFYUpMS3JsZ3d4cG92UXducmpVUXpqdkdFa2NyaGFPd1U3NGJ3Y2gv?=
 =?utf-8?B?NVZQS1NuNDFBZVNkSDBud2xFN3h1TVBVRVVRbVRlWnR1MmJkbS90YVVNbTFP?=
 =?utf-8?B?ZFM4TVRndnF0eXpnMUhiSUFYQzc4V3MwdUVTMWVVTC9kREcwbXNnZ2hIeUpj?=
 =?utf-8?B?ZlZaWmxnOXM1NDUwaFVKei90cnQ0Y1U5b0Z4ZVFTcEgrZ3B1Q0NNY2R4bG44?=
 =?utf-8?B?bXVMNE9CcTYyeGlmcDRrb2d1M3QzUi8vZGpqaGRhd1ZENVdpOW8xUTVCay8z?=
 =?utf-8?B?bXBzV05SanUwQy9BYk1XSmhKSjBSQWFkOFZrTy9SelpnTHFsaDZQYUNreWp5?=
 =?utf-8?B?dnJXaVJXZUtRK25iaTQxSGVjcDJxZmQ2VXI3Z3NpcWRNVk9lSW94MXZ1VTBQ?=
 =?utf-8?Q?2P8Um2Zml85UQTVrb6zb5QM=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686dd43a-51d6-4926-cfc3-08db1b77b67a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 23:41:58.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdcVLo1Qhd3XG+DjqRjyw6YIz4Kxy5/8DSEOSmgjznRplzf/yiK+H/EQwtwN6K0E0DoG5XaKkD257fyftoP7Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR15MB5347
X-Proofpoint-ORIG-GUID: d5nwcLIoXclRGIqy9_uziM_0w4VbpUNN
X-Proofpoint-GUID: d5nwcLIoXclRGIqy9_uziM_0w4VbpUNN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-02_15,2023-03-02_02,2023-02-09_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 3/2/23 6:29 PM, David Vernet wrote:
> On Thu, Mar 02, 2023 at 03:23:22PM -0800, Alexei Starovoitov wrote:
>> On Thu, Mar 2, 2023 at 3:19 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>>
>>> --- a/tools/testing/selftests/bpf/progs/rbtree_fail.c
>>> +++ b/tools/testing/selftests/bpf/progs/rbtree_fail.c
>>> @@ -232,8 +232,9 @@ long rbtree_api_first_release_unlock_escape(void *ctx)
>>>
>>>         bpf_spin_lock(&glock);
>>>         res = bpf_rbtree_first(&groot);
>>> -       if (res)
>>> -               n = container_of(res, struct node_data, node);
>>> +       if (!res)
>>> +               return -1;
>>
>> The verifier cannot be ok with this return... I hope...
> 
> This is a negative testcase which correctly fails, though the error
> message wasn't what I was expecting to see:
> 
> __failure __msg("rbtree_remove node input must be non-owning ref")
> 
> Something about the lock still being held seems much more intuitive.
> 

It's necessary to call bpf_rbtree_remove w/ lock held. This test expects
to fail because non-owning ref "n" is clobbered after the critical
section where it's returned by bpf_rbtree_first ends.

>>
>>> +       n = container_of(res, struct node_data, node);
>>>         bpf_spin_unlock(&glock);
