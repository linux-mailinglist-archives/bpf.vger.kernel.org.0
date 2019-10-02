Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400E1C9001
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 19:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfJBReD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 13:34:03 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:45761 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727751AbfJBReD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 13:34:03 -0400
Received: by mail-qk1-f202.google.com with SMTP id s14so19165512qkg.12
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=LCLLRHRqh5eDd/+AOwIrEOhvR2+XuRvYX6if88062Ec=;
        b=XfhIFnWgdn/7czF/MbMf9RFlAwx6xltTqS+edMHXHHwuOLs+nwCLXZrvFk6PjnE2j/
         UkJNv6mSHILbrycrOEgfat+Jphl+qK39Nl4MaldlUiqPJ7w/YfuSIez8FVW2j6iNUtm1
         VpPJViIiCDIhUoEBnXY1pKcCvyXE/YR47tncZpCVeMjPQ5GWQipX+3Kt2hl7QtU9qn07
         YWXHiCo+/yT8mH8ZWAWAlScbhr7SdwRtBuajpdG4DAs/l8+KkJ3U4Zes3aHrvvF0gRWD
         X/xhmqBTM6O6Q09gqj34cl367cexQsL8jvQs29G5En3+/P1zpYeAwDnj/YI6gze7qdbA
         kxgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=LCLLRHRqh5eDd/+AOwIrEOhvR2+XuRvYX6if88062Ec=;
        b=Bwwd2DQc65r3w6GKyZNq43SosWirYDmvFnwpwLyR3wlJLDmNzy/pcSiZt2EoLGqr0x
         crHSVIL5vMaPHExiWgiZsh5xBMa/1OV96nH3WytvpT/c+XGTSIyOGNZCXiRynbBeyRik
         VVIag2iYDttQHv2333z6/IRyfuxoUnykbmMPOPR5NtylOylt4TxHq2oGoICN0G06hFZG
         h9o4D0jOE7w9XK5ND3OHvXsD2K4TWdlsGMVzjUkhaKR4sbxCH56pq4MLl9N1Ud+uuNYz
         kGMnKLMksb7H33aCB/IlJmZ61NbO1kn9h4gSR5oW+KUN10z3R7EEtIRwDQz50qDYjvqR
         AH4Q==
X-Gm-Message-State: APjAAAXuPmo/Wmla+4vHY4bmRohiDhlLHkEW/k2qcKtXDYMCCgsIRx4X
        qK7GMhcq0PuHKceGTVCvNrw7y7U=
X-Google-Smtp-Source: APXvYqwesAzQXb+pDDcFzHFZaa/1FLKUuQE5iCGv8xR9RwgCJq8EeN1ef/rTmL0AMcKF+f1k7Dbqc/M=
X-Received: by 2002:a05:6214:452:: with SMTP id cc18mr4124598qvb.41.1570037640285;
 Wed, 02 Oct 2019 10:34:00 -0700 (PDT)
Date:   Wed,  2 Oct 2019 10:33:55 -0700
Message-Id: <20191002173357.253643-1-sdf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH bpf-next 0/2] bpf/flow_dissector: add mode to enforce global
 BPF flow dissector
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

Note, that it's totally possible to attach flow_dissector programs
to several namespaces and then switch to a global one. In this case,
only the root one will trigger; users are still able to detach
flow_dissector programs from non-root namespaces.

Alternative solution might be something like a sysctl to enable
the global mode.

Cc: Petar Penkov <ppenkov@google.com>

Stanislav Fomichev (2):
  bpf/flow_dissector: add mode to enforce global BPF flow dissector
  selftests/bpf: add test for BPF flow dissector in the root namespace

 Documentation/bpf/prog_flow_dissector.rst     |  3 ++
 net/core/flow_dissector.c                     | 11 ++++-
 .../selftests/bpf/test_flow_dissector.sh      | 48 ++++++++++++++++---
 3 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.23.0.444.g18eeb5a265-goog
