Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6146CAE16
	for <lists+bpf@lfdr.de>; Mon, 27 Mar 2023 21:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjC0TER (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Mar 2023 15:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjC0TEQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Mar 2023 15:04:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B7401FEC;
        Mon, 27 Mar 2023 12:04:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB723B818A4;
        Mon, 27 Mar 2023 19:04:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE7DC4339B;
        Mon, 27 Mar 2023 19:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679943851;
        bh=5gBuPNoKep58jZJZ2A7T/PwMZj21euhJkbbmerZDQl8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sw05c/rO4PxHWF3R2aaZ8OKUInpF3cxm0e2+Sf69qvtnKH7XVIWehtO+3owXuSiWF
         /3uDucZMvDBifEbDl692VTOoJYS5ymNBir9tdKub8ik2q24652nJyuku4MxlrXy5L4
         tcxksh1WgwNRFg6WrWS1c8CbauK+WWYM0zzn6rNLqudqNOXY6luQ4G0jWIZ0sICBpx
         4CuK4QQTdiiLPx8W7EKm+peW4l/HiVM36ekjeYBA81SMIugfL6wG1/j5ur1VvU/5Rr
         2ucsB8JgRMx5QSCz+2ug8KOc95Pu5Pnc1OnGZU7Etjzgm5jyx4XHdEN9Muk507tncb
         TJFbuhGiN+vjQ==
Received: by mail-lf1-f41.google.com with SMTP id c29so12796902lfv.3;
        Mon, 27 Mar 2023 12:04:11 -0700 (PDT)
X-Gm-Message-State: AAQBX9fRYwA2dZ2DIPj3vRfcMTuqygjOaKwOMFL2/V+7oFY4j+T2TLSy
        XzKMjOPAIHk2Cxa/VVdTCfb5vxscN9DzBFhbuqc=
X-Google-Smtp-Source: AKy350aI7otTUFAj1Lu3xkTRCygHh6+IkNJ0FCb50NrI4XbsKhMraNZsmBGv5AeouqLYd6UZy//NWILZAo5bQ+khyDY=
X-Received: by 2002:ac2:5dd7:0:b0:4e8:5f14:20fb with SMTP id
 x23-20020ac25dd7000000b004e85f1420fbmr3873834lfq.3.1679943849639; Mon, 27 Mar
 2023 12:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230326092208.13613-1-laoar.shao@gmail.com>
In-Reply-To: <20230326092208.13613-1-laoar.shao@gmail.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 27 Mar 2023 12:03:56 -0700
X-Gmail-Original-Message-ID: <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
Message-ID: <CAPhsuW43EiH0tVKU8s+JwV_V6EBETTDyXsAmMzAftpVtcgLHag@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 00/13] bpf: Introduce BPF namespace
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Mar 26, 2023 at 2:22=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> Currently only CAP_SYS_ADMIN can iterate BPF object IDs and convert IDs
> to FDs, that's intended for BPF's security model[1]. Not only does it
> prevent non-privilidged users from getting other users' bpf program, but
> also it prevents the user from iterating his own bpf objects.
>
> In container environment, some users want to run bpf programs in their
> containers. These users can run their bpf programs under CAP_BPF and
> some other specific CAPs, but they can't inspect their bpf programs in a
> generic way. For example, the bpftool can't be used as it requires
> CAP_SYS_ADMIN. That is very inconvenient.

Agreed that it is important to enable tools like bpftool without
CAP_SYS_ADMIN. However, I am not sure whether we need a new
namespace for this. Can we reuse some existing namespace for this?

If we do need a new namespace, maybe we should share some effort
with tracer namespace proposal [1]?

Thanks,
Song

[1] https://lpc.events/event/16/contributions/1237/
