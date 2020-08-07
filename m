Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD74E23EEF5
	for <lists+bpf@lfdr.de>; Fri,  7 Aug 2020 16:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgHGOVC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Aug 2020 10:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgHGOVB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Aug 2020 10:21:01 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C8BC061756
        for <bpf@vger.kernel.org>; Fri,  7 Aug 2020 07:21:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m22so2254394eje.10
        for <bpf@vger.kernel.org>; Fri, 07 Aug 2020 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Oxe2JB52HyB43ucYYj0/ASqKcH4GBHp3SzRnnzqpx7E=;
        b=MZSYZmcb9cAtQX8VKct6v971lRbzb3LZWabIyIdv7XtkxEfKt8HPr+ilh/ug2dpY0/
         v/2bFZyPEMeN3hsWgRavmpu+qgVnCGcJj1s5cfVJUMLYvBQ59UHZyRgreAiSIwIaW0ai
         wvMofm3Ch5H+dnLR8fHySSAk35D5WEfMJbcg6WTQI79GMdS277RFtTBmO9FO+LwUjxxl
         SD8QhP4vyJhalJ7slqIf3AFbU1JMSYS+Bso4V5lYxAT+34MnzUJBm79Y7NSZNH4OmdFg
         mtIpHFm41hqSqNxQRnzk+y9h8mgCWq09WIou8GAx7BNuyAzWbAp2NW8B4GGl5yrvVrre
         v/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Oxe2JB52HyB43ucYYj0/ASqKcH4GBHp3SzRnnzqpx7E=;
        b=JbRulVlYbnQHIksHDyvd2vRar8wxOr1EGSTlLIxClVH16B5TuufG/QWsNHU9RZ8zJS
         bFAR/TFaat9n4174PGLS80gPupLf3mD/6gV9TAlhs1PlNLvHGi5dComQBqHNOQWXJ7GN
         ZuWOCbGelL69V441UDljqQDo0Oe5yYElxqw+AP3QEEd2wy43ZJZ6Xr420Zmxpzpesv8F
         k1GIDZ06g58VOFk7q86aJo8cWuY0NnlyXWVjzwdXlFTt4GtXQm2DJVvjrf8/jGLd6OMt
         Q2fry9V0CFzw6Z4vbleICyyqzu/38PgYg/exvNua8ygrSaPttFDIlqoZnXUUegivmQhi
         Pflg==
X-Gm-Message-State: AOAM530c4wOVwZA2FB6f9IYgSH4Bi6aXjJlZP4wa9bBD0hpSK5J4I6Lu
        2focPb+41vszMMiGeT0WGUI4m1bmT1M=
X-Google-Smtp-Source: ABdhPJxhn6fcjHi7NUb4nLSOn1ZP/YyBA9qocFglvd43RCKqURXu6ICwI3MIO3K33XTgOyr4re0dXg==
X-Received: by 2002:a17:906:ca4f:: with SMTP id jx15mr10013569ejb.449.1596810059924;
        Fri, 07 Aug 2020 07:20:59 -0700 (PDT)
Received: from [192.168.0.28] ([188.252.224.6])
        by smtp.gmail.com with ESMTPSA id j7sm5993269ejb.64.2020.08.07.07.20.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Aug 2020 07:20:59 -0700 (PDT)
To:     bpf@vger.kernel.org
Cc:     Andrii Nakryiko <andriin@fb.com>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Smolic <jakov.smolic@sartura.hr>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>
From:   Jakov Petrina <jakov.petrina@sartura.hr>
Subject: eBPF CO-RE cross-compilation for 32-bit ARM platforms
Message-ID: <f1b8e140-bc41-4e56-e73f-db11062dddbd@sartura.hr>
Date:   Fri, 7 Aug 2020 16:20:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi everyone,

recently we have begun extensive research into eBPF and related 
technologies. Seeking an easier development process, we have switched 
over to using the eBPF CO-RE [0] approach internally which has enabled 
us to simplify most aspects of eBPF development, especially those 
related to cross-compilation.

However, as part of these efforts we have stumbled upon several problems 
that we feel would benefit from a community discussion where we may 
share our solutions and discuss alternatives moving forward.

As a reference point, we have started researching and modifying several 
eBPF CO-RE samples that have been developed or migrated from existing 
`bcc` tooling. Most notable examples are those present in `bcc`'s 
`libbpf-tools` directory [1]. Some of these samples have just recently 
been converted to respective eBPF CO-RE variants, of which the 
`tcpconnect` tracing sample has proven to be very interesting.

First showstopper for cross-compiling aforementioned example on the ARM 
32-bit platform has been with regards to generation of the required 
`vmlinux.h` kernel header from the BTF information. More specifically, 
our initial approach to have e.g. a compilation target dependency which 
would invoke `bpftool` at configure time was not appropriate due to 
several issues: a) CO-RE requires host kernel to have been compiled in 
such a way to expose BTF information which may not available, and b) the 
generated `vmlinux.h` was actually architecture-specific.

The second point proved interesting because `tcpconnect` makes use of 
the `BPF_KPROBE` and `BPF_KRETPROBE` macros, which pass `struct pt_regs 
*ctx` as the first function parameter. The `pt_regs` structure is 
defined by the kernel and is architecture-specific. Since `libbpf` does 
have architecture-specific conditionals, pairing it with an "invalid" 
`vmlinux.h` resulted in cross-compilation failure as `libbpf` provided 
macros that work with ARM `pt_regs`, and `vmlinux.h` had an x86 
`pt_regs` definition. To resolve this issue, we have resorted to 
including pre-generated `<arch>_vmlinux.h` files in our CO-RE build system.

However, there are certainly drawbacks to this approach: a) (relatively) 
large file size of the generated headers, b) regular maintenance to 
re-generate the header files for various architectures and kernel 
versions, and c) incompatible definitions being generated, to name a 
few. This last point relates to the the fact that our `aarch64`/`arm64` 
kernel generates the following definition using `bpftool`, which has 
resulted in compilation failure:

```
typedef __Poly8_t poly8x16_t[16];
```

AFAICT these are ARM NEON intrinsic definitions which are GCC-specific. 
We have opted to comment out this line as there was no additional 
`poly8x16_t` usage in the header file.

Given various issues we have encountered so far (among which is a kernel 
panic/crash on a specific device), additional input and feedback 
regarding cross-compilation of the eBPF utilities would be greatly 
appreciated.

[0]
https://facebookmicrosites.github.io/bpf/blog/2020/02/19/bpf-portability-and-co-re.html
[1] https://github.com/iovisor/bcc/tree/master/libbpf-tools

Best regards,

Sartura eBPF Team
