Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0674D52F1DD
	for <lists+bpf@lfdr.de>; Fri, 20 May 2022 19:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347165AbiETRrb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 13:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346185AbiETRr2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 13:47:28 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159A76388
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 10:47:26 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24KHSTnk022545;
        Fri, 20 May 2022 10:47:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=LtyNjLjFcy97SzC5oCWvmKfdSVmsrnrSXnxXOIAdHLw=;
 b=ezQgKqWNcSi19oqUK3xnRPE8SzkxeDeRhqM9rNP4HfmOAIB5gA+pMkmQOdDDB5/gAMS2
 xccENOU3j/8ALgK8Z7mU/sb8IJD6Ko1z9iELhiph2kNxVxva6mKDca6i/JbCVJzxzhbv
 12S1V3gwtg7h841YZPJpMc/VVSMK+xuEmX0= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g6bja1yq3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 May 2022 10:47:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfBFOhhP0vXCNBuTTcFNKLCCJAtbXciIf4tv4gmlbrDclcsRJ5bkiIknLXv3FtcvXSJ/fOl1FccIDEv/WtFlX2ZAlb889foifaSawBgEqz7Sw2m6jJa5G3fSjueNq80Ir4wnmoNncyctE8h8fLOk/UhMQcULgBqHYmmXY5y8qcJTSAklwZwFry1jxnq2tdwxkI1F1/PDuArDWLucDqPPC/3/KuE5WPyUxUuz1qM4km6l2lRuUH4IghTlIhYNlDtWnLgHdxzJ0T5PJsEiwSq4k+VKN+kk++uI40GRhdNtulph7IrIvQc1Jx2MMVhJLkmYrRE3qhI9fM+IVowBauKTqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LtyNjLjFcy97SzC5oCWvmKfdSVmsrnrSXnxXOIAdHLw=;
 b=DE/M6sgm4ey+4Ei/69gCiX9wX0CYpPc/bo9nLEnQkTXhTHyeLjqLAukiopjnapWfuKldXrwWhkC3km2qIkuquII97toSFzZlCA89pzoFfCYOhlbSUwFbA6HqkegpX116R6/VyLU/DBaemCfzsXQLxt4nfpmApYH7NNEkpnNUKQzx7bWlSrcdc3Ny1fWaDvIhdJM1D8iamuMTxHWkCc1ugtbzAxiGXw0Zk55p4xgS7ceOPxRsTR2bCcXqFuZN0nNXKMldFGenf+TIK1RRKZlcCI+lziylRRTg7jXOayNzHMmqSWSvqOTeR4PyXNkQfaCkNraZsbKe5iTDws4LIObzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4709.namprd15.prod.outlook.com (2603:10b6:a03:37a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 17:47:11 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.017; Fri, 20 May 2022
 17:47:11 +0000
Message-ID: <05459750-39f4-6838-a05e-8dc0aa42721b@fb.com>
Date:   Fri, 20 May 2022 10:47:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next] selftests/bpf: remove filtered subtests from
 output
Content-Language: en-US
To:     Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com
References: <20220520061303.4004808-1-mykolal@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220520061303.4004808-1-mykolal@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:a03:100::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2d2c44c-3ece-4a92-48b3-08da3a88c4af
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4709:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4709917EA6B5472050DD9785D3D39@SJ0PR15MB4709.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azRTeaMY+1dj5cl6Kpezgeln2JsN3MGniXF25xWxOKPPtBYfpGJYp5mClLuS1uEFR+1su08VwDT4gGcJVXTV6/oTzUcx6im+V+nn4q4TJo+fFezTdwoSEG6FSxmkyHBq+W/uiGxMgeYdtnpnlF8yB51BEzCrDiJw3fgzKO3G5bNYhO3SrPTXvPX1w4TNxoHs76OxiNUuvFhxW6lG6kV730rgk2O0Fiat2TghaPTAZ4cC9eBrrDi7wYr5imcbX9qltE56XiA/agkkKtWRk3sJ5XW1GtdeBNBT0iIeeEqzTJgx20Q0PbpK4+RZ3W7TLVUQRCKclzJ3Pq8b3XHvuqpNlqWr70mFftTlI44u0o//Ca+2ON+oXcASHEPDjkRT0Cev1+03fvaJfCKuXuPhsbAWNShstmHkVRdVwBhailERXSlcZLIUgeB4hzEivelZc4H4b2Zkul6kLXKlHFI00iL4phPE/+1fUccipCW5sCJgtRojE4QMIl/Q0igdFIdaLp/lshogYhEy/OjE0C1uImMD516Q6OGUXEIVWiNhAITUesKLpEGfhQX3BG1phvHTRvMVvRlSA86WUzkP4JrDSSkqwaTWyFLqaYm+Vj/zXrPyyK2gbaNSTAOJqglLV4N2STOXfC2dLZMAIskeDy5cKVJ+9V14GEy8TCUiLuLvYKRzuFCqqk3F/z21vONs31KOt0yCnw+xvnFakqtunMM2mTvrgpX+a1vuD2Cp++MZtlD+i6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(31696002)(86362001)(6506007)(53546011)(31686004)(38100700002)(2616005)(186003)(6512007)(52116002)(2906002)(5660300002)(4744005)(508600001)(8676002)(66556008)(66946007)(66476007)(8936002)(6486002)(6636002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXFPeHVvOVJET2VaaHdjcitaMGZNQU1ZRDZOMDVTWGJaNXViQ1gwUXYzZlhx?=
 =?utf-8?B?bEc5a1AwZVAvbFVtSTRwN2xkWnFPa2ZBdndVSVZxQXRFYnA0SXZ6MzRJbmVY?=
 =?utf-8?B?cGZmSUJPZCs3REJ4LzhtR0FEUXY0NmpWUUxURmUyZWUxUXFIdzd1TXo3cUdk?=
 =?utf-8?B?MkRYZ3poTE9hQ0V5S0Y1dFhkNWxKS2IrcTJrWGtFT3owTGUzNThvczVTbnlv?=
 =?utf-8?B?L09ibEhwVC83UmZlcjJ2QzNwZ2JsRmdtKzBwTzFWdS9iMTJJWmVlQ09kRnAr?=
 =?utf-8?B?bm1QMFUyQUU3WUF5UHBCREVid3BYdmc2MlhqUzJpbDB3dW9XUjVoME51c2lF?=
 =?utf-8?B?V3pDbUloWXpsMG9iOFpGaEtnU1B4OG05K0JHc21zbFRTZWU4c01keTROaFRq?=
 =?utf-8?B?bFdxWWZSaEZMRlpEcDBhQkkxeEd5VFlyOU1HZWlQYVBNTDFmTFRRK3FwSzRR?=
 =?utf-8?B?VkgxODd5cFZGQWRiZzJGUTJIT01wZFZJcHJwSlhKcDZiVEMyS09USW05Njgw?=
 =?utf-8?B?T1c2OHdDdjI2b1V6a0l0UlpjOEppTU4ySUZEemVzVFA2aXIxYmlHV0x2c0hR?=
 =?utf-8?B?ZzI5clc1V2d0eStOSjJsYTcyeEcxT2ZPcnVHR2xuYlJ3QXBiWDBiWlhxOThm?=
 =?utf-8?B?ajRvbDRsd1I5dUd0ak5RR2l1MUs3enpPZGpGNTBJVEtUV1E2N05Qc1Z2RkZ1?=
 =?utf-8?B?UDExV0pyQWkzMXllamdEazcybkdPV05xcmtsWDRxRzVHTkxFb0IyZFBWYTY5?=
 =?utf-8?B?NlZjdzFLcjVIemQ2RVNWWGs0UFVhZ1VLVVNIdG5TcWMyaW5UR3poejM4ZEtp?=
 =?utf-8?B?YlZrZk1JU0pJbWVoaWJ6MUdIejg4N1dzU1Y2aVBnVFByT3VHeGxXMVpEZTVZ?=
 =?utf-8?B?dUFEdnYwRG5oblkvc3JIbUNtd1dxTWxYWEdtVUlsalVXZzcyVmtBL2p5U2Nw?=
 =?utf-8?B?Qk5pL2dUZ2xyTzB1cGhLMjljekpVYi82RGlhektGVmxwd1QwQnlGelVMbFFQ?=
 =?utf-8?B?ZTlER1g1OEQxdlE3eE51RTR6V1FZOEJQYit0Q0EvSWY1ckxRekFjQVk1eXVi?=
 =?utf-8?B?YTlwdk1XeWw0Z0U2cEFQaFJsSkVHSEVUTWdzbDFhRjU2MnRHbXp1bjAzc0ZJ?=
 =?utf-8?B?Wk9udTRCM0dmTzk2YkNzbW1ud3RnNGxxM25NUnFmOHhtRUl5TVhrYmNJOW10?=
 =?utf-8?B?empNZ3NZWG8wb3NuMlZzK0xZZ3l6Kys0WVEyWkNuSit6dEpxaUwrRThJUkIw?=
 =?utf-8?B?NVpIT1oxWW1RY3BoRSthRXk1N2JjNnFuMHRPWnhpOWhOMXpaZGswaCt2MUM3?=
 =?utf-8?B?NmJmWjhvYkFHMUlnOTRSS2M3N08vWUpGTEh2L2cyNy83MGRIcnkwSk1Zc2FP?=
 =?utf-8?B?OGNuZTNqQnQ1bzlRMTJEVFhlK2djV1pXa2ZObU1JWmp1Ukh5UkRROXpqZFl5?=
 =?utf-8?B?L2xmNnc4UGZTazlBR1RiNHlxTHlPWk40YThINXF2T2pBR0J4TXJqWFBaaGRP?=
 =?utf-8?B?ZEp0T3VNdHNKVFQzMldiL21IYUNkWXNpUVIxdGR6WjFwR3pjTHVzQ2ErZHZX?=
 =?utf-8?B?blNubUZXOURDWGR4R1RHd0NXd1MzY3crUUhmOW02bWFBVktuemQ5UWU5b1Bu?=
 =?utf-8?B?QlBxSkR0a2x6MzUrb1IwckJSSzg3Rk5YUUQ4WHFEbDEyQkc3QkhMVVFseTZC?=
 =?utf-8?B?ZjJZUlVIdTE1VTJUaFI0MjAwZ2tGelVDY2hOTFpnbWRWak1CWFJTalVnQ3hB?=
 =?utf-8?B?MzdhZTduOWtGQ2xQbmpUNUtaWE0xN05QMVRxa1hJSGY3ejlnaTZDbmRlc1NJ?=
 =?utf-8?B?RS9keUdZeGhLS0xHS1FWajUxRDF4RDdJdDF2dzRGSXhmWFBLTTVJMkNOT0JU?=
 =?utf-8?B?YWt2MlQwK2ZESUZpQWE5bEZzQ3BwRnRoSmtDZS9pUlVFQ1lyenNuNzJhek9h?=
 =?utf-8?B?OTQxN3E4V01xenlCeHNQWUwxL01TT2FzeGZWNzVrV3lpMTIreEcvNEFmWStE?=
 =?utf-8?B?TmF5MkU5MGJveE9PSkpEVVhQaWpzNnlqM1FVV3oydTJvN0FVTG5nTTJDazhR?=
 =?utf-8?B?QTBybFpmUml6blZvMkJHaFpETkJ3b2hnOWx3WHplalo1TDJGMkNqU054TVI2?=
 =?utf-8?B?ZkRsVjJNQklpbmFQQ1N4c2xNbkUxVGRoOXpkcnN2ajhKSnF5dDRRMWxTMWFH?=
 =?utf-8?B?WFJtKzdtd0FNNmZnV1VGMGdveGQ3dnpzbFp6TGh4UStOWW5aeVB5cHliT1VT?=
 =?utf-8?B?Vjcyb3NjSHlsTzFnT3pGL3lpVEwxQkZYdXZ5c05lb21yQ0ZLbjc0SExMNTVZ?=
 =?utf-8?B?ZTZHTmZaaTlGdTlSYks4TUN3Q0M2YzRZVUxIcFY5UUlKYUppWjNjWHp5OU1O?=
 =?utf-8?Q?7Ubh59AXdyeHDGE8=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2d2c44c-3ece-4a92-48b3-08da3a88c4af
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 17:47:11.7381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkiTYsNrEX+cjn4ssnWrx5ZsG+uuEOMyuhkSknajE61A5Z9X/hFUYJfbyHleE9ek
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4709
X-Proofpoint-GUID: hn-TIZBQo2csMrUnwCKAr6piBF--pcvV
X-Proofpoint-ORIG-GUID: hn-TIZBQo2csMrUnwCKAr6piBF--pcvV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-20_05,2022-05-20_02,2022-02-23_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/19/22 11:13 PM, Mykola Lysenko wrote:
> Currently filtered subtests show up in the output as skipped.
> 
> Before:
> $ sudo ./test_progs -t log_fixup/missing_map
>   #94 /1     log_fixup/bad_core_relo_trunc_none:SKIP
>   #94 /2     log_fixup/bad_core_relo_trunc_partial:SKIP
>   #94 /3     log_fixup/bad_core_relo_trunc_full:SKIP
>   #94 /4     log_fixup/bad_core_relo_subprog:SKIP
>   #94 /5     log_fixup/missing_map:OK
>   #94        log_fixup:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> After:
> $ sudo ./test_progs -t log_fixup/missing_map
>   #94 /5     log_fixup/missing_map:OK
>   #94        log_fixup:OK
> Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Mykola Lysenko <mykolal@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
