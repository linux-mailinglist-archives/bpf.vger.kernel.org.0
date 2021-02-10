Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64027316EAF
	for <lists+bpf@lfdr.de>; Wed, 10 Feb 2021 19:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbhBJSa3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Feb 2021 13:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbhBJS3W (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Feb 2021 13:29:22 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4288BC06174A
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 10:28:42 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id p15so2759754ilq.8
        for <bpf@vger.kernel.org>; Wed, 10 Feb 2021 10:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XJYZFGhrBiou1Eqm8bd6lz808exSgkSBgBkBF0GK28w=;
        b=ojprnOV6IXbl4zKe/t3ktzzv/tvyOsXC+wdYoV6szHfexRyQN+Je2QfofyeAko7vE9
         LCoYMkD34VRnUq9BvFgDOqYfvmwhMjeLITQ3aKTkFP+rnPYZS9eLK0sOEXRek8X47ucU
         5MNeVyGoB6LO/vv8S8iy1S6QNOqX/CrZIrUKG1+rxmY7rDj9ta5Ci9cFz4L2IJmy5cu1
         a/twhpPYK3DFjMLa5ABZboL2UuGiR5ChIWMb0TN8M2YtmyOmE1r/iEflVoW4xwqA4lwL
         2PVo4GmRayeqS0eP0iH/WdzW8QUt/B/uYIhw4kthFmEioCwH1J5A0730QkEQyb6ZVpU1
         EyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XJYZFGhrBiou1Eqm8bd6lz808exSgkSBgBkBF0GK28w=;
        b=noMhLsD60ygRwHHpj9CUhSYEco14s0qFkGleZT9+stommCI1n4EXERPeRLdz5i+0mn
         bOXw1paQvK8aqsm7eBTCWYSYPLjEQFArLNhQRdX1nIhV41iLJRMed1RYMcx5gaNtA4x7
         +Gg243nAtadauHgYTF5HJsJ6KRxWNrWAJxVvxFG+c65biKiGx0FXIMs77ZQ197b+2gO6
         W8Em4jHg3Klak/6oFzj//tz/teaaJc853hVVdCj5uxK2ocuMesf6jSXh3mHR9xysltmB
         AhGVOG2IGwYh9BnPrjcXw130dLF07jNnGTSOzq/jZH7X//pF60koPRHWR33rnfAoeRdr
         jKGA==
X-Gm-Message-State: AOAM533y0IUR43E3DeQimCAx0YDS6gwQWb0ov8z35JmT7YKR4HwQbwsA
        +6NjG+khrVBDpi4b2/qyznqYKatNwXzjaOKa0JJ2eQ==
X-Google-Smtp-Source: ABdhPJzInfFQHXgxK/mWD8rTMuDdnlOOh1s8zCpmEHyogH+TAKHuPk0WJlWsK4vZWw1giRnIBnTmp0aUDLiRvp4JyNw=
X-Received: by 2002:a05:6e02:13a5:: with SMTP id h5mr2235782ilo.263.1612981721460;
 Wed, 10 Feb 2021 10:28:41 -0800 (PST)
MIME-Version: 1.0
References: <b1792bb3c51eb3e94b9d27e67665d3f2209bba7e.camel@linux.ibm.com>
 <CAADnVQJFcFwxEz=wnV=hkie-EDwa8s5JGbBQeFt1TGux1OihJw@mail.gmail.com>
 <5c6501bea0f7ae9dcb9d5f2071441942d5d3dc0f.camel@linux.ibm.com> <CAADnVQ+gnQED7WYAw7Vmm5=omngCKYXnmgU_NqPUfESBerH8gQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+gnQED7WYAw7Vmm5=omngCKYXnmgU_NqPUfESBerH8gQ@mail.gmail.com>
From:   Brendan Jackman <jackmanb@google.com>
Date:   Wed, 10 Feb 2021 19:28:29 +0100
Message-ID: <CA+i-1C0xbm_+oz2ZyAWvwjLxeD5niAObN0Ya3y2RvHKrC31Mmw@mail.gmail.com>
Subject: Re: What should BPF_CMPXCHG do when the values match?
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Ilya Leoshkevich <iii@linux.ibm.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@fb.com>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thanks a lot for bringing this up Ilya!

On Wed, 10 Feb 2021 at 19:08, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
[...]
> Brendan,
> could you please follow up with x64 jit fix to add 'mov eax,eax'  for
> u32-sized cmpxchg  ?

Ack, will do.
