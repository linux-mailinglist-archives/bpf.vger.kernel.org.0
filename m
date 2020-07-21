Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEE7227646
	for <lists+bpf@lfdr.de>; Tue, 21 Jul 2020 04:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgGUCy6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 20 Jul 2020 22:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGUCy5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 20 Jul 2020 22:54:57 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7BDC061794
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 19:54:57 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b25so15149770qto.2
        for <bpf@vger.kernel.org>; Mon, 20 Jul 2020 19:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+siojgyYVIbvbV3b1dfwhm6F8sFbXlAlWgHaLSP3Bas=;
        b=g33BWhPH3CK1suNibujLlAyinUfJnC9/dyW/StR8cPiPCzcGTX2ZFAkHOYMaFH/a0I
         6z6fvgpusdjC0rNwyBjmimj38QqX2y/ObDX+GvXbP3w6IDNloXxI/KTjGXrDcZ/oEI3+
         +n6NQ5lcLehgiqr3xx2bBB15217M8k6yiJcoRwq81avpZByb5yo2EezCaX4S41d06SLM
         xGntIR9ZLS5Itg+Ur0xwFc/xi7mBeBUmWCyGFXfN6ND3G8oTeLlXWYLkFoY9Dem0oFYo
         vJUApygsbnfOc+Aq9xsYVopviEWvgpN9S/9w6HyExffqtTKQgRy9q3FGThRG8m8qpyuq
         M1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+siojgyYVIbvbV3b1dfwhm6F8sFbXlAlWgHaLSP3Bas=;
        b=uOArUgbUqwlZiNwWIliIefAMRq/QHWSEWyG+u8c0bwO1kRC5ALAm7PGSx7f73P7GA7
         Pq7oNYQ7wc0cpgRLm0KfRkOS3LDfKBOLBpoInB4oJN3Icm5gfWaK2q5RnsZqWMZX9RNa
         Jda5nvD0ffI1cSl0+hSrRoX0/Dq8sttv4UgddMI5BvsVLQf71EANGbQPzTShudUszWUE
         jAPuYPF8R3CXzphHgTYK5rYpF/QPu95rWZFrK0Q9mBcxZcDiDzBhdOBY4FILdCP7PWXl
         0E+BY0PiDlBdnOii3S332ZYo0AA0IntRoC7sXOaSGANUx+MZc07HS93EwZlftimbkY+x
         aPTg==
X-Gm-Message-State: AOAM531OgxolPEjJviC3GevGrWJ3JBoPoIzXm10Iud3vRxZLvtwEKIOV
        VtYU8acrcqNx9Vu9uRlxXr8F5tEZ
X-Google-Smtp-Source: ABdhPJzKMNab1U0ooBwtZe2+p+AwelLPUoDa2FQNrywH3rZySXl9UlmwAhvjIQk/+CvcntieqZlliQ==
X-Received: by 2002:aed:3f09:: with SMTP id p9mr27174474qtf.259.1595300096377;
        Mon, 20 Jul 2020 19:54:56 -0700 (PDT)
Received: from ?IPv6:2601:282:803:7700:91e8:f7a1:10b7:6c9c? ([2601:282:803:7700:91e8:f7a1:10b7:6c9c])
        by smtp.googlemail.com with ESMTPSA id m26sm23350877qtc.83.2020.07.20.19.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 19:54:55 -0700 (PDT)
Subject: Re: BPF selftests build failures
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
References: <20200720080943.GA12596@lst.de>
 <20200720204152.w7h3zmwtbjsuwgie@ast-mbp.dhcp.thefacebook.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <a0afbf75-5e48-9b18-214e-e9d6c7933aef@gmail.com>
Date:   Mon, 20 Jul 2020 20:54:53 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720204152.w7h3zmwtbjsuwgie@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 7/20/20 2:41 PM, Alexei Starovoitov wrote:
> On Mon, Jul 20, 2020 at 10:09:43AM +0200, Christoph Hellwig wrote:
>> Hi BPF and selftest maintainers.  I get a very strange failure
>> when trying to build the bpf selftests on current net-next master:
>>
>> hch@brick:~/work/linux/tools/testing/selftests/bpf$ make
>>   GEN      vmlinux.h
>> Error: failed to load BTF from /home/hch/work/linux/vmlinux: No such file or directory
> 
> That's bpftool complaining that BTF is not present in vmlinux.
> You need CONFIG_DEBUG_INFO_BTF=y and pahole >= v1.16
> You also need llvm 10 to build bpf progs.
> 

These never ending bumps to required versions to build kernels and bpf
code are not friendly to users. Until a recent commit I was able to use
Ubuntu 20.04 for bpf development and testing (e.g., the recent devmap
changes). Ubuntu 20.04 is an LTS OS released just 3 months ago with
pahole 1.15 and llvm 10. Now with v5.8-next 20.04 is out of date.

These hard requirements are making BTF inaccessible to average users by
*requiring* them to constantly chase new build versions. At this point I
can no longer point potential BPF/XDP users to this latest OS and say
try it out. Any instructions I write for getting started will be out of
date in some arbitrarily short period of time.

Worst, it is not even feature based within BTF; it is all or nothing.
ie., try to use 5.8-next with Ubuntu 20.04 and you lose all of BTF for
all use cases, not just some recently added feature.

If you want people to adopt this tech, you need to make it easier to use.
