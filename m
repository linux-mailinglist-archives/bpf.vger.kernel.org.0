Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52C3412E19
	for <lists+bpf@lfdr.de>; Tue, 21 Sep 2021 06:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhIUE5Y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 00:57:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:1908 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229879AbhIUE5X (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 00:57:23 -0400
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with SMTP id 18KHwaCL016741;
        Mon, 20 Sep 2021 21:55:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5iNgd5VxIlfmlcCpCD+e+zCk6iX+YV4Z0eg0JwaKXZM=;
 b=c8HZpdtL9SdgWZ1q3SmMztOODWqlfToVkGGU78AV+z6sDZ1r8XOscA8e2yE/tRtxiAGG
 AQu9WOXNeqUEQanjtd9KappA5CB5iK7pGk5DQ2vNGZepdgxVc1BPwqQrPh+6FDSLwG2W
 VRrlw/F6vj+wqk4VlqujUzk/jXQbwmD7gWs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net with ESMTP id 3b6jr0fawm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 20 Sep 2021 21:55:42 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 20 Sep 2021 21:55:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcOFZ4JyHFCPm7TC2h9vi8KsTZs8fZaF75K5Nq6ZdCopiDLlk43lvukFLLllrgAhxVvRrZT3zjPBnb1KJ66hli3ZwLCH23aNmm37TkAMRgbCUFvnsggVrWARvpR7Q2AD3K38qc9II97PYJA4biNbzULgxqShMuQlfbbhrh3+9NhgNXInIc+kzCK2Dh9t82SWCXCtbcPVK2IYLEE+vJWK+DcNtui4fTTZq4wEVoWWvqFUPxOcjKAyC2ZDvDMKiRBJ2SQGDBz+h4AHbHPrnBxMjPjNWuEC4Sf9FFZejEOdd8WS3jaoWYMGM6gv1lXv+RrP0CmhAKYHRE07Oz8ohxhEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=5iNgd5VxIlfmlcCpCD+e+zCk6iX+YV4Z0eg0JwaKXZM=;
 b=d86lvuco5x2U8K2Guj3zkjhx2uZLaLa3FxYmWKisvSH55/G1RaesQVwIufB8UhGNsC9XBpKwyXiEidEVIX1xk/cw5YwbcFdELxrX7i90EkIRm20/OX412UzLfJklwPGsjlHhjUTMI6XU/WcyKak4JkR9iwPvCJewYOkudPk2rg9+d9Pr3zoeyzhofedhqla/RaJ1heC2+23GTE4MhPTC7W2QkCuFQxcAYhtD03sqhjfM2bwdC2i62rm06cD6gGbdp7/9yuYKlK4nJNnyzIS9pIUrj5Bm1Sj1LibCTpuqUN/lak2bZy3pF0vA0wdgRpura7D+Z2Fr6LcWKX2DUM1nhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB2601.namprd15.prod.outlook.com (2603:10b6:5:1a2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.17; Tue, 21 Sep
 2021 04:55:39 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 04:55:39 +0000
Message-ID: <4ab8049e-7e06-17b3-56ab-f1776cdf5e5e@fb.com>
Date:   Tue, 21 Sep 2021 00:55:37 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v2 bpf-next 1/9] selftests/bpf: normalize XDP section
 names in selftests
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210920234320.3312820-1-andrii@kernel.org>
 <20210920234320.3312820-2-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210920234320.3312820-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:208:fc::26) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c9::10ab] (2620:10d:c091:480::1:7a32) by MN2PR02CA0013.namprd02.prod.outlook.com (2603:10b6:208:fc::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 04:55:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d7f6ff3a-820f-42bf-74d1-08d97cbc0eb9
X-MS-TrafficTypeDiagnostic: DM6PR15MB2601:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB2601CF1948CA109E3466BE4CA0A19@DM6PR15MB2601.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hy0CDC04zi/LmP5cOt7No3AI4tQanD8S2KpVikz1YOHypdreWiCbxv4oSNU3yva+qZMt/eb3bCX3n2hkiDe+YY0dmGv7IrwKusm4rlT8l7qJYh1heT/yEr+y1bzi7iLlm74hY4v3ZVoiXFG4E7SJWca9vmhOPM4cvAY6UsiTREq6KpMgHoVrl5f8sUbX+naADPtlLcUZednTCf5IxP8Z8u1xC3D1nXEop6qtTJaxUqE9c8MkVX6jVLtoeJFPkDABY51s9fmxRUU47F1EnV3tZ1c7x1f760+tyIROlyDVEsoqFTG+/Tk2ToaBWUDSsW5uFolU8PNYRb0zIRMutLxS8Dql0KcuZZnoZ4Oh8D93HmA7bcZ0/UqXPeqjwUc8UIKUIPDiK6lpsI3MBmkHUr5dSVfYeISn8txCnFYwhbC/+BSovTsvrIaVuI/ilSKs/oyWAhyCDOIhLiUa7nMsgHd5qrQLbOx7sm053rMFJGWo/NBz/d0qEzZcmmRtrU6aJ/3d59ao1mnW+LAZzSkK6f30veC+n0/a5w8UxhUgvO1pp3prOiBWjfqc4uR8TOLhOkX9XNRMwpH64wK61sNq1gTTb/Ywb9gboodZLfsd6dzZUPSKaNjKxNJRvjnCRjah1+0whGZ8ReCYKO7IDYL8j+qAsNj6XfGJuqgNbrGk+EMrkf4McusXFiu2jTU6oy0MC867jEuBy3GNY8MQbp0aorQXz4IzZDdNqobRgOuHEoUuzcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(508600001)(30864003)(186003)(66476007)(36756003)(6486002)(86362001)(2906002)(53546011)(31686004)(66946007)(66556008)(8936002)(316002)(8676002)(2616005)(31696002)(5660300002)(83380400001)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVRZakxLYjNuWGVLZ1AvZUlVNlZTcTJJT2ozd2l1ajl4d3RjaURlampsNWEv?=
 =?utf-8?B?M1pPYXpmaGdCUG5ZYjhKaGZHOUJxVkt0SjNwR29qdHU3a0dwUmtFVlNYMGRh?=
 =?utf-8?B?UjRNY2xrQTNSM0ZUWVRqUlJvQkhPOWJpRUJOcGlhY0FZK0NFWms4dVdSUVpl?=
 =?utf-8?B?eUp1ZHZpY1IvNkh0WTRDWisxSEZiNEltSmozeWtmWUdMNzRGN1FBY0VNNjZS?=
 =?utf-8?B?T2ovd2hGang3MUdnbVVhWEZHZElIK0NyNzZBMW02SzFBb1F2QVRQSnNIMGs4?=
 =?utf-8?B?d1ZmVi9qZ3pneUJCeVJwTytMMU1aYU5zTG5RWFRjb1lueGFpOEV5Qm5zNllt?=
 =?utf-8?B?amU5d2ZGNGNKK1ZZU1d2TWlMT2hwYXE1SnhpVlNTa05weERCdFF5K1hoYVRZ?=
 =?utf-8?B?QmdQZFE5S0YrNmpTNmZwVXN4a1RrbHB4Q0NsblhpTFlXdHJWckNyRmV0eHVx?=
 =?utf-8?B?cjU0dXVIYzBOdzJVZXRtWTVlcWRGSEZhWHp5K0dWcFpEcFhiaHNXMEl6Z1U2?=
 =?utf-8?B?c1dBcVgvdTNuTXV0YUNKWEx2Z1A2dXQzY0YzUW12R05wdFhqclJaRjVzQmNX?=
 =?utf-8?B?MEpHcmtXMENtemhlQ3BpV3ZkelpmcFhmVzIzTk1WWVlEMHlUUTFNbHVZWGUr?=
 =?utf-8?B?cFJ0TzhhM0ZFdjE2cFhrRVpVNFBGOC9jRWtnSXhJK1R5Vnh3TWVGM084QWto?=
 =?utf-8?B?akc1Wm1NRUJlSldXL1F0bTZLWUZiUWtNR3Z2cE02ejM2dUlMTGtucDl3bXdw?=
 =?utf-8?B?MmFhMVpwY0xVNVErZmg0VTF0WnZVMWsrOEV6N21CMytQc1M2ZDk4eHhFZmUz?=
 =?utf-8?B?QmV3NHNMZDI0aExPQ0FENkFwR2ZITzM2TkZxa0NoUDl5a3d3SEV4Z2ovWXQ2?=
 =?utf-8?B?OHh0VUVZTitwdkd1Ylg1MnZNTEtReVppbDM5N1V2SFVUa2xwbU85UitWcHNv?=
 =?utf-8?B?OXVRL2YrQ2xQN0U5emhxT3E5ejBxM0RYTU5ab1B6NEFJNUJsaFVyQkVHT1cx?=
 =?utf-8?B?ZEgxelRqR2JEQlliSGFkWU5YNEsrQjNkR2JMQTdYcGhySFoySDNldk9hOEYz?=
 =?utf-8?B?aHVuOHJTWE5TWFRzOXZKdGo5MzdudVVpSVBZVERNdFduV1dxdTZOY0plcits?=
 =?utf-8?B?ZjNLRzZnZElMZ0RNV2didXZENjdEVzlrMStjYTQ5VC9uTFRneTNGNGNLL1R6?=
 =?utf-8?B?TXQ2TzFPYmN0clhlZ25jaHczdEdVQTBmQXdnWDhUNFp6VWhrNjhBUGFydi9K?=
 =?utf-8?B?U25VK2o5RjlPcGVMTUpHbTZWMmhweDYwVW02UmRkQ0ZSZGpqN1lscWNxMzdE?=
 =?utf-8?B?b1lQV1NhdklDNVh6OVVsZzFWNXNQZGFxQkc3emwreVNiTnhBZi9UMnhkTHc0?=
 =?utf-8?B?d3ZSa1k3NmRybDNEazZlT2lvNmdIaTNMWnZHNy90S3RhM3VkUjV2b3BydEFo?=
 =?utf-8?B?RHp5Tm9WRVF2U2crKzd0YUYrSVJiOGc3SlhOTjZnNDluYW9mTU44WE41Vlhm?=
 =?utf-8?B?TTVkVzdSR0NmWm9hdzcwVUthUEhOWWRGME1yN21oTGQ4a2VEVHZiY254Ky9x?=
 =?utf-8?B?ektTWGd1SnlYazJWVEFyMk9iS2QwaFpZejVXM2crc29EZHlKVGZOYzgvNXJG?=
 =?utf-8?B?Q2xrbGdpb3hmcmg4UldJNjQ1bmU3YVlLcmVPS3ZWWGk3bzVRV0dNdTVRZm91?=
 =?utf-8?B?cmNNZU1EeXl3bkM2TWtKSDh0ckgxMWs4STdXV2w0UFNCZUo4WWpSc2UxUEdT?=
 =?utf-8?B?NmhDNTduVWpXLzdEYmZpV2hRTFlVbmgwL1VIRWp6S3NyUGdKQUZSa0x6Nndt?=
 =?utf-8?B?QVNWMGxsOVpJeVVtNVhqQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d7f6ff3a-820f-42bf-74d1-08d97cbc0eb9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 04:55:39.3850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZnKPjMLRnkRX1WfhVuCkxzELWsFUzlfYQLIlQ3OPl1Xaocq3JeUHm419gDGE5WhmFsqpFK+X8dOSV7Yiyr91Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2601
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 7lQ-ZXaKngIHDVD2SMlN5HNoiudWZRZT
X-Proofpoint-GUID: 7lQ-ZXaKngIHDVD2SMlN5HNoiudWZRZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_01,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 spamscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109210029
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/20/21 7:43 PM, Andrii Nakryiko wrote:   
> Convert almost all SEC("xdp_blah") uses to strict SEC("xdp") to comply
> with strict libbpf 1.0 logic of exact section name match for XDP program
> types. There is only one exception, which is only tested through
> iproute2 and defines multiple XDP programs within the same BPF object.
> Given iproute2 still works in non-strict libbpf mode and it doesn't have
> means to specify XDP programs by its name (not section name/title),
> leave that single file alone for now until iproute2 gains lookup by
> function/program name.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Aside from a checkpatch nit which you didn't cause, LGTM. Some general
comments follow as well, but aren't directly related to the patch.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>

>  tools/testing/selftests/bpf/progs/test_map_in_map.c         | 2 +-
>  .../selftests/bpf/progs/test_tcp_check_syncookie_kern.c     | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp.c                | 2 +-
>  .../testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c | 2 +-
>  .../selftests/bpf/progs/test_xdp_adjust_tail_shrink.c       | 4 +---
>  tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp_link.c           | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp_loop.c           | 2 +-
>  tools/testing/selftests/bpf/progs/test_xdp_noinline.c       | 4 ++--
>  .../selftests/bpf/progs/test_xdp_with_cpumap_helpers.c      | 4 ++--
>  .../selftests/bpf/progs/test_xdp_with_devmap_helpers.c      | 4 ++--
>  tools/testing/selftests/bpf/progs/xdp_dummy.c               | 2 +-
>  tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c | 4 ++--
>  tools/testing/selftests/bpf/progs/xdping_kern.c             | 4 ++--
>  tools/testing/selftests/bpf/test_tcp_check_syncookie.sh     | 2 +-
>  tools/testing/selftests/bpf/test_xdp_redirect.sh            | 4 ++--
>  tools/testing/selftests/bpf/test_xdp_redirect_multi.sh      | 2 +-
>  tools/testing/selftests/bpf/test_xdp_veth.sh                | 4 ++--
>  tools/testing/selftests/bpf/xdping.c                        | 6 +++---

Doesn't look like the test_...sh's here are run by the CI. Confirmed they
(as well as test_xdping.sh) all passed for me. My test VM isn't doing anything
special networking-wise, so maybe it's not too difficult to add these to CI.

>  19 files changed, 28 insertions(+), 30 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_map_in_map.c b/tools/testing/selftests/bpf/progs/test_map_in_map.c
> index 1cfeb940cf9f..5f0e0bfc151e 100644
> --- a/tools/testing/selftests/bpf/progs/test_map_in_map.c
> +++ b/tools/testing/selftests/bpf/progs/test_map_in_map.c
> @@ -23,7 +23,7 @@ struct {
>  	__uint(value_size, sizeof(__u32));
>  } mim_hash SEC(".maps");
>  
> -SEC("xdp_mimtest")
> +SEC("xdp")
>  int xdp_mimtest0(struct xdp_md *ctx)
>  {
>  	int value = 123;
> diff --git a/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c b/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
> index 47cbe2eeae43..fac7ef99f9a6 100644
> --- a/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
> +++ b/tools/testing/selftests/bpf/progs/test_tcp_check_syncookie_kern.c
> @@ -156,7 +156,7 @@ int check_syncookie_clsact(struct __sk_buff *skb)
>  	return TC_ACT_OK;
>  }
>  
> -SEC("xdp/check_syncookie")
> +SEC("xdp")
>  int check_syncookie_xdp(struct xdp_md *ctx)
>  {
>  	check_syncookie(ctx, (void *)(long)ctx->data,
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp.c b/tools/testing/selftests/bpf/progs/test_xdp.c
> index 31f9bce37491..e6aa2fc6ce6b 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp.c
> @@ -210,7 +210,7 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
>  	return XDP_TX;
>  }
>  
> -SEC("xdp_tx_iptunnel")
> +SEC("xdp")
>  int _xdp_tx_iptunnel(struct xdp_md *xdp)
>  {
>  	void *data_end = (void *)(long)xdp->data_end;
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
> index 3d66599eee2e..199c61b7d062 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_grow.c
> @@ -2,7 +2,7 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  
> -SEC("xdp_adjust_tail_grow")
> +SEC("xdp")
>  int _xdp_adjust_tail_grow(struct xdp_md *xdp)
>  {
>  	void *data_end = (void *)(long)xdp->data_end;
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
> index 22065a9cfb25..b7448253d135 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_adjust_tail_shrink.c
> @@ -9,9 +9,7 @@
>  #include <linux/if_ether.h>
>  #include <bpf/bpf_helpers.h>
>  
> -int _version SEC("version") = 1;
> -

Didn't realize this was meant to specify kernel version for compat, and that
it no longer does anything anyways. Maybe this should be removed from all 
selftests + examples to make this more obvious?

> -SEC("xdp_adjust_tail_shrink")
> +SEC("xdp")
>  int _xdp_adjust_tail_shrink(struct xdp_md *xdp)
>  {
>  	void *data_end = (void *)(long)xdp->data_end;
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
> index b360ba2bd441..807bf895f42c 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_devmap_helpers.c
> @@ -5,7 +5,7 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  
> -SEC("xdp_dm_log")
> +SEC("xdp")
>  int xdpdm_devlog(struct xdp_md *ctx)
>  {
>  	char fmt[] = "devmap redirect: dev %u -> dev %u len %u\n";
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_link.c b/tools/testing/selftests/bpf/progs/test_xdp_link.c
> index eb93ea95d1d8..ee7d6ac0f615 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_link.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_link.c
> @@ -5,7 +5,7 @@
>  
>  char LICENSE[] SEC("license") = "GPL";
>  
> -SEC("xdp/handler")
> +SEC("xdp")
>  int xdp_handler(struct xdp_md *xdp)
>  {
>  	return 0;
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_loop.c b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> index fcabcda30ba3..27eb52dda92c 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_loop.c
> @@ -206,7 +206,7 @@ static __always_inline int handle_ipv6(struct xdp_md *xdp)
>  	return XDP_TX;
>  }
>  
> -SEC("xdp_tx_iptunnel")
> +SEC("xdp")
>  int _xdp_tx_iptunnel(struct xdp_md *xdp)
>  {
>  	void *data_end = (void *)(long)xdp->data_end;
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> index 3a67921f62b5..596c4e71bf3a 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_noinline.c
> @@ -797,7 +797,7 @@ static int process_packet(void *data, __u64 off, void *data_end,
>  	return XDP_DROP;
>  }
>  
> -SEC("xdp-test-v4")
> +SEC("xdp")
>  int balancer_ingress_v4(struct xdp_md *ctx)
>  {
>  	void *data = (void *)(long)ctx->data;
> @@ -816,7 +816,7 @@ int balancer_ingress_v4(struct xdp_md *ctx)
>  		return XDP_DROP;
>  }
>  
> -SEC("xdp-test-v6")
> +SEC("xdp")
>  int balancer_ingress_v6(struct xdp_md *ctx)
>  {
>  	void *data = (void *)(long)ctx->data;
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
> index 59ee4f182ff8..532025057711 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_with_cpumap_helpers.c
> @@ -12,13 +12,13 @@ struct {
>  	__uint(max_entries, 4);
>  } cpu_map SEC(".maps");
>  
> -SEC("xdp_redir")
> +SEC("xdp")
>  int xdp_redir_prog(struct xdp_md *ctx)
>  {
>  	return bpf_redirect_map(&cpu_map, 1, 0);
>  }
>  
> -SEC("xdp_dummy")
> +SEC("xdp")
>  int xdp_dummy_prog(struct xdp_md *ctx)
>  {
>  	return XDP_PASS;
> diff --git a/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c b/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
> index 0ac086497722..1e6b9c38ea6d 100644
> --- a/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
> +++ b/tools/testing/selftests/bpf/progs/test_xdp_with_devmap_helpers.c
> @@ -9,7 +9,7 @@ struct {
>  	__uint(max_entries, 4);
>  } dm_ports SEC(".maps");
>  
> -SEC("xdp_redir")
> +SEC("xdp")
>  int xdp_redir_prog(struct xdp_md *ctx)
>  {
>  	return bpf_redirect_map(&dm_ports, 1, 0);
> @@ -18,7 +18,7 @@ int xdp_redir_prog(struct xdp_md *ctx)
>  /* invalid program on DEVMAP entry;
>   * SEC name means expected attach type not set
>   */
> -SEC("xdp_dummy")
> +SEC("xdp")
>  int xdp_dummy_prog(struct xdp_md *ctx)
>  {
>  	return XDP_PASS;
> diff --git a/tools/testing/selftests/bpf/progs/xdp_dummy.c b/tools/testing/selftests/bpf/progs/xdp_dummy.c
> index ea25e8881992..d988b2e0cee8 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_dummy.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_dummy.c
> @@ -4,7 +4,7 @@
>  #include <linux/bpf.h>
>  #include <bpf/bpf_helpers.h>
>  
> -SEC("xdp_dummy")
> +SEC("xdp")
>  int xdp_dummy_prog(struct xdp_md *ctx)
>  {
>  	return XDP_PASS;
> diff --git a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
> index 880debcbcd65..8395782b6e0a 100644
> --- a/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
> +++ b/tools/testing/selftests/bpf/progs/xdp_redirect_multi_kern.c
> @@ -34,7 +34,7 @@ struct {
>  	__uint(max_entries, 128);
>  } mac_map SEC(".maps");
>  
> -SEC("xdp_redirect_map_multi")
> +SEC("xdp")
>  int xdp_redirect_map_multi_prog(struct xdp_md *ctx)
>  {
>  	void *data_end = (void *)(long)ctx->data_end;
> @@ -63,7 +63,7 @@ int xdp_redirect_map_multi_prog(struct xdp_md *ctx)
>  }
>  
>  /* The following 2 progs are for 2nd devmap prog testing */
> -SEC("xdp_redirect_map_ingress")
> +SEC("xdp")
>  int xdp_redirect_map_all_prog(struct xdp_md *ctx)
>  {
>  	return bpf_redirect_map(&map_egress, 0,
> diff --git a/tools/testing/selftests/bpf/progs/xdping_kern.c b/tools/testing/selftests/bpf/progs/xdping_kern.c
> index 6b9ca40bd1f4..4ad73847b8a5 100644
> --- a/tools/testing/selftests/bpf/progs/xdping_kern.c
> +++ b/tools/testing/selftests/bpf/progs/xdping_kern.c
> @@ -86,7 +86,7 @@ static __always_inline int icmp_check(struct xdp_md *ctx, int type)
>  	return XDP_TX;
>  }
>  
> -SEC("xdpclient")
> +SEC("xdp")
>  int xdping_client(struct xdp_md *ctx)
>  {
>  	void *data_end = (void *)(long)ctx->data_end;
> @@ -150,7 +150,7 @@ int xdping_client(struct xdp_md *ctx)
>  	return XDP_TX;
>  }
>  
> -SEC("xdpserver")
> +SEC("xdp")
>  int xdping_server(struct xdp_md *ctx)
>  {
>  	void *data_end = (void *)(long)ctx->data_end;
> diff --git a/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh b/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
> index 9b3617d770a5..fed765157c53 100755
> --- a/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
> +++ b/tools/testing/selftests/bpf/test_tcp_check_syncookie.sh
> @@ -77,7 +77,7 @@ TEST_IF=lo
>  MAX_PING_TRIES=5
>  BPF_PROG_OBJ="${DIR}/test_tcp_check_syncookie_kern.o"
>  CLSACT_SECTION="clsact/check_syncookie"
> -XDP_SECTION="xdp/check_syncookie"
> +XDP_SECTION="xdp"
>  BPF_PROG_ID=0
>  PROG="${DIR}/test_tcp_check_syncookie_user"
>  
> diff --git a/tools/testing/selftests/bpf/test_xdp_redirect.sh b/tools/testing/selftests/bpf/test_xdp_redirect.sh
> index c033850886f4..57c8db9972a6 100755
> --- a/tools/testing/selftests/bpf/test_xdp_redirect.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_redirect.sh
> @@ -52,8 +52,8 @@ test_xdp_redirect()
>  		return 0
>  	fi
>  
> -	ip -n ns1 link set veth11 $xdpmode obj xdp_dummy.o sec xdp_dummy &> /dev/null
> -	ip -n ns2 link set veth22 $xdpmode obj xdp_dummy.o sec xdp_dummy &> /dev/null
> +	ip -n ns1 link set veth11 $xdpmode obj xdp_dummy.o sec xdp &> /dev/null
> +	ip -n ns2 link set veth22 $xdpmode obj xdp_dummy.o sec xdp &> /dev/null
>  	ip link set dev veth1 $xdpmode obj test_xdp_redirect.o sec redirect_to_222 &> /dev/null
>  	ip link set dev veth2 $xdpmode obj test_xdp_redirect.o sec redirect_to_111 &> /dev/null
>  
> diff --git a/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh b/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
> index 1538373157e3..351955c2bdfd 100755
> --- a/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_redirect_multi.sh
> @@ -88,7 +88,7 @@ setup_ns()
>  		# Add a neigh entry for IPv4 ping test
>  		ip -n ns$i neigh add 192.0.2.253 lladdr 00:00:00:00:00:01 dev veth0
>  		ip -n ns$i link set veth0 $mode obj \
> -			xdp_dummy.o sec xdp_dummy &> /dev/null || \
> +			xdp_dummy.o sec xdp &> /dev/null || \
>  			{ test_fail "Unable to load dummy xdp" && exit 1; }
>  		IFACES="$IFACES veth$i"
>  		veth_mac[$i]=$(ip link show veth$i | awk '/link\/ether/ {print $2}')
> diff --git a/tools/testing/selftests/bpf/test_xdp_veth.sh b/tools/testing/selftests/bpf/test_xdp_veth.sh
> index 995278e684b6..a3a1eaee26ea 100755
> --- a/tools/testing/selftests/bpf/test_xdp_veth.sh
> +++ b/tools/testing/selftests/bpf/test_xdp_veth.sh
> @@ -107,9 +107,9 @@ ip link set dev veth1 xdp pinned $BPF_DIR/progs/redirect_map_0
>  ip link set dev veth2 xdp pinned $BPF_DIR/progs/redirect_map_1
>  ip link set dev veth3 xdp pinned $BPF_DIR/progs/redirect_map_2
>  
> -ip -n ns1 link set dev veth11 xdp obj xdp_dummy.o sec xdp_dummy
> +ip -n ns1 link set dev veth11 xdp obj xdp_dummy.o sec xdp
>  ip -n ns2 link set dev veth22 xdp obj xdp_tx.o sec xdp
> -ip -n ns3 link set dev veth33 xdp obj xdp_dummy.o sec xdp_dummy
> +ip -n ns3 link set dev veth33 xdp obj xdp_dummy.o sec xdp
>  
>  trap cleanup EXIT
>  
> diff --git a/tools/testing/selftests/bpf/xdping.c b/tools/testing/selftests/bpf/xdping.c
> index 842d9155d36c..f9798ead20a9 100644
> --- a/tools/testing/selftests/bpf/xdping.c
> +++ b/tools/testing/selftests/bpf/xdping.c
> @@ -178,9 +178,9 @@ int main(int argc, char **argv)
>  		return 1;
>  	}
>  
> -	main_prog = bpf_object__find_program_by_title(obj,
> -						      server ? "xdpserver" :
> -							       "xdpclient");
> +	main_prog = bpf_object__find_program_by_name(obj,
> +						      server ? "xdping_server" :
> +							       "xdping_client");

checkpatch doesn't like the text alignment here, not that you changed it

>  	if (main_prog)
>  		prog_fd = bpf_program__fd(main_prog);
>  	if (!main_prog || prog_fd < 0) {
> 


