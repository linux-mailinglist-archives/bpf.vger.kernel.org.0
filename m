Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48563D5318
	for <lists+bpf@lfdr.de>; Mon, 26 Jul 2021 08:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhGZFkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 26 Jul 2021 01:40:15 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:19584 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231575AbhGZFkO (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 26 Jul 2021 01:40:14 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16Q6E3Pl026900;
        Sun, 25 Jul 2021 23:20:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=64vzNPZOWYGNV0JKuEuAFRUBa87QnXtJ3uZQkKhpaJk=;
 b=N7AWk0ib42SnDCxB94Ctpiq+dyN3YXEnNjpuprve1eRCMlhy0pM3PPjHLks/PSTZgIjN
 uFwR3ZgNZcJainTFEGS+rxk9cngtxY66VJh6BHcw76eNMv946v1VEM0jD7AIycXibsrW
 ovzdWKcYz7ahC4PHDpC0qFKVg3jqkLGOs/4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3a0fyy7qrh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 25 Jul 2021 23:20:31 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sun, 25 Jul 2021 23:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMNGCztwAw/OUqGSQC6nxuVd33sBWyh1nrBRG7Ejq/g9GSWh24hmbqUjuGq76pyXFWw4OfsTMEtX4ulUHDZvnEaiJLIyTlT5rw27klU2PqSdia3f3CWSOidBbu2dX/sVuKx0n7D91CmNXYx9xWUu7wqshnWW7aNgndE/1Eel00fAmzFJqgHJnf0nri0z3c3cX8EuyoorShAqJPSmoJKXJ7gSZYX7MVKtyILFahsBQhZqMji6+npDire3sROmV2r1YHuxtxtQCwOFVDeizUbJy5MsUAOoWMRh4Yl6VCjshZ4D65pHkyMPA943qeRTlglJRxmwqgkcrJr9Vv8sPEdHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64vzNPZOWYGNV0JKuEuAFRUBa87QnXtJ3uZQkKhpaJk=;
 b=JCYzhGaV5nvAv07IjSv13IMuyVp/wTpjzspKl2V2mfAVWZtxWowiP9vJYa2tPy0FvLUf+a24LqQFgCh53MIDhlj3Oed+m+W9ADRR2dOsJFy3UOrt3Z3UwUvp1nZ+c3FWV5gcI2Uhy1xBzsMgEeZJCg4+YetpoWsftIeWhEE2MU0kW7HghQT3j+ZuoEzmUVuHTW6g2gU5FpBwp/ovkZXuTsu161f2iAWRcFnb1/cow+ke6AITXDggARm2W0nFfYC6t4VRgqupepE1xFRPW8mnxVv4VuZcqqi/8ZQ4pEkCieea/XsMcld2pgnkHXdylPr1XiL0NbbJ6dygbnTqUxmdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR15MB2285.namprd15.prod.outlook.com (2603:10b6:805:19::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26; Mon, 26 Jul
 2021 06:20:26 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::c143:fac2:85b4:14cb%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 06:20:26 +0000
Subject: Re: [PATCH bpf-next 2/2] bpf: expose bpf_d_path helper to vfs_* and
 security_* functions
To:     Hengqi Chen <hengqi.chen@gmail.com>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <john.fastabend@gmail.com>, <jolsa@kernel.org>,
        <yanivagman@gmail.com>
References: <20210725141814.2000828-1-hengqi.chen@gmail.com>
 <20210725141814.2000828-3-hengqi.chen@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3bfc8755-bd34-2ff1-698f-57ad046726c2@fb.com>
Date:   Sun, 25 Jul 2021 23:20:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
In-Reply-To: <20210725141814.2000828-3-hengqi.chen@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0049.namprd03.prod.outlook.com
 (2603:10b6:303:8e::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:64c5) by MW4PR03CA0049.namprd03.prod.outlook.com (2603:10b6:303:8e::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend Transport; Mon, 26 Jul 2021 06:20:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d6e3a759-7edf-4cf6-e267-08d94ffd756d
X-MS-TrafficTypeDiagnostic: SN6PR15MB2285:
X-Microsoft-Antispam-PRVS: <SN6PR15MB2285E33819F94B67F0C21052D3E89@SN6PR15MB2285.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORegAkcJfreleEqWbpAWSXMr+/1h6GDyDhRhSN8s8Y7vPFS3mWBhDlEZWPM4cZxhrfWNnJisCEE30PM1HJqXP0gB/BLYTdOiNxjVw3MkogVjvhQZ1pKP+smNNVWzyE+Mh9ne7JFYNDH3O5I8yyOiyk1llZPwKblxMBwxg3cUBx0i9BUsQXA5w+snFCUOAa9sAQSGGRaRxVUtAVXW65Gn7wyvsdcZYpZVmKlRkBypm7MgzHu+1VkPAKRVweDzi346F1VXbDti18G7EwRA5jmYer9p3UQk0PgVyjIXslNBC0GBSk3Lew5CjDrBa0dr0M8MuUk9BkOo1urSJKdx+HymTg/bFpJBkqlMyqKID7yxFOcQFbCWMJ806AJ/KJU5/ctuZf8XOv//GDPasYciJyifmwC6IwyBYpUkClEoP3puAOqnvvCxsZmv/yGhM/aGFEOqlMhHCQonCy1BmvXFRYBv7A73EaM10Qeh26Aj8ETkoUCDZtdxIBtrHXufEExopQ0/gttfQxhTqfk1nRrOgq/QUn4aa6UbPCKY/Ir7L+xRzGL33npJChcMweOP+uQY3A9p3johevWsigptjKFUVn7AtV2NsMd1+8jgqpuULdptASryqKMp97A5ulD/XI9p51iAv/6f/2z28QdnqUB9XDIA28JdP8RzkA3go/FVM1DmBk2yog/QfB8d5/IEyRAdfYpaMcm8cuVpXXLVur2bhtxdD0waThDS4FaTdsqVs8ht7UjciI2o8tswON78mSrsELcF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(136003)(39860400002)(396003)(6486002)(52116002)(4326008)(186003)(66476007)(8936002)(31696002)(478600001)(2616005)(15650500001)(8676002)(53546011)(2906002)(66946007)(316002)(66556008)(31686004)(38100700002)(86362001)(5660300002)(83380400001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am05L1lFTzJRWGhzTGFUS0ZOa3FSWGt0M1JrMzJvSWNJK1d0VnhCSWJrZ1Y4?=
 =?utf-8?B?bExtZlUxVnFlYW1sTUxCYjFaWnlreldkRytHdVpybldwSmgySjlNcmlSNmR1?=
 =?utf-8?B?NElxdHRKWHh2aEFTSVpsc3h1SkVBTktoUUNVYjJGYkJlb2psRVNDNlBtbW9I?=
 =?utf-8?B?V3Bhd3IxVmFCKzRWeGdXVkVHalgwQXltQkQ0MjBrQUhkNHFlcVk0SS9Xa3dB?=
 =?utf-8?B?aVVUSGpSZzJSUEVHNnpOMzljUTNLK0szWGdVRW9EdFB5c3AxeHdRUklJMUdY?=
 =?utf-8?B?c0Y1dXc5ZXQ5Y3hLSEtVZThGd0llcmF0anFiQlJXZW4yTmdZQjJOcFZyNFg1?=
 =?utf-8?B?MGlIWWpkRk9ZZkV1bUNEbUUxdnZiM2FxL0s1YjNDNXJWY1JyaGY0bG1FSWdo?=
 =?utf-8?B?dzVNY0RQRS9qSHBuWE81d2NqT09rODlxRFdSYnpvZDdnQkJ3czg1cFc3ZGNL?=
 =?utf-8?B?Ty9WRXcxL1IxajY5eUhrcDFzWUFvYjVPZStvODBzRWJDREdyeklBVzVDOXQ2?=
 =?utf-8?B?a056YUFIMndvdmFOQzJZaXpDUmdXWStBRFFVUGlZdVNHc3MwZEora1pWa1Ay?=
 =?utf-8?B?bUtIVXFPem1wd1hhaTlxczlDNVFPd09tbTQ5bHl3WlVwWlhPTFV0bFlVa0RG?=
 =?utf-8?B?TWEvSmVmQTgyRlFsZXFoMzI5ZVluR2hHR0Y4V0J5aVdHL3ZqNjB2UEFMNGRt?=
 =?utf-8?B?ajlENFlKbWZuZVpFNXBVWnk1UmMwTHlWWnUvTmdPM2VLTENTOVdFVys5RXpk?=
 =?utf-8?B?ZDR4Ri9OeThiZ3kyZFJDZXRaUVhuR29TRGtmVnI1Tk5kQmYxZ3NOekdlRy84?=
 =?utf-8?B?WEhOVnhwd0NDemRuNk00bE53MUZOOURMVEpLaXVNamhqUUxHZ1BsbXdoUm5O?=
 =?utf-8?B?RlZCcFdRbXp4THZSZjBOcUNzZG0wWkxOMzdQc2s3d2FMTyt0VXdjY1VoeElZ?=
 =?utf-8?B?SkMyaklBZlAwbGFoektuc09XRVIyN280Y0NkMDFwTyt1MC9sWEd6dlRLTUM0?=
 =?utf-8?B?b29JYndWcGJyR2xwdXpldjBMWHFpNG1wR2dpSnVpYkdSRGp1WDNmeitnck5r?=
 =?utf-8?B?b1JodDUyRkcyUUdQMTVlZDUxTkRqdEhnWDlGTjhTS21aUy9vR1BxRDZ2NVFT?=
 =?utf-8?B?Q0RtNm9oZisrQllPVjZtRWhHRmYrcVdTSGhMVC9RK3F0ZDYxZi9XeG12cUMw?=
 =?utf-8?B?U25PanNpSDJ6bXVKWXB4UzVwcTdBTjFiWDZ5MG4yVkgxUGt5RHkwOGtWKzNk?=
 =?utf-8?B?YUU0M2VpcVFtMVJiY1VXZWI4dDZzUGU0SWtwcmpVcWUvdVgxb005SnM2ZzJT?=
 =?utf-8?B?VW9YazVEMGlNOVgvVmJ2WnBBdk85UUYzVS91cEloQzAwWC85UHhUZ0JSN3V5?=
 =?utf-8?B?MHF3SmpPb0t5VjROZkIrWkJhWjE5ZmszcENGZzN4dmlGS0pFcWFoZFNQZ0F3?=
 =?utf-8?B?YUQ0azBFOTlMUDd3T2J2TUFrblVOMmh0WGV5ZHpDSTNiMjZ2NVEzVGw2cjI5?=
 =?utf-8?B?SXY5cE9LQ2Q5Z3hEY2lZelY4am4zN2N5eUZEeXFLeXlqWW9JV245WWkxRGVl?=
 =?utf-8?B?L1M3WUZ5Vk9na2RhWFFlUFVVK2pIYUVFMk8yd3g3QTVzM0FYSVJuR3I5QmRR?=
 =?utf-8?B?VkNSSXFGbVhGQ2RkbmFmZkxjZ29SMTRmcHhWK09XeDZsdUh1K1AxZUpTWkpq?=
 =?utf-8?B?aEY0L3hka3NLVjlwVHRDV29jMHNrNU93bHFZZ0ZmL0xtdHpIWk1uaVl4enlv?=
 =?utf-8?B?ejFLbEtGUGF4N1lWWEZrNk5Wa3ZvYmpjNXhTeWtZK0dGVlhYQ0FRcDJDSDhx?=
 =?utf-8?Q?gA+4gsZADkc4PsMayyhObjeXQss4iWD1Brn5U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6e3a759-7edf-4cf6-e267-08d94ffd756d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 06:20:26.5961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H8M5Pnh2Vd3Pt11j498j7Ez9RxIYQIEl1d7nkgeaHQwQIoKaxW2T5x1ZR8z73maa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR15MB2285
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ZZZTRxogS65YGqWXyN3FTI_CFCmuBkwb
X-Proofpoint-GUID: ZZZTRxogS65YGqWXyN3FTI_CFCmuBkwb
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-26_03:2021-07-23,2021-07-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 clxscore=1015 suspectscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 phishscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107260037
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/25/21 7:18 AM, Hengqi Chen wrote:
> Add vfs_* and security_* to bpf_d_path allowlist, so that we can use
> bpf_d_path helper to extract full file path from these functions'
> `struct path *` and `struct file *` arguments. This will help tools
> like IOVisor's filetop[2]/filelife to get full file path.

Please use bcc intead of IOVisor.
What is "[2]" in "filetop[2]"?

> 
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

LGTM with minor comments below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/trace/bpf_trace.c | 52 ++++++++++++++++++++++++++++++++++++++--
>   1 file changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index c5e0b6a64091..355777b5bf63 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -850,16 +850,64 @@ BPF_CALL_3(bpf_d_path, struct path *, path, char *, buf, u32, sz)
>   BTF_SET_START(btf_allowlist_d_path)
>   #ifdef CONFIG_SECURITY
>   BTF_ID(func, security_file_permission)
> -BTF_ID(func, security_inode_getattr)
>   BTF_ID(func, security_file_open)
> +BTF_ID(func, security_file_ioctl)
> +BTF_ID(func, security_file_free)
> +BTF_ID(func, security_file_alloc)
> +BTF_ID(func, security_file_lock)
> +BTF_ID(func, security_file_fcntl)
> +BTF_ID(func, security_file_set_fowner)
> +BTF_ID(func, security_file_receive)
> +BTF_ID(func, security_inode_getattr)
> +BTF_ID(func, security_sb_mount)
> +BTF_ID(func, security_bprm_check)

Here and also below "segments" (security_path_* functions, and
later vfs_*/dentry_open/filp_close functions),
maybe you can list functions with increasing alphabet order.
This will make it easy to check whether a particular function
exists or not and whether we miss anything.

There are more security_bprm_* functions, e.g.,
security_bprm_creds_from_file, security_bprm_committing_creds
and security_bprm_committed_creds.
These functions all have "struct linux_binprm *bprm"
parameters. Maybe we can add these few functions as well
in this round.

>   #endif
>   #ifdef CONFIG_SECURITY_PATH
>   BTF_ID(func, security_path_truncate)
> +BTF_ID(func, security_path_notify)
> +BTF_ID(func, security_path_unlink)
> +BTF_ID(func, security_path_mkdir)
> +BTF_ID(func, security_path_rmdir)
> +BTF_ID(func, security_path_mknod)
> +BTF_ID(func, security_path_symlink)
> +BTF_ID(func, security_path_link)
> +BTF_ID(func, security_path_rename)
> +BTF_ID(func, security_path_chmod)
> +BTF_ID(func, security_path_chown)
> +BTF_ID(func, security_path_chroot)
>   #endif
>   BTF_ID(func, vfs_truncate)
>   BTF_ID(func, vfs_fallocate)
> -BTF_ID(func, dentry_open)
>   BTF_ID(func, vfs_getattr)
> +BTF_ID(func, vfs_fadvise)
> +BTF_ID(func, vfs_fchmod)
> +BTF_ID(func, vfs_fchown)
> +BTF_ID(func, vfs_open)
> +BTF_ID(func, vfs_setpos)
> +BTF_ID(func, vfs_llseek)
> +BTF_ID(func, vfs_read)
> +BTF_ID(func, vfs_write)
> +BTF_ID(func, vfs_iocb_iter_read)
> +BTF_ID(func, vfs_iter_read)
> +BTF_ID(func, vfs_readv)
> +BTF_ID(func, vfs_iocb_iter_write)
> +BTF_ID(func, vfs_iter_write)
> +BTF_ID(func, vfs_writev)
> +BTF_ID(func, vfs_copy_file_range)
> +BTF_ID(func, vfs_getattr_nosec)
> +BTF_ID(func, vfs_ioctl)
> +BTF_ID(func, vfs_fsync_range)
> +BTF_ID(func, vfs_fsync)
> +BTF_ID(func, vfs_utimes)
> +BTF_ID(func, vfs_statfs)
> +BTF_ID(func, vfs_dedupe_file_range_one)
> +BTF_ID(func, vfs_dedupe_file_range)
> +BTF_ID(func, vfs_clone_file_range)
> +BTF_ID(func, vfs_cancel_lock)
> +BTF_ID(func, vfs_test_lock)
> +BTF_ID(func, vfs_setlease)
> +BTF_ID(func, vfs_lock_file)

I double checked that for the above three lock
related functions (vfs_cancel_lock, vfs_test_lock,
vfs_lock_file), I double checked d_path
does not use these locks, so we should be fine.

> +BTF_ID(func, dentry_open)
>   BTF_ID(func, filp_close)
>   BTF_SET_END(btf_allowlist_d_path)
> 
> --
> 2.25.1
> 
