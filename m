Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D95C486EE6
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 01:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343836AbiAGAeA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 19:34:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59002 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1343832AbiAGAeA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 19:34:00 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 2070DKoX013837;
        Thu, 6 Jan 2022 16:33:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LfVzO4h4kGKM75zJDAkhUgAa+6IEXZ4vcuFuPHIL5Sc=;
 b=PDEnJ9kv6NWiDo2BsLEyfbz3aFX4Ljl+5HUfJtLc1FRvcVd9PlvpEgg9uhfL8Us1sO96
 WVDBIcxYH4BOFJCl4CPORBeZmwa/EHIcJ2DLgTnX/VVRJsMpMhH2YdP2R/eU94RuHpZC
 pvSHr5lv80yTajn7CfI9GKmFQ2IDF8QE2Yg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0001303.ppops.net (PPS) with ESMTPS id 3de4xftft2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jan 2022 16:33:44 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 16:33:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bt242UK6jgGEc2ytAUvGmgslhtRt8M5i8rXayomirDfW45lprpG5fboG/w5aBnLoKkRRvZ58DZ1WaU/xZxKkSupy3YoWxWKK6YcqetLc00/ktYjy62b1qH8IsyuLo0YqaLM1LR5aeJTwNxfTsPHJYhNRhsWRinTrudUecBU/FNLE4SxmonfRveyLnbN/Wenf0qrfRo8W7aumUGjVvN9WpA8x7vL7VVMpTU4l/bd1ewOMV2QAo1oHRNttepD8n2OtwFALOlu3YeVxlKh8gkLYK20/Lwt35+Zfm11lzFCQ6lAPye8p4E4ZmQMJNEchKN8rWbRzYfvWK/l//4q7qLgO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfVzO4h4kGKM75zJDAkhUgAa+6IEXZ4vcuFuPHIL5Sc=;
 b=bePcAn/nDQ4LLsmmyO9O+briZSKSUgfdiw+kTd50qyUk/uGjIuvZSuNUHDQPcdmUJ3liebVvXT/STUN9ohzEIE2feodEdf2P3RA9bhcArkZ12CnCTdHDPUG5fKweARa0odRj9KRzN+X3YR7EdFmApfHfSR3ZwHSqHMaW9K3p75qNzSw8YtDukgsUJfWPvW0lAZpWFECLapmfwWKaJ40AP8+ns0ifEQwzpLsTfTNodG+UsAFhatOUGXg1YKivv3tMG5RIqb0ynf/B/QhNeUZF+TspetCpKpVcH40mDFc4PuOE8C3Bc9BGo7xerVwTAXgKgacZsmXOIOFYAqJSDIP7mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM6PR15MB3797.namprd15.prod.outlook.com (2603:10b6:5:2b7::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 00:33:37 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::8988:8ab3:bd6f:514f]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::8988:8ab3:bd6f:514f%3]) with mapi id 15.20.4867.009; Fri, 7 Jan 2022
 00:33:37 +0000
Message-ID: <481d3cf2-cb51-50c7-f088-df33e08667cd@fb.com>
Date:   Thu, 6 Jan 2022 16:33:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH RFC bpf-next v1 1/8] bpf: Support pinning in non-bpf file
 system.
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
CC:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Stanislav Fomichev <sdf@google.com>, <bpf@vger.kernel.org>
References: <20220106215059.2308931-1-haoluo@google.com>
 <20220106215059.2308931-2-haoluo@google.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220106215059.2308931-2-haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR1601CA0014.namprd16.prod.outlook.com
 (2603:10b6:300:da::24) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9a82bd1-42c4-40d1-cccc-08d9d1755821
X-MS-TrafficTypeDiagnostic: DM6PR15MB3797:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB3797797158716CF86EA46748D34D9@DM6PR15MB3797.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F1eRBHC+0bIoLSWyuSTZFGrGrP00KjamotPKt/+Bg0D7qPpvY3SMaWGAIHRUKg22OpCqru0IH1zXsj3gx6iV52ThGdi4lC2Wxj7aqUBBRGJidy65Cqw6ivPBIOuTVJFFwnzGr1yxUEUHqiBQsQuVsPlrZvjSN2uu5vLrEFiLtSPe0erUb7eq9p96mo22gzAAduaZ/cB0C3n6VarE51l0mVv4S7NDGXYVmzL2HsAObA1jO7onR0tpqvSD4IDpuAi0iO1teQTc/punByxt7VwFn/9CctoD0WhvpxeIcVHv04u33+rbfxCvBYYwAjOK8GGl0YW7fDNARkut554yYX+AzhmZr4jw5Y5wM3G7d/LNbHX8lJg1IQ+q6Tnh7LOmPE29fZZjYcKURFXHu4oBx6hw1UVe2Cp1q/7g2YqZP9v0NAZ5Bhe13UpKUvPw2qgK3ThuZpFIB409WNZT7frvXlTZ8QygdKvJ4RLKHiGxJBANoVs4O2ZfAZ98fj5FZT/D5TppEZD5KUor8UW/dk0zr4gpgUyG7iP6UE1Tok5mi3xkZ20eOzL9mROydT3uobZaNvJezcD9fpaEvOJ8WZUTBgtuPY/9rTNHc1uEUs9as7enMezSTSTtj5wqhvA5/bso7MB6SvTHh4IC9AaI8IxMoQjjiVK9nRhNEn8d+9+JNKpNMuu+VbhSp99pOpNuKsk9bXAo4w+t8zyL6UE76j4fzxnjyRGVRBXI9fn15YwrNQYSphQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6512007)(6506007)(4326008)(2616005)(53546011)(52116002)(8936002)(110136005)(6666004)(36756003)(316002)(6486002)(186003)(508600001)(31696002)(66476007)(38100700002)(66556008)(2906002)(66946007)(5660300002)(54906003)(86362001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGdUUFRsWjFpRkJVaUJSVGs2Q1pRTEVMTCtvbnZMSHRYYldmQ2JTS1gxVHdP?=
 =?utf-8?B?UjRNeHFsM0FYQzl4b2szQUNuR0VZTVhPK0UzV1pvRnhkQ0tuWHB1NDlZNkdK?=
 =?utf-8?B?UDV0dGJyaUEwS2FGa0R1SEE1M1JPZVJ5ZTU2dW9pbmdzUmFTMGZmVTEvV0RH?=
 =?utf-8?B?eURPVVpUSU9lTVhjMWhKQXhUM3RoMnkxVEI5RTVTZk43RnBhaEVQdzEremNO?=
 =?utf-8?B?dGZHUzVKczNLdkt4cW5TbXc0RVd1YlRtcXFVN1NLUUQvbEtNL1UvcHNId1hk?=
 =?utf-8?B?ZDYxNmRrMTVuTHJNbW1RU0YzdkxNdDRoM2RTbGdKZVM4enJNamRtU1VKaCtx?=
 =?utf-8?B?dmFhQ0NOV3BlNXdmcFNiUDlmZ0NiRG45TGpWbzZOcUZXajVqdnFXMlVZQW5Y?=
 =?utf-8?B?eGdCU1dDeHBmLzJLdm9ZemFTcUZwWWxSVzFVZnhGWFdlcmovaDE5ak1HcThp?=
 =?utf-8?B?WDdGTmQ1THZWbUlWN2Q5eFF5dlBRMnBkVVc3emZHMFpQTmlwejRFZlBFL0lV?=
 =?utf-8?B?R1N4SXk4R1pQWW1oQmwzZHRKOUtlUFNTUTNZU2l1bGFpcjRacnd2LzVFQzBi?=
 =?utf-8?B?VDRiR21IcVpmZGpjT0txanpXWG92c2VLd1Nvd2wrT2NxRENCaVFKQlRsck1U?=
 =?utf-8?B?R05kRjhqZDZCakdua1puV0NyaktPNjBRc2NYQUFtWXR6cC9rTU9naWhOY3l1?=
 =?utf-8?B?cGNGQVJkUVlGLzZhc0dOYUFJOTBQa2NqZ1Y0VzBWQmNaRU1pWmtabkh6OVhk?=
 =?utf-8?B?SzZRWTY2QTJ3REFuMlRZZzR6d29aY2xlZEk0RURrQVpaRFB5ZTBRdmlqbXAx?=
 =?utf-8?B?Nm5jdW1ubTU3V0drOGdNMUpKNjdERUYzQVdtOHFQNnZidGlnanFDTmoyR1dx?=
 =?utf-8?B?NVlvU0VIcDdkVGM3VGZ5NW9ZVXNHazJwQ0ZJUzRCSGQ5M0VvZStrQmp4WlB3?=
 =?utf-8?B?N2NYUEdBSFlHeWpETExPSnlyZ2pISVZrYkRGeVhmOG1tM1JJaGJUWFFNeXF2?=
 =?utf-8?B?ZFdqRlFLWnQ2YlZrYXgrS3RHWUt0cHJEaDhjSERDNVZzUlhvUzNUQ09nNElh?=
 =?utf-8?B?cXpoZEZwVkNBNW5mRHgzZ2FFcGJqMDZPTjVtSks5ZnBzY0UxZ3ZBbDY2KzY3?=
 =?utf-8?B?S1JrQXdJTXVqS3had3BkRU5mWGJLZ2ZUSGlvV2UrdlZNL1c3T2xpR1RBMzlZ?=
 =?utf-8?B?TUxLYzZQVDQyQ1QwWUxOSERzMXEzVVBCcXJkOGJFd3l4K1BHREpENlZ4TVVN?=
 =?utf-8?B?bEF0YWhxREdDM1gyNlpZY0tiSXZTZ2NRNUVTNGI0N2JYVUN5YTVsSENsZWpP?=
 =?utf-8?B?SnYxLzVPcDJhbXJBdEhYQWtaUVpiT3RHQSttTklaay9JYkFZeEZqeFVSd2tH?=
 =?utf-8?B?NUsyOWRZUjZ2VkFjUE8rWTNpM3FjcHczWTNraTFVS2xMUlRrK1djOG9nTmpT?=
 =?utf-8?B?Mm4vL3JCZlRXSVNrLzZmalYwTFVpdmswL0p0WlRTdjd1OWM4VWNvKzVnRlp4?=
 =?utf-8?B?M2U2OE40M0lIQ1NGNTlaM2h0MlovRURHN2hEdzlEenRTbU9YaVpYTzVxUHBD?=
 =?utf-8?B?WTZQNGlWRGdFWlljQ3N5MUhkYlV2NnV5U0xhSVl5K3MzWHhrUjl1YUgvcStL?=
 =?utf-8?B?OWdmeGJFTVY1dnNzbjZyUzNwN3g2Mjk1RkhyazhuTUg2RDhicjBqN3NubFpW?=
 =?utf-8?B?VXhlL2FSRWJFbDdCL3VGeVo5UkJWWkVqSjVFT2RxUkxwM2xHT2o0TlhldHkz?=
 =?utf-8?B?S2VpdTRweGhiV25La2d4VHZKQnJUUkptRFFNb29JWUNpMTN6QzVwQVppcEth?=
 =?utf-8?B?OHk1V040WVE2SndaTTQvRnBrOU9RUUFHa0hOSGxHSFFCVUhYdWgwdDYvSk9h?=
 =?utf-8?B?RDRoUDVBTGNVMVBZazRRTUd4MkJLdzYxUm51MWRxVXFoWGNhRFJyVUhCUXFj?=
 =?utf-8?B?RjhOQWttRXZid3F0WFNzakt0Ri9wQnhPd0dnRGFyNjhFUm8rb0xrVmNFUURP?=
 =?utf-8?B?VEtIU3FtSSswdmF6TkJUSnZaQVZ2R0lZdVJlemJPaGsyM0lTREZRSCtZOHZy?=
 =?utf-8?B?NWRPWThNMVQ1anV5MCs1NS9ONHpRRE5NL0srNlhIK0ZYT0p2VnlZOXNmc0xV?=
 =?utf-8?Q?wz5k0qeGoGtWH7rvmJ07PciXX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a82bd1-42c4-40d1-cccc-08d9d1755821
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 00:33:37.0405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tT8jFTPUWJ3UcQ5YRuCrwx8JSUdEKN6lpiCh7epjaUEJYdJr1o3leeGZR20+xql7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3797
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: UlXPPRjn322eEPa-FFsy1A1XIlgj5ykV
X-Proofpoint-ORIG-GUID: UlXPPRjn322eEPa-FFsy1A1XIlgj5ykV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-06_10,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 impostorscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 mlxscore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070001
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/6/22 1:50 PM, Hao Luo wrote:
> Introduce a new API called bpf_watch_inode() to watch the destruction of
> an inode and calls a registered callback function. With the help of this
> new API, one can implement pinning bpf objects in a non-bpf file system
> such as sockfs. The ability of pinning bpf objects in an external file
> system has potential uses: for example, allow using bpf programs to
> customize file behaviors, as we can see in the following patches.
> 
> Extending the pinning logic in bpf_obj_do_pin() to associate bpf objects
> to inodes of another file system is relatively straightforward. The
> challenge is how to notify the bpf object when the associated inode is
> gone so that the object's refcnt can be decremented at that time. Bpffs
> uses .free_inode() callback in super_operations to drop object's refcnt.
> But not every file system implements .free_inode() and inserting bpf
> notification to every target file system can be too instrusive.
> 
> Thanks to fsnotify, there is a generic callback in VFS that can be
> used to notify the events of an inode. bpf_watch_inode() implements on
> top of that. bpf_watch_inode() allows the caller to pass in a callback
> (for example, decrementing an object's refcnt), which will be called
> when the inode is about to be freed. So typically, one can implement
> exposing bpf objects to other file systems in the following steps:
> 
>   1. extend bpf_obj_do_pin() to create a new entry in the target file
>      system.
>   2. call bpf_watch_inode() to register bpf object put operation at
>      the destruction of the newly created inode.
> 
> Of course, on a system with no fsnotify support, pinning bpf object in
> non-bpf file system will not be available.
> 
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>   kernel/bpf/inode.c | 118 ++++++++++++++++++++++++++++++++++++++++-----
>   kernel/bpf/inode.h |  33 +++++++++++++
>   2 files changed, 140 insertions(+), 11 deletions(-)
>   create mode 100644 kernel/bpf/inode.h
> 
> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
> index 80da1db47c68..b4066dd986a8 100644
> --- a/kernel/bpf/inode.c
> +++ b/kernel/bpf/inode.c
> @@ -16,18 +16,13 @@
>   #include <linux/fs.h>
>   #include <linux/fs_context.h>
>   #include <linux/fs_parser.h>
> +#include <linux/fsnotify_backend.h>
>   #include <linux/kdev_t.h>
>   #include <linux/filter.h>
>   #include <linux/bpf.h>
>   #include <linux/bpf_trace.h>
>   #include "preload/bpf_preload.h"
> -
> -enum bpf_type {
> -	BPF_TYPE_UNSPEC	= 0,
> -	BPF_TYPE_PROG,
> -	BPF_TYPE_MAP,
> -	BPF_TYPE_LINK,
> -};
> +#include "inode.h"
>   
>   static void *bpf_any_get(void *raw, enum bpf_type type)
>   {
> @@ -67,6 +62,95 @@ static void bpf_any_put(void *raw, enum bpf_type type)
>   	}
>   }
>   
> +#ifdef CONFIG_FSNOTIFY
> +/* Notification mechanism based on fsnotify, used in bpf to watch the
> + * destruction of an inode. This inode could an inode in bpffs or any
> + * other file system.
> + */
> +
> +struct notify_mark {
> +	struct fsnotify_mark fsn_mark;
> +	const struct notify_ops *ops;
> +	void *object;
> +	enum bpf_type type;
> +	void *priv;
> +};
> +
> +struct fsnotify_group *bpf_notify_group;
> +struct kmem_cache *bpf_notify_mark_cachep __read_mostly;
> +
> +/* Handler for any inode event. */
> +int handle_inode_event(struct fsnotify_mark *mark, u32 mask,
> +		       struct inode *inode, struct inode *dir,
> +		       const struct qstr *file_name, u32 cookie)
> +{
> +	return 0;
> +}
> +
> +/* Handler for freeing marks. This is called when the watched inode is being
> + * freed.
> + */
> +static void notify_freeing_mark(struct fsnotify_mark *mark, struct fsnotify_group *group)
> +{
> +	struct notify_mark *b_mark;
> +
> +	b_mark = container_of(mark, struct notify_mark, fsn_mark);
> +
> +	if (b_mark->ops && b_mark->ops->free_inode)
> +		b_mark->ops->free_inode(b_mark->object, b_mark->type, b_mark->priv);
> +}
> +
> +static void notify_free_mark(struct fsnotify_mark *mark)
> +{
> +	struct notify_mark *b_mark;
> +
> +	b_mark = container_of(mark, struct notify_mark, fsn_mark);
> +
> +	kmem_cache_free(bpf_notify_mark_cachep, b_mark);
> +}
> +
> +struct fsnotify_ops bpf_notify_ops = {
> +	.handle_inode_event = handle_inode_event,
> +	.freeing_mark = notify_freeing_mark,
> +	.free_mark = notify_free_mark,
> +};
> +
> +static int bpf_inode_type(const struct inode *inode, enum bpf_type *type);
> +
> +/* Watch the destruction of an inode and calls the callbacks in the given
> + * notify_ops.
> + */
> +int bpf_watch_inode(struct inode *inode, const struct notify_ops *ops, void *priv)
> +{
> +	enum bpf_type type;
> +	struct notify_mark *b_mark;
> +	int ret;
> +
> +	if (IS_ERR(bpf_notify_group) || unlikely(!bpf_notify_mark_cachep))
> +		return -ENOMEM;
> +
> +	b_mark = kmem_cache_alloc(bpf_notify_mark_cachep, GFP_KERNEL_ACCOUNT);
> +	if (unlikely(!b_mark))
> +		return -ENOMEM;
> +
> +	fsnotify_init_mark(&b_mark->fsn_mark, bpf_notify_group);
> +	b_mark->ops = ops;
> +	b_mark->priv = priv;
> +	b_mark->object = inode->i_private;
> +	bpf_inode_type(inode, &type);
> +	b_mark->type = type;
> +
> +	ret = fsnotify_add_inode_mark(&b_mark->fsn_mark, inode,
> +				      /*allow_dups=*/1);
> +
> +	fsnotify_put_mark(&b_mark->fsn_mark); /* match get in fsnotify_init_mark */
> +
> +	return ret;
> +}
> +#endif
> +
> +/* bpffs */
> +
>   static void *bpf_fd_probe_obj(u32 ufd, enum bpf_type *type)
>   {
>   	void *raw;
> @@ -435,11 +519,15 @@ static int bpf_iter_link_pin_kernel(struct dentry *parent,
>   	return ret;
>   }
>   
> +static bool dentry_is_bpf_dir(struct dentry *dentry)
> +{
> +	return d_inode(dentry)->i_op == &bpf_dir_iops;
> +}
> +
>   static int bpf_obj_do_pin(const char __user *pathname, void *raw,
>   			  enum bpf_type type)
>   {
>   	struct dentry *dentry;
> -	struct inode *dir;
>   	struct path path;
>   	umode_t mode;
>   	int ret;
> @@ -454,8 +542,7 @@ static int bpf_obj_do_pin(const char __user *pathname, void *raw,
>   	if (ret)
>   		goto out;
>   
> -	dir = d_inode(path.dentry);
> -	if (dir->i_op != &bpf_dir_iops) {
> +	if (!dentry_is_bpf_dir(path.dentry)) {
>   		ret = -EPERM;
>   		goto out;
>   	}
> @@ -821,8 +908,17 @@ static int __init bpf_init(void)
>   		return ret;
>   
>   	ret = register_filesystem(&bpf_fs_type);
> -	if (ret)
> +	if (ret) {
>   		sysfs_remove_mount_point(fs_kobj, "bpf");
> +		return ret;
> +	}
> +
> +#ifdef CONFIG_FSNOTIFY
> +	bpf_notify_mark_cachep = KMEM_CACHE(notify_mark, 0);
> +	bpf_notify_group = fsnotify_alloc_group(&bpf_notify_ops);
> +	if (IS_ERR(bpf_notify_group) || !bpf_notify_mark_cachep)
> +		pr_warn("Failed to initialize bpf_notify system, user can not pin objects outside bpffs.\n");
> +#endif
>   
>   	return ret;
>   }
> diff --git a/kernel/bpf/inode.h b/kernel/bpf/inode.h
> new file mode 100644
> index 000000000000..3f53a4542028
> --- /dev/null
> +++ b/kernel/bpf/inode.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */

GPL-2.0-only? This file is kernel only.

> +/* Copyright (c) 2022 Google
> + */
> +#ifndef __BPF_INODE_H_
> +#define __BPF_INODE_H_
> +
> +enum bpf_type {
> +	BPF_TYPE_UNSPEC = 0,
> +	BPF_TYPE_PROG,
> +	BPF_TYPE_MAP,
> +	BPF_TYPE_LINK,
> +};
> +
> +struct notify_ops {
> +	void (*free_inode)(void *object, enum bpf_type type, void *priv);
> +};
> +
> +#ifdef CONFIG_FSNOTIFY
> +/* Watch the destruction of an inode and calls the callbacks in the given
> + * notify_ops.
> + */
> +int bpf_watch_inode(struct inode *inode, const struct notify_ops *ops,
> +		    void *priv);
> +#else
> +static inline
> +int bpf_watch_inode(struct inode *inode, const struct notify_ops *ops,
> +		    void *priv)
> +{
> +	return -EPERM;
> +}
> +#endif  // CONFIG_FSNOTIFY
> +
> +#endif  // __BPF_INODE_H_

For the above two. C style comment is preferred.
