Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D162778FD
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 21:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgIXTOW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 15:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726681AbgIXTOW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 15:14:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C4CC0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 12:14:22 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn7so249792pjb.5
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 12:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nYNQfolVzk1vZsWuLLwjSWbS4j2EWyO6uHCWvWRZVeg=;
        b=hUuL9B2LljZoDiYX/vccdvchsfVW3zD0frsCzdluTXClpc8C2HXET+CAJvamf8MLKq
         QFr9vs2aHQNF5XdI/+Bv2dvZtzG8BKQrL9vMYaLUbZqz/gjss7JyVTBH0Mqt5be7chwc
         g3EHPYVjMh1V4WMwfy14LT7tos0fxp4yVfkVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYNQfolVzk1vZsWuLLwjSWbS4j2EWyO6uHCWvWRZVeg=;
        b=pUd9tIVBpM/WEKHJTHw8uultDsiRjUjOOvbi7KwYuD2ZwZVGLYPhHkAyDLM4y2GzPW
         iu6+jc/NrWgNg5gytNE4eHhKctYB7oFEkxXZyYQtNs5WDfqchZuKQIZkYtUj8osC01L4
         F9gtOTzWLKdaJ0HjP0foc41oP/J4tPR9jkdNAHsnjkiBxQYUgPgC4Lm2Mkidk4Ud4jP0
         kZz9kAtQSkgLgPKMYcLJ8UAb8EJKvDvdXn07tSk4DqVSEAg92WqYpibTonTdD1N13Vpz
         IvErqQ+g/ZjpN9GXMpGwWpkARr7OkI9cy4EPz5fRaPXMXfVt6u56DjRX4VB3b7NxQ7H2
         w0TA==
X-Gm-Message-State: AOAM530p/Dz39ePJaFdTE1poqonJcpE0i6pJyI8KwNlCPYK8S11KZARo
        hAxtwXTiTrDBdZtXRIMjxWUNLQ==
X-Google-Smtp-Source: ABdhPJzCOkXIw+4aHc3ITiPqTIKrHpD3nBHPrufYSJk0Eo6cGU3fq7XJIKl/Iks+YT9V1uuYNnr2ag==
X-Received: by 2002:a17:90a:178e:: with SMTP id q14mr415155pja.154.1600974861729;
        Thu, 24 Sep 2020 12:14:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m25sm249209pfa.32.2020.09.24.12.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 12:14:20 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     containers@lists.linux-foundation.org,
        YiFei Zhu <zhuyifei1999@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Jann Horn <jannh@google.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>,
        Hubertus Franke <frankeh@us.ibm.com>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        YiFei Zhu <yifeifz2@illinois.edu>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Jack Chen <jianyan2@illinois.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>
Subject: Re: [PATCH v2 seccomp 1/6] seccomp: Move config option SECCOMP to arch/Kconfig
Date:   Thu, 24 Sep 2020 12:11:28 -0700
Message-Id: <160097467791.3774715.6342246806292251250.b4-ty@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <9ede6ef35c847e58d61e476c6a39540520066613.1600951211.git.yifeifz2@illinois.edu>
References: <9ede6ef35c847e58d61e476c6a39540520066613.1600951211.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 24 Sep 2020 07:44:15 -0500, YiFei Zhu wrote:
> In order to make adding configurable features into seccomp
> easier, it's better to have the options at one single location,
> considering easpecially that the bulk of seccomp code is
> arch-independent. An quick look also show that many SECCOMP
> descriptions are outdated; they talk about /proc rather than
> prctl.
> 
> As a result of moving the config option and keeping it default
> on, architectures arm, arm64, csky, riscv, sh, and xtensa
> did not have SECCOMP on by default prior to this and SECCOMP will
> be default in this change.
> 
> Architectures microblaze, mips, powerpc, s390, sh, and sparc
> have an outdated depend on PROC_FS and this dependency is removed
> in this change.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://lore.kernel.org/lkml/CAG48ez1YWz9cnp08UZgeieYRhHdqh-ch7aNwc4JRBnGyrmgfMg@mail.gmail.com/
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> [...]

Yes; I've been meaning to do this for a while now. Thank you! I tweaked
the help text a bit.

Applied, thanks!

[1/1] seccomp: Move config option SECCOMP to arch/Kconfig
      https://git.kernel.org/kees/c/c3c9c2df3636

-- 
Kees Cook

