Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACA24A61D0
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 18:03:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbiBARDH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 12:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241369AbiBARDF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 12:03:05 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE51C06173B
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 09:03:04 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id e9so25077119ljq.1
        for <bpf@vger.kernel.org>; Tue, 01 Feb 2022 09:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ka8pYyC0GHWoeLpCYw/LWy4USejRJXtfOSInUudnWSU=;
        b=rS1qZ0MOxeIwPmmzR+xQL1U2O7aHayJsuJjFuIAJ0B9BZDFJh9uBFRVq3Bjz558NrU
         mCd0QaMCyYLA7HCvj1f2WvxtmX4W1IxjHDbOOmD80ZWCsStxMawsl7ejifNbPOL3f7HD
         D3J5lSRrhUmvmp6Z8NwJCI5H0DV0Dh0HmYfIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ka8pYyC0GHWoeLpCYw/LWy4USejRJXtfOSInUudnWSU=;
        b=y877VnfAr92CpdVjn+BKr7iFiQovz2FBte9EDaPEEFKapJ5fUSV626DqYndP85wScO
         kG2G9WSJi5rzUc+UsQy1TV6PepZbd9unz+P1NA3vqyto6I97s2KKTzwhnXvXPylFmFYD
         uDiWU2vcxJqQnYQhwPqaMeCpeN1pmfKqf9DJqmX8BMf4b5reThotqLjeYB5okZPXNhH1
         Fzl9AJn8QVKo3yDGtEC6SBt+ZzoFDcrcN4eZqxqeSE5lz/RA1DwSuNn5WvOsY6jhx9Ku
         EFO6gWSgE3qo8fQTLxcD22MKjFVfYS4ilEpm1BVhCG78uNVBA2MUvDVjcLTYSX87WB1Y
         2Y6Q==
X-Gm-Message-State: AOAM531Syp16YqrIzoS296k0HI+C2M5RvXzh4RV5l8qxVpsaE3R6XUWI
        zg9CQ4K+t4qS9n9UFUb0ZbT17iuFeXqjeQzq+QxdaT4Sj1lJMg==
X-Google-Smtp-Source: ABdhPJwVfxRmzCAilvAQPZlCwmMAtiCGJT37qvg1iWJ9Elg0tjJBVdNw4pveunQ9Laf20RIRO7WSqHq8U60qJGAsC8s=
X-Received: by 2002:a2e:99cf:: with SMTP id l15mr17334894ljj.298.1643734982959;
 Tue, 01 Feb 2022 09:03:02 -0800 (PST)
MIME-Version: 1.0
References: <20220124151146.376446-1-maximmi@nvidia.com> <20220124151146.376446-5-maximmi@nvidia.com>
 <CACAyw9_5-T5Y9AQpAmCe=aj9A0Q=SMyx1cMz6TRQvnW=NU9ygA@mail.gmail.com> <5090da78-305c-dc42-65a6-ef0b2927db51@nvidia.com>
In-Reply-To: <5090da78-305c-dc42-65a6-ef0b2927db51@nvidia.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Tue, 1 Feb 2022 17:02:51 +0000
Message-ID: <CACAyw99rvHp8FEn9_kjvcVBWB84DSXRSmad+bLDKcBk-E+BaHA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 4/4] bpf: Fix documentation of th_len in bpf_tcp_{gen,check}_syncookie
To:     Maxim Mikityanskiy <maximmi@nvidia.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Petar Penkov <ppenkov@google.com>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 31 Jan 2022 at 13:38, Maxim Mikityanskiy <maximmi@nvidia.com> wrote:
>
> On 2022-01-26 11:45, Lorenz Bauer wrote:
> > On Mon, 24 Jan 2022 at 15:13, Maxim Mikityanskiy <maximmi@nvidia.com> wrote:
> >>
> >> bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie expect the full length
> >> of the TCP header (with all extensions). Fix the documentation that says
> >> it should be sizeof(struct tcphdr).
> >
> > I don't understand this change, sorry. Are you referring to the fact
> > that the check is len < sizeof(*th) instead of len != sizeof(*th)?
> >
> > Your commit message makes me think that the helpers will access data
> > in the extension headers, which isn't true as far as I can tell.
>
> Yes, they will. See bpf_tcp_gen_syncookie -> tcp_v4_get_syncookie ->
> tcp_get_syncookie_mss -> tcp_parse_mss_option, which iterates over the
> TCP options ("extensions" wasn't the best word I used here). Moreover,
> bpf_tcp_gen_syncookie even checks that th_len == th->doff * 4.
>
> Although bpf_tcp_check_syncookie doesn't need the TCP options and
> doesn't enforce them to be passed, it's still allowed.

Sorry, I was only looking at bpf_tcp_check_syncookie indeed.
Unfortunate, it would be better if that function had a th->doff check
as well. :(

Acked-by: Lorenz Bauer <lmb@cloudflare.com>

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
