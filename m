Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B7A40D287
	for <lists+bpf@lfdr.de>; Thu, 16 Sep 2021 06:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhIPE2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Sep 2021 00:28:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:45024 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229521AbhIPE2k (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Sep 2021 00:28:40 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FM408Z000527;
        Wed, 15 Sep 2021 21:27:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=F0qcs68BJDnE1+EfNR4peLJ9AfQgDZoWxhnCtZTkNMo=;
 b=KnXipRbibKsNt9yC2Y2w3R7gPliiOqirUoY1rCNhnXKhi25767Xq913eGt8r4TSmGr3J
 HOays+fCQiCsskGyxXkjmSe/Cf7BwWn4YlRVltpDfk9OvZCi16CDMf5uAEEHpY/6hFuK
 H/XDoWez5v+SgwwgwMogj0F2cHqU1tXSkIk= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b3kv0m6ge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 15 Sep 2021 21:27:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Wed, 15 Sep 2021 21:27:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0MYyzF67v6L91xB9zz5boK6pAa8UiMom0dBHgNTJB6K2lkELeU94HclN1NhglyihUuCx1DrWtJmIlT9dkH0vKNvIVtmcSXp//WOr1bUD7ZguV7FfMvoLJWLaszrFb3Oygn4ZhbpA7NtY1PWn3dknf8LkFHLXM8JRQjqMG+Z7cuxoPQ1qARdL7ikFTMIyAcih5gqXsU1fsqnDhL6aCZaPsy6gAE7r5T480vrK8CHATn7mD1GSpY2z9X2jMVA9a68X3yWx/1AElSIiK+7d/z2j76q6Nl1bGQ3yyf+ivN1576URtJ1WEnmb6F6kyyqx/yR7aQeKGTbBVVHWq6u7nrYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=F0qcs68BJDnE1+EfNR4peLJ9AfQgDZoWxhnCtZTkNMo=;
 b=TTOD0SrC2XWWaLrzXTUFTTUFsTx/ykiYBCqbgYMN9sy/cT9dEfgdpMJ1MO6/iFGUhw8F35GkX+C5lleI7gkpp++RIFGadjFl+vm2DCq3iXND1lSvQNCv0QKMxtqLeDIl9gmJV5yU3xYl6Vy9ji/fJf7ptMBatOP1J9y030eWnHsp+ZikyQOesyOLWvr5q4o84KiHs5xb6UGpOgouK/CZXzsnST9LEqJOM2YGBzKLP6BFz0bxUDhcmB8G2i2F9Dqdx6fGb/GXQ5xFkm20FyUmpTzEBHD6BN8uQK89HwBGYom/Js+MQ5TRCeGjdQvPadh5zRi1AdwT5JeKcDfmYMHdyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4339.namprd15.prod.outlook.com (2603:10b6:806:1ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 04:26:58 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 04:26:58 +0000
Subject: Re: [PATCH bpf-next 6/7] libbpf: schedule open_opts.attach_prog_fd
 deprecation since v0.7
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210916015836.1248906-1-andrii@kernel.org>
 <20210916015836.1248906-7-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3ab34338-9cb7-ab60-0d7f-55c52d56af26@fb.com>
Date:   Wed, 15 Sep 2021 21:26:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210916015836.1248906-7-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:74::41) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:51c) by BYAPR05CA0064.namprd05.prod.outlook.com (2603:10b6:a03:74::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.9 via Frontend Transport; Thu, 16 Sep 2021 04:26:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04df5c63-2bad-42dc-70cb-08d978ca3926
X-MS-TrafficTypeDiagnostic: SA1PR15MB4339:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4339F07C0793DDEF75A40F35D3DC9@SA1PR15MB4339.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YD3WH9I/xWNae8tIotz4H07kcRzS5m5r7qNiRjm3hncrplh8eSEtuK3WMN4xRa2ehaMnO+ePN7AUJ629w9cQ8lK1XCelTRjNQTQZ0mDUqAw2vTr/mLu9DWMnu3VojDmondjB93Zb8TNyqeG/fL2HCICfBWH/PZedD4GjohtGVtbFn50dBHuHUGY7mtFvGlxXSAapVXiILxFky5/idYlkfVADXSprIKPRcmn3GtwI3B9cM/S9ROYcbvvHvcsiBloxEo0H1aP1q3VXCFcY3AYZIFF+k8muRMHhMX601Y7tR8IG3/choZikN0AmmcRRAQXv5aPMelTtCAoPf9BNVrqbfF7yULcwoJrZy4TKwiInVSWpmXA1hKwldi2XakH4nRj+fbakw23i5aTRP1MjkkxojQo9KfdIcpGPyDWbl4uMKY4uU6c69tzGPg7Hlxptz+RbRv4vuHQylG4TxW+GAcM499+0HiBHWuLqfA+ZqXI6fNhTZCB6AY4WwryeshUcF/QIFJcOEi/iMSR60gskha2BslT8+vVFV03wJv58hHJFV9oUN5bIrO4cYycbRM7SiHCUNiJo41HweIgKzHugHWtYCQHxNBYIififnH16AOAMEvGiigNg52uchvtIJz1G2nxx003NIyQfs5xY4/JtmmbfSWKZyeLhKIz73sfbD2PAtKIW+METPtVPWMugRhMV/X/YcgzBr/8+DUpQvhdlomUEJ6OfIprTTayZnXP03tlc+ONrcj9OY0qzF8N0YgKxleQO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(39860400002)(366004)(376002)(396003)(8676002)(52116002)(53546011)(4326008)(83380400001)(8936002)(2906002)(4744005)(31686004)(6486002)(316002)(38100700002)(478600001)(186003)(5660300002)(66476007)(66946007)(31696002)(66556008)(2616005)(36756003)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHY5Z1IrNERqZzE2QU5ycnRtTURDajBsWEwzK0t6YTFqcjR2TENOS29VdEZB?=
 =?utf-8?B?Wkw4QnJOeXRIU3VKSjNRYS81ejNYUGtPY0pjSjJrTTBrUzdpckdaL2ptNHla?=
 =?utf-8?B?MlN5MnR2S2tSam9rSEhETnNYL1cxa1g1SzVHQVZBaGxhT05yKzRiUUxVTUpt?=
 =?utf-8?B?aS9DTDhyVXZjU3pvQUNtQTVzRm1mdFhnQXowU2RORnYvK3A2UkpwSUFTZldX?=
 =?utf-8?B?RlN4amNpSTE3aVpEakcxU1NQWjJ3MmREbGd4ZjZSQlB3WkFMTXBGd0lGZ2NT?=
 =?utf-8?B?VGNzL2ZrcXNRb3ZPcWYvcllSKy83dFNieUs3SG1LakFSYWVZYUlwSUpKUVNH?=
 =?utf-8?B?TkhQK0hLSnZRQyt4Y3ZuUURzM2l6WEVYRC9NUVl4b3JEUzRJWUNFbUtOeHlQ?=
 =?utf-8?B?Tm9ycnpaODhpNkVwL2dIUGRBN3AwWGkzNDFxN0tJaDZ1ekZjUXJLOWVIOGJU?=
 =?utf-8?B?Wnk0d1E4Q04ySzBXUzhubk5jUHdvOVp4MytzR2I4cGhNY0wxeEttVGNuWGpY?=
 =?utf-8?B?VHJyOVBGWk94bEFsZnZFYmZaZGVyT2RnQVhGM2Z2ZVFnRTFjMkljVTI1QWIx?=
 =?utf-8?B?WENVWWYzR2FpdVJ2ZkwxTDJYa2s5SUV4QXFnOGUvQmc5N005aDdCMkVabXRr?=
 =?utf-8?B?c3F4YlFMZ0U0N1lCcVNRSHZRbndkTVJxZlZ2K0R2d2xQMmM5UCs0MkxyMUlN?=
 =?utf-8?B?Q3I0YTFRN0IrQjBmZDI2ZjBxQ3ZTR3VCclZHRllOMFRoTjZ1Wkc0aTJWR0Rt?=
 =?utf-8?B?czBKUnhxOHBGcmQ4aDBFZisxeEE3dTZPb0toMHljeGliYXlTME0vb216amhV?=
 =?utf-8?B?d05pUWZnUjNObWpzdWhXK3ZYTms5RXRwZHVsbW9YdHZkd2k1QWlNVk9Vc1pk?=
 =?utf-8?B?QUhtUGZtZUxYS0NvdTJ4MzlLNVRmOTFWQjdXbjc5V0IydXdFSkxySGpHZzNa?=
 =?utf-8?B?OEsvOHpLaFRhNTRNOWQ1Y0tvWWtxSGROWERqZXNOU2hYblFJWDM0KzlGYnNU?=
 =?utf-8?B?MnI1dFpjRHRLNGNPYS9vQ2xIOS95U05KZEZ4SFlmVVV4c1ZTbENLRmFENDFF?=
 =?utf-8?B?SlIwYkxuZmo0QjBTeVhFbURJYk1QYWZZUWpFNzdQVjJPQVlqY3p2UVB1R2Jn?=
 =?utf-8?B?bk15eGFrcVRSODN2QXp3MGZhZTVxb2p5a2Y3RWhmamFSUmVkR1JxTnN1bGUr?=
 =?utf-8?B?SUhYOG1kM3hLQ1lUbm9JeHJLdis2b0w0QlZDc09pbU5qd084eGNiNURWLzJM?=
 =?utf-8?B?MkgySWRRVlBCNElwanVpVlMxNWRFWEVMTTR5cjdFU1dCTVd6ajJxNW0zRWVC?=
 =?utf-8?B?bFBvMVhNNktFa1RxUmJSTmF6ZlVsT2hXeGF2SXNZTWVxcEg4SXBVck1uMGtX?=
 =?utf-8?B?N0Q0VWc3RUNWY2xYZ0ZYOXI3NlNWVFVieTNLU0RzNW5Pc2RxZ2dVcUpsejZI?=
 =?utf-8?B?V0ZXeDl0d21qTW9YUW15L1crYlp0U3pVNkxqbWtYbzVIQVBXWlBQYjJjWVN6?=
 =?utf-8?B?aHdsMGlwZWtodDhxRytWU3RzYXN1SWU2UFpscVRRb3dCVDlQSmFxeVVKYkRv?=
 =?utf-8?B?T3B3Q3EzRTFnZlJINmsxcldEbDFpaXdhNEJQb0VsUVpmaVBvblVpWGIyeWdn?=
 =?utf-8?B?Zm1XWFU5ZHFKaGFnZDIyOVo4RjkxSkg3aXhDSDB5V2RSbHNSbUlZZjNPQkY4?=
 =?utf-8?B?UmI3Y1R4WWIxRFMvUG85S1k5aWVSKzU3S3p0c0Vyb3o1enJHUWczR2NGZ2tt?=
 =?utf-8?B?SmdmYVNFeFJJbURDYVBvS1U1aWh6VzZjN0FBaGdESnl1eEZLTnducVBMaG1H?=
 =?utf-8?Q?Nto+nKCgDgnvPtyyilezuxJsmTke9N8aW48A4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04df5c63-2bad-42dc-70cb-08d978ca3926
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 04:26:58.8312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X4Ceudc5DOie+ObzuMLsTHusvdkIJS92T2zvtL0JLDmOAqs/rdIw6wlVYZm2zPO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4339
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: MEc05ny3vFbyihM8G8D4VYX6ZZEGlWVf
X-Proofpoint-GUID: MEc05ny3vFbyihM8G8D4VYX6ZZEGlWVf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-16_01,2021-09-15_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 impostorscore=0 mlxlogscore=917
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109160027
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/15/21 6:58 PM, Andrii Nakryiko wrote:
> bpf_object_open_opts.attach_prog_fd makes a pretty strong assumption
> that bpf_object contains either only single freplace BPF program or all
> of BPF programs in BPF object are freplaces intended to replace
> different subprograms of the same target BPF program. This seems both
> a bit confusing, too assuming, and limiting.
> 
> We've had bpf_program__set_attach_target() API which allows more
> fine-grained control over this, on a per-program level. As such, mark
> open_opts.attach_prog_fd as deprecated starting from v0.7, so that we
> have one more universal way of setting freplace targets. With previous
> change to allow NULL attach_func_name argument, and especially combined
> with BPF skeleton, arguable bpf_program__set_attach_target() is a more
> convenient and explicit API as well.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
