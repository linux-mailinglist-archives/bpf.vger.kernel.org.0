Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACE66C9A0F
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 05:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232278AbjC0DSX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 23:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0DRp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 23:17:45 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B25FC6
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 20:16:36 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id cn12so30145891edb.4
        for <bpf@vger.kernel.org>; Sun, 26 Mar 2023 20:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679886967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rvYj/tobpmlr6SKnLLs9Yp/LRy5wPKC/VJOtKGj8GrE=;
        b=j+Wb3aCPe7QThVc8nl2mN+9p5l6Sq6ivi4yKycSo9b7uQvqpEKd3MPl7a+ZknOFP+T
         FGgxPXrp5oA3lhcx4rBTV/kYyZOKcxgezbU3D60kJghJiFZvpq4MbAAayKsXVIbTjBz0
         YwFUnSE9bvCU7Q0UQG1BI2HOGeILW2+VxRssrkU3WmFPAoSCT1DZ9xsIsYLMkNm+Lt0S
         JqmkX0Kd+2Gn9+Mdp3W4QOE+YWsVB7MNr3okMSQ+cZpKq2MNV635MouLtuBaK42Jp/QN
         bfZ5n7o80rdG/DqHcfztALZcodfX4s9AWD9pAmWVeYTyHkvlr93mD9bhhVbRA3h4s2bw
         d1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679886967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvYj/tobpmlr6SKnLLs9Yp/LRy5wPKC/VJOtKGj8GrE=;
        b=4myc8h9xTbtVCHlDyS+XM4pLuIASWbUgm1efastwFjZF5Wtx/lT4xIBJA3hE9cI51h
         1e4oDTf2Uc+csGefIIPeCavogVYpmlctt7OTicwyWcWkUtKpvyw/YoD2CXgebYXdyL3+
         WadXP+8A4fJGnwZn2AXt2LRMcx4hgSfT5HdAiJpmzAGd3b5j3eBKdB1PDbxjTV9EadGQ
         e4tkcMMT/3p5c2SzT2Xn/UTCLCYlt6vZKDS+fjK1WvM+HoEJ4ufJJbK+jMXPkPq4GWq6
         VaZVL5Sc8ugeBfC4ktJG5vBmVZJ0iyZwtrI2KeObPCKqUOl0Vgcoo7oKsU3mJcrUGtY7
         CTPw==
X-Gm-Message-State: AAQBX9dMXDR50+Mzithg1G7hp43elh01CFKSQA52EzJZVhV4daisz7ad
        8Qsq/yzjvvIn4g6QopdHvXJzccHTSAZFC1X7IjI=
X-Google-Smtp-Source: AKy350bAwtoBZwnrqyrQ8OVNVuirrs3zzUTA3yxzGYmB9nZcmsgAVK2oXQ8K04cMQAtAfg2AOl8igJrt8KV2G6/0tJQ=
X-Received: by 2002:a50:a444:0:b0:4fc:6494:81c3 with SMTP id
 v4-20020a50a444000000b004fc649481c3mr4757714edb.1.1679886966958; Sun, 26 Mar
 2023 20:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230325025524.144043-1-eddyz87@gmail.com> <ZB5pFYZGnwNORSN9@google.com>
 <2ac4f6037719e25e3e8b726def6ece2907d785f0.camel@gmail.com>
 <CAKH8qBv9vYZsMFivzJ9s=i_w-RakGqECfwXBZfWnDigi6oP1EQ@mail.gmail.com> <CAADnVQL5O4FaDDOUn0q1urfhquek4dE9nrhWa7mVYwvMhi311A@mail.gmail.com>
In-Reply-To: <CAADnVQL5O4FaDDOUn0q1urfhquek4dE9nrhWa7mVYwvMhi311A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 26 Mar 2023 20:15:55 -0700
Message-ID: <CAEf4BzbbgLg3w5ySX8XxBHBR0gzr71XPvJ5s1Tw=A6ScA6Vmwg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/43] First set of verifier/*.c migrated to
 inline assembly
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Kernel Team <kernel-team@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 25, 2023 at 6:19=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Mar 25, 2023 at 9:16=E2=80=AFAM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > >
> > > It was my understanding from the RFC feedback that this "lighter" way
> > > is preferable and we already have some tests written like that.
> > > Don't have a strong opinion on this topic.
> >
> > Ack, I'm obviously losing a bunch of context here :-(
> > I like coalescing better, but if the original suggestion was to use
> > this lighter way, I'll keep that in mind while reviewing.
>
> I still prefer the clean look of the tests, so I've applied this set.
>
> But I'm not going to insist that this is the only style developers
> should use moving forward.
> Whoever prefers "" style can use it in the future tests.

Great, because I found out in practice that inability to add comments
to the manually written asm code is a pretty big limitation. I do like
the lightweight feel of this unquoted style as well, but practically
we'll probably have to live with both styles.

> I find them harder to read, but oh well.
>
> Ed,
> the only small nit I've noticed is that the tests are compiled
> for both test_progs and test_progs-no_alu32 though they're in asm.
> So we're wasting a bit of CI time running them in both flavors.
> Not a big deal and maybe not worth fixing, since they're pretty fast.
