Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5C3588778
	for <lists+bpf@lfdr.de>; Wed,  3 Aug 2022 08:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbiHCGh5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Aug 2022 02:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236844AbiHCGhz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Aug 2022 02:37:55 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D245E4332F
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 23:37:54 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2731W0Tu016623;
        Tue, 2 Aug 2022 23:37:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Z1wBzIVU3LuGFLBRwvX6ad5y7gzqmxPxwiTtAkPQHaU=;
 b=kPL/gLsHEGHig//Mo97Q5qGyBuMWw/4ZaNI8RHcg97N9HbxC6yTAMituMb9q+2UcuKxf
 Ivdtrd8HanUT94UxAOUBCQRIDXVSiGH0B9qxr0d+x/10omD9e96k9x9YVHoHKf7omm8n
 6x8bThT6dyDtN8PNjqpWoMTY+lbqe+Kh/k8= 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hqfeb121a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Aug 2022 23:37:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=moBev22Y8RgOPv2teqQXFOCsriw/Nf+7LQ1zOAq4mt+raJTMIXVN9CHttZSE65SiMVb8W3BXk4blQO+Hwjl7leZLw7fJaPoiy+6dIiaYKSP3hFPm8HFjaTtwpdypHgvFaSIL5WswGy4pvbubV/LCDvI+s2sWOMjHKsNYwgswmC2RlY2gFjXxSNTpYCSj/7QM3OrnZWq6A5GJoeLIhIkLSlmW854vMakTiyK2dtr6Er3+JWJaoZivT5N/7etQ0Ym6kIv+jE04Q3vYOKdDfjXuJgjPlZ4yEL/oE5zZEy0qQmVn03aRM2EWlpdaVPAVW0sOozC3+qkAFFFyFa8RcfUtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1wBzIVU3LuGFLBRwvX6ad5y7gzqmxPxwiTtAkPQHaU=;
 b=L3fulipgtiN8qHjrWOjBbJEApg7gTJ1dFZCGIDQWUwqsug2bVtazqJ/1HAwIAKeOhLv9tMd09pxuAckDz79ZXhUt7Bp7/Vr7unMiYVXKtWti4LxqT64JDROuE4GX1tbyb9mJKwqiMvm1Ty1ZsFUsmbY8nMU7kXpggfyMRFWnsMF8D2+KocRjN1LQa2CWu7siFfiALHJcBvUt4q+lMhsthwgTTIiJg+hReiGPBiCHS2l+xWGnGvc1nufYu99LydTQpKZK99rxioFcLMceVSeUg3RhDt/s5CslDm3EXWxsyWfqFGmv5VDxMqr3Rms0PlUEAKjJoHGGN+ZYYq99Kx83ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by DS0PR15MB5399.namprd15.prod.outlook.com (2603:10b6:8:cd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Wed, 3 Aug
 2022 06:37:37 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%4]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 06:37:37 +0000
Date:   Tue, 2 Aug 2022 23:37:34 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        ast@kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220803063734.ok4a7m3umqa6zzsa@kafai-mbp.dhcp.thefacebook.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
 <20220726184706.954822-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220726184706.954822-2-joannelkoong@gmail.com>
X-ClientProxiedBy: BYAPR05CA0074.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::15) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 827fb7ce-508d-42b9-f20b-08da751aa7d7
X-MS-TrafficTypeDiagnostic: DS0PR15MB5399:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UmocboyMFMn8tX9AI+hHYMTPy70BDcy8UbeYMDuXNG7gI5jsJpvJ23CKLtS0VcXgOsv/j/A+KSI3AsEwR4yXQbzP1qdzGTUHpMWhXLgSOEbvAWOm2hdGR5YNt6tur7Cd+EbqKKUIkhhcbuaiB5SsPZ2W/arG3Cav2PCD3KOuTmPKgiAoUGtaqI0QW37AWQ/JwswhbKK39J2ktCFaLwP733aSm8qIAy7hirZYVW/wtfhMHf/4TQg0f9Mhqfik86RRLvwD83zrdGC7LrNFxi/5yXRuMWBvow3d/hIM3xjC9ouBa0+20lp/Pizpa4rW/mEDIUpQtPjrhXvoqoV+uNJ//kMlYWIwy2kBnJjLHxDimjhzdeCCZfZpU4DAlyobEf0HczZp4IBwp0ljO0f8//ZGp/bept0gDKHD5xtZFDwZNS4dcmtaJlrZdv8X7xEzdLJLhb+v2t0adFWZP9rMaAUNVRQyWWrfnxVORkHSfExwPTKq5rFzVXuAm7b4yPAJ0hSC+xGfSq92eaURz55Skmvf/AW70YdQeYvbaGy8ZLTBynG8uNJ2aKGZcsqgpAhnlFBpOB/k4mG4Un93yRhW/uZx3e10XkjGg86x1+3cz6o3Gh4+kw79rjxUUzH8dqdhEm82CQJmFgvwQWzj6jk+WP1XWhGO4RqxHPnWKNOp8x7dbCye/UtREQkQuSByQANb06PlyJ1BamXU2bhObZGeUQlmRyKyCivJXR2xnsI4/VScRIdgN7d7ZVRCBkUf7xNoCFnd
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(39860400002)(366004)(346002)(396003)(6916009)(316002)(6666004)(6512007)(6506007)(9686003)(52116002)(6486002)(41300700001)(478600001)(38100700002)(66556008)(86362001)(186003)(1076003)(83380400001)(66946007)(66476007)(4326008)(2906002)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Koq04bRHVa6in48MolPvMX4a/aSVaPKvz1w5RZ1fQSW7oCxpUPbU/SPyLUMS?=
 =?us-ascii?Q?SlMfazIuCcOHMW1IxCgAdISgOshMIt+LCYZRTQvau2jI6pyHPUl/23XWyaD5?=
 =?us-ascii?Q?7oCrsitV4cMqJLsT8ASm1nIa6GYlYqKZ+JQs98UaE1snwBsQGlLomPzin9Wg?=
 =?us-ascii?Q?G6Hj6CfWym8DBXO71CaEy5pg3Q8xviqfN1thTGBSsWfgtq1ybzjEJAcwcx7n?=
 =?us-ascii?Q?cah9PZg4bT8VdLEkeWjcExCLeXCKqzFK0NdrRGy8ybw85XYLRjhB8zURkdjc?=
 =?us-ascii?Q?cDHm5dV8FQVVCcq682d7DJm0hf4BMK8BDDcHdzk31T4vyWi9W3tYWeA/WMGH?=
 =?us-ascii?Q?ZG/nLgyn7O0SkheIoB9LdnmJ8SXm8Kgwx17ARSeCR+1qalh2zPNpdFaSuFf8?=
 =?us-ascii?Q?GLxbhjrI3UJQoPrHCT8YpjjA/fSOZp/hoNXHUPpRsZipFz3R1H/1QhhYbTUq?=
 =?us-ascii?Q?Y41spZku8ViDLlhlImavAIyI7Yvo7oY2V9t2gQEo8HoBLLnHMyXSSgrke7Wx?=
 =?us-ascii?Q?It95RgGzclQIUBXR421CaQn9Q/2RP/iqL35iJ38kYNDzzSFwMwJeCL4/cdUq?=
 =?us-ascii?Q?q2ac9SYT16idnh/7DtjoYGP0f+3HG8OwSw0mfK4RmWA6Vu9cZA4TQT/zqzeO?=
 =?us-ascii?Q?Lo0cAG8+VlunG/NOz828fvoY9JydscGbB+yerGMMbjMdc+dLl3BvYR04Iscp?=
 =?us-ascii?Q?Ih4gisHrk+CY5neDeCv8eqxxfAjBEgGGeGeQsAy3hGUCBw0bjf97oknbpVpE?=
 =?us-ascii?Q?Rg2A5iGYc9rxwv2gPd1R13hTog/ZxYRCohshBPJ6kGypt0H7BsmaGEKHmO4g?=
 =?us-ascii?Q?djM7B+lHzYTCLkttXnQzcEBx+ooucz9xs7fkO7lA0IgwQ1cBltJyg6YaLjR/?=
 =?us-ascii?Q?cseuclhTDZN9AVDa0+RWGCHGRcfloFwSU13KI7mHS1sGW2b9/88zu0X6ktJS?=
 =?us-ascii?Q?5R7l5fux2fZ77HYqTR2tx3SXtHT00HDROcWDNvAfGMUk55lcxiMhd0kHdBKL?=
 =?us-ascii?Q?7BLMo7ZEAXxO9cYjKa94UQKKmo+oTbV05mC1ubvbPAkOHZFE0dJX9xTB41CO?=
 =?us-ascii?Q?nj2ih7dM5h0Yczjc4CU02HCGrhA/hl7dyduJzcs/OMqGulleY7er2+f2Ry2V?=
 =?us-ascii?Q?QNJGX42awRX4hFmk+RjyjNOqy1v++Ut/JsUmtxIEtudyn07dri9dbQqz7sgh?=
 =?us-ascii?Q?ugVyfNQioXWn7aL84Yx/YFF0Zv7aMk4bFibF+AbsQLm7GQ79ugVdS1pE8+vS?=
 =?us-ascii?Q?ZAmo/yTtGZAjq228xnqNaKFdqetBbQ1d0EF/NaHzAiN3nMph/oaKamwMZkj4?=
 =?us-ascii?Q?pd/E7JA4LoVvvMYUndgzEvchdiULQMhC8MLy+/P4mIevohHEtIPgR/ujxkwV?=
 =?us-ascii?Q?nMkqmeszbU0grIhNKjBGdZxPoMEDK+AOsgC229GxPoVKe3VJt+GGs3jiwj/n?=
 =?us-ascii?Q?as1TqzE00bBCHMbdeTgoUQHIlgGKzrggg1jC9CBs/AoTAZ9JOHLiOgsr7b8m?=
 =?us-ascii?Q?skDTtgtgZzDI1bgBDtzRNehQZ6RDXBMV96YtyduLp07cp85BYKA9E/5MCQLV?=
 =?us-ascii?Q?7M4S6HNRulOKmwNe53NT8IKo/iZmvv3jhbkUULe1SJhtPda6r6ObsD9THUyy?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 827fb7ce-508d-42b9-f20b-08da751aa7d7
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 06:37:37.6267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYyiZQXw5dc1N1nv+B7Guxgv8x4rOs2dOX7Yl819/ULj0xDlPnvsfv4LU0Se1gEU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR15MB5399
X-Proofpoint-ORIG-GUID: MwsGxgZeiSkFjeA-jcxQTEXFXWXhIET9
X-Proofpoint-GUID: MwsGxgZeiSkFjeA-jcxQTEXFXWXhIET9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-03_03,2022-08-02_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 26, 2022 at 11:47:04AM -0700, Joanne Koong wrote:
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 59a217ca2dfd..0730cd198a7f 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5241,11 +5241,22 @@ union bpf_attr {
>   *	Description
>   *		Write *len* bytes from *src* into *dst*, starting from *offset*
>   *		into *dst*.
> - *		*flags* is currently unused.
> + *
> + *		*flags* must be 0 except for skb-type dynptrs.
> + *
> + *		For skb-type dynptrs:
> + *		    *  if *offset* + *len* extends into the skb's paged buffers, the user
> + *		       should manually pull the skb with bpf_skb_pull and then try again.
bpf_skb_pull_data().

Probably need formatting like, **bpf_skb_pull_data**\ ()

> + *
> + *		    *  *flags* are a combination of **BPF_F_RECOMPUTE_CSUM** (automatically
> + *			recompute the checksum for the packet after storing the bytes) and
> + *			**BPF_F_INVALIDATE_HASH** (set *skb*\ **->hash**, *skb*\
> + *			**->swhash** and *skb*\ **->l4hash** to 0).
>   *	Return
>   *		0 on success, -E2BIG if *offset* + *len* exceeds the length
>   *		of *dst*'s data, -EINVAL if *dst* is an invalid dynptr or if *dst*
> - *		is a read-only dynptr or if *flags* is not 0.
> + *		is a read-only dynptr or if *flags* is not correct, -EAGAIN if for
> + *		skb-type dynptrs the write extends into the skb's paged buffers.
May also mention other negative errors is similar to the bpf_skb_store_bytes()
instead of mentioning them one-by-one here.

>   *
>   * void *bpf_dynptr_data(struct bpf_dynptr *ptr, u32 offset, u32 len)
>   *	Description
> @@ -5253,10 +5264,19 @@ union bpf_attr {
>   *
>   *		*len* must be a statically known value. The returned data slice
>   *		is invalidated whenever the dynptr is invalidated.
> + *
> + *		For skb-type dynptrs:
> + *		    * if *offset* + *len* extends into the skb's paged buffers,
> + *		      the user should manually pull the skb with bpf_skb_pull and then
same here. bpf_skb_pull_data().

> + *		      try again.
> + *
> + *		    * the data slice is automatically invalidated anytime a
> + *		      helper call that changes the underlying packet buffer
> + *		      (eg bpf_skb_pull) is called.
>   *	Return
>   *		Pointer to the underlying dynptr data, NULL if the dynptr is
>   *		read-only, if the dynptr is invalid, or if the offset and length
> - *		is out of bounds.
> + *		is out of bounds or in a paged buffer for skb-type dynptrs.
>   *
>   * s64 bpf_tcp_raw_gen_syncookie_ipv4(struct iphdr *iph, struct tcphdr *th, u32 th_len)
>   *	Description
> @@ -5331,6 +5351,21 @@ union bpf_attr {
>   *		**-EACCES** if the SYN cookie is not valid.
>   *
>   *		**-EPROTONOSUPPORT** if CONFIG_IPV6 is not builtin.
> + *
> + * long bpf_dynptr_from_skb(struct sk_buff *skb, u64 flags, struct bpf_dynptr *ptr)
> + *	Description
> + *		Get a dynptr to the data in *skb*. *skb* must be the BPF program
> + *		context. Depending on program type, the dynptr may be read-only,
> + *		in which case trying to obtain a direct data slice to it through
> + *		bpf_dynptr_data will return an error.
> + *
> + *		Calls that change the *skb*'s underlying packet buffer
> + *		(eg bpf_skb_pull_data) do not invalidate the dynptr, but they do
> + *		invalidate any data slices associated with the dynptr.
> + *
> + *		*flags* is currently unused, it must be 0 for now.
> + *	Return
> + *		0 on success or -EINVAL if flags is not 0.
>   */

[ ... ]

> @@ -1528,15 +1544,38 @@ static const struct bpf_func_proto bpf_dynptr_read_proto = {
>  BPF_CALL_5(bpf_dynptr_write, struct bpf_dynptr_kern *, dst, u32, offset, void *, src,
>  	   u32, len, u64, flags)
>  {
> +	enum bpf_dynptr_type type;
>  	int err;
>  
> -	if (!dst->data || flags || bpf_dynptr_is_rdonly(dst))
> +	if (!dst->data || bpf_dynptr_is_rdonly(dst))
>  		return -EINVAL;
>  
>  	err = bpf_dynptr_check_off_len(dst, offset, len);
>  	if (err)
>  		return err;
>  
> +	type = bpf_dynptr_get_type(dst);
> +
> +	if (flags) {
> +		if (type == BPF_DYNPTR_TYPE_SKB) {
> +			if (flags & ~(BPF_F_RECOMPUTE_CSUM | BPF_F_INVALIDATE_HASH))
nit.  The flags is the same as __bpf_skb_store_bytes().  __bpf_skb_store_bytes()
can reject as well instead of duplicating the test here.

> +				return -EINVAL;
> +		} else {
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (type == BPF_DYNPTR_TYPE_SKB) {
> +		struct sk_buff *skb = dst->data;
> +
> +		/* if the data is paged, the caller needs to pull it first */
> +		if (dst->offset + offset + len > skb->len - skb->data_len)
> +			return -EAGAIN;
> +
> +		return __bpf_skb_store_bytes(skb, dst->offset + offset, src, len,
> +					     flags);
> +	}
> +
