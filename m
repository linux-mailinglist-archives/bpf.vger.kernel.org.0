Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD9763383A4
	for <lists+bpf@lfdr.de>; Fri, 12 Mar 2021 03:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbhCLCeI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Mar 2021 21:34:08 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25482 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230494AbhCLCdi (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 11 Mar 2021 21:33:38 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12C2PjSB030790;
        Thu, 11 Mar 2021 18:33:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=d0G2TnhgGONPmq9Az5zU46KucRD5JSlA0XtzIjMdqRo=;
 b=hg80Y8t53d+4mK73nHdn1MjOZfgubcwna67YgsXMHlkoOGVsJbnRMST7CVGwoj9Plinu
 y5AOh6peJVlxhOcrA4ms/fHaykVquDF/M++jNUzTqKVbHCIU+u4hUMwaiyZBKIW28W46
 SU/1BXq2DXF/yRP55Wx48KBY/hyxcMdyo5o= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 377ms444qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 11 Mar 2021 18:33:36 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 11 Mar 2021 18:33:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql3UVCNcHF3f5SURG0vXeZ8ARLtLdqdB7q3hunDgkLBqyPkfi8C5aiVxG4uPgJRKeF+M2qlCxZL4Hsyy63sbQDBp6laVqc9RYg+tM9FW/j13XICVkeBbAxGpl98qA66ng6xY25J+TWksaQ9rLnd1JJ6XsaBmXAKHuS9ggX6tDAveaoWexgMXWmyEmB8KTTTh3EgbuIhX0O3ohjYRi3YyGsOE57btgWhHuLsDtDoKAMDjo++mQC314ufi574MCkYuZMgoSLaG0oSP999X9LqKHmethdDUpw0Gd/PS6vAV9jPIIzyA64sQVXNEwKdAPbDRKUospmzuiEdTv8BTw10qIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d0G2TnhgGONPmq9Az5zU46KucRD5JSlA0XtzIjMdqRo=;
 b=mlssq3cfgkzmHj9SoPWvH2UvXx2vkanXQogslHgjLlhColRS6RkUhOCbT2i6k7CuhSYRZj+Msn8FjtoHTVki6aBct4GlCI0R8vOdTSUsmJWnsc5chqvW/3ipzzuxGMG6zJISsOcepigQtlsPDMMZPx9Hda8JjucQhfZEz8C4RFCGVwpRdhItfrLeNUx4Jctigasxq3FhIpJUb6l/GVMANz1sPkV/Bb5sA3fAOwfGrm8njHgLsTXayPXYFQrLDXYWAu3Mq2SJXNaI8MubeX/iXIT7i+69xqx2FYTniLVUgrr4vM3yMHIGBoKFMNxPKwvN4mxcQi9JFxKrX9PEyMZBdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2032.namprd15.prod.outlook.com (2603:10b6:805:9::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Fri, 12 Mar
 2021 02:33:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3890.039; Fri, 12 Mar 2021
 02:33:33 +0000
Subject: Re: clang-9 and clang-10 BTF miscompilation
To:     Lorenz Bauer <lmb@cloudflare.com>,
        Andrii Nakryiko <andrii@kernel.org>
CC:     bpf <bpf@vger.kernel.org>
References: <CACAyw9-eYh7sJ_86bS4dDZ52Uf3nY7-=pHhFr42cqXwMj5tmDQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <5e3fc46b-bb84-4a08-8a3a-e910b52b7a7e@fb.com>
Date:   Thu, 11 Mar 2021 18:33:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.0
In-Reply-To: <CACAyw9-eYh7sJ_86bS4dDZ52Uf3nY7-=pHhFr42cqXwMj5tmDQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:298]
X-ClientProxiedBy: MWHPR04CA0060.namprd04.prod.outlook.com
 (2603:10b6:300:6c::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1a81] (2620:10d:c090:400::5:298) by MWHPR04CA0060.namprd04.prod.outlook.com (2603:10b6:300:6c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Fri, 12 Mar 2021 02:33:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92b78781-47b6-4713-fd51-08d8e4ff3ab1
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2032:
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2032FA3DB1A2B7A4A299BD33D36F9@SN6PR1501MB2032.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pB28DnBt+J5lsJzH2nFG1uBfeVgb4DH1+Gnw9JHpbHkBa1ELcnv7RwRQ3gRDiwYy9mqD5OGnhkkdVM4nuabXNJegtsK7IfryZMUCH/2yw2akMklE6E7n74U0bT2gb8Nt2PffRqz7bwfdn2BcmRA2FGriZrXpKJKjOYVyfTZPaSS3D7MaFWPwG8H2GF1FRedpD7IqTBQ8trvojq2UvImQC6o2ad9ea3rjXWtQw8kwa4Hxl/bae0ZepG5c3N3RnLzLIDChnyFQoC/ukZItUru0CCcbyZBA5gmP7flql+Lc4ujZAjxKj4hEJnzFPFNCfeH3wiWqCQ72b6jokf7MKoj+r2he7kBQ2jd3YlyV3q0FAqAiV3VW1K0og0n3ae2MmSBYkFnPcUF99wsy0NGpv7xK43p0a/L+qWDJU8VfvjuqR0JYXRGxTftichdyLzVHwPX9V5vqTBNyYdZcb7U8tE3ncWeq+5jnf7KaQCD388i5ijbSOwKWBqmDYtzM0OP/s+WWexC6HFnfW3vHrahkxvts8XyjejR6jKkqMMc2M1rMWNTfAkhwvS4V3KJ4sBuvGG5mLZeTY6by7jcDocLDwMCtaDL8pEOvINfNmIZsCBvAAf1r72JDejQVKcmd/vjySJD/CiQMg6z/B4j39YxpbIq0wjg44djC2L0fSb4F9wzuEjjtkJ8Atl0+A8RTXNpnWSZb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(376002)(366004)(396003)(346002)(66556008)(2616005)(4326008)(8936002)(66476007)(66946007)(110136005)(52116002)(6666004)(53546011)(31686004)(2906002)(186003)(86362001)(966005)(16526019)(8676002)(478600001)(36756003)(31696002)(5660300002)(316002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q3VES1JaYWpBSEM4TjNwT2FGci9KSHN1N3UyQXE0MEI0eGRpa0JJSzB2cTJJ?=
 =?utf-8?B?Mlo5OUs5ZW0zRE0wRk5ST3dTSG52SzBsMCs5Ylo4WGRkajU5Rjh4d2ZUZmpD?=
 =?utf-8?B?Q0RNanVjUldRM1NqSTF5WWdxL3RRVVVmUjJRZlErdkhhcXBSM2VPUHJObDZp?=
 =?utf-8?B?dFgzb2JxWWNzczdlMmpZVUJ3SFJRTkQ5bnpJa1VoMEJlUkVKR1NzWW80Z1M1?=
 =?utf-8?B?NStFSFpRMVlnbFlZZ2p1R25ic1dNdnY2Rk8yVnlVeGxQdzhZVlF4ZTRJVC91?=
 =?utf-8?B?V1lGa3RKRExOa2RncE9VVjFIaXpKazZ3VkVLaEFWYTJSVXlRSklMM2VsNzVo?=
 =?utf-8?B?dFFDcndPa3BsRDVaSjJaVHBCMjZPRUZnVmx6cExEa2o4SUwvNWtTV2JWcU5O?=
 =?utf-8?B?QkI0U1RYeGlYTGZmcXh5eFBGK1ErT21KQXRUbDh5WDk1aHZiN00xY0lGSW4v?=
 =?utf-8?B?YlovM3F0cUZqbWJ5eUlodmRCeFlnd2NIeGhINVZ2d1NNTFVTSGZQSTV3bTIw?=
 =?utf-8?B?ZTBIa1dPVUpLdTljbG9paXdHZ0FPNGM1bk9ZVzVMRnlReUpHS1l4NncyMVZW?=
 =?utf-8?B?T2lsZ2V0YVR6bU9wL1ZFZEtvTHAwcWoyOEw0SHAvRWZCUUg2NlJJMVhmcVlx?=
 =?utf-8?B?L1pBc3pCbzlkTUxwMVpZY2RaT1FLSnpmc3BzbFBGOGoxZXpHV0R4czFPQnB6?=
 =?utf-8?B?aS81VFFKc0hmYmw4ck9vWkhvUjZhVWtyM0Y0L0t4SEV2d2h5dnRuWWhXQm9E?=
 =?utf-8?B?UGFrQWxkdFZ5dk1Ma0U0UlRJTWN6c2V2YzlxeDloRWpXZTF0QnZubWxUaVR6?=
 =?utf-8?B?TFVnekpqK0xxaVMreExiOVZmMVY3SGk2eTN1VzY5WE44bU9QWG1ZbUxFMXEz?=
 =?utf-8?B?ZWs3bXpBSVkyUTBXWHNJMXVFZUIzQTk4TWxDMnRJWGxMdGhicXBnWTZqb2dy?=
 =?utf-8?B?cmprZUdTUWQyRmMxTmg2ZUJPUTZUa0FIZ0Eyc3JNQ1hCWWcxbmJncVJsTlRk?=
 =?utf-8?B?SU9kQVB4Qk1pVkxReDhXOEZZVTJDUDVsSlhyL28zdldyUDFmc3FNZjV2bFNy?=
 =?utf-8?B?ZU1rNXFvYjlNZkVSSWRPNUw0TnphWDNjUk1mc25kWW9KOHV3bCtXUE9TdG1D?=
 =?utf-8?B?b1VTdTBXZzFXMEkyckdodytYNjZRMTc4aVZNb2FYc1gwaHRheFBobFBQRzg3?=
 =?utf-8?B?eExTVHN2N3g2S3VodUFaMTdpMEJzOFdCM0Z4UnRQNEZKaWN2amF4bHN0MjBk?=
 =?utf-8?B?dVBzUU9OVWcxU0gvRHFQeURrV1p3ZFpPQ25iWDBoQUxPdExSdE9BanI2Z2s0?=
 =?utf-8?B?TG1VVSt0aWIvNVFGYmZqM2c5em5XbHQxdWpNTDV4OHNmcFhaNElodzJFS1RX?=
 =?utf-8?B?Z1piTkZ3ejdoR2hoTVk0VnB2dE4zVHM2WDRWamhhaFdXcW9xSlJ5SnltejI0?=
 =?utf-8?B?WFZnQTBSY1lvWmVZeTBGak1HSERZU0k5TUFmMkhCY2pCR2FGbitlUndPYWZP?=
 =?utf-8?B?YTRwaE53RWlBKzlodkZ3SVFFUXNMaC9aU2VlLysvNk54SGdXWVBYUHBhV3Qv?=
 =?utf-8?B?a3FqWlZUUGZJeGhWYmcrZGVGdXR3ajdWUnA5NHNpdk5CZjExMGZMNUFWckVI?=
 =?utf-8?B?KzBCL1BadG9nLzBMSDRIcHE1Mm04QUVXMzNzbVBzMHlwRlVydVFoZlorVEFV?=
 =?utf-8?B?ejlFbHcyUjlMTk9qMWxROVh1ZFRFR1ZoQmtiYzZZblhSZXBhWFZKaEQ0djIv?=
 =?utf-8?B?VHRBYkJMZ1YrNldKUm1nY3BHcEpRK044cHVWbXBwZkJGcFc1aVhINXhjeERF?=
 =?utf-8?B?Y2RxR2puZTdaQ0x1dzcvUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b78781-47b6-4713-fd51-08d8e4ff3ab1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 02:33:32.8949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TTOf23zU5NphZ4cSIJj1Cqm2EWZ49CcDiShABjAcoRv/1IMwBjZy6OrD0jV+Wis7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2032
X-OriginatorOrg: fb.com
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-11_12:2021-03-10,2021-03-11 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 phishscore=0 mlxscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103120016
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/11/21 3:23 AM, Lorenz Bauer wrote:
> Hi Yonghong, Andrii,
> 
> Given the following C source:
> 
> typedef struct {
>      unsigned char thing[36];
> } foo_t;
> 
> struct {
>      __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
>      __uint(key_size, sizeof(unsigned int));
>      __uint(max_entries, 1);
>      __array(
>          values, struct {
>              __uint(type, BPF_MAP_TYPE_HASH);
>              __uint(max_entries, 1);
>              __type(key, unsigned int);
>              __type(value, foo_t);
>          });
> } btf_map __section(".maps");
> 
> __section("socket") int filter() {
>      unsigned int key = 0;
>      void *value      = bpf_map_lookup_elem(&btf_map, (void *)&key);
>      if (value)
>          return *(int *)value;
>      return 0;
> }
> 
> I get this BTF from clang-9 and clang-10:
> 
> [1] STRUCT '(anon)' size=24 vlen=4
>      'type' type_id=2 bits_offset=0
>      'key_size' type_id=6 bits_offset=64
>      'max_entries' type_id=8 bits_offset=128
>      'values' type_id=16 bits_offset=192
> [2] PTR '(anon)' type_id=4
> [3] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
> [4] ARRAY '(anon)' type_id=3 index_type_id=5 nr_elems=12
> [5] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [6] PTR '(anon)' type_id=7
> [7] ARRAY '(anon)' type_id=3 index_type_id=5 nr_elems=4
> [8] PTR '(anon)' type_id=9
> [9] ARRAY '(anon)' type_id=3 index_type_id=5 nr_elems=1
> [10] PTR '(anon)' type_id=11
> [11] STRUCT '(anon)' size=32 vlen=4
>      'type' type_id=8 bits_offset=0
>      'max_entries' type_id=8 bits_offset=64
>      'key' type_id=12 bits_offset=128
>      'value' type_id=14 bits_offset=192
> [12] PTR '(anon)' type_id=13
> [13] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
> [14] PTR '(anon)' type_id=15
> [15] TYPEDEF 'foo_t' type_id=1

The type does not match with code. foo_t here points a map definition
but the code foo_t is used as a value type.

But anyway, I think you mean map definition type is typedef.
Yes, this is fixed in llvm11 by this patch
https://reviews.llvm.org/D83638.


> [16] ARRAY '(anon)' type_id=10 index_type_id=5 nr_elems=0
> [17] VAR 'btf_map' type_id=1, linkage=global-alloc
> [18] FUNC_PROTO '(anon)' ret_type_id=3 vlen=0
> [19] FUNC 'filter' type_id=18
> [20] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> [21] ARRAY '(anon)' type_id=20 index_type_id=5 nr_elems=4
> [22] VAR '__license' type_id=21, linkage=global-alloc
> [23] DATASEC '.maps' size=0 vlen=1
>      type_id=17 offset=0 size=24
> [24] DATASEC 'license' size=0 vlen=1
>      type_id=22 offset=0 size=4
> 
> Note that [15] TYPEDEF 'foo_t' type_id=1 resolves to type 1, which is a
> BTF map definition. Clang-11 seems to fix this, so maybe you are already aware.
> 
> Best
> Lorenz
> 
