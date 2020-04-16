Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62FD51AB77C
	for <lists+bpf@lfdr.de>; Thu, 16 Apr 2020 07:43:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406392AbgDPFmn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Apr 2020 01:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405910AbgDPFml (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Apr 2020 01:42:41 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39BAC061A0C
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 22:42:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id s63so15971610qke.4
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2020 22:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0skDULWKIHyE4I9lCgbMwA227FfaK+hEIFOmoifKl38=;
        b=DgngdZjYtYwZT6vZHUrVeAXnUAKQQtIkTQaDe95rceKxzENRHUwPR1tENP8qFfNBTr
         reMNUc+FRjUZpkFPLuCjX2DJBN0fgqX/qgN0cpRwbp0a4CCWaT9emXWkavhLmuHqk+sD
         uiARwwzFTnaAbdAzIHe4D26dZHzebhF5fHgdFeRiuJ3FMiLMD6E4xLWmdepUevPV0thN
         M9Yquq9L3DxB5dM+CTnzRZHf+6I+2Ge654JSiXux/yjzAwuiPiuVt0fGAC4FQUMh+euK
         NpBnkaQkes+PUJgS1OHCbVBnWFVOyDLPfxuMKisPS+OuAuujGMNsmmZUjunUKf4msSzE
         s64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0skDULWKIHyE4I9lCgbMwA227FfaK+hEIFOmoifKl38=;
        b=io46KAsN0u0w5v69hRc6LOr1OUfUKJsAL4fqs3efNNFEGW7mO6kh5o2ajQVmCws667
         DjeYCbFtPG0ZHg3Y4nnMuq2e3lkXnrUbZgmTpsE4wqXoaTKYoSG3uK2emjkIbbHRtZR3
         7yVleIRRXy+D08q6BIvNr7uw8xvYFmJrl/5PkvwNwRx+BjRftW75DRREaJM+UsTjwOyV
         kJvZpsshHyBTUT4OQnojm9gNzNvMDi3lJx7uyD0LzVyqsrKjGcGEkc34BBADfrD6PZYT
         3MUYxgM3dvJi67cctpJosCAbvv+krakkSe0Z6N56L1rLkRwF4LxEUggEMDsHcqW377pF
         AsCw==
X-Gm-Message-State: AGi0PuZxCXIYxspSnbL+FhN4YwHjrjchRRh+M2nJCyQmVrkyEUnH9dvS
        NPmfpORQ8qZ9oIAZV3rWHgk+9YcvvV0CIflvjxc=
X-Google-Smtp-Source: APiQypKLxrpqcZXp4Lvogok9Bg5Li11+D/0eI9+stXd8Y+cKxijna9Dykq8W+nckjEEsUAG8fjSAqQD/M/NqKTsb6aw=
X-Received: by 2002:a37:b786:: with SMTP id h128mr29519640qkf.92.1587015760039;
 Wed, 15 Apr 2020 22:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez2R5nZA91j7cf2Z5o3dOEz0QNZK7cxecjmw0B-ZQ7AjmA@mail.gmail.com>
 <CAEf4Bzb2zcfJt6ujAN8zY_=x7-dFO92mPzkbCE+UMHVDGL7J+Q@mail.gmail.com>
 <CAG48ez20KjiYjcYzWnnVCyNTMjNFf+YgnwbbF9BUovZxDzsuEw@mail.gmail.com>
 <CAEf4BzbEcbgAmXSzKx70rEhzmWcZ_8ECuX98_wsfvRkprKQgbQ@mail.gmail.com>
 <CAG48ez15gsNtjiwFtLR_eBGAZnfXAt4O+ykuaopVf+jW5KTeRQ@mail.gmail.com>
 <CAEf4Bzak3FnhD3kUZ4Dn9ZRz=yWSfZ+nkYa1Gz1WeZO7PC7Wkw@mail.gmail.com>
 <CAG48ez0mmVtBVTjy-KmpUnvJ52O=EYKwJWoCxcXH8O6zCG1QHA@mail.gmail.com>
 <CAEf4BzZ2vmdmn111KXXrp3qp1qLb4iMjUJ11Cj06SOGeOB6_Qg@mail.gmail.com>
 <CAG48ez0G5q8CouLsTDHjkOcJ7WKJE09OB9FHFPQJUzQrCmZG1w@mail.gmail.com> <CAG48ez1Bs8_3_+uUB69Qe3RN7tDgD8PcBrzv1H0fqbvd0f4jPw@mail.gmail.com>
In-Reply-To: <CAG48ez1Bs8_3_+uUB69Qe3RN7tDgD8PcBrzv1H0fqbvd0f4jPw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Apr 2020 22:42:28 -0700
Message-ID: <CAEf4BzYGWYhXdp6BJ7_=9OQPJxQpgug080MMjdSB72i9R+5c6g@mail.gmail.com>
Subject: Re: BPF map freezing is unreliable; can we instead just inline constants?
To:     Jann Horn <jannh@google.com>
Cc:     bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Matthew Garrett <mjg59@google.com>,
        KP Singh <kpsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 15, 2020 at 1:04 PM Jann Horn <jannh@google.com> wrote:
>
> On Wed, Apr 15, 2020 at 9:07 PM Jann Horn <jannh@google.com> wrote:
> > On Wed, Apr 15, 2020 at 6:59 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Tue, Apr 14, 2020 at 3:50 PM Jann Horn <jannh@google.com> wrote:
> > > > On Tue, Apr 14, 2020 at 9:46 PM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Tue, Apr 14, 2020 at 9:07 AM Jann Horn <jannh@google.com> wrote:
> > > > > > On Fri, Apr 10, 2020 at 10:48 PM Andrii Nakryiko
> > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > On Fri, Apr 10, 2020 at 1:47 AM Jann Horn <jannh@google.com> wrote:
> > > > > > > > On Fri, Apr 10, 2020 at 1:33 AM Andrii Nakryiko
> > > > > > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > > > > > On Wed, Apr 8, 2020 at 12:42 PM Jann Horn <jannh@google.com> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi!
> > > > > > > > > >
> > > > > > > > > > I saw that BPF allows root to create frozen maps, for which the
> > > > > > > > > > verifier then assumes that they contain constant values. However, map
> > > > > > > > > > freezing is pretty wobbly:
> [...]
> > > > > I'd say
> > > > > the better way would be to implement immutable BPF maps from the time
> > > > > they are created. E.g., at the time of creating map, you specify extra
> > > > > flag BPF_F_IMMUTABLE and specify pointer to a blob of memory with
> > > > > key/value pairs in it.
> > > >
> > > > It seems a bit hacky to me to add a new special interface for
> > > > populating an immutable map. Wouldn't it make more sense to add a flag
> > > > for "you can't use mmap on this map", or "I plan to freeze this map",
> > > > or something like that, and keep the freezing API?
> > >
> > > "you can't use mmap on this map" is default behavior, unless you
> > > specify BPF_F_MMAPABLE.
> >
> > Ah, right.
> >
> > > "I plan to freeze this map" could be added,
> > > but how that would help existing users that freeze and mmap()?
> > > Disallowing those now would be a breaking change.
> > > Currently, libbpf is using freezing for .rodata variables, but it
> > > doesn't mmap() before freezing.
> >
> > Okay, so it sounds like there are probably no actual users that use
> > both BPF_F_MMAPABLE and freezing, and so we can just forbid that
> > combination? That sounds great.
>
> kpsingh pointed out to me that bpf_object__load_skeleton() has code
> specifically for mmap()ing BPF_F_RDONLY_PROG maps, so this might not
> work... but perhaps we could make `BPF_F_RDONLY_PROG|BPF_F_MMAPABLE`
> imply "you can only map with PROT_READ, not with PROT_WRITE"?
> bpf_object__load_skeleton() only maps BPF_F_RDONLY_PROG maps with
> PROT_READ.

I think that's reasonable and given the intent of frozen read-only
map, shouldn't break any reasonable use case. I'll send a patch soon.
