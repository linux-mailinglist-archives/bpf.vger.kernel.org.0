Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5BF1285E0
	for <lists+bpf@lfdr.de>; Sat, 21 Dec 2019 01:09:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfLUAJU (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Dec 2019 19:09:20 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37990 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbfLUAJU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Dec 2019 19:09:20 -0500
Received: by mail-lj1-f194.google.com with SMTP id k8so11680362ljh.5
        for <bpf@vger.kernel.org>; Fri, 20 Dec 2019 16:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4q1kw9KdxyrcQWVabR9MTsO76cXQm+dLIWvVn8YebI=;
        b=VQfRFH/E/5dVxlrHb1ojU2bi6b09Qb3LfjvST+wn3iGitfOQ4aL5VFLgjIedqAop5f
         julZuEp2LaKCemwro3iVfguRbLNgDVKjR839LAv5Qif7VL8oudETNVIOKQEU1+HN02P8
         u7XgZbRWnsPWla17gJkDDAwgA8pGwx9wtZRUDIB5MKWedXltyqvEG89hDr9eM5E8RBRz
         PCG5hd0DbVKsxoN+Q9C6TJId/sh6zOXDEcQPyemgZylKT01qCAX3ZMD3bpAXEdx7qWY+
         BFIsT9Z66U4/1M4QWsdPgaHRL+fNMI0R41QA5KyZsHi8s9yFmofsmvCqp9wcvpIRtyen
         tdnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4q1kw9KdxyrcQWVabR9MTsO76cXQm+dLIWvVn8YebI=;
        b=NdhUUEM3SP6ThVoXin7oJ8vZxi88aHdm03nCh9CXnso5edYUK35dqzL7lQyAOjF3/i
         7P2rYtOJAqL9IZar8Wf9pWt4nz+ujooT4YAsokWeF3f5crdLnFOOa4CKojh2l5HbChlP
         y3UUKXh61rPk0yYAPGAjctSj174IXK5sNQBhp+OmK0YpaZU+HkiPr6bj9nga+vbXsAD5
         uTvL36Z/GlZVc8ZX5Sie/xUHcNl1di27ywSZA/ARx95OqB3Fzc7t5yQN7+0KSxNZwhJ5
         NRvqB34p2gUzDTjst061Xd/Um0lTxN+4/g2QMJjQO/I5mI5JkRjmvVSERfHtHfeDSQB4
         EpSA==
X-Gm-Message-State: APjAAAXaKmsXClX0sQ7AiY5MQSB2PRBExB67obQxJBqGhOPaQ94FM1xc
        +468PE0ITUga24FKzeD3+Yom2MI3rmM43UkwnBc=
X-Google-Smtp-Source: APXvYqwhKrQ1bQnbDsvYsfnEp8RGc0Y7d0O2RyUzeOVZewYr44cudxJAxpu6Y1Gb6KIv9DcXWZJvyfvDzZ4RyjPlnxk=
X-Received: by 2002:a2e:8e22:: with SMTP id r2mr3911020ljk.51.1576886958082;
 Fri, 20 Dec 2019 16:09:18 -0800 (PST)
MIME-Version: 1.0
References: <20191220000511.1684853-1-rdna@fb.com>
In-Reply-To: <20191220000511.1684853-1-rdna@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 20 Dec 2019 16:09:06 -0800
Message-ID: <CAADnVQKo=nP1KK2KPoeJSxapnXbLOwYFUX1jg-CyVAQ2PGy9TA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Preserve errno in test_progs
 CHECK macros
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 19, 2019 at 4:05 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> It's follow-up for discussion [1]
>
> CHECK and CHECK_FAIL macros in test_progs.h can affect errno in some
> circumstances, e.g. if some code accidentally closes stdout. It makes
> checking errno in patterns like this unreliable:
>
>         if (CHECK(!bpf_prog_attach_xattr(...), "tag", "msg"))
>                 goto err;
>         CHECK_FAIL(errno != ENOENT);
>
> , since by CHECK_FAIL time errno could be affected not only by
> bpf_prog_attach_xattr but by CHECK as well.
>
> Fix it by saving and restoring errno in the macros. There is no "Fixes"
> tag since no problems were discovered yet and it's rather precaution.
>
> test_progs was run with this change and no difference was identified.
>
> [1] https://lore.kernel.org/bpf/20191219210907.GD16266@rdna-mbp.dhcp.thefacebook.com/
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

Applied. Thanks
