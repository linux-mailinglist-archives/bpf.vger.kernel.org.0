Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457CE6B3F93
	for <lists+bpf@lfdr.de>; Fri, 10 Mar 2023 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjCJMoN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Mar 2023 07:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCJMoK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Mar 2023 07:44:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5ED1109742
        for <bpf@vger.kernel.org>; Fri, 10 Mar 2023 04:44:08 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32A2nr8W000704;
        Fri, 10 Mar 2023 12:43:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=7rLBf6kHDk3yPUvRJ7EJQTpsVW5KIVnZO/I74MtZofo=;
 b=CK6DiR8ZohjTC5VGOU1Jm9xrRYRX+gVc7EuXiwgGQZ7XODEz/GWbRFxlg609PpOCBBnv
 kDRcs9upcgIVr93yoE3gwr1rGeVSXTlQaYdUdC+GyOM+VWfXCjeQyAuGhqkgYgH8SEuu
 cqdiKzx7lPP5a6CNvE6quedtsUmXepwJa4fMRV3jNNsyIdc9bam4x4j1IlWMV5SpWQlT
 tJGN1tPXCgNgIbaNuuw37cO9L+Mbyf56kNM4/0PdiW4xKzIKOc3SdnTXvFteb1kd09vZ
 Fz4wYoA91e0/vZmhtT7vi7hW5veI89sYOQn3x1AZEWVCTCLorFwLln7XxuIFjQiruo+A +w== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p7v3w0tbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 12:43:39 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32ABq6NX036459;
        Fri, 10 Mar 2023 12:43:38 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p6g48d8gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Mar 2023 12:43:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLgd7HKhyO55I/4sTr0NhHQ/BiPhro+KARp5AWCa8EoG/83LsMFISJQb6WcyZ2ejvvJbHC1swHjK1OS8MDBs6JFJ2U+/TXbzPb2ikU09URBqUA286l7t2XvIFBXUmf7NNoo9D1bX/iNgR0ePdure2oZyAEXKDvCNgAecklNZ7xZT6uVl0EvEIOgrJvu00ojydi3c73mFf8Cnf0uMBfAeqyN8f1n7lg4+LY11WA1cEihVdHThi2E3OUuo2NJDnnSHzuTpa5FRwsCWtWnBEgA338v//vBnEzFK/ReePhSNqlQF7zOOZFwcMVErhVNHO7KALmrBTHle6ml4SjhtAlRV2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rLBf6kHDk3yPUvRJ7EJQTpsVW5KIVnZO/I74MtZofo=;
 b=FfPhIJsVm6zwNd8SxVyi9tK4m8NVjIJ2p+sCd42fdCh94+QaBXtk7YkWk14C2J+JGc2rSP+xzgcJqguUY2SPcqvdI+CtGcxLSHdYj2yR2aHCwISWh55yhgzDoNa+jbfaf5CL9sF2XUeB79ycP4oR5eAeoB5CY27B9Rmvf2Cd2II11MJzxumcNt/Oiylw1FtPD+K3ssqKQHypHTOnRmWMBgI23FdiRRoULp53Ezzp6EcqKFNpI/DIukRmMG3D4LmixksCwjfpRABY+76fq+XZXEx+eoBP09F4gXgXMh3fgND7H2ucjs4MpjQ0XkPsFYDx63BssSFieWOFQvKP9NpANw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rLBf6kHDk3yPUvRJ7EJQTpsVW5KIVnZO/I74MtZofo=;
 b=nlobvqAyCB6sZnOb6JR/+FzFmfjRhkjeuiZDudAS08G4F6eRNL/DPQouvnuJ3TNzNYV13teJPqhaYL4ec7yxPC5Yf0L76HmM+CdEvGy0bXempm7oj0njc0lvT6CbUx2hEQ6E4EdVHlR863/QGS0mT9OZFiB3XmfUHN6mim7bqHo=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW4PR10MB6393.namprd10.prod.outlook.com (2603:10b6:303:1ec::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.19; Fri, 10 Mar
 2023 12:43:36 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b7a:f60c:7239:80a2]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::b7a:f60c:7239:80a2%6]) with mapi id 15.20.6178.020; Fri, 10 Mar 2023
 12:43:36 +0000
Subject: Re: [RFC dwarves] syscall functions in BTF
To:     Jiri Olsa <olsajiri@gmail.com>, acme@kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, bpf@vger.kernel.org
References: <ZAsBYpsBV0wvkhh0@krava>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <faf34d4b-d7a3-2573-383b-2bd8db422734@oracle.com>
Date:   Fri, 10 Mar 2023 12:43:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <ZAsBYpsBV0wvkhh0@krava>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0023.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::20) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW4PR10MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: 56041f1a-35d6-499e-3515-08db21651107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4nPvPvobXHu2ihPL+dwiRCpEwe4+MrlrOz7c5Qmt2j8QCgev8J5a8GnCI9323gepVQloHlXBwEMFxglfOxUK5Q74BRr+vKdaMCV1TPr8CkIpa7aqhuIRxcmmfvumosobwb6N0KJg2cPU2PtoZ8b92FXLXzvXnqaw0f686hHrGWmnsOL4Jp6vPG3TdY/CaHDYqb1lLCiPgnPKCxT/zWZFGoYBCcFTYDEbx/AZHjuCt50oxG8MpL+G3fTOsrOSbjHjKXrbFfzWkCXhFuhNVASiWq38lZzw/Tdu9HANKZRdwNAxEniR1qZRKKxICf7VaQ8/V7Qv9nw+QM2zX8jfQWb0DFBDULfv3FqvGasdY9eaS+qi9yAOwiDgsxjX4wvzkX6iivqNnc1TTpRsbaxaQ/So9pAuNla8/kk60F43kRNQul2rWMcQc8KEnQo/XwElWf2IKHWq90e8LnFzLTlbU/tgVAVRHQijZkcuTXOB7Uu08KbYnBcnm3yTHYhgPN3NNCgZJsy5h2gxvD1auk4etJ9Dp24JS/kdAvVBHkxsfjkXCk7ef/pg3vQvPcKg5ELCfkVWatKMUaafS4MVFi6RwQvEsARh/l250ekYmCNSHQlmyNpa47EzwjD7LHRmAM+U6JU+elggogEdCR8XLMv9aloF9xP39guxIxtPeI0ZxlVQU4Td6ZJ/pbjbReS4aq+y6l5DcJH3zKzyJQVAlWUOpjxlPdC2GRdJAWyZvq5zIwhuU/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(376002)(396003)(366004)(346002)(136003)(451199018)(6486002)(186003)(36756003)(478600001)(31696002)(38100700002)(316002)(86362001)(31686004)(2616005)(6512007)(6666004)(41300700001)(53546011)(5660300002)(66946007)(6506007)(7416002)(44832011)(66556008)(8936002)(66476007)(2906002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHE3QWxkV001VXV6SlpEYno3VEw1c0liVVFCQXJvRlppTU5ocmR0QWlacSty?=
 =?utf-8?B?blJYTm1GSEVLY3h3cW1VOG11QzNHOUg4TlhobVN4V2tFRWU1R3RMTFZLckE1?=
 =?utf-8?B?dHNQQy9heExwb0RVeFZ4Z2ZsM1h4RW8zaEthaVhPbmZKV3Z4citEMUpPeTZS?=
 =?utf-8?B?Q0tpaG5UMXFrZUpJQVE4dmJiLzlHM0ZIZ2FQTEdnQThrbW44WU13Ry9oOVh3?=
 =?utf-8?B?SWRrdXZJRUpCejJxK3VYTFJwbU0wVllHbWEyYTZYMU9HVmRMN3VVYUdkeHFn?=
 =?utf-8?B?RGlUYVZiTVJiLysxZjA1K2t1c01pNDY1WUY2SHBNcFhKWkF0b095UzMyQzRZ?=
 =?utf-8?B?UUhuM3VRYWRqYXQ2SDRFSHNyNjZwRndSdmpFTUJ3Z3F5MEQ3QS9saU14WTNh?=
 =?utf-8?B?ZDNqY2NaWmxuUmxWcUpPLzlGSSt1c1psSmd1YUl1V2NHYThCYkJoUHhkQnB3?=
 =?utf-8?B?bVh3ZG5DNnd6WUlTaHdYbVR3dWcvWEZlWmZrd1FaRmRhQWlZUlhRN1VMWDhF?=
 =?utf-8?B?bEx5ZnVnZ0xMTThrZHYxSnVsc3lxM0RoMzZtbk5vVFAwaFNRVTJQejJScjZI?=
 =?utf-8?B?QVh6amtod1BkSUZVQUhpSDA3VGJjR1VIZFhpeHNsVW1zbzBjSmhJeFp1T3Bu?=
 =?utf-8?B?QXV4N2ZDNFFVVkEwN1RobzV6R2FBVFlabmJuZXB6NDQxKzFIaEhCcjZDMXht?=
 =?utf-8?B?cWJnOHZkSEphNnRaeTAraTJ6WGVxa0xKelJsMlBaTmFtMlVjY0RjNUYzMm0y?=
 =?utf-8?B?RGg2RDhVL0hBRGNNUTZwQXdXN0JLbTdRMGJFUmhRcFdHc2FQU0VXdkxZcmRi?=
 =?utf-8?B?UUJPRWJsc3hibFdWRnB0aGFIM3UrUTJ3QTJDVU8zOHdjTDdoWThYZ0dFSlNG?=
 =?utf-8?B?VS9UZzFoamRiZy9WSDBxTG56cFlNc0xTb0lYcjJraGhIWm5RWW84dnRiYU5H?=
 =?utf-8?B?N3laNkZUbzVlcTYwY25vVmZLTXNTbnJSUnhlQm81WU9meFgycWpNUXJUREtj?=
 =?utf-8?B?blRLWVpsWUFRSWdaRFFwRGNKSzRJQnlVdHkyM1NjOHNsZkxCYUVzVldCQ0Zz?=
 =?utf-8?B?dytScGJkZFZ2VnZlMDV5anUrZWc0aERrSGpqYmplQ09QRXRlRGlDYUlud2Ir?=
 =?utf-8?B?c3gySXdHSEdDNXltMzdlTTZzbWNaQkxSdklJOHVXd2RaSm12VVNvZlhtSW8v?=
 =?utf-8?B?TVh1OEVVek1jdmlkZFQzYjUrT2hzVzVkUjU0bWh1TDhWWkhJaUl4MW42a1lV?=
 =?utf-8?B?elpTQ2dpYmh0UlNPNktxTWVkekZZd0JFZ1ltZHoxT1NnRjBieXNNT3JXNTFo?=
 =?utf-8?B?eVJvSGZyVHN0WmpVbDJiWmkxb3lYLzQ5ekVSSzZNc0RQcThuZUh0VTFkZjZN?=
 =?utf-8?B?Q1Jqd2VzS2VkZVZsS1gyUkQ5OTlGWDhuaElzK1M3MitPK1YxaEZJVWtRbys4?=
 =?utf-8?B?bm9Bbkp3bUhLWDk0T3V2NE1pblhTQThqd1NoSWNMblUyZy9xbGdobU8wT04y?=
 =?utf-8?B?YjNHMUxZQUFEbTJLNU1RQXkvV2FSL2MrUjdsRUlnK01OQzY2UHdENUU0eEg0?=
 =?utf-8?B?YjdXNllHbVEwY01INER2VGZRQklYeFNGakcyUGE5OVFaRk54MzBGTVNvK1Ux?=
 =?utf-8?B?K3A0ZGJpWXFIUzJENFZCYUVjMDBwQURHQ1AyWHFxUzl2cHVrZ29NWVhYdlpI?=
 =?utf-8?B?Q2JFS1ZzNGpzUmVYWk94cmxrOHpzVnhrdG1vS1ZhUUJTR3hIelIrVmlrYTRF?=
 =?utf-8?B?Y3BHalloSk5BVHVhb0syUVUzVWlsT1lnQ21HdEdmMnowMTBoeFh6TUZhY1JO?=
 =?utf-8?B?ZWtxQlFMbUVGWlBpaENiT3BhcVBxSWZqMk5McktLdm1MRWRPYXBOQk5ES0N4?=
 =?utf-8?B?OVlxSFNxOXQ3d1grcFNkbU9Vdk9YQ01nQ3M5YUNvWTRwcGZxNkgvSUZOMDlB?=
 =?utf-8?B?T2dIVlBuaWh3K3BnVGZ6eCtwZzlvSzNRRjdWdVRKTEs2WjlKcWtaLzg0WHVH?=
 =?utf-8?B?dFkrSlgrSUJXL1lTbVRiVm82eTlvTkhXcFRWaEVteEpFMTRYbDdRNVVhU3Rh?=
 =?utf-8?B?anhFbWxWV3lzbWdTUlFoeFhRWjRZanB2cVp5VVU0Z2xaYjNNYW0xeU9wUEVm?=
 =?utf-8?B?Tlkyb2oxUjdiendHRThKclZIWE16UTVTY0xWaEdnTlFjWkhjNytMMnRteFBK?=
 =?utf-8?Q?Jj8Wyk6UsgJOvGmy5KS8tH8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?bmpkOVhhb3hpdTRsTlQ0cUlsczNPR3RtWkZ4MjhmZGJMWW4yc29BVkdYeWJF?=
 =?utf-8?B?S3VLczErTDlETjB0SXBlZEhndWpJdTNyTUNpUnlna2lkWExpUk9OMTU1TnQ2?=
 =?utf-8?B?ZnhXamdkeTBZbkIvZzVPK0g3ZmZBTlg3UU05VzRXeVJDZyt5SE9udFZpNEx2?=
 =?utf-8?B?TjQ5eko0YU4wZzd1SXcxRHhtUVEyWDZ1dG50WlhxYnI4QVM4ZFp5aDV0OEtG?=
 =?utf-8?B?bUZEbm5YWVQrano0SW1FMnhUSkpnREVlMGxDd2tXWm9iOVBSTUQ2WU5xcUVZ?=
 =?utf-8?B?ZC9jcEQ2eEpBMEcwdjBVb09BTVd4dEpGRlFSdXJObHdvajV1cU1uRmE3Q0NL?=
 =?utf-8?B?SEthcStxclZNcXhZWmdFU3VnY0VmdkEvWGVWQXJqWjZMd25YZDBXbXpOTEE3?=
 =?utf-8?B?OXdWVWN5K0tGTEJwazFrb1U4NXJqaXNDQW5JWXlrQnFHdEN2RDJhS2RGWTFQ?=
 =?utf-8?B?aDlVaGcxTlp4blh5QnJEVUlhQVo4ZURhYmFXTE5ISEwzc2wzZmJBamljVzlq?=
 =?utf-8?B?eFJKUDJwdUpxSE90b202T3FMbWlWQjBzZUxMMXhqQWwxMVUyem9vMjNkOGFY?=
 =?utf-8?B?bHZFQnR4bG1QdFFDVWR4QktLUHVJaXFyVlZQWURsV1pNOWtDYmlHZDF0TU5I?=
 =?utf-8?B?RTBqank5MUpGUUZOUWVXTkQvcWJ2SEJVWXBnT2JrdG11eG4wZk53eHlwQm5N?=
 =?utf-8?B?bmF2U1ZRSU14YWxzak5uQ2dFQ0V3NVM2clpDS0pnV1VSVU93NGhmd2NJMEVw?=
 =?utf-8?B?aWNzenlZYlQ2dkwzNjFKWnNPWWRvdkZwUXVwczY1eUlPR25YUk5zQ1dXK3pC?=
 =?utf-8?B?MWFNRE16SmtmNnJzWHk2VXMxekhKZGt5ZXlKRHFJZWlEcUplWEJvcDY0aXZE?=
 =?utf-8?B?UnpWUUVWQnoxM3pLZEdJdWZDdDlQYTNRSjRaM29xTm00SjdlT3V5eVNQdlZx?=
 =?utf-8?B?eEJJN3BKMHZJNWpsdWZqckFlbFJGSm9LY0NrMzdtc0s2SGp0MnV1SzRyUXV1?=
 =?utf-8?B?N2ppdEhkR3Zac1RMRXhYTlh3d3M2RCtlRFRsWWlpN2JxUloyb1U5b1V4a052?=
 =?utf-8?B?VFJJdWxEUXhkN05XcER3SzV2UjdaUjJXYUVtRG5Ob3dHend5ZUIxVjMyeXNP?=
 =?utf-8?B?REN2ZDVFUHZhSFJQcXZTbFY4M2dROXllNlRDSzFpU2lqMW03L3VLdzQxT29s?=
 =?utf-8?B?WXpsU1hGNTlOZTNrcGFzNGRibXF0ZkdvdmNzVFh0cGtmZlVkVHNNRE4zVUUv?=
 =?utf-8?Q?uSAgksEuQsynyWQ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56041f1a-35d6-499e-3515-08db21651107
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 12:43:36.6499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RlilBNrQCU9ES2gBWsCbNwyOdrk7H1/zGQNYlLCs0ebKH0QO0H8HaFQBlA9MwZ4WbtCuaFb4ZD5C6CkHTxOs7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6393
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-10_03,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303100102
X-Proofpoint-ORIG-GUID: Jjm78cxNxo5rG1hKQ2EVqsgfz5SY6Ujn
X-Proofpoint-GUID: Jjm78cxNxo5rG1hKQ2EVqsgfz5SY6Ujn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 10/03/2023 10:07, Jiri Olsa wrote:
> hi,
> with latest pahole fixes we get rid of some syscall functions (with
> __x64_sys_ prefix) and it seems to fall down to 2 cases:
> 
> - weak syscall functions generated in kernel/sys_ni.c prevent these syscalls
>   to be generated in BTF. The reason is the __COND_SYSCALL macro uses
>   '__unused' for regs argument:
> 
>         #define __COND_SYSCALL(abi, name)                                      \
>                __weak long __##abi##_##name(const struct pt_regs *__unused);   \
>                __weak long __##abi##_##name(const struct pt_regs *__unused)    \
>                {                                                               \
>                        return sys_ni_syscall();                                \
>                }
> 
>   and having weak function with different argument name will rule out the
>   syscall from BTF functions
> 
>   the patch below workarounds this by using the same argument name,
>   but I guess the real fix would be to check the whole type not just
>   the argument name.. or ignore weak function if there's non weak one
> 
>   I guess there will be more cases like this in kernel
> 
>

Thanks for the report Jiri! I'm working on reusing the dwarves_fprintf.c
code to use string comparisons of function prototypes (minus parameter names!)
instead as a more robust comparison.  Hope to have something working soon..
 
> - we also do not get any syscall with no arguments, because they are
>   generated as aliases to __do_<syscall> function:
> 
>         $ nm ./vmlinux | grep _sys_fork
>         ffffffff81174890 t __do_sys_fork
>         ffffffff81174890 T __ia32_sys_fork
>         ffffffff81174880 T __pfx___x64_sys_fork
>         ffffffff81174890 T __x64_sys_fork
> 
>   with:
>         #define __SYS_STUB0(abi, name)                                          \
>                 long __##abi##_##name(const struct pt_regs *regs);              \
>                 ALLOW_ERROR_INJECTION(__##abi##_##name, ERRNO);                 \
>                 long __##abi##_##name(const struct pt_regs *regs)               \
>                         __alias(__do_##name);
> 
>   the problem seems to be that there's no DWARF data for aliased symbol,
>   so pahole won't see any __x64_sys_fork record
>   I'm not sure how to fix this one
> 

Is this one a new issue, or did you just spot it when looking at the other case?

Thanks!

Alan

>   technically we can always connect to __do_sys_fork, but we'd need to
>   have special cases for such syscalls.. would be great to have all with
>   '__x64_sys_' prefix
> 
> 
> thoughts?
> 
> thanks,
> jirka
> 
> 
> ---
> diff --git a/arch/x86/include/asm/syscall_wrapper.h b/arch/x86/include/asm/syscall_wrapper.h
> index fd2669b1cb2d..e02dab630577 100644
> --- a/arch/x86/include/asm/syscall_wrapper.h
> +++ b/arch/x86/include/asm/syscall_wrapper.h
> @@ -80,8 +80,8 @@ extern long __ia32_sys_ni_syscall(const struct pt_regs *regs);
>  	}
>  
>  #define __COND_SYSCALL(abi, name)					\
> -	__weak long __##abi##_##name(const struct pt_regs *__unused);	\
> -	__weak long __##abi##_##name(const struct pt_regs *__unused)	\
> +	__weak long __##abi##_##name(const struct pt_regs *regs);	\
> +	__weak long __##abi##_##name(const struct pt_regs *regs)	\
>  	{								\
>  		return sys_ni_syscall();				\
>  	}
> 
