Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64F7FF680F
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2019 10:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfKJJPg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 10 Nov 2019 04:15:36 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41265 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfKJJPf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 10 Nov 2019 04:15:35 -0500
Received: by mail-lj1-f196.google.com with SMTP id m9so10564094ljh.8
        for <bpf@vger.kernel.org>; Sun, 10 Nov 2019 01:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NC4UaOmYyxeIYsdJnwAcb1vsEQuxwDoopSMGqewgnV8=;
        b=rFUVjZIEf9PrQVws+tLtevu6eyP7v8OsQL/Q29XOm6BX84QyzqMZhrW6W0k/xeXoWo
         r8oqpFZfQREpK8sj3G9QVV5leWBV269iimFaEVG/T8qOQmAp86AAtx2wwnwuORA3Mw3L
         qYm8bFey9WLxat/L3VsWYyZxz5t4NOju6O7a/i7tsieTasaP31zUSh9+p33FC5QQ/Z8s
         /AIC3hqHOSh9eesW4purKkM1MfVpxBlkeZdofa3IcyFiEwNy3pzltptGlKgvJwEccnGe
         S8MWXxojuSkGzs/f6Lvs3k+Y1rB81USF2T3mESoh8c/KeX8I9xFgxOGgPk0yCw+1XHuB
         jnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NC4UaOmYyxeIYsdJnwAcb1vsEQuxwDoopSMGqewgnV8=;
        b=fg6E29Op9zhilA4bqG752ONpuJ9KkBzkCmjB2E+OB9l82l2jaHTl4yslUb9KJvlEbL
         McdTwPpWVedcflp9heOBLxmo9TVvK2HWxnttWBUGgoV0biaMlrmpaEJ5KycDFZUEWhbY
         x+iL2MSV0THnPnKddNislWGAxnORTWgwuuOsJ7WzgQj2RvP9bpsyRGnYsZaSN3pXjvB4
         X9Xug7BfRowxBjY7NtdrVHLuQoX8vDQLms+6+K97olVVYuoBh3xBPqfjnl6T0clolch8
         hvgr2PDXH7/9kTgtCTrsdKNzU4gQ9WrWpWs7OeK1IHCuvGGj7lTymFHgSmtLEY3okgWg
         e98g==
X-Gm-Message-State: APjAAAUs/6pEeiJ60yYA31ZcVFxsK9CzDHKs0rCDjLu58bJfwm6VjzFV
        1IyqQSR/t3ArnN5ANWb3kGbia+CR1KdqF9/jD4d0Ig==
X-Google-Smtp-Source: APXvYqxz55BmM0SWVm6sXfhi2GSM8RkM7Fh+UOIM9slJGxqaWfsLQAS1EULfkatYUI0DjuzroQWDufaxhHsv1EDNQzU=
X-Received: by 2002:a2e:9b4b:: with SMTP id o11mr12505739ljj.252.1573377333791;
 Sun, 10 Nov 2019 01:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20191107125224.29616-1-anders.roxell@linaro.org> <CAPhsuW4B_Y+xOTaSFPWm0szn1exjucwL5KBsExWxq4tn_3NSbQ@mail.gmail.com>
In-Reply-To: <CAPhsuW4B_Y+xOTaSFPWm0szn1exjucwL5KBsExWxq4tn_3NSbQ@mail.gmail.com>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Sun, 10 Nov 2019 10:15:22 +0100
Message-ID: <CADYN=9KJ0tFhfkqVvKN9EtHf1RUnj4=g+ufX18s9xANn-ig33w@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests: bpf: test_lwt_ip_encap: add missing object
 file to TEST_FILES
To:     Song Liu <liu.song.a23@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 7 Nov 2019 at 18:55, Song Liu <liu.song.a23@gmail.com> wrote:
>
> On Thu, Nov 7, 2019 at 4:53 AM Anders Roxell <anders.roxell@linaro.org> wrote:
> >
> > When installing kselftests to its own directory and running the
> > test_lwt_ip_encap.sh it will complain that test_lwt_ip_encap.o can't be
> > find.
> >
> > $ ./test_lwt_ip_encap.sh
> > starting egress IPv4 encap test
> > Error opening object test_lwt_ip_encap.o: No such file or directory
> > Object hashing failed!
> > Cannot initialize ELF context!
> > Failed to parse eBPF program: Invalid argument
> >
> > Rework to add test_lwt_ip_encap.o to TEST_FILES so the object file gets
> > installed when installing kselftest.
> >
> > Fixes: 74b5a5968fe8 ("selftests/bpf: Replace test_progs and test_maps w/ general rule")
> > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
>
> Please highlight that this set is on top of bpf-next tree with
> "[PATCH bpf-next 1/2]".

Oh right, I'll send out that shortly

Cheers,
Anders

>
> Otherwise, looks good to me.
>
> Acked-by: Song Liu <songliubraving@fb.com>
