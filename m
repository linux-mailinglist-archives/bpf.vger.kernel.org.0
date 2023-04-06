Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB0E6D9D51
	for <lists+bpf@lfdr.de>; Thu,  6 Apr 2023 18:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239408AbjDFQPo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Apr 2023 12:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbjDFQPo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Apr 2023 12:15:44 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FB9171B
        for <bpf@vger.kernel.org>; Thu,  6 Apr 2023 09:15:42 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id 11so2672843ejw.0
        for <bpf@vger.kernel.org>; Thu, 06 Apr 2023 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680797741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEX4enOHEMKg3zc/JyhzRk/4RAn2Ss7HOM8dyZvjf24=;
        b=Z6PiQ95pUiOQNho4n1EgRCWHjbnlko48E6u9hA5l0lSdTac+EM9z1cr1QRD4tIFUUY
         4Q8mhoqaDRJduOoGjuJTxCj076hZFBmEVM2O+JEup0oBEUHCgj0DYnhF4MB2uWHR3ntw
         TmkSFfvAzc6qeh/nrhcxUqmYra0d8XbS0gZ3/rdcHKiFtgdzPVYtwXMohynQ5f1ZpZ57
         2lsAlAeYJixXwV8Qm/CDRcx6c1Y7jyjw1JfAMSVWpBUVoi4EVwXi2yVsydWiHdZSt8PQ
         VX30u8W/PJPVZHJ6M2I/IKEW0fZRw5ZtRYv++9g6oCnhFDvEVIwGAsOg5jweK4CTSKpR
         ahBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680797741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEX4enOHEMKg3zc/JyhzRk/4RAn2Ss7HOM8dyZvjf24=;
        b=UjmUHts1tuCX88hB0QMWYXtGeHQ7NUv/hVNQqfiy+OATVhhqiDg+GiKien6NpwOB5D
         pfzj38dLqsOhNsWj96fPZay6frjPtkvy3kqK1lBa8bLMkc0yExoJD+sOfaBNW/H/af3V
         /2ge/PZvxcKQSnq3Hhle2cwSImMVOm2u2AUpuKlXiSJiro/FCAjkb369ONa022KBtfme
         K3uLiAetNhf91yS8W7O9fhccPe7h5azsZvC5vvfqH7u71cUzYk+lgt0mOyvD4sb0TsgN
         VQm6zv/Eu8t8aUbNDuR5PErR2uFwd67FcUTLP6LMXSQhveE9ziLj+SMb4y9ZTsi5+rlR
         rh/g==
X-Gm-Message-State: AAQBX9djyDo0z+ra+bh+I0HrXCibVIRB02MqjkMnMJw5T4o9UwKCxWLq
        Hue/goX0i46oMThUkbEfStyhSscgc5SMDpOpz4X6sFDd6EOx9uJBlf3rEQ==
X-Google-Smtp-Source: AKy350aayy3IIv5mB9sXh6ZUF+1BNnG0Wai/koqCB8gy0uyrQ+hbjLfWzGc4H3szupVgZ918zijgFf5Q49FEat8CSZQ=
X-Received: by 2002:a17:906:1e04:b0:931:2196:b863 with SMTP id
 g4-20020a1709061e0400b009312196b863mr3457036ejj.14.1680797741443; Thu, 06 Apr
 2023 09:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230404043659.2282536-1-andrii@kernel.org> <20230404043659.2282536-15-andrii@kernel.org>
 <CAN+4W8hdeEVb=Rs-T+E7QtF++fKYObjb--KmCqqOFg8gL+kocQ@mail.gmail.com> <CAEf4Bzbv25n_d3-aCgLMNTu0ZwF2J4srp02QMj0Hs3gh-sGobA@mail.gmail.com>
In-Reply-To: <CAEf4Bzbv25n_d3-aCgLMNTu0ZwF2J4srp02QMj0Hs3gh-sGobA@mail.gmail.com>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 6 Apr 2023 17:15:30 +0100
Message-ID: <CAN+4W8hFPwekddJ3TKxy3usdSXA-utYpFsqUVduR4ny=qQX+yg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 14/19] bpf: relax log_buf NULL conditions when
 log_level>0 is requested
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
        timo@incline.eu, robin.goegge@isovalent.com, kernel-team@meta.com
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

On Wed, Apr 5, 2023 at 6:44=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:>
> We could and I thought about this, but verifier logging is quite an
> expensive operation due to all the extra formatting and reporting, so
> it's not advised to have log_level=3D1 permanently enabled for
> production BPF program loading.

Any idea how expensive this is?

> Note that even if log_buf=3D=3DNULL when log_level>0 we'd be
> doing printf()-ing everything, which is the expensive part. So do you
> really want to add all this extra overhead *constantly* to all
> production BPF programs?

No, I'm just going off of what UAPI I would like to use. Keeping
semantics as they are is fine if it's too slow. We could always use a
small-ish buffer for the first retry and hope things fit.
