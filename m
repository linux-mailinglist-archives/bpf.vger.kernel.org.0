Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1CD234D6B
	for <lists+bpf@lfdr.de>; Sat,  1 Aug 2020 00:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbgGaWJJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 31 Jul 2020 18:09:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaWJI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 31 Jul 2020 18:09:08 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF59C06174A
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 15:09:08 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id z17so11467910ill.6
        for <bpf@vger.kernel.org>; Fri, 31 Jul 2020 15:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:date:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=px/AVnfDI+JIBGNQ4BT/FQ3aIHFWlFxrS+QtYnmqoA8=;
        b=ryJMsZWbejumb9NA6fFkSfhTueZrAcXRFnKMiVd4jkdalTZHJTPmdEQD7V6C28aUOn
         T3asWFdwshUeJPnJ1bK1cAlVac4Fe3kWVv6gGdFex4lB/f3T6qvzmqyN2GZQBysU2U5b
         85bWnlCQwTzzR0DzUOYtgzruZTd3l+8lfZr282jdNtkMJg7ISlEqe2SRwJ6tEhxsYWvD
         XdX5w7QrEjzHimncScPKvsokw6y0J1Hgq6jQC485uBrsQSWikhFa+TMfighNTfncKmm+
         OZ3slk9allv4/Gmsyg2O+yd+L4buGNaqAQerpmCieFESZOKwE2OU7fK+q3cn6PcNVCZI
         vjLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:user-agent
         :mime-version:content-transfer-encoding;
        bh=px/AVnfDI+JIBGNQ4BT/FQ3aIHFWlFxrS+QtYnmqoA8=;
        b=Sa9OAVgNAsidnW9yP6a9WJ6hWFooikfqP3DnrUHfedYh2Z0UFxlkcZhpmYTcRLyIbZ
         xm+Ng5kAYnVeaV/pWSOtJCUG1F80M19stCUxBjBPE+AC4eq1100apRJA7nosbMtM82v6
         eQI0HSCWpyNaeRl/QvwpSbov6ZCAvxjoTXpOn+z8Uc40IHmbpWzWZGxY6W+7wBQ3MNkd
         05/K82BCDB1Q0VwolAJkFEfT37f45LHS3k7c6u+FsOIKU2ENOLTjfueKG/w1kfC5mgt0
         lTcs73os8rhZOIRy6nnhMU+IwPoCcRE2zB42H0wHI4kJImT8n+h/hv8cegxqFj+zElkA
         69gQ==
X-Gm-Message-State: AOAM530RW5S2Vvi+9m3J+QKU2R8/D4opC1LaLDSY23bz0KtthmsjXG1h
        izRqAoiODAIQf56GnYUyrAo=
X-Google-Smtp-Source: ABdhPJyDq0+RUP33bixvfem2nVppX23qopikfvb3I2WGp+93OxRBf/2zncaIUAwnTiUpSI0Hwb/USQ==
X-Received: by 2002:a92:d60b:: with SMTP id w11mr5365266ilm.156.1596233348181;
        Fri, 31 Jul 2020 15:09:08 -0700 (PDT)
Received: from [127.0.1.1] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id b11sm5602778ile.32.2020.07.31.15.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 15:09:07 -0700 (PDT)
Subject: [bpf-next PATCH] Consolidate cgroup setup in selftests
From:   John Fastabend <john.fastabend@gmail.com>
To:     andriin@fb.com, john.fastabend@gmail.com, ast@kernel.org,
        daniel@iogearbox.net
Cc:     bpf@vger.kernel.org
Date:   Fri, 31 Jul 2020 15:08:54 -0700
Message-ID: <159623300854.30208.15981610185239932416.stgit@john-XPS-13-9370>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I had this on my stack after trying to get selftests to work with
netprio cgroup running. I failed at that for the time being. The
primary problem is if we run tests in root cgroup then we need
a better way to clean them up vs deleting the directory.

But, I have this on my stack and it seems like a nice cleanup
if we want to pull it in. Andrii wdyt?

---

John Fastabend (1):
      bpf, selftests: Use single cgroup helpers for both test_sockmap/progs


 tools/testing/selftests/bpf/cgroup_helpers.c       |   23 ++++++++++++++++++++
 tools/testing/selftests/bpf/cgroup_helpers.h       |    1 +
 tools/testing/selftests/bpf/get_cgroup_id_user.c   |   14 ++----------
 tools/testing/selftests/bpf/test_cgroup_storage.c  |   17 +--------------
 tools/testing/selftests/bpf/test_dev_cgroup.c      |   15 ++-----------
 tools/testing/selftests/bpf/test_netcnt.c          |   17 ++-------------
 .../selftests/bpf/test_skb_cgroup_id_user.c        |    8 +------
 tools/testing/selftests/bpf/test_sock.c            |    8 +------
 tools/testing/selftests/bpf/test_sock_addr.c       |    8 +------
 tools/testing/selftests/bpf/test_sock_fields.c     |   14 +++---------
 tools/testing/selftests/bpf/test_socket_cookie.c   |    8 +------
 tools/testing/selftests/bpf/test_sockmap.c         |   18 ++--------------
 tools/testing/selftests/bpf/test_sysctl.c          |    8 +------
 tools/testing/selftests/bpf/test_tcpbpf_user.c     |    8 +------
 tools/testing/selftests/bpf/test_tcpnotify_user.c  |    8 +------
 15 files changed, 43 insertions(+), 132 deletions(-)

--
Signature
