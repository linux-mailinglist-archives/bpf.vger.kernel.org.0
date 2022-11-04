Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6213B61A565
	for <lists+bpf@lfdr.de>; Sat,  5 Nov 2022 00:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiKDXLN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 19:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiKDXLL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 19:11:11 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E74A19F;
        Fri,  4 Nov 2022 16:11:10 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4Kj8qv012149;
        Fri, 4 Nov 2022 23:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=fDeIu1kWP/kkA1q2rd8J8+55I/6sQd/ae4o56owbcwI=;
 b=CZUzED7RshT08qR8kyb7FWHkldKj5qrlaQQtYFqGV8nhAgx98cWXkWyK+xsrGwSbEk6g
 CfK+AZsPwMHPkizrilOYHIlCWSHic07GmA07d1Vip+LFLxLWH5EmDNhjhk4u53zM4wA8
 zp5RzZZsrgSQHiz9OkBkLaG/bIFRnI/SID/tosbB6+jXrRubluC1NGfJKntqdtlG10Oh
 l57qM/qhTsW7eHCuDP+9HUmC+cKBagcBIG4jEaGugUv8/cVSc+T6E2TDzquNdN5I4Zke
 Yzi2guy+Hfj40aXyEvNzYyICVBlGiRhTxMyv6q0LiatjWsQQqVTNO7+6Hf0Ds+mxzyK1 vg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kgvqtshke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:07 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4KwcgW032161;
        Fri, 4 Nov 2022 23:11:07 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kmqb6r4v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Nov 2022 23:11:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xe96GMCZ4effysmhtyQf2eU57nPlLGZhvGx3RykqCV+VU/Xf9m1WgbBU8duaNYxuFGWgA+jXOPfckMBmmIYL63DLs678Zg9/aATiwZc2M9qNGqP9EX55K7f4vxpTFUB1cX4AhzBMEX3xKbpb64Ihqg14Mfpr8zdMAh1/XqlY2Go/tBGg8TnyiLlPLLlFBAi/FkZIvgxFM32K/KsRt7RLTzkPB/Z6tv/lBrii8ZUkWuPpzmg/b7isQaDzW2OoTmzhquupcGRUjMBOwWKLr/uMmHyuOjGtqqw1txH1wNOSZEww2cpK9TGdkyAAM53nkfAkSNcngn45hRH/w5Qu2C6FnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fDeIu1kWP/kkA1q2rd8J8+55I/6sQd/ae4o56owbcwI=;
 b=mZyTWc04t/uOg+rl7ruB5Tx9zzJJfwne+Hdu5hDUcl/Pf8kojS6u3JBCtSzNuXY7im4OIAYmw4CAJvf4ll8nHvtAAgiU+bN9Wmz0cuG6xTSu7YIFp6ZlDSBStZneGA3sUsj0v6BnsXu2rvfihLC+WeZiGGN60cNvC60+92fPWNjzjCnMaGf5o+wP9dJHITx7NyC4outvX+9JzOyUHahjhf0E3h7MiSn+8ajq8g5N+TN3Ai0EsEC3PZbnDHxfDT2PuC4v5WKGikpY2q2we8ZOsNbBEcHAjD8vFiUKJHS0/D1zvNsbLUSGdfKIZj6gJ0xOkyUPAXo2rkhpXh6xAxM2Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDeIu1kWP/kkA1q2rd8J8+55I/6sQd/ae4o56owbcwI=;
 b=hN4lF+6s72lObRoNDXzD7dP7EzLaM/advXAX3hGdhRlsAad+BDO+0zU3p3KMx1PhGAB8BcntFrPcmxbdd9Ip11vCoA//jedpVfBMYo4q0N0OsG3qfAhanEv1cUWK2TX3sWLPt3icuQ6DueA62yhWdPadVrTVwb9Y/Vb7+CSBUzQ=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by CH0PR10MB4972.namprd10.prod.outlook.com (2603:10b6:610:c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.23; Fri, 4 Nov
 2022 23:11:04 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::36b6:3767:c15f:3b24%8]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 23:11:04 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     dwarves@vger.kernel.org, bpf@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        alan.maguire@oracle.com, Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 dwarves, kernel, libbpf 0/9] Add support for generating BTF for all variables
Date:   Fri,  4 Nov 2022 16:10:54 -0700
Message-Id: <20221104231103.752040-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR18CA0015.namprd18.prod.outlook.com
 (2603:10b6:806:f3::6) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4166:EE_|CH0PR10MB4972:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c70e9c9-1046-4df7-03e1-08dabeb9d8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mizLbw08ARnlbAXOpC0OEZ5ClQkrXfJzoyc7PRztBr/39cgFnvZu+qLWyxMUcVAmGovG5lkX/uSBzaqzuARtO6OcY+s1S1olfLYqYeYHKYkjPfRt74qLMzA382mJsKJVPIG2gJgDGnCTTjYMZh9c4LgrpSOXqrXfaPNgeBGCbt70WobUiYr6IRhG1J2a/XiDrP6dJZiVW+XydwEqpwkeTXZUzRoSwK3oXalVBiJYFFpbMZhQwSUX8z2zwYnf/PZZtra6zVTq1miewWov/qO5Ypx0JG87pUoa+pVDauUloBGJmSEbXMYssXCyXjfqhxfC01u9Puh1tyNgFPqOuwznh3J+7zYIhjBhhGc50GEnxqHwNJ0H9ZaATZzUUoWOSdLUj9979r96JAzTi1IbzknwP8bDFH1xJokptm5uLu4OXKGVjZAd/WSXL3+nC/bS+SGRsZqqQ5vFwNSVWJAlQUiYfCAkYzKNy/Cv12nm/3D2pS5U1SWSHC8b9/3RjrEBM8i7RmN0Db5fuLFipBz3IrQT2YCivx2YqA5XjMA4s+BrU3X0ae2Xp5HOevhH7GdkP2dKZTvildqOA8XS+Q/3JS2SmL9PqwtSj3KVfNd/dFcSxuZSgShML7GP4HtThPjQTn/rI2JYyjCvbrmyn1ch2dvWTPuI4ulMLuus69/rBFQwbw/FoivFokBfIbWqFqc90p4op7kdpvJbdPPUKkztkwQ2sti+uNtMJZVKCKMAYE0dQZ4DaTEAgm2sfegfWqPlgv6hJzv/hLbQc7W1q4WPwgJLHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199015)(36756003)(86362001)(103116003)(41300700001)(4326008)(6862004)(2906002)(5660300002)(83380400001)(478600001)(8936002)(6200100001)(316002)(966005)(66476007)(66946007)(66556008)(37006003)(8676002)(54906003)(6486002)(38100700002)(26005)(2616005)(186003)(1076003)(6512007)(6506007)(6666004)(7049001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4zdZiRgdFR/ZyBHjuT22W1j+39IRJVPyie1W7IU3Cr7faL9vfXI6ZfgT8ih9?=
 =?us-ascii?Q?bOFgbAcLBZFF7X/9Axj5VEIwfrLksnm7eTQ8ZWKqiwAqws9xTlpyTq4RhDBI?=
 =?us-ascii?Q?9Q4svjE1VaUfriyuWKUsFh/8B7HFtOF7R6kJ9yjzshVtPFTq74ZBAqpiC0Wg?=
 =?us-ascii?Q?jEXr+rMY0RnNfJGdW+y7YCwNvEUyYfQAB7x8OwI6bGKcdGPKRI/DpB5Cms7q?=
 =?us-ascii?Q?rTaKfTlBCyjPzqQtj5yMZ546WhFLGogwJFah1QQ+AdSpEBt5BBK6Z5W5W6Qy?=
 =?us-ascii?Q?JjTBBRr/yEKUzOV/xUtdGVUtHWIrQvTojgWV5hdNKS+bi6jFcaFhDXmOycU8?=
 =?us-ascii?Q?BCEF7u973nQCPrFSbqi2e25cdEu+L9e9569Ud8vKQkJHO20UEIBwjb30Yn9e?=
 =?us-ascii?Q?l9Uryn1xuHzZOhOGdtENxmf+F1O85nURLDF+/LWIhuhuPQwHdEfuHoZtRzHN?=
 =?us-ascii?Q?gSXTRTHETP2+zf6wSWp13QRjvrSCEcr+gi0oAmgEiG8QmqW7IwEeP1Dj/2uo?=
 =?us-ascii?Q?R/5Tq+T9eGjw6LoQ176G5F0hyie58ST+nOTgkKss8+b1VHcjid07WWTDCzEk?=
 =?us-ascii?Q?CdqLpeea2S1lAA7CQnad0BQzyILps3npREM3J5GuG9yyfsaO45Hc6wk6SW5/?=
 =?us-ascii?Q?KWT0ycISG/wyZSm9JgkhUFH2RQFp6NyVlKvktjigu3ehFYdaAVjjrJH492Vz?=
 =?us-ascii?Q?/EW5jboKN6p5+qeUCJHw0OwnPRLyH9n676vqcSuQfIiFNLOTwcQ/L1XO3dTE?=
 =?us-ascii?Q?E4bYN42awdcheEpA5IiO0QgH2XWegNTnHRdNZ5G636K9DbagNh+FjS0lsq4t?=
 =?us-ascii?Q?nPXSTx7lbm79VO401nCeU5gHN//0LXTsOG7fzJ3k0RUO14skinl1PNiMT/3z?=
 =?us-ascii?Q?bEUS4uWpq9hxhvNZetou06K5JXS1G6Z4o08XtnjURARwlkroLFmxHCVD/keJ?=
 =?us-ascii?Q?pEhnz7WhG9VD4QXkq3z7fbHeZHmCCdeIWKHScT7FFfm07qsluRU988r/BNom?=
 =?us-ascii?Q?FoFWw5AXTD87um04q0mrj2/Tb6kHROx6O9ifhcSJ3p3rn3UcrbWdFEP7TaU2?=
 =?us-ascii?Q?mKMq05z+inJAzQfU6GUH8GrxtyOS1kzOh8phv1JnnwZNypj0/6pYt05BFll8?=
 =?us-ascii?Q?Mh1ca09RoKudPQvTdH9XLMN7bYIZbmMCIwgvQt6ReAhhr+kfUH9fykPFswDp?=
 =?us-ascii?Q?LMvFdI/sAPO3ikG9cSdDN47bD1jH8S2TL/Viloa5tTbggh8xzsPWQQlov51j?=
 =?us-ascii?Q?3j9JScrycUAaY1137yzJyB8jYRNRo2mtYG1dgcdT8glCyOqIDr+lDpIOF/9G?=
 =?us-ascii?Q?rpcJAPX8k/QuOdIwhNegRAJtFjMMdFsOrKYrTYFUxDa6uTOh+Z8NRecxpCQv?=
 =?us-ascii?Q?Nri0BEwexduUlIrwO48QoDswv/f96xx0UwGABZ0er/401AAjGaloMVSeWz08?=
 =?us-ascii?Q?HuF/N5iLwlBYwR7VZ6hc+ujXIIuFpRAtY3YiiPVbc3Xqz5ajOrwtbettMJWW?=
 =?us-ascii?Q?kAVXMA66keFTVt+8YSOaT9HTTqXuqcicrTGbE7kx96xRfHV1oAZ/6QuMIN/z?=
 =?us-ascii?Q?/bdN1j23ycCkSwDG4BFdpXIRtaV5QvZNQFVPNhe9bU2zs01RE13fBTIszIq/?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c70e9c9-1046-4df7-03e1-08dabeb9d8dd
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 23:11:04.4812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtsfdSbgGT2gJkj7QcxM2qFLL2ue40TiRnKpLm6IhNSrmP5EwqMXbHHd4CKf8DiPbxRphivFrY681uHs8llig0BoUzQT544eeBPvtcprYrI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4972
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_12,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211040142
X-Proofpoint-GUID: a6cvlyTfWll0MNmHYbOxj4WK43wgxfFZ
X-Proofpoint-ORIG-GUID: a6cvlyTfWll0MNmHYbOxj4WK43wgxfFZ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi all,

It's been a few weeks since the last update to my prior thread [1] on this
topic. My apologies on that: Alan hunted down some BTF deduplicator bugs and he
found the root cause and got it fixed [2]. We went ahead and respun the dwarves
patches on top of the latest version, and Alan also created a kernel patch to
implement the tristate for BTF variables. I tested the full series and did a
size comparison which I'll share below.

[1] https://lore.kernel.org/bpf/20220826184911.168442-1-stephen.s.brennan@oracle.com/
[2] https://lore.kernel.org/bpf/1666622309-22289-1-git-send-email-alan.maguire@oracle.com/

To remind folks what the series is all about, BTF currently contains type
information for functions and percpu variables, but not for global variables.
Debuggers would find BTF quite useful as a source of type information, but they
would need that global variable data, as users tend to look more at data types
than function types. A major advantage of BTF is that it is compact, and
built-in to the kernel. Assuming that you can find the kallsyms symbol table
(which is possible via the vmcoreinfo note since 6.0), then you can locate BTF
data. With the kallsyms table and the type info, you have enough information to
enable reasonably user-friendly debugging. There are proof-of-concept patches
for drgn (a Python-based scriptable debugger) to leverage all this
functionality to debug a core dump without any external debug info.

So, this patch series is a re-roll & rebase of the prior one which was just for
dwarves/pahole. It includes three components:

(1) Alan's libbpf fix, just for reference
(2) The dwarves patches to add support for generating variable BTF
(3) The kernel patch adding the variable generation as a tristate

The only new portion is 3, I believe. But all of this should be a complete
product. I used this complete product to build a small-ish upstream kernel
configuration, and I measured the size of the .BTF sections. Here's the result:

Vars built-in:  0x7d3ad1  8,207,057 bytes
Vars in module: 0x62af5f  6,467,423 bytes
 -> module BTF: 0x1a8e66  1,740,390 bytes   (combined size 8,207,813)
Vars disabled:  0x62e90b  6,482,187 bytes

Sorry, I don't have a combined diffstat for the files since these patches are
both for dwarves and kernel repos. But here's the listing of patches:

dwarves: Stephen Brennan
  [1/9] dutil: return ELF section name when looked up by index
  [2/9] btf_encoder: Rename percpu structures to variables
  [3/9] btf_encoder: cache all ELF section info
  [4/9] btf_encoder: make the variable array dynamic
  [5/9] btf_encoder: record ELF section for collected variables
  [6/9] btf_encoder: collect all variables
  [7/9] btf_encoder: allow encoding all variables

libbpf: Alan Maguire
  [8/9] libbpf: btf dedup identical struct test needs check for nested structs/arrays
  (** note, this is already merged, but included for completeness **)

kernel: Alan Maguire
  [9/9] bpf: add support for CONFIG_DEBUG_INFO_BTF_VARS

Thanks for your consideration!
Stephen
