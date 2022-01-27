Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20B4949E8E3
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 18:24:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237319AbiA0RYw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 12:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbiA0RYv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 12:24:51 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6BFC06173B
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 09:24:51 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id w11so6090328wra.4
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 09:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fK+oJcKgMcWWWrq9i21ZgzQKrYXc3WUerqyecUfwfNk=;
        b=jr16Oeqj4M6JLMyVsipYEVvVIvded5FfOcE157uvxzOGZxzmRP7rqcBG3dDr81ekz/
         sHAlPRKtfRvcgblGgpNm673V9YLy7Dw/ENUP7bnqdidi9Fz8GU+jrCqTs2PeSinI/32f
         lDca0Au5N4jWSqWgGXlsQsXFG6aSgywaF6gXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fK+oJcKgMcWWWrq9i21ZgzQKrYXc3WUerqyecUfwfNk=;
        b=XlvMYtZxJsTtsA2KuupIiDZAcEg24FOnJD07T2RppNMPGrJ1QxGXCRYSA6fhWHJC+z
         meYcvJ1bNKIv/J8Fk0PsJo6nNsJdQ9z3+KToW46SjylwzyHXYo+/pQiyFl6GyBKdV1/0
         gVswmwy89XSjcX2Gawn39c+zURO3bzyNECpNecSVyCHAXJeDnzYJT69SAFuebHFrzbCJ
         rsLovk69hhrrzK5pUOmAEP9kFt5FTJvCMnb78xvBc7oDoXF1E9xIYbAjq8cPwmVmBxXC
         1W2VxNrHTYS+0xjbJ5/sDYoGJMzWUzJ8zlVKdA93t3BOYWTh1FtgzXQyJofQ6VTe1Yl3
         cYDQ==
X-Gm-Message-State: AOAM532nteYv611Qo6KBK7LRx+Xlb2NpAodjt6oDA6y93izURYUtIIhr
        2fjFH7L+K0HuaMUi4XUbYS3p2ow32dX2LQ==
X-Google-Smtp-Source: ABdhPJz8mf34rI88UHVzNtKZTD75FOr4XOkhBAJyijwbCDSNNj+qrw51eCzG4JGmZAxB3m/KbIwXoA==
X-Received: by 2002:a5d:6d05:: with SMTP id e5mr3779678wrq.398.1643304289766;
        Thu, 27 Jan 2022 09:24:49 -0800 (PST)
Received: from cloudflare.com ([2a01:110f:4809:d800::e00])
        by smtp.gmail.com with ESMTPSA id az16sm2420578wmb.15.2022.01.27.09.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 09:24:49 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Menglong Dong <imagedong@tencent.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 0/2] Split bpf_sock dst_port field
Date:   Thu, 27 Jan 2022 18:24:46 +0100
Message-Id: <20220127172448.155686-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This is a follow-up to discussion around the idea of making dst_port in struct
bpf_sock a 16-bit field that happened in [1]. I have fleshed it out further:

v1:
- keep dst_field offset unchanged to prevent existing BPF program breakage
  (Martin)
- allow 8-bit loads from dst_port[0] and [1]
- add test coverage for the verifier and the context access converter

[1] https://lore.kernel.org/bpf/87sftbobys.fsf@cloudflare.com/

Jakub Sitnicki (2):
  bpf: Make dst_port field in struct bpf_sock 16-bit wide
  selftests/bpf: Extend verifier and bpf_sock tests for dst_port loads

 include/uapi/linux/bpf.h                      |  3 +-
 net/core/filter.c                             |  9 ++-
 tools/include/uapi/linux/bpf.h                |  3 +-
 .../selftests/bpf/prog_tests/sock_fields.c    | 58 +++++++++----
 .../selftests/bpf/progs/test_sock_fields.c    | 41 ++++++++++
 tools/testing/selftests/bpf/verifier/sock.c   | 81 ++++++++++++++++++-
 6 files changed, 172 insertions(+), 23 deletions(-)

-- 
2.31.1

