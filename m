Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 463CF6D722C
	for <lists+bpf@lfdr.de>; Wed,  5 Apr 2023 03:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231166AbjDEBuW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 4 Apr 2023 21:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDEBuV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 4 Apr 2023 21:50:21 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8541C30EB
        for <bpf@vger.kernel.org>; Tue,  4 Apr 2023 18:50:20 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id z11so22686236pfh.4
        for <bpf@vger.kernel.org>; Tue, 04 Apr 2023 18:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680659420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiLP8+jrkzQ3lueZOsZEvhct3X91sxPt24zWr/HNoAk=;
        b=MFlM7nWz1NH0wWaYss0YxPJMJv5X0u6kUwlD8b4hQAReHD0fn6FWqaZ+s1LGTvo6VC
         +ciAX6zIzC8OMFCK+cPJ8iKHZwhcalGEPbVfWznavExkfNr4x88j2kM6KGdha0JRQ0KY
         SFfuRO+jDd7KixmFrbpcsfwj8MlMKH9+R8yUfiUeSH0Va2tCMURFz2nR3PE0/GRHgi9b
         /tl67YtJbiw5dbvSG15BZhtrF2CS4vKHcooWeWXi3XWLkNJIgQYvM/l+ma0iqLS4MuMK
         epDQrq65HBwulAoYGNmVUEC2LhUDLIbgaKcxPvt7GTmmZmZy3fe4j5I8FO8KXWFUN7X4
         5E9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680659420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiLP8+jrkzQ3lueZOsZEvhct3X91sxPt24zWr/HNoAk=;
        b=X/E/ylAidcSklp7NZyMYgRNoNoWbZY/0Xgw/26SvContMMjn2sCvTGfRH8e6U68pBW
         MxS3L6J49a10C4Zmvl4uuDNP7T2GRhmnR4x1dQIe/yinKRix25TwcD22Y7TIFpy0ZGdZ
         WBpUAnujKfvN4bI+WlZq64ut++lojmSk2/rmkLdQFtKxpko1UYt4piRnwqm8l1FiLYWC
         +8anQ8Uy87ChMBXJP5guzof0X0h/f51WaLlJClKLCenXamgAls039YPwW8uXZoa6ZrQj
         igFUOMUC6NStwy2whvbg+0pMWaZZdKh4sECrvqQJm/E1J9XJ8/Jaqx3HZH7QUfw+eu1I
         /9pA==
X-Gm-Message-State: AAQBX9f3cmkDJG1cmeHdqtG0d4leaQ0G5UBIQyNMYpcLwboak6CIepxJ
        B4Uifbi/37LckvZz4xb91rZnhsnF9sMbmli8La9n5g==
X-Google-Smtp-Source: AKy350aDs8BFxwpio6vfckt1hLdzFHk8VYGmtHOts8wGPj4S0QaoGearr+lp7p8f+qWr9ccJZms4IhlXRpcTK8xBi8o=
X-Received: by 2002:a05:6a00:2da6:b0:625:ccea:1627 with SMTP id
 fb38-20020a056a002da600b00625ccea1627mr2326660pfb.5.1680659419824; Tue, 04
 Apr 2023 18:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <CA+PiJmRwv8UTyQuEBmn1aHg5mXGqHSpAiOJF0Xo9SwZLfW623A@mail.gmail.com>
 <CAEf4BzZntoM0fHzgBuGiqiTNkq=jT-f09nwub-MHyguJCfLeNA@mail.gmail.com>
 <CA+PiJmSNnQ9DD+JVc9hG7iEj5ZDZfhOhYAMKs+f=kXs=DZxuAA@mail.gmail.com> <CAADnVQKMrsc+Dxz3uWeKzCPDfr0XKWaWsbn3AeEm+RCmp-apUQ@mail.gmail.com>
In-Reply-To: <CAADnVQKMrsc+Dxz3uWeKzCPDfr0XKWaWsbn3AeEm+RCmp-apUQ@mail.gmail.com>
From:   Daniel Rosenberg <drosen@google.com>
Date:   Tue, 4 Apr 2023 18:50:08 -0700
Message-ID: <CA+PiJmT4KyWAAEbYWggOLdy-WR=m1D+EO3j1+=UbY-wVUpzYDA@mail.gmail.com>
Subject: Re: Dynptrs and Strings
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Paul Lawrence <paullawrence@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 4, 2023 at 3:58=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> I'm pretty sure we can make bpf_dynptr_data() support readonly dynptrs.
> Should be easy to add in the verifier.
> But could you pseudo code what you're trying to do first?
>

I'm trying to do something like this:

bpf_fuse_get_ro_dynptr(name, &name_ptr);
name_buf =3D bpf_dynptr_data(&name_ptr, 4);
if (!bpf_strncmp(name_buf, 4, "test"))
   return 42;
return 0;

Really I just want to work with the data in the dynptrs in as
convenient a way as possible.
I'd like to avoid copying the data if it isn't necessary.

At the moment I'm using bpf_dynptr_slice and declaring an empty and
unused buffer. I'm then hitting an issue with bpf_strncmp not
expecting mem that's tagged as being associated with a dynptr. I'm
currently working around that by adjusting check_reg_type to be less
picky, stripping away DYNPTR_TYPE_LOCAL if we're looking at an
ARG_PTR_TO_MEM. I suspect that would also be the case for other dynptr
types.

I guess for dynptr_data to support R/O, the dynptr in question would
just need to be tagged as read-only or read/write by the verifier
previously, and then it could just pass along that tag to the mem it
returns.

>
> Do you expect bpf prog to see both ro and rw dynptrs on input?
> And you want bpf prog to use bpf_dynptr_data() to access these buffers
> wrapped as dynptr-s?
> The string manipulation questions muddy the picture here.
> If bpf progs deals with file system block data why strings?
> Is that a separate set of bpf prog hooks that receive strings on
> input wrapped as dynptrs?
> What are those strings? file path?
> We need more info to help you design the interface, so it's easy to
> use from bpf prog pov.

I have a few usecases for them. I've restructured fuse-bpf to use
struct ops. Each fuse operation has an associated prefilter and
postfilter op.
At the moment I'm using dynptrs for any variable length block of data
that these ops need. For many operations, this includes the file name.
In some, a path. Other times, it's file data, or xattr names/data.
They can all have different sizes, and may be backed by data that may
not be changed, like the dentry name field. I have a pair of kfuncs
for requesting a dynptr from an opaque storage type, so you can avoid
having to make unnecessary copies if you're not planning on making
modifications. The r/w version of the kfunc will allocate new space
and copy data as needed. They're a direct analog of the helper
functions from the initial patch. The opaque structure includes
information about the current and max size of the argument, whether
the current backing is read-only, and other flags for cleanup if the
helper allocates memory.

The Fuse bpf programs may alter those fields, and then returns whether
it was able to handle the request, or if the request must go to
userspace.

While the fields have a max size, their actual size isn't available
until runtime. That makes the current set of dynptr functions largely
unusable, since I believe they all require a known constant size to
access, and I don't think the helper to return the length of a dynptr
counts for that as far as the verifier is concerned. Worst case, I
suppose more of those interactions could happen behind kfuncs, where
they can perform runtime checks. That may end up being overly
restrictive though.
