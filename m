Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22A6F2557F7
	for <lists+bpf@lfdr.de>; Fri, 28 Aug 2020 11:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbgH1JtC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 28 Aug 2020 05:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1JtB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 28 Aug 2020 05:49:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7B8C061264
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 02:49:00 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y8so482868wma.0
        for <bpf@vger.kernel.org>; Fri, 28 Aug 2020 02:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ImKXCTbxtsyXKa2yFgKuyPXc7peqmPQCKRcDEmZRSk=;
        b=wog6DIqABp/ebb2IGZ5qejfJIteVOPxgPQNP+g1uRHkw0cOGXEAGVlAQdeTdAEi4TO
         fzsqnayQ5tkT8AjER64mJeQ2qI4ibqQsQy+m6XgbQ1LQHv246XET0b7DzoXz9PGlFfh8
         Os/zGzoV0QN3VzAYFOcu1KDxB+WD9Ux6z9Lnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5ImKXCTbxtsyXKa2yFgKuyPXc7peqmPQCKRcDEmZRSk=;
        b=Abr9K+fU9Wlrb1SvKtzvNMHlo0TCC1MLxUZlOU5i3kT/z1nQ5/ruGgwvaj3k5RHdZj
         jAp0byGcSg1T00S8TUCNq8WvjnPPoLAuN8JTrgBGeyJUNbCwwykfOqq2st7I4GzmOlGi
         9D0LIwhcw/v23gYoDLh1i7lhBIFFbghogloTSrlFwLL22lvcnZqYFipeOu3AfkiNFJo8
         JKi6mKWztjHcqAZ63ZRpuBWMt71gpu0OsdUtHmEfSn39Rjd7OEDSCgv06CwIarwrSCIF
         T5BCcZVWDkZ6KewTLmLKwzjvk0VLimPlb/ZjLsVU81I7H7CH9gjRzpmtnIIv7IZDAOge
         pGlQ==
X-Gm-Message-State: AOAM53328oeBQ6PUBDKC/oz3uo5qdfF4sbBimZc5Gbplck2EeT/b4V0G
        whLoTv1OOCgSd9j7K/y34zGEBw==
X-Google-Smtp-Source: ABdhPJw+dOoONvXEn1EO3gxbLUp/R8/A/w7L4CxzUusgToeNOmQdEZ0BeqI8qOb+3bCDNI+vuUpmrw==
X-Received: by 2002:a1c:c90d:: with SMTP id f13mr813644wmb.25.1598608139532;
        Fri, 28 Aug 2020 02:48:59 -0700 (PDT)
Received: from antares.lan (5.8.0.7.f.1.6.5.2.2.a.f.0.8.0.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:80:fa22:561f:7085])
        by smtp.gmail.com with ESMTPSA id z203sm1371119wmc.31.2020.08.28.02.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 02:48:58 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 0/3] Sockmap iterator
Date:   Fri, 28 Aug 2020 10:48:31 +0100
Message-Id: <20200828094834.23290-1-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new bpf_iter for sockmap and sockhash. As previously discussed, we
want to use this to copy a sockhash in kernel space while modifying the
format of the keys.

The implementation leans heavily on the existing bpf_sk_storage and
hashtable iterators. However, there is a key difference for the sockmap
iterator: we don't take any bucket locks during iteration. It seems to
me that there is a risk of deadlock here if the iterator attempts to
insert an item into the bucket that we are currently iterating. I think
that the semantics are reasonable even without the lock.

In the iteration context I expose a PTR_TO_SOCKET_OR_NULL, aka struct
bpf_sock*. This is in contrast to bpf_sk_storage which uses a
PTR_TO_BTF_ID_OR_NULL, aka struct sock*. My personal preference would
be to use PTR_TO_BTF_ID_OR_NULL for sockmap as well, however the
verifier currently doesn't understand that PTR_TO_BTF_ID for struct
sock can be coerced to PTR_TO_SOCKET_OR_NULL. So we can't call
map_update_elem, etc. and the whole exercise is for naught. I'm
considering teaching this trick to the verifier, does anyone have
concerns or ideas how to achieve this?

Thanks to Yonghong for guidance on how to go about this, and for
adding bpf_iter in the first place!

Lorenz Bauer (3):
  net: Allow iterating sockmap and sockhash
  selftests: bpf: Add helper to compare socket cookies
  selftests: bpf: Test copying a sockmap via bpf_iter

 net/core/sock_map.c                           | 283 ++++++++++++++++++
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 129 +++++++-
 tools/testing/selftests/bpf/progs/bpf_iter.h  |   9 +
 .../selftests/bpf/progs/bpf_iter_sockmap.c    |  50 ++++
 4 files changed, 457 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/bpf_iter_sockmap.c

-- 
2.25.1

