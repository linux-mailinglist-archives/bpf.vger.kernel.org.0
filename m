Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B1A0283D65
	for <lists+bpf@lfdr.de>; Mon,  5 Oct 2020 19:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbgJERgx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 5 Oct 2020 13:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgJERgx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 5 Oct 2020 13:36:53 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 315ECC0613A7
        for <bpf@vger.kernel.org>; Mon,  5 Oct 2020 10:36:53 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y13so10061361iow.4
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2020 10:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QEhNeqE2jCOAsEwTKodA8eAmV7E43ESviSFVdgKMdRc=;
        b=Is65unyTHAXLv09OSYHbRePdwCc7l4IKtGsbz7zS+nJ6WMABIBdpkSUAJCqYHagwbE
         4013Ssr5YLWGWuYxypDUfHTzN3ZS4hlv7qDazy1TJz5H9f7Ua5vhBThiw0S9XuflQi7k
         8MSuperBTfCOOPGBHF9Ct3R24b43x2Txczj0Q2yyaPy8SGhV14MWq3wX6SteTEDBLcrt
         tZZqyMZ2yWZikobInvV2r5rRf+nZc89yM4ZUTJpHx5xtqZkV5pDfymFJzu3ua9E/YPIv
         EX84pe13sKLRhdY5Xy6A/V7sydIOkcjtLAzALYPltaayplG1bYXnijWss2qg1YFdSsv9
         DIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QEhNeqE2jCOAsEwTKodA8eAmV7E43ESviSFVdgKMdRc=;
        b=qKPlHEXSnnXe9QeqjbodhSAwf+NYVCSqgE5RxZSEZvdAWKTvpFNLiuDpe82jl6IW3w
         jvi2WFhIcCI+DSnWb9N6l8ok0Hx8/mkhS02pPVLBKn3nb5sdZtREnFJZjb/pPPSQpsTn
         HS8MUaYQ0HLjjKf6Cfkg4iWTYbJkOGPlWpOHAE3YJwsbrwWsT1786TUlNtRBM5WjuPy6
         cJrlgSMMNm33mDkKjRiNr+UaNJsmbSOS9Df2D2YGe31Cgz9zfTEYhGhqkFZ355ru90j7
         A6ndu6CsI++lV0YqP0OIlP7trfmCHe7MBwGv+tEjaa5WvbQ9OhMizSPCGbTbkhtbu3eO
         DcZQ==
X-Gm-Message-State: AOAM533UfDSXx39NGBfv2duxohb/ydUqk0IPSBwfJ5WXVqeWbLvYfrG6
        2oIjJM7v1hCvr4Xu6C/uEsrX0p7F0+ORyzPBXr+Y4Ezsie+j7A==
X-Google-Smtp-Source: ABdhPJxzXMjpLbbnB7WQJR0r3ek4593dRvwyFwWug+fohLYkK/UU4nFJuZKV3x/oUp2zFTjGCs+e5Kak5DQcuZM8NlE=
X-Received: by 2002:a6b:b2cb:: with SMTP id b194mr800311iof.132.1601919412350;
 Mon, 05 Oct 2020 10:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20201001020504.18151-1-bimmy.pujari@intel.com>
 <20201001020504.18151-2-bimmy.pujari@intel.com> <20201001053501.mp6uqtan2bkhdgck@ast-mbp.dhcp.thefacebook.com>
 <BY5PR11MB4354F2C9189C169C0CE40A9B86300@BY5PR11MB4354.namprd11.prod.outlook.com>
 <CAADnVQJmmY_HER23=3bxCrrsbJoNs1Ue__P24KHj3YY1EkzuKQ@mail.gmail.com>
In-Reply-To: <CAADnVQJmmY_HER23=3bxCrrsbJoNs1Ue__P24KHj3YY1EkzuKQ@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Mon, 5 Oct 2020 10:36:40 -0700
Message-ID: <CANP3RGfyG9_vj5FkgJz2HV+8voLqP3N+6Qi5hpkqJntF0YSy-A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v7 2/2] selftests/bpf: Selftest for real time helper
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     "Pujari, Bimmy" <bimmy.pujari@intel.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "kafai@fb.com" <kafai@fb.com>,
        "Nikravesh, Ashkan" <ashkan.nikravesh@intel.com>,
        "Alvarez, Daniel A" <daniel.a.alvarez@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Don't bother. This helper is no go.

I disagree on the 'no go' -- I do think we should have this helper.

The problem is it should only be used in some limited circumstances -
for example when processing packets coming in off the wire with real
times in them...  For example for something like measuring delay of
ntp frames.  This is of course testable but annoying (create a fake
ntp frame with gettimeofday injected timestamp in it, run it through
bpf, see what processing delay it reports).

Lets not make bpf even harder to use then it already is...
