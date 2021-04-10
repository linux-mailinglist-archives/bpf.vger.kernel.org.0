Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293CB35AF58
	for <lists+bpf@lfdr.de>; Sat, 10 Apr 2021 19:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhDJRik (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Apr 2021 13:38:40 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:56946 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234392AbhDJRij (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 10 Apr 2021 13:38:39 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13AHUKfZ019932;
        Sat, 10 Apr 2021 10:38:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=wNMuaQMczGxVNazQls5DsW1PMKWNBBvc5cX6cSygTjg=;
 b=LXj+9ZNQuH9qrRXq2sqXhrBxoFS6p0gVTZZOEKLg/t6k55RkcITB8Ej76BRq7lw+ZTJX
 nPzMfkJbgHvAHNYuqFYDzemjgKUL1GAyZuj3bTN86X9yeyH6jmpn1ZY944SiInsne2iM
 UTaei2JNA5Mmh8dsQlDpAyFwjdo4PQFBALM= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 37u7h3htf5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 10 Apr 2021 10:38:21 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 10 Apr 2021 10:38:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoJEbz0HxxnIdJx3LLd5Xlwir28klIbVzc6BYs2wyygb2MC1P/qvjVu9LZ2huAeIkQD/PomdqkBVBSbGEtSUF28KUOUVERgcUbLVN1OO+8QeHuQf3tXC4ivoWPo13P02iGg6THeq0kkPUopof23Eqc1FJuki0uuSXRG/BWleMoYbET72tZ1oaSph7ah6oZIqx2MpkA9mFWTritqDAxy/aJET6aE+OW3qUeKe9XWLOqxPoTba4oOcf7FeHK4CWpw1S1LoMpxJQ5IRo/wQwz/9+hG6vCIZEzykqBTDJqjQWkYS0KdbOYxTGxY8Dey9le/LrS/I495JN60xxv4uX+m+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNMuaQMczGxVNazQls5DsW1PMKWNBBvc5cX6cSygTjg=;
 b=K7uQtckQNurOJ89w1pNJIKA6M+x01k3+bDJXlstsVSWIRsyECBPbkq8ENQetnTnouglLHfmHCq99McI39g+PtTELG7uYC92gak+D6Hif6eR4JVs7P5XSTwz2jahymAE9pa3Zl5/3gHC78m3oNuPElNvEzU3YM54k9p0gzUIBWf6dU7o7mvA0npsO1oWY1m4Q4vdTHszMg4qVfwSnEIYO/qS5NSyJVhsbzqcWAhNg4Nrp4GJndBuTmfRX1/p5Xi1xBQKYepmuEplZWs6hA9dkI1JqIFydhel2BDPTlgyPXxZcgQhBNV7t04DsK/s3ty6OpazKQM1B7MnNB3zyxAB0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Sat, 10 Apr
 2021 17:38:17 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Sat, 10 Apr 2021
 17:38:17 +0000
Subject: Re: [PATCH bpf-next 0/5] support build selftests/bpf with clang
To:     Alexei Starovoitov <ast@fb.com>, <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210410164925.768741-1-yhs@fb.com>
 <1ec2643d-0ac9-1dcd-8bbd-12cbc5884e7f@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ee2c2bc8-6b6e-bfad-4570-21cea732e470@fb.com>
Date:   Sat, 10 Apr 2021 10:38:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <1ec2643d-0ac9-1dcd-8bbd-12cbc5884e7f@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:fc9e]
X-ClientProxiedBy: CO2PR18CA0052.namprd18.prod.outlook.com
 (2603:10b6:104:2::20) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e8::19f8] (2620:10d:c090:400::5:fc9e) by CO2PR18CA0052.namprd18.prod.outlook.com (2603:10b6:104:2::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21 via Frontend Transport; Sat, 10 Apr 2021 17:38:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 26df8000-dbc4-486a-69b0-08d8fc476d1d
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB206483EFF6457C837F0AD307D3729@SN6PR1501MB2064.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b7COUJaN4KaRizIjFS3DOqaqmBAY4WC9xRtf3JEnyx2Bvu2tuzq3r1kg+3neThKUF+JTkM3gnvC9UaZt/xYJ59fz7zYGQSL5n+wRTlE4LxfqMwTr8VSUVFWbQhssJtC8QbVwLtn7vd6nUk2JUPOQu23YIL9XSzuuXv8s1skPEW1xpN66a4cSE4ACXMLQL8t5TgchdTdfwmRq1ttHBrqL0tsZ5ZlIG49SA9PplyWPGBNJ9TZeP14sXhJAGkVc+9s81q/FEgfp/h6NMzOGLGXnqOyX5wIZ62M2px0zqaHoUhrAqCtFYCZK4AfrsmnJHoMi27JiWBi4qzjyJJeNVf4OfmA8BOEmQCEp46P4wPA/2v8DLSb9vP53EowfkMBRsAv6fXUF4Cyd2+DbX5TMNLIEpye1vn+v7fIPnR4k4b9ylskaOxXa6X0HFIfNrtDGJIrKmRaZsIdk11Ph8h+0ZB0F0AKCOje2wvuwLw9+PuJUVQW6DoM6Gocn6hD1IJ+To+Ryl/6wg1CzEpZwPLkMuTqd46s/9dr87QLITfBXiljVL4vO2/UdFN79JAIpuiZGoCyoOV49F+/pbJOCdMEFeiOFI2/Xp5Esn+9Hc509xPxn7aPc0RbmP4uXL5xwZHZbsZHxMCQo4nUBIzHvgeTryYi49N5VGsf//Bdg7m1H36/5+wKG4NGV/eKGj3wC+72+Ribb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(366004)(396003)(66476007)(5660300002)(36756003)(66946007)(52116002)(66556008)(86362001)(4326008)(38100700002)(2906002)(316002)(54906003)(53546011)(8676002)(478600001)(186003)(4744005)(6486002)(8936002)(2616005)(31686004)(31696002)(16526019)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OEdlSVlETjdpcm5HQ2VMRlRiTDNWTFcxT0ZUdVZkTkl2dVlIc1N2MG5NUXVz?=
 =?utf-8?B?aTJqY0VHNTVUWVdtVkRjdkE1dmNrZWZKL3VVR1FLYTU2Nk9qQkt3SG1YSjhs?=
 =?utf-8?B?RDNHRXozRFluTm1iZENTOXROSG9QSWk4WkIxRmoxbDYrc0RtTUY1d1V5YlN3?=
 =?utf-8?B?M2NLU1VnQVZRQjZjaUw3YlpqNTFPMVNuTDlaOU1TNDVkV1A0YTJFSFo5NzR3?=
 =?utf-8?B?QWV2dnBoSDdoczNsQjdXRkJ2ZXkvdnlFZUU2NHJleFpqUEtGeXVoVkxxNUZK?=
 =?utf-8?B?TUtIVDhRL3BsSTUvZDRFTjMveXV5dHJDcDFFNzdPR2ZpbE9xUXVNbjRyb0ZU?=
 =?utf-8?B?S3BQQzdIOG42K3F4eVA0cUpzcS9pNU1pcStKOTJLZXZTTWF0MjJ5T3FBSWI4?=
 =?utf-8?B?RzFsbmFpN0ZwK0tqNVpndlZxOHFBWUppVkJlNUcxQnZYWDllV2hZMkp0L2pw?=
 =?utf-8?B?a0YvVVRLeU5ZeGYvSDhMaWVuZFh2ZTI3bGRPZFk1QzBwcEpaZG0zTUZoZE1X?=
 =?utf-8?B?Sm82dzZxTUFqV1V4NUVSdnloa0M5TG5NdWlQZzFEc0lCREczQ1o5MGpaVEt6?=
 =?utf-8?B?TkJqSVAwMmg5VUtHRUthSUJaUjlXbmg3ZlBjZmRvYzJBbkVJRTROamkzY011?=
 =?utf-8?B?U0tyU3VvalZkUWRPaCswWEhPeGFOUzYrSUt1akV6c00zcHRPaW1SU2lvQ0p0?=
 =?utf-8?B?TnlzUVdhcHRzQXFNbTNNamN0ZVhPMnNYRm9RT3c5WmEvMDFYb09CU2RmZlE1?=
 =?utf-8?B?VkhRWk93TUdlZVg4TUY1cnNiVGYrNEtOaXRyeExPMU1EUXkwYjdXMFdiYmQz?=
 =?utf-8?B?RDBKZnJDczFaWmswVzlOOWtxTm50N1JyRXYrdWxIZ2tBMEVJZVo0cjZyR3dU?=
 =?utf-8?B?dnVkbGVFWTBVSDlwSjRNeVFRdnlyOWtDSHQwR1JObW9oVEFWWk1vRk9HWFFM?=
 =?utf-8?B?ZjlGMmw4Q0d0MXZJd3VzbGJWbENpVmFNb1VFKzRqZ3ZnUkNyaEV2ZTVvZm1j?=
 =?utf-8?B?MFR0ckcxamxaMytsZFN3Um1kbUk3TXFKUWlrOG1yUTE0TXAxTXN3UU00UXlh?=
 =?utf-8?B?bGowVy9BQXBYbUFyL0FoSTloTWxBTGRpSFVqYmlMYXFPMzFIdm9abS9oU1BL?=
 =?utf-8?B?OW9xTTEzb1hmeXpzVktRT1VWODJFRGlqeENjV1ZaS0tDWnMxdXY5Y3N3QXBI?=
 =?utf-8?B?RnMwSjZhejllYnRvWW5xL2s3aXRuN3hSNzVpNHZZV3ZUSUVweWVoSUNNWE10?=
 =?utf-8?B?RFkzZ2g2NTNhUDUwYWRFRGJLdGdIOEcvcytrUkhUNXFsOGx5V2VxcCtFKzdD?=
 =?utf-8?B?ZlNvWTl1NWh0enlPSzZsRnZFaU0ybjVldW8wcElqK29FeXlnMzlpRzErN2cy?=
 =?utf-8?B?OVhsRTVORjIzTjlXdkRjUXpaTmJKajVFdlduS2RVaXdtT2d0eW5XOVl2RGRv?=
 =?utf-8?B?ZUIyTGFybWMvMERFVSs4dkVST2tmYW0vZjJRRU1XaC9MZjZJWktUZjBGN241?=
 =?utf-8?B?Rk1XcWwzWFRselRwNStoK0JwaFVKNlZuOWVKQ0hLRGJsVHllL1BJRVVLTHdo?=
 =?utf-8?B?YkEyTDFnaUtsR1pnYXhmdkhFeitPWnJuVmo0bmViWm5HamVzYy80NXlUMjla?=
 =?utf-8?B?V0EzdUk0dy9DclpZTDVWOG5CaG9RTzJPcFNzdzNaRXlaRG1MQndmVXk1akR5?=
 =?utf-8?B?Yk8zTVpCVGI5cGRWVmpuWW9uZ0tzdEJ0SGNSZ08yTjFGeXJ2M3pEN2JMTUJE?=
 =?utf-8?B?emZ4aTF3dThzbHV4d2VGRmlwSlg2Z0U5bG5PbUdvM0szak1GaGpRTlNneFhU?=
 =?utf-8?Q?qC/8RnZbrDJ3cAWCETZTNYt2RyrsUCPA8316k=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26df8000-dbc4-486a-69b0-08d8fc476d1d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 17:38:17.7436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +3Wg+pmEsHK8QPthGti8onvhSOg8tsR6lA7coJnuuLdja2iBz8If/c+zaioZFigc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2064
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: RDCKmOM6H8pvdw_r6EgMpwxVIYzkYnAa
X-Proofpoint-GUID: RDCKmOM6H8pvdw_r6EgMpwxVIYzkYnAa
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-10_07:2021-04-09,2021-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0 clxscore=1015
 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104100133
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/10/21 10:23 AM, Alexei Starovoitov wrote:
> On 4/10/21 9:49 AM, Yonghong Song wrote:
>> To build kernel with clang, people typically use
>>    make -j60 LLVM=1 LLVM_IAS=1
>> LLVM_IAS=1 is not required for non-LTO build but
>> is required for LTO build. In my environment,
>> I am always having LLVM_IAS=1 regardless of
>> whether LTO is enabled or not.
>>
>> After kernel is build with clang, the following command
>> can be used to build selftests with clang:
>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
> 
> Will it use clang to compile libbpf and bpftool as well?

Yes. selftests, libbpf and bpftool will be all built with
clang.

