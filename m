Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5B249BD84
	for <lists+bpf@lfdr.de>; Tue, 25 Jan 2022 21:53:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbiAYUxc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Jan 2022 15:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbiAYUxE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Jan 2022 15:53:04 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE03FC061744
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 12:53:03 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id e81so33523699oia.6
        for <bpf@vger.kernel.org>; Tue, 25 Jan 2022 12:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=Fq8x8ml7RGTMF1BNhU+21LQjT13NU5BwcX2axrLdABU=;
        b=K6cIcUJLN7E85by1UH5ucmSC9v6Y24s89Ctc2Oa8c0fFSihKhvEWFQQzsGUjDK2vH1
         ZVafi/DTHadG1/WzwKStDISboHIH/Hd6bt2bEQoAhIFmhlZrfps7PDx8vYla3ss+u0UP
         0A82qjjTrveNHUEkpE3n++22QotfZIzMLJfvjVxOwOiOJO1Sqh5Ux5H3g9bbiuEeOn7+
         d3msRmx46oB3s7CBsFsUW5n5OgJUIkVWArmBoy9EZyUA675nJWYO/1JV7/mdfRGJ76YR
         EWN2Y4KLqYU/LSnmSckllZowNtXHLoRDEIJX7fq+ysgbUVyhcVERN8syEys9XnLAivJ1
         Jf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=Fq8x8ml7RGTMF1BNhU+21LQjT13NU5BwcX2axrLdABU=;
        b=WvbPI29+9H6xfHcfPzqzcUaJ+buQOXxW9UT23SkgU0Qqjo/0zEKNfIhqDdyA9xR0+S
         VmvAhgPldOUNEK7vlOED1EPVzNGbhF/w4b8Z/GYMUEQF5L4qjsrRKdNz49JyTAUIhklf
         uQN8uuv9LPhWTkQ32oY3FJs3irDxlwZfdbl0/9XIG4DfcjKYwX+s/mzHPGTjWd/X3D/q
         6n1oCxIv5aO3Ew4nx8Vhu6zVsFZ+a3q/KxJHEi5sxdv/255ruC0s3MkPlloWUPBqYbkf
         fgpOIui4EIv4Jy1pvFlzSCmQwZ5UEoZjCDUdiMNa/3Yn+YnkvHH6uVLtRvUatRVXcgRT
         v+9A==
X-Gm-Message-State: AOAM533DY8u78yO7WVjlT45voHkdSd5vfOsta/v6zN3mAWVP+F4NxyuM
        VjI/QSXm+q2S1bDr4rsmqQk=
X-Google-Smtp-Source: ABdhPJwKMPZQaUbnuIz8OZSND+Cgkoqe5h0yFIlZcuAlO7L76G/zNTIn9o6av+Cnobo6MYu45UXp4Q==
X-Received: by 2002:a05:6808:1381:: with SMTP id c1mr1650810oiw.271.1643143983333;
        Tue, 25 Jan 2022 12:53:03 -0800 (PST)
Received: from localhost ([99.197.200.79])
        by smtp.gmail.com with ESMTPSA id t20sm6333339oov.35.2022.01.25.12.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 12:53:02 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:52:56 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     andrii@kernel.org, kernel-team@fb.com
Message-ID: <61f0632858dd3_2e4c520882@john.notmuch>
In-Reply-To: <20220120060529.1890907-1-andrii@kernel.org>
References: <20220120060529.1890907-1-andrii@kernel.org>
Subject: RE: [PATCH v2 bpf-next 0/4] libbpf: deprecate legacy BPF map
 definitions
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Andrii Nakryiko wrote:
> Officially deprecate legacy BPF map definitions in libbpf. They've been slated
> for deprecation for a while in favor of more powerful BTF-defined map
> definitions and this patch set adds warnings and a way to enforce this in
> libbpf through LIBBPF_STRICT_MAP_DEFINITIONS strict mode flag.
> 
> Selftests are fixed up and updated, BPF documentation is updated, bpftool's
> strict mode usage is adjusted to avoid breaking users unnecessarily.
> 
> v1->v2:
>   - replace missed bpf_map_def case in Documentation/bpf/btf.rst (Alexei).

LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>

> 
> Andrii Nakryiko (4):
>   selftests/bpf: fail build on compilation warning
>   selftests/bpf: convert remaining legacy map definitions
>   libbpf: deprecate legacy BPF map definitions
>   docs/bpf: update BPF map definition example
> 
>  Documentation/bpf/btf.rst                     | 32 ++++++++-----------
>  tools/bpf/bpftool/main.c                      |  9 +++++-
>  tools/lib/bpf/bpf_helpers.h                   |  2 +-
>  tools/lib/bpf/libbpf.c                        |  8 +++++
>  tools/lib/bpf/libbpf_legacy.h                 |  5 +++
>  tools/testing/selftests/bpf/Makefile          |  4 +--
>  tools/testing/selftests/bpf/prog_tests/btf.c  |  4 +++
>  .../bpf/progs/freplace_cls_redirect.c         | 12 +++----
>  .../selftests/bpf/progs/sample_map_ret0.c     | 24 +++++++-------
>  .../selftests/bpf/progs/test_btf_haskv.c      |  3 ++
>  .../selftests/bpf/progs/test_btf_newkv.c      |  3 ++
>  .../selftests/bpf/progs/test_btf_nokv.c       | 12 +++----
>  .../bpf/progs/test_skb_cgroup_id_kern.c       | 12 +++----
>  .../testing/selftests/bpf/progs/test_tc_edt.c | 12 +++----
>  .../bpf/progs/test_tcp_check_syncookie_kern.c | 12 +++----
>  15 files changed, 90 insertions(+), 64 deletions(-)
> 
> -- 
> 2.30.2
> 


