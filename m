Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88E04B2D69
	for <lists+bpf@lfdr.de>; Fri, 11 Feb 2022 20:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241696AbiBKTOV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Feb 2022 14:14:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243279AbiBKTOU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Feb 2022 14:14:20 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70A438F
        for <bpf@vger.kernel.org>; Fri, 11 Feb 2022 11:14:18 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21BF4ovZ001967;
        Fri, 11 Feb 2022 11:14:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=xGiig/TpN126rDdXP/lJHq20aeUQ4Io49SL9a7tpsjg=;
 b=hVRxPXg4SHrz0Q79Y14NwTVTRE8c72vUWYjt11L76LdU4TDQNuwVpT4Lqzn+oEHC19W5
 OBIBfq3BJODjo+utPkl/FeM08xldtT9VReoFLpM4EyojVzzFN9mz00yx0Sf8ainH0H1u
 spfmKl9jQtAt9IEYaCIxKvGn29H+yB/EDMs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e54v6a0yq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 11 Feb 2022 11:14:02 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 11:14:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aXeKoiQMkpag97NKOwjEyomO33ozT7kE7qlmDTanxZ42/RSLBN3l6e7lJ79Oa1AdxO3ibYD2+aPivIiRZzje6h8sRCDHsBCpUgyX85He3uZ0SdTjhju5O2p45Yee4yadfpmi5GPe4Gj7LkuzuSKionQRB6RVjZkGbqVlA8vG2n6M04v0CvWgeaMkLMeAmaDetmDTCLpXZUO9c3S8tzGhkCurhiaN2b2NbYCZaST8k6VNXsCJ8+fqMJ/SIr1nzI4JoiXzvIcRwzdFJvLwdUx53KOUx3tkk21SWdsBCja8iOqxN9eaX2vPPysDSmotuCDa4CmyIUj7/USNB+RR+hudgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGiig/TpN126rDdXP/lJHq20aeUQ4Io49SL9a7tpsjg=;
 b=dZ7wG1IigDcUrlRJWuiG1o28yDFu0wvI/Dw2RvJ+hcpTkpk1pozJDozjYWmt7L0meWtGFnXtXdSyj6Y9+ve1wRAdoY6zh+kXD40n6zPPUX67As1g/0Tc7pToMqGEqLRhBbVmf4JTBZ7MJG8FlNPPv3iVCB3bP6ZGo/JiaWvz2he5pooz2O7QvJQNVo8x9OY9qGios3O1y7TXhEZeZpTbGaBGnwYNNGXUEa8EtO5PSqxQi0T6Neu0+8eG3MOA+fdX3ascOMgCydU24FqZtoHPROAQmqOPZ1dnmKeX4Q4EFi8rMEP1S6buXmiFXge1TdvBf+EFghcE3BtURGH8A4+r8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by DM5PR1501MB2165.namprd15.prod.outlook.com (2603:10b6:4:aa::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Fri, 11 Feb
 2022 19:13:52 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::94b4:83f4:def4:b294]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::94b4:83f4:def4:b294%3]) with mapi id 15.20.4975.011; Fri, 11 Feb 2022
 19:13:52 +0000
Message-ID: <039a7434-c6f3-10af-d22d-63e532d20abd@fb.com>
Date:   Fri, 11 Feb 2022 11:13:50 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH bpf v3 1/2] bpf: emit bpf_timer in vmlinux BTF
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
References: <20220211175655.2426903-1-yhs@fb.com>
 <20220211175700.2427105-1-yhs@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20220211175700.2427105-1-yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR05CA0086.namprd05.prod.outlook.com
 (2603:10b6:104:1::12) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b781317c-d51e-4a9b-7257-08d9ed92a43d
X-MS-TrafficTypeDiagnostic: DM5PR1501MB2165:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1501MB2165ED86C6FEA29EEF5204CBD7309@DM5PR1501MB2165.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZYDDODOLJYP/RQDXg6VjJJv8f2TI+yh698Pyz65n5RguHnwB7dNuqTVP8RCLx5N8F04fnJuokHVsQ3Ut+nigYqhx9QaUM7ZFJ3R4QkP1Na9wgfmMUiYQc9thsJQGCt0JDLAZ/WzwESd2vRl78u8WLJZn6HnhfPQ2aQa7paTmVwRL1MgJFHW4pV5gO4y9yJXQKEhwqhzs2HjVWI0ZB1XZWkx87bztvTzS69UAIvvhJlX0LmEwYrErdIxWBIC3FBRQwwt+1gB9sGPZ+UMe6ya49CtqX6OIYMaCjF0ieXkIv6WDw6aGoO+sdzDRXaaHEFEFnG9GjLUCREf7efi8qtZIx3mC6yiCZ0klOcftdRnY2UVF4XSMPmz3S9CkLH8LwQrkRb46OCF32T80m4yZ1XxS1jgsBg5vq3PCJFBlNjTcAfrjozMju93Yzf0eYulAiqMNdFyLXKyvlB0/rf7ojShA17iVc6VsmZOqkqmbfUK+pvWwYcQTOzJPXx4/DJ14OUQWZCmVJhJt+9rJK8cYjMAVm//L9gB2jy7NgQtnXnHYdWkKliSUn0qrddDQe8+P45NoGJqL4v+sCP6sRcBtKIwIRE0KDCC9x+rpw1m58as2IdREKZE2pFiUYasUGNQfCPrO/zltyReCYiuFt2w0SRPijKmN1QQchqprZJaB6wb3imL+bzamsa8wUjnxo+28OUaZ24JzfUD4ZoTYjgJ+usvY4tpOhMXUepQMBMgSTCNR3lQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(66946007)(66476007)(4326008)(8936002)(66556008)(8676002)(2906002)(36756003)(186003)(31686004)(38100700002)(83380400001)(86362001)(508600001)(6486002)(2616005)(54906003)(316002)(6512007)(6506007)(52116002)(31696002)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnJKaE93aEJPRUFtOFlwVEZvT1VvNUxKM1luRVhPMGpKU3dOSmc3akxxdjZW?=
 =?utf-8?B?U0ZkMnVZb1JzUXNpaW15WDl0Ykd4YlVCSnlGNTBUTnRXTTlubU9KUUNjbm9w?=
 =?utf-8?B?Q08vYXUvTzFUbWpGYWo1c2NEMXB3elBha3BrUHpyVHZzdUNQOCtLWDgyNmli?=
 =?utf-8?B?SGVta1ZWVWFMcDhnUldtNHNtTUplYmJjVTB0RnpEMFE4aTNzMENJcitsWFdP?=
 =?utf-8?B?c3p4Mis5UGQzYnZYWkx1QlJobjZoZWcvTlk3SlgrQjB6Z3VXMmdrSmJMbVNR?=
 =?utf-8?B?OUp4TEI1QldRc1BMOFI3N1N6NDNDbnFUeVNRSUw3SmZCTjgxUDVHQkF2bHV3?=
 =?utf-8?B?UXRqM0hGazZ6VHhlcGhna2ZzbWNOZzFzSXoyWlpqTS9EbWorNTRxKzluZmph?=
 =?utf-8?B?UDRsd0U3VTY1VHIxc1FtWEh0WFVMUFlVR1k4RGtlQkFndFpmTC9FaU5kQkV1?=
 =?utf-8?B?NCsyLzNaVXdWeElUb0hkTHV3amhScXdxdzIycHJNQVV6Mm1DMWg0aGJ3NzRB?=
 =?utf-8?B?eEpCajR1QURFN09aNHl3VlBUTDNQQjJGMStzSHRqeDBaejk4WjhpM1BNa3Zw?=
 =?utf-8?B?MjR1alFGYUxxazh6WFovckJpaE1PblVpUS81NzRRZllsa0owUEY0VHNIYTd4?=
 =?utf-8?B?ZGNrMGs2RjQxKzRUR0JaeXBoaXl1QmtBeW51MjgvNFIzWWhFUmlUT282ajVs?=
 =?utf-8?B?T2xIVEliUTljdG1QRmhIOXkxV2MvejRyaVpjMkxyT3BlS1IyNW9JQTRGcFht?=
 =?utf-8?B?L25DdEJQRnllNTJrZW9kR2w3ZTczRzA2ZVVCTUZoNEppWUhqcS93LzlWdE1h?=
 =?utf-8?B?bmdzODhpakpPVU5iWUFGRHZHN3RKYndreldCaXN2KzhtNEQ3cGxKa1Ewc1U3?=
 =?utf-8?B?RjJweGUzaExwdUNhY21INjJ4T3FkOWRwQllYUFJlVmdVUENIUWgvc2pmYXFZ?=
 =?utf-8?B?LzR6bHZSdi9CWHphZDIyaFVxcXJjSEEwYzkyZHVjMEtXUVZXeWhxWlo5aFBl?=
 =?utf-8?B?THh1ZDYxQ1hSYmwvWEIyMkliV3ljOWtJTlg1ZDdMdVpzcGQvVDhPZnBDNU5w?=
 =?utf-8?B?YzREeFZzRW1wbTdrK3VzdnpHT2ZNQi8ydFNwaHo2VmJZZTZqMkYrQUgzV01U?=
 =?utf-8?B?K1dJKzZSd0dlNmhSbkxmRzRraUozRjZ4eldkbGcrdTZIME51dHd1VGptcDBk?=
 =?utf-8?B?aWpNKzBRRi95MllzdEN4c1V1dFRGYS85Z2pZb2xzMHJhN1pYenc0SUZrem5y?=
 =?utf-8?B?eHpRcHp5b3orT2liUmN6QlVtWDFXL1dLTTk5Mk05WVlTT0laeWF0OWFJczdC?=
 =?utf-8?B?bXpKMU5Dak9KQ3hGK29BRm1KQVdKMlpnN3JBQ3AxNC9aUFFyMXBHcllzNkxO?=
 =?utf-8?B?NE5rc3YyUkFTL21NSDlRWXpDckhIK1VlTXBlRVJGNnBiVWlnbG1pay9KUHN4?=
 =?utf-8?B?L2JKV1RZWkhGcVlLN1NYYWZVbWtpZlhrOHRndExHcTVZVVVYblJuQ3lhK2Fk?=
 =?utf-8?B?QVRHR3ltZksrOHhHWVhEMzVVVktveFB2aFcySXBRYUhKZ2VNdVg3ZDIwS2xB?=
 =?utf-8?B?N3FrTGhHejNXdkN0TURFWFVaR0MzK1JWY0drM2pxVUp3WU56aGhDbmI1WlBM?=
 =?utf-8?B?ZzBJOWw0ZitsYitjU014UnR0TnhweTB3MlNWSUd3LzI1cDZOYWpOemJ1ZVJE?=
 =?utf-8?B?Vzl2L0l0a0lSKzdlRFFWRDJFSy9obElaV3kyaDdYVVFSUUcva3F2K0ZXOVJ0?=
 =?utf-8?B?QlhCbEdtOUgzRlQxem9OZS95VE1weUsrVVRYS3M4b3B5UkhhbmJvNVM3aWpn?=
 =?utf-8?B?NGM2cWtYNEZ1MzdZSmNpcXNPS1NOQjlTQTlOTEVrRERsMld5ME8rcDVKWm5U?=
 =?utf-8?B?cllOS2ZvSEM2UHJNVnUwdWNnenNxRTFVS3JxaUFsZDZMaWZSckpSclErRGRW?=
 =?utf-8?B?cW9hTml0clVZRGgrQnNMeFZTNXY1UmhZY3lCUUtjNWxMTDJRMUJYZG1SU2Fy?=
 =?utf-8?B?T1ptWCs5L0M2T251ZkpzUkZjSXdXR3NDRFA2L3UyeXJhZW13M1V3NDV4WEhs?=
 =?utf-8?B?ZUh4U1RLN0IybWRkN2hiakkxZ3daRGVhdHZqTXdKTnNIVm4zRlpJSVVSWjBH?=
 =?utf-8?Q?l9JQ/c2QsvbHceW/FpvZat7tk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b781317c-d51e-4a9b-7257-08d9ed92a43d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 19:13:52.8165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EYCVyr7z5LMUDD9Pf0TaBB8lp7zaDKiYtWBppLxL9KetRJxT1uYg3DM+cx05GQi6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2165
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ZARtoWZW2qBVIWh14EFAo6WyHni-MKOT
X-Proofpoint-GUID: ZARtoWZW2qBVIWh14EFAo6WyHni-MKOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-11_05,2022-02-11_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=987
 mlxscore=0 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202110103
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/11/22 9:57 AM, Yonghong Song wrote:
> Currently the following code in check_and_init_map_value()
>    *(struct bpf_timer *)(dst + map->timer_off) =
>        (struct bpf_timer){};
> can help generate bpf_timer definition in vmlinuxBTF.
> But the code above may not zero the whole structure
> due to anonymour members and that code will be replaced
> by memset in the subsequent patch and
> bpf_timer definition will disappear from vmlinuxBTF.
> Let us emit the type explicitly so bpf program can continue
> to use it from vmlinux.h.
> 
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>   kernel/bpf/helpers.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 01cfdf40c838..66f9ed5093b2 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -16,6 +16,7 @@
>   #include <linux/pid_namespace.h>
>   #include <linux/proc_ns.h>
>   #include <linux/security.h>
> +#include <linux/btf.h>

To avoid conflict with bpf-next can you move this #include a bit up?
I suspect having it right after linux/bpf.h will make this patch
applicable to both bpf and bpf-next. Which means there will be
no conflicts when bpf merges with bpf-next.
