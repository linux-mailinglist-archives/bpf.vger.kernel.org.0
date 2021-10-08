Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC9942665E
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 11:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233947AbhJHJPg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 05:15:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45428 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229853AbhJHJPf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 05:15:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BWLsWfH2JEyNjbtC+2PoK+MShYND9fy9GRvh7JRHRqk=;
        b=B0IqLErgnuZs/NnztUTTyKBIJ6jsrhPKjmApCpE/6QcIoWXiZdYWln9M9ZfXsLDJYuF4Wl
        e5j+NOao+7vJhMkxHdSlweCHCviqlv2TdoTfSu4tLnZEKhOPeXcszaoRUYRoG3Qe1aS5S/
        I73qT106CbWiQbGItnial0/gIkXfIUg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-4u1_UWXMNaGIcWl_wmaUYg-1; Fri, 08 Oct 2021 05:13:39 -0400
X-MC-Unique: 4u1_UWXMNaGIcWl_wmaUYg-1
Received: by mail-wr1-f72.google.com with SMTP id e12-20020a056000178c00b001606927de88so6785670wrg.10
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 02:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BWLsWfH2JEyNjbtC+2PoK+MShYND9fy9GRvh7JRHRqk=;
        b=5jUOjuDwBgR5kGXLPYG1jIWya04h6jEqcD3qvALeJph8SvE/ZLYbqXs5pRvshdnLql
         CbAC8+Www3GaqnpmwSg9s8F8fVhUSW82A/woeVDkQ2xD6FvHh3RtTBz+h919ZZOIOblg
         FNmfthem2p1M7qUXt71T6IFBr9S1nqxg9bN/iXXDreS1n9M8qBLDCDu/V9CQdFqTVlgr
         VyIaeiOyOqyyuCsBz2fzDdI/YazYWqwvqK/+xIypvQaL1QgkVlPK+7E5c99G0/5484IF
         fcA8aUgztP+ShGFKT+AA/UUQtz5dNwn6AqovMQZLVmL+G+FbmluxVn2X7mTVuhCnrqkx
         aYIQ==
X-Gm-Message-State: AOAM530mfoiWlU74A7P8CBd7ugpBbeijJkZ6JBBY84C2vWbvsg26sXaH
        cvILwn3oKtEJO4zqldapm3HShTCjFwoiXFdqmKpnYOr8GmtNjXIBHsDSvAWsqnp27BTzkaPXKBh
        0aH4Gt1S7u8Hd
X-Received: by 2002:adf:aad7:: with SMTP id i23mr2465632wrc.209.1633684417893;
        Fri, 08 Oct 2021 02:13:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuiMCcZOeyZMSLntyh7cBGuXHI088A/avMoZ7Y/sQl/GVYDmFrp8EahVJLgIj1BR72iJKxqg==
X-Received: by 2002:adf:aad7:: with SMTP id i23mr2465615wrc.209.1633684417713;
        Fri, 08 Oct 2021 02:13:37 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id c5sm11385326wml.9.2021.10.08.02.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:13:37 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCHv2 0/8] x86/ftrace: Add direct batch interface
Date:   Fri,  8 Oct 2021 11:13:28 +0200
Message-Id: <20211008091336.33616-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

hi,
adding interface to maintain multiple direct functions
within single calls. It's a base for follow up bpf batch
attach functionality.

New interface:

  int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
  int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
  int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)

that allows to register/unregister/modify direct function 'addr'
with struct ftrace_ops object. The ops filter can be updated
before with ftrace_set_filter_ip calls

  1) patches (1-4) that fix the ftrace graph tracing over the function
     with direct trampolines attached
  2) patches (5-8) that add batch interface for ftrace direct function
     register/unregister/modify

Also available at (based on Steven's ftrace/core branch):
  https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  ftrace/direct

v2 changes:
  - added comments to API functions
  - move common cleanup code to new remove_direct_functions_hash
    function
  - added addr argument to unregister_ftrace_direct_multi API,
    to properly cleanup direct_functions hash
  - added missing unregister_ftrace_direct call to trampoline/graph
    selftest
  - added comment to modify_ftrace_direct_multi about non-callback
    gap between ftrace_shutdown and ftrace_startup

thanks,
jirka


---
Jiri Olsa (6):
      x86/ftrace: Remove extra orig rax move
      tracing: Add trampoline/graph selftest
      ftrace: Add ftrace_add_rec_direct function
      ftrace: Add multi direct register/unregister interface
      ftrace: Add multi direct modify interface
      ftrace/samples: Add multi direct interface test module

Steven Rostedt (VMware) (2):
      x86/ftrace: Remove fault protection code in prepare_ftrace_return
      x86/ftrace: Make function graph use ftrace directly

 arch/x86/include/asm/ftrace.h        |   9 +++-
 arch/x86/kernel/ftrace.c             |  71 +++++++++++++++---------------
 arch/x86/kernel/ftrace_64.S          |  30 +------------
 include/linux/ftrace.h               |  26 +++++++++++
 kernel/trace/fgraph.c                |   6 ++-
 kernel/trace/ftrace.c                | 268 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 kernel/trace/trace_selftest.c        |  54 ++++++++++++++++++++++-
 samples/ftrace/Makefile              |   1 +
 samples/ftrace/ftrace-direct-multi.c |  52 ++++++++++++++++++++++
 9 files changed, 420 insertions(+), 97 deletions(-)
 create mode 100644 samples/ftrace/ftrace-direct-multi.c

