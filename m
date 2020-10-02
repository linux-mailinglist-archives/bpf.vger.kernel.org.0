Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96843281E9B
	for <lists+bpf@lfdr.de>; Sat,  3 Oct 2020 00:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgJBWqw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 18:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgJBWqw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 18:46:52 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DA5C0613D0
        for <bpf@vger.kernel.org>; Fri,  2 Oct 2020 15:46:52 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id o21so3717896qtp.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2020 15:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCxZGcPP6DzbBSpNEFXBNBfx3GODUtXAAVcZq87JNw0=;
        b=KMsGvBaVAIPJ3swgBDPQcPSmhMb2jpm6DqKmD8fHiVgVYVw74CCymuqjk1g1ZQJrzv
         j27NZ3zKOz18TM+fsIw65VvNhb1h+uzUrlqNdFu6ceGcmBVbzfUQdd4UZbXPx4Bdl6tV
         zKDkOXpNI1Tf6iav8oGoIi0sgy1xkR3RcpkpHNbckQ9krZYbq4kkG5pJ70mszT683piD
         HerB+NLbhaDQH8dSorVz7r/HzV50qZxg8vsWfLGWr4PvFU0NHT1uwbd2QpJEd+K87HQJ
         KNyc1oFlQas/7c+sMIyvWfSYMRGcABz91EErS97qNWC4+vDV1+XFjxZCREsGQPhrRTn3
         x8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CCxZGcPP6DzbBSpNEFXBNBfx3GODUtXAAVcZq87JNw0=;
        b=G9A8IX6cJhAeaFohsOF8PjQNletEvS8d7WLOpe4bEyoXR+akmg2biYrwPPeztY+f3l
         a6HqyZtWG/ohv/QA+XlhGhc2PPbH+kd6LLXit+bqcQWMgR0jT7Ypzp3r2Cx/uGbTsLWN
         F9e0Ci2sPqIziGqfCogp442x5UEWAYdTbGN5v7Qfs5L6WgqiM+vEYtzqkFDGtrvsP/Rk
         NC4A4m1uwa8y56HioLTd9Cned5qNgCO+UTV7T/wsGon2dOujBqAcN2woAhHC3iCaPtbx
         2yAdWtjO9bI+gkB1QzwSbvvPaEtpEIi3wmG7zoRE2id8JSKUsSylRWMqMskMQmYoyzxO
         P4OQ==
X-Gm-Message-State: AOAM531PjQGW/61Vhm0+E/QbKXId20kI8RlRFysL/14FF3IB5cObA6i5
        ianwV1/QJApYWsPHH0HVutDDTpgViyiwUF78mrPbRNXQPw4z/A==
X-Google-Smtp-Source: ABdhPJwft1mrNmZKsGn21xVEFNZF0cFBRy0dPGq+FeYTBzbhVatcN1d4Ut5U4OBKEOnvliKxggt/P1/UtX9LiCJZK5Y=
X-Received: by 2002:aed:2f01:: with SMTP id l1mr4723098qtd.349.1601678811259;
 Fri, 02 Oct 2020 15:46:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLueAsn006KnUBkgFrBqQGAabEGJxkWDOmB15oGHe_asg@mail.gmail.com>
In-Reply-To: <CAADnVQLueAsn006KnUBkgFrBqQGAabEGJxkWDOmB15oGHe_asg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 2 Oct 2020 15:46:40 -0700
Message-ID: <CAKH8qBv+Z6xJL=edUz9MvGi7CtCbwsi28gmS+1Qgd1Fr1DPing@mail.gmail.com>
Subject: Re: bug: frozen map leaks
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> after successful test_progs run I see a bunch of leaked maps:
> # bpftool m s
> 3: array  name iterator.rodata  flags 0x480
>     key 4B  value 98B  max_entries 1  memlock 8192B
>     btf_id 4  frozen
> 9: array  name bpf_iter.rodata  flags 0x480
>     key 4B  value 145B  max_entries 1  memlock 8192B
>     btf_id 13  frozen
> 12: array  name bpf_iter.rodata  flags 0x480
>     key 4B  value 144B  max_entries 1  memlock 8192B
>     btf_id 14  frozen
> 13: array  name bpf_iter.rodata  flags 0x480
>     key 4B  value 85B  max_entries 1  memlock 8192B
>     btf_id 15  frozen
> 14: array  name bpf_iter.rodata  flags 0x480
>     key 4B  value 45B  max_entries 1  memlock 8192B
>     btf_id 16  frozen
> 15: array  name bpf_iter.rodata  flags 0x480
>     key 4B  value 40B  max_entries 1  memlock 8192B
>     btf_id 17  frozen
> 17: array  name bpf_iter.rodata  flags 0x480
>     key 4B  value 55B  max_entries 1  memlock 8192B
>     btf_id 18  frozen
> 19: array  name bpf_iter.rodata  flags 0x480
>     key 4B  value 14B  max_entries 1  memlock 8192B
>     btf_id 19  frozen
>
> Andrii,
> I suspect it's due to libbpf doing BPF_PROG_BIND_MAP now.
>
> Stanislav,
> could you take a look ?
Interesting. I can reproduce with 'test_progs -t snprintf_btf':

5: array  name netif_re.rodata  flags 0x480
        key 4B  value 13312B  max_entries 1  memlock 20480B
        btf_id 5  frozen
10: array  name pid_iter.rodata  flags 0x480
        key 4B  value 4B  max_entries 1  memlock 8192B
        btf_id 10  frozen
        pids bpftool(276)
11: array  flags 0x0
        key 4B  value 32B  max_entries 1  memlock 4096B

I suppose we do BPF_PROG_BIND_MAP only to #11, so I'm puzzled why
rodata is also leaking.
Will try to take a look!
