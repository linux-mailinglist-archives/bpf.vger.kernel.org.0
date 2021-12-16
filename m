Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43D604768BB
	for <lists+bpf@lfdr.de>; Thu, 16 Dec 2021 04:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhLPDd7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 15 Dec 2021 22:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhLPDd7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 15 Dec 2021 22:33:59 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F81C061574
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 19:33:59 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id y68so60893511ybe.1
        for <bpf@vger.kernel.org>; Wed, 15 Dec 2021 19:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g3vQi+5i1OPz61K5j5MfR4tB9UkCUXTRdprJ/WRZrzo=;
        b=BY6XqUnexdOD7QozuL6MwP/a/M5hlV0B+5lHS+hx9zlmh9yMZp84y52gZHWJJ42x7q
         iIMxQpXN1C/PSLikERthEq9XDBmz+P0dfbL+Iss9cr2ouZxWuuLb8IcDzQCuirF3OX+L
         MSzezn55taHp+FK/xqWQyW0gDbm459r5P1rp+OfLuiZpGFE4sZPHeNa9pW0nL+MaFIeJ
         8EZDFUMWYcnV/Li+ZnULQO4Lad9CEWwvHZQ36seHbWYwPpHjP4tETu1qKmXxsRDzNftL
         QihC3USi/aod5whwRfcbVhhkxBQykPGW7Q8UsBGcBl/h/LTgAH3hN/wY+n550l5HdCnX
         jDmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g3vQi+5i1OPz61K5j5MfR4tB9UkCUXTRdprJ/WRZrzo=;
        b=eIlNGFgYe1K6nBByRx/dYK8+nPhYw3OTk8m4busJU5pHGfooTppaY/U8uZ8llgPmaF
         Nu5frkWkdlfklcW32U9RgYGA5S2+WlbVTyUoLjw0/HaDU2h81NB1oOwE7r9Jk6HIYs+P
         5oabLAmFVi8LQyTjR8ulb8dSj9BH7SnIV6fx2cKh5YsHhwTSN9G9jtQ0uYAKEgVt1zXZ
         PmcYEVjlw4rT0QQQwREpe0zeTkoHqN7nNAc78kJ74yzhw+733NE/ulj+QJNCi9SUHrCF
         zpLtwTx5t9xHPLSYVxGE1hlts8R9dkg+qYrPmefxZU9+S1F4hqt5gbp8TyIQV+D7MYPi
         450A==
X-Gm-Message-State: AOAM531DnegBIvvLwJNDlXcAuglSvVld2bTeJkGpjHv2PuAro+hslBeO
        yXBKwO/eyD0GobXWb8K/spCtWzVf3tzzXmOqaJv/Ot57IPQ=
X-Google-Smtp-Source: ABdhPJzI6LaoMj6T8ozexBW2f1IMOshJKzgKKg+YrflPU2l95vH6cxvnpY0Qq96Y24mKGAT6k+4exR4r040I5xt7WFY=
X-Received: by 2002:a25:e90a:: with SMTP id n10mr10151026ybd.180.1639625638355;
 Wed, 15 Dec 2021 19:33:58 -0800 (PST)
MIME-Version: 1.0
References: <20211210063112.80047-1-vincent@vincent-minet.net>
 <CAEf4BzbRqsi_0fBYK2S-huurKic1X1hDcJYX=0sDCVpvp669gg@mail.gmail.com> <YbqpAnxRnEbu1but@localhost.localdomain>
In-Reply-To: <YbqpAnxRnEbu1but@localhost.localdomain>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 15 Dec 2021 19:33:47 -0800
Message-ID: <CAEf4BzYkVD2wjKrVuVOU7y3SKNabKUXmP5dVvQgAgY2zaQzMHQ@mail.gmail.com>
Subject: Re: [PATCH] libbpf: fix typo in btf__dedup@LIBBPF_0.0.2 definition
To:     Vincent Minet <vincent@vincent-minet.net>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 15, 2021 at 6:48 PM Vincent Minet <vincent@vincent-minet.net> wrote:
>
> On Thu, Dec 09, 2021 at 10:48:15PM -0800, Andrii Nakryiko wrote:
> >
> > How did you run into this problem? Are you using btf__dedup() for
> > something? Can you please share some details?
>
> I ran into the problem with pahole (built against the shared libbpf).
> Nothing more than that.

I see, ok. I was just wondering if someone else is using btf__dedup()
for something else. Thanks.
