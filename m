Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E711A3B947D
	for <lists+bpf@lfdr.de>; Thu,  1 Jul 2021 18:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhGAQGH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Jul 2021 12:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhGAQGG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Jul 2021 12:06:06 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB0AC061762
        for <bpf@vger.kernel.org>; Thu,  1 Jul 2021 09:03:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id k8so9180965lja.4
        for <bpf@vger.kernel.org>; Thu, 01 Jul 2021 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csy0oso8sVVNOjKf5Gla0HtyiXTuq9Jx8AcUlJu8ImQ=;
        b=W1hitavDQEn8qNccnxW8+c9VumLiSxCJcP12eYPMdesJOpDw+paTePwzJA1Gua8Iel
         2GM50RvgO0jf8yvuEecDlrtjJBs/Mz8/2fIymDYYHr08u8zSQJFY6Pv5DaLiv5wVtxVv
         SJlOYKaMMZbMC/A2RAL1dJzPdnM4G7XO+crdmBz5Aw/tXgFCAOy4uZB3+o/SmuNEA+W1
         v1j8j440WhQEQF5Q7A7tJAlWO8eWRawEukYNXRpIJ3ev0zn5wJ7HlwK9qx2ZW6RK3UAK
         W8U6Sw76TVO36oILcUl142hF9NVUdFGSLz1hflHxC9z4UWOUaxQ2daAYyCeQPHhlqqW5
         ZylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csy0oso8sVVNOjKf5Gla0HtyiXTuq9Jx8AcUlJu8ImQ=;
        b=fbnom2pJD0M2pjPqFQLV/q/NI4vaqW5upaqL0IJCgyohxocXMRlOqe72MJJyhT9w0Z
         QRNi81ol7zA78knP1PRUuvr65xw9xKWAKb/uFM5q9T3fz7r39BwgCT3WzzNj0jYkdZdg
         FO47/inbsSiNmasTR3qgqMQKSwaBkNgC3irL8DAEGrcXrEkVQoVkHEh9Oso4pVt15I68
         1CkPTtIfa8/pXYOoechBYEFMk+CRaZUJZH6XOsp9R0kpLVSnmpaZ7dhZ5CnSh106jFwy
         Bg2LRY4/1LJgldlb5oE/vQg9demrOi73XWlef4lfw9PWXusU4jy+M+J1+wisALS0vzSh
         0EDQ==
X-Gm-Message-State: AOAM531+QU2/6t+tqmI8oicE1oAKU3Fi1ezN1U2hRiKpa6cB0K4/lpes
        f5LyY6KhCKtg6Fr1MGL199LDphCgq9mxKsHWRX8=
X-Google-Smtp-Source: ABdhPJwvTVCLAGoZOJRP0cbmhkzFDDGwtTUKErvtvOWGV08yJxAwgFzrRudfLAQcVSjb5vTaIPhzQ+N/SyE/3VBKqno=
X-Received: by 2002:a2e:390f:: with SMTP id g15mr231914lja.44.1625155414065;
 Thu, 01 Jul 2021 09:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1625145429.git.naveen.n.rao@linux.vnet.ibm.com> <4117b430ffaa8cd7af042496f87fd7539e4f17fd.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <4117b430ffaa8cd7af042496f87fd7539e4f17fd.1625145429.git.naveen.n.rao@linux.vnet.ibm.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 1 Jul 2021 09:03:22 -0700
Message-ID: <CAADnVQ+78iDs7N=8xA6BZVBnPx78Q-Ljp860nmb8cOq7V_6qtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] powerpc/bpf: Fix detecting BPF atomic instructions
To:     "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc:     bpf <bpf@vger.kernel.org>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Brendan Jackman <jackmanb@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 1, 2021 at 8:09 AM Naveen N. Rao
<naveen.n.rao@linux.vnet.ibm.com> wrote:
>
> Commit 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other
> atomics in .imm") converted BPF_XADD to BPF_ATOMIC and added a way to
> distinguish instructions based on the immediate field. Existing JIT
> implementations were updated to check for the immediate field and to
> reject programs utilizing anything more than BPF_ADD (such as BPF_FETCH)
> in the immediate field.
>
> However, the check added to powerpc64 JIT did not look at the correct
> BPF instruction. Due to this, such programs would be accepted and
> incorrectly JIT'ed resulting in soft lockups, as seen with the atomic
> bounds test. Fix this by looking at the correct immediate value.
>
> Fixes: 91c960b0056672 ("bpf: Rename BPF_XADD and prepare to encode other atomics in .imm")
> Reported-by: Jiri Olsa <jolsa@redhat.com>
> Tested-by: Jiri Olsa <jolsa@redhat.com>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
> Hi Jiri,
> FYI: I made a small change in this patch -- using 'imm' directly, rather
> than insn[i].imm. I've still added your Tested-by since this shouldn't
> impact the fix in any way.
>
> - Naveen

Excellent debugging! You guys are awesome.
How do you want this fix routed? via bpf tree?
