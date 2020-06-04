Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14ED1EEA5C
	for <lists+bpf@lfdr.de>; Thu,  4 Jun 2020 20:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgFDShY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 4 Jun 2020 14:37:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgFDShW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 4 Jun 2020 14:37:22 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2780720825;
        Thu,  4 Jun 2020 18:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591295842;
        bh=zVQ/a3QGGMwVEKXv04Zyp+cYabQnJ/hl5W1NaF+IHxU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QqPc/05WRFNYktsxU3lxmkmrsXD/kqlZWBwVd/rV7vMoJxuhSTsBvsT2TC0kgXJUE
         nOAQTo1NYlI6mAduFRJJfY3+txBu+BALxafRUoxnGseD4sDK87m3Cpu3e6uKXDFR0c
         DGuBlSfMdI0khNo/2nLtDvNiaMRjEZWVtH3OgE4c=
Received: by mail-lf1-f52.google.com with SMTP id e125so4249533lfd.1;
        Thu, 04 Jun 2020 11:37:22 -0700 (PDT)
X-Gm-Message-State: AOAM530Yvy3KA0IZwK2G+2RJiuAgNRJcyfyO7j6bDY1iWcf4zpzGyDLP
        YbTz3Wla4ZsZgcq8SjK46Aj8r31pitSBaFvLjAI=
X-Google-Smtp-Source: ABdhPJwELS2VbxbfUSW2SafVtBUYtQ1Mw9hELIS7evhsCM1/DuOzz5FbaC0/82U2B34IP/5Y1RKbQ/h6lWZGK054Vgw=
X-Received: by 2002:a19:c6c2:: with SMTP id w185mr3164934lff.69.1591295840422;
 Thu, 04 Jun 2020 11:37:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQJPwtan12Htu-0VhvuC3M-o_kbnPpN=SXVC-amn9BcZCw@mail.gmail.com>
 <20200604085436.GA943001@mwanda>
In-Reply-To: <20200604085436.GA943001@mwanda>
From:   Song Liu <song@kernel.org>
Date:   Thu, 4 Jun 2020 11:37:09 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7BK+4sJ42YpseWkHf0brW65se5HkQCkq-ONHx--sW4iw@mail.gmail.com>
Message-ID: <CAPhsuW7BK+4sJ42YpseWkHf0brW65se5HkQCkq-ONHx--sW4iw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] bpf: Fix an error code in check_btf_func()
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, bpf <bpf@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 4, 2020 at 1:55 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> This code returns success if the "info_aux" allocation fails but it
> should return -ENOMEM.
>
> Fixes: 8c1b6e69dcc1 ("bpf: Compare BTF types of functions arguments with actual types")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Song Liu <songliubraving@fb.com>

> ---
> v2: style change
>
