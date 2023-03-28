Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62AD6CCB78
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 22:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjC1U2S (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 16:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjC1U2R (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 16:28:17 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EE1269D
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 13:28:16 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f6-20020a17090ac28600b0023b9bf9eb63so13899628pjt.5
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 13:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680035296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRroYQS6N+ww2qUKXi+z1K2wwxDic9QbszmPm8mPM4w=;
        b=BgSZ+AMggpyDoRVfdUEmllSd4p8Fj3WFru3qCPWvbgxE+Dnx9dPKLvPFrUmDZiElCZ
         shM4ZGMrymDSJ9GSxMobSQ3Ia3zYv2+YhNC7/GOISCYC52KY7ey8dI/EeATf28QY0oo5
         LgwKOkWXSzMz7/hxHijfMkY8Q+RF4+5nahXsJkEuBCxdiUDIs5jMnugV9FEzvDkL6OgM
         MxFUE+LlOVM5fQRLAuVL7i6C59cNwtlE8SXRf0+zF+oIxK1bzgpG6H5uQ2MRkB2hzpbJ
         HddN5u8UsN6yky2J+SHjhBApOqpvNw4oa6d5N9EkiQ+ewRBs0YKcUicHkJ00ywhQaVOD
         hyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680035296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRroYQS6N+ww2qUKXi+z1K2wwxDic9QbszmPm8mPM4w=;
        b=bsdhqt6/Qu2blHAusRQH7bKXGGayy+LEHoTUgjafCp6olADkZp48jBD11+Fnh0nPSn
         emppqa1JfxU1YMn8GF2LRdusF3HHyxfZradkSUBD6YOeA6AZMjDMq0aGm5/nMZEfaZo/
         RKov3NgNZFELMsXjJQbTFFM9QfewGQtnyBIGGyl7mnulxz1cLAQQZkJlqNVHdmfS7WqQ
         sSpGE6XMi903rTxMrGV9gv5sEd6HWz3Dw5WOMChJcF7d2xn8i1yOHV32kl5ZhM4P1IX6
         tkq15t4laOaliRf4Fuh0gZCg4EhSUzoO761ibHgl5D4PXVZ0mbXodl1hLidzMxzkS4bz
         hLiw==
X-Gm-Message-State: AAQBX9dY/n6OVzd6cb2z1BEW3A1Oqup6jSVy9cvYkEBE0VvsVgZiEtLa
        YpsvyFApYSmJFcK8Y6MgVT2THbxj+VUN/J4Ffi5mgg==
X-Google-Smtp-Source: AKy350Yd9bJNxs74dbgxZL9GOoj43c/8tmf/AHSCWZZ7VcVjoeU1UAPlW6bOkVRu/PJMS+WHlxuhtiTnrYzm6nZ9b9Q=
X-Received: by 2002:a17:903:2290:b0:1a2:1fd0:226c with SMTP id
 b16-20020a170903229000b001a21fd0226cmr5285796plh.8.1680035295938; Tue, 28 Mar
 2023 13:28:15 -0700 (PDT)
MIME-Version: 1.0
References: <9c5c8b7e-1d89-a3af-5400-14fde81f4429@linux.dev>
 <CAKH8qBvRCBrZz0Cx8w8VsYGJKOLQXf9xzc50ce_nQenhGNdx7w@mail.gmail.com> <CAA-VZP=fUeX7ELEKJQfsJavXyZ7=rp-ebfwCa8jN6b_WKvXFqg@mail.gmail.com>
In-Reply-To: <CAA-VZP=fUeX7ELEKJQfsJavXyZ7=rp-ebfwCa8jN6b_WKvXFqg@mail.gmail.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Tue, 28 Mar 2023 13:28:04 -0700
Message-ID: <CAKH8qBvoj51qisZPLM8PPjBzcxkJ_Af3U-cW5jS8m1o6Pag-3A@mail.gmail.com>
Subject: Re: Flaky bpf cg_storage_* tests
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 28, 2023 at 11:57=E2=80=AFAM YiFei Zhu <zhuyifei@google.com> wr=
ote:
>
> On Tue, Mar 28, 2023 at 11:08=E2=80=AFAM Stanislav Fomichev <sdf@google.c=
om> wrote:
> >
> > On Tue, Mar 28, 2023 at 10:40=E2=80=AFAM Martin KaFai Lau <martin.lau@l=
inux.dev> wrote:
> > >
> > > Hi YiFei and Stan, it is observed that the cg_stroage_* tests fail fr=
om time to
> > > time. A recent example is
> > > https://github.com/kernel-patches/bpf/actions/runs/4543867424/jobs/80=
09943115?pr=3D3924
> > >
> > > Could you help to take a look? may be run it under netns and also hav=
e better
> > > filtering by ip/port when counting packets?
> >
> > Error: #43/2 cg_storage_multi/isolated
> > test_isolated:PASS:skel-load 0 nsec
> > test_isolated:PASS:parent-egress1-cg-attach 0 nsec
> > test_isolated:PASS:parent-egress2-cg-attach 0 nsec
> > test_isolated:PASS:parent-ingress-cg-attach 0 nsec
> > test_isolated:PASS:first-connect-send 0 nsec
> > test_isolated:FAIL:first-invoke invocations=3D2
> >
> > Error: #43/3 cg_storage_multi/shared
> > test_shared:PASS:skel-load 0 nsec
> > test_shared:PASS:parent-egress1-cg-attach 0 nsec
> > test_shared:PASS:parent-egress2-cg-attach 0 nsec
> > test_shared:PASS:parent-ingress-cg-attach 0 nsec
> > test_shared:PASS:first-connect-send 0 nsec
> > test_shared:FAIL:first-invoke invocations=3D2
> >
> > Probably because we're using tcp? And race with syn vs syn+ack
> > (invocatoins=3D1 vs invocations=3D2)?
>
> I don't remember what I wrote in the test :)
>
> Nope it's not TCP. I see line 65:
>   server_fd =3D start_server(AF_INET, SOCK_DGRAM, NULL, 0, 0);
>
> However I see line 169:
>   * Assert that there is three runs, two with parent cgroup egress and
>   * one with parent cgroup ingress, stored in separate parent storages.
>
> Expected 3 got 2, is it possible we are racing against ingress?

Not sure. Can you try to see if you can reproduce locally?

> > YiFei, maybe we should count only pure syns?
> >
> > > Thanks!
