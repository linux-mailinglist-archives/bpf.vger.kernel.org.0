Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26EBD471F20
	for <lists+bpf@lfdr.de>; Mon, 13 Dec 2021 02:33:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhLMBdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 12 Dec 2021 20:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbhLMBdF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 12 Dec 2021 20:33:05 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3357FC06173F
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 17:33:05 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id a23so8596351pgm.4
        for <bpf@vger.kernel.org>; Sun, 12 Dec 2021 17:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0YmcopgnmtWTwnk2BoHebdXsfLf4tV+Q9kokUXla8n8=;
        b=e1uGwiReM73KIxegy+5YsLyglYCgoQsqHzacJVLb85DJ+TVWcS5r78SUCXYznakNSy
         if7p3ALaY6y3PqI0VvfSN1J2JkHNALfkrZPfyOuvOA7Bu/9sGAAKOa3MBiq5FSYksRc+
         yfpbwBLMNagQlRr6P4HwkFESEyNQjayFgA8fpT2uqXpTJzZlKAQ6L79gK2dBBN5Dn/Fq
         Dte/7yZLe2khs5kkeFPn5lsDqAeVr8Up+ld27DhKVndaPNZUESZWM+2w0ichEynPp9Cd
         RQnfVheny82X0HDEqRMPzT7wU0NSCl12AvLXf1cAgMIxzlAogQ+sfmEsWZfvLtdAebE/
         mHPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0YmcopgnmtWTwnk2BoHebdXsfLf4tV+Q9kokUXla8n8=;
        b=HmRcLK0bu8KgGabgRHvLGnuCUMBakS3rQupa+XqTr4RNiRt6a8HJpVLDahmtILMGHZ
         7vtl2SWAbrXvuRHxRyWqaKT/vaNcLFxnWh6YYcCU9F59DjTq8Y03+407dwxiu92H+1vt
         TEuWZdxzXXaTi45lCrOEYhHePY8alwYcNVl7UcxyGoQy59NTuBu7GEIe38aofhZwJW2E
         mRWuJqDzBUjmYIPSudtC/znjZwXB3QoLzd8Rzpm5YFYjp1PBrL9MP9XpcE5BJflxKJM6
         8bv7eo8sAQNhuQwBi9PvAqyw+DU9TG4dEvS87YYk5l2krIvTn2GuL2oyWUsSbYWDN3zj
         11MA==
X-Gm-Message-State: AOAM53288V+LuVyUBOtbnPnVtbtbRR1Q5nHCxASPd6WStWDOU/dNdRet
        XD1UfS7KZTWyPO6iOLf5+IPFJ88XixCrUBNRUiA=
X-Google-Smtp-Source: ABdhPJxAQg+kNXRJ8V8dvGIgw6yYjG32XbKkZmFf5NV36w7WidlND1vNUj8Y2RffR101dnth7Re2mRKXcrWQG6haYUc=
X-Received: by 2002:a65:4381:: with SMTP id m1mr5462348pgp.375.1639359184297;
 Sun, 12 Dec 2021 17:33:04 -0800 (PST)
MIME-Version: 1.0
References: <20211213010706.100231-1-andrii@kernel.org>
In-Reply-To: <20211213010706.100231-1-andrii@kernel.org>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 12 Dec 2021 17:32:53 -0800
Message-ID: <CAADnVQK-qxkLsPBcJSdJzjQ--mHjSNQfDqoA3pcUBOrHPv7hPw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: don't validate TYPE_ID relo's original
 imm value
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Dec 12, 2021 at 5:07 PM Andrii Nakryiko <andrii@kernel.org> wrote:
>
> During linking, type IDs in the resulting linked BPF object file can
> change, and so ldimm64 instructions corresponding to
> BPF_CORE_TYPE_ID_TARGET and BPF_CORE_TYPE_ID_LOCAL CO-RE relos can get
> their imm value out of sync with actual CO-RE relocation information
> that's updated by BPF linker properly during linking process.
>
> We could teach BPF linker to adjust such instructions, but it feels
> a bit too much for linker to re-implement good chunk of
> bpf_core_patch_insns logic just for this. This is a redundant safety
> check for TYPE_ID relocations, as the real validation is in matching
> CO-RE specs, so if that works fine, it's very unlikely that there is
> something wrong with the instruction itself.
>
> So, instead, teach libbpf (and kernel) to ignore insn->imm for
> BPF_CORE_TYPE_ID_TARGET and BPF_CORE_TYPE_ID_LOCAL relos.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Applied. Thanks for the quick fix. bpf-next CI should be green again.
