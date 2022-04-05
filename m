Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4115E4F213E
	for <lists+bpf@lfdr.de>; Tue,  5 Apr 2022 06:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiDECla (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 22:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiDEClO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 22:41:14 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7785B2D7D73
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 18:46:11 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 234NPDhf019444;
        Mon, 4 Apr 2022 18:00:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=EoW53Z739WDT+zUMnSjaF0LQaj9cjIJ4p0ChMSMb1Ps=;
 b=MKKxXlqHHprcMgtDIHCxsBhN1leXAZ6aM0cDYDyPdrOKxmsDEkkvwAfCQJW3CAjtseUY
 lHvRg5HhIXFIlNVPUWC+E6DeGGrgRMhXCgFHl3T4jaLIBBsK7cVqP3HmH/sFDl2VwLL2
 W8bVFkQ8dc6YWMgvsBnR/lcAGpRTk0vRl9Q= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f82704fk8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 04 Apr 2022 18:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHOMbyaEr/CtvBRusi804Sh1v6JOKnBlq5q/hu0AdHVfiEveYna4NxCFjXZTvnn5sPG+2/d8i9Zv57ROqscX/3AqtFTndi71RAiZDw/oUWy6uKeepGV/dUW4lgx1UP44YtvhYC0haoKhCJowN2ZCp8JyXnYqdb2N3jHWQsshswj+HEE6lFDUzlYyC1jJqhUiyGZBZ5L+Rkjb/Wf/sKAPub+ggfq+BRTL+Bvgs0X89eF905Dn3Nvh9R1xTX+2JjkTs4KT/eizHtQqL1fFbvt5vVeM5bSmZbniN8kmGyCFeRt2p4stdEMuRTRD/H+sxqbvgXVZTDFvCN1JpXHDjq1Ktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFXRT9JCnfPT4lhW/t926qh8zCgjggbtUeB46e45pRA=;
 b=O2Nr2fwsXdXX9x6hHMywZdifqxu0PDoXKAb97UJpPTLtY2wwpzJ0Q3S0rOQ8ahynZcvx+I0P/URoDjt+KGJWbwWAgsXOuL+r3jFZY3Ej7ieBsAAN18Y15XL1ncZ8mAoXbVvTLvnK5u+174YcRaIVnM6nwi1zt3iP+lRShLOyhDr5h9c9oGCYbokmCjoJR1Ydjy+WbwnczSBnKAHpvH+VFV3UNNZktuecMHY6qLdX0nwqKoUXApF/6GfD+81KA2jvLMQ67QEDCn/RCzzkycBlS0q7SEgCwKMeEx+dge7I+Oj+r5QcfhwHrmfSMR/0xim7qZq15zDDfzzpzlYUHAThVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by SJ0PR15MB4662.namprd15.prod.outlook.com (2603:10b6:a03:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Tue, 5 Apr
 2022 01:00:17 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::5ca4:f6e8:5d75:1abc%8]) with mapi id 15.20.5123.031; Tue, 5 Apr 2022
 01:00:17 +0000
Message-ID: <5b7e5a08-a2aa-72dd-8bb2-7b10e7ff32b4@fb.com>
Date:   Mon, 4 Apr 2022 21:00:15 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v2 bpf-next 2/7] libbpf: wire up USDT API and bpf_link
 integration
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
References: <20220402002944.382019-1-andrii@kernel.org>
 <20220402002944.382019-3-andrii@kernel.org>
 <22359fb1-33a2-ee2c-4300-a07b175825e6@fb.com>
 <CAEf4BzYdhnGE7HZLrjF0E2-XFwVrQf7G=uVaWJd7p2qaQMsvTg@mail.gmail.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <CAEf4BzYdhnGE7HZLrjF0E2-XFwVrQf7G=uVaWJd7p2qaQMsvTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
X-ClientProxiedBy: MN2PR12CA0022.namprd12.prod.outlook.com
 (2603:10b6:208:a8::35) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49cb2b26-8e38-4d71-118d-08da169fa697
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4662:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB466202DE870B5ED226821B8CA0E49@SJ0PR15MB4662.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZgonT/u1tDr24Wt/184TIoPc9GMfHd6iMxAQV4MClyIdMy5ZabR3eJSOX3YZmY2D6o2TspW6jjJdNor0a4bdhaZRmY77TakJhvNJ0UZ2sqiV/9ceVruSdz4Y17shjAjZkBChzo4ypU0ubWX2qlT4gJi6q0uKVlbWwkeMsFowWPb92+BALm8Ktw4V2YnSaNLDk2MbQRCHfQ3bVWiPRS5PAWRkAfu0/MHTWGEgpHVugpJq4wrruXzqWy9joVJ4pJN11QIMJf7QO9RB2HtCvBm8U7p/F2Sb8v765hmhZXcSV/86rgNHhvxtJxGsgdn8CUBRjzQAFW2Exc8c6tTbMSBSP1ras30Sh35Y69HqWcFNf8JZgJCRwE8CsNxkqt+9ZGSIqwt6UPf2jy+5W4h7wL4QJHmoJMuSDpkl9b29Cjdbz1OX645n6O9XoMS4lGUAF50Yo+s8ZuB+XxwWjjTSJcgVCrfhB/0hbUmgFJIFLJ4Y8Foj9c3O9qo9HPndTgwk6qdDq93NyDCt8Fk+RnV50Yw6a7sA5oa6XV3moIuDp3iaAgxqIa77/PGIxYnanlu2Zc47ETLI3JSmwXS430jbgUFGw/SxXsYRUom60yDMuRKwIGd8g7bPKg8vcynin+B+4wxG1g5NxN/VwDnMYAXaAVtcnYTnwTSFkqrbSon6Y0UwhtEYjSQvlr/NKuOjJhTS3JGzmfkweaykzYFJzeRbuiC+0EdQS4r04SwJwZn1XEwl+TXCYHPql0l7HGiEiJrIBe2l80gpoAVkkM035YCe/YPSv4Ts7MNUSVmWtsoAQelaGzVINk7JWJJ3287pGAGdDoFWR6VcYlf7uQj27wOAZCp43Mz0+klItc/VV0jhqESzfnF5nFDsjL8Lp149eMsSw7qC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(66946007)(36756003)(83380400001)(66556008)(186003)(2906002)(8936002)(31696002)(38100700002)(30864003)(86362001)(2616005)(54906003)(5660300002)(8676002)(4326008)(66476007)(508600001)(316002)(6916009)(6506007)(966005)(6512007)(31686004)(6486002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1RTRHRxNVN6aXFKSEc5dkhhMndYWHVDWmNWb0RKWlJDTUtxazZlQVBXQ2dQ?=
 =?utf-8?B?ZjhWa3pZbGlBVXl0eVNiNVg5Zm1LQUpuczliTDA2aDFqODl3cXFqTEoyS1Nx?=
 =?utf-8?B?WSt1dzB6ZmJOaytuVGVXd3lLNmpNU3VUQkNBWkpIWXU2Z1FGV1FCU1VzcUFC?=
 =?utf-8?B?TXU3Mi96T0k3RWVPd2hlYmJXRDRLbGIyT1lCa1FNc01EU2tqUy9HT25ML2ZD?=
 =?utf-8?B?K1hUQWdXc3pEdFBwQUNKMGRhZHFNZVA1T3BuRlJaWFFRQmFzNzBYaFZQSFNY?=
 =?utf-8?B?OEtKK1F2Q1A4cDk3U0VGdDczUnB2bGNCSVhUVHdWZllwMEYrWTFtVy9aMDV3?=
 =?utf-8?B?Sy9OR3U2d09tbVhxMFF3WDc1a3ZiVVAyOStKYmd1ZVR1WGhRcXZqanQ1anNT?=
 =?utf-8?B?b1NTdFF4ck1aZEFIbDdHc01saW1zMmpsbmliRDlPTnZ1UkR3Mm5nVEZESldX?=
 =?utf-8?B?ak1Wc0M0NitnYVp0aEFCZXVPVGsxaWJVWFJtYnRNbVgrZERTNnRveTNwYUtv?=
 =?utf-8?B?V3RYU2huc0VpQWZlR05QVklwOGYyK2c3WGlqMUlVY3lVazFLbkp4TW5PVTk0?=
 =?utf-8?B?RlhZaG5yWWpXTmNJb3lWdVVxYU4xUTFNbXh4dlVNUG1jMlFZRzJoc3BZVzB0?=
 =?utf-8?B?K1U2Y21FSGgrTEVUZmYvNkluK3labG5BUlVtWTJ1cGRnRy9kRk9GSHJISlAw?=
 =?utf-8?B?TXJBVW1WNVlhZmhRSVZ6RFh0VjI3S0JpdFA1b0l2SXlPWW5IQ05EN1J0eVBt?=
 =?utf-8?B?THFaWmtlQjVNZEVpNTlKVExpbElsMmpYVUdXL0pRbFA4QVNVNTlmMjFjUUhT?=
 =?utf-8?B?OXQzV2xvaTR5SDlmaGxQTHYzZE9OZjdZNVIrNUExY2FvWHlpTVBFa2RGSllS?=
 =?utf-8?B?WTZsaWZ5NDlaTmVKcXZWbW01aUVYMDZha0d5SDhBSkJZbUJhaTRWRDNCOE9Z?=
 =?utf-8?B?REJWaTZkRHcxQTNSNGhScitzN21ZaEc1ZUZaa05KYkJMZzRCYVI3QURHbTJH?=
 =?utf-8?B?NVJ4dDdORU5TbzlNL3ZONU1uM0g0S2JON2dQcEVnTHlXZHNTdGJ5K0J6WmRU?=
 =?utf-8?B?Z3diNUdkY1M1S3dmSHI4WmxjamhXRmxDK01kSkEzaldPTitvckpOWkd6dFdN?=
 =?utf-8?B?YkwrcTFONnFXcWNEQ2FQcE1QM0pQTlNuR0liMHZRSklGNE5DMFZuTEhHMkhY?=
 =?utf-8?B?Y1ROd0lQdmVBMEkxa2g3SWoyZTJQb3BMb21DY3k4RnoweHNBbGk3KzBKUHhz?=
 =?utf-8?B?Q1p1NVNuYWdyUWJ2UHV2cWlTSnBoV1NSY3cyaFV0MjNyVkZmZXdVcEZpN0o5?=
 =?utf-8?B?SlVDTUZmY3hsMGJxZ3BlTkF1cnpoRDVDNDh5NnNxd0wzOXorUzRoS3pQWkdz?=
 =?utf-8?B?ZmF5L0pPci8vWkV4WlB0a0ZQMTlPamx0UlJRR0djWG9vVXl0eDdFVEJZcmU4?=
 =?utf-8?B?Zmd1OC8vN1V5ay9JQTAvYmJhSHI2LzM2WjR3OWRwcFN2T1F0cG5xWisvU25V?=
 =?utf-8?B?ZE0xcmtyVlltbmd4YThGL3U0cHN6aGMrb3hkM2RiKzdjMlc1cWRIdjJ0N0tx?=
 =?utf-8?B?UHBNd0RUZHk2dXRXYlRiUlUvUUNFNElQRVRNZE5BcGJJQURwUGRTZzhqTXZy?=
 =?utf-8?B?OGdkT3lxZGJFQVp3aGNnZTFMTjV0Ym1QT29uQSt3aTNwcm1CV2tubU8zUndW?=
 =?utf-8?B?QVM3NEs2RWZXY3VHTk1qdC9xV29TZjNEdjlkaGZCdUtza0FKSkpkRGt0YVVt?=
 =?utf-8?B?L2l1TlQ5R2J2ZkNFQ3d0SDZQU2FLT25kc2RFMk5rWlBIK3RHV2tGREsyWEl5?=
 =?utf-8?B?dnByRnppRHRIc2lVTU9maGJ0NzU1TWVwT00wMmNlWTZuK291RjZhNDJCOEkz?=
 =?utf-8?B?cWxhRW1pRXA3alVrSWx1b2NzbU1GWm8yNlVYS3VKSXFHVUZFeDlrOHkzaUV3?=
 =?utf-8?B?czhVdjNMcG1XemF4WUIvbktJcFdGOGRaNkVKSHVMdzFwelo3UTlXNG1vaEdB?=
 =?utf-8?B?Vmt4OUFnZGU0MFd3VFA2RTRvaVR3VEJQU25zeGo3ZE9QWjZUc044akY2UHEz?=
 =?utf-8?B?S1YveTB3VVJkVWRlV09idTZPeCtWYXM3cjR4WENldjlvSU9UM0xoNXpRb2FH?=
 =?utf-8?B?cnhWYzA5dlFwcDk3aEJFekRVZFp2UWt2b1Z2WFBxZlQ0eVp6bWZFbjgrMGhv?=
 =?utf-8?B?bzg0aVBCTzBULzFabmx3WnEyVysrUmN3YWdJRVovUWcyZDc4RmE1NldHUVcz?=
 =?utf-8?B?c1VQcTVvYVN3dndQTmR4dUFvNXN1aGlVKytIanBNc2RuNkpDbkJrSEplSkhC?=
 =?utf-8?B?MG9rTzVLTW5Qb1VXSCtJeTBBWmZlTGF2ZWZxcUt2bkVHNzdNanlUNUwxenhq?=
 =?utf-8?Q?NtdetBGegDIl3GOHudogX9PtQDtvsbfP2AcK0?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49cb2b26-8e38-4d71-118d-08da169fa697
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2022 01:00:17.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GYswjGO+/uZgqrufhhss2C0cJU5rF7igPFfkfP4YFK0w8t8LQEMbS4Ik+JjPCRy80f35ojqhyPTNIVmDcVD6ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4662
X-Proofpoint-ORIG-GUID: 0kzShhYDsSu6yMzujRmRLSCuEQtT-WHs
X-Proofpoint-GUID: 0kzShhYDsSu6yMzujRmRLSCuEQtT-WHs
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-04_09,2022-03-31_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/4/22 12:18 AM, Andrii Nakryiko wrote:   
> On Sun, Apr 3, 2022 at 8:12 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>>
>> On 4/1/22 8:29 PM, Andrii Nakryiko wrote:
>>> Wire up libbpf USDT support APIs without yet implementing all the
>>> nitty-gritty details of USDT discovery, spec parsing, and BPF map
>>> initialization.
>>>
>>> User-visible user-space API is simple and is conceptually very similar
>>> to uprobe API.
>>>
>>> bpf_program__attach_usdt() API allows to programmatically attach given
>>> BPF program to a USDT, specified through binary path (executable or
>>> shared lib), USDT provider and name. Also, just like in uprobe case, PID
>>> filter is specified (0 - self, -1 - any process, or specific PID).
>>> Optionally, USDT cookie value can be specified. Such single API
>>> invocation will try to discover given USDT in specified binary and will
>>> use (potentially many) BPF uprobes to attach this program in correct
>>> locations.
>>>
>>> Just like any bpf_program__attach_xxx() APIs, bpf_link is returned that
>>> represents this attachment. It is a virtual BPF link that doesn't have
>>> direct kernel object, as it can consist of multiple underlying BPF
>>> uprobe links. As such, attachment is not atomic operation and there can
>>> be brief moment when some USDT call sites are attached while others are
>>> still in the process of attaching. This should be taken into
>>> consideration by user. But bpf_program__attach_usdt() guarantees that
>>> in the case of success all USDT call sites are successfully attached, or
>>> all the successfuly attachments will be detached as soon as some USDT
>>> call sites failed to be attached. So, in theory, there could be cases of
>>> failed bpf_program__attach_usdt() call which did trigger few USDT
>>> program invocations. This is unavoidable due to multi-uprobe nature of
>>> USDT and has to be handled by user, if it's important to create an
>>> illusion of atomicity.
>>
>> It would be useful to be able to control the behavior in response to attach
>> failure in bpf_program__attach_usdt. Specifically I'd like to be able to
>> choose between existing "all attaches succeed or entire operation fails" and
>> "_any_ attach succeeds or entire operation fails". Few reasons for this:
>>
>>  * Tools like BOLT were not playing nicely with USDTs for some time ([0],[1])
>>  * BCC's logic was changed to support more granular 'attach failure' logic ([2])
>>  * At FB I still see some multi-probe USDTs with incorrect-looking locations on
>>    some of the probes
>>
>> Note that my change for 2nd bullet was to handle ".so in shortlived process"
>> usecase, which this lib handles by properly supporting pid = -1. But it's since
>> come in handy to avoid 3rd bullet's issue from causing trouble.
>>
>> Production tracing tools would be less brittle if they could control this attach
>> failure logic.
>>
> 
> So, we have bpf_usdt_opts for that and can add this in the future. The
> reason I didn't do it from the outset is that no other attach API
> currently has this partial success behavior. For example, multi-attach
> kprobe that we recently added is also an all-or-nothing API. So I
> wanted to start out with this stricter approach and only allow to
> change that if/when we have a clear case where this is objectively not
> enough. The BOLT case you mentioned normally should have been solved
> by fixing BOLT tooling itself, not by sloppier attach behavior in
> kernel or libbpf.

Re: BOLT - agreed that it's better to find the root cause and fix that. But for
some time before root fix is deployed there will be binaries with some incorrect
USDT notes, and tracing programs will still want to use valid USDT notes to
collect data. I think this happens fairly often.

In fact I found an example last week while investigating something unrelated.
Here's a (snipped) 'readelf -n' from a binary in a prod env:

  stapsdt              0x0000007f	NT_STAPSDT (SystemTap probe descriptors)
    Provider: thrift
    Name: thread_manager_task_stats
    Location: 0x0000000000000077, Base: 0x0000000000000000, Semaphore: 0x0000000000000000
    Arguments: -8@-256(%rbp) -8@-248(%rbp) -8@-240(%rbp) -8@-232(%rbp) -8@-224(%rbp)
  stapsdt              0x0000007f	NT_STAPSDT (SystemTap probe descriptors)
    Provider: thrift
    Name: thread_manager_task_stats
    Location: 0x0000000002bd1eb3, Base: 0x0000000000000000, Semaphore: 0x0000000000000000
    Arguments: -8@-272(%rbp) -8@-264(%rbp) -8@-256(%rbp) -8@-248(%rbp) -8@-240(%rbp)

Coming from thrift [0]. Note that this is an ET_EXEC ELF, so the first probe's
location is certainly invalid. Second looks reasonable. IIUC if I wanted to
attach to this USDT, find_elf_seg would fail to find a segment for first probe,
causing collect_usdt_targets to error out as well. BCC complains about this
([1]) but continues.

  [0]: https://github.com/facebook/fbthrift/blob/main/thrift/lib/cpp/concurrency/ThreadManager.cpp#L1003
  [1]: https://github.com/iovisor/bcc/blob/master/src/cc/bcc_elf.c#L127

> 
> For the [2], if you re-read comments, I've suggested to allow adding
> one USDT at a time instead of the "partial failure is ok" option,
> which you ended up doing. So your initial frustration was from
> suboptimal BCC API. After you added init_usdt() call that allowed to
> generate code for each individual binary+USDT target, you had all the
> control you needed, right? So here, bpf_program__attach_usdt() is a
> logical equivalent of that init_usdt() call from BCC, so should be all
> good. If bpf_program__attach_usdt() fails for some process/binary that
> is now gone, you can just ignore and continue attaching for other
> binaries, right?

You're right, goal of that BCC PR was to relax strictness at USDT level, not
probe level. I included it to demonstrate that giving users more control over
attach behavior has been useful in the past. If BCC had similar strictness
at probe level I would've sent a PR to address that as well, as it would've
broken a tracing daemon by now.

>>   [0]: https://github.com/facebookincubator/BOLT/commit/ea49a61463c65775aa796a9ef7a1199f20d2a698
>>   [1]: https://github.com/facebookincubator/BOLT/commit/93860e02a19227be4963a68aa99ea0e09771052b
>>   [2]: https://github.com/iovisor/bcc/pull/2476
>>
>>> USDT BPF programs themselves are marked in BPF source code as either
>>> SEC("usdt"), in which case they won't be auto-attached through
>>> skeleton's <skel>__attach() method, or it can have a full definition,
>>> which follows the spirit of fully-specified uprobes:
>>> SEC("usdt/<path>:<provider>:<name>"). In the latter case skeleton's
>>> attach method will attempt auto-attachment. Similarly, generic
>>> bpf_program__attach() will have enought information to go off of for
>>> parameterless attachment.
>>>
>>> USDT BPF programs are actually uprobes, and as such for kernel they are
>>> marked as BPF_PROG_TYPE_KPROBE.
>>>
>>> Another part of this patch is USDT-related feature probing:
>>>   - BPF cookie support detection from user-space;
>>>   - detection of kernel support for auto-refcounting of USDT semaphore.
>>>
>>> The latter is optional. If kernel doesn't support such feature and USDT
>>> doesn't rely on USDT semaphores, no error is returned. But if libbpf
>>> detects that USDT requires setting semaphores and kernel doesn't support
>>> this, libbpf errors out with explicit pr_warn() message. Libbpf doesn't
>>> support poking process's memory directly to increment semaphore value,
>>> like BCC does on legacy kernels, due to inherent raciness and danger of
>>> such process memory manipulation. Libbpf let's kernel take care of this
>>> properly or gives up.
>>>
>>> Logistically, all the extra USDT-related infrastructure of libbpf is put
>>> into a separate usdt.c file and abstracted behind struct usdt_manager.
>>> Each bpf_object has lazily-initialized usdt_manager pointer, which is
>>> only instantiated if USDT programs are attempted to be attached. Closing
>>> BPF object frees up usdt_manager resources. usdt_manager keeps track of
>>> USDT spec ID assignment and few other small things.
>>>
>>> Subsequent patches will fill out remaining missing pieces of USDT
>>> initialization and setup logic.
>>>
>>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>>  tools/lib/bpf/Build             |   3 +-
>>>  tools/lib/bpf/libbpf.c          | 100 +++++++-
>>>  tools/lib/bpf/libbpf.h          |  31 +++
>>>  tools/lib/bpf/libbpf.map        |   1 +
>>>  tools/lib/bpf/libbpf_internal.h |  19 ++
>>>  tools/lib/bpf/usdt.c            | 426 ++++++++++++++++++++++++++++++++
>>>  6 files changed, 571 insertions(+), 9 deletions(-)
>>>  create mode 100644 tools/lib/bpf/usdt.c
>>
>> [...]
>>
>>> +static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>>> +{
>>> +     char *path = NULL, *provider = NULL, *name = NULL;
>>> +     const char *sec_name;
>>> +     int n, err;
>>> +
>>> +     sec_name = bpf_program__section_name(prog);
>>> +     if (strcmp(sec_name, "usdt") == 0) {
>>> +             /* no auto-attach for just SEC("usdt") */
>>> +             *link = NULL;
>>> +             return 0;
>>> +     }
>>> +
>>> +     n = sscanf(sec_name, "usdt/%m[^:]:%m[^:]:%m[^:]", &path, &provider, &name);
>>
>> TIL %m
> 
> yep it's pretty nifty in some cases. In general, sscanf() is pretty
> great for a lot of pretty complicated cases without the need to go for
> a full-blown regex engine.
> 
>>
>>> +     if (n != 3) {
>>> +             pr_warn("invalid section '%s', expected SEC(\"usdt/<path>:<provider>:<name>\")\n",
>>> +                     sec_name);
>>> +             err = -EINVAL;
>>> +     } else {
>>> +             *link = bpf_program__attach_usdt(prog, -1 /* any process */, path,
>>> +                                              provider, name, NULL);
>>> +             err = libbpf_get_error(*link);
>>> +     }
>>> +     free(path);
>>> +     free(provider);
>>> +     free(name);
>>> +     return err;
>>> +}
>>
>> [...]
>>
>>> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
>>> new file mode 100644
>>> index 000000000000..9476f7a15769
>>> --- /dev/null
>>> +++ b/tools/lib/bpf/usdt.c
>>> @@ -0,0 +1,426 @@
>>> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
>>> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
>>> +#include <ctype.h>
>>> +#include <stdio.h>
>>> +#include <stdlib.h>
>>> +#include <string.h>
>>> +#include <libelf.h>
>>> +#include <gelf.h>
>>> +#include <unistd.h>
>>> +#include <linux/ptrace.h>
>>> +#include <linux/kernel.h>
>>> +
>>> +#include "bpf.h"
>>> +#include "libbpf.h"
>>> +#include "libbpf_common.h"
>>> +#include "libbpf_internal.h"
>>> +#include "hashmap.h"
>>> +
>>> +/* libbpf's USDT support consists of BPF-side state/code and user-space
>>> + * state/code working together in concert. BPF-side parts are defined in
>>> + * usdt.bpf.h header library. User-space state is encapsulated by struct
>>> + * usdt_manager and all the supporting code centered around usdt_manager.
>>> + *
>>> + * usdt.bpf.h defines two BPF maps that usdt_manager expects: USDT spec map
>>> + * and IP-to-spec-ID map, which is auxiliary map necessary for kernels that
>>> + * don't support BPF cookie (see below). These two maps are implicitly
>>> + * embedded into user's end BPF object file when user's code included
>>> + * usdt.bpf.h. This means that libbpf doesn't do anything special to create
>>> + * these USDT support maps. They are created by normal libbpf logic of
>>> + * instantiating BPF maps when opening and loading BPF object.
>>> + *
>>> + * As such, libbpf is basically unaware of the need to do anything
>>> + * USDT-related until the very first call to bpf_program__attach_usdt(), which
>>> + * can be called by user explicitly or happen automatically during skeleton
>>> + * attach (or, equivalently, through generic bpf_program__attach() call). At
>>> + * this point, libbpf will instantiate and initialize struct usdt_manager and
>>> + * store it in bpf_object. USDT manager is per-BPF object construct, as each
>>> + * independent BPF object might or might not have USDT programs, and thus all
>>> + * the expected USDT-related state. There is no coordination between two
>>> + * bpf_object in parts of USDT attachment, they are oblivious of each other's
>>> + * existence and libbpf is just oblivious, dealing with bpf_object-specific
>>> + * USDT state.
>>> + *
>>> + * Quick crash course on USDTs.
>>> + *
>>> + * From user-space application's point of view, USDT is essentially just
>>> + * a slightly special function call that normally has zero overhead, unless it
>>
>> Maybe better to claim 'low overhead' instead of 'zero' here and elsewhere?
>> Or elaborate about the overhead more explicitly. Agreed that it's so low as to
>> effectively be zero in most cases, but someone somewhere is going to put the nop
>> in a 4096-bytes-of-instr tight loop, see changed iTLB behavior, and get
>> frustrated.
> 
> Hm.... but it is literally zero overhead because that nop is pretty
> much free. If you put USDT into a loop, you'll be seeing an overhead
> of a loop itself, not of that nop. What's more, if you have input
> arguments that are already prepared/calculated, there is no movement
> of them, no stack frame creation and jump (as opposed to function
> calls), USDT macro just record their location without changing the
> properties of the code. So I stand by zero-overhead.
> 
>>
>> A contrived scenario to be sure, but no other USDT documentation I can find
>> claims zero overhead, rather 'low', guessing for a good reason.
> 
> The only real overhead of USDT will be if someone calculates some
> expression just to pass its result into USDT. That's when USDT
> semaphores come in, but that's a bit different from USDT invocation
> overhead itself.
> 
> Think about ftrace preamble in almost every kernel function (we use
> that for fentry/fexit and kprobe utilizes it for faster jump, if
> kernel supports it). It's 5-byte nop, but I don't think anyone claims
> that there is "low overhead" of ftrace when nothing is attached to the
> kernel function. It is considered to be *zero overhead*, unless
> someone attaches and replaces those 5 bytes with a call, jump, or
> interrupt. USDT is similarly "zero overhead".
> 
> I think it's important to emphasize that this is objectively zero
> overhead and encourage applications to utilize this technology,
> instead of inadvertently scaring them away with vague "low overhead".
> 
>>
>>
>>> + * is being traced by some external entity (e.g, BPF-based tool). Here's how
>>> + * a typical application can trigger USDT probe:
>>> + *
>>> + * #include <sys/sdt.h>  // provided by systemtap-sdt-devel package
>>> + * // folly also provide similar functionality in folly/tracing/StaticTracepoint.h
>>> + *
>>> + * STAP_PROBE3(my_usdt_provider, my_usdt_probe_name, 123, x, &y);
>>> + *
>>> + * USDT is identified by it's <provider-name>:<probe-name> pair of names. Each
>>> + * individual USDT has a fixed number of arguments (3 in the above example)
>>> + * and specifies values of each argument as if it was a function call.
>>> + *
>>> + * USDT call is actually not a function call, but is instead replaced by
>>> + * a single NOP instruction (thus zero overhead, effectively). But in addition
>>
>> This zero overhead claim bothers me less since NOP is directly mentioned.
> 
> Well, I already wrote up my tirade above and I'm living it anyways ;)
> 
>>
>>> + * to that, those USDT macros generate special SHT_NOTE ELF records in
>>> + * .note.stapsdt ELF section. Here's an example USDT definition as emitted by
>>> + * `readelf -n <binary>`:
>>
>> [...]
>>
>>> + * Arguments is the most interesting part. This USDT specification string is
>>> + * providing information about all the USDT arguments and their locations. The
>>> + * part before @ sign defined byte size of the argument (1, 2, 4, or 8) and
>>> + * whether the argument is singed or unsigned (negative size means signed).
>>> + * The part after @ sign is assembly-like definition of argument location.
>>> + * Technically, assembler can provide some pretty advanced definitions, but
>>
>> Perhaps it would be more precise to state that argument specifiers can be 'any
>> operand accepted by Gnu Asm Syntax' (per [0]).
>>
>> [0]: https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation 
> 
> Yep, will update and live the reference to that page.
> 
>>
>>> + * libbpf is currently supporting three most common cases:
>>> + *   1) immediate constant, see 5th and 9th args above (-4@$5 and -4@-9);
>>> + *   2) register value, e.g., 8@%rdx, which means "unsigned 8-byte integer
>>> + *      whose value is in register %rdx";
>>> + *   3) memory dereference addressed by register, e.g., -4@-1204(%rbp), which
>>> + *      specifies signed 32-bit integer stored at offset -1204 bytes from
>>> + *      memory address stored in %rbp.
>>
>> [...]
