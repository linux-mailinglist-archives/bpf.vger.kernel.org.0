Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA23E264C52
	for <lists+bpf@lfdr.de>; Thu, 10 Sep 2020 20:09:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgIJSIe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Sep 2020 14:08:34 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:6554 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726801AbgIJR7S (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 10 Sep 2020 13:59:18 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08AHunxq026742;
        Thu, 10 Sep 2020 10:59:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=EdjfuqNbzXkb8Akf6zXuqxhRzNvfl0AHniMc96lYMDk=;
 b=Azex/1rSyL1Hu6Qg2xL3msuXtdfdy01P8wK6qYaCCJtHOPv1Dd3LpTg7eR03I1ZVHgqi
 qLVFDNVKI6LlDEdyaHrWJN7ifw8K5o/HFBfXNbeLYAOgyMT/qaeor8E4BSliNtoqLzz3
 FLbZ3KN9XVw8S+Ydv1UO+z0zmQln1tNwQZg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33fqeermfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Sep 2020 10:59:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 10 Sep 2020 10:59:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcXtQMwdJMzO4LUnkHbSprRfo2Jv36lZqYaNv2wUu2VJZxRDNXG3f8dIPStefpvnnvJFJryuBarlM1ij0OdOIA/zONXN07e7FTV0fqEwaF34iSQHckvpDBXhLmb27v4UM8KrL+Bg2w+JkG7cgzcjpG24Wh4dOIqw8Gm/8Ib9flDuvyoTk0h5wCt/+SEl/Nv2qMuwsxEr/XCdF6D9JVuuYbeQOZhZE6N3XvaVPX3xjZIO8tfl+jeHOK66ExSJ8WvUHCI9pEv7/VU2E9ZIeQVEKCbP+sa2V4BeUEfBC4FDFtOgxjE2m7Vbu/I+jee7ugHcSU0CPNGCtX7dYiL+UdR6FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdjfuqNbzXkb8Akf6zXuqxhRzNvfl0AHniMc96lYMDk=;
 b=BxOFqhJL6esBAPRwm4hudJexzeDMSB0QNsAPm2x3T8DqQhWEPF+6CidyQuAXEJGf9RnA7xwWAbBvmVSO3rpB1V/v5RC4nbAPf/97Ste9DJf8AcieJs6eturwD0NRntubkwclpigei5bEpqiAgH3tQCKmUp2fzbDcnVSmGrvGKEcZiHRNsk4rT9jQ9s2ev3l+BTWiPDlzI3mQU8Jd/r4WIGgzYWsLFEPwr4eXvSDH0gb/cIJscmOXL5HHYuaM8i7ZUEqWqxxGMfXBmvUZVKdumUQkOpieTj9G4ngZNbo99eMrNsVrhj01oCbXDhu/yLXXiCvH5aDdI3EgOUgWbMiV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdjfuqNbzXkb8Akf6zXuqxhRzNvfl0AHniMc96lYMDk=;
 b=alLOclLtRVmUfxnynfvAq0dU7m9YJg6vXLFeq8OtFoo3vJmnVgVnOnMLeU6+1Jh9hWBG1KsdTs85E/WbI1Ifo5Rs6yzGGzgu+6I4tOtfsE1RZX/baaWCP7j6KHXY4DV4AOLPqNlrkOyIU/59Tigt7MvNS2+Xh2T/CJHPa8d8Le4=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BY5PR15MB3713.namprd15.prod.outlook.com (2603:10b6:a03:1f8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 17:58:55 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 17:58:55 +0000
Date:   Thu, 10 Sep 2020 10:58:49 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <bpf@vger.kernel.org>,
        <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next v3 04/11] bpf: allow specifying a BTF ID per
 argument in function protos
Message-ID: <20200910175839.su73mcscacfmrzhn@kafai-mbp>
References: <20200910125631.225188-1-lmb@cloudflare.com>
 <20200910125631.225188-5-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200910125631.225188-5-lmb@cloudflare.com>
X-ClientProxiedBy: MWHPR21CA0051.namprd21.prod.outlook.com
 (2603:10b6:300:db::13) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:f5ef) by MWHPR21CA0051.namprd21.prod.outlook.com (2603:10b6:300:db::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.3 via Frontend Transport; Thu, 10 Sep 2020 17:58:54 +0000
X-Originating-IP: [2620:10d:c090:400::5:f5ef]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bf37377c-6dbb-4729-3958-08d855b32ee9
X-MS-TrafficTypeDiagnostic: BY5PR15MB3713:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR15MB37133641694A8CC2828B2252D5270@BY5PR15MB3713.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uCDGmk0JmfwLclCOWjar1/3RxxOgxbjEmyblqs6myI9xbRPcvid/mP2ySIhjV9eesX53kupZNVDr41zlAziFTBN4Ymt/AsigdKEEUPUT2Zvp0uTxT47H39uB12IyT1rV8loXu2o/Yud8e6uNAYoTKobRfN7WLi5JpoK8V7kv++jOck2Ix6RJOSMpXLyU2N0c4Cl85Cr68SCkKJO7BMuKpJMq4zXI4QSK+uP8xrqZD7Mxv8NW+rGHsgy3m4ExVcCtwDQyqTr/xAlqeJq4m8FJmWpluLR3Yk92FczH+hyfz57Xn4ESjxVztoY3molVhd/DsTxn4tVhWsOcFymBEsvlTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(136003)(396003)(376002)(39860400002)(346002)(5660300002)(6666004)(6916009)(33716001)(1076003)(316002)(52116002)(6496006)(16526019)(186003)(83380400001)(9686003)(8936002)(478600001)(8676002)(4326008)(66556008)(66946007)(86362001)(55016002)(2906002)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: ZlmCHfBa65snZp27kipJv0+ZXmAhytF6IRINk88KhKFdoHFeX7IGZi6KlWwUWtG1uuXGGHdjDjKtZSPRKQ/lPJJxniyB2Us/Oixr/U2bMt/gCH7uwtTaspsjBMdq0C+fQsxE5C5FUzwbpU0nk/9Tm1XX8vgR58RE+Ze6uBaob7tfj/aAs5vcMBtLo7lS8jPFu1e5J0GyK/BR+UcTZdCptrkUjB7XwHdchQ6cnOBSEmOEjD7WkAQf3nfy5VHP/toVRkh30lfx43JwSYg+6D8MYJgGwOV3/2t9yckvbYEfKyc/bKP5wChc6Dxi0hFT8ted9t6AhXJbIhx5RMiuacynwJrUxgRPXvbaYUMc+k0+ZIJ+Lb2s8icecq9r55vicL3+FdQEGy7vGRdCODPWksJshxAM2FrZCXjMlQigFaIB7u4otbVjTUZxfxpm1ufOX/3X7VG5N/j1u7V9Dx6UyMOWASCX2tsQSkA3SFAuZ332L0wBsUOWrRGZxT0vkhpNdebU3uNgif7gL4SiGvwDxX3QgihcmzldEPUWJYEa2IvLwO560GW3GOoiEpS9pyDYQOYKMh75vHfML3zWa36WUGCqU/kzthkuwkZpKRoyukEGpadpjC51OWaHmn0BV+/oBE8QBcMbr9xqY5hILs4U3GzR7tGtHiYA9ghdeWxhpV9iS89+HKjdAtVWmv6QqBxbJA9U
X-MS-Exchange-CrossTenant-Network-Message-Id: bf37377c-6dbb-4729-3958-08d855b32ee9
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 17:58:54.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eW9XliysakQg3O+4qQ7wPS/H4bXVowRH8zbS7Fx42OCr375OoegKsptQbcGivKq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3713
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-10_05:2020-09-10,2020-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=1 priorityscore=1501 mlxlogscore=806 impostorscore=0
 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009100166
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 10, 2020 at 01:56:24PM +0100, Lorenz Bauer wrote:
> Function prototypes using ARG_PTR_TO_BTF_ID currently use two ways to signal
> which BTF IDs are acceptable. First, bpf_func_proto.btf_id is an array of
> IDs, one for each argument. This array is only accessed up to the highest
> numbered argument that uses ARG_PTR_TO_BTF_ID and may therefore be less than
> five arguments long. It usually points at a BTF_ID_LIST. Second, check_btf_id
> is a function pointer that is called by the verifier if present. It gets the
> actual BTF ID of the register, and the argument number we're currently checking.
> It turns out that the only user check_arg_btf_id ignores the argument, and is
> simply used to check whether the BTF ID has a struct sock_common at it's start.
> 
> Replace both of these mechanisms with an explicit BTF ID for each argument
> in a function proto. Thanks to btf_struct_ids_match this is very flexible:
> check_arg_btf_id can be replaced by requiring struct sock_common.
> 
[ ... ]

> @@ -4002,29 +4001,23 @@ static int check_func_arg(struct bpf_verifier_env *env, u32 arg,
>  				goto err_type;
>  		}
>  	} else if (arg_type == ARG_PTR_TO_BTF_ID) {
> -		bool ids_match = false;
> +		const u32 *btf_id = fn->arg_btf_id[arg];
>  
>  		expected_type = PTR_TO_BTF_ID;
>  		if (type != expected_type)
>  			goto err_type;
> -		if (!fn->check_btf_id) {
> -			if (reg->btf_id != meta->btf_id) {
> -				ids_match = btf_struct_ids_match(&env->log, reg->off, reg->btf_id,
> -								 meta->btf_id);
> -				if (!ids_match) {
> -					verbose(env, "Helper has type %s got %s in R%d\n",
> -						kernel_type_name(meta->btf_id),
> -						kernel_type_name(reg->btf_id), regno);
> -					return -EACCES;
> -				}
> -			}
> -		} else if (!fn->check_btf_id(reg->btf_id, arg)) {
> -			verbose(env, "Helper does not support %s in R%d\n",
> -				kernel_type_name(reg->btf_id), regno);
>  
> +		if (!btf_id) {
> +			verbose(env, "verifier internal error: missing BTF ID\n");
> +			return -EFAULT;
> +		}
> +
> +		if (!btf_struct_ids_match(&env->log, reg->off, reg->btf_id, *btf_id)) {
> +			verbose(env, "R%d has incompatible type %s\n", regno,
> +				kernel_type_name(reg->btf_id));
The original log has the expected kernel type also which will be a useful info.
It could be a follow up.

Acked-by: Martin KaFai Lau <kafai@fb.com>
