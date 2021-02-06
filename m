Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28119311D39
	for <lists+bpf@lfdr.de>; Sat,  6 Feb 2021 13:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbhBFMzF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 6 Feb 2021 07:55:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbhBFMzD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 6 Feb 2021 07:55:03 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6647FC06174A;
        Sat,  6 Feb 2021 04:54:21 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id x21so10109927iog.10;
        Sat, 06 Feb 2021 04:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=pHZf8IJw7vfwU1AqUSW8aNLmUrq94t6dEUlTjXrhvzM=;
        b=AdCQa+8hBaGCpXRkbGGBmfbwHQSf8oXUkjlxYohnrD4bFFgQlvAVrNbsC0xFrk4wFB
         qaiO4UNApxFcaRJlAInuOxu7KVhR9JZMa2xSXrIVoej+OXaPrdeXTh6XQqsOAOU0o9YY
         e7aK9CAnUDX09JVl4KN3goZpUA7UCkbs056SRQpqMwftzcBZobhaCrfJaxDBcJjpRyI2
         d8s5RvDTiBZNbFWwdoSQj6SVkQMMujXiiRETLMVfsShSwkey5Xy0BCY+zz+njlj8pBWe
         4f10lmJT0QoRbxNcowtGmBGLcBe85JsmI6E2n4yvgG9PHlIpVM3soXkn23sCW9VzB81k
         9rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=pHZf8IJw7vfwU1AqUSW8aNLmUrq94t6dEUlTjXrhvzM=;
        b=AgGwN1M1NMG95U6TCXfuEccJmEvuOAUt7UX4EHBBzKGCii4PMA5DPK24wJQ9a9Zn8H
         XXaeco/oifvFzzTiBBdFlNeKTEtaWIAKbo1Gu0QpMpqge0ypRnnimbj1aTR7iGKCTsKq
         +r5Qtp+YeVEn+YjExkjZe7vpagpjw2kpgHqjEUCeAGZY8SxrE3HYjgbVb3XIO/KSPQDt
         2fnIVG3O6w9e4SG3urcmXQ/JIoqGVH6uLb6Y8yCwTX9nVVXgOj/WdHwDw1+5pOwESRvA
         JuLTrOHynQZ21vG2iZQpSpWc/jLs1kxPZ70cthmj/w5fSAqEUQWxA7oHWTTV5B+2GWll
         ZWdA==
X-Gm-Message-State: AOAM532gbEB0QJoe5hbcy+9LtmWnsNW913LbBnBQ9/skGhYEpWMod0EC
        28NDut7o8mY4bNaeBbFZt44hZDMQvTwuXI8UCfw=
X-Google-Smtp-Source: ABdhPJyQ3APJcttJvD4p976eWFyWkOKanpILSg0Na+usLCGpMOgP8ugflqRKnSL9Q8T5nrIFiuaVJkclvp2XxRr7Yo0=
X-Received: by 2002:a05:6638:3795:: with SMTP id w21mr9446593jal.65.1612616060773;
 Sat, 06 Feb 2021 04:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20210204220741.GA920417@kernel.org> <CA+icZUVyB3qaqq3pwOyJY_F4V6KU9hdF=AJM_D7iEW4QK4Eo6w@mail.gmail.com>
 <20210205152823.GD920417@kernel.org> <CA+icZUWzMdhuHDkcKMHAd39iMEijk65v2ADcz0=FdODr38sJ4w@mail.gmail.com>
 <CA+icZUXb1j-DrjvFEeeOGuR_pKmD_7_RusxpGQy+Pyhaoa==gA@mail.gmail.com>
 <CA+icZUVZA97V5C3kORqeSiaxRbfGbmzEaxgYf9RUMko4F76=7w@mail.gmail.com>
 <baa7c017-b2cf-b2cd-fbe8-2e021642f2e3@fb.com> <20210205192446.GH920417@kernel.org>
 <cb743ab8-9a66-a311-ed18-ecabf0947440@fb.com> <CA+icZUUcjJASPN8NVgWNp+2h=WO-PT4Su3-yHZpynNHCrHEb-w@mail.gmail.com>
 <d59c2a53-976c-c304-f208-67110bdd728a@fb.com> <CA+icZUVhgnJ9j7dnXxLQi3DcmLrqpZgcAo2wmHJ_OxSQyS6DQg@mail.gmail.com>
 <CA+icZUWFx47jWJsV6tyoS5f18joPLyE8TOeeyVgsk65k9sP2WQ@mail.gmail.com>
 <CA+icZUUj1P_PAj=E8iF=C4m6gYm9zqb+WWbOdoTqemTeGnZbww@mail.gmail.com>
 <CA+icZUWY0zkOb36gxMOuT5-m=vC5_e815gkSEyM45sO+jgcCZg@mail.gmail.com>
 <CA+icZUW+4=WUexA3-qwXSdEY2L4DOhF1pQfw9=Bf2invYF1J2Q@mail.gmail.com>
 <8ff11fa8-46cd-5f20-b988-20e65e122507@fb.com> <CA+icZUVwM9VY5huMpbMtGL-rs16JYvBM2MDiebx6taptH3m-Jg@mail.gmail.com>
 <CA+icZUU=qnLmZWsjeU2G=R0sTkx9+6qtG6Cni1xit=-p_vG_Pw@mail.gmail.com>
 <CA+icZUUSTXqACW=0d9k4fC2y8TJEDjQ7WWwnnSR7KxsmC-SJhw@mail.gmail.com>
 <CA+icZUUOS03BgOoSFdUWP8G61b2wjhAx0bUGNstqS7OTm3+7iQ@mail.gmail.com>
 <CA+icZUUjy5cR5cq6PqSA0+KDsovqAx-zH9CozH8TpETu9jYYPw@mail.gmail.com> <CA+icZUW2HVWSZiOHvrjXGP-ubL_iWEHy1u6B3zQn=pN-J1FnSQ@mail.gmail.com>
In-Reply-To: <CA+icZUW2HVWSZiOHvrjXGP-ubL_iWEHy1u6B3zQn=pN-J1FnSQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 13:54:09 +0100
Message-ID: <CA+icZUU6dY-jtZWOJC5Fi2BRGK4jZt_o1JnGH3nmGseUJH4uNg@mail.gmail.com>
Subject: Re: ERROR: INT DW_ATE_unsigned_1 Error emitting BTF type
To:     Yonghong Song <yhs@fb.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Jan Engelhardt <jengelh@inai.de>,
        Domenico Andreoli <cavok@debian.org>,
        Matthias Schwarzott <zzam@gentoo.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Mark Wieelard <mjw@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Tom Stellard <tstellar@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Some post-mortem:

LLVM_DWARF_BIN="/opt/llvm-toolchain/bin/llvm-dwarfdump"

module="drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.ko"

Module has DW_ATE_unsigned_160 and DW_ATE_unsigned_1:

$LLVM_DWARF_BIN $module | grep DW_AT_name | grep DW_ATE_ | sort -u
               DW_AT_name      ("DW_ATE_signed_32")
               DW_AT_name      ("DW_ATE_signed_64")
               DW_AT_name      ("DW_ATE_unsigned_1")
               DW_AT_name      ("DW_ATE_unsigned_128")
               DW_AT_name      ("DW_ATE_unsigned_16")
               DW_AT_name      ("DW_ATE_unsigned_160")
               DW_AT_name      ("DW_ATE_unsigned_32")
               DW_AT_name      ("DW_ATE_unsigned_64")

vmlinux has only DW_ATE_unsigned_1:

$ $LLVM_DWARF_BIN vmlinux | grep DW_AT_name | grep DW_ATE_ | sort -u
               DW_AT_name      ("DW_ATE_signed_1")
               DW_AT_name      ("DW_ATE_signed_16")
               DW_AT_name      ("DW_ATE_signed_32")
               DW_AT_name      ("DW_ATE_signed_64")
               DW_AT_name      ("DW_ATE_signed_8")
               DW_AT_name      ("DW_ATE_unsigned_1")
               DW_AT_name      ("DW_ATE_unsigned_128")
               DW_AT_name      ("DW_ATE_unsigned_16")
               DW_AT_name      ("DW_ATE_unsigned_24")
               DW_AT_name      ("DW_ATE_unsigned_32")
               DW_AT_name      ("DW_ATE_unsigned_40")
               DW_AT_name      ("DW_ATE_unsigned_64")
               DW_AT_name      ("DW_ATE_unsigned_8")

- Sedat -
