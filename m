Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A70F2496B9E
	for <lists+bpf@lfdr.de>; Sat, 22 Jan 2022 11:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbiAVKIw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 22 Jan 2022 05:08:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231424AbiAVKIw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 22 Jan 2022 05:08:52 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7135C06173B
        for <bpf@vger.kernel.org>; Sat, 22 Jan 2022 02:08:51 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id m90so21444065uam.2
        for <bpf@vger.kernel.org>; Sat, 22 Jan 2022 02:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MSwbp3+VbZDCCUjeP6ihrE9kPizvSq0TjM74LzOWLoo=;
        b=HLLC6Pa00WkQGNqI4nhGgelZY/r4frjmQPx5+UNR3j9W87+WOxiQbU7Fq25AwX1eG5
         asIKFvO9d1MmhvKBRmhromWtYrXUQ51gD8P+NZIE+VOzA/VWOZvJi1h3md2PBSI+aXUN
         Q/Q6YvyX5HbPpmCgy/f6VmpRXRcA3I8t0tjKwrKTOuDYGmpvCzLl7cBOJSh1+CuhjH9Y
         cT/fo4MMegDY5P6CUBcuqs7wz10vWfcYIqqHYd8sPTwwYWdF0aOmY+MebuGsFTXsHLV/
         ZZzs6c3L0lkV20UK/miW02HX1K2dB7oyidJX2QvLoRBsyzS4d7x7DUQc92+vgL6MOOHn
         wVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MSwbp3+VbZDCCUjeP6ihrE9kPizvSq0TjM74LzOWLoo=;
        b=tjvia8aoZQjh6L4TMwIihtNeqip+3swZLcWYOXX3i160pK+ig5zRlyzg1ZnGl13cKy
         omtOCvZ7v8XccMskRZo3ikMIeuisSmvc02QiC+CsKA3CPPuWyVN+cKFbvZdmdMlDCC0K
         vtmvmtGitxXp+Lzfg4jcKu4C612sBSxAzsAms5WHIS5rKdFVgx/LUmL7YhjTzpv34AaJ
         TMFzPs0n8Nn1GWwoRP0ZnNZyxoMCnjjdbGAxnXCVaTGjkCtIv1ZKLyzHVmk+pD9N7sfR
         uSeLbdVX8AcVDf07OIJvuO3RWLq8hc7B3WL1xp9+Dm8rO+08JvlQYv9fnl830kgjH4Nn
         rJLA==
X-Gm-Message-State: AOAM533Rt3+suelkLF/7Ysup7n9XydWHUG+XEYvAWuTK8NHSjkDCpCom
        N/gFzm+5B2doyxh7L6kJH/BdMymieS2SyakDFU0=
X-Google-Smtp-Source: ABdhPJwDKfbVCmjb2UnEkHUAEusjA+VcZ3vQFuNnYVOZrKxj1m+aYXhxz7aV8wvy3PTYlafeVaPortGBiMWwCF2p7Vw=
X-Received: by 2002:a05:6102:6c5:: with SMTP id m5mr3163663vsg.7.1642846130986;
 Sat, 22 Jan 2022 02:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20220113233158.1582743-1-kennyyu@fb.com> <20220121193047.3225019-1-kennyyu@fb.com>
 <20220121193047.3225019-2-kennyyu@fb.com> <CAEf4BzYfQ4EbSa+c1-G0x_Zh4L6=TbutmH3qndTmv7wb2dAf1w@mail.gmail.com>
 <CAGnuNNseH=oLjYSUCfxyyxcGmJ3Na0NnTXCBQP21YqTX1GhYPg@mail.gmail.com>
In-Reply-To: <CAGnuNNseH=oLjYSUCfxyyxcGmJ3Na0NnTXCBQP21YqTX1GhYPg@mail.gmail.com>
From:   Gabriele <phoenix1987@gmail.com>
Date:   Sat, 22 Jan 2022 10:08:40 +0000
Message-ID: <CAGnuNNsJdEcG=FuxxTT01o3oFNFvU_Cxe0r+xmixpBv1+zqy3w@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 1/3] bpf: Add bpf_copy_from_user_task() helper
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Kenny Yu <kennyyu@fb.com>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

s/callee/caller

On Sat, 22 Jan 2022 at 09:58, Gabriele <phoenix1987@gmail.com> wrote:
>
> On Fri, 21 Jan 2022 at 19:53, Andrii Nakryiko <andrii.nakryiko@gmail.com>=
 wrote:
> >
> > "On error dst buffer is zeroed out."? This is an explicit guarantee.
> >
>
> I appreciate that existing helpers already do this and it's good to
> follow suit for consistency, but what is the rationale behind zeroing
> memory on failure? Can't this step be skipped for performance and
> leave it up to the callee to perform if they need it?



--=20
"Egli =C3=A8 scritto in lingua matematica, e i caratteri son triangoli,
cerchi, ed altre figure
geometriche, senza i quali mezzi =C3=A8 impossibile a intenderne umanamente=
 parola;
senza questi =C3=A8 un aggirarsi vanamente per un oscuro laberinto."

-- G. Galilei, Il saggiatore.
