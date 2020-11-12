Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64CB2B10C4
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 22:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727293AbgKLV6M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 16:58:12 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:9618 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727043AbgKLV6M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 12 Nov 2020 16:58:12 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACLeTiZ032665;
        Thu, 12 Nov 2020 13:57:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=c+E1JedCwp7N9WoJn/4EwT0c+ZK6cM9euIzgddcDWBU=;
 b=GcrBqNfNG6tbQ0wq9zVYc3RXJuX01wnigc6+eIpNphfNM7/nR3ESR5jhh2tC2VbWnnon
 pYsSMseEf1fQaPA88kPO3WD9pFmTZgGfPuk6qXdKMUKoAWtPjZOy+tVC061a0VU4fgfa
 2TXozrz2kjIttUiUP8saaxdrVC7mMV5WCa0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 34r695ms9s-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 12 Nov 2020 13:57:53 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 12 Nov 2020 13:57:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QIFwau6DjDe/m7ZACAJYKyiljl7g+U/Tzif2WYIamgcX2doXsaLOClesjdYTV7CVyLUM1L8o8TxsibahGFwzX+XcOMEQP46BwcgvtMXzT4kixO6aXkBkgixEA9NJIRr3RiF/dIyEtyfMTLEZTS0kE5odhCViUowcVgHRVXMLzEFCzVqs1J55pENdqP+X2elguideuSZO7Pmvy3ZG2PamXUF3de2+dwP+avqIwW6tn2FAwpwtfM+wObADDB06uQ3fqHz8255JFCoosQznshg1BGxXWYKLErvqxkVIhYXshJCnTtk+BMK/W7JuMX1wFZpOG0LNLxmwLJIJnRDY4/X9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+E1JedCwp7N9WoJn/4EwT0c+ZK6cM9euIzgddcDWBU=;
 b=bMcA5LmpaVdy7uZLkHwoSzZq+pw9Ta14U5L1BlBTsq8xNbiA4VQoZC2OmStaPRULTFeqYoZlWKRXyFtthBmP9EzLt3G4+i6k3zx87NJ1JOCoWqT1Aco0yQzB6s8w3Mk5cljEhxHoP4GG+qmUNqDwHOODSPuqPKSJe907GgN43F6mEeyOrM23lC4Bax2Lr8AxrTTT3s0IaFqunwg6YSWDJ8VDcb9+F7ddCUKpm3CUWsdbi4X6oMrn1BDZlIKRqv/iun5XvBEGH5omJMgPBIvX2Vvgto5GWvf5QQwDe2GK5zA04K2JeAxXDH9/JVOz1/sfxL7EpwoF/dtB5LIeTAZ10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+E1JedCwp7N9WoJn/4EwT0c+ZK6cM9euIzgddcDWBU=;
 b=aEdEm58h6f3NSDSxQr4SIlNa1+qefpl6W7szFZK0nUNY6IMcZfhB3rhmTu9nDctqb1e9TNawdkKbqJKI5rVuRauNINImzB7IA514UnjhcB5xP8OIDc3Ta2RvrF4rFbH6b7oEtEnWHtQf/EDqbRhxmOFPZ8NIzrutBwUkUIJjzKw=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2773.namprd15.prod.outlook.com (2603:10b6:a03:150::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.23; Thu, 12 Nov
 2020 21:57:50 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::bc1d:484f:cb1f:78ee%4]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 21:57:50 +0000
Date:   Thu, 12 Nov 2020 13:57:42 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Florent Revest <revest@chromium.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <yhs@fb.com>, <andrii@kernel.org>, <kpsingh@chromium.org>,
        <jackmanb@chromium.org>, <linux-kernel@vger.kernel.org>,
        Florent Revest <revest@google.com>
Subject: Re: [PATCH] bpf: Expose bpf_sk_storage_* to iterator programs
Message-ID: <20201112215742.mzznj7py3fmnl5ia@kafai-mbp>
References: <20201112200914.2726327-1-revest@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112200914.2726327-1-revest@chromium.org>
X-Originating-IP: [2620:10d:c090:400::5:b515]
X-ClientProxiedBy: MWHPR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:300:16::15) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:b515) by MWHPR13CA0005.namprd13.prod.outlook.com (2603:10b6:300:16::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.21 via Frontend Transport; Thu, 12 Nov 2020 21:57:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc3298fd-ee56-4f3e-7b4f-08d88755ff99
X-MS-TrafficTypeDiagnostic: BYAPR15MB2773:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB27730F5FA6EDB74DDDE07F78D5E70@BYAPR15MB2773.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNOHBi58c5Hdyu2TD6kualrUFDinAx/F8qSxa1b700tmL1JE/PnP+gk4xk8Th5v925uYF89aer/ow3cfCYhJ4IHftSJlUHriI/LpG3N4i6I6q3jmra+emHT+ISDZQYKudnGxMjjqXybSFyjl/cLzX6kI2BdNc7zzTFxsK3SLumX/L2bY4tTSOfCzqB4jxHRRqHeqXGGOG9nGwK3wsvzfiyfrUHkDJ1GvojTMfpZXLKYMyQX3q3mO8Aqld5mTXn0bTehcl2oL0DagSaf8R1FMst6SIF+hAVBIzMw1WqoS6JjUZQKzjUFzkMwIBDs9TRdBpTkeDRc5kN1D8RCV/F6/bJawTTNyScely4y4QN3fJyQUEJFPRTDwkdxKkNNCJ06d8b2IrE4LXuvEV0CyItE2WA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(39860400002)(366004)(136003)(66476007)(5660300002)(66556008)(16526019)(52116002)(33716001)(316002)(186003)(966005)(8676002)(55016002)(6496006)(66946007)(2906002)(6916009)(478600001)(6666004)(83380400001)(86362001)(4326008)(9686003)(8936002)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: IIkYqmZWiVL3DvVCQa54sdHRtCTQjTuL5YHvC4/hTgiAgAxmGqKaFuNMnSsWZ9qvV4vO/tH5e5dj2wyRr+V+3PacK/G4HMYVzY+ZbwowP6aZleSTiZsxLmdIYoN4lVDqboHii/gnrzrsO4gu199hQvONXkdywo4krDFz5TtJKj8v+wY1vtD0SAV/47skUitIdkeI6baQMrblGaz1km8Hcnbd1vlhjQ0E3DyPo6ahqA4Z0rKe9tneN3QoOEfrvfzAqi3W5YtOHDC3AyMd/k142MpoBytOrMGfQbp8TA7Q00oy+vRQkalOWaPfKtT6rA0mqzArZ/Whj6f5ZPtFYchckbXWw1ixHkioRjxKOPLKBXz7pUIZ2dTLsV2URdCcqg8qKqrdHdJU2IlYThWAdrJccpVvdEdO6JTdfWAmxE5MKaFXTVNe9Ya+PX7ofYcNFhTTWaQQtxFkxKtXuBvEym4mKIqfqm1Z1q3dEq8SvR+Am4aZuuQjwdvjw/Iistx4MzP8DRaiUM8tbzGI4ZYHCKU+fgWN2ZK5RQEueD7mn8aX3MIrmQa1y7bZbiny2+hB9JZByaUMWcX29gFIbSlItVsUy0DsF7gC0Tz9wNYMjX7tSG8nOOyNzi9J8kQqhPygcGopZwBwGC1lipMC6Kn/i9Qp8JXBetmh4BeQk4kQ6GVxZVfv8wV2HxFZR+EHSpcUcd+FWh3e+h9addr6kBtspNdgw6YottKM38SvQVSM2J6ghRk9VcBY8B1jOXr0sJttR2EWHp7/+jdc3dGAnYIws0t1guJ9orB0FtJw1QGSZHeyQUbJCNAbUR5UtSBetaT8yupU8Q/kcZZxi5+xNgIfi2FUJvl+Zuc3fjwoQyL2GeMecoh/f9Qt2kHViukIyF5P5g0L9urEEniORSokcfEfYhzgR1LZakK+15TeP9ysh15EQi0=
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3298fd-ee56-4f3e-7b4f-08d88755ff99
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 21:57:50.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3EMn0ky8fD2A145U60KXjlWtiYLmtPzdF3oh+2ZyOmljWO9lY4hZXFw7cAEHjmX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2773
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_13:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 09:09:14PM +0100, Florent Revest wrote:
> From: Florent Revest <revest@google.com>
> 
> Iterators are currently used to expose kernel information to userspace
> over fast procfs-like files but iterators could also be used to
> initialize local storage. For example, the task_file iterator could be
> used to store associations between processes and sockets.
> 
> This exposes the socket local storage helpers to all iterators. Martin
> Kafai checked that this was safe to call these helpers from the
> sk_storage_map iterators.
> 
> Signed-off-by: Florent Revest <revest@google.com>
> ---
>  kernel/trace/bpf_trace.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index e4515b0f62a8..3530120fa280 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -17,6 +17,8 @@
>  #include <linux/error-injection.h>
>  #include <linux/btf_ids.h>
>  
> +#include <net/bpf_sk_storage.h>
> +
>  #include <uapi/linux/bpf.h>
>  #include <uapi/linux/btf.h>
>  
> @@ -1750,6 +1752,14 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		       NULL;
>  	case BPF_FUNC_d_path:
>  		return &bpf_d_path_proto;
> +	case BPF_FUNC_sk_storage_get:
> +		return prog->expected_attach_type == BPF_TRACE_ITER ?
> +		       &bpf_sk_storage_get_proto :
> +		       NULL;
> +	case BPF_FUNC_sk_storage_delete:
> +		return prog->expected_attach_type == BPF_TRACE_ITER ?
> +		       &bpf_sk_storage_delete_proto :
> +		       NULL;
Test(s) is needed.  e.g. iterating a bpf_sk_storage_map and also
calling bpf_sk_storage_get/delete.

I would expect to see another test/example
showing how it works end-to-end to solve the problem you have in hand.
This patch probably belongs to a longer series.

BTW, I am also enabling bpf_sk_storage_(get|delete) for FENTRY/FEXIT/RAW_TP
but I think the conflict should be manageable.
https://patchwork.ozlabs.org/project/netdev/patch/20201112211313.2587383-1-kafai@fb.com/
