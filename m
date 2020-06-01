Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24DE11EAD1B
	for <lists+bpf@lfdr.de>; Mon,  1 Jun 2020 20:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731523AbgFASmo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jun 2020 14:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729781AbgFASmn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jun 2020 14:42:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35559C061A0E
        for <bpf@vger.kernel.org>; Mon,  1 Jun 2020 11:21:28 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k2so179879pjs.2
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2020 11:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=viPBGqxZe33Yc2Esb7OQ2kngpe/ltOOKpTWAHcUjbWs=;
        b=SKDHFM81QnKjfK7xz/DPsHeqqRpqyK7AsINaHQy/Fqk6/xP/B9FzsZWa40e6ijM6Qy
         RHRR1ci6pc+cS99ZUdslrnjZJqlDMobRJZgQ4ZAARIAqBqPRhIPhdH8zJG3S/ZLPA+CI
         ngFLXTHynV3Wugl5zOXoo+ZVRxtI0OeaAzefA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=viPBGqxZe33Yc2Esb7OQ2kngpe/ltOOKpTWAHcUjbWs=;
        b=W1diKgbPR5sNV7BKr/BoiJSxaip2WGVnfth/fcEPfIKPpXl6cabmXnY/HohfHBscbQ
         LebvGGV7GKOD3BhEzcFk2We7iA67J6zRgBjh+sgOWDXz/+c10KtW+4abvVbz1r0lvWUb
         QOyWNqRLUjx+zN69TORSRjSrlqyPBTwZbj6iZ/M/WAkfUTLQkJSXiQKfX8QJL4lWWjIZ
         WkfH5yDa2wVpNRix9CUw78CgJ8GEuUDaJPn3XDwf+8XWDMhzdVV1gYwuEPD/SDrM7w5i
         ud83HijsrdNtXtvHi2nYcUrlablvUX+Osc8VX0Cobe88Sg76UatFZFA1C8vhCHIe0mLp
         8z+w==
X-Gm-Message-State: AOAM532eoS9TZiBVdJywuxR172RrOK5Ju3g0mRD7IaIGt7apkgzplaH/
        D6iOdWVi8yF+lostI0EGMTGMgw==
X-Google-Smtp-Source: ABdhPJxn9ermIOIHrDQ3G+mKVjvic5/rbHK7cfi5LZLfnHkmL8n2qvNv8kjHo8Uz8ejC9e8SrKF5rw==
X-Received: by 2002:a17:902:ed42:: with SMTP id y2mr12419541plb.10.1591035687719;
        Mon, 01 Jun 2020 11:21:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w6sm144150pjy.15.2020.06.01.11.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 11:21:26 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:21:25 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Lennart Poettering <lennart@poettering.net>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "zhujianwei (C)" <zhujianwei7@huawei.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        Hehuazhen <hehuazhen@huawei.com>,
        Christian Ehrhardt <christian.ehrhardt@canonical.com>,
        Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
Subject: Re: new seccomp mode aims to improve performance
Message-ID: <202006011116.3F7109A@keescook>
References: <c22a6c3cefc2412cad00ae14c1371711@huawei.com>
 <CAADnVQLnFuOR+Xk1QXpLFGHx-8StPCye7j5UgKbBoLrmKtygQA@mail.gmail.com>
 <202005290903.11E67AB0FD@keescook>
 <202005291043.A63D910A8@keescook>
 <20200601101137.GA121847@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200601101137.GA121847@gardel-login>
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jun 01, 2020 at 12:11:37PM +0200, Lennart Poettering wrote:
> On Fr, 29.05.20 12:27, Kees Cook (keescook@chromium.org) wrote:
> 
> > # grep ^Seccomp_filters /proc/$(pidof systemd-resolved)/status
> > Seccomp_filters:        32
> >
> > # grep SystemCall /lib/systemd/system/systemd-resolved.service
> > SystemCallArchitectures=native
> > SystemCallErrorNumber=EPERM
> > SystemCallFilter=@system-service
> >
> > I'd like to better understand what they're doing, but haven't had time
> > to dig in. (The systemd devel mailing list requires subscription, so
> > I've directly CCed some systemd folks that have touched seccomp there
> > recently. Hi! The starts of this thread is here[4].)
> 
> Hmm, so on x86-64 we try to install our seccomp filters three times:
> for the x86-64 syscall ABI, for the i386 syscall ABI and for the x32
> syscall ABI. Not all of the filters we apply work on all ABIs though,
> because syscalls are available on some but not others, or cannot
> sensibly be matched on some (because of socketcall, ipc and such
> multiplexed syscalls).
>
> [...]

Thanks for the details on this! That helps me understand what's
happening much better. :)

> An easy improvement is probably if libseccomp would now start refusing
> to install x32 seccomp filters altogether now that x32 is entirely
> dead? Or are the entrypoints for x32 syscalls still available in the
> kernel? How could userspace figure out if they are available? If
> libseccomp doesn't want to add code for that, we probably could have
> that in systemd itself too...

Would it make sense to provide a systemd setting for services to declare
"no compat" or "no x32" (I'm not sure what to call this mode more
generically, "no 32-bit allocation ABI"?) Then you can just install
a single merged filter for all the native syscalls that starts with
"if not native, reject"?

(Or better yet: make the default for filtering be "native only", and
let services opt into other ABIs?)

-- 
Kees Cook
