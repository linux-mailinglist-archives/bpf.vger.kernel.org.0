Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5951362A290
	for <lists+bpf@lfdr.de>; Tue, 15 Nov 2022 21:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbiKOUPR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Nov 2022 15:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiKOUPQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Nov 2022 15:15:16 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569FC27DCC
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:15:15 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id d8so7081655qki.13
        for <bpf@vger.kernel.org>; Tue, 15 Nov 2022 12:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=924S7oFFn3kFSc4L3eSxru/sTZWNMDXi1cyKCrFfwrg=;
        b=X2QYrkVElz4L6Q2zcRlVm/fz3qaD3XDSUx0xm/EDgoVlJiPSDngEwpXsYu3QI3QNWa
         9Hag8NqnNkmPceEbcKKe29c9m3KEsujKb9JDuXvYlsPZt6KgsjqzmB5RfGAAaQQZPYeN
         82+bQ6rplSbJCyUegrKTgJ4NSeroZVtqWF8MtY5TJIgO7D2IQo4OoLaLFxS+2pXhUqGZ
         94o59G4FGZfnvD1jnrqD/QBF7A0NT0gW+JHT9+ySTSjJ8BmXpy25sRs8QJF27OslveKU
         ABsPhZZY/unXblQ0g+7A+ldeZwxiJ6gX4DdFrCfts+nvKWBoprqDUUB/g06mSJq5Gzpg
         95eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=924S7oFFn3kFSc4L3eSxru/sTZWNMDXi1cyKCrFfwrg=;
        b=AW60YXwvaOeZXCmOc8sTvK3VioaP3dLSD1n7zTDa/kEUvq07zesSygnXZVPk5Ouzju
         Zq7qUzehC3SGAq0corXk0A9SZY8t+iOUEiaXUAOCwfPPndNdkbhzssOPp5p6T9AriwE9
         iAj5AMwMKG3GW8FA4KHhTq9j0LHYXyD8NSJxQ9U+t6n+z8PIezwxdstdQ7HJikWw0Yoi
         V1KFG8E1b3JB+cMYVREVD9lW+YBb2tcUKS1TbSzQqTv/5DuG8Tx15naA3N6wDjnm75fi
         YU/cuwGENCWXxrZoIJwQ8KmkuyPAJ0/44zGNn3PxLge2c02gL4cijN0B71Sf+geXftAY
         OH3Q==
X-Gm-Message-State: ANoB5pnxyp4TLcpPdLrhC68/pVv/U1Vs5x+RpujUh7nvg2FXX9XLPz5j
        mXrxy6v62hk1HU4dNhk6sLiniVpDrre/Z+/Tw4bNnw==
X-Google-Smtp-Source: AA0mqf6EcSoBmq58hGNtKOec/E0Jyi6ERfUcqcqMd+j+1E5w6ierG9uQk9QHnTbE5wulqeMv9LmXd9y05PL1Xhb28fQ=
X-Received: by 2002:a05:620a:4895:b0:6ce:2d77:92d0 with SMTP id
 ea21-20020a05620a489500b006ce2d7792d0mr16745627qkb.713.1668543314445; Tue, 15
 Nov 2022 12:15:14 -0800 (PST)
MIME-Version: 1.0
References: <20221114211501.2068684-1-deso@posteo.net>
In-Reply-To: <20221114211501.2068684-1-deso@posteo.net>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Tue, 15 Nov 2022 20:15:03 +0000
Message-ID: <CACdoK4JgyRYwSAANGAm0_15OkvNiPU=MDo3tZCMokMOF8h5vzA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] docs/bpf: Document how to run CI without patch submission
To:     =?UTF-8?Q?Daniel_M=C3=BCller?= <deso@posteo.net>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kafai@fb.com, kernel-team@fb.com,
        eddyz87@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 14 Nov 2022 at 21:15, Daniel M=C3=BCller <deso@posteo.net> wrote:
>
> This change documents the process for running the BPF CI before
> submitting a patch to the upstream mailing list, similar to what happens
> if a patch is send to bpf@vger.kernel.org: it builds kernel and
> selftests and runs the latter on different architecture (but it notably
> does not cover stylistic checks such as cover letter verification).
> Running BPF CI this way can help achieve better test coverage ahead of
> patch submission than merely running locally (say, using
> tools/testing/selftests/bpf/vmtest.sh), as additional architectures may
> be covered as well.
>
> Signed-off-by: Daniel M=C3=BCller <deso@posteo.net>

Thanks a lot for this!
Quentin
