Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 878466CBC65
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 12:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjC1KSn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 06:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjC1KSm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 06:18:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBCE10D2
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 03:18:40 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id ew6so47361412edb.7
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1679998719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vvzr4baxa/x4j/Rm5Ei8bsFwFUzNXSwUCnoszmxMI9k=;
        b=Rq1Hw1Ehk1O95uaNy++X6HO/rBi6Zafxu3iitPBKBzR834+M3wpZjGyR3lLpUmZfRt
         qIuBcga9mebLocWaRkFu8JE9g18UokzmcArwKtOfVT1XnZqL0xFf++23+gWxvhUrClTS
         vCjGAFXHAcPpPNo6kGVolwB1yYriMu67CBL8Lw6e42zZVaQ5Jz43GlRTavwzdYYuthNS
         idJx8oJawEqD8TS3QUjejMV4K9yf1lRaCQpmibLEvop+YzOQgbF2o6iDDDqKWsIpFzq2
         /JFu+14sv+GAHQ/YMHsWzXSibztpR9estlfblfodn5ZcJmAfOgddhyMHvBWxw9LSV0UH
         LmZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vvzr4baxa/x4j/Rm5Ei8bsFwFUzNXSwUCnoszmxMI9k=;
        b=Ra9xCPvvNp037zNlqMoxenQolafa0n2W02i/boEoqnm2MJaODN8Hh04L2Lzb7M8WgL
         F5PwV4haEccjxCjpZTg030HbmLYwht3QVspQmjQJxBu1ISHfgCfcDXf2ji94XwROnqqv
         QK6mHgsnbKicg0AlLB7GImPbwTpNhW46OTZl+D18XgVt22qun/AoEJ6dw5zrFMxImqXu
         DTeuzZMndR8X9yItGu9DbsKgNe3KTCmC14AzPlVR3XJu2GURepzdKfk5CkP9c1M0i+Ia
         Wswf995mwNMslpzxpW21mMAOk72Ea8v3XYdIRemivnKSSiDk7Shck1lFcm7b9IPw5WGk
         Oldw==
X-Gm-Message-State: AAQBX9fPYvYFt8jBuCfwaqo1l2NTDCO9izxOdVjYJJmBPTUOsMwHdU8M
        Tt+87I3TGYMXEAaRB04h8pCvQkjLBxiDINArU0yHbw==
X-Google-Smtp-Source: AKy350bAjIfo1VzLBA/Mcp50eIeAbVuTMaMRgrXY3RuRJhFAjT6lyIbTBOTL+fcMK3N51HPw2QDYWKyPgxTouva1LS4=
X-Received: by 2002:a17:906:b884:b0:932:a33a:3754 with SMTP id
 hb4-20020a170906b88400b00932a33a3754mr7455435ejb.14.1679998718779; Tue, 28
 Mar 2023 03:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230320005258.1428043-1-sashal@kernel.org> <20230320005258.1428043-8-sashal@kernel.org>
 <CAN+4W8g6AcQQWe7rrBVOFYoqeQA-1VbUP_W7DPS3q0k-czOLfg@mail.gmail.com> <ZBiAPngOtzSwDhFz@kroah.com>
In-Reply-To: <ZBiAPngOtzSwDhFz@kroah.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Tue, 28 Mar 2023 11:18:27 +0100
Message-ID: <CAN+4W8jAyJTdFL=tgp3wCpYAjGOs5ggo6vyOg8PbaW+tJP8TKA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.2 08/30] selftests/bpf: check that modifier
 resolves after pointer
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Martin KaFai Lau <martin.lau@kernel.org>,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        shuah@kernel.org, yhs@fb.com, eddyz87@gmail.com, sdf@google.com,
        error27@gmail.com, iii@linux.ibm.com, memxor@gmail.com,
        bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Mar 20, 2023 at 3:48=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> Why would it break?  Is that because the test is buggy, or the kernel is
> buggy?

This test will be fine, but there have been several times when
selftests/bpf for stable kernel releases didn't actually compile due
to backported tests. This is because macros we're redefined, etc.
Unless those also get picked (seems like a sisyphean task) we'll keep
seeing broken selftests/bpf on stable.

Best
Lorenz
