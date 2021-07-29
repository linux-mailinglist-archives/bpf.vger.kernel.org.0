Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3E93DA45D
	for <lists+bpf@lfdr.de>; Thu, 29 Jul 2021 15:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237991AbhG2Nad (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 29 Jul 2021 09:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238055AbhG2NaJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 29 Jul 2021 09:30:09 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B6AC0617A0
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 06:30:04 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id f26so10224591ybj.5
        for <bpf@vger.kernel.org>; Thu, 29 Jul 2021 06:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Qz9La3QPRMndTjsVYo9vnU/gF+lgGUUdSa/ncd8lBk=;
        b=yuwYCym4ZCkUrjAr3kGI7Zwpk9UdTA6kptMprZ7yZVZeVD1JU4YjO07xP0jNSuSS81
         wDOmj4pxIN6tYlRAzi/FaabfoDFunVVKscYb5n8c0EFEZZcLmq9zQQ9M8rlkzafAi82M
         1iRebWSFOqQtH2dMYfOHWZ7z5gZbFvefCxV9txdXz4rslX1hnxB/MIenBOyBYOgZLCvu
         aTktHQjUL7j9PJ90feDGnY0TDjniT8Tfy2akKN1Lzea3Od1zUQp1nCnWLlL/+JOmZ0Zh
         OPJCPoArD8Zmr1tSNMRrEM5CjnMJqNHsY0FjozL6aoUa6vKkVWkMT1vT9WiOWTt3loKp
         u/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Qz9La3QPRMndTjsVYo9vnU/gF+lgGUUdSa/ncd8lBk=;
        b=SrIwVFe3erUFhGdH0pqZT2Flv3/uNDX+pTqmTN+TpzybvtjuR/dOv3HUDlZg2YYeAi
         l8bHos0O+wVjhvIFWHq6vi6KL5JmLRNrhkrekI9KvCS1o3dEtbRUPkNqfKhz46JfTguV
         p199Sl7cIbQVk81ApRpVzF2uyndf6En7DmeQmdoViHhpE8oDl4zEYoo9cLPpZ+mHyGWG
         gu2XL6DhsmbfyCwcHYraj3ILuk11s43YQ6tsWnzEuJUmvgbk+eaanX5BDWEytbAjQiiF
         gP35cep8N1beXpVUHDjDtLEMqDtb/8K/1LO4Jv3D4JbORHN0EYiBMPFEiu1HnXOPFXT1
         xYhA==
X-Gm-Message-State: AOAM5305/VE7f3+mNStyKiwh3Ske6We73plgqRi4DHfJto0Hdw87SDCV
        TuBx1L0BaZE9Jil3PCmbWZk79QIl0eKXtXR1DJGhxw==
X-Google-Smtp-Source: ABdhPJxDNB+xboKdpjjX2tqT4JaA88pbPliST3MyNExL63yz6P083Fk3EPy5DbC/pEXFSKrJgyvieiwFRMc5o98+tjs=
X-Received: by 2002:a25:380c:: with SMTP id f12mr7088014yba.208.1627565403514;
 Thu, 29 Jul 2021 06:30:03 -0700 (PDT)
MIME-Version: 1.0
References: <20210728170502.351010-1-johan.almbladh@anyfinetworks.com>
 <20210728170502.351010-12-johan.almbladh@anyfinetworks.com> <deee75a2-a4ce-303c-981a-cd5b6e8cecdf@fb.com>
In-Reply-To: <deee75a2-a4ce-303c-981a-cd5b6e8cecdf@fb.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Thu, 29 Jul 2021 15:29:52 +0200
Message-ID: <CAM1=_QSDhFQ6EBOi5F3cM9xEoxNFpX_4uCM71cUiOaurRpH0iw@mail.gmail.com>
Subject: Re: [PATCH 11/14] bpf/tests: Add test for 32-bit context pointer
 argument passing
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Tony Ambardar <Tony.Ambardar@gmail.com>,
        Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 29, 2021 at 2:09 AM Yonghong Song <yhs@fb.com> wrote:
> On 7/28/21 10:04 AM, Johan Almbladh wrote:
> > On a 32-bit architecture, the context pointer should occupy the low
> > half of R0, and the other half should be zero.
>
> I think this is probably true. The word choice "should" indicates
> this doesn't need to be the case if people choose a different
> implementation, right?
>

Right. To the best of my knowledge this is true. I can change the
wording to "will" to remove the ambiguity.
