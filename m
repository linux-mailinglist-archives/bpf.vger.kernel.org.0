Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A209C231BB1
	for <lists+bpf@lfdr.de>; Wed, 29 Jul 2020 10:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgG2I5Z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jul 2020 04:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgG2I5Y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jul 2020 04:57:24 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37457C0619D2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 01:57:23 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id q4so24218832lji.2
        for <bpf@vger.kernel.org>; Wed, 29 Jul 2020 01:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=HJ8+zYD3bs4pqtCvGKcax5bNzzsJHKop3reao1BJkN4=;
        b=Z6fDlWE51ldGySvarHMCC6+uPer7n1UtqYxQlJE+C95Hqhex43fAaqwYPVmICPiknJ
         /m4bRedvXo5nbVi1vwk0xbn/HicGFNDSfEww3WBvScxgQrJ2l5v5e+OuV+tgIL7zoAJm
         74JLsoQbtpIJg9wYGLO3Adi8dGFZKNDKu3Y88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=HJ8+zYD3bs4pqtCvGKcax5bNzzsJHKop3reao1BJkN4=;
        b=X1InW9pVChyfyxvESBwuuGqRseUI6QB8ohJ78ooaQrRkFzUEsfolZeyXJeri2OmQbi
         gIFVkmOTPGlFyPvYYG11r/K1q3NvHgJvI/8zHbEjpVZ/9NQg+PdC/wpxx8Qlr5d/O6BS
         W0oNKn7N1PiZ9Dbg8IBvoJRWFF3fUr05NYDLsE0LZZkWjAbfRPCYnuEe7Zap4SirDm08
         YcnMT5iTaCCpjjJNFKq+AUuGdwuAHESUyPW9kxIz8K66cAA7n+Jw64egrqy5OYuJmZcq
         gzcH30W/EVNPtOR0aAOxB8rCXFxkUsIpDW0pvtNFL573nd2+D5fvXFVeynJeePGEcso+
         HXIw==
X-Gm-Message-State: AOAM533vzYxi83yVLBujzEVVIOlaUH+CLGm79NlqS3wqOeqowaWShJu5
        tNyVrCNWoUE24xX36U4V99MPpA==
X-Google-Smtp-Source: ABdhPJzbWvg2bw0pnhEF8NeG+bvvG7WogBjX2YSk6HCKFVj7J3VWmPfFIEhMQzpOY8z12QQvYW94sg==
X-Received: by 2002:a2e:8191:: with SMTP id e17mr13445217ljg.339.1596013041555;
        Wed, 29 Jul 2020 01:57:21 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id j1sm269388ljb.35.2020.07.29.01.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 01:57:20 -0700 (PDT)
References: <20200717103536.397595-1-jakub@cloudflare.com> <20200717103536.397595-16-jakub@cloudflare.com> <CAEf4BzZHf7838t88Ed3Gzp32UFMq2o2zryL3=hjAL4mELzUC+w@mail.gmail.com>
User-agent: mu4e 1.1.0; emacs 26.3
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH bpf-next v5 15/15] selftests/bpf: Tests for BPF_SK_LOOKUP attach point
In-reply-to: <CAEf4BzZHf7838t88Ed3Gzp32UFMq2o2zryL3=hjAL4mELzUC+w@mail.gmail.com>
Date:   Wed, 29 Jul 2020 10:57:19 +0200
Message-ID: <87lfj2wvf4.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Andrii,

On Tue, Jul 28, 2020 at 10:13 PM CEST, Andrii Nakryiko wrote:

[...]

> We are getting this failure in Travis CI when syncing libbpf [0]:
>
> ```
> ip: either "local" is duplicate, or "nodad" is garbage
>
> switch_netns:PASS:unshare 0 nsec
>
> switch_netns:FAIL:system failed
>
> (/home/travis/build/libbpf/libbpf/travis-ci/vmtest/bpf-next/tools/testing/selftests/bpf/prog_tests/sk_lookup.c:1310:
> errno: No such file or directory) system(ip -6 addr add dev lo
> fd00::1/128 nodad)
>
> #73 sk_lookup:FAIL
> ```
>
>
> Can you please help fix it so that it works in a Travis CI environment
> as well? For now I disabled sk_lookup selftests altogether. You can
> try to repro it locally by forking https://github.com/libbpf/libbpf
> and enabling Travis CI for your account. See [1] for the PR that
> disabled sk_lookup.
>
>
>   [0] https://travis-ci.com/github/libbpf/libbpf/jobs/365878309#L5408
>   [1] https://github.com/libbpf/libbpf/pull/182/commits/78368c2eaed8b0681381fc34d6016c9b5a443be8
>
>
> Thanks for your help!

"nodad is garbage" message smells like old iproute2. I will take a look.

Thanks for letting me know.
