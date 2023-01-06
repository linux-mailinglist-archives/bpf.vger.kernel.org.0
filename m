Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF97660648
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 19:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjAFSTi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 13:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbjAFSTe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 13:19:34 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C2A50176
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 10:19:32 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id x10so434320edd.10
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 10:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sIIOjlqeL2P0dvY/uvj5vDsvsmrkj/bi0V/VbjUnZks=;
        b=m21MGPhGUeAExiHodhyZ2c1HqBq+6VNLIfZKdkzp6rODJK7Z9mEe2jSfWS/12gQ4hb
         avwGnyqi+WEiwgK+fuDGxaJ3wuya2axYIUBKtYzKq0JTutMCaEzcooxm0Z4bqlNvHJw3
         idmRCdFm05FFFucWVvY78obaG56fTf3aAnbycuXjRnDyA1xgIraynLhuVtST7lrbo8JS
         Swnbi9eJYcobuE+Yib4g9TkC38SG73F5LwvaVynQ0xjhK1NfYOpiFJ6TwGG8CBnaXdej
         XU+GqMu37x2epHzTP2qSbeZ+Si0ov7COWSZJJavEe6j6LYleSmaNVBuMSu53+73Rktne
         lTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sIIOjlqeL2P0dvY/uvj5vDsvsmrkj/bi0V/VbjUnZks=;
        b=TKXRxtnBltf08sSn/p5t7W1BT0ILJHTcoKnU6ZWUGlB1NsA5sXvasV2/4aoqeOyO5O
         PT7ArqyPCRJ+1SVERHueE6XT4/rYYrsCQoN4YmgW5uy/z9umDJ2SdKmoaGdNZYALZBij
         x61zCrLQpKjFWd13TmXw7VASj572MI5g/41923dFFDs8m3xFQkM6piKv2HagFC5Lsc2C
         iGc8kA6yJW/YGaaR3MLqGAF6cBxyup+Ui3t9NuVJChooRYbnDb30sshrNijLB2btHfcd
         1+Y2YrmPB5Z5K+9eI9DYq5Ec6rzfkg3Jj8R5yR9H8352R3m9fv1wh5Of+Uc28i8zPSSI
         QMZg==
X-Gm-Message-State: AFqh2kquaSpKeSPklVrJ0PMeup9h+UP6v22j1Kbj0NBEvJFqccXm0rN7
        bR1Iq5kd+pVy7+sN33xd3EM=
X-Google-Smtp-Source: AMrXdXuUK1jybtOcDsBu+EOhWseVCiSWgxl9iTVuYgAlbywf/DVv1JlS3wKzx4ky0SNCPTOx5QYGVA==
X-Received: by 2002:a05:6402:d5c:b0:461:68e4:15cc with SMTP id ec28-20020a0564020d5c00b0046168e415ccmr45738411edb.9.1673029171545;
        Fri, 06 Jan 2023 10:19:31 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id p9-20020aa7d309000000b0046776f98d0csm710342edq.79.2023.01.06.10.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 10:19:30 -0800 (PST)
Message-ID: <e30d8e8b50bfdc64e85862d389f888f87bf5e8b4.camel@gmail.com>
Subject: Re: BPF CI issue with s390 build
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Mykola Lysenko <mykolal@meta.com>
Cc:     Daniel =?ISO-8859-1?Q?M=FCller?= <deso@posteo.net>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@meta.com>,
        Andrii Nakryiko <andriin@meta.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@meta.com>
Date:   Fri, 06 Jan 2023 20:19:29 +0200
In-Reply-To: <E5735DC1-7E84-412E-A7A4-432E5652AB91@fb.com>
References: <0c25d95234d8e009fe57199ce35b9fd18bd2cb78.camel@gmail.com>
         <E5735DC1-7E84-412E-A7A4-432E5652AB91@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-01-06 at 16:30 +0000, Mykola Lysenko wrote:
> + bpf list for wider visibility
>=20
> Hi Eduard,
>=20
> Thanks a lot for looking into this!
>=20
> > On Jan 6, 2023, at 5:10 AM, Eduard Zingerman <eddyz87@gmail.com> wrote:
> >=20
> > !-------------------------------------------------------------------|
> >  This Message Is From an External Sender
> >=20
> > > -------------------------------------------------------------------!
> >=20
> > Hi Guys,
> >=20
> > I think we have a temporary issue with CI on s390 caused by one of the
> > upstream commits. All recent pull requests are failing because of the
> > build issue on s390, e.g.:
> > - https://github.com/kernel-patches/bpf/actions/runs/3851652311
> > - https://github.com/kernel-patches/bpf/actions/runs/3851642638
> > - https://github.com/kernel-patches/bpf/actions/runs/3851641331
> >=20
> > This LKML link discusses the issue:
> > https://lkml.org/lkml/2023/1/2/30
> >=20
> > The suggestion is to revert commit 99cb0d917ffa1ab628bb67364ca9b162c076=
99b1 .
> >=20
> > I did this for my pull request and it worked:
> > https://github.com/kernel-patches/bpf/pull/4299
> >=20
> > Maybe temporarily add this revert as a pre CI patch?
>=20
> Yes, please, create a pull request to https://github.com/kernel-patches/v=
mtest.
>=20
> Let's have PR pass the tests while waiting for BPF community input, if an=
y.

Submitted the pull request here:
https://github.com/kernel-patches/vmtest/pull/186

>=20
> >=20
> > Thanks,
> > Eduard
>=20

