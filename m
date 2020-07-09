Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C395621A8CC
	for <lists+bpf@lfdr.de>; Thu,  9 Jul 2020 22:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgGIUUE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Jul 2020 16:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:41050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgGIUUE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Jul 2020 16:20:04 -0400
Subject: Re: [GIT PULL] kallsyms_show_value() refactoring for v5.8-rc5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594326004;
        bh=HRptW16geXbMF/1JQz2D9qCQCfAOGAmvnBukdC9XItU=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=TD1LKAZjcjOakg7+S/fRXGhPdDuzAql+CuGNCIE9UJA9xFvTxpPu3fCoarIlfZZ0h
         V+Ur+89VBFaDgF5/C87vpkA9ag8XLbi1ZXPEudPTC5yBTpoaOumjcsfAA83xjq3tPv
         OUJ8rl62tMue2NKHqWm21BHJpjPbLYtbiJB4Jwj4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <202007081608.AB6F0E96@keescook>
References: <202007081608.AB6F0E96@keescook>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <202007081608.AB6F0E96@keescook>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
 tags/kallsyms_show_value-v5.8-rc5
X-PR-Tracked-Commit-Id: 2c79583927bb8154ecaa45a67dde97661d895ecd
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ce69fb3b392fbfd6c255aeb0ee371652478c716f
Message-Id: <159432600415.22213.6510320407732971510.pr-tracker-bot@kernel.org>
Date:   Thu, 09 Jul 2020 20:20:04 +0000
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Dominik Czarnota <dominik.czarnota@trailofbits.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The pull request you sent on Wed, 8 Jul 2020 16:16:39 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/kallsyms_show_value-v5.8-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ce69fb3b392fbfd6c255aeb0ee371652478c716f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
