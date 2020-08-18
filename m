Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDB3247D3E
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 06:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgHRERN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 18 Aug 2020 00:17:13 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:11962 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726302AbgHRERL (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 18 Aug 2020 00:17:11 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07I49JWD013343;
        Mon, 17 Aug 2020 21:16:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=VZyiIi4+Q3Ftse+f4XizvGRAUgJ7zVbaHhvpKIZIcQk=;
 b=LoSwYmRzBSrJ1G09GUZ4puXGs/kXXdfD5r7DhC43MxjdHB1vR+tKwciNWC4nlqsMZS9w
 MZKHzdT7GiMxqDQE6sx3LjvpQxtD4yiF1RgzQUvHzbAWGqlqfm1nHHtnOtV+Oeq+y2vI
 iyezgIaDKxsfLCHalbGBSyXNTllBB4ckJj4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3304m2rp1q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Aug 2020 21:16:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 17 Aug 2020 21:16:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2xlNOM1pQiydZlnEuHnPlPR6fINW79xKSLaCILf962Y/0uXYWT7WDGVxsEBrKy8kJkzedAhm4X8Jsq1msrI5rM2gEp7MWGbpYT7REBtiWQdVju1iM3O4sCwivhB8z67Ij4MW1mvR6NQoJ8NJ8mw0IbTxeAs6myuQAz1WSvJ2Dgy22x3Wi0xgCNsn18P0UhQotHJu7wk3xeGe7DD1JS0T9hadS2v8aK4LpdQMHCGTr/M9omnNGa8a9FBw42e/tsrMp8NpI/vrN7+MHvsaLame4Aej3LVWYmHbYuYA2c5jl93+zVZVtQG/uUxaFYHk47HczYAPyXBmz6seSR7qZmy4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZyiIi4+Q3Ftse+f4XizvGRAUgJ7zVbaHhvpKIZIcQk=;
 b=cYiu5znIJY7Nx73PO6bOce+F7f9KH3JOfaFKjW9Ep4Q5NwV5ssfRQ1kljPnkfpWwFMnmkA4fpCx7cDs8IJDv4ioK7dlql7AhQwp/KrOlthZSpr3TlJq77fMBMt/IbObU2Ceq+Sib2oQjamxf5Aiu1zdVc9CjbQc+v/zagmsEE4kMA+XrSVEsLMqhUTV2xJjG6j3D5pmbtlz3iP/egjEN99RhwkfzJVSrXRWJovJ2gwL0K7rv3/pjuJCEFZvMBQYtpkDBg2EqbFyZ0NpuH89VaLWWvX/YEN363VR2/nEo3078xrx34kfX2f5j63DnnOB2Vjqip/uzmIwJy8Z08ikjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZyiIi4+Q3Ftse+f4XizvGRAUgJ7zVbaHhvpKIZIcQk=;
 b=K+CB/4q7hN28MSbjxJEkGuqw29bF1QxG/IccI1yrCBpup6TNB4jXqwntV+f+z7n2SstI+7h71JqPOV1Lvn+FmcitEAi3rKAkd50tfiKIncpXwtDVc8I57kfxxdYNXzdPA5BGJPSSBlyWmRqZC+qgg21XeGwkzHM90hA0oxXyJU4=
Authentication-Results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB2453.namprd15.prod.outlook.com (2603:10b6:a02:8d::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 04:16:48 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::d489:8f7f:614e:1b99%7]) with mapi id 15.20.3283.018; Tue, 18 Aug 2020
 04:16:48 +0000
Date:   Mon, 17 Aug 2020 21:16:42 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     KP Singh <kpsingh@chromium.org>
CC:     <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Paul Turner <pjt@google.com>, Jann Horn <jannh@google.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next v8 6/7] bpf: Allow local storage to be used from
 LSM programs
Message-ID: <20200818041638.2dv5cewlgwerd7hm@kafai-mbp.dhcp.thefacebook.com>
References: <20200803164655.1924498-1-kpsingh@chromium.org>
 <20200803164655.1924498-7-kpsingh@chromium.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803164655.1924498-7-kpsingh@chromium.org>
X-ClientProxiedBy: BYAPR05CA0100.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::41) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp.dhcp.thefacebook.com (2620:10d:c090:400::5:9714) by BYAPR05CA0100.namprd05.prod.outlook.com (2603:10b6:a03:e0::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.15 via Frontend Transport; Tue, 18 Aug 2020 04:16:48 +0000
X-Originating-IP: [2620:10d:c090:400::5:9714]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0977a77b-a338-4f05-a6e4-08d8432d86a2
X-MS-TrafficTypeDiagnostic: BYAPR15MB2453:
X-Microsoft-Antispam-PRVS: <BYAPR15MB24530CC4612E6A5C7DC49977D55C0@BYAPR15MB2453.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: maZN3ePiB6RZzfO9b/WPVR+TJwt4R50s63hVLnRMhsj7bT6MdxwsvlKatNytjudRIW2FFv4oUq/ZMPJop2ef+gAy+mMJAD1Hva93hh0kq/paUK1OJ9B3oBglDaSZ1NDBHrAkWB87pJ0bwIgUD9rQIzyY3irp2zkf2EUz9FKpn20zIg2ys3LIWnPFSgt2DYcPJLp8ZkH+bpwnmA/bEXjV+FSXkBRoG58WkNN36gPk7p+n/WlcGRB34cXwG3alzM4+7WE9z98yVZHREvoNVcJcnxTi2nQB+pv3Mhljr9MGhOx5DIinT00dMo6ivAL0DSiB7/HROFO7tDdd9jQ8VN8OJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(346002)(376002)(136003)(396003)(5660300002)(1076003)(7696005)(8676002)(86362001)(52116002)(4326008)(6506007)(55016002)(478600001)(66556008)(8936002)(66946007)(186003)(2906002)(9686003)(66476007)(54906003)(6666004)(6916009)(83380400001)(16526019)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: r6vFBqZlnP3Au+pHHzgfbkkwpUqdYdCqxbG3/3eODVkbS5DHTOJ/BMj1cHb/zgazc7hqbSOhMyy0tfFY0yPrcUw10JIcsuUy31U7tILT+UUsu7io82nG6rVBfqoYdrgVS+w0qg22LEnQAsC9ilqK+HhCzMAmIIphe3B4KQbsI7JKmfBHrAIFFGPlLhZwXWNLvuwRpexJitaUSRhh9ki2Rrhh5WTm6ROH6pfeh19BxjoYLyTQzWZ8Me3rTfDX1lAdPUsTV1zBrNl9u43UABfE2fPhs7Vf+UAakm0OMRlrHxthkzXyPCUBeyrUj2pPYk5NKzPK2kOOpQI13fQOYzX9YYBN97p0PjglZuUH1XRlfNijDTGLi7ls70z0TKd5G20WHmspHhQodgXz3LM8TBvh6EbOmm5g1wa2FeE7XkRH+Uh6MRV7XHhnB58aDIvHxz8b5bdqZ7XfhGESeeHLw0T6BdEFJTkleKRuBiOzC30BfYhPaPveuztA8ryT9bWuRRoiRthjCVkwer0mG+88sLUKHt9copjAaL/8cQP+3dRAUMAeKWuC4K7lq25NpHidDPPW4S4O1zpGbZYFbW54zF4Un0jGJ7ogg0ogj/CeZcQifnU4SXuIVFpEKCcxPE4I5OMldv8Oz8mkVXbcf/E7EfBKSLmYkwdLGPvavX04bpvaszw=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0977a77b-a338-4f05-a6e4-08d8432d86a2
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 04:16:48.7219
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcRjM88QMtsXO9eYQhqN1BDTL1FIbLx4gSmegYHLxmyYejPKbWtP84Rl/zgLsIMi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2453
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_01:2020-08-17,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=5 spamscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008180031
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 03, 2020 at 06:46:54PM +0200, KP Singh wrote:
> From: KP Singh <kpsingh@google.com>
> 
> Adds support for both bpf_{sk, inode}_storage_{get, delete} to be used
> in LSM programs. These helpers are not used for tracing programs
> (currently) as their usage is tied to the life-cycle of the object and
> should only be used where the owning object won't be freed (when the
> owning object is passed as an argument to the LSM hook). Thus, they
> are safer to use in LSM hooks than tracing. Usage of local storage in
> tracing programs will probably follow a per function based whitelist
> approach.
> 
> Since the UAPI helper signature for bpf_sk_storage expect a bpf_sock,
> it, leads to a compilation warning for LSM programs, it's also updated
> to accept a void * pointer instead.
> 
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  include/net/bpf_sk_storage.h   |  2 ++
>  include/uapi/linux/bpf.h       |  8 ++++++--
>  kernel/bpf/bpf_lsm.c           | 21 ++++++++++++++++++++-
>  net/core/bpf_sk_storage.c      | 25 +++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  8 ++++++--
>  5 files changed, 59 insertions(+), 5 deletions(-)
> 
> diff --git a/include/net/bpf_sk_storage.h b/include/net/bpf_sk_storage.h
> index 847926cf2899..c5702d7baeaa 100644
> --- a/include/net/bpf_sk_storage.h
> +++ b/include/net/bpf_sk_storage.h
> @@ -20,6 +20,8 @@ void bpf_sk_storage_free(struct sock *sk);
>  
>  extern const struct bpf_func_proto bpf_sk_storage_get_proto;
>  extern const struct bpf_func_proto bpf_sk_storage_delete_proto;
> +extern const struct bpf_func_proto sk_storage_get_btf_proto;
> +extern const struct bpf_func_proto sk_storage_delete_btf_proto;
>  
>  struct bpf_sk_storage_diag;
>  struct sk_buff;
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e17c00eea5d8..6ffc61dafc5c 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2807,7 +2807,7 @@ union bpf_attr {
>   *
>   *		**-ERANGE** if resulting value was out of range.
>   *
> - * void *bpf_sk_storage_get(struct bpf_map *map, struct bpf_sock *sk, void *value, u64 flags)
> + * void *bpf_sk_storage_get(struct bpf_map *map, void *sk, void *value, u64 flags)
>   *	Description
>   *		Get a bpf-local-storage from a *sk*.
>   *
> @@ -2823,6 +2823,10 @@ union bpf_attr {
>   *		"type". The bpf-local-storage "type" (i.e. the *map*) is
>   *		searched against all bpf-local-storages residing at *sk*.
>   *
> + *		For socket programs, *sk* should be a **struct bpf_sock** pointer
> + *		and an **ARG_PTR_TO_BTF_ID** of type **struct sock** for LSM
> + *		programs.
I found it a little vague on what "socket programs" is.  May be:

*sk* is a kernel **struct sock** pointer for LSM program.
*sk* is a **struct bpf_sock** pointer for other program types.

Others LGTM

Acked-by: Martin KaFai Lau <kafai@fb.com>
