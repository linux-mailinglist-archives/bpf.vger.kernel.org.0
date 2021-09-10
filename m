Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A2C4070E9
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 20:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbhIJSaL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 14:30:11 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:34712 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229476AbhIJSaK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 14:30:10 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 18AIDKg6031403;
        Fri, 10 Sep 2021 11:28:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=P/gv66wsrtSFV2AnfgEaK711kDqcco6mRxoQtozvxts=;
 b=b4cLxe2jRPvG0bvwiQhwYYGbH/9fQtSMJzVE8ne9Ad+4knlZefFixgBvpraLhSQL0Yb4
 DB8cLvOcv7rkaFC+Wa90lfg9/JZq/MuJJYEQnHb3zkQB6XAGqDJez1N2BnalMnHsQ1mT
 TK23ariTScwbKJ+zwQZGaWNYoJHgrN3HMvI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 3aytf2xqwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Sep 2021 11:28:56 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Fri, 10 Sep 2021 11:28:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cne2npIVEB4umgsCNNBDVPnkFFH7n200SSlB2LPtKCL+TfDGKyKV2mCps7p+pXWC8/obAGG/pruVZcPcAsi5ZjSMsrD8v5TqwJ3YBXq6FxFLUFFSBUzqqcVqgWPu7rOXyM3lv0zayJI3NFQjvaJQK19CQcqJ90nq9WM+W8Y5iH+usTpHeCuhSlSrL2Nrq2fbPg0jUHLEonX8DbsG9G+OXgRFx7Ka+r+MP6b2QW+NwMX2ZQCBeC0RrwGqtQi7E48qMZa6iKD5xxKv4KqeWrUk3KW3tetRnpuGNG1heJnJX9WSIl2nW9sxe2QHbrxvqP9IeQ+/1HherwjZ2ptrwbeftQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=P/gv66wsrtSFV2AnfgEaK711kDqcco6mRxoQtozvxts=;
 b=cgwsb46o45touclWZc+D/kjV0WFIWc40/wCafAnT7WB0erS+u6RbbrTp68VpMLzOJOHhCSw8Mt7BTC4FwE8FPL9/b8bzf6osUK7zLgZ5eFLIJ3tTWtefBk+TiUjLrozBJobU+pBqMxGbCygtOBNGFc0B7twkK7dRubMC0e6w9ywQdkzQNpico2ckHIMnTCK4ligdlBss2X4Ev9GS32eSDlnTz9hTetGzWP2x4QCRdb+cyZLm/kuQDgMyx0T8IS+iebIUGAiKaT4gkUpbuHiPdfBmkPxRn734dQ0ogtzpY5gUJ2+tqPEcAs9ou2ig93fbwH3WyTbSAzw7EgQcpe//eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB4016.namprd15.prod.outlook.com (2603:10b6:806:84::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 18:28:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 18:28:53 +0000
Subject: Re: [PATCH v3 bpf-next] selftests/bpf: Add parallelism to test_progs
To:     Yucong Sun <fallentree@fb.com>, <andrii@kernel.org>
CC:     <bpf@vger.kernel.org>, Yucong Sun <sunyucong@gmail.com>
References: <20210909193544.1829238-1-fallentree@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <40733168-d1b1-4d9e-63a5-e767bc9dc1ad@fb.com>
Date:   Fri, 10 Sep 2021 11:28:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
In-Reply-To: <20210909193544.1829238-1-fallentree@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21e1::1064] (2620:10d:c090:400::5:7b93) by BYAPR01CA0034.prod.exchangelabs.com (2603:10b6:a02:80::47) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 18:28:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5ed1e19-fb0b-49df-6c33-08d97488d7a5
X-MS-TrafficTypeDiagnostic: SA0PR15MB4016:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB4016D56301BC7A17D891E2CBD3D69@SA0PR15MB4016.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:317;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1FbVnghSCSaigbJVKv/6X1rdCHx7Ob5gkl+8TCKWzVQgSr7DkF6soou6Y8oDRHBjLu14VymZa4SV6rnydRHpETBgl3k/28BaXjbmUK1MIY87vaA/MN+Zl2PSMnYA0MMjwYBZn/J7zpajZ2m/+67t64erRMF735EKwxlYit4E5gQRyioja39YQMBO0shNO5a4tKKIUTi4u4ptOGPIqb+pQnFg4WOHqA+m5b7Ij5f3Q75Kg2aZWUPSM2NVG2k3uH3rhPeMQKSGN5MLPZnouYzuwWugYqoGTdEMZcT8YuHdJzFR24cq3Z5FCrwKtYFYcw8ffls5obDIcv95yaCxdAVIsMYvaRA0+yxCqXl5yyNEqyiQv2OjU4myksluhxG/8KkoSoWO12vTyUne/pKpfSsFvIVu9B2fQwmGQdVUCcjsagidIA+tlMXZyQ2htHl3CymWyEfmM9mlBPjVX2wVH8RKb7n8CwNHsnD7Z2Ka6DOgNqTG2YDpnCkqqW3mZ3f2FyJZYbdqzhEmbfNEug6q1sUCdlyUVOYioFMYxdBZOUrNqMFLKp8qcZjAsYX6G6ILAnenEqi+JnjorNGDO/FROC/LK+zaa0ehXHz4Mdzh1yhscG2NQPiA6hRq2Y4WUCE2B6y5j8JIUUYbLF8oWxlFfjo6sDr3y3sJVsQ3Rcqc/MPSRCP/89YteLtZxQ8L45jbIHPM/b8OFQRuWvqKUqYsAzmF3PJcRz6o/BVBoMcNltDnaS4h4ddbjj1YnKM8mzib22QDoRLiwMsN3+tVaxVnIYNJabq7CWtFaS3yJzxkmjiSKqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(66476007)(66946007)(31686004)(53546011)(2906002)(6486002)(83380400001)(2616005)(36756003)(316002)(31696002)(508600001)(966005)(66556008)(4326008)(5660300002)(8676002)(38100700002)(52116002)(186003)(86362001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amU4bEp4L0pTSTA0R3NMU2hZN3NUZWg0YTJxSGdCYUJ6SXVKMlAwenEwRnNQ?=
 =?utf-8?B?SHprSjc5ZDVrd3gvOG4wdjBaQVZVSTlYN0NxYzVSeHlhejZhS1pMVGMvcXJU?=
 =?utf-8?B?NzRlZ2FuWTBCMVNBS2FlWEZvaHUxVEZLM2Rhc3FodVdQQXdDd21ZejNkcVZh?=
 =?utf-8?B?ejNJRUQyN2ZZUHA2cHg4d2M4Y0RIbi9uaWJVRUdsQ2NhbVpvd3YyZUtsaHVP?=
 =?utf-8?B?c0FRUjRhc0Z4MlhpTlRqZFROVkZ1dTBKS2V1blZ0VjcxTVN6bkxJSmZlVGdu?=
 =?utf-8?B?VXRYYlluZmtpeFJzZ0I4VmtxOVJETWUrY3Qrb0RoL3pNZFRObkVNN1FXaVYv?=
 =?utf-8?B?QXNYaW9pSUl5Zkt4NUxEajZ5a21JYXNYbDdVcEJ2aXlSRGZuYlBYTGw3bUln?=
 =?utf-8?B?Wjg1N2JGblFqdGFTNUpqUVVKVGc5cDNrdVJNUFllR0RRVDQyc1hsYWhVbmZI?=
 =?utf-8?B?aVFPWGdsUjV6SzBmUnV1d1lBQXpkeVpCYjlFOHBSWldnV3BIUGZIT3gxY29Y?=
 =?utf-8?B?dUJaaGNSN0gxV0ZWa2VHTndlOUNKeTlvdWFWVHY4NzJMRmlSejN6SFlBcElX?=
 =?utf-8?B?NTB1bFc4M2Z5N2ZmcVozZ25MV2tpcVEwbEVxbGlrWXh5aWppTGQ5MGNlbW01?=
 =?utf-8?B?YVRKUHFjM2U4MVgzWW9LOW53NXo5SnZEUFdWSHliMlRkZGlZTnp4NndHbHJL?=
 =?utf-8?B?dFQ1SHVrWUNtV0M0UHB0Mm9QTU50QyszckpRNDNGUnZlQy81L1o0M0w5ZFA4?=
 =?utf-8?B?M1c5STMrbzJNRjNUejRHZ1BFbnhweVNEbkR2Kzh0RlZqM0tGS0dhTHl0NytL?=
 =?utf-8?B?K1dvZFU1ZmdjemlIL1BCTm5Pd2Eralo2Yy9FTS90YU9mRnQ3Y3Y0YWpPOXl4?=
 =?utf-8?B?ZkgyNDVFeXNlVlZhRnRCVDRFT1BUdUtOQXRxL3Y0MHVyMVRpYnNhTGhROEVT?=
 =?utf-8?B?cHhWYlZVVGpPcUxHSFQ5WW9LK3M3WklUbnhtMC9mdElLQmUxemh4cE15bCtz?=
 =?utf-8?B?b3ZjQ24ycDhQVjFlV3o1Vzd5bjg1czk4OXJGYW1sT3p0WlZ2aUdzSnJjSzJl?=
 =?utf-8?B?bFBobVVQNFNnRWhWWEc4NExiTStpZGRWS3lISDAyelBVdnZrRit2RStCekhj?=
 =?utf-8?B?Szd1Y052S21CZFphYUE3b1QrRW5tSVJpdzBXQXRkZ0t1RVArSUtJMnlvaWNI?=
 =?utf-8?B?aHpjb05wYzUwQ1ZWSGZ3SUV6V0pnYmF1bER2MlNoeDdsd0FDcVlVZXhVYjAv?=
 =?utf-8?B?NHZsOVR5bVJidnJzUGk3VU9CVDd1a2VYSmRpQ1hLeXFteUkvOXk2RjB6NzVF?=
 =?utf-8?B?amxRb0trSHJhdjY5czhybDRtTUlCaWRtUkYxQ3Q5czdZQW9NYndsdG91TDQ5?=
 =?utf-8?B?Q0NSWmU5QmxKekZ2RTF4YlVnVVBkczVqdWljb1pwRlpjaGpzcTBxVlUwbEVF?=
 =?utf-8?B?dnZLM0RwNngxbkRJWkVRWWxvSmZhODZXQm12UVM4SEVzY295WUNBRVpYVDZF?=
 =?utf-8?B?SDdZSVNzbzB1Mytqd3U0Mk0wQkZsOEIwM0FHaUhVTXRuMFovMGZXbnIrNkxp?=
 =?utf-8?B?aFVKNk9lRnFjQ2xtenJ0bkxNa1grTzlMZXgrTVBZK0VndW5Ca1ljVmFtdFQ2?=
 =?utf-8?B?RkJKa2F1Kytxbm52QXpxMkVkY3JTeFhSL2lpTFJQM3N6UGRKQnM2WkEwSEM0?=
 =?utf-8?B?dkJ2OW05aS9hRFJMeWowb1c0UVF5b21LRUxESjlyeGgyZm5BdkJzOGJiZ0Ey?=
 =?utf-8?B?VlpOOE42OEMvaU45NWJvV1lJMzVIdCt3cVVmNlJTS2w1K3draXliUkFUaXVp?=
 =?utf-8?Q?vVYXv/eAE+CoCIVQp+bvZvnB5aVE7G8qGGCcg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a5ed1e19-fb0b-49df-6c33-08d97488d7a5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 18:28:53.3491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OMWw8e7BrgNIYYHF+62vUuCurlk+T51DJqd5CofCcNkdj6ZsiAKqHNu5MLW3/oOr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB4016
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 3ILeKanKH_DlZcSySP76f6VbKytP3g7z
X-Proofpoint-GUID: 3ILeKanKH_DlZcSySP76f6VbKytP3g7z
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-09-10_07:2021-09-09,2021-09-10 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 bulkscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 clxscore=1011 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109100105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/9/21 12:35 PM, Yucong Sun wrote:
> From: Yucong Sun <sunyucong@gmail.com>
> 
> This patch adds "-j" mode to test_progs, executing tests in multiple process.
> "-j" mode is optional, and works with all existing test selection mechanism, as
> well as "-v", "-l" etc.
> 
> In "-j" mode, main process use UDS/DGRAM to communicate to each forked worker,
> commanding it to run tests and collect logs. After all tests are finished, a
> summary is printed. main process use multiple competing threads to dispatch
> work to worker, trying to keep them all busy.
> 
> Example output:
> 
>    > ./test_progs -n 15-20 -j
>    [    8.584709] bpf_testmod: loading out-of-tree module taints kernel.
>    Launching 2 workers.
>    [0]: Running test 15.
>    [1]: Running test 16.
>    [1]: Running test 17.
>    [1]: Running test 18.
>    [1]: Running test 19.
>    [1]: Running test 20.
>    [1]: worker exit.
>    [0]: worker exit.
>    #15 btf_dump:OK
>    #16 btf_endian:OK
>    #17 btf_map_in_map:OK
>    #18 btf_module:OK
>    #19 btf_skc_cls_ingress:OK
>    #20 btf_split:OK
>    Summary: 6/20 PASSED, 0 SKIPPED, 0 FAILED

I tried the patch with latest bpf-next and
 
https://lore.kernel.org/bpf/20210909215658.hgqkvxvtjrvdnrve@revolver/T/#u
to avoid kernel warning.

My commandline is ./test_progs -j
my env is a 4 cpu qemu.
It seems the test is stuck and cannot finish:
...
Still waiting for thread 0 (test 0). 
 

Still waiting for thread 0 (test 0). 
 

Still waiting for thread 0 (test 0). 
 

Still waiting for thread 0 (test 0). 
 

Still waiting for thread 0 (test 0). 
 

 
 

[1]+  Stopped                 ./test_progs -j
root@arch-fb-vm1:~/net-next/bpf-next/tools/testing/selftests/bpf ps
   PID TTY          TIME CMD
   231 ttyS0    00:00:00 bash
   254 ttyS0    00:00:00 test_progs
   256 ttyS0    00:00:00 test_progs <defunct>
   257 ttyS0    00:00:12 new_name <defunct>
   258 ttyS0    00:01:03 test_progs <defunct>
   259 ttyS0    00:00:02 test_progs <defunct>
  1310 ttyS0    00:00:00 ps
root@arch-fb-vm1:~/net-next/bpf-next/tools/testing/selftests/bpf fg
./test_progs -j
Still waiting for thread 0 (test 0).
Still waiting for thread 0 (test 0).
Still waiting for thread 0 (test 0).
Still waiting for thread 0 (test 0).
Still waiting for thread 0 (test 0).
Still waiting for thread 0 (test 0).
...

I didn't further debug what is the issue.

> 
> Know issue:
> 
> Some tests fail when running concurrently, later patch will either
> fix the test or pin them to worker 0.
> 
> Signed-off-by: Yucong Sun <sunyucong@gmail.com>
> 
> V3 -> V2: fix missing outputs in commit messages.
> V2 -> V1: switch to UDS client/server model.
> ---
>   tools/testing/selftests/bpf/test_progs.c | 456 ++++++++++++++++++++++-
>   tools/testing/selftests/bpf/test_progs.h |  36 +-
>   2 files changed, 478 insertions(+), 14 deletions(-)
> 
[...]
