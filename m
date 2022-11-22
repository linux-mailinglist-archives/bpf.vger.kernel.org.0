Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651136334CE
	for <lists+bpf@lfdr.de>; Tue, 22 Nov 2022 06:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKVFsz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 00:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiKVFsy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 00:48:54 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35D324F2F
        for <bpf@vger.kernel.org>; Mon, 21 Nov 2022 21:48:53 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ALMeuYj011543;
        Mon, 21 Nov 2022 21:48:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=yLtqNAgmmuufmQiwUoytrgfFFxELKydvwmkHr9YCAl0=;
 b=bL8Pb8TU9sbWgLRFkpAjKUt7Tk0iTP15ph7HjAjnRTIOqBXy8Mcdq2o23ByeVxBphDHr
 ConUnZ+LBfan2Ut2CEk5x4ezSIapn4jO+LNFCG4QBM5oknfhHxkzJgl4+Y675Ks8FVjb
 7dJtckT55WW31iX66yHWZsvmEiIDpCWsHGaufTDVkfU696iT58zheUYmJJduuroqFA5G
 vHM66WkNrxtT0ZTpOPCaUynCCmtDQH/ng2xMpG/jrmZSKAwawqSCuraJWJJ5OVvAEZGE
 1NB0QBRIoeTOSWG0dmF9zDQ1Kih3YKRzzNawEstFQNMGn6I1w18Cl3aoDqGURDT4583q cw== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m0jav9yu8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Nov 2022 21:48:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7kfdiVYKuMEwujs/UIEtwQ96V9HqdmmL2J5iQ6ftJPEwukbUrqze5BNmRnzf9O2Y03BRGPJcYngLmI1OEQhQ3iWeNoDhndV9ULzGbT7CwScOW5q6GMaED5iX/zUtiRck2q2yadGtIUdhEzSCOw9kD7XOCrhrSvGgdn1m422/C4eXoeZ0fWxO8bbvEg7+BBukaZCanusMCj7x/cRKAHke04OhSTd1tNpQ2k7PCie9Sf+aZtVP31aH3HzhhIAhABbksEkMtjsloxqDWQ3YDtmmidARbwQuHhPsOTYQW3SgA3HCUPHHHFGF99Qz/83qwF1ZeBMXY7fxC8FzkbCWpbZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLtqNAgmmuufmQiwUoytrgfFFxELKydvwmkHr9YCAl0=;
 b=HqtzzryEKY5nzpuHcavNGcfswme+oLK5zzwq35od5SAGLi9K30oF4XUUmPgMHcxRZ0mLFw9zYYgUqK7hnsZlq4RgpDpTi+nMo29H9xti4lh3z01Z9i5xV1xpDoUQJs/btvSXEXBeoC94lUlpNl03q3ao6ux27KEEltvB7zwKCAIFt8mHxkpeyhyshsZEXAUQ7YX/Mrxz/U1j2NjHN72nRK3Biiz2aj3gur0djlFo9yPrfh0ve0t9qVxENB7FdeMgv3rn+oRV/KSvjP38R0fmOGtYK5wOXE1QsLGp+4IpMLDLCD9Y95UnYLr8zF+oF5K0VvaTtOrg7OiECJVt+Nrmog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by DM6PR15MB4122.namprd15.prod.outlook.com (2603:10b6:5:be::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Tue, 22 Nov
 2022 05:48:37 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::6faf:531e:6c19:d223]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::6faf:531e:6c19:d223%4]) with mapi id 15.20.5834.015; Tue, 22 Nov 2022
 05:48:36 +0000
Message-ID: <5f66b636-66a0-5ad6-c83f-09cfc1b020c0@meta.com>
Date:   Mon, 21 Nov 2022 21:48:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v7 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221121170515.1193967-1-yhs@fb.com>
 <20221121170530.1196341-1-yhs@fb.com>
From:   Alexei Starovoitov <ast@meta.com>
In-Reply-To: <20221121170530.1196341-1-yhs@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0358.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::33) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|DM6PR15MB4122:EE_
X-MS-Office365-Filtering-Correlation-Id: c45bc45f-7f24-40a0-ec8a-08dacc4d32f6
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cU2vDx9/UaI2GPPUBnMG9MZNEAh21eQOceE75//Z4uEdmOoo0QgcrS9csTfMbCrzeWAaJzAT+v737JTVyL5GK9o6wAX4oYn2npmp8e+9v6tiC2X6ZJZh/LGbVb4JGlCit/7GVwlzCVcDw0CXmsME91uTB4/H0sIDb6YHKOJVLAMcAQc4aTCmd2QMqnLn4gmtnk+3sPsS+Xw7Iwn2LD5+cd89YGimZjDTzPebH1RBR/1TUGJiCmIG4U9Ts4UnWID+lZTwaIviKX99hvg+DBJVlItzeexrYlWzQdu9lO4pE0F+UZC3PZBTlQ9eTwCU6LBkQhjk/bgo73VrBjlulLRVrEiBB2BCEcY8ygViv4d6IB5l3la1ns7o1ti6OoMfRBg7yKHxlFTknTSJFdSBhFBCf1VFsfuccV9S9+2iQKWBAvbQJQNosfbf0DbCghWN7seT07e4Z79+sXb3b93cRS2GFxppxY5H3HeEa9NyjC6VLBBbQQx9rGFV+xo0aeEkrGXNZiXOOooTiKgp0YmxxO9xLGg071TNcVbzR6XW3654AI5PfJWooGn+xqMHAEtEXW79N+RRHZDm7ZOW0xr6iFbcwPMbJq1OZZ9rY6M9xn1qc4a3JVziiAq7R17IT2nJ7B8mNCFzDGHhyYmJP0Jnj5ibItoaoWBY6wv/nGb2wXLpNNHlnKOkQJW1eYWwC4AMT1hEUSHzWo/VhXyPC/q5nMURVBnmXTenmi8BoSr21BgVrVw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199015)(83380400001)(6506007)(186003)(36756003)(6512007)(2616005)(86362001)(53546011)(38100700002)(31696002)(66476007)(66556008)(8676002)(5660300002)(8936002)(4326008)(66946007)(31686004)(2906002)(4744005)(6486002)(41300700001)(54906003)(478600001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MzlrMEcyNDNjbW1HcnFVVzlLV3FqbzEzUjVkTFozbVM1SkdVRXJSbTJiRkJ3?=
 =?utf-8?B?TklpVU9yN1FqQ3d3R3krL0ZIbG1vdzZJOGhnUE1rU1FDd3p3NWxOeTJkK2hK?=
 =?utf-8?B?eStWeUpHQit6Ylg3ZytzdkpYOGFPZjdmNXdraU9hdCs4YlZVditqTVViVUdD?=
 =?utf-8?B?VnYrOEg4aXkyRm81dkVGTjlsVDNUeWVCUFBGd01PWG1xSnl3a2Q0V0FSZktm?=
 =?utf-8?B?VE5uRktvdm05cDFqeWFuOXhtRkV4eDE0MW1hU1VBT2I2a3NvT1c2bDVBNGtH?=
 =?utf-8?B?QzNoSDIwbHQ5VmtWRCtzeURReEcyNzQrZjRpelRPVGpNWW0rOCs2QVRuK0lB?=
 =?utf-8?B?cjRiMmcwZUJUaHZwTU1iS2QzV3VqY1J4QUsyYXpnK3lTWFdXenB3QzVGNXVr?=
 =?utf-8?B?MXplTDRGSjlvL01vVXRmanUwMTFKNk8yM1Fyeng4YzBDeEUzMEw2T0hXUmlX?=
 =?utf-8?B?L0tzSVBnTWsxV0tkeTNSblFvSnZxYmFvU1oyN0RXdGhFdnd4T255ZytKbXRw?=
 =?utf-8?B?U1RGdHlyUG9UdlJOdE1CRkJLdUpQNVAxcTNuWG1jNUw3TVNwY2wxbUttcG9Z?=
 =?utf-8?B?d1NaNzdBMHlvWE1iV1E1SDFYcW0zYTdSdHhoMGFJbEVBdlVUZStSM24zMDNF?=
 =?utf-8?B?eDFUanFqUXdvSDZnQU9KTWJ0akhUR3RrSVVxeWt3Ry9OZFU4SFNXTXRqc3Vs?=
 =?utf-8?B?QW9DSFIyYmIxcjA1QjIwUkFtMGc3My9EZnVzK0RieDRpcFBZc1F1aytPWG5t?=
 =?utf-8?B?U3lkOEg0NVRiTCtsa2o3NElleXFWSVFob2pVMGZiM2FPYU1tK0cvSWEzVXZm?=
 =?utf-8?B?R0FtSGg0RENGY2toZXVuR1g3dUR3Zk8zVE0zeXJVamw2TE9nOEhiU1lkUGcr?=
 =?utf-8?B?aFduMy8rTlBsZUF3NExTTzJLUGU5aklPbFJ5cTZFYTU3WlMvUmlRbmhBTk1w?=
 =?utf-8?B?SjFTeW40c3pIVU83NDM1TmhQL3ZFb1RWTzBqN000d0xxendSTXVkWWdJTENn?=
 =?utf-8?B?YmI1SHQ4YmlkMUpzSFJ4Ukcrek1LczljYWFSUFM5RHJFdGxSamFTY2tXNXVY?=
 =?utf-8?B?MGtiZW9nRTNjc3JvMkJaaXE5T3loYmdqdmljV092QndVY0JOZDFPSC9nRW0w?=
 =?utf-8?B?WG5QVitlVktyRHJjTzgyYlBRUlByRi9jZThkV2liVjlXZVJnRE1FVmNocHp5?=
 =?utf-8?B?b0ZiQVZHbzg4ZUozY1cvOGRYQkR5cU5YVE1PcnRZMnlHWGc2T29MV2wzOUlL?=
 =?utf-8?B?djVkanNJRnptUHcxa0VxUFhFVU5JUTZVNi9MY0dhZWovT3dYa28yWVlLSHdK?=
 =?utf-8?B?bXl3L1Z1Zk5Mb1VVaEpjdDdzVkxMNlFQbkdMTmFyVTQwY0M0ZVZKVmRkTUhC?=
 =?utf-8?B?eGdtY0hkZS8vZTVNRGhISnVNN3pDUkVHNWQwTGpSWGVWamE2K2N6YXROV1NP?=
 =?utf-8?B?WjAxR1NVSFNCZ25sZ0dmenRYNGg0YmNUWk5WZVFFdWsyb1FudS9RejNsMlBi?=
 =?utf-8?B?U0ZRNmxFUXBEakZ1UW15Z2RObXpwUmVHRmlzNm1mYTJWbllRK0d3RHd6Umxm?=
 =?utf-8?B?YURDaStTUms3S1hobll6SXhlTnpuenJlY1E2SjV6Q2dRSjRicXY5V3YvTWdB?=
 =?utf-8?B?bFZSckUycXVQaFRSQ3ZQbFJrdW1wZzI1RmVNMElTZWhNKzNlT1VmZ1BxUm1R?=
 =?utf-8?B?QXBuVE5nZlRzOGc2blV5b0VjOU5Wb1hCbm9HTTBOSkdXTittSWc4VEJKN2Vr?=
 =?utf-8?B?UXNBRVJzZUloTzBvR1FYREI0cWs0UGVENW85MTN3NVZMMHF2RVVTUFhYMDhx?=
 =?utf-8?B?MzB5dzVWbjRNSDR4dy9WZW1YTGx3VzJKMnU1UlBFODBueXl1YWlhZ3gyZGU4?=
 =?utf-8?B?YnIxMytjWU1WR09PTzZtd2xBdytwbi8rRFN6UzhpUjExWEd6WWNQbC90SlBK?=
 =?utf-8?B?K2MxWjlvRmo1SnViMDV0a1ZlOWRhNmxhVEZoZmhFRm40SmRJaytoWVZJWG0z?=
 =?utf-8?B?VjJ0MjB2ak96UVI2b2E0VmQ2WW5lcmJxUVdNMWR4ZDhpMWtTeHRwazlNSzNq?=
 =?utf-8?B?ZE9kVWxFM0xUSjhhdmVGVk1lMU9DSGtITUxjbXJaL3FsODhsYjRjK2wxQ2dv?=
 =?utf-8?B?QUhTcytzN285d2lVdHNpLzlvMFhlbE9kcVVNQ0ZPQ01KZ1RBdUttOXNkWnZM?=
 =?utf-8?B?bFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c45bc45f-7f24-40a0-ec8a-08dacc4d32f6
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2022 05:48:36.7968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IaCe0flAonuJQbTR8x+xfbwMX/xfjTwzQGbetvKx0DDfe2F75d5nbECez5+XPfp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB4122
X-Proofpoint-ORIG-GUID: cAq751k3H4a8KgASu1zepNErIRn0BaOX
X-Proofpoint-GUID: cAq751k3H4a8KgASu1zepNErIRn0BaOX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_02,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/21/22 9:05 AM, Yonghong Song wrote:
> +	if (env->cur_state->active_rcu_lock) {
> +		if (bpf_lsm_sleepable_func_proto(func_id) ||
> +		    bpf_tracing_sleepable_func_proto(func_id)) {
> +			verbose(env, "sleepable helper %s#%din rcu_read_lock region\n",
> +				func_id_name(func_id), func_id);
> +			return -EINVAL;
> +		}
> +

Even after patch 2 refactoring the above bit is still quite fragile.
Ex: bpf_d_path is not included, but it should be.

How about we add 'bool might_sleep' to bpf_func_proto and mark existing
5 functions with it and refactor patch 2 differently.
We won't be doing prog->aux->sleepable ? in bpf_tracing_func_proto() 
anymore.
Those cbs will be returning func_proto-s,
but the verifier later will check might_sleep flag.

