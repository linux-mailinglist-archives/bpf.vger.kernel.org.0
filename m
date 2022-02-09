Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955A64AE5FF
	for <lists+bpf@lfdr.de>; Wed,  9 Feb 2022 01:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbiBIAZj (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Feb 2022 19:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiBIAZi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Feb 2022 19:25:38 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6371C061576
        for <bpf@vger.kernel.org>; Tue,  8 Feb 2022 16:25:37 -0800 (PST)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218N7cIK022280;
        Tue, 8 Feb 2022 16:25:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GVUObPhpz9tUrEXL7wW9TZ7r518FMiC369mXMigfuM0=;
 b=bEcqie1VlbcB/6PSai9gNdFL7y1Lg/T+3Exb5R4OylBozQedSMupgXW58pt7v/XH2YCh
 wcJ0ig+CN7r+bq4fseaihBMhjDA59bLHBUYlaKzEx5T7DgpsaFZ4zoaUMhOxrJazbqNG
 U5jSLkVKgG74WrpGK4D76XMwOz1Uf7A/be8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e3tybbxv8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Feb 2022 16:25:22 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Feb 2022 16:25:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4TrKpm7/s4Cm7A0ZivaJgUfrvE955+QYazSe3dcH0+2qn3nsOn1iNZ0bnD9ngceXfgczgXlz7AzCNnL3iqUB2GFoW94RoPWMGWPUSq7hpUJraXn14wTPj8RSobk7zoDfLi6rQWu2/1d3KB26XxnEgawbXEc7l4Lod12n0AYoZC45XS7W+H90wBX79dZted6/fk8qwuvTC4ru0vDa0ybeVA1lEwWqSHFC1nD/6WBEBkZM69wx4siKcdgeN4MphBoWySZEl+EfQrp5dT4+O61GpKMz5w6L6vIxEhdEQ5UnzTfRG8FJZqiNiIYK/PkjoCSXTqXo+djtxKArthkj1Z2wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVUObPhpz9tUrEXL7wW9TZ7r518FMiC369mXMigfuM0=;
 b=N7Cf0FzIEO3OulJqC3IsHraGJOXuvKxo4wo+bfsm9wmxtzluhKQNRR3Zhr4wVs9ZVVp9iSgHi0mTvBUa2SHFcaRiMyXA05q5BzOXK64hnQ0JZqklKG6M+tdrxRO3CnlSBSjhiDi4bNS+5TeD7SLHFNBx3fDB6rCWebIG8rNiD56l5KGhKz4N+ilxROXXTX8Nbxu3tzLlTXa87EWDHLL2Dwi8X8cHKztpEAV9uIF7ttEGX+I0upoB9Y4G6qySlwwCxVchX9L81zYBAutbZMxStFSlLDqyPkrznjHAbGkAEFVuYkOtlYM/I0LGnL7jye+ZGEuVkDjcGODyPB6IzzflvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3308.namprd15.prod.outlook.com (2603:10b6:5:16f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Wed, 9 Feb
 2022 00:25:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 00:25:19 +0000
Message-ID: <8a126b25-b8d0-3838-ecaa-0613c9e4894e@fb.com>
Date:   Tue, 8 Feb 2022 16:25:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH v2 bpf-next 3/5] bpftool: Generalize light skeleton
 generation.
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <davem@davemloft.net>
CC:     <daniel@iogearbox.net>, <andrii@kernel.org>, <bpf@vger.kernel.org>,
        <kernel-team@fb.com>
References: <20220208191306.6136-1-alexei.starovoitov@gmail.com>
 <20220208191306.6136-4-alexei.starovoitov@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220208191306.6136-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR15CA0033.namprd15.prod.outlook.com
 (2603:10b6:300:ad::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75c92fc9-bfd1-48af-4522-08d9eb62a742
X-MS-TrafficTypeDiagnostic: DM6PR15MB3308:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB330862F49F5FF3BF9E7B52B3D32E9@DM6PR15MB3308.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:22;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qH7I0VsQnEUF3zYb6HYS9y7JhIo5XJko2HmWZS3agY7mSJkJhB1NjLHIrQPKRUedfExTvl32s4ILNhbBqVXUJp7NVswC82ImcO2/6y544qnv3gYiptFm7xbqoT8UFnelLaAmLB9a85xiAhA15h+LjecoaOjYL2tJLfDUxcUNcXijVsQd7/7PwOlf9tpr43CmbA9Vtak8ceJfM1Z+vV1MN4QE+PJE6W+P2FZ4omUFl+pVrCzbsdkrWRWa7TjaY3n+nCgSc3+AswPLZ0rz2cu7oNYnoeIOm5YKXl9slorwcvvF0/OohXr9fA+su9bdb0tdtgmFG+tPV07m0/n7CYO6mXPQMpaN64+q3fEgUl/XOmhM/Q4nYw0TOjPwfag6nuUEdtskPYmnE35+50TiKIKuzNNCibljh6b2DU8pxSuV5JcjdttqBcmvPVLAKG3Gd6i0YF561cHIV5jdpqVddPY0X4bq2G5TBce7DZ9QShMU+TR0gRutm5j6mRnxToky1MpTIFuznlBBeI6rX5CiaYQNyMAlp/SHBCR9cNo9HvHpYO04tlfOYUQD7/lNhCeOJj50COO0hHxEDwKA6QJxmAZI7gacLNqyxF65pCSr+4OgNXK9HNIoRYbIKUpY/EYKo2h4JxMFz+ZGH9uj0b7G6bUOlMY/BcWYVb+d+CbnsCAtb08zg9GxOU47Zc1xArC1okP4qRZN70CwIQkJ4dit1UJAndYLh1OF0xar+HlGWM9x2cR0N/zyFD+OogkUXC1cQ+7a
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(83380400001)(66946007)(316002)(31686004)(2906002)(186003)(2616005)(53546011)(6512007)(5660300002)(6666004)(86362001)(38100700002)(36756003)(508600001)(4326008)(8676002)(6506007)(8936002)(52116002)(66476007)(31696002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2hTaHZrbXBpOHU3K0pCeXhuV3lzTnkxdk8rSlNGcjRtZmNLR1oycEFic2Nv?=
 =?utf-8?B?MVVEcXRJMlYyTGdkNEpNWTd4K0pVVktHVzN2eG9nL2wzNWY1TE5NRWR1eXMv?=
 =?utf-8?B?blpOVWczYUdmdmZlYVFMS0xwVHhwN0VLdnV2ZGdIK0UwMmo0Q0h5Sis2WFBI?=
 =?utf-8?B?dGNGRE4yTGFHelRZczVaSWhKRnlubEZTVXhBSFVSWFVUWUpRMFIxYmhPTjZI?=
 =?utf-8?B?L1NsbWZ6SWZUUk1qRlJCdElhcnMwaDh2OEtTbGR5UVE4ZVc3SmFvc3BDbC92?=
 =?utf-8?B?RE9Ddy8rK2RrUVNDbGxFaGpXb0VVekNYSGo4V3M4STB2SzB5Z2R1Kzc0R01i?=
 =?utf-8?B?NE5hL1gwOUlSOHRpSzhuUC9JSGJOb0JubTJwSXd5SWdBc3o2NGtOMGtUQmFX?=
 =?utf-8?B?YzFCNEhsMmxvbVk3akpMci9HMitWUXc0c240UHdXbkhhZmZTT1pXMUU4M2I2?=
 =?utf-8?B?UklSMjdZOUJLTzJ1dFB0YzdOZGU4YmtKQW56QWVMNnkzb2tUQ255TVBnbjhE?=
 =?utf-8?B?NVhxcjFJcUQzTWYyd3h2RmRlNlpZbVFrc0E1QXRLeXluNDYvM3VWN1NBS3I0?=
 =?utf-8?B?NHVsVjluWkFXWlVMdXg1YkxrSEtYOXlxa3hyVld2b3lsbEhSS20vbG9kTndT?=
 =?utf-8?B?NEdtSUtqemxORjg3TXZ3QTN5L3NDYVRJZ09tRE13dDB2L29NVVI0di9EZEFE?=
 =?utf-8?B?Zy9NcEYwR2xDUDdQNEJiYVlSRkRmaXIrdFB0a3p6RTVUc2VhN1I4Y1lNUWJB?=
 =?utf-8?B?M1dyTndoVmkzamM4VWRESXZvVHhxTFFicUJqb1Z2Nld5RkdSdkJHUjBtWE9M?=
 =?utf-8?B?MXNwT2htWjVTYVgxZ3lwV3ZVZ1F2OFhvMzRCc0E5TldpUGdBanBPQmtCbVlR?=
 =?utf-8?B?YW5mSEFVVy9lKzFkTmRzeUpvTW5kNFowU2lMN0lsbVUvS21ZSmt6NUJ1RExP?=
 =?utf-8?B?ZmNwQ3ZhZFNyT0VjYytLU1h2MVY0b0FTK0YrcjFGcHlrM2gzczlYVXdMNTI1?=
 =?utf-8?B?OTA3d21rd0hjUDlmQW56OWlHQXRqSm1oeUplbkUxTFBHRUI0YzBXd2lvOGhZ?=
 =?utf-8?B?K2lDVWdWb1lZV3pVNzlRUTc0V2h0Um9uczVqTUJDa01MRXg5WmVncXAxM0xC?=
 =?utf-8?B?bmswZlRnWDg5U0VmcUplcXZNTkxnbXJNcUk5VjVrdFpPRkNJMFZDQ09vQko4?=
 =?utf-8?B?dnZXZ1BEUTN3ZnpNRDUrOUZuSklHQlVURWJVcG1aRVNHZGFVUHFyaDNOMENX?=
 =?utf-8?B?UVFHcEkyL1o1eFB4d01oM2szSTV0aDVFTjIrbFJwai81NERVdEl5RGIyZXVC?=
 =?utf-8?B?aDg4ZzVUZzY0UkdBTVhvNk91VG9nNVMreThhUksvNE9FaDcrMm90b2haeUFn?=
 =?utf-8?B?UEVLQmlRaDUvRmxUZmk4N2VaN0djWnJlRHlCK3FkSmNCRk9nM0N3QkU2anNz?=
 =?utf-8?B?VzBQMDg1M0M4dDZYc2lQZEpzcFc4MlYzbmtJR2l0ZjJnclNOb3kyNVRQT1pv?=
 =?utf-8?B?MkpzQmx6bEZBOVJGSDFjYzBwMFNpN3U2VzN6elNJRFIvays3dmMzL0VwanFP?=
 =?utf-8?B?a1FKWi9PNFdCczIzc2EybWZaVm8wd29kU2FrVERReHRwalFreEZ2QXNaN0xm?=
 =?utf-8?B?LzQ4QTlUaC92djVpM1VVbjNwMk81UmF4M3NsSUJQUlNMblREaVF0ZStZY1Az?=
 =?utf-8?B?aUhEbDRaVDhmV2k5eFV2Y2VyRDZpbngvb0VoN1hpSXVxVXFLV3JKZytDR290?=
 =?utf-8?B?TW95SDJOTUFWdC9oNmdhOUdvMHprRExyK0l1QUNqLytFS0hRWExqaE12elcw?=
 =?utf-8?B?bVdPcTFFalQxRzJ6bVN3NVlPZS9ObGpTWkp1T0NPV3lkTy9maGx6MHdvWndM?=
 =?utf-8?B?Y00rV2RpWmFHNWVScnhiVk9Ca3A4YkRRQTUrVjFvUHFKUjhKR2ZUZFl2c2ta?=
 =?utf-8?B?aWhRV1Q2akNNYUYrRFJpeGNMNlJiS1lxL1paNEIxd09KUGhQakVjVEpxK0I2?=
 =?utf-8?B?U2hmU3RLRFV6WnpnM0cyRHg1TFZ2cFl2aHVvazhKTUlIWDRQVjF0YUY0Qzlp?=
 =?utf-8?B?U0JrdEdjOHlNYmFoMDMzNWc5NjRtYkswQTNxTlQ1d2EwUEo1Q1ZGcS93N3B0?=
 =?utf-8?B?eklYUUZveWtUTzJoNW9TZHZjL0pseE9ZZ3RTK2VBaGQ3ckFyQ1NGdEp5dUx3?=
 =?utf-8?B?dnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c92fc9-bfd1-48af-4522-08d9eb62a742
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 00:25:19.6033
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: diHvJizj91GUOeMJjZxY7BUAGHlYFVLXqkhDUsY7LYm4TfV9qMLig+hJDZpyNGi0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3308
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: mjMii2kNhi2h2Arf8_3r8LEJWWTS-8b8
X-Proofpoint-GUID: mjMii2kNhi2h2Arf8_3r8LEJWWTS-8b8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_07,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202090001
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/22 11:13 AM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> Generealize light skeleton by hiding mmap details in skel_internal.h
> In this form generated lskel.h is usable both by user space and by the kernel.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>   tools/bpf/bpftool/gen.c | 45 ++++++++++++++++++++++++-----------------
>   1 file changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index eacfc6a2060d..903abbf077ce 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -472,7 +472,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
>   			continue;
>   		if (bpf_map__is_internal(map) &&
>   		    (bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> -			printf("\tmunmap(skel->%1$s, %2$zd);\n",
> +			printf("\tskel_free_map_data(skel->%1$s, skel->maps.%1$s.initial_value, %2$zd);\n",
>   			       ident, bpf_map_mmap_sz(map));
>   		codegen("\
>   			\n\
> @@ -481,7 +481,7 @@ static void codegen_destroy(struct bpf_object *obj, const char *obj_name)
>   	}
>   	codegen("\
>   		\n\
> -			free(skel);					    \n\
> +			skel_free(skel);				    \n\
>   		}							    \n\
>   		",
>   		obj_name);
> @@ -525,7 +525,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>   		{							    \n\
>   			struct %1$s *skel;				    \n\
>   									    \n\
> -			skel = calloc(sizeof(*skel), 1);		    \n\
> +			skel = skel_alloc(sizeof(*skel));		    \n\
>   			if (!skel)					    \n\
>   				goto cleanup;				    \n\
>   			skel->ctx.sz = (void *)&skel->links - (void *)skel; \n\
> @@ -544,18 +544,12 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>   
>   		codegen("\
>   			\n\
> -				skel->%1$s =					 \n\
> -					mmap(NULL, %2$zd, PROT_READ | PROT_WRITE,\n\
> -					     MAP_SHARED | MAP_ANONYMOUS, -1, 0); \n\
> -				if (skel->%1$s == (void *) -1)			 \n\
> -					goto cleanup;				 \n\
> -				memcpy(skel->%1$s, (void *)\"\\			 \n\
> -			", ident, bpf_map_mmap_sz(map));
> +				skel->%1$s = skel_prep_map_data((void *)\"\\	 \n\
> +			", ident);
>   		mmap_data = bpf_map__initial_value(map, &mmap_size);
>   		print_hex(mmap_data, mmap_size);
> -		printf("\", %2$zd);\n"
> -		       "\tskel->maps.%1$s.initial_value = (__u64)(long)skel->%1$s;\n",
> -		       ident, mmap_size);
> +		printf("\", %1$zd, %2$zd);\n",
> +		       bpf_map_mmap_sz(map), mmap_size);
>   	}
>   	codegen("\
>   		\n\
> @@ -592,6 +586,24 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>   	codegen("\
>   		\n\
>   		\";							    \n\
> +		");
> +	bpf_object__for_each_map(map, obj) {
> +		size_t mmap_size = 0;
> +
> +		if (!get_map_ident(map, ident, sizeof(ident)))
> +			continue;
> +
> +		if (!bpf_map__is_internal(map) ||
> +		    !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +			continue;
> +
> +		bpf_map__initial_value(map, &mmap_size);
> +		printf("\tskel->maps.%1$s.initial_value ="
> +		       " skel_prep_init_value((void **)&skel->%1$s, %2$zd, %3$zd);\n",
> +		       ident, bpf_map_mmap_sz(map), mmap_size);
> +	}
> +	codegen("\
> +		\n\
>   			err = bpf_load_and_run(&opts);			    \n\
>   			if (err < 0)					    \n\
>   				return err;				    \n\
> @@ -611,9 +623,8 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>   		else
>   			mmap_flags = "PROT_READ | PROT_WRITE";
>   
> -		printf("\tskel->%1$s =\n"
> -		       "\t\tmmap(skel->%1$s, %2$zd, %3$s, MAP_SHARED | MAP_FIXED,\n"
> -		       "\t\t\tskel->maps.%1$s.map_fd, 0);\n",
> +		printf("\tskel->%1$s = skel_finalize_map_data(&skel->maps.%1$s.initial_value,\n"
> +		       "\t\t\t%2$zd, %3$s, skel->maps.%1$s.map_fd);\n",
>   		       ident, bpf_map_mmap_sz(map), mmap_flags);
>   	}
>   	codegen("\
> @@ -751,8 +762,6 @@ static int do_skeleton(int argc, char **argv)
>   		#ifndef %2$s						    \n\
>   		#define %2$s						    \n\
>   									    \n\
> -		#include <stdlib.h>					    \n\
> -		#include <bpf/bpf.h>					    \n\

I noticed that in patch2, the "bpf.h" is used instead of <bpf/bpf.h>.
Any particular reason for this or it is a bug fix?


>   		#include <bpf/skel_internal.h>				    \n\
>   									    \n\
>   		struct %1$s {						    \n\
