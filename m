Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06106D54A2
	for <lists+bpf@lfdr.de>; Tue,  4 Apr 2023 00:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjDCWQ6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Apr 2023 18:16:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233787AbjDCWQz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 3 Apr 2023 18:16:55 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF533AAC
        for <bpf@vger.kernel.org>; Mon,  3 Apr 2023 15:16:55 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id qe8-20020a17090b4f8800b0023f07253a2cso31990748pjb.3
        for <bpf@vger.kernel.org>; Mon, 03 Apr 2023 15:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680560214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3p+YSonEoc2cSUu3Xn55f6FEsVw8kFB3Z3VKLiWAyHA=;
        b=crnSdoIXsVS2z4x3uJaX7WHL1NfuabSz/APH/Q2NYIERE1dWZ2LONR/I4t++gPj3oW
         3+jLkDPt682sx8Std8PYL5XWksRrTCdnqSAbyJNtliqnykkrR0SMAa5scCYipk6WgkyK
         3lOPHLUfYR58ykB/L1SWpt5gXwrMKmlW7JvHPmHDJEIvUbTQD1zAlXJcOh2oHBsF8KMp
         6sv1ELlYwX4mniIFNvBKpRGND4BUPDEisFIEOzN+lKW19kUSoHl0q4LH+/YgKKJBePKX
         zpjIG0Hl2devO+zGj6Fd5Bz/RuvmbJQHNhz0pxtC/5EpZOezFv/cl+bn53bxkx9kZReT
         fvCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680560214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3p+YSonEoc2cSUu3Xn55f6FEsVw8kFB3Z3VKLiWAyHA=;
        b=ZeIB1ibdsGHQHz3k3vpsfsfAEFrtcjSDSWRC/ixsJMu1K2VtH2d/8r1CJSDyEDYjFZ
         dojaPhVF0nms4FpOIAQkVFr7ZnDPmQQWsCVidxqNjgVG6O20ATswNqHH+EHpK87ySPUs
         dV+rNPaIQIrBCjeEpfQtuXol+DfX3NXcndYbDUocIFq5eai6yhwALZouMduPYdva28qZ
         iGFrahM+3zIltvWqG/EiSaVzLnDdNca0jECsvw9v6dGDb5pGbBDCNPaN2V8OM4x8paYD
         pL4OxLyJwrTayvn3n3xw9zWgB8DMtzyo4VWFlC+La3s6fWA0XevuSL3oL+E260Mre5tH
         +XoA==
X-Gm-Message-State: AAQBX9ew8MolrDLSpljgbfPQ0+4F+3NbHoNRXvc1Da92UkHDL04KhNha
        cUyo6aQ3lVXXB24YVd0JAXqg6ZvWWh2eJqSIGJ1RfA==
X-Google-Smtp-Source: AKy350bN7Wp/YgCpdZzclwx6VXeAU7ntgwIBJNqdMZ2EjfqDsezbRFGjuFx7jymAv6ZpcEuSXFX8+xd/3Sig3QDa8Pk=
X-Received: by 2002:a17:90a:c08e:b0:23d:30a:692b with SMTP id
 o14-20020a17090ac08e00b0023d030a692bmr185012pjs.4.1680560214323; Mon, 03 Apr
 2023 15:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230403215834.26675-1-zhuyifei@google.com>
In-Reply-To: <20230403215834.26675-1-zhuyifei@google.com>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Mon, 3 Apr 2023 15:16:43 -0700
Message-ID: <CAKH8qBtWQhMn+TwTKhkXiu_ypKv-turNHObuLqNUhcYKpLG31A@mail.gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: Poll for receive in cg_storage_multi test
To:     YiFei Zhu <zhuyifei@google.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Mon, Apr 3, 2023 at 2:59=E2=80=AFPM YiFei Zhu <zhuyifei@google.com> wrot=
e:
>
> In some cases the loopback latency might be large enough, causing
> the assertion on invocations to be run before ingress prog getting
> executed. The assertion would fail and the test would flake.
>
> This can be reliably reproduced by arbitrarily increaing the loopback
> latency (thanks to [1]):
>   tc qdisc add dev lo root handle 1: htb default 12
>   tc class add dev lo parent 1:1 classid 1:12 htb rate 20kbps ceil 20kbps
>   tc qdisc add dev lo parent 1:12 netem delay 100ms
>
> Fix this by polling on the receive end and waiting for up to a
> second, instead of instantly returning to the assert.
>
> [1] https://gist.github.com/kstevens715/4598301
>
> Reported-by: Martin KaFai Lau <martin.lau@linux.dev>
> Link: https://lore.kernel.org/bpf/9c5c8b7e-1d89-a3af-5400-14fde81f4429@li=
nux.dev/
> Fixes: 3573f384014f ("selftests/bpf: Test CGROUP_STORAGE behavior on shar=
ed egress + ingress")
> Signed-off-by: YiFei Zhu <zhuyifei@google.com>

Thank you!

Acked-by: Stanislav Fomichev <sdf@google.com>

> ---
>  .../testing/selftests/bpf/prog_tests/cg_storage_multi.c  | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c b/=
tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> index 621c57222191..3b0094a2a353 100644
> --- a/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> +++ b/tools/testing/selftests/bpf/prog_tests/cg_storage_multi.c
> @@ -7,6 +7,7 @@
>  #include <test_progs.h>
>  #include <cgroup_helpers.h>
>  #include <network_helpers.h>
> +#include <poll.h>
>
>  #include "progs/cg_storage_multi.h"
>
> @@ -56,8 +57,9 @@ static bool assert_storage_noexist(struct bpf_map *map,=
 const void *key)
>
>  static bool connect_send(const char *cgroup_path)
>  {
> -       bool res =3D true;
>         int server_fd =3D -1, client_fd =3D -1;
> +       struct pollfd pollfd;
> +       bool res =3D true;
>
>         if (join_cgroup(cgroup_path))
>                 goto out_clean;
> @@ -73,6 +75,11 @@ static bool connect_send(const char *cgroup_path)
>         if (send(client_fd, "message", strlen("message"), 0) < 0)
>                 goto out_clean;
>
> +       pollfd.fd =3D server_fd;
> +       pollfd.events =3D POLLIN;
> +       if (poll(&pollfd, 1, 1000) !=3D 1)
> +               goto out_clean;
> +
>         res =3D false;
>
>  out_clean:
> --
> 2.40.0.348.gf938b09366-goog
>
