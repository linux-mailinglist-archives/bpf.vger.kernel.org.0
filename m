Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0BF6CE900
	for <lists+bpf@lfdr.de>; Mon,  7 Oct 2019 18:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJGQVH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Oct 2019 12:21:07 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:42300 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727791AbfJGQVG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Oct 2019 12:21:06 -0400
Received: by mail-pf1-f201.google.com with SMTP id w16so11459571pfj.9
        for <bpf@vger.kernel.org>; Mon, 07 Oct 2019 09:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NkXuW1G1iXWE4slUD0lSJkWLL+y2RHcYC+ZyAyzgowE=;
        b=dWS2TgaTt0Bv8xsCtF16fYZk/AHXazeKxyr28dQI7CAR0eDZp8nQkvZRw0fLhZxN81
         TTnOrwluDfNXyaKPGxlXqnErp9TW+nTp4OW94Qvim8xVmJ35KAsx6MZw9xO1tnbnjB1A
         Q54OKZMq9gKvGPxRJhiAXjIQRy0mMfjytg/gg87kVHP11cW11PwrCBMrZ5GX3vFFJi1v
         nHhIGZxOnUseXX0cxvlwbEJ+5w7d1iZDaJVIPhqpPjsTILl04C6ryjPeVH5+mtppJTYK
         j5dWuZKJqJBA8Qeh1kOSnkC+R0i6IboJolOHrTvt8MztQlFdOWwR6Yh3X9TjR9i0ozWv
         fFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NkXuW1G1iXWE4slUD0lSJkWLL+y2RHcYC+ZyAyzgowE=;
        b=gn2/qykySRV+DCG36YxqTxstnp3y5dj1xe3OhFbwhc6GjOzydd96eSa4pdEi/foJcJ
         SI9S/VmUoYnxp35OO281p18b/6qu6BIKXm7jCjspYoU7lq+sAbkMNXUdyHfql6o9bXkv
         pI9uUQ2KrROIa9v3GG8ApFZykGm+H15MSpjSZipDop2/sNnCoH3SVZgDr4WWb8hJKuU9
         huJzj5hrnIInPj8LNpJiYmD4VFLtYyCYJGikFHbekH5CboeRs73M6oOnLesB6lstMye7
         0LBOlycXGlYc+ysV53mKCtIMwq1Gk90nX8TY42o+0ZSIZGym+mHg22cpHkghL9drI1eG
         jQQw==
X-Gm-Message-State: APjAAAWz/2sjKqdBV0GG59gpEJOA+aYsmkxrxTjevzqhxt5m1X+zWAqx
        O1oheRuNIfPdXQWacJw4wNxv838=
X-Google-Smtp-Source: APXvYqwQrOzjU1ODhjUSN59JxfcztN4xSdIwPfJC+gPtVfw15vRe7FXV4Zo/Sh8sA4ZXmWKm/z2NhvM=
X-Received: by 2002:a63:9149:: with SMTP id l70mr11107825pge.154.1570465265892;
 Mon, 07 Oct 2019 09:21:05 -0700 (PDT)
Date:   Mon,  7 Oct 2019 09:21:01 -0700
Message-Id: <20191007162103.39395-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH bpf-next v3 0/2] bpf/flow_dissector: add mode to enforce
 global BPF flow dissector
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

While having a per-net-ns flow dissector programs is convenient for
testing, security-wise it's better to have only one vetted global
flow dissector implementation.

Let's have a convention that when BPF flow dissector is installed
in the root namespace, child namespaces can't override it.

The intended use-case is to attach global BPF flow dissector
early from the init scripts/systemd. Attaching global dissector
is prohibited if some non-root namespace already has flow dissector
attached. Also, attaching to non-root namespace is prohibited
when there is flow dissector attached to the root namespace.

v3:
* drop extra check and empty line (Andrii Nakryiko)

v2:
* EPERM -> EEXIST (Song Liu)
* Make sure we don't have dissector attached to non-root namespaces
  when attaching the global one (Andrii Nakryiko)

Cc: Petar Penkov <ppenkov@google.com>

Stanislav Fomichev (2):
  bpf/flow_dissector: add mode to enforce global BPF flow dissector
  selftests/bpf: add test for BPF flow dissector in the root namespace

 Documentation/bpf/prog_flow_dissector.rst     |  3 ++
 net/core/flow_dissector.c                     | 38 +++++++++++++--
 .../selftests/bpf/test_flow_dissector.sh      | 48 ++++++++++++++++---
 3 files changed, 79 insertions(+), 10 deletions(-)

-- 
2.23.0.581.g78d2f28ef7-goog
