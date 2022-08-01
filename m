Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F80258740D
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 00:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiHAWpN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Aug 2022 18:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234970AbiHAWpM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Aug 2022 18:45:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27CD203
        for <bpf@vger.kernel.org>; Mon,  1 Aug 2022 15:45:10 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 271KBKnl016663;
        Mon, 1 Aug 2022 15:44:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=R1HBc0eE6DzlSxEJNNR71lDybMQ1j8UP86gieL7QzFk=;
 b=k/BMyNzn+5rsUB3TqbFqVfK15AI7NspTK5BR7eS/tqAIZ4paFxo3/66b1d278WY7cQcD
 gknRTzzFEWP+2tbFlJ/0qY1btelWvNW9N75NCU7vWBL8gYplblCJWRifEMnoLAwKVdiu
 7ALwsDoR1hwa07MdHJELx7nMOX/W7EomkIg= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hn25xf6cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 01 Aug 2022 15:44:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beMpl+FMx2kqa1w6UVSz/E/pPgHGUI6dSTGtOxw2Yb19dwlNLOFFtgDOUcCmV6EK1HhqRvKHFqDgeqxtcLxICHanGKJYM4993i6P/7KODW2lv6tzzv82Z5UlFrUxXo0KaklCK7FImkGihwJmejRaUEx9KSizov2C+3fsV7i4V1TsbvD+Y/h3SZTuj8z9IxZUnMKEesu4TabkdVSQh3Wc+Bui2aQu6gB62ML+vCBo80wkmht/xHOVz5SrX2LbhRFUmQx3x0YJxvR5jGPj/YqJUK4OMAxcg9LUD+2qWoi8rHB+kGW7T0HfjDyTqAltOrRtsKasm60w+hn/cBJAzsGXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1HBc0eE6DzlSxEJNNR71lDybMQ1j8UP86gieL7QzFk=;
 b=Nckeah4Onf5yxCj+BzB4dX5MUaOiqT4Fx3YIbepHOHg3Q73zHungXC2YqCZsYUhVPQPZR7X8U6t8nzxEqfFdHyqp16X2snEMd3QWiuMOFvTQ9XrOLUTQu1+Nk5o8s1aHnJyrKvlLv5cwuZcAMok5E1cUL2zU/syXYlie+QbRyApvdxzHSLup9ybElm+rNybTlfaE/QrEaGzkqcvtzrVZKvWD7ZswyzJuviaYf+PwGWZWxisBYSYNfxIcv9Mo7KSqu2udcdOI01WDUrZd01KzSO88nZnGHuumG+2ofJFxQb5xLlSXqwSx9lDyPCxh2VuxXpZdmb1gEFS1sxmxNqk6Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by BN6PR15MB1764.namprd15.prod.outlook.com (2603:10b6:405:4d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Mon, 1 Aug
 2022 22:44:55 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::5457:7e7d:bdd2:6eab%3]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 22:44:54 +0000
Message-ID: <33123904-5719-9e93-4af2-c7d549221520@fb.com>
Date:   Mon, 1 Aug 2022 15:44:52 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 10/11] bpf: Introduce PTR_ITER and
 PTR_ITER_END type flags
Content-Language: en-US
To:     Dave Marchevsky <davemarchevsky@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <20220722183438.3319790-11-davemarchevsky@fb.com>
From:   Alexei Starovoitov <ast@fb.com>
In-Reply-To: <20220722183438.3319790-11-davemarchevsky@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0154.namprd05.prod.outlook.com
 (2603:10b6:a03:339::9) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d115f93f-9b8f-42ad-61d6-08da740f738a
X-MS-TrafficTypeDiagnostic: BN6PR15MB1764:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9suMloDdAoIDpm6d1xWYakS8sSVELAUMmwxpxLddIKH8WJO9OhGNsEjkdmJNTyovcYMCoq0selupbNoEI0oPDTOMtQ7Uhle+Phz1g4bB9HAKHAOD4u7cJnTh9Qa8+O+SNThu+9+UFt23B7wN4xLRKK5X6Ea50+4tMePnvcfkIi4BeQafJyNuAjiUwoF/+iiBayAeDtmurenIUbsT+7P4jmkhSRkwS7kGwcHYwmmDcvDVlq4wz63eea22+MiaqzxIxglkwrZPB75T0kcguRv8Xh+Hcvse4FEPcpoNjnj3TLM8eJ7nJMI/IZakLCQkZpLLoJ3Hn9C9LbyolL53fVEHQn+BrpL8sTEp7E9kQaiBbyCy315XECAWd/p03U7n4Y/HJ+aSalV3bmbDNQljTXbI3DzJbJ/7JjqVzOqinZC9swauZrepJPs3i+h6o9GPet7EMQkq0+oJTJYftytKmZi4pjsQuyGwSE6oHQXtdzD55oUMZVbxvmbFPy3TuUKTGeXAWdsCeEy6F5xnfq/uaGI0wcY2EY0FYiyByFAwiQlc7mvNDrRKU4R7V12GPmfJWRyPt025WoSj+mNRQyXidotP7/RoCgrdP7vZQAqDpcaCmq5QYr/dpQwl8pDbOC8LCaRigC9yghsUUWAQYgOF6kKS00pP8EuDMA0kLc74FnPLRiDwOHYlQk1d9SG+d6KoF3baWYBCUFHaDbXt2LbNOEQZ4e+jD5U9pPr+Vk9dXymyppeMY+RsCqmPtd26gVrFx6IUYMVdLtTm5mQ834wkooCb3MIqW1rVbC00OJ6X+xn+NQWYQpbtOYdM230z97mNWOSWqPAjRcw6VsC9ITsOJVnfFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(366004)(6506007)(83380400001)(52116002)(41300700001)(6512007)(2616005)(186003)(53546011)(31696002)(38100700002)(4744005)(5660300002)(6486002)(2906002)(8936002)(36756003)(478600001)(86362001)(66476007)(4326008)(8676002)(31686004)(66556008)(66946007)(316002)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUdraW9xZmIwa25yaHNjMGFwYjdwYkM5dmFFZkpvVEtsSzFwOTB2OGlsKy9p?=
 =?utf-8?B?eEcya1JUb2hqK3pKTjQ4MjdFRWN6QWlhbE5HQVBTQ0lxWDBtOS9YS0xUaTFY?=
 =?utf-8?B?MjBENy9oTENDNU5wc3JYNzRNRUltYzBEYUdFVktlWDQzOWxRUjRBa1RrL290?=
 =?utf-8?B?a3QxbGlrREJhbmdNbGkyOU10ckhRRXNUSGNMUVErSEhNVE84NS8rSVFJU1F4?=
 =?utf-8?B?bndHclB0MHRNNU5KbzIzNnNrcko3TTYzWVJlZFFxUHVWMkFPaWF3b0FWVnQ3?=
 =?utf-8?B?clB4VjdOZEhZRElibm5nQkVWUVgxOFc5RTNBMjlEb3daVjl0SlEyTUZrWDQz?=
 =?utf-8?B?UVVQNlZiWjZhRmp0TG05eUplRzM3ZmZCMURZZHQ4T0k5YmlJMTYyUERPbGhv?=
 =?utf-8?B?UERkWlNKc3BnelZoVkViZzJ5aEVKZkNXWWt5dkFOSC83SkRWZWF3SkNJSWNP?=
 =?utf-8?B?dFB0MEFtTXdJall6aWlicWJFMnVsa082N2dwUnhZbEZoQmxXZnl1bFN1NnJE?=
 =?utf-8?B?NjdoQkhXMG9ETDdvOHBPY2pWZFBVQ2svTVFpb3g3RTFBVWhkeTFVY1RIVmwv?=
 =?utf-8?B?aGIvUEJVL1o2NDdYb3BpbW9LYnEzam1XQWVqc2ZiOVJkY3VlV1JRR0U1T0Zt?=
 =?utf-8?B?Z3ZhbE1tR2Y1Y2U3blVacURYWU1hbzdDbktTb3Jpa2ZuZHorSmY3NDEvSjRQ?=
 =?utf-8?B?UW5BY2FtbGs5ZGt1Y3NSMElueThlMFdqZVlxMVRsMms1WmpUUnBwdTVnZUky?=
 =?utf-8?B?ZThrTWVtRVF5dTNDc2x6c3c1TXFBN1Nqcy82dmNkYnAvdTY5SkFuVk5HU1do?=
 =?utf-8?B?ZzdQdng3NkdLSHBIQXM2MFRTRW5weW9Ca292N0NReDd0TlBnancyUFRjMjNH?=
 =?utf-8?B?T20rUEV0TGlRQkgzT0VyOVpsV0tFRzNOaTNZR2lvRGdtajI0dXBuRDMwVW40?=
 =?utf-8?B?SXBBVmpSejh0aEtDZGR5dTEwK2I3TmU1S25mTE9vSHZUaE1DZE1ZYWlXWHpH?=
 =?utf-8?B?V1lKak5xUHZmTk9mYTgvVTFIalA0cVhQc3RWZjFsQWl6ajFFaWhIL04vS0Iv?=
 =?utf-8?B?bDd0c3g5TUZscXlYcCtTNmFwYWFkUVhheUI4UGhrYngwOWdNYit5cGVMdkNm?=
 =?utf-8?B?Y0NQb2RnUTYzTndGaVFnaEFZczJ4NndjdnJMOGRZMGFSMHNRM0t5UUdPeU55?=
 =?utf-8?B?NHJFSmlqQmZGQ0VGYjFpcXhVS2tLTlN3VVFzNnNVZTlIMlFPb2xQd0I0NjJH?=
 =?utf-8?B?WlhWMmlZTTJBMkhpYjNFUkRNb21iVEdTUmwzWEtrVGVtNUJ4eWFTcWxDUnRZ?=
 =?utf-8?B?MW4yMi9LdWRsRy9icWZvZzJSSzJoejBNSGsydFFRS25EdG9ZNUZiRXVZNzhz?=
 =?utf-8?B?R0xscDhOWWdDNGFmOFROZXhoaXRLRnBIMUQvWVBQL2pCRzNVclFtSUhpRFBh?=
 =?utf-8?B?NGE3VThzY2dOa1FJTC9ycnNSbEZSWkhsVTBZM1ExWDBWY0x6OVdLNlBVUEcr?=
 =?utf-8?B?RzBXNzVkZnV4UlcwMWhHS0d4Zng5R0Fidlp5eFlWVkladnhSaHhHcXlRcWpx?=
 =?utf-8?B?RlYxV2ZhZmdQKzhVUGlEREtJdXJZNTlZWjJnaDc0UkZVaE9MVkp6eldjWldo?=
 =?utf-8?B?WFY2ZDVudFl6RkM5bWlPanpsUVpjbHlwM21rRnRZalJobmQ5b1o1dWVNNE1h?=
 =?utf-8?B?WkJnN0Iwa3hycmpnSDhiTjdISFhwTlBzMlhTcUVnNGY0b0lIUG85NTR6SnFG?=
 =?utf-8?B?MDRVdXZnNklFZDE1a1VjWDExUTNnUEJxdGxCeGo0UjJFTUphVnhLeFI2L0k2?=
 =?utf-8?B?MlVzZ1hNTGZmeTZxT1ZkRjBHdHJGajRrM1JTOEdaOW51ZlRTRkRYZGRoSnhz?=
 =?utf-8?B?M1dKSzFWYnhGY240bjFQNmtwNmE4SFEvdThyb1VRR2tHeUN6NDN4S0w1eDdK?=
 =?utf-8?B?dUlUMzBFUVgxRDR0bmhqblpMci9yMnBWZStMYXZXeTg4dWRJMVZsZkNYbUV0?=
 =?utf-8?B?KzZGdVlGd0x6eEZZOWVLQWRmYjFpQ21CUE1LUHBrNFA0MWhjSmhEd0tVQVlU?=
 =?utf-8?B?TVBiV2NTOVhha1NyRkxBTFc3TTBYRnJ3TjRzakxLOEhKZUhzOXdNZGsrYVVK?=
 =?utf-8?B?Y2hTRStjOUloZzdmc25IZFNQdms5VktoaG5rMVRNRTQrSnZyaDFLeEZqQ3cy?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d115f93f-9b8f-42ad-61d6-08da740f738a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2022 22:44:54.2812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3FpcLSbRr+eAnjaRFTc8EDlulkDpj+pJW5Id5Diit39hRkLo5ZcCyctJhUZWNtYG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1764
X-Proofpoint-ORIG-GUID: 5eFD-FV1UjhYXi5l_fBz_UPbUJRHD2d6
X-Proofpoint-GUID: 5eFD-FV1UjhYXi5l_fBz_UPbUJRHD2d6
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
>   	if (__is_pointer_value(false, reg)) {
> +		if (__is_iter_end(reg) && val == 0) {
> +			__mark_reg_const_zero(reg);
> +			switch (opcode) {
> +			case BPF_JEQ:
> +				return 1;
> +			case BPF_JNE:
> +				return 0;
> +			default:
> +				return -1;
> +			}
> +		}

as discussed the verifying the loop twice is not safe.
This needs more advanced verifier hacking.
Maybe let's postpone rbtree iters for now and resolve all the rest?
Or do iters with a callback, since that's more or less a clear path fwd?

