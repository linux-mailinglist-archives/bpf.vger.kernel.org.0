Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF012B5593
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 01:13:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbgKQAL4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Nov 2020 19:11:56 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:44542 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730651AbgKQAL4 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 16 Nov 2020 19:11:56 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0AH09MGb027805;
        Mon, 16 Nov 2020 16:11:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=/gT5HwKnBjqIYwJiFfbIHZ60mx1wxKinsE7en1H6jNM=;
 b=aSDmec8nTGdTHsksnSLIunteBffS0tPrQPAvwAUutoqF5qP0N5wN7FggrNZoX/CWDQes
 sCCFdeFPLqlhr4TwShb/bpGD4NbmnsFNCyJS1Fk/Z+2RMpM92pZ+4FGYRu6JUFzLeDgq
 rRiwSRBOQjiU+r0rUDwmVwSZfgrpwPjWAdU= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 34tbm4u29e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 16 Nov 2020 16:11:36 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 16 Nov 2020 16:11:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlDCO3pIcY/uq3dp9p4MeAkQujmvMYN3ury8lj3TU2eqPeQX/QNiFVa50woHClVYz+RfUZpMsi7NDKXIOCDLYcdxzrRkhC1A1CFjSQlMo+AwnSIZZRHrdK3aZw53sW/y3W8+w4YTqiMXjtOx3uxCFwFExToRqOdV/koUDm0LiCxS1/qQkfnLvTNHiJ/3oJMZaTuNDUUFKDzZDslb3iDX50SLARpF39rP/ghxQn3m4B94i3w1Y2pMnxhkdNAfTKAbh4m2JA/fXQlR8gtX3KGCewteo8dv9HxMMFbwX/JMMiPYhi3Tu3pc/okAgPWhfHyFUIpn36ESuOi0KqChVPuVnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gT5HwKnBjqIYwJiFfbIHZ60mx1wxKinsE7en1H6jNM=;
 b=jci22qwU2Nu2dv8CXPGFkNoYTE7E2gooOV/5UM4PBikAOn9Hz4RK6xj2uKqkRrCGP4aWatzdNXM+CZjfiN+3o2wmZmf7vvNb9hPXPIAeJEfxvtK1SljZnT6yLN8RD9udEaG9MR9twlmnEAnoCk6WuFbgc+hiJhuGrEM0VtKFAIA8eXMLvriKNDFiMxq41bqw8al1FUXZlDVa4S0XnvW7JEbyDWjDhibx2Yuvwyffl+NeQlPgNG9VaM66VgzzGfhf3R1ayrU6FF+hoSdbxeYy23WKrIIiZJDTSofgU2AQJZlZiWfqTaiXkxNVUi9nB3nEmtv7ikrE42GkTyPsM7Kt6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gT5HwKnBjqIYwJiFfbIHZ60mx1wxKinsE7en1H6jNM=;
 b=B8TmkmznRuDIQC1pi7h6oJ7pNOKDQ4iPbd77tHguXLw8h8Z3SklRgErqwg0miarreHtivS0aaUQ9kiAERkC7pFtiL4CMxzhG77aAzm5szwJxL0jX5XECGdm/pudJjoHUfUaCEvzBxL6ayKdC6EibkNwDVBN+J6uSSLKZd+uRdq0=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3255.namprd15.prod.outlook.com (2603:10b6:a03:107::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25; Tue, 17 Nov
 2020 00:11:35 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3564.028; Tue, 17 Nov 2020
 00:11:34 +0000
Date:   Mon, 16 Nov 2020 16:11:28 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Pauline Middelink <middelin@google.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Add bpf_lsm_set_bprm_opts helper
Message-ID: <20201117001128.7bepy37cxuymfwr3@kafai-mbp.dhcp.thefacebook.com>
References: <20201116232536.1752908-1-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116232536.1752908-1-kpsingh@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:8f7f]
X-ClientProxiedBy: MWHPR04CA0045.namprd04.prod.outlook.com
 (2603:10b6:300:ee::31) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:8f7f) by MWHPR04CA0045.namprd04.prod.outlook.com (2603:10b6:300:ee::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.25 via Frontend Transport; Tue, 17 Nov 2020 00:11:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5be41ae2-714c-4bd7-a207-08d88a8d5801
X-MS-TrafficTypeDiagnostic: BYAPR15MB3255:
X-Microsoft-Antispam-PRVS: <BYAPR15MB325557B5C8F1A9494872AD41D5E20@BYAPR15MB3255.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vs/WKVeLyj2MdxZfaNb9jaJfDci69+7QNw6HDw61AHCvilnbv2g6NE/B9Zk0nFJ4DHX/NizBGF5zHiCNqOYrfq0BKfiBd+sWKRvai7/PDhOkYj82fiTRw/YKHonE78QHjlJ4AknqAyEuGKsZbOx89v54eqvnWoIxT9cruWZaAjpAdweaurXngDqn4dt7J4B6lcuFjC88afvLrqeOWTbup9g0Jzxe0sGrMkUAw0S5ZGLglsroKwTe3LLv+ssn89Lv1Qf32qiMWfU2817IuZhOd3Aa6t7qc5Vbb393KG7wg0VCHUIaP5TIi58jKXxP8W7a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(376002)(346002)(39860400002)(366004)(83380400001)(9686003)(16526019)(186003)(6916009)(8936002)(316002)(54906003)(2906002)(6506007)(6666004)(52116002)(55016002)(5660300002)(86362001)(478600001)(8676002)(7696005)(66476007)(66556008)(1076003)(4326008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: wwa/cXpHT+ejmmXP+NXdRc20lWSHsdfugkFljEg+pujxeT7HHK6jW8Rpi2fNbppnkBX+sgj1mJNf2PlUJdldDVeq6FIv1Z/wm7TarxTmizrebBfcwCXRebqkkxdKw9XqaMCIn50HxKLXWbDeaYn/YXQb/tNGwhfo0uSyonAejqd/m0QYgU+9kSIOvKr9ssaQgaBbyHjQnDNVufWpEchA4zXfr/eWe9vSs8K6Q6U3RJFdazIHeGydBsNX59Xv4Mowb3T4p3rPI4tRxVqIP4vYUPDxbyhs+9eb2aByTsV30vdOW3O2kTwjQyy3hrpLiTVVBcpiGnGYNxs3FWkeyJpHFWSClTWIcCbSoR1h6JsIFQlPPU2581eo8k/htvQ80uk58uRn2exof6EL01apdUUeCNPn6UzRGhpknvlzqHxI7k8LlshneOln04Ff8Q+cF0IPl+1SCXY9inmv+5Qjc0+MDROILrhIsHjd2WO8/sKu336X5rj3gPA0ihhE9eWhMv1vZZY4jO7tmCU3z81nIp3aarm3iyyXi02hgM33jAuyaxk0Ny9zhWtAlxKqVLZNfrqZIQoR2JOcVUvIXUOgadDE/OdE8zBwBLEy5XERJrWXcCPn3LAuWCBA3h/icTOA4KW3EDAQJSrHdQa5WW327ubBiNj3vAnXGTUh/XFPoJPFY4SuOs0+d7qApgI8ZZ04duMs5cMshr6TLyNvsFfCPXKH5C9k8TtLTxMTwPyRgKgM3NSmmfLwXdHDpDsfmdKfmYgkQOxNFFjM2jpc/h1zPPLDeUsQByzqJopXOQSvwcc6swACIy7mQ12ulG3EQr9ACJSMxsycbn2rcxlqfmAnNZqqvRrCHem7pRNns8nbadMjm5S+fPVfk+VIgxv+en1DObz4o6tF97FxGTWq7b7xDIEp3WS3OxrqHZ6k03hHi1Ms3Yc=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be41ae2-714c-4bd7-a207-08d88a8d5801
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2020 00:11:34.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KBuw12vbmwoVtgzZXjrArvUZkuZsitWmdSi1VKIfJZXOUhYQph3Qel2DBeOyCxu+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3255
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_13:2020-11-13,2020-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=2 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011170000
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 16, 2020 at 11:25:35PM +0000, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> The helper allows modification of certain bits on the linux_binprm
> struct starting with the secureexec bit which can be updated using the
> BPF_LSM_F_BPRM_SECUREEXEC flag.
> 
> secureexec can be set by the LSM for privilege gaining executions to set
> the AT_SECURE auxv for glibc.  When set, the dynamic linker disables the
> use of certain environment variables (like LD_PRELOAD).
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/uapi/linux/bpf.h       | 14 ++++++++++++++
>  kernel/bpf/bpf_lsm.c           | 27 +++++++++++++++++++++++++++
>  scripts/bpf_helpers_doc.py     |  2 ++
>  tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>  4 files changed, 57 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 162999b12790..7f1b6ba8246c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -3787,6 +3787,14 @@ union bpf_attr {
>   *		*ARG_PTR_TO_BTF_ID* of type *task_struct*.
>   *	Return
>   *		Pointer to the current task.
> + *
> + * long bpf_lsm_set_bprm_opts(struct linux_binprm *bprm, u64 flags)
> + *
> + *	Description
> + *		Sets certain options on the *bprm*:
> + *
> + *		**BPF_LSM_F_BPRM_SECUREEXEC** Set the secureexec bit
> + *		which sets the **AT_SECURE** auxv for glibc.
The return value needs to be documented also.

>   */
>  #define __BPF_FUNC_MAPPER(FN)		\
>  	FN(unspec),			\
> @@ -3948,6 +3956,7 @@ union bpf_attr {
>  	FN(task_storage_get),		\
>  	FN(task_storage_delete),	\
>  	FN(get_current_task_btf),	\
> +	FN(lsm_set_bprm_opts),		\
>  	/* */
>  
>  /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> @@ -4119,6 +4128,11 @@ enum bpf_lwt_encap_mode {
>  	BPF_LWT_ENCAP_IP,
>  };
>  
> +/* Flags for LSM helpers */
> +enum {
> +	BPF_LSM_F_BPRM_SECUREEXEC	= (1ULL << 0),
> +};
> +
>  #define __bpf_md_ptr(type, name)	\
>  union {					\
>  	type name;			\
> diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
> index 553107f4706a..31f85474a0ef 100644
> --- a/kernel/bpf/bpf_lsm.c
> +++ b/kernel/bpf/bpf_lsm.c
> @@ -7,6 +7,7 @@
>  #include <linux/filter.h>
>  #include <linux/bpf.h>
>  #include <linux/btf.h>
> +#include <linux/binfmts.h>
>  #include <linux/lsm_hooks.h>
>  #include <linux/bpf_lsm.h>
>  #include <linux/kallsyms.h>
> @@ -51,6 +52,30 @@ int bpf_lsm_verify_prog(struct bpf_verifier_log *vlog,
>  	return 0;
>  }
>  
> +/* Mask for all the currently supported BPRM option flags */
> +#define BPF_LSM_F_BRPM_OPTS_MASK	0x1ULL
If there is a need to have v3, it will be better to use
BPF_LSM_F_BPRM_SECUREEXEC instead of 0x1ULL.

> +
> +BPF_CALL_2(bpf_lsm_set_bprm_opts, struct linux_binprm *, bprm, u64, flags)
> +{
> +
> +	if (flags & ~BPF_LSM_F_BRPM_OPTS_MASK)
> +		return -EINVAL;
> +
> +	bprm->secureexec = (flags & BPF_LSM_F_BPRM_SECUREEXEC);
The intention of this helper is to set "or clear" a bit?
It may be useful to clarify the "clear" part in the doc also.

> +	return 0;
> +}
> +
