Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1B6A418E
	for <lists+bpf@lfdr.de>; Mon, 27 Feb 2023 13:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjB0MSH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Feb 2023 07:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjB0MSH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Feb 2023 07:18:07 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332C7B458
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:18:05 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id cp12so2634852pfb.5
        for <bpf@vger.kernel.org>; Mon, 27 Feb 2023 04:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O3Wbk4PyzeJv8vEVqhgTB6nRT41+PZyv3EpdVvZLss=;
        b=kLBr+8AAjfUN+W39IHft0s19JEo3QXQvA4IJHevtsTRa6ZWK6ueOUV11+5pyKRXV0Z
         87V1gl2zCTQjCKRVo6peImHHVA0SnxHk8FBWi4FMPsK0IlmBTUT6WARMogA3vTBxDV+y
         e4gD477Z/23mreZ44MJtExd040W89lvvtvqn79KApu/reuqUz4cYnb+onBTUxdlDsesO
         mCo2T4HnwBIVcsKdgZpfKqXP53Y5dUUDNb/HcnGRiMY85y7D3Y+HQQ9B+AwW8o7N/xmQ
         3+OQwcI8Bkn8lvDN3/9VJyaooFFguSDsDIJj0a0Bp9PBJtuY7oHMo+RusdQv4VsRvCvl
         MD/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O3Wbk4PyzeJv8vEVqhgTB6nRT41+PZyv3EpdVvZLss=;
        b=PgNoPs8kCI03CEWOKc7oYjwrenAHXM5vmWJelLnH5CysTYjUsqBXJHEn6b+W/cTHEq
         yUJUMVudA+wwakxSCejUIF26kwpXy/FGB+zMsGconjjqUq9pVehO0fO8LrU4toYCRls6
         s5KElOye/5VNxwgjhddMUH9ffXQQ9t3bXYE1iDFGATo1bgce+y/DMsbf+LpLuDPygs/g
         dLzVj4GMTIrE5sb1jV3xh6ce4v6tO+O6qSpT0q+AvPJVLrIuNvJrxVfoSgBbc1SrK+yZ
         VRcVhOxSW+vw6uPm5WO8D2BRoo4uVW3mi8BcZvV/u4NU8/pbTQAvkk9CYpk8nr32X68W
         yM+w==
X-Gm-Message-State: AO0yUKVGY6TFEoSwFbaq0ZclV0LX2gxrGj0nk1vujgFR5K45UXTVAaxM
        r0Rqkz/TQZhSNRKwzYzuD2HEJ1reICiO6wxfPOrfKA==
X-Google-Smtp-Source: AK7set8wIvfOUTxpgUk1eqPvVSg2OskvjVdzsJ3NgROYebIQXNVp3jUycVc1FS2zPrMjnKbVJwVF3adhec31up6OZDw=
X-Received: by 2002:a62:864d:0:b0:5e5:7376:ea4d with SMTP id
 x74-20020a62864d000000b005e57376ea4dmr3475333pfd.1.1677500284525; Mon, 27 Feb
 2023 04:18:04 -0800 (PST)
MIME-Version: 1.0
References: <20230222161222.11879-1-jiaxun.yang@flygoat.com>
 <20230222161222.11879-2-jiaxun.yang@flygoat.com> <CAM1=_QQRmTaAnn0w6wteQ_FKgoF=vGX_okfbiUHdyUB0ZzNghQ@mail.gmail.com>
 <7CAF04EF-FC1D-4BE1-A639-92D677525C63@flygoat.com>
In-Reply-To: <7CAF04EF-FC1D-4BE1-A639-92D677525C63@flygoat.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Mon, 27 Feb 2023 13:17:53 +0100
Message-ID: <CAM1=_QRVEG0Fw9U99V3ohMe60h0DwMzyWvV_gYdJ=SrQ1D11Fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: ebpf jit: Implement DADDI workarounds
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "paulburton@kernel.org" <paulburton@kernel.org>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Feb 23, 2023 at 11:29=E2=80=AFAM Jiaxun Yang <jiaxun.yang@flygoat.c=
om> wrote:
> I didn=E2=80=99t see any place emitting DADDI.

Right, the JIT only uses unsigned arithmetics :)

> Yes I analysed all other place, most of them are just calculating memory
> address offsets and they should never overflow. Other two is doing additi=
on
> to zero to load immediate, which should be still fine.

Ok.

> >> --- a/arch/mips/net/bpf_jit_comp.c
> >> +++ b/arch/mips/net/bpf_jit_comp.c
> >> @@ -218,9 +218,17 @@ bool valid_alu_i(u8 op, s32 imm)
> >>                /* All legal eBPF values are valid */
> >>                return true;
> >>        case BPF_ADD:
> >> +#ifdef CONFIG_64BIT
> >
> > DADDI/DADDIU are only available on 64-bit CPUs, so the errata would
> > only be applicable to that. No need for the CONFIG_64BIT conditional.
>
> It=E2=80=99s possible to compile a 32bit kernel for R4000 with CONFIG_CPU=
_DADDI_WORKAROUNDS
> enabled.

Yes, but DADDI/DADDIU are 64-bit instructions so they would not be
available when compiling the kernel in 32-bit mode for R4000, and
hence the workaround would not be applicable, right? If this is
correct, I would imagine CONFIG_CPU_DADDI_WORKAROUNDS itself to be
conditional on CONFIG_64BIT. That way the this relationship is
expressed once in the Kconfig file, instead of being spread out over
multiple places in the code.
