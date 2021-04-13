Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCA435E969
	for <lists+bpf@lfdr.de>; Wed, 14 Apr 2021 01:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232821AbhDMXE3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 19:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhDMXE2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Apr 2021 19:04:28 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55466C061574;
        Tue, 13 Apr 2021 16:04:07 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y2so17898289ybq.13;
        Tue, 13 Apr 2021 16:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACuueoewNajSzLpvMXPnoRuu2miU/7IxNAGu5/df4sc=;
        b=c6JibF2KsDFbzGhvVMoSEAjYy4uyeVuLYPOkPVUlOzaB5J4efWYCEi0nwZTxW64bvK
         K8Of9/V2AoLFx3q2sc8UqbmQow9RTT6j0OFce0N8FhRJ9iqRWOk2lxbDxje5ah2mhyLt
         lWPBg2+xmcz7Zr6G8rJlw0RN6KnFJrl0UYabihkF5W+VUBGqMY0AZNwzuCld05HdSCbF
         yCqME1FvEzoS4DhQT+LfQ61DM15F72tDh4FGR3cgrMufOkbTcZPJQVu6Hax+fja/C+M3
         Y4yRYWk1qTeG+R9OjcJ5ImQJI4VLtLDgOr98LqwGBAu5TyXvHZIeYwIz2jmiggIF/ONs
         JO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACuueoewNajSzLpvMXPnoRuu2miU/7IxNAGu5/df4sc=;
        b=B8LApgHEXzuDfmkuKYdzjUFDkZ/1+ll/2KqYAzXuVNyt1OVbFtPFYafqj69tPuAy9Z
         PoMBS0zDqIXJXRp4lHAcU4E9eGM7kTQYrIt9alKPeR4ZPWtMAbn0OlVlRF34PaqiOJcZ
         ajeDmkwohfU+7RUqLGUNGnXuhhLyV8kO2b4sFlEnJ6j9C1zS6KizlhariEPua9Akvt6G
         1669Q6DoyB9mC8T0p9K0P/BuFLy3IMOa147kLpZqnBT5MBpKnR03yCkUhBBlcriJpMdg
         87bcpE9j2tFOp1eBegLoksF2Hc6ZAwEAdF2K+Au4heGdAa9Zzv1HjWN6T5h0des+Ebp/
         qP8g==
X-Gm-Message-State: AOAM530cFIiA539435w3OD3rlfWa5tv+9Xhj7zbi0mMzjglEI1Poxyqh
        UtBCLkMb5vhd21aaWhPnu/Qfq6BvMhg/DxDfewo=
X-Google-Smtp-Source: ABdhPJyvIkafcsqoRblCq0eg0Od/0dTMn4arhUvLGa5QxEWHY8JzCLgbT9Ekbry4beAKltE5Wll6O9gO/qBA+HsEVQo=
X-Received: by 2002:a25:3357:: with SMTP id z84mr39345648ybz.260.1618355046733;
 Tue, 13 Apr 2021 16:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210412153754.235500-1-revest@chromium.org> <20210412153754.235500-3-revest@chromium.org>
In-Reply-To: <20210412153754.235500-3-revest@chromium.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 13 Apr 2021 16:03:55 -0700
Message-ID: <CAEf4BzZPfqKzE==hBwJvmKawusy_orwR7zLg71AUoH2P11G0=g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Add a ARG_PTR_TO_CONST_STR argument type
To:     Florent Revest <revest@chromium.org>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@chromium.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Apr 12, 2021 at 8:38 AM Florent Revest <revest@chromium.org> wrote:
>
> This type provides the guarantee that an argument is going to be a const
> pointer to somewhere in a read-only map value. It also checks that this
> pointer is followed by a zero character before the end of the map value.
>
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h   |  1 +
>  kernel/bpf/verifier.c | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 42 insertions(+)
>

[...]
