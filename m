Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5292332B8
	for <lists+bpf@lfdr.de>; Thu, 30 Jul 2020 15:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgG3NKf (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Jul 2020 09:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgG3NKe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Jul 2020 09:10:34 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A366DC0619D4
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 06:10:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f7so24879200wrw.1
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2020 06:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=bLy47z/l46PUzRdtsF8KNtDq1ZYKxoe/ZvHqmmLYwsM=;
        b=rA630qLBmcH60uXUiKI7cOObkiTkJJDE5SgPFTVDaJyStwfa6HBkCyyTSPwYqSt4di
         isaMo/c31umKZP+MB+NjACCNPWz2A2glunigpDgzqPWm3Mg99XquCPdMQgz/p6kjZkwf
         3u0gIpYOaW70LzS7d3p7aluBOLMaRrrikG8Mw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=bLy47z/l46PUzRdtsF8KNtDq1ZYKxoe/ZvHqmmLYwsM=;
        b=kuWls5Aa0QVUqnZZM+9QmsznEXMuDqOCI/VYlcQu09axYgWHfRlzryhPZzLvs9EHW5
         gHexhQ0bQ7V2PDjuWVZW3YI5wjYUVAKl+1CUTzEm6DCaYHUAwcK4YJzXgZnve10SysJ1
         oFPu45F1hFZ73N3F/P5xmcUlmOzRLOeAq378ODI/oYSOZpeKP1mFIpDgxDwiccRXF1B0
         4mQQAs+U27F8wparS+fTug8FNyE9EUKiZFM/aP0sPPqM/02EqhN1U0H8R7yf5yNOSOJp
         AHSYDF/YyPyI9X6hoVWoEQABi8rhBoKpohSB6KaFlJ1U98UU6M+WhlacHKyFUU0pgyG8
         /A1w==
X-Gm-Message-State: AOAM532vbcWZuggyK0gXOHNDt8Ni3iPnNbbpbSkq4vJvnfn0oyB537+6
        HJST0xbsQO3g4mPqQpU+yv6TQcU5cMI=
X-Google-Smtp-Source: ABdhPJwpz+fIzS473/6RWEfWAW0+4PwUoAQ47U6SHdAZ8vdizWarWfp6LDX0dstOQIIhgnrm/pNf7Q==
X-Received: by 2002:a5d:6407:: with SMTP id z7mr2774102wru.412.1596114633289;
        Thu, 30 Jul 2020 06:10:33 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id w1sm9181290wmc.18.2020.07.30.06.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 06:10:32 -0700 (PDT)
References: <20200717103536.397595-1-jakub@cloudflare.com> <20200717103536.397595-16-jakub@cloudflare.com> <CAEf4BzZHf7838t88Ed3Gzp32UFMq2o2zryL3=hjAL4mELzUC+w@mail.gmail.com> <87lfj2wvf4.fsf@cloudflare.com>
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
In-reply-to: <87lfj2wvf4.fsf@cloudflare.com>
Date:   Thu, 30 Jul 2020 15:10:31 +0200
Message-ID: <87ft99w3lk.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jul 29, 2020 at 10:57 AM CEST, Jakub Sitnicki wrote:
> On Tue, Jul 28, 2020 at 10:13 PM CEST, Andrii Nakryiko wrote:
>
> [...]
>
>> We are getting this failure in Travis CI when syncing libbpf [0]:
>>
>> ```
>> ip: either "local" is duplicate, or "nodad" is garbage
>>
>> switch_netns:PASS:unshare 0 nsec
>>
>> switch_netns:FAIL:system failed
>>
>> (/home/travis/build/libbpf/libbpf/travis-ci/vmtest/bpf-next/tools/testing/selftests/bpf/prog_tests/sk_lookup.c:1310:
>> errno: No such file or directory) system(ip -6 addr add dev lo
>> fd00::1/128 nodad)
>>
>> #73 sk_lookup:FAIL
>> ```
>>
>>
>> Can you please help fix it so that it works in a Travis CI environment
>> as well? For now I disabled sk_lookup selftests altogether. You can
>> try to repro it locally by forking https://github.com/libbpf/libbpf
>> and enabling Travis CI for your account. See [1] for the PR that
>> disabled sk_lookup.

[...]

Once this fix-up finds its way to bpf-next, we will be able to re-enable
sk_loookup tests:

  https://lore.kernel.org/bpf/20200730125325.1869363-1-jakub@cloudflare.com/

And I now know that I need to test shell commands against BusyBox 'ip'
command implementation, that libbpf project uses in CI env.
