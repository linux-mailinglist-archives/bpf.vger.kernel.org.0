Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B68403208
	for <lists+bpf@lfdr.de>; Wed,  8 Sep 2021 03:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344112AbhIHBDu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Sep 2021 21:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345534AbhIHBDn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Sep 2021 21:03:43 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDEAC061575
        for <bpf@vger.kernel.org>; Tue,  7 Sep 2021 18:02:37 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id q70so716616ybg.11
        for <bpf@vger.kernel.org>; Tue, 07 Sep 2021 18:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yq4co9EYbYaCdu4YPu/qO77bS2KvW97AxKfl/zEey3M=;
        b=duhWhdRc5kL4Bcv4YJOXmoK2TgOk/11kYi++a9m7F3qONS7ytYnC1GrPhx2r/Q8ELX
         zMeb+gXJ3GTYTHqOdkoNhVxWpS3JT0/3JwKEDXrktpKcrJCPrVMG07opY/ea9daIvckJ
         EM9ycUsCrZkPVVO0bx6kNWsmpAbPOrH+Ov4rhVPd4zuzz0Lonrxf5/wGPkILFGopIk49
         5kZQnf6O/LCvUJvwslAHaJ+uqg1Azj41+l809q9LQ6pArUE+Kim8O7287ZMkZZZMbyMy
         iGyT8nQNSm/KBm/ibcMiXO1SvQjojFt9CTz9vRKluiy24/XN7t7wWBYXS4d2YMqt9/pO
         gJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yq4co9EYbYaCdu4YPu/qO77bS2KvW97AxKfl/zEey3M=;
        b=Bl8hFLEoBxgkFKWBHBldoEvWAEFS98eD5ZNQx26s/SyLY+5bn6vIcZ4cJW9EP2naL8
         TW8PlBTBxFwQpjRr/zVVZDIGHzwputZWWVYGTEvolzPfv1AtgtoORhrXz3fsEMtjODma
         eJSG0G+LGyjh0Ehnwi8AefyAksDvGAeYG17VuCSJSWn1lVvrIfVAddAdatQ4H44gnRPa
         LlqKNQU5UVrpcMPXMvfE3eh1yyUVCocw0PhDic2OnA6fAhlc0mQoPgvouS3V34KLhaQc
         0iPpPbo0JEXgsWWa0scGbPPtPOwymD8DfTIQv1EKKQCCoC+JewGIiDPQ5fsuCgjPO+Qx
         3aFw==
X-Gm-Message-State: AOAM531wR3acyRsQaKqozsItuYeoJKCxP2i/FYd8lIsFP63/pZyi/5Cw
        T/7C6bUSwpVxAU2kQSoG9hHFpoiG7yzSM20HcboYWzov
X-Google-Smtp-Source: ABdhPJyU2JVHSeUZRfiEl+iuD5DnFdOwHsXK0CZ1Bu7jO22UGGCAe4xjkQameyzR7VWjvVy0QCQIKCJbymNIXWe3RkQ=
X-Received: by 2002:a5b:7c4:: with SMTP id t4mr1588381ybq.368.1631062956265;
 Tue, 07 Sep 2021 18:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210901194439.3853238-1-alastorze@fb.com>
In-Reply-To: <20210901194439.3853238-1-alastorze@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Sep 2021 18:02:25 -0700
Message-ID: <CAEf4BzaLcWctJVHgk3F0C1hQNh5qs9RUGZKDFYm0xvJrGW7OuA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/3] Bpf skeleton helper method
To:     Matt Smith <alastorze@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        andriin@kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 1, 2021 at 1:25 PM Matt Smith <alastorze@fb.com> wrote:
>
> This patch series changes the type of bpf_object_skeleton->data
> to const void * and provides a helper method X__elf_bytes(size_t *sz)
> for accessing the raw binary data of the compiled embedded BPF object.
>
> The type change enforces the previously implied behavior of immutability
> for this field while casting it to (void *) before assignment allows
> for compiling with previous versions of the libbpf headers without
> compiler warnings.
>
> The helper method allows easier access to the BPF binary object data
> and is leveraged to populate the skeleton field.  The inclusion of
> this helper method will allow users to get access to the data without
> needing to populate an entire skeleton first.
>
> Checks are added in the third patch to validate the behavior of the
> added method
>
> Matt Smith (3):
>   libbpf: Change bpf_object_skelecton data field to const void*
>   bpftool: Provide a helper method for accessing bpf binary data
>   selftests/bpf: Add checks for X__elf_bytes skeleton helper
>
>  tools/bpf/bpftool/gen.c                       | 39 ++++++++++++-------
>  tools/lib/bpf/libbpf.h                        |  2 +-
>  .../selftests/bpf/prog_tests/skeleton.c       |  7 ++++
>  3 files changed, 32 insertions(+), 16 deletions(-)
>
> --
> 2.30.2
>

Fixed \n\ alignment and made a few small tweaks. Applied to bpf-next, thanks.
