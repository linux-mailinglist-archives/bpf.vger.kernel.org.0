Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C73835FED7
	for <lists+bpf@lfdr.de>; Thu, 15 Apr 2021 02:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbhDOA2k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 14 Apr 2021 20:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhDOA2j (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 14 Apr 2021 20:28:39 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3627C061574;
        Wed, 14 Apr 2021 17:28:15 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id k73so17885370ybf.3;
        Wed, 14 Apr 2021 17:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DFlmD2IcGE8mdewprdvFzz8B8Jh3L7e3VAFDs4879yQ=;
        b=sk3Ygg18PtzGk5rJnjmULucFP6fpxCnu0nbvFKkZ95Yvr9RmkNJubcEgPww1Tb4kYY
         m9KA4jxFaSwEc5lWiFdbqlm19r2GQmtA3OywBSzvS3E3zNgpQYxROth3niVXMezaxgIR
         yaCuxP8zeQJ+7OjqYVAxrxv7O5pHnU0yzyYw/y2/q3LM+rT63V0/An5GWurWxQDUpD07
         twEUNV86TNjG1Ply771svk27/nn5Qw6uhMbIk9c4Y+kM+F8VFJHo06hqzGONNOOKI55/
         oAq8DLScXpGi+rhU5F0rJn6k7j4+A27IADhpyQJsYzYfVv03BtonEMSo6hdG2KdZTtp1
         9s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DFlmD2IcGE8mdewprdvFzz8B8Jh3L7e3VAFDs4879yQ=;
        b=dZVsd5ggksUA+AF5UAhPZchHDR6/Xl9gzUmhSKRGhoR1GjpprTho0jWRzB2nIbWCIo
         3qDNbOsB8V5/YNv/yqBCCuQz+w+Zvr+6jG20oq/aZmIS1iBmcqt8TzpG0ofWrD9E9kIV
         IYuv8vPDuh6DFR0xMUyt+pUwxQFCvLwBD9Te67B3QoFHaVem5ycL4MmG03I0h7ADFEF0
         5Zyf/pBkzwfWk2CA4cbQNba3/ICB7iLn9uOFdG26+9HI2rLuR6C7jecrmCUwiZ2rHnHU
         sCXaEknTfowTamM+m1BkIsjRPDm95HcEdPsZdCjE9xNl+6pUE2eGxxdJIM+tC1ozAn/7
         vmGA==
X-Gm-Message-State: AOAM532TS3J7KUp/e/VytL+gsTXXFjN5VeC0fhdl9KtvR3HyCwym9fyF
        gfCcdpgdOyYkroNGlkrjv4K6rkSpQUn1lgGa0cI=
X-Google-Smtp-Source: ABdhPJwTHzjQhURwnB9CjFT7el4suRf2NyEl8kc8ApV8sWWqwqdLGANlqLQBokONLSLYyWsB8gOzHiVhmnuUQNSnWXc=
X-Received: by 2002:a25:c4c5:: with SMTP id u188mr817891ybf.425.1618446495207;
 Wed, 14 Apr 2021 17:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210414155632.737866-1-revest@chromium.org> <20210414185744.y6x4pmnkqph5tmnb@kafai-mbp.dhcp.thefacebook.com>
In-Reply-To: <20210414185744.y6x4pmnkqph5tmnb@kafai-mbp.dhcp.thefacebook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 14 Apr 2021 17:28:04 -0700
Message-ID: <CAEf4BzYT6mvExWGKGBgrfJP9FCWc9uzcYK_mh5_-ZTUYAATZLA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Fix the ASSERT_ERR_PTR macro
To:     Martin KaFai Lau <kafai@fb.com>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Apr 14, 2021 at 11:58 AM Martin KaFai Lau <kafai@fb.com> wrote:
>
> On Wed, Apr 14, 2021 at 05:56:32PM +0200, Florent Revest wrote:
> > It is just missing a ';'. This macro is not used by any test yet.
> >
> > Signed-off-by: Florent Revest <revest@chromium.org>
> Fixes: 22ba36351631 ("selftests/bpf: Move and extend ASSERT_xxx() testing macros")
>

Thanks, Martin. Added Fixes tag and applied to bpf-next.

> Since it has not been used, it could be bpf-next.  Please also tag
> it in the future.
>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
