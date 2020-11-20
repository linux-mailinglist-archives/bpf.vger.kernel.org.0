Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACB612BBA6F
	for <lists+bpf@lfdr.de>; Sat, 21 Nov 2020 01:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728341AbgKTX7R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 Nov 2020 18:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728242AbgKTX7R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 Nov 2020 18:59:17 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023A7C0613CF
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 15:59:17 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id b17so11789712ljf.12
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 15:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XGbTCIuZOTjImDuECPHgPztM+ob1Jh/w4JCSuaWysl8=;
        b=F7GS0CnZoLQZsd60ze5qvCDpXMSLI40/SpzvFW2rlnL2ZGQsu9FP2VdHFJJcXSc/Mx
         ywQViQeQUDiVRYnXhOndM5IYUrsZOLGAJjBoQXUcy4dOA6BiQjBOf3l0N81v74uaIp5Q
         /AlhPw10MHseYMV2hIMrFXL3A+9XwPIxX2AA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XGbTCIuZOTjImDuECPHgPztM+ob1Jh/w4JCSuaWysl8=;
        b=eLCLcE7I2SS+KUFSwn4PWAvOe//dmCDyns01Y4lJZfDcBgKOdaFfsVqT/69KOtz3fW
         5Q0hzFyFlysz1NJVurKXW2H5AJ3VWTrrfwySN9L61s/Dzgp/kzw+RV0ZKrtkiyW6CDUz
         TZ3MY0QNa6Bk4RCjMufT1GPMRIXTGn6Xn66YKqHzgyOgqbgTYOj3sRolilUDyTHCEZzp
         MD6vwMlX4gZmIRsDbGtOarUpWHFrNIQPvpyQDt+sLiK4WJXjuN2DcN5MvO3qDwXKwW5w
         9UP+1U2ktUB1laAOTg0aM8LObATAOwUDFx569dI4Ywms0XZ9pMcAbL3IERfj37KrxH4A
         jpvA==
X-Gm-Message-State: AOAM532bxE9KEAyjqMPeWt3guxc5Sm5/a70TMIRI5jEsdoH9I6hszSqV
        7hY32Yh/OI9OvP/l9GMSPQd6iF6oPrPYfQ==
X-Google-Smtp-Source: ABdhPJy8WWA/lPkqvkGCcTZfnKZXrjX01nKXG1/q8OzLqFqy/eqw1XZYL6OPi6lLmE4nKLav85fHeA==
X-Received: by 2002:a2e:998e:: with SMTP id w14mr9566279lji.100.1605916754968;
        Fri, 20 Nov 2020 15:59:14 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id f3sm506870lfc.124.2020.11.20.15.59.13
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 15:59:13 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id b17so11789632ljf.12
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2020 15:59:13 -0800 (PST)
X-Received: by 2002:a05:651c:2cb:: with SMTP id f11mr8560585ljo.371.1605916752808;
 Fri, 20 Nov 2020 15:59:12 -0800 (PST)
MIME-Version: 1.0
References: <87r1on1v62.fsf@x220.int.ebiederm.org> <20201120231441.29911-1-ebiederm@xmission.com>
In-Reply-To: <20201120231441.29911-1-ebiederm@xmission.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 20 Nov 2020 15:58:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh9YvRgb2TsBaJnRM3eARaUp1U-_H-5yMVmSHifC6b-QQ@mail.gmail.com>
Message-ID: <CAHk-=wh9YvRgb2TsBaJnRM3eARaUp1U-_H-5yMVmSHifC6b-QQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/24] exec: Move unshare_files to fix posix file
 locking during exec
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>, criu@openvz.org,
        bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Oleg Nesterov <oleg@redhat.com>,
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

On Fri, Nov 20, 2020 at 3:16 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> @@ -1257,6 +1258,13 @@ int begin_new_exec(struct linux_binprm * bprm)
>         if (retval)
>                 goto out;
>
> +       /* Ensure the files table is not shared. */
> +       retval = unshare_files(&displaced);
> +       if (retval)
> +               goto out;
> +       if (displaced)
> +               put_files_struct(displaced);

It's not obvious from the patch (not enough context), but the new
placement seems to make much more sense - and it's where we do the
de-thread and switch the vm and signals too.

So this does seem to be the much more logical place.

Ack.

      Linus
