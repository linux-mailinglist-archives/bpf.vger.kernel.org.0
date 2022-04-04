Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA6404F1112
	for <lists+bpf@lfdr.de>; Mon,  4 Apr 2022 10:38:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234262AbiDDIkP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 4 Apr 2022 04:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233468AbiDDIkO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Apr 2022 04:40:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A51E1EC5E
        for <bpf@vger.kernel.org>; Mon,  4 Apr 2022 01:38:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 03026210E5;
        Mon,  4 Apr 2022 08:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1649061498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+KywJWEh+za1jRyKG7b9cO+IUoRKbEOrKraLG5OweRc=;
        b=TGaXi9GvEZ0BNLx7zJ5zaf36vcyQHrz+4sz/MCDni1/Kg7z6hEAdjTblIqWBxRndKWNlFd
        xDDx7NAH+ecG0p5DrNcXgvzlIPZpQkZivzs2SqKAtW9zEhMzi++iLLQVO9F9Y9IazIiZ8B
        /1iBmIE1gFJbJca5WxYorcB46WmPcL0=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8DA7513216;
        Mon,  4 Apr 2022 08:38:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PHODH3muSmKuBQAAMHmgww
        (envelope-from <nborisov@suse.com>); Mon, 04 Apr 2022 08:38:17 +0000
From:   Nikolay Borisov <nborisov@suse.com>
To:     bpf@vger.kernel.org
Cc:     daniel@iogearbox.net, andrii@kernel.org, ast@kernel.org,
        Nikolay Borisov <nborisov@suse.com>
Subject: [RFC PATCH 0/2] Add btf__field_exists
Date:   Mon,  4 Apr 2022 11:38:14 +0300
Message-Id: <20220404083816.1560501-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

Here are 2 patches with which I want to probe what's the sentiments towards 2
changes:

1. Introduction of libbpf APIs similar to the bpf counterparts: bpf_core_field_exists,
bpf_core_type_exists and bpf_core_enum_value_exists. Of those I've implemented only
the first one and the reasoning behind this is in the patch itself. However, the
TLDR is that there can be cases where based on the kernel version we have to make a
decision in userspace what set of kprobes to use. There are currently no convenince
api's to do this so one has to essentially open code the checks that can be provided
by the aforementioned APIs.

2. The kernel has for_each_member macro but the libbpf library doesn't provide it,
this results in having to open code members enumeration in various places such as
in find_member_by_name/find_struct_ops_kern_types/bpf_map__init_kern_struct_ops/
parse_btf_map_def  and in the newly introduced btf__field_exists. So how about
bringing the convenience macro to libbpf?

The reason why this series is RFC is if people agree with the proposed changed
I'd be happy to extend it to add more *exists* APIs and do the conversion to
using the  for_each_member macro.

Nikolay Borisov (2):
  libbpf: Add userspace version of for_each_member macro
  libbpf: Add btf__field_exists

 tools/lib/bpf/btf.c      | 28 ++++++++++++++++++++++++++++
 tools/lib/bpf/btf.h      |  8 ++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 37 insertions(+)

--
2.25.1

