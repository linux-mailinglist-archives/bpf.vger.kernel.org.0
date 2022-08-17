Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0B597662
	for <lists+bpf@lfdr.de>; Wed, 17 Aug 2022 21:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbiHQTXB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Aug 2022 15:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238953AbiHQTW5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Aug 2022 15:22:57 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2985A405E
        for <bpf@vger.kernel.org>; Wed, 17 Aug 2022 12:22:55 -0700 (PDT)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27HHrPoC032397;
        Wed, 17 Aug 2022 12:22:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=m9pEhhPWO49yg6/YXv4UA9ZWQ92fj950yKGXTE0luiU=;
 b=NP852h1UWMT6sgvlOIoN04Q4Lz9/WbKjJqzCdP7b2MRguiq8496hkitgcwUfFXKu1McI
 QyUVJrttjNjTlo1onFe1Cdd+hYEqtv3xMCe5FjpGSmawPQbCf2FG3/qHOH+FSyqU0o9L
 fzWrgRdUgmlRPPytCXK+rJd5sgB3CmNozx0= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3j0npd5m2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 Aug 2022 12:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWHTikwCrq9LCv5HhtgG5gjJXjr6vo4yZ+MYkjzVNEj9NLCTDVY5UeKm17c6u0HV7Sc1T/v9o0WlZkkbDN6f2bjz1sza4UBp87lqwgdzVspz44G5WgXCvsii0a9PVnNz52p6QL+AOZfrlHC1ZRqdNrRtw8+RjIkupTyt3WgkMrJ86oXmWbk36CPd+dB1my/2xwmhRICPs06aUyF0dOIKSPR7zxknW8vIDGGOpUZwpo/nTExUsS4u6nXmhg+7453k1q3uP72kSt5lMbN1nE1A/IdS/WvoJGyVJjCUsAd+0XdVLfFm9V6Kae6nHsu4hMMY8FWU56Iy1zXQL+QrOoBnZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m9pEhhPWO49yg6/YXv4UA9ZWQ92fj950yKGXTE0luiU=;
 b=AQ31vfmUGXuvy3k8PN2qifkTIKOuKnxjgm5DLNuN9u7nMepOqlcmumNrEU/dQNSfdN82wYgicNfsyVIBgsyECJoPK1cJpZ3UIuUFSYFU5MJ70whHp6y1TF8feSLilgmPOPEFLKXFJUhnWSQZ0RObq5wB7KCheVUIekkF2J4I/kCq4QDg9/G6QxHl1Yl6225D4/vjvvr1pQvgYSmsEHgx3s/EBcBffaVjNh6LdsSVz4G8b8f1iNNbDCX2QbDYRaxV1AzedV/+d3q4BDEICpp65BS9gVaxyT8NX+CMt+dAbmw2iLi+DYctaeqW8BQRZUCKmIAiMC3ayuRA77r8dPxi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BY5PR15MB3553.namprd15.prod.outlook.com (2603:10b6:a03:1b6::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.19; Wed, 17 Aug
 2022 19:22:37 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5525.019; Wed, 17 Aug 2022
 19:22:36 +0000
Date:   Wed, 17 Aug 2022 12:22:35 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Introduce
 cgroup_{common,current}_func_proto
Message-ID: <20220817192235.u3e45w2wmnxt4xlb@kafai-mbp>
References: <20220816201214.2489910-1-sdf@google.com>
 <20220816201214.2489910-2-sdf@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816201214.2489910-2-sdf@google.com>
X-ClientProxiedBy: BYAPR21CA0030.namprd21.prod.outlook.com
 (2603:10b6:a03:114::40) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20f49d45-6003-45e6-56c4-08da8085d7e4
X-MS-TrafficTypeDiagnostic: BY5PR15MB3553:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4jX+LG8llkjZ9g+0x2+P3jDJmyxkYT+T6dHLfRIUKHrC1bBFLD/EcvApYm/9ek0S3CwuBTkZ1Mgmf+BhkuxmtDe6cd3MhGKXZbz2GezGvnYRkkDhhvh1tecpCXcwPMpz0K8OW3KQOMm99XJgX4kDgyf4+d2aZ7RLv7bODBn3FQY/Xfct1jJWImR22Y0Z7NAAeI5ZmLf+I4OSMh7pB9rAgukJUaPK8h009KRQAVWlGFgylgDoPM3/8MKVFbQRAt2OeEboN49ztNf2j0iUhLLRSrnuylDzm98F/lgDMmjmM0SEONrzYdkwxlCXXSUX9JYpHZrGwKgAJpr2k6s12dU7GeVoxy7NfrDZW5pyR4+6AXSq6jmGCs8ErvsKi7rYNmYBtyet/JWDIbZ0nnX1gIGh6uKkiipXei7x1VC1EWdltobbim4y3du6/D+MYVmHILjmoi/+gW3vuiCOPfjAdZ8KQ6WxnwbzALtwlEo95cqQYTlpZmM/6eh6+XOzbdLZh6DvCaP9LsSnWG77NgIMrJBwvTUKscC78IhiqHuNrgij21UErOsmAY/50po66twVUG8nVY9qO+RPyj7sLc9SEs8QWwNtRzASwaq9SnVI5m907E0viMdLDSpSjRL0FdPuCZW3xbQ/0kJI7ls9h/v6b3VPuO0jbu+ybgAGu6+ho7FXaoTgTGHdAy3VQREQwZqiKJR/u5HAhe9JNEwKOUQsN3KfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(6506007)(86362001)(41300700001)(52116002)(6512007)(1076003)(9686003)(186003)(478600001)(6486002)(33716001)(8676002)(4326008)(2906002)(66556008)(66476007)(316002)(6916009)(66946007)(5660300002)(38100700002)(8936002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N6FTNc/XryzSqmu0MwSwvZO9qJXyJI2YxJePAWG3GoPMwOhOuK3vIvt4SPBU?=
 =?us-ascii?Q?1yOi9fysF3mrMPCZ5UK+ES+xzvYlaAknDD37EvSPfkUXORUkl1upHSHXl+r/?=
 =?us-ascii?Q?qAzlAyJdUfr00WOyI+bqhZfPn1RPL0Xe/k1p8smPKfNhO3A1oBTuv0AAZlcf?=
 =?us-ascii?Q?a3HA3X9Oj4bMpWWEUzvWEwzWVTToPRRqOvZlG4laWiQKSzBTrZxDwYUzXpnm?=
 =?us-ascii?Q?Kr5lpziBCWDUMZ97rEo1guym0phh1irTgupMvcQwF1ABq15DqGpQz7mSRQ3a?=
 =?us-ascii?Q?X8ebl6zQ9GKnX/TVTaGPYEtDQ0ZkWRUAoRQoZ1E0iD61Zy02j7pkvS3BBZY3?=
 =?us-ascii?Q?ZT45h0kQ5u7zWRke5iqaxOt7DTdTiSmgab7sbyNgWgrsovQ9TE1QNB8RoOHq?=
 =?us-ascii?Q?L2Q0X83ztLuzcNjn1aKu3KEhBqfoFgV4w9WHoiF2KPiGdmSh3RTFL9K8c1ko?=
 =?us-ascii?Q?2Zwj34zL1pdPO7PfWt/Pa5K+DP2+5/uzgA+Emm3KpYbYtZcJsYu3Jk4ot3pJ?=
 =?us-ascii?Q?MveACnkgsv9bUuTh0tDciOQ/Lj/N0zm60/nszo4FBH58selfpKONyNHIUakN?=
 =?us-ascii?Q?CHVv59foOP1tFWPXNLM4P0ibySzuODw9KkZUEB6SMcJXfDTwSOhDS32weanJ?=
 =?us-ascii?Q?5UvXVLw7SQk5lQ2iuzqo19zDG17jv7Z/FwrrFtEz5SxOOLI7yTsMoClurYrU?=
 =?us-ascii?Q?Te48cr4x9S9JANC0QBOs9FPsVRp1zWTA7Jy12t6Mhv/HxjR3FA1n8ovPQNJa?=
 =?us-ascii?Q?jU8N7vnDfA/amf4qfUkfdEDiltUjSAfz2/C4zi5VnAivNETXQKfp/O0wScGR?=
 =?us-ascii?Q?hN1nX01F5ysmqrh8FWzEwP3rON8Swgn46tp4hKoTjCjrfTVR3f0Ny2GrxnR2?=
 =?us-ascii?Q?ktY5xSj5LTa+JJPgPOrBDdle88D6oTvrzrtNiToFWsCMUtsob7qbBEfE5lK2?=
 =?us-ascii?Q?Lp62xViJN+pwOB0zfZW3Anl/GYz7f+eo+c9zWMsSguHhdxmTTFxj8FmJjTRY?=
 =?us-ascii?Q?NxttV5Asv1h91wzFBCwXGxbUSdOEv0zASO9F38o/Q2DKhUjD3UFnSZy+HXVv?=
 =?us-ascii?Q?qz+GkTjgHdrDxuB8TRRVcChYEmniJC/bUYkA4QHoQQSk0acSzvppc5y/tEzO?=
 =?us-ascii?Q?j6NHcqTNaptawWh5ZyNSP0wGpqBvRG8sO1xuREwrEHJAX8plx942tZNrkKma?=
 =?us-ascii?Q?cJH9CvWtYmgzI3gZ+JL0Sb0/iORR2WnnVAVe8ec+TqIVv7b+mABZBg7LGxpE?=
 =?us-ascii?Q?VqHnT7IszZHBFXzkq03TvcDu5PCiQjcWduqIgaGIeSy2txO5G9YyVa9aayz1?=
 =?us-ascii?Q?JYnAx6J1jdkE2dqApUzOUmCaHLLBn8d73+K+XoacnBWKpVbExOs3I0bG86lL?=
 =?us-ascii?Q?r/UzEp1dPqOPNRGX55Ouj7LJpTqiGsNAUSXvMVLIFYLUYTxH/jSGvFhd5AKm?=
 =?us-ascii?Q?R+tiD/kIVxNQmaqAl7O98JGECp0YjI5et2V1kE8wV3x4v/D/L/rz4YzUdkGI?=
 =?us-ascii?Q?0YwKVFQ+u8cbLN3utIPPoW7WNItbyuoDY0c6ISC+Az/6JnX2P+aJMZoFRKeq?=
 =?us-ascii?Q?lu28AbCPaplRrNrtp74KfF2YmuhxPAWq2JXRm+eokbJJdx9Sn1IRNEAIJ/4o?=
 =?us-ascii?Q?Uw=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20f49d45-6003-45e6-56c4-08da8085d7e4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2022 19:22:36.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iUviw7SPDPWu1nxnIgwHkJp1w7OHtIQRS/BrqtJvMVaGSk7HvjDDwwBxgmPGl6JI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3553
X-Proofpoint-GUID: pKuMbu5VPl_323TvamQEq7049Uy292C9
X-Proofpoint-ORIG-GUID: pKuMbu5VPl_323TvamQEq7049Uy292C9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-17_13,2022-08-16_02,2022-06-22_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 16, 2022 at 01:12:12PM -0700, Stanislav Fomichev wrote:
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index a627a02cf8ab..c302d2de073a 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1948,6 +1948,10 @@ struct bpf_prog *bpf_prog_by_id(u32 id);
>  struct bpf_link *bpf_link_by_id(u32 id);
>  
>  const struct bpf_func_proto *bpf_base_func_proto(enum bpf_func_id func_id);
> +const struct bpf_func_proto *
> +cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
> +const struct bpf_func_proto *
> +cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog);
>  void bpf_task_storage_free(struct task_struct *task);
>  bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
>  const struct btf_func_model *
> @@ -2154,6 +2158,18 @@ bpf_base_func_proto(enum bpf_func_id func_id)
>  	return NULL;
>  }
>  
> +static inline const struct bpf_func_proto *
> +cgroup_common_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	return NULL;
> +}
> +
> +static inline const struct bpf_func_proto *
> +cgroup_current_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	return NULL;
> +}
> +
There two new functions are implemented in cgroup.c which only compiles with
CONFIG_CGROUP_BPF.  I think the change in bpf.h here should be done in
bpf-cgroup.h instead.  Otherwise, the changes in filter.c in the next patch will
have issue in resolving these functions when CONFIG_CGROUP_BPF is not set.

> -#define BPF_STRTOX_BASE_MASK 0x1F
> -
> -static int __bpf_strtoull(const char *buf, size_t buf_len, u64 flags,
> -			  unsigned long long *res, bool *is_negative)
> -{
> -	unsigned int base = flags & BPF_STRTOX_BASE_MASK;
> -	const char *cur_buf = buf;
> -	size_t cur_len = buf_len;
> -	unsigned int consumed;
> -	size_t val_len;
> -	char str[64];
> -
> -	if (!buf || !buf_len || !res || !is_negative)
> -		return -EINVAL;
> -
> -	if (base != 0 && base != 8 && base != 10 && base != 16)
> -		return -EINVAL;
> -
> -	if (flags & ~BPF_STRTOX_BASE_MASK)
> -		return -EINVAL;
> -
> -	while (cur_buf < buf + buf_len && isspace(*cur_buf))
> -		++cur_buf;
> -
> -	*is_negative = (cur_buf < buf + buf_len && *cur_buf == '-');
> -	if (*is_negative)
> -		++cur_buf;
> -
> -	consumed = cur_buf - buf;
> -	cur_len -= consumed;
> -	if (!cur_len)
> -		return -EINVAL;
> -
> -	cur_len = min(cur_len, sizeof(str) - 1);
> -	memcpy(str, cur_buf, cur_len);
> -	str[cur_len] = '\0';
> -	cur_buf = str;
> -
> -	cur_buf = _parse_integer_fixup_radix(cur_buf, &base);
> -	val_len = _parse_integer(cur_buf, base, res);
> -
> -	if (val_len & KSTRTOX_OVERFLOW)
> -		return -ERANGE;
> -
> -	if (val_len == 0)
> -		return -EINVAL;
> -
> -	cur_buf += val_len;
> -	consumed += cur_buf - str;
> -
> -	return consumed;
> -}
> -
> -static int __bpf_strtoll(const char *buf, size_t buf_len, u64 flags,
> -			 long long *res)
> -{
> -	unsigned long long _res;
> -	bool is_negative;
> -	int err;
> -
> -	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
> -	if (err < 0)
> -		return err;
> -	if (is_negative) {
> -		if ((long long)-_res > 0)
> -			return -ERANGE;
> -		*res = -_res;
> -	} else {
> -		if ((long long)_res < 0)
> -			return -ERANGE;
> -		*res = _res;
> -	}
> -	return err;
> -}
> -
> -BPF_CALL_4(bpf_strtol, const char *, buf, size_t, buf_len, u64, flags,
> -	   long *, res)
> -{
> -	long long _res;
> -	int err;
> -
> -	err = __bpf_strtoll(buf, buf_len, flags, &_res);
> -	if (err < 0)
> -		return err;
> -	if (_res != (long)_res)
> -		return -ERANGE;
> -	*res = _res;
> -	return err;
> -}
> -
> -const struct bpf_func_proto bpf_strtol_proto = {
> -	.func		= bpf_strtol,
> -	.gpl_only	= false,
> -	.ret_type	= RET_INTEGER,
> -	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
> -	.arg2_type	= ARG_CONST_SIZE,
> -	.arg3_type	= ARG_ANYTHING,
> -	.arg4_type	= ARG_PTR_TO_LONG,
> -};
> -
> -BPF_CALL_4(bpf_strtoul, const char *, buf, size_t, buf_len, u64, flags,
> -	   unsigned long *, res)
> -{
> -	unsigned long long _res;
> -	bool is_negative;
> -	int err;
> -
> -	err = __bpf_strtoull(buf, buf_len, flags, &_res, &is_negative);
> -	if (err < 0)
> -		return err;
> -	if (is_negative)
> -		return -EINVAL;
> -	if (_res != (unsigned long)_res)
> -		return -ERANGE;
> -	*res = _res;
> -	return err;
> -}
> -
> -const struct bpf_func_proto bpf_strtoul_proto = {
This should be useful in general other than cgroup bpf.
It may end up moving back to helpers.c soon.
How about take this chance to add it to bpf_base_func_proto()
which already has another string helper bpf_strncmp_proto?

> -	.func		= bpf_strtoul,
> -	.gpl_only	= false,
> -	.ret_type	= RET_INTEGER,
> -	.arg1_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
> -	.arg2_type	= ARG_CONST_SIZE,
> -	.arg3_type	= ARG_ANYTHING,
> -	.arg4_type	= ARG_PTR_TO_LONG,
> -};
> -#endif
