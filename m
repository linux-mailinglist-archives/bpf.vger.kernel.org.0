Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 778AA4CD901
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 17:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiCDQXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 11:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiCDQXI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 11:23:08 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2642A166E2E
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 08:22:18 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 224B76kC015638;
        Fri, 4 Mar 2022 08:21:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qHnPfI4DNOghEJGtqAmXrmzeaTToTMWzgQ6afURcup4=;
 b=bdctvL6DMIN6Q1PufhJydaYmQ4NzGDJ/lNVQm0Y4q0stzfGjqbn3rUMGfG127FPXxW+V
 xjT95+JugZY4DyVsA/s95aU+uT+la7L+VX2Komm7cy1AvbMOdVqy1/7ledax7Lf4NSKo
 75I0P/dTP9l7g2OWV6n2HUKQcyUCofPEL+U= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ek4je662r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Mar 2022 08:21:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPhX7UiotTXlCXpBp85/TdVLOGS9viCXI0RgWP6MOAP7h6++r3CFGbkwFE0837dl5DUDkooMjly5b2QAGXwQgyxT2rm7ccmjOmw4KafkNIQ70Jlhb/I6Zc304f+ojuBVLAZ/TCk37lO/HEd5jM7FSl9GWQKf5HSJw8TOi0K8fdq8cIo2WNkznItNx+j5RbRIUFHqWW4vmgmek3mKsJQ9q17XOsrgXhyQb7HLoXv4/+FWWG/uKrfjbMzj4cf8I6KpRv+e4UK4qSqbGKnGaL1i+dzxOy28wPY9XvfA5/k1+VVozwJ1SNPnQ8FMbC6tiijogOaVQdn5BLhEjRv1WrKg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHnPfI4DNOghEJGtqAmXrmzeaTToTMWzgQ6afURcup4=;
 b=UD5sV9A/YgxTceZf/pyTg6e3PQGDNs9jMhbULTmilJiNn016CXrU82bgTVZ4ab24VKcOcXM8T9B8N+Ni1fC/MVVN1njgJH8RSnXFH4231mJovxurY/8pEyl/jz3KQCIwk+1xg6VigwiB9XpTm3jNtVlcgmFBA4JYXtGVS8XjCcS63DGEKpegCbaIv/u0AbMIjm4iqamFl+3zhRXi+Og6AyUWj0irhK44NgYH/H9FW1lNPvey8D+n6nGzsIJkZvGLS/ccrik4fYalFmuekz4xm5QfttmG/fkr5emW8vVtDzZ/miOgomDT0PfsGEPzcKX9tXs4QaRNr18/uEwxlItApA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW5PR15MB5124.namprd15.prod.outlook.com (2603:10b6:303:191::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Fri, 4 Mar
 2022 16:21:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.029; Fri, 4 Mar 2022
 16:21:38 +0000
Message-ID: <acf30143-dc2c-9651-44b6-af45a1c426ce@fb.com>
Date:   Fri, 4 Mar 2022 08:21:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH bpf-next v5] bpftool: Add bpf_cookie to link output
Content-Language: en-US
To:     Dmitrii Dolgov <9erthalion6@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        quentin@isovalent.com
References: <20220304143610.10796-1-9erthalion6@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220304143610.10796-1-9erthalion6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MW4PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:303:6a::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b212a7a-1711-4d1f-0d01-08d9fdfb0ef9
X-MS-TrafficTypeDiagnostic: MW5PR15MB5124:EE_
X-Microsoft-Antispam-PRVS: <MW5PR15MB51241B6D0FD6353648ABD8BFD3059@MW5PR15MB5124.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J+aDF6uMupMSdMiSjEl3JV01Lewm0kQB5bMQwoGHUNHgzmtc3xyAY+ViaRpAYFHFZ28r//aPIiEjSC/+7u/0hUaOWNu17atzVIBUZzv5bbRVdMDpNWdoqVtSeuzuV5KkihGDD0L6EUEL8tOB04yCh3jvhAJQNT/oX2GK1nJwebj6A9fEt6ZUxrFaOh22lmNbkIdyXXyyaGaGiL72mu1Zb2dVbtqgHgVMT9x9hK7ve9ymvyG/LPahzRT+qqQt3y3i0qP6XN51R7kMFG8mxVxdR0aXNh6lPyX6XDfmacGHtNz0Ptw+EYRNgyYjkr6xm82dH4gn2HbVew52oefvIE66LKHLW8WjYxzp1XOcGBZpgwXnQc4QuwKyU+wUibXZ5Wt7tLimgVGg6ixLGcoFpyE9CAW7VEfQ3NXfUxhHnDhBdJrHdsCMhu59fM6yy6ftHZGjw6uEJz9f8+eBAdbHpMLYtDn1yF1pLJirtUxO3A2oAP9qW2zSlwJy0Lr8JjqP4XaNi6zTZgNkY042q3ibdIPJsBwrRK6kMYUSFeh+3sLlXIbjo8oSUX908PcVJ6XlkMdbFZyXDMSVEX2BMZDZhNzBX5YwGCMMDDDZGO6ByFegD3757oh/wLzg6JJhb66YAqbmXjnR76jvWaQuIM4+nSnlX9veSi3Sa4JmKK2HQe2SzPgJ/iPv3yeY/q0IeYmrLGNQn83MLcY8Thp2t9F6hrjM4t3RnYDAJXhwX0EjAOm1w6Nc+BqpEF3RVSlR0V5cikVL99vFpnx413j5pwxN4Sbs8buR8urnycLwzIvn6JPa5ebu4/LYGgPzVWlkVPb+5cp2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(31696002)(6666004)(66946007)(66556008)(6506007)(8936002)(6486002)(966005)(5660300002)(36756003)(83380400001)(508600001)(2616005)(186003)(8676002)(31686004)(316002)(66476007)(52116002)(53546011)(6512007)(2906002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVgzdXZuRWNSbmpUZTRHQWk4YnZWWDZiMmJJRFFkM0cxMHBQaFlUTHJNcGtQ?=
 =?utf-8?B?b1N3aHB4T21TbERtY2M1T2FnM0RkMEZ2bG1EbmtaQ1AydXNrWHNJMUMyT04z?=
 =?utf-8?B?OXNob2E4WURJa2RhUVRiUkZudXA4eW5sZkxUOWNQT0w3SmV1UHBQU2dMRDdJ?=
 =?utf-8?B?M21PZFpLajA5TTJJU0Nvbnc1R0RCSEE1QTRTamEzTHFBREkvTUJzNER4Vkli?=
 =?utf-8?B?STVlMFovckZXSkRESi80TlYvODh0Qll5RGEwcHdrbCtuNDZJMmp1a0NJSUtx?=
 =?utf-8?B?MkFDSVl1Q3IxUG5kRjhIVGwyendPZ2IrMnYxK21NTXNXdHI0ckdWY0o3dlFD?=
 =?utf-8?B?RXA4UUk1bldsQks3Sy82N0NOSDQrYi9PeFhJR05YaFJDRnJCY0NKM3hPSlZB?=
 =?utf-8?B?eHVQR0xmelUwT3A2N2dya1lJV1hJeHZmTmppaEJ4NlpFa1ErTFNxMmZmdE53?=
 =?utf-8?B?RnoyUHUweFVhSWhYcC9PYks5dmpQbjhOVlVKQktkNUtIVUt3RzVDdjV2YVdF?=
 =?utf-8?B?NzhIOFYrWkFPd3VzTE9vWkZpc25ZbzJBUVpTdGlnMEhDbjVkWUVrRllGM0pT?=
 =?utf-8?B?SEVWbWkwSDhjN2syeGEyUUtYNWtITWYvZ3E2ckM0SG5uTm5pNU5vUmtmdmJR?=
 =?utf-8?B?dk1sTmZhUllTeXhidWZTMVVxQjJibVRyclplZlRrMXhDYmR2VWxkbHRSWFcr?=
 =?utf-8?B?cHdCVXdNWldkWjZjcjIrV2JITmpUYTNYeVAxTXBsR3pOdXBIMXpNMVpPMGVi?=
 =?utf-8?B?Um90cVBHYTlaZHNDbHU2aUJ0Sko1MEpvUFM3dVRwMndQWEhWc1FTZXVQK3Fo?=
 =?utf-8?B?dWsxZHRjZTRZMFpUb3RMT2Vsek9BZGQ3WFI1Nzl6TTdLNXMyUm9DdE5rRzM5?=
 =?utf-8?B?azNWbFpzVmxBendPOTdxUGJheDJrZHVVYjVCT1RJVnV6S2hyNE9LUjBWWTNh?=
 =?utf-8?B?UWpINy9JUlhsMW9tRjJVZVllbm11OXZsejRzMzVOVjJFcG9MSEs5bXBpR2Rh?=
 =?utf-8?B?cm9nbTZielJ0U1pSeUl1R2g5WjNTVlg1VE80L1cvMHVsQW12aVU4WTBJaGtx?=
 =?utf-8?B?VUNmbUhuOVBFZUhsMFlrUzlYUWMzWEUrcFlnRVVaYjR0T2g5VytkcitVR1o5?=
 =?utf-8?B?d0xoaFlZUGo2dnh6YkVNSFd2RXFzbVorNjlDWWlrbUROZHdIRWkrRFJWRTNr?=
 =?utf-8?B?RmlwS251bTlOWWlNNElYWVNSR1haWlZrd21VU2htZDB0RUpkeWdCbHJpakZO?=
 =?utf-8?B?YkdocHZUenhLaUpHUW92VTZEbkN4S04xY3VJMXZxV1RtNFdqUENnMzFGOXUz?=
 =?utf-8?B?K3ZML3hTU09YaXBlZ0NZUGlLVnF6OTVKSXZQOVVOTnhFSlcySXBzUG5CVUhH?=
 =?utf-8?B?WHFGVERtRE9xWW1KNm13dWtiMlMyWCtqV1Y5TXBjeVZSQjdxM0piZjl4TEVN?=
 =?utf-8?B?WkVmMWRpMnFKcWwwWmcwQ1Y2TklRTS9XRVNYL01MR1BNcjNzY2FnMDJ1TUJM?=
 =?utf-8?B?VlBGRTBOamVQNjd3OEx5cVpyMFVVK2dCcXlLZkNHb0hzR1NUeUJBQndlU1Uz?=
 =?utf-8?B?UUhnT1M0d2V4YlFSd1pMRUpRcFJKL3VxZWViTFFEaTBucnJxeXZHWXdNWG5y?=
 =?utf-8?B?Y3hYOUw3OGszcEF1TUhtVE1KdkNRYnRzK2ZWcE8yRVhrc1JibW9wVEFCbFI1?=
 =?utf-8?B?N3NvWDFDMnZkanVkRXhzak9ZRnJ3a2tmdUViajJoakdYOG5MSUNxbDVKUHZV?=
 =?utf-8?B?Z3pzR2dvTmVncHBHWVFwL0RqbmRVcWJ4YnJmdkxXQm5KaEZ3UmNUQWRIOW52?=
 =?utf-8?B?WVBBZmJiOXVqZ0VtSlRoc01VUHIvKzRia3lReGJWaGp2L3d0d3grOXp6aEx3?=
 =?utf-8?B?ckZ1UzByL0RJRE9MK2FxNVJ2OUYvWTFqWmJnT2RnWWJudXNoeXZBemNGbHZh?=
 =?utf-8?B?MmlHRlMvTDg0SS9UOXNqNjRabkRYTmtJL3cxQjFNTEQ5b0FmZHpIVTFOU2th?=
 =?utf-8?B?U2pPWHlpYTFweTNqZVBtVEgzSFJ4Q1ZWYzJ2QzUwQzFpdDUzbVZmckYwMGJF?=
 =?utf-8?B?blBaYzVYYUVKd0ZuYXlVMnl4R0F1TnVQTFZXOXhYQVBJU0lGbEkvdG5UMDZr?=
 =?utf-8?B?MEFnRGVmVkdJQlRuQWhKYkZOZEkwTlBnSGtnSE9FMG80bzV2OFFkd3FUY0tV?=
 =?utf-8?B?OUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b212a7a-1711-4d1f-0d01-08d9fdfb0ef9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2022 16:21:38.0394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0FTwzhx8J3flZnt/1zsAUBvj4G8E4+e/F+O/YIFx4shtk6gxKq9tVW8y75N+Sa0v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5124
X-Proofpoint-GUID: JWDgNtiIUsnZQ7NYew67sxLtc9h460K-
X-Proofpoint-ORIG-GUID: JWDgNtiIUsnZQ7NYew67sxLtc9h460K-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-04_07,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203040085
X-FB-Internal: deliver
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/4/22 6:36 AM, Dmitrii Dolgov wrote:
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.
> 
> Implemented using the pid iterator BPF program to actually fetch
> bpf_cookies, which allows constraining code changes only to bpftool.
> 
> $ bpftool link
> 1: type 7  prog 5
>          bpf_cookie 123
>          pids bootstrap(81)
> 
> Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>

LGTM with a few nits below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
> Changes in v5:
>      - Remove unneeded cookie assigns
> 
> Changes in v4:
>      - Fetch cookies only for bpf_perf_link
>      - Signal about bpf_cookie via the flag, instead of deducing it from
>        the object and link type
>      - Reset pid_iter_entry to avoid invalid indirect read from stack
> 
> Changes in v3:
>      - Use pid iterator to fetch bpf_cookie
> 
> Changes in v2:
>      - Display bpf_cookie in bpftool link command instead perf
> 
> Previous discussion: https://lore.kernel.org/bpf/20220225152802.20957-1-9erthalion6@gmail.com/
> 
> 
>   tools/bpf/bpftool/main.h                  |  2 ++
>   tools/bpf/bpftool/pids.c                  |  8 ++++++++
>   tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 25 +++++++++++++++++++++++
>   tools/bpf/bpftool/skeleton/pid_iter.h     |  2 ++
>   4 files changed, 37 insertions(+)
> 
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index 0c3840596b5a..1bb76aa1f3b2 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -114,6 +114,8 @@ struct obj_ref {
>   struct obj_refs {
>   	int ref_cnt;
>   	struct obj_ref *refs;
> +	bool bpf_cookie_set;
> +	__u64 bpf_cookie;
>   };
>   
>   struct btf;
> diff --git a/tools/bpf/bpftool/pids.c b/tools/bpf/bpftool/pids.c
> index 7c384d10e95f..6c6e7c90cc3d 100644
> --- a/tools/bpf/bpftool/pids.c
> +++ b/tools/bpf/bpftool/pids.c
> @@ -78,6 +78,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>   	ref->pid = e->pid;
>   	memcpy(ref->comm, e->comm, sizeof(ref->comm));
>   	refs->ref_cnt = 1;
> +	refs->bpf_cookie_set = e->bpf_cookie_set;
> +	refs->bpf_cookie = e->bpf_cookie;
>   
>   	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
>   	if (err)
> @@ -205,6 +207,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
>   		if (refs->ref_cnt == 0)
>   			break;
>   
> +		if (refs->bpf_cookie_set)
> +			jsonw_lluint_field(json_writer, "bpf_cookie", refs->bpf_cookie);

The original motivation for 'bpf_cookie' is for kprobe to get function 
addresses. In that case, printing with llx (0x...) is better than llu
since people can easily search it with /proc/kallsyms to get what the
function it attached to. But on the other hand, other use cases might
be simply just wanting an int.

I don't have a strong opinion here. Just to speak out loud so other
people can comment on this too.

> +
>   		jsonw_name(json_writer, "pids");
>   		jsonw_start_array(json_writer);
>   		for (i = 0; i < refs->ref_cnt; i++) {
> @@ -234,6 +239,9 @@ void emit_obj_refs_plain(struct hashmap *map, __u32 id, const char *prefix)
>   		if (refs->ref_cnt == 0)
>   			break;
>   
> +		if (refs->bpf_cookie_set)
> +			printf("\n\tbpf_cookie %llu", refs->bpf_cookie);
> +
>   		printf("%s", prefix);
>   		for (i = 0; i < refs->ref_cnt; i++) {
>   			struct obj_ref *ref = &refs->refs[i];
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> index f70702fcb224..91366ce33717 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.bpf.c
> @@ -38,6 +38,18 @@ static __always_inline __u32 get_obj_id(void *ent, enum bpf_obj_type type)
>   	}
>   }
>   
> +/* could be used only with BPF_LINK_TYPE_PERF_EVENT links */
> +static __always_inline __u64 get_bpf_cookie(struct bpf_link *link)
> +{
> +	struct bpf_perf_link *perf_link;
> +	struct perf_event *event;
> +
> +	perf_link = container_of(link, struct bpf_perf_link, link);
> +	event = BPF_CORE_READ(perf_link, perf_file, private_data);
> +	return BPF_CORE_READ(event, bpf_cookie);
> +}
> +
> +
>   SEC("iter/task_file")
>   int iter(struct bpf_iter__task_file *ctx)
>   {
> @@ -69,8 +81,21 @@ int iter(struct bpf_iter__task_file *ctx)
>   	if (file->f_op != fops)
>   		return 0;
>   
> +	__builtin_memset(&e, 0, sizeof(e));
>   	e.pid = task->tgid;
>   	e.id = get_obj_id(file->private_data, obj_type);
> +	e.bpf_cookie = 0;
> +	e.bpf_cookie_set = false;

We already have __builtin_memset(&e, 0, sizeof(e)) in the above, so
the above e.bpf_cookie and e.bpf_cookie_set assignment is not
necessary.

> +
> +	if (obj_type == BPF_OBJ_LINK) {
> +		struct bpf_link *link = (struct bpf_link *) file->private_data;
> +
> +		if (BPF_CORE_READ(link, type) == BPF_LINK_TYPE_PERF_EVENT) {
> +			e.bpf_cookie_set = true;
> +			e.bpf_cookie = get_bpf_cookie(link);
> +		}
> +	}
> +
>   	bpf_probe_read_kernel_str(&e.comm, sizeof(e.comm),
>   				  task->group_leader->comm);
>   	bpf_seq_write(ctx->meta->seq, &e, sizeof(e));
> diff --git a/tools/bpf/bpftool/skeleton/pid_iter.h b/tools/bpf/bpftool/skeleton/pid_iter.h
> index 5692cf257adb..2676cece58d7 100644
> --- a/tools/bpf/bpftool/skeleton/pid_iter.h
> +++ b/tools/bpf/bpftool/skeleton/pid_iter.h
> @@ -6,6 +6,8 @@
>   struct pid_iter_entry {
>   	__u32 id;
>   	int pid;
> +	__u64 bpf_cookie;
> +	bool bpf_cookie_set;
>   	char comm[16];
>   };
>   
