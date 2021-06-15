Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB08A3A8C84
	for <lists+bpf@lfdr.de>; Wed, 16 Jun 2021 01:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhFOXcW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 19:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbhFOXcU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Jun 2021 19:32:20 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C92CC061574;
        Tue, 15 Jun 2021 16:30:15 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id t8so246989ybt.10;
        Tue, 15 Jun 2021 16:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=lrNuChciOT1m4Cxcoui/LhFfctlKythbyRrQh5z2mbE=;
        b=bDvq7IfMbWYNuleCjIA4lWoaCodbP/05wErrBm3s0LseDpTY7hVSU3/DOkAmi/xm9f
         NXPfHBhyilJtzKEVtnnMwUGohAdpGnQwqdYU0HAIOBT2VuTmKp9YcHtLKgv8K7R11Os5
         MfwfIKJCXeExVNCa3vTlZ1QgIipDY6QKMcyrma/1LhZ1X0VBVcWEYu77RukIa+OogkJ1
         DUIxeDpBE6H4pn4TYM3+UtgYFTkYDC06re86EPQfSo9OcUhISLQ+LmXVZqePRrbpKt++
         sMGfT1yYAklt5DuBS0S9d00aVDM5HPeSS3/pHvwJgKnv76OWoTooQHYT5GS7GTadU/nY
         WXvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=lrNuChciOT1m4Cxcoui/LhFfctlKythbyRrQh5z2mbE=;
        b=W0qEnZbr/bdBe8R3QTfKRwRizJx+8fDuDvehuncLiu0gGpSXVFOwjwLnG8/Fas6m78
         Ve4gDRGFxVV8w2SjENX6XseVXOkf4Ius7VBAJbA99Xx3nJQf1gdGcpgxLV4D8eSBe3Mn
         3rjTpMh4uCO81jZVTmAOtiOp6OLlLSaXp1UdiM4ghQsiqCg8ukm4wsGIwmtQ/rPffpE4
         aKi8Bc5XQ8o6gGcF1tp2g22tz9pZg/qK7J/Y5BKLWVsKGYHySw+9rfUPYmt/hGgXQpbN
         3Gn9/nl+udkgBQl+cqmPrgi+nNPqHsWS14w4QK0JN0AXZMOE2h+IGBpqvEAWCKABh4Gd
         D+pw==
X-Gm-Message-State: AOAM530G5MvA1kl9tN88UCuaJQqH3KqXc+mJ4r8EeRj7u6D6/g7N0cWC
        IizxFLFlHpteU09Sc07/J+n1lBnliDCLTpgAMkc1T2QL+oZIJw==
X-Google-Smtp-Source: ABdhPJwLRWFpQ86AvbMesovS7NROr/kJQOgojlOcmVZJ6ZwczvXeBBpecT1ZXWz1AD/jMgn5VW6tQECoPyBhb6b1034=
X-Received: by 2002:a25:7246:: with SMTP id n67mr2242758ybc.510.1623799814611;
 Tue, 15 Jun 2021 16:30:14 -0700 (PDT)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 15 Jun 2021 16:30:03 -0700
Message-ID: <CAEf4BzZnZN2mt4+5F-00ggO9YHWrL3Jru_u3Qt2JJ+SMkHwg+w@mail.gmail.com>
Subject: latest pahole breaks libbpf CI and let's talk about staging
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org
Cc:     siudin@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey Arnaldo,

Seems like de3a7f912559 ("btf_encoder: Reduce the size of encode_cu()
by moving function encoding to separate method") break two selftests
in libbpf CI (see [0]). Please take a look. I suspect some bad BTF,
because both tests rely on kernel BTF info.

You've previously asked about staging pahole changes. Did you make up
your mind about branch names and the process overall? Seems like a
good chance to bring this up ;-P

  [0] https://travis-ci.com/github/libbpf/libbpf/jobs/514329152

-- Andrii
