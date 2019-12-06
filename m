Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055401158A6
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2019 22:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfLFVao (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Dec 2019 16:30:44 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:40059 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfLFVao (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Dec 2019 16:30:44 -0500
Received: by mail-lj1-f179.google.com with SMTP id s22so9161796ljs.7
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2019 13:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k0AxtQz+D7li61OwD0X5pV6PAQ8uw+d579qmg3IG/Sc=;
        b=mAfmmdqYYPI+241u23YkLT5FNXAd6Us6oAhyOkFeeaChfuL8HUY/KL/aRPeC98uOjB
         jBRgJGVuaY5rSYOEiVnLD0huIwsk1PmN72pR4DaeFr6S/isdPi7syuc31sNbHp/s7iTC
         oAuG1/6vwNvlvB8iyfZgu/hd6hwR5cl5xev52EZ6lhICVdpMvQD28ICIKiVa9buPcQNo
         Sn3C+NK50zWpLU0kAZSY020jw9rqfutmkug6FQB440KyYK8ADpqOC68gnj1MYlGa+uAf
         1jbC956B7ggVWt2RP9xQJkFx7yLDkuYl5riRLDm7WgqIYVQ/MUlal1CQUtu3KLdbjdB7
         0KxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0AxtQz+D7li61OwD0X5pV6PAQ8uw+d579qmg3IG/Sc=;
        b=mRBEb+1tR+6yw3NNpj1fMm3AMkTCjlfggsJN4BMrZ/2oKYs5nZDm+uxMGDNGNFw7pU
         sG06bF2GO+5XB5zV3OtjXw28gqJJGyEU3OP3vztYbTt+klN5tWTiMVOYs1YobRBEwmNt
         rcl2k9sKEQKnbYbe45h/C9+nETz6vz6ngKQxRwt9BNLTfqmjUA9dADdcUV1zdmazHKQ8
         Y/yS1s2taDOoo4lAy/u4gHdgmrcferc7zjC1MdK9PUGE0TYySLSs+1UgOo6yDzLeFgm5
         7OwM7CZBP2XwCEMYeNPCQV/occZePmXJf7k4/3egfKMA9nKPflY8JSvHbQg6GdivaEPJ
         iCGw==
X-Gm-Message-State: APjAAAVxnayyy8RTDkwL+03TXS5tBjdokIosPCpuxDJ3DMopQQ3/sMMd
        MMAG9z6kHgiHNuDdt9Uf0EPP00YlbTxmiaXTw+Jc
X-Google-Smtp-Source: APXvYqyZoE3a2k8tZCPJpj4lF4MwO9mGx9MdBNu06QbG8u9mHXKSYb/POTKAfMu4sAUc1UjlBg8/cUDFd3qgiyCR00Y=
X-Received: by 2002:a2e:4704:: with SMTP id u4mr9986759lja.117.1575667841756;
 Fri, 06 Dec 2019 13:30:41 -0800 (PST)
MIME-Version: 1.0
References: <20191205102552.19407-1-jolsa@kernel.org> <CAHC9VhTWnNvfMAPz-WhD9Wqv6UZZDBdMxF9VuS3UeTLHLtfhHw@mail.gmail.com>
 <20191206212746.GA30691@krava>
In-Reply-To: <20191206212746.GA30691@krava>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 6 Dec 2019 16:30:30 -0500
Message-ID: <CAHC9VhRv8dTXt0e9L16KXdCTs8E-fFym5tWq8y0dqPT0ghgKgw@mail.gmail.com>
Subject: Re: [PATCHv2] bpf: Emit audit messages upon successful prog load and unload
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-audit@redhat.com,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Steve Grubb <sgrubb@redhat.com>,
        David Miller <davem@redhat.com>,
        Eric Paris <eparis@redhat.com>, Jiri Benc <jbenc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Dec 6, 2019 at 4:28 PM Jiri Olsa <jolsa@redhat.com> wrote:
> On Fri, Dec 06, 2019 at 04:11:13PM -0500, Paul Moore wrote:
> > Other than that, this looks good to me, and I see Steve has already
> > given the userspace portion a thumbs-up.  Have you started on the
> > audit-testsuite test for this yet?
>
> yep, it's ready.. waiting for kernel change ;-)
> https://github.com/olsajiri/audit-testsuite/commit/16888ea7f14fa0269feef623d2a96f15f9ea71c9

Seeing tests for new features always makes me happy :)

-- 
paul moore
www.paul-moore.com
