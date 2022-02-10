Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D694B18D4
	for <lists+bpf@lfdr.de>; Thu, 10 Feb 2022 23:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345239AbiBJWvf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Feb 2022 17:51:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345155AbiBJWve (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Feb 2022 17:51:34 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8DB75
        for <bpf@vger.kernel.org>; Thu, 10 Feb 2022 14:51:35 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21AMfmvg017399;
        Thu, 10 Feb 2022 14:51:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=vAQHBr0rgmc5ZSAh9wNZUN58MJa9tLfasqeLMyACFTo=;
 b=TPGzdeeg72o0zN4cWDMAEUWupmbGq41Ly4EUMOf6lENu4OSvIo7cmmgLOFj/eOs3F3Pv
 WLSCt66Rr82gZxO1EZ5Y4xGOSUhWKjFtQRh7lW0Jekh9rIbjxroOfx/Y+kRhwfBMf5Np
 JNTxKzjX1HIeQln7JNQXS4TMwjeW9OZTo6s= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3e58mhsejc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 10 Feb 2022 14:51:21 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Feb 2022 14:51:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dd7ElNA+UEdsBhr+p9L+91QpKVTKNhuBUe/m+ykgLZlzD94xYQWbCSlaNXpI09oCwAuVaj6aza3ehVAvXAZn4dUXh2tYqpcl6X1dRcxI0YBqk9DmlwUy1SihebVSKiGdso0/oB6ZQqhjE+v4ok/AzvoJK1Zk9UE1VsmNHifDqxzR22KD/SqGG7pXncc9+3/sTMj+Bh6bYlWPQl2314WR2mQgOurToafPSJTnFNanN4y1Dz8SOz14Nu3eev0SyHkZBkoUw5sUj9tKlsFeuqCNEDXzHwi9Fu2rbrrCaSN728Y9IdF0dS2R98UrZCAqpb+q09EQt7s3i6PoeJ10P+uQ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vAQHBr0rgmc5ZSAh9wNZUN58MJa9tLfasqeLMyACFTo=;
 b=AFsnmv4SM/F7EgbkG76H6S/uU93KKl9Fusyy2dnrSMfchCqUzxMePHwo0I1XDpXeX1GlOq50Wxmghan3IsefmPIwfX0UELHrig8GuM9clx3q3FSJ2258K8f+GDAV98wCEpcmdwMk0GDfeYVBJLQoI7bE6QkCi7mMqYIcsptIJRAKTLqBN0RAcfkeyGSIMLRLuGvCZMNKQVlcxAUWNjlo5z2PJ1p1SN83m6bO1FBwThctFgZ9J6iNtKbFCa8uT7Hg7r92dzQhkkecEwCYJufHeJK2hjUh0dZyqGc5DvofA/UW2WbmwjalZPAx9+VDuIuW6WVGgYgisCJ3ziwGziDrHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by PH0PR15MB4477.namprd15.prod.outlook.com (2603:10b6:510:83::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Thu, 10 Feb
 2022 22:51:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f54e:cd09:acc2:1092%4]) with mapi id 15.20.4975.011; Thu, 10 Feb 2022
 22:51:18 +0000
Message-ID: <78216409-5892-6410-a82c-0ebf5fdb1504@fb.com>
Date:   Thu, 10 Feb 2022 14:51:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [PATCH bpf-next v1 0/3] Avoid typedef size mismatches in
 skeletons
Content-Language: en-US
To:     Delyan Kratunov <delyank@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
References: <cover.1644453291.git.delyank@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <cover.1644453291.git.delyank@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-ClientProxiedBy: MWHPR1701CA0004.namprd17.prod.outlook.com
 (2603:10b6:301:14::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7d37118-b34e-420f-4a45-08d9ece7d9d4
X-MS-TrafficTypeDiagnostic: PH0PR15MB4477:EE_
X-Microsoft-Antispam-PRVS: <PH0PR15MB447763E69B60016920D55353D32F9@PH0PR15MB4477.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L82sYWbFrfsXdPrqTHoUMQKOkHMT1bqLm3N1YwlSovoOP7Pt6odO6mYvjjPySN8nd/XHZuPaKNfYXBLvz5eWFX5ocYDm6z3ffUdbX+pnSD4yKm2d8g7L3aH254OME29tm7OgrtRxlMakLX1EoOXaxKwMfM7asX9wpR7yMYcj6wcaAAQf4dVvwpkPRDOfi2il445CMMZx3PK9bw5BAKDnZnxi+t8OQHlFqvtLEG+odT6pTo8zMEgYSST6fe39f4FTnh425fQjl6wlikJ58H490lOvJnvgDHbv1wbvC6OwsORQ7rbXFj7Kr8z7uZHqkMd4+IPk9BpkIJfqXngqKZrXNcy6sF9llauXftISKOHEeV+FqSQBTe1VLMESswU1nLdyVjDU7moZjdCF6Wp1YsjYjSic7rllSqV6GBICFUiG20XDLkLDb+IGbzfKRZouxojUS6craQSe+uWic0MizaHogJ3nMQzNn72M0HB9CdHabkWooIjPBW0ESV7WHfl/FL5rUYwSgkJisT+aA1BAMFDgT8hOyyVsuaqxkA9PfAy6NTfDVei9lVFaHzhC8IqUeJqw1jA6PTxWwNoKSRCMJzWTNudUGvXzxFzsK0yFNJKliwrGuDkFHbZKsvyyxpNCdmNkz3Xjp8E95uNxtkgqT/lug75ixIQOwyPc62P0aU+HOJ/qlNOx64dTjU86J57exIn8WtGP1l7PWzz5zlrBge9ilMSl6ozLrOutENuszGYQe1xNVetFFpUYb1CGjbVbbqL3EhW1n6zPdZUVrHPJGd+K+iR0hjmDImOM5iDN095eanb3kVTjduiXMER4XoOjkGnsr/hncEf0wOy1yAZIl/SqdQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(508600001)(2616005)(966005)(52116002)(53546011)(31696002)(6506007)(6512007)(6666004)(6486002)(83380400001)(86362001)(66476007)(66556008)(5660300002)(66946007)(8676002)(38100700002)(110136005)(2906002)(316002)(36756003)(31686004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEQvdGxEclJ0bW9WYUEvVkpLY2l4RkxGenVzbHk2UXc2U3RIbkVLakRKeGQ5?=
 =?utf-8?B?cHNNYzZERmhoMnRuL293a1dPcURvNmtvSFM4NXZ2UFovQ0hPS1Y4YUlMdG4x?=
 =?utf-8?B?dlU1dmVrelBjdE9NSVZhSTZlZ0JWSnZuMWV1RVE5Q0p2Q3FjSXJMM1NQeTlB?=
 =?utf-8?B?OUlyUmFGYkdzcHozMXV0dURvVjA5aWRNUDhLU0V5anVoUUNOQzYzb0tlNU0v?=
 =?utf-8?B?UXIzR21ZVEtPUVFraUNoRGZkdSt3a3RrZStJYWF1bkRrMngxZlc2Qzd4N2hs?=
 =?utf-8?B?WjQyeWpUR2s1RGhlMFBKaWNYT1B2RGd3K1pscTEwOExKRnNaSWhOMUZVdmRz?=
 =?utf-8?B?NVNSMEtyWUg3TUN5NCtUTW8vNkdJWGRQUmFnaTZQYzgzcDBXTjE5R3hmOTBF?=
 =?utf-8?B?UEhvc2ZOR0FhQVRSTGVpWkI1VzlLVHVwbkxXRlIvRjRMbkwwY2N1WnVnTnQ1?=
 =?utf-8?B?TndaMVF1L0llQStTMTFhME9DaVRDUGRRWWJydkREdk0ycy92ZzRSRzhwZDF0?=
 =?utf-8?B?UnloT0h2cGlwY2htM21sVnhKU2g3RFUxa2JDeXFXYzVCTHovSndVb1Ayb01s?=
 =?utf-8?B?Y2E2bjFpV09kL0hLaVJ0RFlFUUxRWTJPc3k4R1dEYUoxSEhmS1VKKzhMd3FF?=
 =?utf-8?B?OTRoQUcySmczaUEyVktyOFJJRnQvRmMxRmtmRG9lMXFGWHNYVTlSMGI0d3ls?=
 =?utf-8?B?aGhPZ1BEd1QyS2xUVnpWd1hKZm1SREhORXljcllKNjVRU3R1N2VzWkhKcFdz?=
 =?utf-8?B?QmNoOXNQVGtHUW1KZTBBa0RyUkk3VS9zUjZEengwR2U5MU1vVWtxZUxndU1I?=
 =?utf-8?B?Z0NBSnF3NkVZVmUwYzJwclZoVzFHNlBTRWpVb29YWVhWeHVtaVZEUGY2WEZV?=
 =?utf-8?B?cW1ibkg2VHg2UHZFM05FQlI5SFZNNzR5SVNZMGdqMDBuTFgzcFpIaHJISzRT?=
 =?utf-8?B?REtZR2FDakFoNEI2R09NUjhkZHRJSkNlR2hxNXgyR0NJODlhdHcyTXU5VGln?=
 =?utf-8?B?clZhQVpsYnpHS2xUU2dUS3ExbGNsNnhHZE1zaGRjUG1lYU9oWXNOVWJzblB2?=
 =?utf-8?B?SXN5WThrdTU1OFVWQ2J1ZXpqKytrZmtGYXF3dkVQRXl2RGNnQVhoSzFoRVhZ?=
 =?utf-8?B?VmF2YlM1dnhTdnpEamIwT0duVUw0VjJPNlY5c1I3TjR5dXJxZWp1SzRsaVl4?=
 =?utf-8?B?c245UTRJQmJLZkNmclYwa2szdWVWUlFOMGNyTVpoZHcybDdmTHJxdTNzTW9s?=
 =?utf-8?B?TGJCcGFyR0toUzY2SFU0TzJnd05YYmFlZm1IRW1nY0NKcFpwRlJUYzVnOEk1?=
 =?utf-8?B?Y3NkRGN3UnZvMGRMdXh5Z1ptbUk5aUNEQk9YMlpiTzVNN0xyQXZYeTYxTzBs?=
 =?utf-8?B?TUFPbE1uVjd0OXk3c1lrN0ZoSEMzVnpzRWd4TjV6ZmhXVk0rM012bDg1MUxO?=
 =?utf-8?B?Qk0vNVZ3bklEUEpjb25rMWt4amg4ZWdLdzVKQ1VuMEg3a1JrTXpuRm1jVFZB?=
 =?utf-8?B?TEhWaHVsQ09pSDloTzU1N05MRng1a0t3bmdqY1p6LzV2TmUyTE8wTmtpNkM5?=
 =?utf-8?B?RlNIUjVpak02QUpwdFZ1MFlxRDFaUlN2NVNLOTdGcDBpR20wZ3Z2cmE5RGt1?=
 =?utf-8?B?akU3bmFIekx1YW5yVFFSaTU2TXFJVHRsTzkyZklna3AralQ1SWlrT3ExTXZm?=
 =?utf-8?B?VmlrQzBBT0VFL2w2TTNSZmF6SXpKWHZQZkpEK2VzT0pxdkpTcW50ZStSbFZv?=
 =?utf-8?B?a0VmNzV6a0UwcFZUaW5GUmNrYjAvNy9tcmhRYjVrQjQ3QlhsZkxSaEh6cjZj?=
 =?utf-8?B?NzQ5Y2NaTlNJV2w5YnFWWFRaUGMwNlR0dlM1SnowUmYwL3lzdys3eGsyaHhk?=
 =?utf-8?B?bWV6VmR2VnJVYWNSZlVmN1oyZWlhdldmZzRKbnRDakZLa0JUeFBwNjU2bmdJ?=
 =?utf-8?B?dXN4b1ZlYkE4dGxNc3B2SS8zQmxCeHZQOXRCdDNyWHJHb3FqdzdOYlhLWWdo?=
 =?utf-8?B?Zy92aExWTjI3cElCQW41djJ4R0lRVFZBeHp6S0tZMkhVckVvRjdzY2wzZE1S?=
 =?utf-8?B?Q1NjNFVSaks1SzFZbHg1WDZTTllRcUJtY0R3Um1XbkQ0MXFCaWlaR1BKMEpO?=
 =?utf-8?B?WitzcVVESWpkdlhrMCtKeG1iR0FYL1F3eXJiVys1V2tQSUZFRnFPYS8wdERh?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d37118-b34e-420f-4a45-08d9ece7d9d4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 22:51:18.8148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+PprasIMNrc9ZkexOSYsm7xF5j8ozuiKtyQrVEHEjo7crirwcm6i9NEFAnkXkQM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4477
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: fA025QbG_LVS0IhgWPuATjRyGRQYtLSK
X-Proofpoint-ORIG-GUID: fA025QbG_LVS0IhgWPuATjRyGRQYtLSK
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-10_11,2022-02-09_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 bulkscore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202100117
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/9/22 4:36 PM, Delyan Kratunov wrote:
> As reported in [0], kernel and userspace can sometimes disagree
> on the definition of a typedef (in particular, the size).
> This leads to trouble when userspace maps the memory of a bpf program
> and reads/writes to it assuming a different memory layout.

I am thinking whether we can do better since this only resolved
some basic types. But it is totally possible some types in vmlinux.h,
who are kernel internal types, happen in some uapi or user header
as well but with different sizes.

Currently, the exposed bpf program types (in skeleton) are all
from global variables. Since we intend to ensure their size
be equal, and bpf program itself provides the size of the type.

For example, in bpf program, we have following,
    TypeA    variable;

Since TypeA will appear in the skel.h file, user must define it
somehow before skel.h. Let us say TypeA size is 20 from bpf program
BTF type.

So we could insert a
   BUILD_BUG_ON(sizeof(TypeA) != 20)
in the skeleton file to ensure the size match and this applies
to all types.

In the skel.h file, we can have
#ifndef BUILD_BUG_ON
#define BUILD_BUG_ON ...
#endif
to have BUILD_BUG_ON to cause compilation error if the condition is true.

User can define BUILD_BUG_ON before skel.h if they want to
override.

This should apply to all types put in bss/data/rodata sections
by skeleton.

If this indeed happens as in [0], user can detect the problem
and they may look at vmlinux.h and use proper underlying types
to resolve the issue.

WDYT?

> 
> This series resolves most int-like typedefs and rewrites them as
> standard int16_t-like types. In particular, we don't touch
> __u32-like types, char, and _Bool, as changing them changes cast
> semantics and would break too many pre-existing programs. For example,
> int8_t* is not convertible to char* because int8_t is explicitly signed.
> 
>    [0]: https://github.com/iovisor/bcc/pull/3777
> 
> Delyan Kratunov (3):
>    libbpf: btf_dump can produce explicitly sized ints
>    bpftool: skeleton uses explicitly sized ints
>    selftests/bpf: add test case for userspace and bpf type size mismatch
> 
>   tools/bpf/bpftool/gen.c                       |  3 +
>   tools/lib/bpf/btf.h                           |  4 +-
>   tools/lib/bpf/btf_dump.c                      | 80 ++++++++++++++++++-
>   .../selftests/bpf/prog_tests/skeleton.c       | 22 +++--
>   .../selftests/bpf/progs/test_skeleton.c       |  8 ++
>   5 files changed, 107 insertions(+), 10 deletions(-)
> 
> --
> 2.34.1
