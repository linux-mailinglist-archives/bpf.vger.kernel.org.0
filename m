Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26D02C1335
	for <lists+bpf@lfdr.de>; Mon, 23 Nov 2020 19:33:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731930AbgKWScH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 23 Nov 2020 13:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729487AbgKWScG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 23 Nov 2020 13:32:06 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB30C0613CF
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 10:32:05 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id e139so25195880lfd.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 10:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GqcYLKj/NZRsqtATYR+P+/ypK5dgCZ+R6Ix8LeOTgdM=;
        b=XOYSyXSCBiFCeiwN5T3mq03mJVEfjBlNTRNj+97JpTIv9QNoYcq4KVTHoZKM0RHUiZ
         aMU5eBLcUVn2oepe6LrQnnte++28IjEawjsUcGYm7bg7xVWSL0ZVXbri92VAFRnzmk1D
         ELGEE8c/OC8+MrV/MShiQvK0KfsI5O3l0+7BU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GqcYLKj/NZRsqtATYR+P+/ypK5dgCZ+R6Ix8LeOTgdM=;
        b=QtemszwJXifUvzZl9XMwkPihBEPv1j+kxeD7FDVX6ii9eOOooFR+pMHIVki9XefHs7
         CytgrqsuB5Hy5xZtMlQOQEKdcDFh+QJRsiQpe6JWvQi9bGPYveKdRmUaY37xbbUmbpkP
         +O4hqURJ3u6CwMeU8sOcnjdnpX1EuDB9azOQKCoEY0Kr1CuBjOv1doOZ41AAHqyPbo9/
         nh4H5R4vQ0ZzeidTMPZipeLvr4Jx2pAW+MAfwpHXGStujoxCicMbRoQXJ8uQd57rLuvi
         Rk3JLj4iM6pzONF5W1A15omMuSsEn51hP7c9SCvHbfX2BcpGpwzFGGCpLZj6HeWsDRrG
         H5YQ==
X-Gm-Message-State: AOAM532zcyJnH6EhEkFS1dAPvnV2VKrzeV5cYDwp1wLcPOAWfCSrTFkP
        Ta2vC0t7ldcDoMLuyt5QJ9Oj++FBBv93qw==
X-Google-Smtp-Source: ABdhPJyJknzA4KRDcg8AKHXPlfEVkSPi5Vr+QQkYbg+YoPnT1iVZ4WyvONiECnWDbxCU8RT8Fv0mUA==
X-Received: by 2002:ac2:5b4a:: with SMTP id i10mr216995lfp.92.1606156323445;
        Mon, 23 Nov 2020 10:32:03 -0800 (PST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id p8sm1462075lfk.109.2020.11.23.10.32.03
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 10:32:03 -0800 (PST)
Received: by mail-lj1-f174.google.com with SMTP id y16so19131115ljk.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2020 10:32:03 -0800 (PST)
X-Received: by 2002:a2e:8e33:: with SMTP id r19mr281899ljk.102.1606155929844;
 Mon, 23 Nov 2020 10:25:29 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-2-ebiederm@xmission.com>
 <20201123175052.GA20279@redhat.com>
In-Reply-To: <20201123175052.GA20279@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 23 Nov 2020 10:25:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
Message-ID: <CAHk-=wj2OnjWr696z4yzDO9_mF44ND60qBHPvi1i9DBrjdLvUw@mail.gmail.com>
Subject: Re: [PATCH v2 02/24] exec: Simplify unshare_files
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@infradead.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 23, 2020 at 9:52 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Can anyone explain why does do_coredump() need unshare_files() at all?

Hmm. It goes back to 2012, and it's placed just before calling
"->core_dump()", so I assume some core dumping function messed with
the file table back when..

I can't see anything like that currently.

The alternative is that core-dumping just keeps the file table around
for a long while, and thus files don't actually close in a timely
manner. So it might not be a "correctness" issue as much as a latency
issue.

             Linus
