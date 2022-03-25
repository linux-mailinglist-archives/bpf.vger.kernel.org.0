Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E38B4E7BAA
	for <lists+bpf@lfdr.de>; Sat, 26 Mar 2022 01:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiCYWqc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 25 Mar 2022 18:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiCYWqS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 25 Mar 2022 18:46:18 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCB1210478
        for <bpf@vger.kernel.org>; Fri, 25 Mar 2022 15:44:42 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22PHObx7009398;
        Fri, 25 Mar 2022 15:44:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=TlZ6OsIvtfJDtQvoou+QRDyuJmiZbatjwT3GzINmGL8=;
 b=lveUcjJ9QL68TnNZoW7DPQU0qSGWVorno98UyodSl59A9k8VHfLO7SUKSnMKdyBslPAZ
 9yTB9GA4JqFE9QLSqQm91i87cV3/M0s2nYcXIckjhEb64GqX7C13dO5yuLtEd+kIuKpV
 mnexyBX5cGsZh0iDa5hHpBKhqgr5XsQXNrk= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f0n6vyfus-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 25 Mar 2022 15:44:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAEtox40gvdsEYZsO9A6z2S+ZMQ8G0U3xLooM7YoVkVHsvIVym1UyobbMkZzB0uc0MF2EDt/25WdjhqXEgM4BR4iRxkXhU5ibuL1N0XHh0bzvf4TKZ2pc+yuLx/9y927XxbnVfVBHGhC276d/ZrStXHYHERjqwCTQhty8B1Hsgh950eOyB+8eIMIl2RRIWsk5y/6CrbmTn/rs9/1zvxrlh6914PD0wChtz42u3AIcctsAmvXHPGt65m4UYEiRKLy8swJewOyCSDPn4o2jw4RCvKfmscuAFSzqnzaoAXEb9WB24BaGJS8XTGPU62R6WbbXGVQ0IO2XlijoVvV+53OJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlZ6OsIvtfJDtQvoou+QRDyuJmiZbatjwT3GzINmGL8=;
 b=ij0vBzfVseJxJX4yyva8BOykaVYsd0qZJe84BXxPR2+nBt4oXVkfb1RKpVgfP+5Cl5XibVPwFckh06sWee+41JMEyqbN57Xl2Ak6j/FYmtUhjHBc8NSdQFsEU1MnVrhNsEEFcwfjv2oxMce1UbBd5/rvMFv6HckojXSKsEuR9CYwk126aO1zOn/LE/MySRJOjvfG8tife9FdtQI4/oqQzpOnLCYT5SziA0TUhEcSPOVHdr5FGsPZrrMNTH/+pFMmfJBJics/2K78Dv1YNreKH8er0ocxi3JeMNPKPAzud717nTgi9rsQfR9WH/AFu7xXjA2WGZjsGM/dIGehy19+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3449.namprd15.prod.outlook.com (2603:10b6:5:16f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 22:44:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 22:44:27 +0000
Message-ID: <5b9269d7-b5bc-ecd6-093e-a9e8e770b95b@fb.com>
Date:   Fri, 25 Mar 2022 15:44:23 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH bpf-next] selftests/bpf: fix selftest after
 random:urandom_read tracepoint removal
Content-Language: en-US
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com
References: <20220325222314.3838278-1-andrii@kernel.org>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220325222314.3838278-1-andrii@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0036.namprd16.prod.outlook.com (2603:10b6:907::49)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c9c609fd-f5be-40ec-5daf-08da0eb10424
X-MS-TrafficTypeDiagnostic: DM6PR15MB3449:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB3449F31D016672DB5B7B29D3D31A9@DM6PR15MB3449.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AbbI26u1MrAg6Q3MNuRSGuvEtnnYaYxj9L2Np09kCNPVpVDl4/n5G/RWwM9rY9ExiiNAFcLW79coS0j+/DnUE5VWCJ+m3/eWlJaC8yN5liKFFrP5zV2Yl1fanFUGRojG0fADovHvd+Ped2g5lhr2YyM979nm4BY+VAAi24oL8/gEhYwYTJLpurIWUV5tX9PLsgBoqaNBmprZ45OnehrIJPpCU1XSHAKkczhdTCHydnyFZxfGbaIXl0+owkva2TdAj2phj2k4zYoitzphj6Q87ZQaE5WPC4EHn3gNJ4UTMR1asLYG8Ys5NSUCkcTBigDddFrzZFo+rKVGWVzJlbzgNGdVXdVygF82swVvpbTES1BM8gjYmh2Dy1vML3vxlWvqyksCm/znHqKlFq2LSzVkdN2YdjdHYA17UIbky4ci7q48+uRN/GUW99KFJN9k8phzabxRL1WvVPF6nE8W69mGGNmHHZ5Q+VAvIcu3EKOMPyNPNuzUHwc77++RwsnldgxcMM742i+mLafZZ3MTfx1hl4G/xDfKobVEMw1BSX1+Z9eniRLCcw9Atw2icVMD+En44VXjBJSZNIqHvjgOh8+ReFuw8PPHDIsTVipkxYxzes8rUYXNUhBhyZsluVkZewhOi4ONMhVBvu+IL0EXKMiSlFdCEjxntprkUJdGoMWkGKwke9MqOZo/GeNoVqc39cxx8Dj357qYo6lRhu+x8ikE4DiEEE1QhR0J+tgAkti9gMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(2616005)(36756003)(6512007)(31696002)(83380400001)(66556008)(31686004)(66946007)(2906002)(8676002)(186003)(6506007)(66476007)(53546011)(38100700002)(52116002)(508600001)(4326008)(6486002)(6666004)(5660300002)(316002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzZhb0M0amx3bzFnWk5sVGdyaVVaTnd0bnNkZ1FzK2tITEttdkhpOERSdmpF?=
 =?utf-8?B?VnlnNzd5Tkt1bmdSZ2lnZmV1bVVsblpMQTVldExlc1dBeWdKdFIvck9yTi9I?=
 =?utf-8?B?U1ZIdkYzSUh4QWRUc1YyWkZlK2Y4eXVTeERCcUtOZi9OckdvZXo1S1dLYkVQ?=
 =?utf-8?B?Q2dIRUhIbEF6ZThUeE1sUXJyRW9XcGFrMDYyamFVSkR5eVVVVEJ0VVR2TUEw?=
 =?utf-8?B?ZzRVU3Jkd0JadXMrL2dFZ2x6Y0IwWHI1SWVhR2dNTlZPMzYvYlJIWFR4akNn?=
 =?utf-8?B?TVQ0THBGYnQwaGljM2RndlhxUmw3ekVER2lFMmpZVWIwT3B6ZG14a1BtbytM?=
 =?utf-8?B?SEo2UkNnV1JqSUwyRU9YUmxLU3JuZkRCMm5IVE5CNFhWR2JyQWdvOU0vcU9H?=
 =?utf-8?B?elA2cy9IRTE5U21OcmhGOHkwY05RRXNHS3FtNWRuNHJ2N0dOMis4elR2c1V5?=
 =?utf-8?B?c25qczhNUC9PaE5ZMVF1TWYxM2JXVVNIQ2xlQUFaWlgyb1o2UUxUUzBIeHRY?=
 =?utf-8?B?THF0dXZ5eUhvdE5rTk1RdnkzQ09SeFlyQ1FSc2U3amRHWEUva1Zib2FueFJW?=
 =?utf-8?B?enRjMTg2RDdKK05wRWsvS3pNbmtZeDZFbVRvNkplRzRSR05hekkvQjZ3bkFT?=
 =?utf-8?B?dWVFekQxQ3hBeVdTbGxZQjlhdisyeVV2ckZVWmt5WlFDQVZyZEJuSFVvazFy?=
 =?utf-8?B?SERrN1g5a1hkOEltS0c5TGFBOFh4VDFRZjZRYVRBSnkyS0tLM0wxenY2Zzlq?=
 =?utf-8?B?VlAzWlRLVUNaZnRYUnhQZzFuVUErZHlBMUtwN1hSdkJNb0x5QThZRTJuTEJm?=
 =?utf-8?B?S0xSUy8yQkRrYVZ6empGSGVvT2EvU2pjUDdYWHd3WktPWmdEOGN4L0YzQ2hM?=
 =?utf-8?B?VEcwWlF1VWZWZFU5c3VibEJ5UlNKZUNCSVc2S21CeFJaODZqS0dtYXh2ckMy?=
 =?utf-8?B?SVVEQVl1bW9RdVdEbnVxbytUNWdSVE5ZTS84Skkvdk9aWmZTdjBsUUVqZHZY?=
 =?utf-8?B?ZjNpTSs4OEo2VjBBdEVDMWN2cDhxaVhDMmV4Q1BNemNSdjJUOC9JbEtwRm5B?=
 =?utf-8?B?VjZDMEw1OHQrME9CUVROZ1B2bjcvelVZQUZ1ZWFZeEwvNHpyL1E1RStFc0Fa?=
 =?utf-8?B?RXozckVTdlNPdUpMUjBLWGlGMS9LMHRXd0pkRW9VeXd3eXkveHZvVnVQVXR0?=
 =?utf-8?B?bEF6bE56c016NWxaazJpV0w1VU1hd0I3Q0dvdmZydFdBWDZPWnlOSGQyUEtY?=
 =?utf-8?B?YmlSUnZySmRWY1JXRWphQnFFMTFDSnNZdTRCd2pvcmZZKys1RFI5VmJoMHUy?=
 =?utf-8?B?S1UrenNpRDBRUWJnYTVBdW5ENmFLd3NjSHBqQmhFamZrR21hMzI2VkJyaTg0?=
 =?utf-8?B?RXN5Q1VuVlVPWVBqc3VENFpGSXcwaUo5RlhuWE5LR1RKUGt6UXN6Lzhhcldw?=
 =?utf-8?B?OGhzTkx4aXRXT0JhZnM5MG1PU3Vqa2FrMXYyWjhJZGIzNDF3YzFlQW0xMXUx?=
 =?utf-8?B?UkpVQnpOQkZMUTlNK2NSRXh1SWp3QlFlSmd2NnFIS2VndDRLS0JoRXBTOU5k?=
 =?utf-8?B?eUN0eEk4anBHdHV5MWlOMFJwbGNDSm1qN3hibTJTaUJIdVIrZXRPQ1I1ZGs2?=
 =?utf-8?B?UHNTejhFVnRjN0V2d3Q1eUxoSTNDM3JrRlRsd04vSHYxTWZiQlVMcUVuTGRk?=
 =?utf-8?B?ZmZYaDdzR3BTeFN4WmhCRVpIMlFBS0JCMlg1Qjk3SFRrdXZHUzRwYnpmRm5I?=
 =?utf-8?B?K1hKZFl4REd2OTJYRXFaT1p3KzJHajhvRG5iUGh0bXg0Q2o5ZzJkQ0pXdmFw?=
 =?utf-8?B?c0RSZW1kemE0UkpuN3JIaHJQODlPSHZ6c2FoakRkdGsxcHRCdVFuQlU0c0JH?=
 =?utf-8?B?QVVDZzdIdkVwcFU1amVMNGQ2NEZIQVNCZVpZV1JORWVwQ0tObnJEL0FpZjlB?=
 =?utf-8?B?UTl2amMyMGkydzZXQ2dEN2VPOXQ5N0QxTlpSZW5nQjNEVUZoM2JrTnlwQTg5?=
 =?utf-8?B?Q2p2Y0lWRy9HNDVwMzdqc0diTSttQnA2SEJJYzkwRk82VHZXQjlPVytIb0lo?=
 =?utf-8?B?RnNxV2RRWTN1bFh6Q3FzbVVTQ3VtZ3FabzFuNXNESGlGazdiMTBPUXltVzdM?=
 =?utf-8?B?Si9tVU5sUXNrSHM2NmxqbVd0a2F0Z3VrSVlSVzE1VmZwa1BYMkZRcWYzZ29m?=
 =?utf-8?B?cVJsaDFUSTJHL09xRlo0NDYzS2c5d1Nsekd2dWlucFpHNldyTkZNVUFaR0dk?=
 =?utf-8?B?KzFzaW9lc2g0QzR1N0U3NC9iblV1VlU5V3EvTlRGT1lxRS9qdG0zTUtPL0FG?=
 =?utf-8?B?VHk4UmtrdGlYc2w2ZldqNUdOaWF3Zzl5M1QrSlpCYlc5NlRsclNLUmxYYWVo?=
 =?utf-8?Q?bEWlCRRPke2g6/Xc=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9c609fd-f5be-40ec-5daf-08da0eb10424
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 22:44:27.1588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5NISS4pSj4r+6kTbmfIG8zKmWgxNVLwLNjCW1Vqf4wXNXhadVb5QVO+adiX/tGhZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3449
X-Proofpoint-ORIG-GUID: Rz-5yllFt6tL8hVb2eu4wPEHA5xDrnc7
X-Proofpoint-GUID: Rz-5yllFt6tL8hVb2eu4wPEHA5xDrnc7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_08,2022-03-24_01,2022-02-23_01
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/25/22 3:23 PM, Andrii Nakryiko wrote:
> 14c174633f34 ("random: remove unused tracepoints") removed all the
> tracepoints from drivers/char/random.c, one of which,
> random:urandom_read, was used by stacktrace_build_id selftest to trigger
> stack trace capture from two different kernel code paths.
> 
> Fix breakage by switching to kprobing chacha_block_generic() function which
> is also called in both code paths that selftest uses for triggering.
> 
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
> index 36a707e7c7a7..698fef6d90bc 100644
> --- a/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
> +++ b/tools/testing/selftests/bpf/progs/test_stacktrace_build_id.c
> @@ -47,7 +47,7 @@ struct random_urandom_args {
>   	int input_left;
>   };
>   
> -SEC("tracepoint/random/urandom_read")
> +SEC("kprobe/chacha_block_generic")

I tried this and it doesn't work in my environment. But changing to
    SEC("kprobe/urandom_read")
works.

Also, if using kprobe, maybe rename 'struct random_urandom_args'
to 'struct pt_regs'? Also, the struct random_urandom_args definition
can be removed.


>   int oncpu(struct random_urandom_args *args)
>   {
>   	__u32 max_len = sizeof(struct bpf_stack_build_id)
