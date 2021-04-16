Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6F63625FF
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235437AbhDPQuy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Apr 2021 12:50:54 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:62282 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236502AbhDPQux (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 16 Apr 2021 12:50:53 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13GGaHC1015872;
        Fri, 16 Apr 2021 09:50:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9t5D9lX2LWlKhu9YG31RVQiJiLnVmRck8jvP8sTcKg4=;
 b=FVnpvZnNxIV/Abe+G+OWFtdoAPhyKRtZam9XcfSjeidZGX2Dt8211J9RN0kOYULpf+po
 cA3U3sPNwKkAhbNpKSXmRDCW0XoVXrTpf/9Od74nyexV32HgB8b56uW6uUSsCm4hH6uu
 Uk6e8n775AfbmK8pFNPQ/zMSjg2cQTUw+E4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37yb5j18rm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 16 Apr 2021 09:50:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 09:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iBfHlcX/L6LS1IOMpj3cggfvzhCAdMB2pYL5cbeYlAWmrxVKxdMRCVp+akpGzRccVeo8uLa0LkfN93YXQDanj+KbwijUPQzLPzpeeGOkO2KL5kehKegMffuBxwH9noYDycHfESlUHkW2MT9adqYXrVj5M/gzoe4EE64VAAiLtuZ6/6yz4Gxwv04QZ9rcYu814qvrqJFLCTLYYWLZgYGOQJT9iUk1tJIb3XHuQsXo+KcvJOo3l6spH/eX9WS4OrDiEjfhm+YoizK162UsLcEPJJ+/JrSj9pt3HdV47l0rs48WH30VT9Ih/Ks0FY2FHlmSTNDytWCHeGRzm1fY+Lgncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9t5D9lX2LWlKhu9YG31RVQiJiLnVmRck8jvP8sTcKg4=;
 b=mRdKSvl/8yzm5qUGO72/Rb66ExhB4xG1g0Hwo7HHlmWXolo5GNlpX62pmWlDul+99IidSCzXYzH0GHJDF2rBO1AaqI1DOasImqJ3NhXw0JvfLxGLm+ks0v1F/SLRwgKNhxf8hIbRtMWUC/qIwF0Vnj1fO9S4nxBdS1CChsEF5xQhDp96yAWLwx2t0GGQOOfbKG44NZwzWkaI+cJgOvh1/bbsCatnsVdIkd8cP52sd40ntiWXzp9qzkd8T9JcmVJ2YW51H6H+l4YJz2BI6UwTfetG4SGSJF6oaR5GjqTodPICnuKl5Cdaykp8ktZenUa2HZDX7d6kswPFbOsN8aJzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: iogearbox.net; dkim=none (message not signed)
 header.d=none;iogearbox.net; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3982.namprd15.prod.outlook.com (2603:10b6:806:88::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 16 Apr
 2021 16:50:12 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.038; Fri, 16 Apr 2021
 16:50:12 +0000
Subject: Re: [PATCH v5 bpf-next 1/3] bpf: add lookup_and_delete_elem support
 to hashtab
To:     Denis Salopek <denis.salopek@sartura.hr>, <bpf@vger.kernel.org>
CC:     Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Luka Oreskovic <luka.oreskovic@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20210416095814.2771-1-denis.salopek@sartura.hr>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <89e0177e-2ff4-f2a2-9e17-7f86fbc1b13c@fb.com>
Date:   Fri, 16 Apr 2021 09:50:08 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <20210416095814.2771-1-denis.salopek@sartura.hr>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:7e08]
X-ClientProxiedBy: MW4PR04CA0083.namprd04.prod.outlook.com
 (2603:10b6:303:6b::28) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::112e] (2620:10d:c090:400::5:7e08) by MW4PR04CA0083.namprd04.prod.outlook.com (2603:10b6:303:6b::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend Transport; Fri, 16 Apr 2021 16:50:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5743b2b8-21be-472e-a688-08d900f7b3de
X-MS-TrafficTypeDiagnostic: SA0PR15MB3982:
X-Microsoft-Antispam-PRVS: <SA0PR15MB39823990450D353EDBB6CA92D34C9@SA0PR15MB3982.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O3RuWpulwxUrzKLu78pWpxGxIhbJ97yL1LZyLw/1uQtRNluN1B1u4tCltv0pzTGEF4NzFvgs9ISB/b/SsyCL2D79BMFr/tmAW66hKbWHPebAHM0g5ORZpEs3C3exVt9tOAqueILNSX/2B6AsMna/+RPpxED3UmZ+h8Ty0zyHflb464xOPufxwUxeHmpR69UpJXqoyUfGwACHP6pLkC7rE04ghEeRoN8hUO2yLlHhsuhkQsjlxwypw1uXMeFiHM91FiG26chCXw2JRpymdofTvxIouj74ydrl4yaPiqRn7As3CmYVxKMK53WWThqlEgOzctgydbsDqfO5eH0Bs+/Cn3/XFHGSmOLNuI+e+cKiheTMHNRpCuWwBXQz3QJ44wuOpAWpZpIeVTR8sGgfdd+chdVxUrrSzO4ks1+Y4V7mYW4xmNRD8akApffdN+q0LJr2CxT0Rqdfu5ZuzTDuGdx+uv4qcRyjVnBSVMM2QjWYnXxbMo6kJeJrfCwwfRqSmv5zmeFD68Ohdap80CjeV+4HbgNhl3Bwu1fKueuReeOEpohe76ivXi26S/LC5Z1FCnyHrjJiEJWk5WY3t8RRs4yQSmZENuUJEjNGPHKWwnJjYt2x041TlPTOCbVvABN8E68ILG+r6UR54taD+UUgPF+KXuXT5UQyLtXyLSXwB8bL0fWwj6SfUaS/X0zReHg0vrSx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(366004)(39860400002)(376002)(30864003)(2616005)(316002)(83380400001)(31696002)(8676002)(186003)(6666004)(66946007)(16526019)(478600001)(6486002)(4326008)(86362001)(53546011)(52116002)(38100700002)(8936002)(2906002)(66476007)(31686004)(54906003)(66556008)(5660300002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UkJWdncyMnBrUHhaZFEvdU9mRWRrdGRKN3Y2emdDREFEMk1Xb3RTR2h4RlA1?=
 =?utf-8?B?VFBicGlMK0k4U3BXVlVnK0ovYzhXMzBOMlFsUFEyRHYrREw2NTlZaStFcGtB?=
 =?utf-8?B?ejlXMDY1YVVvL0xrZzRTcmk3TE9tNFJTbzhiUGIySlZSSXFOOEp2Si9XMlV6?=
 =?utf-8?B?eXR0VTVDaUlvaTViN2oyakxSekFKbFZIQjlBeGU0dENpY3FqZDNwRzc4MXhR?=
 =?utf-8?B?N3BORU9mUWRDY254Z3ZsQ0h6aFRRZGw0NThZVkpieHV4WTR3THFPTGxSMkpH?=
 =?utf-8?B?SmkybnphY3N0bzRFQSszcGQ4QllKNk9uUDdtdWsxVGlFTVhzOEx2S1hOYjVz?=
 =?utf-8?B?RUZDTlRUODgzY1J6ZURFMjVHL3o1RitGUHR4Qy9JUDErc0hWaGQ5Yk9kOTR1?=
 =?utf-8?B?c0lvTWJXT3V0YVZldjBMU0VjRFN4Snh1Nzh6ZWFnQTdQaHYwV3RSZVcxREhW?=
 =?utf-8?B?MDdVTkJERHRtSVRCSVFTRnBadWZUVC9VdEUyTjNBQ2FiZjRmbHVMY1FGeWd4?=
 =?utf-8?B?Slh1SXFYSHF0alVocHVNeWJMMmdWcmlaV2FFamx0TnpUNnZNOWhzeFlNcHkw?=
 =?utf-8?B?SW1mb0xPdWVaNE5DSjFheFJVTUNRWEZGNVRDVXg5Zk1xbG9GZUVKaDJFUjRv?=
 =?utf-8?B?cTRuUkltL1JxRENWNnVGdDB3NUxSaEtyOFpydEJMZmdPcVVxQUdSYkhQay9v?=
 =?utf-8?B?aXdCMjN0TjFQb01SL0dIR2lPd0E5Y0twbGxOUXdvMUJ2NEx6aUVzL0srNmIr?=
 =?utf-8?B?WVR1Z29VT1kvcGQ4V25Rb0RZeEZnTmQzN1JzT2RCN21CcDNCNEdUMGRCMnM1?=
 =?utf-8?B?UnhBU1hUeHJ4Z2V2VUtEVTZhckpqSXBDWFBZY3BpcFZocmdZK1JFR2ZMLzJy?=
 =?utf-8?B?YTY1NkU4SVJETHFFVU52bGlzcTJ0OUJxTkI3dStibWN5RWlKL2RlK0VLYWEv?=
 =?utf-8?B?T1RNWWU5aUJMeVc5RkQrbDhuSUNiMHVkWHovU3MrYzlla04yQ2FIYjBlZSsv?=
 =?utf-8?B?OGpDcXdkeUtpUTFBMXJlWGtFT1p0YWF6dkhSN1lhWjFyeEdyaXJleHNLQTlV?=
 =?utf-8?B?VmZxSk1ob0wzd2twVXVWMzRUbGJrS1VnZnZzVmtKZ0NjYXgwVGRDYUwxQzE0?=
 =?utf-8?B?OXBYVFZraVBDQWcxTEtkQW9oYWszM1ZndEk0NjY0ajlHemNnUFhnakJUZU1h?=
 =?utf-8?B?RGpwWUxwT3JnQ2ZDWkJ2RkN2bXFBY09NSFFQeTNDUmRoR2w3bDJSaldZanRN?=
 =?utf-8?B?THdta0hrQXZWMzUyTjRqMk1TbkIzaE91Ly8zZkJOd1ZWK05aZmlSYWgyQ09r?=
 =?utf-8?B?K1BBcG82c0w1UFJpcTZwS3VnajY3eWltMWVQakRZRU9YU0dTZmJjbDdDd2g2?=
 =?utf-8?B?YzZFbTBMOGhLYk1Ia1BVd25YeDAvNm5XSFRZUklyS2JDeGpRSTBaWjFsejUz?=
 =?utf-8?B?b2pKRE9uQVVMTWJ5b21STk4rZzVvUXBUVDc0cEp2WmR5NG5PTmViNjRHWHNH?=
 =?utf-8?B?T1ZVMDhEdEtTOW0xTzA1Wm1kalVubENVbGZDKzFUUFVhNCt4UzFTTm55S2Fl?=
 =?utf-8?B?TXFOeGlnMzJTYW4rdlgyakFWOFM3WjVwZG5Ebi85cXoxV1JKQVJoUmJOeVRw?=
 =?utf-8?B?amNQaXBkOEkxdXpHN3RkSmc4NTErSTZabDFtNjBSbElyZ1VMM3Y1TlFHdWt5?=
 =?utf-8?B?dkVNNGZkSjVnVTJEWFRIckxQUk1HZnhPTUhtTnMvbVpEK05SenV1Yzhkbnl3?=
 =?utf-8?B?RXU5WWRJcTZUZ1ZJK0ZRWEFubG1vUm1WQkMxbmFnVS9nZFRDTStSYnoyQzdS?=
 =?utf-8?Q?xs/GdBij3scyFoDDy2v0+9WTWJ6sJrMIQ+6fY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5743b2b8-21be-472e-a688-08d900f7b3de
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 16:50:12.5810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6po82QFNRLNXANKa69LkXnBKmmgQn1aKfYz8RAIh/LZxZkW8w87nAFHe7PwDl++
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3982
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: _xgPMroVdsRxquAQ22i1Vs19FwOsH1mc
X-Proofpoint-ORIG-GUID: _xgPMroVdsRxquAQ22i1Vs19FwOsH1mc
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-16_08:2021-04-16,2021-04-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1011
 phishscore=0 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160120
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/16/21 2:58 AM, Denis Salopek wrote:
> Extend the existing bpf_map_lookup_and_delete_elem() functionality to
> hashtab map types, in addition to stacks and queues.
> Create a new hashtab bpf_map_ops function that does lookup and deletion
> of the element under the same bucket lock and add the created map_ops to
> bpf.h.
> 
> Cc: Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>
> Cc: Luka Oreskovic <luka.oreskovic@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Signed-off-by: Denis Salopek <denis.salopek@sartura.hr>
> ---
> v2: Add functionality for LRU/per-CPU, add test_progs tests.
> v3: Add bpf_map_lookup_and_delete_elem_flags() and enable BPF_F_LOCK
> flag, change CHECKs to ASSERT_OKs, initialize variables to 0.
> v4: Fix the return value for unsupported map types.
> v5: Split patch to 3 patches. Extend BPF_MAP_LOOKUP_AND_DELETE_ELEM
> documentation with this changes.
> ---
>   include/linux/bpf.h            |  2 +
>   include/uapi/linux/bpf.h       | 13 +++++
>   kernel/bpf/hashtab.c           | 99 ++++++++++++++++++++++++++++++++++
>   kernel/bpf/syscall.c           | 33 ++++++++++--
>   tools/include/uapi/linux/bpf.h | 13 +++++
>   5 files changed, 156 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ff8cd68c01b3..d39fe682799e 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -68,6 +68,8 @@ struct bpf_map_ops {
>   	void *(*map_lookup_elem_sys_only)(struct bpf_map *map, void *key);
>   	int (*map_lookup_batch)(struct bpf_map *map, const union bpf_attr *attr,
>   				union bpf_attr __user *uattr);
> +	int (*map_lookup_and_delete_elem)(struct bpf_map *map, void *key,
> +					  void *value, u64 flags);
>   	int (*map_lookup_and_delete_batch)(struct bpf_map *map,
>   					   const union bpf_attr *attr,
>   					   union bpf_attr __user *uattr);
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index df164a44bb41..f30cabe02814 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -527,6 +527,15 @@ union bpf_iter_link_info {
>    *		Look up an element with the given *key* in the map referred to
>    *		by the file descriptor *fd*, and if found, delete the element.
>    *
> + *		For **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** map
> + *		types, the *flags* argument needs to be set to 0, but for other
> + *		map types, it may be specified as:
> + *
> + *		**BPF_F_LOCK**
> + *			Look up and delete the value of a spin-locked map
> + *			without returning the lock. This must be specified if
> + *			the elements contain a spinlock.
> + *
>    *		The **BPF_MAP_TYPE_QUEUE** and **BPF_MAP_TYPE_STACK** map types
>    *		implement this command as a "pop" operation, deleting the top
>    *		element rather than one corresponding to *key*.
> @@ -536,6 +545,10 @@ union bpf_iter_link_info {
>    *		This command is only valid for the following map types:
>    *		* **BPF_MAP_TYPE_QUEUE**
>    *		* **BPF_MAP_TYPE_STACK**
> + *		* **BPF_MAP_TYPE_HASH**
> + *		* **BPF_MAP_TYPE_PERCPU_HASH**
> + *		* **BPF_MAP_TYPE_LRU_HASH**
> + *		* **BPF_MAP_TYPE_LRU_PERCPU_HASH**
>    *
>    *	Return
>    *		Returns zero on success. On error, -1 is returned and *errno*
> diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> index d7ebb12ffffc..5e57503d4706 100644
> --- a/kernel/bpf/hashtab.c
> +++ b/kernel/bpf/hashtab.c
> @@ -1401,6 +1401,101 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
>   	rcu_read_unlock();
>   }
>   
> +static int __htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> +					     void *value, bool is_lru_map,
> +					     bool is_percpu, u64 flags)
> +{
> +	struct bpf_htab *htab = container_of(map, struct bpf_htab, map);
> +	struct hlist_nulls_head *head;
> +	unsigned long bflags;
> +	struct htab_elem *l;
> +	u32 hash, key_size;
> +	struct bucket *b;
> +	int ret;
> +
> +	if ((flags & ~BPF_F_LOCK) ||
> +	    ((flags & BPF_F_LOCK) && !map_value_has_spin_lock(map)))
> +		return -EINVAL;

We don't need to check here. It has been checked in
map_lookup_and_delete_elem().

> +
> +	key_size = map->key_size;
> +
> +	hash = htab_map_hash(key, key_size, htab->hashrnd);
> +	b = __select_bucket(htab, hash);
> +	head = &b->head;
> +
> +	ret = htab_lock_bucket(htab, b, hash, &bflags);
> +	if (ret)
> +		return ret;
> +
> +	l = lookup_elem_raw(head, hash, key, key_size);
> +	if (l) {
> +		if (is_percpu) {
> +			u32 roundup_value_size = round_up(map->value_size, 8);
> +			void __percpu *pptr;
> +			int off = 0, cpu;
> +
> +			pptr = htab_elem_get_ptr(l, key_size);
> +			for_each_possible_cpu(cpu) {
> +				bpf_long_memcpy(value + off,
> +						per_cpu_ptr(pptr, cpu),
> +						roundup_value_size);
> +				off += roundup_value_size;
> +			}
> +		} else {
> +			if (flags & BPF_F_LOCK)
> +				copy_map_value_locked(map, value, l->key +
> +						      round_up(key_size, 8),
> +						      true);
> +			else
> +				copy_map_value(map, value, l->key +
> +					       round_up(key_size, 8));

You can have a common declaration like below in the beginning of the block.
	u32 roundup_key_size = round_up(map->key_size, 8);
and use roundup_key_size in copy_map_value_locked() and
copy_map_value().

> +			check_and_init_map_lock(map, value);
> +		}
> +
> +		hlist_nulls_del_rcu(&l->hash_node);
> +		if (!is_lru_map)
> +			free_htab_elem(htab, l);
> +	} else
> +		ret = -ENOENT;

Probably it is more readable if you write above like
	if (!l) {
		ret = -ENOENT;
	} else {
		...
	}

> +
> +	htab_unlock_bucket(htab, b, hash, bflags);
> +
> +	if (is_lru_map && l)
> +		bpf_lru_push_free(&htab->lru, &l->lru_node);
> +
> +	return ret;
> +}
> +
> +static int htab_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> +					   void *value, u64 flags)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, false, false,
> +						 flags);
> +}
> +
> +static int htab_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
> +						  void *key, void *value,
> +						  u64 flags)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, false, true,
> +						 flags);
> +}
> +
> +static int htab_lru_map_lookup_and_delete_elem(struct bpf_map *map, void *key,
> +					       void *value, u64 flags)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, true, false,
> +						 flags);
> +}
> +
> +static int htab_lru_percpu_map_lookup_and_delete_elem(struct bpf_map *map,
> +						      void *key, void *value,
> +						      u64 flags)
> +{
> +	return __htab_map_lookup_and_delete_elem(map, key, value, true, true,
> +						 flags);
> +}
> +
>   static int
>   __htab_map_lookup_and_delete_batch(struct bpf_map *map,
>   				   const union bpf_attr *attr,
> @@ -1934,6 +2029,7 @@ const struct bpf_map_ops htab_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_map_lookup_and_delete_elem,
>   	.map_update_elem = htab_map_update_elem,
>   	.map_delete_elem = htab_map_delete_elem,
>   	.map_gen_lookup = htab_map_gen_lookup,
> @@ -1954,6 +2050,7 @@ const struct bpf_map_ops htab_lru_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_lru_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_lru_map_lookup_and_delete_elem,
>   	.map_lookup_elem_sys_only = htab_lru_map_lookup_elem_sys,
>   	.map_update_elem = htab_lru_map_update_elem,
>   	.map_delete_elem = htab_lru_map_delete_elem,
> @@ -2077,6 +2174,7 @@ const struct bpf_map_ops htab_percpu_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_percpu_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_percpu_map_lookup_and_delete_elem,
>   	.map_update_elem = htab_percpu_map_update_elem,
>   	.map_delete_elem = htab_map_delete_elem,
>   	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
> @@ -2096,6 +2194,7 @@ const struct bpf_map_ops htab_lru_percpu_map_ops = {
>   	.map_free = htab_map_free,
>   	.map_get_next_key = htab_map_get_next_key,
>   	.map_lookup_elem = htab_lru_percpu_map_lookup_elem,
> +	.map_lookup_and_delete_elem = htab_lru_percpu_map_lookup_and_delete_elem,
>   	.map_update_elem = htab_lru_percpu_map_update_elem,
>   	.map_delete_elem = htab_lru_map_delete_elem,
>   	.map_seq_show_elem = htab_percpu_map_seq_show_elem,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index fd495190115e..78f6312d9bdb 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -1468,7 +1468,7 @@ int generic_map_lookup_batch(struct bpf_map *map,
>   	return err;
>   }
>   
> -#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD value
> +#define BPF_MAP_LOOKUP_AND_DELETE_ELEM_LAST_FIELD flags
>   
>   static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   {
> @@ -1484,6 +1484,9 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   	if (CHECK_ATTR(BPF_MAP_LOOKUP_AND_DELETE_ELEM))
>   		return -EINVAL;
>   
> +	if (attr->flags & ~BPF_F_LOCK)
> +		return -EINVAL;
> +
>   	f = fdget(ufd);
>   	map = __bpf_map_get(f);
>   	if (IS_ERR(map))
> @@ -1494,24 +1497,46 @@ static int map_lookup_and_delete_elem(union bpf_attr *attr)
>   		goto err_put;
>   	}
>   
> +	if (attr->flags && (map->map_type == BPF_MAP_TYPE_QUEUE ||
> +	    map->map_type == BPF_MAP_TYPE_STACK)) {

Need better code alignment.

	if (attr->flags &&
	    (map->map_type == BPF_MAP_TYPE_QUEUE ||
	     map->map_type == BPF_MAP_TYPE_STACK)) {
		...
	}

> +		err = -EINVAL;
> +		goto err_put;
> +	}
> +
> +	if ((attr->flags & BPF_F_LOCK) &&
> +	    !map_value_has_spin_lock(map)) {
> +		err = -EINVAL;
> +		goto err_put;
> +	}
> +
>   	key = __bpf_copy_key(ukey, map->key_size);
>   	if (IS_ERR(key)) {
>   		err = PTR_ERR(key);
>   		goto err_put;
>   	}
>   
> -	value_size = map->value_size;
> +	value_size = bpf_map_value_size(map);
>   
>   	err = -ENOMEM;
>   	value = kmalloc(value_size, GFP_USER | __GFP_NOWARN);
>   	if (!value)
>   		goto free_key;
>   
> +	err = -ENOTSUPP;
>   	if (map->map_type == BPF_MAP_TYPE_QUEUE ||
>   	    map->map_type == BPF_MAP_TYPE_STACK) {
>   		err = map->ops->map_pop_elem(map, value);
> -	} else {
> -		err = -ENOTSUPP;
> +	} else if (map->map_type == BPF_MAP_TYPE_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_PERCPU_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_LRU_HASH ||
> +		   map->map_type == BPF_MAP_TYPE_LRU_PERCPU_HASH) {
> +		if (!bpf_map_is_dev_bound(map)) {
> +			bpf_disable_instrumentation();
> +			rcu_read_lock();
> +			err = map->ops->map_lookup_and_delete_elem(map, key, value, attr->flags);
> +			rcu_read_unlock();
> +			bpf_enable_instrumentation();
> +		}
>   	}
>   
>   	if (err)
[...]
