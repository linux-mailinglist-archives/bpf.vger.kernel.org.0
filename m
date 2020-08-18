Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCA9247BD4
	for <lists+bpf@lfdr.de>; Tue, 18 Aug 2020 03:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgHRB24 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 17 Aug 2020 21:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgHRB2z (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 17 Aug 2020 21:28:55 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA400C061389
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 18:28:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f26so19566952ljc.8
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 18:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H9GGIPZeeCr2buv5LskGV0KUkXunajXDJwMIsnUEH9E=;
        b=XB+4puoAJ7oLIcF7LzRl/MGchCEIBEGK143/RcJlKBa6gZV2vs2J0/WgoHfVuiYGzU
         yP8FrR6fRFu089/Ospd7PbbInczCklxVj6i0XRwtqWSI/I6DXT6hmzzEpnvoMEV80Id2
         N57VYh7HVcjr6EsHTAY/h831U5di5F/kheIj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H9GGIPZeeCr2buv5LskGV0KUkXunajXDJwMIsnUEH9E=;
        b=b4yN3DAPo0ibzCQaTp2EW1WvUj75ItPHc7ysq4qG9Y3Pn+dYPOmhws0/DMcbycENfQ
         Z8mSjgiyqUXzHwapulBR+ANyFObME7zG+tw3K5CB905u9JIC7HTEzxjoPdgZjBkLNvBV
         f8cix/0QG3KuspiHpdCths3fY7h0X0+Z2PPcYm9zbOu4r4XhfQEva5IKKqdFsp6nKJ0J
         onxl/UVa34dMbwx+EJRx6e3uDM8qdCWQlIdwQbxO6kYuiTH7ucW2ZdLlrZ98XaJTmM+9
         iUISJue5E/VRXmr2NXluKHMRp3zm2Scv84wKEUjuxzme+oHxNLb2EAkDycXXRKxbBeqs
         DG9g==
X-Gm-Message-State: AOAM531ZpACMO234D4niWT6b5XJUfywVOlCUxIxS+cZluWojfe0OzQDJ
        1+yMK5zj0+217OuAo6TyMF7ihX7mIGA1Fg==
X-Google-Smtp-Source: ABdhPJylDBbzgSc5hDZxeIJhTeF29xunxVxINb8bBRsDSs8MmQOdA78OUUjqi7La/fAaUMjDOPYVlQ==
X-Received: by 2002:a05:651c:543:: with SMTP id q3mr8397638ljp.145.1597714132917;
        Mon, 17 Aug 2020 18:28:52 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id j66sm5962362lfd.74.2020.08.17.18.28.52
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Aug 2020 18:28:52 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id t6so19560863ljk.9
        for <bpf@vger.kernel.org>; Mon, 17 Aug 2020 18:28:52 -0700 (PDT)
X-Received: by 2002:a05:6512:241:: with SMTP id b1mr8521728lfo.125.1597713683604;
 Mon, 17 Aug 2020 18:21:23 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-12-ebiederm@xmission.com>
 <CAHk-=whnocSU8muZvmCBoJNz8vYO53fi8S06cSYwdqh1WfDqig@mail.gmail.com> <87v9hg69ph.fsf@x220.int.ebiederm.org>
In-Reply-To: <87v9hg69ph.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Aug 2020 18:21:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_Tg4TYz2_SPE=h+xjXKTDCTCRzg=1ERgh_6WOVTgz9w@mail.gmail.com>
Message-ID: <CAHk-=wj_Tg4TYz2_SPE=h+xjXKTDCTCRzg=1ERgh_6WOVTgz9w@mail.gmail.com>
Subject: Re: [PATCH 12/17] proc/fd: In fdinfo seq_show don't use get_files_struct
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 17, 2020 at 6:13 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> task_lock is needed to protect task->files.

Hah. Right you are. I found a few cases where we didn't do that, but I
hadn't noticed that they were all of the pattern

        struct task_struct *tsk = current;

so "tsk->files" was safe for that reason..

So never mind.

           Linus
