Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 210822B6FD1
	for <lists+bpf@lfdr.de>; Tue, 17 Nov 2020 21:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgKQUOX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Nov 2020 15:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgKQUOW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Nov 2020 15:14:22 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9384C0613CF;
        Tue, 17 Nov 2020 12:14:20 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id h23so25747726ljg.13;
        Tue, 17 Nov 2020 12:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pzu8jH46SgZ+8ojxydBvx1A8kyubP5gQeS4suLTV/C8=;
        b=sJekO8w2IrTTc+gVj1WW9UmsX131YuYv++S/Gm37dfBKw9PIh3fpGUWuGHdDEEInvY
         8xJKAo9gkOgs00PdLgf5JTFbPB9/Eo44ezD0KfRwERu+obhPkrt9Y8lPj94wCohW4c6i
         xFDDSmVLXJaAiIM+A+NbO9jUF5I5KGTM9md536zcHqpGOgIX1j/WU1D/ZkZniUarBy41
         FX5a7ZPWwSzW7Jee8GXOj1KIQEvB+dey0ceqcr8Dp6wYQvyz5e4VDBojQFROS1Wyc3G4
         NyMJmbDdX9zo0c8P+7oJZ0guOZmvpJyUHJ/coTde9Wzcl98TFavr6n6cBfLVJ/hebqbU
         RpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pzu8jH46SgZ+8ojxydBvx1A8kyubP5gQeS4suLTV/C8=;
        b=BC4bp7S5cseQPgfDUsvgR86rdtPcdCFI6iQVmYj+I2lCeVnY02IFFI8JLtXqkjxduw
         7OqnLvSt6b9NGvhOA8F4N5zmJ+ogdA7D2uUOxycQOAvYsdpgyX+Ff+94JnXV2ZwR1S+n
         fX66xTJQeNy9/Oa69bCJUDsrgX7hReYe4GADUDhtZzj8b+g9e5JkW7V0bAo9RxgKRw3b
         aS/e38fXUYGWxWiN3It30e4nfOOufKb9KTYza6CrOkPfrOiecJ2XUbmyXauBxDlRnU1m
         6r75QUdjvAJ0Nz1ZRR/qjGNbOHRu2qo1swJyE5pMHFOLS7vVNbK8YqOSA6vdIP+ervBK
         +ffA==
X-Gm-Message-State: AOAM530ENNsADannE6pua8uNCv3msOaLgELEHv9aSxNiOCsP7AehJW8w
        ocK8gpqjaeeb1KTqizW+xeInwXytyWsvEubisjY=
X-Google-Smtp-Source: ABdhPJz0lAhB3VZcKHN0+whSRBsObhDazA9JH55BLyTtQhQ1O2cnfHbWtp4pdE2+IX8BEGAafKM/z3rMMx7pXJOKtd4=
X-Received: by 2002:a2e:9648:: with SMTP id z8mr2593730ljh.91.1605644059204;
 Tue, 17 Nov 2020 12:14:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605642949.git.dxu@dxuuu.xyz> <21efc982b3e9f2f7b0379eed642294caaa0c27a7.1605642949.git.dxu@dxuuu.xyz>
In-Reply-To: <21efc982b3e9f2f7b0379eed642294caaa0c27a7.1605642949.git.dxu@dxuuu.xyz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 17 Nov 2020 12:14:07 -0800
Message-ID: <CAADnVQ+0=59xkFcpQMdqmZ7CcsTiXx2PDp1T6Hi2hnhj+otnhA@mail.gmail.com>
Subject: Re: [PATCH bpf v7 1/2] lib/strncpy_from_user.c: Don't overcopy bytes
 after NUL terminator
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 17, 2020 at 12:05 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> This commit uses the proper word-at-a-time APIs to avoid overcopying.

that part of the commit log is no longer correct. I can fix it up while applying
if Linus doesn't have an issue with the rest.
