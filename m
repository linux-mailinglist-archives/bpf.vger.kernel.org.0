Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE872B0E27
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 20:37:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgKLTh5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 14:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgKLTh5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 14:37:57 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442CDC0613D1;
        Thu, 12 Nov 2020 11:37:57 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id o71so6161934ybc.2;
        Thu, 12 Nov 2020 11:37:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtLkoa9iAtcoKvRAxfNUbTm4+1oQ+ytkZHUyokgstJ4=;
        b=cxElvG3juUSp4eDvzLwnELhSzMtlkNS9wKjPRoPk2rkjWEHgMWOzjcfVO3YWP3UshJ
         7agQoR7fczYpY5gv33ayeLIrzXjpbCdveA0dDYtwkGLIJBK+z9oQdWtjGziumdLRzwIk
         DCjTl8ba4L3PdBHY6NGQIKYvD9/a4Za5BDoWXyshuNJK0tq5//xrTaXWgO3PzPbVDawZ
         9CBBtBLJo29h8ayDn7tL17HsMYMYzo85WcGxqy58HO3OkI08/mcmEnrko5ysWCfA0dka
         UVi7K+7AWV9nipwZ1KPz6btv5c127sqCRFMvflF80lZjNs5T8T53IAUGZrN5BkuFuMq9
         49YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtLkoa9iAtcoKvRAxfNUbTm4+1oQ+ytkZHUyokgstJ4=;
        b=K2RSXwcO7sbokQd5CgGQdXrJlZ9kt8wQiTN+M0t+IKoDGwIPJvdI5ogqnPD7wjo/xU
         eHN5SXhoWEPF3svsnT7LkhV+0pRqFxNCwyHmVe2XW2UUJHCXnDh3BgIr+b8pI0j8vkQ4
         ne7OVaOecq9Xc6fYcnyqhQ5aio3GydtyBOOvTOJUDtpeb4XJA/MAR1xJV30N0Z1FqIQ1
         Ta1OXuJGvlfLsRYgaI0H9wiFlxBFRX0TZxS2rj3SXIYhBH29tg9MyQOyrnp6isk3g5Jy
         l0vVXN6/NxqVU3lcojL+cVa1WhJ7SxxdC8khMjo8yitbDpMrxmvRw+H99+KcAc4KxKQh
         WjmQ==
X-Gm-Message-State: AOAM532vODbrci0Ci9x3YF+Oqv6dlz3UgnAzFk8u/vYZgOSKI+4O9utI
        aiRKdjk0mY/cycnt0buRbYoyAsiHx1HmChJgqR2+XTP2MaMGOtoM
X-Google-Smtp-Source: ABdhPJwKVlR+yFDaUQ338b2RsN1RMVpJXiNBwI7ojXQ0kLP4DSTUgbCXr+63b/XPFcW1USZoKHRKT/LRX56I9XDgzpw=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr1643837ybd.27.1605209876608;
 Thu, 12 Nov 2020 11:37:56 -0800 (PST)
MIME-Version: 1.0
References: <20201112150506.705430-1-jolsa@kernel.org> <20201112150506.705430-2-jolsa@kernel.org>
In-Reply-To: <20201112150506.705430-2-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 12 Nov 2020 11:37:45 -0800
Message-ID: <CAEf4BzbdysbGSvJRBZDN=R82KOSgQ8qm_6TDGMhEP3Pvg1RQSw@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] btf_encoder: Generate also .init functions
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        dwarves@vger.kernel.org, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Nov 12, 2020 at 7:05 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Currently we skip functions under .init* sections, Removing the .init*
> section check, BTF now contains also functions from .init* sections.
>
> Andrii's explanation from email:
>
> > ...                  I think we should just drop the __init check and
> > include all the __init functions into BTF. There could be cases where
> > we'd need to attach BPF programs to __init functions (e.g., bpf_lsm
> > security cases), so having BTFs for those FUNCs are necessary as well.
> > Ftrace currently disallows that, but it's only because no user-space
> > application has a way to attach probes early enough. This might change
> > in the future, so there is no need to invent special mechanisms now
> > for bpf_iter function preservation. Let's just include all __init
> > functions in BTF.
>
> It's over ~2000 functions on my .config:
>
>    $ bpftool btf dump file ./vmlinux | grep 'FUNC ' | wc -l
>    41505
>    $ bpftool btf dump file /sys/kernel/btf/vmlinux | grep 'FUNC ' | wc -l
>    39256
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Looks good.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  btf_encoder.c | 43 ++-----------------------------------------
>  1 file changed, 2 insertions(+), 41 deletions(-)
>

[...]
