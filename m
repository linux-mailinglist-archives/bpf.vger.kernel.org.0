Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4685616F2CC
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2020 23:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgBYW61 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Feb 2020 17:58:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgBYW61 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Feb 2020 17:58:27 -0500
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D061C222C2
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2020 22:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582671507;
        bh=8bLwgDUcfc17/MEjkWqjnj4ds0c77O7VLNAvJmMEbzA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C8iNxCUxP3AI0dTXTrss8TBQtL3XrNNiwCYtqATfrcJW8WIkOvMQ+g3g7bWBH9jGI
         NJISQ4bSRLZnFWPQWZeU2nnm+8XqIfS3ld4GD+/cJLRglwu1ZAYWOfzG1FBW5y4En2
         vdVhLZuQ2qd7S9eL7tfvBzzgdZfeZLBULCLJBKgA=
Received: by mail-lf1-f54.google.com with SMTP id 83so448482lfh.9
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2020 14:58:26 -0800 (PST)
X-Gm-Message-State: APjAAAXjNHnX/73M3Rz5YZ9aUIkXyP6JY/++T/SMR6Totvthj4HNwte/
        b098v/8ong5dzaXhsejisvSuf/GTsOrJQ318xsw=
X-Google-Smtp-Source: APXvYqxUQ7o0h+1F+7gmORX0Gx22GhuBsuCNEDUOlqODLsuohl3xDqlvJHzsIgJHNaIUPZm0dcfO8GbCUQ6BM5fYYWI=
X-Received: by 2002:a05:6512:6cb:: with SMTP id u11mr595681lff.69.1582671504934;
 Tue, 25 Feb 2020 14:58:24 -0800 (PST)
MIME-Version: 1.0
References: <20200225223441.689109-1-rdna@fb.com>
In-Reply-To: <20200225223441.689109-1-rdna@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 25 Feb 2020 14:58:14 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5EZr6crE0Bx0bLtWD+armXzAAsotLnBN045RUKrnrrdQ@mail.gmail.com>
Message-ID: <CAPhsuW5EZr6crE0Bx0bLtWD+armXzAAsotLnBN045RUKrnrrdQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: Support struct_ops, tracing, ext prog types
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Feb 25, 2020 at 2:35 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Add support for prog types that were added to kernel but not present in
> bpftool yet: struct_ops, tracing, ext prog types and corresponding
> section names.
>
> Before:
>   # bpftool p l
>   ...
>   184: type 26  name test_subprog3  tag dda135a7dc0daf54  gpl
>           loaded_at 2020-02-25T13:28:33-0800  uid 0
>           xlated 112B  jited 103B  memlock 4096B  map_ids 136
>           btf_id 85
>   185: type 28  name new_get_skb_len  tag d2de5b87d8e5dc49  gpl
>           loaded_at 2020-02-25T13:28:33-0800  uid 0
>           xlated 72B  jited 69B  memlock 4096B  map_ids 136
>           btf_id 85
>
> After:
>   # bpftool p l
>   ...
>   184: tracing  name test_subprog3  tag dda135a7dc0daf54  gpl
>           loaded_at 2020-02-25T13:28:33-0800  uid 0
>           xlated 112B  jited 103B  memlock 4096B  map_ids 136
>           btf_id 85
>   185: ext  name new_get_skb_len  tag d2de5b87d8e5dc49  gpl
>           loaded_at 2020-02-25T13:28:33-0800  uid 0
>           xlated 72B  jited 69B  memlock 4096B  map_ids 136
>           btf_id 85
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>

Acked-by: Song Liu <songliubraving@fb.com>
