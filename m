Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545824B7F7F
	for <lists+bpf@lfdr.de>; Wed, 16 Feb 2022 05:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343690AbiBPEcg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Feb 2022 23:32:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbiBPEce (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Feb 2022 23:32:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B03848A303
        for <bpf@vger.kernel.org>; Tue, 15 Feb 2022 20:32:23 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21G0rP0b019261;
        Tue, 15 Feb 2022 20:32:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=H3lhFPpd5z4rHrlEmLVTPFOoev4DAgg8+cVI/Gy1K+w=;
 b=aspEq8gULB25uKzAfK98F2yLtegMeUydUsjeHh5OC/D7u125S5PjrGXZI0yMBr/5fXrk
 TWHU/5kpT92f9A0xxcSVR6EpHoL8NO/G/nr8/idepS39C8Fg32X49UJEfnRomclMUHnT
 EfAwTATc6rCPgHUVi1rRqtkNm/0+AuTEcuc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e8n4b9r1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 15 Feb 2022 20:32:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 15 Feb 2022 20:32:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbJ1rf6gbZSCfZxwaow5X2nIN6yQvgqr0q35dcRAME8GpzB1KnxKl4R+xUCuWgDp2D+G8nba1Q8jRrWnNb91ZGEan/TGpgJrJhb860ep3sU9FxgUGSLe9H6VgwUaJgxRYOu4cbqovPJSl7agzplYUR7MJh+w1XQJzei/858xFzZi9aqByrMqSlMXnWXOcRf3Xz8zD9aFc4imTnZs3dE1GRV65LYKHp95x0Iu0Opm5TB6sAiH06KAbii0ShUbczofHC+Yc8pBk+wDORH0LlQE3AUR4ZIPiNJ4WguYr/GnZfME10AYnqhcReQJMXjjqhgwvcWifC32f+K7fxQDBZc/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3lhFPpd5z4rHrlEmLVTPFOoev4DAgg8+cVI/Gy1K+w=;
 b=Bz/EyKkVRigCh+gIMFs2x+I6yZXsqcWfPzS8m30XnKuI0Fmhh1cLK7cghHLg+GeekZuTYwbFhbgMNTElJeR0g7Op5DGcmbh4sBq6BL9nxzKmzNL20OgsdWZ33GyU3P+8onrq11OEt7cKjfgQLapxW6B2pcQrq5S7uPFOI4i6+fiv4/oTkTwkUMisNfHXo1Dw0QCZYo+JT8g0X5LAIhbjW9/s8vdgy+wxq1WCGDIRL7A34RmYgFarCaZ4/Nr8oR8zJ+rkycvxERCd8VS4Rp4UZXU1YnJcF75QQ7JNhlYn6VUdJ8eUIA8lafwzfFJyyiIKAGgO9C2ZzK/tvgod9gNo1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB2955.namprd15.prod.outlook.com (2603:10b6:5:142::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Wed, 16 Feb
 2022 04:32:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::91dd:facd:e7a5:a8d1%3]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 04:32:03 +0000
Message-ID: <c861356d-5187-4995-4049-10ac1ee0babb@fb.com>
Date:   Tue, 15 Feb 2022 20:32:00 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH bpf-next] scripts/pahole-flags.sh: Enable parallelization
 of pahole.
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>, <bpf@vger.kernel.org>,
        <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>
CC:     <kernel-team@fb.com>
References: <20220216004616.2079689-1-kuifeng@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220216004616.2079689-1-kuifeng@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0271.namprd04.prod.outlook.com
 (2603:10b6:303:89::6) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49b639cc-3f7f-463c-ae64-08d9f1054824
X-MS-TrafficTypeDiagnostic: DM6PR15MB2955:EE_
X-Microsoft-Antispam-PRVS: <DM6PR15MB295514565B5B66BFA7485828D3359@DM6PR15MB2955.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o1ERVHjSwjUVG6UZA2/OJmq1ORz+gGX8CUzHnG49qkZP5eHKlu/yxRx7GwK4+55CNDOTJ3RQywDqdciPCOdBRgK+Dk3aUgjjCtWgXbVsdn3G7hSjqr278WuANz6gL7yUmDJaNbsuf42m231QQcAv+Cz4xt/1DAPEdQg1wn0az/7FdxEgjCnr1Hi0xHbnZERm34dyzvDwL5BQL7+md5t7anMxz6jZwe2z7ejG73qgJPLyEOKpfPKP/MQPsAtSgmwTw/s8I5HMl9A+CAVaR00PEE1/mILnuetzX5jpcrRcSZ1FyNMWFXIfKJ0DQtNMOedIL2CQRuQcYfz+X57NvUjm2faCOwnBe7WVoUm2HdxoOnLEDTFTNuqveUV7eATwpd19PXwqeAb09SRfrYzX3hRTfEbo7L0Dum5wE4pqypcq5Zu6frhz6HL5iHlRgme2Di0CYS/2Iq9m1PQbf16J9nUDG5zsmBUYJPaX5PdRedANxx5mWxk5dkVEmjwRMqKXxf3Bel776yJm+2sogjRFJXTBXyfyiE2CyXP78Z5ETRZQXYqWmc7HOeHlvK6Z2H30bapitsoRmVfSJtMw4oNvM4y1fO1VeanxwVeH8qiKHyxiOov77yZ5dolgoSdZAzgOn/xGMkftMxD5zejUllRtz2WQSpGEK6D5YtTy1HGexQzsuDfKaErU7lK7Yvsnalwh3boMPK+C5ueS3Ppq9MqbWvTppeswTJrsx4UdJCFxb6DLAOk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(186003)(8936002)(508600001)(6486002)(5660300002)(31686004)(4744005)(83380400001)(2906002)(66476007)(316002)(4326008)(66556008)(66946007)(8676002)(6506007)(6512007)(86362001)(52116002)(2616005)(53546011)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHh5dFd1b0IzVE5jSTBDcEViQUpSNDU3cGIxQk5SR2N2MTB6OEpEYm10dVJN?=
 =?utf-8?B?U3A4ZXF4SFFEeEovRHFGZlJwcnE5a1l3Q0pvbDJ0MUs5ZHlPT1BuSEVRVytG?=
 =?utf-8?B?S09IOVo4VjQwV3BpbTlRR2dYeHgxTHVuWmxOWWh1YWJyM0RueGFXd3I2bkhJ?=
 =?utf-8?B?N1hLdDRSVnUvMEg4bXVDbitPbjhwMVQ0T2diSUcraExncmNkRUM4SEZCZ1BW?=
 =?utf-8?B?Vk1ZaEM5bUxXNEdpSkpoc0IwaTFwVHlRSG9GS2lrTzI1bTg1RDM2Zm9DWEFx?=
 =?utf-8?B?Y0xtd05rYk5oQlVWSDZZWnhmajdmQUJRZUlQV1dSVzlsMExySWdidjdTbXRZ?=
 =?utf-8?B?UU8xaDk2bnBqcUhVRlZheEhBYzg4ODhoTXRYay85eWs2WWljakw1NURKa0Y4?=
 =?utf-8?B?NVh5UnMrRUpiaDZXaHpEemZRZU1BWE8ybllNNlhPV0pSdm0xNHlUakNBdWtN?=
 =?utf-8?B?ZjZKc1FxRGVOMXdzSzFNVFlXTGZhYTFzNUEwcDFGL1RUa0V6eTRwR1pPT3Nk?=
 =?utf-8?B?Yk5EVHpqMVU1R3NtUWd3Nnpha2ptZEQ1ZHNEYmJnTHA4eE92aTI5eUpnR1M2?=
 =?utf-8?B?SUxQR3M3Uzg2S2hlaG8xaDZuZnhTTE45TC91QVc3d1pXOXdJS0RDSEdpbVdC?=
 =?utf-8?B?MDlLZ0MySEF3a2Mrc2kyeG50b0ZHeVEvbTFmeXR2UXZadU1XWmt5QURoYTNv?=
 =?utf-8?B?U0Vza2RYakNUNXdZZWs5Z3ZCbEpqb1F2ajlXRkJ5YVgvTm9RVmRIL0NKVkpp?=
 =?utf-8?B?V2IvTjY3SEV3ajQ0WlhuMmZpZ2dXQWxkZnluNXhaRkhVQ29RSHdjcWxydXY0?=
 =?utf-8?B?aHIxU25oYmc3bnprb0k0Z3NmS05Ia0ZubTA5Q3NNbVV6MXBtMG5MRDFWZk1T?=
 =?utf-8?B?eE8ySGptV0hyNlZGeUdGNVJCOGFDQVpmdzR1MExjQ3lBZlQzME1JcW94SDZF?=
 =?utf-8?B?V1JmdHhWYzh5Nk5jSWlrK1c5bzhEZFpvNHd3aWhCUDdkb3pTVVlrOTVyWTk4?=
 =?utf-8?B?WUJZSmtnYS9ZZEIzMkVSSGgvQ05Gc0xzWUMvK2k5ckRGR0VFUGg2TGdBS1VZ?=
 =?utf-8?B?ZzBPTDhlRHlGK0lNZm5UdjlTUmN1UVphQ21KNTdwVS8zWTBYZ3hjT0Mydkxo?=
 =?utf-8?B?SytRYlRNTHBaeHNNWDgwTEoycUE0ZjZpZ21nNUJSdC83NDhmT1c4V3BaSnlN?=
 =?utf-8?B?ZEVuVzN5SjZmck5mV1o1ZnlYeEI0MGYyRVVhdGwyMHRIZThvTldHRkpFV2M4?=
 =?utf-8?B?Yit3eGU2YmlreHBmVFZkSmVETWJ5aW5XV3ExNStmY1RqQXY0RUxLT2hiT2Vh?=
 =?utf-8?B?aExEcEpYQkV6OTVjR0dobUhTRXF5Vk14c21TZE5vcG8yc204b0Y1dXIxWUFR?=
 =?utf-8?B?TEFQdk0yQnd6T0pSYVJQa0Vvd3dSejZOWTR0QVZzVmkybTNLTjhhYWdVSXVk?=
 =?utf-8?B?ai9UdloxZTZCSWJJQjFXSC9DWWZMbit6WEZKVHVEblFJQzUxN2x4SkllQkg0?=
 =?utf-8?B?c3BUY0dZakt2VlhMcEticGcyN0pmOUhiUERVTG43RE9OeVZQNmRmK3h5bmRZ?=
 =?utf-8?B?WjBVYWVnbzNERFdKUWovUjNRQXBYZVEycVBaZWRXS1NCT0l3TVFhM3l2QUJ5?=
 =?utf-8?B?UlZvWnpMdW5XMFV6dkt3dm9lNXJOVy9weDBDTE8wS2F1SEhEcHV1U1Y2dVNr?=
 =?utf-8?B?bUd4V1c3cllldHJNYzU5Z2RrUXNGa0V1ZlIrWjRxMXNlNnBqQXlRbms0ZzFz?=
 =?utf-8?B?LzVDQVRib1R0SkNTYWR3NEVKS21OZ3NjUVRMRFBzWXh2UTB6RkdIUHNUMUVC?=
 =?utf-8?B?ZVdkOWo1aS93M1B0Y0tiU2l1R3NKQi8zWXBqZ0VSaFBIQkhSNDZUMGpHem1x?=
 =?utf-8?B?RmR3VHZVdlMvTlhRdVpDVUVvWTIxNFZER1FJZ2RteTRGdWNDazV5c2lWd3Nn?=
 =?utf-8?B?UHZRdjlJVXlpaGpLeTBDVFhaaWNjYWowbnc3eEVaZWw2bWlsZ2g5Vi9ZZXQ5?=
 =?utf-8?B?aWMxdHdQcWNQVmNZUEhKbEg4RGZKY0thcDh2UCtGZmRXMWE5eGV1VWQwVEVn?=
 =?utf-8?B?OTFXSzBtcHozMW4vTHFsZzlhNjNWMDFsMGN4SVJSRC9xZmZIZXdLQm9mQUNG?=
 =?utf-8?Q?afYsIzTonozFM3TbHeNfR8d/j?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b639cc-3f7f-463c-ae64-08d9f1054824
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2022 04:32:03.9004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1gVTrYdq/iw4YiuAKzNWZGMKRXpJhzeAx6jA1TbRqAGWULzH4YPzow9yUSQheXW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2955
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: dBx-lJLJvox6bbfaAmPx8tf5r9qZWWQH
X-Proofpoint-ORIG-GUID: dBx-lJLJvox6bbfaAmPx8tf5r9qZWWQH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-16_01,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 impostorscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202160021
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/15/22 4:46 PM, Kui-Feng Lee wrote:
> Pass a -j argument to pahole to parse DWARF and generate BTF with
> multithreading.
> 
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---
>   scripts/pahole-flags.sh | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/pahole-flags.sh b/scripts/pahole-flags.sh
> index c293941612e7..73f237ce44e8 100755
> --- a/scripts/pahole-flags.sh
> +++ b/scripts/pahole-flags.sh
> @@ -1,7 +1,7 @@
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0
>   
> -extra_paholeopt=
> +extra_paholeopt=-j

-j option seems only available for version >= 1.22
(please double check).
The script scripts/pahole-version.sh can be used to
determine the pahole version.

>   
>   if ! [ -x "$(command -v ${PAHOLE})" ]; then
>   	exit 0
