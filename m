Return-Path: <bpf+bounces-7502-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DED77838B
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 00:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376211C20D14
	for <lists+bpf@lfdr.de>; Thu, 10 Aug 2023 22:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFDE25148;
	Thu, 10 Aug 2023 22:18:32 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DBA22F02
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 22:18:32 +0000 (UTC)
X-Greylist: delayed 1951 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Aug 2023 15:18:31 PDT
Received: from mx0b-00206402.pphosted.com (mx0b-00206402.pphosted.com [148.163.152.16])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B1EA
	for <bpf@vger.kernel.org>; Thu, 10 Aug 2023 15:18:31 -0700 (PDT)
Received: from pps.filterd (m0354654.ppops.net [127.0.0.1])
	by mx0b-00206402.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37AMAdqC022278;
	Thu, 10 Aug 2023 22:18:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crowdstrike.com;
	 h=message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=default;
	 bh=uNDn6UT46pxNe/15es5z5+yt17g05049oB8dBb1m9wU=; b=TUgWppuSy3y/
	61DIjbFxu+lV0+tQ7b54Ctw6kPO1zlb0d/plfoku0aVluSXG+x6UI8cPqOt7LPla
	OLV8MtE0xnTxE6v3f0XYCOraKCEpt4v+/4Rv8UvhB0EirJDK7W8i1chQl/D0zsBP
	Lpx63TomTKb67tkwKEmEI45HWz0oD2X4s9U3RCHJNaYsPDVCkwDncjJifPdBf51n
	wuAuJirGWUFkJMK+MDBXS+6NEBo6YyfAmGIhkeUgQKoFgQSx4LWEaaegIyzChZCG
	qx9p1aqhl9gLNttxmxRjXa8rscFj8BSO9nXmWLaa8R2oW/268ISx7rVQDm08T3bL
	WFvBz5uEzA==
Received: from 04wpexch06.crowdstrike.sys (dragosx.crowdstrike.com [208.42.231.60])
	by mx0b-00206402.pphosted.com (PPS) with ESMTPS id 3sd3dmrsbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Aug 2023 22:18:27 +0000 (GMT)
Received: from [10.102.42.42] (10.100.11.122) by 04wpexch06.crowdstrike.sys
 (10.100.11.99) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.16; Thu, 10 Aug
 2023 22:18:26 +0000
Message-ID: <674989d5-abc1-60fb-64ea-da25d24f935e@crowdstrike.com>
Date: Thu, 10 Aug 2023 15:18:25 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next] libbpf: set close-on-exec flag on gzopen
Content-Language: en-US
To: <bpf@vger.kernel.org>
CC: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Marco Vedovati <marco.vedovati@crowdstrike.com>
References: <20230810214350.106301-1-martin.kelly@crowdstrike.com>
From: Martin Kelly <martin.kelly@crowdstrike.com>
In-Reply-To: <20230810214350.106301-1-martin.kelly@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.11.122]
X-ClientProxiedBy: 04WPEXCH10.crowdstrike.sys (10.100.11.114) To
 04wpexch06.crowdstrike.sys (10.100.11.99)
X-Disclaimer: USA
X-Proofpoint-ORIG-GUID: 5i-vkjPWXWdj1cNLOJq98uKg-FMX9pBu
X-Proofpoint-GUID: 5i-vkjPWXWdj1cNLOJq98uKg-FMX9pBu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_16,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 priorityscore=1501 mlxlogscore=932 malwarescore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308100192
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/10/23 14:43, Martin Kelly wrote:
> From: Marco Vedovati <marco.vedovati@crowdstrike.com>
>
> Enable the close-on-exec flag when using gzopen
>
> This is especially important for multithreaded programs making use of
> libbpf, where a fork + exec could race with libbpf library calls,
> potentially resulting in a file descriptor leaked to the new process.
>
> Signed-off-by: Marco Vedovati <marco.vedovati@crowdstrike.com>
> ---
>   tools/lib/bpf/libbpf.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 17883f5a44b9..b14a4376a86e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -1978,9 +1978,9 @@ static int bpf_object__read_kconfig_file(struct bpf_object *obj, void *data)
>   		return -ENAMETOOLONG;
>   
>   	/* gzopen also accepts uncompressed files. */
> -	file = gzopen(buf, "r");
> +	file = gzopen(buf, "re");
>   	if (!file)
> -		file = gzopen("/proc/config.gz", "r");
> +		file = gzopen("/proc/config.gz", "re");
>   
>   	if (!file) {
>   		pr_warn("failed to open system Kconfig\n");

Sorry for double-sending the patch; the first was missing the bpf-next 
prefix and I wasn't sure if that would be an issue. Feel free to ignore 
this patch, as the other already got a reply.


