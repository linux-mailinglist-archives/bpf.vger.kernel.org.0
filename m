Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F57E334ADC
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 23:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233764AbhCJWCm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 17:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbhCJWC3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 17:02:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F23EC061756
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a18so25009048wrc.13
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 14:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfVu4rgHClGk+8SIjkOcz2mDzeC9JP6hk5DHUIIUQrg=;
        b=hz2+fCxPAmSw5xiUIHLElrNRlQWd6rjSlCoNRPMHK4OJHfQAdBK2m+ZfllvSf/vLCQ
         Vc8k9Eesy786WaBQRzzgWwqAXqdYypfnxAQGWNeXOhNiH9QHavMnvPSXoixIZTicIMAm
         QU3sZ0RHWC9NeNIBBSJF2brN2UH8zOfsM8V6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VfVu4rgHClGk+8SIjkOcz2mDzeC9JP6hk5DHUIIUQrg=;
        b=hvaG9HYSpINbfNQJA5BkecbuRzXryYMxGsPRhSdO7Uo9MVkeCRDFF+hK85KR0A54md
         p2HiXFQ2444fu+HSN2HWQrLBRVHpJJPBkNJj8ciWxAbBFxKlqXG6Nn4x7k4Ur5PYg0zE
         BA2IKaaC4QEp1k1Hb6TX9AZLXzkLfb31YVVo//D8+Fg0EYfX+lAwUtcfZeWB2EH99CfC
         +SVz75oBiK+eQPbrJbLG7Sglb8FC3Y0aNy7aVtS3UdpHZ5R25JdUQrNTcgt4jultriSw
         UC0i/whCgxEVJ24aIhbkr4qQQcmKmSBbYJmU/X/obAiIw7n388OpKMBvSTmZEzJmk4a/
         qRbA==
X-Gm-Message-State: AOAM533gm9aXN1SWgTjIxJ91eh62Ar+Th8OS/2SsHQRmkd5Au1tWxjIh
        YftzVbEs8v2Zr9TmppctWYA67se2KoGQfg==
X-Google-Smtp-Source: ABdhPJzxL8IVcjAp8x6e2r85HgQOwpHHsvW/wLcSOWALF0m4Pwpobaon8H/CcjdC5Jb4H5bzNQSY+A==
X-Received: by 2002:a5d:58ce:: with SMTP id o14mr306939wrf.4.1615413746955;
        Wed, 10 Mar 2021 14:02:26 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:e08c:1e90:4e6b:365a])
        by smtp.gmail.com with ESMTPSA id y16sm699234wrh.3.2021.03.10.14.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 14:02:26 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        yhs@fb.com, kpsingh@kernel.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@chromium.org>
Subject: [PATCH bpf-next 0/5] Add a snprintf eBPF helper
Date:   Wed, 10 Mar 2021 23:02:06 +0100
Message-Id: <20210310220211.1454516-1-revest@chromium.org>
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

We have a usecase where we want to audit symbol names (if available) in
callback registration hooks. (ex: fentry/nf_register_net_hook)

A few months back, I proposed a bpf_kallsyms_lookup series but it was
decided in the reviews that a more generic helper, bpf_snprintf, would
be more useful.

This series implements the helper according to the feedback received in
https://lore.kernel.org/bpf/20201126165748.1748417-1-revest@google.com/T/#u

- A new arg type guarantees the NULL-termination of string arguments and
  lets us pass format strings in only one arg
- A new helper is implemented using that guarantee. Because the format
  string is known at verification time, the format string validation is
  done by the verifier
- To implement a series of tests for bpf_snprintf, the logic for
  marshalling variadic args in a fixed-size array is reworked as per:
https://lore.kernel.org/bpf/20210310015455.1095207-1-revest@chromium.org/T/#u

Florent Revest (5):
  bpf: Add a ARG_PTR_TO_CONST_STR argument type
  bpf: Add a bpf_snprintf helper
  libbpf: Initialize the bpf_seq_printf parameters array field by field
  libbpf: Introduce a BPF_SNPRINTF helper macro
  selftests/bpf: Add a series of tests for bpf_snprintf

 include/linux/bpf.h                           |   5 +
 include/uapi/linux/bpf.h                      |  28 +++
 kernel/bpf/verifier.c                         | 178 ++++++++++++++++++
 kernel/trace/bpf_trace.c                      | 110 +++++++++++
 tools/include/uapi/linux/bpf.h                |  28 +++
 tools/lib/bpf/bpf_tracing.h                   |  45 ++++-
 .../selftests/bpf/prog_tests/snprintf.c       |  71 +++++++
 .../selftests/bpf/progs/test_snprintf.c       |  71 +++++++
 8 files changed, 535 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/snprintf.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_snprintf.c

-- 
2.30.1.766.gb4fecdf3b7-goog

