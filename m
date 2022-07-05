Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9275664D5
	for <lists+bpf@lfdr.de>; Tue,  5 Jul 2022 10:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiGEIGs (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 5 Jul 2022 04:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiGEIGr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Jul 2022 04:06:47 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC1413D79
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 01:06:47 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id j7so14136009ybj.10
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anyfinetworks-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B5hHTZX8k5YVulOX+y/19eWncPyMjQTiLI6tApiZDhk=;
        b=6xDWK7ASvF7LjwW66OAkx87Ojwg+fadmN0koItgcLHqGOjPw8f75wIPFtzRL0dV6Pn
         dEFtfO1lpIgYkSsgTCymRalfhlZtXMVUV8XL3c9UxGsn8sMcPA5JtYgALIRneKs0R0L3
         ezAY0ulXmzTudrHn3aKXJVmMJhJe3GgBbCu87pCTKzyh9aUw8OLlWM1dTkiZ3AE5vtiv
         yk77klYv5KlnH4oMyDUOvueT+77ccW0fIotr+aCEfdtzmIIXkmXfGC25HfZHuW1QzDIw
         cEHKhpo+X1LYqvJD9jzcQsBQA2z+6qqxukuU9qR6k2+uyLh38efAtlx/VONHW9cOOROy
         M+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B5hHTZX8k5YVulOX+y/19eWncPyMjQTiLI6tApiZDhk=;
        b=qxUbgr44JScfxx8/SMMfOtZ+iN45AAd1dcfAS+jXnbS17y10d6Rjfl/f5zl+P648/9
         lNv/B6a60n2INoCLTx3sxlpziDGDxcU6Er5hXtyfZW8JwOhk9dO7eeoHSnj88QEKKmIT
         wFMYvOuYA7eakJWP9HlaHhbHWD1hnI2WUnhJxiay1Qts9NQy4JoWZx6GpSU04mqtNssC
         EvN87eAYgu74meFb6wK6iObiaHKkCp1b+IbRPE5Iwio6Uy20sR5BJFCJHkxmjSZ1Z5h6
         ewM1Xbgtv2R0bY3h6WoF+QfvFtob0pKJHrhG9qMGtxc+/VhrhaYn3/kNuw06IVB3E0zb
         jEbg==
X-Gm-Message-State: AJIora+aeCw/4ZX/6tbslvMobrDy7eGBRCBRpeGYjjUXo7US9+ELwK1W
        27T40jH3RWN5kp4e6bhrdIZHSEEAL7DB7RkHcGdo+w==
X-Google-Smtp-Source: AGRyM1tcBgz1IY9sqZnh2yDyhQ83q5nmqLhSg283Gb5KHGXE7yZ5JxF303ch2a50yZtGJkGhsxL+FbW1h5rlQMrHMhU=
X-Received: by 2002:a25:fe01:0:b0:66e:3653:d533 with SMTP id
 k1-20020a25fe01000000b0066e3653d533mr12986032ybe.445.1657008406289; Tue, 05
 Jul 2022 01:06:46 -0700 (PDT)
MIME-Version: 1.0
References: <CANoWsw=eP+kYHvT+AUwY=8D=QDrwHz=1_6he8vz0t+Tc1PVVBQ@mail.gmail.com>
 <6e86e8c4-4eaf-3e4e-ee72-035a215b48d3@iogearbox.net> <xunyr135ytxr.fsf@redhat.com>
 <CANoWswmar9ELFGiqNeG7SCuaciaoNWEq2E+YaRq5J4fwRqfuZg@mail.gmail.com>
In-Reply-To: <CANoWswmar9ELFGiqNeG7SCuaciaoNWEq2E+YaRq5J4fwRqfuZg@mail.gmail.com>
From:   Johan Almbladh <johan.almbladh@anyfinetworks.com>
Date:   Tue, 5 Jul 2022 10:07:47 +0200
Message-ID: <CAM1=_QTEAA4vzVHJV3-fcLOGqAcef8q6U7bg5LbH-CKehuQLxw@mail.gmail.com>
Subject: Re: test_kmod.sh fails with constant blinding
To:     Yauheni Kaliuta <ykaliuta@redhat.com>
Cc:     bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Jul 4, 2022 at 10:22 AM Yauheni Kaliuta <ykaliuta@redhat.com> wrote:
>
> Hi!
>
> On Fri, Jul 1, 2022 at 2:05 PM Yauheni Kaliuta <ykaliuta@redhat.com> wrote:
> > >>>>> On Thu, 30 Jun 2022 22:57:37 +0200, Daniel Borkmann  wrote:
> >
> >  > On 6/30/22 3:19 PM, Yauheni Kaliuta wrote:
> >  >> Hi!
> >  >> test_kmod.sh fails for hardened 2 check with
> >  >> test_bpf: #964 Staggered jumps: JMP_JA FAIL to select_runtime
> >  >> err=-524
> >  >> (-ERANGE during constant blinding)
> >  >> Did I miss something?
> >
> >  > That could be expected if one of bpf_adj_delta_to_imm() / bpf_adj_delta_to_off()
> >  > fails given the targets go out of range.
> >
> > I believe that, but how to fix the test? It should not fail.
> >
> >  > How do the generated insn look?
> >
> > The instruction when it fails is
> >
> > (gdb) p/x insn[0]
> > $8 = {code = 0xb7, dst_reg = 0x0, src_reg = 0x0, off = 0x0, imm = 0x2aaa}
> >
> > And it's rewritten as
> >
> > (gdb) p rewritten
> > $9 = 3
> > (gdb) p/x insn_buff[0]
> > $10 = {code = 0xb7, dst_reg = 0xb, src_reg = 0x0, off = 0x0, imm = 0x68ad0283}
> > (gdb) p/x insn_buff[1]
> > $11 = {code = 0xa7, dst_reg = 0xb, src_reg = 0x0, off = 0x0, imm = 0x68ad2829}
> > (gdb) p/x insn_buff[2]
> > $12 = {code = 0xbf, dst_reg = 0x0, src_reg = 0xb, off = 0x0, imm = 0x0}
> >
> > IIUC.
> >
>
> Johan, what do you think?

Hmm, I can take a look at it. What is the target arch?

Johan
