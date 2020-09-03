Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEAE25C666
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 18:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgICQOF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Sep 2020 12:14:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47582 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728382AbgICQOE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Sep 2020 12:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599149642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jGAdLQjW6FOgPUxVRaWqQKhLck137J1XrjmXbaXLEGs=;
        b=ZSFR5kIuA0XcCDVtB7mq6FweKwRTfwwsZSvKc17vf/IKW7qH4N7Op+HY8ZeQON1DGHinfz
        WoUlxj6TIrta8ukk6RXFz3EdnPKeHWNFgPidttmitBJHC2JY5Rfyi3StSy2BxWaqvs6M64
        7YOOya7nMcDVsvsTLcoMEu129c3BDbo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-SHiZPytwMT-4NqTexGqdAQ-1; Thu, 03 Sep 2020 12:14:01 -0400
X-MC-Unique: SHiZPytwMT-4NqTexGqdAQ-1
Received: by mail-wm1-f72.google.com with SMTP id b14so1135948wmj.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2020 09:14:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jGAdLQjW6FOgPUxVRaWqQKhLck137J1XrjmXbaXLEGs=;
        b=q6gs27bgJJ4cEjltpauONc630VknIyp/siY9G9lGAmqcj1YAnA3qW/trmFlU1xAIB3
         trVR3C1MifB82iENqdK7R5nIq2z16E1B3Ed8Xl+8pyu1G5rPARpghWQbgrnO93lpTt6u
         5fdWv8Joi8oe6npYZbwhaX+lLHvcWbgCedvXehs5R8SRHo4n+Cg4BGxwt7bTC3JCFIVk
         oXEbO9PHv6v7DkcYliN/W71Hnn4OVEad6Dhne2FLuD8gcoAb4+qv8R+2uG9gAS4kS/0B
         kad4Q6KJRpFbhiwsAnKpRJmoChgSU4F9gY1lgWpH3zKj1TFeo776nd7jvfbNcMHexbzZ
         a/Rw==
X-Gm-Message-State: AOAM531qUCfjwWHoyhTpfGsawFwBRqfxAySmTki4VnhItFGYsy36mv6n
        7FIAeqUdF0tX1x6v/UVhsClEhkMxTSYVVSakJnhGxO2XSUTzDBtlUascbSjZIQheRt6r9a/ToV7
        Vf9PW5bYqyxWjFniGbqqRA97UCkfN
X-Received: by 2002:a1c:81c6:: with SMTP id c189mr3214601wmd.124.1599149638449;
        Thu, 03 Sep 2020 09:13:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLwTnbAUeQXyhFBLpRUejXDvyRQT+2BW9XLl9ZJyMFL4lBJRcRGudz6RCa84ST8ZVblJASyWqVMaUkQJdFqIc=
X-Received: by 2002:a1c:81c6:: with SMTP id c189mr3214574wmd.124.1599149638164;
 Thu, 03 Sep 2020 09:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200903140542.156624-1-yauheni.kaliuta@redhat.com> <1ac6aef1-b38c-06c7-6e0d-b8459207d7d9@iogearbox.net>
In-Reply-To: <1ac6aef1-b38c-06c7-6e0d-b8459207d7d9@iogearbox.net>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Thu, 3 Sep 2020 19:13:41 +0300
Message-ID: <CANoWswkX9xrG48HHO19Q67ogmNcOArpe4iZwWU4_S08A7H+_Cg@mail.gmail.com>
Subject: Re: [PATCH RFC] bpf: update current instruction on patching
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     bpf <bpf@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Sep 3, 2020 at 6:10 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 9/3/20 4:05 PM, Yauheni Kaliuta wrote:
> > On code patching it may require to update branch destinations if the
> > code size changed. bpf_adj_delta_to_imm/off increments offset only
> > if the patched area is after the branch instruction. But it's
> > possible, that the patched area itself is a branch instruction and
> > requires destination update.
>
> Could you provide a concrete example and walk us through? I'm probably
> missing something but if the patchlet contains a branch instruction, then
> it should be 'self-contained'. In the sense that the patchlet is a 'black
> box' that replaces 1 insns with n insns but there is no awareness what's
> inside these insns and hence no fixup for that inside bpf_patch_insn_data().

The code is
Disassembly of section classifier/test:

0000000000000000 test_cls:
       0:       85 01 00 00 ff ff ff ff call -1
                0000000000000000:  R_BPF_64_32  f7
       1:       95 00 00 00 00 00 00 00 exit
0000000000000000 f1:
       0:       61 01 00 00 00 00 00 00 r0 = *(u32 *)(r1 + 0)
       1:       95 00 00 00 00 00 00 00 exit
[...]
00000000000000a8 f7:
      21:       85 01 00 00 ff ff ff ff call -1
                00000000000000a8:  R_BPF_64_32  f6
      22:       95 00 00 00 00 00 00 00 exit

Before the patching the bytecode is:

00000000: 85 01 00 00 00 00 00 16 95 00 00 00 00 00 00 00
00000010: 61 01 00 00 00 00 00 00 95 00 00 00 00 00 00 00
[...]

It becomes


00000000: 85 01 00 00 00 00 00 2b bc 00 00 00 00 00 00 01
00000010: 95 00 00 00 00 00 00 00 61 01 00 80 00 00 00 00

at the end, the 2b offset is incorrect.

With that zext patching the code "85 01 00 00 00 00 00 16" is replaced
with "85 01 00 00 00 00 00 16 bc 00 00 00 00 00 00 01", 0x16 is not
changed, but the real offset has changed.

> So, if we take an existing branch insns from the code, move it into the
> patchlet and extend beginning or end, then it feels more like a bug to the
> one that called bpf_patch_insn_data(), aka zext code here. Bit puzzled why
> this is only seen now, my impression was that Ilya was running s390x the
> BPF selftests quite recently?

I have not investigated why on s390 it is zext'ed, but on x86 not,
it's related to the size of the register when it returns 32bit value.
There may be a bug there as well.

I did think a bit more on your words, making the zext patching code
specially check jumps and adjust the offset in the patchlet looks more
correct. But duplicates the existing code. I should spend more time on
that.


>
> > The problem was triggered by bpf selftest
> >
> > test_progs -t global_funcs
> >
> > on s390, where the very first "call" instruction is patched from
> > verifier.c:opt_subreg_zext_lo32_rnd_hi32() with zext_patch.
> >
> > The patch includes current instruction to the condition check.
> >
> > Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> > ---
> >   kernel/bpf/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index ed0b3578867c..b0a9a22491a5 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -340,7 +340,7 @@ static int bpf_adj_delta_to_imm(struct bpf_insn *insn, u32 pos, s32 end_old,
> >       s32 delta = end_new - end_old;
> >       s64 imm = insn->imm;
> >
> > -     if (curr < pos && curr + imm + 1 >= end_old)
> > +     if (curr <= pos && curr + imm + 1 >= end_old)
> >               imm += delta;
> >       else if (curr >= end_new && curr + imm + 1 < end_new)
> >               imm -= delta;
> > @@ -358,7 +358,7 @@ static int bpf_adj_delta_to_off(struct bpf_insn *insn, u32 pos, s32 end_old,
> >       s32 delta = end_new - end_old;
> >       s32 off = insn->off;
> >
> > -     if (curr < pos && curr + off + 1 >= end_old)
> > +     if (curr <= pos && curr + off + 1 >= end_old)
> >               off += delta;
> >       else if (curr >= end_new && curr + off + 1 < end_new)
> >               off -= delta;
> >
>


-- 
WBR, Yauheni

