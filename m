Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74EF231238
	for <lists+bpf@lfdr.de>; Tue, 28 Jul 2020 21:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729540AbgG1TMH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Jul 2020 15:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbgG1TMG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Jul 2020 15:12:06 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CA8C061794
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 12:12:06 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id t6so4742479qvw.1
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2020 12:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8mjqLCPYN4/lsWkCTlTmUkF2RHJu424LAFvzHwy0I/Q=;
        b=kQspul9Us6I5DHoA06AQETBssY9kx+E649WEDrqUQ2h0SWKAdQZxXy6ORkrwnLTmrG
         UVYD6NOIwx3ljcHAfxRf2WitctNlakFlH6Rofrtk2RuUoq8BIX+2P3OsNXhPs2aTCKxM
         /jHqO5iA6zbgMk8pgdcHZqUCnQBQEbvKxAnTSTr6hmLN0dEjsLSrnC3cAqzToOp3uoss
         EHDSlxm0qplp2w0Trt6ZiJQnrG93wgkG8Wx6sF0xjfP300mYCgjbUiaU8/QjxK8kP90o
         QEcK+jioKaBAonHSQndSrUrurIDcA+KxWIY9hUjiBUL4W5sPSv3M82oxAtJq/yvPQhIZ
         x79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8mjqLCPYN4/lsWkCTlTmUkF2RHJu424LAFvzHwy0I/Q=;
        b=WcQzAf0cHcaELCb+DnTXr88aY80tjw7kEbqswLiVjLFtFzaYmLpa9RLBhVJWQQtnGl
         8Np3QEjDK1LUM6+Pc4GB1LsQnTL4FloIaoTXfd2YNCh8Vin/QXZKP6joKx/mIZA6wijk
         nKXM0wxrpqTzUUAjpQweS+gCvl5Ed/StH2YDBn6E/jpar55BT4NyxWM6EHeLRt0/xZ+5
         n5ij5piZWshAt5Q1OWRo+eRejlliFPjbUg0gj47CqT6CKik0RPJd6ehAu5RDkeqMtTlG
         NeEbpQVhby99bwFV+g/U8umGdtnN/q8mDzJ5WtKuaxQ9KFIbySNN5gR9Ntc24sVHEfC3
         +7nw==
X-Gm-Message-State: AOAM530baBpA7NBSERisx6lUybUkSlNZHjQzUHnvssGHASvoEf3dVTdU
        MkmQcbUdi2L6dnVJr/Xvua3XxN45Lt2/OSoZ20Q=
X-Google-Smtp-Source: ABdhPJwXnCRxZ3maJtAfeNFeiwsgb4pzc03mhHhrpX8ke3D8oL+FiXn7Fz5GHbTOvfeaf+ztA4hM3z/oduzUTNqWAbg=
X-Received: by 2002:a05:6214:8f4:: with SMTP id dr20mr27517819qvb.228.1595963525443;
 Tue, 28 Jul 2020 12:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200728120059.132256-1-iii@linux.ibm.com> <20200728120059.132256-4-iii@linux.ibm.com>
In-Reply-To: <20200728120059.132256-4-iii@linux.ibm.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 28 Jul 2020 12:11:54 -0700
Message-ID: <CAEf4BzaSJp-fOn2MG_8Fc2mo9ji5gZBLn2xCGyCiAmPbHkqSQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 3/3] libbpf: Use bpf_probe_read_kernel
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
> Yet another adaptation to commit 0ebeea8ca8a4 ("bpf: Restrict
> bpf_probe_read{, str}() only to archs where they work") that makes more
> samples compile on s390.
>
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---

Sorry, we can't do this yet. This will break on older kernels that
don't yet have bpf_probe_read_kernel() implemented. Met and Yonghong
are working on extending a set of CO-RE relocations, that would allow
to do bpf_probe_read_kernel() detection on BPF side, transparently for
an application, and will pick either bpf_probe_read() or
bpf_probe_read_kernel(). It should be ready soon (this or next week,
most probably), though it will have dependency on the latest Clang.
But for now, please don't change this.

>  tools/lib/bpf/bpf_core_read.h | 51 ++++++++++++++++++-----------------
>  tools/lib/bpf/bpf_tracing.h   | 15 +++++++----
>  2 files changed, 37 insertions(+), 29 deletions(-)
>

[...]
