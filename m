Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861CB6CCA57
	for <lists+bpf@lfdr.de>; Tue, 28 Mar 2023 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjC1S55 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Mar 2023 14:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjC1S54 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 28 Mar 2023 14:57:56 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9C7A2
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 11:57:55 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id q88so9855895qvq.13
        for <bpf@vger.kernel.org>; Tue, 28 Mar 2023 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680029874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13zTQ3Cr/anSDqz1yarZAy/6uVf71AcQ6m3G4N+b2UI=;
        b=pYNbvcYNQZrEwPedM0SUYUMeQ3VBmF0yORVFbeRWvSSuADLj7PLRe3MTjgJiI9l6hX
         rEeAcFT7CMrd/cfpFSxAFSN+QirTz6JdTpr8d2MUVRDhowPwvlezADyf3Gc6nNV6p3lg
         +BUL7W9o1BYKD9ppqjOIwozgk5Z2bPBbRxpz2QmZxv9MF8t0D5hBNPbyRMRhRdLzf93L
         iKKKW3TSOjiHK3ghNQMWCdtYMvE+jlrRw4VxxymCNE/ZVqIOkiOo9QEea98AF1nh0Psx
         edQHUJYRJtsZ82gG59FXukIoDN8zHfYKgvIGBZI6UobJj7m05kOgw7Lm+16DX8BPqG+y
         h1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680029874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13zTQ3Cr/anSDqz1yarZAy/6uVf71AcQ6m3G4N+b2UI=;
        b=sCvJQSfXTzv/fJJa7Lnovm3JpCumWCVqlGwZN3Hhck6EllUL2qLA6iYSIgUGahD+qA
         bKYxbMz3yucn5zk2UVXXewMM4lGQW9aaCItI0A3UK1WAYo4Xf7BqvAQ7JOZdEPAx60MC
         z1NAOicIdEzAYdLtEU8A6Ou2MVtNiERXAsVt/m+oIYCnLb9jOglHLGmUqOzMrVclkH3E
         ylKRh5hm9tE3yp1NXjbOSc8yZNgTl7jSVghhuO8NvuaVfPsMSrxr3V7zid77uSgFXUdY
         +plLd4Y/AzyALwurlFFRDrI2D992BMeMr8eb3ljo685z1K0gcWz2KxlD/qQPIOyMYF9v
         ScnQ==
X-Gm-Message-State: AAQBX9fIVjt6MxKbcMJe3udKAY7o8B4QTHGMeurc1JSQHjPu2m52ZQRQ
        dy/7IRXv3A36zBVaCaH/i1twVSmgokYzqSMJgJz++9DMuiHFMYRCMufExw==
X-Google-Smtp-Source: AKy350aCx5BHA9UDzXeGhHnSqbOkKx+i4E2oohGx8eb3Co0SWEAeK7ItsVrqMT1VZdL8SSj1bLkse/EHg3Qzz1PvBiQ=
X-Received: by 2002:ad4:4d4e:0:b0:56e:9f09:ee58 with SMTP id
 m14-20020ad44d4e000000b0056e9f09ee58mr3248264qvm.8.1680029874187; Tue, 28 Mar
 2023 11:57:54 -0700 (PDT)
MIME-Version: 1.0
References: <9c5c8b7e-1d89-a3af-5400-14fde81f4429@linux.dev> <CAKH8qBvRCBrZz0Cx8w8VsYGJKOLQXf9xzc50ce_nQenhGNdx7w@mail.gmail.com>
In-Reply-To: <CAKH8qBvRCBrZz0Cx8w8VsYGJKOLQXf9xzc50ce_nQenhGNdx7w@mail.gmail.com>
From:   YiFei Zhu <zhuyifei@google.com>
Date:   Tue, 28 Mar 2023 11:57:43 -0700
Message-ID: <CAA-VZP=fUeX7ELEKJQfsJavXyZ7=rp-ebfwCa8jN6b_WKvXFqg@mail.gmail.com>
Subject: Re: Flaky bpf cg_storage_* tests
To:     Stanislav Fomichev <sdf@google.com>
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

On Tue, Mar 28, 2023 at 11:08=E2=80=AFAM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> On Tue, Mar 28, 2023 at 10:40=E2=80=AFAM Martin KaFai Lau <martin.lau@lin=
ux.dev> wrote:
> >
> > Hi YiFei and Stan, it is observed that the cg_stroage_* tests fail from=
 time to
> > time. A recent example is
> > https://github.com/kernel-patches/bpf/actions/runs/4543867424/jobs/8009=
943115?pr=3D3924
> >
> > Could you help to take a look? may be run it under netns and also have =
better
> > filtering by ip/port when counting packets?
>
> Error: #43/2 cg_storage_multi/isolated
> test_isolated:PASS:skel-load 0 nsec
> test_isolated:PASS:parent-egress1-cg-attach 0 nsec
> test_isolated:PASS:parent-egress2-cg-attach 0 nsec
> test_isolated:PASS:parent-ingress-cg-attach 0 nsec
> test_isolated:PASS:first-connect-send 0 nsec
> test_isolated:FAIL:first-invoke invocations=3D2
>
> Error: #43/3 cg_storage_multi/shared
> test_shared:PASS:skel-load 0 nsec
> test_shared:PASS:parent-egress1-cg-attach 0 nsec
> test_shared:PASS:parent-egress2-cg-attach 0 nsec
> test_shared:PASS:parent-ingress-cg-attach 0 nsec
> test_shared:PASS:first-connect-send 0 nsec
> test_shared:FAIL:first-invoke invocations=3D2
>
> Probably because we're using tcp? And race with syn vs syn+ack
> (invocatoins=3D1 vs invocations=3D2)?

I don't remember what I wrote in the test :)

Nope it's not TCP. I see line 65:
  server_fd =3D start_server(AF_INET, SOCK_DGRAM, NULL, 0, 0);

However I see line 169:
  * Assert that there is three runs, two with parent cgroup egress and
  * one with parent cgroup ingress, stored in separate parent storages.

Expected 3 got 2, is it possible we are racing against ingress?

> YiFei, maybe we should count only pure syns?
>
> > Thanks!
