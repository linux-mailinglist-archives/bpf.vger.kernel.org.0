Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E042CCEDC
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 06:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgLCF5R (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 00:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgLCF5R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Dec 2020 00:57:17 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551C1C061A4D
        for <bpf@vger.kernel.org>; Wed,  2 Dec 2020 21:56:37 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id x2so957089ybt.11
        for <bpf@vger.kernel.org>; Wed, 02 Dec 2020 21:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VMPTTD0B++eEBizXiXdWHEU+HRzzp5m0KtTXKLyz1I0=;
        b=QR5REfYt74Otd289Teob80yzbwRNhoau4fyzhWxsTOIEDmnj51WrI9UUFIz/yfoeDn
         HNvQ4lR03D0yNxisSCZRg6gltyZqRKDHSyKn1rBm1YFtqx7MjTjhA2Ea6M9i8LWw8dGk
         6tNtFuqdZYMns8AjRprhxNeAYWCRwDAA5zyw61bMesiT+gxZ7Y+G6nRLwumh6DnAE1DQ
         w72d24Ll8rMoUXMZ5Wj7yp+ZPcrXLohgXGuWAnwD7ANwoPdWngRyPlzwz/9Np2r+xH76
         f7XmbZtlPNAW5OKHaijtWsK2Khpf27FBju7NmZiLpi5ZtHn2c/Jk4ZKuwdl4y7iSCMt3
         CuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VMPTTD0B++eEBizXiXdWHEU+HRzzp5m0KtTXKLyz1I0=;
        b=eUAtmfIEmh4PdmcP4aQ/tPzr+AtGMdFn4G0gWOz2UWyNEKFq4A8mBlr/wR4EdTuGTI
         xJptbpwa3fvpGGQUwkhdYz/CBBZugLfmPrJXXButtM2yzQYHHk3qmPR9DDHk+amhF+z3
         QaQ+tCudYg7GkJOY9M4/iZS2Do0CiCLe6d52afkl5l596JN7h60s2GOA2isWGgB7zgDV
         ldOmAIIgKECQYnotCGYajO6jcE0Mx4ZA5My52TWz57v6Lf+f7Xy4Z65FUSyH7/KRo+UO
         Caeeh190JxI4WZ3ANZ3Fgk5Mt995yiLCmf3i7RJn17eJZny4dBmu7WsqffPbJwhbuIqp
         CNvg==
X-Gm-Message-State: AOAM531aPc7RkRU/eKetceO2S1aAFPlDYEVplWTQRaF6yI1ApvfBrBG3
        qAxj5Xfm8Qq7t0Hy7YOTHK7is0si/hNPMCL2Mec=
X-Google-Smtp-Source: ABdhPJweEgOpK2cII3qDn6bcKT6+SDc9ScqPlX6Qvp4mPUfWsZwwnrz/KA7XZQDjlCYJtV6iUKa5hyPUQFDkhrYcpM8=
X-Received: by 2002:a25:3d7:: with SMTP id 206mr2255662ybd.27.1606974996587;
 Wed, 02 Dec 2020 21:56:36 -0800 (PST)
MIME-Version: 1.0
References: <20201203005807.486320-1-kpsingh@chromium.org> <20201203005807.486320-4-kpsingh@chromium.org>
In-Reply-To: <20201203005807.486320-4-kpsingh@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 2 Dec 2020 21:56:25 -0800
Message-ID: <CAEf4BzbXA-az9cAKwy=bpqFOkX+6mtirm0TRxkyTmZdm+bXxoQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Add config dependency on BLK_DEV_LOOP
To:     KP Singh <kpsingh@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Dec 2, 2020 at 4:58 PM KP Singh <kpsingh@chromium.org> wrote:
>
> From: KP Singh <kpsingh@google.com>
>
> The ima selftest restricts its scope to a test filesystem image
> mounted on a loop device and prevents permanent ima policy changes for
> the whole system.
>
> Fixes: 34b82d3ac105 ("bpf: Add a selftest for bpf_ima_inode_hash")
> Reported-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: KP Singh <kpsingh@google.com>
> ---
>  tools/testing/selftests/bpf/config | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 365bf9771b07..37e1f303fc11 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -43,3 +43,4 @@ CONFIG_IMA=y
>  CONFIG_SECURITYFS=y
>  CONFIG_IMA_WRITE_POLICY=y
>  CONFIG_IMA_READ_POLICY=y
> +CONFIG_BLK_DEV_LOOP=y
> --


You mentioned also that CONFIG_LSM="selinux,bpf,integrity" is needed,
no? Let's add that as well?

> 2.29.2.576.ga3fc446d84-goog
>
