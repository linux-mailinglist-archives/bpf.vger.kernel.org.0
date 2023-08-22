Return-Path: <bpf+bounces-8277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B27847C9
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 18:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450B11C20B9A
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FAE2B547;
	Tue, 22 Aug 2023 16:35:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B39B2B543
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 16:35:10 +0000 (UTC)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7240D196
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 09:35:04 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9338e4695so73096541fa.2
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692722102; x=1693326902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkXP95R+6qTP8NiPFfijVAsdteuXJQZdWBI624NnB5Y=;
        b=lldNQWjM5Uc60J3WiznPoXlAiaFi7p5djOVBSKGNKnPz4j+Wr71vG1fLYaLTyrg007
         s2N1gqG5ImuDf2T1Mday8JmprKsrsqlGAHQwtDyiBMEbcpuSaOgYV028H18JdCUXw7z+
         55A/iymy0zIhQGqI87RNmZ4YUE8LGZrV/R4YA2Gsw1dkuV56H/6h8DyLHTCLtJERqb+W
         jlp+bKpXyPA7lib1sRuC42goxt5+sIU2ReJrkNzcAOxFP4mZSE+ZMXPbkahB7DXRxSwV
         nHCA4AWFrIvT6v913TOaHJm4UOP/tzrygxqn10tMOAVwW1KqWnJ8wb/2YCrDdulwA3aE
         mgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692722102; x=1693326902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dkXP95R+6qTP8NiPFfijVAsdteuXJQZdWBI624NnB5Y=;
        b=F/eZP+UiVEH2MqHFk90nsk9uSzOKB7tgEVbHVDGLDxHBiUWq8kTXXR8z9PZoFW1243
         7NPO3QX1jYm6dkrmMsTRzup9XQomp2WqgAgkML4ayvt6mCcrECydxlrWAK9/iiALIrNz
         vmnvesrcDw+Tu4OM0x5GZqbAArd36ykkEdfdXWSKm46iB8glDgwIIhPPTMenY+FRYv3t
         nwdOn3N7Tz7kkoRmu+2S397EscLkSW83KpfIODLV7+20tpMUpYFIgJa9dlLYnL24OOJZ
         fSYdbm0uwvWcE37VjeKuvM1bm1oI35Pk9usElYmUySTWJQX/YDaFWSvBjh1cz3RxRmow
         3www==
X-Gm-Message-State: AOJu0YxUq3ZaMn0QHn5UIL/acdQbyQ3770JvsngvaFRsxlYb3sXrgw/A
	YBfrmPhOHwNDqdQAVtr/6bgnG3opk9FeTGGZMKE=
X-Google-Smtp-Source: AGHT+IFJMWtjew3fmQcLTbXrazxNnxaPob3DtcjLZEO/ijWSn7gbLW/Sz7Rtm6R8fB/Ku5SwQMdwTQPhoqtfye3ftCQ=
X-Received: by 2002:a2e:8891:0:b0:2b9:f3b4:6808 with SMTP id
 k17-20020a2e8891000000b002b9f3b46808mr7983269lji.29.1692722102241; Tue, 22
 Aug 2023 09:35:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230809114116.3216687-1-memxor@gmail.com> <20230809114116.3216687-13-memxor@gmail.com>
In-Reply-To: <20230809114116.3216687-13-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 22 Aug 2023 09:34:51 -0700
Message-ID: <CAADnVQJoNM7iNfhCesw0gygYtOsW-iS1AbRythfX5ent1BAtwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 12/14] libbpf: Add support for custom
 exception callbacks
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 9, 2023 at 4:44=E2=80=AFAM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> Add support to libbpf to append exception callbacks when loading a
> program. The exception callback is found by discovering the declaration
> tag 'exception_callback:<value>' and finding the callback in the value
> of the tag.

...

> +       /* After adding all programs, now pair them with their exception
> +        * callbacks if specified.
> +        */
> +       if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
> +               goto out;
> +out:

The above looks odd. Accidental leftover?

>         return 0;
>  }
>
> @@ -3137,6 +3148,80 @@ static int bpf_object__sanitize_and_load_btf(struc=
t bpf_object *obj)
>                 }
>         }
>
> +       if (!kernel_supports(obj, FEAT_BTF_DECL_TAG))
> +               goto skip_exception_cb;
> +       for (i =3D 0; i < obj->nr_programs; i++) {
> +               struct bpf_program *prog =3D &obj->programs[i];
> +               int j, k, n;
> +
> +               if (prog_is_subprog(obj, prog))
> +                       continue;
> +               n =3D btf__type_cnt(obj->btf);
> +               for (j =3D 1; j < n; j++) {
> +                       const char *str =3D "exception_callback:", *name;

On the first read of this patch and corresponding kernel support
I started doubting my earlier suggestion to use decl_tag and
reconsidered going back to fake bpf_register_except_cb() call,
but after sleeping on it I think it is a useful extension for both
kernel and libbpf to support such tagging.
We might specify ctors and dtors with decl_tag in the future
and other various callbacks that are never explicitly referenced
in bpf_call, ld_imm64 or other bpf insns.
So having libbpf and kernel support such tagging will help in the long run.
It's not going to be limited to exceptions.
Despite the extra complexity this is a good step forward.

> +static int
> +bpf_object__append_subprog_code(struct bpf_object *obj, struct bpf_progr=
am *main_prog,
> +                               struct bpf_program *subprog)
> +{

Please split this refactoring into a separate patch for ease of review.

