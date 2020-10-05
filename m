Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FDF2842A7
	for <lists+bpf@lfdr.de>; Tue,  6 Oct 2020 00:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgJEWrE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 18:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgJEWrD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 18:47:03 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6FCC0613CE
        for <bpf@vger.kernel.org>; Mon,  5 Oct 2020 15:47:03 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id n22so11291452edt.4
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2020 15:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uWv/MLe4IWuuwbmgVY36C/jBWi0pkWKVi1wbsytwksU=;
        b=PL+iHnGw7+qwCdHuD6saV3KJsxkS5E/bXPwSDrnnfT3Ib1u5A5aAZlCPImn1qoQoJP
         /kIS01oSsOFzCbt7OMJCUN1veoATyXHNEJ848OkTmG2hzy+KPsgaoROMz516O386ztxv
         dAWqcqwXA4/1ph7G7dFrExFvUbPoeepv+DhHAhYM3rNPWtN0Ya9lD91NA/HJ0UNGP9y6
         W+4r2K8EH3Px5ZrqTgMYzXoCYb1JOdfc83Jqo0jW5UCyCgMssDJFznUJE/iU88d7Wvsw
         xIhf/Hmveh0XBLR0JJ6dfOExp0V/D5ooOklYQv2vgdWMMNpCiGFfXrAFKDWbrvkN2zFY
         DR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uWv/MLe4IWuuwbmgVY36C/jBWi0pkWKVi1wbsytwksU=;
        b=L3DBl6/dfNugPGAiMocgl+lZVDVECAsf59ql03hZOMHCmlHblFPzrzQ/kM3Ma7fw4i
         cQQamfjmlrmz46xPdd+/sLjlbPGg3b2dmdPylCIYbyv/zoCtrimC5O6JDh942wATHc3u
         IXMd3se81H9DVTdB6kIzbUJLlw4YZ5DrlYgpqu4UOYPgaKaMFIwvjhIA6pm9vGSj9S9E
         9iu4+WvtmGD5Wt2CRC2nJHQYbuhAGreBQFKtE25igK+mXCZ6yXGL/DdTdIQx8cwDoNpi
         DN1gTHVbJiEUsC3Zrd8A+WWdgtiknGFrIvi8nTRzYFzBanxJvxYF8X4zfwnd85UeGXh7
         RYCg==
X-Gm-Message-State: AOAM531tgHTV3bi6/bFW+5ShlZlcFxkqflFUe07BYr6vZ/WNS2mu14ZH
        9kSvRMcE3oECoBbbc0uyxK7dKwlG0ViQItzzB3dJLHsXFNQ=
X-Google-Smtp-Source: ABdhPJwGGKc1GYg9AXQJHDyQgGTIxMrS/j1FOMZyPNqHDkzAL1YYCWzM70IDAZqZ99x8Y072mt7pPnhoID/5RUZh6bk=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr2219392edm.100.1601938021935;
 Mon, 05 Oct 2020 15:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201005163934.331875-1-lrizzo@google.com> <CAEf4BzZq8t0XZy5Z6SBHAURJBxuDBPdU9amsJ0z0os7TE-cjoQ@mail.gmail.com>
 <e7f55966-41ab-2953-d78d-630463b896c2@iogearbox.net>
In-Reply-To: <e7f55966-41ab-2953-d78d-630463b896c2@iogearbox.net>
From:   Luigi Rizzo <lrizzo@google.com>
Date:   Tue, 6 Oct 2020 00:46:51 +0200
Message-ID: <CAMOZA0+JKVnMZtuZA3bOOsPSonnaoLC2w-O2Jwg4=wa_OscLTQ@mail.gmail.com>
Subject: Re: [PATCH v2] use valid btf in bpf_program__set_attach_target(prog,
 0, ...);
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Eelco Chaudron <echaudro@redhat.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 6, 2020 at 12:33 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
...
> Could you send a v3 with updated commit message wrt side note and prepend
> e.g. 'bpf, libbpf: ' into subject prefix?
>
> Please also carry Andrii's ACK forward.

done (note the subject change in v3)

thanks
luigi
