Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69BD584522
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 19:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiG1Rqx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 13:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiG1Rqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 13:46:52 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BDF5007E
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:46:51 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 26SACkbM017059;
        Thu, 28 Jul 2022 10:46:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0XnLZhPBM72fNNywjotpssxQ3tFN1XD/g7mYXQ9yzYQ=;
 b=EImI5h153MDJfXSfav4ejjEkRGb0rxJeTUPc2z4o6woi58JRZSZavraOsEX6hwddqh1f
 j6nw53eB+HO34RyKOZp+l7QkzybzTvAXROMIuEsxfk83xzqsvo0v1sJv/CHq1tX4mq5H
 ysD28ONCTelmYzOFy6BZhmIVIg8CGAzM1j8= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hkpembnsm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jul 2022 10:46:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbc2g1xgnd0uEaRbl3nl0BWvk5K/fTjCHXlNhmk+IZneJXnY14a0YOzrsNiKgi6CXTlY2Ei2l78V7FvZZyJ1k2u14EwKM0wr+bcYUnp6/FZR0U44aCL+Eg3Zg7omzhMOTUSTzoH3SE5Bv589V0ZfMqn5Le/snD7K6gvYTBz61nt2++W+4dc+W0DrHnmj7Ur21+sAOYaMsDH88WfTUn5+k3xipc/8JPvOJWRM+sMx5poDBPgUb/rOqBQ69BzGvCXGHFu/YN2wIz9rXBqm+HDepPo2oWR9q1Iy0if2vWiNV/Fui7h05IFUKNDCQS7ygXndLD720kagySoK3lU4w0rgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0XnLZhPBM72fNNywjotpssxQ3tFN1XD/g7mYXQ9yzYQ=;
 b=kyL5hOU/Yxs4Bb2tJKG6E8HybiEo/J1Mp5FI8WXVCb285Ojt12wLkFP6HbYnic2Ufa5gq6YA/H/V09xuU5KrrcKtYP5BuIj3lgXmbQ7N9vQY44jDvKEUDCq2oXsybAah9LzEtPSBO/F71hnvi52jbAZL9s7OvdXlpM4nQ5245IDEGIBNz2gVAraEfyemTS5FNnFWTQ02DtjR2uHLC8aDeU1YyLDn93J4as2TTgRnFspLOyyThmWtz0fMcdVdp58yQ9PqcRlZ589iVNZ9+I53yh7l7nddeGzdTCee3nNUDMinF/XtkjpngMjJUiX4G2mpnDoFZ65uygtS4fEllOv+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3792.namprd15.prod.outlook.com (2603:10b6:806:8a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Thu, 28 Jul
 2022 17:46:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::9568:e5d9:b8ab:bb23%6]) with mapi id 15.20.5458.024; Thu, 28 Jul 2022
 17:46:32 +0000
Message-ID: <18273e85-4e45-c395-0aa9-a10125d59e50@fb.com>
Date:   Thu, 28 Jul 2022 10:46:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [RFC PATCH bpf-next 0/7] bpf: Support struct value argument for
 trampoline base progs
Content-Language: en-US
To:     Kui-Feng Lee <kuifeng@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     "daniel@iogearbox.net" <daniel@iogearbox.net>,
        Kernel Team <Kernel-team@fb.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
References: <20220726171129.708371-1-yhs@fb.com>
 <aa998af64d0662af4c138175259244640cecfcbf.camel@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <aa998af64d0662af4c138175259244640cecfcbf.camel@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ME2PR01CA0058.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b84c6bd3-b045-4b54-08a2-08da70c11be3
X-MS-TrafficTypeDiagnostic: SA0PR15MB3792:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YHtrBz4Uk7ep2nkLVcCPEq2xV830DVqwaRNEnskXZnQHpda5VkxQOqN5EjyEC8MK6yVY7dagmHAw+qG8G8+myLXpSNCVl/lWcTaXuCGBanS5gIuoI/wLfvgbcKoj0chaSvGnOpZ525vtyuEin6xQULUqRX0k18N+zKN1p5eUhBxEhxXtUA8fq/Wl1lpGIBdcGGcv7OnM1VbiU3B5HStUJLgjG5IjyQS0TL7Q3EKOKER/XT2e47sz2evhF1pXfti4jcZu1a8m6M61uHO4R4N7eM/F7tKbCjURcMwFG73zriKNg7s1drxPkAAPnaihrc8FrcYAy3K0X3ULQJUqL+xRJBWPhHt56PGIDzUx7ISXVBUNH/7tQkkuaY7/8n7P8ymCq6hFBGvltLaqIqEk8lKtN39UnHq7U7yYI3wUzT1/LrvHbzS4n9GWVlF6mWm2xxLqrSiqkGb3p6oskYUTh5D5ai8/sVKPAh40fHI48YnhC1AaPzPTUG0moR9kdIwdnEHgzTRpNE3LwJQES0EfAhskiih+o38u5BSyEsMtHbKDSqAPEqp7LKZst0zLzDzV3SOZn6zo6eN357ZKMIuRhLiXM2l0DAR8ze/685m6Af7ygxyFYZXl7DJPwqBkoINnMY9plLYVP4Xv/FqUcLyaevSDwIweCdGSG1Nx5vjgUgMKu8ennFQ1Qw5ltnhZZPewCLlQMJ7sNb/jS3TNYw1AITuS9UejMNzx/tG7a1CpAydMGdJ/aRFd0Xg2GdrA0Zhkewl+SBAANxSq82iRUnoum97/8sL6WzNxKsQn3TIL/EE3E0d2p1V+m1kAK9zVkegwhehbOqALbASxY58xiStDIbNlA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(83380400001)(6666004)(66946007)(31686004)(53546011)(36756003)(66556008)(66476007)(86362001)(8676002)(4326008)(2906002)(2616005)(6486002)(6506007)(31696002)(38100700002)(41300700001)(110136005)(8936002)(478600001)(6512007)(54906003)(316002)(5660300002)(186003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXFqZDJwR1BYdWdEZkF4dVhzT1lkNHNQUUNvc1RsWE5veUVKMWkvMER6NG9y?=
 =?utf-8?B?UjFXUlk0OWFIdzlSOUNiek9RSm5ZVnJxSkZIVzB2YkU1TXVBR2pnVFRxL3NZ?=
 =?utf-8?B?bHIyY3dMRXhKb2NGRTZTc2JSOUg5N2ROY3Y4QWF1cnViWitqWE1xMVRiRm5B?=
 =?utf-8?B?YlBraDd4NTdzWExYc3RoWGlCVGNMSEJjNkFzdEMwS0MzS0FpTXNUQ1Q5Zmwx?=
 =?utf-8?B?YjBmMmdFTmx4YlQ3OGhPekVsKzJHZHJVMjVUMk5tOHJONlN2N3V1K0VtNTA4?=
 =?utf-8?B?QmZQbDRFanRUQzlWdS9FQlYxNThtdld6U3N5cjVWdUl2cDFrZXdwTW03NVdn?=
 =?utf-8?B?Z3ZPMlVVS1J4ODBLT1IvTTBYUkxPUThCNzhUVTlmT3kxblJLYjc3TkQzNjR5?=
 =?utf-8?B?U2VMQzFXY0dXZzF1QTM5Y2FodHZkRkFWaWZ2SSs2RlZQMmt5N0wzTVFlTjVP?=
 =?utf-8?B?WmtuV0I0UGExbng5OVdXZzBWQjhGVUV4SGNFRHNYQmhJUlVCeUdSUTFKL3Rv?=
 =?utf-8?B?bkJNNUFGVVJJeitxbGZoZkFINWxOcHF1MjZiS3B0cnB6cGx3T3ZveG1PR2cx?=
 =?utf-8?B?dU5QUldMNTVuNjZ5S2cycXN4SEUvaVA5VXBmRDhQRmNiTjJDS3pjSWFxdzBX?=
 =?utf-8?B?UXhHc0lLb1NTczVacklQN3R1M2FBc3p4VDBCSHcwYU95Mlhmc2t5bDFjQWhn?=
 =?utf-8?B?K21OWlZkUzhjV3RpeFd0RHdkQXlmM2xEZW0zSTJ6TzhuUGZvYkpSQTlGV2FB?=
 =?utf-8?B?TlczNDJCSkJyMWVZNzlxbWZvZzlQS2MyU0xnVEVSWStkV3NBWnp5Y3J4emZG?=
 =?utf-8?B?alJEcEdqcnJZMU04WTNTSWtZSzFUMDVYeFFjbzV6R1NjMTZ6ckR3ZVdnUlFG?=
 =?utf-8?B?QzJRaGxZamFJZmtZY3IrL0NYMW55MUZBUFc1ZUgxNUMwU08xNEFiSFMxdWpJ?=
 =?utf-8?B?NUUrTWRIcHJFNE0zYzRlLzRNbElrd0pPbTlKSUVRNVN5YlNhTkpsWXdIcDVZ?=
 =?utf-8?B?b2xXNUd2SVJIdWhoS09ldXhGTFJWTkZjTUVrajMwb1VKT3loK01yWGFLUUVm?=
 =?utf-8?B?NGkrNUF5WjQ0YzdHTWFEYWV1UGd3clpaTjJ6UjNyU2VoT2NSSEd5a0NOK21P?=
 =?utf-8?B?MENGNS9KM0pPUkdIeFRtcTJjMk14QkxzWk4vSWwvc09rMTViU3dxVEt0ZEMy?=
 =?utf-8?B?dVBFM29iL3psSjcyY3o1U3Byd1ArU3BpczFBbzhjVTNvbWhLdjErQ09qWjdC?=
 =?utf-8?B?V2hmdkVsRTlKZHlOT1Y2ZWNoVkpRSHd2aHB1ektPZUUzSTlaV3c2UDFud2Uz?=
 =?utf-8?B?TkQ4eXk1SEZxRWtNeXNKLzNWd0orMWNzN1crNjNqQnNWT05xSVl0YUV4bGYv?=
 =?utf-8?B?RWQyenBQUkpvWjhkOTdSWTVKWERwQjNZZ3BQV3g1UGo3R0M0YmRLSmU3WG1B?=
 =?utf-8?B?OWJIeExWTWZnbFJJS3Zva1RTVjVSWlpjS00wU2liWmdJbW9DdTc3ZHJva3pY?=
 =?utf-8?B?aEF5RzVmWGVtKy9aclV3VXoyOVJBN1JQUUFTZDlMZElFcFppTy84TG5FSzcr?=
 =?utf-8?B?UUtWM2dmTWpPS3RHRWZONk9NNVpibEY4Mko3aGY5ODdCMHYwTkRKQ1R5bGV1?=
 =?utf-8?B?MXB4SnREUnpUU1JabDJjRzNBM1Vub3dEZUZBbjVZWFc4MENFUUljdmZNWVdJ?=
 =?utf-8?B?OHRFWDl4OEkrRCtrQU9hZGwxeFJnMkg0a0Y3S0RkU0JXQmpUSDcraFo2MmVE?=
 =?utf-8?B?ZysvK1hjeFJYaHByUVRkUGRiZE80WDhPMlhXQmN4NHhxM2htczlOL3o1emU4?=
 =?utf-8?B?MWFtRVhqUWw3cFpOQjFCNk9GamdnYUlNemtZVkkwYnlyaVFYSEJacHJXUjBX?=
 =?utf-8?B?TWVXTTNMbTZYeGZmL2N4Vkt0aUZUMVluY0szQnVlZDZsR1ZHNW4rcTNoQlEx?=
 =?utf-8?B?a1luelJjZGNMdEIvRWFUTjNIOTB5TE5keVB0cEVKUGtwNjBlQ0pBMjRJLzZt?=
 =?utf-8?B?ZmlkcmtwSGQ3OHNRaFlMQzF3WVlBWVRLdU5wVzBtUGJ6c0g5Q2VSMmsrMHlo?=
 =?utf-8?B?V2orOHp0Y1VqbTFRVjdhUW41bGhXUURXcHRBdFR2VEdoR1dvbjh3eEtvYnV5?=
 =?utf-8?B?RExYam1FY0Y5Sk9WdFhMREx2KzUvc2g2bnp1aG5hVHZxNEFhN1JUNU9tUU82?=
 =?utf-8?B?REE9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b84c6bd3-b045-4b54-08a2-08da70c11be3
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2022 17:46:32.8177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lRbzhRGSwjx6303uMG09pqpbXj9dLu5tspqXoETELKt44Fvt54n8AmxaVyv+exd+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3792
X-Proofpoint-ORIG-GUID: uBjek0wk2jwauJIU8RqI8Uyijk1NJuZw
X-Proofpoint-GUID: uBjek0wk2jwauJIU8RqI8Uyijk1NJuZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 7/28/22 8:46 AM, Kui-Feng Lee wrote:
> On Tue, 2022-07-26 at 10:11 -0700, Yonghong Song wrote:
>> Currently struct arguments are not supported for trampoline based
>> progs.
>> One of major reason is that struct argument may pass by value which
>> may
>> use more than one registers. This breaks trampoline progs where
>> each argument is assumed to take one register. bcc community reported
>> the
>> issue ([1]) where struct argument is not supported for fentry
>> program.
>>    typedef struct {
>>          uid_t val;
>>    } kuid_t;
>>    typedef struct {
>>          gid_t val;
>>    } kgid_t;
>>    int security_path_chown(struct path *path, kuid_t uid, kgid_t gid);
>> Inside Meta, we also have a use case to attach to tcp_setsockopt()
>>    typedef struct {
>>          union {
>>                  void            *kernel;
>>                  void __user     *user;
>>          };
>>          bool            is_kernel : 1;
>>    } sockptr_t;
>>    int tcp_setsockopt(struct sock *sk, int level, int optname,
>>                       sockptr_t optval, unsigned int optlen);
>>
>> This patch added struct value support for bpf tracing programs which
>> uses trampoline. struct argument size needs to be 16 or less so
>> it can fit in one or two registers. Based on analysis on llvm and
>> experiments, atruct argument size greater than 16 will be passed
>> as pointer to the struct.
> 
> Is it possible to force llvm to always pass a pointer to a struct over
> 8 bytes (the size of single register) for the BPF traget?

This is already the case for bpf target. Any struct parameter (1 byte, 2 
bytes, ..., 8 types, ..., 16 bytes, ...) will be passed as a reference.

But this is not the case for most other architectures. For example, for
x86_64, in most cases, struct size <= 16 will be passed with two
registers instead of as a reference.
