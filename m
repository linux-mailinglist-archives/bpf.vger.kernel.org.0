Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613816A3375
	for <lists+bpf@lfdr.de>; Sun, 26 Feb 2023 19:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjBZSbQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Feb 2023 13:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjBZSbP (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Feb 2023 13:31:15 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF451A976
        for <bpf@vger.kernel.org>; Sun, 26 Feb 2023 10:31:13 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31QF5krV012273;
        Sun, 26 Feb 2023 10:30:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date : to
 : cc : from : subject : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=u0oXz/aDNSFl52OrjnotRTBDmfTEChpK8edhBiBU16c=;
 b=BuFAasxAuhyflkCl2qBIzoFE0nvouzWEgyozszJTll+LM63buU/VPJDgCsqoa7643n0d
 Cvs8Okxtqt2zNoCJovx7j1eMvhZVGtvVcpx/Mj2bY44yYxfs0IQh4k9OvfX0nEii5mOK
 JtTLV+RLY0fGs3t1bzG8eag93FM0uf32BSC7j6m39kajG9H+kYkdNVSevXsqb59I4aO6
 +S2JX1k2ZMxZXEnZ/BX0r+VlADyiukysceMkFN1ZGRqjHm+tNbVDf35z/5+sVF413bvt
 UntWffVvuQgWR+ti8BMF3329dzLQj2pGd5rDFAiH8tbfe7FuxrS/xuYDoTUYlvDOsV88 HA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nyh20ejbx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Feb 2023 10:30:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xo5NLT8UkzX7hrnsv38DewJ6B/Dxt8llFkOYDnoQBaJ5qLkljPQBZyTSY2RaAJWnd/O1U/yGJ5x8X9cIYy4tw6c2DuZGrngnjC9HHJ3Byf2sXYjyQ7rj4iqcU1X28SncIU9NM4S9I5mvRkIkOyPb8aEjx9MuTXSHu+3/kMzW3HnWUAj5qZDn3wgDGvKDZKy6bOAWCc+iPlyFaVWICmZYRMkGYNyljkYnJwvvws5/15Oq7WFCpIe2o5uIy0pOCDlmeLfj/wCHkF9/K8wxU1M+gca1Q9fzHvR5qMhx7Y51InIFmOZT49tUBSMPRgM1TKH0xMBxigGlBz+pu3B2C82LhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0oXz/aDNSFl52OrjnotRTBDmfTEChpK8edhBiBU16c=;
 b=byyyJQ/Ok7CdCJ5Gpcekz8XChLvAOc2YHLKjjowT8fmMxFng6w0hMX6p13r4kQwLxPXea32GPLxxHeOOxbNZOUcKx6YBMdS1qUw6S2X1M5gorVHrjegh6Q+kEhXYJ7aCMmXaqb6JAvRkDrl3cuD/JC4tsoJz+/CvdzDYc5CI0uaO5KAOTwIfyRmmnTEhG2nrJZ3+eNKbMvjwwagzhCqmJD9gFegZqgJSd/ns65oovgUpNsSlo4BGJcEoLrzUDGxO9sw6DV18TqF+9oiKQ6nRJ5A5HbRupB3chhVsCTT04IjE4zRIz9DPWcQc0zFNEmocGrR3vUo9fK23Ep7hrfAKbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH7PR15MB5738.namprd15.prod.outlook.com (2603:10b6:510:271::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.27; Sun, 26 Feb
 2023 18:30:54 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::a595:5e4d:d501:dc18%4]) with mapi id 15.20.6134.026; Sun, 26 Feb 2023
 18:30:54 +0000
Message-ID: <4bfe98be-5333-1c7e-2f6d-42486c8ec039@meta.com>
Date:   Sun, 26 Feb 2023 10:30:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Content-Language: en-US
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
From:   Yonghong Song <yhs@meta.com>
Subject: [v2] bpf: Propose some new instructions for -mcpu=v4
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: SJ0PR03CA0117.namprd03.prod.outlook.com
 (2603:10b6:a03:333::32) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|PH7PR15MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: 62864055-2c22-45b9-4e01-08db18279873
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Rvenl1r8Xiyx0ACte/8FDq5jCzGV0Ugk6tBmBWtOANOD7FQl+oLh38Y9RALZ6VxCBaFVBXn58dehg2R+/RzXwfG2ziKvtcqAJD8y+S5qrngNW9yC0SFXgOceLGRveY2VkdK+kyjxVPLugoTQyoY/ntiXCWSm2TCD9HSqnfkSJkIlpEs3Xthl6dTMVSoUWRxtQsJGpw/TVg4IpbtE5LHufizdzhjTSAVkhIC28M/cxzRngngccHxObYI9xu0t5VguFONMlkJXM+SR+TVmlTSMAErqnMPmap01c4Ooz85+P53lxJ6mw/j7Tvr2NmqWZuStcmXPTNb50OsZVEKSvK0FrooCzqmPkf2l5mzYYdBYsRI3mnamqa7aOTQe7s1i+qdNOPG/3BDYctXmTbUhvY+TdrBidkvPvcA7PeT6IwPOA6F9GyZ9OFCpa83OqDfe7p/85BLsuLCIl1eD9qxq5yTERIV8lQxssZSTmdGQXTSqf70pgZAjTM+3k1bEnc0zmNSmLQ+DlGAVsPU5JZ+pTBhvAHDL/nAKsTajme2IGX9eAe4Dr6G5wlISCQWNE9s4RYWx4E8OmxSrZt3DoIrY7p+4Ki0WAKXGz29kWdGl0u6uUpPxpLZrrkqivIR5kmT5XOjTg8oNjqIB9f5e2HUu/hB7vtQxvF+3upe07XYIofry1QOGYJqFt83A1ZRam0GikxEIhOPveBuMAiYAtV3hcMKe6nJnpRfJ+T/ATC2c0G0MpgkyF8gmLyHSf5KIhg+zvrQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199018)(186003)(6666004)(41300700001)(6506007)(6512007)(478600001)(8676002)(4326008)(66476007)(66556008)(66946007)(110136005)(316002)(966005)(6486002)(86362001)(36756003)(31696002)(2616005)(8936002)(31686004)(5660300002)(38100700002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MkdZbllCZGFWNzlwdU50bWxETElQVytWSnVET3hyT3FtcktFOWd5SEVvc1Nj?=
 =?utf-8?B?SWt5QU5rNW0rZGNLcEF1bmljTnd5SU12VEtLd1N1N0l0Sm1va1U1ZHhjU1po?=
 =?utf-8?B?THJ6cmlCdGR3bEJxc2JyWUh0RzdOMzFCRHNQbWxMWDFvcTY3aUhhalZXTlV6?=
 =?utf-8?B?QlJPN01sVkoyTGlnUXNsMW9oQXZ5NkovTVpzOE1iR2huSG4zSE15Y0NUWUpy?=
 =?utf-8?B?TUt0TEM4QWVNNGw0aVVJZFN5OVNXRWhGMGlNWTNTejFBYjVGR1h4alFRSTBL?=
 =?utf-8?B?d1I5YzBWMGhwUG9JSUxncE1oRmVjWmhxMUlES3cxQWhjZ1U5Y0dtdkNJVmVi?=
 =?utf-8?B?WVBiY2l6aFY3ZnF0MFVFdFZIRGZ5WEdNVi9WUFAzSVhPam5aNnp5YkZRTlBE?=
 =?utf-8?B?TkVLc2FDSUV6TWFNRTJDd1FTcDlyYXNrK0FUc0E3UkJ4ck16b09KS1lTZzVr?=
 =?utf-8?B?SjlyanFVYkFCT3h2QlRFV0ozUUVmV01QMnVxSFVmUkwzejMybERGTXQzaDBO?=
 =?utf-8?B?M3FMUUlIczM2Y1dJd2pGRW5Qb1FOTERPY2NWb29KZ1l3VWphRG9wTjdUNm9Q?=
 =?utf-8?B?VUZEeWR2T05FeEtVcWRmSVdpaVdVUVlNMzFVREVZaHhrY3JTZmhOc3M1aFBO?=
 =?utf-8?B?eGFmZ0FzaStWanJvNFR3MzdHSkNLMjR6ZU92Yjl6b3hCZXhhZ1VtbnN6Vklx?=
 =?utf-8?B?OFVZdHhSTkJ5Mm5ocDF4OWZGQnlabzgxWEQrZ3JDUkdNdTdxRlRpZnhrSWRI?=
 =?utf-8?B?NGZUZEk1SjRIQWFJL3ZEU3MwNEFXVzk2djE2MVJybTBmaWd2S2lRQnBDcmlj?=
 =?utf-8?B?VXhTbWJ0U1hzWDdEYnU0eVlYa2lmYnNqUzB2aEx1dG5VckNtQm9HWExPaFNH?=
 =?utf-8?B?Q1MxU1dBc1RvL1MxRTlnLzhhb1dkTjRpQzJydmxlcERTZG9pdFd3RHVZa3RB?=
 =?utf-8?B?YzJnYktYSS9HbGVzYzZneXEwTWpBMjNIUlprLzZLU3JUbzZwZlNGVDNWcGVE?=
 =?utf-8?B?K3NWTzF4Nkczb0pLaGFBMDZPNHVYMXd1VU9zblB2VEx0ZGR4YTRsSGxrYzVW?=
 =?utf-8?B?ZVpNSTBiUGZHaFhqVmd1aEg2WE9FazhsWGkreENLSXUwdzZtTzBqcjJEbVE3?=
 =?utf-8?B?VHZwQmpweUZPR3h5bXZCVTB1R3RRU3Q1dHZtdnVoWVZMT1I2U3B6cm9hVVB5?=
 =?utf-8?B?SnB5M3BQTHAwMFNFV0FVZjJ2VlAxSHlpRGlGNTV0TjlrM05nWGpsNElKMjdy?=
 =?utf-8?B?aVlkU1pkRlkxcW44TG82Rmd1b21kL1UrV0FkSG1Uc2x3dGZiV2ZESUZBbGNm?=
 =?utf-8?B?TmZ5dXUrVmRHS2F1dlFNcU51Snc4Nkd6VFNVdG1wa3ZhUFozRUtoZVVTS0Vx?=
 =?utf-8?B?MDFjekRRUGswUElpc3FNZDR5NVBZQ1VmQWhSdjE4djdPVmJYREJCRVB5MWph?=
 =?utf-8?B?T2lRRkdpQ094NEZtd1loTFlQLytKWTZPajdNMTFSUXBOVnhKYnQ1SElhN3Z1?=
 =?utf-8?B?dCs3U0llZmFlKyt3a012aEQ4dVVBdmNxaWROT2c0QURnY2pVMldTb1hSUWty?=
 =?utf-8?B?Mk1PVHNlUFhicFN1bU4zRmJtVlMwREJ4eTR4dVk2WWRyL0NIeHNsZDNjTERP?=
 =?utf-8?B?M004RkdlekY3UktmNXZiamlwbDFVMG1tdkJZV1VlNWk5Y0x5VWM0NThtcmhX?=
 =?utf-8?B?dDZOa2hUMlc1cUxJdVJ2bVlhbXVuYy8wR3JBSkVjRVdGTHJEQ1FjQkpOSzhK?=
 =?utf-8?B?T2VJRWF3NGpDNTErNTdrN3pWRUUrOUo1MVkrQmR3cGdCN25reHM4aEFjaGxH?=
 =?utf-8?B?QjZHTmFjQTA2NWJBYWw2SFNFVmR2UzlSSTlVc29tZnNIcW9uR013ZGlLdXJL?=
 =?utf-8?B?RDV4clB6Z3dRdVVVbFVvdE5TQ2FLNk8rMXdJcTRhb1hKQU9CbjMxck5XM25x?=
 =?utf-8?B?SE5Nd0VSbXNiMXduZUNweUtzZzhmNjh0c0pCWU9sNG9QWEQ0TGdIVWN6TTl5?=
 =?utf-8?B?TzFYN3ExV3hjYkpPL3RvbzJueHZRUEFhbS95cVBJV2pHMGVoQ0hWN1M2OERs?=
 =?utf-8?B?ZkFTKzFIbnBCS2NQR1ovUWRXVC9ZYVA5TktEcU5GNEdXdVVoTERmWVNrd3l0?=
 =?utf-8?B?UjFnbE1CRElvdkg5NUltOUdNbXlBYlBadUtLTFE2SDNQWjloSVNsVVkvZysr?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62864055-2c22-45b9-4e01-08db18279873
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2023 18:30:54.5104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rsC611aaOyx4wzMmWSYbGOiP5DGDPjgy8u9rlsBTJduUSOa4gu9I6AMR2dNam9AU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR15MB5738
X-Proofpoint-GUID: _Y6iVhaxu9O0abc0THzCRX1riKcpCNmV
X-Proofpoint-ORIG-GUID: _Y6iVhaxu9O0abc0THzCRX1riKcpCNmV
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_17,2023-02-24_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Over the past, there are some discussions to extend bpf
instruction ISA to accommodate some new use cases or
fix some potential issues. These new instructions will
be included in new cpu flavor -mcpu=v4.

The following are the proposal to add new instructions in 6
different categories. The proposal is a little bit rough.
You can find bpf insn background information in
Documentation/bpf/instruction-set.rst. Compared to previous
proposal (v1) in
 
https://lore.kernel.org/bpf/01515302-c37d-2ee5-c950-2f556a4caad0@meta.com/
there are two changes:
   . for sign extend load, removing alu32_mode differentiator
     since alu32_mode is only a compiler asm syntax mechanism in
     this case, and not involved in insn encoding.
   . for sign extend mov, there is no support for sign extend
     moving an imm to a register.

The corresponding llvm implementation is at
     https://reviews.llvm.org/D144829

The following is the proposal details.

SDIV/SMOD (signed div and mod)
==============================

bpf already has unsigned DIV and MOD. They are encoded as

    insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
    DIV  0x3          0/1           BPF_ALU/BPF_ALU64        0
    MOD  0x9          0/1           BPF_ALU/BPF_ALU64        0

The current 'code' field only has two value left, 0xe and 0xf.
gcc used these two values (0xe and 0xf) for SDIV and SMOD.
But using these two values takes up all 'code' space and makes
future extension hard.

Here, I propose to encode SDIV/SMOD like below:

    insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
    DIV  0x3          0/1           BPF_ALU/BPF_ALU64        1
    MOD  0x9          0/1           BPF_ALU/BPF_ALU64        1

Basically, we reuse the same 'code' value but changing 'off' from 0 to 1
to indicate signed div/mod.

Sign extend load
================

Currently llvm generated normal load instructions are encoded like below.

    mode(3 bits)      size(2 bits)    instruction class(3 bits)
    BPF_MEM (0x3)     8/16/32/64      BPF_LDX

For mode, existing used values are 0x0, 0x1, 0x2, 0x3, 0x6.
The proposal is to use mod value 0x4 to encode sign extend loads.

    mode(3 bits)      size(2 bits)    instruction class(3 bits)
    BPF_SMEM (0x4)    8/16/32         BPF_LDX

Sign extend register mov
========================

Current BPF_MOV insn is encoded as
    insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
    MOV  0xb          0/1           BPF_ALU/BPF_ALU64        0

Let us support sign extended move insn as defined below:

    insn code(4 bits) source(1 bit) instruction class(3 bit) off(16 bits)
    MOVS 0xb          1             BPF_ALU                  8/16
    MOVS 0xb          1             BPF_ALU64                8/16/32

In the above sign extended mov instruction, 'off' represents the 'size'.
For example, if BPF_ALU class, and 'off' is 8, which means sign
extend a 8-bit value (in register) to a 32-bit value. If BPF_ALU64 class,
the same 8-bit value will sign extend to a 64-bit value.

32-bit JA
=========

Currently, the whole range of operations with BPF_JMP32/BPF_JMP insn are
implemented like below

    ========  =====  =========================  ============
    code      value  description                notes
    ========  =====  =========================  ============
    BPF_JA    0x00   PC += off                  BPF_JMP only
    BPF_JEQ   0x10   PC += off if dst == src
    BPF_JGT   0x20   PC += off if dst > src     unsigned
    BPF_JGE   0x30   PC += off if dst >= src    unsigned
    BPF_JSET  0x40   PC += off if dst & src
    BPF_JNE   0x50   PC += off if dst != src
    BPF_JSGT  0x60   PC += off if dst > src     signed
    BPF_JSGE  0x70   PC += off if dst >= src    signed
    BPF_CALL  0x80   function call
    BPF_EXIT  0x90   function / program return  BPF_JMP only
    BPF_JLT   0xa0   PC += off if dst < src     unsigned
    BPF_JLE   0xb0   PC += off if dst <= src    unsigned
    BPF_JSLT  0xc0   PC += off if dst < src     signed
    BPF_JSLE  0xd0   PC += off if dst <= src    signed
    ========  =====  =========================  ============

Here the 'off' is 16 bit so the range of jump is [-32768, 32767].
In rare cases, people may have large programs or have loops fully unrolled.
This may cause some jump offset beyond the above range. In current
llvm implementation, wrong code (after truncation) will be generated in
earlier llvm or a fatal error will be generated for recent llvm.

To fix this issue, the following new insn is proposed

    ========  =====  =========================  ============
    code      value  description                notes
    ========  =====  =========================  ============
    BPF_JA    0x00   PC += imm                  BPF_JMP32 only

The way, the jump offset range become [-2^31, 2^31 - 1].

For other jump instructions, e.g., BPF_JEQ, with a jmp offset
beyond [-32768, 32767]. It can be simulated with BPF_JEQ with
a short range followed by a BPF_JA.

bswap16/32/64
=============

Currently, llvm does not generate bswap16/32/64 properly.
Rather it generates be16/32/64 and le16/32/64 instructions based on
endianness of the current bpf target in compilation.
The existing encode looks below:

    bpf target     insn code source insn_class imm
    big endian     LE   0xd  LE(0)  BPF_ALU    16/32/64
    little endian  BE   0xd  BE(1)  BPF_ALU    16/32/64

LE insn will do swap if the running target is big endian.
BE insn will do swap if the running target is little endian.
See kernel/bpf/core.c for details.

The new bswap instruction will have the following encoding:
    insn   code source insn_class imm
    BSWAP  0xd  0      BPF_ALU64  16/32/64

The BSWAP insn will be swap unconditionally.

ST
==

The kernel has already supported BPF_ST insn like below,

    mode(3 bits)      size(2 bits)    instruction class(3 bits)
    BPF_MEM (0x3)     8/16/32/64      BPF_ST

The semantics is:
    *(size *) (dst_reg + off) = imm32
LLVM just needs to implement this instruction under -mcpu=v4. looks
like gcc can already generate this instruction.
