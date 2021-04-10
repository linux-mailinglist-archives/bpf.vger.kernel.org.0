Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4724C35AF35
	for <lists+bpf@lfdr.de>; Sat, 10 Apr 2021 19:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbhDJRXs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Apr 2021 13:23:48 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:17450 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234392AbhDJRXs (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 10 Apr 2021 13:23:48 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13AHK9b1004693;
        Sat, 10 Apr 2021 10:23:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5qAwhG377JAAFY4EakYQc2/XeWI0eABLjsfDiUK54Rc=;
 b=b6UAQogD+UV4ORnoq2v+530w0JB1oUt/qnIJ36Mlym0YLAb7S7N2LX+8gKsbg9VoAtRg
 vMSbx/A1sSHu2TyCEQLKRCaIF142k+JqF4JnO6OhH7stTSTmv3tBFcdl2b/yOLA8DJhd
 VHk1tGwdRRPJSzJRK2XuRk8ZCTLPW8IOiU4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37u7be1wev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 10 Apr 2021 10:23:29 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 10 Apr 2021 10:23:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q7+CT6IoZUZHPJQReoRplQ1dXK5LhZBVWn/aOk6gxiGbYFcwDjXrHHIfC0a79KGvSs/UCVpvLZtf3kwkrM19zDnPZGJzbdpJZpstvTbHOuWaPXkmIzqWTYFYAT3lrMwfOwmyMQtLeCyMcqpTB3WA15ot/bEaFheh/DVZsFBIawC0jnHA0XuDR+IEYHxMNHiSnPKYd6cQa9ZlngMXD+wG5+7SEQlV97H/uXTBOFscMF3dhDi7pEeFGfeF4ZEouDwise6tuKSO+VMY5Kw0L/u4rwSLZVm6d5QOH/G811wl4YK82Prh102MheXJoFohBx8r0+Yp7w5WZ3pkKPqRLGY4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qAwhG377JAAFY4EakYQc2/XeWI0eABLjsfDiUK54Rc=;
 b=UTX2Fvnoo+L6FTDkq6SySWLm82VQwdCeY5tyAvmCjYYYIiq4Ho2czqvTV0UkTYHOl2yIKAH1LI+5BEtD+jEj0ehdMICwHvnMz9EQLtsfgx0yjbtS3AWWPlZVq7fEq69eq09odZdm1ArdtRM7CWjqclwrgtCNr6H9bVxrdgzNPsl3ECNNT0oW/E86D1ccLVBlYcoRbiodYRrIkS3hJBVlNLAvlN4I494qz6JGC3PPDSiFCdbJDwIraOHvcroFLmLWLe7fI+CNIqi+YZeOt1o5PfYRjvnf3jSNXk4I/bCfwEVVCyjbGgTMUBA/USN8XaNssFzIk3dAKU+srvHNEe9vrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1585.namprd15.prod.outlook.com (2603:10b6:404:c8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Sat, 10 Apr
 2021 17:23:23 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::315e:e061:c785:e40]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::315e:e061:c785:e40%3]) with mapi id 15.20.3933.039; Sat, 10 Apr 2021
 17:23:23 +0000
Subject: Re: [PATCH bpf-next 0/5] support build selftests/bpf with clang
To:     Yonghong Song <yhs@fb.com>, <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210410164925.768741-1-yhs@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <1ec2643d-0ac9-1dcd-8bbd-12cbc5884e7f@fb.com>
Date:   Sat, 10 Apr 2021 10:23:18 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
In-Reply-To: <20210410164925.768741-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:3c5b]
X-ClientProxiedBy: MW4PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:303:b7::21) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:3c5b) by MW4PR03CA0106.namprd03.prod.outlook.com (2603:10b6:303:b7::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Sat, 10 Apr 2021 17:23:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c62ed24e-f23e-44d6-c521-08d8fc4557b9
X-MS-TrafficTypeDiagnostic: BN6PR15MB1585:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB1585EE880790A47AB595017ED7729@BN6PR15MB1585.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ki6ZAZMGbS5KWLA1gnGhUIo3G+oYINAC7VSbzzc3jqgZ+GeRWBq/OjDBtRQtAWB4eRnxXjW/6TItJD/J12v8U50EqbnvcaaAJ7FjMTWG8wrVJcowx/Dlu+efs4E8nOWlAlSOKvdsixYSjFYx9hmdaBDle5uCeAyKjCCyaaYN6W6WoV4O0ufTGbLVebZHFiK13qnku1x7gBfN8yWYhz8UGuDLMtv/CB5/aHJwF53hSEhh/yWk5hkARVt5FoJMKLW/Id2Ks+2fH0tB1nkbAsWEJ16mHEVPRZIu+Fv9TBVeHfBE/jE12qLnjqmhldTjFiBNtlF76Sj74JT5sQAubEyrZTVeC/7lj7ZO4lsxV3R8YlJ9jn1wdPEjaqmcdLxkm+C8nrx4hKde1iSal0cWB/xdyOQMnwxPCkzdaIuXO92jyOElzBHvoig/50QzGAvOxH+15edConAAo413aZlPCkMICioGGi/oofMEALMj8z2KMNd/xIKPfQwF+LJFrJOWakH9MAwwnzQoeWvvkZIWEdz+WBFQj2Dk2VaXBrDQ6sFp46zdZH2vurhk+VK+vEFqI3tWwNvIP+2DFFaQamDvuByf1v3CLgW0Oj96m0z6nljMFObDGAQpBBKBdSvIcKs7zvp5+DANdL44MvnWNdihBAG11OmmmZvNpELESxfpuWj30cdER2zH4+/QErfLoeP4KP3L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(376002)(346002)(396003)(136003)(31686004)(2616005)(2906002)(8936002)(4326008)(8676002)(36756003)(478600001)(66556008)(54906003)(6486002)(316002)(53546011)(52116002)(5660300002)(4744005)(86362001)(66476007)(16526019)(186003)(31696002)(66946007)(38100700002)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M1NMVDBOZ0tvTW9WdUdpamF0Y3RLR1ovUmM2VkpRaFQ4RmJSRDhHVDcxL0JG?=
 =?utf-8?B?OWloVDVwUWdMN1BESDZLdm9KY1lGb0xvRS9rVnZUbzFoK3Jqd1htVmZ0ZmFw?=
 =?utf-8?B?V01GVGIwVFFRdDNqWi84dDhyYVJlYlpzdmhZWDVJSCtLYW5sS1pqOS9KcHl3?=
 =?utf-8?B?MkdGU0ZFdjJaeEdCbm5GVHZGNEM3QlhjZG5hKzQ5M1Q3YnRKYjhaVVdtejMw?=
 =?utf-8?B?RGZWVEN3RUtubWtjODZYRUN4MlJsNVcyZ3IrT3FkN3JhTjZEMmNqS2YzVTVG?=
 =?utf-8?B?eHVPVE84R3RJL1FTRkVxOTBYdmtUQzd0amY5M2d4NHRJSkoxQy85djNLcFZr?=
 =?utf-8?B?L1REUmplZXg0V3p0T1E3QnNPa1QwV0k5Q1U3U0dIOUEydGEwQUVqZDdhbVBj?=
 =?utf-8?B?SUxVT1VuNkpHUXV4NFhDbDNZKzVoaDMxTjdDNkYxWHF1M0VWVkFsbWlVNVR6?=
 =?utf-8?B?QWMzREZad3VJQW15aDdralV0dXR6aU1KZjl4RDBLSG1ERFZ3Y2pDOHF3a3ls?=
 =?utf-8?B?emdXUTlUN0FvTlJMTE1NTEpIQ2w4R3d3U2pOT09MZURPN05TWnJwTEJOVGVw?=
 =?utf-8?B?bXh6RDRrNGhXMkRiOUhReTVpcnh5SGcwZkhScHhValYvKzZQUG96RUJyZE0w?=
 =?utf-8?B?aS9za0tuNytDMkRmWW1TM1ZFRFhSdGRKakhZRHV2UjJDQ0VDcnl6TG5weEVH?=
 =?utf-8?B?UWJBN1c1aE1PZnNFWDdVMXRWdkEra3dXbzgyOWhjUEEyTytKN2lwbVpsVUFi?=
 =?utf-8?B?MkY2dGV5NXFiTTRPSCs0UUFabmdnL3dHUkNzSENxdEc1c3dJZUFQZ05ucnl2?=
 =?utf-8?B?eHBRL2RrTkM2WGVHNkxKK1YwaGhLRFNlQkJsTVJLTG1JZUxHOHAvVWYvWFpw?=
 =?utf-8?B?bzJuNmZUaGlvTUpjMnhHYU5mMldsT3Z5N29zOTQwTEFhdTRKYVoxY3M0ZXRH?=
 =?utf-8?B?T05FZUExZkxzL2YwN3dIRlQxeUkyUXI4Z3NwSytiQUhFd1pjSHZRSUc5cmRl?=
 =?utf-8?B?VGtSYldjMjNvSHN0WnIzSDh1U2FtelZFSFJkbUNjaVJZd05hdDZTOUJhRklT?=
 =?utf-8?B?L29hS1FUb0RPVTdiMW9GZFIwSXkrODhMVTdtdjlheFVLbVhNeTFWMld6cTVy?=
 =?utf-8?B?bGNsanh2WGI3ZmJCenc4djVrZUhWTXBxWStXWGIvZEQ5bTQ0cFFIekx2SGQz?=
 =?utf-8?B?cDBVVXNIeWFza3oraXhaUGtkWXRVeXAyc1VKcFl6WFA0Uk85Y3dENDFGSUZR?=
 =?utf-8?B?QUxHbWFIZXlSK3d1ZGkreDdmTFlKUVRpelQzSmYvWFkwSWFFUVBEZW5sM3Ar?=
 =?utf-8?B?d3VGRisxZmRwS3dCOU56RjIrTU5jN1B2eU9wbUY3bkJ3T1krdTBCc2wxbGZs?=
 =?utf-8?B?cGUzeXRaeFVIMThoOW5YdU9FOVhZVDRQc2p3RFUyTEZtN2ZEWTJWRFU5amsx?=
 =?utf-8?B?Ni9zZmQvUzhSY29QZktYY1JUMERGM2lBNTNwZkhhVWFNUmdoLzFHb0YxclNN?=
 =?utf-8?B?OEFZTE5ENHNDMFVFVUNjdnNvMVBGVS9vTWpkL0VTTm9ETzlnN3lsYnMxb0t3?=
 =?utf-8?B?SGJBWHZOcmZ3M0xyajRrZ0xNU3NyOVFJcjRRdHl4dkUyTkRYRHR3M1ZJQjFV?=
 =?utf-8?B?VjU2SkpTUnF3bkVUY2EwM2RPeGZsU3NJL1g3M3ltc29UYWZrdlRGU2liK3cx?=
 =?utf-8?B?c3NYY1VIV3N3Zll4QXArZmRiY1VYVU9CenpOVEFzZkJhM2s5cTlOR1YxdGZW?=
 =?utf-8?B?djZCWWUxeUJuVEhTMEpHOTRKZ1lEWmt1Z3luS0hlTzAxc0czQ0NUenU4Z0dN?=
 =?utf-8?B?MW0yUXYyU2t6VEM5d3NsUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c62ed24e-f23e-44d6-c521-08d8fc4557b9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2021 17:23:23.8244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYCohmEnAkmIx+iGMgbjENJuZWyTfkxR0ujLX5lxYcWilLfFgac/JRAEowQaVgPt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1585
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: -uKe5LNtDm-3u6pW3S1eOfP2kdvoC8mQ
X-Proofpoint-GUID: -uKe5LNtDm-3u6pW3S1eOfP2kdvoC8mQ
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-10_07:2021-04-09,2021-04-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 malwarescore=0 clxscore=1011 impostorscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104100131
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/10/21 9:49 AM, Yonghong Song wrote:
> To build kernel with clang, people typically use
>    make -j60 LLVM=1 LLVM_IAS=1
> LLVM_IAS=1 is not required for non-LTO build but
> is required for LTO build. In my environment,
> I am always having LLVM_IAS=1 regardless of
> whether LTO is enabled or not.
> 
> After kernel is build with clang, the following command
> can be used to build selftests with clang:
>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1

Will it use clang to compile libbpf and bpftool as well?
