Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCDB6C2203
	for <lists+bpf@lfdr.de>; Mon, 20 Mar 2023 20:57:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCTT5D (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Mar 2023 15:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjCTT5B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Mar 2023 15:57:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C832202D
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:56:59 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32KH7c1S021652
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:56:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=2XKew6Qt7ahCguRH0gt1ynAdJqRurJvbAvz7eCOM9Zk=;
 b=faS00CtXTz2JTplgfelz0QReFw9cjwSAsJvWnmFo8iGYSIzu2liNinIz3zB3Au1ArHqn
 0v8vaTnrsh3zVrxMIe/cwapvY4x9V0H/8Bzdmz9Rhnzjr6R7HeVLO6dfUt7oa4xRCZo9
 eTLs0ScDNCkMRNx4YP7sw9JoqsrjuggX3dt14jcHK3E9yC+XG9qYW71p51QCfJEyC+aZ
 ji4RX/PW7JihROw3yt8O98Z4JELCihaCLmzE+dPsXdKPZX+6s9DrTld4KRbIHw+nNaUZ
 J/OV6CQbKglhzedKw1kR/jot8N25zn8yNF4YTIWISc8DqgGTWa1RnQxFIGUJSZ1x2heq MQ== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3peq8hb4w5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 20 Mar 2023 12:56:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1SUdvWkv8iu+EyGsPXzTHBtS2PTi8qUkC2PpaXhAmF3+oNL60aFLkdo32OLT+zY9GU7GONfh0YjhbHYleFt3OMnLgHjM9OezFD7kcb6Q/6lNSX29St4jy/rQpgyrrEEy5u/bRtBoi4SnWGmOzhKNVj+9ejIbh2bI5Vi9d7GgWDOLsGM44tkLHt24CWhZUm1KvCdr5g2TAIGkXg+9oc+n0ImkKrPW+ME0NXouBnddtdjgsKIGJV1ba+fEjbVI7yunEzIq69WFLjbwW4uCykm+CbP8iBwVhf4tazSIq7eZmjFMvNMQnlqY1Haj1n9W/seacj38qIlQgJHQXgWYhgKBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+SfDJzHITrUcq6lr1ylKxlR/OiW+zVDK4zrmbvcXhw=;
 b=AgtgOM1KC1st4U4OPvaZtrE1O9w3W31SxysA20k1501fnxFbn/GOliX/iBrAfY7ChReaAwR8T6+C4h2E5I2vcIZ8xUVR31LgMq6oOuQdH9mQL8skL4ABHN9LfqSkSFZH5gPFrwF3XCwXZtOBeTJ6BPFWsomVXgM4NFPZN0M8D3bec2VwyxuYbkV2soaB/UG36rbLeQIsilssvhif8A7uVpws84hkRnDMhRh1R4NmaNC2iHHLMOxhNNUPCXzgGVS4cT5ioWQ1HO4Sl6Mg6xVU5200P41AVQTb0UAwJgoDAtkcTpronkvHUxHCTNSbi9zL5lJsJZWv7jZgeYx0bkBNnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 69.171.232.181) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=meta.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject header.from=meta.com;
 dkim=none (message not signed); arc=none
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by IA0PR15MB5620.namprd15.prod.outlook.com (2603:10b6:208:436::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 19:56:51 +0000
Received: from MW2NAM12FT104.eop-nam12.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::9e) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Mon, 20 Mar 2023 19:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 69.171.232.181)
 smtp.mailfrom=meta.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=meta.com;
Received-SPF: Fail (protection.outlook.com: domain of meta.com does not
 designate 69.171.232.181 as permitted sender)
 receiver=protection.outlook.com; client-ip=69.171.232.181;
 helo=69-171-232-181.mail-mxout.facebook.com;
Received: from 69-171-232-181.mail-mxout.facebook.com (69.171.232.181) by
 MW2NAM12FT104.mail.protection.outlook.com (10.13.181.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.2 via Frontend Transport; Mon, 20 Mar 2023 19:56:55 +0000
Received: by devbig931.frc1.facebook.com (Postfix, from userid 460691)
        id 3E24D7D4C173; Mon, 20 Mar 2023 12:56:46 -0700 (PDT)
From:   Kui-Feng Lee <kuifeng@meta.com>
To:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Cc:     Kui-Feng Lee <kuifeng@meta.com>
Subject: [PATCH bpf-next v9 0/8] Transit between BPF TCP congestion controls.
Date:   Mon, 20 Mar 2023 12:56:36 -0700
Message-Id: <20230320195644.1953096-1-kuifeng@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM12FT104:EE_|IA0PR15MB5620:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 35dff018-8695-46cf-55dc-08db297d420c
X-ETR:  Bypass spam filtering
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nnOcqihDpLF7tXV/C8zhBEyvFIJfWvuKAJBX2656QgCl8NLOomjU1OdHH5K7nrhtJeGmMZbltc2MjrsUSuR2OBmIQdFxfYY4LoRsOibgUlTdEwmlBRl0EwI8qaA1VGPe2khhvvoBuzt81fgDa8+PgsCXH6dAE8p7zXPqemN9X11nSGUGzeNUVjRxcE2fiwoDLHJTFcCt/+WEzYKFCCZim8cvwcYxi7dJ7qRdgwa+HT8EbCtXXRSRtZ+myM0K72Dh2ROje743eedvQzTPwpCHGG/zjVHhe27qvfda6kiRrEuA3QMDk8FlTt6hXn24TH40+9A5y3qZyqsDzxLFZTJ8pqWMCt90v3LWEldxWlY9Obynkc1eLp2LiSmSgBpdAqouJHSKTMSUUpW/At6PUDn8W+Bvcq7ItOSTSHhYoH9Dg5vK/HJR0FWPNmFhbLCRMzuT8i7CwVMdB3c8Lg85GwkkuXrPJInE5s6rZbNJvNtvIpDmKYjsDAbt+4ynaFiNfCP1AiTG5Yvn6Twx6p5j8kuQurUZsXwG8B3Ntd+KHw4+YcyEp79RwLJATaCMN+nTGXZNJZN4JMyvfP+ixZNNiFoD/C2jmynhWBnxCLs7+I7TIdC4CkYY/g1nrqHvfJRgxmdYlI4PEsmzrtWI9nFXdq0Gt0fdJSRnRNI1TF7DdHLld2m9JvKew0KLolIY+wpHE8dCnO75w0DPxvDmX6sVhE0r1v3QYeGCdnw/bbhjjMjONVc=
X-Forefront-Antispam-Report: CIP:69.171.232.181;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:69-171-232-181.mail-mxout.facebook.com;PTR:69-171-232-181.mail-mxout.facebook.com;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(336012)(2616005)(26005)(1076003)(966005)(107886003)(47076005)(6666004)(6266002)(316002)(4326008)(83380400001)(186003)(478600001)(70206006)(42186006)(8676002)(5660300002)(8936002)(2906002)(7596003)(36860700001)(82740400003)(41300700001)(7636003)(356005)(82310400005)(33570700077)(86362001)(36756003)(40480700001)(40460700003);DIR:OUT;SFP:1501;
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 19:56:55.6781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dff018-8695-46cf-55dc-08db297d420c
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=8ae927fe-1255-47a7-a2af-5f3a069daaa2;Ip=[69.171.232.181];Helo=[69-171-232-181.mail-mxout.facebook.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-MW2NAM12FT104.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR15MB5620
X-Proofpoint-GUID: HXlO_iq0p0PeJ0GPYHQJdwHWq81idd6l
X-Proofpoint-ORIG-GUID: HXlO_iq0p0PeJ0GPYHQJdwHWq81idd6l
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-20_16,2023-03-20_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Major changes:

 - Create bpf_links in the kernel for BPF struct_ops to register and
   unregister it.

 - Enables switching between implementations of bpf-tcp-cc under a
   name instantly by replacing the backing struct_ops map of a
   bpf_link.

Previously, BPF struct_ops didn't go off, as even when the user
program creating it was terminated, none of these ever were pinned.
For instance, the TCP congestion control subsystem indirectly
maintains a reference count on the struct_ops of any registered BPF
implemented algorithm. Thus, the algorithm won't be deactivated until
someone deliberately unregisters it.  For compatibility with other BPF
programs, bpf_links have been created to work in coordination with
struct_ops maps. This ensures that the registration and unregistration
of these respective maps is carried out at the start and end of the
bpf_link.

We also faced complications when attempting to replace an existing TCP
congestion control algorithm with a new implementation on the fly. A
struct_ops map was used to register a TCP congestion control algorithm
with a unique name.  We had to either register the alternative
implementation with a new name and move over or unregister the current
one before being able to reregistration with the same name.  To fix
this problem, we can an option to migrate the registration of the
algorithm from struct_ops maps to bpf_links. By modifying the backing
map of a bpf_link, it suddenly becomes possible to replace an existing
TCP congestion control algorithm with ease.

---

The major differences form v8:

 - Check bpf_struct_ops::{validate,update} in
   bpf_struct_ops_map_alloc()

The major differences from v7:

 - Use synchronize_rcu_mult(call_rcu, call_rcu_tasks) to replace
   synchronize_rcu() *** BLURB HERE *** synchronize_rcu_tasks().

 - Call synchronize_rcu() in tcp_update_congestion_control().

 - Handle -EBUSY in bpf_map__attach_struct_ops() to allow a struct_ops
   can be used to create links more than once.  Include a test case.

 - Add old_map_fd to bpf_attr and handle BPF_F_REPLACE in
   bpf_struct_ops_map_link_update().

 - Remove changes in bpf_dummy_struct_ops.c and add a check of .update
   function pointer of bpf_struct_ops.

The major differences from v6:

 - Reword commit logs of the patch 1, 2, and 8.

 - Call syncrhonize_rcu_tasks() as well in bpf_struct_ops_map_free().

 - Refactor bpf_struct_ops_map_free() so that
   bpf_struct_ops_map_alloc() can free a struct_ops without waiting
   for a RCU grace period.

The major differences from v5:

 - Add a new step to bpf_object__load() to prepare vdata.

 - Accept BPF_F_REPLACE.

 - Check section IDs in find_struct_ops_map_by_offset()

 - Add a test case to check mixing w/ and w/o link struct_ops.

 - Add a test case of using struct_ops w/o link to update a link.

 - Improve bpf_link__detach_struct_ops() to handle the w/ link case.

The major differences from v4:

 - Rebase.

 - Reorder patches and merge part 4 to part 2 of the v4.

The major differences from v3:

 - Remove bpf_struct_ops_map_free_rcu(), and use synchronize_rcu().

 - Improve the commit log of the part 1.

 - Before transitioning to the READY state, we conduct a value check
   to ensure that struct_ops can be successfully utilized and links
   created later.

The major differences from v2:

 - Simplify states

   - Remove TOBEUNREG.

   - Rename UNREG to READY.

 - Stop using the refcnt of the kvalue of a struct_ops. Explicitly
   increase and decrease the refcount of struct_ops.

 - Prepare kernel vdata during the load phase of libbpf.

The major differences from v1:

 - Added bpf_struct_ops_link to replace the previous union-based
   approach.

 - Added UNREG and TOBEUNREG to the state of bpf_struct_ops_map.

   - bpf_struct_ops_transit_state() maintains state transitions.

 - Fixed synchronization issue.

 - Prepare kernel vdata of struct_ops during the loading phase of
   bpf_object.

 - Merged previous patch 3 to patch 1.

v8: https://lore.kernel.org/all/20230318053144.1180301-1-kuifeng@meta.com/
v7: https://lore.kernel.org/all/20230316023641.2092778-1-kuifeng@meta.com/
v6: https://lore.kernel.org/all/20230310043812.3087672-1-kuifeng@meta.com/
v5: https://lore.kernel.org/all/20230308005050.255859-1-kuifeng@meta.com/
v4: https://lore.kernel.org/all/20230307232913.576893-1-andrii@kernel.org/
v3: https://lore.kernel.org/all/20230303012122.852654-1-kuifeng@meta.com/
v2: https://lore.kernel.org/bpf/20230223011238.12313-1-kuifeng@meta.com/
v1: https://lore.kernel.org/bpf/20230214221718.503964-1-kuifeng@meta.com/

Kui-Feng Lee (8):
  bpf: Retire the struct_ops map kvalue->refcnt.
  net: Update an existing TCP congestion control algorithm.
  bpf: Create links for BPF struct_ops maps.
  libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
  bpf: Update the struct_ops of a bpf_link.
  libbpf: Update a bpf_link with another struct_ops.
  libbpf: Use .struct_ops.link section to indicate a struct_ops with a
    link.
  selftests/bpf: Test switching TCP Congestion Control algorithms.

 include/linux/bpf.h                           |  11 +
 include/net/tcp.h                             |   3 +
 include/uapi/linux/bpf.h                      |  33 ++-
 kernel/bpf/bpf_struct_ops.c                   | 250 +++++++++++++++---
 kernel/bpf/syscall.c                          |  63 ++++-
 net/ipv4/bpf_tcp_ca.c                         |  14 +-
 net/ipv4/tcp_cong.c                           |  65 ++++-
 tools/include/uapi/linux/bpf.h                |  33 ++-
 tools/lib/bpf/libbpf.c                        | 190 ++++++++++---
 tools/lib/bpf/libbpf.h                        |   1 +
 tools/lib/bpf/libbpf.map                      |   1 +
 .../selftests/bpf/prog_tests/bpf_tcp_ca.c     | 116 ++++++++
 .../selftests/bpf/progs/tcp_ca_update.c       |  80 ++++++
 13 files changed, 759 insertions(+), 101 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/tcp_ca_update.c

--=20
2.34.1

