Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377DD2BB1B3
	for <lists+bpf@lfdr.de>; Fri, 20 Nov 2020 18:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728765AbgKTRsD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 12:48:03 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:32942 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728292AbgKTRsC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 20 Nov 2020 12:48:02 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AKHk8xk011661;
        Fri, 20 Nov 2020 09:47:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=nFXJs59iKppT/kHGULH4YEXuAgAArAjUu4YR3HqjoLk=;
 b=ANhDEr02IKtBHAGF6He1K4tKVeHzvI2Pwz5up0MqV4YzFAnMLI7bk8io3KFp9IkWnYNz
 xm1X8OWy5NIsiQZHCUUsKKEpDWDvePyPiMisuI+oQPDgtizmn/YTU04Y7lh7SjoNr0WH
 jTtHtArrpq4xy5KfZDLeWDW/q18WKEPxlyM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 34xat42gxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 20 Nov 2020 09:47:45 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 20 Nov 2020 09:47:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LifHS/gwO6liW1m2kZ9aJ9T8+3MQr/68wjKGvJImtQxk6QT4igqovQWhtIcNED23e+IhKcolheEM7unJKQkpLwImqkuNmdDrXcNmZM2wz2t6KBv1ybe9RTuWmE3iUPYzRi1ihUWBZ7ngg5ORjqR4BHtuGfRuzw/nO3iMsUssr2yTl2zrx4fqDS8K4uNKUVKCCbXtVmVtE5p/H9S69EhIXRvZJyKiz1JeMzYMN5FuRiLX0606TN5MVqo+IBBjtA3GY/Q8WHcPDLAMpN63437x55ilnYt/2BnYJ+sZKgQmQJP7fs1CFt+4qB3tUANfleguX7Smslxse1X9cLSKB6KP3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFXJs59iKppT/kHGULH4YEXuAgAArAjUu4YR3HqjoLk=;
 b=R3OzgqDOvrq/s844hjx1+EusXMIFwzVPqpaJRWMb5jkce/vwChRBHx+tfLMbuHPR48lX+alhovgycdYOu1zNHEXr0+LvQF/oL/xcrpPa3GkAlZ8Ka2xGAVwRvR6b8/OT3+3RZad3v3QQcZlN4+dhGbQ51D8iice/pRDhZwU9U3Q4GvdtK1+Acos3xBgEVrmFHmT72xfvfG6RRCBEHDidJuugoNpt/Wy23POZp+fwudo+DFx6EVWM1/CLPONsGUd7XNiKT8Rw4uFMYyVsBcRWpP4JwOkXPqlsODzvR7F9+FSV56DlqOXCdSYStk08AGXhCf/l2Ia1AZVyx7ubMPE06g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFXJs59iKppT/kHGULH4YEXuAgAArAjUu4YR3HqjoLk=;
 b=K0RHrhAUAm3N9OPXYwIYIPt+DJbNYiKRiKyzpm2ZNQ8X1hyizw8F6WHabL090JMrwj/+z2iGDbOR1PyjYuwNlig3FDKds/Pn4kLxvPDHoMHIqRKPILFtQdoLKZK/EpAiHvdqtGN9j9SY+b/rUeTyHaEgbPwsVVYB2rbhVAvUATU=
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3208.namprd15.prod.outlook.com (2603:10b6:a03:10c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Fri, 20 Nov
 2020 17:47:29 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%6]) with mapi id 15.20.3564.028; Fri, 20 Nov 2020
 17:47:29 +0000
Subject: Re: [PATCH bpf-next 2/3] bpf: Add a BPF helper for getting the IMA
 hash of an inode
To:     KP Singh <kpsingh@chromium.org>, James Morris <jmorris@namei.org>,
        <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Mimi Zohar <zohar@linux.ibm.com>
References: <20201120131708.3237864-1-kpsingh@chromium.org>
 <20201120131708.3237864-2-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <a9336dd5-df17-85d9-7c63-d8ab4b74b459@fb.com>
Date:   Fri, 20 Nov 2020 09:47:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201120131708.3237864-2-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:f0a]
X-ClientProxiedBy: CO1PR15CA0049.namprd15.prod.outlook.com
 (2603:10b6:101:1f::17) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1688] (2620:10d:c090:400::5:f0a) by CO1PR15CA0049.namprd15.prod.outlook.com (2603:10b6:101:1f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 17:47:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: caabdbb8-db9d-4ce5-0097-08d88d7c59b8
X-MS-TrafficTypeDiagnostic: BYAPR15MB3208:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3208BBF583341EDEA38B4837D3FF0@BYAPR15MB3208.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ptaw6LsvrMJYeedQCE/gA6rRMLs+ChFC8iThHS3buEjug44DMwaRbO3ltclWzPKY3V3CDOBV61RTrwAE4j6VI6S2fSNyq3tMGgLO/qccBqLlV9KgIQ6VL6RVG9UpmWWzMyEI4tOyy1oRIwewKcEGssYccNShtBfn6IFhE58vz0iGgcCHr3y+lNs4xpPW11ZGUn943NnbXWfSXxuM9YjUCjsYDxnlhWaC8BccDUI1+lQlr0LQq+U28c5Ilmqn0DSA/mcqCxaqje5doPkAOrjgp4gnbp7j8NrYAvALIDFSSExYtWaRJw4vCLheSA7YGmP722MyboppY1qV4fivPfbQc5W1Y9aXd34zNwMiNyq9PbZbBamazVqw2OwuB5X52qqo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(346002)(366004)(39860400002)(36756003)(66476007)(110136005)(316002)(186003)(16526019)(8936002)(5660300002)(83380400001)(8676002)(86362001)(53546011)(478600001)(6486002)(66946007)(4326008)(52116002)(66556008)(31696002)(2616005)(31686004)(2906002)(7416002)(54906003)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: lM77Rmaamdeq/zcaV1b/5Qla9CcDF1p4ui4hiZOHtdxe8GSSnY0BGdluaA0X0rdqIyuZNbFp2xfZe4x8McbICvRjeWFC7tBcWTZH9cnX9/RnGk7CdG9XBsA7ME8/f76279puDlrjb6uEKWx2MfchT8qY3323UgL2JO/FqQ48ThTgR6SRwjjwyvvlZetT1FZqZqBR4/oLySYKgL/hdit1U5zEQBZGbILM3bDScniuyr7lp+gHyTj3D39bac5tTmqXHbC7E+xA2gN0s46rp4FTpHaiWWVnSiOXZHLxQzHeVE94BuL/ERfqT52jcaL3PcGE0lmSSRKI907wt9xi7ATSE9WzW/r83mIYV7uUMrIr/eSziSYpgpaYLuZFKO23SoaRfo10zwZeGU7TCnVOB5NP+S2kPJ11LLNyb4HxUNjIUpDZCNuA0bh9QQ+DRCI552S9XMjeuTQKFP9NbIbIox0S2vhZ46lGROiINAHuCYBLtRgGmkBoiITtwviEUToIScwwUb5GPaCAJcJDtJVjj8FTCellK2pVdPTiIKzMLWG6vzoI0BdFFF10pt8HkIZ76ceJ2sFEvIn/+BM7Mf1QV39wO2aPSMkcTY3lNA7lb45Wa7UI+KWHt1iRWu37sqH9czWpFV+uKsFVZ8oIBbqmWsdbK1TZs0jgBuST2SZDaegdkb2nOT0nRhUIlvefO/BrW3sQrZimFxn4tGWyp9Yo5DiWO60U++ohxj0xGcw6tcdVVv1lY+E/aHn6Xr88cdWoXS2+kwRvyxtHTm/YmhOhkkm+gxrHJsek7KU8gkMn1z8lBqh+9/ajc2C9j75EqXULlZzjzMl40rcJJ55up8RbK2/IOXDQi1yUwYkKWgBQIzwNOwzv6FlFkX6gOPaVPyJ1rP22eYcITQ3bU/Ihke8og5v6iaUq12zbC98NMO28bEsrGFI=
X-MS-Exchange-CrossTenant-Network-Message-Id: caabdbb8-db9d-4ce5-0097-08d88d7c59b8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 17:47:29.4976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p7BmP82ReeOe01XCEvSQNyt9iockiO8YOIG3lWmV0ke2jnCOKpOvVWnQc/MI+zZg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3208
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-20_09:2020-11-20,2020-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011200122
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/20/20 5:17 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Provide a wrapper function to get the IMA hash of an inode. This helper
> is useful in fingerprinting files (e.g executables on execution) and
> using these fingerprints in detections like an executable unlinking
> itself.
> 
> Since the ima_inode_hash can sleep, it's only allowed for sleepable
> LSM hooks.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>   include/uapi/linux/bpf.h       | 11 +++++++++++
>   kernel/bpf/bpf_lsm.c           | 26 ++++++++++++++++++++++++++
>   scripts/bpf_helpers_doc.py     |  1 +
>   tools/include/uapi/linux/bpf.h | 11 +++++++++++
>   4 files changed, 49 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 3ca6146f001a..dd5b8622bb89 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3807,6 +3807,16 @@ union bpf_attr {
>    * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
>    * 	Return
>    * 		Current *ktime*.
> + *
> + * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
> + *	Description
> + *		Returns the stored IMA hash of the *inode* (if it's avaialable).
> + *		If the hash is larger than *size*, then only *size*
> + *		bytes will be copied to *dst*
> + *	Return > + *		The **hash_algo** of is returned on success,

of => if?

> + *		**-EOPNOTSUP** if IMA is disabled and **-EINVAL** if

and => or

> + *		invalid arguments are passed.
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -3970,6 +3980,7 @@ union bpf_attr {
>   	FN(get_current_task_btf),	\
>   	FN(bprm_opts_set),		\
>   	FN(ktime_get_coarse_ns),	\
> +	FN(ima_inode_hash),		\
>   	/* */
>   
>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index b4f27a874092..51c36f61339e 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -15,6 +15,7 @@
>   #include <net/bpf_sk_storage.h>
>   #include <linux/bpf_local_storage.h>
>   #include <linux/btf_ids.h>
> +#include <linux/ima.h>
>   
>   /* For every LSM hook that allows attachment of BPF programs, declare a nop
>    * function where a BPF program can be attached.
> @@ -75,6 +76,29 @@ const static struct bpf_func_proto bpf_bprm_opts_set_proto = {
>   	.arg2_type	= ARG_ANYTHING,
>   };
>   
> +BPF_CALL_3(bpf_ima_inode_hash, struct inode *, inode, void *, dst, u32, size)
> +{
> +	return ima_inode_hash(inode, dst, size);
> +}
> +
> +static bool bpf_ima_inode_hash_allowed(const struct bpf_prog *prog)
> +{
> +	return bpf_lsm_is_sleepable_hook(prog->aux->attach_btf_id);
> +}
> +
> +BTF_ID_LIST_SINGLE(bpf_ima_inode_hash_btf_ids, struct, inode)
> +
> +const static struct bpf_func_proto bpf_ima_inode_hash_proto = {
> +	.func		= bpf_ima_inode_hash,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type	= ARG_PTR_TO_BTF_ID,
> +	.arg1_btf_id	= &bpf_ima_inode_hash_btf_ids[0],
> +	.arg2_type	= ARG_PTR_TO_UNINIT_MEM,
> +	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,

I know ARG_CONST_SIZE_OR_ZERO provides some flexibility and may
make verifier easier to verify programs. But beyond that did
you see any real use case user will pass a zero size buf to
get hash value?

> +	.allowed	= bpf_ima_inode_hash_allowed,
> +};
> +
>   static const struct bpf_func_proto *
>   bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   {
> @@ -97,6 +121,8 @@ bpf_lsm_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>   		return &bpf_task_storage_delete_proto;
>   	case BPF_FUNC_bprm_opts_set:
>   		return &bpf_bprm_opts_set_proto;
> +	case BPF_FUNC_ima_inode_hash:
> +		return &bpf_ima_inode_hash_proto;
>   	default:
>   		return tracing_prog_func_proto(func_id, prog);
>   	}
> diff --git a/scripts/bpf_helpers_doc.py b/scripts/bpf_helpers_doc.py
> index add7fcb32dcd..cb16687acb66 100755
> --- a/scripts/bpf_helpers_doc.py
> +++ b/scripts/bpf_helpers_doc.py
> @@ -430,6 +430,7 @@ class PrinterHelpers(Printer):
>               'struct tcp_request_sock',
>               'struct udp6_sock',
>               'struct task_struct',
> +            'struct inode',
>   
>               'struct __sk_buff',
>               'struct sk_msg_md',
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 3ca6146f001a..dd5b8622bb89 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -3807,6 +3807,16 @@ union bpf_attr {
>    * 		See: **clock_gettime**\ (**CLOCK_MONOTONIC_COARSE**)
>    * 	Return
>    * 		Current *ktime*.
> + *
> + * long bpf_ima_inode_hash(struct inode *inode, void *dst, u32 size)
> + *	Description
> + *		Returns the stored IMA hash of the *inode* (if it's avaialable).
> + *		If the hash is larger than *size*, then only *size*
> + *		bytes will be copied to *dst*
> + *	Return
> + *		The **hash_algo** of is returned on success,

of => if?

> + *		**-EOPNOTSUP** if IMA is disabled and **-EINVAL** if

and => or.

> + *		invalid arguments are passed.
>    */
>   #define __BPF_FUNC_MAPPER(FN)		\
>   	FN(unspec),			\
> @@ -3970,6 +3980,7 @@ union bpf_attr {
>   	FN(get_current_task_btf),	\
>   	FN(bprm_opts_set),		\
>   	FN(ktime_get_coarse_ns),	\
> +	FN(ima_inode_hash),		\
>   	/* */
>   
>   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> 
