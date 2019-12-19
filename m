Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0041270E2
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2019 23:48:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfLSWsT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Dec 2019 17:48:19 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44072 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSWsT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Dec 2019 17:48:19 -0500
Received: by mail-qk1-f196.google.com with SMTP id w127so6030326qkb.11
        for <bpf@vger.kernel.org>; Thu, 19 Dec 2019 14:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/XlMYuAWe99Qbj4KvKqgiv835zxVu0mJXn+Y6HJ71BU=;
        b=JE+yW+ExTEngLhBL6puf+HVsTn9AI84SbOAs0/I9vQ3GPmCIGr9/khd4TIPG8x6w67
         jed4DfO71r4T10Fm5h8lSup6pZRhVnllwryOqtbGscjbE/SBZiRo9oE+9YyaWqudeew/
         qAvcx3MH2P2R8TxAH6qxaLjee4BV8+39waKTb9iimzmdRuqfcmun3GGUvnXZbpGtMUEY
         /hQZ35RJIljYB5hUErebQVqas0UGQk6FFKJ4JvnT35zhQtMQyzgKpY592TVmL2RDukpq
         eBu0faPAQVMKMd5YDhCHyyiAAh/2RC/9TYB1CrvsdukcbyP1MZRdv5UZ8CNelBYC/krL
         iq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XlMYuAWe99Qbj4KvKqgiv835zxVu0mJXn+Y6HJ71BU=;
        b=U09OE2Mi4GCTgB+p/RHFuvRWf5IRzlz79cuc9Dk26uSyT1vB6aLPVE0gL6jX3oxvOe
         zl351iyOwCroDtLLkSf0JnsKW+pzc5vI77oHTDI0m6AOn8JS/JzBxsFFN9kwGrOtrPTq
         4mugkBoCfvyJxFsASQs0cBJ8EJ5dhOSYjv98FA5oUKaBDK7cvg/nH0Zd1gPF/kWlSQ3R
         z96sYEyHE3wtbIQWOWibqyaZa6w5LpmSvC9i+Q2/ZkQXRjZHqjQCfm7aNVPjNLS6t1bD
         dOk1WyWEa4FooqdegTK3aOiCpv1maALNQML5aoey0N2MQLE0i/S16bpa64ktsqwLWKwf
         zFZA==
X-Gm-Message-State: APjAAAXDg908s70DUONVzAdHyTYgifUi3achqUF8HHhEgypGTO7MlA1I
        doXRqHWkX1lW7iO3kkFM6bqDjqUHYIFvT8eEaoU=
X-Google-Smtp-Source: APXvYqz5LCWIachsgbHWVW3AWmJbTXiEeiDRiHNliJKtPiswEGD8UCebFm4FI60Uy5JiYFTCTih58dmsWLUuy1hnq/k=
X-Received: by 2002:a05:620a:5ae:: with SMTP id q14mr10889282qkq.437.1576795698269;
 Thu, 19 Dec 2019 14:48:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1576741281.git.rdna@fb.com> <7b9b83e8d5fb82e15b034341bd40b6fb2431eeba.1576741281.git.rdna@fb.com>
In-Reply-To: <7b9b83e8d5fb82e15b034341bd40b6fb2431eeba.1576741281.git.rdna@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 19 Dec 2019 14:48:07 -0800
Message-ID: <CAEf4BzZ_48vOHeq7v1CwZGsCofMiDnq5n=dOzONnDLWicr+0Ug@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 6/6] selftests/bpf: Test BPF_F_REPLACE in cgroup_attach_multi
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
> Test replacing a cgroup-bpf program attached with BPF_F_ALLOW_MULTI and
> possible failure modes: invalid combination of flags, invalid
> replace_bpf_fd, replacing a non-attachd to specified cgroup program.
>
> Example of program replacing:
>
>   # gdb -q --args ./test_progs --name=cgroup_attach_multi
>   ...
>   Breakpoint 1, test_cgroup_attach_multi () at cgroup_attach_multi.c:227
>   (gdb)
>   [1]+  Stopped                 gdb -q --args ./test_progs --name=cgroup_attach_multi
>   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
>   ID       AttachType      AttachFlags     Name
>   2133     egress          multi
>   2134     egress          multi
>   # fg
>   gdb -q --args ./test_progs --name=cgroup_attach_multi
>   (gdb) c
>   Continuing.
>
>   Breakpoint 2, test_cgroup_attach_multi () at cgroup_attach_multi.c:233
>   (gdb)
>   [1]+  Stopped                 gdb -q --args ./test_progs --name=cgroup_attach_multi
>   # bpftool c s /mnt/cgroup2/cgroup-test-work-dir/cg1
>   ID       AttachType      AttachFlags     Name
>   2139     egress          multi
>   2134     egress          multi
>
> Signed-off-by: Andrey Ignatov <rdna@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andriin@fb.com>

>  .../bpf/prog_tests/cgroup_attach_multi.c      | 53 +++++++++++++++++--
>  1 file changed, 50 insertions(+), 3 deletions(-)
>

[...]
