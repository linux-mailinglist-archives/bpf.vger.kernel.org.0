Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0409C5754B0
	for <lists+bpf@lfdr.de>; Thu, 14 Jul 2022 20:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240455AbiGNSLb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 14:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240239AbiGNSLb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 14:11:31 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DDFDE1
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 11:11:30 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id m16so3431658edb.11
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=an4sw7TWu7op9cZTbyb5OmGvtawD/XacfSbmfNvod8s=;
        b=ji1rrVoPWkoLxzEx2i/wY0IFsTZU+zAQxraBlOXSEOfa3Gd8E3zXqxxcusMHpFu2i8
         xgsN9UGh6HZ+L0W9bgXzCRXhjAry/ArGcoY6wvMOFxGu7xL++SMCjUYpw/HoYhRq0U8N
         vYQ3d8Bvk2VwZhpRgTt9gxtAENkLTmXJ8caOfhbQoixvLbT8H6HMe1tzhKQvvjxqPVj2
         VeLum0i4lOkDmp8d4Oly7SRGpO+ktGYdkW1qCsdCUszzAQ4DSnQcste3j0ZNCTM9h+kW
         ZF9O+y01lGryPuFL4gtaQ4giI3QfctYGUoE7kBk9g/r/ql438bWCPvOInnNC66OpPpcH
         C8wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=an4sw7TWu7op9cZTbyb5OmGvtawD/XacfSbmfNvod8s=;
        b=YINheOKeezer+b0n6+rTNROVhBg52isgzY+cr7r6mpXCJL9yw8sedS8g9uy/7LslOC
         5d2pKZyxsfTlap6zmRDgBcYpC9ErzVTz8TiFvBiNtV/+NdobRWCEOtbur9FM7QjaE984
         eroOhRbPBvro5pVTqfx7CPVefb8jwqJ7mVM0viIcv+LTmg3c3SpjMfxxy5kJGqXukuWv
         sVVzrySb5POmsYjH9YPvx6UwF3ofMYs45MnS1asmXH/rSJLF0ogMWEmb1Syl4QRLiAkI
         Pu1xKqK20QoR/DpxsuIwPbhSDLepeSOMLUeFyMthwAHuYqyG3RkvhUFWqRD3Mv5L0PmN
         sB/g==
X-Gm-Message-State: AJIora91GW7qGydO2MYrHqXSe3HHFKLVwsk7R3zK77JdaeLM1ZfHbXLL
        o1tt12Jo2FsB2Dd/9dSngRdvq47z0TlGzxkAzEk=
X-Google-Smtp-Source: AGRyM1vjiK0HRv706SjukcvaMXRoCE4IBbSthfoARy8qjgGN1xcgdiq+iLnABRiCz9JaSbj905oK1WcHdz21qbnOFSo=
X-Received: by 2002:a05:6402:1c01:b0:43a:f714:bcbe with SMTP id
 ck1-20020a0564021c0100b0043af714bcbemr14231771edb.14.1657822288816; Thu, 14
 Jul 2022 11:11:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220714171220.1108229-1-indu.bhagat@oracle.com>
In-Reply-To: <20220714171220.1108229-1-indu.bhagat@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 14 Jul 2022 11:11:17 -0700
Message-ID: <CAEf4BzbP3sDZgMc67XaNgVjm8RSvwQKJsjKoYv2Wsi6fdeao5A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] docs/bpf: Update documentation for BTF_KIND_FUNC
To:     Indu Bhagat <indu.bhagat@oracle.com>
Cc:     bpf <bpf@vger.kernel.org>, Yonghong Song <yhs@fb.com>
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

On Thu, Jul 14, 2022 at 10:12 AM Indu Bhagat <indu.bhagat@oracle.com> wrote:
>
> The vlen bits in the BTF type of kind BTF_KIND_FUNC are used to convey the
> linkage information for functions. The Linux kernel only supports
> linkage values of static (=0), and global (=1) at this time.
>
> Signed-off-by: Indu Bhagat <indu.bhagat@oracle.com>
> ---
>  Documentation/bpf/btf.rst | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index f49aeef62d0c..3f9cc9150c89 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -369,7 +369,7 @@ No additional type data follow ``btf_type``.
>    * ``name_off``: offset to a valid C identifier
>    * ``info.kind_flag``: 0
>    * ``info.kind``: BTF_KIND_FUNC
> -  * ``info.vlen``: 0
> +  * ``info.vlen``: linkage information (static=0, global=1, extern=2)

0, 1, 2 are not arbitrary integers, those are enum btf_func_linkage,
which is why I asked to mention that UAPI enum here

>    * ``type``: a BTF_KIND_FUNC_PROTO type
>
>  No additional type data follow ``btf_type``.
> @@ -380,6 +380,9 @@ type. The BTF_KIND_FUNC may in turn be referenced by a func_info in the
>  :ref:`BTF_Ext_Section` (ELF) or in the arguments to :ref:`BPF_Prog_Load`
>  (ABI).
>
> +Currently, only linkage values of static and global are supported in the
> +kernel.
> +
>  2.2.13 BTF_KIND_FUNC_PROTO
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> --
> 2.31.1
>
