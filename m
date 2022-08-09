Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69FC58DAD7
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 17:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiHIPMZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 11:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiHIPMY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 11:12:24 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240F1C54
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 08:12:23 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279EdZIr011170;
        Tue, 9 Aug 2022 08:12:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=zFgiQjFOG5UW62pLBWb0Y8a4lxPqW2lEpjw0ztbV2o0=;
 b=pl3q5VAHiukzMMvVdp509lkzzBNHp7es8I1V3RaBD2tvZDZiNQEA2tEnoe74SYXKESBo
 TAX2X6HENTRlCnJd0CPT+m9wvf0+G2wY8IfVGEZwHUnXJ5EOmAT22rsSheSLXwHEjIuE
 cRIyyqZCBUBDh5U4y3CIITAqglsnad3bObg= 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3huagr57tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 08:12:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lem/nJvl6BH6D8Nk3NFhul/ch/7YQXzJZiOWEDou0F/1l7hD0xPBfz5be7D+XYdEst9t0kKjziBxa092mFAxLa85b3MpPNezdQutTYsAVzjrdbGoQ5NrzbsoN99w1NbxusR2UMLh2IbMEssTv1xVSWv7YhlVn/bwqdCB9tUb524tM/se7lR3pxc11FcG/QMOtf8dO0LlQ4Pxgbc3MYLebT4KcfE5xh0p7vy5ccO4aE6zyBDit6pZZjMfPpOfBES3eMiZINfkuqsnb4CGK24w/rq21mcXmVsKUVdMjelXOLtdKKoT47VKLkdy9Nq6wwEC19VC+QW6yQEhHN2Ql5ozjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFgiQjFOG5UW62pLBWb0Y8a4lxPqW2lEpjw0ztbV2o0=;
 b=A2zEzTtRgZsqDZUY/tQN4vC8D+mB/xVMXB7OYXiGMvY+bFMPqwTz75HzvVb27F3Xaz54eqRfAjPFcsQDanAYvXUn4wBgNbeMDleBGyP5+KDcTxILV6IDLPSqWyrfZDiX8MV2zj0Lq1F2e5OhV+aiv8bIlSKQvLxBRM3hyPTXufHzHSCMlAoWNQmOfP+O2QN4TsB9ij9savRMLjYzmJUig7nT8MIWZOc2SKer4NYoZm9PzYg2VNTpJ+1/ZlGoen1tjmG83VACVN8eBYSRPfFQSzdC+shU30z/wjJgTXikql9EYQDkIDuEsPc6lCzG2OX7csKEIInyz6CZLNp12dLfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4400.namprd15.prod.outlook.com (2603:10b6:510:82::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Tue, 9 Aug
 2022 15:12:07 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 15:12:06 +0000
Message-ID: <d854ff88-cb8c-e2df-ef96-dde1498649e0@fb.com>
Date:   Tue, 9 Aug 2022 08:12:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH bpf v2 1/3] bpf: Allow calling bpf_prog_test kfuncs in
 tracing programs
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
References: <20220809140615.21231-1-memxor@gmail.com>
 <20220809140615.21231-2-memxor@gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220809140615.21231-2-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0042.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9f92194-87b0-4d55-d9e7-08da7a1985ee
X-MS-TrafficTypeDiagnostic: PH0PR15MB4400:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EREa3KA3oqFZsqK+EP6Qg6TIltt93Q4QomgQV/3cVdbNXVfJy+dJPJtvmwLC698MdaoKe0LM7mcNIoeXWik/2NTlqOVfGMQh6YycbSw7ePPspY9TEn8Vva5gry/HJertxL1+MRuuDVtXnDEQiVGyJm9jSM4tV4DcVo6XokYBnkSdu5JQnmGzx5u9+YxgxlNgyP8fOlZZNVP1sehXBKhAe5NU9CwiiBE+k8Yxe48u7vZMEvrbFELYjckR1u6v5aycY1gAvebrUtL5i9JZlaWLAgh493AiLISjZkaziqk2UlH1PM5AS3Yblqfy4h9LuvC3/Wp8H2df05Hn53VaRGmX0L1K7rWG6QE59DJrS5UfXn6QyLPs4PjdDqqUEUsnCkqQx5Tt72viEURqyRk9YsgMcKBJBDRZUvv7GnlrJFmpmDXT2gfHoKl2DO7ka5OO0rRm40gmBO4gjek5BMIOo0KPRV2A4AEb9HMyuIYPfPMd4gpGP5l6AjJIVXBgDaDIvWA+nHDFRb+kb6/cHDYiRqYX4QgFh3agK801OXCTeuyDw90/5LjTr8dSF6xxPlo7XFVWbCrMAtTS52GxYDtOOkz8kRe314rovVaymC40AC/Y9vNAP7xDksdxhquPI7Kyqxtj1gUTPDAHDFcIZf0VGRQjLnVuFac5InSSPS3C1MG0IBoVXq84l2oevogKOG8nmrJoz4qY1WApTJvFjjvD27kRkVQnFdoyi4gtDDAHcScYaFt+zCFN5j2u5tmD0xj+lcxTOTmCMG9UwxtSwYUzpAI3qBpV+7oLS5iDMrMMTuZ5FiONUCfMrszs096h592DfvkGG5C6KoyJGX/0T1rtwBWSFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(36756003)(6512007)(186003)(2616005)(4326008)(8676002)(54906003)(66476007)(66556008)(316002)(66946007)(2906002)(8936002)(41300700001)(53546011)(31686004)(5660300002)(478600001)(6486002)(86362001)(31696002)(558084003)(38100700002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0pEb2NOdWFqdTRZUEt3SnVISDNhb2ttUTRneFgxZUJkclJsSlNjMEpnSExz?=
 =?utf-8?B?SVVVR24zRjlOZVRIL3hvS2xFL0wwYnhwYXVaWmh6aDdBV2tXQmhVUmpZZ2sx?=
 =?utf-8?B?M3RsYTZrK2JvV2FkbFFSV3p3aEVPcFQxN1k1OWR3K2pLTXR0bzdid1hraklo?=
 =?utf-8?B?VGNYZzVMdEptaXp5VEU3Tm9CL3RBOXgwYlVITGNkU0VlWm9LbVd5MVJlUjlD?=
 =?utf-8?B?TVBQY1JBa2R1eVZkTTdhdjdJeHJWWGVVeVRkZHBDaStBaDY4YmY0Qzd0WHJo?=
 =?utf-8?B?a04xd0M4bWp2TmlXMGhTN2tTbzlrT2tGd3ArQ0lsMVJTVFQ1RGltOTNZUW5K?=
 =?utf-8?B?ZWpGb2lxV2JvUFhiRzJ3aWlqY0ZRSmh1dUU3Z0ZSRktlTmRKYUtEdWkvdnN6?=
 =?utf-8?B?K1BNTWJRRmpMWXBSZjlCOFFTc01QcW1iNm5EV0g2VFRUaldsZGFqelRsZW9k?=
 =?utf-8?B?NVZnbERQd0JKL21yTWt4ZzhrcFpVbmlIeTJHZktGZVVoaEF5bnlhVTZGV2dk?=
 =?utf-8?B?aTV2US9vT1dBalcvVmF4UFdhNU82dVpTdU1vaFJpekhaQzNHUUx3ZXZUUHdy?=
 =?utf-8?B?clUvWlZPeFRHMUVoY1JiL280eVpVdzVkZ3V6ZGlwNWU5NGY1eUozTnM2T2s1?=
 =?utf-8?B?MTFWczRJakg1ZHFTY1kxVmFwaW1WRjQ4cXIvVjMwb0h3SmxJcWZnci80ZHpz?=
 =?utf-8?B?bWNKb2pUUjVqU0xFRWxaQU9ZNlFWeU1ZQ3J2T21kN2REQTlWWkFvWkRXUkph?=
 =?utf-8?B?OXYwaDlIQ3FReFVTWFhNd1U1a1FXc04vQmNOMTVHNUw1cGJia1ZWN1FHN3ds?=
 =?utf-8?B?YVEyZFc1Y2F3WVZYWEZxajlKbnV3K1EycXhUYXdjak9LS0JEUEFmUWViYmli?=
 =?utf-8?B?ZDM3emQyZ25IcVFROUx4NEtodS9LdGt3WDVhNThWaDRLZjg2dG9Lem1xOE1j?=
 =?utf-8?B?VTJEY2dEK1FQSEVzN3F2SVM2cC8wZGFJNFpSQUxjWjdhWjRpY0hOQUdUWVlK?=
 =?utf-8?B?QlMwRDJIckZreFh1SWZZb0NwK0NFcEZTUFp3WjJ5OERlZm5CREtHMEpEQS9x?=
 =?utf-8?B?dHFHMmV4NHVGbzAyR3ZmbUNFY0RmV1BPYjZhNE01ekI0NmROYXNSMktWZUN2?=
 =?utf-8?B?RnJjTDZPQWswM081dlZlRUN1SXdDc2ZvamZtaGJXNjA5OWExL2lDS2g0RGIy?=
 =?utf-8?B?N0w5MmFPRGVNcHpkWnl5cGdrd3owL1dxUElTc1ZUQTV6U2t1ajFrK1k4U2Fa?=
 =?utf-8?B?ODhHT3J5bG1MemRWR0NvcTUrM0ZCQ3Y4RnlxTjdLZkh2NThzMWpQajZoUkVR?=
 =?utf-8?B?cTlvbUNPMitmcTh2c0tRYmJJSm9qanFJWTlLVDRib0JYS1Z5T2N6V2l3dTBP?=
 =?utf-8?B?eEtGWjlJZGkybkErSDJubjBFTE80Z2JrWFFTdlBtOWZrdkNUb3F4dmFNZXpX?=
 =?utf-8?B?YjJuSnUxdzRlNW9SbDlsSkxKYUk1MUl5SktBc1NwN0hIeXVRUVRQNFRpWnB3?=
 =?utf-8?B?NVFxYVF0NittNmh1UU1wK2VXcVAzK3Jvb1NUTVczeTlVRUYzSEwxUld1MXNN?=
 =?utf-8?B?clN1Zno4Sk1WN0JGNXBsQXhnbFdGSWF2MmJVaDV3emRtOVB0MjBNZ2l4MC84?=
 =?utf-8?B?T3oxTWhJVG9RUWdFZU9CbEVGWjY5TUpFUE41S3VBOHJrdzlzaW12YlJRT2ZY?=
 =?utf-8?B?QUNzWCtpemdlZElITTI4OGlBR2ZLOE1ianNFZGNXd3JpR3lqU2FaRHd5c21l?=
 =?utf-8?B?NUhoQmJ4SjJtN0FNWGZtUVBUUGVCS2g0Mkg5T0hPL3ZyS1RPNGZMeVZTWHZX?=
 =?utf-8?B?eDJNU2lTSHQ2TmN0Z0pTY2sreUUrM1JISjdUbjFwbU11dGUwSHNOVVRQb0NR?=
 =?utf-8?B?VGlUQjVzSkFaZWVidkxFc3FWVzVBclM3MXlmaG52RjQxSGdCMnRaNzFzYXdB?=
 =?utf-8?B?cjVub25aRnFLU0QxVklWbjVHTURiUVAyUVJMakF1aHRKTG9KcHUveUlhc0NM?=
 =?utf-8?B?U2p3ZXl4ZjZ0bEJJVzlUMWZwT1R3Mjh6Z1BtRi96M0RzMXIxZFd3dzRmU24y?=
 =?utf-8?B?WHZITXhtVjVsVFNTSEQwaWh5R1VKWVFOZWM2UEE0a0pybXdHQllzSU15SkhX?=
 =?utf-8?B?ZWUzZ1NxSXNiRFdFL2lKU2FJR2YwQ29CSHNxZ2Z0NDdGMnlGSjZsMlJXQ3ZU?=
 =?utf-8?B?WVE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f92194-87b0-4d55-d9e7-08da7a1985ee
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 15:12:06.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmI3gF3L9VojSGX3raVbFFevqPN4l25h+WXLDg/mQEi/sipZoPGGv3y+hz4zATnS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4400
X-Proofpoint-ORIG-GUID: gNdHPIpks_MWgsQU17tPKBLMYbH8pWqq
X-Proofpoint-GUID: gNdHPIpks_MWgsQU17tPKBLMYbH8pWqq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/9/22 7:06 AM, Kumar Kartikeya Dwivedi wrote:
> In addition to TC hook, enable these in tracing programs so that they
> can be used in selftests.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>
