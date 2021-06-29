Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC33A3B7754
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 19:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhF2RkS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 13:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhF2RkS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 13:40:18 -0400
Received: from mail-pl1-x663.google.com (mail-pl1-x663.google.com [IPv6:2607:f8b0:4864:20::663])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176EBC061760
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 10:37:51 -0700 (PDT)
Received: by mail-pl1-x663.google.com with SMTP id i4so11303619plt.12
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 10:37:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:from:date:message-id
         :subject:to:cc;
        bh=UNyWplnK1RWdGLxbRVuOQ5s+qEqLt/CTuvraWi7Z4dg=;
        b=K0OssyBM6KfEii3OusKQX1O+nqGQMk0O9rSnHhEzUMbXangMjhitdOcz/bjTazct51
         7usbkMTSSVhTPNXKVkpbrO9Pt6GlXaR0ZERz4LHUiof0csv+mOCsQvBPHhGZ9W6Klv4e
         49ubwwtDZTdS5HQJ8qzRYNe5E6vadetcVNMuqWp/n7CZvyPvTb6DmkIse1tzCZa1OkxC
         F/QliUu94l3BArNCs5mMDds0geM15qFRm7pv2aaf8CB9oQgVPH8R3CTFCUFInM5OyscN
         Q/gKl7I2gEfLEaDvaB8TR8Lyom9kIwNQnRCYfNhPR1d85aiQFU5EKMKCw3ls0m/sg7a1
         eKBQ==
X-Gm-Message-State: AOAM530DyqJjIFg/h7SFvnNW2QhmIHtcJRwiA5AslNoAJOKj9ihmEk/F
        CzlnoHToiyrtohDxRT0xT989gq/AfiS4qplKd6sh82doy0vsog==
X-Google-Smtp-Source: ABdhPJyRzxoR1DeHJC0P7HkrHD2eopln+2yh9UXVn6EyZSrujnNNwKGkERqs7NLp22yj5ZeSV1y/0uA6mfLc
X-Received: by 2002:a17:903:228e:b029:101:af04:4e24 with SMTP id b14-20020a170903228eb0290101af044e24mr28797671plh.3.1624988270456;
        Tue, 29 Jun 2021 10:37:50 -0700 (PDT)
Received: from restore.menlosecurity.com ([13.56.32.60])
        by smtp-relay.gmail.com with ESMTPS id cs19sm6818295pjb.0.2021.06.29.10.37.48
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 10:37:50 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.61)
    by restore.menlosecurity.com (13.56.32.60)
    with SMTP id b84b92c0-d900-11eb-8d46-f1832bde6be8;
    Tue, 29 Jun 2021 17:37:50 GMT
Received: from mail-ed1-f71.google.com (209.85.208.71)
    by safemail-prod-02790022cr-re.menlosecurity.com (13.56.32.61)
    with SMTP id b84b92c0-d900-11eb-8d46-f1832bde6be8;
    Tue, 29 Jun 2021 17:37:49 GMT
Received: by mail-ed1-f71.google.com with SMTP id s6-20020a0564020146b029039578926b8cso2470293edu.20
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 10:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=UNyWplnK1RWdGLxbRVuOQ5s+qEqLt/CTuvraWi7Z4dg=;
        b=HLXa5iST1dBAmqyrm3a1uMy66GCZ1PckBNEEGvk6BvYytv/R7+iFPp3MxPHfrf8QIZ
         AreUOxLSOqQOTmf+mAfzm3uZrlqhyuATQFv0p/6g7Bgw49AuXP7lYv8ASELNeErFE41s
         rHQd0fwOnC5L/M2mvfZ3slTWOmZGhUKf61QAM=
X-Received: by 2002:aa7:cc01:: with SMTP id q1mr38240532edt.84.1624988265840;
        Tue, 29 Jun 2021 10:37:45 -0700 (PDT)
X-Received: by 2002:aa7:cc01:: with SMTP id q1mr38240517edt.84.1624988265665;
 Tue, 29 Jun 2021 10:37:45 -0700 (PDT)
MIME-Version: 1.0
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Tue, 29 Jun 2021 10:37:34 -0700
Message-ID: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
Subject: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
To:     bpf@vger.kernel.org
Cc:     David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support for policy routing via marks to the bpf_fib_lookup
helper. The bpf_fib_lookup struct is constrained to 64B for
performance. Since the smac and dmac entries are used only for
output, put them in an anonymous struct and then add a union
around a second struct that contains the mark to use in the FIB
lookup.

Signed-off-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Rumen Telbizov <telbizov@gmail.com>
---
 include/uapi/linux/bpf.h | 16 ++++++++++++++--
 net/core/filter.c        |  4 ++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index ec6d85a81744..6c78cc9c3c75 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5925,8 +5925,20 @@ struct bpf_fib_lookup {
  /* output */
  __be16 h_vlan_proto;
  __be16 h_vlan_TCI;
- __u8 smac[6];     /* ETH_ALEN */
- __u8 dmac[6];     /* ETH_ALEN */
+
+ union {
+ /* input */
+ struct {
+ __u32 mark;   /* fwmark for policy routing */
+ /* 2 4-byte holes for input */
+ };
+
+ /* output: source and dest mac */
+ struct {
+ __u8 smac[6]; /* ETH_ALEN */
+ __u8 dmac[6]; /* ETH_ALEN */
+ };
+ };
 };

 struct bpf_redir_neigh {
diff --git a/net/core/filter.c b/net/core/filter.c
index 65ab4e21c087..2ea997cacf4d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5299,6 +5299,7 @@ static int bpf_ipv4_fib_lookup(struct net *net,
struct bpf_fib_lookup *params,
  fl4.saddr = params->ipv4_src;
  fl4.fl4_sport = params->sport;
  fl4.fl4_dport = params->dport;
+ fl4.flowi4_mark = params->mark;
  fl4.flowi4_multipath_hash = 0;

  if (flags & BPF_FIB_LOOKUP_DIRECT) {
@@ -5311,7 +5312,6 @@ static int bpf_ipv4_fib_lookup(struct net *net,
struct bpf_fib_lookup *params,

  err = fib_table_lookup(tb, &fl4, &res, FIB_LOOKUP_NOREF);
  } else {
- fl4.flowi4_mark = 0;
  fl4.flowi4_secid = 0;
  fl4.flowi4_tun_key.tun_id = 0;
  fl4.flowi4_uid = sock_net_uid(net, NULL);
@@ -5425,6 +5425,7 @@ static int bpf_ipv6_fib_lookup(struct net *net,
struct bpf_fib_lookup *params,
  fl6.saddr = *src;
  fl6.fl6_sport = params->sport;
  fl6.fl6_dport = params->dport;
+ fl6.flowi6_mark = params->mark;

  if (flags & BPF_FIB_LOOKUP_DIRECT) {
  u32 tbid = l3mdev_fib_table_rcu(dev) ? : RT_TABLE_MAIN;
@@ -5437,7 +5438,6 @@ static int bpf_ipv6_fib_lookup(struct net *net,
struct bpf_fib_lookup *params,
  err = ipv6_stub->fib6_table_lookup(net, tb, oif, &fl6, &res,
    strict);
  } else {
- fl6.flowi6_mark = 0;
  fl6.flowi6_secid = 0;
  fl6.flowi6_tun_key.tun_id = 0;
  fl6.flowi6_uid = sock_net_uid(net, NULL);
--
2.30.1 (Apple Git-130)
