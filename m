Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93EB043E818
	for <lists+bpf@lfdr.de>; Thu, 28 Oct 2021 20:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhJ1SRL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Oct 2021 14:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbhJ1SRL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Oct 2021 14:17:11 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65A9C061570
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 11:14:43 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id d10so6666473ybe.3
        for <bpf@vger.kernel.org>; Thu, 28 Oct 2021 11:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7T/o7gzYHn1XJ86gzv6LBiMh4xTGOSj3AQJ9Bl0dSSM=;
        b=dBARVh9ivMZ6y3U6HYZaVxXKkLIIwSFsjIspxtton7czjqoCfTjYejiaAeAzwaGHzL
         kjK/j95mIuAajeDLgjXIk+N+jI/bBCsW0YbDNEXBUcwPk3eC+b8OSfibIXmQeQ0xM1LI
         MDK2jsmBxC7WOvVtdDUobscm+n6n+HH865zqO6wkxa6bjm2azULWEBbqfrCOlXU1HnrC
         aU1LS3pBubFXugdC4mLe1oW+fL9C9Csd15D2hUP+y4y0Fv9AaGZiZaGCb/HzKjF1xX9p
         /wofhaQowaITvFleaaPzCIir0NJdbmNXgNGQxbvR4xoihVaoO+3Z5DDDqXKQzGwu3oy+
         9+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7T/o7gzYHn1XJ86gzv6LBiMh4xTGOSj3AQJ9Bl0dSSM=;
        b=HkCcht/KpU1qbTn5sb8bBr3ay0ULf2VDi09Yq2+CD76Gm1n2948p9A/hchDSP1s9Ue
         6YSlTsqI79RYbOtVQcLjNLXDsSU9C2f/S/pWyDydPCgZYXdGho1MYOo9T8wW3yvxWUC8
         lopSYefojSPUPUz58iv0mfv5mOPVYxE7j5LeD/PJl25kas6AKbSoaQTN6PFo+sEM1h5y
         7xd1V0Zp7NpFSTPD1BVlN1GusT1s7z6kk2A9Bw1MQLLJz9aMvQ/npjo+Im1Co+pk3oBW
         hfulI7c1zGFqE9exL/NlRyR3mQ4+ZnBph2gg2lAMI120T0IO6c1VfRgND5pbq6fAbut7
         fEhw==
X-Gm-Message-State: AOAM533pDbw1YjUztHeJwUxumwo80YPJkK4YJUjmyJuwvOPz2ChSlGc5
        TdDE2RKfzwV/A8vI77yY5+vcaxzoAesvrMFLfR0=
X-Google-Smtp-Source: ABdhPJwBv3gPHQMidOUA6fkCb7xDYFbkLqA/JzJ4v3nhfd76yGqJUQf17AA9zEt7TQ8VtcciZm9nOCRITFAzIJdCpQI=
X-Received: by 2002:a25:ab88:: with SMTP id v8mr6557493ybi.2.1635444882969;
 Thu, 28 Oct 2021 11:14:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211027234504.30744-1-joannekoong@fb.com> <20211027234504.30744-3-joannekoong@fb.com>
In-Reply-To: <20211027234504.30744-3-joannekoong@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 28 Oct 2021 11:14:31 -0700
Message-ID: <CAEf4BzbrAnwj0GnZFFTF_XfVwZZuwow_q8dO8M4mXb6bzKY-8w@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 2/5] libbpf: Add "map_extra" as a per-map-type
 extra flag
To:     Joanne Koong <joannekoong@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin Lau <kafai@fb.com>, Kernel Team <Kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Oct 27, 2021 at 4:45 PM Joanne Koong <joannekoong@fb.com> wrote:
>
> This patch adds the libbpf infrastructure for supporting a
> per-map-type "map_extra" field, whose definition will be
> idiosyncratic depending on map type.
>
> For example, for the bloom filter map, the lower 4 bits of
> map_extra is used to denote the number of hash functions.
>
> Please note that until libbpf 1.0 is here, the
> "bpf_create_map_params" struct is used as a temporary
> means for propagating the map_extra field to the kernel.
>
> Signed-off-by: Joanne Koong <joannekoong@fb.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/bpf.c              | 27 ++++++++++++++++++++++-
>  tools/lib/bpf/bpf_gen_internal.h |  2 +-
>  tools/lib/bpf/gen_loader.c       |  3 ++-
>  tools/lib/bpf/libbpf.c           | 38 +++++++++++++++++++++++++++-----
>  tools/lib/bpf/libbpf.h           |  3 +++
>  tools/lib/bpf/libbpf.map         |  2 ++
>  tools/lib/bpf/libbpf_internal.h  | 25 ++++++++++++++++++++-
>  7 files changed, 91 insertions(+), 9 deletions(-)

[...]
