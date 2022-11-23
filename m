Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8259A6368D3
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 19:30:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238956AbiKWS3v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Nov 2022 13:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239221AbiKWS3g (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Nov 2022 13:29:36 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355E6F037
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 10:29:35 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id c129so19977450oia.0
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 10:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nY/GetO0ojf+iZPKg3hv2WXNz71nE7mSwhFRQYOk8rA=;
        b=sz5g01+ON0AtuUZHovF5qCplXGYARKpRflG0mxepxPrTm9wyXboj9DugJNEmbM36o+
         XusU8Loltia9OHBlro3fHJ77xxqJ8Q8vs2y7tpm9PJpCLn/KY4sPPzk2lnUR7qHFt7Uh
         e/q46mZLpm59EKXriFJZ4n33IsZBwRZLZhB3mJ1cIUpk8NxF86VOWPLRmOMlcU8Hm7Ot
         YAvNHDeAFtKoazlpfE49KlyYeZSjy1qqKzl014GojzamO7RL/LINqRg/TMlCCmumzZLe
         WaT4bfHjApuvrYEHV1f5XN95MMTJvB+q7ZUeZ6VC0FRkYNf6Nr2yPABTzlq99ShcrIbX
         n9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nY/GetO0ojf+iZPKg3hv2WXNz71nE7mSwhFRQYOk8rA=;
        b=yfIKQUA7rex4HXQyMFv4GuiUZtJ5JztRpyEEBJbZvxekGxpivyh3gCpXoGbMax7CEF
         wIAKZYyO2SPc2ERLR+wVHaz/kyC43kT829ceepz6Zs2OhQrjgTTtb2Ej1Xkq11ABl4fR
         uPmMjUvcQjERltZ9U8o8TqhMYpZ6Wl4QgaEPANwBaQwfHDla25k9kvK4YDtFLpdTHX1e
         dRtMzcw8Wu3SQhl5H6wmowdruH2uY+rH82SFBE3e4eLz7hbmrT5wyD1KC9uA2d8XvFRE
         02H1eQVreNCcV2zL6qca7EDDb1FZkhUfygOxNWRz96A2HySlwoM+9qoCV1qoUpA4WCLT
         gjtg==
X-Gm-Message-State: ANoB5pkb8M90KNmaU3JsS2PXOl5Vy+aieii5g5+yIBs+QZVZC9LEhn++
        Gz1XZUX6wBmjhEJ/q7RAKE26h3l6UJ4wWCf7+8K2Bg==
X-Google-Smtp-Source: AA0mqf5Z7f+oqbSMm+nMByO3KvXwrijzWqgC0HeUlc2lWzDx4dH99Nc2INA5soSPtL9HnO9B7JPwvxxzRMShLuIJ4H0=
X-Received: by 2002:a05:6808:f09:b0:354:8922:4a1a with SMTP id
 m9-20020a0568080f0900b0035489224a1amr4511945oiw.181.1669228174410; Wed, 23
 Nov 2022 10:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20221121182552.2152891-1-sdf@google.com> <20221121182552.2152891-9-sdf@google.com>
 <877czlvj9x.fsf@toke.dk>
In-Reply-To: <877czlvj9x.fsf@toke.dk>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Wed, 23 Nov 2022 10:29:23 -0800
Message-ID: <CAKH8qBsSFg+3ULN-+aqabXZJRVwPtq9P71d0VZCuT2tMrx4DHw@mail.gmail.com>
Subject: Re: [xdp-hints] [PATCH bpf-next v2 8/8] selftests/bpf: Simple program
 to dump XDP RX metadata
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 23, 2022 at 6:26 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@redh=
at.com> wrote:
>
> Stanislav Fomichev <sdf@google.com> writes:
>
> > +static int rxq_num(const char *ifname)
> > +{
> > +     struct ethtool_channels ch =3D {
> > +             .cmd =3D ETHTOOL_GCHANNELS,
> > +     };
> > +
> > +     struct ifreq ifr =3D {
> > +             .ifr_data =3D (void *)&ch,
> > +     };
> > +     strcpy(ifr.ifr_name, ifname);
> > +     int fd, ret;
> > +
> > +     fd =3D socket(AF_UNIX, SOCK_DGRAM, 0);
> > +     if (fd < 0)
> > +             error(-1, errno, "socket");
> > +
> > +     ret =3D ioctl(fd, SIOCETHTOOL, &ifr);
> > +     if (ret < 0)
> > +             error(-1, errno, "socket");
> > +
> > +     close(fd);
> > +
> > +     return ch.rx_count;
> > +}
>
> mlx5 uses 'combined' channels, so this returns 0. Changing it to just:
>
> return ch.rx_count ?: ch.combined_count;
>
> works though :)

Perfect, will do the same :-) Thank you for running and testing!

> -Toke
>
