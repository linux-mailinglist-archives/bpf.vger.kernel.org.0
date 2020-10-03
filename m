Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66712281FCC
	for <lists+bpf@lfdr.de>; Sat,  3 Oct 2020 02:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725446AbgJCA2u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Oct 2020 20:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgJCA2u (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Oct 2020 20:28:50 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C67C0613D0
        for <bpf@vger.kernel.org>; Fri,  2 Oct 2020 17:28:50 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c3so2303232ybl.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2020 17:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nk4CWgbIqPsMcoonFz4dC3c/N9raqs+0p3uLCmR/5sU=;
        b=NSHhMurd8CpY8HVZGzpnhM1pfiu64cuu1dK2WRETQC1Xv0vXovrw4oYrATb+PaKchu
         tKCZqzM/itTfEt3aCd6XJhC2dKY8Aw/S/oYkijGoC9IgDsyMp6nW++nk4zhw7eLBBqY0
         0fQJ7PZjrVe5PT6vjN7YUJkfJYgcOl1gBDnjzMbyW32fzQr4qfUtezk07dJL+kyKbdVo
         oxNpIFyih8l7aUg9M1R8Xlq0REHebTexT+cM5zt+prd+2rXiTPKWovWKHPbBHfK1mg6n
         9f1rUaRizzk6+ftzVBxqcWywJuaKUv+Zju55H+GTsIgXdThIsYDcmTgNyGQUVMc4vCFQ
         9Mrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nk4CWgbIqPsMcoonFz4dC3c/N9raqs+0p3uLCmR/5sU=;
        b=QRbghpzEQDIfYj0xVG4SWFzuiQ8MMDH4J8pdcB6RQ19taI2xF7lLTmG77ij0wtLwq9
         O6DzFUtT2e9aiaLCajkVlzM2Xt4UnkeII4Ctyrcb2l03VOOLsGaOqDfA4kTLrauio0MH
         rJZh8lG4tiooQa3WPgpCcu5LuLmokvAjKMXqtVh9C6dYf39Aog0qegYHAn2d+h39eWXf
         E3KNqfsMNkEuZJxci00RATUBittqP6Ut0q3Z0ngEquTVNUvAaACJcaJU5r3UgYVWurW7
         0EF6Cia4FvNvmrp2sE9O0DX/ClBRl+BhEkqUgNVlHiocsI0VFhWEKapB8J2emzlj3cs/
         d52w==
X-Gm-Message-State: AOAM531H5lQCpuTySyGoozx+yhKsoGLNWJgHNFHSea8LLaLRQs12Skmq
        2G6iZAQSGibD9yvEWWr6O6xWW64xz6wsZAKK/ntR4RW2cio=
X-Google-Smtp-Source: ABdhPJy7vJ5P7YvOp2Yg2Be8TTB7XnKQObc+GPqy7Fe5iBmH7sPd9t7/lcF05mM0w0Y+BXgKidzm6OMuh+4zpzeRmzc=
X-Received: by 2002:a25:8541:: with SMTP id f1mr5673562ybn.230.1601684929605;
 Fri, 02 Oct 2020 17:28:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAADnVQLueAsn006KnUBkgFrBqQGAabEGJxkWDOmB15oGHe_asg@mail.gmail.com>
 <CAKH8qBv+Z6xJL=edUz9MvGi7CtCbwsi28gmS+1Qgd1Fr1DPing@mail.gmail.com>
In-Reply-To: <CAKH8qBv+Z6xJL=edUz9MvGi7CtCbwsi28gmS+1Qgd1Fr1DPing@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 2 Oct 2020 17:28:38 -0700
Message-ID: <CAEf4BzZ4Ex_4XPJtC_XiZooO68DsA9qu60Pw0SQbF0BgzL-zoQ@mail.gmail.com>
Subject: Re: bug: frozen map leaks
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 2, 2020 at 3:47 PM Stanislav Fomichev <sdf@google.com> wrote:
>
> > after successful test_progs run I see a bunch of leaked maps:
> > # bpftool m s
> > 3: array  name iterator.rodata  flags 0x480
> >     key 4B  value 98B  max_entries 1  memlock 8192B
> >     btf_id 4  frozen
> > 9: array  name bpf_iter.rodata  flags 0x480
> >     key 4B  value 145B  max_entries 1  memlock 8192B
> >     btf_id 13  frozen
> > 12: array  name bpf_iter.rodata  flags 0x480
> >     key 4B  value 144B  max_entries 1  memlock 8192B
> >     btf_id 14  frozen
> > 13: array  name bpf_iter.rodata  flags 0x480
> >     key 4B  value 85B  max_entries 1  memlock 8192B
> >     btf_id 15  frozen
> > 14: array  name bpf_iter.rodata  flags 0x480
> >     key 4B  value 45B  max_entries 1  memlock 8192B
> >     btf_id 16  frozen
> > 15: array  name bpf_iter.rodata  flags 0x480
> >     key 4B  value 40B  max_entries 1  memlock 8192B
> >     btf_id 17  frozen
> > 17: array  name bpf_iter.rodata  flags 0x480
> >     key 4B  value 55B  max_entries 1  memlock 8192B
> >     btf_id 18  frozen
> > 19: array  name bpf_iter.rodata  flags 0x480
> >     key 4B  value 14B  max_entries 1  memlock 8192B
> >     btf_id 19  frozen
> >
> > Andrii,
> > I suspect it's due to libbpf doing BPF_PROG_BIND_MAP now.
> >
> > Stanislav,
> > could you take a look ?
> Interesting. I can reproduce with 'test_progs -t snprintf_btf':
>
> 5: array  name netif_re.rodata  flags 0x480
>         key 4B  value 13312B  max_entries 1  memlock 20480B
>         btf_id 5  frozen
> 10: array  name pid_iter.rodata  flags 0x480
>         key 4B  value 4B  max_entries 1  memlock 8192B
>         btf_id 10  frozen
>         pids bpftool(276)
> 11: array  flags 0x0
>         key 4B  value 32B  max_entries 1  memlock 4096B
>
> I suppose we do BPF_PROG_BIND_MAP only to #11, so I'm puzzled why
> rodata is also leaking.

all .rodata maps are also BPF_PROG_BIND_MAP'ed by libbpf, if kernel is
recent enough

> Will try to take a look!
