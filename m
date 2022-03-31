Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E394EE223
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 21:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234606AbiCaTzX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 15:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbiCaTzU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 15:55:20 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B36345AFE
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:53:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s13so1188925ljd.5
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 12:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=3Fe2GvTNlN5Neu/WOj5NCag4gg9rlxwhKIJcxl6fHb4=;
        b=C6xp4utFX6+9w0/Yo9Q8mC+GGLDWKzWlzon0wXIFIt6cjYHeLeA4JoXFcczUfpSe4t
         YSibu6TKSwO2MqpU1THDQ0dO1LC3cd5+ojrbiLyBzBxAX6gi/JPed+Xd0xETmmPxEZxB
         FzJTskB9o9kC7b9yjNtNwckNNKvsWW6Nd/WLv6s4WEDBABIRbd2QsDF7cav3J0paNogf
         0Cw+ms2OGRGZuYMru5b+7KV6Us1tWcr9Z7krVVOgRiC6+y+iTooalSuQx1m6CNmSHFii
         nRRjFf7Lc82Yv/fdRq+Is2HLPM598W06W2RMDBhLovkVkPBoHD51jcfZ9S8oLLqmSJqe
         90ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3Fe2GvTNlN5Neu/WOj5NCag4gg9rlxwhKIJcxl6fHb4=;
        b=cVUF15RX38ntRk6zprayisyqr2GYYREeS0yNLnv6ALCZ3PiyKWlMG2W+eAjrCmYi5a
         +UpDgbL0bas0f0B9xLWuU1yt7+lKk0p6saWSydf/UjpY8r9V1YUbhEYDL0GeHceUmwMg
         74e9cQ2DvWVQjfCegyuKz0q/FtYhSPFX8qyC9YS96qzcIYUIRMBomVcEmQZTax+zrB3G
         C1vW/nBhRGg/MLKIAeRXhbEpzMitFg5BK+6FZJRGCkKAuzdoYfF10BhpoM9HNyTgEmQw
         WIuaekjdZCslLNOhES70Ve2jMYHJ6+bijYwHHqzcTvYN+NfIOABlfV7EXR8cAwcqnVSQ
         XDgg==
X-Gm-Message-State: AOAM532l4IVJWH7SnRT41jUhg67Vt91340FjugGooaSo6aIDhldAVO38
        vryW5q81ZA1kBMDmzxi4HzuarQsUP0Fs4GYuYvI9SYbcs5A=
X-Google-Smtp-Source: ABdhPJzIGhrOBzm+A8NP1MQaekgE3izsOFsnEMeMk6+rz6r090YUY0I9hRLl6RT9xTIyr8qGr+mI5uuQT1vQZf+TCM0=
X-Received: by 2002:a2e:a707:0:b0:24a:fdc3:5ba1 with SMTP id
 s7-20020a2ea707000000b0024afdc35ba1mr1595256lje.393.1648756409508; Thu, 31
 Mar 2022 12:53:29 -0700 (PDT)
MIME-Version: 1.0
From:   Grant Seltzer Richman <grantseltzer@gmail.com>
Date:   Thu, 31 Mar 2022 15:53:18 -0400
Message-ID: <CAO658oVD+0Ltuww1F-AZdPtSE4O4M-BH5NP_R-oSBWszZ3oZiQ@mail.gmail.com>
Subject: Questions on BPF_PROG_TYPE_TRACING & fentry/fexit
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi there,

I'm looking to implement programs of type BPF_PROG_TYPE_TRACING to
replace kprobe/tracepoints because from what I can tell there's less
performance overhead. However, I'm trying to understand restrictions
and use cases.

I see that there's a generic `bpf_program__attach()` which can be used
to attach programs and it will attempt to auto-detect type and attach
them accordingly.

In practice, I'm curious what I can attach programs of this type to,
and how are they specified? `bpf_program__attach()` doesn't take any
parameters outside of the program itself. Does it attach based on the
name of the program's name/section? If so, is there an idiomatic way
of making sure this is correctly done?

My follow up question is to ask how fentry/fexit relate. I've seen
these referred to as program types but in code they appear as attach
types, not program types. Can someone clarify?

As always I'm partly asking so that I can document this and avoid
other people having the same confusion :-)

Thank you very much!
Grant
