Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E03364A8FE
	for <lists+bpf@lfdr.de>; Mon, 12 Dec 2022 21:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233442AbiLLU7D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 12 Dec 2022 15:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbiLLU67 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 12 Dec 2022 15:58:59 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A2E18385;
        Mon, 12 Dec 2022 12:58:58 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 2BCHZAC4020735;
        Mon, 12 Dec 2022 12:58:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=WgOUMr8z6oZ40qc4ivDGi3tUC3eAS9ETrP3dlY67HCw=;
 b=a7S9jNjvQIKQxBfISEUyxD/QfiVFXllBvTiuwhYSnxnwjtgFutmMCEbWzlabSv4B10Ec
 +ekmg8j7sRXJgiOJrU04K6nPChGgOFs6yMhcQhjDh88wL1rgGljnkOzQj9T5/Z2BAu6C
 NcDhoIE0eGIXrGyEnAEbVok4VQI/PWlHVwYQR6iAe93Spb142b4PRxzY75U4h/j3lB5I
 1x+KP1N3UwggPbeVVAsIOa0n/lHN513X1pI4jQSmKw0k+hFo6Zx2/JnyMQQcGJ4G3Eur
 QvSSjTdmuVmwwxcw27f+aUIi4vLFTMO/UqnAmTdqfh70wYx2ICv7izfFY55FCuCMRrjP 1w== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
        by m0001303.ppops.net (PPS) with ESMTPS id 3me4u241ap-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Dec 2022 12:58:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZxJnsCUo/mIM4VkfilYP/n8VdL7bCuKFyz29zgJO/qFuHIlt3zt68CWAbGYshAgTIP42WzeUJ08+Peg1dVKrfCkTwi8szQ/nzRySanHUpDCLsXVtZvDET2A8retKJQBdX2i9ExyRevs82FHFYN3Lf/YIdlDH4FGRqO+O5ncMdzss3tI7Pec1Wo/Wz1rGs4Ek+lFuTMNbs6Q356q1oiYRCWy+PK540D0PkAL3M7h4+qgJibjxuUNXh5cequC+DWDpjAg7CKGQEkALdJfL/M/ry2ayUPJMnzk+f212yJkRyMf+xL6+5mo6WVB+rdn6Og9OKJK4tZcXW5VecoLTyD7tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WgOUMr8z6oZ40qc4ivDGi3tUC3eAS9ETrP3dlY67HCw=;
 b=Dqg2U9xFLAM55eqfeP1bBIcG0LBaGexAx0ITYC+cvNods7IUm0TpteIeWq9P5RFsHTF3kGjCos4PuZ52aG09oG4ep3WCGbPE9mM5ucTorWy12tlC5vVCvfMuaLMMbLT57g7tth0zg9TYAMsbT4ZkqsEyInlanXrRJhR+4hFG9c/DR/rLA1NK1Q/PEnMUP2G1DirOCBDYjbax4V5OttjhOOyG6XPghfx1vBWL8FNRCzMNP9abTRKcWnhhHCDe+WGUMkFIvsfUTBHJIKGECgirURZZtHn4SB9pmNL/Vk0bk0ug7qjWFsniUZn8bEdcdHggrDdfkX8jAFf7xwfId6vdTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by MN2PR15MB2830.namprd15.prod.outlook.com (2603:10b6:208:132::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18; Mon, 12 Dec
 2022 20:58:26 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::f462:bf61:5f19:e2e9]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::f462:bf61:5f19:e2e9%4]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 20:58:26 +0000
Message-ID: <474389f3-b50c-e941-5459-8a1318a7117f@meta.com>
Date:   Mon, 12 Dec 2022 12:58:23 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next 1/2] bpf: fix nullness propagation for reg to reg
 comparisons
Content-Language: en-US
To:     Hao Sun <sunhao.th@gmail.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
References: <20221212040911.2337521-1-sunhao.th@gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221212040911.2337521-1-sunhao.th@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2055:EE_|MN2PR15MB2830:EE_
X-MS-Office365-Filtering-Correlation-Id: db46f678-0872-4af4-96a4-08dadc839cf5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p14lSqu+H++BK09KdX9oU+17G8Bv6elESlFDlMcczM4L/I4bZknP7QhS7pVC7DNJMLNMEiJwc2HiiZCXCZCDuSox42imyJjLVTGQtqhLQ4b9dR5PyfXRpreEtzEZzQ9xiwHiyoqdoiAKbwHSrIP8vMRfawIxSoiUMMFjI4gvXX40fPcJQnCL/6ODxO8j28IADCmboULMiaJUZhNGiP5zZJ64YaD8m+FauF4dYgspy3Y8YNLgjPCsA1scxNut+QZYOhdOvxrBC1bemTznUhGHT/uFFYyi3dJTETjXvCyeAMyq6v3an0Q2tMSV/d/GZxPGOCgEp0zcUn+RfVe66BsR+KJxHQHt4eDHIgthGjV+byNYYCi3gYvnwPgQYyLsvfk89c27bg4Q/F1pEt1Zz/+EyUmqofumx8sMV2HaKF+kTyEU8SrAOtvMUO1pjn5HK/Tx/aMAiX8005A43iHWum4f0m3wObrrulT3bQxxRHWTshbhc0IUJ4yXQRE48I2aCIi/3xeYplZLW/O2gih+LEvNwtAxkKD2WR6uO7IgJ+4wRoiS8uBTPHT3opgUIISI25tySpt5ioeTQO60z3QXnNwvkdNWpjr6N/DNSv/6Ot94A1HKdIsHHb00ZFb51cQ695bMg6NJxZJLlrozPTZCrhXhQ1Dv2D8XlSVy2k5icMZm5UNSBNwabjG2H0cQzSDnHg45d8wT3yiDBTtSA+Xw1zyVZhntN+WfZCIxJwRJ1sqA9rDHrzG1x4k1TT/ZZKWHdmLZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199015)(83380400001)(45954011)(186003)(2906002)(2616005)(38100700002)(86362001)(6512007)(41300700001)(31696002)(36756003)(5660300002)(8936002)(7416002)(6666004)(31686004)(6486002)(316002)(478600001)(966005)(8676002)(53546011)(4326008)(6506007)(66476007)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFFvdmV0aWlpdGxxTTJIalBSVUdxWW1sK3JBM1k4WWdXSG1wcFppbWlZc2J3?=
 =?utf-8?B?cHcyM29aR2pzVW9URlV3ZDRnY3psWmRHVmdNdHFqMGE3Z09YcFgvWEpjaU5z?=
 =?utf-8?B?R2pBWkN1OUpTV1Blb21BVzNQeTVxSHJlSlN1T2ZyWjV5SzRzcHZpTjVhY2wx?=
 =?utf-8?B?bTVTcVFaOUVTN0pzd0krb1FVOTRLaVVCOHc5OGw2eHVVZ292c2xIK1BjR2l5?=
 =?utf-8?B?bENxODdQOUcyV2hFSi85ZTNTY083Y2xEa2lsSGZjNGloTjRiUTZzaGszYWNU?=
 =?utf-8?B?QUI3akxJTFNZak5hcGdjUU5jWXRycHE3UjhWK212clpZaTdYWnVybXdYbHha?=
 =?utf-8?B?WVV4dEI3VGFWcGIvVlJWamlvRVFSREtlQlZmMUJkWVJuWGE4VkNsdWx3MkpZ?=
 =?utf-8?B?YU1oanFUY3JFSEc2Ynp3d2JrRGhTT2ZIa052Q3N0NFMrSkdYTmQ1Mm9mQzJW?=
 =?utf-8?B?TXh3T0prZHovQTUwTWNHUitiU3N2eERkRUhkaWhsZTIzb2kzU0dHcFVQOTUx?=
 =?utf-8?B?blZKY0FHaDIyN0dkTWNNRi9XWXFHcldWTjdhQnl2Y1pFNXRsckxWaTQ2MDZO?=
 =?utf-8?B?cGhjM3NqcUpPNCtiaFliQU5BMERRQnE0V2FWUUI5TUF2dS9OdE9BeHgzVmRR?=
 =?utf-8?B?TGsvdCs3THBhRnpUZHpRS2dPMWNDK0FZTGltaHBsUXdwUEV0K09GWEw2bVV0?=
 =?utf-8?B?U2pqemE0VHJCUUdKRGVsY09CaXRoaGs1bWlPUkFpaTVBNWhwZmQ1bWFJSjJu?=
 =?utf-8?B?dGxWMGpmWFhkTmJVTUhvWHI4YXlyRndGdFZoY3JLMEZVL21pYS9Fb3dIRm9M?=
 =?utf-8?B?N3NsVWlvWUxlZEV0dUxrR1JQVDBhNThJVEd5RTdBUVJsZ1UzVmMxbUk5d1U0?=
 =?utf-8?B?Q21PWnQvQ2Z0eXAzSER1ckJLa2ZENGg4UHVWWEhsNVE4NHV3QUdEOGIzMkc4?=
 =?utf-8?B?ZTNtaFI3K1ZnTWxXSWtVYmtQSzM4NVBnWmd2cHdhaWQ4Z291cjJ4cjk1SU1z?=
 =?utf-8?B?WFhBSWptQ0tobmsyYm5pVFB4MERIOGdFY1U0bEJRc3U1QjBBWG1jR0c5T2JU?=
 =?utf-8?B?MzNKSHhOaTVCMGxHS0o2U2NvVFBjRTdsckRMd1ZPQ1M0U09aalNUanV5S1Za?=
 =?utf-8?B?Z3BYQTB0U2JRYURHVTZwaWM3UDUxNS9kMUJrU0JDVHVvREtxZ1FtMkxoMlVP?=
 =?utf-8?B?aVZrdGRwNWtiMi9uTHh1UTJTeFpwdWdIVzZVUTExWHNvdjhydzQwT3Z0dnJS?=
 =?utf-8?B?dnBwMktSSnAxdWRUMkNvc3RESVN6YXJidTJsaGRxZjdnM2hXeGo4Q2RhR2Vx?=
 =?utf-8?B?Zkk0SXE2R1BoV0ZIR25HOGp1ZGVteUdDTlhpM3IyNklmS3dzeWU0WjJITURP?=
 =?utf-8?B?M0VWYUZaVzRuZzdoOVVmY2xDZkx3OTRnWTNrVCtac1B5dUFram1YYmNQcFA4?=
 =?utf-8?B?Z0lZaE8veW5Gd1JjR3ZIRFcwNTQ1QmVXbU4xMHJyVWtMZjU0ek1nbCs2SElP?=
 =?utf-8?B?RXZOS1pCUUZrMzhFRC9TbDVvREhqVVBFRUhhUDZpUklqR1NLblNybGE3M1Zz?=
 =?utf-8?B?dzVYdk1Md0w2c0FzUno0Tm5keGg2SXZFSnBuZzVOdW1aQ3RQUTZjQ2hXQVNK?=
 =?utf-8?B?YzFaeWRzbzQvR004aUxuMzVXUExoS3VIU3BSTDlXQVljMHVINGVnckJhWGlX?=
 =?utf-8?B?cnZCc2hSaFdKSHBDR0VwYm9qMUZua1p1ajVwcjY3N0hCK2M3TXU4amcvK1pt?=
 =?utf-8?B?K0tsSEhHd3V4Lzg1MHFmRW1MYzRBeEFpdHZjZGNWZ1BFbXNkcHlxWGpveG5O?=
 =?utf-8?B?Ty8vYXJiakxYTnpFam1ZdnlWUm9VL2gvejMwZXMyTlVwUERHQklMeVNmRlNF?=
 =?utf-8?B?UzhkQzRxNXFVdmxoRGF6UU1IUGhhR015a29kQXQ3OWw1ZU9jSHM4bDhKbldQ?=
 =?utf-8?B?cTdPNENkRVpGM1VYRTUraUNEeitBM29PV3BVeDlHV0cwcjBhNUNtczBGNFJD?=
 =?utf-8?B?REsxRElZaEZaTU9taDcrQzZXeVdnVk1RNGhqdGxxY1JzVUphYWp6STRRUzFY?=
 =?utf-8?B?Z0RHbVdKM3JNdDJCRmVyQmphcXV3Q29weC9XaXliNU10NnJGOUhsT1pWSEdG?=
 =?utf-8?B?VXRCYzE4VG5lRjRiZU5rL1ZqL0c5RmJmY0JOcms2L1JkeHhLM0I3V09zUjdZ?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db46f678-0872-4af4-96a4-08dadc839cf5
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 20:58:26.0857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vyvdmw/w8dmPplVGbonPPDVkxKkEBMuTiiCqWGsiTd1KQMCCrv6/+5gAzMfj9nk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2830
X-Proofpoint-ORIG-GUID: ZpWYz7z3eK1pD_AEQ_3UpeXH-FHoze24
X-Proofpoint-GUID: ZpWYz7z3eK1pD_AEQ_3UpeXH-FHoze24
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,BITCOIN_SPAM_02,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        PDS_BTC_ID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/11/22 8:09 PM, Hao Sun wrote:
> After befae75856ab, the verifier would propagate null information after
> JEQ/JNE, e.g., if two pointers, one is maybe_null and the other is not,
> the former would be marked as non-null in eq path. However, as comment
> "PTR_TO_BTF_ID points to a kernel struct that does not need to be null
> checked by the BPF program ... The verifier must keep this in mind and
> can make no assumptions about null or non-null when doing branch ...".
> If one pointer is maybe_null and the other is PTR_TO_BTF_ID, the former
> is incorrectly marked non-null. The following BPF prog can trigger a
> null-ptr-deref, also see this report for more details[1]:
> 
> 	0: (18) r1 = map_fd	        ; R1_w=map_ptr(ks=4, vs=4)
> 	2: (79) r6 = *(u64 *)(r1 +8)    ; R6_w=bpf_map->inner_map_data
> 					; R6 is PTR_TO_BTF_ID
> 					; equals to null at runtime
> 	3: (bf) r2 = r10
> 	4: (07) r2 += -4
> 	5: (62) *(u32 *)(r2 +0) = 0
> 	6: (85) call bpf_map_lookup_elem#1    ; R0_w=map_value_or_null
> 	7: (1d) if r6 == r0 goto pc+1
> 	8: (95) exit
> 	; from 7 to 9: R0=map_value R6=ptr_bpf_map
> 	9: (61) r0 = *(u32 *)(r0 +0)          ; null-ptr-deref
> 	10: (95) exit
> 
> So, make the verifier propagate nullness information for reg to reg
> comparisons only if neither reg is PTR_TO_BTF_ID.
> 
> [1] https://lore.kernel.org/bpf/CACkBjsaFJwjC5oiw-1KXvcazywodwXo4zGYsRHwbr2gSG9WcSw@mail.gmail.com/T/#u
> 
> Fixes: befae75856ab4 ("bpf: propagate nullness information for reg to reg comparisons")
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>

Ack with a small nit below.

Acked-by: Yonghong Song <yhs@fb.com>

> ---
>   kernel/bpf/verifier.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index a5255a0dcbb6..aa651e4517e0 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -11825,7 +11825,9 @@ static int check_cond_jmp_op(struct bpf_verifier_env *env,
>   	 */

Could you add explanation why PTR_TO_BTF_ID reg type should be excluded
in the above comments?

>   	if (!is_jmp32 && BPF_SRC(insn->code) == BPF_X &&
>   	    __is_pointer_value(false, src_reg) && __is_pointer_value(false, dst_reg) &&
> -	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type)) {
> +	    type_may_be_null(src_reg->type) != type_may_be_null(dst_reg->type) &&
> +	    base_type(src_reg->type) != PTR_TO_BTF_ID &&
> +	    base_type(dst_reg->type) != PTR_TO_BTF_ID) {
>   		eq_branch_regs = NULL;
>   		switch (opcode) {
>   		case BPF_JEQ:
