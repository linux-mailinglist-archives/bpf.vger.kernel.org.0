Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239492C6085
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 08:36:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389420AbgK0HgF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 02:36:05 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:22174 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387909AbgK0HgE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Nov 2020 02:36:04 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AR7YmFf010797;
        Thu, 26 Nov 2020 23:35:47 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=mQvQ0rvbzqNsMzUa1i9/6+L8ietghDzy1lzpxz0vY0E=;
 b=ARp3RaUVeWRPWipCWptrIQH8Z+qSlgDzqqSLNAqZHyMivZQtDsPbQ8CHpzLpE7HnJlH+
 NvAPDSn/lfnxTbllcu43864pR4Nh0TVnVLljFov252FzEhr2Rkf9a7P4q4evs6IfK9/D
 GF9e+XQlf8udDeiTwyJbQ9kaOZioWN3OR8U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 352q7391ar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 26 Nov 2020 23:35:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 26 Nov 2020 23:35:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S+IHc4DQWia1ezWZcphsOuiIm6CPg+u8hT7NDITKVQshX3lcxbutZeHroGya2lXyu9LA5RSErU6OJa69A0Cffm2fQGXa5H+/OfUI2om/pg9n9hnGRy+NyNlsMwicTkJg+4QM/vAjTyhoOn3xn/94ScppIVdb7glBdT3m9Y7blbP9l6SMmVn9Uc9Rx4HhBI7wo8bFUomPvc0A/2w2fK93PASbGCVnt10v3LMBPrtE5l4MFv5ZutoMTBTkIoe2pGF80xwBi+j/7AkrcA2sMgk95yMscYoIG2V0WbFUXvCb982ULQ0MvTMlH0ubLhXN2pVq41piyu1IqPQkl9U8Oee0/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQvQ0rvbzqNsMzUa1i9/6+L8ietghDzy1lzpxz0vY0E=;
 b=L39v98b6uDrt7KMyxu0pvx0aftqxY98wVIeYzeW2s4cbZLUWm3mbysjDU1WvRHka9nqyRgNkrpoQ8PVZlrWueiUObmi4lbLD7X03nQqid5MIl+bG4YBxfjixfI8LoGwwZ3PLZhfeUtYk5Ki1jf0SAOqMmHdywDuF8K3DiayyjFwFbm7m5ukDEFSDEfKO6XxxsouqOTnoanzQ796w0LiQm71DRwcR6gdXrWErMxIeuwwISTEeu+EkpMKjVR6vmALRCBtRALjRE4odNg7EcdxRjJdrxOHwJ39+FgvAKOt78+CfNnY87FekcViqcoWFNmpneGSOls0nwM0fBSKLv4o6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQvQ0rvbzqNsMzUa1i9/6+L8ietghDzy1lzpxz0vY0E=;
 b=IJqMnfaqxKvrx8C/KQ5SaIrKcFjJ3vjfiMH9GWRVb3zNvfJfVZDPTHeORI8uWPyLHSsM8nY2M73zI3Vmi5Zbnj0b6AlseUlH1YJBsW4Y+ibu4b7XJ3AH+Q1QeFYoGavnae4p8kKxiudnv2pngQa6f3uzmCWzp11+qYFVcioBLhI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2263.namprd15.prod.outlook.com (2603:10b6:a02:87::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Fri, 27 Nov
 2020 07:35:45 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 07:35:45 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     Florent Revest <revest@chromium.org>, <bpf@vger.kernel.org>
CC:     <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
        <kpsingh@chromium.org>, <revest@google.com>,
        <linux-kernel@vger.kernel.org>
References: <20201126165748.1748417-1-revest@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
Date:   Thu, 26 Nov 2020 23:35:42 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <20201126165748.1748417-1-revest@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:7e72]
X-ClientProxiedBy: MWHPR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:300:ae::28) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::1008] (2620:10d:c090:400::5:7e72) by MWHPR14CA0018.namprd14.prod.outlook.com (2603:10b6:300:ae::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 07:35:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9ee1aa1-f87c-43f1-2d44-08d892a70d1c
X-MS-TrafficTypeDiagnostic: BYAPR15MB2263:
X-Microsoft-Antispam-PRVS: <BYAPR15MB226356C52B58563EF531D149D3F80@BYAPR15MB2263.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vMJ+fwFlsb4yPejkcJ7UmWILzPoMp//iwTtJdaKaVbPRh6ajMagSx7KkXz0Q5I1bEWRiHZp/xCXBqaH/0q7mpbymm2eDezA6TZNgDRGjwFYnuYI8E2zsJxSNPhEv9MneYERrbXM6E8HRTrbzeGadlnZS70cMTOKS54Pi9BjCZz2M7KpyxYzukS2mWQo4vCONxgvXY/YP3rLAWSJQ+dsc71yvZUteiQWUgULgCzEogzOP8JMRvzuDR81CC8BMBCbGBJehE6SR5+EBrcOCn5eWj4+1dwiWg8vwW7IFuDj4QOpBmlo34cDWtbE4bJcRDfuThV6/XBVvu5ibkkyz1X/K8GiX93jd+sbGenuOLLvnZqdCqFhvcJN0G21SEvpE+tdi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(346002)(39860400002)(136003)(396003)(316002)(16526019)(186003)(8936002)(8676002)(478600001)(31696002)(86362001)(36756003)(83380400001)(4326008)(66946007)(52116002)(53546011)(2906002)(5660300002)(31686004)(6486002)(66476007)(66556008)(2616005)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S3JqUDU0dWwxRDRWQlZTTUptNlN1ZkZ0RmN4WU9mL0diRVNnUklxejZKWjlU?=
 =?utf-8?B?WTRPOFZMRi9pOGYxeisxSlN1UWRqSG0va3RlMU9HbTlVdXd0UFJjVlZDemJR?=
 =?utf-8?B?RDk4cW1Fa1hRT0pwaFltSVJvYm9BL0VaWEZlTnQ5TnpUV3lnWmpCUVNZcTNl?=
 =?utf-8?B?cnV5SlNwVG84bDgzNVRFNHZIWURKWlNyRU5QeVJsZ2Rjb1lNVHVXdjZsb0Uz?=
 =?utf-8?B?bTRFNkk0Vi9RaUFnNmFkb2pIb0g0WlBvWUlDRSs2Yk5vbitJSHVHcHZmOTdh?=
 =?utf-8?B?ZkUweHNmMHhFSUMzUnFUN2luejgwdndRM0JUSmNwSTI3d21uRnIzVU1hWFNj?=
 =?utf-8?B?K2pDUWdmUXFobW1ReEZ4bTlZU3pFNzZZbXJUOEsxZEFBaFk1K3FTbmpqc1Fn?=
 =?utf-8?B?SFdzRkgxSTNUNU9KVGR1STducGJiT29BVmwreFVXb0lUVjAwM0UwekdiejRP?=
 =?utf-8?B?NERnSDNvRzhDdkZYOUJORU1XUDllQ3lvNGUrcGpSUnI0a3RTaEZGZFJJbmNk?=
 =?utf-8?B?NngvMWNsTG4zZzBoSHhDc2VycnRIMm9oUWYya0ZMaTUvazhJTjBMWlNqWk5C?=
 =?utf-8?B?c0U1MThubVVzYXBNb3IyNnNQbGdIb1B3UDRyc3lVTzRYRkVCVnA0S2M3bXRH?=
 =?utf-8?B?N21uMzJuQW5OZmpMNTV5SnkxQkRxdzZ0L3pFU2dZZWg5Q3JiaTZpSkF0UGh6?=
 =?utf-8?B?MTB2SXJwNDZYWHkyNU1SSXFNZUFRSXVaM0RLZk55eXR0aUM5ZjRob2FtV212?=
 =?utf-8?B?K1NVaDlEMXhRTkgvcnF2aVB5eUpmeXhBVExoUFI3UFBGTi80Y1JodW01TlJQ?=
 =?utf-8?B?UGxMSjlLd0xRT3N5bUxaOWF4WEgwR2sxOTJzQUNrdlI1aEVIVEdUQXBLUWZO?=
 =?utf-8?B?NWV6RmZZWnNrSERzRi9JTE9ISE5KS0dqNTJOaDZ0TzNIYUd1TXhZVmx6ZEtp?=
 =?utf-8?B?R1gwR0JOSjB5b09BS2RacmtKalBtNXVLT3FBaGVtbUxIZmczeVI0THFxYWts?=
 =?utf-8?B?OHM4am1xWGxPZ0twUHNCbEhuWFpKZEIwZU8xa0ZJNitSK3NwaXg1eEhuODRB?=
 =?utf-8?B?MXlpQjl0Zk05TWZiVEFYVzljUVZQd2RHZWoyM1Jpd1dWb2NlNnFjQ1FaLzk4?=
 =?utf-8?B?Y3ZuT2V3WFVaeWZKSUZvczBJS3pvQ0xzd1VBRUp3aDlaNlFwa0c0a3Q4Y2d3?=
 =?utf-8?B?OHBDWStvVVZHVHF1dElWdk5DNkliUUtJK0ZoR2J1YzhxaEdxREs2WTVtem8v?=
 =?utf-8?B?NEZsWW9KUjlYZTkwL3JrbXJ5R1JLU0NnL1YxelczYXhJVGNWRUxtbzR0cjRX?=
 =?utf-8?B?MzBoZGkrSHRkSU0vZmNCeElmdm85OWE0SllIR0t0bnIxaDNiN1QvcEJ1M09N?=
 =?utf-8?B?b0xrVkhlWHhYR0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ee1aa1-f87c-43f1-2d44-08d892a70d1c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 07:35:45.0998
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J9m8ad/CCA5sC3d7pmeWGbzYTZdWKugx7ei8oMqtI5H8+yvi+h2sFp3IMzBNHoUx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2263
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_04:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270045
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/26/20 8:57 AM, Florent Revest wrote:
> This helper exposes the kallsyms_lookup function to eBPF tracing
> programs. This can be used to retrieve the name of the symbol at an
> address. For example, when hooking into nf_register_net_hook, one can
> audit the name of the registered netfilter hook and potentially also
> the name of the module in which the symbol is located.
> 
> Signed-off-by: Florent Revest <revest@google.com>
> ---
>   include/uapi/linux/bpf.h       | 16 +++++++++++++
>   kernel/trace/bpf_trace.c       | 41 ++++++++++++++++++++++++++++++++++
>   tools/include/uapi/linux/bpf.h | 16 +++++++++++++
>   3 files changed, 73 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c3458ec1f30a..670998635eac 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3817,6 +3817,21 @@ union bpf_attr {
>    *		The **hash_algo** is returned on success,
>    *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
>    *		invalid arguments are passed.
> + *
> + * long bpf_kallsyms_lookup(u64 address, char *symbol, u32 symbol_size, char *module, u32 module_size)
> + *	Description
> + *		Uses kallsyms to write the name of the symbol at *address*
> + *		into *symbol* of size *symbol_sz*. This is guaranteed to be
> + *		zero terminated.
> + *		If the symbol is in a module, up to *module_size* bytes of
> + *		the module name is written in *module*. This is also
> + *		guaranteed to be zero-terminated. Note: a module name
> + *		is always shorter than 64 bytes.
> + *	Return
> + *		On success, the strictly positive length of the full symbol
> + *		name, If this is greater than *symbol_size*, the written
> + *		symbol is truncated.
> + *		On error, a negative value.
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -3981,6 +3996,7 @@ union bpf_attr {
>   	FN(bprm_opts_set),		\
>   	FN(ktime_get_coarse_ns),	\
>   	FN(ima_inode_hash),		\
> +	FN(kallsyms_lookup),	\
>   	/* */
>   
>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d255bc9b2bfa..9d86e20c2b13 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -17,6 +17,7 @@
>   #include <linux/error-injection.h>
>   #include <linux/btf_ids.h>
>   #include <linux/bpf_lsm.h>
> +#include <linux/kallsyms.h>
>   
>   #include <net/bpf_sk_storage.h>
>   
> @@ -1260,6 +1261,44 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
>   	.arg5_type	= ARG_ANYTHING,
>   };
>   
> +BPF_CALL_5(bpf_kallsyms_lookup, u64, address, char *, symbol, u32, symbol_size,
> +	   char *, module, u32, module_size)
> +{
> +	char buffer[KSYM_SYMBOL_LEN];
> +	unsigned long offset, size;
> +	const char *name;
> +	char *modname;
> +	long ret;
> +
> +	name = kallsyms_lookup(address, &size, &offset, &modname, buffer);
> +	if (!name)
> +		return -EINVAL;
> +
> +	ret = strlen(name) + 1;
> +	if (symbol_size) {
> +		strncpy(symbol, name, symbol_size);
> +		symbol[symbol_size - 1] = '\0';
> +	}
> +
> +	if (modname && module_size) {
> +		strncpy(module, modname, module_size);
> +		module[module_size - 1] = '\0';

In this case, module name may be truncated and user did not get any
indication from return value. In the helper description, it is mentioned
that module name currently is most 64 bytes. But from UAPI perspective,
it may be still good to return something to let user know the name
is truncated.

I do not know what is the best way to do this. One suggestion is
to break it into two helpers, one for symbol name and another
for module name. What is the use cases people want to get both
symbol name and module name and is it common?

> +	}
> +
> +	return ret;
> +}
> +
> +const struct bpf_func_proto bpf_kallsyms_lookup_proto = {
> +	.func		= bpf_kallsyms_lookup,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_ANYTHING,
> +	.arg2_type	= ARG_PTR_TO_MEM,
ARG_PTR_TO_UNINIT_MEM?

> +	.arg3_type	= ARG_CONST_SIZE,
ARG_CONST_SIZE_OR_ZERO? This is especially true for current format
which tries to return both symbol name and module name and
user may just want to do one of them.

> +	.arg4_type	= ARG_PTR_TO_MEM,
ARG_PTR_TO_UNINIT_MEM?

> +	.arg5_type	= ARG_CONST_SIZE,
ARG_CONST_SIZE_OR_ZERO?

> +};
> +
>   const struct bpf_func_proto *
>   bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   {
> @@ -1356,6 +1395,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_per_cpu_ptr_proto;
>   	case BPF_FUNC_bpf_this_cpu_ptr:
>   		return &bpf_this_cpu_ptr_proto;
> +	case BPF_FUNC_kallsyms_lookup:
> +		return &bpf_kallsyms_lookup_proto;
>   	default:
>   		return NULL;
>   	}
[...]
