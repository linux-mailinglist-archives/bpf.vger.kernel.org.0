Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA425A6F07
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 23:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiH3VRr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 17:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiH3VRr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 17:17:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3C5883FA
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 14:17:45 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27UKBMge025981;
        Tue, 30 Aug 2022 14:17:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=NWhN87kcYNZZ3BNHZx/R9QYHiuQKwiqWtpxZamqdaHo=;
 b=NsNLVmrANu2RsuXJ2akH3m1F6+kJByyMIIOtj17iLkPZu4g0DDtyaLaauRtwGdmk7Olm
 0s8/mayqfxbOziIXW03YJFNp0Nyf++DrCbr/AQHAD9BNbhDJ6kRSC31+1TTaRVZAECj+
 fTSYrjXJKuELNvcwf07xmuIzSQ69AeC4Q/4= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j9e9ymqr6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 Aug 2022 14:17:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DPSmbkMyctyra05BP00uB9Qhxgmbl64t/XmyZxzuYJvmWhjL9xCFdt/hYitQXViNBX6is9PFsRZCv60fi8fI5OETzXaEIquUoioYs63YODr+IM4m00I6/on3D9yrQV+Zd0Ito1UEqtnUM0BUsLwHZJzYnYjAA0xMQRiI3MBVxV7RJWkNnYxKiy7riUOoF0UfkFdcWRN2mUv0PXZpm7nHwQipJuTLo/vGe00goFElN6+y0bbdYbCJisLGP6pH2hvTBV37/25HghcjhRiRhF0s2XbMcTbUkgMxGTo6gGOiQIuAwRWreBDz7DouECYhpmPXKD26vLYIiWYTeCBUXEP8pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWhN87kcYNZZ3BNHZx/R9QYHiuQKwiqWtpxZamqdaHo=;
 b=WcK0WEA82zIFywNhgfvxd/QfDrQezuga/jRuw6XOxWWUOQK0IOEX+MqGruZfiSYgA2pLyE8tfO39GtJabzja6RhfhNDtqElkzNurgKSdtCOvFMlGxEoWAUOMASJB3AOcgnq+TpjCUIVW32MMh8PyTfF4UuChHQXvZowwqGCtpRkN7xAs3bWJdi6Xdnj7XmLDQNOBCn3oTWShGXP9VuPfe7M2A44kfnLiML6sFmo57rn8UXyirTs2tHjQNQ9cm6WO13EyMH/2pWNRmvacxyt+akFdYNLsxspNb2XCEKQx+xDoiRLwzrQVLPi1MWs8VggzmIWMwStsbu1wyg5GIM4deA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MWHPR15MB1840.namprd15.prod.outlook.com (2603:10b6:301:57::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 21:17:28 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 21:17:27 +0000
Message-ID: <413f97df-c70a-9ce3-3a4a-90f93d8aa2a0@fb.com>
Date:   Tue, 30 Aug 2022 14:17:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v8 3/5] bpf: Handle show_fdinfo for the
 parameterized task BPF iterators
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220829192317.486946-1-kuifeng@fb.com>
 <20220829192317.486946-4-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220829192317.486946-4-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0052.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6149df1-657b-40d0-7551-08da8acd0a98
X-MS-TrafficTypeDiagnostic: MWHPR15MB1840:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H7hYuQqCJSx8F9x2sYxA3Gi6hqeCQ875vZoj6XEcmH7SY9JbuQloZAJDUtrEAi+JiO+pDEeBrVO7unVPMfTS/xGBSCYRckI/vZkGFLCd7UHym07YWpNbQGUIIhqrZNZVrTjy3A0eeDT6elzfwjfC6nqyGIYvvASA+2l7ivps4gv55QsHdmr+45fviXIbkCzw8NRuZRnFrl7Xu6pSkiXB4H/fivgaSTM6CjFtgESJdGnORCpU/6pEErFSGdTfX4Nq0h1nh7I9tjCNYqjv+3gE9hU3TH//pkIdhdPvOD5pbqHyFYQZ0jFESG+gXipo0X5OW9/awE7FDzmkmPsEyKxbrLbbsAwU1aL2EUfSOeIvg+bIv6mgGmjDeh1MS6i5RDrVkU0HI6w5j2hxh7OGMjp9FbgmSoKApHWFhFD8K2hGUkcOaj6rFmFSFQ53CrnFkvFObMxOo0FE/pINqyvxwYaQ7u6EnlHasDB8XiqHShbapfG/O/ucuc/jFdHzNxIAX4X5lk3s3UE2tyZvZUXGrdcU8WzPlApHhH01sUtEnUW0M+qZEAuF7kjxb551VOJfut4ZEQ6xGr5LQBrjwIQjjSpkQd5cX8iz/zvxLFH/GPi44SuwArbX6wEYtKMXzZWIboT9YvaymALQn2JtPrpQZCDBzhRJhOanZ9JBfhB7NJxerklt+SAnZqB4bg6Plgx9esP4uaSGmdfH8XH4J91dL1kKBt8HHin47+NkrPhG6yUMPtNAyxAsYuXaz+g7H7MdKfHColOLZHJ3IVC0GdmiHdCPMaTrSzwLfkGo3ZJ35p4l6Ew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(366004)(39860400002)(346002)(66476007)(6636002)(66946007)(8676002)(316002)(8936002)(38100700002)(5660300002)(2906002)(66556008)(6506007)(86362001)(6512007)(31696002)(53546011)(36756003)(6486002)(478600001)(2616005)(41300700001)(83380400001)(186003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0IxZ3lMbWM3MHd5RlZJME1PSGpHRVVKSzFkMkpSUzU2VytyZnkwaXdIbXJi?=
 =?utf-8?B?aWszWHU4U2JtOTJrTFpDcWtxWEVhWlFRZkVUSVdRLzBmVW1qVUFDN0hGY29x?=
 =?utf-8?B?K0VMdXpXZ2V2WlFIcURtTmxUWXo3LzRGY1VVQVZMaXo0WXdkK2pBajY3bGRk?=
 =?utf-8?B?aEx6d3pneXp5ZEZ0WE5BY01lek5PS3ROUU04MDE0aG4wYkN6OGd0eHRnQjN4?=
 =?utf-8?B?WUZoblBvU3NScDNKdWhWdVZDKzE3YkcwdUFVYUFodWNxVlgvNHZuMVNjYVlJ?=
 =?utf-8?B?a0V2ZkphL2w2c2hHQjlQUEt0enM3UVRFbDk5VldGY2ZKZ2VIeTlHaVBmRmVF?=
 =?utf-8?B?ZTR0VUt1VnNOZmY4SjZjd1Fja3BhV3JwcDloR0VXRTF3RkZ2RGFqY0JQdkl6?=
 =?utf-8?B?aWtESThHdzM5MHBsQmdwZHpicisyVHBFTWlGWGxKYjIwUmV6Mk0zQk1ZYjRE?=
 =?utf-8?B?T3FFTVZvNUorUGRNYmJWSWwyQ1d0SkdQNzFVcW0rcEVMUEI0Q1NTZlhETHNX?=
 =?utf-8?B?TlFHL0Z3YW1jSHdtTmRweXYxTjhKa2dsei9XRi8zU2dwdnNUcVBNa2k1a2Qv?=
 =?utf-8?B?T3A1M1gva2RoNmZuaHllNzcvdW9lZkM5bjVKTWVKQi92R0lRZy9xQ0tYNUU0?=
 =?utf-8?B?dkFSQ0kvVkJiRjE2NWZCbjRXaHdFSnRSeEwyV3MrbWJNSWZ6b1lvcUJYQ0M0?=
 =?utf-8?B?STJoQTFSZmV5WlhmZ1gxdm94L2NqRUhpUTNMbVhiQ0g1Q3NJM1JYclZVSjdw?=
 =?utf-8?B?WmppVml0U0FwdFhiYmNMQi9FUXpLR3F2N284RzJMS3dkUnNqVkV4K2dPcTNv?=
 =?utf-8?B?VlFoK3VNR2lOMmxHMUJmTmhmRGFRSHF6ZzkzQUx3a2lyRnlzMEU4SkhHWG5F?=
 =?utf-8?B?VHZzK3M0eDFWSjVNbnM2bzMzTEVTUUQyZ2hxcThJbW1JK214TEVGOC92amJj?=
 =?utf-8?B?d0ZENFAyTnNDcUhpV0dyYTNZNVlEWWxHMmtBK0tqQkRWRWVlVnpFM3lnRkdZ?=
 =?utf-8?B?VEEwdFBBRWJRaE1SaHN4SmVQdDNWY0xmR1p6bUNGWmt2aVd5YUpjVUo2NUQr?=
 =?utf-8?B?R01kVEFya1FUVWpJbGpkZTEwRmhZT2dIZThPRmtyU2oxYXllSmdlc3FPUnNo?=
 =?utf-8?B?N2ZvbHlIUXQxVisxUTlEV3greXljSUNKMU1JVTU3eFFuMlV0cmgvNWtvRXpr?=
 =?utf-8?B?TFh1NE1MYVRyZml2YlZsWUozK2NxQUVkZ1pQaGZaT25FcVN1bzluR2EwUXdo?=
 =?utf-8?B?NlNxYUFDU3hiUlJzTzBmSDkyUGVKZ0g1RlpwcFpCQVBRbVZLdlVveHpaRXl4?=
 =?utf-8?B?ZFNvN1d6SGJ3VTMwN1hIWk1ja3RiVkJGTWNDWEgrWUQ5RUl6VXUyK2NyZ0NL?=
 =?utf-8?B?RTFnbmZ5UDgvRDBvR2lwWENWNXhpZjA0WVV5RzdtQ2podUZTMjJBMVZ4d1Ri?=
 =?utf-8?B?MG15RXo2aDBJb1FsWVUvUnhyaE5hMWZUcGpJVWNjazZ4aVYwd280VFl1ZmN4?=
 =?utf-8?B?Sy9Tc3dadXd4ajRXTDBYK293RDRqMnA1czVMK1cyMnAzc2ZCOXpFZEhjd0lY?=
 =?utf-8?B?SjdvSlVhWTd1MkR3ejMvTHM0Qk80QWZjYk11dzd1L2xaazQwZCtuSTRsSWJa?=
 =?utf-8?B?aFYwSEV3WTV3UDFQWTJidkM4WEpGcFNjTXFWaFVvalNtUnlpcXVJSm1mZkRa?=
 =?utf-8?B?M0EzUSt6TVFUSk9HNDFHY2x3cHIvSDRHRzZreW1XWVRMNEJxMnpyRGl4ZFIy?=
 =?utf-8?B?ZFlONlpBRXlFT0loUU1RcW5JOWJySTlRRGwyalF6Q2R4aFdlQ0RRL1VtbW8y?=
 =?utf-8?B?STlIbmx6TS9nVTdzMk9tbnlJSmNkU2l3YTNlT2IxUjVTTGNKTkJYcFVMQTho?=
 =?utf-8?B?ZVdhQVV0UW1rcW5OTjdqeXFzU21aOGgrWWpjYlFXRFZaTUlvMWtZVUljbmZ4?=
 =?utf-8?B?d3dXUUphaVI1V2VEUkJxRkI1WG1oaHFUS0NLRGllenQ1b25pSFM0NTd2ZUxo?=
 =?utf-8?B?RFF3cXUyMDBROHh5TU01dG4yQ3IxSlg2cm9mblUwQnpHcmwzaTR1QnlCckJ4?=
 =?utf-8?B?OEI3MkxRMXVpWjhhcENJc21VdVluWkM0YVBQTVVwZm5GQTduQ212ZTdFTGVO?=
 =?utf-8?B?QWlveE03S0k1bENMTHM1NjZ0YVUyY3RFYURlaE9ja2ZMd2s2VDFIRzhjZnVa?=
 =?utf-8?B?VUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6149df1-657b-40d0-7551-08da8acd0a98
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 21:17:27.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CrSLroNaV7zAIOrWF7oo9dP7I7ZR0S6z88SiBR72fU4yXbU5c99HbDYvwfaokSy2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR15MB1840
X-Proofpoint-ORIG-GUID: ZsAUsmKV130wedkYpJjX3KmyymhJYWth
X-Proofpoint-GUID: ZsAUsmKV130wedkYpJjX3KmyymhJYWth
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-30_12,2022-08-30_01,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/29/22 12:23 PM, Kui-Feng Lee wrote:
> Show information of iterators in the respective files under
> /proc/<pid>/fdinfo/.
> 
> For example, for a task file iterator with 1723 as the value of tid
> parameter, its fdinfo would look like the following lines.
> 
>      pos:    0
>      flags:  02000000
>      mnt_id: 14
>      ino:    38
>      link_type:      iter
>      link_id:        51
>      prog_tag:       a590ac96db22b825
>      prog_id:        299
>      target_name:    task_file
>      task_type:      TID
>      tid: 1723
> 
> This patch add the last three fields.  task_type is the type of the
> task parameter.  TID means the iterator visit only the thread
> specified by tid.  The value of tid in the above example is 1723.  For
> the case of PID task_type, it means the iterator visits only threads
> of a process and will show the pid value of the process instead of a
> tid.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>

Ack with a nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/task_iter.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 5140117447e5..c10aeeffe1d6 100644
> --- a/kernel/bpf/task_iter.c
> +++ b/kernel/bpf/task_iter.c
> @@ -10,6 +10,12 @@
>   #include <linux/btf_ids.h>
>   #include "mmap_unlock_work.h"
>   
> +static const char * const iter_task_type_names[] = {
> +	"ALL",
> +	"TID",
> +	"PID",
> +};
> +
>   struct bpf_iter_seq_task_common {
>   	struct pid_namespace *ns;
>   	enum bpf_iter_task_type	type;
> @@ -683,6 +689,15 @@ static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, struct b
>   	return 0;
>   }
>   
> +static void bpf_iter_task_show_fdinfo(const struct bpf_iter_aux_info *aux, struct seq_file *seq)
> +{
> +	seq_printf(seq, "task_type:\t%s\n", iter_task_type_names[aux->task.type]);
> +	if (aux->task.type == BPF_TASK_ITER_TID)
> +		seq_printf(seq, "tid:\t%d\n", aux->task.pid);
> +	else if (aux->task.type == BPF_TASK_ITER_TGID)
> +		seq_printf(seq, "pid:\t%d\n", aux->task.pid);
> +}

Let us use '%u' instead of '%d' for aux->type.pid since its type is u32.

> +
>   static struct bpf_iter_reg task_reg_info = {
>   	.target			= "task",
>   	.attach_target		= bpf_iter_attach_task,
> @@ -694,6 +709,7 @@ static struct bpf_iter_reg task_reg_info = {
>   	},
>   	.seq_info		= &task_seq_info,
>   	.fill_link_info		= bpf_iter_fill_link_info,
> +	.show_fdinfo		= bpf_iter_task_show_fdinfo,
>   };
>   
[...]
