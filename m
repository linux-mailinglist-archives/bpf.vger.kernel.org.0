Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409F16B7AC9
	for <lists+bpf@lfdr.de>; Mon, 13 Mar 2023 15:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjCMOqn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Mar 2023 10:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjCMOqe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 Mar 2023 10:46:34 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C225CC0C
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 07:46:02 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h3so12860598lja.12
        for <bpf@vger.kernel.org>; Mon, 13 Mar 2023 07:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678718761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZU3eeU90JBi/3GIk6p29rW5k1M8hDub5drqnvYJ6QdQ=;
        b=cbBaf2qLv59ldJVok/VQBgk/MF97JmbPeTG+HugmmhyW0Og1/jIce904z69ZugC/Fa
         73hiNsVR1Evxk88mpLttfdrwyX3OEQlwFVfO/F7alWxa3FpPJxRrFJkJnAjYLEfv+JHM
         fop7pjPQYni3D+2INjYoBR/A/4ignMggCjqml22UTcDMIgkszUjLv8Pzuk3JH4UBd0e2
         uzCH/BrBqb5V4LT5tyU0i+sMROMH7Tv6eAJpjoQs1q/xwYH9OkhD3rH+ktX0WP6TYuPg
         gJaANHr1BNr8W0kZfIrTAlDalc7dwrcE+i8i1ZigpUQWeJK53u9dNt7HhaizBg564esf
         cmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678718761;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZU3eeU90JBi/3GIk6p29rW5k1M8hDub5drqnvYJ6QdQ=;
        b=1wvTsEOKuCMQlQ8aCOmPU8rYH/DKd7ddQmwsnzYmu4EtAAMdy5Lj0nU1z70mESPJke
         j6Lp49N9Sm35YlBLdTxTgBrE+kwY5NwdTxkOcz6niX9BLRLxwpM5a7ylMvqPto3C/XpK
         qfKf/B1TCjYy/XPgomJtDQWkQ9JWUXLk0qwxJpuGXlf7D11XZ27CDK1P7ijITzVDTgiz
         qKBKgwWkeZLaQd1Q4Q735wvO7aA8souII+tiwM8hsZlEGLJ6OyRh8DwHO0rh3P+XRhh1
         u3/8XnZPFawPaeYDBJIFf72PHJaKNVIUWpIOAGZFjieivztwBuIX20CVlZ4abfmI6ivO
         0Uhg==
X-Gm-Message-State: AO0yUKUZ7rSltD8DidF2ZBb41e0GT4jTMqtvk4wwlif9gIAFAsWHfgr1
        25/TbtmBs6YVcsIllCbrn1g=
X-Google-Smtp-Source: AK7set9pATtzCeI7W36un+hcMUsDjWioqpH+C7R3/Z7wPeH1bUjpw3f9rKxV0t88qyhAb0BSbjFmdg==
X-Received: by 2002:a2e:b53a:0:b0:294:5a6c:5221 with SMTP id z26-20020a2eb53a000000b002945a6c5221mr3007542ljm.19.1678718760800;
        Mon, 13 Mar 2023 07:46:00 -0700 (PDT)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id v19-20020a2e87d3000000b002959b1162f0sm7573ljj.96.2023.03.13.07.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 07:45:59 -0700 (PDT)
Message-ID: <87964239858beb2fe8e2d625953a3606161c85b3.camel@gmail.com>
Subject: Re: [PATCH dwarves 2/3] dwarves_fprintf: support skipping modifier
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Alan Maguire <alan.maguire@oracle.com>, acme@kernel.org
Cc:     ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        haoluo@google.com, jolsa@kernel.org, john.fastabend@gmail.com,
        kpsingh@chromium.org, sinquersw@gmail.com, martin.lau@kernel.org,
        songliubraving@fb.com, sdf@google.com, timo@incline.eu, yhs@fb.com,
        bpf@vger.kernel.org
Date:   Mon, 13 Mar 2023 16:45:57 +0200
In-Reply-To: <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
References: <1678459850-16140-1-git-send-email-alan.maguire@oracle.com>
         <1678459850-16140-3-git-send-email-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-03-10 at 14:50 +0000, Alan Maguire wrote:
[...]
> diff --git a/dwarves_fprintf.c b/dwarves_fprintf.c
> index 5c6bf9c..b20a473 100644
> --- a/dwarves_fprintf.c
> +++ b/dwarves_fprintf.c
> @@ -506,7 +506,8 @@ static const char *tag__ptr_name(const struct tag *ta=
g, const struct cu *cu,
>  				struct tag *next_type =3D cu__type(cu, type->type);
> =20
>  				if (next_type && tag__is_pointer(next_type)) {
> -					const_pointer =3D "const ";
> +					if (!conf->skip_emitting_modifier)
> +						const_pointer =3D "const ";
>  					type =3D next_type;
>  				}
>  			}
> @@ -580,13 +581,16 @@ static const char *__tag__name(const struct tag *ta=
g, const struct cu *cu,
>  				   *type_str =3D __tag__name(type, cu, tmpbf,
>  							   sizeof(tmpbf),
>  							   pconf);
> -			switch (tag->tag) {
> -			case DW_TAG_volatile_type: prefix =3D "volatile "; break;
> -			case DW_TAG_const_type:    prefix =3D "const ";	 break;
> -			case DW_TAG_restrict_type: suffix =3D " restrict"; break;
> -			case DW_TAG_atomic_type:   prefix =3D "_Atomic ";  break;
> +			if (!conf->skip_emitting_modifier) {
> +				switch (tag->tag) {
> +				case DW_TAG_volatile_type: prefix =3D "volatile "; break;
> +				case DW_TAG_const_type: prefix =3D "const"; break;

Here the space is removed from literal "const " and this results in
the following output (`pahole -F btf --sort ./vmlinux`):

    struct ZSTD_inBuffer_s {
            constvoid  *               src;                  /*     0     8=
 */
            ...
    };

(Sorry for late replies).

[...]

