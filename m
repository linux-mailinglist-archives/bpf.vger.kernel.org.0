Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A6A44E044
	for <lists+bpf@lfdr.de>; Fri, 12 Nov 2021 03:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhKLC3Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 21:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbhKLC3Z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 21:29:25 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BED6C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 18:26:35 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id y1so7224122plk.10
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 18:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=jg8T2SnQ6iLy7JP57Lnsl6uAObuUeGWr5YxqLf6oiWk=;
        b=NBDVXOK1XHhgBEPRgmk3eXQJcThGg7Iri1F8bjM4ns9qd3TKS0P3AdZS+Z/tW3GpWP
         jzPSgZOnl1bVAcnp0sjeDX+uaqEl7eRVHXcospqWiKEqn9OCE/NpA/b2MX9It9GrCAxK
         zYtFk0vvfSS2tDuMaD+sa7LZ0lNA9Vyb0vldgZA2McKslZfy8KImHAuV/bDvPrjuJxMS
         PJo9FZ0pPLPuJV+wuwE8apShsHPKJQ72el8kF3FXZZMVV0k5HatqhKH0N7vTA2Zkx4XM
         d+yLanP7TcEjfzXM+IQqIWwlhIIKm/IDYdLBxSiGcVuCC9/QS7+8MVYV1lpKCjqBlM7D
         he/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jg8T2SnQ6iLy7JP57Lnsl6uAObuUeGWr5YxqLf6oiWk=;
        b=6cSN3IVlRN+CVKMDsQNGe/BPNyOhvccH0OkBu+R3sp5FEC5N0dR4JyTfc3eZK61umX
         qfnqH2+X+yHjZYMfI+sjgt+ESjk/cDPXDxI/kkUBWL9VIu5/S2CcQKqvzNq948ut2l0O
         cwwRsw+hrkOoH1niMgEgKkVCHM3XYVf+uRNsKj9MhYB6/oE5CLxcaIcqxSNxVuggASmi
         W5zCj1T8WjMnjPe64enPjKDyw2blJcwqftFrUGBGp1N3mAdv0qeGhDsjPHnRMT9CJUBe
         4Nx/jhfsmMQfIyD5zHaYi7I8z7ipalP0HpgnnvjemGkLtdEOM41a0jyl6hojL1wstHSt
         a3MA==
X-Gm-Message-State: AOAM532GAWeYlmzymfyxfUMEjXXG5enrXUDGbUwWYCUBk8Dhqu63z2ni
        tL/F7QLtXnjyqXdqvS8SK8z8+pKVbVQgo3u2Ml0=
X-Google-Smtp-Source: ABdhPJzQ/Gi6yrlImPIrMA2jlRq/dBkU6J0v6NQCPfDaU69n3n9kZqsJgeGMYodV/qv3qFklQAZBMkIM/X81O4mLPBI=
X-Received: by 2002:a17:90b:4c03:: with SMTP id na3mr13782545pjb.62.1636683994534;
 Thu, 11 Nov 2021 18:26:34 -0800 (PST)
MIME-Version: 1.0
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 11 Nov 2021 18:26:23 -0800
Message-ID: <CAADnVQJ6jSitKSNKyxOrUzwY2qDRX0sPkJ=VLGHuCLVJ=qOt9g@mail.gmail.com>
Subject: fd leak in lskel
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kumar,

I think I noticed a small regression:

$ bpftool prog load -L ./test_ksyms_module.o

will print:
"loader prog leaked 2 FDs"

That's a builtin sanity test in bpftool that checks
that loader prog is doing the right thing.
I suspect the cleanup path of ksym patches is leaving FD opened.

$ cat /sys/kernel/debug/tracing/trace_pipe
         bpftool-1356    [002] d..21   175.537998: bpf_trace_printk:
btf_load size 1895 r=5
         bpftool-1356    [002] d..21   175.538085: bpf_trace_printk:
map_create test_ksy.bss idx 0 type 2 value_size 4 value_btf_id 32 r=6
         bpftool-1356    [002] d..21   175.538108: bpf_trace_printk:
update_elem idx 0 value_size 4 r=0
         bpftool-1356    [002] d..21   175.538165: bpf_trace_printk:
map_create test_ksy.rodata idx 1 type 2 value_size 4 value_btf_id 34
r=7
         bpftool-1356    [002] d..21   175.538187: bpf_trace_printk:
update_elem idx 1 value_size 4 r=0
         bpftool-1356    [002] d..21   175.538191: bpf_trace_printk:
map_freeze r=0
         bpftool-1356    [002] d..21   175.540873: bpf_trace_printk:
find_by_name_kind(bpf_testmod_invalid_mod_kfunc,12) r=-2
         bpftool-1356    [002] d..21   175.540876: bpf_trace_printk:
func (bpf_testmod_invalid_mod_kfunc:count=1): imm: 0, off: 0
         bpftool-1356    [002] d..21   175.540877: bpf_trace_printk:
func (bpf_testmod_invalid_mod_kfunc:count=1): btf_fd r=0
         bpftool-1356    [002] d..21   175.543305: bpf_trace_printk:
find_by_name_kind(bpf_testmod_test_mod_kfunc,12) r=-2

I see this leak with other tests too as long as they fail to load.
On success the cleanup of FD is good.

Any idea?
