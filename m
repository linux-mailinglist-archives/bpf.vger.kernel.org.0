Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F7C219432
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 01:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgGHXQn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jul 2020 19:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgGHXQm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Jul 2020 19:16:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88670C08C5C1
        for <bpf@vger.kernel.org>; Wed,  8 Jul 2020 16:16:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id q17so16194pls.9
        for <bpf@vger.kernel.org>; Wed, 08 Jul 2020 16:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Xz83zbMBS1ciMi4HP8F5AMInxsp8lIOMa2E1ookzEnM=;
        b=ZzxSL3jE8TfZozJ+lUu5EWR8aD1tJwnYAK9Rn7Z7nImkfg7B/XXRCmyi8+tK0R92N1
         /Stwcle6e+18anI9CK//KGt1cZmJd0DyMHlEP4hTTwuOuq7nExSNEYQsGsrBeGlQ7C/b
         1hJ6p9N0VQwEZpNtgSUyrG6baMnNJ9biO4ikg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Xz83zbMBS1ciMi4HP8F5AMInxsp8lIOMa2E1ookzEnM=;
        b=O3IspKyyhcIuGAtxwWnPR0JQtDf8K+gJpHofF31nmbjV4mkplFE6IQwIjCOqsDtY47
         v/zF4Vkk4bnufEg8/W2FQk6fs/3E53QkeMk5uNGPCeKzonIq6lErWKWUIzwEA62tGKaX
         sJw9RG8OtzN8mduZ7DcJTmBMh4jHVBxf/hyFskbwDE7JylHxbQeb4UdqrYGDnf/EvSI3
         TlQ6G+U6iIFm1Cp5lUfJ7bk08K4Vo1rJNcH52xPwPShRRrRAH0GGJyQ0Ex50uCTKfKlB
         v+fN2mPa3ruU2H9yO8+I1GVWcXvmgAmn1667W+xMhqbTYF+qAAJop2v+GIYPo/dlwH1r
         RVNA==
X-Gm-Message-State: AOAM530UqnX4xc8e5siLmK/vuwt8AoNYWVbiKpbp6HLF8nKpboJQ+I91
        wE01Uvz+BSygVcz57HlYd7BvMw==
X-Google-Smtp-Source: ABdhPJyo85bWfKc7dmUbm6uwAqu7RbmKNA71lY/V6RFecIv5/ryA0rj3xviymXs4MMndMmbtr18M+Q==
X-Received: by 2002:a17:902:6544:: with SMTP id d4mr9149663pln.138.1594250201062;
        Wed, 08 Jul 2020 16:16:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z62sm734522pfb.47.2020.07.08.16.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 16:16:40 -0700 (PDT)
Date:   Wed, 8 Jul 2020 16:16:39 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [GIT PULL] kallsyms_show_value() refactoring for v5.8-rc5
Message-ID: <202007081608.AB6F0E96@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Linus,

Please pull this kallsyms_show_value() refactoring for v5.8-rc5. I'm not
delighted by the timing of getting these changes to you, but it does fix
a handful of kernel address exposures, and no one has screamed yet at the
patches nor their existence in -next for a few days. Folks have reviewed
(and even tested!) the series. :)

(I'm leaving the more experimental current_cred() WARN() stuff for
later, obviously.)

Thanks!

-Kees

The following changes since commit 48778464bb7d346b47157d21ffde2af6b2d39110:

  Linux 5.8-rc2 (2020-06-21 15:45:29 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kallsyms_show_value-v5.8-rc5

for you to fetch changes up to 2c79583927bb8154ecaa45a67dde97661d895ecd:

  selftests: kmod: Add module address visibility test (2020-07-08 16:01:36 -0700)

----------------------------------------------------------------
Refactor kallsyms_show_value() users for correct cred

Several users of kallsyms_show_value() were performing checks not
during "open". Refactor everything needed to gain proper checks against
file->f_cred for modules, kprobes, and bpf.

----------------------------------------------------------------
Kees Cook (6):
      kallsyms: Refactor kallsyms_show_value() to take cred
      module: Refactor section attr into bin attribute
      module: Do not expose section addresses to non-CAP_SYSLOG
      kprobes: Do not expose probe addresses to non-CAP_SYSLOG
      bpf: Check correct cred for CAP_SYSLOG in bpf_dump_raw_ok()
      selftests: kmod: Add module address visibility test

 include/linux/filter.h               |  4 +--
 include/linux/kallsyms.h             |  5 ++--
 kernel/bpf/syscall.c                 | 37 +++++++++++++++-----------
 kernel/kallsyms.c                    | 17 +++++++-----
 kernel/kprobes.c                     |  4 +--
 kernel/module.c                      | 51 +++++++++++++++++++-----------------
 net/core/sysctl_net_core.c           |  2 +-
 tools/testing/selftests/kmod/kmod.sh | 36 +++++++++++++++++++++++++
 8 files changed, 103 insertions(+), 53 deletions(-)

-- 
Kees Cook
