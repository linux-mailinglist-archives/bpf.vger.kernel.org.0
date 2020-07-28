Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2C5231434
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 22:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgG1UsS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 16:48:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:34408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728202AbgG1UsS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 16:48:18 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B37392070B
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 20:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595969298;
        bh=kBixs23XUtecrIkNXzTXtaKENi+WX/WG1vdCmp9gbXg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2en8HXZ4wyKGdCVJ1ItLCYW1QwksqiibAJHpxDnUMaZx2Bx7f348nk82CJIJ6blfL
         DNrDlJTsE9l+kwyJ4DX9pE0RKXWmH6cUiqXcIdNQNZUUlvMQ470OiZnsMu0sEtpo8j
         9EKMocMZwmo6C9iKHKIl8E8p1RS7Y8gyzR5iyEYQ=
Received: by mail-lj1-f171.google.com with SMTP id q6so22655090ljp.4
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 13:48:17 -0700 (PDT)
X-Gm-Message-State: AOAM531IUTt+TQPu7e8ehWUr5qpxQEGoGOIee3HZHuF78vJHq3aUvAOH
        f1FV4QwdBEho8LSLBWJZQF07s9djFXzHVBVccMI=
X-Google-Smtp-Source: ABdhPJx8BXwO/pwjUa6h99YT3R96p5bfOykP2a4XXB4oywCEFpgFPHxN4sPZ98fWnBQ7w8MozC6JALTcrQa5vJHvZbI=
X-Received: by 2002:a2e:88c6:: with SMTP id a6mr13303567ljk.27.1595969296038;
 Tue, 28 Jul 2020 13:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200728120059.132256-1-iii@linux.ibm.com> <20200728120059.132256-2-iii@linux.ibm.com>
In-Reply-To: <20200728120059.132256-2-iii@linux.ibm.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 28 Jul 2020 13:48:04 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4OkZ0CPk0=Foem-BnUP3FGSL-ffuO-+euW1gNWhupghA@mail.gmail.com>
Message-ID: <CAPhsuW4OkZ0CPk0=Foem-BnUP3FGSL-ffuO-+euW1gNWhupghA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] samples/bpf: Fix building out of srctree
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jul 28, 2020 at 5:15 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> Building BPF samples out of srctree fails, because the output directory
> for progs shared with selftests (CGROUP_HELPERS, TRACE_HELPERS) is
> missing and the compiler cannot create output files.
>
> Fix by creating the output directory in Makefile.

What is the make command line we use here? I am trying:

   make M=samples/bpf O=./xxx

w/o this patch, make created ./xxx/samples/bpf.

Did I miss something?

Thanks,
Song
