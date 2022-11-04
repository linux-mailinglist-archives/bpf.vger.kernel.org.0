Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2718619186
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 08:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbiKDHEM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 03:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiKDHEL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 03:04:11 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E226AEB
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 00:04:08 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3NTgam014052;
        Fri, 4 Nov 2022 00:03:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=jxD1qFqFNPt1gOQ/JzfRa7qINWGtBoe21MHIitYQGW0=;
 b=OjxhdI6lXikv+JcKe9NN7gWVoCHt09BncKfrEpf1wGLP6WqN/Hij1nmLX+wVvartLbkC
 ADDoI9JgywPi3gUOJiDtd+A0RLJ3kMzGZARvf3AWy/swzEo4AmDjWm4lM3NCjoOlYHVV
 zQAo4T4UNLMvenKbuYQXmbMtZUaEwLUCOD1WVfrcqRE+sZDewlmmOOxfgu0e/YmFb2tL
 QzFMRaaUZ6uOunWWGu7a8FmqeGjOFLmoMv1flmy/xP9dLrSteyhaBr2O54ZX85/70M3K
 7j6fz5VZsbvX6yXqGTWis7LA5+6ol41Y2y+ZO2kT7+eIpaEgEctkPlngHRLGkxh/o5DV TA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmqbnapfd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 00:03:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=celIm10+pM2i7CChPaFImZULPwiiUTv06IreiyX59S3/IwbF9WM0Sa64FZA2s4qub7ezH9uSVzovhDqA6FT+ndTq/lPjPOTRpc5f88b5Atjcp31IVgcHXPkSjVVjCn/+Qeb2XrZlb2BbknRIjFeBHuvr2Aei1k10RW6b3lZl268P5VVBCTOPebpLASW1bZukeWHxNPqeb4mCeBRS7Qhtx2HB+NzEarhrpH1uqpZ98EDzaTTCzvlpJKEwj/AH/zl7JDqrVulADRzhYXFnEHMaoouhvO4v0NkxYGzPye0aNvZRvVPGT3k2udezhcqtiI97RTbEPpzUfLhemMZ5O98oRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxD1qFqFNPt1gOQ/JzfRa7qINWGtBoe21MHIitYQGW0=;
 b=TX45cwKKNdH5hDuciq6Be/qnfZtiJ/GCKGoshZIm+XLA8ThooZXnzhk1q50G+RA3Qz706fiQaZxN0hBPNAh6LxLaAIpBEuyp+LeV0rjNqbH0ubJqIT3x7VD9gPEc3wQvED9+X9Br9moqi088YrPFIyI741Kar0NhvAH21bYJuBLZgaCRM13ov7VtQODGquSYMQ9Ury/Zp4YJHi+KeYC19ikycF2luTCEii4HV43J9qnCAnGkku09HuH2gWDsbSfaAH5CC+g+4uxpFavPdvcCS/7S7BnmT9bD6qq2/Qz0Bl13FN3ezCgvIN0gEcH8W5WNnuya0oqvTRXWCKiWzV0rZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by DM5PR15MB1514.namprd15.prod.outlook.com (2603:10b6:3:d3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 07:03:52 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be%6]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 07:03:52 +0000
Message-ID: <0e1ab4b0-422d-f8b4-4673-d1239e2a0794@meta.com>
Date:   Fri, 4 Nov 2022 03:03:46 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v4 24/24] selftests/bpf: Add BPF linked list API
 tests
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-25-memxor@gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221103191013.1236066-25-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0039.prod.exchangelabs.com (2603:10b6:a03:94::16)
 To DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|DM5PR15MB1514:EE_
X-MS-Office365-Filtering-Correlation-Id: dd24a3cc-8a30-4c10-7d4f-08dabe32bae0
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuwxgpD1P0eles5c1cvV14g0V76jYg7kbRGaRKx/vURrS+GK16lAWrcqmxk+vKfyoSwkb6mhKUucSF9tcI1ihUq2boGwnPrBNIfVUgL5h7K/YA3kR3sm/gXhs4SuUPWb+1zwv6Bz0CEntu/VIotoDeULAdhyEGwMTmuKFcJ9NYjL6gz8QxuKgLwsu3MSzHqg+1p6KQl4y0zc+G96pkMQbYlGSI4XxkP414FIkNdNdXOoVf7aEZg/MtfFPyfy6+qPnVlc95VwzcKa4gSocJ8akJJQDdMdKxCI+aF8VZz3IyAH3a5430n4ATO0/k08uDFv/SQzpn4c6QsPxsCPVpU4GcRuwIZLUGQtcah3+XVIPWY+WvbQwmhBz4rzcri3zsDyZkMbHENu5ZKDWj5DCyLySQEY1DUaivce+yQQYp55c6i3R3FF3MZLt8w5kCmjWF1aD4yYh24ly9wrSYKQl7NStq+P+3BZeJ22kXSpED9dFkElDHltfTvsuweBHuy6l7o7N6CEm4byFnGTsIP8WwWBWS4zVbwCyPCQYHvpLm2GdLzifo4d7dbo4MdSlNQE0Dg4g3XiZjgcJhIxRQ7oVmjxxWrR2Y9eKgpnEOECBEuWum6gH77OdIp7YK2yipXtrx/ApHbVRpYTWhgkNMCY4k+MWZz3LPURvsMOmwmMa14sbiyttiFFMld0a31GuhMo1jXJyav/3oYXkPNNw3H0bit2ZQDqP3XGNQYbq7atPORNhwvkoP8hPfnjzbvB3S0P+9y1zabNwBMsSdNPvja30E2rSnSdrtP5ncyV1mNlniShgOl6ON5TuxZM6/Bc5EA7GGBp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(451199015)(84970400001)(36756003)(6506007)(54906003)(31696002)(38100700002)(66556008)(2906002)(107886003)(5660300002)(6666004)(6486002)(66476007)(8676002)(66946007)(316002)(4326008)(41300700001)(2616005)(86362001)(8936002)(478600001)(31686004)(53546011)(6512007)(186003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUlqcDA4a21yQkdvODBBSm50ajVuWTBoOGs3SEViZUFIcllsUjZVeDB3RkZj?=
 =?utf-8?B?UGFydDNla2FZYTZ6TVNaSkNTd1ZNdzgyMlZkK0tVb28xbnYrT0NwSENKM0tS?=
 =?utf-8?B?MnA4SU5VMjUxT2ZuTks5NWo2Z2pBV0hYTW96aVA5TEo0R09FdW83eUxQM0VK?=
 =?utf-8?B?Zzd3RTFhVVBORjBJRGFEWTlFbGNkYjE2Q3BlK09hQ0MrRkhxNmFWVU5QbzN3?=
 =?utf-8?B?R1FpbUhwRmVKSlU0S04wWnFYdm5aeUJVNHJoanRqRlEvakxTMS9rajFNOThM?=
 =?utf-8?B?VGJEeTZvU2picFhsU0I4MzFNeFROMklqejNZTnVTZVJreEFMR0JMWnlxMTly?=
 =?utf-8?B?WEpsS2hseUJpTkRIWExVc0d0WXhSajU4Z0ltT0VCWGlpbDYvWERXZXNKcnBk?=
 =?utf-8?B?T2lpRHpVbkhNQWNOZ2hYU2RzTERKaGxSM2dBdWIzK1ViZ24rV0lKTUxBWGo3?=
 =?utf-8?B?UEhlQmE1VTg1SCsvRUEwclZnUHZFZkJKdHR6M0p2T0dyY1pEdlFwRUo2dnVv?=
 =?utf-8?B?cWJpd3JoWm9XalFEd1ZXOFU1SHpWRGU2bFE4QnMrUjE3Q2dPeWRHL0ZkT2J6?=
 =?utf-8?B?SHV0bXYyRFEvdEsxc2hBMDAxdWxySUgyL0ZnNU1Mam9ld3ppMEpQaDQ0cVkw?=
 =?utf-8?B?SzdoeTNlMkpsNDJVTjd4UHo1bWpWeXI5WUZDc09SeUxmWlBUZStwdWFEZ3dR?=
 =?utf-8?B?clVtVklmd082Zk80bUhTalpwT29SOEtJVVlYSHJIOE1LczVWMWZjS0gwYlRK?=
 =?utf-8?B?dkx6dzZaSThEazRPc3BIUWJtUW5DV3pYYVZrZWhITXJOc0NxSExWN3IxSU95?=
 =?utf-8?B?RWU1VHdMYUlCTUxldzQ5MDRWOXlnNVhjM0NSRFJKVUxQQkRGVklRdDBJc1Zs?=
 =?utf-8?B?aFVlNTlzeDlNbkc4a3cwY0QwSUphR2hJU1lKenUyVFF0WTlaQkM0a21raFJC?=
 =?utf-8?B?dmk5K2UrcVVyR2JmdTFHQTBRL1preHM2STFOMUVpTkJOQVNGYjViNWNnbnZ1?=
 =?utf-8?B?MjFoYTZ0YmRNTzk5L3J0OEg0YVJWRE5GeENUSytXUXFVTVBGT0UyZHltNDRQ?=
 =?utf-8?B?Q1dFZEp1cFN2YjhkdklITTJaY2V5UDZRL0V0MWNBeHlKb1IwNUV0OTJyU2lh?=
 =?utf-8?B?YW9iMXBiYlhXbmx2cnNIOEtFU1dMM2Mva2tqY2pLTjAwVzYyOEdKeW5RYlhp?=
 =?utf-8?B?bWpZR3hDSWRVak1PZnpmWTBEMVpYa29GU3dQck9SSWpPQk8rTGYrQ1ZGSi9G?=
 =?utf-8?B?YnNGb0RQU3cxa294bWFYc3B2Wmhyd2tvclVTSGZvZVl0aHhTT2M0VHo0SWlL?=
 =?utf-8?B?ZEZKQnZ2cXdyZjdqVHNHU2FEWkhZZnNaUmsrRTFjbWtmWE10ZWxkdTZyZnhR?=
 =?utf-8?B?QUNpNmVFUytTcldCbVIwSDFzbXNDYll0aWxDOWt1U1RFUDRQQXEvMzloaW9n?=
 =?utf-8?B?S0t0V09QWlRpajM5TVpXRVBDNHJDT1pEMEc4RjhiNnZxS1lKMTgrdC9pc3NE?=
 =?utf-8?B?K1h4YStWQWpaZlJmLytiRExUSHhxZTQydUd6T3dpcEVtUnFnaE1LWVh6UGlq?=
 =?utf-8?B?NFpaT3A1ZXlXQkl2T3U2ZG5yT0FDVnN0cGFFM09IVFp3SlZ2S3laNmtISFNk?=
 =?utf-8?B?NEYvWEtHd0tqUVRGTmQwZWZqWVhxUlpKcFp6VTBnVEZ1U0NBdTc3WUNkZG8y?=
 =?utf-8?B?V2E3T3Q2OGtTRTdSYTA0RktrbG9odHR2Vit0YXNuQWRUcnQxTWkzMVNuTXpi?=
 =?utf-8?B?OGM3NWtpbWlLdmVjNVozVWRWUjNWMFFRSWdLRG9oZ2czZld0YkRzREhqUFVC?=
 =?utf-8?B?MmRKTW9zN3l1VndlUE8ydjdXVUp5V04xb0xNOW9ESTF0Z1FkYVFLdDVKd0Vo?=
 =?utf-8?B?OWVPSllQOHNhN3o3ZVp4bEMrL2ZzdVN1bUhSVUNiQ0luM21ES0RrMkd4QTUz?=
 =?utf-8?B?eE1xaW1VZm5xMGVoNGhkZkFoVkQ4d21oaGdLT05yV3d5YXllYWwxY3gyRXlT?=
 =?utf-8?B?SEcxVm1PczlPalk3YzhsN0haYWo4bUdNVytCcjJjeHpPZDZKY1hVOUZtRGVo?=
 =?utf-8?B?V0orQTE0dlFQVE5BQzNwK0ZTRVZGUEM4b3ZieUpreEVTMWJ2dzhSUHcvOVZn?=
 =?utf-8?B?bDFxWHNLWnV3Z0N6Vzd1Zm84TmJzK0pUa0ZxekN0S3NCTU1LcmtjTnJwMmNM?=
 =?utf-8?Q?myby9lqIV/USw99et3ageIc=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd24a3cc-8a30-4c10-7d4f-08dabe32bae0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 07:03:51.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkH45ccilRtbrXbGye6dMaDGYfGwHRxX2JInZmP9XX3XJCTKKlb/ZK+/iV9PyQNEgH406ByWNKpDconNeozaJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1514
X-Proofpoint-ORIG-GUID: r8rIQkHtGH1JjEsE0uSSZYLWEhbzIuiR
X-Proofpoint-GUID: r8rIQkHtGH1JjEsE0uSSZYLWEhbzIuiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_02,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/3/22 3:10 PM, Kumar Kartikeya Dwivedi wrote:
> Include various tests covering the success and failure cases. Also, run
> the success cases at runtime to verify correctness of linked list
> manipulation routines, in addition to ensuring successful verification.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

[...]

> diff --git a/tools/testing/selftests/bpf/progs/linked_list.c b/tools/testing/selftests/bpf/progs/linked_list.c
> new file mode 100644
> index 000000000000..eed0b2c1eb4a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/linked_list.c
> @@ -0,0 +1,330 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <bpf/bpf_tracing.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_core_read.h>
> +#include "bpf_experimental.h"
> +
> +#ifndef ARRAY_SIZE
> +#define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
> +#endif
> +
> +struct bar {
> +	struct bpf_list_node node;
> +	int data;
> +};
> +
> +struct foo {
> +	struct bpf_list_node node;
> +	struct bpf_list_head head __contains(bar, node);
> +	struct bpf_spin_lock lock;
> +	int data;
> +};
> +
> +struct map_value {
> +	struct bpf_list_head head __contains(foo, node);
> +	struct bpf_spin_lock lock;
> +	int data;
> +};
> +
> +struct array_map {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__type(key, int);
> +	__type(value, struct map_value);
> +	__uint(max_entries, 1);
> +} array_map SEC(".maps");
> +
> +#define private(name) SEC(".data." #name) __hidden __attribute__((aligned(8)))

This __attribute__((aligned(8))) causes my clang to fail to build this selftest.
It fails with:

  fatal error: error in backend: unable to write nop sequence of 4 bytes

Tracked it down to llvm/lib/Target/BPF/MCTargetDesc/BPFAsmBackend.cpp:

  bool BPFAsmBackend::writeNopData(raw_ostream &OS, uint64_t Count,
                                   const MCSubtargetInfo *STI) const {
    if ((Count % 8) != 0)
      return false;

Presumably since ".data.A" section is PROGBITS the compiler tries to write
4 bytes of nop before / between the variables, but fails.

I'm using a clang built off of a very recent LLVM commit [0]. David Vernet
was able to successfully build the selftests with a clang built from
late August's tree, so maybe it's my clang version or some other toolchain
issue. Which clang did you use to build this?

[0]: github.com/llvm/llvm-project/commit/2a827e4a988b614bc6f70abe00308ceeb50dcd0a
