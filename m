Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC49649C6BF
	for <lists+bpf@lfdr.de>; Wed, 26 Jan 2022 10:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiAZJpO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Jan 2022 04:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbiAZJpN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Jan 2022 04:45:13 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66173C061744
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 01:45:13 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t9so8816056lji.12
        for <bpf@vger.kernel.org>; Wed, 26 Jan 2022 01:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bnkwPVjd8gERi15PejeRSl6RpasvAU7m0QgLpZCryOE=;
        b=o2OH/SX+q0f8PhXQtrCtcIu4R/3petNi4CdvQYzPn605fTwCcNeoxPLdZ44byyZrC8
         KuskMFXGnFSMMbEguRaDdN41l8HNpOSXlaAH9xkWTTdsI7MOiN6YngkK6qPPbuSDl4iL
         XmDyL7URVClIZqSyDg8Ae9wg5F2vRbtcKpvnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bnkwPVjd8gERi15PejeRSl6RpasvAU7m0QgLpZCryOE=;
        b=VIDPgGeDA2UYSZ5OgFj3puOsef5y+eY8xiAU2kvLwMiNiP+HRJ5S9zleSjHFX6Uemg
         BX2acQ7zE1ikNsFaHWVyhOnlk3hntH3gK2sTJZp8nkWGtnmg3+yeLnevmHc/+FJDz2NN
         6pWY3FpwBIdA90BuxYGgEEdzQeymWypWcGZcbCk9RoSLerfFqEZWKVofMQSkf80c6WIA
         cuRc42gfRMI8mUjY11y1PGZ5cDAiwzbZpSVrEIpysJPZCbmzymwTziXrIY+Av5iGIe46
         qofbME2hIXdkvKz0CIDupd3luVRSDx7Ud19DRIhx5+z/rMVc5itm24mft5aTTO+efsv8
         2rig==
X-Gm-Message-State: AOAM533BSJfsr1GapHaDrpcPTqRrxT3vNVL4yq9I2aQ5SlT212tCLhfU
        8y852F3X4cRGCx1W6/SbwF/+p/4nhGEk9a/9vX30tA==
X-Google-Smtp-Source: ABdhPJw1RxhrH2QiGQh8zOXtB0UG0Owa8Qaj/JCeYoea+5nUdaNK9tV2INvRQ2plcyqlF41LuRieL9I+0nqD3rrHHV8=
X-Received: by 2002:a2e:6e0e:: with SMTP id j14mr5158246ljc.510.1643190311516;
 Wed, 26 Jan 2022 01:45:11 -0800 (PST)
MIME-Version: 1.0
References: <20220124151146.376446-1-maximmi@nvidia.com> <20220124151146.376446-5-maximmi@nvidia.com>
In-Reply-To: <20220124151146.376446-5-maximmi@nvidia.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 26 Jan 2022 09:45:00 +0000
Message-ID: <CACAyw9_5-T5Y9AQpAmCe=aj9A0Q=SMyx1cMz6TRQvnW=NU9ygA@mail.gmail.com>
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

On Mon, 24 Jan 2022 at 15:13, Maxim Mikityanskiy <maximmi@nvidia.com> wrote:
>
> bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie expect the full length
> of the TCP header (with all extensions). Fix the documentation that says
> it should be sizeof(struct tcphdr).

I don't understand this change, sorry. Are you referring to the fact
that the check is len < sizeof(*th) instead of len != sizeof(*th)?

Your commit message makes me think that the helpers will access data
in the extension headers, which isn't true as far as I can tell. That
would be a problem in fact, since it could be used to read memory that
the verifier hasn't deemed safe.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
