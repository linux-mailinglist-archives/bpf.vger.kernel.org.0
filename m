Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B27EBC35
	for <lists+bpf@lfdr.de>; Fri,  1 Nov 2019 04:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727486AbfKADHN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Oct 2019 23:07:13 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38121 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbfKADHN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Oct 2019 23:07:13 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so8391059ljc.5
        for <bpf@vger.kernel.org>; Thu, 31 Oct 2019 20:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YjtUu+ZjBUpJQENL1NViWSeyjL7FzrnZoX2E0Dq1O0=;
        b=gk6PoWf6ZXUa6579VGeypvSp4C/K6mNANQBb4tcmQkX6dvtZSZ34TzwohmOP6ZKOTc
         yI2zVzM1p6A5omsx/w3LB/K8p7bHFBaIBapdzxh8ZQjSmhgZDdm9nQRNZ7s+LnrLKj7y
         K6VDH3NV+FnkRVRTTfXfj6JQMJykdHCALOx7GmhgLth14vV+BxmHHzdFvoCzKveVQoHF
         a1Y2P2JG3diLgCGQvJ7YAVDeEne5EwFbeA+hWYxq7yv4O0u8mtJCPAFzl2tvshSWc5xq
         LmV+glrUysJXth9xi+SuUpU5t2IDftsgo30B0GzaeEor4M72n5U0jdq0y37gjyDG2Npn
         dMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9YjtUu+ZjBUpJQENL1NViWSeyjL7FzrnZoX2E0Dq1O0=;
        b=l8c5V68uw6rVbQkYgvW7u5EuhZzuijP3UqCjL9lXt/Yvz6yP6YhscoiV2JGkeqeLO5
         oVntWNDXSnmbrQkoD3Aoxf84VK0maq/H5JqD8/ChByh32EwxOZaFZxacR0ldvmiJvhho
         1bTGcobjVVWi21Nkox0WMQTBroT6kPbetLJtoH1hLtNEdr0wfXXT4iNtHis+V6/W+4uc
         PtWmng/XUUltPTvUoY0EHcctIXiKzc1M5OjWqAos+Jo+bEgiNN79A5n8Z0b2yfdOX0V7
         cmlPmTT4ZmzhfHFbchabhKFxrebyyDAhKbTqV5r977lV1GEd5PEz5OKm05LWr5uDMvRU
         JN+Q==
X-Gm-Message-State: APjAAAX2n1IsZZuHO04ioK32foq14BBWIaxUpM8i3O2mNPAeN72z1bmS
        ubw5toKXb8V8Vi43FNZxByE4EQ==
X-Google-Smtp-Source: APXvYqxBgStPWBSoVB7roZSG+OwDwgB8iap4XvkdoTiqNOC9zDQxJ8xPS2ZnA0FZbY47bi/cZihz+w==
X-Received: by 2002:a2e:8694:: with SMTP id l20mr6374058lji.64.1572577630658;
        Thu, 31 Oct 2019 20:07:10 -0700 (PDT)
Received: from jkicinski-Precision-T1700.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id v6sm3926282ljd.15.2019.10.31.20.07.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2019 20:07:09 -0700 (PDT)
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     davem@davemloft.net
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: [PATCH net 0/3] fix BPF offload related bugs
Date:   Thu, 31 Oct 2019 20:06:57 -0700
Message-Id: <20191101030700.13080-1-jakub.kicinski@netronome.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

test_offload.py catches some recently added bugs.

First of a bug in test_offload.py itself after recent changes
to netdevsim is fixed.

Second patch fixes a bug in cls_bpf, and last one addresses
a problem with the recently added XDP installation optimization.

Jakub Kicinski (3):
  selftests: bpf: Skip write only files in debugfs
  net: cls_bpf: fix NULL deref on offload filter removal
  net: fix installing orphaned programs

 net/core/dev.c                              | 3 ++-
 net/sched/cls_bpf.c                         | 8 ++++++--
 tools/testing/selftests/bpf/test_offload.py | 5 +++++
 3 files changed, 13 insertions(+), 3 deletions(-)

-- 
2.23.0

