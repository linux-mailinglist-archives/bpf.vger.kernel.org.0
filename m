Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096895A14ED
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 16:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242262AbiHYO5d (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 10:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbiHYO5b (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 10:57:31 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2008A5C54;
        Thu, 25 Aug 2022 07:57:30 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s11so26440951edd.13;
        Thu, 25 Aug 2022 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AWgibCutTfiXIvt1m9RTcF9fCySSvFCw3FLjdJD2IpE=;
        b=C70ncnQdcfLkQRh5beTHFLYm2Xr5aL8dyJ05LyZAAoxq43dfjUXgxN+2DBaL8Be9OY
         XgQeekxKLNVZayt56D2uiq/VDqHm0tYZ/Vhdx5JfnLDS5sgqF8aZhRqS0Mh0OQvBjRO3
         pk41I+NtmZdUfvxBrzetpuKIlU6npQSRUan3sZyvlPE3ZwUj1m3u8YdC+Y4rEsYkhhg8
         868haE61xSnVRzHlaIz/Dnol5dn6310bLkR0hYmjUF6AeIpRPpf04f3gdLHsbEueoCyK
         F79yBqqKAEpwqmqmbDjENQk/9gpKIsumv4MO6+FS+S+cTB3Q1QzWrBquirZ/eg0J5ML+
         ynrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AWgibCutTfiXIvt1m9RTcF9fCySSvFCw3FLjdJD2IpE=;
        b=BHi1awEIve238ANGyVcWgDMWvQqJYT8ydaCTJsjHqh24LGaIKHsZu5PNw8Zzw4csCW
         3oNKXuQfzOBu/MJRvk7cZqkIpVROIk7BS962dNfhnchyNK8XFZztadF7RJKuQ2K5DK5A
         QhfWjJSCmk6Ob03BoieDWVLXkgRvP3KsMNgsG99X9oSxDI9/78OAx+tfRk8y5V01SZhE
         tNhNkdIfK/yPVVkvg5hUFfG/i/6UFS7rz7i9nnehFid3B+sOzzTZZaNd+BfoALWBV1Uk
         pw+OLYg4fBnI/pEAyl7oNw+XWX/oxXhNhMxElirTHe7Nke1Bog/CBO/DaTkJ5ZCEGN2k
         hqog==
X-Gm-Message-State: ACgBeo16IvL3XSD69Kcm4726LzW7XKF3jqrOEDSiNsi0avOuPVKHpTiI
        RvNiaIdnQPSfhOFIK02oklv/I41qjKzObMdODxs=
X-Google-Smtp-Source: AA6agR5uEVWGQ14qOvh2nHm+3LCvwRF1MuQH+zegJwfuo0hfrZozx+kQEzgOuQXLGz4Hn08TiRxJyXNZ5BWpo1yLuT4=
X-Received: by 2002:a05:6402:378f:b0:43a:d3f5:79f2 with SMTP id
 et15-20020a056402378f00b0043ad3f579f2mr3597324edb.338.1661439449387; Thu, 25
 Aug 2022 07:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220825110216.53698-1-quentin@isovalent.com>
In-Reply-To: <20220825110216.53698-1-quentin@isovalent.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Thu, 25 Aug 2022 07:57:18 -0700
Message-ID: <CAADnVQKdXUjBnq2P5hLahtGnJh6-_8bgQFFRr_EyykTRZb8Ujw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: Fix a few typos in BPF helpers documentation
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Jakub Wilk <jwilk@jwilk.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 4:02 AM Quentin Monnet <quentin@isovalent.com> wrote:
> index 4fb685591035..0487ee06edef 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -79,7 +79,7 @@ struct bpf_insn {
>  /* Key of an a BPF_MAP_TYPE_LPM_TRIE entry */
>  struct bpf_lpm_trie_key {
>         __u32   prefixlen;      /* up to 32 for AF_INET, 128 for AF_INET6 */
> -       __u8    data[0];        /* Arbitrary size */
> +       __u8    data[]; /* Arbitrary size */

Sigh. Looks like you didn't even run the build of selftests.
Please see relevant commits in bpf tree.
