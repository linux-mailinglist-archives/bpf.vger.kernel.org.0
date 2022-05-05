Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4300F51CC45
	for <lists+bpf@lfdr.de>; Fri,  6 May 2022 00:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiEEWtB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 5 May 2022 18:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359153AbiEEWs7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 5 May 2022 18:48:59 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14E5E88
        for <bpf@vger.kernel.org>; Thu,  5 May 2022 15:45:17 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 245JdKra024374;
        Thu, 5 May 2022 15:44:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5StVPPK+rZvgSszqaK26AIWahIpttriw0lJq3T5Cn6U=;
 b=p5Vx1kN6REch23XRzFyfAcxwuryBhBHpcHGbItq7yIAVSSTS2k6JUWo11AP1DJorChsX
 O6NbJr85WrIiwr7M3UUbokuM7QOEHCg7UgRCiV/UZslxeJmsYofgyK7ZTdiWOv3a2uUY
 M5KSnmuSNsP+3tGkaNZGqeE2WBFGK9TMDXY= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fvhd1asf7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 May 2022 15:44:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExHxgUq+6ryfEHmD9qWW94zmLpwnwLM7whMCbDqDBY9+HWFDr9l8kJ+FSkAIjKXY71UdkEOulXi/XFQ19ktJ1pMoOpH3XrS7hUQQ0lf7xih5Db0PT9Om1x1WhnSsb59TLasxRCeQPBcnBJ+68q4tLdxdlRAFoMFcaS54+NeVYHKUkcZreTpXbb5pmgirqUGUs4e6EZyeIIXu9FuYxNTzm1oOuSq6SFpwRKib2hgP1TVtoDAHpXgEfoKZCC32kSO+FLGcyokARRFzZuUkKhfeahAqvkzRD9W5T57f6v2oG9Kd9BAVbyfu42nhFIvdIU4WBwpdovgr5zFOUJ1p/lU9Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlPsogaax3VvpdRGUZ2EMG1ZH7p9Bcx0fS/jFkGrBZg=;
 b=EABQx9V+LIsD/utF4Rpa3n8IMR0Z4mUL3iAuOcalIFezodksfIqmP0rOnM3jRUiWrWyOq7kRbRTbKmxSRAyGrmOZQl3o98sEkM4TuGkmyN8T3q4l3QrHdwHAvO6ins6hP05HBTo23dsWyj39lZfpSCi0SpeGxfr2MGsyAgwXgZGQOEL3EyCDgS2Prvnu6FhlUYP39i8Q03LGUA6o2a/ZH8i+bhuLaZxXirQ26Wry53G3trq98K1zsICGuQ0skqEVhZIxPWuvIzsYSAwPiIkdxetdpLQT1xObkHAceOjHakGk0usvXND4hNUV/HDDyYe/qQtw9WmwK/GwStgu2W3eRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BL0PR1501MB4260.namprd15.prod.outlook.com (2603:10b6:208:82::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 5 May
 2022 22:44:57 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5206.024; Thu, 5 May 2022
 22:44:57 +0000
Message-ID: <7c65e346-6e51-4f06-99de-adaa129cf9f8@fb.com>
Date:   Thu, 5 May 2022 15:44:54 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH bpf-next 04/12] libbpf: Add btf enum64 support
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, bpf@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220501190023.2578209-1-yhs@fb.com>
 <202205040133.jd7yTwg5-lkp@intel.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <202205040133.jd7yTwg5-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BY3PR10CA0017.namprd10.prod.outlook.com
 (2603:10b6:a03:255::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3880385d-2660-4af0-bf7d-08da2ee8e136
X-MS-TrafficTypeDiagnostic: BL0PR1501MB4260:EE_
X-Microsoft-Antispam-PRVS: <BL0PR1501MB4260F012249EF9AD25D43148D3C29@BL0PR1501MB4260.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KDvwtolQNtg6c/sNJQYX749BMIQuTDYGZr5rKuDI2blPfyT2Y8Mn2nXy+Gwq43kXpTFWG/TbLRcjUjIJPCQy3cfHxXz7mo6U+MkxygUXxPCc2lKAv7iTkNC4rQiJNBO8Dc+u/R8CmlELfHi+CCdjfZp8a3QvugVNjuaQdDF9/IPmOSKMTrEEKMeko12NQuYR9+e/JbEYRU35HV7LgsyntVNoLcYgZ0BJCUpKIIB7wfIUt2qZ49uG3H8fB3DQUJrmkN6g8tqwY9GZY2CdXytDo0QKdjeVkUUGGPUXxSPjDrRxUzDITRlLg8xpjJwiepKYbcx4LYKNRo0YGAA6USdv8rZNuDokisMDUkWOQ0z/ou/OuzocUxhvnGrynz5N691qURcrxA+jJTb+AeA/4b6l14QKK+efabb4l3wgwNs1/PcDYWrIH7R6j0exil7qAOboI6JzvqZTx2/FTBMM22JFGNO/MfV2Z26He7gj8CI0hUm0p+Ua9BWutj95i9bmjNbL8d9/uWpcwo8VAdZul1Ty/4sdwGMRNYVQREVN1jZdWR+D89hOVanxG41qSC1YbzGIZ3RT5IrYijcIsyrbf0yAX7642DipDqFKI5g0C8CGWdyARTqqSmEsV0pQ94ddJW7A7DtfuIKidjJB+jH4drkls+C8HK9ocuhguJhNmxZsc5waFz2V5HKQAtm8SJCeytoqFYFogn/oIdIe4t0JHyL6sd2OtFQ53mQ8FMj5+UZDHrSPiKIXrEtNq8xKv4e0fZSbssCHXLWToPndN3UjJyEUdBg2XDe80XgEZthafLim7qcp9zro/rNtTM5Cf7+wqESw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(6486002)(8936002)(6512007)(83380400001)(316002)(186003)(54906003)(66556008)(66476007)(6506007)(2906002)(2616005)(966005)(66946007)(508600001)(31686004)(36756003)(6666004)(52116002)(31696002)(5660300002)(86362001)(53546011)(4326008)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEVQTjFPU0dUdklpdVhQSVFoYk1UUThIREtDOUQ2bHhsbi9PUUY2d3M4TXdt?=
 =?utf-8?B?aysrVnA1L29MdUczdmdldEUvMHdVcytUenZySTdtQWowSGo5djVHeXlOV2l5?=
 =?utf-8?B?RGkvVTZwU2c5TjB4RWpZbnBkczNoSHVaYkQ5UHJVeGt6RTU5RkFFUTU5QXBD?=
 =?utf-8?B?bHdHeG1QcXJZdC9Cc211UVloa0o0YTJZS2dwTldCMVJlTDVMVUdoVXozQVY2?=
 =?utf-8?B?ZTBzZ0JlTlhlSWlEN1V1VVVOaUhVdkVQcExuWkNUOERrZksyVVRsRUorZTJV?=
 =?utf-8?B?MEl6bUIxem1DWDV5MU53Q2FGK2gvYTE1US9peVhkTi90Ly9NSEdnaHdlMm5J?=
 =?utf-8?B?amlIbkErc05FTkhZRkkyZlB6VnVLY1lpUkRDTndiVUJQaGFOS0R4aXJ5dFhl?=
 =?utf-8?B?OHBxKzNMaEh1eTFVdmpPUWhySU5qQzkwZU1SWGJsei9EcWh5S1oxQjQrdmxn?=
 =?utf-8?B?TEI5eGx2bmxDT1BhbmJ4TkRPc3J3N25PeW1SQ21lZFVCNUtUQlZGL2dyUDB4?=
 =?utf-8?B?eDZnQjQ1WDVPZnVmNHdGeisvb3pNM3VyWllraVdCVVo1d0ZoMTBZODcrU0xp?=
 =?utf-8?B?WTBzZ3VIbjAwWEtvRTFwdHZzRTJsQWRZMUMrTHAyTTIxQ2liWnE2SWRhd1N3?=
 =?utf-8?B?NHB3dTg3NnZOTnM0Q0l6dlg4VEZkSDEzRG9QeVhVT3lERUt4YnYzUWF2VkFN?=
 =?utf-8?B?VmF6dmM4ZDBXREZrMU5UUnc0QlNBRjFRM3lSUXJkRGJmK000Rzh4MEpGelFW?=
 =?utf-8?B?N3JRU2cyc09icm5IK1JrWStzS1JtMUl3T2FJSUR6TkVCWndKVlV4QWFOZGhB?=
 =?utf-8?B?QzVxSEhYWGJHTnRXc1ZEallpSzdsZ1g4dGgxWmdtODVva1lROG1DTFNsTXBS?=
 =?utf-8?B?Z1R2R2FlZnZWUi9laVk2V3RyV0toY0pUVXVYMm5JMXgzRTR3ZXFOdytScEFl?=
 =?utf-8?B?NzAvSVJ3U3dpUGVNa1lyM3VIZ2NLMW9hVk5VRHExd3FFeW9nSFhMSUxKRy9a?=
 =?utf-8?B?c1lDckl6RmcySlFOTHFJU2NUSXE3SmwrcFZxbytRMlZraWxzWHVkbW1aOUNy?=
 =?utf-8?B?WEVwUjBrcWc2bW8waGhrdmthSXhpU2IrTkRKL2F1NzQ0cnJsaUdtSjg5cmZN?=
 =?utf-8?B?cFZWYWZwaUtmZ0NoV0hGU0dxUTZmbTdoSlVjRHlsVmpJOGY5QjNyN29Vc3or?=
 =?utf-8?B?Z0NtWCt4L1Q2cUozaTIyWXh3NDNtME9xTURlZkptY2hQaGptdGFSTWhnUFNo?=
 =?utf-8?B?MExiQ24vZTUrdjdNSmRtOUFuZWdFN0M4ZXNnaGNySFpuOG9OTmZOaERycU1H?=
 =?utf-8?B?NkNkS2tYQ2FVZ1Jwak1NQ0I5c3NUSXIzVFM4RlgvZ0RNWStVb093N3huVnpN?=
 =?utf-8?B?RnBiODhxWUEwbWNCRlBGc2FHRWd1VUJ5STVyK296NFVwM2hJKytyRnlKaWc4?=
 =?utf-8?B?cEpmWElLQWZtRFFVSzV0bDR0WkhGcURjVlkrTkcwcUMxK3N4TytvQ2pwSVBa?=
 =?utf-8?B?TEVVeWhZWHRoaThLUGNHeEVuMEFTMmdURi9EMGhqV0U2aHFwUmd4RGNUUEkw?=
 =?utf-8?B?UTJybVlFMlRSQUNCUzJWVzFoTXJMbTRJaEl4dENSbXJ1N3RRTXM5Y0QvZkJk?=
 =?utf-8?B?OXRFR0tzamVWYmZBT3RXQzNleVBjNTVhS0NIWmtmdkNhSXRMeDFQS1lkR3hE?=
 =?utf-8?B?WjkyWlpkSURxYk9LYzBxS3prUDh4N2FNN2RJVnhYb0FWallINXI0UzU3U0hV?=
 =?utf-8?B?dnVOcVkzTDJXL002RzFPYW1XNWJUMzNqc0VyUmY5Z0VCQlZCZ1lwMXc3Tlgw?=
 =?utf-8?B?SThpRmFtMmVYeWE5d3I5eHFpaG1VUVV4Q1hSK09zYUFzYWNlU3NVZUswUmFO?=
 =?utf-8?B?OG53dENOeGlnbVBDNTZxQk1nZFllc1VTb1RFakxLaWszNFEveGtQaDkzTHFm?=
 =?utf-8?B?c2h3TVpvNXN6RXlSQ01LeTFBbkxneHJRdUJnbzQrU09lR3RIcGUzMUlzQU8v?=
 =?utf-8?B?bE1zUzlOQk5mcm5Ib2tjQno1czg0VVBlWW8yNXp5TU9PUkFJTkMxNGxKQzk1?=
 =?utf-8?B?Wk9OREh2VFpjVGRJdjRmWGhGdW8zalAxdmNnQ2hNVUZ1Q0duZ1g4RU85amdI?=
 =?utf-8?B?UUM3ckxERXhDRGMrSThOeXBiVFgrRHl5M3F1L0x4Wi96eWVwNjMyRWd4YTB6?=
 =?utf-8?B?UTdGemxDTlk5UjdOUzV3eE5lWTNxYkZkaWFHUjVhK1Rjd3lFdE1ydmVEYzRI?=
 =?utf-8?B?dTdKNVVKMGQxSmFQalFnT1dNcE5wWVAxUUZRMkt0cnFxMTZnYksvamNLdU5t?=
 =?utf-8?B?SWJXczUvTmxZKzYweks1SjRDbi9hRmhxM0ZkTXpJQUQ1NzQvL2hYREI1UWtY?=
 =?utf-8?Q?Olh/TLmkupRE+sBM=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3880385d-2660-4af0-bf7d-08da2ee8e136
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 22:44:57.3192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHp90yajZ0QYRq2HROQxcdRvVIns0N5jIhqoqUY0VIRvYiz1I13rVJlvoxWIO1Xv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB4260
X-Proofpoint-ORIG-GUID: xwj03OMTFApva_Tnmc9Gn1AsqVBAaYo-
X-Proofpoint-GUID: xwj03OMTFApva_Tnmc9Gn1AsqVBAaYo-
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-05_10,2022-05-05_01,2022-02-23_01
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/3/22 10:22 AM, kernel test robot wrote:
> Hi Yonghong,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on bpf-next/master]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Yonghong-Song/bpf-Add-64bit-enum-value-support/20220502-030301
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git master
> config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220504/202205040133.jd7yTwg5-lkp@intel.com/config )
> compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> New smatch warnings:
> tools/lib/bpf/relo_core.c:348 bpf_core_fields_are_compat() warn: if();
> 
> Old smatch warnings:
> tools/lib/bpf/relo_core.c:349 bpf_core_fields_are_compat() warn: if();

The following change should work:

diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
index 1e751400427b..2c8d5292e946 100644
--- a/tools/lib/bpf/relo_core.c
+++ b/tools/lib/bpf/relo_core.c
@@ -345,9 +345,8 @@ static int bpf_core_fields_are_compat(const struct 
btf *local_btf,
         if (btf_is_composite(local_type) && btf_is_composite(targ_type))
                 return 1;
         if (btf_kind(local_type) != btf_kind(targ_type)) {
-               if (btf_is_enum(local_type) && btf_is_enum64(targ_type)) ;
-               else if (btf_is_enum64(local_type) && 
btf_is_enum(targ_type)) ;
-               else return 0;
+               if (!btf_is_enum(local_type) || !btf_is_enum64(targ_type))
+                       return 0;
         }

         switch (btf_kind(local_type)) {

I will wait for more comments before submitting version 2.

> 
> vim +348 tools/lib/bpf/relo_core.c
> 
>     314	
>     315	/* Check two types for compatibility for the purpose of field access
>     316	 * relocation. const/volatile/restrict and typedefs are skipped to ensure we
>     317	 * are relocating semantically compatible entities:
>     318	 *   - any two STRUCTs/UNIONs are compatible and can be mixed;
>     319	 *   - any two FWDs are compatible, if their names match (modulo flavor suffix);
>     320	 *   - any two PTRs are always compatible;
>     321	 *   - for ENUMs, names should be the same (ignoring flavor suffix) or at
>     322	 *     least one of enums should be anonymous;
>     323	 *   - for ENUMs, check sizes, names are ignored;
>     324	 *   - for INT, size and signedness are ignored;
>     325	 *   - any two FLOATs are always compatible;
>     326	 *   - for ARRAY, dimensionality is ignored, element types are checked for
>     327	 *     compatibility recursively;
>     328	 *   - everything else shouldn't be ever a target of relocation.
>     329	 * These rules are not set in stone and probably will be adjusted as we get
>     330	 * more experience with using BPF CO-RE relocations.
>     331	 */
>     332	static int bpf_core_fields_are_compat(const struct btf *local_btf,
>     333					      __u32 local_id,
>     334					      const struct btf *targ_btf,
>     335					      __u32 targ_id)
>     336	{
>     337		const struct btf_type *local_type, *targ_type;
>     338	
>     339	recur:
>     340		local_type = skip_mods_and_typedefs(local_btf, local_id, &local_id);
>     341		targ_type = skip_mods_and_typedefs(targ_btf, targ_id, &targ_id);
>     342		if (!local_type || !targ_type)
>     343			return -EINVAL;
>     344	
>     345		if (btf_is_composite(local_type) && btf_is_composite(targ_type))
>     346			return 1;
>     347		if (btf_kind(local_type) != btf_kind(targ_type)) {
>   > 348			if (btf_is_enum(local_type) && btf_is_enum64(targ_type)) ;
>     349			else if (btf_is_enum64(local_type) && btf_is_enum(targ_type)) ;
>     350			else return 0;
>     351		}
>     352	
>     353		switch (btf_kind(local_type)) {
>     354		case BTF_KIND_PTR:
>     355		case BTF_KIND_FLOAT:
>     356			return 1;
>     357		case BTF_KIND_FWD:
>     358		case BTF_KIND_ENUM:
>     359		case BTF_KIND_ENUM64: {
>     360			const char *local_name, *targ_name;
>     361			size_t local_len, targ_len;
>     362	
>     363			local_name = btf__name_by_offset(local_btf,
>     364							 local_type->name_off);
>     365			targ_name = btf__name_by_offset(targ_btf, targ_type->name_off);
>     366			local_len = bpf_core_essential_name_len(local_name);
>     367			targ_len = bpf_core_essential_name_len(targ_name);
>     368			/* one of them is anonymous or both w/ same flavor-less names */
>     369			return local_len == 0 || targ_len == 0 ||
>     370			       (local_len == targ_len &&
>     371				strncmp(local_name, targ_name, local_len) == 0);
>     372		}
>     373		case BTF_KIND_INT:
>     374			/* just reject deprecated bitfield-like integers; all other
>     375			 * integers are by default compatible between each other
>     376			 */
>     377			return btf_int_offset(local_type) == 0 &&
>     378			       btf_int_offset(targ_type) == 0;
>     379		case BTF_KIND_ARRAY:
>     380			local_id = btf_array(local_type)->type;
>     381			targ_id = btf_array(targ_type)->type;
>     382			goto recur;
>     383		default:
>     384			return 0;
>     385		}
>     386	}
>     387	
> 
