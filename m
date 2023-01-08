Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F9D66615EB
	for <lists+bpf@lfdr.de>; Sun,  8 Jan 2023 15:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbjAHOwR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 8 Jan 2023 09:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233340AbjAHOwM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 8 Jan 2023 09:52:12 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 773CCB1E8;
        Sun,  8 Jan 2023 06:52:02 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4c186ff0506so82943757b3.6;
        Sun, 08 Jan 2023 06:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzwAFW7zinORJzeaGrXO5tj6nkM04VHWKq1dvM6y2Ck=;
        b=mEByeNFhewTstoNVG4o1nkBJFJweaMmghaVfDHDNWFgUhV2A2+WJX9LXeNR7XTAgkw
         eHcpLCPN9Ct3aZBVL+ewht7tXCNbdjMrur7cud+9/fTa+Y0+kxvnil4umvyGC76mPBZN
         c5uUXWxK+hr6F4WXV7yKS0Ta8y44QOzBo9N0mTwLBBnRCJ3nudSvAJvkNPj3AtzWjTMI
         PGTABma5nHqOmjvTJrvBlJfNgcIW6t54VqUz0V3LKs9n5a1pMLEtMrC/K1RXi+OYDbHZ
         /CJwL/chiDO97VWJ2+8nlg5BzAe2NW9H5/uHGW9/ekosNtw8UjIcJ8cMhCLaJHSp/0Kp
         EOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzwAFW7zinORJzeaGrXO5tj6nkM04VHWKq1dvM6y2Ck=;
        b=gwvllWryppG1IV76s4twI1WYq+e5yo4jSdJKP8T603pSM/jwyIVVbRdS2mi7AfuJtw
         sgfqLUfZZgtaiERwDDTWPgZ+8C71QfFO/pHcxW8BzRQ72nSWy143mEJZTJfcEsBl5pQW
         K+ty1ouLemYmu5xdY/OXL0P1pPh1HSunFRRtue87PPnKkVkP3MLwNKhoaWH9qyopsZMR
         gTLKPsgXl9zHqD54XsODzHSUlmj+IReRX8qlIbYFsn+hlR4mrGJmmtH787ZaKPX2dkLo
         6O/z8EHX/7N9Y2c0F8kPFbKduBtKoU1x4rUU6a9HvA5SSRopD9tB2oqgLB8s7ygp7S1I
         a11A==
X-Gm-Message-State: AFqh2kppnJTkQNDliUDI4Gqpq+YTIRMM7zQKiC251yWDXpB/2BKy/UJZ
        lfLbdsEzWprgPEhAdVfuGFyOYT2V3nhzdUHFySL8QVY3GjcRmS/JygyO9A==
X-Google-Smtp-Source: AMrXdXstbU5Vui6U0z8u53S6DTcoIvasZztwpkkfMXpWNLgjYjzJD7fuBuulyZRifq61QZOO609kyUfPLHDrVA9nk9s=
X-Received: by 2002:a0d:ea54:0:b0:483:813:c70f with SMTP id
 t81-20020a0dea54000000b004830813c70fmr5710975ywe.266.1673189521770; Sun, 08
 Jan 2023 06:52:01 -0800 (PST)
MIME-Version: 1.0
References: <20230108021450.120791-1-yakoyoku@gmail.com>
In-Reply-To: <20230108021450.120791-1-yakoyoku@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 8 Jan 2023 15:51:50 +0100
Message-ID: <CANiq72m_pKc9WKEg8XJtqdqJP746YGkZcrWm=nytBOLcXwfiNg@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: Exclude Rust CUs with pahole
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Eric Curtin <ecurtin@redhat.com>, Neal Gompa <neal@gompa.dev>,
        bpf@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 8, 2023 at 3:14 AM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Version 1.24 of pahole has the capability to exclude compilation units

It would be nice to have a reference ("...of pahole [1][2]") to the
commits that introduced it in `pahole` -- especially the second one
below has a nice commit message about the use case for this patch:

    Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=49358dfe2aaae4e90b072332c3e324019826783f
[1]
    Link: https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?id=8ee363790b7437283c53090a85a9fec2f0b0fbc4
[2]

> (CUs) of specific languages. Rust, as of writing, is not currently
> supported by pahole and if it's used with a build that has BTF debugging
> enabled it results in malformed kernel and module binaries (see
> Rust-for-Linux/linux#735). So it's better for pahole to exclude Rust

I think this came from a rendered link from GitHub, so please
transform it into a link since otherwise people may be confused where
to find it:

    Link: https://github.com/Rust-for-Linux/linux/issues/735 [3]

> Reviewed-by: Eric Curtin <ecurtin@redhat.com>
> Tested-by: Eric Curtin <ecurtin@redhat.com>
> Reviewed-by: Neal Gompa <neal@gompa.dev>
> Tested-by: Neal Gompa <neal@gompa.dev>

Given the patch has had non-trivial changes (in fact, in this case, it
fundamentally changed the implementation), these tags should be
removed and requested again.

Thanks for this!

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
