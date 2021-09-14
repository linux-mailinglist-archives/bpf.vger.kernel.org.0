Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFDB40BC10
	for <lists+bpf@lfdr.de>; Wed, 15 Sep 2021 01:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234374AbhINXME (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 14 Sep 2021 19:12:04 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43918 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234320AbhINXMD (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 14 Sep 2021 19:12:03 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18EG2NOx003624;
        Tue, 14 Sep 2021 16:10:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=K2fZSZ1kayzcj4XtlhJ9P7V9lq/tnI06EifIHZR66ig=;
 b=AfKx0TeOpiU9V1nIisrDnqLnA8gns5trbO/z2/9BqQFooSaFjdjmx8TU2aivnRpuVIR6
 JK8EFtV3LvIjmCsZz3yegp/DAU1m7rFfwigG/PZVyTiqwNk4q6VZukbFWuQRpNWD/gLU
 i9CG2z9pDRCxHGqqBlq8OzfDoqQopp4dk58= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b2kh06ks4-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 14 Sep 2021 16:10:33 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 14 Sep 2021 16:10:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWa6ifjy7CWjL9DNBGzNbcRpMDFQZgDt++gozevASwinn7KVEh9xcG/4csNVGJ4CU4ISgRaXmnrNwGkkxMuul4Hh80/YGe6wPl8FRGK+VgFp6wY+yFa1UDboQh5QJ0gFHlNBvH3h9pfkKqe9nKpnm/MvRusmLwNTNszzyR5Q3HFWPYAezW6aPCv4rLBwmLA3rXDk5hjscSHL0PLBTCJQfwAVkc+biBzIIxLhPJGFYwVDmmFQKOuqRXi0KO2G5eTL14bEphho+eir2mKRVw7j41M431aGGUVghDjAB4x5ig+qKZNdYdehPIrBGBVXbaqkdGn1RW/hUcPFUXc6jBpQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=K2fZSZ1kayzcj4XtlhJ9P7V9lq/tnI06EifIHZR66ig=;
 b=HC+eNvy3TWZV8bZVV3xpLtW73Xr+Y2vp4cE48+zveORmUlAZ97btTfeoqTbtl+kGnYzU3YGwyYw5SLbqpdO6VOCqsC7E2ncG5gF2+fTlFUKyLQwgvnmqdNn11PgJIQWoW/ZLuHXyXvF1lVWIQsMi40OSmJ7akzfSNO5blcNKTrviy3Ig3UmOwDzfWqlky6AOrACdjqCqkdwb10kwkIUFLjvco9dBKjcaUsRy4fYiSHlBNglPhVdD3wneWAOMaYnf1CywklR/xpaWx1cYF24ihpLMyF/AZmbnnHiByzXGItLLpp3ux9Wm1mSx1hREJueHOsNT6iaiNwEEGeXL/8s9/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4644.namprd15.prod.outlook.com (2603:10b6:806:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15; Tue, 14 Sep
 2021 23:10:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 23:10:27 +0000
Subject: Re: [PATCH bpf-next] selftests/bpf: fix .gitignore to not ignore
 test_progs.c
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210914162228.3995740-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b2c207d4-015c-b099-105a-b155b9c9ce33@fb.com>
Date:   Tue, 14 Sep 2021 16:10:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210914162228.3995740-1-andrii@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0012.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1169] (2620:10d:c090:400::5:1c4d) by SJ0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:a03:33a::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 23:10:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fc42114-90d3-4abb-d5d1-08d977d4d70f
X-MS-TrafficTypeDiagnostic: SA1PR15MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4644DF0DA364073C20CE664DD3DA9@SA1PR15MB4644.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EiN6oIaYrzFlVbKktkIyCxd9SMn38Q3yqAnyw8wml4zpFBdqT5cUkDiIF/b8XRUvMXYBOgmP4CEt7O5evQ4gQJ3lGrLzOPIjoxVSCQfYx6R1Oe/mdjNdvC9qJB/7JvYDIIJfj0VQDAnmxFAFPF+qJbfjauMstF45NNy8K7Vw3zASoJZKQkF/baqv6vS7qzi2XIq0UFC79BG6U5P+t7rkgZpTXw5OX3HArZpfgZF6KP5Cknro85Uh60OGTzyGvjNk51869ro44SvEAny0Ye0EksUppu+5wB6nDo+79plf1yRWzqm6lkx7+Ys4l34NwJVQB5e/WsqjQmGF/YfoNlGjxwFFE7w/5AXVFp34SXAAqis7gG1qL4d6fnbnckpCvzLHzH4jl7LsRNSTUgCCrTGRwsJGQ+PO0ORHg4U39qBPn3yuKhnhNlJzhvaQ0ypDoKEONetMGmzgA9Z+YAJ8ZEzACqHAnSRaLb5oC+Q+Hi6YrfnYHlB5MO4uy9uSQVoCmyjDqd6r4auR5NL6Z/+skYw3NllRINzySEXq9nA46tcHdZyn7EXzdPXVNbhQi4wPVadNb5kCQYZBOF57u2sqMtmK8SYOJEpoozRwp5lMojTZnCT5mpiK43elzsdiQyJQ159rfrDns3DX2iab5GNBi5YH/XtClDBVSM80h927zKxPJe7CNJv7SysErTgh3Dw7n8Xs2h0agw/pOHnlBAVdQiw98EIs5/s/3JdiMiKvoyM6pMHqvPwHv73xL/RxMqCqNeig
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(4744005)(2906002)(52116002)(36756003)(38100700002)(2616005)(4326008)(186003)(86362001)(8676002)(6486002)(31696002)(66556008)(66946007)(53546011)(478600001)(5660300002)(66476007)(8936002)(316002)(31686004)(142923001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0E0VCt1OGVKVk9NaFVjTWR4cktyRFplRUZ1MDZBa0oxYVpiRk9EeTRmTFN1?=
 =?utf-8?B?eEZhKytXK1BZaE9pWVQyRGxZV2FCMzJjb2ZXSERoU2ltQkdROVMwQWJ3ZWFC?=
 =?utf-8?B?d3R6b3NkS0dVZ2RvdWVVY1V1UTc5MW5VUkFBSEhwU1JzS3JNa1pHb3duYVNT?=
 =?utf-8?B?YUxrQ2JzaXJTZXVHTVBaUUV0Q0hmRW5jaXRNSXN3Qkxxb0p5dUxyb25Fa3VJ?=
 =?utf-8?B?dXdVTFVvUE9jQUtDajUvTFg1cmZhSWdZMG1pSkFQNkxkYTVmdE16Sk9Gd3py?=
 =?utf-8?B?NkkvREhrVm4zenBvYlc3TUhMQVpRZ3JZZG8xdk5EaFE5enpLMnVPbU5iS3du?=
 =?utf-8?B?eFVCWWNLZXpMODJDK2JzRHA1eFVVck9oUHBnSUswcnkvajcwSGVIbEZJVnEz?=
 =?utf-8?B?WUF4Y0RkVGgvaExINGoxbDhLSUFBWXBhZDhaa3dDOGFvODhoQ2tZeUtkb2lx?=
 =?utf-8?B?eFdBYXgvQW1pbG5qMEswSFR4VVF1OTRqODJMZzhNa3ZJaldwSFQ0d24zeVp0?=
 =?utf-8?B?NjUrWkhXWERNTGJrUVNSZ0lyTTE5RGpkSmxaZ01qMEhtSS9YeWthSDRpKzYv?=
 =?utf-8?B?TG9nbE1CM1dxUldyd1g3K0hJTFMrRnpFbUx0YXFYZ0ZTYWRPVE5iblh4M2hV?=
 =?utf-8?B?THlvMWhTVDAwTlkrYXJPTEFkV0gybzAxT2cvYkJZKzAzck01aXFRTWJZSlBr?=
 =?utf-8?B?QW1FYW12cDR5L1o0VDBVQW9RdXJaQXdtNm1XbTlpNnZTN0ZBZ1pNSk9YeWRy?=
 =?utf-8?B?Q295ZWRXUUp0RWFXYXU4RkxXamRYUExwK3lQSGkzajFxR3M5ZGZvQ3NkMmgv?=
 =?utf-8?B?R2J3ajJCNGxCVEU3ZEVaS0JLUTFacUs1TndtZG9CcGJrRnNteFhLdWRGRkd2?=
 =?utf-8?B?SHRsbGNGRDRJM2RGb1k2Vng1ZTNXV25uOGxGWHhqTEs3TWJTMFFTcnN0bGpJ?=
 =?utf-8?B?cmpmSGNnRy9GM0h4SUxxbTVKR3RYN21WRXJSRm44T3pOUjg3a09aeUNmY2Yx?=
 =?utf-8?B?UGxwd1dTa04vdjRDaGtOcFQ0QzB2N1lyd21qU1ZqZUNXVlVxWUthdlZadDQx?=
 =?utf-8?B?R3RJamhnN3hjKzQvTzN5RFV4THhhMWpFNnN3YUpITnVnVE1JekFOTDI1K0ha?=
 =?utf-8?B?QTVzaWZYU3JSVEhOcm5FUUh6YUFmbVlUb1FrNTJxTi9vSTBNWHovVCt4aUpF?=
 =?utf-8?B?TndkVEVBVytXUDNYNzd5M3NEcG1QNTdTWE1mS0J3RW13Yk5Ud20rYjd1dUZr?=
 =?utf-8?B?QXo5YU92VmNjZ0FCRFFjZjNkYzRhUTN2b0Q0aFh3c1dSNERIMFNyb0x3bVVB?=
 =?utf-8?B?UWpTQ1d6UXJpWUMwN2llV1NXSXUzZHdiYVlhRG8zcm1ubnZzQjRObElOOFhW?=
 =?utf-8?B?NzJEa3Y2Nmx3VTZyN1htQWRGT0c3b3R3Tkw2bjk4VStIRytsSTM4UDB1cnJk?=
 =?utf-8?B?aHlIRmlhWmtKYkpFenF6YXZ6V1IyV0llWEFyN2xxM3gxMFBjS0RSdFIrL1Rl?=
 =?utf-8?B?bTBhZDNPYkQ3TkRyY2VkUHN4bGRoekJyRXpsR05ORWJGU2s1Z1U2SVNRVUdw?=
 =?utf-8?B?NnNoZlNFckt2UlhFWm9hZFc0N3ExbUxUb1pwRlR3TUdvOFdLWFhiYmxWR0hY?=
 =?utf-8?B?OGY4bkVjYUVOMzZHL1djd2R1ODd3NnlDQUlyeEN6UWdqZkg4cUZJcVB0U3dJ?=
 =?utf-8?B?cU9tejdqbkt0dDliN2I0UjFGek15cUhQNGV6ZFpPN2gwSmVkREZQSm16SjAw?=
 =?utf-8?B?enBHaFhMY1hYNUhjSnNSd0ErVy9WbVZWQ01iZkNtaGdRK09May9TTHUvRmUw?=
 =?utf-8?B?aDRwV3dsY0ZRMXg1aTF1UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc42114-90d3-4abb-d5d1-08d977d4d70f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 23:10:27.5756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIiheHCcKnZk8DdLWtOHIYE79of2ehGAjzXE019Dj0HDuCnXWr5AzKXpgyvLv+eY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4644
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: JFpTS7QloxWN233Z7IVcMijYwldIMBIP
X-Proofpoint-GUID: JFpTS7QloxWN233Z7IVcMijYwldIMBIP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-14_10,2021-09-14_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 phishscore=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109140133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/14/21 9:22 AM, Andrii Nakryiko wrote:
> List all possible test_progs flavors explicitly to avoid accidentally
> ignoring valid source code files. In this case, test_progs.c was still
> ignored after recent 809ed84de8b3 ("selftests/bpf: Whitelist test_progs.h
> from .gitignore") fix that added exception only for test_progs.h.
> 
> Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule"
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>
