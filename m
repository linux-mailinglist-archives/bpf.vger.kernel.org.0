Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F093EE06C
	for <lists+bpf@lfdr.de>; Tue, 17 Aug 2021 01:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbhHPX3N (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Aug 2021 19:29:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:55446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234391AbhHPX3I (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Aug 2021 19:29:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE6B160F58
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 23:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629156515;
        bh=5bnvIV4VWElcsj2fXkT1fY88QtyfF7nwxgQgeNqY8Yw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n1UK+ViTvcUMMKJgh9X/1LCmTi0sWKbxp7ecqYeBUs3YOhR99j/7bV6hF6KxzVmF4
         J2swBU5UxWtSeqpLVIsy1BIi8qxe8QPOTNVF8xclX7r+Pr29qtqPOsIfgYof32re4F
         Unp3pm1eVwHlpSoaYsUkIzIwoaFL10CUjAAQS7LfEqP1wTkd8kqniunKifgZOdWbVF
         HqW05WiEYNBJ7RBQ3w1j+PxRnXbggJspGoMPyb/3Ty9WR3LH5qyhGDFpO0dsEimRcK
         C2dnrHF7n+o5SNSPRLH60XKiwBkuL2u5R/T7n3rAk9MjhAxPBmd8Vg1Qdlo510FCFi
         iwEDJDRjgZCFQ==
Received: by mail-lf1-f48.google.com with SMTP id w20so37713058lfu.7
        for <bpf@vger.kernel.org>; Mon, 16 Aug 2021 16:28:35 -0700 (PDT)
X-Gm-Message-State: AOAM533UxJMmLFXEtQVJSkLJGy4bXMty43VeGyZb0MvSq+SruJoEH39/
        kwAJNzBS5kcXqRZC8VDCb2/ygL2du6n3pt++Ico=
X-Google-Smtp-Source: ABdhPJxFNMLMJKAcBWxulKAYwHgI0qqyhbxAnor8Hitj+UqcO2folbT1sXiiY68ZYKek4XXOxoSfOi3KRvedgIia3hk=
X-Received: by 2002:ac2:55b9:: with SMTP id y25mr174139lfg.261.1629156514260;
 Mon, 16 Aug 2021 16:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20210816175250.296110-1-fallentree@fb.com>
In-Reply-To: <20210816175250.296110-1-fallentree@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 16 Aug 2021 16:28:23 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5NYMVRCmCXu=gJudfReYzMZqTUVUUWfH+U6FzVo=dWJQ@mail.gmail.com>
Message-ID: <CAPhsuW5NYMVRCmCXu=gJudfReYzMZqTUVUUWfH+U6FzVo=dWJQ@mail.gmail.com>
Subject: Re: [PATCH v1 bpf] selftests/bpf: Add exponential backoff to
 map_update_retriable in test_maps
To:     Yucong Sun <fallentree@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, sunyucong@gmail.com,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Aug 16, 2021 at 10:54 AM Yucong Sun <fallentree@fb.com> wrote:
>
> Using a fixed delay of 1ms is proven flaky in slow CPU environment, eg.  github
> action CI system. This patch adds exponential backoff with a cap of 50ms, to
> reduce the flakyness of the test.

Do we have data showing how flaky the test is before and after this change?

>
> Signed-off-by: Yucong Sun <fallentree@fb.com>
> ---
>  tools/testing/selftests/bpf/test_maps.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_maps.c b/tools/testing/selftests/bpf/test_maps.c
> index 14cea869235b..ed92d56c19cf 100644
> --- a/tools/testing/selftests/bpf/test_maps.c
> +++ b/tools/testing/selftests/bpf/test_maps.c
> @@ -1400,11 +1400,16 @@ static void test_map_stress(void)
>  static int map_update_retriable(int map_fd, const void *key, const void *value,
>                                 int flags, int attempts)
>  {
> +       int delay = 1;
> +
>         while (bpf_map_update_elem(map_fd, key, value, flags)) {
>                 if (!attempts || (errno != EAGAIN && errno != EBUSY))
>                         return -errno;
>
> -               usleep(1);
> +               if (delay < 50)
> +                       delay *= 2;
> +
> +               usleep(delay);

It is a little weird that the delay times in microseconds are 2, 4, 8,
16, 32, 64, 64, ...
Maybe just use rand()?

Thanks,
Song

>                 attempts--;
>         }
>
> --
> 2.30.2
>
