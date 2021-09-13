Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED854082CE
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 04:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236880AbhIMC0x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Sep 2021 22:26:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58966 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235364AbhIMC0w (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 12 Sep 2021 22:26:52 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18D0CsWf000911;
        Sun, 12 Sep 2021 19:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=CWEAc6HghwcICLCDOy1f2HBIJFDL9JLDqn6bZJT33Bc=;
 b=Pu/njGtrN+72evX0fYxcM5ZjUe16LsW/9w/Jef3z+IzI7eNgd4u8/jYPqG21QSAySvpL
 wwNqPOb65ghiQQWHQ7NeDI3LOI7IjI4x1AWdtsEnzlS2TDfzfpPr4J0o6O6ego1vHBfx
 ZZwSCz8J2s+esoWUXSXXSU0p/Y0L8AzhBp4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b0syx6y76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 12 Sep 2021 19:25:15 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Sun, 12 Sep 2021 19:25:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zwnw5xOICJIA7s48hmyxddPHJz58/adWZjEkya9jWtk7JHb9hxmIj+cTIQfVmIafQRR3LU9iqnOXv9cv0Vol55WLk8QkgDuogR0czZ8gnOOJz3Y4S0nZDQ2tDDb6ikg0dYGaYA4tOQzRKn+OSA5KHAAHzm/s7ujUtvi/v3OynH9ate+YBbCD7w2h8R0elN/VrN8GUbxuh/p1TWTiRsYwiTCYe/PQe9I44acE/OMB9S5LRevAg2hj1pMePq3JqWEgBWFU5Gu7nGaIfn/xcgE2Yprz3u1kNpln+KfdNP8imR4/D9AOzGb/FEu/GNJk8EqGkrj8I2Bpi8BSE/9R5SP0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CWEAc6HghwcICLCDOy1f2HBIJFDL9JLDqn6bZJT33Bc=;
 b=NkqFeAmta7dg4K/4n/Q/7q16tqXSmAoO/iL6sakK7wl4Ot7Sks5FGeUaY1WAx5cHXaQlBSYTjIwhV+duWr4sjOYG9hXAb2emsBLZxlG7s5KFqNtlZ6Zwd8MCJJ/mBX9STcrbA4ajL8ZGfMM/5Lk3y/ws8QyQyqm+XtuV34CqXbWDtXmfInPxXYnqC2BV7TEj9uIGR8P6uCoigtM4r4jLtdFy/DsSf548x7UBz7EuOYdvV95SwgIjQiualSANcjLXX3JzpI/vkqD7PRpbHja8FKGMhhPnopxZoUM+NGqIbvtTF3BVhSUiXUo7DRsXOsyF/6IIYwXLvF4KB8HD+DQucA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3760.namprd15.prod.outlook.com (2603:10b6:806:84::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Mon, 13 Sep
 2021 02:25:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.018; Mon, 13 Sep 2021
 02:25:07 +0000
Subject: Re: [PATCH -next v2] bpf: Add oversize check before call kvcalloc()
To:     Bixuan Cui <cuibixuan@huawei.com>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kafai@fb.com>, <songliubraving@fb.com>,
        <john.fastabend@gmail.com>, <kpsingh@kernel.org>
References: <20210911005557.45518-1-cuibixuan@huawei.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <39ffe740-0092-61ee-5af7-8de41b5700c0@fb.com>
Date:   Sun, 12 Sep 2021 19:25:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210911005557.45518-1-cuibixuan@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21d6::1021] (2620:10d:c090:400::5:941f) by MW4PR03CA0183.namprd03.prod.outlook.com (2603:10b6:303:b8::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Mon, 13 Sep 2021 02:25:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc3c3190-7ec0-4a59-e277-08d9765db3c7
X-MS-TrafficTypeDiagnostic: SA0PR15MB3760:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB3760D275B4C97833E781CA6DD3D99@SA0PR15MB3760.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f7ajL/hX6CmLXuu/OGhzEijn8DxxYS9SCxrrapCM4CoN5+Kqz8zHWrJB5yBr0xBSnPj+1fhka0qujn9e3FARzzW9Cl/NzCpX+VKLgVepDopAYhjg44HohsMnln6Dudv7GfbTE/Hf8TVsFYfHFQeLx6rlsOtiuzd2KyYEvRvL6A9fqUsz7yuZ+oRfDZcbwTke5fJyfrtxMFWZiEOeI/iRt/2E7kepKWBMiIM0vCXzKvLSmQ+nn7glrP4Ds9bF6Soc32xtkYYYzfPKiwIRYriKOtr1ZbdGeOIcvVrKn+di9j3CNYj8N5G6cCXgDDaIcxGrNoWMMM8ZuUrXqM9ZNIaKxWqsyHg+hbvby9E5xcgWr1zPrHj8N05M4Khd+1Kbak/bfGl2bC7NGXZ8WjFIe47du+XcNkTvWsshPdyJIc3RrDEOGNcJlZkpR7vTn+CgZZInWiokARnNYm7zArOyhO/09VdOSvYRnoZVCFU1tugupElF+IrRCE53h2VgEhzP8N1v5YD5Sq4a6S7tP5m/mXYg6pwA3gWFa+73iOhd7wTNjm4RWZu+t1WDrtH7ejj+naSs2OYKwz3HzADEYUFmmbRixvbwR3QL8KngpZ1v3164O/pzR16nM5+JO9a36yvEyF65Lg5/siGjESfmHWzl8KVtyvT5pRtM88jKn2HubacoemCB/Bag4pZA7PJnwa9t05vB6QOf/EDLtqHBGS+Qp2CsaiXGaB/BL+TwHw5yUMrX/a0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(186003)(2616005)(6666004)(66946007)(36756003)(2906002)(53546011)(4326008)(5660300002)(52116002)(478600001)(83380400001)(45080400002)(8936002)(8676002)(86362001)(6486002)(31696002)(66556008)(66476007)(31686004)(38100700002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eW9yd3dnVXRUbXN6SzlkSzFPaEErcGdRYkF4dy9yZCtaWXh3YmhNUzVueHBN?=
 =?utf-8?B?WWN2R3REbzFWa05TTjVmMUtxc203aXp3Vkp6SGhoZGJ2U3gyK1RVU2IxeVFU?=
 =?utf-8?B?SExaMklDc1NTRGhUMS90b3FBeFFtaURVNlQ2THBmTm93eTMvZzd6a0ZpU1JO?=
 =?utf-8?B?eXVOcjlic1BNb2ViblQ1NHRqYktVSStCRmxENzZIWi82c2ErS0p1cG9jV01p?=
 =?utf-8?B?aVVKUVhPeTc1b0tNV2ZmQWJqT0RKVnZYWENNVXRibTF5b2twQVEwZkJFZlRT?=
 =?utf-8?B?ZFIxMjdDYW12WVQ1M0xwbUNPL2hXbjJtM0dLUnl5UzRpd0ZJR0NsQk8rQkxM?=
 =?utf-8?B?VFVCSkxmOGQ3NHVHdjFIc0szSjJCNVp6aDBIRU9Fb0JiNk9Idld0MkZUWkY0?=
 =?utf-8?B?SHpsNlZya0dWR3J6WlBrNnFmWE9FTEgrZXhHOEhhR0F6dndMOEJaWkZKM2RF?=
 =?utf-8?B?aUZHWm9id3AvU3BWMjk3cmFrU0VTY1lPOUJzbHkwWTJVTytINWFOU3UyQjll?=
 =?utf-8?B?OXNnSnFod05ScnM0VmkycXVFc2FuS1ozM2V3NFZpVU1nMXl4dnp1S1BmZ1Ni?=
 =?utf-8?B?KzZFbVZtaVZjUnAreC9NZUVxZzdYOExzZnpxbThMR092SEJPMXIreitxeFR2?=
 =?utf-8?B?ak54RGNZcDRDRFZ2MGdYTkZHSEU1bFIrd2R2QkdpNDBYb3J5WXFDMUd3MGFL?=
 =?utf-8?B?TGRMcFY5d2JIaXY2OU5tajcvcVV2clZlbDFUMExFbzNCRHhqM25jckp4RWhO?=
 =?utf-8?B?VTA1VzB6RXMrU2k5NDJZVmJFbmpjUzR3WkpFR0IrNG9VWEJPZmtUUHlFSU15?=
 =?utf-8?B?OFdPOXhHbjlGOUhYa1E1ckY5NVY2anphQzQ2NVdjVGJrcTZkcUF0QVpwWWJ5?=
 =?utf-8?B?REZXZmhqVEk5NndpcnM5SzFLR2RsdEJFTkhYWWhBeWRZM3pBM0M5c2pOYVBC?=
 =?utf-8?B?NDMydHlXTXR6VkkwSmVxZlNuTGFOZEFYODN1dkNneUN6alFXRThmUThDblNq?=
 =?utf-8?B?Y3BpSUVZNVVtdHhNR0ROR2ZnWWlPKy9yanNoRTg4SnFZa2dhSDBXVndwdlVi?=
 =?utf-8?B?Rzdad1U3QnNnZzB6aStkVGhoa2tiaDYySldpS20vVm8yMEhYVmlDaFplaW5q?=
 =?utf-8?B?OHNRdGNsMlFMZnA0VFlXTHR2MjdlYUlkYTJFVE8yaVJ4UHgzUzFkQUk0LzZH?=
 =?utf-8?B?ekd1NlFIMlo0ZWVlNC9qVlVhMENGdW9hWWRIUkJMdC9QMkNkbUpmVlk2eGJw?=
 =?utf-8?B?Rnk5ZVNkREo2VW9HVEh1L0ltK25Ec1VDTm1DMHhGVVpBeGhQdnllekpwVC8z?=
 =?utf-8?B?SVp6eHB6WTg2YjdoSkJaS2d3cStFQWQ3WGN5RWdhM3hZNWd2NlM4NjFZUDAy?=
 =?utf-8?B?SFAveU1sR0tCMk50VkpwVFhvc0NhVDNLQ2xyczdZdFE2bFBPRXVKUnBtcGVp?=
 =?utf-8?B?dEFCQUZ3UXBjQm94QmFYSm9pdngzSUVraE9DZ3huYTZJYUprOEJQTy9iU1pk?=
 =?utf-8?B?ZzdUNzNBcmlTbk9sU3lTQ3pTOWJVNmt1SFJGOUFLZVJLaHNJUStJdWxwd2Yy?=
 =?utf-8?B?SVZZSUlFVTdNc1N4dllHOU9IK3NPVHo5MVowaDllUHZSUGRmNmw0VEphTmdm?=
 =?utf-8?B?aXI2R0NUQ0MvMi9IeXJ1QkFlc21XekZXUEtnZnczeXdVWVlvd0pGQkRpUGZa?=
 =?utf-8?B?RjgwbDNnSE9OSEFYNGtJVDhKeCt5aTNleHVGT3ZPS2xaZGtXK25uWlhqNlBD?=
 =?utf-8?B?S1FzeGVNMGxNd3E4VGpjYjFXaUVCUW9HOCtaNTI3YWtXY3g0aUMxaStJUlVS?=
 =?utf-8?B?NlFqcnRHdnJ0UVFGcE9pUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3c3190-7ec0-4a59-e277-08d9765db3c7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 02:25:07.1142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 82pDvQPA3yQ34tUB5yjO0GhJHrwUC0wKc54ol61hqgYBUJ+qk5YbsINeOwDowrtB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3760
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: a9OpBy05VQHUdZm8PSZxYPOz2N9JNjJD
X-Proofpoint-GUID: a9OpBy05VQHUdZm8PSZxYPOz2N9JNjJD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-12_10,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 mlxlogscore=737 spamscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109030001 definitions=main-2109130015
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/10/21 5:55 PM, Bixuan Cui wrote:
> Commit 7661809d493b ("mm: don't allow oversized kvmalloc() calls") add the
> oversize check. When the allocation is larger than what kmalloc() supports,
> the following warning triggered:
> 
> WARNING: CPU: 0 PID: 8408 at mm/util.c:597 kvmalloc_node+0x108/0x110 mm/util.c:597
> Modules linked in:
> CPU: 0 PID: 8408 Comm: syz-executor221 Not tainted 5.14.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:kvmalloc_node+0x108/0x110 mm/util.c:597
> Call Trace:
>   kvmalloc include/linux/mm.h:806 [inline]
>   kvmalloc_array include/linux/mm.h:824 [inline]
>   kvcalloc include/linux/mm.h:829 [inline]
>   check_btf_line kernel/bpf/verifier.c:9925 [inline]
>   check_btf_info kernel/bpf/verifier.c:10049 [inline]
>   bpf_check+0xd634/0x150d0 kernel/bpf/verifier.c:13759
>   bpf_prog_load kernel/bpf/syscall.c:2301 [inline]
>   __sys_bpf+0x11181/0x126e0 kernel/bpf/syscall.c:4587
>   __do_sys_bpf kernel/bpf/syscall.c:4691 [inline]
>   __se_sys_bpf kernel/bpf/syscall.c:4689 [inline]
>   __x64_sys_bpf+0x78/0x90 kernel/bpf/syscall.c:4689
>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>   do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Reported-by: syzbot+f3e749d4c662818ae439@syzkaller.appspotmail.com
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>

Acked-by: Yonghong Song <yhs@fb.com>
