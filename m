Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF0D49C37A
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 07:10:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiAZGKS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 01:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiAZGKS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 01:10:18 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3326EC06161C;
        Tue, 25 Jan 2022 22:10:18 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id z7so3915794ilb.6;
        Tue, 25 Jan 2022 22:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K/aPgp2JpR9E/Fra5lI3DY3AzPQHtjHLcim/5ByHdMI=;
        b=bxwRDirN9d8JfOeuxVI2jmtJUr0Y5v7HCA/4eRhVWl5L6go6SRlKaHJsP2tYOBgoBa
         D/a7lHUvIKn0hZEy8Lv0gUfSy5QfsIpOhgqFgPz7YzTlEJMVYGsaoqTCbki0hu8kqLYh
         fYzJuoymXcbJP+s1v8HveQhU3SPP+m2OOPvWjyPqMylMqW5dwH9UR1KO5gfBZUyiL8bY
         y4iMXrkuUOtCWc0AusLw8RdwkrNtOkqDjO/D8PownG4Dcnx/OWnNGKK36LyOP7KixxZB
         mO3C40l+fv3UUDl9Nw+cjy7CvxhHpshm1R0bvn4zkMXFufY1HD9GSaQtn2fwAYsSJ1vl
         xlzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K/aPgp2JpR9E/Fra5lI3DY3AzPQHtjHLcim/5ByHdMI=;
        b=3ckzWeQeBINdg9GFNxb29BOd2iGt2gFXSakd7zSe2z4hkxX9CZ3KXuZKcokdwfVPoU
         mno6Ii6AAWbGiLBLp/hEpJAf/xr4V+2PTLil77U7CYHEux4e1ww3lvT7/hmS8pLIIiRr
         izTj6f2LOgi4OGHcLF/1/y+6NK6xiwJyHhkBx+R7yXA9RKVwW19yYwW+KQundBANab9q
         q4Kv2++IyxiuXBGFcmI1uU1cYbVF6o6QIcUpgbV1RhS9JqBZXetSrz9bJOSPD8/pzWeg
         XpD26tT1BYL9ZrvQ5J17otSljy5V6rk+rhBytC2ddNSrges/XHuyjlBiv4b1vu5ED1v+
         uxvQ==
X-Gm-Message-State: AOAM532AWLzfsWNAx9TO+4HeRy7KniswNIYi4truX7XHWivSzrXkIkSo
        F7oA5JD0Xcj/rOddmJwoLWbmIBkrugIYK0R8V3TZ9/voVAw=
X-Google-Smtp-Source: ABdhPJwrKr04BB3KkHhjZpWbjvi5Dr6ox77Alfb8YjKogTx62z4KrlsKpviorlcKvj3ybgFJCgAorpMQ3AsfMNTZhQg=
X-Received: by 2002:a05:6e02:1748:: with SMTP id y8mr13690538ill.305.1643177417595;
 Tue, 25 Jan 2022 22:10:17 -0800 (PST)
MIME-Version: 1.0
References: <20220126040509.1862767-1-kuifeng@fb.com> <20220126040509.1862767-2-kuifeng@fb.com>
In-Reply-To: <20220126040509.1862767-2-kuifeng@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 25 Jan 2022 22:10:06 -0800
Message-ID: <CAEf4BzZcPsSVTF-o=fke9xTDRxT6itakmw1UUHX0nL74BpUgqA@mail.gmail.com>
Subject: Re: [PATCH dwarves v3 1/4] dwarf_loader: Receive per-thread data on
 worker threads.
To:     Kui-Feng Lee <kuifeng@fb.com>
Cc:     dwarves@vger.kernel.org,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 25, 2022 at 8:06 PM Kui-Feng Lee <kuifeng@fb.com> wrote:
>
> Add arguments to steal and thread_exit callbacks of conf_load to
> receive per-thread data.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_loader.c   | 2 +-
>  ctf_loader.c   | 2 +-
>  dwarf_loader.c | 4 ++--
>  dwarves.h      | 5 +++--
>  pahole.c       | 3 ++-
>  pdwtags.c      | 3 ++-
>  pfunct.c       | 4 +++-
>  7 files changed, 14 insertions(+), 9 deletions(-)
>

[...]
