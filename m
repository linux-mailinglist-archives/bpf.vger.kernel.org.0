Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C264A4C3CDE
	for <lists+bpf@lfdr.de>; Fri, 25 Feb 2022 05:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbiBYEFA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Feb 2022 23:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiBYEE7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Feb 2022 23:04:59 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD22B235337
        for <bpf@vger.kernel.org>; Thu, 24 Feb 2022 20:04:26 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21P29VPs028625;
        Thu, 24 Feb 2022 20:04:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WyHYJGRwHRqfkoQJj2KHi36tiUicnK8EJzLEfVIMVa8=;
 b=ecUXJ/UaqqJkW7ojHcMvGBwW31IKHIbCixyGPFy78CrIXIJNfuFReUhLVaWrIiRHlFSY
 Z5NZ8d5O2y3bXLBX6KK/iGQq+9KA5R8/cyUcdK32GuKu5cqxS3L3Hwk51sIGjHhZnxDN
 S3TIvImABFLU6hM6b1ZWMdSiblShU9Dk2iA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ee1rk81s1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 24 Feb 2022 20:04:23 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 20:04:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYLV8mUBJWsfJdtGWJ9W0I2eFxRQifmXAiVRRU45KGJDJJ5Hwh6WimL5Md3tHwoMSr1Wesy8VbkXHO7juXg7VYavQuj3Q+dMQwXZqRnc86iKhC44YxFBLjClCWrVoiaBRxFtCdydKAQ3U4ULToZSjx4VyVfVGWwDOAYi4Q2+E3X2bqd4CxwJl/b8p5ma8Jc24bsJzoLvCq60wb0q7zzFzn89qQcF7QBzIcfHJGmUSuu9hp8OYbe0j2/M/U+O2DdprsOdXmYn4zwn2zH3qSzPt/H1Dj6c2ARfLtWSpdAIdnYDqB1oaM7b6R0fHInZGJpqLqNjTOBm407i6X4argMNkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyHYJGRwHRqfkoQJj2KHi36tiUicnK8EJzLEfVIMVa8=;
 b=MWYF/GC7oFplW5K5b4otOG5fbzN+yjoeqrhomoDBBGYhIHdi/F2H9hFzv4r4caPi5REV7PZnM4xLFMG9+lDAO58wM1bwD7QUmLpAhZG/vGtSF95QhfvmzHFSlulamZ9+CtNzAOX61EQth/zLU8ZDf6gA7zRyKoflfnyppeZNne9w9knxg7ILNtBVLn2ylqKwEUa95k1AIQf9fXc4NgwT22fc9NHVnrfvQaBWny1kRmch4bU3NAAynCgAKebHbl0gvt6bZXgkfJ4/uxfjzw0T303CKrAXsJu4gWSd5P+0/l8nuYV2TUnrjNHj9SvpqzwPqxce89x2ReUctSXRXiFsig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL0PR1501MB1988.namprd15.prod.outlook.com (2603:10b6:207:1b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Fri, 25 Feb
 2022 04:04:13 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.025; Fri, 25 Feb 2022
 04:04:13 +0000
Message-ID: <7bb7006a-9f2e-a41e-7fb9-e14438536b83@fb.com>
Date:   Thu, 24 Feb 2022 20:04:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next] bpf: Fix issue with bpf preload module taking
 over stdout/stdin of kernel.
Content-Language: en-US
To:     Yucong Sun <fallentree@fb.com>, <bpf@vger.kernel.org>
CC:     <andrii@kernddddel.org>, <ast@kernel.org>
References: <20220224214928.826717-1-fallentree@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220224214928.826717-1-fallentree@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MW4PR04CA0276.namprd04.prod.outlook.com
 (2603:10b6:303:89::11) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8479c83-1409-4c63-02ef-08d9f813e215
X-MS-TrafficTypeDiagnostic: BL0PR1501MB1988:EE_
X-Microsoft-Antispam-PRVS: <BL0PR1501MB198849E4D9EDC6AD6B072A86D33E9@BL0PR1501MB1988.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyrPc78p+/03Ex3bt+MRyEPqarg1t1+wxdmQelfBGQANF4ua/46iGV3V4tKkMKRKx0HK+7CYmzISBwuf6ugaBxJ089UN14JJ52aT7743oqf+jQrfIT4wcU4V44cJRXSfPTRrL1Vd/lYbflo2YfVJsSJGloWwBFZeRZjAXYc4lvr0abWkJFhSlqz2EhEGwEs1euA9665Bm0giniwQmCqqaOYutb1wZzQaZtmKDF4JuZeWBewwiC5LYyDMMPRVmrAt+28wn5PbE4ViOJ579M9O9zv2SQojxEdsY21NZAM3Clacv9U/GxOWMuFWRU5nHwzNT8sFU50S0fNRCCEVDpGvACl7GQgpcjE1/zM4eWfDKq65A/gH9ZCqBAmI9g1Fe5icvKjDE2VeZMTruHXoYKbQtiOb8RAgJhXb/hr3L/xxVzpAbEuQNIgmR7FDIWtEqF2PZpWpGaNJbIoVNEgZHuP76IU9QCIl1LfWWQ5iCrSISYd1PezOkFvHbE0foi9ZQYn5QoQaGbgxiF6dmVjbGBMXkFHN6LJmYZFmbuX4BcTzeZw+psBLGlug8hTt1CfQ/6Xc2V6x9OiLps0BObYL5YKngm16cUuzFK8yd+paW4PMFYfpVu/0IdkMc+aoZLEAzh//XHh1zBS4QhqMFVzIe6oySzel8Ydc11pYuNoWs5BFJLKUM9zaQ71GNKd4g2T1bORU8EfZBKB4h+X7gWR8UOsEACxjL58DSuMJSSemwL17yBia9ym0kneuutCskUTxAmkGpW8D1wsCz0jEsgN3GM5yt1YF84O8hCX7V13MmB21rXydXhEF2IWZOzm1pctMsU60
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(38100700002)(6486002)(6506007)(53546011)(52116002)(508600001)(186003)(966005)(6666004)(2616005)(66476007)(316002)(4326008)(8676002)(31696002)(2906002)(66556008)(8936002)(66946007)(83380400001)(31686004)(86362001)(36756003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0JYV3RvWTFZWElRTHBMVDdsK2QrN0wxOGN4L0QyYndsMTFUS250TzVIZzJr?=
 =?utf-8?B?akdjRGs0L3BjbGFtTVA4U3dxNlc1RG43bWVwV3NQVDljbXB4b2Rsb3lIeERo?=
 =?utf-8?B?NWQzaDM4ZTA0ZDFxV29JWGNjWnVTbUF1SUtydjUxWk5FbkZKSm8xVVJvVVVX?=
 =?utf-8?B?dG91VlRIQkdralBCaFZNZUlVR21nc0xUem8zaXRQNm9WYm5neEhPdnZiNGw2?=
 =?utf-8?B?ck1OZHpDRHRCWjZoc0N5aFV4SnVFS3V3WVdia0lrTGFma1dITG4zUis4ZWFs?=
 =?utf-8?B?UWl0MkNuS3BqZWlDd1dVUlNBWnRtV1A1QmZTY05ZZ25mNFhmS1BqSHd2bVFG?=
 =?utf-8?B?eHdxcm9oY1BvZUIydDc3NGR1YTVzNHhZUWtLbjdRZXZ4Z25FWHg5RmJLTUxj?=
 =?utf-8?B?Sm95bFV0VEdpckNPSjh4THp4WGdYR1N4Wjl6RU80bXBHQXQ2WWlXTWI2a3NB?=
 =?utf-8?B?YjN1ZTJXemJDVEJGdld0WWxEMi91c05lWXdiQjBCd3YzeTdGdmRrdXRKbmpG?=
 =?utf-8?B?eFpMc0dwOU5IWStyNnN2ZEZkZWFrd3Z5Nm1nRE9yY3U5WnQ0d1NpTDNPV0VC?=
 =?utf-8?B?RS90Nk0rRTJjV2JWRll2WkpHZW9KRm05amdmWHJPcUJMUUlHd1RRSk5MOFJF?=
 =?utf-8?B?YitNR2lGT1hDbGZEMmRhc2tPelBpT2pGU2JzWER0bnpkbjB3aEFiWlcyZGRO?=
 =?utf-8?B?MlFhdkpObmpTVG5RdVhmUC9VeDVCbnR4R2RuczI1Uld2WWJ5VHZ4TnlpNUhy?=
 =?utf-8?B?UjkrYlNaanBMQXJiVGVMTUlFTUdyQkRvRklZamtpRUFVc2E4azFoZkxlU2FM?=
 =?utf-8?B?cFo2T0Z1NUtxMjd1N1JOWnJNN1p5cjcyRWlMS1k2Z1BGdjNmUTJQNHhUU3gr?=
 =?utf-8?B?MkZIZUQ4cjYrSzRaTTZsNW9IL3lCVm9JUTJ4NmI5YS9ZWDRubWtrYWR5Vm5j?=
 =?utf-8?B?T2c1aTFkci92bURGR1BQY3VnUFFMTEFHaUNCZUdBUlZWcHkxWlVSSHVDSi9X?=
 =?utf-8?B?ZCtjY3BsSlk1V25sUmxqd2NRd1RnS0JMZ0VLT2JpUXBKTnEya1RHemo3NU05?=
 =?utf-8?B?Q3BXMmg3ZUVCKzFmbnMyY3A5N1hPODNKczVCRjBqSEJuc1JWaXBlekFzcExw?=
 =?utf-8?B?Wno2OXczZzI4eWk4dXpzNkszNFRucW9FNTNRT0pKdWdtTmRRdFNSK01zTDJX?=
 =?utf-8?B?SS9Dam5kTlRVVTRxdE1SWnFsWHBieDhwaDRnNWRYakpwRDdiUUdxRGhNbW5y?=
 =?utf-8?B?NWJpdjMvVzA3L2tvTnYyZ0FseWhtZ1YxdkFjSVhwcGd1M0NRcVJVU2NqQ0l1?=
 =?utf-8?B?dzNOZEhHZktuMUc1NmI1Y1VwNHdOdEdUT09UVWV6b21Zc2dFbWYzM0Y0VEgr?=
 =?utf-8?B?M3g1cm1jNzM0SlFBSG1xYVB4cFJsaHpiUTFkQTduV0dxVE1mM0pQK2thbHFt?=
 =?utf-8?B?V3JpNnRzTnV4cU1mTUEva0ZuVDdocSs1WUc2VExZVTZpUW15Nit2UzdKZ0pk?=
 =?utf-8?B?N3ZKVGkvbU9mWERLRXpsc24zWnY1aXQ4M1lBQTJ0SjRXbTFJVWFxcm8vN1h0?=
 =?utf-8?B?dGR6SDg4c2w0c3E3WDZMMHpseTE0M1ZFUTNCZVRoekpqS2R6TGlZNDFnckZ2?=
 =?utf-8?B?c0Y2UWtacm5GVXJDdmhyVDB2d2NMcFNHNTlKaThoYzhwWUdpdG0yc05wTDVK?=
 =?utf-8?B?UkxsOCtkS21HcVdDZUNqUVBtdXBuUW8wNzF4cHBxdDZENHpBbkV5dWF4bngz?=
 =?utf-8?B?eituamoxMmVWZEVZSDlDZVlEdU5Mb0dITy9tNXl1T2tDNjhYWW9oTFpxcVhj?=
 =?utf-8?B?d1pENldwM013eUpuTlU1aG1oR210QWpGb3ZPQUxsdUhlWXZrYXZONVg5V0JF?=
 =?utf-8?B?ZEM3V0k0U0ZHTEtNbHlrSnZwOVFJcmplU2hUeE1VLzg0RmhxZTE2THIvcUFH?=
 =?utf-8?B?dlRhSklzQVNzYlJCTWN0WGRPZmN4ZS90MjQ4UzN4YnNBeDlJcVE1YS9YLzJ2?=
 =?utf-8?B?ekUrUTRLM0dBanpXY2tlbmw3NkxwVi9zNDAzRmx5OE9CRUlRdjg2UG0xYmF4?=
 =?utf-8?B?SGs5ZUtvcitnNUtYNHBMdG9qMDF4Y1hBRkdLc05iUXlDU0JoZkhQUmdZNEtj?=
 =?utf-8?Q?y/CvFdKlRb6Ci4YiiJagCa6A6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e8479c83-1409-4c63-02ef-08d9f813e215
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 04:04:13.3074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yL78TUVerWSlegwFL3Fq89ZC1YkeaaD83fTUWVolUQ31YiRmWMnBCs10mjwWFFtm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB1988
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: N7uCZlWsLrnnAzeKJCGnfH6gFfHKy9Kf
X-Proofpoint-ORIG-GUID: N7uCZlWsLrnnAzeKJCGnfH6gFfHKy9Kf
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-02-25_01,2022-02-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 phishscore=0
 bulkscore=0 clxscore=1011 mlxlogscore=999 adultscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250020
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/24/22 1:49 PM, Yucong Sun wrote:
> In a previous commit (1), BPF preload process was switched from user
> mode process to use in-kernel light skeleton instead. However, in the
> kernel context the available fd starts from 0, instead of normally 3 for
> user mode process. and the preload process leaked two FDs, taking over
> FD 0 and 1. This  which later caused issues when kernel trys to setup
> stdin/stdout/stderr for init process, assuming fd 0,1,2 is available.
> 
> As seen here:
> 
> Before fix:
> ls -lah /proc/1/fd/*
> 
> lrwx------1 root root 64 Feb 23 17:20 /proc/1/fd/0 -> /dev/null
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/1 -> /dev/null
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/2 -> /dev/console
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/6 -> /dev/console
> lrwx------ 1 root root 64 Feb 23 17:20 /proc/1/fd/7 -> /dev/console
> 
> After Fix / Normal:
> 
> ls -lah /proc/1/fd/*
> 
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/0 -> /dev/console
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/1 -> /dev/console
> lrwx------ 1 root root 64 Feb 24 21:23 /proc/1/fd/2 -> /dev/console
> 
> In this patch:
>    - skel_closenz was changed to skel_closenez to correctly handle
>      FD=0 case.
>    - various places detecting FD > 0 was changed to FD >= 0.
>    - Call iterators_skel__detach() funciton to release FDs after links
>    are obtained.
> 
> 1: https://github.com/kernel-patches/bpf/commit/cb80ddc67152e72f28ff6ea8517acdf875d7381d
> 
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>   kernel/bpf/preload/bpf_preload_kern.c          |  1 +
>   kernel/bpf/preload/iterators/iterators.lskel.h | 16 +++++++++-------
>   tools/bpf/bpftool/gen.c                        |  9 +++++----
>   tools/lib/bpf/skel_internal.h                  |  8 ++++----
>   4 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/kernel/bpf/preload/bpf_preload_kern.c b/kernel/bpf/preload/bpf_preload_kern.c
> index 30207c048d36..c6bb1e72e0f1 100644
> --- a/kernel/bpf/preload/bpf_preload_kern.c
> +++ b/kernel/bpf/preload/bpf_preload_kern.c
> @@ -54,6 +54,7 @@ static int load_skel(void)
>   		err = PTR_ERR(progs_link);
>   		goto out;
>   	}
> +	iterators_bpf__detach(skel);

In fini, we have:

static void __exit fini(void)
{
         bpf_preload_ops = NULL;
         free_links_and_skel();
}

static void free_links_and_skel(void)
{
         if (!IS_ERR_OR_NULL(maps_link))
                 bpf_link_put(maps_link);
         if (!IS_ERR_OR_NULL(progs_link))
                 bpf_link_put(progs_link);
         iterators_bpf__destroy(skel);
}

Since you did iterators_bpf__detach(skel) in load_skel(),
in fini(), we don't need iterators_bpf__destroy(skel), right?

>   	return 0;
>   out:
>   	free_links_and_skel();
[...]
