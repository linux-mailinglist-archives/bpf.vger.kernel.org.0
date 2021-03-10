Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB27334A3E
	for <lists+bpf@lfdr.de>; Wed, 10 Mar 2021 23:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhCJV5y (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Mar 2021 16:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbhCJV5Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Mar 2021 16:57:25 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBC5C061574
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 13:57:25 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id f145so3100786ybg.11
        for <bpf@vger.kernel.org>; Wed, 10 Mar 2021 13:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0LLAvLEt4Q/flZodga2OrYjGrK/Uqk3nAiMer6vSAug=;
        b=bcVpxEBUs64nD0dbp/HHMiiAth2SF4KK9MHLxBqadkNzlNoW0kiAEEdYh+LNXvDqai
         dvH6MiTS+/pPlcu0OlYXT4yxX3fiYCTGFo/1qaQUR09TZo+bH62AkPKUQ2XOGlMGekDM
         pyHnOiL1r3fnJLRKGLIldci3jwdNgogcv7+XnsWWBviT96c0wEQ9S7wswgwc6KZ5DCnP
         n6hI9jhaOz9f6F1+pRLVvqgWfLynzT5nCUXbn6s2OIQ0rKo2wB3oCnEDsyqjh3AepVL8
         qZPLKL2bRtBBSxqYWc2bvxtX48TAunERX1EG3fVxbSAGPX6TCEe55LBhczzD0fMRHICF
         AVXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0LLAvLEt4Q/flZodga2OrYjGrK/Uqk3nAiMer6vSAug=;
        b=TfTIvIiP/Dv2+djrCH6diNFkRKFwcuvPaO7tHZwuNdt2bsb+G01I11h+KrGUPzI2GN
         SgcaT/hy9W8tnMwzfUDCBF12C6U2kcdSkLC8f3UMC7Er0rFd2/8fblLXkGDu58vKTSRj
         +2PEoTyzOYM1wiMUebR1PV9MTPa4i0OOzh5WBHGxONDlTzFSHSKzu9KE93zx9cNio9uv
         f3EfurpFzNL5j6OZ5N3IUtZTUggYEoYvbMSwMx5/BZ50r6ROpKaKzRCqjTS6XPyCm8SA
         akDFXpfa53JVPvC5iJqL1hkFs5pbDNCBudnBccboyAL4VIUAoBxbkiOKAnODUYQSbTgJ
         VyfQ==
X-Gm-Message-State: AOAM530qTQVTXswfjS/MWj98XIrSPrWon3ZmDYphcqvX4I5uoIFt8zm5
        1M0E3QjxsXsc/DrZsQaGwLL+pLQ9LZcOPwOqBso=
X-Google-Smtp-Source: ABdhPJzgCcBtG3wH7WcAWdcPRL8QZV22tzE/VLSG6nIFbb+lk7+0ohyC1/GKBcUXHIj5CDXBNgvw9mf9Fl3rAtuukRo=
X-Received: by 2002:a25:7d07:: with SMTP id y7mr6985710ybc.425.1615413445101;
 Wed, 10 Mar 2021 13:57:25 -0800 (PST)
MIME-Version: 1.0
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 10 Mar 2021 13:57:14 -0800
Message-ID: <CAEf4BzZ2t_VbdtSde9uPEYNaggZLj3peyA8opHj1Ao_FO8AVrQ@mail.gmail.com>
Subject: test_ima passing only first time
To:     KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hey KP,

test_ima is passing only the very first time I run it in my VM. Alexei
earlier reported similar issues. If you run it second time without
restarting the VM, you get the following:

10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.00425121 s, 2.5 GB/s
mke2fs 1.45.0 (6-Mar-2019)
Discarding device blocks: done
Creating filesystem with 10240 1k blocks and 2560 inodes
Filesystem UUID: b9927426-1d29-458f-b2a0-8fe56455d209
Superblock backups stored on blocks:
        8193

Allocating group tables: done
Writing inode tables: done
Writing superblocks and filesystem accounting information: done

./ima_setup.sh: line 53: /sys/kernel/security/ima/policy: Permission denied
test_test_ima:PASS:skel_load 0 nsec
test_test_ima:PASS:ringbuf 0 nsec
test_test_ima:PASS:attach 0 nsec
test_test_ima:PASS:mkdtemp 0 nsec
test_test_ima:FAIL:71
#128 test_ima:FAIL

Do you see it on your side? Do you have any idea what's wrong?

Also, see that super-descriptive `test_test_ima:FAIL:71` line? That's
the reason I'm always bitching about CHECK_FAIL() use. At least this
one is not inside some loop.

-- Andrii
