Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71235BEB58
	for <lists+bpf@lfdr.de>; Tue, 20 Sep 2022 18:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbiITQuI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 20 Sep 2022 12:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiITQuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 20 Sep 2022 12:50:05 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454F820BC5
        for <bpf@vger.kernel.org>; Tue, 20 Sep 2022 09:50:04 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 28KA0hvm013850;
        Tue, 20 Sep 2022 09:50:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : from : to : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=F/gNDY6cLQKkMLQzo4+GMGw8XRiNZAaow9qEI6Vf47E=;
 b=JyWb9eAHhBn9ovSsG6t2k10y8jQI2rTyQf6lEsZ+79fWL5aLXeweBVZT0AHxop6SuhBr
 jfdU1/VxsglI1qZEGWBI4OVlINqpMqvmip/kkqHU2CTwVscTHuP1LODJTx/RbynQ8d/8
 V8icWoVP49ug5ropfPfPucOl4isOcg1yHvg= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by m0089730.ppops.net (PPS) with ESMTPS id 3jqbd22vqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 09:50:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiSGszweX/mKLWCbOVEKHLLePlX6UMDBB5GpsVxY5O1Up4zQm3prwIlyL4jzZJub9UNojxucsZX6zWcMramwiRgpqLudPpBlpns7rMI+Ch1QQuVmeIFLxArLNWmS85xlnkqFRmKPMoTkMGxL45/bxfzh3znU16Uh8EK02wZOTMsEjCnsuDYwoWkZc90IzqryqxH2/SKt9vKsxtcCox8olCh9ydYeLXOvwDB125GUTwp2dxqveoUV3/U8ZyNIHNeRRQA4PSjUN6234Wg3ziYOfG/HMmtvDD9eeJ6rn6En+JkrYwEmF5qtRZDEII9qqKHIxzMrGHmuAxIApZ5WMmWEaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/gNDY6cLQKkMLQzo4+GMGw8XRiNZAaow9qEI6Vf47E=;
 b=FsIi4V89+DyzsHT25Ki/4I+ZHMnKr7RNMGhY6UY2x3YgRR/Br0aqyemB+JzNG/yvQuu9ELux1yDdHKIFsupsTdNWKtEfOidjZ8yuRnx56ARLemwP7KbH5UXdCe5vSK+o227lZ5fMRAQ4a7XIa4qPme5pjoBszQdQxaE3hjZ97CUwxU5jYuzCKmOgve3gbmQtQdnBMz4uiU02zi37bi/lvKK54Rj6bJRk1Y5b4AvCOvecXtf3w5pLMa9JW4PiytNMDgxxEqvy8ETv4h5K08/K9Qo4ETzW+Qvue/AvFqLVFVzeZMtHZrbqhRBHFsDOZurASKgZ6XHeEJ3LFAR8eX6NgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR15MB1787.namprd15.prod.outlook.com (2603:10b6:4:56::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14; Tue, 20 Sep
 2022 16:50:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::cdbe:b85f:3620:2dff%4]) with mapi id 15.20.5654.014; Tue, 20 Sep 2022
 16:50:00 +0000
Message-ID: <953ceea8-16ed-5aa1-b170-c87b354e941c@fb.com>
Date:   Tue, 20 Sep 2022 09:49:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: LLVM 15.00 github repo build panic to run
 test_core_reloc_kernel.c
Content-Language: en-US
From:   Yonghong Song <yhs@fb.com>
To:     Vincent Li <vincent.mc.li@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CAK3+h2ykSR=CXBDZs-_9JjBTim=2E4QHAzvkP=WR5Ke3EFd6Ow@mail.gmail.com>
 <737a8c08-5f2d-304a-adb8-f9f33d9e3ef3@fb.com>
In-Reply-To: <737a8c08-5f2d-304a-adb8-f9f33d9e3ef3@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR22CA0011.namprd22.prod.outlook.com
 (2603:10b6:208:238::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR15MB1787:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df17989-5345-4784-d58e-08da9b282855
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s5mnaR+z84L69b25mzgn2BumfiakatWlvOhjSWHqrDuZ4Va/4t200o0fvljy1YlKeidT0oQ8LnPEW19uVHXW8lUxLBqoLF2jxBnO1H52Chaoi2hbcI7dLjoUKz0uQzND0bR4AqW5BLMGtuj0G4uMY3UpF0UmCJO+hB4eQKf6BHVobAKrMbboV0NFwDiv18frWBSEt0emM+wCuS+Rv26xhAI7EGtT1y1Q4y0BJuHoKnxj9R9ZDyQCbUzcwYLm3PNREPF/kybNB1cIpdoXqUpLBYkIIriKl7LthD5FmX09c54FC8p4Sc1FH8RBhezYI4TxrJy9Nb2xaRSrZT6uQCYiXMa7uxrU7xhR5Yle3n8jVzX59l29wY2o8bBf9gyqrY6iW9S1KrtKWvUDq7EDjd9ziYDtcBMERhiTPM0YXmPRzhcESzUaOwH3XJPKaRiXDZyKfCZY8YQLLQ+ADvVOgOZXUJ6aodmmBuWdxRTSl/XK4sORHs3s0FE0llMkkuuOOl2RqWFpGkT1sy9dGM+RYKMjeiSNmHYBXPwV0RNsok4dLFD+cadDsJ912JAFk6yt6OrW5PAHGFsAt3zt6I4QSxiW7/+poWasJcw8ZEnhhtD7X5au7ThD0BPAb3VoEy+lJEpeYDxBn1xOslhDjV8xCcOXUi2tTjrtpH+Cxmf92t6MtqMbxGl6+FWnXwz8k0yNmzKpuVjAKWgkE7//dBoMvZUA89HlTk6obT8QU6IqYehDdvFEalbrwxJwWr0xSiUVBOuiHrgrbDTJ50CwMIaZtNVIgdFgBe/rMeSlW9b0Ky6rYz4rFScopy9J3R4WyZ1CBbVBsNbhpb5twmP0MjO45xh/Tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(451199015)(6486002)(966005)(478600001)(38100700002)(186003)(8936002)(110136005)(316002)(2616005)(66946007)(66556008)(66476007)(36756003)(8676002)(86362001)(31696002)(2906002)(5660300002)(4744005)(6666004)(31686004)(41300700001)(53546011)(6506007)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVdSVHk5OEt6bE1WZTFNQU9iT2ZhbGhoc0o4NDhjcVNHK1BwMjU2UVJzbE9O?=
 =?utf-8?B?OG0xS1M3SytmUVlhYjdjdU9ySFhXN2RPVnNQM0ZrWWNSQVJGSUVMVGZYcjBy?=
 =?utf-8?B?aGFUbkpSaE04YUhhbWYwTHVsdXVUR1U1LzloSEpYVk1YRnRzWnVFcHhyVFRY?=
 =?utf-8?B?RjVnWTU4OHhxU2tNdUkwK0Q4eG92dTRqZm1takl5TUd4NkpCRkpRT0N5MWpv?=
 =?utf-8?B?WHNEdjYvVkJlWE9rSXhZN2QvWnFMUkczTFBxWmw3Y3dJZHVZclVOK29td1VH?=
 =?utf-8?B?SE43eGdxN3o1akd0THJwNWJMdXkxSXlvd3Mzc1dWRmhPbFNmRUpYVW5sODhZ?=
 =?utf-8?B?LzMrM25lb3NreTBvR256aFdPOS9FcURRSVRiTVZTZjMvUDBFbkhzTTc2NGIx?=
 =?utf-8?B?Und3aTJ5NjZPeXd1aGNFRTVVSi9vSzBQRjVsQ3E5RGR6TlN3cHBmMzdoVTRQ?=
 =?utf-8?B?VHY2YkNCMm4xbitnYW9HWDdCNGsxTCtNamUyNkJSaDZMRzBMMzNNRkY3YXVo?=
 =?utf-8?B?YUFXbTY2d2hxdWdlLytuOTdsOUxvb2NDVVlGMzBIZUp0SDdJRmlkeThKck03?=
 =?utf-8?B?OG0xeVNhaGdhYXNSanBGdEpEenE0OEYvRDVVR2tiRlZBb3Q4T2lKa1dsRFFz?=
 =?utf-8?B?MjVZT0NQME1vbHFITXpycEFDbCtYTkVNSEU3TDYrQ2dzcTZDTFQvZm9xN1V0?=
 =?utf-8?B?bVJQZHkvRHFLTThmZTFTYVU5dzQxdFRPZ08xeXdlcDNWN3g0Q3RRdzlYQytu?=
 =?utf-8?B?VlcyMHVYZy9OTnJxaTJtRmZDekJiWTBGU2w3bzUrNlFDNG52cXJWZnZoNDFP?=
 =?utf-8?B?c3BPOTFBelBBUHlIUEVndk5sT1IrQUtVUGRMaWthYUNGcU55QXNSQ1pZa2Jp?=
 =?utf-8?B?TVBuOVBhZldpMXZnVUtWMU5iSTQ3VmNQTkx6RVhxT3kydzdjRlluYW9Ic1A5?=
 =?utf-8?B?K1l4VDJURFBiVno3UzZVb1JES3pWNUc4K0RiTHc2T0dWT0NscjJkOUYxU1Bu?=
 =?utf-8?B?b3NHd1BGUk1PUzlhY2NEVllhSXBTOGNya1p2NG0yZ2c3dmhqRXVFSUdKMVRE?=
 =?utf-8?B?ekFoQUdkSzgyV3JGTS9vRkhFM2NHL044Z1YwWi80RUpMQnV1VTdYcVBuRlY5?=
 =?utf-8?B?SVliZXdBRi9tc0Y4by9uaDhkMERjQWNoRE9BSS9UQ2RXVVd0ZmYzOTFFQUxn?=
 =?utf-8?B?N2ZtUHU1WWpOSWZDbDZNN1M0ZnpLWUQ3SEY1ZVJNR3pHQUtNQ3F4c1BNc21H?=
 =?utf-8?B?NXk0OHV4NHhiWGNqb25ZN3d6WnBwL1NhZDJWaHFsdHVYYzJYTk9EV1gyU3Jx?=
 =?utf-8?B?TWlaQkxGMlVLNXAyZkpDT2NRZktqMmQ3UXBlZWRkeTNKSkw5clo0Q1VLcEdv?=
 =?utf-8?B?NFdyOEZEYkNTK1FORm5XNHloWGYzVXVvR2lVZkFmTTl3d0xOMUJTNW1keGxr?=
 =?utf-8?B?RjdaRkVsZis0c1dLV0xoLzl0WkRzNU9LQjhhRGQ0RjNDQS9objcvNTAvclhz?=
 =?utf-8?B?RUcraytiZlgrZXhzVHpDVklYRzJDUG56S2ZxTldNMEdFQ0gxT0FkQnA5T2ZN?=
 =?utf-8?B?WFJFL3ZOTUp6NFJ4NkprUHNYZ0pUTXhoTDZrY2xybEs4bUl2WHI1aWM2ZEcw?=
 =?utf-8?B?RXpmeEVxMW5xV01OTEU1Nm9SMVF1a091aDRPZXQyRU10YTBwMkdzN3pqNHdo?=
 =?utf-8?B?dGNtR25aRk5wTGJTN3BhcFk4ZFhCcEdBZEo3TVhvU3lHQ3FTU0tWN1o1TDhD?=
 =?utf-8?B?WW9qdUxVeWJpYXY5cEFlUGRZZGkxa1hLeFFsU0xBeVEyWjA0VEJweWkwQ1VB?=
 =?utf-8?B?T0pCS1lJaC9GMnhBaHcwVVJ2N1lJckE1R29xdXJ3RVEybitYMzVQcGU3YWF5?=
 =?utf-8?B?YXVYZElNQ08wYlh5OG9OSmhzT3E2WkIvRis1R0pHaEl0amJDQnpxTTFWT0NV?=
 =?utf-8?B?dE1ibThPRW1NTXJad0JoOEpGRHk2QWpJZW1qVVptV25GeEY4VFA0Y2FqckJi?=
 =?utf-8?B?aVZMcGxQYXRvQXNMNFhLcHh0cTZKODFPcmY3UWh5ZGg3bXV3cUxCMSszTVRO?=
 =?utf-8?B?TVhoUDlyaVQvMUUxWEN1SkJQK255bWY4Q3Z2NjdwNVRnMm1GWEJqMUc0MUJN?=
 =?utf-8?B?Y1ZUZWQ3UUFLQWhIU0l2dXVDb2JwY3YrZVFBNHdFYWxXOFVKMUdhVFBxWm85?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df17989-5345-4784-d58e-08da9b282855
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 16:50:00.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjapQhiipJmG8bDP5BMYFR4vkNzhZ3UvVN8srlMFiFA4M+eTo07vnrIkRYS6FuCF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1787
X-Proofpoint-ORIG-GUID: qBg1927AuW2KqFvjbXueveiDEG8OoSQY
X-Proofpoint-GUID: qBg1927AuW2KqFvjbXueveiDEG8OoSQY
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_07,2022-09-20_02,2022-06-22_01
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/20/22 9:42 AM, Yonghong Song wrote:
> 
> 
> On 9/20/22 9:36 AM, Vincent Li wrote:
>> Hi Yonghong,
>>
>> In case you missed the report :), I ran into LLVM Clang 15.00 panic
>> when run bpf selftest, I reported in
>> https://github.com/llvm/llvm-project/issues/57598

I added some comments in the issue. In summary, your local llvm15
is old. You need a newer llvm15 (the best is based on llvm15 release 
branch), which should fix your issue.

> 
> sure. will take a look.
> 
>>
>> Thanks!
