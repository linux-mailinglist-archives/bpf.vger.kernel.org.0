Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA3355A289
	for <lists+bpf@lfdr.de>; Fri, 24 Jun 2022 22:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiFXUWl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 24 Jun 2022 16:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiFXUWl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 24 Jun 2022 16:22:41 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816DC8289B
        for <bpf@vger.kernel.org>; Fri, 24 Jun 2022 13:22:40 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25OK9e2q030269;
        Fri, 24 Jun 2022 13:22:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=Ti8Cyzv6ygS5ks1rUln2U4wSMC7OhQ6bdC1+HwHx03k=;
 b=QYe2P//HcK6Wq1p9hwotXEj6ZavancPK5h2f6OLSJNJS5LLsSr2b4LcOywVAfnmAt8UC
 +9aypgD1O/uuDuRRcc7FQHPUunK6o+CsnTg0F2CeaoWM9nDcZa9a6DLlPs6SirUEAuZ7
 qL+yPiV4OqVj0yiKlkru7w+ljxB/gW8XzM4= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gwbd8bhh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 13:22:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VqbgZZibcElwQGqqf7Jy+fSU1WlhL2vS1iEN9SBR9A0aZMtnlA4O8q9kNAlAFYa5wrMZLPVdyzthxQerETryWY1qjqBcumIlWjmlvdmVnR/OYDMjEfQhcRSEoHYzj3TQmxUPukJPCH6OG9aqVKWfVyVGvSlbC+E4eZtTW/OazMKqVHJA1Teg3HITtBGCD3YB6PpfW3/+kxzljYK0tkhH2pDLvnksCzK6l5J6fhpvK1jply6gLUKW2SSOparHe+TcNZCRx3tIzfrKqVtuzVVf0hmmU5EXybM+UDDTuLWQDUHV8KFB0Q0/TDwsxrjH2hOat1JLqy+kEG7aQDbeiPGoYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti8Cyzv6ygS5ks1rUln2U4wSMC7OhQ6bdC1+HwHx03k=;
 b=I3IcF0eATVLfiInIb404annVkKuYMrlhzybiNXoku9RwnEHuyM9SJKqzhAe9rTTiEBeXJ9HsZyyjK4AcsRZVBuWADzV5GNQcGXPCNo/ls5p7+dkVcE0c0VqjQvr4V3WV4sFLwJkpYFXdgl6gNjMz6jJmrhK4vI5zp3QoN1qVNs6F53AUdduHOyFhM3I3nocYYKnafhJkq7gyOcqoceVLsMUus3unB0Yo1QXAHCdkd68Ec67YeRN/idmZ5tBowRSPIC3JLHVllBhXWG2AYr0Y9BlxOKcB3iDXTb4JtbSF/FYi7OZrbXwE+uP2KjWT8XER+S5R6zxjmEAxoucnfebinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MW4PR15MB4475.namprd15.prod.outlook.com (2603:10b6:303:104::16)
 by MN2PR15MB2736.namprd15.prod.outlook.com (2603:10b6:208:128::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 20:22:22 +0000
Received: from MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762]) by MW4PR15MB4475.namprd15.prod.outlook.com
 ([fe80::3941:25c6:c1cd:5762%7]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 20:22:22 +0000
Date:   Fri, 24 Jun 2022 13:22:20 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Dave Marchevsky <davemarchevsky@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH v5 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
Message-ID: <20220624202220.bpbwozm7tjcwxcep@kafai-mbp>
References: <20220604222006.3006708-1-davemarchevsky@fb.com>
 <CAJD7tkYkhg2RQWJi72Eu0UOAqLGAPYm21TxQvCVC4R74TK0vqg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYkhg2RQWJi72Eu0UOAqLGAPYm21TxQvCVC4R74TK0vqg@mail.gmail.com>
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To MW4PR15MB4475.namprd15.prod.outlook.com
 (2603:10b6:303:104::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c6e9bb7-66a5-4095-40e9-08da561f3eed
X-MS-TrafficTypeDiagnostic: MN2PR15MB2736:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7A4sIox/iTxYf548RQ6FNUHHRaquXDz2cNoxBtTGtTdD+n7Y26rxt2nspPPlvSKrvxHIXXWhsPWzWtLDSv4t/t+3uzsJpw6uCDjOoBuHEoHp3F4usdyv7Pf07ejJGYbpUf0e5OCMCDG3wvRaekxWSLnE/JRL/suNwAsQBLEdpvmdi98k75nXGu9OaePVD3shmIrgCa755L69esmpBFbxSBOgjGoWRnSxpMgBvcclo7zKg3zZXFkegduKW1YM9qXHrQpMwsJwg+28938ed9OFbXpQv+vPli5hISC8OPdGF9v0lz7QUWOWTkFRgjg/YtJTjCocDhxiqPCeQHnk6Vx86l6s3v1EoVwG2Co4Sih58RTXXLdrAdRdbL0PvbV771qeSp85xvCANRqtoxAF+5HyHxSVowm2AhoonenGklFuyHbZu82lct3aoNeKfb/WvoBDKL5N4nd+kRjN0R0rRdNH8rSRKTWVZCEUsB/29ylhfoeDi3/cUeSOVKLmNz+WBYCDDuyqh2l+4SQik/YvT0UgnBuIR8eeE8ec6HvvJ+BHUN6/tA/Qd2dzND2Wd2qd3P7O1wwWbTx2uRW+V1sR3US12hLF9U4/02KbvoZDDCJdzmvCfL9zNH0qtE+FEiPo/yjRat5nFCru+iBrvObJXiJNNIypwJ+rdYnC2kSAFsYAeOGd0MZFcd/AYZ7aV1BcGWKX1e/WU3+93+u0xH0Hqm3HZf8NMaltJrX93vP2M7nV/W8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4475.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(396003)(366004)(346002)(39860400002)(136003)(376002)(6506007)(83380400001)(38100700002)(41300700001)(53546011)(1076003)(186003)(478600001)(33716001)(52116002)(6486002)(6512007)(66946007)(54906003)(8676002)(86362001)(66556008)(5660300002)(9686003)(316002)(66476007)(2906002)(8936002)(4326008)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eGq0vqOcuKGnjrLXU5Oi84EyZK3RA8O0gIPvtzxttfHGn1jLMaUK2TxFQhw/?=
 =?us-ascii?Q?j0BKEvLzizfPeqpR30+ZTqPQbLwND38RsfOD5Db4lnxye3dvakkeQU4Kir7G?=
 =?us-ascii?Q?WaKUaUO3UjARgqm+AFNMt/x7bFw7vpzPGsv5VkNGrWmcztgcAepXGlmqRCjS?=
 =?us-ascii?Q?oQ8vPzs2ss1b0FMqb1VDKA2LKL009qvj1VbDBaK2wnFUUR20k2XX2XdGgMiz?=
 =?us-ascii?Q?7+C7zJ+wEEpalIXf1ln1q3tx7cSledByrihNSz1t3IMhO07wVZYjIEPgvtlg?=
 =?us-ascii?Q?FSS6SaL9gV0eQLQjyIsWiDw/Ld+nhvdGr0tMCOXeTGnfMnUKQR8V6caPEMBi?=
 =?us-ascii?Q?LXGmrhj35XCaxYcY8kZLDD9V0LqMSlrnUl8tJLjlCswS233FdSI71A2yZMrG?=
 =?us-ascii?Q?HRHdm5XjI8JeFJgnAl7turEGV4TP3VdMDMuWRyT8eLvfzdxKAXw+mtReh6Gi?=
 =?us-ascii?Q?1hF1Wd82MPrfC6Zzy3nQPEwVu/Pguw1N3j9JZ4U7fVd4w+ceNo6e8cI0V1J+?=
 =?us-ascii?Q?qllOcvtwlUNnBGtXLNTormcbTyEFYyVwXp+qOwonjOAWJjDjrQFRFVdr4ESi?=
 =?us-ascii?Q?nO3AnZhD16pAx/uu0+v1NqdKdqLViJXJMRG9XUc8NmPsTT4oiR3t7GgaifGc?=
 =?us-ascii?Q?DNdC0M0sZbztuOZmYh7pEq1DTerCIrTX9Zg9XQXIKnAvQ5qYUE15owTT965y?=
 =?us-ascii?Q?ZjmRPEebruZQgV5FqxeSw/EpdOVcN/HNV9fwDMFVZQXEsFhpo86rJsutcicQ?=
 =?us-ascii?Q?2U7nNtTkRs11qkC8n4MvqfuUZ3vqwvXaTGXKsINPuhFe3OMHmSeP286MzisI?=
 =?us-ascii?Q?Iz/pqtQ5BAuHwuTfwXSX+k1IVv1ziyTYcxKpCZtUwFW0bqUDcQ2C8M1sNGhi?=
 =?us-ascii?Q?79pBs4p3kZdGWtMM7umHYeGXRROyPCsXcS4e67ZX+dAKuD93HuWSrBt+LH9h?=
 =?us-ascii?Q?KgrARmr40F49D+MioL4JHsN3N1/O6cPhUB9BRAD7qp+eDchyAadXR4//9rhr?=
 =?us-ascii?Q?YvsJSPYb5T3cqDoOxtM8BpLAG6Qt/JaYaUeVc84uWeo0ZMchEwyJ8NR7uIqt?=
 =?us-ascii?Q?LqJ6w3LcNu+L3O64+pZNyXXYWF4dzroFS5tA4EzQTw9M3rlv45/XzbEFQkEb?=
 =?us-ascii?Q?kzkxRvrQdwFebqLF42UZDGMbE1jYTUD4E502T6G6cf7qZimXB8fW4srHst6g?=
 =?us-ascii?Q?yWrMPfYoJBPTgjuOW0gqTSmjk1DqcJNAf8Anp+Ghtp9LygaISJNJajfl9kl4?=
 =?us-ascii?Q?kkExCNQNN6zrAdOoAppnEKDL0MRrRU2jRy3tOLWJohEXRbBtsOZ7TWEtox9j?=
 =?us-ascii?Q?zG1fVu+i7hWKJtW+qzWjO/oiMy/VB4Wl/yHprmhQADoLDqmQIbR0XT344/KX?=
 =?us-ascii?Q?zuJVqACME47blYga0z7zXb9GKZrt2S1nBAQUl4Wr9Slqfw2FBR9BFJIQOMCR?=
 =?us-ascii?Q?2u0x6UfANF5BYeFrbLs0eAn1FpTuCnp//suC8BZQIQ2ASieWcotJjiJGUZXy?=
 =?us-ascii?Q?YcXFAaKIiJjcfZkf9g5BobSS0siyE/Jo6F5ZchQDDcnhrc+Fh12LIAf5HoML?=
 =?us-ascii?Q?me+EefCPTWSTnE/Hd09JgHpGUdMqLI0q2vhkxhG3On1wdKAZ9g4/BUV1QfBd?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c6e9bb7-66a5-4095-40e9-08da561f3eed
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4475.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 20:22:22.8088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h6mZrNKmvBYcSV/ciE+BR5UACjQnq2UwrtTNPr7T9G2RikPFb7FWir2uUIPQfu+0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB2736
X-Proofpoint-GUID: zwahuPmp8hmlql4ZEncvvJIOpV-6bB4r
X-Proofpoint-ORIG-GUID: zwahuPmp8hmlql4ZEncvvJIOpV-6bB4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-24_09,2022-06-24_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 22, 2022 at 04:00:04PM -0700, Yosry Ahmed wrote:
> Thanks for adding these benchmarks!
> 
> 
> On Sat, Jun 4, 2022 at 3:20 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> >
> > Add a benchmarks to demonstrate the performance cliff for local_storage
> > get as the number of local_storage maps increases beyond current
> > local_storage implementation's cache size.
> >
> > "sequential get" and "interleaved get" benchmarks are added, both of
> > which do many bpf_task_storage_get calls on sets of task local_storage
> > maps of various counts, while considering a single specific map to be
> > 'important' and counting task_storage_gets to the important map
> > separately in addition to normal 'hits' count of all gets. Goal here is
> > to mimic scenario where a particular program using one map - the
> > important one - is running on a system where many other local_storage
> > maps exist and are accessed often.
> >
> > While "sequential get" benchmark does bpf_task_storage_get for map 0, 1,
> > ..., {9, 99, 999} in order, "interleaved" benchmark interleaves 4
> > bpf_task_storage_gets for the important map for every 10 map gets. This
> > is meant to highlight performance differences when important map is
> > accessed far more frequently than non-important maps.
> >
> > A "hashmap control" benchmark is also included for easy comparison of
> > standard bpf hashmap lookup vs local_storage get. The benchmark is
> > similar to "sequential get", but creates and uses BPF_MAP_TYPE_HASH
> > instead of local storage. Only one inner map is created - a hashmap
> > meant to hold tid -> data mapping for all tasks. Size of the hashmap is
> > hardcoded to my system's PID_MAX_LIMIT (4,194,304). The number of these
> > keys which are actually fetched as part of the benchmark is
> > configurable.
> >
> > Addition of this benchmark is inspired by conversation with Alexei in a
> > previous patchset's thread [0], which highlighted the need for such a
> > benchmark to motivate and validate improvements to local_storage
> > implementation. My approach in that series focused on improving
> > performance for explicitly-marked 'important' maps and was rejected
> > with feedback to make more generally-applicable improvements while
> > avoiding explicitly marking maps as important. Thus the benchmark
> > reports both general and important-map-focused metrics, so effect of
> > future work on both is clear.
> 
> The current implementation falls back to a list traversal of
> bpf_local_storage->list when there is a cache miss. I wonder if this
> is a place with room for optimization? Maybe a hash table or a tree
> would be a more performant alternative?
With a benchmark to ensure it won't regress the common use cases
and guage the potential improvement,  it is probably something Dave
is planning to explore next if I read the last thread correctly.

How many task storages is in your production use cases ?
