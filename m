Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAAE62FBE3
	for <lists+bpf@lfdr.de>; Fri, 18 Nov 2022 18:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbiKRRpA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Nov 2022 12:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242112AbiKRRoy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Nov 2022 12:44:54 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9665B58D;
        Fri, 18 Nov 2022 09:44:53 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIH05ip006042;
        Fri, 18 Nov 2022 09:44:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=KkW6Zh8aGXp6Hj2eR6SGLTqOBGxbVqwPjm2gtTXtg18=;
 b=DWrsfhAhWDOP9ldeSdz3S93a5ymRHlEscq+KNvLNnXe2rQqnsST2R4xQdeIkSaFoi9gQ
 pcVt4Mw5WBTUgOd1hNsNBlhmV6wurlbRrBZnlClA+mqSx1OHXLawJeLm3BPglQ7E9sKe
 VjTZVIJQgeBZg+bMvge/Rq+Xdd2gYMcCOiPM7OTiDEvalufuqYZX733Hb9P3SixlszH3
 VyZ16CtY5dVWZrS+KLQVK9AigKBg89u97QBTVyuCT03h1ZhmWuIHFqiSeh45zYtmNloQ
 oVSgL2KeGASq8gbqaQJt7M70Lj33TAWeOyFGlMXT65IUvEwvI3YvvR8V+N3KE0WFlnY1 sg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kx0w7vux3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 09:44:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PyTO1Mzq5wg/DAhfMh42y3CgufDBWF8IpbmXew3pIXsjcKPe7+el0GbLlHoKfNKC9DC1yPuIrqewyNqnwxPD/coaKo8vpovjqEPAWgalADVFI/UiAYyyUsKivKDjf6VyuNy5emfC8VTg1ycRA7fwn6GIMEJxyaUzEmwkZPXzGJzKUOVlnyWNCXR/XW7BCsl7T2tupRZsJaGYhZIFtA98UGNsrEyTjWvkD72cfTSPQOSOhTuutbppqaCj/Zm+2Tia8WamSnKzqmMWTt/xAYHbdMu338NQkPhMT08QWdxZAn7ygLKDoe7yhwDfDibTUX7DEkleERSbqaj9KCfkiCCDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkW6Zh8aGXp6Hj2eR6SGLTqOBGxbVqwPjm2gtTXtg18=;
 b=Lv/+pbsBPJcP/63FvspJsxeFGbxVLxWJU4BPuIarcAi/QpEfJgNakJAbL/pYfJeG+pXQRLj6v+SxwU9kqnv1VC0vRuFfcJiYN3A3AnsgM4CPVaN4YOPLiFECALaBdNh1MzQUfvWAKkxX0Fkzrt+jxZ8UYkaFfjxe2ReS1mF3iCk8OaOteegFJTBGdU5P3kfhT7z1/PAv/JK8bdUdZvzcn0QdRaPZmGyYlGa/BDxffiWAubbqcH/X4HqGNO1lMEIqRaQcW47yLtDt0ItkhONd5qsWe0V2M1/poAuVE9y7uDo3AxUqax4CYjaZDSuQg82gZ1L8YAjf/WC5Rhou94oNOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by PH0PR15MB4541.namprd15.prod.outlook.com (2603:10b6:510:86::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Fri, 18 Nov
 2022 17:44:02 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::563a:dd91:dd5:6a8f]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::563a:dd91:dd5:6a8f%7]) with mapi id 15.20.5813.020; Fri, 18 Nov 2022
 17:44:02 +0000
Message-ID: <43d5d1f5-c01d-c0db-b421-386331c2b8c1@meta.com>
Date:   Fri, 18 Nov 2022 12:44:00 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Florent Revest <revest@chromium.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221108220651.24492-1-revest@chromium.org>
 <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home>
 <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
 <20221117174030.0170cd36@gandalf.local.home>
 <Y3e0KtnQrudxiZbz@FVFF77S0Q05N.cambridge.arm.com>
 <20221118114519.2711d890@gandalf.local.home>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20221118114519.2711d890@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR20CA0005.namprd20.prod.outlook.com
 (2603:10b6:208:e8::18) To MN2PR15MB4287.namprd15.prod.outlook.com
 (2603:10b6:208:1b6::13)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR15MB4287:EE_|PH0PR15MB4541:EE_
X-MS-Office365-Filtering-Correlation-Id: d72939f2-3aa0-4913-e3d0-08dac98c7b19
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crxQhvD5SlIc1dh//aMlRxzRBJDu03nYkj9H3yKHiV3K4XwIRdVwgPKMm2IF9qyYkfH1sbn2RomyyImVEDCh/jzpHdIR4g0To91yeuZvFtOIMXYvMgqUW7j90LhpVqfz9LXiHYMzhpLFVzEZM3/z+rGg4S1QOr5J3TawizqlUaGDCS9QL+REZP5g5KWpHu2KMW64rcGvfzPwc9NfmvpEya5biFDwnyL5BpNvH4m7rfHW39UZQyFER6e+M0Y7v75gEwwz0yme901nOhFVP99cm3PrCoo27LU6jsFEbBUJv/mpvtO2aqEpPAOar1sRTDBc5iktdK9obDd+Z4z6nhUbHCjpz2gL1GmtOzRECsYlxlejrO4ZmfGIhKkzp7to/O/W/gL/b/VFnl4RA5OfzCyEsKrDez7BQIT7PL71V494nP1lMcIbyqyKMh2t60tqV1q9Fx3OYI9NI1WOhicstKywvx9UA7ezmiMgF2E75nKyXorgSINzIYJgluM1uej4unj4K1keX4RPo3vmj+RCMRgZfdQrjYAP9KrPxK33yhKuiey3dK6bHlfHBXT09h7ZikBiiaf58VtdHTi3oXP4/hTnMLZjJCGqWqg8eZtj3u6nLuPhrZUpXB513Jt15GHq4v/Phv6tu4QAgLIt0YS7UrcIUdwUqVQocpt0cwZ3esETTSId8uSVd0NKzgV8wQmICSokYa6NoW4Cmfp9o+9kcbhNF2A3kdNQQHoAY2d/bEpDczSQ6jnHwZwRShbyoISiU6Lh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(346002)(136003)(376002)(451199015)(36756003)(31696002)(86362001)(38100700002)(6506007)(54906003)(31686004)(110136005)(53546011)(316002)(966005)(6486002)(478600001)(7416002)(5660300002)(186003)(2616005)(8936002)(83380400001)(2906002)(6512007)(41300700001)(8676002)(4326008)(66476007)(66946007)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUZtZ0JkMm5WY0hzNkMzMWVyR1pZeEh6UUw0NFZsWllaYmhPTlZLWnFaUFJV?=
 =?utf-8?B?S0xPVW1YK2Jmdlc0Z0x5M1doalRHTTZJOUhIcHd2NkVnWENraStZOEVnU0V2?=
 =?utf-8?B?OCtQeEtQZWMyMU9mK2ZsQ2FHcFEvbTNrb0VFdFhYSG43cEZtU1lCeU1yMzhC?=
 =?utf-8?B?Y1lJWEN5U1h6RWc2SGIxTFVZVVQwbTNwUzNPK0JJdUlCZUVZMVEzY2pWQlc4?=
 =?utf-8?B?OFdWVnkvMjhPYmRsdHdPelVUNFBPRk4zYzhwWjFzdTlDTGVVOUhjNytvNE1N?=
 =?utf-8?B?TGJmalIreVVZV0RyeVVtcmVOeFlTeTg1NEx1NTRDcmhWS05vVkpuWDgxWWUy?=
 =?utf-8?B?SVF4Z0Z4K01vcjlNdmxkYVVqNmo2cWhyUGhhZXE4dkUyZnNTblBlQlhxOWZL?=
 =?utf-8?B?eEN3OFZBcWlrZnNLRjBqeVBOS2VBVXF1YVFMTWwvV29ONi9ud3NmVXlmMEJJ?=
 =?utf-8?B?MmE2N1ZvUFBlYkRUMEhmdit0bDQyb21JdzdyaUJPWFlOS3h0SlJySlkyVjJs?=
 =?utf-8?B?dUQrMHgvNmNkY2JidmlnMi9mdUI3KzBBRVZ2Zm1nL01TUjRjOFFrZkh2VGtE?=
 =?utf-8?B?TEtibUZWM1d2bm5hbDlvYlh2UG5oRUdGTTJDRjJSd1VjcHBTVWpYdmkzaHR0?=
 =?utf-8?B?aWRCNUVZaWlvNFFIZkR5MXkreDlGZVFSRHhtekpuZXYzTkNyNUpyckkzWTZC?=
 =?utf-8?B?VlFOL0c5dEhhZTBPa3Mya2J2NkJ1MkEyY0xxd3ZvTEZObDdSK1MwdkJMcmNl?=
 =?utf-8?B?T0hJZ1g3LzlaRW4zMHlHWEE2eExXZUVFNmd4dkF6WWpraThGQkxmLzBESnZn?=
 =?utf-8?B?R3h3YmNNWHBiWjJLNjBzTWYyZktkNVNqSStXejIwaExxR1JoSGxhSnlnZlpE?=
 =?utf-8?B?VG9UQTgzUXNXS09CUUpKY3dJbzhTS0Zld0FZamNNNDJZT3M1T3A1WkRYaHFX?=
 =?utf-8?B?b09mdjhkaXZvczZFdmdNUjc0dVpHVFNnZjdjN3dJNFJrMnJOOWN0elZKUS9s?=
 =?utf-8?B?UVlrdVVaTEdKc2tyUFMrdzdsb1pDcEl6bnI4VXVaRUFFbFZaTDdSMkMyOCs4?=
 =?utf-8?B?czFXQnlKejdkQXZabU5BREp3MW1BOEZ0Y01RM09xeTVEN1kzNHgxZUZZQklQ?=
 =?utf-8?B?Y0xIbTJ1czhyb0U2S1VDT0ozYXdMbm9IenVmbnRpTTZ6NXROeWl4ZmdKejhK?=
 =?utf-8?B?emJRVjdwR3g4VzZ6b01PQ1FNZ2pMb2lFMW1MMVluRmorVlJpY1VNL2RoR09W?=
 =?utf-8?B?TEZmc292SmNrbHpKOG1WemJhTFhBc20vM2Z1L0wyOXNmdFpGS29lRUQ5RXZE?=
 =?utf-8?B?TUdENVNjbW1mMjM0cDY5Y3Z3QzVnZUN5OUdZQi9aYzByYzg3WGVVdTQwZUFP?=
 =?utf-8?B?ZlFSc1F0OUJGbEVhZHVLamprdk45N09oaE9JOXN1WGlrSmFtWjEzMnpFeTdG?=
 =?utf-8?B?cG5vbHZrMHgzSFJMWi9mNUtRd1VuTWNzYkZsOGtRQUNtcUhIVnhUV3hTUm9y?=
 =?utf-8?B?Z1ZzL2ptekRuSVEvc0VoRkltS2Y1SDBCNUhyejJVemVpbUcrUlN6M1pIUUlj?=
 =?utf-8?B?QXJyZHkxbnNoREFtK2ZEZzh0VUhLaWxVRDJPalZQSHcxQ0JtZFhCeE5reWsv?=
 =?utf-8?B?bnJZSWM5QWh0cFhrMmR6dFRzckdpdGlmanR1bktnMm83aUdxdzRPd2VjdjhT?=
 =?utf-8?B?aUI4WHZaQVNBVUdVNVgvZ1JDZFJtbTNPdFRLNlQvVVBDT05BaWNwcm9vSnVS?=
 =?utf-8?B?QWRaQU5tT0NKem9ZYzhyY3RDYmx3ZVRqMk9qNks4T2RhclZIbkZoRGRBUk43?=
 =?utf-8?B?RWgxaVNXamUxT2tRcllLSW94bjhNUmplSUN6Y2NqMU5tT1B2ZUpzZk1wbFlP?=
 =?utf-8?B?cW05MG5OQkRwd1NVWjFocys2cDhsbm9hTEhveEkzTHM4czM4TXdIV1JFWXhL?=
 =?utf-8?B?N2ZTZ0RtQ2pTSzBjU1pwdTRwb2hBL1orNmZaSzFkaEhpdm5nYWIvS09GeGlN?=
 =?utf-8?B?MVdjaldFSHZJUHc3VzhLdnlDd0ZTMVYwT2pwM2JxcVFTeW95ek1XaEJXZWFB?=
 =?utf-8?B?RkgzVE1oRlhvMWFYMHdCS1hUNEt1K21nc0JWWk9QaU5jaENZWFF2TUhlSDJp?=
 =?utf-8?B?ZGJKSXd5UG1XdXM4QlFXdWtvVnNvdWlqLzJRY2xFS2ZTZWRCZm9JT0hWTWVD?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d72939f2-3aa0-4913-e3d0-08dac98c7b19
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2022 17:44:02.6120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: on19FzWNIP3x2BRcCwyvse/BUXc+l+eWdI0f5U6saHmOuKSzs7DAC0+BJ/+OOgv7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4541
X-Proofpoint-ORIG-GUID: Gy-wviDedfuFtxjT78GZdf_iyseylS05
X-Proofpoint-GUID: Gy-wviDedfuFtxjT78GZdf_iyseylS05
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_06,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/18/22 11:45 AM, Steven Rostedt wrote:
> On Fri, 18 Nov 2022 16:34:50 +0000
> Mark Rutland <mark.rutland@arm.com> wrote:
> 
>>> Not alarmist, but concern as being able to modify what a kernel function can
>>> do is not something I take lightly.
>>
>> FWIW, given that the aim here seems to be to expose all kernel internals to be
>> overridden arbitrarily, I'm also concerned that there's a huge surface area for
>> issues with maintainability, robustness/correctness, and security.
>>
>> I really don't want to be stuck in a position where someone argues that all
>> kernel internal functions are ABI and need to stay around as-is to be hooked by
>> eBPF, and I hope that we all agree that there are no guarantees on that front.
> 

For ABI concerns, I don't think we're doing anything fundamentally
different from x86 here.  So unless our ARM users are substantially more
exciting than the x86 crowd, it should all fall under the discussion
from maintainer's summit:

https://lwn.net/Articles/908464/

> My biggest concern is changing functionality of arbitrary functions by BPF.
> I would much rather limit what functions BPF could change with some
> annotation.
> 
> int __bpf_modify foo()
> {
> 	...
> }
> 
> 
> That way if somethings not working, you can see directly in the code that
> the function could be modified by a BPF program, instead of getting some
> random bug report because a function returned an unexpected result that the
> code of that function could never produce.
>

The good news is that BPF generally confines the function replacement
through struct ops interfaces.  There are also explicit allow lists to
limit functions where you can do return value overrides etc, so I think
it's fair to say these concerns are already baked in.  I'm sure they can
be improved over the long term, but I don't think that's related to this
set of functionality on ARM.

-chris

