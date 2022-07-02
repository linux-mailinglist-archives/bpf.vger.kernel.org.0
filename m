Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B4C563EC8
	for <lists+bpf@lfdr.de>; Sat,  2 Jul 2022 08:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbiGBGQe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 2 Jul 2022 02:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGBGQd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 2 Jul 2022 02:16:33 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956D41A837;
        Fri,  1 Jul 2022 23:16:32 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 261NSeoG027823;
        Fri, 1 Jul 2022 23:16:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=Ebk6ANhet4qEjKkYpQuJbhfIQh8z5PgMeoOwCX8XOeE=;
 b=EesdfmN2GvW9vBmdyYwiK4LoMWaVrghG8Chcg3je1r0scr1OCd3kJczFG28sE1qSI9/N
 cZFHBHEJlNz8Wfa09rDjRNv1xa2q0SimHYDiVrLGEaT5Yt0GmYXeHXWGWkoxqfX0h3q7
 3cx5LrtvKYtjt7JqHZRilRjCbeYX5OhCa80= 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by m0089730.ppops.net (PPS) with ESMTPS id 3h195ad9g8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Jul 2022 23:16:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EfeHpPAX+seC0rkW1tpB2xUmZueFVl1FFaEEiTG8sD9877rP982PDKIfPge65ALrmudafzyQoJJtI2lw3ymDs/gBFXy7MR3py92UMyCQdkHnv9oEc0YgOwJ7eSmJCGGdGnHfdnxcBxZgI/eg0QvU1mlkD7FMuZeRqc9kl7nDXBSMPusGNVcXFLI5B+UKhopPZSKZBSzqzt/zfD4x5YcjTuoLkreZYnSqJ7Wj0jpU2X6RR77LXwTLdZq2StD2bfFwRFRhO+BsLEzKUn1INy8EGauj9tJGZcrv32ZnaoNiM9CEKGdD9HGTM6ATMONDVcU+rOTdxLPID4ALqloQ/+FwMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebk6ANhet4qEjKkYpQuJbhfIQh8z5PgMeoOwCX8XOeE=;
 b=fcCQmtUdLc+K9o29B5QFcR0Ep8FArYLaZsTLZLDWKbHDmjCk4S5SaKJgmsgOpGoTKZa7fdBixY6wDzBUUbvklstHEQuBFQ7LtdlRVqPQuezPc8PD2M0DmC3XWBGdez2uZKwRYLWDqu0bmqrTcjnDnz1Xlx4xqBi8HUq+6z9Ji88qwmW5BhxzOo/0Hs7Bz5wt/nJjLWomx+Qem9cC2Ewa7fiF/DpI8taDevKROQ3qNUHNRSXV4On1c7Zqm8svQqWImSH7ersBqn+pdvvwcp+IJWGHDGISKJcqDf4MPrdpUMZekWl23zVR0cxkdcEeJ1S931FjOgAql5+9GsAX6pulzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM5PR15MB1163.namprd15.prod.outlook.com (2603:10b6:3:bf::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17; Sat, 2 Jul
 2022 06:16:07 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::acda:cdec:5c2f:af77]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::acda:cdec:5c2f:af77%7]) with mapi id 15.20.5395.017; Sat, 2 Jul 2022
 06:16:07 +0000
Message-ID: <4fe6d1f1-32a8-7e4c-33fa-66cab1a295f7@fb.com>
Date:   Fri, 1 Jul 2022 23:16:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: add a ksym iter subtest
Content-Language: en-US
To:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net
Cc:     kafai@fb.com, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, jolsa@kernel.org, mhiramat@kernel.org,
        akpm@linux-foundation.org, void@manifault.com, swboyd@chromium.org,
        ndesaulniers@google.com, 9erthalion6@gmail.com, kennyyu@fb.com,
        geliang.tang@suse.com, kuniyu@amazon.co.jp, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1656667620-18718-1-git-send-email-alan.maguire@oracle.com>
 <1656667620-18718-3-git-send-email-alan.maguire@oracle.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <1656667620-18718-3-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0191.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::16) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0b10f10-b070-440b-0fc2-08da5bf25983
X-MS-TrafficTypeDiagnostic: DM5PR15MB1163:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NMqIsca+y8o7itOb+hqOJsNejWCrsAontdYEkpVSq0+oSUZgX/HoKdJ8ARTLq68rMQG+gMc3WUVVVfTWuezYtV72ympNgKFn0iV9HxZQUQ9r6JY3D5qMYqiT8mKbzNGRC9HOsRiCRGsnR6LXKMMZS0wM0lqAbirR9jGMzfEcWB/4EbQhGquwWvO3RqXZqyzVPeRpqGd19ikHolg0kNtECR6S8+5CHmpt5Mv4iEzOmb5JMOdZ04BBmwBS3SO/px+l1Z95nbnR4f1Nd4MWGXE/X1c4XiU343AMRsJkVPcJdusJCzZWTJlWo0/jc/SW5ATGU3Ha5flVD0mBuZqJIdHFNR2cUk9qduOAhIhx64O862ly7f/VPnuHjvrUgqD95E8Hj8x/ngIo/o+pzflbH4mnkleljw5D4kmym7cohhvspRjJMMo9mzhIPFw4psq5jiQ/WjoQWucI4sYUO+Gz25s/PyzNI7E7O2htprl16Wt0Jx+l88v+8uJ9mteWWB30zCGu0+MI12bNRIsZkAsPAU9uDtX19AATktQ5CztWDJO1Mjb5An1ZX41LeuKK8mzPqWM5IdLhnyCmJ+3hc9t8KTprRw3cCeOb5/G53RF2zOAgRwEWJbOeacAko+7a1S5unFkivMzcekDPDoeTWo8p01+IYesAIonKSOBum7p3aAcU99OwahSMUGod0jI0uRGI7G7q4SC36hywxfDBJvFzTEsBv+OaSISlixHa0FyYXRPWV+QaTJ2fDtr0Ci5EXio+1Ro59p0PspcouMQhZQCtxh1hsxeKdJM8NVIz6TM1cuZYysZVes+4+xSZWbFMELg/ZI1wVoOH0pb2HX/oQNsbf4jgHYVS74lzpKTves04/3AWv1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(5660300002)(7416002)(6486002)(8936002)(478600001)(2616005)(186003)(83380400001)(8676002)(41300700001)(6506007)(6512007)(53546011)(31696002)(2906002)(86362001)(6666004)(31686004)(316002)(66946007)(36756003)(66476007)(38100700002)(4326008)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEFRSmRYc2c4UWxrakJIbWdXVWJZcWNoM05KUVRxQmN5ekdJMmNiVGhjcTFl?=
 =?utf-8?B?WGF6UGl2ZS9keHZzakEzNVB0MldCVTZZSnRHNUR4YVdWV0RycXJkRm1xaWJr?=
 =?utf-8?B?TXlLUUE0eDcvRGhuaGRPbUh6cWNkK0NvZU1ValYwTEJWZEhTTE1LV3dsVFRX?=
 =?utf-8?B?UUc1aGZLRFNYSGl2TEZTYjZLU2RZU3FWM3NSc3hjRmFRZHo3b3VOOXUwakh1?=
 =?utf-8?B?S0dORFBua3poYTk1T0F3Y3JOSEMzNVpnaE05eVYwVDYvcjJwWE90YWk3Q2xh?=
 =?utf-8?B?UzJlWFBaMUR0UzIxYkFPdFJ3SnpUbDdHM2NmYnd3R2JKN3E5bitaQ3c3UkhY?=
 =?utf-8?B?UXdmeTQ4Zmp4Y2c4TVF0dEdCT0M1MzF5ZzhWdmpJVlFEM29xajNUOE9iQlBn?=
 =?utf-8?B?V1Q2M1dOR2dpcENRYUNjbW9DNU9iNEUvR2NtTmpFMmdvY09NRWFxWWNPUXNa?=
 =?utf-8?B?Mjhyc0M2RlBVMjFpWVNlZEFpM0ZlclBoNEs2MkJYRC9ObytnaTB2SXVLVVJv?=
 =?utf-8?B?S0ZJQkEvZ1U1SjBTT3lhUElheVJPU1E2YWQwNmltU2VaTlZXWDIwRVFJRjBh?=
 =?utf-8?B?WnpQWDAvOW1tSmljWW1YNU5zeVJBNGtGTTUwYnZMdk91cXRxNm5FNGNtdDFn?=
 =?utf-8?B?QmMySHl3bStpWG9HUjRHRzdCTkNqcFU3RXlaaXd0Q01XVlVCQXh3UW1xcXkz?=
 =?utf-8?B?Qk8zNWszWXRaSVYvRUgvejdaK3lLekhselUxdmlOR2xKbmt0cjFwSW9HTzE3?=
 =?utf-8?B?Zm9KMG4vUTNiMDhDdUlpVHB6OHB4T3RodVBwcWt2emt2QXVoL1AwWElHY2Ix?=
 =?utf-8?B?Z042ZUpaVnMvUkFwOFVLd1p6RjFKM0FEWkRjMW1FOWRhaEdLd25BMjhwcUtZ?=
 =?utf-8?B?aGxlT3FIM3p4anUrdE1kNkU5dlI4MUpPWDBuMFB2cEUzdjlEQWZxdTMxT0xt?=
 =?utf-8?B?N1FGSkRka1ZXU0tpcUs0OFpxMHdZMXVMTDh3ZHprSHN4Rm1SY3lHQ05QVjRr?=
 =?utf-8?B?NUZOU3BDMjNvV0pTbmtYa01rVHYyM2JKZzJxN256ZENadzYzeFplekpVL25I?=
 =?utf-8?B?OE9ENFVrMUxVcHZEelZmcFQwU0lDVWMvSEkvcmdTdDA2allJdnBzSHlGbjVy?=
 =?utf-8?B?LzhXUzB1ems5aFpod0Q5SU4yU3o4OVFRRk55R3lpSXBKOXJwUVJoUVk3Sjl3?=
 =?utf-8?B?WmVRMnJGZFRmQ084RU5ReDBDdmVkVFlrbU5sWFBKOGhKa3l1UWJHQUUyRzd1?=
 =?utf-8?B?RWRhWkFUUVRDYm44NVdHeEJHSytCeW53dFZIc01vbXByb1hwZXp3UkFReVN0?=
 =?utf-8?B?d0pHOFk3cml3ci9STXMwY0VXZXo4Mk8zNFpDV0lQbEpVY0J4Z004eTJ4L25i?=
 =?utf-8?B?dDNwWlpjQVc3Q1hqdDM5L0lWT25kbm5zNXJzR0NGdUdSdU1oRmd3dVNDTTVo?=
 =?utf-8?B?Y0NxSWpTdnVWTHhQTHV4a1ArRG5Zd1ZURjRkbkh4cXFsVVV1TWIwR0lJWmo4?=
 =?utf-8?B?STNuYktYb2NaK21LazFKSXRIczFES2RRQlZDRVowZlBITlYvZVpxY2xYTkJm?=
 =?utf-8?B?Z1RDVGR2TUZCQStiSngwTGtKdytkZ25PYjNyeURrUnk0NlhoeVh1Y21CTFE5?=
 =?utf-8?B?QTlkTFlGdHd3NUF4SFFPb0VxdmtGT3JFNVRWU0FrbWc4MjdMaGVBVTNqbjF6?=
 =?utf-8?B?Vzkwdy8ya2J5Yk9ZTXFyc2RER2RwdjcrM3l4cElKZVpNQldFUUxEVEZlTk00?=
 =?utf-8?B?OTlxS3g3SVNkZ0Ewd0lEbWhEbzd5TTJNaEdjWEZkVnVBdTJxUFBLYXZ2TXk3?=
 =?utf-8?B?aTFSdDR3QjR3VTZJa3VobzN4T3JNSDRyb25PTngyM3ZmUE1MNS9jNWNJMTV6?=
 =?utf-8?B?UFFhamVaelVaWUtPc2JQc25RZXVFMktrL0pxY3JQV1Nsb1VhZnVITFZuR25v?=
 =?utf-8?B?Q1dEM2U3OHpST0d6b3NFZGZ1RGxKbitaWmRLTVZsTFBBWVVONHZVMXE1Wkl3?=
 =?utf-8?B?V0FKaGJVVElSWGVNM0s4T1FPbDRnZ1gzamhDeW52RG80djRCSzJMZWs1a05P?=
 =?utf-8?B?Y1kxN3RpalZId013K2puRmxMdFN5R2l2VFppeXZkYXVlRGVrWTFqenpIcnpW?=
 =?utf-8?B?VXVJL2F5M1d4QjdEQ1dzRjl0VU1mV3BKOUsrV0VhbnRpMTB2R040T2xNUVpQ?=
 =?utf-8?B?MXc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0b10f10-b070-440b-0fc2-08da5bf25983
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2022 06:16:07.0977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UfdJPtNfhUD5+4UtlXJ68qhq1aR97tMAI6+D22hv1XLrPaTzGCkAz5kVNodnnKfF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1163
X-Proofpoint-GUID: Ch03JkyG7DFHb4rpsNZD1sOld_Ra9D0j
X-Proofpoint-ORIG-GUID: Ch03JkyG7DFHb4rpsNZD1sOld_Ra9D0j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-02_05,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/1/22 2:27 AM, Alan Maguire wrote:
> add subtest verifying BPF ksym iter behaviour.  The BPF ksym
> iter program shows an example of dumping a format different to
> /proc/kallsyms.  It adds KIND and MAX_SIZE fields which represent the
> kind of symbol (core kernel, module, ftrace, bpf, or kprobe) and
> the maximum size the symbol can be.  The latter is calculated from
> the difference between current symbol value and the next symbol
> value.
> 
> The key benefit for this iterator will likely be supporting in-kernel
> data-gathering rather than dumping symbol details to userspace and
> parsing the results.
> 
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

LGTM. Thanks!

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   tools/testing/selftests/bpf/prog_tests/bpf_iter.c | 16 +++++
>   tools/testing/selftests/bpf/progs/bpf_iter_ksym.c | 71 +++++++++++++++++++++++
>   2 files changed, 87 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_ksym.c
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 7ff5fa9..a33874b 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -27,6 +27,7 @@
>   #include "bpf_iter_test_kern5.skel.h"
>   #include "bpf_iter_test_kern6.skel.h"
>   #include "bpf_iter_bpf_link.skel.h"
> +#include "bpf_iter_ksym.skel.h"
>   
[...]
