Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AB4D584236
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 16:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiG1OwR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 10:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbiG1OwQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 10:52:16 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED775D0E7
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 07:52:15 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SCrYDl024804;
        Thu, 28 Jul 2022 07:52:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/cURauBZCALZNhRFTqMIQnmYJeCqYJfu48tEmvZEwOU=;
 b=RJMbRCr24q/7Zra6ceRJEIbYr8P2rhON49RNDnjJXt2WFi+875cBHpj+NlfQLy38Ra3d
 cgJPBRJnQG6PGTUOi9m8EjBeuNP4jSKfmkYuBCejWKg2nOM7/NGv//mAHpgInUqqR9Zv
 /zGpyI/4CWuRIvb0sZYwHk9bfZwrhWlP80o= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hjjnsyqr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 07:52:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PxGG9lcqY9apkRfrqF7ndrpXkYL/WccKC2dwIH2ELunPk5KGI6o14voQstUXBrp5lq9nvEkxDI85MZFcbGhjHwbciqMd+rIs5wX7mTnjQ8Ajdz8rXaktlXrewDWngT2FrXUMDyCPjT4gupmxbFx+EuAifBneYM+au1gaTqRrIz+w4l679/Be+SI42NOm0DllkLfB62ZYAjR3IaFWtA+UuFNfnhc7qbclCcT3U10R1EzVNxW++9CTf/sg7PO2ZJQGaF4q5wnOLEIn4B2hPd6DKTrsQulvM1rLobjkKArkrxkxGktkhYjXa/Gww5mp0pQo9wBY7d1bnK2F4vy9ptQC1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/cURauBZCALZNhRFTqMIQnmYJeCqYJfu48tEmvZEwOU=;
 b=GQ9rM+IlAsWusWesmsi6NOyPSeLan7QlJ2KcpfJ5dk466XZoOpS0GJAoZjPajywKRBonZxv+/FmfYuRc3+AWI8NoScl+6GmggoUXHNEA8DFhfmryJUJR4zSoIlFwqUzd1iAAcLsfKKfPaVqJfOV6IJk+9qLL/j4MJs5/O27XSzgLmmrvWJRT+mqvNRiZNxPmDTmCnfYbUYliI3NcsfxG1pmci2Ie3EeyfGWrm7VN+U6EMxe82ukIljMSBsyFiUBlZaq81vcBmsTW5IvJuLNGLl1wtYzVx3wtYqmXyoG65O9PAM1dnQ/J36440kKxAazuY8rFHMLH6gkh41pXRF2Qmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO1PR15MB5052.namprd15.prod.outlook.com (2603:10b6:303:eb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 14:52:08 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 14:52:08 +0000
Message-ID: <44fff416-49d5-458e-c464-e15483e2c90a@fb.com>
Date:   Thu, 28 Jul 2022 07:52:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH] BPF: Fix potential bad pointer dereference in bpf_sys_bpf
Content-Language: en-US
To:     Jinghao Jia <jinghao@linux.ibm.com>, bpf@vger.kernel.org
Cc:     davem@davemloft.net, kuba@kernel.org, ast@kernel.org,
        mvle@us.ibm.com, jamjoom@us.ibm.com, sahmed@ibm.com,
        Daniel.Williams2@ibm.com
References: <20220727132905.45166-1-jinghao@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220727132905.45166-1-jinghao@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:334::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a14eee04-1877-45f7-01d9-08da70a8bec2
X-MS-TrafficTypeDiagnostic: CO1PR15MB5052:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4wXaiXttCVWFWM7m4GJRo3Ys0j+e/9VKa7EhgSEShj9iRaFbmg9nGRQGUobSPY1X89A2le0zsJzWpKcZjKnDSsGGdAas8/jZi8CLRpotLY/YBJrMQy7YNn32vIbuJDKRxfsymb7XbF2EK8pHgrpzN6N/uUZRwNcFYa87mdwCMfO1JyZd+FQAWT8OmWY+gX62EyVy1rexDotPVn+vWjnhl+N1SJIEXpUWXgjriomjwDwf1Tfm3jffr+k33nfN1dRfVVl8ysf4G6Kltipmy9wKUW5v/wRmYFTJwbrj6/UrY8Trf/ElNDMRFm4OmTbFgok48jYQojd9VhGlzSsqlHs+k6EZCDN86wWlRiH8cyArgnwEolsS5Wz74ON7OwOOMGlt2WcbRZAX/oMRew6JkPI5qzMI2r3EYaNmllHIMPwDw3b9zhVbhv49gDKgKcCglFPVrBlr9EeD9Gpm0MofgDMiAimlqm6IGSRQRsO77j4MyIroS+4xMovaVvT6Is4RC5stRcp7CHSysolLhKaPT135Toj2THNDSF2z2/k85MPfz3HRPx5tN7d8gzvo8AAzHvsn6JvRc3tE/VaMfE0REuEKZ34UjBPHJv+yn7IPX0B+Srvz9N7cgehjdjB9U4s9hWcHGYZCD2t0Ac5qqYXmspPC8xwnFTKDqKWyk7tFiuiGmoAMZa7NTcao0J/NST3wCsMVP5Ol5ccyXEqNIjHPMZziap4OqjtF28ThxIqkOGESLtesX1+LXfGzc1g/Zg48aIN3bX6tALQQmMY14M4sw++ZMo6sE9IJ3HxQAUxna/nd+4d6UUcbd+xd72nTGeDbtH1NdEBrzhqZPscU+sIxeiHupUimE1n263f7/foCU2LRcxPSu7n9Ph6f1KWtwPZDERSEIcaBH79Qmh1ymYYrUk4Xcg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(2616005)(186003)(66946007)(66476007)(66556008)(4326008)(8676002)(6512007)(966005)(6506007)(41300700001)(36756003)(6666004)(6486002)(478600001)(53546011)(8936002)(2906002)(5660300002)(316002)(83380400001)(38100700002)(31696002)(31686004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjhhdUFlMGlJbUZwajZGVS9uanhDZTF6MC9pSGI2MmFEWlNicFN6SjhZTi9w?=
 =?utf-8?B?WmQwR25wWW5XaG93dFA0RnZsMFN6L2w5TTVXcWJxRnAzcWxGQkVXRzJjT2xt?=
 =?utf-8?B?cG5haVBId3VHVXlIQXVMU1QvQThlOHkzQWduY0d6MStJWnZSRENNemZpT08w?=
 =?utf-8?B?K0RDYVQrUkI3cHBYUE5TTmlXVUcvMHcvRDFzZ3IwOExXN05kV3gyQzBPblgx?=
 =?utf-8?B?UGtyUnNmTVJTUUMvdk1PaU4xTzFuVTgwcVJPcThiWXNRcS9GejZCOXdlcWlj?=
 =?utf-8?B?QzB2M0c0a0YyL1VHSjBNSEQwSlM3T2wzd3p1T3dMcTJjeHlsbWcvWEtSU1ZR?=
 =?utf-8?B?OW53R0dhcnhSVHZwRUxrVlhHNWNYTlVGQnNyejdXblVVUmVJa0VQVGhpRWFx?=
 =?utf-8?B?N0tZVEU5b0p6dnhRR2VSTHNwaXpHRWZFWTFMVFB0WWhzUmdCTy95UUtvRVJN?=
 =?utf-8?B?YXJ0QnFBaUtUY1RIQVNyY2IweDJmWXN2ajdVWG9kdUthQ01zYXcwaE1KQ1ND?=
 =?utf-8?B?MzlqN3h1b1RmWEdiTlhIMEhPdGRKNS9xSVpXUm5EKzl6Z2FtWGxoY1BlQmR6?=
 =?utf-8?B?NDE2UU9KOXFrUWRNdEMzZHdQZlNPcWhBMXNZaWdHOGQ3YnUwaDRNbm5ENDFm?=
 =?utf-8?B?VWtoejFudmgzRFZ4TjFaTzVCaUpXTEk0RmVZdVZiWHpSMUhlYWpoTU9TWkxh?=
 =?utf-8?B?QVloL20vUkZOYlA2TVNjLzNwTlNIam51dUErdXZMblhvekkreVBXdkN2dzY4?=
 =?utf-8?B?dWtaYjVvSnpNTDZZVkxvWWtTN1dGZlRRUHg4ZFlkQ2YvWlRlVXd3bldyejJt?=
 =?utf-8?B?VE4yYnpCSUhYN2Y5Z0FIc3l6ekk3WmdzRUpWYm1zeHVHT1BKOUZHR2RzUnNX?=
 =?utf-8?B?RjhObjF1ZVpyQUZQS1JSOXMwcVVScTVhUHFoZUlZdnZPYmFFTVRjUGhIcmZs?=
 =?utf-8?B?bVNLVC9oQ0RoZWlMOFUzNjZ6RTRINVRldGNDeEhhMTRmdElNSHdIdlhzbW4y?=
 =?utf-8?B?TWgrRkxvVGRuR3d1RjNRWUQ0RnZwY0txcnUvdUpVSi9QdDQ0bUlkS2ZEVVJ1?=
 =?utf-8?B?Zzd6dlNQSHA4ZjYxc2JtbytpTzZWTjdQTGRzV3RlVUNvcDVaeGV5VFBOZEow?=
 =?utf-8?B?TVhaZTByTDZYNW9YZUdlWGFNWm9nRDlFT2R2WGMwb2xFc0grL1RCcWk3SGJ6?=
 =?utf-8?B?Szk5azZ6SlpRT0hzU0tYemoxQVpSQ3dZUkRhVy9vNFU5VGgyOVBWc1hGZlZK?=
 =?utf-8?B?MHd1Y2tiN3RPZjJ4MXBYc1ZyK1FQM0EzcVMvN2lPNkRUbG1Gbk00TGV0b05X?=
 =?utf-8?B?eVl5c3hpcUk2UnArVWdZdEsxaDJlbzM5YVFMWEMvTTNldjRkVWdkTFlMaUJy?=
 =?utf-8?B?MU1HZnovcmZFZ1B3OVRWMFh3b0EzSVdSQVBrenRqekRwb1RGdGpUbWlLdlA0?=
 =?utf-8?B?MW84MEN0RGZSK1N3ZkJvN1VyT2FkcXo0QWFXb21BWkxCNks1V2NpOU0wUGtS?=
 =?utf-8?B?dll1Z25jTjNTV1R1MXE5N1NNaURoRnd0ek9SajZxYWZRenFFNEtnUGVJczlJ?=
 =?utf-8?B?ZGNjaWYzKy9HSHlLYVBsRHFaRklpZEZidWEvMXY4NWhVd3FEWmxxdld6VDFy?=
 =?utf-8?B?NjRDWFB2LzB2WGF2Q01GS3hYQUJkY2tBb0ZDMmZuc1VOM2NDQmY0bk9yWWtv?=
 =?utf-8?B?SHc5dm5oWk1lNTArbnl3LzV3OGEzL0hvNlNIdkpyZ2I1TFlvRmpTcktTaTBy?=
 =?utf-8?B?N1pYREp4SytkSTZzWnV3b01TQjdjaVl3enNPbmZjd3RiWmgyaFFKUm1SSjdj?=
 =?utf-8?B?Q1pwRzJwQzI0SzBZRWd1eW8vNWhkcHJxQUY5bXpCRUQycGZtSVpsL2lic0pw?=
 =?utf-8?B?SjNXK0pWVjI5VDB4K0NOL3ppRmxGd0RwcUI1dGtFV25ia21IbGE2aUZuUVIv?=
 =?utf-8?B?a1ZPeVA5N2hYc05velhyYWF5enZFekpqVXkyN2ozbC9raXk5enQ3bC9yRjVC?=
 =?utf-8?B?c3U1RHl6K1NSV0g4bUZVYzZxTHh4TjZQbXNTWGhNYUQ5K2JSMkhhYUUvNkxq?=
 =?utf-8?B?QUl5ZHJVMzdXTUQ5UGFmY3EwNFd2RW40UkNrNEhlS2J6ZEczNXN3Q05oQWYv?=
 =?utf-8?Q?MK/mj+dKOW4bQwtHG7Yeikb11?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14eee04-1877-45f7-01d9-08da70a8bec2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 14:52:08.4954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UyDBA6xWaSWCDxG1Vkpt5VTJAnt8RsRICPDy3oNmi5n22HqjpQ23+iXqDhT7gP6j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5052
X-Proofpoint-ORIG-GUID: GiMcWtTi4i7lK2NWPxXsS_fgrm39142Y
X-Proofpoint-GUID: GiMcWtTi4i7lK2NWPxXsS_fgrm39142Y
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/27/22 6:29 AM, Jinghao Jia wrote:
> The bpf_sys_bpf() helper function allows an eBPF program to load another
> eBPF program from within the kernel. In this case the argument union
> bpf_attr pointer (as well as the insns and license pointers inside) is a
> kernel address instead of a userspace address (which is the case of a
> usual bpf() syscall). To make the memory copying process in the syscall
> work in both cases, bpfptr_t [1] was introduced to wrap around the
> pointer and distinguish its origin. Specifically, when copying memory
> contents from a bpfptr_t, a copy_from_user() is performed in case of a
> userspace address and a memcpy() is performed for a kernel address [2].
> 
> This can lead to problems because the in-kernel pointer is never checked
> for validity. If an eBPF syscall program tries to call bpf_sys_bpf()
> with a bad insns pointer, say 0xdeadbeef (which is supposed to point to
> the start of the instruction array) in the bpf_attr union, memcpy() is
> always happy to dereference the bad pointer to cause a un-handle-able
> page fault and in turn an oops. However, this is not supposed to happen
> because at that point the eBPF program is already verified and should
> not cause a memory error. The same issue in userspace is handled
> gracefully by copy_from_user(), which would return -EFAULT in such a
> case.
> 
> Replace memcpy() with the safer copy_from_kernel_nofault() and
> strncpy_from_kernel_nofault().
> 
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/bpfptr.h
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/include/linux/sockptr.h#n44
> 
> Signed-off-by: Jinghao Jia <jinghao@linux.ibm.com>
> ---
>   include/linux/sockptr.h | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
> index d45902fb4cad..3b8a41c82516 100644
> --- a/include/linux/sockptr.h
> +++ b/include/linux/sockptr.h
> @@ -46,8 +46,7 @@ static inline int copy_from_sockptr_offset(void *dst, sockptr_t src,
>   {
>   	if (!sockptr_is_kernel(src))
>   		return copy_from_user(dst, src.user + offset, size);
> -	memcpy(dst, src.kernel + offset, size);
> -	return 0;
> +	return copy_from_kernel_nofault(dst, src.kernel + offset, size);
>   }

The subject and commit message mentioned it is bpf_sys_bpf() helper
might have issues. But the patch itself tries to modify 
copy_from_sockptr_offset() and strncpy_from_sockptr(), why?

>   
>   static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
> @@ -93,12 +92,8 @@ static inline void *memdup_sockptr_nul(sockptr_t src, size_t len)
>   
>   static inline long strncpy_from_sockptr(char *dst, sockptr_t src, size_t count)
>   {
> -	if (sockptr_is_kernel(src)) {
> -		size_t len = min(strnlen(src.kernel, count - 1) + 1, count);
> -
> -		memcpy(dst, src.kernel, len);
> -		return len;
> -	}
> +	if (sockptr_is_kernel(src))
> +		return strncpy_from_kernel_nofault(dst, src.kernel, count);
>   	return strncpy_from_user(dst, src.user, count);
>   }
>   
> 
> base-commit: d295daf505758f9a0e4d05f4ee3bfdfb4192c18f
