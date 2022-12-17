Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A86D64F6C5
	for <lists+bpf@lfdr.de>; Sat, 17 Dec 2022 02:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiLQBX2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 16 Dec 2022 20:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQBX1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 16 Dec 2022 20:23:27 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC026E9F3
        for <bpf@vger.kernel.org>; Fri, 16 Dec 2022 17:23:26 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BH0hf8b011606;
        Fri, 16 Dec 2022 17:23:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=vOhEb/YhmI1sYqN4UWP4YN3CMUznvw5+QTHxGxEdPnc=;
 b=FGlAJZTZerQ89K56U8wPwLL+7GeIshgTWC9B4aQOt3wpeZcO+TCDHZZYTZAGpZV07BbH
 eHTLf0oiwOS5PiqGJkQPnhJqHoQNh1TjZwiR/mQZjaDuiihfCTOxXLs6ctDvgaEOmRbv
 w5mmSLRCMC/R/Gt4NBCaLR2GkOKrnoTIjttANHLqjbMNkRFsVtDPIoz7/gKEuzKW4e11
 0mzNARYpBmwXL8hiYFHPah9H0I1iI4i9DXDLab8PCI1ek4Fe9U+4M7LmgXkoQpqItGMA
 NxSBqmRPu5G2Mmu1d0qamNfgC4JGsq8paW9lmxd7bO8KSRJPdt5l0cCRk67+EFT4X7fi bw== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2105.outbound.protection.outlook.com [104.47.55.105])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mgh7v6kx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Dec 2022 17:23:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUP4oTSJZctoLpxBJXNUHwF0Q1vAkAlTeStBFCPAjnR+UORfeUacYm884Y3XvXZpHLtMUtobrkvnsKoG+8AB8fgWYqTW1N2bAPzmqtZOxChzaNBWDKLSUEMi2HPMXy61o1VBSarKIuXrCy+l1vB07M4kWyT6z6cKQqqrrB1TM/znFl1JTR5zBVPr/BI9AubfAJ+HShJh2Pzg+XCu4dVPhIfV5wAYLcXBa5LQCQVu0eqR7jFS8WG7SrArvI7hHTdmUGXaVYiqLs6DdSqjZQ7DC91JG/H7rkwjttYfIE2FOXLD4old40kpIfCLLUWuXHH0zX3GB1LyR7vkpVDA/ih+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOhEb/YhmI1sYqN4UWP4YN3CMUznvw5+QTHxGxEdPnc=;
 b=UxyicHtI3czP7UCcUFXav5COD7ZXMZX9SKVWmgxpMYUbmLXU3ziw6nvz2Za19Z1jNZtohLab546mYIFrOK8Y0EYYi78EzeeI8FZGXYw4fJ5popEUSY+1e/GwI/E4YY77QGcOstjU0bTqH5tYl/oAzzonQDjWVKzhMdqL2F7FOWoeUvwBajeKH99uJBDd9I+n0HTbfrZwwFl+XMBj8wy/Y7eaaLIpM36FW5lGHzshBZHHRA7x65E3vczdTrlFrRxJ5nq0s7gAmE/mFXBZ7bdY0A1nee15F5rSc1hQkihyObmO8k61kfu8k0RhCqGGrFmyxXYw3+ah4tjtNmvTZoah/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2811.namprd15.prod.outlook.com (2603:10b6:5:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Sat, 17 Dec
 2022 01:23:08 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5924.015; Sat, 17 Dec 2022
 01:23:07 +0000
Message-ID: <e68b892a-c688-f266-3819-0282ba5a1ac9@meta.com>
Date:   Fri, 16 Dec 2022 17:23:04 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH bpf-next] bpf: Reduce smap->elem_size
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc:     'Alexei Starovoitov ' <ast@kernel.org>,
        'Andrii Nakryiko ' <andrii@kernel.org>,
        'Daniel Borkmann ' <daniel@iogearbox.net>,
        kernel-team@meta.com
References: <20221216232951.3575596-1-martin.lau@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221216232951.3575596-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0012.prod.exchangelabs.com (2603:10b6:a02:80::25)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB2811:EE_
X-MS-Office365-Filtering-Correlation-Id: 3710f474-3c1b-4dfa-17df-08dadfcd40ef
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpiGj/peYrRkNQqEkUrwf/M3iHaCiJ8ReUmmfKwoWlm9RqFjQUBKmwWeSEL7ziPVMYMvBIBxZk63NwdeFb3xT51MjRqoS4VKjZSzWMbCjAN1UCvL2aOQACv/79ttZ5S9kq3I7oP39JOT8YFAkHsM2MBJTxXWH3BC3eHQiwYIwz2GHGSIwLIGTVWrSwrz8lzjdCGIB58To8aAMm9YAUTtgwXqWoc0KPIndznqgRu7tXcm4C1TFS3tYe1dlzedRIqRmH3D9FuHBSsCWYy9Ufal20C3SIXg8Omqz3JUHPGS0tTH291a5fQ1MKWiQ/0e54o0GRRdz4rGQBDeSmJeAhzd+yhtS/C04QODxrkwo/+lqc+ZekBefBMwNeeLTHt3jIRi5VsmMlKjFu7t5oaOeU0HCqx8Zk20tf0LhIRIxo/M2Mh9+kFk5NDdLNoi4zviB9kjPuGFpg3R6CWFRxVu3eM6KJ1E/edMK2HuC3/awMuqqXa7fnBqxdh8pFaIcBEUPkK4fNekmqtXNjeMar2L0AV39FDPrT6msdohaUS7/hYn913GY4DU4si08AlFDFkr4yHHKK8k6OejVxpqQr+A6XD8CR73DAIJyxO3wYIjgW+cKspG33iMh7FMHtb9cdIpyutbSWg/+XS/IoccmdI+6pED1CWH1hNyHM6czUz1Pge6wGKfCV1Sg2m9ek7jb/0HCNWa38/gsz1DbimjYzDZQLMI1ZsA4p/BgJxM3OhDfVOhuSo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(366004)(136003)(376002)(39860400002)(451199015)(31686004)(2906002)(5660300002)(66476007)(66946007)(66556008)(8676002)(478600001)(316002)(41300700001)(54906003)(107886003)(36756003)(4326008)(8936002)(6486002)(6506007)(186003)(31696002)(2616005)(86362001)(53546011)(38100700002)(83380400001)(6512007)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mk1EUHdpRm9hbTlLR3IwZU5KbmxBYXpGaDQvbDdFa3BmcUlWcmw3OGxjVnMr?=
 =?utf-8?B?R1VPaXZIWUowSEh6bDl2NTN6VURub3d1cGtRNk9RSklMcE5pRFFSSFh2TVd1?=
 =?utf-8?B?VnpHdTBlMVpSYVNDbEFsb0t5QU10NlUzWldNUzBFZGZGQUtDamEyeUZaL1BL?=
 =?utf-8?B?THVKWGRXem1iZ2Y5djVYbVFwMGFLcFdxeHZJbHhQbndFaDh1bndBK09hKzNs?=
 =?utf-8?B?U09GQndmVXdxb0ZIZm16dk5pOFBSZ1JrNGJnbDAwclFmc0N0TXdjWlIydDlp?=
 =?utf-8?B?Z29jdXE4bGZ5RUE4RkdUTWJ0T0k0N2RSeUpVRURqYjRuNlJWczA4TEc2MmRX?=
 =?utf-8?B?Z1Rhc21zL3d1RUxWYW11Q3MvZTFzUWVUYUJFZjQ2Q1R3TE43ek1mS1E5OUJr?=
 =?utf-8?B?ZC9OSmFmeUNWcTBZd3VzU0FHaFdnYlV0a1drZEg5WmRBWWsvYk5kQ0xWQ1A4?=
 =?utf-8?B?SC9oQ3JlbGFlSWZUSEdSZXIxaVdCeEpoOTlBWE1XL3IvK0hTVTZCNHRaRXR6?=
 =?utf-8?B?bTFKQmpRZkFMOC95SDlSZ295R2ZRT1BCK2kyS0dwTU1ISDBjdWhTRjhwRSs5?=
 =?utf-8?B?dlYzdW1qdGk4REVNTktxMHU5RU1HUjJHUGVIZUxvYkZrV0NERVJzaURtQmI0?=
 =?utf-8?B?OC9UdDJZUHVpakQ2SHlJTERpRDhmUWtwVzhEWWNBdGNwZ2VtbUh1RXJ4eDZs?=
 =?utf-8?B?QWFibFZteXJvUndaMkFYZ2s5ckpjR2lyNDg3NTJwKzZmQTZrT2Rrd0gzZWdJ?=
 =?utf-8?B?U3pZNDVBdHFRVXVHVnJFNXVFRGNNbWZRSit1MVYzYVRMVW45YzVmaHpBOEwz?=
 =?utf-8?B?R1NaR05BVDFERndGQkhXSHlmR21reDk1NXZvNjJ0Vmc3TG8rdktNWVg4QnlC?=
 =?utf-8?B?YVJNOFRQZGMxRy9NWUlqcEFkY255SWMwbGlWUE02MVdZM3ZaUEZ0MmRuTjhO?=
 =?utf-8?B?d01hWGtxVkt1WUdCUjBxeUx0ZDlxMTkrL3h0Tys5cjJzVkV5LzJTZFBVUjRo?=
 =?utf-8?B?UjVUaWpEbEphOEhSdnZjQXBlQlBodmNzUWpQRWhzLzAzd1h1OFErdXM0VWdN?=
 =?utf-8?B?WEFtQmowcmFFZmZDVUVQNFdxY2ZWZlJIT3Rxam9SLzJob1B1VENKQXBVaFVL?=
 =?utf-8?B?NnZaQVNXYmZNTGRhcmJnNWJFbXVLQzEvUFZnMExFdFF0ODZQdEh6eVpUNlRO?=
 =?utf-8?B?WGxlaDg0WGZqQWt6L3hqa05MWEVZNGsyRXRKcTVrZlVOUkMzVEFWekhZekRC?=
 =?utf-8?B?bmpoZlZvdk13MlU1clk4YUVOZWR0bUJPZXNtNU1mRktlWmk3N2tNMTVad2pB?=
 =?utf-8?B?eXJuaFMvT0p0dUNpdUxVUzVTQjQyNk5uUWRQRVIzaEdpMUNtWmRJdis3djY2?=
 =?utf-8?B?K1VFK0Q5ampjNjhaL2N6WmE4SmNBMDJ1ZDRKdnZCMjI5WWtiZE50MWNyQnlQ?=
 =?utf-8?B?bzBDdkVRRSt2SS9xR2F4QVNFQVBqWkV4bVBuV0sxM1U5bCtwMTdiRXdwN2k1?=
 =?utf-8?B?c0J4UGRFQkpvT21URHhDaGtudUNhRk9WWFVrSEFLMzBDalV6VVZDUit4WnlF?=
 =?utf-8?B?Z2dVZElxUjFwa2h0V2JiVXVZdnZpUU41b3QvT1owZTR0QkMzcGZLZ1VMaWty?=
 =?utf-8?B?cllja01VbGxqNVp2YzVRSUo1cHJnSVdOamRvV3RYYTQrNkU4QzdHakdaWXNO?=
 =?utf-8?B?MXpFelYwQzgyZHczbW5TQnByWHdXbXc5ZHRlSHZMZkpkMUVqZ2lhNlZ0VFVn?=
 =?utf-8?B?SmlMbllCWXFrOFozM2tVN1U4cDlCSlViaDYyeGdJa2NQd2lGci9FKzhNVEky?=
 =?utf-8?B?aHhmMjNQYkZRMlNBOTZmbmpkSGhMYld4ZXA4YmlpYnR3ZDc1K29IMDBjcnB0?=
 =?utf-8?B?cHFvUFlQdUJzMUt4czhjUW1zcGJDUWNxelBVMS93YVZjaEh0YXZVVFFJZzB6?=
 =?utf-8?B?ZDFFNzU0VnZRd2RsYWgwazNmNnBYTmZIY0UwN08xTnV5aTFGWm5oZjBXekhp?=
 =?utf-8?B?N1NrdXNNZ0tHV1ovM2pVR2pPRy9laUk3STJ2MCtuWTFXaldnZUViUkpXVDlZ?=
 =?utf-8?B?bnNwSURMSXNEa09qd0M4bHRiSm9nU0plSy9KUSsvb3U4QmtiaFlyQVdDaW1I?=
 =?utf-8?B?alhpbzV4eEFBMUQ2N2FpYWtKbmF3WTNKZi82SzQyc0Q0MSsvaVZQYjVtQWF0?=
 =?utf-8?B?YUE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3710f474-3c1b-4dfa-17df-08dadfcd40ef
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2022 01:23:07.8453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t8LmAj7VUkuYZJYHTeOrwhIfFXSdmaEEQQ7ZWakOtxlr574FIqlSlksAuqpJkwM2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2811
X-Proofpoint-GUID: h_DD2hl669Fz0xzY05mJfdWzWht8XwMa
X-Proofpoint-ORIG-GUID: h_DD2hl669Fz0xzY05mJfdWzWht8XwMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-16_15,2022-12-15_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/16/22 3:29 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> 'struct bpf_local_storage_elem' has a 56 bytes padding at the end
> which can be used for attr->value_size.  The current smap->elem_size

'can be' => 'will be'?

> calculation is unnecessarily inflated by 56 bytes.
> 
> The patch is to fix it by calculating the smap->elem_size
> with offsetof().
> 
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/bpf_local_storage.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
> index b39a46e8fb08..cb43e70613b1 100644
> --- a/kernel/bpf/bpf_local_storage.c
> +++ b/kernel/bpf/bpf_local_storage.c
> @@ -580,8 +580,8 @@ static struct bpf_local_storage_map *__bpf_local_storage_map_alloc(union bpf_att
>   		raw_spin_lock_init(&smap->buckets[i].lock);
>   	}
>   
> -	smap->elem_size =
> -		sizeof(struct bpf_local_storage_elem) + attr->value_size;
> +	smap->elem_size = offsetof(struct bpf_local_storage_elem, sdata) +
> +		offsetof(struct bpf_local_storage_data, data[attr->value_size]);
>   
>   	return smap;
>   }
