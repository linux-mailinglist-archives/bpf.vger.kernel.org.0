Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35C2F487131
	for <lists+bpf@lfdr.de>; Fri,  7 Jan 2022 04:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345822AbiAGDXJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jan 2022 22:23:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30732 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345061AbiAGDXI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 6 Jan 2022 22:23:08 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2070vD8W026381;
        Thu, 6 Jan 2022 19:22:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=MCB2ossapKhAH+OihxKa+E4Kw6Eck+qzTH51iKPAxAE=;
 b=CQX6cYaShrRuSoknZTdViGUt5fvu0WzfoDOd7phAZ/x5/Rp0ZrzzcSA8m5qtq/MwWPqp
 1PU57PsNLdE9VHeglgx/L7lHWJ//C77vvmGDWMDPT8eBuVmlqNOfH1f1ayL8wkTONrrk
 KaBYiNgolYFemX6EGjG/IoB3zfdISzc/koE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3de4wpu5dx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 06 Jan 2022 19:22:02 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 6 Jan 2022 19:22:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs8FeDwuhtpTc9fvZNOGA6KYCoMxLMBrGOAieAX7Vc7kdVp17R5oqOaYiyl4m2DJ2gFTa2PIu0QfGcn8HUvutdeG687Ik6LLKDFpwsM3fV6aDcZIs6cO7wgfOvxnwenNTfGx30PRzxpsyrxkn6DE2X7bMHIAAm2sLTinSpr9SiZi6h5cFxQlyCwn0LIyixoRdEy16+Lgi4lb4Vs05wTLXMpF7juad/ims2JNSPdRwE6V39HR2O9427v2ANjRSQPiQG5Q35RT1IbnLXPSkGkEn+ZqztRPFCFfiRGbCmhjf/C8zoD+egX27wPj4tO2GWoJhHvH9QXQsMA3y9Qk2cffhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCB2ossapKhAH+OihxKa+E4Kw6Eck+qzTH51iKPAxAE=;
 b=KYaJiccDHtxfT4P03z8yICI2VX4/sOR6mgkPcqrBZNX/mlJd/tCzS7TjtPYNqJstgLCq5ndClnChjb6BpPlBbDOqJknhAeb8mUZLqgtQRoNT7c/nrayyO6Xn2lA8Ny5IMvH4hb4oaePPa7h/StbmZ176/G9DsWMle8y2yr5U0qLTRMuy2mAM4iGuLmWxSenMbUzE4kdxHREci68N/1p97D1kHEh30fBrRr1WgHkNF3vhUXpWugWtUAmmUvKmqD88c7bOyrnvtJ6Xs4737DV3hB4Qh3rZHNIaHeOF0bFJBU0pPtP/lI+B5SZ9wKCGLl8c7sBXVJ2fUgd8RGhBcphlBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4708.namprd15.prod.outlook.com (2603:10b6:806:19f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Fri, 7 Jan
 2022 03:21:59 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ede3:677f:b85c:ac29%4]) with mapi id 15.20.4867.011; Fri, 7 Jan 2022
 03:21:59 +0000
Message-ID: <7597b807-9869-64d2-b4b8-2ca720ac797d@fb.com>
Date:   Thu, 6 Jan 2022 19:21:51 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next v2 2/2] perf: stop using deprecated
 bpf__object_next() API
Content-Language: en-US
To:     Christy Lee <christylee@fb.com>, <andrii@kernel.org>,
        <acme@kernel.org>, <jolsa@redhat.com>
CC:     <christyc.y.lee@gmail.com>, <bpf@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>, <kernel-team@fb.com>,
        <wangnan0@huawei.com>, <bobo.shaobowang@huawei.com>,
        <yuehaibing@huawei.com>
References: <20220106200032.3067127-1-christylee@fb.com>
 <20220106200032.3067127-3-christylee@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220106200032.3067127-3-christylee@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CO2PR04CA0100.namprd04.prod.outlook.com
 (2603:10b6:104:6::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 339be9fb-9993-44e1-bae9-08d9d18cdda7
X-MS-TrafficTypeDiagnostic: SA1PR15MB4708:EE_
X-Microsoft-Antispam-PRVS: <SA1PR15MB4708D9FDEABC62D94F9CEA6BD34D9@SA1PR15MB4708.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hy4z51evztq9F6ZbmG6/N6mWPD8FrKBWOdRW8Kn97eQRYi66GFS2X4ipAz3adxKpgFUa2UOf79WGjAoG29S0pINf9Dd2tmgqIFSxsBV4gwfVSp97fuv/9MRIl+R12llKT18xf6U7ArCJLRfPWJAc5lUIjIg+DBWEBNLvGJ5DftnHkWIP5HV4ZSSn8RUrK9yYpzWeXc/f+J6TcU5FBNsbk0RSZXWezbt4Gat5ziX71muTiTBkmcf+51Uvq32al/+QN+FGPfrjiAGIsMKgzIwrDLfGJMC9OXypJd1z8qxQdH6f+Cn/9hNBlq9Za35D8RjjyX8gUp2Wj7ALK2ToH30QB74GC7IC7t9sTVPCprB5pElRlYLD/eyR/fegEdkbmQlz6WaDEgmwPlGfHc9UoSZF1zZIECEzMR4GotuG9tqCCZuYRYkWdqDkO35bn7usVKnn0uBHCMpYMKIofqlblhMBuEH4ryxTcXUpgmT/BO1Z/B1G6ZHHluC90g1/44dCbyCtS+ELTiLUPcu667EPounMiZtAVC2X14MstGAlFXr77oUMH6sYZT9LHj4+dJRTFswmAPvjacsQ02DD4UiHt10+tOEWoCUgR2HTD9HrjGMOUyUZ3BX/njbhIXsb5LA7WhQewaqOtR8KjFMyHrvWU/BeBrey5DaJOWMMf7mhNwWAOHQ+E1L2WYxP9nmqJ7p07Fn3O9zzLoFwSrrS2hl6jnd0nQaQfoCz8SSRDpcLECJ0TSNmxYgCWh1R5xOS0EbhW5PkSx8+ftdvwKb2y4z0MbvnOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(8936002)(38100700002)(6506007)(6512007)(8676002)(53546011)(66476007)(2616005)(66556008)(186003)(4326008)(5660300002)(6486002)(508600001)(2906002)(86362001)(31696002)(31686004)(66946007)(6666004)(52116002)(36756003)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVNpMFdGUm1KVUlSNGdpUEcvQVY2aEp6cTNnbEd0Y2MzdmFxT2R5d0pNdEFZ?=
 =?utf-8?B?WDBPV1NBMVJqUktoOFlPZmdGTlBOclJEOHRra2pZa0JySklRRkMzcG1XVGxl?=
 =?utf-8?B?V0lOZUkxMlN4SU1KSGdKTWFCcE12aGVBSFdicWpXQXJ0aVJKa0ZHdXAydnBm?=
 =?utf-8?B?ZzgrYTZoc3hLR2hyOUdsUDYzWktWNjg5QVZ5Q1ZzdVNPSmk4aGVGc2VPanMx?=
 =?utf-8?B?THVCdFAwVkJoQkNYR1c3Wm0vYUcrZUxESzJuaHpEWUVEUkZoYlV6SVlpQ2d1?=
 =?utf-8?B?RjZaeWphSk9xc0ZZV3ZIWU5iZlljeW04aUJYd1k4N0pBd0hqVnErc1o0REZW?=
 =?utf-8?B?OVVFYXZJOVlhcGRFOEVnMFp5R29QRnNTZzJNWEhpczNmWU1maURzbTA1QkFl?=
 =?utf-8?B?NTAwRkpaU1RhWVhOek1NMXVUUlJKN3JydUtXTU9SWUNJckJFMEVQTVk1L1Qz?=
 =?utf-8?B?MjJFb0xUQ3VaWFpoT0x6N2VWVU93blMzRGk5Ujlqc3VIc3pVeWlPc3hiUzAv?=
 =?utf-8?B?b1FXK3YvVFpacERLV3V6K2M3U2Qvd0ZGdmh2V2I0U1duQndDa1RKdm02M2hQ?=
 =?utf-8?B?UlNHbkE2TFFnVUNrT2xlR0JxbEdxSEptdGlFbnVUdEVvcEtheVY0dzhhQVl6?=
 =?utf-8?B?WHZLbnh0SDlpdVBNelNROFB6QUdCTXBmMk1rSFRmZkRMMm41cGl0WVlFNzc0?=
 =?utf-8?B?akdValRNL0VrVFJNTFhqK2hDeFNDRW56QXF0WE5LTnkyWGtGOFRiNDhWK1JW?=
 =?utf-8?B?MTU3ZW03SzA1M0tIYTZGRFhaMHIzVm1WbU5ZVDFmWkdSUVRjbm5VZE9ETWFv?=
 =?utf-8?B?SUFwNnRNOVZScEcySkpzQ3V6UWo1ZFh6NzM4UytIck8rVHczU2hmZTdUYVNF?=
 =?utf-8?B?WHp2T2RyNGVlSmY2VnhQOXRMR0h6K1hSRmVnTzN0Q2NPSjh1WTJ5R0FSL2dC?=
 =?utf-8?B?UDUyNnRTVmw5VTFFTEhHaUUzYkJiM1pjTXBmT0dHbWtUdE1GQ0VIK0V2ZjVH?=
 =?utf-8?B?aFZQaGJSejdpalVFNmVKSTRrWDNCSUs1Sm0xaDRhbkwrOGM1RzJIdmxET0Rt?=
 =?utf-8?B?QW1wcHZkeVZ6TG90ZUFaTFlNbCtlZWxUeHR4cFF4dEFrbzRrYUkzbVkxS3NL?=
 =?utf-8?B?Y3ZNazFFTm10cnN2YlA4R2VhQ0dYZWRRSk9TeUJyVGh6eG4xSExnSnJSRk93?=
 =?utf-8?B?MDRSbEk5YTBYR1hFRzYxYmN2NEFRQURwRGpVNHRWR1YxYy91bjAvWnJDNk1Y?=
 =?utf-8?B?b2puRGNXVnVXOGI4WW9OUmc2cWVTR3Z0YlhWUHl1K2IySGhleEtRL0tiOFFG?=
 =?utf-8?B?SzJ5NHlDTERsK0luU0dCRUN4RzhkMmxuaW1RdHhmUDBIaGpNa0tBM0RFbGJ4?=
 =?utf-8?B?b1hWenJGSmhYV2hXOGx4dzlaT2dWeGJYWWFsUlZpbk5rOUYwVjdUOEYyaXFh?=
 =?utf-8?B?ZEozUGprdHZIWmY2VE5XRzVqdzBBWXMwVlI1Um5zaGZGbzJEK0xqNUNTa2pr?=
 =?utf-8?B?Z2FuYnVLelVSdGZkeVJjZUt1bkFoWnRjNlBCTFI1ZzM3T1BhWjJoblZkTHVj?=
 =?utf-8?B?OWYzaVBvRDFTT2ljV21EeGNROVlaVEI0eDZNbWVQZ2Z1OHpiekpUN0JVTXpz?=
 =?utf-8?B?ZUZON1VuYWxGU2dKVWVQZFZlWFV1aVhlMlF2aXphVTMydExKUnlMMGxGenBV?=
 =?utf-8?B?OTdhTy9yOUloQnl3YlY5UTcwbC95U2FOMVVoVVlLazdUNWRBb200d1luZmhP?=
 =?utf-8?B?Yi9EZ1k2Q1ZvcnJmVU1kQVlWcVJCVHBlaEFHUzRnbmJVbXpBbzhGcnNlVEFH?=
 =?utf-8?B?ZU9WQytHWVF3bHNzVWU4TnBHNDcycHRoNkpBZjl0QmdQdW8yYVNLdk9LdzdW?=
 =?utf-8?B?QmpJSWhaSnE4QzAvaHNIaGgvbW1SU3ZNWmxmcnlXZUw3aGtTWGx3K0MzbWpO?=
 =?utf-8?B?aTExRW1TbkY1MEw4ZnlMNlZjdXhLN2FRbUNBd2lmZTJNdFhzdVd1L2JxOVN5?=
 =?utf-8?B?elIwYkFPSkpjTURySldPQXpXMUNlTzRsWVNGTWUrdVk5NDN5Qko5bzR6NWE5?=
 =?utf-8?B?Sk15ZlhmMDQyalIwYmdoYmtoL2VtNGRXLzVQZTBtR0FHLzZRNndyamNRZ2Vz?=
 =?utf-8?Q?V3hKYgB+6YhTY4FpVd+TJdCRG?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 339be9fb-9993-44e1-bae9-08d9d18cdda7
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 03:21:59.5738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: guVrwkkD816Gy5YOIEElGNslqY9CEod+AvFG9QqXi/bertW3LrDk2jhV2Qy2lFxz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4708
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: QW0A7s9N7XfX6lI3Ahroere2VHTbI1B5
X-Proofpoint-GUID: QW0A7s9N7XfX6lI3Ahroere2VHTbI1B5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-07_01,2022-01-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 adultscore=0 mlxscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201070020
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/6/22 12:00 PM, Christy Lee wrote:
> Previously libbpf maintained a list of bpf_objects, and bpf_objects
> can be added to the list via bpf__object__next() API. Libbpf has
> deprecated the ability to keep track of object list inside libbpf,
> so we need to hoist the tracking logic to perf.
> 
> Committer note:
> 
> This is tested by following the committer's note in the original commit
> "aa3abf30bb28addcf593578d37447d42e3f65fc3".
> 
> I ran 'perf test -v LLVM' and used it's output to generate a script for
> compiling the perf test object:
> 
> --------------------------------------------------
> $ cat ~/bin/hello-ebpf
> INPUT_FILE=/tmp/test.c
> OUTPUT_FILE=/tmp/test.o
> 
> export KBUILD_DIR=/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build
> export NR_CPUS=56
> export LINUX_VERSION_CODE=0x50c00
> export CLANG_EXEC=/data/users/christylee/devtools/llvm/latest/bin/clang
> export CLANG_OPTIONS=-xc
> export KERNEL_INC_OPTIONS="KERNEL_INC_OPTIONS= -nostdinc \
> -isystem /usr/lib/gcc/x86_64-redhat-linux/8/include -I./arch/x86/include \
> -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi \
> -I./arch/x86/include/generated/uapi -I./include/uapi \
> -I./include/generated/uapi -include ./include/linux/compiler-version.h \
> -include ./include/linux/kconfig.h"
> export PERF_BPF_INC_OPTIONS=-I/usr/lib/perf/include/bpf
> export WORKING_DIR=/lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build
> export CLANG_SOURCE=-
> 
> rm -f $OUTPUT_FILE
> cat $INPUT_FILE | /data/users/christylee/devtools/llvm/latest/bin/clang \
> -D__KERNEL__ -D__NR_CPUS__=56 -DLINUX_VERSION_CODE=0x50c00 -xc  \
> -I/usr/lib/perf/include/bpf -nostdinc \
> -isystem /usr/lib/gcc/x86_64-redhat-linux/8/include -I./arch/x86/include \
> -I./arch/x86/include/generated  -I./include -I./arch/x86/include/uapi \
> -I./arch/x86/include/generated/uapi -I./include/uapi \
> -I./include/generated/uapi -include ./include/linux/compiler-version.h \
> -include ./include/linux/kconfig.h -Wno-unused-value -Wno-pointer-sign \
> -working-directory /lib/modules/5.12.0-0_fbk2_3390_g7ecb4ac46d7f/build \
> -c - -target bpf -O2 -o $OUTPUT_FILE
> --------------------------------------------------
> 
> I then wrote and compiled a script that ask to get asks to put a probe
> at a function that
> does not exists in the kernel, it errors out as expected:
> 
> $ cat /tmp/test.c
> __attribute__((section("probe_point=not_exist"), used))
> int probe_point(void *ctx) {
>      return 0;
> }
> char _license[] __attribute__((section("license"), used)) = "GPL";
> int _version __attribute__((section("version"), used)) = 0x40100;
> 
> $ cd ~/bin && ./hello-ebpf
> $ ./perf record --event /tmp/test.o sleep 1
> 
> Using perf wrapper that supports hot-text. Try perf.real if you
> encounter any issues.

The above doesn't exist in upstream perf. It would be good to just 
demonstrate with upstream built perf. Otherwise, people will confuse
what 'perf' we are talking about here.

The same for another 'perf record' below.

> Probe point 'not_exist' not found.
> event syntax error: '/tmp/test.o'
>                       \___ You need to check probing points in BPF file
> 
> (add -v to see detail)
> Run 'perf list' for a list of valid events
> 
>   Usage: perf record [<options>] [<command>]
>      or: perf record [<options>] -- <command> [<options>]
> 
>      -e, --event <event>   event selector. use 'perf list' to list
> available events
> 
> ---------------------------------------------------
> 
> Next I changed the attribute to something that exists in the kernel.
> As expected, it errors out
> with permission problem:
> $ cat /tmp/test.c
> __attribute__((section("probe_point=kernel_execve"), used))
> int probe_point(void *ctx) {
>      return 0;
> }
> char _license[] __attribute__((section("license"), used)) = "GPL";
> int _version __attribute__((section("version"), used)) = 0x40100;
> 
> $ grep kernel_execve /proc/kallsyms
> ffffffff812dc210 T kernel_execve
> 
> $ cd ~/bin && ./hello-ebpf
> $ ./perf record --event /tmp/test.o sleep 1
> 
> Using perf wrapper that supports hot-text. Try perf.real if you
> encounter any issues.

here.

> Failed to open kprobe_events: Permission denied
> event syntax error: '/tmp/test.o'
>                       \___ You need to be root
> 
> (add -v to see detail)
> Run 'perf list' for a list of valid events
> 
>   Usage: perf record [<options>] [<command>]
>      or: perf record [<options>] -- <command> [<options>]
> 
>      -e, --event <event>   event selector. use 'perf list' to list
> available events
> 
[...]
