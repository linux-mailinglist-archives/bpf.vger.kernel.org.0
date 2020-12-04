Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79A2CF506
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 20:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbgLDTtK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 14:49:10 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6878 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726392AbgLDTtK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 14:49:10 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B4JmA1B002447;
        Fri, 4 Dec 2020 11:48:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=BAFXsuzvvdTC8bndIkfF1sEJfX8YjPl6ZinqaXAThhI=;
 b=SlFg4pPdVLA/UAZCuPozPr8sy2Ej7Qf+IaM8NT+T55R5yYk5o57tXaFHK2gFTFS5SCoW
 YqWoWu9/A6xEU+BEHFfZSmOUhQCdmmEFsR5cf3aAm+EAR7Ve8lmJnv/FzNajyhngwXOe
 K3/Sijerww5H1f2/gXUW3GCdDQDV4dPbB9M= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 357tfmrequ-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 04 Dec 2020 11:48:12 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 4 Dec 2020 11:47:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PinrbliVxhHBCNJi1OMSSGQpoVwR8XOHcfHmE/0YPlgT78OBgZoH9Kf5LcKfAEEzfxIMOH6xObxGImuIfimNgGgyR+/dA9Yr3y+fWLRWrjQ9DIOazRJFpDccENZQdjOZERzqKctT/KFOeX8TT/0Y5H0/9bAsXtV1pcSFFUzGShw9wmfECkYnGxaw+m6YqKbypbgeQ/kQEu1yGaVK4AP6mhSp+YlW1VnO1R7b8YU+65Ufb4pK08TKowgdjO9P5YANWBnLFtkavtK7+cyu4xR++MfdyN8X4k9FSOno/P4x3d2H9/ygB4D3eAAp3IikdtwLcBhE71XwM5UKCVTwmnY8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAFXsuzvvdTC8bndIkfF1sEJfX8YjPl6ZinqaXAThhI=;
 b=nCODn5faHd0n50dJAKlQRej/8Lb+7ifEuB7cixEIDaavfUp1DBwQ+7Xekr59FUWQWx+kiK/ABPsQOKr59R9eqS7c7HIwVTt/dtU+7PVX8W3f/7xHdjjQQJx4DXXciy6vd+db6vPxpSvFV1edxzWak62rnOS+QtZMmd/b547YwR0JH2+9pGag14c1SFOCNo4keSgSobnT8Z8oEdRN4eVStNTrZepoAEdzSOEv39+eY5xcI7pAAQuGCGKdJ4n59XHQNKBInNg8Rkp6zQvFdRJE5gw4cSopcKJF4+dgUTkV8tszycplluSwzmFuZjpL6AO7j8MprK80HdbTVsuyXI+1fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BAFXsuzvvdTC8bndIkfF1sEJfX8YjPl6ZinqaXAThhI=;
 b=E2ZObLiLpRq22FFZqcP0nWL0sS/5NT4Co0ET0aNtNjB8lbTY+PA0tMbZ/GY4D2Je062FCcYdMNf6Z3fndskfU6rGhf3rbeYQbXgCqEzWSek7ztr3GMlbJ0p+jy5hGcwSmU8ulLWT8udFAJCbms/WTr0pfWzMyhjzaHA9fBDeOhM=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2327.namprd15.prod.outlook.com (2603:10b6:a02:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 19:47:56 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2831:21bf:8060:a0b]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::2831:21bf:8060:a0b%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 19:47:56 +0000
Date:   Fri, 4 Dec 2020 11:47:48 -0800
From:   Martin KaFai Lau <kafai@fb.com>
To:     Florent Revest <revest@chromium.org>
CC:     <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andrii@kernel.org>, <kpsingh@chromium.org>, <revest@google.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Expose bpf_get_socket_cookie to
 tracing programs
Message-ID: <20201204194748.cqyz7hfx5s5dyszc@kafai-mbp.dhcp.thefacebook.com>
References: <20201203213330.1657666-1-revest@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203213330.1657666-1-revest@google.com>
X-Originating-IP: [2620:10d:c090:400::5:adde]
X-ClientProxiedBy: MWHPR20CA0015.namprd20.prod.outlook.com
 (2603:10b6:300:13d::25) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:adde) by MWHPR20CA0015.namprd20.prod.outlook.com (2603:10b6:300:13d::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 19:47:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a465c5fc-6288-406b-eaca-08d8988d7eb1
X-MS-TrafficTypeDiagnostic: BYAPR15MB2327:
X-Microsoft-Antispam-PRVS: <BYAPR15MB23272E75C5468014AF8BBD89D5F10@BYAPR15MB2327.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NoT5ykmUAVdh1lbVlFFm4q/tx+8Or9dIpDjZYMViTL0yweS8aRNYc+GtvX1/Ds7k5UR9dcWfuVCrsI094ZGEzwyx0Jty/oAWpCm9JGMHtcFF44hVf8J7CLz5EP20Ee7CM9tUUn+b2KJh/vKX29OuZJimEp7vqjAf1aXVfL/+SJinFXjCOzdtslIpp4wQpg2TTgYXsjb43oXz6qP3eoInbztOHl/tDT3WGL4dzhjKwBBBo2n0Sn3cl56VcwDKGqJDx05qiqNIV9KGi2wSPI+6vr7MpsAK6nOG/ZDD3rPnrCfzM/nWvlnhjWZTLVmWra4ijKusvxwuDFHPhoUsqnGgYLFzDLf5PFNRt5gGuVsMdvoVfEZl24VAdkQF59epChxiKUphCJ2borzbZ5g60ucogA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(376002)(136003)(83380400001)(66476007)(5660300002)(316002)(2906002)(66946007)(6916009)(1076003)(86362001)(66556008)(966005)(6666004)(478600001)(9686003)(6506007)(186003)(52116002)(7696005)(8936002)(55016002)(8676002)(16526019)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?dFF/GkJnfZUhxs+0aOaLWnXNgE4jUFaxw4jr/1sDjgbzIzcq4qkL3muRolXN?=
 =?us-ascii?Q?9LC1KgS1sDm3Q7rp/opFowAEuAtbhQY02bxbRH9p83ClYwwwhRraXpW/vBMA?=
 =?us-ascii?Q?RpTnnA1TCAMj2qVuAJaslu0FhzcpZA74U1o4AwWn5U+j9jMhogGv0L3J5ILJ?=
 =?us-ascii?Q?q+sbgXudezr7KNi5yqVx5inhRBnovK+oryqrh/+PscVPhwwC+HhZT8B7CK+m?=
 =?us-ascii?Q?uEBJ7HrJuojkCJbl41+eJjj5BQOAtu4o8gxj5s8ch7rfz+kEREefLsL33/It?=
 =?us-ascii?Q?K3XHSNaAxei5u9S3vdA2LO/NqP8jRlmmQTA9Bp7RZc5N4EaY3f6XUlTJ7C39?=
 =?us-ascii?Q?EHDO4NUZLyFXTVLz0IG9lxl9pkCKK4W36Ww7/0COMXW+FqQPzZYTij3fZIXI?=
 =?us-ascii?Q?wlYPqpqAmFTD2LRW9oj/H4gFkJoIss/rFje87bB3G4lCg9V0pdfxNUqp/zPd?=
 =?us-ascii?Q?8cBMEqevK+33SXEGUOk1R1Cxu/Np2zjbSPiJd92YqAb9/C4HdkTYCl+nuSnV?=
 =?us-ascii?Q?FTQgq2+41YiHNV90o45h/oCt3vFKTLlq//caJbfwhsjrKPQjnn20DE1Hg0GY?=
 =?us-ascii?Q?zpV4fjWPW4+kaqPiXJdVm0USwY7Lf71+EGrDyt3S7xsNDrBivoMxQUoHTdpv?=
 =?us-ascii?Q?tqPr6mzBYcA6FxjpSf0KNARgzTNDUXQBH9Xi4pm2wz26Kx37ut691RrB95JX?=
 =?us-ascii?Q?39eV9OelOzo2LSJ3Eq03/K5xCeCDLkgj/OKQGQDGFzYD3NaOjQZPUnX4RYbb?=
 =?us-ascii?Q?g6HCkMqBx6gulJYNqz1bW6quxH8hQT8qOSxreIuITOb52zpLnUU7eMOGxY57?=
 =?us-ascii?Q?s1GjXUy5EAwtg2KMEeHg4nwjGEGizI1eQAhEq9c/CDaquvrOhD8dqdmnUjLa?=
 =?us-ascii?Q?eAYna70m5CXWDed+LWFhwd74bI4X80/Y6Zng9ztwZjSBvnp1jf/UIP6x6gCq?=
 =?us-ascii?Q?rm/vwJIGzX681cUv8ckX0B9SxnSrFjD8thmWFXooaJ3SBslbskC6WH0k0eMB?=
 =?us-ascii?Q?5u8M4tn92JyzIjlEJ91Aia4Bjg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a465c5fc-6288-406b-eaca-08d8988d7eb1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 19:47:55.9832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: urtmo6LdcEZ49YHJLXaaIBNU49oIyUjMFQ1iKsjCYXP9SZ0dFlSCAWMKgmBTUDeX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2327
X-OriginatorOrg: fb.com
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_09:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012040114
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 03, 2020 at 10:33:28PM +0100, Florent Revest wrote:
> This creates a new helper proto because the existing
> bpf_get_socket_cookie_sock_proto has a ARG_PTR_TO_CTX argument and only
> works for BPF programs where the context is a sock.
> 
> This helper could also be useful to other BPF program types such as LSM.
> 
> Signed-off-by: Florent Revest <revest@google.com>
> ---
>  include/uapi/linux/bpf.h       | 7 +++++++
>  kernel/trace/bpf_trace.c       | 4 ++++
>  net/core/filter.c              | 7 +++++++
>  tools/include/uapi/linux/bpf.h | 7 +++++++
>  4 files changed, 25 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c3458ec1f30a..3e0e33c43998 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1662,6 +1662,13 @@ union bpf_attr {
>   * 	Return
>   * 		A 8-byte long non-decreasing number.
>   *
> + * u64 bpf_get_socket_cookie(void *sk)
> + * 	Description
> + * 		Equivalent to **bpf_get_socket_cookie**\ () helper that accepts
> + * 		*sk*, but gets socket from a BTF **struct sock**.
> + * 	Return
> + * 		A 8-byte long non-decreasing number.
> + *
>   * u32 bpf_get_socket_uid(struct sk_buff *skb)
>   * 	Return
>   * 		The owner UID of the socket associated to *skb*. If the socket
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index d255bc9b2bfa..14ad96579813 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -1725,6 +1725,8 @@ raw_tp_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  	}
>  }
>  
> +extern const struct bpf_func_proto bpf_get_socket_cookie_sock_tracing_proto;
> +
>  const struct bpf_func_proto *
>  tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  {
> @@ -1748,6 +1750,8 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>  		return &bpf_sk_storage_get_tracing_proto;
>  	case BPF_FUNC_sk_storage_delete:
>  		return &bpf_sk_storage_delete_tracing_proto;
> +	case BPF_FUNC_get_socket_cookie:
> +		return &bpf_get_socket_cookie_sock_tracing_proto;
>  #endif
>  	case BPF_FUNC_seq_printf:
>  		return prog->expected_attach_type == BPF_TRACE_ITER ?
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 2ca5eecebacf..177c4e5e529d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4631,6 +4631,13 @@ static const struct bpf_func_proto bpf_get_socket_cookie_sock_proto = {
>  	.arg1_type	= ARG_PTR_TO_CTX,
>  };
>  
> +const struct bpf_func_proto bpf_get_socket_cookie_sock_tracing_proto = {
> +	.func		= bpf_get_socket_cookie_sock,
> +	.gpl_only	= false,
> +	.ret_type	= RET_INTEGER,
> +	.arg1_type      = ARG_PTR_TO_BTF_ID_SOCK_COMMON,
In tracing where it gets a sk pointer, the sk could be NULL.
A NULL check is required in the helper. Please refer to
bpf_skc_to_tcp_sock[_proto] as an example.

This proto is in general also useful for non tracing context where
it can get a hold of a sk pointer. (e.g. another similar usage that will
have a hold on a sk pointer for BPF_PROG_TYPE_SK_REUSEPORT [0]).
In case if you don't need sleepable at this point as Daniel
mentioned in another thread.  Does it make sense to rename this
proto to something like bpf_get_socket_pointer_cookie_proto?

[0]: https://lore.kernel.org/bpf/20201201144418.35045-10-kuniyu@amazon.co.jp/
