Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE286838D0
	for <lists+bpf@lfdr.de>; Tue, 31 Jan 2023 22:41:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjAaVlO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 16:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjAaVlN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 16:41:13 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF2D1A968
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 13:41:12 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30VIH1qv032702;
        Tue, 31 Jan 2023 13:40:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=asaKDxbmru2+KA2efFHfbSeU9CPB4J3jT+ZyvCrN/Hs=;
 b=gxA8/Jce3tnYSPsuGpw+RSRZwbL9PVVWvkBJFAWeBlIJZUMhQ2suPGUDpo52a2LlnX1j
 JJeHVVRv208zTHVuXNRDq2ZG2XqTrz/tb7V9kfPcpqWCr+zElIwwCAGfkCliKuJhgbZR
 dp5YvMws1aR0q2s3zYaM6y5Wt8B2+bwAB2arUuv8EjEzscDtp8BjLaQUVCVfJqE8B3Dv
 TsVotOpkyzfxmQ0cyhFW/M9UD5Jb9U1j6nMsqcoyVnbWTb9LpnG9uUGK5hFeVfsEopM8
 V3DMQ1NXaSHZiu/IdX5aMuQlsSFmL+dmmvH3Zv+Q7Nii0Fhsc/8GT0awW0BO9kUkZQ4R Sw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by m0001303.ppops.net (PPS) with ESMTPS id 3nf37ev7c2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 13:40:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co/GtoXmbHR1wJmcNlnIRnMN3+vF7WUTh/biApmi0JJfycGk6nlbuvF7rh5TDk5I4qaxMG1JpX63iRv8p7UiLVwAD35C2hwFtnzCQv75j2DPzEzSqhkgx/pPU05zkfR5aZELT291cam5c9hrapx5fA2xCfdY1G6VoWugjF75cjq6/go1UWPW0hnYYU9WpU3fB89wXWkuVx0mmD8aYsPTlEqknS43MQWH4MPU0kU2jkzcspMdWPSxXwqu8E1fOgvvI25/GYcRvgFHG3swprfVbY6hqGVdP2bgJsTwo6xuyhQweMLPupYcK2gXaMwkV18cpmDbtKj5ixKfcv2F6hAm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asaKDxbmru2+KA2efFHfbSeU9CPB4J3jT+ZyvCrN/Hs=;
 b=VRIukWnTbpibL6XAAJG8BCyRZ6TWn3jTFHgl6umXcTg67yzoElmALbMQklLlq0qLgw9eh9TlKSMbNZNeNg4mt5tYWXw0ZVcygd8Ao+aan47oeRAG0QQ7YAp+zFH631wHrbuPgDSWjLxjRQCx54bsjZtw09CJ9Q7bA1MB4pFv8OgxrLK2f8R5v1l0edpdagzQiiLljKiAGdD7XXx1UloRp83ngrmHzDvGCV9DQr3L/HpUQm5Bu9wNULYoxMzBxeHK2YKUCCp/jt3W8MC5PYYYHkoK2wrhk2V3hisjn4ewiKIu+Dk5jE+bAqC+vtVsw1RRZHWNaHChPBaW3SuiWQFzlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4442.namprd15.prod.outlook.com (2603:10b6:303:103::13)
 by SA0PR15MB4062.namprd15.prod.outlook.com (2603:10b6:806:82::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.36; Tue, 31 Jan
 2023 21:40:52 +0000
Received: from MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::a677:2a9d:89d6:b1d1]) by MW4PR15MB4442.namprd15.prod.outlook.com
 ([fe80::a677:2a9d:89d6:b1d1%9]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 21:40:52 +0000
Message-ID: <2acdcf01-46d8-9fb0-0d9a-e559ea9b7a48@meta.com>
Date:   Tue, 31 Jan 2023 16:40:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH v3 bpf-next 11/11] bpf, documentation: Add graph
 documentation for non-owning refs
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20230131180016.3368305-1-davemarchevsky@fb.com>
 <20230131180016.3368305-12-davemarchevsky@fb.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20230131180016.3368305-12-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0311.namprd13.prod.outlook.com
 (2603:10b6:208:2c1::16) To MW4PR15MB4442.namprd15.prod.outlook.com
 (2603:10b6:303:103::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4442:EE_|SA0PR15MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: a46234bd-6d7c-4f4d-5dff-08db03d3d35a
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RkJ3LdbwUkKBVKqL9tUMpuD/uh3swWRaOEQ+ztPZBJz1EiroJpisxgISvuZBZCJENaeux7dRiYJvaySZdOAMikfRUZXURCXq4cRfU5oS2Ip72d/gDow/lBX9Wve1pRp39eyCRtm82nmU+hi8voa6XPoNKHAtMPxvHclpYUdLm/8A1TKQi9Ji/iywrKC/55AEKacmU85cYNcCpARLjF+vPyJxceJLFYWKGjBXQpvZvfcyMSWHpN3fnS7wmF9mknqzh+xSus2YnjyJuIgnSRzmCYPys9oFdb3uDYERbEpfKOlBo+mCqec9s1volBphAEIJIty7kyROhWlMmZwgNgj9rfFJkW9JS/6Q4PVpFEFXqWvPmtZefA2xlnmaEJ0cMwAWuslGZJRtiXl4PweUTHFkc6gj48UreQ/Nlaee9sur7xoNrJlcNnTuQ/z6yONba/XLnShaMAl8WXATQpyCxGhQ0i80ZUZgFqG/QbEcjWz/UQAP4P0DrIRjeTSCizTSUH7ccmH3qp2KIHogfVB/grjUvyZ2M54fhxEwksZMs3U5BovMKkWdyaKb2ZhQZZqQxmFH8/wNYkzURsLvTw2lFektAWaCHbNS6epIwUhKMZaQgO9ufTkSs/YWALTE8eUX6086y/kYggHlts+5X9B/TgWLOmIDsqj2XlCNg5bPQepHZJKyOG7WJVaVkC3Xz10ayJhVEpfkob7mX5YRtXla3Yoo6iAgq9ZaStgLVVQ5R386M9k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4442.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(451199018)(31686004)(83380400001)(66946007)(66556008)(66476007)(8676002)(2616005)(38100700002)(41300700001)(186003)(6506007)(53546011)(6512007)(6666004)(8936002)(4326008)(31696002)(316002)(86362001)(6486002)(36756003)(4744005)(2906002)(478600001)(54906003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWlhNEp2OWFTTTdtRHVnbXNObCtHVDBVczZWekpzUFhwekJLeTM2RWxBSCsx?=
 =?utf-8?B?QUdBNktMYXZJRFM3NW5NQmExczEwZ2xUazYwNVRETzkrRVdOU2g3Y28xNEd0?=
 =?utf-8?B?WTIvcEVVTG1YR3J1eFlKNU9kbzNKUm1QZ2orUlp3Y3A3UjI0djUzYzJqNWhm?=
 =?utf-8?B?dWovMXJKVnFsZ0hNb3pNOEZGZjlYb1JjL0Vva2hHZHZGekxuNysxYS9pakV2?=
 =?utf-8?B?Y2w2dFpUajViRWlESHkrWFYvbHNqZFhlREhiSHFzVDhWUGZpZjQrRlZvbkdT?=
 =?utf-8?B?anN6cUJ6VCtTOVNzTTU5VlF6cUYwNC9lVU9PQTFOK0kvTkxvY09kbVBwK1JB?=
 =?utf-8?B?S1VBUXVyN0dzU3NBMG9lWW5LYTF0WWZ4SElsa3RyZTBMaDBvSDZyN3VDUlZ2?=
 =?utf-8?B?eEhtZXJXRHVwMDVNZlhSMVI5QXIrRFJRdm16NE1icXlyS1I2eFlMSFpJaDdz?=
 =?utf-8?B?aFRYZUUrSmdoOCtzYWtMT25TVGZwMllXeDhCdDBhakhiOUF6MGExc3VxOEcv?=
 =?utf-8?B?MjhqdHBJQ29Rekd6dTlxazhIY2QveDBCK2tWWllGVVR4ZDJ2R2l2ajM0Um1n?=
 =?utf-8?B?bVpsTGpjak4wZTVpZnhBYS92QlRrTXBLWlJNbmFXUFJRaWtMbm1VbGk1aGxo?=
 =?utf-8?B?QmpDWTdQY2MxTEh0ajRpRlN5NFR3UDBmeGxHcHlmRXZINEw1ejVTUDZCUUlt?=
 =?utf-8?B?Wm8xTlpPUjBYTGUyRXZ3WGl4Y3hpNGZpSGtNTkV5YUVTdEhtVUlsc3VDM09Y?=
 =?utf-8?B?NzRzVkNOOGNYTHozREVWNUhDNnR0aWpyeXZjZ3hWMU5GYWhlcDBTUVpzUStE?=
 =?utf-8?B?VHRURVdMV3Qva2FwMHY1VXo4RHdWOGtXTmtZTlZFelA0QU1zaEdocFIwVndU?=
 =?utf-8?B?T3E3K205eVk2YVNIbmNqWkh4OEFiSnd2R3VNcnkwcUxjWVllcWQwVUljOFkz?=
 =?utf-8?B?OHNvRTAzSCthRVpjSkl3WHhpOU1OSFNIMWh1NUVwRHhLa3U0S1VrMm9VVkhJ?=
 =?utf-8?B?eVNkditzajAvVzJwcmtoOExDdEZoRk9JN0tXMEs2SzZFNFhZRXhudG52ekFz?=
 =?utf-8?B?ZjFtbHlyMFhFVzRVMERyMThQMHE3Vlp3cnhJUEpGRVhmK3o2Y1ROdGR2MzVV?=
 =?utf-8?B?ck41Q2g3OGtWVWp4MXJMK0JmZld3SUpta1ZBQk9oZ0JWZWVKdURWVDBYRHNa?=
 =?utf-8?B?WlFpQ3BKaStGNVBIQjgxckJBTTdCMzk3Q0tiRDBZeU1wL3hHelYvbFRSc3Ez?=
 =?utf-8?B?T01QYWVSZWtwYVJrRzBwSGJQQ3d4OUUzbWJMYlBwcnNzb0t4ZTM4Rnd5eFB2?=
 =?utf-8?B?RlFsNWd5N0hYd09nRFprbVk4cVk3dzhFOVdnQ0hNdnpUL0FET1RPazF6TnFD?=
 =?utf-8?B?Y2tMVy9ORmc3QUlJMHRDRkF4YlpIcmVGSkJUSjlxMkVXOWd3NXpRRm02OVEv?=
 =?utf-8?B?K1VUTnA4bHVoZHNUOUZseUtqNmp1dmZEcExIcW96S2lQVEdwV0RzQzJzdnZO?=
 =?utf-8?B?blFhRE5PejRWdjZ4NGlRQUlHeFpudk1TOXlpSTAxTGJpRlpYeXFsZlY1aENH?=
 =?utf-8?B?OThpRnZSV0tMVWF6ekdFV2ZSRDBGaTlTb1hIWFZUMHN1L1VldHg3dWxhK1Fq?=
 =?utf-8?B?N3cyZDJaRkk3dzJkSHU2dkhkUk5iKy9kK1lENG5vRWtPUXJZUHl0c0puaFJs?=
 =?utf-8?B?NFlVSCtwQUFGcGw4RTVSam1rMlVKdmJwLzErN05RN1NNMkljclphdEZrWGxS?=
 =?utf-8?B?THJuVkhBWS9sMkNkYWxFcjgyUEh2aGlmV2U5ZndVWjRWaHZrdWJrVlV5ZlJt?=
 =?utf-8?B?N3dlQmpZSWNscVcxeTFLQUlMcWFzcjhMWHpERFQ2VmtSYlNrMHhOWXMzSWhx?=
 =?utf-8?B?eFdCb1V2R213ZnNTWTVIdUZQdHB4WGV2RDNxdFdtQUlGcWpBTFdUL3dIcDN2?=
 =?utf-8?B?ZWU3a00zWGZub21tSkI0Nkh3Wk0rZFF3bDdaRmhuL3Bzaml2OUNlZ2Vmd1Fk?=
 =?utf-8?B?N0tOK3BYL21FSUpvM09teFNXODhCdUFnU3JDQnluSi9MblduNE53YmI1Q2M5?=
 =?utf-8?B?VEprRGIyeWx5OGkvVkd6NmRIK3NEWDNEK3IyZzBNOThxYWlNRmxTLzAzUmJW?=
 =?utf-8?B?MU5hVXk0WGZ3dGpYaTBBNkNrN3BmNFl6TWhTT0FVWFkrd2hjZUNBdzFXaHc2?=
 =?utf-8?B?VE1mNFkzeXNXQzVibTM1UUViMzJaOGF4RnpjMzNBcWpoME5XekpUNW9jZFpM?=
 =?utf-8?B?amtaL3lXbkJoSHJKVldWTmNRTEZRPT0=?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a46234bd-6d7c-4f4d-5dff-08db03d3d35a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4442.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 21:40:52.4766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jh71IxUZz/O9Nafu5rSNz2drVIv6ChcJMxmAPSYVocK36VvXWAeqnnA8yEGQ7D13HTuxmgzw4Daeh4xTTyTIsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4062
X-Proofpoint-ORIG-GUID: STxBQbzLhCUjQQ6Fls2Px1yKixCm2uR7
X-Proofpoint-GUID: STxBQbzLhCUjQQ6Fls2Px1yKixCm2uR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 1/31/23 1:00 PM, Dave Marchevsky wrote:
> It is difficult to intuit the semantics of owning and non-owning
> references from verifier code. In order to keep the high-level details
> from being lost in the mailing list, this patch adds documentation
> explaining semantics and details.
> 
> The target audience of doc added in this patch is folks working on BPF
> internals, as there's focus on "what should the verifier do here". Via
> reorganization or copy-and-paste, much of the content can probably be
> repurposed for BPF program writer audience as well.
> 
> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
> ---

Whoops, I forgot to rebase in some of the changes David requested into
this patch. Since I'm sending v4 soon I will add those in. Probably
worth waiting until v4 to look at this patch. 
