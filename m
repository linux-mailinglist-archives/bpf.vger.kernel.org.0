Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF9879B84
	for <lists+bpf@lfdr.de>; Mon, 29 Jul 2019 23:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbfG2VvP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jul 2019 17:51:15 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:35169 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388888AbfG2VvO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jul 2019 17:51:14 -0400
Received: by mail-pl1-f202.google.com with SMTP id s21so33905855plr.2
        for <bpf@vger.kernel.org>; Mon, 29 Jul 2019 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Ky51eWLkWqKn9vu5XgFYadpIqkYzkr7aTFdFnNTQm0s=;
        b=MFkx4MeFQBofsS1qaTHjIDBKc57vd+P4SE7zguji88eHPTh5dHAbyt0Wj8MHWUhRIy
         bGIZK0mzCbLdKDFDx5S+/B5GiconXVgjxvUDZ1u6WjHLNp4qC827KCLx9I0Y84ET2Q/R
         JCABlHwuAN7Iv75sGV/3in5j88iY9cKEJ+mw9XP9YVUB22qEJ0TYyM8qIaDpU7xC18YY
         ca/bL1OJkRfiHBmB1XL63yktzBXcoQJ3kkjbf/kdM+CDn0rxmPE5IVqQpdMPhQOAESUX
         BkbU0DA3ChotuIBVK7iCyrdArSZCRxFgMO51R3oTxNtAlSRF5SzKlHz6hL/hJsjch0yX
         NnTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Ky51eWLkWqKn9vu5XgFYadpIqkYzkr7aTFdFnNTQm0s=;
        b=haLVMtHMXcJdPiOJ9SxnjtsLcN02D/SxBMzIvDe9HhT2P3sxT6SUDwMc0uENbg2bVf
         iOi/hU8q3fBh21opmnMJ4ozdTkCo0puBwDFPZ6+15HmL70mrAfauK7ryo/EExsbPItr0
         zUgS5X3CU9LrsXcok9xij+h7iqrL1fF2Y3uffLAkrPlB54PbTFXSIJD57C+PcUTrthQf
         NXAdrq62zv2MtaPUq+9Z4cko5ZY2PabBUCFKzzpUDr2V1QQooBxT9yokq3EKwo+w8z8q
         dFyck3olDc0/NhTmK+E6qGJXcPc96IrnpEw7cWKAbh0zmpdONGaD5aawdZhh10/pqDDG
         1DUg==
X-Gm-Message-State: APjAAAUx0J/P+ItA27SCLGwiCJIEpbyOrbHbTO3cwYaqomohNGUxfIEK
        v8NhOm86KjE+xmGxDbdkqZpEH0s=
X-Google-Smtp-Source: APXvYqyFxOxYQ67UvP3oT4a6QlvXzPKBxO+TGpvCE3BuhjhqfW2WM1GR+PmaoqJFc002MDt4vtWnjns=
X-Received: by 2002:a65:56c1:: with SMTP id w1mr104359426pgs.395.1564437073710;
 Mon, 29 Jul 2019 14:51:13 -0700 (PDT)
Date:   Mon, 29 Jul 2019 14:51:09 -0700
Message-Id: <20190729215111.209219-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.709.g102302147b-goog
Subject: [PATCH bpf-next 0/2] bpf: allocate extra memory for setsockopt hook buffer
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Current setsockopt hook is limited to the size of the buffer that
user had supplied. Since we always allocate memory and copy the value
into kernel space, allocate just a little bit more in case BPF
program needs to override input data with a larger value.

The canonical example is TCP_CONGESTION socket option where
input buffer is a string and if user calls it with a short string,
BPF program has no way of extending it.

The tests are extended with TCP_CONGESTION use case.

Stanislav Fomichev (2):
  bpf: always allocate at least 16 bytes for setsockopt hook
  selftests/bpf: extend sockopt_sk selftest with TCP_CONGESTION use case

 kernel/bpf/cgroup.c                           | 17 ++++++++++---
 .../testing/selftests/bpf/progs/sockopt_sk.c  | 22 ++++++++++++++++
 tools/testing/selftests/bpf/test_sockopt_sk.c | 25 +++++++++++++++++++
 3 files changed, 60 insertions(+), 4 deletions(-)

-- 
2.22.0.709.g102302147b-goog
