Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A4D4CC5CC
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 20:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235848AbiCCTO4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 14:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiCCTOz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 14:14:55 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E798915A205;
        Thu,  3 Mar 2022 11:14:08 -0800 (PST)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 223D0MaK001672;
        Thu, 3 Mar 2022 11:13:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vH0hjS9y86oidtsVbUA8Hzglb1gTDx5Fie80Tk/oH6o=;
 b=jkvJjXN3oTJz5n86xc9OE6gqeJ6aHQ1aWnwcjF1vLuTAY3/bLz3USOBcc2BIu93MXmIH
 wjTV2ivQrDR1ynCnZF/5HV3AYROofeswA9C4Rxbg2Ip2izvgogh3SIWpl8IBAGOoNBrk
 Az6N+wFb0GxyuseNkRM60ycoRSXF8QR3fPw= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ejx682kkm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Mar 2022 11:13:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJQ6RmCPdGpw5aZ+kb9RmSTQNAD4lm479y1qYi9YEskY4dISGpmri0IrpuZmNBA3V+MFT6dd3+UZUofBeHefj9oOfjhZ9a9IhAbVcj7eFatI7P2m5fKpXDNawRBspEGy7U/53H5ocXsiiR2GorjrokWbfubPbZ7T0QiubsCBk2olZBDw0T7dSUE+n9A9SrJfGXGdZdM2XM/Gw+zhgB8LFNAx9RtWeowxQF+i9G3jLDFE2BxQV3Aelkm1PsNbv519Xk78E2jfVHrTXlFQLZVjoSnwtMtr3PsE0zx7s3BFQCfLFs5b7CFYF9CKom8+lb8aJ+7fHAHb8j3uk8G56IkzSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vH0hjS9y86oidtsVbUA8Hzglb1gTDx5Fie80Tk/oH6o=;
 b=mPA/Ldy/95MSoh3E2SFO7mmIf8p9iNOQ8pbuo/zzZMpO7otivzpPxF7VzL5Q4UwXpg0+nl6hF041UnpOZCR0KKzAQ5/h4bRSleAi6/D4gqyiX5VNFIggiYMDjDcUa2qyj2f7NQAzJaUdUaqu7fBGevBNhWgsgmD3Ez3tAMLdmwcTjXGB6l9xu/1efrtshB7qGEmLyRQ7EZSlShLvrBhYh2YAf9cB0c01g9YptLyUZlojcjYmfV8b9pzioijrlLU186Phy8wqVargodwfrCM/56bbpjQj4d1kONxR25wGHTWr0N+NRSZwFf8IYjHBBTFRFdJmkgo+yxuGBjxn/fRDXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3016.namprd15.prod.outlook.com (2603:10b6:a03:fd::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Thu, 3 Mar
 2022 19:13:51 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.029; Thu, 3 Mar 2022
 19:13:51 +0000
Message-ID: <2c5669f1-b9d9-ee78-c5ee-d29a41d4d70a@fb.com>
Date:   Thu, 3 Mar 2022 11:13:47 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-2-haoluo@google.com>
 <7e862b1c-7818-6759-caf1-962598d2c8b3@fb.com>
 <CA+khW7gAEL+yBmXjWO28ns5hU4oHVZrEArfepuOfy6Q1y7VDKQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CA+khW7gAEL+yBmXjWO28ns5hU4oHVZrEArfepuOfy6Q1y7VDKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1201CA0016.namprd12.prod.outlook.com
 (2603:10b6:301:4a::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5ce5374-9a31-4551-9e6a-08d9fd49f392
X-MS-TrafficTypeDiagnostic: BYAPR15MB3016:EE_
X-Microsoft-Antispam-PRVS: <BYAPR15MB3016D2E4B21A89876E247643D3049@BYAPR15MB3016.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yydyKeDAxRfUmvxI72ZPpEohoWIKQ+jCDmYcDL8MQO9C4oYUQIFcs8JDlhfIIP+9bCdaJUc2JnNcZwj3iq0bHAokiAAjJ+5Crr32hYNBQ2IO3uKlN1rJaq9rMUpcRZTKMFz5FXeV/yF6apHFt8Rrm8BpxFGEe8z0yZgV9pQgeVErAMI36kVLY54xorTiJtqqxbsDFjMSiz1BggS3YDIdYoIGVp2487DgPa7jyhjZEBWv/qf+Xxn8Cjwpvl0xr2r0zuBZSP2ouxDN/InpunU6CPVoHCexhjXQq41nG0FfWYqTJp/WQCjVmDfbvznQ1zzo9aJheJiWch91PRKEFGwdK7wO8b+3Kb4w6kmO/M7VXjfYYjmVOmgsjHmJW3VBOyJsGI+KqkDMUdf/XKuJoCmCn1EjfAfMd6TVHP9euAic61Khh6a9DUhocauGyMOR/mS1+Cml+KAZOoOR8EF1o00PDUKaJFAQUg4XBKKWtVoAo84dlm9g+YZ5VbZOkHyRNPknzkMGLCoztxtuRwmWk7ejmAMMRcpNwvxG0PpBnY1PFEalOOKmvYGt4iz1DOr1p+ZV5o5nfw1+2opF2AjyZg66cWHPqyfsiV/JaWX/m3Is4qQNMDz84jQx1u/FXebZmIISRbwz5CIOWEoMSkVy9RBrErBK13IeNR3H+D7JRkZFLFvDCblMQ8tCRAW8Lfg2/AwezEagtSrplnXzBijiIn3TJQ5z4o2q/rD6fNvm7dKMz09oEeghzcNKCG2rPhlBpcJz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31686004)(508600001)(6486002)(4326008)(83380400001)(8936002)(8676002)(66476007)(7416002)(66556008)(38100700002)(6506007)(6512007)(6666004)(54906003)(66946007)(2906002)(31696002)(52116002)(186003)(53546011)(6916009)(36756003)(86362001)(2616005)(5660300002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFU1OFQ2VCtZV3A1czZ6Vzc2Y3JQV2tkaXUxZkN6ekZ3L2szMzVaNHUraHBs?=
 =?utf-8?B?L1FBWStKd1NqWnBWaVZjdDVNa05hdzBCcVNRWFMza2VXOGhLQTJUbk5qUE1R?=
 =?utf-8?B?a2YrYng2Mmh0TTZBVUhTeFFMeVhSRnhvS2RtVEo2STZwRnpSZ0dEa2NpdXV5?=
 =?utf-8?B?ZGd6TjBRUnBlckpCVDlYc1JvOVJIdEtmN2xvUWRUQm5JbG5xL1RSL2paaExB?=
 =?utf-8?B?NVRiZWpKNmY4Yy9PWnQ4ek5YamUzZ2x0UTY0QTJpak1vYkJhaUNGYlVzT29I?=
 =?utf-8?B?Qi82bWx0ZU5POTBpWFVKa1gxdlJSUHVTNU04TDJkdE9XTk5adHRCM2ZQWFJV?=
 =?utf-8?B?Y3VycDgwejJtS2R4eGtlWHNGSXdmRitkUzNNc05KQnhremxWOCtaaG0wSVBI?=
 =?utf-8?B?Q21NNEZsTmpZaE5PV1JFSXFQMEJTeDNqcmhXZnFRNWEyWTA4THh3WFNjR0ha?=
 =?utf-8?B?dXZ6NnZOZmtrNzQ5a0tWcGdNWWlicXRnWWZLNW9DRWpENnMrTGtGdGJMM2RF?=
 =?utf-8?B?YXpvYVJOQ1RsYkFVWkNjMEo3cUk3aWRSU3YxZUVzOTEwUXFOSk1rakswNkFY?=
 =?utf-8?B?STJaNFB0cXE0dnBoUHZ5akthMzFxMG5oQ3pOVVQvM1JERkZHVi9EMFViaUdh?=
 =?utf-8?B?ZGFkNXBHckJwQlhiR2VDUVNOWmt1bUxWTmMvd2JZc2dJejRIKzEzOGthZmpL?=
 =?utf-8?B?eTE4bndVWEo4ME5ENUVQa1R2V1Fab25hNS9BcS9nQXdHdzBZNS9ZZDZiL2xN?=
 =?utf-8?B?bUdsY3VWQ2JMTWFtbUpac2NZNm5jbER2cU5zUFN0V1k2cERPaktheUVDZUdN?=
 =?utf-8?B?cUJPeGtZejB0akJLYTBMUjFqNEhzVURVWGN0WUNrWnNRR1QwQVBOd1FIOGtL?=
 =?utf-8?B?VmFqVGdoU0VSd2cyQkFuYnlLdi84SXRyc0hxZnFzS25BVVJqbkVrd2d0NDUv?=
 =?utf-8?B?bmxxdjNtcWxYcVhlSW9lR0V2YkpUNyt5ZW9LT1FPSmw4SXg2MGZPb1V5Umpp?=
 =?utf-8?B?MXdwZnpiTXkwb1NKc0M5WC9ELzIzeWk1Tnc5amNNazRFdGxKeG5MVi81eVU3?=
 =?utf-8?B?WS9JVFBJcEVrYk9sZjFzdzNRZ2gxN0VicUpENUhHeUhoVGlmdkc2ZEFBYjhl?=
 =?utf-8?B?V1E2bit5N0F6V2xoQVBPZWppSjN6WVpXVXBiUnQ2WjNtd0RIMDBUQjd1azl3?=
 =?utf-8?B?Rm4wOE44SThLeXE2V0M0OThXVkpaam1oUmRObE81eVN1bVQxekkrYjUvN09v?=
 =?utf-8?B?Uk94VFQvaHVSUm5xeTdEQ3ZWR01WbmJrNi9QclcyUGthZnQxbWVNa0hKdm5H?=
 =?utf-8?B?TkxnYTBpSkNCemE5RGVoWGJKK0x4Qk1Rei8rUnJkWE53dE9YaGZvdGRLSkNV?=
 =?utf-8?B?NFhkb0d3ZllVU29jcDB3SjZ5T3Vka3RGTGhUdzJSbjY4RUZuZG5kYW90aHlD?=
 =?utf-8?B?TkJOVHZ1dW5qSGNHSjRwUlJrOGcxVlNIV2ZmYTd4clJDY09GZnFOWEdhU3Er?=
 =?utf-8?B?QUVZeXZ0S1Rxc3ptNDQzT2VNaHgrVEVtclZQS2U5TmF4cEpmLzl5Uk9CV2N3?=
 =?utf-8?B?V3AwbXNXMXg2a1FoVlJZZWdqTVgwdnNqbzA5MWljSzhpT215eHhLdjdtRGYw?=
 =?utf-8?B?MEt2TzBvU1VkLzdYSnFIaVRVUlp5YThQTjREUjkwTWJ0V2lWdGNFdzhpcVln?=
 =?utf-8?B?YjZZZkswTHBISzBxVCtjVnFqQnFlZ21FODhQT21acnJiU1M1T2JmcXlDMmcy?=
 =?utf-8?B?VmxwOXQvSHFrYktJSGxIWGpONkU5RXBlN0RGV2dVZXJmWUVYZVJDSGw1VERh?=
 =?utf-8?B?K1dQRnVURWVYSGFvM1VIRmhjZGlRUWQ0TU0rQ0FoTlU4UHRBUzF1V04zSysv?=
 =?utf-8?B?NTZtK2doS25LZDdDcGN2Uzd2eCtqcWdTNzRYQ0xnb3lYUHR0anZyOFpTWVRq?=
 =?utf-8?B?VC9ZZDJtWUtNanZEN0hlc0FibWRsU2NlbnY4K1BSUGxlWnAwZEJpa2cwT1J0?=
 =?utf-8?B?WXYzWHIrRHFLMGdrOTBzQmRvQnplcmRLTWVPOUNISlpMTXl3dSs2WlZhUjVt?=
 =?utf-8?B?WVhGOUZpOUUwSmVPYU0wTjV5WXJaZVFGOXR0bDdsV2Z5NjBFKytraVVvSzlK?=
 =?utf-8?B?RmxIcGl2Z1BlYXlpd2pUSGVQQlU3Ly9tZHBlZXFiWVcxbmNReHY2azN0Q0hM?=
 =?utf-8?B?L2c9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ce5374-9a31-4551-9e6a-08d9fd49f392
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 19:13:51.2579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcadmoCIE/rIRAPeIdropny863rvh884vdtehX/B72hxAIgjX0WDlS7dP1JOFImr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3016
X-Proofpoint-ORIG-GUID: GYYGdqFjc6Qi1yWBhIcKg7saDg6nxRv4
X-Proofpoint-GUID: GYYGdqFjc6Qi1yWBhIcKg7saDg6nxRv4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_09,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 suspectscore=0 mlxscore=0
 impostorscore=0 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203030087
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/3/22 10:56 AM, Hao Luo wrote:
> On Wed, Mar 2, 2022 at 12:55 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/25/22 3:43 PM, Hao Luo wrote:
>>> This patch allows bpf_syscall prog to perform some basic filesystem
>>> operations: create, remove directories and unlink files. Three bpf
>>> helpers are added for this purpose. When combined with the following
>>> patches that allow pinning and getting bpf objects from bpf prog,
>>> this feature can be used to create directory hierarchy in bpffs that
>>> help manage bpf objects purely using bpf progs.
>>>
>>> The added helpers subject to the same permission checks as their syscall
>>> version. For example, one can not write to a read-only file system;
>>> The identity of the current process is checked to see whether it has
>>> sufficient permission to perform the operations.
>>>
>>> Only directories and files in bpffs can be created or removed by these
>>> helpers. But it won't be too hard to allow these helpers to operate
>>> on files in other filesystems, if we want.
>>>
>>> Signed-off-by: Hao Luo <haoluo@google.com>
>>> ---
>>>    include/linux/bpf.h            |   1 +
>>>    include/uapi/linux/bpf.h       |  26 +++++
>>>    kernel/bpf/inode.c             |   9 +-
>>>    kernel/bpf/syscall.c           | 177 +++++++++++++++++++++++++++++++++
>>>    tools/include/uapi/linux/bpf.h |  26 +++++
>>>    5 files changed, 236 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>> index f19abc59b6cd..fce5e26179f5 100644
>>> --- a/include/linux/bpf.h
>>> +++ b/include/linux/bpf.h
>>> @@ -1584,6 +1584,7 @@ int bpf_link_new_fd(struct bpf_link *link);
>>>    struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
>>>    struct bpf_link *bpf_link_get_from_fd(u32 ufd);
>>>
>>> +bool bpf_path_is_bpf_dir(const struct path *path);
>>>    int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
>>>    int bpf_obj_get_user(const char __user *pathname, int flags);
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index afe3d0d7f5f2..a5dbc794403d 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -5086,6 +5086,29 @@ union bpf_attr {
>>>     *  Return
>>>     *          0 on success, or a negative error in case of failure. On error
>>>     *          *dst* buffer is zeroed out.
>>> + *
>>> + * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)
>>
>> Can we make pathname_sz to be u32 instead of int? pathname_sz should
>> never be negative any way.
>>
>> Also, I think it is a good idea to add 'u64 flags' parameter for all
>> three helpers, so we have room in the future to tune for new use cases.
>>
> 
> SG. Will make this change.
> 
> Actually, I think I need to cap patthname_sz from above, to ensure
> pathname_sz isn't too big. Is that necessary? I see there are other
> helpers that don't have this type of check.

There is no need. The verifier should ensure the memory held by pathname 
will have at least size of pathname_sz.

> 
>>> + *   Description
>>> + *           Attempts to create a directory name *pathname*. The argument
>>> + *           *pathname_sz* specifies the length of the string *pathname*.
>>> + *           The argument *mode* specifies the mode for the new directory. It
>>> + *           is modified by the process's umask. It has the same semantic as
>>> + *           the syscall mkdir(2).
>>> + *   Return
>>> + *           0 on success, or a negative error in case of failure.
>>> + *
>>> + * long bpf_rmdir(const char *pathname, int pathname_sz)
>>> + *   Description
>>> + *           Deletes a directory, which must be empty.
>>> + *   Return
>>> + *           0 on sucess, or a negative error in case of failure.
>>> + *
>>> + * long bpf_unlink(const char *pathname, int pathname_sz)
>>> + *   Description
>>> + *           Deletes a name and possibly the file it refers to. It has the
>>> + *           same semantic as the syscall unlink(2).
>>> + *   Return
>>> + *           0 on success, or a negative error in case of failure.
>>>     */
>>>    #define __BPF_FUNC_MAPPER(FN)               \
>>>        FN(unspec),                     \
>>> @@ -5280,6 +5303,9 @@ union bpf_attr {
>>>        FN(xdp_load_bytes),             \
>>>        FN(xdp_store_bytes),            \
>>>        FN(copy_from_user_task),        \
>>> +     FN(mkdir),                      \
>>> +     FN(rmdir),                      \
>>> +     FN(unlink),                     \
>>>        /* */
>>>
>>>    /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>> [...]
