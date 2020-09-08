Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6BF2610B8
	for <lists+bpf@lfdr.de>; Tue,  8 Sep 2020 13:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730064AbgIHLeh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Sep 2020 07:34:37 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49899 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729869AbgIHLcI (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 8 Sep 2020 07:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599564722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJOK6TJNvITfrbUqg2poQb5ZILvHFMf3hPNolITcdKo=;
        b=GkNzZEYv8MePUEo9B68CsJcLvgW9/JzUAlWUEJfT8zTi3jnVZqUY/kSQcdmsvYd7rbi4Ml
        53Xs6MIX+A0yLnE15hOYmYMq4gI9gDo4bv5n2NkCLpnAthmE0e5D2SoH7DQ8qNCrPZ4pzH
        rkz/UbyFp4BV1xEaJtCaZYVxy/sQzno=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-8n2UFsmuNOaDzqtkgM-gpw-1; Tue, 08 Sep 2020 07:32:01 -0400
X-MC-Unique: 8n2UFsmuNOaDzqtkgM-gpw-1
Received: by mail-wm1-f70.google.com with SMTP id c186so4619636wmd.9
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2020 04:32:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qJOK6TJNvITfrbUqg2poQb5ZILvHFMf3hPNolITcdKo=;
        b=Q5OUiEjMBpwhH97LssPygf0NElsmwGMKDaMgZHD1CmFQKo7YQ3LKgnRiJvHNbftzUD
         B0j43GDHjBtONt3LdKYaG3tN+TiqQ7Oq9+ZKsllEe1W4FT7bBXsiTiH0y1ZnqnjeWFDd
         aXDmJo4yIaBYoHD7k3byQFEsno4UiLicEYijYUM/bw3Nvyr4TxD1GhNsy99ablhmH17f
         Ca+gGZrEb0Ph3BPRy2dDn7VtqGFkFD/Ucf6XV1w9qjpbmwIH6tD/PKZIsAfeeWHxo5V/
         rvwAve5TgqOzpmNw5IqgfXzl4ih/CMqO3bAEkiUaTE/n1P7VizlkyQ1jbGFZHyI191Ik
         RtFA==
X-Gm-Message-State: AOAM5314cUyhxfq3NFDaGbkSeIoNtKZ7V4Zia3mmf66Fm2471mhS4JLO
        KixkOq4h2VALgUdPHvbBMwtgzPBjwAAoV/eHXEdSF3H25QmXGUbNYJ0N0eHXTbTZ05MObULBDa9
        r1QOS1VL77XCVLHSIqI66Xo3GPCFN
X-Received: by 2002:adf:ec87:: with SMTP id z7mr28434521wrn.57.1599564719759;
        Tue, 08 Sep 2020 04:31:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUOWkdXN7QQTinUyEwo+4yowl4NNkJ+HqJnZwZ73aBZNS2bIbARUjM8eh1nFLlsFmFg9r+dIH7TyKdiD9mxw0=
X-Received: by 2002:adf:ec87:: with SMTP id z7mr28434498wrn.57.1599564719494;
 Tue, 08 Sep 2020 04:31:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200903140542.156624-1-yauheni.kaliuta@redhat.com>
 <1ac6aef1-b38c-06c7-6e0d-b8459207d7d9@iogearbox.net> <CANoWswkX9xrG48HHO19Q67ogmNcOArpe4iZwWU4_S08A7H+_Cg@mail.gmail.com>
 <7510248caa08a521150b3089e12ded4312eaf14b.camel@linux.ibm.com>
In-Reply-To: <7510248caa08a521150b3089e12ded4312eaf14b.camel@linux.ibm.com>
From:   Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
Date:   Tue, 8 Sep 2020 14:31:43 +0300
Message-ID: <CANoWswmGO45kBwtfPLCwd7LeUQstDS5L3yqDVUny1y2r=VcACw@mail.gmail.com>
Subject: Re: [PATCH RFC] bpf: update current instruction on patching
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi!

On Mon, Sep 7, 2020 at 7:14 PM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Thu, 2020-09-03 at 19:13 +0300, Yauheni Kaliuta wrote:
> > On Thu, Sep 3, 2020 at 6:10 PM Daniel Borkmann <daniel@iogearbox.net>
> > wrote:
> > > On 9/3/20 4:05 PM, Yauheni Kaliuta wrote:
> > > > On code patching it may require to update branch destinations if
> > > > the
> > > > code size changed. bpf_adj_delta_to_imm/off increments offset
> > > > only
> > > > if the patched area is after the branch instruction. But it's
> > > > possible, that the patched area itself is a branch instruction
> > > > and
> > > > requires destination update.
> > >
> > > Could you provide a concrete example and walk us through? I'm
> > > probably
> > > missing something but if the patchlet contains a branch
> > > instruction, then
> > > it should be 'self-contained'. In the sense that the patchlet is a
> > > 'black
> > > box' that replaces 1 insns with n insns but there is no awareness
> > > what's
> > > inside these insns and hence no fixup for that inside
> > > bpf_patch_insn_data().
> >
> > The code is
> > Disassembly of section classifier/test:
> >
> > 0000000000000000 test_cls:
> >        0:       85 01 00 00 ff ff ff ff call -1
> >                 0000000000000000:  R_BPF_64_32  f7
> >        1:       95 00 00 00 00 00 00 00 exit
> > 0000000000000000 f1:
> >        0:       61 01 00 00 00 00 00 00 r0 = *(u32 *)(r1 + 0)
> >        1:       95 00 00 00 00 00 00 00 exit
> > [...]
> > 00000000000000a8 f7:
> >       21:       85 01 00 00 ff ff ff ff call -1
> >                 00000000000000a8:  R_BPF_64_32  f6
> >       22:       95 00 00 00 00 00 00 00 exit
> >
> > Before the patching the bytecode is:
> >
> > 00000000: 85 01 00 00 00 00 00 16 95 00 00 00 00 00 00 00
> > 00000010: 61 01 00 00 00 00 00 00 95 00 00 00 00 00 00 00
> > [...]
> >
> > It becomes
> >
> >
> > 00000000: 85 01 00 00 00 00 00 2b bc 00 00 00 00 00 00 01
> > 00000010: 95 00 00 00 00 00 00 00 61 01 00 80 00 00 00 00
> >
> > at the end, the 2b offset is incorrect.
> >
> > With that zext patching the code "85 01 00 00 00 00 00 16" is
> > replaced
> > with "85 01 00 00 00 00 00 16 bc 00 00 00 00 00 00 01", 0x16 is not
> > changed, but the real offset has changed.
> >
> > > So, if we take an existing branch insns from the code, move it into
> > > the
> > > patchlet and extend beginning or end, then it feels more like a bug
> > > to the
> > > one that called bpf_patch_insn_data(), aka zext code here. Bit
> > > puzzled why
> > > this is only seen now, my impression was that Ilya was running
> > > s390x the
> > > BPF selftests quite recently?
> >
> > I have not investigated why on s390 it is zext'ed, but on x86 not,
> > it's related to the size of the register when it returns 32bit value.
> > There may be a bug there as well.
> >
> > I did think a bit more on your words, making the zext patching code
> > specially check jumps and adjust the offset in the patchlet looks
> > more
> > correct. But duplicates the existing code. I should spend more time
> > on
> > that.
>
> I guess copying the existing insn into the patchlet was introduced
> because there is nothing like bpf_insert_insns()? I.e. we can replace
> an existing insn with a patchlet, but cannot append anything to it.
> Would introducing such function solve this problem?

Sounds as a plan!


-- 
WBR, Yauheni

