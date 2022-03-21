Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEC84E2C76
	for <lists+bpf@lfdr.de>; Mon, 21 Mar 2022 16:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350380AbiCUPkt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 11:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348735AbiCUPks (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 11:40:48 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1632339690
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 08:39:22 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22L9nhE1024297;
        Mon, 21 Mar 2022 08:39:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=GJNK0/o+LzKo262FgwzH7g42xh7t0jsncuJlsA3L8V4=;
 b=URBEXK+f/jv01en52ySAVhkMHGHkLNSJN9S0bgkbJwD3YKJVJb5SYkcMS+HGKFc6cf18
 8VIWiXGzFU9xuGgT5wfRcfqa/m2dSywjU7c0Nm1XhUWIjbUHab4/02CnbDifl6SK6rja
 WSI9S2fGbgCMb2ClOlmjiJ+pbnc87VPjXKc= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3exq2kt2uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Mar 2022 08:39:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhSXC54lp//gZxqPZgTayWMZ2ISqJdUCNn/Il+EUHlaT7tCFGm4yYxvWVwBrrfzKv1xjDo7kG0qH6NPAJiK8b9IDqjgamFOTmbd4p96+uy9PEortwa7mxzRRc/75wYo6Ghv0mPlPIx3aaN9vDvJCh7ziHRcWyMDd0GlVIg7lO2TLCen8BMRt8FCRgJa1yjhR4NNOh/aNqlt8Uc+HIva2gmHnxppMZgBIL13DjGrm+FOj8APZYk0ssGBPSxWJ3GZ9YhQpc3h2A/JElqXDo2iU9t8WmkZfc0Z5pd1sb5SCvg4WaeR5oNHCwftkIm4Y8lTginYSDeO05n+0S0VjE3UNLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJNK0/o+LzKo262FgwzH7g42xh7t0jsncuJlsA3L8V4=;
 b=NCOXlxHc8t3S4EjEpnvhLXSEmiPpqCM4edV2hh56Ycakl8UJnP2nK6mSncawbjpMbP2xHgHqXvyEb3AJ7lfNngs7G1L2XrY5fXt9ASmG4bl/G5dsqKrDbS3Dy7VMgxTLaZtP3HFNalvdJUYCrkEA9FJBFCCn/oAOmzpUvFqL/fjpTpyyO6lptQhGb6jQ7+CU+KLmXeILaNktPcE+fLLv4yyZkhs4Qis/c9ETazV6ToMQCG0VfNbB5GfXCGmTf4LU9+YmZBybASQ2pIC1PKE6OdbqzAiYpL//zg1apgWsU43K+DjjTBIizw42ba4fNG/Hekeg+WI7JhvlMiEYGAQpig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CH2PR15MB4279.namprd15.prod.outlook.com (2603:10b6:610:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 15:39:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5081.023; Mon, 21 Mar 2022
 15:39:06 +0000
Message-ID: <1284e957-bcd5-a562-2233-d193b28432fe@fb.com>
Date:   Mon, 21 Mar 2022 08:39:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH bpf-next] bpftool: fix a bug in subskeleton code
 generation
Content-Language: en-US
To:     Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@fb.com,
        Delyan Kratunov <delyank@fb.com>
References: <20220320032009.3106133-1-yhs@fb.com>
 <f469d022-7b3c-2181-0fea-6cf877f7c014@iogearbox.net>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <f469d022-7b3c-2181-0fea-6cf877f7c014@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MWHPR15CA0062.namprd15.prod.outlook.com
 (2603:10b6:301:4c::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b1f6098-f2a6-4440-e8c8-08da0b50ef34
X-MS-TrafficTypeDiagnostic: CH2PR15MB4279:EE_
X-Microsoft-Antispam-PRVS: <CH2PR15MB427938100500AD8ADDE0580CD3169@CH2PR15MB4279.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 62b/uP1sFROfHHwQmyyQamNzeI0OEarQTDanRia1wyLYCxCXff6GppTc4mnys+E+VHr1tEHW/NTS2CE+tpWeiIFZcbR8GWZUy+bVR2MQpOMQty8Pft3BLVokDbj81xefpMpW0R4jRQDuKVNlF+eB4FJSaEuUHEy/FNCKHvgBJdb1wMXFsoAgVHIaqpqc/0DaySof2hQmCMAQ2ngXBTzoiqkozQMmVRITlMQ5tYmvlH1sdhYM33jvAykYQKNXAqKc/nNJyXwRA4NaPWAsNYH7ZkzxCZOI9zZoxw/BXvhoGovDGfUIAzPby5a3cUrVNpkEM74XXYWoYbWuREoqfhX6lMtcb/txhUNiPCjSL5qbO2+O5laJ20F4QlnCXGR0D6HGKExupvP2wije9Muhn37P8UCBuJGqB7Z9wP/145blJW4hojg2VeqDP84/0yhwoopPskBB13fxxCbb+EX3i9sCnWwcUOguH2CE3HM28KbjTvC8v9cS9kO2KEZqLrJAELFvyV/if+TciOWwwmIi6h8ToZ88BSwmaPbPQSvx2kHWQC5sV675Ispvsk2I06F1rbC8LPCEGQYOi8KXfijkgfovFslF13SvSEhtQVDfgzi59bbbkSvybXULlN4zATykB/SxpD+Trl1lk4XNWR5VsdO3rUBJ9wt4V7EiBCpgBYavMs5cKq4mAPcIthVbLwkdzRklFAowgLHTz+3Bw3UCOF4Lt8vkjA4Lga+F0ieoItfD1Ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(38100700002)(53546011)(6512007)(6506007)(186003)(52116002)(83380400001)(2616005)(6486002)(36756003)(31686004)(508600001)(8936002)(54906003)(86362001)(316002)(31696002)(4326008)(66476007)(66556008)(66946007)(8676002)(5660300002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1Y4dng3NGpNUHptUlI3b21XYUVnQUUwYnFaUmlCNitnTFhBNGJoV04zeEh2?=
 =?utf-8?B?c29KdVEzTE9TWWZpV2Y4YWp5TitYUVdiNkJ2bkh3VnBBbDBNNENOejJFa2pz?=
 =?utf-8?B?NmNUbGw2RTJvZzR1SmZuTXE2M0JXazgrdmJ2OFFPM0orMGljRzlkLzdpd1Zo?=
 =?utf-8?B?eGhObkcxQTkzRWRRTlVCdm5sZ2hEUkh5TW5NbEtPUmpROW9YZFhYN040THRW?=
 =?utf-8?B?bm9SbWdtbGs5cHJFdlIwK3FrcithMmpBbStCL3J5elVLL3VkcGV0dUhFTmxG?=
 =?utf-8?B?c2hSeGsyMnU3V3hZU0doSXRqMlFRdVlxM1ErSFJtMUtVbEw4YW5remdDU3Nq?=
 =?utf-8?B?YjYyMm5iOGdYUlhRYVRjZ1RvNlBKTWNtV24zSjJDYmhxZGxWa1ZmV0FJR09G?=
 =?utf-8?B?aHNFN2FmRXhKejdlUEJuQXpYcE9zc3JNQ3BEellOMzBxamQzaDZ4UGlUR2FH?=
 =?utf-8?B?N1V2UkQ5SjFub3hCVGJWVkZwKzVKR3BBZUJpYksrN1p0TFZnWkdnU3A4Tkl6?=
 =?utf-8?B?WmV5VlhZUStvSkIyRG5uSUQzeG1Ra0JtcjkwTmFJbCtRRnZML21pRGZNcXND?=
 =?utf-8?B?UzJPOFlUSTRsVXpsWmZkNllpVkhpZE9ncHExdlc2TmFaRncxeUNuczVLdUFF?=
 =?utf-8?B?THphb2x2UDNYdkIxS1plRGhrOGp3YU0va1duUWZwSlg3dUprWjBUdTJpQ2FM?=
 =?utf-8?B?bFVKampKUHFyZCtWVjhuSGRzS0d4WDl4Y01OOGlpZ1hGQnlxYWE3Wldxa3ZF?=
 =?utf-8?B?cXlWTTcvc2xNQ21qMFhia1MvdEFsVnlOSG0rYS8wRFhTckVtV0ZjajBudk9U?=
 =?utf-8?B?RmFXMUl2Y29Uc250L2FBRjQyelp3Q28yamN1WFFjd2RITkdqZnpYZExSSnB5?=
 =?utf-8?B?ZzRHbDd6Vk13Ty9LWGNKNVRLUksyWjJPSko3V0REdER5WGJmOVJDSHMyS3pV?=
 =?utf-8?B?SG1kaDdVZGtTMkUvdEl6RjcrWDd2RWZBempMSldFQ2hWUDhZVmZNV2ZGRkVC?=
 =?utf-8?B?WVcvNDhIcW5JSnNpZUJrRHpyTXpKOHgvcWFCdHVZOFFGZTVlam5Eb1IrdE1T?=
 =?utf-8?B?VWxaM1V3MGhWOWFTUHBXd2RneElLV0RWaGh2d3ZhT2dSSXRqSnhXNHkyRXM0?=
 =?utf-8?B?dnIzTFo2b2t3TURBVHhhMFkzcWgwK0dHOWJFTXFzU0tXQmNiZitWMDM1amlj?=
 =?utf-8?B?bjJOd3dEQzNRZnNnUktMY0ZlN2Q2T25VNkY4OUdTakV3NGdiVisycjBodDdj?=
 =?utf-8?B?dkhldmpYTWdFY1ZEOHMxdDFmbjd2SEswRUVUY0hxV1VHUDFyb0JJcCtxL21p?=
 =?utf-8?B?MDB6WGVDV1FlNFU3MTBJOXhlSmE0ejE2ZkkyVVQ1QVhBdzlsZDlGdnBpWUp1?=
 =?utf-8?B?NEE2S0drNVQ5eGRaT1NFc2xwWkc4RWZSRzhzQmduYzNTSjZBbUFITm55RTBC?=
 =?utf-8?B?WFZ4NHl1dWo5T3dVa3pINFRlM1RPQVJhNTEzMGk5b1VjNkhoQ3NqSDdUYTdn?=
 =?utf-8?B?RkV5ZTlUcStvRWJMK0Zkc1lIKzA1VUtUTExDMlF1QkxYSkxuWWVnY01RWnJh?=
 =?utf-8?B?eHNVTWtTWWhjYWx4cTdYSGR0MmZRQ0pScTlmOFFrNSt5RlUySCtLdjZxSHBS?=
 =?utf-8?B?ODZNRjZhRDBJZnRhRTNveU0xOGlvRDczb2pZUU9nSUczWnJzNVFPYzNjNnZk?=
 =?utf-8?B?ekVJdHpFVTFITlh2RnVnTUV3WXBCY2E3eEZNRlExSEFudGI2YUJTVWxrdEx6?=
 =?utf-8?B?YUFPeUdwYmI2alFpb0ZBOE43MHFvYVNTNUkrTkc5NCtYQ1k1TmVlQXZ3TG1B?=
 =?utf-8?B?Q2cwU0hCTUJhRTUyOUtLMEN5cEN2L1A3V014QnQwMlkyOG5zb3NmTWJhYkJV?=
 =?utf-8?B?WUswa1RYOVl5NzdBc3NyUGtaNEluUFN1NmU3ZjBKMkQvT056RE5sWmcrNmJK?=
 =?utf-8?B?bTkzVlYydjRJUGhVKzd5cG5vWU04UWt4L3czMllxUFV4eW1PNExGcWtsZlNT?=
 =?utf-8?B?aGVvSFV1ZVdBPT0=?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b1f6098-f2a6-4440-e8c8-08da0b50ef34
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 15:39:06.6263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TUJF63JJGSYDny9R1PSySihCo4Cy8dmBAAZ3FBFWWvw0qIAyKnioMZPmLFYy+DWk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR15MB4279
X-Proofpoint-GUID: ZcL38F-TNFQpLvUzjqsrncS7zjnJxhp6
X-Proofpoint-ORIG-GUID: ZcL38F-TNFQpLvUzjqsrncS7zjnJxhp6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-21_07,2022-03-21_01,2022-02-23_01
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



On 3/21/22 7:31 AM, Daniel Borkmann wrote:
> On 3/20/22 4:20 AM, Yonghong Song wrote:
>> Compiled with clang by adding LLVM=1 both kernel and selftests/bpf
>> build, I hit the following compilation error:
>>
>> In file included from 
>> /.../tools/testing/selftests/bpf/prog_tests/subskeleton.c:6:
>>    ./test_subskeleton_lib.subskel.h:168:6: error: variable 'err' is 
>> used uninitialized whenever
>>        'if' condition is true [-Werror,-Wsometimes-uninitialized]
>>            if (!s->progs)
>>                ^~~~~~~~~
>>    ./test_subskeleton_lib.subskel.h:181:11: note: uninitialized use 
>> occurs here
>>            errno = -err;
>>                     ^~~
>>    ./test_subskeleton_lib.subskel.h:168:2: note: remove the 'if' if 
>> its condition is always false
>>            if (!s->progs)
>>            ^~~~~~~~~~~~~~
>>
>> The compilation error is triggered by the following code
>>          ...
>>          int err;
>>
>>          obj = (struct test_subskeleton_lib *)calloc(1, sizeof(*obj));
>>          if (!obj) {
>>                  errno = ENOMEM;
>>                  goto err;
>>          }
>>          ...
>>
>>    err:
>>          test_subskeleton_lib__destroy(obj);
>>          errno = -err;
>>          ...
>> in test_subskeleton_lib__open(). The 'err' is not initialized, yet it
>> is used in 'errno = -err' later.
>>
>> The fix is to remove 'errno = -err' since errno has been set properly
>> in all incoming branches.
> 
> If we remove this one here in which locations is it missing then? Do 
> these then
> need an extra errno = -err statement before they goto err?

Everything should be covered. The following are all 'goto err' returns:

         obj = (struct test_subskeleton_lib *)calloc(1, sizeof(*obj));
         if (!obj) {
                 errno = ENOMEM;
                 goto err;
         }
         s = (struct bpf_object_subskeleton *)calloc(1, sizeof(*s));
         if (!s) {
                 errno = ENOMEM;
                 goto err;
         }
	...
         s->vars = (struct bpf_var_skeleton *)calloc(10, sizeof(*s->vars));
         if (!s->vars) {
                 errno = ENOMEM;
                 goto err;
         }
	...

==> for all maps

         /* maps */
         s->map_cnt = 7;
         s->map_skel_sz = sizeof(*s->maps);
         s->maps = (struct bpf_map_skeleton *)calloc(s->map_cnt, 
s->map_skel_sz);
         if (!s->maps)
                 goto err;
==> calloc should set error number properly if failed.
	...

==> for all progs
	/* programs */
         s->prog_cnt = 1;
         s->prog_skel_sz = sizeof(*s->progs);
         s->progs = (struct bpf_prog_skeleton *)calloc(s->prog_cnt, 
s->prog_skel_sz);
         if (!s->progs)
                 goto err;
==> calloc should set error number properly if failed.
	
         err = bpf_object__open_subskeleton(s);
         if (err)
                 goto err;

	return obj;

==> bpf_object__open_subskeleton() in libbpf.c does set errno probably 
if 'err' is not 0.


> 
>> Cc: Delyan Kratunov <delyank@fb.com>
>> Fixes: 00389c58ffe9 ("00389c58ffe993782a8ba4bb5a34a102b1f6fe24")
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/bpf/bpftool/gen.c | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
>> index 96bd2b33ccf6..7ba7ff55d2ea 100644
>> --- a/tools/bpf/bpftool/gen.c
>> +++ b/tools/bpf/bpftool/gen.c
>> @@ -1538,7 +1538,6 @@ static int do_subskeleton(int argc, char **argv)
>>               return obj;                        \n\
>>           err:                                \n\
>>               %1$s__destroy(obj);                    \n\
>> -            errno = -err;                        \n\
>>               return NULL;                        \n\
>>           }                                \n\
>>                                           \n\
>>
> 
