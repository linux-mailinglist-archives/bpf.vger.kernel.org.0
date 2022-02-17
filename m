Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950CE4BAC38
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 23:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244249AbiBQWDm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 17:03:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbiBQWDl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 17:03:41 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A79403FC
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 14:03:27 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id y20so5431291iod.1
        for <bpf@vger.kernel.org>; Thu, 17 Feb 2022 14:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dfs7F5uuqV8nuUKMpDlcbNSX1IC+uxOsrVgIn5/OmMw=;
        b=Ye9Ntav2H6JXAp5Jjajb5ZbgwlHhggPgrcaOQ+4j2k3bFJ9TXwB0CREsl6p59UTHGu
         v3IdeRWGJKZcAAGOstmQ1fTkehXSuz3dG62MX0GjmaDNdBNWPGCnmOZd58vuKvbyzBRQ
         FRISyOED5eF8Wk8/E89ANFMQ59khXj1vuSuobMnNWUsB3X+YI5ooPp96UQ7yGga/BYcz
         QneLbhIbN6gc4/thV3TC1AJFUxwzng9dKgbZNUxiBeBLZ+RaKz9W/JtV+wz0Tju4+HiZ
         KnVUHRRPfa/M+VchwJq65V6ym6WgNDzTz61bxszil/Ka8Ul2HodJXKXyj1xgaGFfFyQb
         xXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dfs7F5uuqV8nuUKMpDlcbNSX1IC+uxOsrVgIn5/OmMw=;
        b=2X2+TxLDBuKn/DD9sPIS1hBWVsPrVhrsRCfEvLvdHpreYqkWd7gjAFtyokMQxe1agO
         Wq4cDgbRCIgSnHzAVmCd5NizHjF0RShyODHqtLBNVeEgFZIXD1wFX+oAj3GoamSv+Vvv
         5Pz8lLYQCye4H3Z/OiVNXzUn3OyWs0Bfe0OIgc84tvKhLirn+vdJs7gfN5eLRmjZ/sND
         W+nkRlwK+/mvi83Pulh+C3iU3/taj/RynEdfM7TuoyodZ09SCN5ESEqGSHsDFCQCNc/g
         La9hKiiJBVbCfywF7B2pI1v17uMfxT9k4ZiQkjsuzbBG6xZcwdXH4yDiz6055qqTRhWW
         zRgg==
X-Gm-Message-State: AOAM532MrP/gZ/pdrzBlAUhyXxJ99YLS7smE5ZbQ7mg24kN6hl0+D7fo
        8l7DhUjdF6NnFtIP5jj7kPJOElByYV6+K76IC10=
X-Google-Smtp-Source: ABdhPJx41KxZVOLsbWonWOxniu7qajDWswkVlKNopZjkX6zBRhj/vuWbE1VIcQemEgAq76amC/5u8u0r4rQYBS42tpQ=
X-Received: by 2002:a6b:7a45:0:b0:638:ce15:2045 with SMTP id
 k5-20020a6b7a45000000b00638ce152045mr3281175iop.79.1645135406461; Thu, 17 Feb
 2022 14:03:26 -0800 (PST)
MIME-Version: 1.0
References: <CH2PR21MB143007E8EFAA83E15F5B1572FA359@CH2PR21MB1430.namprd21.prod.outlook.com>
In-Reply-To: <CH2PR21MB143007E8EFAA83E15F5B1572FA359@CH2PR21MB1430.namprd21.prod.outlook.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Feb 2022 14:03:15 -0800
Message-ID: <CAEf4BzYP6NxyFOvNs_STfAO9qZ=z3UkXcEmFGEDGK3+rfJf97g@mail.gmail.com>
Subject: Re: libbpf API to extract bpf_line_info from a ELF file?
To:     Alan Jowett <Alan.Jowett@microsoft.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Feb 16, 2022 at 8:59 AM Alan Jowett <Alan.Jowett@microsoft.com> wro=
te:
>
> Libbpf folks,
>
> Is there already an API or are there plans to add a supported API to extr=
act bpf_line_info from an ELF file?

No, there is currently not. And as you saw, few APIs that were exposed
are deprecated. It is a good idea to let users work with BTF.ext more
directly, we need to carefully design the API to make it both
user-friendly, efficient, and extensible.

>
> The closest I can find is:
> LIBBPF_API LIBBPF_DEPRECATED("btf_ext__reloc_line_info was never meant as=
 a public API and has wrong assumptions embedded in it; it will be removed =
in the future libbpf versions")
> int btf_ext__reloc_line_info(const struct btf *btf,
>                  const struct btf_ext *btf_ext,
>                  const char *sec_name, __u32 insns_cnt,
>                  void **line_info, __u32 *cnt);
>
> But this is marked as deprecated.
>
> Use case:
> Prevail ebpf-verifier emits "pretty printed" BPF instructions in various =
use cases (verification failure, dump of assembly, and others). I was plann=
ing on augmenting it so that it would also emit the file/line number to mak=
e debugging verifier failures easier for developers.
>
> I ended up writing my own code to extract bpf_line_info from a .BTF and .=
BTF.ext sections, but ideally, I would want to use the parser in libbpf.
>
> Regards,
> Alan Jowett
