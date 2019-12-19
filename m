Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A03521270D6
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 23:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfLSWnL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 17:43:11 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38348 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSWnL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 17:43:11 -0500
Received: by mail-qt1-f195.google.com with SMTP id n15so6477968qtp.5
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 14:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SmMbowtTfAsbOVAZeLeZB+ZGZ+/7tm77KWfmwIKdb4=;
        b=XZmYEIH46LKUs03Xl0hOlGSqzReBbz9tImTF9PRYNLUdvD1Eku+iFe+fzEUE6u/pS5
         lR2HQJf8ay92exAWL/RrfiFLGZanVYE/74UC4QeC6Kt7J2VdCOqFBZaywl4N5JB4pfFN
         CZMBtJrEhHqi4vJAIp7+TjI7Yu5nw2BfIJxIEEj9b/Wn3wzpFZKuxAb+NEUEt1b/rQ3p
         yA2jTYZ4BGZv/2OS11NtoAaHwccHFNtbeLYF1as8dtzA0vifk+TjMC3RiHZEdGdbGx8W
         MFjlFoOOe2TuelS0Hoo4mfWEzYu0akm9SqAS/fvR7xGASXLCkKd+ljmaPucbjANs4EUc
         wVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SmMbowtTfAsbOVAZeLeZB+ZGZ+/7tm77KWfmwIKdb4=;
        b=DJPVce7vYk2vNgrrYWsSTU+A5VHmXYtA0Suoh0qyyNhZCdnUHLx7DLhHp/kmpuEP8Q
         JA5ZhFkPDaoHbVCqhHjYxR0vAo5fgpgP6YoOr5z8FA4tFd7zyE0nmcZG+94l8VaNIdaB
         GgYp49w5zQKj8EViUGURA2KmaXTH7luvknO5XNq2Wtkz0JVPRyHPV4weJ7oGs+OonKjq
         WeNFh9VSDXo4n43fRiRFXMDeh+V2jN8ckCzVbV0BnhjRsoPHE3C5pehSjiGKNkOy9EW8
         3Ea0r+EIQ9xzMag5VIjGJiEegjPnKU+g7+nEyV/j7V4HX2Rs4JIVmj6W0qxDoUvMNx5D
         r3GA==
X-Gm-Message-State: APjAAAVXsL1jFG+PeinkDa8pcCtkFAquomYD0L6E1rLVXrTDbv83ft+R
        EkJVoGSHfOOu3KvI6l3dUf0dc2ak3BaAKt2Y25Q4ih4z
X-Google-Smtp-Source: APXvYqzVoazwULr6X7Xyh/BspWYhEiQ+E57X4awFh5cH3Gk0sb49biFKquTdybha8i9G0c+YuNfhzTa5UdP4yHNWrVg=
X-Received: by 2002:ac8:5457:: with SMTP id d23mr8920577qtq.93.1576795390308;
 Thu, 19 Dec 2019 14:43:10 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576741281.git.rdna@fb.com> <bd6e0732303eb14e4b79cb128268d9e9ad6db208.1576741281.git.rdna@fb.com>
In-Reply-To: <bd6e0732303eb14e4b79cb128268d9e9ad6db208.1576741281.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Dec 2019 14:42:59 -0800
Message-ID: <CAEf4BzY_U0dTcvCuF73g_Vh+6nJTBce0wHsDXeaJWSQ3Ud4rRA@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 4/6] libbpf: Introduce bpf_prog_attach_xattr
To:     Andrey Ignatov <rdna@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 18, 2019 at 11:45 PM Andrey Ignatov <rdna@fb.com> wrote:
>
> Introduce a new bpf_prog_attach_xattr function that, in addition to
> program fd, target fd and attach type, accepts an extendable struct
> bpf_prog_attach_opts.
>
> bpf_prog_attach_opts relies on DECLARE_LIBBPF_OPTS macro to maintain
> backward and forward compatibility and has the following "optional"
> attach attributes:
>
> * existing attach_flags, since it's not required when attaching in NONE
>   mode. Even though it's quite often used in MULTI and OVERRIDE mode it
>   seems to be a good idea to reduce number of arguments to
>   bpf_prog_attach_xattr;
>
> * newly introduced attribute of BPF_PROG_ATTACH command: replace_prog_fd
>   that is fd of previously attached cgroup-bpf program to replace if
>   BPF_F_REPLACE flag is used.
>
> The new function is named to be consistent with other xattr-functions
> (bpf_prog_test_run_xattr, bpf_create_map_xattr, bpf_load_program_xattr).
>
> The struct bpf_prog_attach_opts is supposed to be used with
> DECLARE_LIBBPF_OPTS macro.
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---

Looks great, thanks!

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  tools/lib/bpf/bpf.c      | 17 ++++++++++++++++-
>  tools/lib/bpf/bpf.h      | 11 +++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 28 insertions(+), 1 deletion(-)
>

[...]
