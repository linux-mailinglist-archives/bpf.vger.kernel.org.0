Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64CAC454D63
	for <lists+bpf@lfdr.de>; Wed, 17 Nov 2021 19:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbhKQSu3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 17 Nov 2021 13:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbhKQSu3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 17 Nov 2021 13:50:29 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5199DC061570
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 10:47:30 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id e3so15457508edu.4
        for <bpf@vger.kernel.org>; Wed, 17 Nov 2021 10:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kylehuey.com; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2GQP2tRGysNgPEKNCjI+dwty2vanWOhkRb6VoLXLY6c=;
        b=cwihSbWXg/XvJyyox4hBavRvB43vlOFqjx0Ds7R7QUBkVvFBWqFdGsRVpbdaqduTXV
         lWY/xgnS2OvmtgH0WOAYFCikajlVm8p7uWcpv/7XvH7YVsRymkbcLTFNZhoMH0OkFNib
         x61xgU0vbY/zNqkzXCo3Wcdgl/mo2Dc+R/xPntSCtRJmojF9TQ/2taROZZJBYzLvHDlG
         Ua4m3kTdCLHG4QSdfXIk/EfcdIYLaEpoQkQdYKY4GPayfIKKDcMzsPtUmVfgsoZJc0Jy
         f5Pwr4cJV70tcrnPJXyRXfmym7oh/x1Ug7FP2E5gm1tDNXuGrayTDOMDF7tcZ5secqag
         Q6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2GQP2tRGysNgPEKNCjI+dwty2vanWOhkRb6VoLXLY6c=;
        b=rd9NAgg1Wssk/WCkC1gelnb+v9xsSFZe06pcONzHhlXSbWMgU9r8TV6v3vyVby37WU
         i3BiKJFSrb5/QNX2lrGuAh+Hbs9s484t3lTiZVdMtGXvV+Sa0/80l9RJHs+Opf2ziCxx
         FPnaFlh8axsnq9YPQ66+7re8uUn+E93jnB29GKnZw/PZ8LlDZmPB/N0JI0FNZJ+yqj++
         sNi2G6C/QHIWz5j43vAYBIeXSmtP4f0g5nTFx8GqffxyTAIDRCCnIYTdj/QW0nWIWvZl
         xNSysPFn0EO3hrvqAqIwUCgOUYKMzntnWpSCfalYJf8SqpVoYIKThdnBj5K8tiPGH5aV
         fXkQ==
X-Gm-Message-State: AOAM532N55wzIR7QnLDi7WcnzsPc+hv+4k0HCWxqwj1c/YJJG6BcLx34
        Qbap2r1uhLUpU4fYH7i31kfbce/NXSj95GXMHf9Dhw==
X-Google-Smtp-Source: ABdhPJzzVIVN1wyydH6f4f7OlGu6N3bX8zKWGU3H6C2rPo0t+oyEeAHFI/swWYHkGFU26QqJA7D3qJ52L+jOiMsxclQ=
X-Received: by 2002:a17:906:140b:: with SMTP id p11mr24492849ejc.116.1637174848825;
 Wed, 17 Nov 2021 10:47:28 -0800 (PST)
MIME-Version: 1.0
From:   Kyle Huey <me@kylehuey.com>
Date:   Wed, 17 Nov 2021 10:47:13 -0800
Message-ID: <CAP045AoMY4xf8aC_4QU_-j7obuEPYgTcnQQP3Yxk=2X90jtpjw@mail.gmail.com>
Subject: [REGRESSION] 5.16rc1: SA_IMMUTABLE breaks debuggers
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, bpf@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Robert O'Callahan" <rocallahan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

rr, a userspace record and replay debugger[0], is completely broken on
5.16rc1. I bisected this to 00b06da29cf9dc633cdba87acd3f57f4df3fd5c7.

That patch makes two changes, it blocks sigaction from changing signal
handlers once the kernel has decided to force the program to take a
signal and it also stops notifying ptracers of the signal in the same
circumstances. The latter behavior is just wrong. There's no reason
that ptrace should not be able to observe and even change
(non-SIGKILL) forced signals.  It should be reverted.

This behavior change is also observable in gdb. If you take a program
that sets SIGSYS to SIG_IGN and then raises a SIGSYS via
SECCOMP_RET_TRAP and run it under gdb on a good kernel gdb will stop
when the SIGSYS is raised, let you inspect program state, etc. After
the SA_IMMUTABLE change gdb won't stop until the program has already
died of SIGSYS.

- Kyle

[0] https://rr-project.org/
