Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F1A580461
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 21:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbiGYTQW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 25 Jul 2022 15:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiGYTQR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 15:16:17 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7648D105
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 12:16:15 -0700 (PDT)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26PI5Y5P009407;
        Mon, 25 Jul 2022 12:16:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=lvVMnEDUXKIJaFbFtHJQrF3p/WGx+8EVkQ5i3rBg64E=;
 b=qjGdY51tRYr7Dj2Q7Ie4BkbWlNyNRR3GM7F2YXZicqdFFgtw4LJXZuOoAcXcW/pL2jvh
 4tkWLS3in5qEReFoPkUwRjtAU97s/ozhkAQR5pLuowyuetVdSDQH1ogALUuPGb66KrnD
 nYzjgzpxqNnn1qTdbwLnTHMEQ1zdfpY81qU= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hge3qkc7u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Jul 2022 12:16:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnQqNmgbwAVQwLR6enkKxFf/KOhWhTkGT/pboqpY+2F3LVzJmerlvDCka0gQHcg7rsxT7YAROHlTVnKdIRWvo2glz3yw/amUx+W584WUZDgy0aHxWhiBh5yP02fs5KaUPOF5f781Kqw3mXMFi0fG27ioVya05FsEZJxn/O0KeXbpnS9giz+SM77hhLge72Oyo/1QPlz6C5ov8lUaBrGRCf5zOHTi7v+q3/bg3ca4pj1C4kwpNfMYaHg4vQWmHElidPugRB78sdbxnEbD1uHFn5jmjjoJLKV0NRqnFMwjywITN7VJIYGz2L6gHZ3OaiLfTzyHBIwU66de7n4vePXQYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvVMnEDUXKIJaFbFtHJQrF3p/WGx+8EVkQ5i3rBg64E=;
 b=Q3slxL8WLEJ5aPLwNl5+Ca/NQdR/rOLaaeKMVzOrsIZY/IHBiTFhHaiYMkTXNnofTuD8ICYQLTY24y74AT820db7qLlHHiNxzCNQcpeUtnJMGYLkxJl6+nYHFVeSqUiYw0eCKKYDXavROofQZGevOFl8umOhF+ZS6d1bBlQv9VvGgJh181UcjGcXSsu+msiH/1gC0kDhPG656OeUFg2LZFV1l9enqwwEG+QhyupUeR93d5w7+tvlyEb1wyHH+CW54daPFkznx5KLo8ZPpBtZTDYVuOOs/BNPjydps3nS2biMXIvyj0f8utjpGUxX1jSgxIdtVk8jLWMCm/IZHJuj6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by SA1PR15MB4627.namprd15.prod.outlook.com (2603:10b6:806:19e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 19:15:58 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::a88e:613f:76a7:a5a2%7]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 19:15:58 +0000
Date:   Mon, 25 Jul 2022 12:15:56 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, jolsa@kernel.org, haoluo@google.com,
        andrii@kernel.org, daniel@iogearbox.net, ast@kernel.org
Subject: Re: [PATCH bpf-next v2 2/2] selftests/bpf: add extra test for using
 dynptr data slice after release
Message-ID: <20220725191556.lmzpm4f2wcs5azep@kafai-mbp.dhcp.thefacebook.com>
References: <20220722175807.4038317-1-joannelkoong@gmail.com>
 <20220722175807.4038317-2-joannelkoong@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722175807.4038317-2-joannelkoong@gmail.com>
X-ClientProxiedBy: BYAPR06CA0068.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::45) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeb4686e-e6de-4c07-378d-08da6e721ab4
X-MS-TrafficTypeDiagnostic: SA1PR15MB4627:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6YCkPYVdYgyLlOYfjpCltVvU0ZEV6YH3345mG15TX5kQ+ixdd7Z0wDLuxk0FLBEe/gL+8WZNiOKVuEoog4ALi2ejJzaCm96wFHEwbg6tngu5mmhIHhuUA/PwsZmGJfTxCpzxSR/clHIEVw53fYsjvX8BPSHl6EHAqFXpm3nZvrg4SMyRPm1dI1dQA4VYqT8RPF/XD7mDmMebSMCXF4FjeNV6k6P0cFHWElXHAllWfD/oWJELLHdDNbAkyT52Upu813z7s7fpdZz4S1OaTMaqQOS2Ehx52VpCJMUe4GaGDvgw2x1TLXi/jNTxPaEU3SLynYLEWnjmbrp4KQB7Xgjfjswi+zFVWutNJKp7Q1grzXv8vjE/nzQXZcvirrc++U3GGRc8prWkZ83dMMPDzYcQkj6LrKvDRtrEjFAsGPS61axYljkh1rpmi8H+L0ZcCZjKe+QecTcC7zADsevtG+OQQpjoa8NASj94SqzO0v6POLl5z+K76dtM/WCsFOsQRput5WP2ozPiXwhAVasdtFzFJBO6GHzklre8nlQEYfCSQXNru8OTkvTzd40pQGd7N/NQGBQH+4mmJ2BhjONI36SYnhVp2wYjrXjD4eBKIHnkUqcEuOx3vJIHwodPtIgy1GYG2acGL8FduiqFLuHt0OIR8jBRqgv4aPPC9xLvTlZDz1A14MGgg7eKBWXw+Sm/79H5LxxrjgyiFwPRb12Mn719zYy37ZHeiFjkPc0pMaK+40EeqiIdOGKdc0zs8itv/Ugj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(6916009)(186003)(8676002)(66476007)(66556008)(66946007)(316002)(38100700002)(2906002)(86362001)(6506007)(1076003)(478600001)(41300700001)(6486002)(52116002)(4326008)(4744005)(5660300002)(83380400001)(9686003)(8936002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GH7c4aK3Ot8hqnrPcQFxrlAWnhcIsMEnHIEsUNzdtzLhge5IZzvggHi31PLJ?=
 =?us-ascii?Q?oyPmP0m5BIRriB0OnRKLtIeJSB+9+WU39yw7BEaeKhIaWMEsjJo5xqckoo80?=
 =?us-ascii?Q?9FZh2o3CAs/xb7mUWOzo2AJHKiH0jr69o1uuUzZttynpGFJD4CvTTqWrkqgS?=
 =?us-ascii?Q?/XaXMFZ/DM9JPTSL0U35fvc2AEa23e0mcv4iCQHN9YvikIzjkmKpRaE/QQEI?=
 =?us-ascii?Q?qmKngN8BmhBYoig0tVyXTdO34CFpQNbtX1AUx6Tntz3zGGR2e4qtjDT7wx8K?=
 =?us-ascii?Q?DCBhy+WkrpLojK1Lc1uw7GTG2ZPndg4xS17ak2gTGRfKCt/ma8GOHEHkEhQK?=
 =?us-ascii?Q?hDrS3N+9BZ1f1VTK2MzkriJtnRXJ9vScKyPvHPLyXoXMRm293D39v8cvItGT?=
 =?us-ascii?Q?018aDtxbL6U8x7RMLx8h5YWjiWx6RPyoWXX38obMpN9Rn3PebXwflgpw9Guh?=
 =?us-ascii?Q?BuD4McuBry/rbBp5B4YqiKN08Y+iiCK3lLpYK71hX/Xhy0elYB0v+gg4J4yk?=
 =?us-ascii?Q?vMV+xn+28ZJZRXhThJKqX3tdkp0/ygH6ri9wgfC9Xv1bBmGQ55LY9p3qX1BI?=
 =?us-ascii?Q?o6Vd7klJ5zbmKngaTcTLJFwF7KgSPb4QAzEhy5X6OkwTJAxeSsySxnXjHO7L?=
 =?us-ascii?Q?G94y0a77I9R25BNe6CGjZsDUR9DU6+hE4Hn06wiSmkqjwLaspMLxK0SSZ+nJ?=
 =?us-ascii?Q?e+Q2DepbcP1DTk50sfDLpfbmQMfcAmZfOKW3j9/KjhCI+Ifo51JrKMbVGn1H?=
 =?us-ascii?Q?NLzTlqySIMSZcZ5/QNjplsly6sPjdwpW9+ribFT+Suc/EeELPr1WVdPvcP4R?=
 =?us-ascii?Q?aI03wwx5mNlDLMrNRqYcUQD1+5vFMgPlYiVElJKFh8At2H7Ft6hGHVDp9+5K?=
 =?us-ascii?Q?Icg9aO8Ws4Pdx6zEttQd/xh9034xFRdcU7B+JiBdZtBd/OiXGzyPQ9jqIvmO?=
 =?us-ascii?Q?srAqfQ7larwt9CE6fUv0howqNkkP6Aj+8/tEcBPEmCyI+Br+LtN+usgi0sf+?=
 =?us-ascii?Q?MIfoYTpnMRCW0bwwsDt1ymAWymwOmQv/l/PL81OP2rmvvq1luvduzq+Ll2YZ?=
 =?us-ascii?Q?hXLyivWG+efI8YpVNPrzLIxfj1ajl5b13Wb1S9/P0Vb+PaKilxkVm0AhZwE2?=
 =?us-ascii?Q?QClMKBcZ5Zzjbi8xcaIM3U3Ile/BNXRNmnL/Cg+bau7wA7EXHcSJvqffwM9a?=
 =?us-ascii?Q?8qCDz3h/+8t0CsQv/UBGq74Y6X7wHPNUClif/C3Md73wsKhSJOmxqaFPpAgL?=
 =?us-ascii?Q?apCu3vSfQQ4P1yOcowNQWehk+jwGOJJBv7CBfI5eI1kac0lHqyPfqAMP6MtW?=
 =?us-ascii?Q?2wJJl1pwfbWcnsF7wFMTaiceoEtxLrgcp6RCpmAUY/OfqKZx8AaXuRyKpoxD?=
 =?us-ascii?Q?txyD7J9nP2C5/60EX4wpPwkr2kC+mo7eaJErGZn2KU+k7Tcpg8TYNgWoXshH?=
 =?us-ascii?Q?YxSUMsZpARV2Z53SqwNvSbsFjO+1EuW2zp1AY5M4nBGBNOczdHiWPOkUl5rs?=
 =?us-ascii?Q?XKHgOlKgqqGYaODfof5AxRGc4n/nAKd4T5JsfFYRww1ebBy5NUXEkzOt8ji2?=
 =?us-ascii?Q?rZScDS7ilRunHPTvO0kIBiHpzfDoyGVVPNDvPt2P/Aip4aGK4GXUIlZ0e2fT?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeb4686e-e6de-4c07-378d-08da6e721ab4
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 19:15:58.2503
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nS6DAARsG/eDwC7MHMdSy+v9/X/ylu02YtujslLa9IRF5NZCJgalWbCz4cY8PoOc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4627
X-Proofpoint-GUID: tXE9NdbKJYMsFkv1d0dqrkb2aY7GKNzp
X-Proofpoint-ORIG-GUID: tXE9NdbKJYMsFkv1d0dqrkb2aY7GKNzp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-25_12,2022-07-25_03,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 22, 2022 at 10:58:07AM -0700, Joanne Koong wrote:
> Add an additional test, "data_slice_use_after_release2", for ensuring
> that data slices are correctly invalidated by the verifier after the
> dynptr whose ref obj id they track is released. In particular, this
> tests data slice invalidation for dynptrs located at a non-zero offset
> from the frame pointer.
Acked-by: Martin KaFai Lau <kafai@fb.com>
