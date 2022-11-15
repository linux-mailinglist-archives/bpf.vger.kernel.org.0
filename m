Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D963A629F9F
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 17:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbiKOQxR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 11:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiKOQxQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 11:53:16 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE85F12D27
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 08:53:15 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AFGNKaJ032624;
        Tue, 15 Nov 2022 08:53:01 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=1IOqWDa56CgoRU2rB2pIvVEJ1HCmE+J5nbgj4AM88sM=;
 b=HcZD9rpwmzpSNMjyrnz8hA69fBHLp84kn0szDZtHtoIKpCC92Ry5KzhCO4lYTBPCk6dr
 txk+tXuWjfvXN0eN5sRstgWX5xCiPtgha7GHXaZhH8Rdua3JXbBG37Uihdp9+jT0nACL
 IPkQgMduBlZcp7yb534DxcIlAZNr6q9Ipz8jYdoeaut4EfXbVQ2IunMfTUvs1xoy99Df
 4X8rq2JUGv/I1LvBhSczdLXvSCQrR3I5DZROywllNkcpVz7lQG+Z+3/k+5fY7gXHs4hV
 JsPnVcfOgpGC9kLubANU5aXPxNpwtcS4b6jCVJmROGtI8qOI0qlc3MsyvSt3+mryHxRp kA== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kve8689ep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Nov 2022 08:53:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLSLjxYtQerV7ccv11TWUNIuuLCUC7h3EqyADJevjQwQPHZl1dn2Y1tC8JBxctNUmYOwKwkS3O3iPtRxvei9rAeKO657hrMGgxGEY/vpt0nPVBqem1CJf+zbRjaWPfIeyXCQtGCs99f9iM0i1pKIpC8FPlqjoxev2bxowzhrQfEbvXiq4KQalmyan05xAJKsFhDXOLtX6xU3eb4lXvQVHRk05GOJRSC28A70l9SXXka3c6HSnITxu7H6KQ2HNnSfeamICdPdPk8S2v7nloM7hR/dkT6jRPGANz7VM6mL9ICQma9ZmijUmOkaoDOjHp4WdznSnltIZDiVZH8bMtEFYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IOqWDa56CgoRU2rB2pIvVEJ1HCmE+J5nbgj4AM88sM=;
 b=MGM/wg3uqTcPA9stj83+TSW9k36voWJPO/5MFRjbnCS3+WEh99V8lkd6tPwoHoxoN0h3jI1k4XyoA9qqIykMtE/+cyW5sIbNwijcU4KqcX7McAKTPkZkc4qX8doqgNprC8qSAfV48M/LryE82Lp3MWoAXwD0YzJx6q9sKniLbZ8aKwgawhnaS8ajeuJGSJ69k3VNX3zd9QLLfG5UEiWMGb9WCyhgUaSaZMpJ6pcueGgxoXO3hDnsTggdQlNHgexDREN0JC2gzZd0tHHxgoGDFJBNeLI3tOo2b1hsZIyZavXiK4mGbwzGD/vmha3+OVWePO9rZWGAhGUEsKCASJkESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by SJ2PR15MB5720.namprd15.prod.outlook.com (2603:10b6:a03:4ca::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.13; Tue, 15 Nov
 2022 16:52:59 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fc34:c193:75d9:101c]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::fc34:c193:75d9:101c%4]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 16:52:59 +0000
Message-ID: <f0058919-d90a-bf0e-100d-fcd991093ee6@meta.com>
Date:   Tue, 15 Nov 2022 11:52:56 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH bpf-next v7 21/26] bpf: Add 'release on unlock' logic for
 bpf_list_push_{front,back}
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221114191547.1694267-1-memxor@gmail.com>
 <20221114191547.1694267-22-memxor@gmail.com>
From:   Dave Marchevsky <davemarchevsky@meta.com>
In-Reply-To: <20221114191547.1694267-22-memxor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR19CA0020.namprd19.prod.outlook.com
 (2603:10b6:208:178::33) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4039:EE_|SJ2PR15MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd14b18-cfd6-4ccd-f75c-08dac729d921
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ElrquC/k2rweQl2D8pjMC5h7osPt3vHJZIbcKDjUOf6VxndUraIdLDsEhjSgqxrn2WiISadN3Ddu8YyhxOmtsyxhYzKyktflNqkVIiUpBJ2UGBbk0yKOESoXeGgE4ozcW4vFYR6colB1YwbNTk4opAFGwcrF4IbMVilINgTf6xgi3VfgEtoCupqqI3YeIvnbqUZqNhn2ImrTjUNLPHE3iK8IDSr7BOx8/6HpSHSb5x1/kcg7tF9P7oft6EQaCqnKElIhmfwOd9qsmfZ/l0bqY7tM8Yx6Lzb+lqvqULkt8U98pLrhzst4hQmauZczMRoVJsXBpkKSa506gi612/tmdbIDkTVjWR7qg1xPWhY1XL5CRFmaL0YASrHe2OIudSeN6cG0nuHo4dB0xHoQmAoc7ZdIVHUMPvK16ojTluxQlJoVZfz8unq8s7eMsW6Y/95karsasGI+7I/+zVUjaZ5s1NxEhf/RbJUM/Tr8IA9sSxwrQWg90sl0ZyZUlKeBV5ARzfKwYMOC2+tONSTHT0P+A7NgICdtH3dz0Kojtm8+YfpN7SKGQXBbE8bMzgDLirzXvZdYQmp/MaEJyaDFEwFvzoGjvU1Bb6BKJo0ixazOWvTSe/dTsdmPpxE5p1Ikdley/H7hTL8/lQqVE+iPz+kMeukxaJW8MZvh3WgFFi2JCHnapX7a2EGO0Yxi5MHfbdWb6b+mg1+2/gw0lnyKlYX6bBce/Afq6IVqLctO4HZbHdfWSiCzwR+THwMInY2E4Wj7wKXG5ELUF3fK5KrpRcsdduG4ZddsKak2+t+9CB6q+Uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(31686004)(36756003)(31696002)(86362001)(6512007)(83380400001)(186003)(53546011)(6666004)(2616005)(38100700002)(6506007)(6486002)(66946007)(66556008)(478600001)(8676002)(316002)(41300700001)(54906003)(8936002)(4326008)(66476007)(2906002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K01hM0xVb2dRRGtXYjh5ODFQWjV0Ky96UHExekt6Tm5kdFMrWE9NNm83aW9Q?=
 =?utf-8?B?NHRSaHhMZVpyTWNsZ0FTWk52N2t4K1FjUVlSTUVWOU83cEZ5bmxwdE1qeUFu?=
 =?utf-8?B?SnV1S2ptOWxCL090V2p2aWFqSHZNWXFyOWRUbzR6My9BZTNRNXJwNnY4dDNj?=
 =?utf-8?B?enJyL3hVS1hFb2MxOVBNQmhJTFplWTk4OEFHQjVNclBxcWU1OU42TVdyUjMv?=
 =?utf-8?B?bFdHTlgzNFgycDc4bURXM1ZBcnBld0s4a2wwREhheHBFc2M5U0U2Y2RIMGJv?=
 =?utf-8?B?Uk05SDZldlphdlVsenVkZ3dUeXRibjZIQTNJZytJRGhwamZZd00vUEpBd1dr?=
 =?utf-8?B?RXBsa2ZwTHJmWmJhdjZKall2b2x3L0hlQ01KV3lHL2E0VXZhUHczenk1U0VP?=
 =?utf-8?B?Q0NLcUx0L3BiV1pqeVdpdnlEK29XMWdhcTZZczMxSWErRzRaYitMMy9DTWpB?=
 =?utf-8?B?N21KWTRGc2Jjd0JWZVhKV29JMVFqb2JJUXZKQ3lPcmFBWlhZMUJ1YlJsREpT?=
 =?utf-8?B?eHc0OWRRbmhPRUE4bXI4S1BnclY5NUdHTzFGTmhrT0VqUUFTd1dDV3ltR2ZL?=
 =?utf-8?B?SzJNbmc4MjdubWV5ZEdqVWtySmpHN0xZZXVSczY5eDBIaVpYa29KMzZWM3RG?=
 =?utf-8?B?WFZ3ZU5QZWkyMWFYcE9LREpOaWNNeC96Q3k0NXVhT1FGSEVXZWRGMThFTmpL?=
 =?utf-8?B?b1VFQ3BYQlBQNWFsMWwvMmpEQnZybFIyUWJBb042SlcxbWVLVldMN3pXUEgx?=
 =?utf-8?B?bjJiaW9kQTdPRmpJRHMwSTc5UHRTYm1vN2dBWFlUMnhJa0pLZW91N1VSaW9i?=
 =?utf-8?B?NHBQaURWSkpYR1lPNlJQeTZ4Y1ZGVVYwdHg4dU9jRzF4dVBGek8rZUVnanpz?=
 =?utf-8?B?ajBzZTNTSG95WEVSL1RuWFdmSmhLaXRwNUpBSjVFSUhNekhjNGlxTjJTNnVh?=
 =?utf-8?B?YzNzNW5yVVFxTEhyV3haUCtsand3bkx5dmZOMXV3dkx2TFNGM2owMmFZa2w0?=
 =?utf-8?B?MEhBc1lZSXBsUEJWTGluK0R5bDRWeXZVOVJsTlkwZGpoWUs2SXJoNG9TOEJk?=
 =?utf-8?B?N01oYWpZSHpocGxiTVBCekdNWlY5d09TcjE3QWt0R2pCZEJKcXJubEJ3cUkx?=
 =?utf-8?B?clFzNUJSeWZIUUVaLzkzZzlQMkRHVjB4d0dLcDFrNm5UVGVkOUlzWWEraXli?=
 =?utf-8?B?WXBTZGdlU0UrMXRRUWNWdzdKa2NVNXUwU2dJbVBjNjJESkhtU0pJTWVsUGJK?=
 =?utf-8?B?cW9VWlBkVVRtci9SQ1M3WU84VDRhNVhOVTV3eTl1NnV4eU9KbXM3UUl4alpw?=
 =?utf-8?B?TExQbnNneGRvN2VBRWVORXh4Z3h3S3VrY2ZCbHVCTFY5UzR1YkxhelZ6SVNI?=
 =?utf-8?B?R2ZxcVJOYUczQ0JFdXBlU05kMTV1eUxCbXBuL0c5SnFJOVBObzI0eFo5QnRX?=
 =?utf-8?B?eXRRbGhPcTlNUVE2N1hKYzNXVm1DMWFxQXV3UTdRUTVwV0JWR3N2Z2VqQVkv?=
 =?utf-8?B?dll0Z3Zya2FmMVBIN3F5Qm9GSzhTSXhONEtoRXM0Y1BoOVRNVXRDMGJPTU51?=
 =?utf-8?B?VXNXTGM1Y21TWW1GVWtwVGV4Zk0rQ2FSUmZBcGYvdW9NdExseXluZm82c2x1?=
 =?utf-8?B?K2xVbFQyWHgvaVJzZmlyeHlsVjg1SnRMUzUyclh6MGtES3hWYWhnVTJUN2dJ?=
 =?utf-8?B?MVlUZDhWSEJieW1ZbGNYd0E1WWhnRHBiK01oWUFyVXpibnZkRDh5STdjc3lU?=
 =?utf-8?B?a1EwT3hKMUJyRUY2dnZleGF2d0x4SjVteXBHa2Y4MXRzYkxJTkRpb3VZNVJS?=
 =?utf-8?B?aE1qVmdpdmlZcE0ybkZVV0JtV0w3RTdIVkJGYklkVXViOEtJZ3RQbnVDeWsx?=
 =?utf-8?B?ekZIaEdseU5lYWtXZlNXMEFyVWNib0R2WHN0MDBQOFg0RVpQbEwwR2pScGth?=
 =?utf-8?B?N1YyaFhBa2kwbXFpOUFsRTNOSytxOHdESEszWmNaSnlYMm0xWkQ2NkFJMzZh?=
 =?utf-8?B?V3llTzJib3hsM2FncldWS1hiR1gwRzRFaUt6NzlkL21zbEJ5YndzK0dEMFpF?=
 =?utf-8?B?UmkvU25RSE5ZSlkxd0JvY3FGM3RGdGpnWExiYkpnZnRMREk3N3A4dGhGVmZI?=
 =?utf-8?B?Skc2NGI2bFd4SEsrRmlqLzZFRGpBQ1BvdmtKaC8yYVYvRWlqTkxaaGsrQWJl?=
 =?utf-8?Q?h+/3tjArnDsNUH9oiKrkaNI=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd14b18-cfd6-4ccd-f75c-08dac729d921
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 16:52:59.1825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wIubzaQF2MGkskytiUZGjXYqN6gu75OsK9fvKQ5aYBU1kdMl1vkgPCI+siVVYZEJduazwalYbq5ZL2Ijh6S75w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR15MB5720
X-Proofpoint-GUID: 1OUHu__1YCOMKuucUDGTPwhPv6KeM3KT
X-Proofpoint-ORIG-GUID: 1OUHu__1YCOMKuucUDGTPwhPv6KeM3KT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/14/22 2:15 PM, Kumar Kartikeya Dwivedi wrote:
> This commit implements the delayed release logic for bpf_list_push_front
> and bpf_list_push_back.
> 
> Once a node has been added to the list, it's pointer changes to
> PTR_UNTRUSTED. However, it is only released once the lock protecting the
> list is unlocked. For such PTR_TO_BTF_ID | MEM_ALLOC with PTR_UNTRUSTED
> set but an active ref_obj_id, it is still permitted to read them as long
> as the lock is held. Writing to them is not allowed.
> 
> This allows having read access to push items we no longer own until we
> release the lock guarding the list, allowing a little more flexibility
> when working with these APIs.
> 
> Note that enabling write support has fairly tricky interactions with
> what happens inside the critical section. Just as an example, currently,
> bpf_obj_drop is not permitted, but if it were, being able to write to
> the PTR_UNTRUSTED pointer while the object gets released back to the
> memory allocator would violate safety properties we wish to guarantee
> (i.e. not crashing the kernel). The memory could be reused for a
> different type in the BPF program or even in the kernel as it gets
> eventually kfree'd.
> 
> Not enabling bpf_obj_drop inside the critical section would appear to
> prevent all of the above, but that is more of an artifical limitation
> right now. Since the write support is tangled with how we handle
> potential aliasing of nodes inside the critical section that may or may
> not be part of the list anymore, it has been deferred to a future patch.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Can the two WARN_ON_ONCE in this patch be converted to
verifier-log-and-EFAULT? Looks like they're both in
functions with access to 'env' and are checking for
scenarios that should be considered bugs in the verifier.

Aside from that style nit, logic and patch summary updates
here LGTM.

Acked-by: Dave Marchevsky <davemarchevsky@fb.com>
