Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C033A553271
	for <lists+bpf@lfdr.de>; Tue, 21 Jun 2022 14:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbiFUMrB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Jun 2022 08:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbiFUMrA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Jun 2022 08:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73746286C7
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 05:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655815618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N+Zc+zs/CTabWFdASR8nBFUHsR9XBPlUJlIq03EFu3E=;
        b=IiD+7ezlvf/XSTLaI2m29BYA6uJPg6/LgEBI91gSuR6mU2uxchziGwCpMzHA9aBIUH6W82
        d9c7P7puXbZKBP3d0Hq5UWBUYpMi1zgmw7FPyi17v/5QVSrdJDFSXzDaUYRVxN80RRnw6u
        v3fEdTFhUEKiw+qux+T/Vy7yavJxoOg=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-10-vluYtgQQP5C3-ICIUfKiZQ-1; Tue, 21 Jun 2022 08:46:57 -0400
X-MC-Unique: vluYtgQQP5C3-ICIUfKiZQ-1
Received: by mail-pj1-f71.google.com with SMTP id gi2-20020a17090b110200b001ecad6feb7cso2958043pjb.5
        for <bpf@vger.kernel.org>; Tue, 21 Jun 2022 05:46:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N+Zc+zs/CTabWFdASR8nBFUHsR9XBPlUJlIq03EFu3E=;
        b=wtgdcLqXqBbg3IC8w2gAlFjoLpoY/zi1wggxjKBJCRkaI95JcfTBDuhdJwLXkmK+G5
         zak2a0n4Pt4VDzkx4XeV3zsmX7Q5fm5hd54Vn4wVrMcQlrxnPdhD7jWX2R4di4oOwyxy
         FPo8X6FpUnfBCC7+r9/l/GB2J3UTaJ9MljY2U9dUKMDddy+XV8aGhYrE5/Wd3WDY3hdA
         rrCvrMe8joFx4+/AEawcvlmq7uox7SaMEBjc1UJ5g7FsP6Ediz3f5bPs2pr9W9cYgIBP
         XD+sXmERNolCwLx0D5ptZCR9Irvx/LBC1juyERCq1EmhgTvfGpQVVsEjGWlkV+4lu0xY
         yecA==
X-Gm-Message-State: AJIora++uotaIrtBQ4CAFvkb3J0FRzCz2d880m7VlLNVkAbswVMETbjw
        804BbJDwytkVGARECx+2Jyb+iNzAuH/0QcZjUDrVqdWtuscnQgdEbzHPFcP0HIcJ0500OKeF/O9
        s+TEg+bt+v38dcZWjAcF8sjPCowFu
X-Received: by 2002:a17:902:6946:b0:167:8ff3:1608 with SMTP id k6-20020a170902694600b001678ff31608mr28655456plt.116.1655815616299;
        Tue, 21 Jun 2022 05:46:56 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1teC0OkbDR7N7pOPAmvKa08vFkUWc/koR9zPlIJH29RZ+AlXdwjCmgImUHkgGInBsWhnUkoZ8Gqxeap7A+nWZw=
X-Received: by 2002:a17:902:6946:b0:167:8ff3:1608 with SMTP id
 k6-20020a170902694600b001678ff31608mr28655430plt.116.1655815616037; Tue, 21
 Jun 2022 05:46:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220621012811.2683313-1-kpsingh@kernel.org>
In-Reply-To: <20220621012811.2683313-1-kpsingh@kernel.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 21 Jun 2022 14:46:45 +0200
Message-ID: <CAO-hwJ+G6ZaNUFC-Qv7Lw2PQOEs0rV7r5ZD8FEAj0=+NVy5zYw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 0/5] Add bpf_getxattr
To:     KP Singh <kpsingh@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 21, 2022 at 3:28 AM KP Singh <kpsingh@kernel.org> wrote:
>
> v1 -> v2
>
> - Used kfuncs as suggested by Alexei
> - Used Benjamin Tissoires' patch from the HID v4 series to add a
>   sleepable kfunc set (I sent the patch as a part of this series as it
>   seems to have been dropped from v5) and acked it. Hope this is okay.

FWIW, this is perfectly OK with me.

The reason I dropped the patch from the series is because I don't
absolutely need it anymore: all of my sleepable kfuncs are now
declared as SYSCALL type, which is by definition sleepable.

I still believe it's valuable to be able to define sleepable kfuncs however.

Cheers,
Benjamin

> - Added support for verifying string constants to kfuncs
>
> Foundation for building more complex security policies using the
> BPF LSM as presented in LSF/MM/BPF:
>
>  http://vger.kernel.org/bpfconf2022_material/lsfmmbpf2022-xattr.pdf
>
> Benjamin Tissoires (1):
>   btf: Add a new kfunc set which allows to mark a function to be
>     sleepable
>
> KP Singh (4):
>   bpf: kfunc support for ARG_PTR_TO_CONST_STR
>   bpf: Allow kfuncs to be used in LSM programs
>   bpf: Add a bpf_getxattr kfunc
>   bpf/selftests: Add a selftest for bpf_getxattr
>
>  include/linux/bpf_verifier.h                  |  2 +
>  include/linux/btf.h                           |  2 +
>  kernel/bpf/btf.c                              | 42 ++++++++-
>  kernel/bpf/verifier.c                         | 85 +++++++++++--------
>  kernel/trace/bpf_trace.c                      | 36 ++++++++
>  .../testing/selftests/bpf/prog_tests/xattr.c  | 58 +++++++++++++
>  tools/testing/selftests/bpf/progs/xattr.c     | 37 ++++++++
>  7 files changed, 223 insertions(+), 39 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/xattr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/xattr.c
>
> --
> 2.37.0.rc0.104.g0611611a94-goog
>

