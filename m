Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3074A7A0D
	for <lists+bpf@lfdr.de>; Wed,  2 Feb 2022 22:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiBBVNd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Feb 2022 16:13:33 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:56031 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiBBVNd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Feb 2022 16:13:33 -0500
Received: by mail-wm1-f50.google.com with SMTP id r7so297708wmq.5;
        Wed, 02 Feb 2022 13:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oaJCammhcYshGlWjPLBKRiVK+htd4TpvchdOh6MhZWs=;
        b=N0wTJJhBZUkOEzvXrq+x4PXHZIFKECf0a/bnuM5QnVf0FM39ZnMV1FD4BTsEhehtSe
         FFccnH4ZpbFOGce9CwPHxkytPtdLw3cYtp9TTHF5yTBlZ2kd11s5ovF9kpaZtAOiTsFp
         6qMPbiMXFoZhL4PnNHZgCEMHxs1ljQ+T3yZEXAxEhRS8a5jIWe43psYiuzcd2MYJdXVr
         fwkOUNU4q3I2tXqernEKEoP6/ZX1R2WbBSoJh0XeIaHRhxGIO5+PY53O76piK6vlV8PM
         YTQeD2uluFeOjfirpN+jJVRRMc6XqVb0OMKOwmTsRSzqWsMqL3JupLizJXY+rnsdUjWl
         EyTA==
X-Gm-Message-State: AOAM5337829lz7qyWNba0hpXwKmCA01zeJtvYzq3IJqsJhRRovRu4KtL
        IIyAooqqloPgiH0R32+GMo4=
X-Google-Smtp-Source: ABdhPJzkrInO/l1EiTNnYJrpeeRkAjcl+VuBaFvgkUKdY0HTVIDjgXFwpx0I9OoQiXIBknmjeWxavQ==
X-Received: by 2002:a1c:a9d7:: with SMTP id s206mr7602777wme.38.1643836411557;
        Wed, 02 Feb 2022 13:13:31 -0800 (PST)
Received: from t490s.teknoraver.net (net-2-35-22-35.cust.vodafonedsl.it. [2.35.22.35])
        by smtp.gmail.com with ESMTPSA id f5sm13914322wry.64.2022.02.02.13.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 13:13:31 -0800 (PST)
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf@vger.kernel.org
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 0/2] limit bpf_core_types_are_compat recursion
Date:   Wed,  2 Feb 2022 22:13:26 +0100
Message-Id: <20220202211328.176481-1-mcroce@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Matteo Croce <mcroce@microsoft.com>

As formerly discussed on the BPF mailing list:
https://lore.kernel.org/bpf/CAADnVQJDax2j0-7uyqdqFEnpB57om_z+Cqmi1O2QyLpHqkVKwA@mail.gmail.com/

Matteo Croce (2):
  bpf: limit bpf_core_types_are_compat() recursion
  selftests/bpf: test maximum recursion depth for
    bpf_core_types_are_compat()

 include/linux/btf.h                           |   5 +
 kernel/bpf/btf.c                              | 105 +++++++++++++++++-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   3 +
 tools/testing/selftests/bpf/progs/core_kern.c |  14 +++
 4 files changed, 126 insertions(+), 1 deletion(-)

-- 
2.34.1

