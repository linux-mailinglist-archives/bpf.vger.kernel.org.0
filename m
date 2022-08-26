Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCFF65A3030
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 21:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiHZTtw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 15:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbiHZTtu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 15:49:50 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B97FF1
        for <bpf@vger.kernel.org>; Fri, 26 Aug 2022 12:49:48 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIP6a8003788;
        Fri, 26 Aug 2022 12:49:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=L8IxtbkHebmzPlikITWIG7tMYSK8+Im1/b8rdWz92ZE=;
 b=fPcNbFJlyncuwuYzdG/6TbfUT0nSxG7U+928z5b9ldcXvTu5Tqo/rYPrTIDcDPHZSdvW
 GoOLp121JAttY4RfT4UiBWiyhcRFOs5sF9JH7X10r9gJ2Js6Hf/K1+eF8wiDsf0VBqYr
 xtzbR+F/BnGFisZrxelt1k+uInjnZVfV7rU= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j6yw0a92p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 Aug 2022 12:49:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUexWt/QRoHapBMoEzKYD/h6iLzT2Ia4csVOVUPkMXrhafZ5B1UItngUCYZm59B+gZrk2jkaW8aFXvfoD8nmIfWyrq3dLxsJotzrN48JRahAWkd1P/TyvAZZiNlpkrNjN7DuokvStNQCCPRtpAX5pyEgdfgpAXbHcUHtPqbjCCepLpbqmCHhPQ5T/WBMVXS+TpWSsQGddOqEs00pUV2Hub5K0XTOQ2j8mpzZDWsfKuGAVQ2Z1zoVTTUSZmnrrutTNKcQT4DNwt4NNWIeyeifAs2+kFjJBlJBMOzNxDcNC/qn/6+SxcrjVfE9oOx8TpnlKmV/CtruuV5glZFpe+BdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8IxtbkHebmzPlikITWIG7tMYSK8+Im1/b8rdWz92ZE=;
 b=WsiDq/AsY/KifEKTlS9a7Iq2vtihs5DYLg0HwSGBzddZLFjqmUFx5GirQQeBu00+UI5/U2MZ0oKHTItmCZmqrORb0/beu39n4aVxxWRGieQ0kHVBmqunbyOQrxPrAMBYpTdeBQoTgKrcw5UJi8bHnbZjdnchuJlUg4WGQx7NBZDh5zu/aswM3cgSSlACan8VKPq3+JhhgXJGsk2H5vK0p7SR14UNDyWY6w4UVMY7gaBHDHAE8y3eu/VWF2++EeKSg84kWFY4ZnkpNNWXCPhmKudxfQ6HMlyonY0Z1Ig8i39SvSvkfZP04OCr/Zbpov8oWaVXAOyGZqWjW4//m44chA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM5PR15MB1131.namprd15.prod.outlook.com (2603:10b6:3:b9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 19:49:32 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::d4af:bf29:567:6cb3%7]) with mapi id 15.20.5566.015; Fri, 26 Aug 2022
 19:49:32 +0000
Message-ID: <af4b71d1-b793-8774-171e-7d8104153b66@fb.com>
Date:   Fri, 26 Aug 2022 12:49:30 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH bpf-next v7 3/5] bpf: Handle show_fdinfo for the
 parameterized task BPF iterators
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
References: <20220826003712.2810158-1-kuifeng@fb.com>
 <20220826003712.2810158-4-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220826003712.2810158-4-kuifeng@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0038.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::15) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bb65095-8e04-4085-fccd-08da879c18b6
X-MS-TrafficTypeDiagnostic: DM5PR15MB1131:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 883WeUFyXYXGoGCVUfCZx2NOa0JCprTbjIq0Z4MdJyBfn3WmVL/gePgoxizLuHUUtKjyeGi3tLDVQCwc1k+rtRC0YltasHPVaLZmNCmE2ZGnz6DPd9gvduOix2jBqyaabHMRf1JL3uNziIWftgt+iTsHev2IkP9pNljevtz1kbpv4cb72toBjkAnMk99yxSEjP7HKu405xilCQMiQOFcV1Ty1/o7eXZWDrCq/OxruEZuqHbnpwweKSX9xk5PPpM4k3iU2PxqMUF4brkqZU4La/SZv7dHVOuJoJf3bxXsystpHrZcaeBzkJajLotO5hdTdUroPv8FhW8DtOISzAh1XJX/yuwBm+qP8Fsc17ex2yaJKLrLH6Gua89DzSjH73zq2jEATmfTeQpY85bSJsU8c0b3I1aTcWvI7BNp+sBmfXlbFObtksCuA1ovAuTDlVB1Z2kWm6dumT4lIzAesPNFEHoyx0GO43DVbgNw+pmsyGI2t200bclEnADQA/8a/Rzqggx0Aj2WLP5MasXqGkYvdKWIsUxLt45j5g6YwXSWwtetLFrpDhxDYufjBxrLJgQHY+oByMxClLEmicvhE20BeOYXMU+3MfxbIiw/CzYc7UxzN8GPND3UDaBDroFmnjSQpt4TeinmXakZeWTOB8AFqz7SDsSE4Az971FMBjtJL02dDgH3zaFdnlsAHOeXKJRdsRs6w6tYmgF2+JGdqPajTz2puffmx+9KSvc9V0/AN9pQD6O7XM0yIQ1lmdAbopZ00jOH8FQU36IDNAAOs8ChYwSdRsBLdWMxwBj67O0x0Oc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(6512007)(8936002)(2616005)(38100700002)(316002)(66556008)(66476007)(6506007)(53546011)(8676002)(41300700001)(186003)(5660300002)(478600001)(6636002)(31696002)(6486002)(83380400001)(31686004)(66946007)(36756003)(86362001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGpPUDk3NGpyY29iK1FxSzNuMDV2SHVtNVFPNFZWU0wzbldnaFNGVFFVd0F3?=
 =?utf-8?B?RjZRRFhQUEdHSWlPcU56cE9DWU5YU1ZtSmF1SzVCUU9BSXp2citZTWZ3WWdj?=
 =?utf-8?B?bEZZSGZ1aFBZTVhualdvdUlFMGp1NU5pVmc0d3VIU0pZdC9QRkN4NmxnZ0F0?=
 =?utf-8?B?c0t1dGYzaVVwVzZqS3prSTgzVmQyS3VkQTU5WEN2WXlBWUxpRTZ1ZlBROEdF?=
 =?utf-8?B?QTFIZm5rK0JJcW5nK0ZsaUtZVGVpTzJETHVtdlhoUWNmWG1rWHB2R0RDbEIr?=
 =?utf-8?B?Y2NFeHYvNXF1TGVCbmlBaG9xR2hjTEliUXU3NGMzYkVEWmtIUG11bGVFaHZC?=
 =?utf-8?B?VUt0SDhFbHp6SWdnTUZuNWFKU0ErdXNGSUJWa3VKcU1TcVZSWjZLNWI2ZUox?=
 =?utf-8?B?OXFDSUNha0NVL2tKc2JFMXB1S0E4czV2WExYM1FrZzZabG1rTUFVZW9jRElJ?=
 =?utf-8?B?UHNhaGdCTE5GejBtclhCbS93TDQzS1RYUjB0WkVnenJnTU5FS0JTNFozTjZI?=
 =?utf-8?B?QnNHUnZzZDVRNFRmeWNLV1lub1V1UUJRbGJDTkdXcjd0S2V4MFM1Sm9yR3Nx?=
 =?utf-8?B?YzRsM0w0WHVlaTdBWndDQnk4MGRXcXVNcWRIOEEzcGNmbTVTbW52Qk8rNzl4?=
 =?utf-8?B?K3BJWUVhVFJMUmxXc2FXTnpKNUVIM2h0NXVpWkQyc3lnZTVPc0hHUWYwMEhU?=
 =?utf-8?B?REE1ano3OVo5YzVwVXBsdldIV3BVUytlVHBEWEFPdTdNaHQrN3J5K0Qvb2tt?=
 =?utf-8?B?QkR4bmdZamNCSnVaNm5zek9yV1B6SE5Bemd5NXBOQW45bXQzK1dwbVQrTUlI?=
 =?utf-8?B?ckozaFRybHhRVEYwb3YxenNlejZrbTJ2QUdiU3dOc1FQZTBYM1VEVkdxd0Mw?=
 =?utf-8?B?Tml6eThCSjJYcFpzV3g3RjB0T1UwRmhJVmkwL2xsYUJmbHF6bEN1Y1NCd09M?=
 =?utf-8?B?bTdqUlFZeDllNjlqaGc4NWtHdW00N0Zick9ON0dJc0NWVGRtMXo3aDZ5am5t?=
 =?utf-8?B?YzRCcDZhU3RFVWU5NEZWVFN4QWNVUkhGRG5PSExxM20rVDJ6bGxLQlAybWtn?=
 =?utf-8?B?WXdQUDcydzUvcjNpdDkxOUlENi9RbDVIeGNIa3lmLzFxZFQ2OEFRZlBkN0pJ?=
 =?utf-8?B?elZUYzltVm8xaTZ1U01WVDFKaDEwU21jTTdTdXpHcVViVktlVFdRejlIOEg5?=
 =?utf-8?B?UE9tcnhNdmxuc3B1cFVXcndveFBjWXB5RDVxdFZnelNzelJpejlPTnVlcExy?=
 =?utf-8?B?VWJ1SEI2aVg5SDBPZnJXY2l1YnpRQ09vc1p6SkV2UCsxNFc4R1kyNmtjd0ZI?=
 =?utf-8?B?aGc3Ni9jSGtiRmNBOXBLZk9MaDFxYnBEUk9VdlZEeFFuVmRkdk5DY3lxT3JG?=
 =?utf-8?B?RC9hVTB5WGdvRi9BZ0s5cXBHMk94UjNubTNtaGtuUW5nZ3VpYUFVWkZpNmxk?=
 =?utf-8?B?L0VFRkx6RDRsQ0c5M3dqUzBYTXdCRDBIL1pGOHZZNzZjMkltaUw1Tk8yaVF3?=
 =?utf-8?B?amZWV2JQNW8wa0gyRjMxbGVFZHppRTJiTmc5KzVDcjd1ZWxXQ2JxcSttU0l0?=
 =?utf-8?B?YVlVb1VzVFhWSEFHdHJFNXhVY01qaFp0a0lwT0lsSXpCWVlXak4vNENtV3Zi?=
 =?utf-8?B?UEZ0Y1pZOFZIckczOVVlUE5Xc0FvMTMzWnAyaDhaWFNSc2dhdCtURVJJZjBU?=
 =?utf-8?B?NE5JVE1VanRvY3l4cEhLVVJweGd2UzB0Ym1WMS91WitQSDgzSHV3SGJmMkNO?=
 =?utf-8?B?RWxycDcxTEM3Sk12TDJlMk1OQWtMb3U5TlNwZHJOMGhmckZoZTlKdVYyalNB?=
 =?utf-8?B?Y3Y5bVNNWi9xZXVxMHh6cXRVQ1p0VzR4cWdOZmRxYWltR0Z0V1hxKzVUNzF1?=
 =?utf-8?B?RStqNk5yVkZIckF0MUpWdGVSU01tcUFSbFpyMTlWTjlhOU9sVy84dHMzcHZM?=
 =?utf-8?B?OHNRdllVSEVTOWRpQ2xTZmdmaWlEUGlxckRLZVhjOG1mQmRFTnB4eHRHQ1B1?=
 =?utf-8?B?NXdBKzZCb0x6ejhOTlpwWlVZZE41NGhGQXNDRlhZaGJnbjlSRHZxYTRkSGpQ?=
 =?utf-8?B?RGlmbmw0cFBXMzJTbUw2WXNaaVNqaGZqWXRJa0Rnb0RSVDFtRGo1Z2NXdng2?=
 =?utf-8?B?U0FPV0R1cVlOd2F5aVRxR2pXUmYyQjduaDdDakVrcllSWXBSbi9MNVE1M1Fu?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb65095-8e04-4085-fccd-08da879c18b6
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 19:49:32.7202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AIPsleVh/Krrdgns1X64+kqKdYiSM0YxVY2Olt/OijVyRrjl/LAsQjqKdm4Lwhfi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1131
X-Proofpoint-GUID: zU_za1X6abcb-1CW3ByLW7M9ozN2YZZj
X-Proofpoint-ORIG-GUID: zU_za1X6abcb-1CW3ByLW7M9ozN2YZZj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
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



On 8/25/22 5:37 PM, Kui-Feng Lee wrote:
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

LGTM with a nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/task_iter.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
> index 72c8747dff89..d3e8e1549135 100644
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
> @@ -623,6 +629,15 @@ static int bpf_iter_fill_link_info(const struct bpf_iter_aux_info *aux, struct b
>   	return 0;
>   }
>   
> +static void bpf_iter_task_show_fdinfo(const struct bpf_iter_aux_info *aux, struct seq_file *seq)
> +{
> +	seq_printf(seq, "task_type:\t%s\n", iter_task_type_names[aux->task.type]);
> +	if (aux->task.type == BPF_TASK_ITER_TID)
> +		seq_printf(seq, "tid: %d\n", aux->task.pid);

"tid:\t%d\n"

> +	else if (aux->task.type == BPF_TASK_ITER_TGID)
> +		seq_printf(seq, "pid: %d\n", aux->task.pid);

"pid:\t%d\n"

> +}
> +
[...]
