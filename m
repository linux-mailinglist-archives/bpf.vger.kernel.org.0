Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73EC4EE3E2
	for <lists+bpf@lfdr.de>; Fri,  1 Apr 2022 00:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242352AbiCaWQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 18:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234081AbiCaWQG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 18:16:06 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCE13114FDF
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 15:14:17 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VJ37Ld029832;
        Thu, 31 Mar 2022 22:13:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=UmiUPlae2UV9Y9UrD+tUmu4xdUD55wo9fF7vWqgmU0c=;
 b=Idb4dBwqyZQ6uszGO/PfxC5V6qdytjA6TD7b9+rWXivB4CATEHJQKiFgLnllys9DfTgv
 QpSnNcKaP75hqH+UweNrFgVB4mCMvLC2QqcL0KK2MabJWgXZbsP+t10926W0XOw1CsTz
 eMuXixhE1mREycwhys5HEkF+0WCETkPp2TugdWrMZRJoYsTx3SUltabkcsIE2xXyNOKl
 pCCq5xRlxfmvBi24gn7TZv+Il4MYB21cVHkW4SEzWRLQbl68+USMMhLXzYHaPRVo2mZG
 Zzh8HzAiyKnLSMC0uPyWasGbxXxu+aqeMofWQEwrP/cWoNid/9m5ze/Y7jXurKE6SOlp AA== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1tqbdchx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 22:13:57 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VMBL1G010578;
        Thu, 31 Mar 2022 22:13:56 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2106.outbound.protection.outlook.com [104.47.55.106])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f1s95drj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 22:13:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJGN3HrBGh2BjhLVRAIc/Ri7HwfU10q8R56GEMhrFTlcHAJiefm1foN9Tu4w3KgeCl4dQt8RJG9IY7IvtxStuYBMl+9YNJGnIV/63dxv196gSBdG41mOAmDIyDl6+M0q5kR1sL6yLqaTgvzOJ5qco1ckp6l1D0THXxVOll9bDszb6Cd26bft71Aeq9A7fn8jacemfzd9Zew0kt+IYNVDheaRgXr5JY28XI34tywUWFok2tpFTaaQ6axLg0HQpC/hCmrelrDVyNqRuG2C8LRF63r68kjLX2+3aE1YX31A9d6cvICUxgpkgsplE6+CZULWumKSwQ7+cMHiQJIV0IoQ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UmiUPlae2UV9Y9UrD+tUmu4xdUD55wo9fF7vWqgmU0c=;
 b=iozB/WwbTlptAfSlwMNZH3paYjRtpd6gECKnD1vOjJGomj5ey4yQ40hrjO8bG0PXS2apc8+2G1n1LwgqOv0JTAHJszNj69vu5RIrTWx+8uK+MAl8J9yep2WE/jN28v3ubKDfC4vmeYEn0z6ECmK8C2hSwqU7FkKI+V2fpFL2Gw6klAi6dao7FYkOs4U4ZqORdvmdf5Xw0jWKoBKCUEXn/9TfsNWB39/2rdd5IE8aXeitXJKLvUlqGNCNyGwv/Z+/9ZU7O5y3I/ykGzdOXjdjrfHcgEVI8K+0ukkUuaMGh5q6ZPefjatlFjmO5tPkHgcjOcHlfm1oCkzMi385PuTa7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UmiUPlae2UV9Y9UrD+tUmu4xdUD55wo9fF7vWqgmU0c=;
 b=TpH0wrQF4SPBezqPZYng+r7W1t4UzFtQ1Y3D8NLt4Gv87xyKJ63CAzzY/I81acP3uaFvPXbxZ0KmuN/6R3e5UmBa7mdaYo8l/+15REjf3cHs5eGZjPHLLhRioWruZEp36UUbqTuiHn8AOHDbfLQEKSSiYiuhSc6xVtTGVpzxXQQ=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SN6PR10MB2432.namprd10.prod.outlook.com (2603:10b6:805:46::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Thu, 31 Mar
 2022 22:13:54 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386%4]) with mapi id 15.20.5123.020; Thu, 31 Mar 2022
 22:13:54 +0000
Date:   Thu, 31 Mar 2022 23:13:34 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH bpf-next 7/7] selftests/bpf: add urandom_read shared lib
 and USDTs
In-Reply-To: <20220325052941.3526715-8-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2203312310230.18524@MyRouter>
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-8-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO2P123CA0050.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e424a8c8-c185-405a-90b2-08da1363be7c
X-MS-TrafficTypeDiagnostic: SN6PR10MB2432:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB24329FCB4B9A882675BBE314EFE19@SN6PR10MB2432.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lMY295u2GH4ELBJIZ9Zg5+4/YAVko0pOO9M6mV7BYMztIyCXa+O/KddavfwLTW5YY2hneCnBzzb+/svvBdJBxMg5B/sNdIa9jptZjKaNww8GbnMVurv4nWUdivxq+NOgJHjgJpUtFgNxQ2tfKeKHKTJlrz7NBvuy44eBdkta2AiCHnl6Hzko5hcUIg4v0MrRbB3z7ACv7iDNATvMQw4MOaU5YV/yL5Z8xyv39GpueXOXNh4VnJXe1dvMR3HaAOfdOTH5b8RAXIBwBzQ9BT/QD01yQaEGcPNbfQs6uZc4uwHwtziKdz6ddwrP+APosyE04VexClpuj7ndY5kaWbl/FhuebJYS5xVtTsw/3pR/dbf+uy3MAkLWeXlG/L4gI8C7BDj4CvCCOKkAD20a6bIOn7yy7jM34SCsA45wUVBnUcHIekeU+ZRld9MUH2vvhZGSrWY3INRqPf3m0kgj8J7CRQsEkp8/I5X8giwl+7hUXVnaJLJLOsUuIRRV+LkeED337RzJGjVpAQY6zbEfsbtIZE0dfrGjCToaVSZu+bzbLzE5Z6iT/vTBhREcYYDbe56XKCawIGQwlwlrSh/8lTkKRamFNsLWr3l7BJPo3RFfY2oZQc7/5Jltew9DyPcChjRjzEpwUXqeWoLlX4mj1RHc0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(2906002)(8936002)(38100700002)(5660300002)(44832011)(66556008)(66476007)(66946007)(4326008)(8676002)(86362001)(33716001)(54906003)(83380400001)(6486002)(316002)(9686003)(6506007)(6512007)(6666004)(52116002)(186003)(6916009)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u2lcabO5fDerd0OukB2+Td0HekHPaGZLGiTWrlzYlFIpa5QuvXT8ssPsVlV/?=
 =?us-ascii?Q?We+tPtP3t4RbdBMaOGUVoGKDBwuoy4ZceNpRQ7AKnvtP6f8R/vOakDYlpp3Y?=
 =?us-ascii?Q?kBDsY1Et8h6mLW3b9Pi0/ApY8DYuiVK/fVds+osXclRK7bVEu8N6pRDL9bb2?=
 =?us-ascii?Q?aldWUBGctqOsT4lxjGGXF4Q55y0VNrjrjlqavWTUc67O0azLfDbgpas+d1Hk?=
 =?us-ascii?Q?FPp2DUd3hT6Akt556jJg4O0Y4ohKZ9+cbT6bYVZr2XjqzxaV6lBA95y2Bf1/?=
 =?us-ascii?Q?K1DuVcVu2rezFk/+swYcumBuqOqFfM/wmVq9XO6dOaR1eSQ+9OzFvkDRTmQj?=
 =?us-ascii?Q?CSBEFgtIbCVS2nTmlLLMmJzMF+d6JG9rCmlrr1FqsvuK2Bq1oJT9TlohYJ/G?=
 =?us-ascii?Q?aCRzyJut1IBiDMiygUtCDS4cbeqXbYQUzsLbAVsZTg89O6XmjH/qZVSDySEd?=
 =?us-ascii?Q?hXtQjHBkIL6QlnLWJ3k0uRI6u5AruBWt2Cmvt8aBWoydecYJ0s+bl4D88F+C?=
 =?us-ascii?Q?v4jxrDGdqopqB6y4PGeMVUUbAACdWo2U/7B9XGX+HJA/wd23BTRxOC34iY5E?=
 =?us-ascii?Q?IcQT6E83RxsQQZcRtLYzXM4m2m3FnfOBtnqx5NRWFNMVbxPXYsWF96w2s/pJ?=
 =?us-ascii?Q?Xv5JGgUA/64Tl/0FNMrIurW4o7hnjQVyigbgXVBadM1rD4J2w2J2f645Q7zj?=
 =?us-ascii?Q?1i/VmkfukQdbV4fjydn4OgI4rcBQdqqZf8d44be0J47GfbHeSL2RNp57pXMG?=
 =?us-ascii?Q?DWvQEbF4Gy6flWiOhyTlMtMfE/MCAyvAUCz2wCnMysYrKK1WlrB6/BfTed+A?=
 =?us-ascii?Q?fE+H/h1/SBWx/CeoHfax3dn0acNNuN8N6sqYgxxFTpcbaRr0J+2KO2mG49jl?=
 =?us-ascii?Q?hEF/ma1Bl7ScZHsN+I88b0T300LuvVADPloi+EHPXmP4lQdVvYHdZKfiOga7?=
 =?us-ascii?Q?VibNL/r7qO7C6Iyp3u/K25TnSLda5JNK/dQv5QgUrPtN+5LZ3NeiP5dOkZwt?=
 =?us-ascii?Q?XwtzaPL1rViZoyfDm1G4tyL+uW1VlyMvlgjGrpssC61f+NpAAF+ocjMmaTcV?=
 =?us-ascii?Q?/OssiuYZ0l0JhLlUPwkeiZHt4HKROiG6tr7B63ov/OehmtPxua4KhnEIamf4?=
 =?us-ascii?Q?ci6Tk1Xoaa8vG/jgNnRII8VphMEyfmCE7o8FUZZVOnAmBh6R4B6/CK5eDO/y?=
 =?us-ascii?Q?ECBil/jO2xaF9jwu/NaYJlEeyAZKpUBkMQftu39wo+q45Q/BCVcCBoVxVin2?=
 =?us-ascii?Q?lmzBD/umgFq7vF4Kayn/7eKzdplDlv3TPuslhsxN/jsDS9Zh+/O3pCoy4pmm?=
 =?us-ascii?Q?3zkKOnlaEJEy4BVDXNV52cO36RAzdfjHtTsJfi0ImrpeUSBUK8m7lm+xFwr1?=
 =?us-ascii?Q?FXUIl/GEo2MM8KkU8C1O7JQ2SIBhzeJzHqaPAgyjjFsGD0u4tZclp7qo6Qe/?=
 =?us-ascii?Q?2UY9mpRNNJO7EQTE9Kgz13TYeFfOUV2Fo3cLyxTjFzmrZzrBqAro88c1URya?=
 =?us-ascii?Q?mH9LWQvF9awdDc98WuNrv3z+I+6UUkuTPViKBPu4DWnf71NU5/vg+uLTrosl?=
 =?us-ascii?Q?6a67UnNokOwhxsHpR/HTWGGvvQNRc6ntPXJMxHi8lq1MuKUnb7TFHVW2HIET?=
 =?us-ascii?Q?8KpYZFfwFXXw9VdXIwB+TnEYbJDfTw/Ex3bDgZf9ZgSlTErHuAg/DHy3Gnbm?=
 =?us-ascii?Q?WmYZ4aFI0neMMbyNZuNNdTCUoLQHevDjIJNj+WniNX+YgVfUvau14bi3APCz?=
 =?us-ascii?Q?1lHtF/FcOCweX+XQyeyF3ldJOUeMinRYre6caXNirI8ZhOgPBZVO?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e424a8c8-c185-405a-90b2-08da1363be7c
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 22:13:54.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J+HL3KsYxQNDfNManmamxw9qtGbQGEoIck/ZP/DMMokbFzpp4aP3tCZKD6mjic98xW+wOUfH46So0g4X61fRkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2432
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_06:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310115
X-Proofpoint-GUID: 1OGcBAXI5TYKc3ptkYZVNmoOxO8-189P
X-Proofpoint-ORIG-GUID: 1OGcBAXI5TYKc3ptkYZVNmoOxO8-189P
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Mar 2022, Andrii Nakryiko wrote:

> Extend urandom_read helper binary to include USDTs of 4 combinations:
> semaphore/semaphoreless (refcounted and non-refcounted) and based in
> executable or shared library. We also extend urandom_read with ability
> to report it's own PID to parent process and wait for parent process to
> ready itself up for tracing urandom_read. We utilize popen() and
> underlying pipe properties for proper signaling.
> 
> Once urandom_read is ready, we add few tests to validate that libbpf's
> USDT attachment handles all the above combinations of semaphore (or lack
> of it) and static or shared library USDTs. Also, we validate that libbpf
> handles shared libraries both with PID filter and without one (i.e., -1
> for PID argument).
> 
> Having the shared library case tested with and without PID is important
> because internal logic differs on kernels that don't support BPF
> cookies. On such older kernels, attaching to USDTs in shared libraries
> without specifying concrete PID doesn't work in principle, because it's
> impossible to determine shared library's load address to derive absolute
> IPs for uprobe attachments. Without absolute IPs, it's impossible to
> perform correct look up of USDT spec based on uprobe's absolute IP (the
> only kind available from BPF at runtime). This is not the problem on
> newer kernels with BPF cookie as we don't need IP-to-ID lookup because
> BPF cookie value *is* spec ID.
> 
> So having those two situations as separate subtests is good because
> libbpf CI is able to test latest selftests against old kernels (e.g.,
> 4.9 and 5.5), so we'll be able to disable PID-less shared lib attachment
> for old kernels, but will still leave PID-specific one enabled to validate
> this legacy logic is working correctly.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>


haven't looked at this in depth yet, but hit a compilation error on 
aarch64:

  LIB      liburandom_read.so
/usr/bin/ld: /tmp/ccNy8cuv.o: relocation R_AARCH64_ADR_PREL_PG_HI21 
against symbol `urandlib_read_with_sema_semaphore' which may bind 
externally can not be used when making a shared object; recompile with 
-fPIC
/tmp/ccNy8cuv.o: In function `urandlib_read_with_sema':
/home/opc/src/bpf-next/tools/testing/selftests/bpf/urandom_read_lib1.c:12:(.text+0x10): 
dangerous relocation: unsupported relocation
collect2: error: ld returned 1 exit status
make: *** [Makefile:173: 
/home/opc/src/bpf-next/tools/testing/selftests/bpf/liburandom_read.so] 
Error 1

following did fix it:

diff --git a/tools/testing/selftests/bpf/Makefile 
b/tools/testing/selftests/bpf/Makefile
index 58da22c019a8..c89e2948276b 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -170,7 +170,7 @@ $(OUTPUT)/%:%.c
 
 $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c
        $(call msg,LIB,,$@)
-       $(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
+       $(Q)$(CC) $(CFLAGS) -fPIC $(LDFLAGS) $^ $(LDLIBS) --shared -o $@
 
 $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c 
$(OUTPUT)/liburandom_read.so
        $(call msg,BINARY,,$@)

