Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DBD6A4FB2
	for <lists+bpf@lfdr.de>; Tue, 28 Feb 2023 00:36:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjB0XgI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 18:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjB0XgI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 18:36:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E8924105
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 15:36:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id h16so32680504edz.10
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 15:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gFx4hRqwQFOw+JMMt+JnP5adqugyBWbYEArkSzeHROk=;
        b=AVQPwfPby688NEMS8FZfWlinlH0HlT6r3+SDg8o6Qr2bVvDAgAhXctm+Ef/C3IB/SG
         H8SbE387OHAMhPgDpjjOet2Um/x3ylaDPX/PdSsoB1LQrtN91Ugs//wIZM0Wb4INjzhk
         V8WtRmvnC0LGprdmvPn3cCWqhGUvQKCdowHC4QYeviAwo3io3V/5SwDa1cKx6TIeNUUl
         A1iyZkugUFRPqfYEXSlLi8X2OFDilcTHkuDuqtrDWKTO2qjuiZ1xx84eZoexrgkfGZkM
         Xnh5uQ6viPBqz2GI4NkwmxKoMEnKlEW3761hm2gTSBX+0cZoolftfNOH5Dhod5xH4HkC
         0dfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gFx4hRqwQFOw+JMMt+JnP5adqugyBWbYEArkSzeHROk=;
        b=OO4MfEKMvPVRPmcWXhnq3JLLcFaRe57/dVncX1IbNXOhh9tCrO53qA3Pqhww2bQUo/
         UeXlfh0o16EqkFunSDqYNuuK0tiliFMioDtFN4QClYJLJMgG34ZmLOBS65Fvomoo7FnO
         wY7QxF6OKi9+XBfOCziZb9lC2K5rZWAXq5vV/akAfPu4Y5I7uNpoK6AGPVh9WFGHVknX
         heXi4/dNYcCvyMAkDQmXD62FQ1NoYX3JvC3HpUkDjTMqz9OxQ47sF7BaUyuzcpLCsUaB
         vcCNeCzAxyp0WKpy0chjqVpFd8o8g3X4p8WtyLTmftXWVmwSKJEKiHy4IMq+2V2UwCQE
         R/bQ==
X-Gm-Message-State: AO0yUKUdv7g2tBcFLhNshStPqui/f1rJKiKJKkjcoJPBf2EXRP12a/8f
        d5kGWB/o2Q0wcnC6qOXSdS4aJHTLoH3B+Oq8fsk=
X-Google-Smtp-Source: AK7set+G6V8phVeJ2Tur78D16XFtaDCRsPB1AslcbHtjzWyQR7lFhWM3/7rHLpTwtEZJ3gotPPuAyv7ODgx9VpoadB4=
X-Received: by 2002:a17:906:4bc4:b0:8b0:fbd5:2145 with SMTP id
 x4-20020a1709064bc400b008b0fbd52145mr214783ejv.15.1677540965477; Mon, 27 Feb
 2023 15:36:05 -0800 (PST)
MIME-Version: 1.0
References: <20230227224943.1153459-1-yhs@fb.com>
In-Reply-To: <20230227224943.1153459-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 27 Feb 2023 15:35:53 -0800
Message-ID: <CAEf4Bzaqqzxo7fMNxrYXf5VgLVqSR3cOGkM6KF=hTNqcc1DTBw@mail.gmail.com>
Subject: Re: [PATCH bpf] libbpf: Fix bpf_xdp_query() in old kernels
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 27, 2023 at 2:50=E2=80=AFPM Yonghong Song <yhs@fb.com> wrote:
>
> Commit 04d58f1b26a4("libbpf: add API to get XDP/XSK supported features")
> added feature_flags to struct bpf_xdp_query_opts. If a user uses
> bpf_xdp_query_opts with feature_flags member, the bpf_xdp_query()
> will check whether 'netdev' family exists or not in the kernel.
> If it does not exist, the bpf_xdp_query() will return -ENOENT.
>
> But 'netdev' family does not exist in old kernels as it is
> introduced in the same patch set as Commit 04d58f1b26a4.
> So old kernel with newer libbpf won't work properly with
> bpf_xdp_query() api call.
>
> To fix this issue, if the return value of
> libbpf_netlink_resolve_genl_family_id() is -ENOENT, bpf_xdp_query()
> will just return 0, skipping the rest of xdp feature query.
> This preserves backward compatibility.
>
> Fixes: 04d58f1b26a4 ("libbpf: add API to get XDP/XSK supported features")
> Cc: Lorenzo Bianconi <lorenzo@kernel.org>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/netlink.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
> index 1653e7a8b0a1..4c1b3502f88d 100644
> --- a/tools/lib/bpf/netlink.c
> +++ b/tools/lib/bpf/netlink.c
> @@ -468,8 +468,11 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct=
 bpf_xdp_query_opts *opts)
>                 return 0;
>
>         err =3D libbpf_netlink_resolve_genl_family_id("netdev", sizeof("n=
etdev"), &id);
> -       if (err < 0)
> +       if (err < 0) {
> +               if (err =3D=3D -ENOENT)
> +                       return 0;
>                 return libbpf_err(err);
> +       }
>

As I mentioned in another thread, I'm a bit worried of this early
return, because query_opts might be extended and then we'll forget
about this early return. So I did these changes and pushed to
bpf-next:

diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 4c1b3502f88d..84dd5fa14905 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -469,8 +469,10 @@ int bpf_xdp_query(int ifindex, int xdp_flags,
struct bpf_xdp_query_opts *opts)

        err =3D libbpf_netlink_resolve_genl_family_id("netdev",
sizeof("netdev"), &id);
        if (err < 0) {
-               if (err =3D=3D -ENOENT)
-                       return 0;
+               if (err =3D=3D -ENOENT) {
+                       opts->feature_flags =3D 0;
+                       goto skip_feature_flags;
+               }
                return libbpf_err(err);
        }

@@ -492,6 +494,7 @@ int bpf_xdp_query(int ifindex, int xdp_flags,
struct bpf_xdp_query_opts *opts)

        opts->feature_flags =3D md.flags;

+skip_feature_flags:
        return 0;
 }

>         memset(&req, 0, sizeof(req));
>         req.nh.nlmsg_len =3D NLMSG_LENGTH(GENL_HDRLEN);
> --
> 2.30.2
>
