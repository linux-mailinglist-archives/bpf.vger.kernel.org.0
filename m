Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7641F14489C
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 00:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgAUX5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jan 2020 18:57:00 -0500
Received: from mail-qt1-f176.google.com ([209.85.160.176]:33382 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgAUX5A (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jan 2020 18:57:00 -0500
Received: by mail-qt1-f176.google.com with SMTP id d5so4262912qto.0
        for <bpf@vger.kernel.org>; Tue, 21 Jan 2020 15:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=C7ec4ISisBCmycKNgZR5SkMgE5nr16XsORF/ICf7iq8=;
        b=k47YnmjmZRz1wI28ErxaVSA3aduOS5TKfFcHS0np5VymxnObkv7tIdAWNpvKEyKyca
         KE65hRWdyuy85vuALK79+Z7cOJmRJWamDE2GqHQI9Vp4+VKXn0QQ18IkWR7/qm/vk4yA
         bfQJT1tsqD4kHLHokU0ywRwGzWg6WEram5wXvHmJOJwxiCJ1KCfq9xDnN6GjfGMV79dV
         EirmuAyHQOadu9BddCIJ9ZUIbdr28D5I1fZOrpP1WtPkpA++6OCr2qPPE4+vTMo8b/Xk
         u4SaCOsyaDrEs83EoTWimPo5nFV66Sx30iZDw6LDYiWrU5e3mfx7t5PguU9dmW5Rku33
         1BrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=C7ec4ISisBCmycKNgZR5SkMgE5nr16XsORF/ICf7iq8=;
        b=JCktXHdoE5FVczmfaqo45BPyDX/2Fb99SxWd9YaVCSmbx8p8E1y1IljFwp83UkTSIU
         TTXlg7Xa8TQc1pfpYnEMMN/RRwqKTTD3aaCeE/yePpL0jI+KIYdqF2PLnvclLbhfqFC1
         rwVnuwlgkfNttj83h3z3gPFkI8kbN0F1xCS8JAK0bXIefCW4MerNF4si7CWcKlWJr8B+
         PDC6TXu1iw8SOMUawMX3NREqZ6qXm5gAULZfMmRxysUVRMGgB/xbtRwlYrSsgcV1dII8
         cQ09ygiVdrqyppfSjVKr6ssvYWKgYPLf4YYK5yZ0Bhxo9fTMJ2gEsdrY+xlwDte9v12O
         sBrg==
X-Gm-Message-State: APjAAAUPQN7Ub/VWE8WI62o7FbhuACymAJxOKaqgwIkhDDOSQhNbqeze
        3MfUZeA+4SXInsT5YsgfbzHTahPMlDOWmy1IFN8=
X-Google-Smtp-Source: APXvYqx4n29MDbCApbL0K4xUgfeAf4WLcMkaVlR4klnR1mEchJcurKEdv0CuCvqMImWngpGaB/GJAe1UjZ90kOvc+bo=
X-Received: by 2002:ac8:7b29:: with SMTP id l9mr7113127qtu.141.1579651019734;
 Tue, 21 Jan 2020 15:56:59 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 21 Jan 2020 15:56:49 -0800
Message-ID: <CAEf4BzbWvCaAU5_t7k+fUiPyHgtxJnTfuC2QaAQCxf5YcZ8Bhw@mail.gmail.com>
Subject: Re-thinking BPF logging
To:     lsf-pc@lists.linux-foundation.org
Cc:     bpf <bpf@vger.kernel.org>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Re-thinking BPF logging
=======================

BPF historically had a very restricted logging capabilities through
bpf_printk macro. It's almost never used in production due to its
limitations and because of how heavy-weight it is. BPF developers
would just sprinkle few logging statements here and there while
debugging issue, and will immediately remove them once they are done.
But real-world production BPF applications need easy-to-use and
flexible logging capabilities, both for debugging at scale in
production, as well as for ad-hoc local development needs. Its hard to
anticipate what needs to be logged in case of production issue, so
logging has to be shipped with production version of BPF application,
but enabled whenever issue arises. BPF needs to re-think its logging
approach to satisfy real-world needs: zero-overhead when disabled,
low-overhead and reliable while turned on. All this without
sacrificing code clarity and developer productivity. We pose that with
all the recent BPF advancements (BTF, global variables, BPF text
poking, etc), it's now possible to have a qualitatively different
logging capabilities in a modern BPF application.

-- Andrii
