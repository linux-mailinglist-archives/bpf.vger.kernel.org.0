Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36D34ECC13
	for <lists+bpf@lfdr.de>; Wed, 30 Mar 2022 20:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350365AbiC3S3J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 30 Mar 2022 14:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351577AbiC3S24 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 30 Mar 2022 14:28:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BEA657156
        for <bpf@vger.kernel.org>; Wed, 30 Mar 2022 11:25:28 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22UHKgLU008508;
        Wed, 30 Mar 2022 11:25:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZZNyT8adx3a2wX6dIJugAWDk4bnBooIkIz64exEjS/Y=;
 b=eK50vLybm+Xka/hMfSQTjh6r4apEG/sArpT3Fbm6rt1JAhupToXNMab4Fo+tqz8J510l
 mFHCqE/e6WtItl7e5I5RoK5J/ApW7GQ9GWjIskYQE2dGx1RwIoVqSw77TiWhWs62AXYx
 4CXNx6EVNXkPoInQl7NKO7QeHDL2pREHczI= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3f3s5ymx3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Mar 2022 11:25:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afJcRTsdXx8z9/YXAkb6m0vPuHMZXsiL4ZIrlFCgJs+2zbnWg4t99czGe46q/Jx5heElIFpUkuVbVOtu9xjTx2GzeynXa4hdWrzXeruZNSbIDDu+uzIcfqmFTQ2Mqnq8RSJVwrDfnMhH41PKck8G8ePgSXjUIQ2ykZvOoQZ4pY38CifmLsDzVO2isTgNa4XZC8vmCRNEfYIufNVoDk2ROPn1C9SRuDe8YfS0qmM1SmJBxwQV+Ap8+1JL8cemv8as47qF0+4xraVgU5befSoPCkh5s0/pxDobFNgRNeZw1xegqDMP9o3a2G4bl5F5FLJJ1EZzxc/fHzi8OIkyreLVww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZNyT8adx3a2wX6dIJugAWDk4bnBooIkIz64exEjS/Y=;
 b=Z4fOCnjlXnwpyG7gd7kttZMRhQWaee53rT22+kPNrZUshFZq0ljLR8OXuB5FGm2V/Cn0cwX6g096AP4dOrl3FTWqGY/EnuZrwGFW13fP2s2Pboxvyed4iKMoHKFVPA2VKuXswA6OgQIn4HSMDV2EHfvuiRU9IYf4MKqW5aFsNRjrLocxEvOrMqh3Ctr/1KtaM2nWTHBMWo/L1KSxt+VS17oW6kaTBf4Ypi2Hz+EP9Do5l7WhOUNr6CDBxmFpj/qQBkfnQLI98SMlYARBuVnWK5KzeviKpjT5HXxPFFC9RVFDGIRvf2ihf8/Oq/kziO0jIw0iOngLyRmuX5K5gzYyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB4694.namprd15.prod.outlook.com (2603:10b6:a03:37b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.23; Wed, 30 Mar
 2022 18:25:09 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::4da5:c3b4:371e:28c2%7]) with mapi id 15.20.5123.016; Wed, 30 Mar 2022
 18:25:09 +0000
Message-ID: <c5487e82-f90d-9cf4-29ec-04314428019e@fb.com>
Date:   Wed, 30 Mar 2022 11:25:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH bpf 2/2] bpf: selftests: Test fentry tracing a struct_ops
 program
Content-Language: en-US
To:     Martin KaFai Lau <kafai@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220330011456.2984509-1-kafai@fb.com>
 <20220330011502.2985292-1-kafai@fb.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <20220330011502.2985292-1-kafai@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0252.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::17) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8dd1df4c-b516-4cfe-e20b-08da127a9f62
X-MS-TrafficTypeDiagnostic: SJ0PR15MB4694:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR15MB4694FCE7F557B67CC2099B70D31F9@SJ0PR15MB4694.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: liPpda065IIGh1cOo6A8DRUpSfGMhlz6LCmtPdsGeA7F6zUkDrOBTSQ+IAlJMkC94vfGjd7/ndXUHzTdLC46cvIzHeBu2grV+tkV7lR9DvQkWC4Zg8xa1MnSY+BLwDV7RPF1/tLDds3isyvKI7t+/Nk5ipfg79ClD6B2zGGtiFqH1fb35hbA6DTwT1BZyg0xy1/daRFFHPjUre/yjUkT2o5A8y4h6HMz6FctivPfjjv7UclnUlCDtuEtiv9vKue3jQmxgkRKAIuCdk3rzYF28nTJ2nlxDerNJpHdtsPwEGm6JeKNvndOdyhabciSG4oPy9bUD+/Z9c0rs+EqEmo+P5qow4FY4/OeQTvapOSDGxD5JXnNvb1DrRqYSs6YKZKebDCgkBrqZa/27sxLBstC0S092o8HjEjrbuAxewEgg7jXwm8FnMBJa78CW7PC7EAatbhiFwKWrxVXoE6OjJnnXARXvyWkAKj99+/8duRdrDHNxC5RsKTkuiGTj0/7cHz3nRzmx4i0w5vQTnpaO1th+2pOX1fHYSFkLksyEbHjSOkIQ+o+d03q8l1EofTRgEdw6AxtlRSuaW6cAr0SxXTwxIyZz31hf0sUKFvmKp7w3ZiNyuooqWWriXaQ6wxVaJjGiLAiEIeM/xfFqORJkPqZIAPwt8YXcG5JsP/QwtTF0Wm1/n89Qmiyzz2SCFfkdXrSba/T2ZzG/C2+dIDSKGjMRV1DC5Ls7FbeEXt+qlmsau0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(31686004)(66556008)(316002)(4326008)(53546011)(66476007)(6486002)(8936002)(52116002)(66946007)(508600001)(5660300002)(8676002)(36756003)(6512007)(6506007)(6666004)(54906003)(38100700002)(186003)(31696002)(2906002)(558084003)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVk0ejd1Z25TM2w2WHNSRnNmdS92QzR3NWQzTlEyUklESXVFQmpndEUxcnox?=
 =?utf-8?B?Zk9IU1pETS9kWFAyZjB3aUF6d21WTCtSVUtRUVI4bWJRbnhJRm9GOW10YllS?=
 =?utf-8?B?bllpMEdrd2R3WHBZUUtBeGhaVm5EaFptYzZuYjh6a2FMdDhxYXZZUGtXNlE2?=
 =?utf-8?B?MXpzTXlYTFZvZzZGMGlQNldtbVh3Q3dhd1RlZUljR1RRRUpIblpGWmlpWHln?=
 =?utf-8?B?bmRpQ2FkcFVTOG1OZXFJaXBpY255TkkzeVR3bjlDOHRpcS9tQzhxUVU5cHha?=
 =?utf-8?B?LzVyM0FSa053OFArZCtWVHR2eE5ZK1JUeEFNRXhWa1hSQUtYV1gxVExCazFC?=
 =?utf-8?B?dDFwRUtWcFBQUnVMcUJyZ1R1b2ROSjMxSW42TnhmSkcvL1pqc3pKVFBkSTc1?=
 =?utf-8?B?Q2pzSlJFQ0YvblRXZDV0cmlTYURjRWV6bnNDOEdVS3FWdmhhaEw2VHVQWVN1?=
 =?utf-8?B?d3pYRmtWM0R6RHQ4UUxoWWNEcWhVdUVCZVpDSFMvK2hvT0JoQktOODNWYlRB?=
 =?utf-8?B?Mnk1d2g4N1k0dkpUUldrQ2F1RFNmNnNiblkwR0VoS056YmU3eDdxRm5qdmFF?=
 =?utf-8?B?WXdLcFZjbnRRZjlQcFNLcW5kVGk1TmRXKzhmNkx4anZvK1BvaGw0eXVKaUg4?=
 =?utf-8?B?WHhkOW1nWEcwOG5UQWFFOGFDZGUwR2VoT1A3aERQOUNLdE5GdldoSVFydkg1?=
 =?utf-8?B?SWhHTWRiazFmeURQSUNXRTIwNTFXYlFMWmNnSi9vbXFIeCtzTXgvNkdxM2FI?=
 =?utf-8?B?NUVXeGpwR0Fkbm1zMm01NnZac2t0eGoxYTVPT3FsR3NDbXFjVXhaTU90WHkw?=
 =?utf-8?B?cXJnSFRCSm9KOXR0alhsU0FVK3JhVW1QaUZBMWZRZFpZVWFRWGJKeFhJamx2?=
 =?utf-8?B?dVNQVVRKU2xiMUFLQ3BDS01OS2x4V3VpYU50Mm5XVjhpRy9OT3d3Q1JGMmZ1?=
 =?utf-8?B?RDNRNE5abk9vWTRsK2VkclJaMVRsU1RlenRXWnlJeG5qVWNPbVAwVk9aWlpV?=
 =?utf-8?B?S0VnNkNURmltWEh3RjVPZFAyOHlEeHVXZjUvQlFWN01Nb1ovMVZKRWpOR1hz?=
 =?utf-8?B?TVoyVkd0bWJBekJ4WmVmUW9LeFJhWlhIejdKTFZZTVp4V1hOK0o4M3RHcW81?=
 =?utf-8?B?WURPZmo4UUNROEkwbDEvZXdJYUJkZmR4ekdyOUY5bVdsM2ZCYWlaTW8xTlI3?=
 =?utf-8?B?QTdyaUVrTm5zSDc1Q2RWUXR5R2FTZ0MzMjdvZHZZTkxubzFyVmFINHFNNTNS?=
 =?utf-8?B?QnNlNTBmdElUT2w0eGxvL1NkdDlLaGsrei9YWjFyencrdjArSUR2WThMR2VQ?=
 =?utf-8?B?bTFtQXV2c0RhWlZ1Y3NROTFwTEhWSVFEZjZyM2hiTVd6MkNTdC9NYisxcTdW?=
 =?utf-8?B?SWZxVlFuV1N5d0IyLzFvZ0pZV1E1MGcwNnVrSjBsOUJHWEZ6OXhzZk0rbUdP?=
 =?utf-8?B?UUhzM2tTc3RlaXZnZVdUc2lBWThzUGptYlBveHVrdDQ3UkxZcFRST3VTRnZN?=
 =?utf-8?B?R2FheGtIK2tkZmh1a04rRHdXWk1vRU0xUTdsNE4zdlRUQm8zTlVpdUFLdi9C?=
 =?utf-8?B?R0ZFS2RFRXptRWVrZVFmUTdNeVJ1WXJZRGhVTnlRMjZlbkMyRlZ0VHZwU01s?=
 =?utf-8?B?bjRFeUoxSWhEcFpDWkJyem1GNU1FQnNTTm9lQTVhVDFMUExpV0JxSk1rS1hV?=
 =?utf-8?B?aVNpR0FMMWtSNm51bzlzQXBQb3I1RnNDbUIrbDJHL0hUeEd1bFVaY0M1YmdN?=
 =?utf-8?B?dzg5VzVoMTl6clVZU25iRmJMeHJ4aytIYlhkK3M2NFZ4L3JNeHd1U3RkQUVz?=
 =?utf-8?B?Q3UxVkZiakdEczVYeFpERXkvSWVLdlhDbWg5M1B0WVdTREdsci9zYnNQQkM3?=
 =?utf-8?B?SGoveVRIcEdJam8zcmwyYjdkdWVldWZqdXVSQ1dFL0Q5UHBZVWs0U2Q2TzVl?=
 =?utf-8?B?ZGx1OHZzRWttUUhZTEZqYk1DU3B3NEh6eFQzV0R6dmVPeDF2NFZzVmVoaVg1?=
 =?utf-8?B?akRLRm5MOWxEMGRuSEJDZ3AxRFU3MzRZdWJPUVphZWN0SEdyNzBOTC9abkl4?=
 =?utf-8?B?eXEyYlhldjcyc1NCa3NNZG9wVG1IOHNDN3NZY0ZVNkRlMEZYZFVXaDZ6QTJY?=
 =?utf-8?B?dk9DT3RYMUlnMnB3Qk9YdXZOQVcveGZrUmdIVHR1YWFVUkVDK0VQN1FCUVY4?=
 =?utf-8?B?UUZXTHd2VVlxVENFN3ZCeDlqWU5qa0ZUOEdwc1lhbkpiSEloNWYwMzFJZjJV?=
 =?utf-8?B?SlBuc1RDTHFqN2x5NktHa2V4a25hTlhPNjNkN1JNOXRXVFdFWXdETm5oOFZP?=
 =?utf-8?B?U2J5MHpPM2FUcDgycVMya3FCQlpWdVlJUGdiMHpueGwrU1dUbWZuZmtQSzNK?=
 =?utf-8?Q?DCG08zHErKXS5QMU=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dd1df4c-b516-4cfe-e20b-08da127a9f62
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 18:25:09.7901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uVMTiXzTYbzttUstHy6E0K52C0jBIMtNvYokZd431Ow2RtU9yWJSB/bBWniwOqqm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB4694
X-Proofpoint-GUID: 8_M2DpDENWd1nQQCaAjsB-Sp93Fp-_FI
X-Proofpoint-ORIG-GUID: 8_M2DpDENWd1nQQCaAjsB-Sp93Fp-_FI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-30_06,2022-03-30_01,2022-02-23_01
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 3/29/22 6:15 PM, Martin KaFai Lau wrote:
> This patch tests attaching an fentry prog to a struct_ops prog.
> 
> Signed-off-by: Martin KaFai Lau <kafai@fb.com>

Acked-by: Yonghong Song <yhs@fb.com>
