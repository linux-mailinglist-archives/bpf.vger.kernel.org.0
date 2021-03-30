Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A2334E4A5
	for <lists+bpf@lfdr.de>; Tue, 30 Mar 2021 11:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhC3Jnp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Mar 2021 05:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231464AbhC3JnO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Mar 2021 05:43:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B31C061574
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 02:43:13 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id o10so22785400lfb.9
        for <bpf@vger.kernel.org>; Tue, 30 Mar 2021 02:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JMP8eDgEhkYe8HifK8hiZaQ+dPjG3XHyor02oL/kDAI=;
        b=MlwnLNsqgBxL8YUSWjm+MIxEqUOZf3gHDWgUjVZixnVpKX0TjBh6rwSeXh4NiWe3Ba
         2YfWjzuxp+xcUPiO7SF/G6WvOxIgDZ/uMVye3/HgZF8+Pk0AVP2Q+M8WacMfy0PT8dfA
         kykhZvNML3Xx94Xu9sHbrftYuRGr24ZUwsNF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JMP8eDgEhkYe8HifK8hiZaQ+dPjG3XHyor02oL/kDAI=;
        b=jQpvaHouDJPetNahkUvI/3RALbIcWezAIHTF0KJFc3T8/cC+P+u1PwJdi469qlwm7r
         0K1O/1X1Fax51LOHvkSylOrmjbWiTQD1GZFQt7v6lPTIkWvhwYw3cMUH8FrV4chG8VUZ
         C65f8r0Dwa8lTLQAaWFWlrZFAtaJn7HRxfUMEHbwKkXFekZZ4tjuurI5efbIgIZJ39Sq
         Y547kP8T9pqwTR4IYEZBOG04VqWZZ0OOfEFd/ouX1kcOSNVZSo/GKskJIbR6JnjS6aWP
         i/2ql5kD/V4tCnhvU8/545nTrMKmE3oJICn8WqT5SBPzUS/FGMbXYAnZ0zFfx05EGlvk
         KZKw==
X-Gm-Message-State: AOAM533nImtLMSfpC6nCLdNT+O8wB2VGK5qOojGCTxG0lY+6xF/erAYi
        XZIZ7mymM8We5oCD4mQGHmHDzEqjGcYiuMGGJqlONw==
X-Google-Smtp-Source: ABdhPJzEQTFUznIaG0ADYbGDgvJk50ou2vGmKxTVWu6BgICvmUZ2b7dDC8Vm09470UJMQxH0V/sMwUEQbIsQkaUPstM=
X-Received: by 2002:ac2:5f5b:: with SMTP id 27mr1466084lfz.325.1617097392308;
 Tue, 30 Mar 2021 02:43:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210325015124.1543397-1-kafai@fb.com>
In-Reply-To: <20210325015124.1543397-1-kafai@fb.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 30 Mar 2021 10:43:01 +0100
Message-ID: <CACAyw9-N6FO67JVJsO=XTohf=4-uMwsSi+Ym2Nxj0+GpofJJHQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 00/14] bpf: Support calling kernel function
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Networking <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Mar 2021 at 01:52, Martin KaFai Lau <kafai@fb.com> wrote:
>
> This series adds support to allow bpf program calling kernel function.

I think there are more build problems with this. Has anyone hit this before?

$ CLANG=clang-12 O=../kbuild/vm ./tools/testing/selftests/bpf/vmtest.sh -j 7

  GEN-SKEL [test_progs-no_alu32] bind6_prog.skel.h
libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] bind_perm.skel.h
libbpf: elf: skipping unrecognized data section(5) .rodata.str1.1
  GEN-SKEL [test_progs-no_alu32] bpf_cubic.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_dctcp.skel.h
  GEN-SKEL [test_progs-no_alu32] bpf_flow.skel.h
libbpf: failed to find BTF for extern 'tcp_cong_avoid_ai' [27] section: -2
Error: failed to open BPF object file: No such file or directory
make: *** [Makefile:453:
/home/lorenz/dev/kbuild/vm//no_alu32/bpf_cubic.skel.h] Error 255
make: *** Deleting file '/home/lorenz/dev/kbuild/vm//no_alu32/bpf_cubic.skel.h'
make: *** Waiting for unfinished jobs....
libbpf: failed to find BTF for extern 'tcp_reno_cong_avoid' [38] section: -2
Error: failed to open BPF object file: No such file or directory
make: *** [Makefile:451:
/home/lorenz/dev/kbuild/vm//no_alu32/bpf_dctcp.skel.h] Error 255
make: *** Deleting file '/home/lorenz/dev/kbuild/vm//no_alu32/bpf_dctcp.skel.h'

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
