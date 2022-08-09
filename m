Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E9B58E331
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 00:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiHIW3j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 18:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHIW3i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 18:29:38 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51B865557
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 15:29:37 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279JQQvY029172;
        Tue, 9 Aug 2022 15:29:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=5iGU3uYwlikd8plrKOshYDBFVkjE4iYtG4QTo4H3Fx0=;
 b=P6voVh927BEvcgGUQAOZ12yUKC5mW+bK8FM02SEBfy3BuXnu8jn2IVHN0fzgK3wa2Vc2
 1SvZqOtKHEE/xbl7dMD6UcTrkE0FiaCge3+X+E4qmR93bCqWyC3utr3WOMXS1LUXI0NH
 RgplzgREgucIUD+p0x6ebMylkR6or8J/CSY= 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3huwqx9bej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 15:29:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jc/yTxS1t+A/eZzneHCDMetLu/JmqtFmZ8MnL4LcBXIUU/gdzuuqOlV7SYOV98aYA+zdQrgUvyWDex6gtfA7YYsVSI9xGHl3xaTy6hEs8w7g3p1VeyEe0MJblShrP8nIdRPc9XnlPNdRYbApoTR46+emU9yT8nWoPk6WTuvICrpe59yrNgLHXDZMTn/lOgcmbBBINMLH2yYX/nF1bR+esPvg0NysoPcWKjNweJu+RPxtMdb1Q2nJIeG3+/QmSeiznryCpRjXQydMTb6mnwphhcj051Yxnzi1O39AdFvaIBO+eH/eTUFPIuR7SZP/atIFVGS8VzpUmprLNWNR+7lBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5iGU3uYwlikd8plrKOshYDBFVkjE4iYtG4QTo4H3Fx0=;
 b=bZAMRq4gnEbFS3X0DM5Q9lvdw7L/XiEXzrIIVerqr2cycl4ZynHmGnt4KCR2YL2p3RBA9yFODpnQaqvnBrrs//Q2gqnJ8weMeGz477/1gAU/f6TbyEVPZofP/ak8YVndCibTmw3A6d9vi25zAqN5AFKBjky/Z+new13WjyiOR7afDxNWhSQRoV48vd3L3B6y0TOvmKq+aJUoJ9QnwWZl1cpDDv5MnQAJienwZWDaXNWf8l2Ahxm8crhsWUcPhHqreeum6smszQwXcGUQUOW01tZCdLjF8SQSr/c8V2w9zC9cqMHR5eSSaelFJ3az7m/x9BPRwfSwRHfY6Chq1+ZI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by BN8PR15MB2690.namprd15.prod.outlook.com (2603:10b6:408:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 22:29:11 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::5455:4e3f:a5a2:6a9e%5]) with mapi id 15.20.5504.021; Tue, 9 Aug 2022
 22:29:11 +0000
Date:   Tue, 9 Aug 2022 15:29:08 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH bpf v3 2/3] bpf: Don't reinit map value in
 prealloc_lru_pop
Message-ID: <20220809222908.hmy4pz3ai6howqhm@kafai-mbp>
References: <20220809213033.24147-1-memxor@gmail.com>
 <20220809213033.24147-3-memxor@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220809213033.24147-3-memxor@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:a03:331::35) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d9c73cd5-74f2-4543-eb7b-08da7a569510
X-MS-TrafficTypeDiagnostic: BN8PR15MB2690:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mdUd2l3SoboadbwWR0cCBX5gnK9XHG/KAInayrmOHmvMixJuHe6ptkmabJrr0127rpQhIn8cd5/8OdZPRwV+J007d2HjFGAgJtdEGT4yX92pUPGJga51dKGf2w2vajTgbmO7dCMTcmbp5bau64TJnOgzRrNGuLPdCiRUYk0qRgkFQiWaPaKyDBtMv8Im+bmPxoKIdfFzYMM1TJGWpW8nLTLlMZah8CU1ac6314FzferOiwrBC21cxoFYji/2oBCT37t1N2HtA5AX2syMVbBLHggnH6s2REf0Tipj1uOOk/KJH4U18hE7JWp1grvnRgfOIBqlNe2tHCaYDwrE2c5MRv9oBjXUiEPxlew6uN6ZW+IZwY8qlHDEFBoYArbaDuSqYIUrKjXRcSDKNd87QHCMnkvdUH1lCrCGTzxO9FRsrCsYbyOehNtX0RRQhJgW/uhUH8N5c5pqvQm7+CIPl5cWaQDh+g/YSj8ogyoWsAVgQl4lRxniDg814OCSf2UfXrgbvRUiBbEYu8aGU8r9hZJQbyoWrHvic/PiziLvDS7g8+Bf2l/4YVFD68wperO3NR21EKYV9doO8GEqnZlOS+6wqv8NJaJVIlBR3LaCyL0kWBWHKgBOXnWBodA0hZTW/SgkGZ6LitmI09iZA/v+0ZZL9VEu0I+sEfOMn3dD6TbY944s7dJP+xJ8aqaZL3KaEcdytgnyvGAT2EJQKJ+fA3WBeXdDJYT4SY3lr7UJGykzS0syJR3FInhvtIFFxGVl68tj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(396003)(346002)(366004)(39860400002)(376002)(1076003)(186003)(38100700002)(83380400001)(8936002)(66946007)(8676002)(4326008)(66476007)(5660300002)(6666004)(2906002)(41300700001)(478600001)(6506007)(9686003)(6512007)(66556008)(6916009)(33716001)(54906003)(52116002)(6486002)(316002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ojQ5Abdt5n6x1xZJG/rlwFFlNL0XbZoTjjfyWCWLSO6ZY6gjhAj1FKWWKHAN?=
 =?us-ascii?Q?3m/gnOhqUc+YQFuj4BOz+/XtEWW+6GujlLhL+pbzE1xkJFSYS/5QRyLVNAbR?=
 =?us-ascii?Q?yKh1bGqglQMylYFe+S4IhuTyTGBzFPhKB66SsnISAvbcRyv6flWm1uIT+m3k?=
 =?us-ascii?Q?MzgvIj1CGhyRGWlg9RajSvhDiZEdrJidGwfNe4CSFNZOPSubUUBf0XD6b4q5?=
 =?us-ascii?Q?R0G/Lv96hkUdVXOq4shhRLafWbmiHrBjNu2QK+QBIyZzLVgSEPvnKN4nKU4x?=
 =?us-ascii?Q?nGt/T8ksLdwUf1mOlTeKXEM+8ww7mL7TppLrJBbtMtIe6FIUkXLKipV2q83P?=
 =?us-ascii?Q?WU/JfGA1BTgWkFJlUET3PCHzL2XgdOqdDgM++C1YbcLXXgnRlxzd72kknmvx?=
 =?us-ascii?Q?Im3DAhlgpdYYS5elS4+cVpRzqPB7uRm0l/D59g+YwIfMa8dhC8gQlPdxKTnq?=
 =?us-ascii?Q?ezB31jQqvWYgDd+qsx9FlN9XJTMBVGVeT962viDN+oDAGD+eAWV6RW5PkR04?=
 =?us-ascii?Q?M/LFZe/tXW7wJCMtNubcg1rOi8Zkr1fNPzoa/10goUSL9s7vAu221xJtqneM?=
 =?us-ascii?Q?k6VvnKc7EqGyqJpGnAraK3B8QOBGswm5gCfn8qyqfGnpPqRD2ko6G/vZ1pjA?=
 =?us-ascii?Q?a7h5RwYArWllGeT6M3W5/K2PcgoqlZJMMML3FIBUC8b6zHq1kPXk2h/Q9J11?=
 =?us-ascii?Q?9gariw9Rio0V+7+bU9ICRV/UXlk/8qUCQIdag6RcPd680mi33Vp29AbNb0Ts?=
 =?us-ascii?Q?Su8YjdpMBht2rjZwqzc9EyWZed22xAd0o8S9JheBhxZhVIwwhl5p7OnoLmZS?=
 =?us-ascii?Q?/Xys3JWgA8XjGj1/Pbl+NX3UBe0yGDiSherWk+jJ1vd9mUDAJHPFzVSLFD8z?=
 =?us-ascii?Q?Qmve6+T2ZZXEaTzaS4Wij+kQkxxxFdYo1n/yJxeGrk9S0SvchPWhxldmIi7G?=
 =?us-ascii?Q?2wP5hFtt3MxSfH2XB4TwogMyDMWK+sdOyCCNCAWjdlS4dPAkz2x7OlSYbI2j?=
 =?us-ascii?Q?oiPRi6gF3GkXtJ7KdSIzT7E2GbTwEJBYLrn0xiiJDTwSRVOvJDmP+uEb+snO?=
 =?us-ascii?Q?Pe+miI+/zz12W8a/d0disHs6S2/CY1c44eZGAAZ4X+f0kFu7cWpIr6+ITM/v?=
 =?us-ascii?Q?iltz15N6IaNdByaOE/Ye9blFgBj3CxI/+Q4IBfPiHDHJOExUJCTK+o/FmAPq?=
 =?us-ascii?Q?2c8cy1tz2/csHTJdTT30FIpEYrQ76KOYoskjOi9pVvy2CxqgeqrDVK44efuU?=
 =?us-ascii?Q?gW0GzdMwR7mwJj66hee4S+vkGrtQZGeXfN6orZqHQejPlEUnvcBPpoXIII8g?=
 =?us-ascii?Q?TWGzo+dw0OsvwSbCr8SQK/YdZFNc/P+QDbkBux9Rt9UyEX9nKeoGW0QwMdvU?=
 =?us-ascii?Q?uEDHo9TgACbUS/9ZvEjCU/2neDIhvqAQkn+lWSL/rbDes0M1cuQ+UOJx92Ss?=
 =?us-ascii?Q?WgUyEMEuneYCOc9MGe2h3T+yUt6+HH+W/7MdyBkQ0VqRk4xhdwKV2AMe3710?=
 =?us-ascii?Q?gLtvpLaJyBl6QlaEp3sk1yJG6DZVtmDIzMJDBZreB0s3PC8sd5Fe0TV24tSG?=
 =?us-ascii?Q?6p5qD23O0m0vMvstTUfyCam6pO/OYS9zhtXmd0lhR1gJHpzicOzI2I2+xzkR?=
 =?us-ascii?Q?LQ=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9c73cd5-74f2-4543-eb7b-08da7a569510
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 22:29:11.4445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DWnok4XC0IS4Yz4nSWz4gRp2Ka4FoZHf82JugqYuQYGFVcuWwNUkfNMduvZfXcH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR15MB2690
X-Proofpoint-GUID: SeA4qQPnHiprysHJv5ilT-9wCrmBSvKz
X-Proofpoint-ORIG-GUID: SeA4qQPnHiprysHJv5ilT-9wCrmBSvKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 09, 2022 at 11:30:32PM +0200, Kumar Kartikeya Dwivedi wrote:
> The LRU map that is preallocated may have its elements reused while
> another program holds a pointer to it from bpf_map_lookup_elem. Hence,
> only check_and_free_fields is appropriate when the element is being
> deleted, as it ensures proper synchronization against concurrent access
> of the map value. After that, we cannot call check_and_init_map_value
> again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
> they can be concurrently accessed from a BPF program.
> 
> This is safe to do as when the map entry is deleted, concurrent access
> is protected against by check_and_free_fields, i.e. an existing timer
> would be freed, and any existing kptr will be released by it. The
> program can create further timers and kptrs after check_and_free_fields,
> but they will eventually be released once the preallocated items are
> freed on map destruction, even if the item is never reused again. Hence,
> the deleted item sitting in the free list can still have resources
> attached to it, and they would never leak.
> 
> With spin_lock, we never touch the field at all on delete or update, as
> we may end up modifying the state of the lock. Since the verifier
> ensures that a bpf_spin_lock call is always paired with bpf_spin_unlock
> call, the program will eventually release the lock so that on reuse the
> new user of the value can take the lock.
The bpf_spin_lock's verifier description makes sense.  Note that
the lru map does not support spin lock for now.

> 
> Essentially, for the preallocated case, we must assume that the map
> value may always be in use by the program, even when it is sitting in
> the freelist, and handle things accordingly, i.e. use proper
> synchronization inside check_and_free_fields, and never reinitialize the
> special fields when it is reused on update.
Acked-by: Martin KaFai Lau <kafai@fb.com>
