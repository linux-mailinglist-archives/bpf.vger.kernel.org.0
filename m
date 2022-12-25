Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A4F655D7A
	for <lists+bpf@lfdr.de>; Sun, 25 Dec 2022 16:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiLYPYV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 25 Dec 2022 10:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiLYPYV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 25 Dec 2022 10:24:21 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF752DF2
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 07:24:19 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id c124so9772958ybb.13
        for <bpf@vger.kernel.org>; Sun, 25 Dec 2022 07:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1INdOH259j8gNXiOVyfBkxWz5z02v+TbXTRnfXOmtpc=;
        b=SouorNKLkXk4GYWP+Dt15e/MaXJG5n0jUEn+p0nxTHRy8akRUPTn5wnoegL2Ko4SaQ
         EGZLQPzUhCGwFeF1nQduMaT3WAyu5FX7Z8ML+a+E5nbP29NPqNVhwUKU2dcsa9VjIkqe
         RQFw4mMQfTy7v5Too0Zb+l0qKbXtDfh82rup4QhRCNRf2f1662hTzcGwV6ENOG7Hapn9
         WZTl+tMjHpm4ROycqsHpAlZSKhOwaFn+IEwXLWDc/DPiQd44QmEGyDFeche575m3qpP+
         qOy3aJ+b/NSyr+J4g+neWleL7409nEwK+OrFguuxp0ASm7lw5eR1FQlvHgDNICwGJVJu
         3KMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1INdOH259j8gNXiOVyfBkxWz5z02v+TbXTRnfXOmtpc=;
        b=yTnA3Ea8yGy2cnTXG9qEQvJysZjhKFVf1kzh+OdE8ruzW2XLVSJxWmoCG1FNfVXBN2
         1CtXKJlnpe1tKpf4eQuqZ7h96m2/8CjpFUfTIvevcSP+V3u5qM5ciTr47gbJ+Z16l7IU
         aT9zA3dATX101YsUPU4oi0T59dxbYcv4UTnGmIv5PJG3W+Irttu5D5VhcWJmzpyZEuJI
         cv5Ke2LpQKlkOe1sFTzZxEUypzrNr1JWArOmq3ygH7U+Eog6Xs59pHAGdIhjv44aj9/l
         HHOKNYk++AbNlHUJwil7Hgrox2P8P9yFX9945UFHpPnED2ggRlGIRS++lCPa+zRIM9DX
         +7pg==
X-Gm-Message-State: AFqh2krboeaPvin/FGsnfUvxWStMoGhOo7pAnQUpeNjgOFHUSr/ZdSIL
        WkNZs5JJJn8bqc9KCaQ9k7sb06ufKOYmYoCONLGSo7CL6LW2KA==
X-Google-Smtp-Source: AMrXdXsxXICnSePqxO96nqGh1kv/ah21teN7Icb5XEfrC0fn0weVTzz5mBIwzBkJ+WLthAH0Exvf4yz6NovUjUMZSdc=
X-Received: by 2002:a25:d496:0:b0:70c:4fa3:2cce with SMTP id
 m144-20020a25d496000000b0070c4fa32ccemr2253858ybf.539.1671981859068; Sun, 25
 Dec 2022 07:24:19 -0800 (PST)
MIME-Version: 1.0
References: <CAEc2n-vmWk6+hG-fcqvMdeG-hSyuFoHv9R79U5MjnOU7nXQSpw@mail.gmail.com>
 <871qosy5u8.fsf@oracle.com> <87mt7gwqx6.fsf@oracle.com>
In-Reply-To: <87mt7gwqx6.fsf@oracle.com>
From:   SuHsueyu <anolasc13@gmail.com>
Date:   Sun, 25 Dec 2022 23:24:08 +0800
Message-ID: <CAEc2n-t1W5uit+S9FkttdvbLhZgRdX2-RzUxw71X9FyptsdaSQ@mail.gmail.com>
Subject: Re: Support for gcc
To:     "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc:     bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Thank you very much. It solved my problem; what bpf-gcc build can now
be loaded by libbpf. BTW, when I tried to use bpf-gcc in godbolt.org,
I did not add any additional compile options, and it reported an
error:

/opt/compiler-explorer/bpf/gcc-trunk-20221225/bpf-unknown-none/lib/gcc/bpf-=
unknown-none/13.0.0/../../../../bpf-unknown-none/bin/ld:
-pie not supported
collect2: error: ld returned 1 exit status
Compiler returned: 1

On Thu, Dec 22, 2022 at 2:26 AM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
>
> > So you need a bpf-unknown-none-gcc toolchain.
> > You can either:
> >
> > a) Install a pre-compiled cross available in your distro.
> >    Debian ships gcc-bpf, for example.  See
> >    https://gcc.gnu.org/wiki/BPFBackEnd for a list.
> >
> > or,
> >
> > b) Build crossed versions of binutils and gcc, configuring with
> >    --target=3Dbpf-unknown-none.
> >
> > or,
> >
> > c) Use crosstool-ng to build a GCC BPF cross.  We recently added suppor=
t
> >    for bpf-unknown-none there.
>
> Incidentally, thanks to Marc Poulhi=C3=A8s godbolt.org has now support fo=
r
> nightly builds of GCC BPF.
