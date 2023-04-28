Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A6B6F1A77
	for <lists+bpf@lfdr.de>; Fri, 28 Apr 2023 16:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjD1O2h (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Apr 2023 10:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjD1O2g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Apr 2023 10:28:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3453C20
        for <bpf@vger.kernel.org>; Fri, 28 Apr 2023 07:28:35 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 33SA9HIH025036;
        Fri, 28 Apr 2023 07:28:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=j9zRoWZaQ2xKRhaBNW8NyCf/soJnERbQHNTAXRhd49U=;
 b=aWTTKictPpUaXqW0TJlgB7J5G+aTRRnkryK/RYm3tra6ZWRlYoq4+BOTvIPMrpEtoKQL
 GeBWQq+LrRYn84/HJBqtR5NOKVw5rBfF5ml9z2J8r3m04Kkmz4xm2gMfKVx5+3uuWDoD
 orW7CdV7gL6ALUkuJwClc5+LENyA9wAkGan1o+scyPw38Gu3KkLv70J2e7tBwkfrgwIH
 RfnXOIRUhciqIjKQg+fJT6NC0fhcgnntzZgfxnqHG7fXwI5rS/7PcnMDFu0QXJEegxtJ
 bDC5wZpRP0u6GzoamuF8MDqbZwS/hjsa9smirlHA1sujf5KGzHj+LKPIR3Xq39p7Kl+q OA== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
        by m0001303.ppops.net (PPS) with ESMTPS id 3q7raea53u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Apr 2023 07:28:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SxU59A85CoRH7gNJsvsnhJ/rGSvIkHBEyxaVYSb4BBszgck/jE1usFUTXpYt3wgqL0pBWmXk7sxXwY2u1JDN76pQZnfAcmWtNhAMxOaRGkogFLnYvey7CSmKOmRdqE499/xyAU/oC7dnytenT1OcW/F6euGZAdqoLTtIvz77UTfS5pR65j+gMN1gAxVF7J4ofyTr/uipxhthZvBV8JVEt/JluCwa11v2dbVXtpzjH6S55rwbNb3EfV+oVEcbwTLdNHi6arG8hgh9qH7iPallbdpK/JESJY/7LKGG4QHbzTdqSuEWjYpgU1NHZb8Ych4muUfA+l8P2i9lBFG01Q1olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9zRoWZaQ2xKRhaBNW8NyCf/soJnERbQHNTAXRhd49U=;
 b=e4rmMbCTWIGr3hkd/Rl5bRdSCokYOSEjloyz/aWsIWInMIeN7l0LlsNvZ674yl9+iMVHr7fSuFkDO14LlSw2p7SDv/4a/szSzlIJEc3FRhm0b/fxcdXo+UPuepEg91TM4OkM0tMDRy5Iorc9pGPFi6N6RX3vBiXjuc68oFPeiQkHSoqP4cgSXsEO3Ql0SzxWVl/oA9lR/IPsA5XLF6wAkUA0JqodzPdpIukhHaT7/YulNDrOrO3QVq90ZFYbpvXkJMUhCzY5u8x+fS0EAnR5T4GqoEERWIUHbc7Up9cS9gwbvntnkX+xJ7oZJ/Cs6uIAp8AvyZuYu24ea+MtMJWLLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4838.namprd15.prod.outlook.com (2603:10b6:806:1e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.23; Fri, 28 Apr
 2023 14:28:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6340.022; Fri, 28 Apr 2023
 14:28:18 +0000
Message-ID: <95da955e-46ac-4f28-d1ce-841db371dde8@meta.com>
Date:   Fri, 28 Apr 2023 07:28:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] bpf, docs: Update llvm_relocs.rst with typo fixes
Content-Language: en-US
To:     Will Hawkins <hawkinsw@obs.cr>, bpf@vger.kernel.org
Cc:     Will Hawkins <whh8b@obs.cr>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
References: <20230428023015.1698072-1-hawkinsw@obs.cr>
 <20230428023015.1698072-2-hawkinsw@obs.cr>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20230428023015.1698072-2-hawkinsw@obs.cr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::18) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed5a2c4-84f7-4141-b110-08db47f4cf59
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aYszFyoS/dA66kqbNw4aoGCmV4dAgmri3/8NjvEaJqOe+z/MIHAj8A1Mm++jHccAq+8pEJSNxZLzbVR9h3eGdna7PAnXGTLN1X4IITYI+crIdU4lbn3dO35SyWa89NcXvpm73EZWyJLWs8DMyQ53HnJozVn/u7DSnx2Snh9f3V1IFRO4ikqwRWw1hT+l+uGFwv7menF5q1QN5VTgPE1NyQ21JisxymPrkxcAa9ifts3tPHSr7OmaNQ9vAOm7unaCzZ3koQ+mBrHFttoboONJK+/VHBvNhn2hyxhHtWQ3nfoAYKUkxQnRVuduGRGzy2RbICYiBgS3Us5FP/i0FWSbYcsnw3YfzzIcNs7TRNRQOsQq0EdxmCYW/dITae+ZKZsSlz3cFaPf1+Pd9QH3SLf+7yojixkZPYd+JLWpYX1pMMycMfmhyS3KOs+y8KgWPcX6PjJBQbL/ljdfu/K9lfU0pxA15Ej9JR8ZcbM3yK/gM3DLL2NgOyNi/gr0Ig509Gdbzs2cuBnyVbuOvWfav6bZAdMcY0Ea3nJRMSUfBwwRH5L7XtwHQTs/FMdOZRXH2HxU67Myh1RN+yjiMtHok211Mtw9lRNNZkm7OBUcTw8qdsWew4wfeVXjGrd0jseUtL/Bng9u0B3iBGuCS0BmHn0ccw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199021)(54906003)(478600001)(5660300002)(8676002)(8936002)(36756003)(2906002)(558084003)(31696002)(86362001)(38100700002)(66556008)(66946007)(66476007)(4326008)(316002)(41300700001)(186003)(53546011)(6506007)(6512007)(31686004)(2616005)(6486002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VWwwYk0wMWVsSUp3aGNqNUZOdjJHQ25UTlQ0R2c3MFF2L2VpRE9neUJWNFQw?=
 =?utf-8?B?Z2JMaUVTNGRlUElCR1ovYk5yNzh3bmtlRERNM01tSHIyUnlVRDR4MTJCSUhv?=
 =?utf-8?B?TlBHS3JXUm1LMkhSQ0pXamplbzM4bFBsbEo3YTAvT29WWlN6a1Q0WHAxSXYv?=
 =?utf-8?B?c3Z4Tm9veDRZVGFHSHlrUmpzRkhIVm04Ty9zRThtMVhiVFgwQUFyblpkWXZr?=
 =?utf-8?B?dGdaS2NrNlFYaWQ1Vk0rQzFFSkxNTEozaUduRWs4Tm4zSk1aUzB0WmhVT1Zr?=
 =?utf-8?B?dGJzY1J4dXA0Rkc3blFlcWhtbjlkcitaMEozc05BbWI0WGNCVWxWVHBaNXMy?=
 =?utf-8?B?SmdEL2dxdzJCZVFQV3lHd2dHMXJyZEJHUFZKRlE3T3hwWHAxN2wybTcvczlh?=
 =?utf-8?B?RnBIUzF2QnZLWVFCdkZOcEFLRmxQTDJMd1VtQ1Y5bHowZnFISldDbGM2clpC?=
 =?utf-8?B?aTBmSUltdVBqVmpaSlQ0eStwM0ZRV2ZMeWFXZEpQd09TWE4yMEh0d0hmVCsz?=
 =?utf-8?B?cXo2aUpMSXpHcHpoeFM5VnZiV1pSK0FsRXlzTXZxT1U0WjJNRFN3ZVB0VGFT?=
 =?utf-8?B?SzdJZGhCMm9RTmhNRnR4OEZPR2MvR1VHd1o4dTRNS3hUZ2VVZkZUc3J1UTJ0?=
 =?utf-8?B?NzhFMy9nelB4V25rTVpDSWZwbCtMNE5LYkpUNDBGdi91dmxrdnFqTmIrNmZM?=
 =?utf-8?B?ZGszNTkxYmdQb0Jab0wwcVpJeGp5cUNrSEpRZnBkZXZEaXA3d0dteTFpa0VL?=
 =?utf-8?B?MTFhb0FnWDBUbDVES21iaGVpT1NuaWtGLzVDNG1wbnNRb0VabTI3aVhsMWJD?=
 =?utf-8?B?QzlucnhzUi9xUUp5bFQwd2lJOE1YRlJqUnEzdWtHeVpsRTgzajZyR2xIOTFO?=
 =?utf-8?B?dDhUMDJsNE1adjdrK0ZVa2dDSnpBRy9ucmdxaXptRUFHMTRvcE1HVkFENy9L?=
 =?utf-8?B?eVpNTElvell6cTlGWS9Tc0hwTUQ0a1NYeFg3R1Zuc0dRZGZuZ0QzNFJNMnR2?=
 =?utf-8?B?U04raVVLWjhsakFiTjBKVmhjdFVLbGJoaFhUK0tGRWJVMEk5Q2VKMHpaVUkr?=
 =?utf-8?B?VXN4WlpyTkhSTEVRQWNMSC9JdnNZcXlPQkQ4Q3dRU0x4b3UvZVl1WklyV0hp?=
 =?utf-8?B?cDFEZTBlZjBEMVEwQ1FUa25PaGJIKzYvSElBUDNhTkgzaGFQeGoyNTlRMjFp?=
 =?utf-8?B?dFNlNk9YMFJOWUdHS2pUNURKc3ZUYnlCZ1FlaWI3dU1Bd0tvYnRUNjVtVGto?=
 =?utf-8?B?RVFGL0dzZkdvQkZ5Qlpoa2hZcVV0Mno0VnY1ajFSdFQwV3BoK25QWWFSM2JG?=
 =?utf-8?B?TUE0c0VzMGd2cEN4Vll5MnE2MG5mQTZ3NmpoZ0lKY0M3NUlFUHVjaUFyeXd4?=
 =?utf-8?B?OU11eXhodEtac0hWUkFZRWxNVkRxN1BMOGVVN0tWaEJpZDZGTUZybnNCeGoz?=
 =?utf-8?B?eXVRdmtxcHJUWWhqK2xiNjJHRGw2clRYeXlBeHFSajMwbXVmSm1jZmpmQVFp?=
 =?utf-8?B?L0gzTUhvbDJvY2dKMENULzB6QjRBVjhNVzRKTktpSG9ZWTFPbEZEbzJTYlZK?=
 =?utf-8?B?NlV1UEtPSG00elgzUE5xZkVoWUp4dFB4dXl5QzdqMDlDRnc4S1FRS2hHSFg1?=
 =?utf-8?B?MXN0Y3Z1RUdieGp0WWYrQWxaTW9qQUE0RVRnR2M1VkY0TDdNV0V2QmxvZ3Yr?=
 =?utf-8?B?djhNNnF2VTI4THluNlN1TndXcWZ0VWRGZUE5Tlg5eTgxeHExV3F0WnVxdUh6?=
 =?utf-8?B?SU9hRCt6dnlJUDNYSE5WMkZqQmZPaklWODYrYkJkLzRNU1RqaVBka1lhUUtY?=
 =?utf-8?B?Y3djaTNmVk1wZWdwUzhmMm5xUjZKc1YvWGRLNHFiREVIdlJYbEpBMkl3STA1?=
 =?utf-8?B?M2tMSXJ2NFJhbjcyanlhR0VEZ3dTNEk4RlNvd0xHNmhRRTY4WDBvZTdzNTVD?=
 =?utf-8?B?dnRSd3JvUjNQTjZNWUF1RWxGVVVvRWlHYXVJc3JCcmphZC9WeTN5WWpYb1FW?=
 =?utf-8?B?YXJJUmpUVC8wREtyWWErbjRmTFVyR3lCdjQ5eWRGcktLL3B1SEMzSkV2QVJj?=
 =?utf-8?B?U0UrWElPT2RXZ0VoT3JNVlVyZit5S2MzODdnNXRYbkIzR0hVTmRXOHRaOTRF?=
 =?utf-8?B?dC9wOVMvL1doekRNR0JvcVhwVTVKbC9QRm01akpKak1ZamVpWFFzN0RTWGhR?=
 =?utf-8?B?eWc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed5a2c4-84f7-4141-b110-08db47f4cf59
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 14:28:18.1572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hViqk22pTuBb2rZYZ+nC5VqHuABse1rXFG9RqcNJD4py+QcujnKAC55zknYO5e6t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4838
X-Proofpoint-ORIG-GUID: Hx8XKX3MN2Ii6DC6NHI3zQ-Amyv9qPoS
X-Proofpoint-GUID: Hx8XKX3MN2Ii6DC6NHI3zQ-Amyv9qPoS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-28_04,2023-04-27_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/27/23 7:30 PM, Will Hawkins wrote:
> From: Will Hawkins <whh8b@obs.cr>
> 
> Correct a few typographical errors and fix some mistakes in examples.
> 
> Signed-off-by: Will Hawkins <hawkinsw@obs.cr>

Acked-by: Yonghong Song <yhs@fb.com>
