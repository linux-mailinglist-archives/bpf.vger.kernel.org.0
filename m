Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 614823B779B
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 20:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234850AbhF2SJE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 14:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbhF2SI7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 14:08:59 -0400
Received: from mail-pg1-x564.google.com (mail-pg1-x564.google.com [IPv6:2607:f8b0:4864:20::564])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC11DC061787
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:06:31 -0700 (PDT)
Received: by mail-pg1-x564.google.com with SMTP id h4so19252981pgp.5
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:06:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=SjMnFBATeZzhfctKlqr5suc49PJwFcteXOCUCbHM7JQ=;
        b=BXOiskfYCg/hhexn+5Rpp7NSbahAkzpLy2Iv+roS9vc6hpfwcHkXQ/a1UqdeyOXEX1
         2Ix3iSZ5FB9BCcb4aAKOUW8WEvGcY73q4lcPOv/VeV6pwZOhf8TnNIEwnKHGYiaj/RcH
         WfrbbVAekeFL1PfiAm+e4z86r02rfbY1ecMf/938N5eFPgjOcrkatxDy9hXWTufGoT6Z
         E/A+nAbZNCRJriXYzP7prU15Hc+auW7qHzqp5ZOQQSiEKeS3CSuGdmyke93moxwB0kv+
         YPdWXwzvib2pXtOUfeSK/UKzVg5cktFkMnI/4ggJ0H1Nrtt0I/dD+F3ttNPwWLM4EUMt
         8RkA==
X-Gm-Message-State: AOAM5325m5OeYHe6i5sDb1wMzkhLrYtu4YehLUBVXPUEJGv2bnC6L5KQ
        PuWv5vAj7Yu1eDY8Bd7nEbtDQ60lTvZBGEpXEB9Z8U6VICvLTg==
X-Google-Smtp-Source: ABdhPJx9dM1c7iHQDaJeKnaWJEWJItBhfrs1NCn1cSy+KTC3049qlhzOhL9eu9eNJQ/6KGmsJg4ZHS768ShV
X-Received: by 2002:a05:6a00:1648:b029:30c:a6a2:99a with SMTP id m8-20020a056a001648b029030ca6a2099amr11124141pfc.25.1624989991420;
        Tue, 29 Jun 2021 11:06:31 -0700 (PDT)
Received: from restore.menlosecurity.com ([34.202.62.190])
        by smtp-relay.gmail.com with ESMTPS id mu11sm6655500pjb.4.2021.06.29.11.06.30
        for <bpf@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jun 2021 11:06:31 -0700 (PDT)
X-Relaying-Domain: menlosecurity.com
Received: from safemail-prod-02790022cr-re.menlosecurity.com (34.202.62.191)
    by restore.menlosecurity.com (34.202.62.190)
    with SMTP id b8dc8b50-d904-11eb-b272-e19649fe87b5;
    Tue, 29 Jun 2021 18:06:31 GMT
Received: from mail-ed1-f70.google.com (209.85.208.70)
    by safemail-prod-02790022cr-re.menlosecurity.com (34.202.62.191)
    with SMTP id b8dc8b50-d904-11eb-b272-e19649fe87b5;
    Tue, 29 Jun 2021 18:06:31 GMT
Received: by mail-ed1-f70.google.com with SMTP id dy23-20020a05640231f7b0290394996f1452so11983359edb.18
        for <bpf@vger.kernel.org>; Tue, 29 Jun 2021 11:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=menlosecurity.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SjMnFBATeZzhfctKlqr5suc49PJwFcteXOCUCbHM7JQ=;
        b=EKy34M7HY3iu8pslU+mvjF4LbykWqynC0XVzFW7Qvu4RKUF51bp5OSO5J6/fCHG6Kj
         aegSb3FJphfYWz5Xt5FLGNLSlKVvMAmH3RnF4//cW0v6CTN6UOfCLK6AD5E+oPUEu/v0
         0Au5NfcG+dVD2mk/7pLCsxHYoC/f/dqSSKmao=
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr1624164ejc.188.1624989985772;
        Tue, 29 Jun 2021 11:06:25 -0700 (PDT)
X-Received: by 2002:a17:907:1b06:: with SMTP id mp6mr1624144ejc.188.1624989985565;
 Tue, 29 Jun 2021 11:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
 <87wnqc1rvy.fsf@toke.dk>
In-Reply-To: <87wnqc1rvy.fsf@toke.dk>
From:   Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Date:   Tue, 29 Jun 2021 11:06:14 -0700
Message-ID: <CA+FoirCBPGG=dq6AO39djrrjH82-KL9HoMx=92XZXuKOLA1p=A@mail.gmail.com>
Subject: Re: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
To:     =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc:     bpf@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Give credit to David Ahern for this patch. Shall we change anything there?

Sorry for the whitespaces. It seems like I can't properly do this from gmai=
l.
Let me try to redo the whole thing from the command line.

On Tue, Jun 29, 2021 at 10:51 AM Toke H=C3=B8iland-J=C3=B8rgensen <toke@red=
hat.com> wrote:
>
> Rumen Telbizov <rumen.telbizov@menlosecurity.com> writes:
>
> > Add support for policy routing via marks to the bpf_fib_lookup
> > helper. The bpf_fib_lookup struct is constrained to 64B for
> > performance. Since the smac and dmac entries are used only for
> > output, put them in an anonymous struct and then add a union
> > around a second struct that contains the mark to use in the FIB
> > lookup.
> >
> > Signed-off-by: David Ahern <dsahern@kernel.org>
> > Signed-off-by: Rumen Telbizov <telbizov@gmail.com>
> > ---
> > include/uapi/linux/bpf.h | 16 ++++++++++++++--
> > net/core/filter.c | 4 ++--
> > 2 files changed, 16 insertions(+), 4 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index ec6d85a81744..6c78cc9c3c75 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5925,8 +5925,20 @@ struct bpf_fib_lookup {
> > /* output */
> > __be16 h_vlan_proto;
> > __be16 h_vlan_TCI;
> > - __u8 smac[6]; /* ETH_ALEN */
> > - __u8 dmac[6]; /* ETH_ALEN */
> > +
> > + union {
> > + /* input */
> > + struct {
> > + __u32 mark; /* fwmark for policy routing */
> > + /* 2 4-byte holes for input */
> > + };
> > +
> > + /* output: source and dest mac */
> > + struct {
> > + __u8 smac[6]; /* ETH_ALEN */
> > + __u8 dmac[6]; /* ETH_ALEN */
> > + };
> > + };
> > };
>
> Looks like your mailer mangled the indentation of the whole thing.
> Threading is broken too...
>
> -Toke
>
