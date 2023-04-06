Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3766D9F8B
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 20:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbjDFSKx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 14:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjDFSKw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 14:10:52 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C28E9449A
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 11:10:51 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 336FKer0025837;
        Thu, 6 Apr 2023 11:10:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=va1L1isP3Re34ePnf+oWqJkzK0KvWynotu/zCSRaJ8o=;
 b=YmzP0wyvE58JO2Xxd1az2qDZtYudtM4y5Id/1ZrqY4b84k3AXtmA7b7SEb7arnbXN3hn
 DRCEqOrCY7KTmDYAVUe5FVWMVC05JPQi10OZ3t17ih90kXOhpGP+5agaeJb/UAQUZOR+
 mbsUkTFz743h6E+0MGrSnQbOfLZ+y5KOIBJrfSmY0mu2kTSzzg5D6yMWO+X8bCGSihUY
 hUflltdbEuWJXW2Ulq3flMkoq61ITXYlTxNAm709AvNhMsZy1Dlkli0f0phOiRs8n7Pp
 R7BuzU4cjCk7mzrl6+JGSF7UGRPoDBwr71oK9LEfOcS8EgCIR148VJLa15XhnRVlNbgc Bw== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2043.outbound.protection.outlook.com [104.47.57.43])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ps9bg9tcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Apr 2023 11:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RqfKk5ULlREot88D5x3TP768RfdSWIEnJDX6+t8b+qjALAGEnYP+diDBJ0tBEv5QdT0Io7KAndT5hYaNzqUxpyACeL7+DBe0uEhwNHDvaHSCKRE5ggM36wfHI2gaJRn1E+bx3325drFPKODwjlEtrM3V6/f1mKROF9CI4gyWk3VqAm9F9OkoRsdB6BK/Li5LOVDzNUwYxp6G7RZYkbNgm6WTpGAZIdr2/sUZ4sUlJ0/5XuNteB8s0yGdxFZX3WcbqLpPUcgJTnzE0qz1U8uW/ffghDVPvjpimABSh3kmVKO21oLgU66hNPjGmPjtxS/iPe3wSQhLGaM0X2DI+npLFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=va1L1isP3Re34ePnf+oWqJkzK0KvWynotu/zCSRaJ8o=;
 b=aiAkPtmCg3YC567/0+8eZ7Z0UQCE5awp3kTnb1hwsHGI61tYHlRkZ4lRSetFj/N2FbSNAo0zcYqbdMpggZT+ssPox41EsBKm5zKuFHZ+WEuTJMvmCL5qbWaUfS2FbZXHTJTrZRI7Amr44nHkfsk04+FrD9DCIgtiNLuclqV8NnFv0fda9vdkMdpqsE6HyxAdj+omgHu14+Nn6F4SzmtwKlCuo3ev/aa9xEOyfOWsDPlELRs3texuwB1rWqPIKscB+4iQmpPsO2dasIrPy2kvGHDtJa0E3VHHBYhUKk2+aHryLBjWjqo9GrCr5yZ+6Gs/8ql8520N0Lw0GD/tmOpCRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by CH3PR15MB5515.namprd15.prod.outlook.com (2603:10b6:610:142::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Thu, 6 Apr
 2023 18:10:34 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b173:3262:a66e:b7e2]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::b173:3262:a66e:b7e2%8]) with mapi id 15.20.6254.035; Thu, 6 Apr 2023
 18:10:34 +0000
Message-ID: <97ba28ef-b825-94d2-e90f-89969160a86d@meta.com>
Date:   Thu, 6 Apr 2023 14:10:31 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH bpf-next v2 3/4] bpf: Improve handling of pattern '<const>
 <cond_op> <non_const>' in verifier
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20230406164450.1044952-1-yhs@fb.com>
 <20230406164505.1046801-1-yhs@fb.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230406164505.1046801-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:2d::40) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|CH3PR15MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 431431ca-3601-4b53-12f0-08db36ca372d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hNDMF4v/yob5RtCYUt7VPeSdTaXE37bKrmc9uCFO/YA0Ti0z/vXMNMJdwCvmnHlzF8ICMN1oEA6meq6xG/MvpQvic7eie087LGRFnqYZOIJsaLH+KTZL/IFeTtNq8TklmH/L4ZiM0Yqh/oAkZQjGov6eWr+EVplUpJpSV9roCW0/6CIGpfXxSv0MOx8ri+djcVfKh5aCrWOF4xO379PPkkcy65ACpwse9Nw2zvRqIWgobYQzm94Y1BZNzTsJSIwFkR8n1ve9BSmsdf67v10d48A3oggEMV03iRPpEoxJbxQvr99yLzZpOzIgn56A9vGPaoQkoQHV7CMB2A37lEKhvrSWgdffpV2IG+zLzV9WKsB4TAcmPqqmrXvm0Oq/aAgvpZbnf/KAIUJkyIVwF7TPkadD/OwQuMN8em7ytU1asDZWxhBt0rympGy/w1AOiBDpSAvD8kYM8B1P/UgLttieDrIsvKiCaHsgcfO3hdDJz4ofgxnUloX9RwaqaaBCfxIF3xXZGjoy5n4/K24OnVjhVKBdcFhYRvQzl/EbrTWlWQpvPDu3RlfUEuiTjBpDBotuGjcuIDgPsQoTRJwE+u4PK96InB1CYDUwv43IpeVv3x18ATq/sATj9kGEJFfONaF/VuuryX06YFRYdaDnCPXjaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(8936002)(41300700001)(4326008)(8676002)(31686004)(83380400001)(316002)(5660300002)(38100700002)(66946007)(54906003)(66476007)(66556008)(6486002)(478600001)(2906002)(36756003)(186003)(6666004)(2616005)(6512007)(6506007)(86362001)(53546011)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2hJcGgzWmVrVTlLWi9jNnhDcE5Gd3ZqR0FJY3UrUUtxckVmbkY1d2FkNmxX?=
 =?utf-8?B?YUNSOWZZc0tvcHAwdWJMRldFUXVpVHF2THE1M0tkdWQwdmV4N3o5a1lVbjQ1?=
 =?utf-8?B?YW55VWc1UC9LZkU1RGsvVXlQb0dtcTRmWWx1eUZHVjZVY1J1WWZhak41NTRU?=
 =?utf-8?B?b05lSzk2b2Q1ekMwN3lWUWhVcFVheEtmU0t6bWJMVC9Kd1g1emlDeUFDNlBI?=
 =?utf-8?B?K3FadTkyRXo5QkJtODdUdWdnNXZjOTl3ZXN1S3kvNFYvcTRTc1BBbnh2WVln?=
 =?utf-8?B?Yzk3b1VQTGVBSWwxVFkyb2VQckZla0VDVHZXcEpUVEJCTlZwMnZUYkNjUU1o?=
 =?utf-8?B?Y1Zhd1dwbU1CSmhyQ1U3QUt5NlR6TzNFN3d4TEdzeUZjNFcyaW43S3lRRStw?=
 =?utf-8?B?MFlYTWRaTnQreHp6a1NQTXd3Z3BVZzFGR1VSUU1CT2k0NUIyckNMWlBpL1Rx?=
 =?utf-8?B?dmFkNXJMcVBZQzZJVkw4eFRNYVBvWGJzSGFhR3g1UDIzMGJmWGJjS2VpUHpY?=
 =?utf-8?B?OW5McTVhNHpaYlBhcmRUWVJrRENCOU55MlVKVlFKaUlxTnlnNUV4ZElETkh1?=
 =?utf-8?B?RUJJT1BHSnphZDZmZTVoSWM5V3Q2b2JESzBiem9PSDJOQWQvdGdMYkRXeTZn?=
 =?utf-8?B?eGFCYmc0aEk0SXcxZG0wRUFmVU5BbGh1VDhTNlhHODVJVW4zVWh4VG1KckFn?=
 =?utf-8?B?ekljUDdRMUEwY0Q1NnhCanBaZU5pNFM4TWV6WHNUWHpaMVIxWHJoSElmMndR?=
 =?utf-8?B?SUJQWWFnSHN2dURhNVZRa3ZDWTVEcW43dUM0bUZxTHRFMVcyVVNFb3BRc0hs?=
 =?utf-8?B?VDFHS0RCR2JUVklidGtDWlFkYWt0Qk5ZekwwL2Z6TFV5cjhSV3pDazNsTlVB?=
 =?utf-8?B?SnpPL3hoN2czcEhxOGhLUjBLVzRlRXEvSWQ0OHZjM3NXUHdSUUtOV1JrOEYv?=
 =?utf-8?B?SjRQbXVHdk41eUpaWFowRXFqaG0yZnNmNXlaMUpBbGZXZk0vZGdqM0NDblhS?=
 =?utf-8?B?THkwVE0zMjlweVpyRFBycithOUpXVlVveDBBMFJxL2E1dmQ0Qnh0UE43YXUv?=
 =?utf-8?B?aXhRN0syMlBrSGEwR2hXdFUwMzhaNFBQQVhnYjc4MmV5SzZGaVhINEwyamcy?=
 =?utf-8?B?bWxnSlpCVS8ySXdYdkQ1WXFCVS8zKzBhSHI3OTF5bmtzLytCSUIrdSthVFRQ?=
 =?utf-8?B?dHJuek45MXlIUmlHZjR0K2wxMFlEc2VZbTlrTzJXRVJCSlpNdWpjWEZXNkZV?=
 =?utf-8?B?NUVNeXRRU0xIMXJsVjJzeVJwN3BxcGl1VmtoZnVSdy9waUd2azQ4bGtyT211?=
 =?utf-8?B?WjdYY1M5VFhLYjBKbnU4ZStqWjc0R1VmdTZWeDRBUFVzcm1iS0JiMW9wSXM0?=
 =?utf-8?B?TXkrRFVHZ05QWk1uU1Z2MHZZVWI1cGJDNXpoVC9LbDV2amNFR29wbXIvOWo2?=
 =?utf-8?B?a0JxTG9NVWFPL0tBYjExamo3Ukdxamk4dTRmcFNoOUtJRTgxME1XWlJMc0hT?=
 =?utf-8?B?WDJVelM0cGpVV25qVWJOTlgxZ1VLOUNpUjNValN0cFFBMzNLeG5qZUw4c2R3?=
 =?utf-8?B?Mm1mWFRYZUlnTUNUMUpCMFhDYlZjMGF5NWpzb0lHTlY3VXI4NDVDcXJYWjdm?=
 =?utf-8?B?OWUxc2NUTFROSEpJeTZjRTkrUnRTY0lBUG1jZ2t3WklBMVdUU2tCcUtBd3di?=
 =?utf-8?B?TTZhL2ZOQ0k1NkhoYnhNZHgwbW05OGtjeDNnaDU4RkQzTjVQOE1nM29yU0or?=
 =?utf-8?B?Q0cxenpTSlQvQkN6U3ZjdW5FTFFBLzg1SXZlaVNwU01rWm1jaHF0c1E1TGlR?=
 =?utf-8?B?amNwZDdUV0JNNy9hcGRGWXE4RFlLcmYrL2pPWmdIMXBXb0dZSjZUNGZSMkhi?=
 =?utf-8?B?OGY0dmVvWWRmU3lpcnNUSlVVM1ljYXEvTUxHR0pBQkJWY29icWs0MHZyRmlX?=
 =?utf-8?B?STBjOFpob3Q1bUFmQXo5M0k3UUN1d2RNQStNS1pCTWlYTDNIMkl1SmtmdTZr?=
 =?utf-8?B?Z1dZcks2ZExHeW5rMzFRbUJIZXJJTFZrMmh2QlFkOFFYcTJTeVFOKzJjcFVu?=
 =?utf-8?B?b2NFeWc4dDBlN3Mya05qU21CallXRjI5VEg0eW1TYzZ3QkFRRTRWWHVJNzZi?=
 =?utf-8?B?WTNKS3I1RDJvYm5rdUxnZHl3V1lNNTNOQTZ6bHU2MkNEOE1vZDE2TTh2aXB1?=
 =?utf-8?Q?gjcZbDLypoMipfTUUX/hR0c=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431431ca-3601-4b53-12f0-08db36ca372d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2023 18:10:34.1380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUY/8xpm2PXZ2DTi2r23TXoMUPyIe9TVUFNJLcko1b6FXfwGLVH+pFv+HaSS6V6H+CFX8I0f/dc8adEzWRBS5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5515
X-Proofpoint-GUID: f70meYmGYwLE5e3DV7TBvq-a_mIoktyd
X-Proofpoint-ORIG-GUID: f70meYmGYwLE5e3DV7TBvq-a_mIoktyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-06_10,2023-04-06_03,2023-02-09_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/6/23 12:45 PM, Yonghong Song wrote:
> Currently, the verifier does not handle '<const> <cond_op> <non_const>' well.
> For example,
>   ...
>   10: (79) r1 = *(u64 *)(r10 -16)       ; R1_w=scalar() R10=fp0
>   11: (b7) r2 = 0                       ; R2_w=0
>   12: (2d) if r2 > r1 goto pc+2
>   13: (b7) r0 = 0
>   14: (95) exit
>   15: (65) if r1 s> 0x1 goto pc+3
>   16: (0f) r0 += r1
>   ...
> At insn 12, verifier decides both true and false branch are possible, but
> actually only false branch is possible.
> 
> Currently, the verifier already supports patterns '<non_const> <cond_op> <const>.
> Add support for patterns '<const> <cond_op> <non_const>' in a similar way.
> 
> Also fix selftest 'verifier_bounds_mix_sign_unsign/bounds checks mixing signed and unsigned, variant 10'
> due to this change.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

I still think there's a refactoring opportunity here, but I see your comments
on the related thread in v1 of this series, and don't think it's a blocker
to find cleanest refactor.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
