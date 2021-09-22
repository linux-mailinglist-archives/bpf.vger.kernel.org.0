Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F35413F08
	for <lists+bpf@lfdr.de>; Wed, 22 Sep 2021 03:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbhIVBoM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Sep 2021 21:44:12 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:39650 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231297AbhIVBoM (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Sep 2021 21:44:12 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18LLEbjF019931;
        Tue, 21 Sep 2021 18:42:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=EO8EgsaNCalE7ElqTeO8I0WslRuoUYb8SzbnCjnPhqw=;
 b=RPUICmo6nhXJyTl12eHxxesuS5fwnZykYkAdpc/HUvfurDWbntl48ds6R1Pwkfi+Tfd4
 LzbQagpPlfib9urPKgLKiy8Q8PmuyPc5pr2jsClcVBDHLFUrNgwEQ08fG5gncv6A3Kru
 r6sxIRx+VakCTQUn7W2wmLcDMIxh1RWAVHs= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3b7q4w1d8t-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Sep 2021 18:42:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.173) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 21 Sep 2021 18:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTtiZmMj7q3qw+ioDiI6Jh3gcNkpX4VWya+IDMFRoXb81IUCdLVzQDVLnk5Uhxjz8QxsJ3+HkHhff1JUKRigPaWdfXObvaFYbmkmyKROD/OmgULbzUvOadsZkr56GA/obA95QSqPpLX5qhc53a51jNDfMWPrDO7BpuJXQuNfnIPx6syffEI6j7Ugm/PzzirrGMQfJnFL5cZ2DrdNiF+Z/iv+q8/vDgaSNeEKDuciKZMeQOio2mQPVVH0xl0viTxJzrQZ74IyC8WfA3hZtRJHOCSkWcembG4W0eqUcW4G7x9GdUHEHHuE+lZI/Ao3lGcbesEFKF4Snan2gA/YqYJXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=EO8EgsaNCalE7ElqTeO8I0WslRuoUYb8SzbnCjnPhqw=;
 b=FQwzWazIevwCAzCdYxLeS3U0zRgU0roLOdWM1RE/58zj+5ne272kBt8Kd/Cis+8nl2U7dDevKrnvJif2G0fP6YYnfqWJm548K2o8rttPGfGd3x8tAb9OVEi8iDe3yZE9bdSR1VmRPV9+JPsbofdNfYsd9V7JzdHjBZCHALdIRUA1Wrei8GkH8j+BeVf4A9v7rqSWjWI/StFClsXgkRKkgdaXl4CxW3Z2myx8HyH/aj41K0bxiNFTw/S+oC7QuT053PHVWNlDxJ8UXbjcKOG1V6/vAMghSVupXoFaQ9RABeiEU9fYHUD7jnkkm3I6pM6/dsisZsG614PzOSytSewaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM6PR15MB2473.namprd15.prod.outlook.com (2603:10b6:5:8f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 22 Sep
 2021 01:42:28 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::94f2:70b2:4b15:cbd6%9]) with mapi id 15.20.4523.018; Wed, 22 Sep 2021
 01:42:28 +0000
Message-ID: <c4d6fa1a-182b-8cfa-7a53-374f97af4ecd@fb.com>
Date:   Tue, 21 Sep 2021 21:42:26 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.1
Subject: Re: [PATCH v2 bpf-next 7/9] libbpf: complete SEC() table unification
 for BPF_APROG_SEC/BPF_EAPROG_SEC
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>
CC:     <kernel-team@fb.com>
References: <20210920234320.3312820-1-andrii@kernel.org>
 <20210920234320.3312820-8-andrii@kernel.org>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <20210920234320.3312820-8-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0248.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::13) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
Received: from [IPV6:2620:10d:c0a8:11c1::12b6] (2620:10d:c091:480::1:d228) by BL1PR13CA0248.namprd13.prod.outlook.com (2603:10b6:208:2ba::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.6 via Frontend Transport; Wed, 22 Sep 2021 01:42:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77ffc647-62d5-43ba-285c-08d97d6a3c35
X-MS-TrafficTypeDiagnostic: DM6PR15MB2473:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR15MB2473C8A946716145EF16093CA0A29@DM6PR15MB2473.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kiT15jT61Gz6r3i0y+faAMsPQkh0zKB4Lc1dbmt8BljmG67tY1SPKfkc0A68CbzgLl172luhMbgLbt1G0ggfn27sagA05PZnHhk98h54uaC9RpOgZBte2yaw6ovCB7BKpvIxQgs1trEvEwkiY7zOMu/oQUe8X1MY5Ntf0P/A69E2u9uEf+QaujGFyJN42BbE9ZYS2OkAbirJID1VHH3P3WkWiCDvUA9kHvlbzNAPunr0t054ty9tqaiuKeGL9R1Yx2/s+N2Yc5ilVdNsfMADBT6e2Rvz6T7SWnqhfJHVfL7teYm67+Jbx7ib+Mn4Nq0tgo9zfCa5SA+P9gY8f1NfLdIdXS7iiIFdDfaL1EYCeg3QIPgafAkxV9HTrI5FIWxmVe6Mo5H+YwlpGubZfLAE7n4KKTDoHPH32YjJeM21D/bNgk4GqSRjb6GU1JfjYhvMJOEzzoWQsARhHp7QLvgNy2l34IeVMxWX6m5X9nJL6Ial/OSRX7EVIKgO9EPIITBgqIb9GCJRQeAprIvUWh9N/GgK9cdRXPZsqp3TvRsdYV7hg7EXLFOemRWOMx2IRFGGj2SQAY0UCrc4gn7bXEdOL6xJv2eG5PpXH9TQxoyc+bhkvCYvEX4NCJHQrwxhT8sJr6PbFwVDsky03Bko+ldsVFz5aPLDgvj1bWulLG8pN3YXMudTZCA5bvKFRr8jfEA9LwDG26QqxNUzU7It1LKkt3EMB8EXVGs0uPP8y33Ms3c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6486002)(66556008)(186003)(2616005)(53546011)(66946007)(316002)(83380400001)(508600001)(86362001)(31696002)(2906002)(5660300002)(36756003)(31686004)(38100700002)(66476007)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmVLaGU3YTFCVDl0ZStZODhsb1czVU1jNG9CWG91M2xabXJLUWlHZjkybC9i?=
 =?utf-8?B?V0JzZ2s0LzJaNU5hWnNraVhzSG5OcXYwZlZaaitPeERYUE9wSVYwWlQ5bDdS?=
 =?utf-8?B?Z0gyZW1vVjdIdzc0YldCb3RMWm55S2N4aWM1empwTnphMGxXQ3F2dVdKL0t4?=
 =?utf-8?B?RnpwNGFLOWNYUTVPMk80SW5nU0tjZ0FzZTdGMGJlTk1QYzNRTmErNUpRSUt4?=
 =?utf-8?B?Y1lhTzRDS2lBZzB2cnJadFJzSGI0U3YvYjVqeXZhN254dUNMWEQxeEdjR2tZ?=
 =?utf-8?B?UisyblYzampJYmFmUkdyNEpDc1JubGs1MklqVEt0OTd4OC9PaWg3MXhoWUxa?=
 =?utf-8?B?MWNwZS9mRk9wSVJ2elloZmhMZGZvaUV1NUNzcDk4TmRKN3BTakp6blN5NVBJ?=
 =?utf-8?B?ZCtvRHpxRGF3WGY2NGdMNUlvbU1XQUFyRnFxTmVETGd0cVRwQ0Z1WE5mRUMr?=
 =?utf-8?B?VDVZQTNiUzJvdTc0TVhnMm5OU1BFUHkzd0lBTGV5Q09DbitqbnhNbnlUd2pM?=
 =?utf-8?B?b1ZUdjRmcU1IV3dpN3o1bEFmZjVQbzJuZExHL1F6TVprTHgxb2ZvMEUrNGF6?=
 =?utf-8?B?T09KMS9jQkF0Z0tnb0lvaFREZUdDUFN6bmZteEltRkE5U2hOT3lqazlWVkRV?=
 =?utf-8?B?bXJyZUtmN2xid3o1LzZySVJFZ0NmTldpb2ZRQmZsRjRneHJyaGVVWXFIL210?=
 =?utf-8?B?bFJqUnRHV2lBTjlxOXVqZkkvUlVLRFJxS0hhcGJITGRFSGNEejJZS3U3MXd4?=
 =?utf-8?B?T28ycEZWaHBteTlKTXJSeXNSTmNUSnNvZmxVWjBrRXpON0J4SHd5THZTaGZQ?=
 =?utf-8?B?RlJUZTUydGNva1piQzgxL3ZXTzdaOFAvRkgyZlRLb1F1bmZvUThHQTltc0Yx?=
 =?utf-8?B?Y3ZLQTh0QUJnVWJCNHk1elU0WnNTY2NRcHdyRjlUM20rbXFmVEljeFZEYmF1?=
 =?utf-8?B?b2RsQWloRGphdFpyaTBwZiszSVpOWnlweTNNdzNWUzBONkp2M203RkhTZXNJ?=
 =?utf-8?B?QmV5bTRNVkVzYlRSZWMwVWxza3BScU5GamtUWU9JK3hEcjJQWnlGSkFGY1lZ?=
 =?utf-8?B?bDNPejQ3aGkyNno2VnpUL3Irb2RSbDhwNjBIZDVXU01STmtmRVNUbkZOLzZF?=
 =?utf-8?B?ZFhVWXRjeUQwdjMyN0lGdyswNUZPdXVIOEFPbGQ0Vnh3MThwb0xvb0lRQjJF?=
 =?utf-8?B?ZnN2enlhREFZaEFXamJZUDM4S3c3U0wzdWpUdmNvb3RHYUE5cmE1R244RGJG?=
 =?utf-8?B?NkxmSGtqbkpnWmtpaWhJNmdnT0EySU0yOVlIMmhjb2grRWdvMFEyQjRRdUZo?=
 =?utf-8?B?bjc0SE9mc1FOczQ1OEVtamxnLzZoekp6UXlBWC95RlRuaS9OVjlYdHN3bmx4?=
 =?utf-8?B?TnNkNTJsMlJGSFpnSHo2dkQ2ZnZOWktIS1JKMCsxWlE1MFJxdXgyVGNLSHBz?=
 =?utf-8?B?ZEV4dlljMU5hVXhMYnltcld5Z093dDBQL3FHbTNZcEV3UG5UMmtZdWF1SkM0?=
 =?utf-8?B?VkMrcjltMmNQcTJMZTRkazhiOGZtTlF5MUpvdzc4Smhnc3dMUUtSMGhwZC9M?=
 =?utf-8?B?d2drMW96QXZwV2Q4LzFPenE5U3RXejdtMjJFaDQ4STZBcTdjTEtoQm0wbVFl?=
 =?utf-8?B?eWNLdXc4QWVZWHB0SmdZaFFMU1FhYkcxTytFTEQ0N2g5VjhYN1hXOXlGTi9X?=
 =?utf-8?B?ZFVVeERuVXByM0NqNDNDRWRkRlVQZGsxeGhWd3I2YVBWQnNxdDJWcEk1OGlw?=
 =?utf-8?B?MUNLR2FmcDdrakQzUm8vYVVIeXZoalpDSTllU2Ird0paZ0xEN0tDVHJTbHdY?=
 =?utf-8?B?cGpYbVl6a2dac1k5UmhCdz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77ffc647-62d5-43ba-285c-08d97d6a3c35
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2021 01:42:28.1221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3froZZWpDHaCbJJj7/EqkUwM+zD40BOVhvHdTWMSjvHFygfe7ampCi9+/myjpqfEPuAxAiGIugOBiyjEfwSkhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2473
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: U7dMJl4MhxVr7T_Pto76kCJxBub_mgSF
X-Proofpoint-ORIG-GUID: U7dMJl4MhxVr7T_Pto76kCJxBub_mgSF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-21_07,2021-09-20_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109200000 definitions=main-2109220008
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 9/20/21 7:43 PM, Andrii Nakryiko wrote:   
> Complete SEC() table refactoring towards unified form by rewriting
> BPF_APROG_SEC and BPF_EAPROG_SEC definitions with
> SEC_DEF(SEC_ATTACHABLE_OPT) (for optional expected_attach_type) and
> SEC_DEF(SEC_ATTACHABLE) (mandatory expected_attach_type), respectively.
> Drop BPF_APROG_SEC, BPF_EAPROG_SEC, and BPF_PROG_SEC_IMPL macros after
> that, leaving SEC_DEF() macro as the only one used.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 136 +++++++++++------------------------------
>  1 file changed, 35 insertions(+), 101 deletions(-)
> 
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 734be7dc52a0..56082865ceff 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -7959,32 +7959,6 @@ void bpf_program__set_expected_attach_type(struct bpf_program *prog,
>  	prog->expected_attach_type = type;
>  }
>  
> -#define BPF_PROG_SEC_IMPL(string, ptype, eatype, eatype_optional,	    \
> -			  attachable, attach_btf)			    \
> -	{								    \
> -		.sec = string,						    \
> -		.prog_type = ptype,					    \
> -		.expected_attach_type = eatype,				    \
> -		.cookie = (long) (					    \
> -			(eatype_optional ? SEC_EXP_ATTACH_OPT : 0) |   \
> -			(attachable ? SEC_ATTACHABLE : 0) |		    \
> -			(attach_btf ? SEC_ATTACH_BTF : 0)		    \
> -		),							    \
> -		.preload_fn = libbpf_preload_prog,			    \
> -	}
> -
> -/* Programs that can be attached. */
> -#define BPF_APROG_SEC(string, ptype, atype) \
> -	BPF_PROG_SEC_IMPL(string, ptype, atype, true, 1, 0)
> -
> -/* Programs that must specify expected attach type at load time. */
> -#define BPF_EAPROG_SEC(string, ptype, eatype) \
> -	BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 1, 0)
> -
> -/* Programs that use BTF to identify attach point */
> -#define BPF_PROG_BTF(string, ptype, eatype) \
> -	BPF_PROG_SEC_IMPL(string, ptype, eatype, false, 0, 1)
> -

Similar thoughts about comment usefulness as patch 6.

>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {			    \
>  	.sec = sec_pfx,							    \
>  	.prog_type = BPF_PROG_TYPE_##ptype,				    \
> @@ -8003,10 +7977,8 @@ static struct bpf_link *attach_iter(const struct bpf_program *prog, long cookie)
>  
>  static const struct bpf_sec_def section_defs[] = {
>  	SEC_DEF("socket",		SOCKET_FILTER, 0, SEC_NONE),
> -	BPF_EAPROG_SEC("sk_reuseport/migrate",	BPF_PROG_TYPE_SK_REUSEPORT,
> -						BPF_SK_REUSEPORT_SELECT_OR_MIGRATE),
> -	BPF_EAPROG_SEC("sk_reuseport",		BPF_PROG_TYPE_SK_REUSEPORT,
> -						BPF_SK_REUSEPORT_SELECT),
> +	SEC_DEF("sk_reuseport/migrate",	SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT_OR_MIGRATE, SEC_ATTACHABLE),
> +	SEC_DEF("sk_reuseport",		SK_REUSEPORT, BPF_SK_REUSEPORT_SELECT, SEC_ATTACHABLE),

Ah, I see that after this patch the alignment issue from patch 6 is better.
Nevermind then.

>  	SEC_DEF("kprobe/",		KPROBE,	0, SEC_NONE, attach_kprobe),
>  	SEC_DEF("uprobe/",		KPROBE,	0, SEC_NONE),
>  	SEC_DEF("kretprobe/",		KPROBE, 0, SEC_NONE, attach_kprobe),

[...]

> +	SEC_DEF("sk_skb/stream_parser",	SK_SKB, BPF_SK_SKB_STREAM_PARSER, SEC_ATTACHABLE_OPT),
> +	SEC_DEF("sk_skb/stream_verdict",SK_SKB, BPF_SK_SKB_STREAM_VERDICT, SEC_ATTACHABLE_OPT),

checkpatch really doesn't like the lack of space after comma here, I agree
with it.

>  	SEC_DEF("sk_skb",		SK_SKB, 0, SEC_NONE),
> -	BPF_APROG_SEC("sk_msg",			BPF_PROG_TYPE_SK_MSG,
> -						BPF_SK_MSG_VERDICT),
> -	BPF_APROG_SEC("lirc_mode2",		BPF_PROG_TYPE_LIRC_MODE2,

[...]

