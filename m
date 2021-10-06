Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37942374E
	for <lists+bpf@lfdr.de>; Wed,  6 Oct 2021 07:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbhJFFCM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Oct 2021 01:02:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhJFFCL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Oct 2021 01:02:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 411126113E
        for <bpf@vger.kernel.org>; Wed,  6 Oct 2021 05:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633496420;
        bh=qMP5f81KSvX1eo5teNmbek7BeqIlWIkNS82aarfokZ0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hDzaBVAbDJGdx0nAPMSZnQHzTPhG1o5XsbH+fIZVKbS71GJVmGyrTSEqZ6BjeMGsn
         qgE6QJGkjPokQH22MJDuSRRI0MAIGntjXeKObvmTdmKWKcdAiX1ZU4BO4TdRXnffNb
         lJyDu1kI6W299/mHOhTzrbyP+JHyku+WMgCvnj1pvp2PjVaYBjgg06+bUrUTstdHP7
         az1Ay4IeTKc4hnOYs/FBztinu3XNcOqu/3YdqnoLqR3FuPjdF7iRQoIZiTwtiJa22/
         Ep569v7D4CyYHeuPupa9jJw8a/xFT7SrwW1RaAB+ae7MLJqd8I62aR6WUVg6IreLJH
         RbmPO1sXU7S5Q==
Received: by mail-lf1-f52.google.com with SMTP id b20so5158377lfv.3
        for <bpf@vger.kernel.org>; Tue, 05 Oct 2021 22:00:20 -0700 (PDT)
X-Gm-Message-State: AOAM532s7xzrJIX/u9+gbYr8dv/lwlbM8FJIQnMUltSLzJojubtyiifi
        l0fjZS/zqAcfzaomIlgv9jPeaQDQYUp5+fUGRG4=
X-Google-Smtp-Source: ABdhPJzMHisClcQBrm5WPcMpkvxVpCpKrqo6u7qI2MIWp514u5txKQbeB3XywdlvCh1zc7TJ4X5KC/ztzt5Bq3J3g7M=
X-Received: by 2002:a05:6512:1052:: with SMTP id c18mr7199453lfb.223.1633496418629;
 Tue, 05 Oct 2021 22:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20211006040623.401527-1-hengqi.chen@gmail.com> <20211006040623.401527-2-hengqi.chen@gmail.com>
In-Reply-To: <20211006040623.401527-2-hengqi.chen@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 5 Oct 2021 22:00:07 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5B-C3p-1yJjzWoXm-Mp=USkW4x72pw8i9YPYH=zOMP5A@mail.gmail.com>
Message-ID: <CAPhsuW5B-C3p-1yJjzWoXm-Mp=USkW4x72pw8i9YPYH=zOMP5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bpf_skc_to_unix_sock() helper
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Oct 5, 2021 at 9:08 PM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> The helper is used in tracing programs to cast a socket
> pointer to a unix_sock pointer.
> The return value could be NULL if the casting is illegal.
>
> Suggested-by: Yonghong Song <yhs@fb.com>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>

Acked-by: Song Liu <songliubraving@fb.com>

With one nitpick below.

[...]
> --- a/scripts/bpf_doc.py
> +++ b/scripts/bpf_doc.py
> @@ -250,17 +250,17 @@ class PrinterRST(Printer):
>          license = '''\
>  .. Copyright (C) All BPF authors and contributors from 2014 to present.
>  .. See git log include/uapi/linux/bpf.h in kernel tree for details.
> -..
> +..

nit: We usually exclude these trailing space changes from the patch.
