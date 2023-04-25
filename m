Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999D46EDBEC
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 08:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbjDYGyG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 02:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjDYGyE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 02:54:04 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9806949EA
        for <bpf@vger.kernel.org>; Mon, 24 Apr 2023 23:54:03 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OJjMTU024885;
        Mon, 24 Apr 2023 23:53:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=XAIjyT1hUKuLT+yUhTOFKFWzuyKNJOUoiStaRGTD6Mk=;
 b=KFapzkvaBGcDtV16v3OSOpwg/LT1tSICFZcgeMoKzKjiZ33YArF79eMZPNXkbSkx30+d
 yOpmKNPtxAA8CJ7BAUwkz4vBO1g2Dcm/cgCsPFk1TAI8m6aWGDNZpWEv8Lxqpb4scjxa
 IvvP5l8i7FjWrbCJiU0UDt8Z5aSrnyvQWVk0E8Ut+V16PWDiO21qVzHEV+cqYO6dKwOw
 gJo/IaZDRhwvEzBjDUNPFTwEwhZZFlMb/5kgym3Q97Q8gTvyZjnEGFNxA7AzJLRoBdsN
 7AU6N5jk0nSMRLfHO/axPOj6/9UAWihSGItz1t2t4qHNB4vVlmyiblwDZlTAvwxVOfWN gg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q5ufcdj8m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 23:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IBgzmX0RSFraOCMhGC5QsPjm8JNNDOPKmHKdm3HLKslvADVJbD+cpcByVgaoPFh3bjE1tXh7f/Fsq+Ha36xHFdcocLZa9Pt2RaAj+fVN69W6MrMhGbZ7/dlipIUEkSACnEFqR2hpuS1sOh2d7ruw2VbYNHsU9d+c5dhWL0OmP22QSLtzu+kwyBMBWfte1aA4tvOWgnhb0Zlw4zlNIXuMhLh7rVlqs69sZNIDert1LFl3GfWaFid9kuTyROSDsruRZV53d1CdEDs7CnBB8DcxMMUSoM4tIZd2PY30VjaofVzH3bSRoG+ShvmDo4yw1//eqkK07gxp/LhJkgFE9vPOhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XAIjyT1hUKuLT+yUhTOFKFWzuyKNJOUoiStaRGTD6Mk=;
 b=DXNJ7Jf2nOQBHrLTNmlINMyxdj6cA5GVIqedWfyd5CojEBetjgblwDAxycTb2C3GFTjlFJpRq0Px6eVvTUin3Evm756RUfkncfhEirz7l6CI85SX3p+uMRfFMn28dr78DrdyvolfoTQ2kWB5c0S08OWXTnlMQnEaUfYJoWEEPt0hDERbbQxux62634Vc5DtNrcBN4fhMz2Bum/LkrWW4/kbIgIOVm2ezGMX+9Bx0mrv1n51rB5hXNy5ILDAe25xFq8rjVi6C4FKWWEo7dnKNfPxdOm7rLKVVFvAPDQWmbjYMbVz3mhG6ic8LIkoZY7EDvGAWI4L1VYN8l1aj3ONtcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by DM6PR15MB3749.namprd15.prod.outlook.com (2603:10b6:5:2b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Tue, 25 Apr
 2023 06:53:45 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::c787:379d:2ce8:e19d]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::c787:379d:2ce8:e19d%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 06:53:44 +0000
Message-ID: <142a73ee-e9b3-35f9-e0d2-d617fab43537@meta.com>
Date:   Tue, 25 Apr 2023 02:53:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH v2 bpf-next 9/9] selftests/bpf: Add refcounted_kptr tests
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Kernel Team <kernel-team@fb.com>
References: <20230415201811.343116-1-davemarchevsky@fb.com>
 <20230415201811.343116-10-davemarchevsky@fb.com>
 <atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd7tnwft34e3@xktodqeqevir>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <atfviesiidev4hu53hzravmtlau3wdodm2vqs7rd7tnwft34e3@xktodqeqevir>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:208:134::25) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|DM6PR15MB3749:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d3cf1c-e71d-431d-1d5f-08db4559cfed
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qE5Aq5bhC69ED9ACWGNyuVnk2jepCkHUjqXjlt36EHNlHwJXOnp2THCjLzNEwSesT3m/QQeFxKVc3mcscG2hqnYo5YyRF0XHDxrfqFs5ztwRXM88RXF7WQi7Kr3Pa7vrHdFmB8evNzdMQZcivUICODwWuxt+ozfD6ARc/qM1duxJ9dKiCL9qMBZr045gt03qhXbknAu/kVWZADTecDR4B+KF8U41oMvFplmvsbs6fiby/kDCxQRMbUkZ6NezhZBxWVak5GnvLENNSIrTT2yaXqkm6oP/OR0/U90UssR5RqXnBuV4e4JAuiY//VWY/bbp8WsrXvohYXebZucgvBL92XmhkWrXP/DlelwefrtfYPIlIPP01n6tgc8fGshLJrDewGJQedOvGr5/K0IDRBUoZuQ3PA32swiJxkgByc0mFeGgzq0NdcrLK2crBWZV5jBc73cOuyCBIgrwCEp+ES8BKOlhq2OL/NVj6rIgOABmhOQbww5BthX+xOWvsQXRmYc3PITZpmN0zc/NOUYiwUNCDqdFhxtT3giq5P9mGeEAUbsHh/2XWARBtvVD2SFEeEkpGQWC1WxtsNKTj7KwMiH1HZ94ucy1YTgXkGdmYRbueyV70TMGq66/qVchWc7xY81jIcDR2ytPPjHZ1/aAlswaXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199021)(38100700002)(6506007)(53546011)(6512007)(186003)(8936002)(2616005)(83380400001)(2906002)(8676002)(5660300002)(36756003)(478600001)(54906003)(6486002)(110136005)(316002)(6666004)(4326008)(66556008)(41300700001)(31696002)(66946007)(86362001)(66476007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEt2TFRQR3hzYlZ3cmdocktRYXFJUXl2L1owN2ZvQmVuTEp5MWVZd21sczV5?=
 =?utf-8?B?UTAyQWZqWDJnWk55dEI4V0lXZkI5dEhERkF2aVhkWEhNZDNWaENoQk1kMit2?=
 =?utf-8?B?WkUvSks5RG02Zm1tenV0RDU2VERVTmhhLzJFb1RKWTdieFkvR0Q3WUMrRzMx?=
 =?utf-8?B?SkJtZWFnd2NDcXh1YjJadGtINmU1MlliaklISWRxck93a3pNRmx6a1hhL2M3?=
 =?utf-8?B?S2hDVnI1OEV1WHpmbEZsNW52R1pxTzdIbEJxbmNsQTdJdmo4OEM1UGhNRWp1?=
 =?utf-8?B?K2JaMk5FTHhDZTdOWkhKeFAydGVPV0VFQzEyNnZKcDZacGRaVXduRW1ubnpl?=
 =?utf-8?B?RjZYaE5qNS9NakVQU2twNjNNVlE0TTduMEgzU3crQnBCUlRLZWUybG1YZFdI?=
 =?utf-8?B?UFB3K1FyM3A5T1JaYUtIckNMMmpFeVRQMVZ3QkxCRlByYkg2cmgrbldxb3dG?=
 =?utf-8?B?YjgwWGZ4MVFEQUp3UXI3QlJtdjFuWDM4d3FmVGVtdEJGTWFCSkI3ODM1K1JT?=
 =?utf-8?B?cmxmek1yM1hwb1ZHZmV1L2FFTG0vMHZnUjcrdi9wTjlpZGU4Z21TeHZXeDRM?=
 =?utf-8?B?djM5WTZTOHgrTnA5a293VFF2RCtiY01rc2ZVNklpYWxKdDU3NFo5KzcwYzBi?=
 =?utf-8?B?Zit3b2t1VXA2clU0azE0Vk1KSERldnAybmtIZ0loUEdRSzMwQVc1Wnc3MVg5?=
 =?utf-8?B?c0svcDNWTXFOaWtOcE9PM09IWk9ydEJUSFo3ZktnNDgyT2tsbHZoaHpPSVBM?=
 =?utf-8?B?QU02ekQyUG5qdWI3YkVnTkhaeFNna1JjSjVRbjlOMldDWGhDQ0plbzBvbXBt?=
 =?utf-8?B?b1FZZ2NYTTQreFZJSjB1eG8xK01tU3lFZktnV1pkQ1JhUXl3VldyN0F2eFZq?=
 =?utf-8?B?L1B6VENJaFRuaTBYSHdpQ29peXZjVzVJNlpvM2Z5T3M4VnRZVHV3ZlVRbnhY?=
 =?utf-8?B?QjhuWFRBYVRZVjJJdFFRaE1maE55aFZ1aGNHcjBaYThEYmtKbWx3bjhSU0xk?=
 =?utf-8?B?dFZLUXBybXNMbzZDWVJqenZqaVVIanVpUnJhTDJFY1d1WFoxUFI2MCtNTEpP?=
 =?utf-8?B?NitsMER4MG5pUzJpb3lqbGVKZUlpUjNWMGFaOTl0cmFPZFJyK3p2dG5NVk5H?=
 =?utf-8?B?RzdnSThUZUduQUVTZXZReEhwSjJKY2Y2OHRLbDFSaFlSeDl0N1dhTmJidWxM?=
 =?utf-8?B?WGdzR0h1cUVSRUhRVmNyUDdmSWF3c1ZXZTh4dmUyYnJCMCtLcWg4U2FURVVz?=
 =?utf-8?B?bXYrbXRxb1ZwTCtuMUFFSDB6WnpKdzVKdUFUZmZtVTkzSjJHS0ZreklWdTZ2?=
 =?utf-8?B?SUdtNFEzSEM1bEZTZHIvOEFDRks4a29rTkMyQmdNM29WVnlsYzlJUm44Ync1?=
 =?utf-8?B?WXJqMUdzSmRNVVdyVGNKaTZYdVB3cHRsUDVISmlod2RCRkFGYUFmaDNnS1ZO?=
 =?utf-8?B?bzhxS0p5Ky9pTlNyQWtra01ITHdzc0lpekF2Q3MrdEhGdjBqdXloMmNuQWpi?=
 =?utf-8?B?eWpzSVhKVHZteGhQQVdIQkxySGtmRXFKSHgrK1A1UllKb01pTlRuQXlQL2VT?=
 =?utf-8?B?S2p3TjNDU2hqQnRZNllyeUpvWDFJZTVTNmYwSDBDWHczcTc2MWlRbURJSDhh?=
 =?utf-8?B?UFdhaHRCa0ZlVE0xcWkxY2ZpdCs4cXpjQkh2MTQrSU13QUlGUjJ6d1Rvd2Ry?=
 =?utf-8?B?RkN5ZmtMSllTZVdVdWh3L3BNUGZLSnZIcDR4eVhMdGl2SGx0V1FnR2dhbzJ4?=
 =?utf-8?B?U25QZDZjeDZwVkU4NC96S1JzVkwvazlzeUFEeDdWajVjSjNqVHlqdFlQYkhB?=
 =?utf-8?B?bzRiVXNXdzNjaE52WWZOSGI1eGhuNE5WQy9qRGYwd1hadUcwSkYzdGFyWTBz?=
 =?utf-8?B?OHVPQXV5ZUtGRTFaYmdPSlFEcU96TEJDUnkweTl6RzdqMmZlSHkrNk13Y3Na?=
 =?utf-8?B?UzcxRVBlUmFud2hTL0p5MU9nQjFvS0s1ZUVyVWxGZGNwWlhtM2FkWERuZHo0?=
 =?utf-8?B?d2U1SkRWQ2JtS1huU0d2TTljcE1CTnhUNmE3UkN1M0FBUGtQOWNjdW1jV3oz?=
 =?utf-8?B?NGVJd2tGalFaQ0xOdnJtdndVc3c5TDFwcElIR0h2aVZYcmttNXk1ekRheUFr?=
 =?utf-8?B?ekpWb0N4a3p1YkwwMHRUQkhseko4RDNqdUJ2ZldTZWNjY21WNVF6MEQvcG5W?=
 =?utf-8?Q?7dyZbBaxaly8yeQQMf7/8PY=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d3cf1c-e71d-431d-1d5f-08db4559cfed
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 06:53:44.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOu+9JhF56sALAr4RyxewYmgXnM8wnYT3lMMy0LuF7AyRLEKsep9IzCLxS/UZmlrJPECW69TLMdZgJD70T7RJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3749
X-Proofpoint-GUID: P-wSuXjg1e4zUzazQSJ8HbExWHaG84I4
X-Proofpoint-ORIG-GUID: P-wSuXjg1e4zUzazQSJ8HbExWHaG84I4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_03,2023-04-21_01,2023-02-09_01
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/21/23 6:17 PM, Kumar Kartikeya Dwivedi wrote:
> On Sat, Apr 15, 2023 at 10:18:11PM CEST, Dave Marchevsky wrote:
>> Test refcounted local kptr functionality added in previous patches in
>> the series.
>>
>> Usecases which pass verification:
>>
>> * Add refcounted local kptr to both tree and list. Then, read and -
>>   possibly, depending on test variant - delete from tree, then list.
>>   * Also test doing read-and-maybe-delete in opposite order
>> * Stash a refcounted local kptr in a map_value, then add it to a
>>   rbtree. Read from both, possibly deleting after tree read.
>> * Add refcounted local kptr to both tree and list. Then, try reading and
>>   deleting twice from one of the collections.
>> * bpf_refcount_acquire of just-added non-owning ref should work, as
>>   should bpf_refcount_acquire of owning ref just out of bpf_obj_new
>>
>> Usecases which fail verification:
>>
>> * The simple successful bpf_refcount_acquire cases from above should
>>   both fail to verify if the newly-acquired owning ref is not dropped
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>> [...]
>> +SEC("?tc")
>> +__failure __msg("Unreleased reference id=3 alloc_insn=21")
>> +long rbtree_refcounted_node_ref_escapes(void *ctx)
>> +{
>> +	struct node_acquire *n, *m;
>> +
>> +	n = bpf_obj_new(typeof(*n));
>> +	if (!n)
>> +		return 1;
>> +
>> +	bpf_spin_lock(&glock);
>> +	bpf_rbtree_add(&groot, &n->node, less);
>> +	/* m becomes an owning ref but is never drop'd or added to a tree */
>> +	m = bpf_refcount_acquire(n);
> 
> I am analyzing the set (and I'll reply in detail to the cover letter), but this
> stood out.
> 
> Isn't this going to be problematic if n has refcount == 1 and is dropped
> internally by bpf_rbtree_add? Are we sure this can never occur? It took me some
> time, but the following schedule seems problematic.
> 
> CPU 0					CPU 1
> n = bpf_obj_new
> lock(lock1)
> bpf_rbtree_add(rbtree1, n)
> m = bpf_rbtree_acquire(n)
> unlock(lock1)
> 
> kptr_xchg(map, m) // move to map
> // at this point, refcount = 2
> 					m = kptr_xchg(map, NULL)
> 					lock(lock2)
> lock(lock1)				bpf_rbtree_add(rbtree2, m)
> p = bpf_rbtree_first(rbtree1)			if (!RB_EMPTY_NODE) bpf_obj_drop_impl(m) // A
> bpf_rbtree_remove(rbtree1, p)
> unlock(lock1)
> bpf_obj_drop(p) // B
> 					bpf_refcount_acquire(m) // use-after-free
> 					...
> 
> B will decrement refcount from 1 to 0, after which bpf_refcount_acquire is
> basically performing a use-after-free (when fortunate, one will get a
> WARN_ON_ONCE splat for 0 to 1, otherwise, a silent refcount raise for some
> different object).

Thanks for the detailed feedback here and in the other thread in the series.
I will address the issues you raised ASAP, starting with this one, which I've
confirmed via a repro selftest. Will be sending fixes soon.

