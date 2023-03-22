Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE696C5A58
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 00:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjCVXa3 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 19:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjCVXa2 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 19:30:28 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209C02D63
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:30:27 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w9so79637931edc.3
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679527825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HM0wWDWkoM4nz/M32R2UOx34nzAO01QLW6nOLEFeBxo=;
        b=dhDyJOQ+BaUg0FkCb7lNZOLUlW7QTdHhRAfH+G2qYwZrQS0xQhYF7iWhacAsrqpVY5
         jO3uOaoZ/uRYMLnEcj/JwEq1nhPCP6zp8VvrFQNAlSobHDnh2qc6Dsf6Uqvv/DHKucrx
         NMOXMJpBtjWzRB59TuBxDA8DAT9BF2y4qFIbKowrj+k8Utp5ykTikK6iHSep/mkPSYpB
         WT5eHRlrSXDx6UMSTCSgBM2KBoDFQkDKTnB9pRzVO/qSd5rMNFAXoVwdqGhEvzI4ctAz
         ftFH8CFrmqyU85b+sAJBN7JBT23DhzBd+V+iExszA6v2KF0OVlSfgqJ69Bu5O1FzRxMa
         IYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679527825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HM0wWDWkoM4nz/M32R2UOx34nzAO01QLW6nOLEFeBxo=;
        b=viz0mlUEEVoMdirdNzJZo24h6g9AXl20o3whYHtHj2/isI4OmKeExffGZR0sS0Wb4T
         eGCR/Q3X2Onsc5dWWHJkpiXDWoPeT8pXx0S/cWV2GBCeSEMOlhvlE+HlC6izC7qqSa8q
         BVCfXN3ZSWVZRE8uMIqaEy5OHhMwdvCtED58sr5TW/HToVvI2x0AYZsf9kOP/XK89EvT
         qWFhYsBihkwdO1bI6bKPzd/qo75U5ktV+V8SzoypSXU5KPEkB/ETF0w3IWIhwOxYGSzA
         8ZG64qU2VewhMo/fgLI4w/wWY9TAyZSBxOW/k52UqoMUHlEJwYsTqYzsv5QgItv658sQ
         wQuA==
X-Gm-Message-State: AO0yUKV2cKzkSEyOunPlwN5NCjUy094kdufWh2c+govIgdyuagjgdMs2
        glH4bBxpgcaojJENbV/d6ajfUtzvWzePW4lJXt8=
X-Google-Smtp-Source: AK7set/TfNuLak/VIfWrZI7ekSey8bmUgCTe9rr3yQIqVHNIMHfjU9QVvlPz/UltAzsbcm8AU4J8bO4YNy+eAeBOPR8=
X-Received: by 2002:a17:906:85c1:b0:931:fb3c:f88d with SMTP id
 i1-20020a17090685c100b00931fb3cf88dmr4382456ejy.5.1679527825495; Wed, 22 Mar
 2023 16:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230321232813.3376064-1-kuifeng@meta.com> <20230321232813.3376064-5-kuifeng@meta.com>
In-Reply-To: <20230321232813.3376064-5-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Mar 2023 16:30:13 -0700
Message-ID: <CAEf4BzawinCHggouRLMffXVGaePUsjxumvGU=FczDERKriw5jw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 4/8] libbpf: Create a bpf_link in bpf_map__attach_struct_ops().
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 4:28=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com> wro=
te:
>
> bpf_map__attach_struct_ops() was creating a dummy bpf_link as a
> placeholder, but now it is constructing an authentic one by calling
> bpf_link_create() if the map has the BPF_F_LINK flag.
>
> You can flag a struct_ops map with BPF_F_LINK by calling
> bpf_map__set_map_flags().
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---

LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/lib/bpf/libbpf.c | 95 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 71 insertions(+), 24 deletions(-)
>

[...]
