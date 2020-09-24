Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6374B277ADD
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 22:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgIXU6W (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 16:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIXU6V (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 16:58:21 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC256C0613CE
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 13:58:21 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id a2so450128ybj.2
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 13:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QzbuBNxK3wNeLlJKjch49BJLwKYi7d7SS39OGGSKCPo=;
        b=PVedTV5vWy3Dp+by926iz3FI+vmTrZZhOtzKlV7wKYH773PeIvGWrFfqS/QHs/JpF1
         CVq0Z3Py9lzMacs5BhxiW1LDQbtF7+aD76yYIZIezRdgpL+jMu+C2J4As7fBJSLPR3J8
         kuPwEcR8TUYIYtH9HtWPJ9cymOdCz3NDnvqvyBgQUyGsHk7LUmA0o5o55NF6eBJuv4Nj
         aEl2QSEc9fLYUNg03R8NwDl5+6wShclguxDZOyr2+qmSMfUv/KkLcl/l2Ix4MZutpKAL
         MqtCpb9j67zlAcRUk0uraFp0Mgp9XdvEOqknP/nKZIB9rke9CeN2Xk7mf33GWjtoDCH9
         roNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QzbuBNxK3wNeLlJKjch49BJLwKYi7d7SS39OGGSKCPo=;
        b=YezQMirobl8w7QhhZSSIjmhAVyuvDLAsa01dh1hU9B4iXJ8NP7lYs0mcV+1vtuvzSU
         ZT1jd69yBY2mtggXKk0g50ef/Aw92Z7da9/6LMeVDn1lkrKFbu3liSl58YxsMBibJkBv
         ASrSWdysqHZiw/mf/2kwYOcAVYDLX+AP6JjouUq5GvjftH6IIfrIaEv1+5SORh6Oq5mG
         Nj5RW1RB+z3TLjqcd63eTa09w1QVztWylLG0P5nP5/080a4hqM1mVNWZklcA5wv8PMOT
         adEOL1xT/UkDbSo1hw9P9RD2o+a9qa0/IWIFJChWinpPbtFT8b2TYJG5iMHZjYxhiXv4
         8JUQ==
X-Gm-Message-State: AOAM5327vSS5W58vuy4V7d+1K/32KLi2ARtZOkcg6ka064eEcsVqbnpy
        hALgc4zgpqPpKu4qANe8utx6+PwH3DAzeL0UkyQ=
X-Google-Smtp-Source: ABdhPJwpyrBi3lVLcc4jkqyOKSggeDKHIsehyR3orBkUHpW0e8cs97bblR6DcQroE+nM4ndJt4dJV8KplLuAKaK8vcw=
X-Received: by 2002:a25:8541:: with SMTP id f1mr900224ybn.230.1600981100990;
 Thu, 24 Sep 2020 13:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200923210959.95921-1-iii@linux.ibm.com>
In-Reply-To: <20200923210959.95921-1-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 24 Sep 2020 13:58:10 -0700
Message-ID: <CAEf4BzZh39iuF3=YPCkzboPUXMzPe7wmMNkT-0KewUrfEw9ZJQ@mail.gmail.com>
Subject: Re: [PATCH RESEND bpf-next] selftests/bpf: Skip some verifier tests
 on BTFless kernels
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 23, 2020 at 2:10 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Mark seven tests as requiring vmlinux btf. Check whether vmlinux btf is
> available, and if not, skip them.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>

Ok, given no one objects, I'll ack this. test_progs won't succeed if
kernel is built without BTF, so in environment where we test these
tests will always run.

Acked-by: Andrii Nakryiko <andriin@fb.com>

> Resending due to patchwork having missed the original submission:
>
> https://lore.kernel.org/bpf/20200921184219.4168733-1-iii@linux.ibm.com/
>

[...]
