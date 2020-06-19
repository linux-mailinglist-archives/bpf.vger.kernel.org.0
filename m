Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49CDE200159
	for <lists+bpf@lfdr.de>; Fri, 19 Jun 2020 06:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgFSEqA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Jun 2020 00:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgFSEqA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Jun 2020 00:46:00 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0ECC06174E
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 21:46:00 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y1so6288924qtv.12
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2020 21:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RDC1KGuqO/+SWnU7VVz8nN0YT8Fc98ZrMtoYnIfytQ=;
        b=iTE6P3zEKHx62/0zD7yx5lXGCl1tnBhhAHuNrLVrIRipKUL1OlMCTgVa3xUYnaIYQO
         Gfku89P/OtMON97eyGz69/C3q9anuC1N6Wpx3kImGa9truxlfd3cH75J/YN4nXPoOR0f
         ZaoPQAtrR4udEEMATzKzWH9OdPvLhokvShU90TdJXw5lN7hGUn3dTZQvgEKIKB5cfVka
         +AiAYWyvierxjpgZazjj4xXZJ4oH/UERDL7QmmEfh+ieHUixVS7HzAU6DgnknTUbXxs7
         WEW5P7DRXk1GWz8bl69L8QcpZvgRH4RjUckWx9DE0S47PsP8blC0caHYOOkpl0MDPKhA
         lFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RDC1KGuqO/+SWnU7VVz8nN0YT8Fc98ZrMtoYnIfytQ=;
        b=QCWmZzSPVrDVXd2FKAyLMSxgSL/qgc77bT2moV7T/Tgx5kgfLBFsBffNmqFMu+KVaz
         fJTviC7YiE7Y6Ozl7FrFkuGzNeRF/gZCY0i8Mr7xki0j2ZtPIvlnfFSXUwIKYNO1wfBD
         Rzzy3gZRhRxGk0TuwPqKb9pG16dkkgg6RcK38tyFGDe0r8jT4Z0R0FVDI+9IUaqqgTYV
         HOZR3WypYgKPXzBRoXHkb15b158MUUxiuS6CvwQCzZkxwzXLcwN7Qs4C3XwxqIp/kI2d
         gZDGUEIzR40FkAo5bNBDgATM3cGCGd3OdgLXfKiVWSSxhuDziXfPdAludqXq5pZst3mU
         XJYw==
X-Gm-Message-State: AOAM531pTnrS6FArLYbUyYXZz1VKMLt6wEwEgb3Bb6UIkH3uqkKO+5X5
        065HUICXMwM+I2pbNpRtf7TUz867B4roqHIrnuc=
X-Google-Smtp-Source: ABdhPJweXnLN3sFsK8r7jqmcYxVHPztZ8I16VVgwnopDonIM9kuC+Lt/tRMq0CX3PxXoHR0hEEahsKqhkuefrz7Uy2Y=
X-Received: by 2002:ac8:342b:: with SMTP id u40mr1613684qtb.59.1592541959345;
 Thu, 18 Jun 2020 21:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592426215.git.rdna@fb.com> <043d319c9d396b3c9244a03ed183043d7a91550b.1592426215.git.rdna@fb.com>
In-Reply-To: <043d319c9d396b3c9244a03ed183043d7a91550b.1592426215.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 18 Jun 2020 21:45:48 -0700
Message-ID: <CAEf4BzYiq6BYhCoq9y6D+y0j7SWcFMEy3EGVg1hh03ZmzaLajA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/6] bpf: Switch btf_parse_vmlinux to btf_find_by_name_kind
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jun 17, 2020 at 1:45 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> btf_parse_vmlinux() implements manual search for struct bpf_ctx_convert
> since at the time of implementing btf_find_by_name_kind() was not
> available.
>
> Later btf_find_by_name_kind() was introduced in 27ae7997a661 ("bpf:
> Introduce BPF_PROG_TYPE_STRUCT_OPS"). It provides similar search
> functionality and can be leveraged in btf_parse_vmlinux(). Do it.
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  kernel/bpf/btf.c | 23 ++++++-----------------
>  1 file changed, 6 insertions(+), 17 deletions(-)
>

[...]
