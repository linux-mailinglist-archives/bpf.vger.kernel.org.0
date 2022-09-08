Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23165B132F
	for <lists+bpf@lfdr.de>; Thu,  8 Sep 2022 06:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbiIHENJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Sep 2022 00:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIHENI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Sep 2022 00:13:08 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FCE87681;
        Wed,  7 Sep 2022 21:13:07 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MNQcD0nHNz14QMw;
        Thu,  8 Sep 2022 12:09:16 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 8 Sep
 2022 12:13:04 +0800
From:   Zhengchao Shao <shaozhengchao@huawei.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <jhs@mojatatu.com>, <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <martin.lau@linux.dev>
CC:     <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
        <ast@kernel.org>, <andrii@kernel.org>, <song@kernel.org>,
        <yhs@fb.com>, <kpsingh@kernel.org>, <sdf@google.com>,
        <haoluo@google.com>, <jolsa@kernel.org>, <weiyongjun1@huawei.com>,
        <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next,v3 00/22] refactor the walk and lookup hook functions in tc_action_ops
Date:   Thu, 8 Sep 2022 12:14:32 +0800
Message-ID: <20220908041454.365070-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The implementation logic of the walk/lookup hook function in each action
module is the same. Therefore, the two functions can be reconstructed.
When registering tc_action_ops of each action module, the corresponding
net_id is saved to tc_action_ops. In this way, the net_id of the
corresponding module can be directly obtained in act_api without executing
the specific walk and lookup hook functions. Then, generic functions can
be added to replace the walk and lookup hook functions of each action
module. Last, modify each action module in alphabetical order.

Reserve the walk and lookup interfaces and delete them when they are no
longer used.

This patchset has been tested by using TDC, and I will add selftest in
other patchset.

Last, thanks to Jamal Hadi Salim and Cong Wang for their advice.
---
v3: remove hole from the structure tc_action_ops
v2: save the net_id of each TC action module to the tc_action_ops structure
---

Zhengchao Shao (22):
  net: sched: act: move global static variable net_id to tc_action_ops
  net: sched: act_api: implement generic walker and search for tc action
  net: sched: act_bpf: get rid of tcf_bpf_walker and tcf_bpf_search
  net: sched: act_connmark: get rid of tcf_connmark_walker and
    tcf_connmark_search
  net: sched: act_csum: get rid of tcf_csum_walker and tcf_csum_search
  net: sched: act_ct: get rid of tcf_ct_walker and tcf_ct_search
  net: sched: act_ctinfo: get rid of tcf_ctinfo_walker and
    tcf_ctinfo_search
  net: sched: act_gact: get rid of tcf_gact_walker and tcf_gact_search
  net: sched: act_gate: get rid of tcf_gate_walker and tcf_gate_search
  net: sched: act_ife: get rid of tcf_ife_walker and tcf_ife_search
  net: sched: act_ipt: get rid of tcf_ipt_walker/tcf_xt_walker and
    tcf_ipt_search/tcf_xt_search
  net: sched: act_mirred: get rid of tcf_mirred_walker and
    tcf_mirred_search
  net: sched: act_mpls: get rid of tcf_mpls_walker and tcf_mpls_search
  net: sched: act_nat: get rid of tcf_nat_walker and tcf_nat_search
  net: sched: act_pedit: get rid of tcf_pedit_walker and
    tcf_pedit_search
  net: sched: act_police: get rid of tcf_police_walker and
    tcf_police_search
  net: sched: act_sample: get rid of tcf_sample_walker and
    tcf_sample_search
  net: sched: act_simple: get rid of tcf_simp_walker and tcf_simp_search
  net: sched: act_skbedit: get rid of tcf_skbedit_walker and
    tcf_skbedit_search
  net: sched: act_skbmod: get rid of tcf_skbmod_walker and
    tcf_skbmod_search
  net: sched: act_tunnel_key: get rid of tunnel_key_walker and
    tunnel_key_search
  net: sched: act_vlan: get rid of tcf_vlan_walker and tcf_vlan_search

 include/net/act_api.h      |  1 +
 net/sched/act_api.c        | 33 ++++++++++++++++++---
 net/sched/act_bpf.c        | 28 +++--------------
 net/sched/act_connmark.c   | 28 +++--------------
 net/sched/act_csum.c       | 28 +++--------------
 net/sched/act_ct.c         | 32 ++++----------------
 net/sched/act_ctinfo.c     | 28 +++--------------
 net/sched/act_gact.c       | 28 +++--------------
 net/sched/act_gate.c       | 28 +++--------------
 net/sched/act_ife.c        | 28 +++--------------
 net/sched/act_ipt.c        | 61 +++++++-------------------------------
 net/sched/act_mirred.c     | 28 +++--------------
 net/sched/act_mpls.c       | 28 +++--------------
 net/sched/act_nat.c        | 28 +++--------------
 net/sched/act_pedit.c      | 28 +++--------------
 net/sched/act_police.c     | 28 +++--------------
 net/sched/act_sample.c     | 28 +++--------------
 net/sched/act_simple.c     | 28 +++--------------
 net/sched/act_skbedit.c    | 28 +++--------------
 net/sched/act_skbmod.c     | 28 +++--------------
 net/sched/act_tunnel_key.c | 28 +++--------------
 net/sched/act_vlan.c       | 28 +++--------------
 22 files changed, 118 insertions(+), 513 deletions(-)

-- 
2.17.1

