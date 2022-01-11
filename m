Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA62548B39B
	for <lists+bpf@lfdr.de>; Tue, 11 Jan 2022 18:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241281AbiAKRTX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 11 Jan 2022 12:19:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344118AbiAKRS5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 11 Jan 2022 12:18:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D93CC061748
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 09:18:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 700FDB81C04
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 17:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE22C36AEB
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 17:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641921535;
        bh=M1PXH4TpNqgNmMhA1P1pyfs7aUoRrGGzhlW7iHGTyBI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dEt0Zb6I8DyUQ/2ZxiUGbUm8nkAN3mvkpa3j56wAsDhb1voKwKYnvsTRsoUGG1lhn
         SApnbO5PI6kz1QpyeLD5vek1nF3j66enYRC1QI4F3gMLQczW4LTwAPKzKD1B9PGVkD
         i5dp/0LrZAsknCZQ3uBuBPx3ZXQyswVx1kKMtzlyV82UcZcLKIpDTWJiwF0m9Xph4z
         m7HPqcTzPB4aWcifmZZSPXbV3ZGseyUcg/KENm+VMa6Trbdgn9753KCkXDFpiJCXO5
         jHyPcxrG3ImuwwZRfLslK3Ex7JtXIirqVSbZ1ygWo4RZCZc/7NyzV2ca9Qb981SIDp
         baag0KHnqfPSg==
Received: by mail-yb1-f169.google.com with SMTP id n68so3691852ybg.6
        for <bpf@vger.kernel.org>; Tue, 11 Jan 2022 09:18:55 -0800 (PST)
X-Gm-Message-State: AOAM533gIaADFUUDiKDd4YCF7gTPqeaUlJPOqhcs2qfH6C4dsJTlJk/a
        na2K6OAYXI0H0vSj0iYEn9ThQ0lbQePU7xMI8AY=
X-Google-Smtp-Source: ABdhPJxpUSLLWri5b9onExYzq1gtha/lIiqAaH7M9/DDO3378Z6pYgyBpXhTvgM/NVdUjXYVGbKDBP/HpU25oLZv9VA=
X-Received: by 2002:a25:287:: with SMTP id 129mr7374899ybc.670.1641921534364;
 Tue, 11 Jan 2022 09:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20220110143102.3466150-1-usama.arif@bytedance.com>
 <CAPhsuW58rPRsiKXmUNWa11ROzM5GpwbgAGxm80bgiOGPfmu0qg@mail.gmail.com> <8e512316-d99f-1e17-0132-39608afaffa2@bytedance.com>
In-Reply-To: <8e512316-d99f-1e17-0132-39608afaffa2@bytedance.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 11 Jan 2022 09:18:43 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4hMSmEEL7vF2h-7SCPEK4Hg4b0NRJaLONY0gKSFsKVGg@mail.gmail.com>
Message-ID: <CAPhsuW4hMSmEEL7vF2h-7SCPEK4Hg4b0NRJaLONY0gKSFsKVGg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf/scripts: add warning if the correct number of
 helpers are not auto-generated
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, joe@cilium.io,
        fam.zheng@bytedance.com, Cong Wang <cong.wang@bytedance.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jan 11, 2022 at 3:17 AM Usama Arif <usama.arif@bytedance.com> wrote:
>
>
>
> On 10/01/2022 22:43, Song Liu wrote:
> > On Mon, Jan 10, 2022 at 6:31 AM Usama Arif <usama.arif@bytedance.com> wrote:
> >>
> >> Currently bpf_helper_defs.h is auto-generated using function documentation
> >> present in bpf.h. If the documentation for the helper is missing
> >> or doesn't follow a specific format for e.g. if a function is documented
> >> as:
> >>   * long bpf_kallsyms_lookup_name( const char *name, int name_sz, int flags, u64 *res )
> >> instead of
> >>   * long bpf_kallsyms_lookup_name(const char *name, int name_sz, int flags, u64 *res)
> >> (notice the extra space at the start and end of function arguments)
> >> then that helper is not dumped in the auto-generated header and results in
> >> an invalid call during eBPF runtime, even if all the code specific to the
> >> helper is correct.
> >>
> >> This patch checks the number of functions documented within the header file
> >> with those present as part of #define __BPF_FUNC_MAPPER and generates a
> >> warning in the header file if they don't match. It is not needed with the
> >
> > Shall we fail instead of warning?
> >
>
> I am ok with either warning or error. The only thing with error is that
> it will cause the eBPF program to fail compilation even if its not using
> the helper with missing/misformatted doc, which i thought might be a bit
> extreme as the eBPF program will work if it doesnt use it.
> If error is recommended approach i can send v4 with #error replacing
> #warning.
>

Even the BPF program is not using the missing helper, it may still get wrong
helper ID. I think we should fail to compile in just cases.

[...]

> >> +                break
> >> +            self.line = self.reader.readline()
> >> +        # Find the number of occurences of FN(\w+)
> >> +        self.define_unique_helpers = re.findall('FN\(\w+\)', fn_defines_str)
> >
> > How about we only save nr_define_unique_helpers in self?
> >
>
> self.define_unique_helpers is used to give the first
> missing/misformatted helper to print in "#warning The description for %s
> is not present or formatted correctly" below.

I see. This is useful information, so let's keep it.

Thanks,
Song
