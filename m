Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1381F44DBE2
	for <lists+bpf@lfdr.de>; Thu, 11 Nov 2021 19:56:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233234AbhKKS7g (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Nov 2021 13:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhKKS7f (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Nov 2021 13:59:35 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B18C061766
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:56:46 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id y3so17524204ybf.2
        for <bpf@vger.kernel.org>; Thu, 11 Nov 2021 10:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dnIc47purjwMpUl5e3CLm7Ww5Sx8C0i487XgWjDX+Zk=;
        b=FJN3sDx+2YrS8cbTpI5MGhTiZCoPbz4tHrWPK0QktWOHHU5f1g9ApBtBaZHAQOfyuv
         tCrdhyz7DHdOs4/eu+m6qr0tVfDbZVyIfNpF3/QiFBRvR+Xh73LRaQUs0X9dFDHYY6jA
         VhoHN9H/hlmyPnNdzJY5CgP3d9hlSQEV6qmmHJ2NVMDkoQLcu2x6xuH7njaZ/ygQ0Q+0
         d9xmqXeQLstlmhwHbqN/0UIZgiTJ/cey95t3hYoHwjrI+sZVMh7aV98lOYKwgR7BDtKJ
         JZuo1IsRIm0Upjzkpk0e4y1KRLPw1l5HPtaPonfXdD8EiewedGr10kJpH7nGJpfM29ux
         flQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dnIc47purjwMpUl5e3CLm7Ww5Sx8C0i487XgWjDX+Zk=;
        b=d4ADn+0BhQ+yUiAY4vt14AYx9/MvkOpDF+WHZkDMrSvncQJH5iy8jaDFRQxltOnAJX
         1MD1ahvYjyahz1YXNGhkXTfrI3B613/jWJGljhj6j0DktAJzWZXdlJZJW4ksibEjLHHT
         s8hRO/HdpME5HlVzMMfwcr+GQnFVpIdT9eHwqLHtmsLWThm+L8PK17gF5CEa+whe/sJ8
         r0nclY2J78tWhazfZ2Y0mzG9h11HzNyoTt1z6NIZRn4cKSqed61SPtCODHPig0KRhLvI
         aJF5jKr20oi8JkKGec9Q/ThE6TTtbdmgKx2DrbT647ESRSH4El7TJoY5RGDT7qwnsJId
         D+1w==
X-Gm-Message-State: AOAM5335g2PyzUnMsjKzxbzaL1WPRN5EEbMkJNPEFiEdACzq9thKKaJJ
        y461icR+RoxFQ8/ciuY/97v1EapiHtAhSytmxlgn+8Ygja0=
X-Google-Smtp-Source: ABdhPJxCo7gJUUhzAOt+WU+ujNeq+h3As18WKhA3BVHqj+qvCHJofm6ppxVqg1l/JJHDhmdu9NTvSivCd3vPIsGdq5c=
X-Received: by 2002:a25:d010:: with SMTP id h16mr11252898ybg.225.1636657005775;
 Thu, 11 Nov 2021 10:56:45 -0800 (PST)
MIME-Version: 1.0
References: <20211110051940.367472-1-yhs@fb.com> <20211110052033.372886-1-yhs@fb.com>
In-Reply-To: <20211110052033.372886-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 11 Nov 2021 10:56:34 -0800
Message-ID: <CAEf4Bzaj1=FPSQW1Bcujgwh9emQ5ncQf8tgxgzKBm5+8WOFYJw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 10/10] docs/bpf: Update documentation for
 BTF_KIND_TYPE_TAG support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Nov 9, 2021 at 9:20 PM Yonghong Song <yhs@fb.com> wrote:
>
> Add BTF_KIND_TYPE_TAG documentation in btf.rst.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  Documentation/bpf/btf.rst | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>

[...]
