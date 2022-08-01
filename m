Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00658735A
	for <lists+bpf@lfdr.de>; Mon,  1 Aug 2022 23:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiHAVaW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 17:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235258AbiHAVaD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 17:30:03 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179675140A
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 14:27:19 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KBQoJ023039;
        Mon, 1 Aug 2022 14:27:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=tKGlt77IUS+X4nShxtbx2FUZ5/8xaFByEUihLQyN3y8=;
 b=IUd/q4KqZ92pKU73lh+wnnPWJlxHpE0n4XUVUAEUeFMA5ZQRimV9LmYbEJ7/LcINZBJK
 BX6Egc1svrK9+pOfy1NkeBjBSG1g2JOPJX7dLHfTXVVjWEPFgtWTKfLY2Ks/yGP2Hw8I
 +gVWAlmcEMOhFINZz145cInsuATr1EhEwAA= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn0pjy0nk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 14:27:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3XQfGxEQyRYtZvn92bQrDnd6VV/4lCB0/+sd+6JUH+kXhVkH8rGsyJ/50nGXVr5wJMDdOgcr+LD6J7JVYRKQl2BTOAEMpdSOcUugG7gEIf0aptvP1tQ2SlU6T/obeieV/IcwjBuVUuTZhHn4zw19QQmmPfmhuiEVYMPwLSp01xK1uaPxURVlI6PNFpghe/EnUClRuPYYOJmDGnmDfZd44XtWsPtK6zc0DbA4P/9y3KjJjTCvcH6ZQjONGvKCkmVvofDlup64A+zaJQmxupFtHBVJ8roA0Lf6g3CykOCbvpLhzl2iM1CRWKLm50ONTmd6FYefd9wFuPcEHmjW790vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKGlt77IUS+X4nShxtbx2FUZ5/8xaFByEUihLQyN3y8=;
 b=IiLq36moPGPkwbdPZalZEeger0FN/oQYSAldw13GxUkz/l99c8P68H5K7KkcBKjpjfqdxtzq9GHpNFGKH7PMFqSt4RS+u7kwNGHPt+L3+GnavEt2+MtPWeer6jP0pRX5jryU1NwPKr+5ful/JoPxFzR8/yc6OKwMAwkFVlLLmXFv+qysjNb9y+2C0Z5+Y1iCTNNYR08G2a3xmqYhQt9pvOO4NgcE9AZevm171mkXHXVU7JQFpCzfJ8MGP6GUNP1om/bq7NKsYTLp7zEE3dt1nP4RTZGpUxkLwtW7cBkjjXD4zf6oczk3Gkdsu9o0nI6IF7KNUGSvSoEg6664wvBmNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by BL0PR1501MB2178.namprd15.prod.outlook.com (2603:10b6:207:35::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 21:27:02 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 21:27:02 +0000
Message-ID: <ce6163e4-bee8-3bee-d0f7-503648fb55cd@fb.com>
Date:   Mon, 1 Aug 2022 14:27:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 00/11] bpf: Introduce rbtree map
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20220722183438.3319790-1-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0130.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::15) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc9ca6cc-b2b2-435f-2ff9-08da7404930b
X-MS-TrafficTypeDiagnostic: BL0PR1501MB2178:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Dj0h7RGAEMY5OO3A5UCjmmeHtutjiQHwe1C7CgZqzSQME6IUEGP4PqekOBgiZgDQazfDZWCz9Jyuj4M+9FWEaoKwDHQ3cWzHWoUKZ8dSfgHiTrR6vpGXXCnegbNgYHx/kUO/pdEDfRXq+9LSsjgrNPwQNu16KzBOZASc4OKD4SkGNNZaimKnbmOVLn2Ds1mwW7yYYpVhUzgyXCSbLvPwlyt4QeBLK8FhT9nBpgo6zm1VPj3+PlBSs8SJCQpQMDqIMYAGLE6A1Jpz9eV9SqfR2Jfz4miG+U5vWmc4vYC5Nv9zVfFqPz+YW4abmHQo9fFOTX/db48vi96XnJNhFtDtm74HHKdCCTBfX1fiJ80lwi/eaFIFQlWOJSYwXtHlXoSMwMsLihgY4TjG4njO0NZ0DbWB1tabokrpaUje2CaQk+heP1P2oHgibZHte5lkG4P5HIa4dYN6V3X6Ce+b1I03p1tbFHmOwUcD0scYUkQm2Ugw3HllTlz0SAGaiK05UlhCQ9ohcCETmPvxd7Q+nD8JMjjlQTZBl3DqLjmO9We8iVd+A0TOxxPcXapNMdtdOH+zPTE+J0sIQgwj6wa6faP7XWfx/P/Q3nj2kvTkc7Hvl4DknaS+MbzdEUVUJhdtHvgOs3NqnPOXppqNjVu0kY8xX6JW38mwTdUYyktff6se5cYNFdQ+8P2wc1Nii+i6LLElaFXvZ+ctaBvfpIztQDXZYNDkSPQ79lAXRXKCt81uCincScXrpbPA7mDYb8cxQ1zBzEfy59JeMl5G9qlRZAg5JBm+yFhunLdGppL6ShU3MPuSQrZyGD2RcXzbj2KFN7OkOh12J1n+GORhhdxxhJxMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(86362001)(38100700002)(5660300002)(316002)(36756003)(31686004)(54906003)(8936002)(66946007)(83380400001)(66556008)(8676002)(4326008)(6512007)(186003)(66476007)(52116002)(478600001)(2906002)(6486002)(2616005)(31696002)(6506007)(41300700001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFNyNDBvbDZMcWEyWmJUK2VXU2ZISkNueVNGSnhtSVhqc0MwRTdtbkZJU1I1?=
 =?utf-8?B?NGJUTFRlVTgvNGF3TkpuOEowLytDM3NhbWViRzNrZXVKVlZlWXM0VmJtMlNG?=
 =?utf-8?B?RzQxZHl0T0tqNkx5aE9TaFl6WkdjRjVwSHZ1U29CNjVZTXJYN3R5Y21nWTAy?=
 =?utf-8?B?YVdkcDlHV0JzZXpBam8xK2JWUjk3OEVmc1lqRDBUd3VoS2REakVXY0NPQ012?=
 =?utf-8?B?Y2tTM3RlRm9oYlF6Qk1YVEYwOVR4QS9SbHVuVXNsWWUyc2Vld25WSlFQM0VZ?=
 =?utf-8?B?MDVESnNRQnRnd0x5bkh5Q1RucTdHSi9qcnlUTmJ0ZTdBcFRWbldlcFh4Qkwz?=
 =?utf-8?B?UEhpTzlXSlRyV003S1Y1bXpvY3lUMkpncnVsSVlWdDh5dzN1QnFCQXBDdUxQ?=
 =?utf-8?B?WGxieTJuZ1ZuNDlNczlQeVp4S1orRzF5b01QR1NNbVU4Y1hrbENJVFptb21p?=
 =?utf-8?B?R2lDSEZLOG5QVXREanB5TDFuRlNOaTZyVjVTQ28xUGp1R1N1YTNwSFdrVURY?=
 =?utf-8?B?blNuL3VybHorOWhRNUVoNFgxWkwvQnBseWJDdmJtcEpsQ21zODVIV3VWd01Q?=
 =?utf-8?B?VU5LVFVHdTBsdWN2RTc5cnJEbTR4UHA5WkRxNDNQcGN5MFBEOUx3ZjBsVmto?=
 =?utf-8?B?V1RCV2JTbFhjRlhFRVB4eGVscjJDWHJoQU9nUmZhNjcrWHVkTGNNbXBXOS94?=
 =?utf-8?B?YUg2N2VjNUZBSVZldjZFWlErMndFbUZWYlZTUTgyQWdXeHBoeFZGN1FJc1Ju?=
 =?utf-8?B?R0p5alU2bGxjY0dIRndQMmI3enYzQXZKTGYvYXFpL3JSb3BCSm12MEx3NWUz?=
 =?utf-8?B?RXpHTytnai9FbG9neXZud2VyWUJnSENjSFE4Vnc3MG1kd3l4QjhDVSt1SElK?=
 =?utf-8?B?Q1Z0N0d6Q0pKMlBra1AxVkpsR2pVbDdvc3NFWFk4M0Y5MVRwV0l2VDdSaUVZ?=
 =?utf-8?B?eE5kM3BHbGRjTk40OTIxckNNNy9Cc3V5MWdCSlliRjZPN3JhdGRLSUIrY2Ex?=
 =?utf-8?B?bzdJQlZ2SFVOYTFkd2UzNElsakRxN2FhaWVSMFprT1ljb0ZOR0c0emF1cTN6?=
 =?utf-8?B?SFl3UXI0eEdvQzRTYmV0TXNTM3NEZVVCK0VaeWJuUDdoUnpuR21EQUxVQnlG?=
 =?utf-8?B?N1h3U09ZSndwY001WFJmNjRjZDBKQUZrenV1c0I5SEpqMkxQMHNDS2VpZEFZ?=
 =?utf-8?B?RnhKZFFFUVdyU3RuUWZjbi9ZeCszODlISm9kTEZ2cDVpci8rMWd4QnZsczVa?=
 =?utf-8?B?MHJlRjRmNTJsR0Evb2ROMWpmODJ4dlRSNWpyc05LRFIraEZIS1Nsa0drVHNN?=
 =?utf-8?B?QzJYcll6N1k4NXJEY0JEVS9qZmtYM0pmTnFGc3MzVUxoU3VMNDBJKzN2bzhC?=
 =?utf-8?B?VjBnRG1YSlMxeHFkZzVUcXpkdW1iRGk3Ri9OblFLK3ZoUjRUcTF1bVE0VzNl?=
 =?utf-8?B?VkF1UFdBandoeGFvYUsrUjJtZHZBc3pPWDdyWUdQS0JUdk0wVXF0Z0tzRDBt?=
 =?utf-8?B?NSs4MlhzZW0weVhmeko5QjJQZTZLbW5DTUI1bUJOb1ZadGZteVk3dGtWSVlx?=
 =?utf-8?B?aTdWQVBuUFVyM0RmcmxsQXE5YWtacTRpWVJuQ1BSYjZvUkREV0VUK2t3emc2?=
 =?utf-8?B?R1ZQMzJyb1p3MUpBVm9nczMvNEI3WHhHT1pOalcxMlRiSk9abFF6RTVKUXJj?=
 =?utf-8?B?bHQwMXNQV3ZIL3k0MGg5NmVKaGsrV3QxcHlQK0F0dFRBMWVhcWFBZk5Zd2ZG?=
 =?utf-8?B?VnNjRVg5SThmamJ1cUpUdmpJR0tkMjV0a1FNZkZLVTliN3R5TU1FMDI0bGdw?=
 =?utf-8?B?WjJmTUhVM1RNQUwwL0U2dC9oZVF4NXFYOFlnaEM2SGxaUDVWbk5SOWRBV0Ns?=
 =?utf-8?B?bVNwaWs5N1Nrb2t4enFoWXZrZWlKR1hnT3ZVNFlldHpmMzlOYTViQnQzeW1F?=
 =?utf-8?B?eUp1SHJvTDFjQU1QcmVwQ2U2WCtuSzVQcmpMbzh5UGN3QUp2dkxIczVzWEV3?=
 =?utf-8?B?bDJ4eHFqNnJxY3dKbnRkMUVzaWQ3V3pLMWtZdlRsYTUxU0FmTXBDTlF5Sms5?=
 =?utf-8?B?Ni9LWXBlOEZPeUFNK2czRzgrR3dkSDlZS1VXM1VJQ0FydWFtTisyUUlieHFF?=
 =?utf-8?Q?EoRW6WJXa0y479EKjEZvRXXFR?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9ca6cc-b2b2-435f-2ff9-08da7404930b
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 21:27:02.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l1U8TzK+WN3oekC7wmB4nsOTrhyQoqtu2cnr2x7I2BRtvuA3w0GxDbSN4pizRhEN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2178
X-Proofpoint-ORIG-GUID: TlqC2OFWypR19sIWKlHwoX8lIJFHhDTJ
X-Proofpoint-GUID: TlqC2OFWypR19sIWKlHwoX8lIJFHhDTJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-01_11,2022-08-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/22/22 11:34 AM, Dave Marchevsky wrote:
> Introduce bpf_rbtree map data structure. As the name implies, rbtree map
> allows bpf programs to use red-black trees similarly to kernel code.
> Programs interact with rbtree maps in a much more open-coded way than
> more classic map implementations. Some example code to demonstrate:
> 
>    node = bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
>    if (!node)
>      return 0;
> 
>    node->one = calls;
>    node->two = 6;
>    bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
> 
>    ret = (struct node_data *)bpf_rbtree_add(&rbtree, node, less);
>    if (!ret) {
>      bpf_rbtree_free_node(&rbtree, node);
>      goto unlock_ret;
>    }
> 
> unlock_ret:
>    bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
>    return 0;
> 
> 
> This series is in a heavy RFC state, with some added verifier semantics
> needing improvement before they can be considered safe. I am sending
> early to gather feedback on approach:
> 
>    * Does the API seem reasonable and might it be useful for others?

Overall it seems to be on the right track.
The two main issue to resolve are locks and iterators.
The rest needs work too, but it's getting close :)
Will reply in individual patches.
