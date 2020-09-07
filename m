Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F1F25FFDB
	for <lists+bpf@lfdr.de>; Mon,  7 Sep 2020 18:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgIGQkb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Sep 2020 12:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbgIGQkY (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Sep 2020 12:40:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5AEC061573
        for <bpf@vger.kernel.org>; Mon,  7 Sep 2020 09:40:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so16467167wrt.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2020 09:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqofUc8zWEtfn+646yQyHV6NmB9WV8nndhuaIKpsu8o=;
        b=MAFjd/xVjC3AlDAISmhAVdSkBa+rK+WyPVh1o820TCdj1cOCjA6t7eKe9587gOc3gx
         LBLaH6MKeS36NI/3pBEFBWeeoNSkannYJDSZklk00H2npXEDiNOdLmHvgdSUO0hLaRyH
         fG5QtcW0vHAirk+PC/g1IDR6sYBgnLm2yG9wvY7+rqwsM+prGYgEhRmzwsFRMm/Oatqy
         q3cXIRk2uzVPso+wHckUGzY62tV1Ja101lhjQMa+ORlW5tL+xw0Pch0aQYuH+bggwej0
         r/6XJVWJQZGNNrsU+HFLgtkdqjE6ThF6MAsTUo4ssjB1VI+lu3KIRJbNWWEfJPX/Fdv9
         cXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sqofUc8zWEtfn+646yQyHV6NmB9WV8nndhuaIKpsu8o=;
        b=nwapOjaOjbrbe1RRdhvZI40TvtlHX1If3wbph6QFJvKgv4YzxInvDr0QuRO3/XVT33
         MwCkOX9CUeDMMB5+oXxub5fMVXgbs1sd0eE1LZ4m84hnub4wi5u1ghmemDZKvyOdaFG9
         DVqVgrTUqPESRA3y/Z9WcvbXym1QJWJCNAMJGNXT2sDQ6fYvSL6q3E2iggyLgK9th30d
         RZBC8UqfCN9FTDt8P0PVxZzkHI9G9Vhxf/TbUeJHRfz1kwsGbmgSB9VEWyiaOHWxlm4C
         vFttbusTE7xyMsHtpVs4WtqqupBMO1894hV3KibG5T0l5bvm1JxomrZJcCO8PL0qd7tQ
         e2Gg==
X-Gm-Message-State: AOAM5306U8Dq+CUqKBMTD3NVUWJGt+krDmXQVBTGY+E+tjoYehZRkh5P
        RjKCsUSIRY7PB2K6o/1aWi3FCA==
X-Google-Smtp-Source: ABdhPJzSahTn/UmHXn1MKEztfjpMjfbbGbaZ8uNP+BEZwggJO7Oa4j76uEzfEKzYvr8E0X+GVwHHfg==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr22097344wrs.274.1599496820813;
        Mon, 07 Sep 2020 09:40:20 -0700 (PDT)
Received: from localhost.localdomain ([194.35.119.187])
        by smtp.gmail.com with ESMTPSA id d2sm9934895wro.34.2020.09.07.09.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 09:40:20 -0700 (PDT)
From:   Quentin Monnet <quentin@isovalent.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf@vger.kernel.org, netdev@vger.kernel.org,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>
Subject: [PATCH bpf-next 0/2] bpf: detect build errors for man pages for bpftool and eBPF helpers
Date:   Mon,  7 Sep 2020 17:40:15 +0100
Message-Id: <20200907164017.30644-1-quentin@isovalent.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This set aims at improving the checks for building bpftool's documentation
(including the man page for eBPF helper functions). The first patch lowers
the log-level from rst2man and fix the reported informational messages. The
second one extends the script used to build bpftool in the eBPF selftests,
so that we also check a documentation build.

This is after a suggestion from Andrii Nakryiko.

Quentin Monnet (2):
  tools: bpftool: log info-level messages when building bpftool man
    pages
  selftests, bpftool: add bpftool (and eBPF helpers) documentation build

 tools/bpf/bpftool/Documentation/Makefile      |  2 +-
 .../bpf/bpftool/Documentation/bpftool-btf.rst |  3 +++
 .../bpf/bpftool/Documentation/bpftool-gen.rst |  4 ++++
 .../bpf/bpftool/Documentation/bpftool-map.rst |  3 +++
 .../selftests/bpf/test_bpftool_build.sh       | 23 +++++++++++++++++++
 5 files changed, 34 insertions(+), 1 deletion(-)

-- 
2.25.1

