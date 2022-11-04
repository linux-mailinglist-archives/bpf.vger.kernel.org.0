Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDB4618E7A
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 03:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKDCyr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 22:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiKDCyr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 22:54:47 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE876158
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 19:54:43 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 2A3NKe7g030703;
        Thu, 3 Nov 2022 19:54:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=txIGg8a3otlxUcr2Mz35/ilbs53m0KCKrn6WPZfkjnk=;
 b=E4tnZmwMmhp+abSUhviukm1wE0qt1hw5YYAp5saZrkauJIj7CvpUyan+TrJjCcnuNuZ7
 6gjjpIAl7IoesQxkxT5cAeMJdytPjrMJYviPtPdMgGPtyJHvNYYLlw4kNxnXJRKaxzOq
 FRhb3LpQsyG/WsSU1oEPRbUqFpcSbgdvcF0rUd8pDUHvhBO1MOCsoWrljUiV7oL2aOxq
 tBhjKExsZyHJIumN4N8T7jOGvK6tMyRV+W/RsV7+oTvAu4slAbNQnINhleUIulrchyt5
 +oKQ0lIOO0MkFSWemztScB3krNuJqUWhvBQU6NJlCtm925PGoOMjJRcPjeNoZV07D0MI QA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by m0089730.ppops.net (PPS) with ESMTPS id 3kmpgk9r3t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 19:54:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZpA/Xjw8g0jmM2MHMdYt9DNJfV0t4bmIy04L3nc9ItIrvxOHFTvoDqwXdWat8kkImqIHHCtpPMDdO3RcJTrJ06wvdeSAkvqlCIWXLTPObxLXZZBSzmcUQMlOh/96oF4SmJ4/ivmMvfUK5Zj2mI/SXWfuUPRxOyIUoDvCYE3IkU9Q3wfHNPPEd/sbG+Ee02izhNV9+sNV4T7rMLiy+pA5PaUGP4ntw603kSw6v1dNEt6uDBLPyDWclV7AoNubDKD4DAqBEGMTTD0/nxcOGbT9mhT/tD7bbv9gq4VYyVUW69JjpkygP7E8ZPBwBSWmmLbpvTUZRSUJ2vtdE75Bh7M+ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txIGg8a3otlxUcr2Mz35/ilbs53m0KCKrn6WPZfkjnk=;
 b=i+bEGarToP6TmR04GM6jCvm9rnCwX0gjGX7shucHbbg3oO1WHkkMerNEDBzPaQ9GVJMXiX+GYwteCK8kzLpxC/Gkf4On6MKxeufIRJNwkNsl8i/Ts2C9UkaQZgDDqGlTdwh5BoqMxUxUODpWFhWv26HapUaI9XxapWYZwGYq7Z2gOGlLR7gJrNPJfMxqlC2NpGbZ/A2Tb6BjDm2EO4mfhUsPDQpnuIXXZ3txwWcTi6ETvd8nmCL0co0yAa/8dmd7JCxVnAsYEh2hE6jzgN8WH94gkgULYgnZ+9umQdmiEsAk4vZyjDe1g286hgezs/KMzvT/WCYC471P81ACvDM0XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by CO1PR15MB5004.namprd15.prod.outlook.com (2603:10b6:303:eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Fri, 4 Nov
 2022 02:54:26 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::cb65:6903:3a52:68be%6]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 02:54:26 +0000
Message-ID: <b0e329c1-730f-5ed1-633c-5823a36c5a23@meta.com>
Date:   Thu, 3 Nov 2022 22:54:22 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v4 14/24] bpf: Allow locking bpf_spin_lock global
 variables
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Delyan Kratunov <delyank@meta.com>
References: <20221103191013.1236066-1-memxor@gmail.com>
 <20221103191013.1236066-15-memxor@gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221103191013.1236066-15-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: BYAPR07CA0073.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::14) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|CO1PR15MB5004:EE_
X-MS-Office365-Filtering-Correlation-Id: ef200e74-b607-41a4-0034-08dabe0fe278
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juTB3i91F2FXL4GeebWQnub5ZjIxOVxYpJdjg6DUErt22FCgj3+MyVdxBlZVAcFpVOiffybZCJg9DpGuTY2f029yVY3ynzGEPFN2R6mXdzFa+a31BcD+Z69h+KGMRi4vsS7iXe3CBGAIWIR6iTleKyV3nLxNzc2jh6xwJftXKYzoYpRDuLXNcR12M+GegxVjIKEgI26yfcAFM2dwnRCcZ/DpzMK/HelsPj34MKpCyeaqwYpgumwH51UK/nlIVU7ws1UvbP7tdSEnU8jwV6uoZd2VZzM9/pnue6hontuLwQgnEuf3SV2FOL/UHoT+sP7fyZe0vB/sL/wKM+ENm3+E/y4QYnYIRKqndqTGDzXFV24m5l4V69SEXHJfNRabdZlBxlVMigWbxhBt/H1uQiLh1z603Gqu3VHfj/E6dDgY5DJVVojpmK1F6wXxML8hLTjE8/a4TeliuMzg2JWakYJd9Bj43fQtFvV9XReYeQqvGTFJ2njYEjcM9AkxLVc2Ekl5/2/RSMZb8n7iVev0LlttiYbfhdOCPQcZ+r9XrJGxUh/4VJcNjDe8MjKIzEVJpn7kYP42/pbDigRpuB7DnLS4jgO1xHdMKi4YamQQD7xfxOwSfywzfXT1H8tp9CwfWdzy+ppRclCS1Z6cj/uah0j4A5niMoiWogScNWfc2nNWXK9ewGJ2XXdsCuwC1uzNBhgowZVY1pQtNMR/zYPjphx3pUTlEs1TnKL0FCzGAdgesV1GYTjxMvefEe1JQzuUsXzIU9VQ5/ZZcPD2IPbVxOkbpHNI0pOMk8klDsztWUbZaDXqfbgtnuwbviSjLlCPypTM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(39860400002)(346002)(396003)(366004)(376002)(451199015)(86362001)(36756003)(38100700002)(31696002)(31686004)(478600001)(186003)(2906002)(2616005)(53546011)(6666004)(6512007)(966005)(83380400001)(6506007)(107886003)(41300700001)(316002)(5660300002)(54906003)(6486002)(66946007)(8676002)(66556008)(66476007)(4326008)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tys1a3JScVozcGJQUVhDUWU2VUx5STlnZ29jSytEYlZyM1VkbFZxR0NxMjFj?=
 =?utf-8?B?ZUZRV2xrUUYxMUpTREt3VWp2WlViTjRKZlZmMXhMN1haRmpHcCtZbTYxaStI?=
 =?utf-8?B?RmtUUlZWNVJvNFNBL0ViNHVXUklXOVcyNkxBeTlNZzloam5WYmhld2lOUE1u?=
 =?utf-8?B?OHhnTjQ0bndRRmRaeGM4TnQxZElEKzRRcldGYjErOXFBWXpYeTNSbnYyb0NC?=
 =?utf-8?B?eDV4dXUvUGk1MHRTRkNWZVhlcDljMmoxU3dTT0pzZEFtcXJ4ZlZBRDloNDVm?=
 =?utf-8?B?Wlp6di9Hc0QvY0p1ZEVtcUJIQ0pjd0J0UzhZSWFaMTg2ZS9hUi9XWDVXeGYz?=
 =?utf-8?B?L2pTbEo3Si9QcmtQSVRzK2FUZytvV2RyYmZURTgra0E2YU9QR2xWeTFpWWZs?=
 =?utf-8?B?Q1g5WTZnWXlsL240c1pudGtuV2tnRThGMkw5Rm0rc1hXS0VZY01BUkdjZ3Zr?=
 =?utf-8?B?anFYQjgrKzRJRjdHbHQvbm5LM3FFaWRaOGQ4MTlkazUxakordHNXOEZRSUwv?=
 =?utf-8?B?OG5DTit2eUg3ME45a0NqZ2RodmdVTXBlWG5PQXhTc1B6dHNVS1N4d0tLd1dK?=
 =?utf-8?B?YTlYOE5JNnA2VVdLcm5BYW9rbHVSK0pGenN4RHc4bys4QkU0YjBtazdxUDhx?=
 =?utf-8?B?OFpGaUNRWXZhMVVVWjZNQUJLUlE4MVlNd2tSVTFhckNEcmtHVWZtc2o4UVRC?=
 =?utf-8?B?eEQzS0lLQjhiSmY2Tm0xSk9waGlYUkNTSEd6bEkrcHFxVXI5WjljdXpTczl6?=
 =?utf-8?B?bkpCWnNEOGZ4bGgzQmNLcVQ1MkwweWdoK1hOdlB4Snp5Q0NncG9oaUhGNlBF?=
 =?utf-8?B?RStBbWNZWVFFM0d3anJNazR3a3ZjUGxoOVNCWFE0cDFIeHZ2WlAwZ21MWUdX?=
 =?utf-8?B?WUZVV1BWNGZrZW4yOWo2b25kODhGRnRTbEpBUkxnY052b21pRDk3M1liem5K?=
 =?utf-8?B?OGtHVlIyQzY5aEY5d3lrRld4R1p6SGVTTFVRR3hCcjFjUE02ZzVNTHBFVTlE?=
 =?utf-8?B?dUx1SHhmaUplaHdnZmg0MXVtTjR5QWM1Q3N2ZzVRQ0tCd1ZsSlFySCtVUkhU?=
 =?utf-8?B?RmRNajBmQm1JeEV2bXJnb2w1cG1MelMvREx1aTVOWDRLc0hJN1VCSnMwanNH?=
 =?utf-8?B?cVFDNm9vV1dnc1ZnWERTcXVrbFIrcDFYN2N6akN6aFRkRWFyOXg4ZFloeklK?=
 =?utf-8?B?RXhuV1g0YWZmbVJ5M2Q1M2dvanR3ZWt2SHllWEdFODYxZUZHRVdpdFFNbTUz?=
 =?utf-8?B?Z1U2N0ZzZXRrdlZUMkNSRmpqZ3cvZm12SzhuUjZ5Ly9lcVoxTE04M3JObHpE?=
 =?utf-8?B?d1k4cXBhc3FjbGRMSEw0K2pPL2xOVGtVWUpUeU4xMTVVYVVYdlFZZzJKWnhR?=
 =?utf-8?B?K0g3QjN2ZGZUVnBVdDNUTjRuSlFxTTFYMmJsR09DdDBudkxnMk9TZGlWeHp3?=
 =?utf-8?B?WktMNTRSZHkwNFUrem9oRUliNGhSekJZOEJlUmQwalFmRVNOYVA0c0lQQWpQ?=
 =?utf-8?B?SlJVZjh0SSsxVDNHNENJOUV5ZzdNT1RmMUp0NzhkNWdEdStCQjVkVTQvbE11?=
 =?utf-8?B?bDBmQXBVanAvdC9IdEFtM3RhM01wOWFRamN2YXhQcXdjNHM3NVNQcmM2OUph?=
 =?utf-8?B?UkV2d2tFL00vVEZkQ0V5cmxPVjRYWlRncllGR21XZG5PeGlkMGVPRlhxYjBT?=
 =?utf-8?B?NFJEdHI3aGptL3ljQUJKNjVEd29TSVZIeGtNbkxsRGIvby8vZGJZdHFIcklG?=
 =?utf-8?B?TUNkVURVMko2Njg0L2dKaDcyN3pHdmFkZ1NpRDVNNXdSL1E5bzBma1FSdVhu?=
 =?utf-8?B?Nmo1TitoMGgwbnFKTmdRUSs1Z3hJNXAzZzVNVzkxRU02dFE3L2k4QVpmS0FY?=
 =?utf-8?B?V0dMc05ua3dCTmxnaWJrQzVyeW1wZzRqelhOOE8xdXl0QUZPWHNucVl0aCtq?=
 =?utf-8?B?L1NvbDJveEQ2bzliaVExQ1BSL0Z2bDc1WE9CaStnay82UzAwU3ZlcDEwQW5W?=
 =?utf-8?B?dGFVY1RkaDdlSjJBNTd5aDM4L05oYnZYcG9iSzBwelJuRU5ONHdaMFU0MlZl?=
 =?utf-8?B?MmZsREl6ZEY2V0h4R3RpOTFkWGFiYnZRNDdvRTQrK2d3cFFzcWNjOWZIZExn?=
 =?utf-8?B?cmFnWlRnTmRoaktEemkybzZTdy81VUpBckZtV3ExN1FWSkMwc3RjczhERFcv?=
 =?utf-8?Q?RbntVXD7m5xOZ49GZDVtLgY=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef200e74-b607-41a4-0034-08dabe0fe278
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 02:54:26.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iiJHmvS2aAqgiViLIcDRxunlten7xbYkrj+ESShmTP9bhvsm8YBRjNFeinjx6ucfHUi/Ojogdf8pEXd4vJqD8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB5004
X-Proofpoint-GUID: jLRYNDg5Kb1_4DFZTcFWyFHtu0ngcCrk
X-Proofpoint-ORIG-GUID: jLRYNDg5Kb1_4DFZTcFWyFHtu0ngcCrk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
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
> Global variables reside in maps accessible using direct_value_addr
> callbacks, so giving each load instruction's rewrite a unique reg->id
> disallows us from holding locks which are global.
> 
> This is not great, so refactor the active_spin_lock into two separate
> fields, active_spin_lock_ptr and active_spin_lock_id, which is generic
> enough to allow it for global variables, map lookups, and local kptr
> registers at the same time.
> 
> Held vs non-held is indicated by active_spin_lock_ptr, which stores the
> reg->map_ptr or reg->btf pointer of the register used for locking spin
> lock. But the active_spin_lock_id also needs to be compared to ensure
> whether bpf_spin_unlock is for the same register.
> 
> Next, pseudo load instructions are not given a unique reg->id, as they
> are doing lookup for the same map value (max_entries is never greater
> than 1).
> 
> Essentially, we consider that the tuple of (active_spin_lock_ptr,
> active_spin_lock_id) will always be unique for any kind of argument to
> bpf_spin_{lock,unlock}.
> 
> Note that this can be extended in the future to also remember offset
> used for locking, so that we can introduce multiple bpf_spin_lock fields
> in the same allocation.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  include/linux/bpf_verifier.h |  3 ++-
>  kernel/bpf/verifier.c        | 39 +++++++++++++++++++++++++-----------
>  2 files changed, 29 insertions(+), 13 deletions(-)
> 
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 1a32baa78ce2..bb71c59f21f6 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -323,7 +323,8 @@ struct bpf_verifier_state {
>  	u32 branches;
>  	u32 insn_idx;
>  	u32 curframe;
> -	u32 active_spin_lock;
> +	void *active_spin_lock_ptr;
> +	u32 active_spin_lock_id;
>  	bool speculative;
Back in first RFC of this series we talked about turning this "spin lock
identity" concept into a proper struct [0]. But to save you the click:

Dave:
"""
It would be good to make this "(lock_ptr, lock_id) is identifier for lock"
concept more concrete by grouping these fields in a struct w/ type enum + union,
or something similar. Will make it more obvious that they should be used / set
together.

But if you'd prefer to keep it as two fields, active_spin_lock_ptr is a
confusing name. In the future with no context as to what that field is, I'd
assume that it holds a pointer to a spin_lock instead of a "spin lock identity
pointer".
"""

Kumar: 
"""
That's a good point.

I'm thinking
struct active_lock {
  void *id_ptr;
  u32 offset;
  u32 reg_id;
};
How does that look?
"""

I didn't get back to you, but I think that looks reasonable, and "this can be
extended in the future to also remember offset used for locking" in this
patch summary supports the desire to group up those fields. (I agree that
offset isn't necessary for now, though).

  [0]: https://lore.kernel.org/bpf/311eb0d0-777a-4240-9fa0-59134344f051@fb.com/
