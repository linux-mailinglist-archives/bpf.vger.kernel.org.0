Return-Path: <bpf+bounces-4722-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293C374E5A7
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 06:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625531C20CEA
	for <lists+bpf@lfdr.de>; Tue, 11 Jul 2023 04:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39B34436;
	Tue, 11 Jul 2023 04:02:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FE33C28;
	Tue, 11 Jul 2023 04:02:26 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0D1E42;
	Mon, 10 Jul 2023 21:02:19 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f4b2bc1565so8175071e87.2;
        Mon, 10 Jul 2023 21:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689048138; x=1691640138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/bqIvBWP0Vc31nnjqB0//tzgjYO0px2TJafgW9vm5w=;
        b=GkRcWJs+DiK6fWtziTeO4u3Kbwd4mWCi2N1c+O4kMrH32zvAnoRzj5kxG6UwA1Qlay
         +mo8pMsgNY0yazf1c4MQvSK+7xx9oq4PdBNasVssCtAsHvNeQVoV2CJi1M6K2Bf5hNDR
         swwsnOblY9bwy4DbwyanYzd9MUtQsNcGq1A6iSCLgNGp2mQUVwoS2/N7EyYpTc+BEd+7
         h6aMfbQYZ8mcsUW4QnXBE8Ph4zjbYRPqi/LVIIFsqocOlSAWb+wmsfUaCLeRJpYHm7Uo
         WytWftqbvIZ09xMSFwAJ/wLTD0oJExUlSU3fCaCKzoDAEHlEXFxJUMO75nmzUPiJZJP8
         6ebQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689048138; x=1691640138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/bqIvBWP0Vc31nnjqB0//tzgjYO0px2TJafgW9vm5w=;
        b=CMZTbx0LSFWLpL+knfiVU8Oi/Ge+dFqGINiCUSnomXFI3tQ6cEkvjYGQsVP1o1CitT
         L2EKvF1Q2tvbvQkbsC9PlwZIBUyg4H8Ppi/uOOTu+Y6JWDAPkE+GVSNA7Je5TREhVTuI
         tZGzfwKYAiDmKZiyhTSOA7az2l4MT0ffTYwoe5Z79CyVB+2TbIjbl9078NqUZzFp4Qj/
         e1RNc1kWccVjxPhe0T6MKzYKVmvsqz2tsrGKxiStDPZxP6GeLDMu3SjBfn2R4ht2Hqz+
         H8wDEYGwmisOr+3h99O/c+SoXPAPaV08HcUC5SMUqf9WF5/UP+HkOhay2hpRMP/AJ5aP
         lyBQ==
X-Gm-Message-State: ABy/qLZzVShUOjqWFru+X4e6lWFPmWmfqRsYsAf8Gbk8hZQjgK6XKwAQ
	oj3c79ag0sgfnbYyqS+APckmVqQWBETalyOy8YA=
X-Google-Smtp-Source: APBJJlFe4nkrNFIrhStPNzTSn/NrxTnQnj4Q8af+lJNpHH4V3pQvF3BXg1txpWkpf5bbscZsUyo3fhPn8HKjTeLwtzk=
X-Received: by 2002:a05:6512:5ce:b0:4f9:5ca5:f1a6 with SMTP id
 o14-20020a05651205ce00b004f95ca5f1a6mr11293431lfo.17.1689048137493; Mon, 10
 Jul 2023 21:02:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230710201218.19460-1-daniel@iogearbox.net> <20230710201218.19460-6-daniel@iogearbox.net>
In-Reply-To: <20230710201218.19460-6-daniel@iogearbox.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Jul 2023 21:02:05 -0700
Message-ID: <CAEf4BzYBCHp6x_4mwjduHidJDfQ94-p2gnGSS+V3oAtqg9xsMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 5/8] libbpf: Add helper macro to clear opts structs
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	razor@blackwall.org, sdf@google.com, john.fastabend@gmail.com, 
	kuba@kernel.org, dxu@dxuuu.xyz, joe@cilium.io, toke@kernel.org, 
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Jul 10, 2023 at 1:12=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Add a small and generic LIBBPF_OPTS_CLEAR() helper macros which clears
> an opts structure and reinitializes its .sz member to place the structure
> size. I found this very useful when developing selftests, but it is also
> generic enough as a macro next to the existing LIBBPF_OPTS() which hides
> the .sz initialization, too.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/lib/bpf/libbpf_common.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf_common.h b/tools/lib/bpf/libbpf_common.=
h
> index 9a7937f339df..eb180023aa97 100644
> --- a/tools/lib/bpf/libbpf_common.h
> +++ b/tools/lib/bpf/libbpf_common.h
> @@ -70,4 +70,15 @@
>                 };                                                       =
   \
>         })
>
> +/* Helper macro to clear a libbpf options struct
> + *
> + * Small helper macro to reset all fields and to reinitialize the common
> + * structure size member.
> + */
> +#define LIBBPF_OPTS_CLEAR(NAME)                                         =
           \
> +       do {                                                             =
   \
> +               memset(&NAME, 0, sizeof(NAME));                          =
   \
> +               NAME.sz =3D sizeof(NAME);                                =
     \
> +       } while (0)
> +

This is fine, but I think you can go a half-step further and have
something even more universal and useful. Something like this:


#define LIBBPF_OPTS_RESET(NAME, ...)
    do {
        memset(&NAME, 0, sizeof(NAME));
        NAME =3D (typeof(NAME)) {
            .sz =3D sizeof(struct TYPE),
            __VA_ARGS__
        };
     while (0);

I actually haven't tried if that typeof() trick works, but I hope it does :=
)


Then your LIBBPF_OPTS_CLEAR() is just LIBBPF_OPTS_RESET(x). But you
can also re-initialize:

LIBBPF_OPTS_RESET(x, .flags =3D 123, .prog_fd =3D 456);

It's more in line with LIBBPF_OPTS() itself in capabilities, except it
works on existing variable.


>  #endif /* __LIBBPF_LIBBPF_COMMON_H */
> --
> 2.34.1
>

