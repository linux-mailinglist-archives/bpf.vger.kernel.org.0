Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A981E67C465
	for <lists+bpf@lfdr.de>; Thu, 26 Jan 2023 06:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235936AbjAZFto (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Jan 2023 00:49:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235678AbjAZFtn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 26 Jan 2023 00:49:43 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D04A29E37
        for <bpf@vger.kernel.org>; Wed, 25 Jan 2023 21:49:42 -0800 (PST)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30Q3WuR4008627;
        Wed, 25 Jan 2023 21:49:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=xpO+tKrh32289Gy/GlcS9qoboRFUTpfa4NV1HcrSel0=;
 b=j6F9NvphUPhpzfla3MOwDJ3JKmPr1YK4yE7o2FjWtpMkx1qAm1qfIrpvV4+fo+LEwIG2
 NmONNiAYU9GhDugTceqi35pG3tGYMzkQ6yzcfIO06IcWPpGYx320LoOCAf4jOsKmokHo
 CeyFIJg4PlMm02pDTCKes53Xp+DmxO1wwOg+LXSaWQR+eFuQMGjbixhnEKkbzeaDMjei
 fMzpA+PXUFP10vHGPUfYMjGaHzyemehpHy/gduBOBUst5Bb/AzvDpbETaygQbgFv+fO3
 EmWQq8U101dBvFOT7O2wTc2G9BgRFxCxVKFBPQ0irdIV3Q9yDDuSvN3hXrqL7df/ebUK KQ== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nakkbjhga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 25 Jan 2023 21:49:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jv1EfeE3oHcB4twto1QTqq9DHm4bOt3y5sCXYBKuTREipzz3s/pEufqAv6wRgNvqlbuxavv0zYkvleOobHw30YvW0OjxyI8iApft2qUO9mWRP/JE4+u0h+CYwae6zUPvGKAJVDSVQnYee1ADj4bi6vtPyKSx++bE13CJ8ik0fXiYVurzitOIuAjiEF5OXSsvxlTZGZ5YGWcTt/9gh80OLISsQDol/JdsZkDjAQrBN0TAfWSkQTmpsFWf8SvE5oevz/gv5FbgknoSzorZZDJiihz6p6n3SgdhhnttjV6qIO94eMOqsoObkh8rCALgwByDev5mC7ndJGid+ctyTwf+9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpO+tKrh32289Gy/GlcS9qoboRFUTpfa4NV1HcrSel0=;
 b=IcOX6gZXkNCGABInuURJ5f8kOC9QlcOyLk9vNEEwq/H1UQrlsOEwDyFnxgHKE5TldcXZJn9ucArLGcQZR9t/qDQn5rHEyXEnDojpr0FDSMNuB4WIUV32cTKqUrE/a3Cdy9dCOytjCekbxV/NHF0PReRQJnFTiUhIsQ2DmgLZOi+DujutFj/ZGpR5ll1I2NOQD8ZJPhG4xiuPWywwFJE3FQKxWh8HWiJVGmechxWXTYySlBen5+QB67LNdSKukGXa6C3wGuJywnTWBQRu7wQZY0r8YHlb6cEQe8zAAVg/cFAxaJmrofvtLpfpi2QghVufCmHLpAaV09sCK85DeFVwZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by MW5PR15MB5145.namprd15.prod.outlook.com (2603:10b6:303:197::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Thu, 26 Jan
 2023 05:49:24 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::d262:2be7:fdcc:7cfe]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::d262:2be7:fdcc:7cfe%7]) with mapi id 15.20.6043.021; Thu, 26 Jan 2023
 05:49:24 +0000
Message-ID: <58f2f815-e7d8-8205-4669-ed2254d813d1@meta.com>
Date:   Wed, 25 Jan 2023 21:49:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC bpf-next 0/5] Support for BPF_ST instruction in LLVM C
 compiler
To:     Eduard Zingerman <eddyz87@gmail.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        Yonghong Song <yhs@meta.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, yhs@fb.com, david.faust@oracle.com,
        James Hilliard <james.hilliard1@gmail.com>
References: <20221231163122.1360813-1-eddyz87@gmail.com>
 <CAEf4BzbNM_U4b3gi4AwiTV5GMXEsAsJx8sMVA32ijJRygrVpFg@mail.gmail.com>
 <874jt5mh2j.fsf@oracle.com>
 <1155fda8d54188f04270bb72c625d91f772e9999.camel@gmail.com>
 <20230112222719.gdxwdocfutpbxust@MacBook-Pro-6.local.dhcp.thefacebook.com>
 <790ab9fd-dbcf-4593-1634-6f706675cde2@meta.com> <87a62mhl3m.fsf@oracle.com>
 <f1e4282bf00aa21a72fc5906f8c3be1ae6c94a5e.camel@gmail.com>
Content-Language: en-US
From:   Alexei Starovoitov <ast@meta.com>
In-Reply-To: <f1e4282bf00aa21a72fc5906f8c3be1ae6c94a5e.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|MW5PR15MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb38641-8862-4c06-045e-08daff6113e5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QE1qbS9Q7cKoXasdlVu1xMKAv78JP0CRmyna8aKNRStkRtpn3K43YsfNYBqA99VRhg5IG9KAOTb1e56BRN57coUlqAvZ7ahMH+RluY8bjTj930bY4qX2/WJANZbgDzoHH3NsNFLrjTRGDQKH9iljWGrEPaE2cJGdc7cYmUoFWeuWdkbrfYlYjrrWqi5ICTtZeqne80Af89hltvgKXBnUO+RXXbVQKXHbmEcNFftq0CmR7rTmpq+9M0Vuymh/Kn1moexS7MXoyVHHb/euiL16hNx3Ag1ErcnMYPJ3kPDiqdK7jMZezf6bZO0T8MaIKIsl/ymRlZutNpdEDUeSpMQix6/lIiWLkrf5w7DUqB0nc1cpCKNP3kOdUtxQp/RQ03rwZk4j7kMIGhMjNoJL3aDl/fabK7khtq0X9wTjsKZbpKrVC0Ih9zhzB9Bl4p57+zu69tA95aP+okjqDvBchJ46hZdkMJK2Mh0Cgy3anHLwm0vi5jKLCtWQdnnYj+XJBouLLjM/usFMqymVuQKSZNP1M2912h4Pmz6GmJBZ4eY2+FIk/mtFTDurA5CUKZg0x1ZUPHn4X5RBf9kB7bX+QcQsPiVuATFWax4yZK6l1maaGGcVa351YyosA+wEk1LibF8dVIZHfoI9yFYCvGpd+so93/CMHx4jP5ms1ZhW2x69uFLSLeMqD6ie6DVUp4LcKrOBR9EnO7UtXWuaY2DvmvfpWPMtooTV1o3wZFdzhNxTaXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199018)(478600001)(6512007)(31696002)(26005)(54906003)(110136005)(316002)(86362001)(38100700002)(2616005)(31686004)(6506007)(41300700001)(186003)(6666004)(83380400001)(8676002)(6486002)(2906002)(53546011)(8936002)(5660300002)(4326008)(7416002)(66476007)(66946007)(36756003)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlpvaExBc2dDWjB3Vk5rRW0raFg4UnZvZ2k3Q1IzeHdVQ0Y4UHdpOWU0Rk9C?=
 =?utf-8?B?cUltaGNEaUpXcXhWV1hmV1FVWWt5dE1ZV3d4QW4yYmdGYzZPdjdsY0VZRWJo?=
 =?utf-8?B?OEJPcVd1bUtLaFduSTMyem9MR1dFamkreDhkdzEzZFdMdEUvNkZQUG9oRGlN?=
 =?utf-8?B?dFJBVnJkMUMzUTNKbGhGYjFSYmRLOVA1Yk5ScWRtV1ZMK2h4c0d1STZjalpN?=
 =?utf-8?B?ZmtDMHFQRzJWbDdrRzI1aFBxV2o1eS9IZWFOOVRDODVPYSs2UmZkcXJ6RUNw?=
 =?utf-8?B?M1QwT1VMT1ZXcmZWOUtvakpuWExQRXF3WC9HSTlha2RQR2tRbkx5UWFnZHYr?=
 =?utf-8?B?UVkyVWRFY0dGZjdwa3FDUjVlQk51UFQrUVF2U05iY2Qzb0xzMEtIWFNtZ3lU?=
 =?utf-8?B?SWRYdFVHQ0orMDlLSG9wM0NkQWVzNlJQTUlEeVBtcnFTZHBmcjlvNjgrUlBt?=
 =?utf-8?B?TEpKRytGRGZXeWtPZEJlV0NsbFpoNktPTEtkWU1MRUk2V1FRakx5NjJ3VzVJ?=
 =?utf-8?B?MHhtcUIxZkVraGZXeFBpZjVDRDZrM3RDL2FSMVdzbXVRTC9BSjdabVU1WFRp?=
 =?utf-8?B?WGNFemNoK2FxRHJ1cEI4SG5XOUZyV0Y0OUdaVXMrbTdLWWRIR0s1aDJ5QXAw?=
 =?utf-8?B?L2I0bmJDd2IwS041bkFITHMzUXFNa21rTG91MWM3RjVhTjdIVXByM042dFJy?=
 =?utf-8?B?bHpsbEMrb3pvWWVDYkEzVktTYjFJYW1pY1p3bFNhdGZiMlFxb1dIZHdMSjNT?=
 =?utf-8?B?akZJSm10RjR1dVo3dGlnSXVETHh2T2lnZ0J0eUZvVkc3NjhsZEtKY2ZsVnlv?=
 =?utf-8?B?RHpFclh0TUVSZVhiYklwM082azNla3Nla3N4clQ4UWx1YTVGL1p1R0NQS1JL?=
 =?utf-8?B?cG8vdDlvNFZneVowd3BtRGxzVUl5R0JyNjJnalRybDk3NlpGNFJtZXVWeENv?=
 =?utf-8?B?NWo0RUZ0eFdqTzNpYlNENmxVR3dTaDZIYldyVllEUi90ckU2Nk9FOS96cm9o?=
 =?utf-8?B?QmdPNmtxbkdPOEEvVG5sanY5dmIxbDk5NVczdjQ4K1lIN0FqQkh5RDFldUpZ?=
 =?utf-8?B?RzRBWXg1T1hrdGdITVk2aVRKb0F0aDNnamNoREZBMnM1MHlac203RXJ4YXFp?=
 =?utf-8?B?M29xaGdhOVc4a1E5QytqeDFPd2trWHRQZW1mdU1pWEU3NE5SRzRFd3pBdm55?=
 =?utf-8?B?cjY4ZVYveUN1dzI0eldGaVVYK3ZpRmxTWXpMWm9Pdms2SlhIQmFoUDFVUUo1?=
 =?utf-8?B?cmdGUlNqLzJNSU1vNDVNcUNBcHFYQjhHQUp1U3lWU29EZzcxSGJueUpaUE1I?=
 =?utf-8?B?R3RDV0pFY3VwMGlpU3pnVnlCbHVBc09USXZwOGpkV0lvSHZxSnl6dC9xWHRa?=
 =?utf-8?B?a3BkQVVXVTk3YlkyZlRwYUtjS0NZTUk4SkhCVzd3MW5OQjFUZjRwRG1wQ0RQ?=
 =?utf-8?B?NUNwWmJ4eStRUGJPaG5sY2toSnhkR1FUSDRpajIwRzBjVmVYdEgxMnhxblJt?=
 =?utf-8?B?U1Fuczd0WEVTMVV3YVYxTWRqaUQvaWFwdkVxK2tLV0cyUTd4bkFOYVJGWHMv?=
 =?utf-8?B?Wmo1ZElWaW5aeURoYUVqelR2SXgxd0prM0taWXJ5S3pPUjYyNlQycUd5R2hH?=
 =?utf-8?B?WlhmeTltMk1saGtMOEMwQllQc3dPbXppcmJJMVMvaWRibDZiaW9WcXExVUx3?=
 =?utf-8?B?UXR5a3Ztb0pyenovdW05MHBDNHREbU4xT0VFakw0aHpZUlJJc0ZXWS94MExk?=
 =?utf-8?B?eFRRdWtHRHlUbytrTUdSS3Rzbk0zT1QrN0ZQVTZyRlYvZVUycjBiTzMvMWpa?=
 =?utf-8?B?QjIyOFVtUEQrbW9XSU9PVlpZbFdPWU05bkFod1Zhd2ZoMmo4SnlSU1NxVjNj?=
 =?utf-8?B?a0V3dC9ocFdxTDlDZTlOdGE0eFBIUUhSTGdxUVhpZlQrU25UcS94TlJuSDNN?=
 =?utf-8?B?QVcyUG5jTXNJM3ROdEV3cnRQN1VhVVRCS3dlL1dyWFcreEV3RUgySDRoOVlI?=
 =?utf-8?B?dm1wM0l3aWh0Zklhd2VSM1hiOXN6cFFzcHJyZHpObG1HdUdhSTI5d0tWZDgr?=
 =?utf-8?B?MFpXaHdMd1dEY1JrYXdtWGg1eEY1OW1EaVZ6K1FkUU9CMUZaZi9aUUh4OVBh?=
 =?utf-8?Q?mqhI=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb38641-8862-4c06-045e-08daff6113e5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 05:49:23.9213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pBDg6MXihiJvUL32F1mX4LRpRBmU/xsPzW9lpkjzgJ4EOhrCimRJ7T1IqKrzFs3C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR15MB5145
X-Proofpoint-GUID: cSCSpJN5pEjL08LXZ2bBCsU7llrXZ2v_
X-Proofpoint-ORIG-GUID: cSCSpJN5pEjL08LXZ2bBCsU7llrXZ2v_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-26_01,2023-01-25_01,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/13/23 8:47 AM, Eduard Zingerman wrote:
>>>>         So the patch extends this logic to also handle BPF_ST.
>>>> The patch 3 is necessary to land before llvm starts generating 'st'
>>>> for ctx access.
>>>> That's clear, but I'm missing why patch 1 is necessary.
>>>> Sure, it's making the verifier understand scalar spills with 'st' and
>>>> makes 'st' equivalent to 'stx', but I'm missing why it's necessary.
>>>> What kind of programs fail to be verified when llvm starts generating 'st' ?
> 
> I should have added an example to the summary. There are a few
> test_prog tests that fail w/o this patch, namely atomic_bounds,
> dynptr, for_each, xdp_noinline, xdp_synproxy.
> 
> Here is how atomic_bounds looks:
> 
>    SEC("fentry/bpf_fentry_test1")
>    int BPF_PROG(sub, int x)
>    {
>            int a = 0;
>            int b = __sync_fetch_and_add(&a, 1);
>            /* b is certainly 0 here. Can the verifier tell? */
>            while (b)
>                    continue;
>            return 0;
>    }
> 
>      Compiled w/o BPF_ST                  Compiled with BPF_ST
>    
>    <sub>:                               <sub>:
>      w1 = 0x0
>      *(u32 *)(r10 - 0x4) = r1             *(u32 *)(r10 - 0x4) = 0x0
>      w1 = 0x1                             w1 = 0x1
>      lock *(u32 *)(r10 - 0x4) += r1       lock *(u32 *)(r10 - 0x4) += r1
>      if w1 == 0x0 goto +0x1 <LBB0_2>      if w1 == 0x0 goto +0x1 <LBB0_2>
>    
>    <LBB0_1>:                            <LBB0_1>:
>      goto -0x1 <LBB0_1>                   goto -0x1 <LBB0_1>
>    
>    <LBB0_2>:                            <LBB0_2>:
>      w0 = 0x0                             w0 = 0x0
>      exit                                 exit
> 
> When compiled with BPF_ST and verified w/o the patch #1 verification log
> looks as follows:
> 
>    0: R1=ctx(off=0,imm=0) R10=fp0
>    0: (62) *(u32 *)(r10 -4) = 0          ; R10=fp0 fp-8=mmmm????
>    1: (b4) w1 = 1                        ; R1_w=1
>    2: (c3) r1 = atomic_fetch_add((u32 *)(r10 -4), r1)    ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff)) R10=fp0 fp-8=mmmm????
>    3: (16) if w1 == 0x0 goto pc+1        ; R1_w=scalar(umax=4294967295,var_off=(0x0; 0xffffffff))
>    4: (05) goto pc-1
>    4: (05) goto pc-1
>    4: (05) goto pc-1
>    4: (05) goto pc-1
>    infinite loop detected at insn 4
> 
> When compiled w/o BPF_ST and verified w/o the patch #1 verification log
> looks as follows:
> 
>    func#0 @0
>    reg type unsupported for arg#0 function sub#5
>    0: R1=ctx(off=0,imm=0) R10=fp0
>    0: (b4) w1 = 0                        ; R1_w=0
>    1: (63) *(u32 *)(r10 -4) = r1
>    last_idx 1 first_idx 0
>    regs=2 stack=0 before 0: (b4) w1 = 0
>    2: R1_w=0 R10=fp0 fp-8=0000????
>    2: (b4) w1 = 1                        ; R1_w=1
>    ; int b = __sync_fetch_and_add(&a, 1);
>    3: (c3) r1 = atomic_fetch_add((u32 *)(r10 -4), r1)    ; R1_w=P0 R10=fp0 fp-8=mmmm????
>    4: (16) if w1 == 0x0 goto pc+1
>    6: R1_w=P0
>    6: (b4) w0 = 0                        ; R0_w=0
>    7: (95) exit
>    processed 7 insns (limit 1000000) max_states_per_insn 0 total_states 0 peak_states 0 mark_read 0
> 
> The difference comes from the way zero write to `r10-4` is processed,
> with BPF_ST it is tracked as `fp-8=mmmm????` after write, without BPF_ST
> it is tracked as `fp-8=0000???? after` write.
> 
> Which is caused by the way `check_stack_write_fixed_off()` is written.
> For the register spills it either saves the complete register state or
> STACK_ZERO if register is known to be zero. However, for the BPF_ST it
> just saves STACK_MISC. Hence, the patch #1.

Thank you for explaining.
Though llvm changes are not ready, let's land the required
kernel changes now.
Please craft asm test cases for the issues you've seen with BPF_ST.
