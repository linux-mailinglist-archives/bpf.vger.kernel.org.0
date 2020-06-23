Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B258920494A
	for <lists+bpf@lfdr.de>; Tue, 23 Jun 2020 07:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728830AbgFWFpI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Jun 2020 01:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbgFWFpI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 23 Jun 2020 01:45:08 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E59C061573
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 22:45:08 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id j80so6485013qke.0
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2020 22:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iQb1LWarUNT4u6FgFIJlMZU0dc6S9SQHy5vQlSUDJQA=;
        b=SIqcQv4RAPWdGwdngkfhBAEwvCqVo2hpbpqWdIDOI/qEtn1oeF7Vn0aaePpoPEm1ne
         4Febm6CK4+XyHdPPW7JnflnuENYe86+8PLeIwIqx4BNtodOfj0rT2axXoU8YB2GfRCww
         lzBmJo8Asvyhe9/ff0SNS8yJ4gD09zfC0pOdMXFnwO8uuMf0WICLFtsE+SUqAwmZlFnu
         5SLGoDIF47Ox38py1hwidGvRGkQ6Ar+KksCiW2k8kliVmx9o/3AWXNtEH315R/vW+6i+
         Er9eUek0q7vSqdweG8TcksmhzKGaU7HlDk+h/keiGoVoi0vsZKSWw8PBixq7/zUEg/JT
         T1Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iQb1LWarUNT4u6FgFIJlMZU0dc6S9SQHy5vQlSUDJQA=;
        b=DYYV4yGeGg8aoRO1+OptJLDTyUNZ9mc9X4o92+6s4CYFZbQgiGDph3lRo9XBhlNWY7
         9cuuorWDmBJ7ZO9U9fASYs/b1MujaiiGCZRrm8kYtC39ew6gE5LS1o7Tk95OOlIPXHuv
         GNjobnvxE6b8xwKchzIXQuevBBZ2Hz4imdEzGlCU6aLHsFFpSWh48dyEwPs2jksX8/Gb
         ngeFLlhVGCVu6gDVg2E629RQZNEPUSDxHJY7djcJHMzc6bxb4g5ThhnDXcGg7aAkpz5i
         kDopnrx/gQ4xdpWemLggm7LIf5JIBK9ft0RiTA8cW7u73R2e09hfCLR1rO1/+Ma2IzK0
         TDRA==
X-Gm-Message-State: AOAM530h7mRW6NWvOzYbMz+XJtLlsJkym8EOWO6XHRyBvOZrXZSsLrj0
        3A9dRspIhVDFh2qMPYdes+P63k5DLcxlUQhrHbY=
X-Google-Smtp-Source: ABdhPJxLOwCrbXNMXY2g8BbgiJ/a4A2blbATs/yhelSaRWtqSwQuinmm7+HKK6n1dcSlLDVnOMDBm2bSjEwjtvasqS4=
X-Received: by 2002:a37:a89:: with SMTP id 131mr18607609qkk.92.1592891107201;
 Mon, 22 Jun 2020 22:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200621142559.GA25517@stranger.qboosh.pl>
In-Reply-To: <20200621142559.GA25517@stranger.qboosh.pl>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 22 Jun 2020 22:44:56 -0700
Message-ID: <CAEf4BzafxBFCa=sm-MoG71iwMA77Rj4OS-6w4U1OahP3+cH_wQ@mail.gmail.com>
Subject: Re: [PATCH] fix libbpf hashmap with size_t shorter than long long
To:     Jakub Bogusz <qboosh@pld-linux.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jun 21, 2020 at 7:34 AM Jakub Bogusz <qboosh@pld-linux.org> wrote:
>
> Hello,
>
> I noticed that _bpftool crashes when building kernel tools (5.7.x) for
> 32-bit targets because in libbpf hashmap implementation hash_bits()
> function returning numbers exceeding hashmap buckets capacity.
>
> Attached patch fixes this problem.
>

Thanks! But this was already fixed by Arnaldo Carvalho de Melo <acme@kernel.org>
in 8ca8d4a84173 ("libbpf: Define __WORDSIZE if not available").

>
> Regards,
>
> --
> Jakub Bogusz    http://qboosh.pl/
