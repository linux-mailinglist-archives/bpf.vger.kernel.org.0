Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BB8BABC5
	for <lists+bpf@lfdr.de>; Sun, 22 Sep 2019 23:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389212AbfIVVHd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 22 Sep 2019 17:07:33 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35835 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388917AbfIVVHd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 22 Sep 2019 17:07:33 -0400
Received: by mail-qk1-f194.google.com with SMTP id w2so13327469qkf.2;
        Sun, 22 Sep 2019 14:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NEjeJRMZu7XwAcL5sHF1ZmhnHlSVlmSsLDwPoar0bfQ=;
        b=n3jysIRrqtOkIShrRYRjMwqH9Rpe1/L0JXM5cxhE/hhqqPJuevRtXqirOLhY1NsNWx
         VZXrL/hrpU4aFVbz9zeh1sGV0d25HpOeckGFl6FAF5uwfYVsKMluYRYsozbyBoLBtOaU
         ZULTQKxbWcnrvue6Y0+QchjkjVpyGA3qm64fT+OqsvQ4yY0GVkOAz04wLnlWwzn+VWTa
         w0C0zdQ6c6abSWenSrrf9jt3LGekm3KaOoAuQlz/dFPpnpSQRUC8Iw7fgEyW6bsBuwci
         7zuQGa2Pl8u/LHE77BGSAeLV8B8Y9mKTSAsd3ts/gH2muTTX0VYgleq6lMJm8//uyYqT
         Le+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NEjeJRMZu7XwAcL5sHF1ZmhnHlSVlmSsLDwPoar0bfQ=;
        b=LKHQ7x9S/hAz0zRbqwx3VS0ulL/us7pi7ySZyBk5yUgtDLbO8WYieo7DT4kcFvdwYS
         Npz2A5CteWMjhEPI508N/JiaA9XM6AqH7DRBg8pTEgL9P++yQFacLpN4teY3azeTXFCc
         Md/bGwMpT9bt+rYtlLd7DPvoSQ6Ba3D6ZlcpjCT87LICQs+cSP4PQNgFs4PUFFJKK7y7
         2v3QlcpgZwxHhY/4U/2pybtNKgu6Sp7A6lUQMVAJHTyBheeykaeLWIiPp38oyg/TiKMM
         8ac4psUOz9BdIL/9UOUvfzgXTkXkXqiB1/egx6vMx+oeiQK7kpdC8Eba90akz6x3Dpwk
         fJHg==
X-Gm-Message-State: APjAAAWDH5xFZsngIg/SokjxYX7rsCcprxdVvUpb0oR4B9fONPVCSls5
        aIHCYG7ffM6wTGGEP8Y0AT1hD52VIBdkk2G75XY=
X-Google-Smtp-Source: APXvYqwtpFjo6cICe41R6nirPAgdVTqLFuXU1uLtdszZC7k30831HZetJAwUsNsjoJ+dYojFLJhe9ctsHcyRmQ0Y8aM=
X-Received: by 2002:ae9:eb93:: with SMTP id b141mr14705029qkg.36.1569186452282;
 Sun, 22 Sep 2019 14:07:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190920062544.180997-1-wangkefeng.wang@huawei.com> <20190920062544.180997-31-wangkefeng.wang@huawei.com>
In-Reply-To: <20190920062544.180997-31-wangkefeng.wang@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 22 Sep 2019 14:07:21 -0700
Message-ID: <CAEf4BzbD98xeU2dSrXYkVi+mK=kuq+5DsroNDZwOzBGYbMH1-w@mail.gmail.com>
Subject: Re: [PATCH 30/32] tools lib bpf: Renaming pr_warning to pr_warn
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Andy Whitcroft <apw@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 20, 2019 at 10:06 AM Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
> For kernel logging macro, pr_warning is completely removed and
> replaced by pr_warn, using pr_warn in tools lib bpf for symmetry
> to kernel logging macro, then we could drop pr_warning in the
> whole linux code.
>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Martin KaFai Lau <kafai@fb.com>
> Cc: Song Liu <songliubraving@fb.com>
> Cc: Yonghong Song <yhs@fb.com>
> Cc: bpf@vger.kernel.org
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  tools/lib/bpf/btf.c             |  56 +--
>  tools/lib/bpf/btf_dump.c        |  20 +-
>  tools/lib/bpf/libbpf.c          | 652 ++++++++++++++++----------------
>  tools/lib/bpf/libbpf_internal.h |   2 +-
>  tools/lib/bpf/xsk.c             |   4 +-
>  5 files changed, 363 insertions(+), 371 deletions(-)
>

Thanks! This will allow to get rid of tons warnings from checkpatch.pl.

Alexei, Daniel, can we take this through bpf-next tree once it's open?

Acked-by: Andrii Nakryiko <andriin@fb.com>

[...]
