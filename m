Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0B0718FD68
	for <lists+bpf@lfdr.de>; Mon, 23 Mar 2020 20:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgCWTRA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Mar 2020 15:17:00 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36066 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727689AbgCWTRA (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 23 Mar 2020 15:17:00 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02NJ2oYK024816;
        Mon, 23 Mar 2020 12:16:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=otqEUhr/v1OnfZxdIwVgyt0VK6Y7rKhWzkOlQ7xE93c=;
 b=VVNnnDQoN4Tb0KA/ul6PNHlAaR8skOz/yW073pr8Xc6hIb38XOkqacao7ByGtzH4FXO6
 dDClfnJgnK6Ct2UGUUfVNGPAUpTka2T6WSaq6X+sraKrNQaLApUVFzC7Zq0tu2FnUpHG
 18X1stDrCCy9nRs4UC4p7Dzai5muSOfTplY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 2yx2xy6sfc-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 23 Mar 2020 12:16:41 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Mon, 23 Mar 2020 12:16:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWjbwo0n+hzMdmR3LQRsDG65PozA66xOClWAB+kkLYVks0d2//3Oa2/8TOgwec5EJTDIpUoTjgsb1rv78+Tn4DSPjaETSur4ZUv3phCJQRelnk+03NZMfMMonOVRLAHYyQXxaCWEhLemSiphkdkiEmj1mJAqWW3xNidHQgdvcBCFdPt/85zFWpIDTmCdvYbwwSc7xoEqJMhBWbJgu61ScXwxAwcuci6e2nsJ9EN1heMRG5XIwRYZnPnlKqndScL/cbmehJNhvJPCnwJnrZE5dwweezDZYjrg2DameIpd932j2ZRfApp3eghavd9p6sPYyxjwlNVbBS2Fg0MhLeGdRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otqEUhr/v1OnfZxdIwVgyt0VK6Y7rKhWzkOlQ7xE93c=;
 b=bMB9gx/H5dUsbeNJA4JV6KHbDJ08zisG/gRpMGEtmDStKhHXUnqeY+7d+qoc3mY+xnTXW4paMy+5WN9/VL1ObuXRFh9BlGEbXmu9ZYOdaPNYY/d/av44S3EEhQ00lL8K9dYkMSv9GBOrAc6GS5gvGB0lfBCLmbtFuu44iLh4dD4DraKdB5yOQXU/uxUTKXz1ZHPLQfy++56dVUC5PP7w8uniK6CXEO17eIG4MA/WN9dRqzSOQ+Z2VrKOlf+uegu1sMlZG/MzUqS+5nD7g04/TCVSFXz+E939ke15kJxcyd1fifeqpu09ITnK+QnWM+H98xLdDEeGeJht2r2Trgr1ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otqEUhr/v1OnfZxdIwVgyt0VK6Y7rKhWzkOlQ7xE93c=;
 b=NMojCJRvDqQq2pBhDXmfAG48ej+kEZElzNoMG92tq1i66lySFRQPfCjriCYOwnz+xpm41hL38wU30KqggkTpRJJdGHwpsGG4HECCoYIA3MYtlqoPXyAfdImuBXd3ACCJd3JFR3iS9UhRF7Rp7/apo0Dn+o7rwdk1TLmbXh7PYDU=
Received: from MW3PR15MB3883.namprd15.prod.outlook.com (2603:10b6:303:51::22)
 by MW3PR15MB4076.namprd15.prod.outlook.com (2603:10b6:303:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15; Mon, 23 Mar
 2020 19:16:36 +0000
Received: from MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98]) by MW3PR15MB3883.namprd15.prod.outlook.com
 ([fe80::a49b:8546:912f:dd98%5]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 19:16:36 +0000
Subject: Re: [PATCH bpf-next v5 4/7] bpf: lsm: Implement attach, detach and
 execution
To:     KP Singh <kpsingh@chromium.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>
CC:     Brendan Jackman <jackmanb@google.com>,
        Florent Revest <revest@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Kees Cook <keescook@chromium.org>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20200323164415.12943-1-kpsingh@chromium.org>
 <20200323164415.12943-5-kpsingh@chromium.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3455719d-1359-cdba-431e-e7d06e5b398b@fb.com>
Date:   Mon, 23 Mar 2020 12:16:33 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.6.0
In-Reply-To: <20200323164415.12943-5-kpsingh@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:907:1::42) To MW3PR15MB3883.namprd15.prod.outlook.com
 (2603:10b6:303:51::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from MacBook-Pro-52.local (2620:10d:c090:400::5:2131) by MW2PR16CA0065.namprd16.prod.outlook.com (2603:10b6:907:1::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.18 via Frontend Transport; Mon, 23 Mar 2020 19:16:35 +0000
X-Originating-IP: [2620:10d:c090:400::5:2131]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2aa32e5-a89f-47b4-8c30-08d7cf5eb4f6
X-MS-TrafficTypeDiagnostic: MW3PR15MB4076:
X-Microsoft-Antispam-PRVS: <MW3PR15MB4076878C23E618E602EA6D3BD3F00@MW3PR15MB4076.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(136003)(39860400002)(366004)(396003)(346002)(376002)(199004)(5660300002)(54906003)(31686004)(86362001)(81166006)(81156014)(31696002)(8936002)(8676002)(66556008)(2616005)(66946007)(316002)(66476007)(478600001)(52116002)(53546011)(36756003)(6506007)(6486002)(2906002)(6512007)(7416002)(4326008)(16526019)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR15MB4076;H:MW3PR15MB3883.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DW7j4ElvO26E6jc6nGCCWxIxZrBlUNnvjgLINDClSZmkCOVdAAzVS5g1A8Si/QqaaxqG4Y+FdAPZNl4X/ZAqLf0N+GOTrS1mFmWHZ6KFmpXiY3R0ugMOrJD3PBAsXVhKxlCiLWoKaaVTeo7b46ed9nhKhvLeoa+KC4QX7hR52p7eZBPsI4d7xYewldTCqVsu/w1kfZ3Hp4UNGoaarl1AH6ob57GulFgfsIcFG2/uKOKL8baHWtP0PL/MED8qbf91ejYvcfkbO7WxCJjbBjo8Ez2Qo9pBQN6FRYrosTzPIO/ivdBQuY1lMPGt0q+PuaZwavYjEGgJdwVLLImoSr32XDuuqFzfeYTy7PQdds3Mxf97nVcYHS/UF3DgHvyMhKa9NBvYkWSjf/XQh19YDlksKw0gSrP09K8VROLKnxel4ZWYxPylBLPAeYUDbx4KqabT
X-MS-Exchange-AntiSpam-MessageData: SS3q6ltAsUl+8/2hKIe36X/Inx9VSlqBnfB5cHapzXf5NQYN5pHFhOjhOUlbpwOXlPSFDDBoWcV35pydeTNUcaLWkaiaaWawDlytEurNuDDvIOSVzJz1g1Gt8KYx1N0umVp0CYWyL7ZqlhJyOxa+vDxaqgPE603KN3C8RdyyIhBJJg7WtQ70MR9YN8HaHteu
X-MS-Exchange-CrossTenant-Network-Message-Id: e2aa32e5-a89f-47b4-8c30-08d7cf5eb4f6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 19:16:36.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AOU4mmblhxKwjV3SrEr1kFZPjAvZrdnpxndXHuJO5tENS+ca+SUucjxroKJb83U8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB4076
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-23_08:2020-03-23,2020-03-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230097
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/23/20 9:44 AM, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> JITed BPF programs are dynamically attached to the LSM hooks
> using BPF trampolines. The trampoline prologue generates code to handle
> conversion of the signature of the hook to the appropriate BPF context.
> 
> The allocated trampoline programs are attached to the nop functions
> initialized as LSM hooks.
> 
> BPF_PROG_TYPE_LSM programs must have a GPL compatible license and
> and need CAP_SYS_ADMIN (required for loading eBPF programs).
> 
> Upon attachment:
> 
> * A BPF fexit trampoline is used for LSM hooks with a void return type.
> * A BPF fmod_ret trampoline is used for LSM hooks which return an
>    int. The attached programs can override the return value of the
>    bpf LSM hook to indicate a MAC Policy decision.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> Reviewed-by: Brendan Jackman <jackmanb@google.com>
> Reviewed-by: Florent Revest <revest@google.com>
> ---
>   include/linux/bpf.h     |  4 ++++
>   include/linux/bpf_lsm.h | 11 +++++++++++
>   kernel/bpf/bpf_lsm.c    | 29 +++++++++++++++++++++++++++++
>   kernel/bpf/btf.c        |  9 ++++++++-
>   kernel/bpf/syscall.c    | 26 ++++++++++++++++++++++----
>   kernel/bpf/trampoline.c | 17 +++++++++++++----
>   kernel/bpf/verifier.c   | 19 +++++++++++++++----
>   7 files changed, 102 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index af81ec7b783c..adf2e5a6de4b 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -433,6 +433,10 @@ struct btf_func_model {
>    * programs only. Should not be used with normal calls and indirect calls.
>    */
>   #define BPF_TRAMP_F_SKIP_FRAME		BIT(2)
> +/* Override the return value of the original function. This flag only makes
> + * sense for fexit trampolines.
> + */
> +#define BPF_TRAMP_F_OVERRIDE_RETURN     BIT(3)

Whether the return value is overridable is determined by hook return 
type as below. Do we still need this flag?

>   
>   /* Each call __bpf_prog_enter + call bpf_func + call __bpf_prog_exit is ~50
>    * bytes on x86.  Pick a number to fit into BPF_IMAGE_SIZE / 2
[...]
