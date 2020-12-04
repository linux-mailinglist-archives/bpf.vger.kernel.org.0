Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5D2C2CE720
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 05:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgLDEv2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 23:51:28 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57116 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725989AbgLDEv1 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 23:51:27 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 0B44hwkP002370;
        Thu, 3 Dec 2020 20:50:29 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=PQzUIns0TeDI0qJuGS+2bKr4/vipiWlGSwe4pYzbSoY=;
 b=XCtAbyZaRx2cSEmxoQFA/VLPLGeKn97ik+jmkAKDQztJ7zJtmoo98VGWjZmKILJCJZXu
 3ZwQO/ByZ7zoI9ezYoz/WntS28RiU3GyXsSNHCNITyxIo1x9dICo79lVGZnRlmyRDrQQ
 zJeZbpoKwueqWBl7ULOeeNPAXTHK7gmLF/4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 357682b74x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 03 Dec 2020 20:50:29 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 3 Dec 2020 20:49:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNzWDf0fIGggTHxL7xTuGaOIGEQqYG00brU8lRzSvKnhVTqdfnIreqdfACLZuXMDKHDW21ZX815IvpEi4UTbWcOj4a+56GBg3J+sgypk1ts3iDjcrzSaspzsjsRrmuStUCgCqbVU8kaDzxgn+NR14RI0CmKm6dro5LiGhYR4lGU4mE43BqGS/xLUKa6Q/5YrTY3n3W4i5yJVqJuRdOXvDGB27DlmicrTuOz9MeU5QTGArWzIjXJ2Jtfs6afgUL8aHNQ0ti2Rn9CtbN/i9QaUgYsQfr1rY217FN+rTB8wefZRv63Hwo9vU/nZT6olpNaX1WE+hGVICJWE/Zhc94+Iyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQzUIns0TeDI0qJuGS+2bKr4/vipiWlGSwe4pYzbSoY=;
 b=ZmCCrDuB7G3tsanrHKjy+wEQ0Uq/Q8pzvF5+QHlcXF/Ajx8URAcDddzWDCmGC2M1tGO6QyhE0CcyxtruaAcbfOf7yEwc2fO3tq9/nYD8DLQqkj6dWxoBk9INZta9pmlUOSq3KLmZnY5i1xJPJ7z5gZadlPEejPYcy+wNBK7q2jjlO9Fo8V8+B+SuwN0TSlQAsSWfyKi5LjV2zm0ruZ2x4LGkg6dlYAdaqHHh1hViWdeeNtICL+Es+6nvGkKEVQ4OvOQUjSM+sobYAmaEzOnxCYj1LMk3l2SXP2tTWcCV0zKsPA31JsPRHS9HHm/w3MbWfjG6utT+I8dI8rCRUxj0AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQzUIns0TeDI0qJuGS+2bKr4/vipiWlGSwe4pYzbSoY=;
 b=jf/r13JbK61/d8YxeWcC+o8gBOE/DCOJFM33ysOKWskw1mRHiiEctAxf1esFO9IfWSyvPhZ6aPr4bgRXmLZX2MZCQZiJ7q/hNVQCw3vqQGF3Vo7cJZZMwpRHPcdKW65BLiBhkbU0+VpqexFvTQPFj0WqbrOGuVT4mM86J5sJVTs=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4117.namprd15.prod.outlook.com (2603:10b6:a02:c1::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Fri, 4 Dec
 2020 04:49:52 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3632.021; Fri, 4 Dec 2020
 04:49:52 +0000
Subject: Re: [PATCH bpf-next v3 05/14] bpf: Rename BPF_XADD and prepare to
 encode other atomics in .imm
To:     Brendan Jackman <jackmanb@google.com>, <bpf@vger.kernel.org>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KP Singh <kpsingh@chromium.org>,
        Florent Revest <revest@chromium.org>,
        <linux-kernel@vger.kernel.org>, Jann Horn <jannh@google.com>
References: <20201203160245.1014867-1-jackmanb@google.com>
 <20201203160245.1014867-6-jackmanb@google.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <33df38b3-60a6-9408-dfa7-f10b6273b226@fb.com>
Date:   Thu, 3 Dec 2020 20:49:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.1
In-Reply-To: <20201203160245.1014867-6-jackmanb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:86b1]
X-ClientProxiedBy: CO2PR04CA0141.namprd04.prod.outlook.com (2603:10b6:104::19)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::12b3] (2620:10d:c090:400::5:86b1) by CO2PR04CA0141.namprd04.prod.outlook.com (2603:10b6:104::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend Transport; Fri, 4 Dec 2020 04:49:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0254ebb3-817f-43a4-af10-08d8981009c8
X-MS-TrafficTypeDiagnostic: BYAPR15MB4117:
X-Microsoft-Antispam-PRVS: <BYAPR15MB41174E7EBAE78707BD347094D3F10@BYAPR15MB4117.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wiwHsQJCYrUCO7eUcRrNMIpXQ7zztiztqMcn1hFNsfQYo6w+ACJsJA2FZvaLQ4ZTge+r9JIpmMIF6Ck49DUjftXlBrvpKwf1H7Qt4O8Yk04lD/NrOYvhtAwJv8ZvuhW1r69+QNar0DdMSnZsdXuCBntmvG4g4+lf5wTeJ9sACNvPPihkW66/3PzFAWBfveNbfqTxj3/LzLAswzWwP09VxizrH6SVbijhpelTLLUjkXIAKXlLCs5Hy8b+uMJoZFN3tBlIhcyQLTIkBMT9c9ZCLEaXgW3aSRAIz9vS9jSwQkjFSICosYU6zLRomUN/YrGiJm6K7xD2k29ib4a/dCIS3pct4OK94AOxfUz3i9dztV0Rm0Olv1abS9H9YY+C+pMfB3wWTBZ9vKVjFS/GQuoYs/EgSH1I+1MIIZCrqAb6dGSwMFk2LOuS5KmeYPsKOADh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(39860400002)(376002)(346002)(396003)(31686004)(478600001)(66556008)(66476007)(52116002)(16526019)(186003)(4326008)(8676002)(53546011)(2906002)(36756003)(8936002)(31696002)(54906003)(86362001)(66946007)(5660300002)(2616005)(316002)(4744005)(6486002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eWxNckU0UmVTMHFwcjFLYkxBalkvR1lITkx1TUhRVi9CS1p3UlF3eEMrcHJv?=
 =?utf-8?B?bzFpYldaNnVMWE9oSU5QdEF0OXFWcHhNcVRjaWltSVNKV3h2Z2VCYk42emEv?=
 =?utf-8?B?U2x1QXpXL200NjJuMzRLOXF0a0RNWnRJMUVrQlk0Ymx2SmJCc2gycmpaMzRp?=
 =?utf-8?B?ZGhGOE5jdGkyTFN4U2huZkhrTzRRYW02b3RuMERUbi92QlU1S1pTcHFFSldo?=
 =?utf-8?B?WGloVWhNV3VPM0lpQWhrbmkzbGVQNXIzWEFOcTRBN2JDaWhnOVdDOVVsR3Fy?=
 =?utf-8?B?L0ozVTdudTYwYkpwa1YxdWliaFcwQ29OUjFtVDc2d0hsY3dhdEVCNXlqYzRG?=
 =?utf-8?B?Rng1L3BOZExFQTRSQ3orQTZhRC9rb045SGRwQVVVd2JJQWhNb2tEQkUralBZ?=
 =?utf-8?B?WG55NkxOTVJQV200RGdYV0kvSmltZ0J4SHE0ZUZXOWhGc2I0OVdlRUVaazA4?=
 =?utf-8?B?NmY2dXVTM0VzaEpaU0p5bWVSeHM1QjJ1S0VXV1dNT0ltNzBVSkdPbDN1MzlR?=
 =?utf-8?B?QTJyQkZkczdjNm5CSHgwL2FNS0tiOXZhMnk3OVhtQWxkYzBwOEllOU1uN0t1?=
 =?utf-8?B?YXRGSnZKRHZtVVAxNCtWWTZVQ09oanhiWWxJbG9yNmJ1d2krbmJPVTl1ODcr?=
 =?utf-8?B?bTdMaCt1ejdubkhvTS9rL1FXS2RYcVo1ci91NDh6Rm8wVzF1QmlqdkxVUEZQ?=
 =?utf-8?B?ZjNZZXlyd3hnWmJHUTZDeEFETW14bXFIVkIwem1iNlYwTjJGSjFuT05waWRS?=
 =?utf-8?B?dmFORjBFTC80S0JpSDNCSTBBcVJOOEdiOVpCN1MzZmhGT3lUemR6MHpycXo2?=
 =?utf-8?B?WHVyRXFSWWJyMFJGTlpqRGJFWXlVc1VzV0F3bng1Z0xydjJaQjBOMEcydHpm?=
 =?utf-8?B?MFMzZE5DYi9PVlJ3K1dGUWtRTDhiSVJzRFNuZmZaUFNCWHpxdDJQeVM1eFI5?=
 =?utf-8?B?aXgvSFpZNzZJZ3QvU3YyRGRIZ3NBTDF5V3dGREhWTnFpS2VoS3NBd3dsTkdr?=
 =?utf-8?B?amhPUHlqWE1GUmg5L1lQUzBGdFozY1NncTFtdzhpZ0ppWm4vajlhQmdQb0dr?=
 =?utf-8?B?SHowa0N5YWFFTDhjUXBFaXIyc0VmZU5nQXdaM0tzWlp0QUdKdEJNVW1ydVdZ?=
 =?utf-8?B?NGl0VE9OZ1J0NkdEWTd4bW5Fbk9HOGRKeVhzcHo3eDlTTWtFeEtSNEgrZXZC?=
 =?utf-8?B?cWlyVnlBelQ3YjFjTkxybEJyVmlzY2NIRkdJem1hdWhTN0VXWDNRRTF6M0Zy?=
 =?utf-8?B?R3Z3RllHMVJNQlp3RjluajdYWlBybW00OUJvRUFTM0twT2laakNXMHNmMkNa?=
 =?utf-8?B?N1JMRTdyNXN6VmlydG9QY1NMbXh5aVJCY3dGOXowaTZTQ3crVTk0eUJyRGc5?=
 =?utf-8?B?QUJaWlFnamlMRGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0254ebb3-817f-43a4-af10-08d8981009c8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 04:49:52.6069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfd26op4yLDZ5q3eYEmePrIpmFJ9A8n+c+6tyrSrG1YZymYU/G6W3+QKPc/fqEAx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4117
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-04_01:2020-12-04,2020-12-04 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 spamscore=0
 bulkscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 adultscore=0
 mlxlogscore=677 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012040026
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/3/20 8:02 AM, Brendan Jackman wrote:
> A subsequent patch will add additional atomic operations. These new
> operations will use the same opcode field as the existing XADD, with
> the immediate discriminating different operations.
> 
> In preparation, rename the instruction mode BPF_ATOMIC and start
> calling the zero immediate BPF_ADD.
> 
> This is possible (doesn't break existing valid BPF progs) because the
> immediate field is currently reserved MBZ and BPF_ADD is zero.
> 
> All uses are removed from the tree but the BPF_XADD definition is
> kept around to avoid breaking builds for people including kernel
> headers.
> 
> Signed-off-by: Brendan Jackman <jackmanb@google.com>

Acked-by: Yonghong Song <yhs@fb.com>

> Change-Id: Ib78f54acba37f7196cbf6c35ffa1c40805cb0d87

As pointed by Andrii earlier, this 'Change-Id' is weird. I didn't
see it in other submitted patches.
