Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EAD600656
	for <lists+bpf@lfdr.de>; Mon, 17 Oct 2022 07:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJQFdh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Oct 2022 01:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJQFdg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Oct 2022 01:33:36 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134F94BA5B
        for <bpf@vger.kernel.org>; Sun, 16 Oct 2022 22:33:34 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29GMThhm028066;
        Sun, 16 Oct 2022 22:33:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=A91YxAxwuo+NIkgIPMf45+QfZnT6UTJkGTl/X9DEu58=;
 b=c725S3Uad1D6huZJayzGfKNnnL64zS00tf94VImmdfb1JsOtMw4AkCtqv800PJ0FH35I
 Zg7u76thcCbU3sUIEUqsJlbsVKHt/ZNJ9w0JC+SF71NGQqHdmuoGAUnR8C28o65jgqlI
 WkwhtgCBYvkXrDwOWk6NYQ1rVWNa+fhrm3WJh4zsEPHJtgLyTitiPw7u0O5+2HZk8gwu
 qS6H5XdLHFfcJDpaO+YYcDU+HLoDwklhowhzFE1Eh34e6BahhxlinCGtHhwv6CY6Jied
 4Cn122/+qnLVEVz8ozXj41Tqpqg+CgABRUP5uUSCxWF3EeG98jEGkYVpGpTXJNGhFAl/ VA== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3k7syt4ruu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 16 Oct 2022 22:33:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iarpjtLN279t+D6c7H4uFEewcxMkcoyCKbXYWsZGaQq8JaFc0ZAAJaAaLHu84/oIfmLaj7tEL0CAMbAMJZs9o3/6/KIR7lrXoTDY5QsicWAlnQIWGD7SwZAR+g9g+jj9AFL7hPoentFncQlHVe7tQ6V1B592YkKC/1hiOfgj2xKDaEuAq+of+b/ejMhTlUS+EhLezW1ylVfW9WP2STuI9NY+RR13HyJW6QriGnbeGN5vFDZufBsGWSwTpv8T60vXzLoa9YxRNHnyXk0ozA64yuzCi+il0Slt9BrdQyAKUAVzA4ooGUt/ZVfHat84XxsOz1IZ0enevDLHgsD4wvHSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A91YxAxwuo+NIkgIPMf45+QfZnT6UTJkGTl/X9DEu58=;
 b=WMt07Y7iQ/V3az8P5A/HmvPZ4kmlTFa089Q/EP+Yt9jfTPABw3hmjxqj9NKkW7nDULJEAcLW3IaThD3BINw/URCqXDGe9q8sLcpenyVl4vHQsterEJUhkHQFiN/narCc7YznSCYVahhlyDCDXV/S0mS5Ry1lIOSb/7QAj1OuuB/r1wm0krZzbCtl7fbuFpyQdPJoGSW7bxznPD5BAHkjljzLbRSDxiSRFF7lvey/ea4wA/J62OQT/UTA/KCaTS5pgdK09F9zCeUUvMIvIEmpuQS89joacxpT7YQWtxzw/JSRtwjodsBu7ay38qUekzOSe5fTFhBmtvxhWFAz2bK+Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4467.namprd15.prod.outlook.com (2603:10b6:806:196::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Mon, 17 Oct
 2022 05:33:14 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::6e08:a405:4130:f36e%6]) with mapi id 15.20.5723.032; Mon, 17 Oct 2022
 05:33:14 +0000
Message-ID: <262c86ec-8f1c-5e88-d5ff-f4bbb87d588b@meta.com>
Date:   Sun, 16 Oct 2022 22:33:09 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: Add reproducer for decl_tag
 in func_proto return type
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, haoluo@google.com,
        jolsa@kernel.org, Martin KaFai Lau <martin.lau@kernel.org>
References: <20221015002444.2680969-1-sdf@google.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221015002444.2680969-1-sdf@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:208:134::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SA1PR15MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 1755ebde-4188-44c7-4f0f-08dab001160f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kMgWs/3cy3+CQS+ubEZqJwspTyK53oX/QdRRy9ppnXyYHqiTimBGgjDoNadcTTE+HQUSpQlJ/2X/5WmMTuuqmgfTzwKLbR4NmMyn9RQ/cVJVhAsv35Gqin0ROau+S4a4r2llGJjeyVqq7YXw9keNzsMWAd7mqcUWduIN70ACFumOxA/aR+okV2yn2xFLVZp6UsBscCffwg8OsxRKaDDPMfoDuRyoGJkLYlGU1dpCv5Nia/encZogldTivrq53cnpeJdfsFJqgeNayeDoJEgCfBtIfs3WeJUOlBYtBqDI0T5/S9dJ5S9Z+shsMIq13dKRT5hyZGJk576Ci6KVrvnpwC7TuO6wIWIXeug7FnCCE1IyHhguu1yGKIF8oLktOxgTq/vZ1OxzV3polyqJjTYxFNGv0QalhC56+zoXvdETrggUDnxJWIilFJgEDQJD4VvPETlkysK/CevDFiH801V/h4ravZPgXgoBTo5I6TvJ6bBLsZtUoM9w+yFy7x54573B1RzUL7hmwQEXwB3DFkiZ9Qnqv0qb3FOXZtkrmGbYU1vBpmLxK3oaBoavRqUAqw4/RKDD++EWZKfDKjh36Rsdec7tz9wAUuheYwRw7/fEtU0og6RQL+iOGYC2XAAqqG0eiIYrSKTGePdUnI8CY3eO4pU7krboRhJs8Wn9eSKfszwdZIoeanADPZaTgH4nmR4GAesy0G5+05a0SeFZ+AszBYualTAGDK2BLwDVzOHLI5Jg43e2aH7J/5oEruX1n2+oYxlFJGl635velbCyhfnYzm0XyBXQelMhp1wnzKVQzeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199015)(6506007)(31686004)(4326008)(8676002)(66476007)(66556008)(66946007)(31696002)(6512007)(36756003)(38100700002)(86362001)(478600001)(186003)(53546011)(6666004)(6486002)(316002)(2906002)(2616005)(41300700001)(8936002)(4744005)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWo4OHlSTnBSYmpXQWpJbUxZd2Z1cGdPSGNPWS9yajhyYXBwa3lNZmNFS0to?=
 =?utf-8?B?WUFtdmJHNnhSeTVoMVRwUXlGVExabzJFZndBcE4rcW1yTnRKQTl6ck5COHda?=
 =?utf-8?B?TWdlaHBtVndiY2VTYlpZY2FuSjkvNy9VcVlNUmh1WmJzblk0SmhBb2pST0NK?=
 =?utf-8?B?WWNuallqQ1lZd0dEeTd2U2gya1R3RFAwTVd4OG8vVTJGSThFYzl2bldQZnVk?=
 =?utf-8?B?cWZuVlJXaTMxNFBRYlpiK3hkY1VRTTF3RWp2ODQ2NTRTc2JrTTRHY2xIbW44?=
 =?utf-8?B?THRmT3FjR0gzMDhZdWlZeVlaaGNFdzdDb0U3a0RLYXQ3VDhxYlkxRVd3UktC?=
 =?utf-8?B?U1UxaUVOeFo5Snl1emRScTlCYlZuMUpnYzJKd244bWFZZGcvc2VySGlVYU1s?=
 =?utf-8?B?YW9KdVhubTdHUEVTbTlxRms1TWpJNmYyUDNrUFM5aWFIdWVCYWJYemdEMkpP?=
 =?utf-8?B?cTBNQWZxV3RTVFJmK1NyTkkxWmxNQ2VqVzAvMEhYeVpaOXR2YURSVmcvV25Q?=
 =?utf-8?B?T09SNE16aVcyckNFZXBjU3hUUnZtOHF0cUVEQ25zaDBsbEorcHVaVUdCWmlT?=
 =?utf-8?B?RWVWaUxiL1NOakJRQlU5cTUzU0xsa3FyTUdRNURtM3Vhdmk3RHhnbFdCYkR6?=
 =?utf-8?B?Q1BzTXpIV0ZiblVwQ3BjM1ZOT1Byd2FTWlEwdWRrcXluZ25pT2hOb0ZaNC9p?=
 =?utf-8?B?bGJlRVBGTzZWQ3VabWllM2twalJRU3k4STI3WTAxYlg2SXYxSng5c2c4YUxN?=
 =?utf-8?B?aWpSQzVQaFd6ZHJiUXlYdkY5ZUU5aFl6bmFRMmpDQXNhS1czSXhBc1gyR2ls?=
 =?utf-8?B?bW9Fa25qQklrQzh1UzlGczZjVUNUWW5HeU5ldkx3d1FOQkVGejJXQUJiN3Nu?=
 =?utf-8?B?Q2U2M2dMSkRLNW94YmFxMXRpMmN5Mmp3RXhRSTdBYTcxNW5IQ0pvUjVwdjJN?=
 =?utf-8?B?ZE9hZjZKTnExT2h4RFlXSlgzRFNnNVdnS3NZOWZzMThwWmFhVnZ6K2h5ZnNR?=
 =?utf-8?B?RGl5VTQvSzFTQ2Z6SWhDQlp5YndHS2pOLzRoLzFXWUpOeGpaazlRSXFvUC9E?=
 =?utf-8?B?QXZremUyVWJFaUI3Z2xnbHFVVURMNmlRK3NQVXgvRVhhRW0zaVFwY3VVdmtM?=
 =?utf-8?B?RFhsVkx0SHcrazVpd2wxNXdMMjJZblR6T2U0NUw2ZnBnTU9uMC85bUZyd1dP?=
 =?utf-8?B?eWlKNFJ4amtlWWlBRkhsVVlEV0d2Q00rSGpqN3RFTnNwbzNSVFJYbnpEWEhY?=
 =?utf-8?B?clExMjdQNXM1UFBYZzZ4a0F5NnVPblNKMjZJdjJQYkhNR1NwUk5aVFNQcVRq?=
 =?utf-8?B?OTArWWRHZmhiRkhicTlxZ1FrS0xvZ3dseVFOcCtCdDNtUHJxMlJ1WDJ0bkFx?=
 =?utf-8?B?NE55aXNCMzRKNkcwTkcvNWZxd0RXMTM1S2R5SktZRUhWWEt2enNHdTNpZnNt?=
 =?utf-8?B?cTR5dVhzZDZDOWtvdlpISjlmT0ZCNFRma1hjdXppNytRQ1FCRWlud3c0VURz?=
 =?utf-8?B?eFFHeFFaWml0blB1bmJlOXZwNlVNSFRibmpIcFZHWWNXK0ZiVXk2cUNzNGEw?=
 =?utf-8?B?K055TDJycjIvV3huZEtaWi9WdFdNOEVKMFcwWTJtdUZMbUpBYVhLeGZNV2sr?=
 =?utf-8?B?MDJ3UzNYWXBGV244S0l4SS8yVjZudUJGVUx3RENoc0JKTk03elRYa29JaHAw?=
 =?utf-8?B?N0dUSWwyREJQMjVmck13TTMyTW45VEdtcGkrOGFySzB3RUliRnN2SWVmclNt?=
 =?utf-8?B?U3ZlWkdBZzRmVWdhOHlpQ3JOZlpsRjFZNDE0NmpFSmZudlc4Mi8zQ1F3dlpi?=
 =?utf-8?B?cTRYMUhIWjFqZUZZM0NPQ1M0aEQyV0hwUlIxUFJxRGNubExyTVRZV2F1cHFt?=
 =?utf-8?B?aHhiVjltREpsbktTRkdBUlgyTTdnQVUyWk5ML2k5SUlEVmRpemRKa05tQ21R?=
 =?utf-8?B?aEFkOTYzakJwQkZIaGczVXdNeml1YjRjRjNwaGpKK2lGUjdwYUI5Mk9ucytT?=
 =?utf-8?B?dGVkZzdIbmxWNElaTTR2MGswUWhUTzVuSnFmM3RFcjFpWUQxdHFHbnF1RitZ?=
 =?utf-8?B?dGlDSWNQUXlKK0JWblZ6cmlocHNvanlSSThJUXNRWnN3RDc2Qld4Uzk1SnVr?=
 =?utf-8?Q?rxnrNAfL77y1eDct9zBOfinZ7?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1755ebde-4188-44c7-4f0f-08dab001160f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2022 05:33:13.9779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ujhvJs37q0MRhwTOnQ/L9ALaHF8Ujor8KmAf7h1ACPVJUv3YAvzzGsQaaOtDxBEE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4467
X-Proofpoint-GUID: _PqICun5puuJnm9Ojy_AoJ40azKkSJOg
X-Proofpoint-ORIG-GUID: _PqICun5puuJnm9Ojy_AoJ40azKkSJOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_03,2022-10-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 10/14/22 5:24 PM, Stanislav Fomichev wrote:
> It should trigger a WARN_ON_ONCE in btf_type_id_size.
> 
>       btf_func_proto_check kernel/bpf/btf.c:4447 [inline]
>       btf_check_all_types kernel/bpf/btf.c:4723 [inline]
>       btf_parse_type_sec kernel/bpf/btf.c:4752 [inline]
>       btf_parse kernel/bpf/btf.c:5026 [inline]
>       btf_new_fd+0x1926/0x1e70 kernel/bpf/btf.c:6892
>       bpf_btf_load kernel/bpf/syscall.c:4324 [inline]
>       __sys_bpf+0xb7d/0x4cf0 kernel/bpf/syscall.c:5010
>       __do_sys_bpf kernel/bpf/syscall.c:5069 [inline]
>       __se_sys_bpf kernel/bpf/syscall.c:5067 [inline]
>       __x64_sys_bpf+0x75/0xb0 kernel/bpf/syscall.c:5067
>       do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>       do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>       entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> Cc: Yonghong Song <yhs@fb.com>
> Cc: Martin KaFai Lau <martin.lau@kernel.org>
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Acked-by: Yonghong Song <yhs@fb.com>
