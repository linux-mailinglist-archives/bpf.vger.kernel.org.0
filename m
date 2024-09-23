Return-Path: <bpf+bounces-40205-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B419797EC7B
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 15:41:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704EB281E4B
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 13:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15321199E88;
	Mon, 23 Sep 2024 13:41:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722EA38394;
	Mon, 23 Sep 2024 13:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727098904; cv=none; b=rPdD3obTmVcyy7oYhZ+tFingYqh5VZ9iw3iIWmWi0d1Q5FVPHozZ1wKYYqeqio3FjsVUDXjIhca9O34XAUoyUhe6SrvEPSHCQ7Qd1suN5RjdkFScyOGkrfolAU3C1vNrgPLmnMCxVlkqUPt6l3rns0LGSsTJO6Ri70nb0MFwZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727098904; c=relaxed/simple;
	bh=hsxv2s0aP4r3lxntQOdM0DgLVU7283pZh+orvWKbXoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzqztbqNPUA4eHOsiwB+G+r6X/jmj+1pgitPqg6uX7V9WD+1E0bMCboF+//ltgynYUeGfa79Z+VhrBgrbsWD5hutOeXhOME9o9e1QL2i/PKusUOvoZLHwtyBt2bYEF9VkJEvs9Dh9FwA1HG9UQi/cLtTedDfO0blOMdYcsGTBn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6dffe3fe4fcso20018957b3.1;
        Mon, 23 Sep 2024 06:41:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727098901; x=1727703701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t1Nb87hNB3zzIbZ7p6JsVdiw/rvLzl7jE2mKiDh11Ss=;
        b=cPncJKBeIEi92osID8qicn52NpCCjk5O2wyPc4PPGNmjV/zRT7WtHRau1GSVPgrsqD
         +YE6WDcrpNFfOgbdyhtre5cZ9nwBJE0SbIwkkwvDVw/r8ngQTVm6CqifP5fSl69AuEuH
         zuy4GxIT6m8yPz1puXlnbnAIt9+goAyXVHKgex8cGfE74cNCDMarDzrApb3RJqHVxaqa
         pg2SOois21lYOt1ZrbJGV+WKklqY7HclqwaF6UnchH5mKojULbVseNrHyn8j4hgBP+AU
         uTLLMWHST+mnFm3abxhm3uszRKXGF3CMei0Ha4DAWICs9kp0y7L6vZdM6HG+o4TzogDu
         d8jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUGGEB2d/R3J1384oFa+vpK3jj/O+Ezvx/HzbI06QIXAtB4o/KFZBE98wyCR7TIXagjMg=@vger.kernel.org, AJvYcCVQPcfX4MZaSiOUf9u45B2jLwWjRGX6CqpxAkKNRopPyts6ii/ezXXinUYt3NDeKB2jFncE0xsexL75xli/@vger.kernel.org, AJvYcCVvx64HEQ4AAZB3/d5dyczIsPhiaCdrgJZexAPLu8c5xHPtoUAb+d0N+RT00eIUEQI1eJ0NQCXt@vger.kernel.org, AJvYcCWpH87WWRU58iw1NUKWSQ3clEOc1Fz8R+EbNy0GRFpCd2pG2CusoO1zsgLXBWdcfAX3OHpIXGtS8ZxDwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIgZ/q5E9lc3Y623b8eGpYZJvYurJMrKFddOFSARzoHykJSDPM
	1Qry6rb6sLV/QBhW6XzQflGtckQFqO4U11f8GeNEJOA2YZw6S0pTDz0e4S/g
X-Google-Smtp-Source: AGHT+IEp1tOQad9OBsRlt3qcuhXq4am6XPqR3aO2VhPUjzwA7mT8FDgYo1wkrQ73zneRvZMTntdyOw==
X-Received: by 2002:a05:690c:6612:b0:62c:c684:b1e1 with SMTP id 00721157ae682-6dfeeeeb549mr89065737b3.29.1727098901027;
        Mon, 23 Sep 2024 06:41:41 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6dbe2f0759asm34603967b3.131.2024.09.23.06.41.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 06:41:40 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e00f47f70eso11568657b3.0;
        Mon, 23 Sep 2024 06:41:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViIVIrs6YPpgNkjENoW1fPQ0tDdyupyBgo75So/gc7bduCUumGQSoyyU4AhYE8SP4Dz6k=@vger.kernel.org, AJvYcCWPFF9tZR/1S8lAha5Ky99xyRrCpKUdC+9c2WtEItKKU5/rZ0ueBw3BQKiBchwBI+QPpsdtyY2v@vger.kernel.org, AJvYcCWQ6il4IJyGnImudLNnCpHOuDM7AfJHezot6GSYUsxsQ2HZa/Mm8VJh+5vMFCiaaR2XSWrx1VRuX2+PQNBT@vger.kernel.org, AJvYcCWsNGBszvr3aUa3K+cb49ZKR1SkCExGMrJyud6Yua2gMOG9C+bqrtVwDT1ETteYUx9yrURtkXjv53zFPg==@vger.kernel.org
X-Received: by 2002:a05:690c:6a03:b0:6d3:be51:6d03 with SMTP id
 00721157ae682-6dfeed8e97fmr94972827b3.23.1727098900023; Mon, 23 Sep 2024
 06:41:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240910-am65-cpsw-multi-rx-v4-0-077fa6403043@kernel.org> <20240910-am65-cpsw-multi-rx-v4-3-077fa6403043@kernel.org>
In-Reply-To: <20240910-am65-cpsw-multi-rx-v4-3-077fa6403043@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 23 Sep 2024 15:41:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUf-tKRDzkz2_m8qdFTFutefddU0NTratVrEjRTzA3yQQ@mail.gmail.com>
Message-ID: <CAMuHMdUf-tKRDzkz2_m8qdFTFutefddU0NTratVrEjRTzA3yQQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 3/6] net: ethernet: ti: cpsw_ale: use
 regfields for number of Entries and Policers
To: Roger Quadros <rogerq@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Julien Panis <jpanis@baylibre.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Joe Damato <jdamato@fastly.com>, srk@ti.com, 
	vigneshr@ti.com, danishanwar@ti.com, pekka Varis <p-varis@ti.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-omap@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roger,

On Tue, Sep 10, 2024 at 11:25=E2=80=AFAM Roger Quadros <rogerq@kernel.org> =
wrote:
> Use regfields for number of ALE Entries and Policers.
>
> The variants that support Policers/Classifiers have the number
> of policers encoded in the ALE_STATUS register.
>
> Use that and show the number of Policers in the ALE info message.
>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> Reviewed-by: Simon Horman <horms@kernel.org>
> ---
> Changelog:
> v4:
> - reverse Xmas tree declaration order fixes

Thanks for your patch, which is now commit 11cbcfeaa79e5c76 ("net:
ethernet: ti: cpsw_ale: use regfields for number of Entries
and Policers").

This is causing the following warning on BeagleBone Black:

    WARNING: CPU: 0 PID: 34 at drivers/base/regmap/regmap.c:1208
devm_regmap_field_alloc+0xac/0xc8
    invalid empty mask defined
    CPU: 0 UID: 0 PID: 34 Comm: kworker/u4:3 Not tainted
6.11.0-rc7-boneblack-01443-g11cbcfeaa79e #152
    Hardware name: Generic AM33XX (Flattened Device Tree)
    Workqueue: events_unbound deferred_probe_work_func
    Call trace:
     unwind_backtrace from show_stack+0x10/0x14
     show_stack from dump_stack_lvl+0x68/0x88
     dump_stack_lvl from __warn+0x6c/0x1a8
     __warn from warn_slowpath_fmt+0x1bc/0x1d0
     warn_slowpath_fmt from devm_regmap_field_alloc+0xac/0xc8
     devm_regmap_field_alloc from cpsw_ale_create+0x10c/0x36c
     cpsw_ale_create from cpsw_init_common+0x1fc/0x310

> --- a/drivers/net/ethernet/ti/cpsw_ale.c
> +++ b/drivers/net/ethernet/ti/cpsw_ale.c
> @@ -1303,6 +1303,9 @@ static const struct reg_field ale_fields_cpsw_nu[] =
=3D {
>         /* CPSW_ALE_IDVER_REG */
>         [MINOR_VER]     =3D REG_FIELD(ALE_IDVER, 0, 7),
>         [MAJOR_VER]     =3D REG_FIELD(ALE_IDVER, 8, 10),
> +       /* CPSW_ALE_STATUS_REG */
> +       [ALE_ENTRIES]   =3D REG_FIELD(ALE_STATUS, 0, 7),
> +       [ALE_POLICERS]  =3D REG_FIELD(ALE_STATUS, 8, 15),

You are adding these entries only to ale_fields_cpsw_nu[], not
to ale_fields_cpsw[], while cpsw_ale_regfield_init() loops over
ALE_FIELDS_MAX entries, whether they are valid or not:

    static int cpsw_ale_regfield_init(struct cpsw_ale *ale)
    {
            const struct reg_field *reg_fields =3D ale->params.reg_fields;
            struct device *dev =3D ale->params.dev;
            struct regmap *regmap =3D ale->regmap;
            int i;

            for (i =3D 0; i < ALE_FIELDS_MAX; i++) {
                    ale->fields[i] =3D devm_regmap_field_alloc(dev, regmap,
                                                             reg_fields[i])=
;

                    [...]
            }

            return 0;
    }

I tried fixing this by skipping entries where all of .reg, .lsb,
and .msb are zero, but that doesn't work as that runs beyond the
end of ale_fields_cpsw[], thus operating on random data.
I think you do have to store the size of the array, instead of assuming
ALE_FIELDS_MAX entries everywhere.

> --- a/drivers/net/ethernet/ti/cpsw_ale.h
> +++ b/drivers/net/ethernet/ti/cpsw_ale.h
> @@ -33,6 +34,8 @@ struct regmap;
>  enum ale_fields {
>         MINOR_VER,
>         MAJOR_VER,
> +       ALE_ENTRIES,
> +       ALE_POLICERS,
>         /* terminator */
>         ALE_FIELDS_MAX,
>  };
>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

