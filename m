Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5561430E964
	for <lists+bpf@lfdr.de>; Thu,  4 Feb 2021 02:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhBDBWV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 3 Feb 2021 20:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233750AbhBDBWU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 3 Feb 2021 20:22:20 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0DC061573
        for <bpf@vger.kernel.org>; Wed,  3 Feb 2021 17:21:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id m1so1541630wml.2
        for <bpf@vger.kernel.org>; Wed, 03 Feb 2021 17:21:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorremedies-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j+CCct/yqWWhCZw3gwa5fyc19nO2DSL0stjS7g0kfQE=;
        b=M8tQrAQYX3vA8+ymM1L8FvjWGkC9spE50A2roKqIlqca2ocZ5rT1EUTHyPnBXC1pqk
         9s+u5KcASFJpwVwC7bqTe6v4ZpUNS9/gOaz3xG8E78xWAaEk7YLcDOPy95l2bj/a1tPk
         DK/5EwlrOlRFwQz+J+5bYZq4UVcIFwy5dM5vwc+vGFpicJyliw+5GQQTBh9k0sAefchB
         oPQQfEaL7En9+fQ4Cb7qGhIkb5BUopuBlxE9vasaX16WtZaVM8NmCRnp7dABEQycAFjf
         K8eIz7R+CnbOtUR1Cew3a1hSdphcDDMzpBFLp5rhoOvuv/rY1ybNchKYQPCE1/b94Ul4
         laIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j+CCct/yqWWhCZw3gwa5fyc19nO2DSL0stjS7g0kfQE=;
        b=S44aMHYWjl+3Z0AMfSnoisg+jkNy3pP4a+XQxuy5dTShSGWoXGt7wOUp23P65jCEbM
         E1eEx+qFmsUuz9lmU1qzgNgJL+ClDTV9e4mEaq+CKPSXPh92qG30XjKI7pAMz7MBFSdI
         weipjJoSTLegnkkd/NhLBNuIsJHFvSjtYYCQskV8t0HbUJM6jVY+9XqB9jrxApXbH8S9
         jwquh/haodixxzuMT7sRke0+M+f08KkK+VW9FRSZb3my0seKeoBr4+yVqE4BFSYbep7k
         t6PpSxiN9dltwJKcZcvSIektlNXyU4BrEwieqekf/heAPNEm4IaoG3xR7TdMIvhg14wV
         ifDg==
X-Gm-Message-State: AOAM5313pcbUsZ10fQM4Xo/bPYV04s6DdEAurE91nwBAAZLi9l8SPJt9
        KfkL94EbLXVpyr4RBHH2gjIWfa5RZdrxL74JOYLvqA==
X-Google-Smtp-Source: ABdhPJyoddBm71GAgrITcaKh7lIpdDRtQ2IIFSgXI9xVVdWlRZPbBamWdTzrEqVP9pNwezaRYtgBBRawQ+K06qZSLI8=
X-Received: by 2002:a05:600c:3504:: with SMTP id h4mr5232890wmq.168.1612401698810;
 Wed, 03 Feb 2021 17:21:38 -0800 (PST)
MIME-Version: 1.0
References: <CAJCQCtSQLc0VHqO4BY_-YB2OmCNNmHCS6fNdQKmMWGn2v=Jpdw@mail.gmail.com>
 <CAJCQCtRHOidM7Vps1JQSpZA14u+B5fR860FwZB=eb1wYjTpqDw@mail.gmail.com>
 <CAEf4BzZ4oTB0-JizHe1VaCk2V+Jb9jJoTznkgh6CjE5VxNVqbg@mail.gmail.com>
 <CAJCQCtRw6UWGGvjn0x__godYKYQXXmtyQys4efW2Pb84Q5q8Eg@mail.gmail.com> <20210204010038.GA854763@kernel.org>
In-Reply-To: <20210204010038.GA854763@kernel.org>
From:   Chris Murphy <lists@colorremedies.com>
Date:   Wed, 3 Feb 2021 18:21:22 -0700
Message-ID: <CAJCQCtQfgRp78_WSrSHLNUUYNCyOCH=vo10nVZW_cyMjpZiNJg@mail.gmail.com>
Subject: Re: 5:11: in-kernel BTF is malformed
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Chris Murphy <lists@colorremedies.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 3, 2021 at 6:00 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Wed, Feb 03, 2021 at 05:46:48PM -0700, Chris Murphy escreveu:
> > This is just the vmlinuz-5.11.0-0.rc6.141.fc34.x86_64 file
> >
> > https://drive.google.com/file/d/1G_2qLVRIy-ExaJI1-cTqDssrDu3sWo-m/view?usp=sharing
>
> Can you please provide the vmlinux for this file as well?

Used this
$ /usr/src/kernels/5.11.0-0.rc6.141.fc34.x86_64/scripts/extract-vmlinux
/boot/vmlinuz-5.11.0-0.rc6.141.fc34.x86_64 > vmlinux

https://drive.google.com/file/d/1h6cC9oZ16oLbR6NyPqKkVGaoUQ2u1UQz/view?usp=sharing

I recompiled with gcc 10.2.1 and I'm not having these problems, so it
might be that.



-- 
Chris Murphy
