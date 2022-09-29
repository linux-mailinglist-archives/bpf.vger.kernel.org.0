Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446095EFF55
	for <lists+bpf@lfdr.de>; Thu, 29 Sep 2022 23:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiI2Vfw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Sep 2022 17:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiI2Vfu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Sep 2022 17:35:50 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8276A7A8B
        for <bpf@vger.kernel.org>; Thu, 29 Sep 2022 14:35:49 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28TKTUJ0012026;
        Thu, 29 Sep 2022 21:35:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=h8eW2W5wXUHDOCq2AfjbhH+evFziA4W33cqeDOLqkSg=;
 b=jBhRZHYKwDDn+uEUVXAFDXmTSge+4wbiT7qxI1r4EA+j+m/0JnzMOJCb5ugVPcTpUyK8
 Thkxem/el25ZroYtEom1ulHqS70lGyI9Um8Y/gYKFZF+OJfpzONDoZA6ncw/NR1X9dIY
 DVw9a5xyJAlJQ97hi58qL3CytHVOSD2pIZZIHFTQgVgrEtXkITlztp5dlfbkhymvmDU3
 k/d0ywjoEJ6HzDAxitOKvliPpNrxB407VSZ1FJE9ywtKiFkA9keaIERkgyd1d+Opl3Zx
 Ww3tmXAAMNto+099tMva17RYrb6vL06ZDGNi9wLqu5bSTLFkYxjQ249qbXSZKmkfWsAa FA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jssubp88s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 21:35:47 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28TJXv6W033639;
        Thu, 29 Sep 2022 21:35:46 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jtpv38c5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Sep 2022 21:35:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AwVm/DdobtP60dsx4EjERJWwZ4WyFnntnmtbywwLJs9MinD1wc5dRHbUmdM3TcZmvmDxKl1E07YJJJV9cHD9ZD0IPI2xzS2n6laT3GhRz2o/zuqyLTPhVB1g5KAfzDSqEeGUgLCkZZ4ckh9VmP6BC8fjx3r0eOzaz2cFuBlcXQRmUnJEdyNysZkzXCE7BVB207CxrXRdtYAjdFYArAVzuupT8dOjNJOj9pZmDfv/jeXnJ9ktGGlMwhEvIkWXH0q+mJoHItot5DAvvtCoK5MYcb106BkPVnQYKcS3Rpy0MX46B78tl9fNkduw0TYpxgelr/9f1NR9zx+zS1KaKFSFbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h8eW2W5wXUHDOCq2AfjbhH+evFziA4W33cqeDOLqkSg=;
 b=kxspcqiG23Pu9RQEnran/qahF5xdU3rskX+U57FPOevTIKDoKazLOiDn9bI4bOSIh/NcDj8df1Qs6k2OHnH/Jt1oJDVB5ZD5tcu8Orp5otcUinmincszpsYVrQT67xk1OK5b2TMN04xgrjb2DlXJ5qqm3/a1hqfXLTzu9zp/AoOHU076ZJn4DIOSrWUDOF/fyL2boCG5cE2OEVXDsuWwS6Le3gJrq+e8rRFuRO6u6GQENy8vOml/fLA+FARhQpD9l8OmNJA6tvNp7WdYMNjAaYnXeBeNSH+btkQNp1mZ7chpPUL16svVLIs/8k3907i5axwS9cSBar41S6iQEoQfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h8eW2W5wXUHDOCq2AfjbhH+evFziA4W33cqeDOLqkSg=;
 b=qe0pq2X4bSOU1LkNX1aymy4ux0jJtWdZyg2oVtND3y9zH3AU1cMCgM287BRIg1SYIoKQ1gr9jYGjnp/04rLT36EYS57WWeEvzyUQbvB7kg087/JLtLI32WYwm4wwIWB4nG0s7eYDGN5I3ckuwhVsvLDdEX4/Qk6YsfR1pBejSV0=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by BN0PR10MB5157.namprd10.prod.outlook.com (2603:10b6:408:121::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 21:35:44 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::90bb:12d:954a:c129]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::90bb:12d:954a:c129%9]) with mapi id 15.20.5676.018; Thu, 29 Sep 2022
 21:35:44 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Johnny young <johnny96.young@gmail.com>, bpf@vger.kernel.org
Subject: Re: Is BTF info sufficient enough for BPFTrace and other debug
 tools to run ?
In-Reply-To: <CACbfJv8tn5dZmz=6+SMC4HZV05s-vnV2Nq19pC0D=eTLUu91Pg@mail.gmail.com>
References: <CACbfJv8tn5dZmz=6+SMC4HZV05s-vnV2Nq19pC0D=eTLUu91Pg@mail.gmail.com>
Date:   Thu, 29 Sep 2022 14:35:42 -0700
Message-ID: <877d1loocx.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0196.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::21) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|BN0PR10MB5157:EE_
X-MS-Office365-Filtering-Correlation-Id: a11a550a-9998-43e1-66b7-08daa2629059
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8tXJwQDMGfzk0UEOgkYyKC6O0zqO5/lKh4xef4KDPZaPMbSChaF7tPwaunF7s6hfyQzpPaE7SO2UEyeEK/4CGN9Qe5NUW+7kSIamsO/n/IJiSSshhjlNURRGNzJoEEmI39/K3bXHjSYNAArNA18eRfd7nVak9VubLDjzVOKlCyu+OJDghGJ09d2M4HaxcrCP0q3OC3ynXstBlSNnVg+m0IumktRfoRSnlORy7GUjHkCZXxT7F7BkdTmVgZ2mlYUPhe8hPLnn6fhLMJB3fz+Srbxft567B+W2fD4RX5IJZpCGUt4a/AtLPUdaUmCUHNTZD0iFwcuR2P6RV9oV1hTFbpGOjIJKZ2bJCnOpXvtl3OhooGgQBeXmne/zXUQMCjVzaMLhhpSFpTWaU0koU5PVag2G9cRnS2c5wDrpdfmOvhN6OtZPaRiRY8S6MpjJhiAnJ82/sBd5L3NUfUfO0n9B9R4u/1f+lMjy2B/PkycQwANxNr4RDB0wjI/fdf70VF0IE2Hg4czljqBYnRwO8hP710EqEPmnHsCdP3FmwLrnNAxyXc9uoGrHHnDDDcuh0Irgw5ANZ/Nyvzl/osD9ZFrjSoYyegXVAMNu9cy1bApLMfpx8GqMErxRXmO/zFqq/bhj3svWJEFan2jvMHktj/pAkXadQPpDzTlttpaEn/2P1nIPV/ntQa2bTHF6IXEzn+GjOebK3oiHKPimE10HJPmrOt3JN3GsbjaWPIEoqQHUa9VRggViTm4xBSNzJcoKrsBIoffzSpdWkzSdoMgz2k+zA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199015)(966005)(26005)(41300700001)(83380400001)(6512007)(8676002)(478600001)(316002)(5660300002)(86362001)(66476007)(66556008)(8936002)(66946007)(6486002)(6506007)(2616005)(38100700002)(2906002)(36756003)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hNXEv2L2b1PcJZiLDqG3ohgs+50D0Gd2fXs9KrMUGmC8kuSNeE/zXCDk89V4?=
 =?us-ascii?Q?ptTRoLvT9+E96Gzm18XSVmuSkYa1fT5GnRRbG5IRynp2KppWwjnPIIY4yduB?=
 =?us-ascii?Q?jZdYD4UzUjn425nQZ9d5niLEBB+/vD/6QlwI+1wteBz3qhQodcDTJZWovfrm?=
 =?us-ascii?Q?LaK7ZfB3UyhHYYctyE1OX60Tg5p512Rx1L5SZf7z0QY5l7h1Vdqhd/6z9C8e?=
 =?us-ascii?Q?vPxNpUhOwczmO3HUKWk5RFzV7NN2CYkT1+16lPX79dmpDAWZbAo3mFqjzgnU?=
 =?us-ascii?Q?4DaFMRLqYP3RcHqlZ/dDzBcF9yvSbUa8P+yVt3PhCzDf7GlewDs4o/rKC9WO?=
 =?us-ascii?Q?oSFQnrLakZV3jqeHaAx07xioU9zXK2+USWkUGaYD2eAwK3TzVJae5uH1RoI4?=
 =?us-ascii?Q?Io9qiyI5TCJsqH68ruEbA8+klytGuGnCwisDY7xNG/8NzYTJ91NL7FHN5yK+?=
 =?us-ascii?Q?KjhrJRHM07RziCIJuMTvv+KSZJwoKUPpdyKC25eDlH9Y8wyGrOvog7QzAtPk?=
 =?us-ascii?Q?1ukJdXMYzq0iLhvv7K/NCsNYYEEXIg6xsfISC+mpmVzcRKuOPRL6VMAOp3Wt?=
 =?us-ascii?Q?cukxnbYO1CmHBq0l0DSSLwQp63kn7n8EAI5r0L21W6QZzZ3D98OF2nfqZp2y?=
 =?us-ascii?Q?iVlIw5jILgPA0UpWLmLhL5lsoCR8PQm/qBPH6aEhrG0HU4D2nTzAQuOA0iAw?=
 =?us-ascii?Q?XkfVwAP7EdQTuEa7MeaOpgr47QcvAirOcWvLiaGWQD1Aqw8QPWJZJqtBnUeS?=
 =?us-ascii?Q?We+QF+9obFFhG1kquhYnqCQlZct4sZmvwKwdZSU9DxmqjHAnQSMS4arIg9mC?=
 =?us-ascii?Q?0w8TifaHHkN3OtxMNs0NmLhNkRtHPURStDoejI6u1CzSmNDaA+tCIBD763hN?=
 =?us-ascii?Q?76vLY+QsiogAvF7FHUAJhUoU5D47ucNDFPyYvGsryK8l3tZT5eyXMZeK/tNH?=
 =?us-ascii?Q?aS8MNrb5q1Mvn91yiYb0OuwTCwPZZ+R72IaJjT6C/9GsdoyHTK/zKUmjQzne?=
 =?us-ascii?Q?8sZHrS6V6eUhmRXH7J+aXwjOrJLtiHzWjKKJmJOT0jrvLCyAzYVgrxS8jrK1?=
 =?us-ascii?Q?vvnooCsXcsBTI4wGJa++ToWFhtj+Qz84XS8LQPburY44EO8DYlM+T8/9PiH1?=
 =?us-ascii?Q?qhqgmrsQJlFkVd708hDwPQe3h7ha8X7mGqteWm2grn+AyMj89lboBfjzWkZl?=
 =?us-ascii?Q?XmeuPtP+a4AripgSrdeckldkMDUm7bTn8SqGek42PJhydgYRK/o8Bvn9nWFB?=
 =?us-ascii?Q?rz0Qubuj6tzGYOE1a6HM3iMiOCPDycPUfvA+U+MMqQPtHevjUXNSIprN4jKd?=
 =?us-ascii?Q?e0r6/wDjIjubl5QAA7NFiNdc9kteil9RcMKpIjB5ruhPUSjdXjUvAjYWuke1?=
 =?us-ascii?Q?hh6u0OHv9AWnAdIDtgROJ10nZnbuAe0G84SJPaj8pgO12OXOyiF/NiQOWN8+?=
 =?us-ascii?Q?rzAtnKG22mas0y6mI8PiJVlv1f76jIY6jLxKx3g3xmhVTjLRr51jl9ozmT1i?=
 =?us-ascii?Q?vJb+FIkrMvrL2/M8cKHNxWOL1lL97SoWbTpxd8+tfOaJphDlt0tO4rPLMHpR?=
 =?us-ascii?Q?Oi2RicoL9mkJ9Rmqse+cAK/gNRBvX5aI1mlnFu2SPr0TWjODmWWusn4Lkmst?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a11a550a-9998-43e1-66b7-08daa2629059
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 21:35:44.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 86IkKr8Q3gJH6UY5ZalIUwm9Xm64RuE1j0ru/OgHgrBKt7gmohTd8XgCvEdlOp+tmD7+FxLypG65ZYz2E30jCzKXIGwh4zOJCp3DO5UqwGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5157
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-29_13,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209290135
X-Proofpoint-GUID: c59n7hY2-wIClfw3iiP9w2-dwJ5tm5ET
X-Proofpoint-ORIG-GUID: c59n7hY2-wIClfw3iiP9w2-dwJ5tm5ET
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Johnny young <johnny96.young@gmail.com> writes:
> Hello BPF
>
> I understand that CONFIG_DEBUG_INFO_BTF=y will generate .BTF and
> .BTF_xx  sections in the kernel image which are much smaller than
> those DWARF sections.  But I also try to understand how BTF can impact
> bpftrace and the existing debug tools:
>
> 1) If the kernel is built with CONFIG_DEBUG_INFO_BTF=y, can
> bpftrace relies on BTF only without kernel_devel ?
>
> 2) Can the existing kernel debugging tools like crash(1) or
> kgdb(1) take advantage of BTF ?

Hi Johnny,

I can't answer all your questions but I can chime in regarding
debuggers. BTF could provide information to both of these debuggers, but
currently neither of them know how to use it. There's a few reasons and
challenges.

1. Kernel and module BTF today only includes the type information
   necessary to describe all functions, and percpu variables. Most
   debuggers would also like to know the types of global variables. I've
   got a patch series [1] which allows pahole (which generates the
   kernel & module BTF) to output information for global variable
   declarations as well.

2. Assuming you had the BTF, you'd also need a symbol table.  The kernel
   has kallsyms, which is an internal symbol table, and most debuggers
   today don't know how to read that - instead, they rely on the symbol
   table from the ELF debuginfo file. I frequently work with a debugger
   library called drgn [2], and I've got a branch out for review [3]
   which enables drgn to read the kallsyms. In order to do that,
   debuggers need to be able to *find* the kallsyms table, so I added
   information to the vmcoreinfo note in the commits 5fd8fea935a1
   ("vmcoreinfo: include kallsyms symbols") and f09bddbd8661
   ("vmcoreinfo: add kallsyms_num_syms symbol").

3. Assuming you have symbol table access and the BTF is complete enough
   for you to use it for real debugging, then your debugger still needs
   to have logic to *find* the BTF and parse it (probably with libbpf).
   I've got a branch for drgn [4] which implements BTF parsing on top of
   the kallsyms parsing logic. With those things together, you get a
   debugger which relies on nothing except data it finds inside the
   kernel, and it works well enough.

So the short answer is - no, currently there is no debugger (that I know
of) which can leverage BTF. But it's in the works for drgn, and once we
get there with drgn, I'd hope to see that developers for other debuggers
might see the power of it and consider implementing it.

[1]: https://lore.kernel.org/bpf/20220826184911.168442-1-stephen.s.brennan@oracle.com/
[2]: https://drgn.readthedocs.io/
[3]: https://github.com/osandov/drgn/pull/177
[4]: https://github.com/brenns10/drgn/tree/kallsyms_plus_btf

>
> 3) If the kernel is built with CONFIG_DEBUG_INFO_BTF=y, are the
> symbolic info and types info in the debug-info section replaced with
> BTF formatted info?

No, BTF is generated _in addition to_ the existing type information. BTF
doesn't store "symbolic info" i.e. symbol table data, so it couldn't
replace that data. It only stores type information, so hypothetically it
could be used instead of DWARF .debug_types data, but in practice that
doesn't happen.

Stephen

>
> 4) Given the current upstream development effort for BTF, can we run
> bpftrace without LLVM now ? and can we run bpftrace without the help
> of kernel header files (kernel-devel) ?
>
> 5) Has bpf CO-RE become reality now?
>
> Thank you!
> Johnny
