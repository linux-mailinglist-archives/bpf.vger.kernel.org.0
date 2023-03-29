Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43076CF13B
	for <lists+bpf@lfdr.de>; Wed, 29 Mar 2023 19:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjC2RhN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Mar 2023 13:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjC2RhM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Mar 2023 13:37:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26F740CF
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 10:37:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so66495669edc.3
        for <bpf@vger.kernel.org>; Wed, 29 Mar 2023 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680111430; x=1682703430;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1dV7OVak+xipmFWBgmFvqh5wraIL/xIMUgap2QSWB5Y=;
        b=IfhB4g9F0xV9DemxsoJTPIOrnb6dBx54PwF59uAZAh2XEAjbJ89PSzEktq1THws1lf
         kkq6StZyIG5L/IGyBfdpCOZifF4wCOZUb0ZcYl1H68B51fvBrxT2hq3XvT3Cz0vv54/q
         uXG23sFnP3gkOVv6g3hibjjortq4oi/3a9QvUxMDpFM3XO7O+JqLod6nAee/0W1IY7Vd
         3WvHenB+eNdtkIGwfqhF3SsYJ/SWtwkbCF06vCdTLrM+U1yZsgZeDfyOiXdV3uEgF0gl
         pe9Y3Im1zY1ASvrrBztOMTbydzjBSeaiXaP06uZZR6Ir2RhvC6CRQY1btiGdezehFusL
         Q0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680111430; x=1682703430;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1dV7OVak+xipmFWBgmFvqh5wraIL/xIMUgap2QSWB5Y=;
        b=Z0XvnzO9BF3kwgomwztyvQSGL709iTTKhGWcRSzPQ+ZZ0Db9c/BKFucG5mejpa6KF8
         szcys7/lBRGM6/hx45ZefTOa9113G/S0HCWtFm/6aNLfz791F99kMMjlaz4S0Q0M0T1R
         w6+emSqz2UL+x7weKl2+11sUbIVvHHDAJy4d3MslZ9fCUvKBTHwm5Ngs5qBGJoL5oVUq
         DUWX+ND0bifqKvLJoyp6Wrckxac+xndGa+GbDSk5ro1zKTtOHNB/6MLGW38PzMZicfjR
         9o6+bo6MVxmF0V5JkljufSBTilo6ffOM6Hpkquqyt8K8EacqvrsVP+7CPjc24OgKWY1r
         u4Xw==
X-Gm-Message-State: AAQBX9cX5bjAsilU5xyO4Ab5eiZZ/JCS7NedzazVcP2RZ3TC+PlnrI+E
        F2P/DrSFZzqFoC+Bnk37P4Y=
X-Google-Smtp-Source: AKy350a/UKbTZxmJKz8DlCtni8EmqElLAH94UsLDEikxy0hrJLtX3JQBkjDq5qCym6izrcQhrj3FqQ==
X-Received: by 2002:a17:906:94cc:b0:930:b130:b7b with SMTP id d12-20020a17090694cc00b00930b1300b7bmr21556858ejy.6.1680111430082;
        Wed, 29 Mar 2023 10:37:10 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id qn17-20020a170907211100b0093048a8bd31sm16717261ejb.68.2023.03.29.10.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 10:37:09 -0700 (PDT)
Message-ID: <4dfb40c14e1ad9fb2d7903236d0a19bb6b14f06e.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] veristat: add -d debug mode option to
 see debug libbpf log
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc:     kernel-team@meta.com
Date:   Wed, 29 Mar 2023 20:37:07 +0300
In-Reply-To: <20230327185202.1929145-3-andrii@kernel.org>
References: <20230327185202.1929145-1-andrii@kernel.org>
         <20230327185202.1929145-3-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2023-03-27 at 11:52 -0700, Andrii Nakryiko wrote:
> Add -d option to allow requesting libbpf debug logs from veristat.
>=20
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/testing/selftests/bpf/veristat.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selft=
ests/bpf/veristat.c
> index 83231456d3c5..263df32fbda8 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -135,6 +135,7 @@ static struct env {
>  	char **filenames;
>  	int filename_cnt;
>  	bool verbose;
> +	bool debug;
>  	bool quiet;
>  	int log_level;

Nitpick:
  it is now three booleans that control verbosity level, would it be
  better to use numerical level instead?

>  	enum resfmt out_fmt;
> @@ -169,7 +170,7 @@ static int libbpf_print_fn(enum libbpf_print_level le=
vel, const char *format, va
>  {
>  	if (!env.verbose)
>  		return 0;
> -	if (level =3D=3D LIBBPF_DEBUG /* && !env.verbose */)
> +	if (level =3D=3D LIBBPF_DEBUG  && !env.debug)
>  		return 0;
>  	return vfprintf(stderr, format, args);
>  }
> @@ -186,6 +187,7 @@ static const struct argp_option opts[] =3D {
>  	{ NULL, 'h', NULL, OPTION_HIDDEN, "Show the full help" },
>  	{ "verbose", 'v', NULL, 0, "Verbose mode" },
>  	{ "log-level", 'l', "LEVEL", 0, "Verifier log level (default 0 for norm=
al mode, 1 for verbose mode)" },
> +	{ "debug", 'd', NULL, 0, "Debug mode (turns on libbpf debug logging)" }=
,
>  	{ "quiet", 'q', NULL, 0, "Quiet mode" },
>  	{ "emit", 'e', "SPEC", 0, "Specify stats to be emitted" },
>  	{ "sort", 's', "SPEC", 0, "Specify sort order" },
> @@ -212,6 +214,10 @@ static error_t parse_arg(int key, char *arg, struct =
argp_state *state)
>  	case 'v':
>  		env.verbose =3D true;
>  		break;
> +	case 'd':
> +		env.debug =3D true;
> +		env.verbose =3D true;
> +		break;
>  	case 'q':
>  		env.quiet =3D true;
>  		break;

