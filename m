Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C3A2772C6
	for <lists+bpf@lfdr.de>; Thu, 24 Sep 2020 15:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgIXNk6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Sep 2020 09:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgIXNk6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Sep 2020 09:40:58 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AF3C0613D3
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 06:40:58 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 77so4009062lfj.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2020 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cDrHVTOD+iSWXelVapd6LAkJ7VfbRManFz9vUWJEqwc=;
        b=KCxqPAVEUh0NN2sRqfB2Er3kRv3k3VxWZOlCy1TnuFltpouAeT9UrqF3gbDCWNhLso
         Q4gthE2otk3e6NybEISvLpG5ofuUJ4TsMDfT/fjZlK00Lj8I+w0dolYj3GdjwFPq6Ih8
         CvX8q1UtLGea0tijaEcOFvSd32Yq46wp4o0mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cDrHVTOD+iSWXelVapd6LAkJ7VfbRManFz9vUWJEqwc=;
        b=n9tFJlCUAeEOp3P44jk1iwB+DIj7bi52HLQFnFCD/Bhp7Lpm5ir+mcaVpc/27J/v95
         L+2Sjokzk8so+qtV+bZ8zgS5Y0JVZgTILmCeCwRlS/frD7xcLuLvj0KEFfwczlc9JmTf
         SDjPNjgYE6wEp5fACJ3KgE4nKVbNaw3YahwqPMoMMDmuWfWj8Lq7K6s2fK7tedzUa0+w
         zPJcYlXnuKLDd+D3Iv4gOm5zcvvrFScRIFuvLNlG/v/zVbSHmF584Y/tbqexvOi+RtTC
         JSkgItC15YOr76FsWLB/GcYvYMOTxBW79lemnqj2e0rQlBUreeFUw1BrIKRyQvrNo5YH
         edWw==
X-Gm-Message-State: AOAM533vTwPQJvs0T1Z9gmc0fo5YOzKFT2VqBB3QPUtz17u2RFHXvDu1
        ohIacRtp7rYKIw44v7lthxZ3Hw==
X-Google-Smtp-Source: ABdhPJyhP2oOUzht7mmnYmL06kxXBu44hSqGNAaV4Vj6cp2z2M4mFMwQjvAP9vCt1lBA3/mkfw8qIQ==
X-Received: by 2002:a19:6b17:: with SMTP id d23mr362374lfa.190.1600954856089;
        Thu, 24 Sep 2020 06:40:56 -0700 (PDT)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id s20sm2085680lfs.135.2020.09.24.06.40.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 06:40:55 -0700 (PDT)
Subject: Re: [PATCH v1 0/6] seccomp: Implement constant action bitmaps
To:     Kees Cook <keescook@chromium.org>,
        YiFei Zhu <yifeifz2@illinois.edu>
Cc:     Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200923232923.3142503-1-keescook@chromium.org>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <43039bb6-9d9f-b347-fa92-ea34ccc21d3d@rasmusvillemoes.dk>
Date:   Thu, 24 Sep 2020 15:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923232923.3142503-1-keescook@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 24/09/2020 01.29, Kees Cook wrote:
> rfc: https://lore.kernel.org/lkml/20200616074934.1600036-1-keescook@chromium.org/
> alternative: https://lore.kernel.org/containers/cover.1600661418.git.yifeifz2@illinois.edu/
> v1:
> - rebase to for-next/seccomp
> - finish X86_X32 support for both pinning and bitmaps
> - replace TLB magic with Jann's emulator
> - add JSET insn
> 
> TODO:
> - add ALU|AND insn
> - significantly more testing
> 
> Hi,
> 
> This is a refresh of my earlier constant action bitmap series. It looks
> like the RFC was missed on the container list, so I've CCed it now. :)
> I'd like to work from this series, as it handles the multi-architecture
> stuff.

So, I agree with Jann's point that the only thing that matters is that
always-allowed syscalls are indeed allowed fast.

But one thing I'm wondering about and I haven't seen addressed anywhere:
Why build the bitmap on the kernel side (with all the complexity of
having to emulate the filter for all syscalls)? Why can't userspace just
hand the kernel "here's a new filter: the syscalls in this bitmap are
always allowed noquestionsasked, for the rest, run this bpf". Sure, that
might require a new syscall or extending seccomp(2) somewhat, but isn't
that a _lot_ simpler? It would probably also mean that the bpf we do get
handed is a lot smaller. Userspace might need to pass a couple of
bitmaps, one for each relevant arch, but you get the overall idea.

I'm also a bit worried about the performance of doing that emulation;
that's constant extra overhead for, say, launching a docker container.

Regardless of how the kernel's bitmap gets created, something like

+	if (nr < NR_syscalls) {
+		if (test_bit(nr, bitmaps->allow)) {
+			*filter_ret = SECCOMP_RET_ALLOW;
+			return true;
+		}

probably wants some nospec protection somewhere to avoid the irony of
seccomp() being used actively by bad guys.

Rasmus
