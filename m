Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BEB4C9EA9
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 08:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233208AbiCBHzB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 02:55:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbiCBHzA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 02:55:00 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D638182D2C
        for <bpf@vger.kernel.org>; Tue,  1 Mar 2022 23:54:17 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2221cm3l004359;
        Tue, 1 Mar 2022 23:54:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6UV8awnT/8GYT6v+ePEIh68/14sGoiVDUJbw7hJeE5w=;
 b=KIbxUJbSm/T8R9Lm7Zx11ah1pWhAGkjx+n9w7QgyFQMQqF/Ilz01WluntraUYuf5u/Yn
 YGASTY+TOkN9ia7sYgNNJIdNJtLE0TOJxghQgbgxRt/Lhm+6L6a3nj+yMUQYb/yBMRoK
 kpO/9A9jjWAQZPCWHOB/T+2xhZQOyU35Hyc= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ehvdcamk7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 23:54:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hM2AC3LuyHVoLgTBf1emsKanbw8reQ9xKFoaJYuoGKGXIZGnQWvVEcZrxRSIsZtIgtHJWW/fcDMLgIm8XcGgjTfGn/J+Dh+G3MSi6cl7MufJilgyH5QN9iY04OaZ4V/jNf5xJTqVhLCCptE68XUntJ948BDgl+nSkHeBYrMFqa6SLxVD7e1QAJTQYYntrvBBq2ZxtGzpjReoUsbQLc5ZDF3DEmIYMaxto2SM7xcSs9KbLYwu6zZzzt2J2SusB7BqnKQ8WsyYTJ+LRwiA7IhXejwySFSEPPVDT5GthrXS9k5ndkPvsbQ/TNVRxwe8vQlFwnFvFZbpboG36DqNShjcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UV8awnT/8GYT6v+ePEIh68/14sGoiVDUJbw7hJeE5w=;
 b=cBcz/u5ynXAIkTmC+3LjExVHIAKmGExr1tViIXyGTObLDeusvOxAuZRlrc5k9acPODdah4JvYpyGXcWJrAuvx0Tf3oN+u0qAEOjJopcbL2yUv6pDRIt7kF446UsJSUbKsOd6y3pXepZS6piM21usvZtfLrg2027JqLLqJW0e6XQZH+C/Ph7cdmfTWegS1+gLTuO3eyQobcH1uMrKo1wH3BnMxDzeEzy9rqPiZD92Y9Fgt5ZM7R3Oy4WurSB1S/O5toX42NLk7yUcr9zhCJDfft2Yf2HwwbSt2TK7VOkAS9thNY8AoBBhAh/Bfyj3qcw6/lCH1iFNR9MUCZ6k8rl8ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MN2PR15MB2943.namprd15.prod.outlook.com (2603:10b6:208:ec::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Wed, 2 Mar
 2022 07:54:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.5017.027; Wed, 2 Mar 2022
 07:54:00 +0000
Message-ID: <a646e7d3-b4aa-3a00-013e-4fc9531c2d83@fb.com>
Date:   Tue, 1 Mar 2022 23:53:56 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH v4] bpftool: Add bpf_cookie to link output
Content-Language: en-US
To:     Dmitrii Dolgov <9erthalion6@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        quentin@isovalent.com
References: <20220225152802.20957-1-9erthalion6@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220225152802.20957-1-9erthalion6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MWHPR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:300:ae::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 96dedc18-82f7-4d83-2649-08d9fc21cfd8
X-MS-TrafficTypeDiagnostic: MN2PR15MB2943:EE_
X-Microsoft-Antispam-PRVS: <MN2PR15MB2943895955419A14CC89A41AD3039@MN2PR15MB2943.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YDBxIrL97cdm89C/tlNW3Yk9ixxPrVsBJYyS5xvtNmC3jrEkEXhk6vs9NMELLhx6VLFAuc8vgi7zfZIPeOrreh508TW88HusEBiRVRuPTvsHfNCfRXOjxtI/TKY9V8NhDzbR38qrzDkVG6FUrlbVOIMLHYSwMq+6MyLw0LjPXPHxAXZKY3VrBjRNRLlzP6edyTB1lOW6oGTCcGQq7usIry3W6KQ9KEKYVnijYWJroj+WuGUX7nzHGDvTsQChoV6N58GpJXOhaHTS3JgkWdkQJbg8TFveA5a2xOtZnqEEAwIofwSGg30+usbjPJv3RuelEJQL8Oo61k6U6GIqSAKICjOBZ9dEBJwdvV7wz+wB0QmVjlIOqouBIn4GbeRs1D/yYcH7xaxxbIAlBQ7Iht05EuCm26aXz1T0xRNpGNjYGSMXsZuZGNkS8ekEmtdXbY8QDR6SgOJK+qJhsfEUHI6KNXKk6hYDlvEPZwWWesIYCRWgEy9oNNBJs0bfKHs2s1Cy2k3dHPef7EvKiSFp5lFCIJOp2G08+FEalWqM0PEC8ZSYhVyIW456nKZa7oIlDQgcgpvCWRF2dZSlM791cdd/RZPi9mf242qHNXuzPGDsQWZOgj+z6yEvkzTsaXs7Zvt0t1UFKbhvXo0L7ACs19aWGdpGQwpm2W22RDvqvNI5/0uzm660vU6AgFzaTopVDwJr4/jvC0SbM5Ak2HeTVctKudTkDExgmlCdukcx8lMkJrJeAEPcVek6JQKTxfp2em1VYHQcPwDEacsyU4Z5+x9eX1htGW2QPAnefDrbvemmv6yoT6URfluv64ZvOBeLSxsDw9HWgtWhfbpyR27y1fV4Yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(83380400001)(38100700002)(186003)(31686004)(2906002)(36756003)(8936002)(66556008)(8676002)(5660300002)(6512007)(6666004)(316002)(31696002)(86362001)(53546011)(66946007)(6506007)(52116002)(508600001)(66476007)(966005)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG51bGU3RjJKL0dlMWJTRE5UZmxwYzhVTVN6L2xvZDRtekRhdlpGdlJDa2Zx?=
 =?utf-8?B?bFpSZU5CZk9yTGx3cDhVWW9LTWhYRjZBVkQvcnNWaHdFR2JqdGpHc1VSeVlz?=
 =?utf-8?B?bUhSL2I4dnh6Umd3M0o5MlFLRHFTWmMzY2pyajRaZG1tRnBzM3I2d0VmTHhF?=
 =?utf-8?B?LzFBWHJYT0ZVOG9ZdnNQZXByQmtRT0NieUd0ek1XakNrbmV5WTk4SmRSWldx?=
 =?utf-8?B?UXNUeE11eUZnUmJLbjI4alcxUGRRMjVCNXUvN0tFNzkxWGRjdDBsbDdIdFRU?=
 =?utf-8?B?WHlYSnJWazFTRE5JSlcyeFE3Z3hHRGRYK1libzFsSXdQZDlOTlF4dmxFN1Rs?=
 =?utf-8?B?aWRQejBMeFNIcGpJTnp2LzhKUHVPdTZOdUFNUS9HVnZCakpWNFV4WTQ5VVZx?=
 =?utf-8?B?NEZSNmxtZTBuME9RVUNPMEp0Q0I5bmxPUmowTHJpdGtWbnRIREwwTHZqanJa?=
 =?utf-8?B?UkorNjRJZXNmdGZUNkg4bndHNllkOFJ3K0JmeVMwQURzVnBLQjZDZEFad2l5?=
 =?utf-8?B?RTQxQnQyczhHci9qMkdlc25jSlhDTVpISitrUHg4NmVhL3daZW5Sa0FMOE5m?=
 =?utf-8?B?V283TzRzeDRYaktIcVJVMk1qQUZnQmp0cmp0UlZFSm11WmpWMTRMamg1Umor?=
 =?utf-8?B?QlNnQ2V5L3NtbnZaK3ptd1BVa3lEaWYrQWpKeEowd25wdmdJM2RKZ05kejlv?=
 =?utf-8?B?OE9IRW9GU0dHYnVBeGdUejZ3ZXlSUzlBaXk1MFJ2V0pMN0JFbVdLM0F0bGVN?=
 =?utf-8?B?aHZtTW9Hdk5TNENTTlAzb1ZpOXc4bjNNTFU0bStVTzFwUXM5aG1xWnI3RGND?=
 =?utf-8?B?NGk3WFpLODlMTFVJZGFleHdOaVNTLzlVSW1kWnF5TUs1OGR5emdqN2ZiSFFJ?=
 =?utf-8?B?RmdGbmpFejljeEpWZjZSZ2E3SjNtZG1YTWFwL29HSXpvSU0xOUkzNFl0Q2J4?=
 =?utf-8?B?VThranpVd0xZUVRaN0YzaFphSUp6bjlQamlSVzNsdlBoY01ZSlhCV0hZeVNW?=
 =?utf-8?B?RkU5SU85bnI0M3hQUUNrakVQNm9LSHZ5YzZ2NG1DbUVQM1dwT2ZqR09hdzhv?=
 =?utf-8?B?cU5JelFDa3RPNlFXU0xqWEs5WmNyL1QxUWtsSkllY2FtMXJoTmNNMUVLMm80?=
 =?utf-8?B?VHBJSm51WEhUL1JWdFpCcmJWYloyNUZSUmduOGJNOVZKaVgvaStpeHR2ZE9Y?=
 =?utf-8?B?WCtUSWtkbWhvSUJaSHJZbjVCcllzUnBsdVFtcElvVU9lbFIvTGovTk95M2My?=
 =?utf-8?B?K1pqTjFEaFRKQnZnK0VicGR0UFF2SUR2TEJrZlh3Zy8xSnc4VjNPQXVyeFMw?=
 =?utf-8?B?bUtJeDlOSGt2L0wyemY4SWVKTG1YZDlzODBVemdpUnQwMCtWTlRzbmpzZTlS?=
 =?utf-8?B?Y1hWajhMQ0ZVQVFCZDJHZFJaNEJGSGhTMVVtWFplS2VRdElvNzFHbUNHRkdu?=
 =?utf-8?B?YnhLalVpa0F1ZUpiRFhNcnNab2QwUWtySHlpcC9MbVRmbDJsYXJZSzlFemxm?=
 =?utf-8?B?VWRodWM0VEpIaXhicWtvcDN6ejI1MllHd2hRZkhkZUdFb1o4bGdGS0lDT1pU?=
 =?utf-8?B?M1VXUzlUMDhFTmZBQmxXTWdZa24vRWZXVzBsMmlaWGo3Z00yMU9KMVlnemZ5?=
 =?utf-8?B?UThNdDRDelduMTY1ZGpuWTlxQStCQk9zOEo0U1J2UGpIY0pJNHN4VlR3dUh0?=
 =?utf-8?B?SnlPQ0FuSGNKNDZPb0hSSnU5V0FqbmlGakNmcTVWa2RQYzB2WFVSQ2RQczdu?=
 =?utf-8?B?S2N5ZmdBUEtuQVBnT003TTE2N1B2MUNQcldGYlloRGI4aGFtQjNIbzBmd3FY?=
 =?utf-8?B?ME9HRGQ4MWtlcTFlSGlPaXNsTXlRSG1qeFY4OTB2b3BJZ3U1QTVjT2NZRkhW?=
 =?utf-8?B?RU0zUVFQdWN4d21ET2dVaDk2VTMwLzlLWHQwYlpudVpwRnc3OFV0MDlNMlky?=
 =?utf-8?B?YWhKdTEvTUdTNUk5c05qN1RuQjI3a3FFV0hKVVhGMDhsSkMzYUtYUUtoT0JP?=
 =?utf-8?B?RFRQN3FndmF0RTlYL05tRC90a2J5NG14VytFdVFUYk4wZVZhVEJWMmtwL29q?=
 =?utf-8?B?Z3V5UUhUUjJpOGJrMnhiK1BLV2pVaTJTZTRsVTdWY0xsVDIzRHY3a3R6Y0xH?=
 =?utf-8?B?N2RqMngwelYyOEFHOW1LU2x5Q2h3aDh2c2hUdDBKNERjVXdEVWhUVmJPRnhx?=
 =?utf-8?B?SUE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dedc18-82f7-4d83-2649-08d9fc21cfd8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2022 07:54:00.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dZP11qFXMxEgdk43i50kzpbWdXGCNfWe3iTySCSwjemhcJzTKHVs+p/zL1AcMwCR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2943
X-Proofpoint-GUID: TnE3b-SuaEOpI9Pox0CoH1qQA65AqRDx
X-Proofpoint-ORIG-GUID: TnE3b-SuaEOpI9Pox0CoH1qQA65AqRDx
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-02_01,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 mlxscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2203020032
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



On 2/25/22 7:28 AM, Dmitrii Dolgov wrote:
> Commit 82e6b1eee6a8 ("bpf: Allow to specify user-provided bpf_cookie for
> BPF perf links") introduced the concept of user specified bpf_cookie,
> which could be accessed by BPF programs using bpf_get_attach_cookie().
> For troubleshooting purposes it is convenient to expose bpf_cookie via
> bpftool as well, so there is no need to meddle with the target BPF
> program itself.

Do you still need RFC tag? It looks like we have a consensus
with this bpf_iter approach, right?

Please also add "bpf-next" to the tag for clarity purpose.

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
> ---
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
> Previous discussion: https://lore.kernel.org/bpf/20220218075103.10002-1-9erthalion6@gmail.com/
> 
>   tools/bpf/bpftool/main.h                  |  2 ++
>   tools/bpf/bpftool/pids.c                  | 10 +++++++++
>   tools/bpf/bpftool/skeleton/pid_iter.bpf.c | 25 +++++++++++++++++++++++
>   tools/bpf/bpftool/skeleton/pid_iter.h     |  2 ++
>   4 files changed, 39 insertions(+)
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
> index 7c384d10e95f..152502c2d6f9 100644
> --- a/tools/bpf/bpftool/pids.c
> +++ b/tools/bpf/bpftool/pids.c
> @@ -55,6 +55,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>   		ref->pid = e->pid;
>   		memcpy(ref->comm, e->comm, sizeof(ref->comm));
>   		refs->ref_cnt++;
> +		refs->bpf_cookie_set = e->bpf_cookie_set;
> +		refs->bpf_cookie = e->bpf_cookie;

Do we need here? It is weird that we overwrite the bpf_cookie with every 
new 'pid' reference.

When you create a link, the cookie is fixed for that link. You could pin
that link in bpffs e.g., /sys/fs/bpf/link1 and other programs can then
get a reference to the link1, but they should still have the same 
cookie. Is that right?

>   
>   		return;
>   	}
> @@ -78,6 +80,8 @@ static void add_ref(struct hashmap *map, struct pid_iter_entry *e)
>   	ref->pid = e->pid;
>   	memcpy(ref->comm, e->comm, sizeof(ref->comm));
>   	refs->ref_cnt = 1;
> +	refs->bpf_cookie_set = e->bpf_cookie_set;
> +	refs->bpf_cookie = e->bpf_cookie;
>   
>   	err = hashmap__append(map, u32_as_hash_field(e->id), refs);
>   	if (err)
> @@ -205,6 +209,9 @@ void emit_obj_refs_json(struct hashmap *map, __u32 id,
>   		if (refs->ref_cnt == 0)
[...]
