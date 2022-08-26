Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F925A2F5B
	for <lists+bpf@lfdr.de>; Fri, 26 Aug 2022 20:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242340AbiHZSxz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 26 Aug 2022 14:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345302AbiHZSxY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 26 Aug 2022 14:53:24 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C310CF23F3;
        Fri, 26 Aug 2022 11:49:21 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27QIDowt010633;
        Fri, 26 Aug 2022 18:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2022-7-12;
 bh=XJxiWGosAAPagbEvF0IGjynWcJoMm/V9XjQ9Uq2kSR8=;
 b=UdAh+pzxgmbfOu8u+07PSsdG10eKcL/jBt6X9qqbo33naF/53jjE5w5QVEsLlvQFgGRX
 MrbgMOg0sTJrO2WkeBdA83YvnZTq85mgZNrmg9Z9QapGazxDkQCtIdYDzU980iN3Pd1a
 gpdj3KBnJ1i7zhyuaLDquSmMDjLnjzWtQDgjZc2oVPB59foEzn8xPP8hSgJ37F66AFXo
 dXqpU9oqjO+WOZDKjkem29oSP+a1XALQ2+AVy7VBM1x2KaUqvEEijCDvFA/LsTJ3+7LE
 A5cOkA0hZ52qstPGrJv3BKyl++GSqtg8ZIXRyqG7PnfZKR/Bw28RWuo8ESP4wrCVqrpN TQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3j4w242dyv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:17 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 27QGpdXh033635;
        Fri, 26 Aug 2022 18:49:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3j5n6r8kc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 26 Aug 2022 18:49:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Frc3F3lT7dQi4R0cnarD3DykA4ttGQ/0PyTgsmczzkr7Y3/umfUDsUJ33E0HbR0u1oxftrPhcQNIcTAsAUtBjTxDOLOip0bqAW4RisULdB6KWWkbmhodTYPbEzGCnM/gaFV7NBOr+8mSQXju5R5coaZVeXY6aLZxlFRk6r7kkl+LK0Tg7BdoN52USkqwdUA82MaOVS3aG8Iy2+Qe6U/0E8qZ+V9WxYZq66iJAOS/4uWBcIR0hxjT4CPqqO206ZAK8uErD1kwTmQvok6CVlJJmNXX6FbKbqmhHr2phjGZNuWDeBxV//inFmIoGeTbdyVx+hVOWZbkIVWSIaBSg/QoLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJxiWGosAAPagbEvF0IGjynWcJoMm/V9XjQ9Uq2kSR8=;
 b=jnSPmA0c9RwoMCbvA0a8vHI1733Ev7YtRNLMO3wTJjtxjsskgdYB4cr4r/KNd91MGXEmxzm3bCmPO8MeaO6/u4tZGBNR5O0ZIBjBO9SjnD+QZjYM3KuKNmbzq4N6XVfW9kG4t6AC7aemE9GDVpdqdclX2FdnKQffSa6lVjdocP+sY8JYaX7+8MgDlI21drio1jtCyZjJGGvRAPmx8lxkaIKh+pYog4xgicBRfZaqkEskj8eb2UCWYDcJfP6qtd4l9lCDxIGSzyBqL4twJuGJ9hslSFz7GSLwWF6hsNLb/7aqtjTrHnFfwlPfNGoWi7+RENRloS6lBqKyBJLg1vofnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJxiWGosAAPagbEvF0IGjynWcJoMm/V9XjQ9Uq2kSR8=;
 b=BAigLk5odnPQmO4s+7Quap0AXI0r2gUn9QWaI/QRobB1euSLWkcxASx+lYx9PhlLF5BoRlkfzeE2poN4uQOUCMizgxHnkP5h9C/Pxp1RD2QTCFxNuOdaSp2EvHZ2cDnS0wMAnU9yOAeGEawSfgh4Cm1wZ45M+/widq4FQy+rv9U=
Received: from CH2PR10MB4166.namprd10.prod.outlook.com (2603:10b6:610:78::20)
 by SN7PR10MB6331.namprd10.prod.outlook.com (2603:10b6:806:271::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 18:49:13 +0000
Received: from CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5]) by CH2PR10MB4166.namprd10.prod.outlook.com
 ([fe80::44ed:9862:9a69:6da5%6]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 18:49:13 +0000
From:   Stephen Brennan <stephen.s.brennan@oracle.com>
To:     dwarves@vger.kernel.org
Cc:     bpf@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
        stephen.s.brennan@oracle.com, alan.maguire@oracle.com
Subject: [PATCH dwarves 0/7] Add support for generating BTF for all variables
Date:   Fri, 26 Aug 2022 11:49:04 -0700
Message-Id: <20220826184911.168442-1-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0127.namprd11.prod.outlook.com
 (2603:10b6:806:131::12) To CH2PR10MB4166.namprd10.prod.outlook.com
 (2603:10b6:610:78::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11d18188-4487-41e6-06ca-08da8793ab99
X-MS-TrafficTypeDiagnostic: SN7PR10MB6331:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHp8IALLn73vGdJRHNWGFUzeZxqkc6GJaVbLsWDe5fUmfuhgTwajzS7GhXYFI6q//q4IcUAuhvmgnBd55xneIg8fsHdxnl8ozh+hfC7CSdwywijWZK7vA+FdV3fhW6Z/h/k38mor0vk0LutgNrbSJb4loIJr91PJUzeb8CPT6MBMGOIcD23s1QjY3UUBwmhhtdsCh6YXqQaf5vqPDNdmanPFjBciAfsoZerqvLbORqCl1Gcn04KvAj1aUE9ivU9r2xXmkW1siJ+zhNk5CHHAXZH2q7zSVYWwLJmQODZZCHqqOgs0M6JHw6fbimzX/mjBSsnzGpw3tCU/50KDF3ZH+o5/v3d/PXwLQ/CxEqUT4sQeU+1kh5ek3dTUhsp7ifgZM4eFGRhXrfx4sjvLtyoumTFW66MGIGyF1iDpXgvGgr1F2kolT3xpXu4nlrL1rqcQKinXszeWq+kFJ8KKpmc0a8/z57c7haICRtJi1+g5HSbzd+fyTthCq23xouUK8Urhj+HRbzSPNlbCMnSQzKCorh1U21VejAz7aocFl61l/qzOBe8AYSfJl3tRbNBrGc1L9p8tzva3YXNLm7rehYw0JXXMaJrZd4/YP1q8GC0i4JU/F1DsRV9aZ38bcf9Rcr00dzSZ/97QwDvIVAj11RFk+OHd+WphAmdSWegqBy9WEafUblJTvUsOiULw1uG18thQ79mm2R1uJ/4kOhgUvOG7BlRMItAwE5CrVQXJewzvnPXN3CMfTb14HYe9cDce5t0S0Mzfz6m9eSEM62bBZQNXEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4166.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(346002)(136003)(376002)(107886003)(6506007)(478600001)(966005)(26005)(6486002)(41300700001)(6666004)(83380400001)(2616005)(2906002)(186003)(1076003)(5660300002)(8936002)(316002)(6512007)(6916009)(4326008)(8676002)(103116003)(66946007)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+zdsgL6jJHX5o4LNeqCGmQhsXLgdojCywQVPBpsixKQfbl9Zdrk8ae7wftbF?=
 =?us-ascii?Q?1MZprMkN5GDqdFHlSKzNQ4/GoTIozVowmB1UY+nlSdjdubnrCZlDsPiY/XI7?=
 =?us-ascii?Q?aJnEr0RjjTlGx6CSidFDoRAWYG/XFIj8aOuHCEOV1W0LvY7w1T6G51Ux6mvu?=
 =?us-ascii?Q?Nf0y9wJtmAD4kzCL//8/U20SZdYXslZ5gBLdtO8DUa9mIAvJCWOj6RaRvQbP?=
 =?us-ascii?Q?JtrcrBatkX2L4bYZkT1PY9HTLjNMLgaClRX3iGBRk1s+ErrIel2j/Ci1mSkB?=
 =?us-ascii?Q?VVGb/yf8cvp/9ZNdTjoGqKCLrQhIsdzG53qRRNANjBq0BZbFras7BfJVM4SO?=
 =?us-ascii?Q?2UPt5rjXrgsZhsfY7KAREPs+D8FAGMpGAPxVyuakpPCtSgVQuiwbaFfgSDB8?=
 =?us-ascii?Q?fdlxFiXhISe6R1cfjGN2OTsmPfMhXgC5POPdm7wiGPieHfGop5P/9HSkxaKE?=
 =?us-ascii?Q?hsmT28bkCJ1vrd3aybAXhsD1xVR+nVFu2r9SJdf38WtsrnEFn6KR3UnBiGxs?=
 =?us-ascii?Q?bn7jTZGMN0nu2vGRVK2gS2rcUJygltAtEN2H9Rw35VVjgMtkFXAgZBf/qkL1?=
 =?us-ascii?Q?tOshAd8DQLIRMaf14cmzsr/PLS1v3d+QXi8RLEbFCycvzrslidTP/bWZpc6k?=
 =?us-ascii?Q?cRBNqfSGQ/98G+ZDS402SVYjou/QadrzA0DHZwT3/0TRVYuzPLOSlfZWGAyH?=
 =?us-ascii?Q?1VGpQl34f3hov9LVRXkU/pNXknpaidJZLViL2708bW25uuEAFTnlceJAWn9G?=
 =?us-ascii?Q?ZPvO70WNAiJti6S6S9pdvrlZR3T2f5R5dDYoT4+PIzyMd9JUFKH9Ngxv49GG?=
 =?us-ascii?Q?GXFZcxH9K9x+t3eS6MArS5DxGFkxQ8XPsrdd8sw2LKrkj5XQ1rq5qyxt1lBo?=
 =?us-ascii?Q?M8d3wKJbs5lK+ZL6wIQhj5y06aL++cUW4kgaqbshUJHNX1957k5LlBmLCExC?=
 =?us-ascii?Q?s7LEVAfXDAD2O/k9qgsMmm9HQHdNQqhG0XnHWmUg+2BJAlWYEhTECeU59jga?=
 =?us-ascii?Q?eHiBCC7O9u2tGkqFViKRi432CauvwJ1l1/6DBYJA5K8rWZauukGmHdPT06BX?=
 =?us-ascii?Q?k3pshV6Nb0NRAH4lAJueLIXQ3GXHaDukpFtgrAn7iTqdHI+FHxiquscYNzl8?=
 =?us-ascii?Q?JArGTxAnjNL+HJX3tIRZ98GFwmyrIHUATVqpprEvGqaQkrzYFHGP2vKs5yH7?=
 =?us-ascii?Q?FqCLgGxdaQPWPkHGfb/bbc2bWZO77X9hVjvb9BC093K+W32ADhLrs82qBKc7?=
 =?us-ascii?Q?RPtCqzTXqQCsVDkZ+AkkzyMTD/5XDhnqS9NGtepdQ/2+bO4U5eFQOGTa+mkU?=
 =?us-ascii?Q?OPubW3A0b4QWADLQ3rSxwMsxnvlpyz7Ee5fpsMClTDPFRl93ZG+FToua2nd3?=
 =?us-ascii?Q?XwMVkAHJJkuHCyF9ULdD/WKrR8Ye9shXpxzYD/faG73FfNHazic4PBXKlJwG?=
 =?us-ascii?Q?OQM0rvNhj/y6F30y4Em+2QQbifwqaYuwOs4HCzdeFuBcVlILLDZID0SOg64J?=
 =?us-ascii?Q?2ibm+9kdqwxncxO6ZotLS6k/8j1pSKcufnCtOnWzMCLh4s5HlHkssV8xFTTM?=
 =?us-ascii?Q?z+isNM2sc+xlpFDaPBYptv26MqzsZtZM5u4fh1WApPH0099HQAif0D8VRE54?=
 =?us-ascii?Q?hQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d18188-4487-41e6-06ca-08da8793ab99
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4166.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 18:49:13.6939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YRmNa7Qz5WEdq56TZODQ8847ZEOhHQ7tzBHURZmkcrgAypO1QLVFxG05Z3oTwT9rGZySz/8J1A8xIbOftJ0VM38qYzG0hekjcU3bYNTCJHE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6331
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_10,2022-08-25_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxscore=0 malwarescore=0 mlxlogscore=869
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2208260075
X-Proofpoint-ORIG-GUID: vAeNGIpuB5XP7S_RWpuD_vpoFn217KkC
X-Proofpoint-GUID: vAeNGIpuB5XP7S_RWpuD_vpoFn217KkC
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello everyone,

BTF offers some exciting new possibilities beyond its original intent;
one of these is making the kernel more self-describing for debug tools.
Kallsyms contains symbol table data, and ORC (for x86_64) contains
information to help unwind stacks. Now, BTF can provide type information
for functions and variables. Taken together, this data is enough to
power the basic (read-only) functions of a postmortem or live debugger,
without falling back on the heavier debugging information formats like
DWARF. What's more, all of these data sources are contained within the
kernel image itself, and are thus available on live systems and within
crash dumps, without consulting any external debug information files.

However, currently BTF generation emits information only for percpu
variables. This patch series removes that limitation, allowing
generating BTF for all variables, thus providing complete type
information for debuggers.

Of course, generating additional BTF means that more data must be stored
in the kernel image, and that may not be okay for everyone. Thus, the
new behavior must be explicitly enabled by a flag.

Testing
-------

To verify this change and illustrate the additional space required, I
built v5.19-rc7 on x86_defconfig, with the following additionally
enabled:

enable DEBUG_INFO_DWARF4
enable BPF_SYSCALL
enable DEBUG_INFO_BTF

I then ran pahole to generate BTF from the built vmlinux in three
configurations, and recorded the size of the BTF for each:

1) using the current master branch
   size: 5505315 bytes
2) using this patched version, without enabling --encode_all_btf_vars
   size: 5505315 bytes
3) using this patched version, with --encode_all_btf_vars enabled
   size: 6811291 bytes

A total increase of 1.25 MiB, or a 23.7% increase. This is definitely
notable, but not unreasonable for many use cases such as desktop or
server applications. I also verified that the data generated by cases 1
and 2 are byte-for-byte identical: that is, there are no changes to the
generated BTF unless --encode_all_btf_vars is enabled.

I also verified that the output variables makes sense. I created an
application which parses the output BTF and dumps the
declarations (BTF_KIND_VAR and BTF_KIND_FUNC), and then diffed its
output between configuration 2 and 3. I'm happy to provide a link to
that diff (it's of course too big to include in the email).

End-to-end test
---------------

To show this is not just theory, I've created an end-to-end test which
combines BTF generated via this patch series, along with a kernel patch
necessary to expose the kallsyms data [1], and a branch of the drgn
debugger[2] which implements kallsyms and BTF parsing. Core dumps
generated on the resulting kernel can be loaded by the drgn debugger,
and the it can read out variables from the dump with full type
information without needing to consult a DWARF debuginfo file.

Future Work
-----------

If this proves acceptable, I'd like to follow-up with a kernel patch to
add a configuration option (default=n) for generating BTF with all
variables, which distributions could choose to enable or not.

There was previous discussion[3] about leveraging split BTF or building
additional kernel modules to contain the extra variables. I believe with
this patch series, it is possible to do that. However, I'd argue that
simpler is better here: the advantage for using BTF is having it all
available in the kernel/module image. Storing extra BTF on the
filesystem would break that advantage, and at that point, you'd be
better off using a debuginfo format like CTF, which is lightweight and
expected to be found on the filesystem.

[1]: https://lore.kernel.org/lkml/20220517000508.777145-3-stephen.s.brennan@oracle.com/T/
     (The above series is already in the 6.0 RC's)
[2]: https://github.com/brenns10/drgn/tree/kallsyms_plus_btf
[3]: https://lore.kernel.org/bpf/586a6288-704a-f7a7-b256-e18a675927df@oracle.com/

Stephen Brennan (7):
  dutil: return ELF section name when looked up by index
  btf_encoder: Rename percpu structures to variables
  btf_encoder: cache all ELF section info
  btf_encoder: make the variable array dynamic
  btf_encoder: record ELF section for collected variables
  btf_encoder: collect all variables
  btf_encoder: allow encoding all variables

 btf_encoder.c      | 196 +++++++++++++++++++++++++++------------------
 btf_encoder.h      |   8 +-
 dutil.c            |  10 ++-
 dutil.h            |   2 +-
 man-pages/pahole.1 |   6 +-
 pahole.c           |  31 +++++--
 6 files changed, 165 insertions(+), 88 deletions(-)

-- 
2.34.1

