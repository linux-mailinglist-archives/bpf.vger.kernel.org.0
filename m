Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094486D55D7
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 03:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDDBZn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 21:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjDDBZZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 21:25:25 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7C710FE
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 18:24:51 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id bm13so6297548pfb.5
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 18:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680571491;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LI/tEczA6Rhcpyhx7Bvkym4xdN2PbafQMXp0NregYho=;
        b=BWvclCCWQKumjbY6gcg9t72FY9AfqJRsjun5d1wh7i+56oegv0KGRcHByg23yStozv
         OM/2mIFBQugdWDs6pbZ8KClu4K6B2H81PoMXQNUXCnqXaggD7I2DHONKWhYBxla8tjpt
         9uWDqfCeooxBlMiNn8tgJZU4XE+ky0iEFo0O42teXvC2g4oMGY+gOhTKoL4FuRhZ5JVL
         pOKPNPKvCADNgqoaQeBoydpXFplfpf2gAPnAFtB1uog7zUWE0RqaQwPZRLcJH/ZC4fMT
         MmYjuRQ1hb66cag7eFqx2kZs4DSycq3n9dPC/nyWBEEJgZ1O82zc43x1QUUoauSUQQAl
         Cnqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680571491;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LI/tEczA6Rhcpyhx7Bvkym4xdN2PbafQMXp0NregYho=;
        b=7/9DhydqroRdky/Avk4dg6dJGWn0mbjtVQ5YpYks72NxdsuK94vgXgsaXCFBt7RLbW
         Odh5USTu1gXKJ4OPctJeGoThPhvlbABaMHxu0Rv+Fqo8JI62+nAgb2h+F5QuONV7yA7O
         I1gUHoPsToLEkIrR/mIJb/0d90LUGsAncjcbcMzizu23/BLuKAMdZe+/aWV3Godcua2K
         6oB/lN//6XY4BHiyWAgc7f8iqV+smb50WMB0Scae7PuvC+50GWS404JTJLChiItgswHO
         +5+YRG8OgaMOeGMRPGpoKgnRcrRoGNkzKaQLM22I7v2HSEW84zjY4wOHZTpO0CadefOb
         0Lbw==
X-Gm-Message-State: AAQBX9fy0f/bxtVFsK6PbmeiiyPANVKI5AgC9ruAo6pKO353PxDq5oSY
        mnjDPN13jNZcxQ1LO+oHqi5OHoA2eFlBS4l3BRt7qDMiKkDsM9OEfAdjhjHd
X-Google-Smtp-Source: AKy350aSaRALubc54PJRKaxcZg05uGa6/tNokEpOE+/MjFNjpPw/BzCNhYW44csvVnT14PM2zvOUrPqhMVCvQwKDd5E=
X-Received: by 2002:a05:6a00:a1c:b0:62d:e8f1:edbf with SMTP id
 p28-20020a056a000a1c00b0062de8f1edbfmr300878pfh.5.1680571490690; Mon, 03 Apr
 2023 18:24:50 -0700 (PDT)
MIME-Version: 1.0
From:   Daniel Rosenberg <drosen@google.com>
Date:   Mon, 3 Apr 2023 18:24:39 -0700
Message-ID: <CA+PiJmRwv8UTyQuEBmn1aHg5mXGqHSpAiOJF0Xo9SwZLfW623A@mail.gmail.com>
Subject: Dynptrs and Strings
To:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>
Cc:     Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

For Fuse-BPF, I need to access strings and blocks of data in a bpf
context. In the initial patch set for Fuse-BPF [1] I was using
PTR_TO_PACKETs as a stand in for buffers of unknown size. That used
start and end pointers to give the verifier the ability to statically
check bounds. I'm currently attempting to switch this over to using
dynptrs for buffers of variable length, but have run into some issues.

So far as I can tell, while a dynptr can have a variable size, any
time you interact with a dynptr, you need to already know how large it
is. For instance, bpf_dynptr_read reads the dynptr into a local
buffer. However, that buffer may not be larger than the dynptr you're
reading. That seems pretty counter intuitive to me.
bpf_dynptr_check_off_len ensures that the length passed in is not
longer than the dynptr. This means I can't, for example, have a buffer
that could support NAME_MAX characters, and read a dynptr into it. I
assume this is to ensure that the entirety of the buffer is
initialized. If that's the case, I could create a variant that zeroes
out the remaining buffer area.

One workaround I've considered is attempting to read to the minimum
length of string I'm comparing against, treating read failures as a
nonmatching string. Then I could read any additional space for larger
comparisons afterwards. This would mean one call to dynptr_read for
every string length I'm checking against.

The bpf_dynptr_slice(_rdrw) functions looks nearly like what I want,
but require a buffer that will be unused for local dynptrs.
bpf_dynptr_data rejects readonly dynptrs, so is not a suitable
replacement. It seems like I could really use either a
bpf_dynptr_data_rdonly helper, or a similar kfunc, though I suspect
the kfunc will require some additions to the special_kfunc_set.

One alternative I'm looking into is providing kfuncs that perform the
requested operations. That allows checks to happen at runtime.
However, I'm having some difficulties working with strings as kfunc
arguments. There is an existing helper function bpf_strncmp, which
uses one constant argument which ends up interpreted as a
PTR_TO_MAP_VALUE. To make a kfunc, I assume I'd need to add another
special kfunc and then adjust the expected types.

Any of these solutions that use fixed sizes ignore cases where I may
need to compare two strings, neither of which is a constant string
known at compile time.
How should I go about using possibly read-only dynptrs whose lengths
are only known at runtime?

[1] https://lore.kernel.org/bpf/20220926231822.994383-1-drosen@google.com/


-Daniel
