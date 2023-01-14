Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8611466A762
	for <lists+bpf@lfdr.de>; Sat, 14 Jan 2023 01:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjANAKN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 13 Jan 2023 19:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjANAKM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 13 Jan 2023 19:10:12 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2C84D716
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 16:10:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so55961198ejc.4
        for <bpf@vger.kernel.org>; Fri, 13 Jan 2023 16:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sHH8wqJrFYYq8jIHgmXoM8DdwMkNa3V6oSSF5rvjaP4=;
        b=N4n1Pa2fJNOnvxii0o0XoN3bTHqrhJsbOQ45d7t8jBfSBKjgzI9dCM8eXnuJDbZyDH
         gxACiKyhxlU6R21wZWdM0H9OcN8kuznOmHCyMozRJzENH1EwmE3p7A64cYViqFVo0f2u
         h1j6RFlLpXXjAixVfTGg2oIjcoWhxgd0E9WRvQy6GSbpZ+kTlEBLdGGMZSIJzIOe4SXi
         H2dXwJEzWui/0xQE02qyZ4G0NcWmnakx6oFptYVc3+uGjxdZt7T9/uN2sCeAEkVUWtWU
         pvcu45Bo7d9ZHAPHThe72ilKrmce+v+WNWRP5iMCRMxGNY3P0bugJhnvonmWwWSLBPc8
         z0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHH8wqJrFYYq8jIHgmXoM8DdwMkNa3V6oSSF5rvjaP4=;
        b=J3tgmBbgXDTAW79JmsK7wzeq4RImO/0+LP8xDbG3Y48laRwwfy6OV3EVCIGcngpQvk
         tbLPDp9aTzXFwp75O6fM1ylp6r0mFOcX/bv3xq9eaI49gtWPLNOLRTlyNNRfGd8NNN7c
         zQtfQrY6RgQNQp4lMF07L5DPwzBdIdy2ujlfEIB+dnIzarFTOkoF8BPA6nhc1PL4+zhI
         ommNF+u8SA83wDUNa2UVpg57lomDEClkpKUUaV6/A+Txk2Fdb3All6kolilnnL0emit7
         FqXUx+Zf1xMrizrpIXgWyMEU9Z4p2fQ+pUxZRglqEU1/kI8g/hJ/9KriN1ap63PL8Qng
         KURg==
X-Gm-Message-State: AFqh2krRTrPMdyaA1f5RLMy4EmJ08dVtVfTJjJ34+Qd3w8d/pz1GIhJB
        xMmshp5rRwWXfUmcPNrEIkEq+ID0uJ0=
X-Google-Smtp-Source: AMrXdXuhkUevlGkHLhUcRnUquBCtTZAfilts0/pFtVkXcNFYDlG2ELfO6AiQiMEbLJ2cVIpGwC7eNw==
X-Received: by 2002:a17:907:9006:b0:84d:411d:64a4 with SMTP id ay6-20020a170907900600b0084d411d64a4mr4451836ejc.38.1673655009787;
        Fri, 13 Jan 2023 16:10:09 -0800 (PST)
Received: from [192.168.1.113] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b007c0b28b85c5sm9009730ejt.138.2023.01.13.16.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 16:10:09 -0800 (PST)
Message-ID: <b836c36a68b670df8f649db621bb3ec74e03ef9b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Fix to preserve reg parent/live
 fields when copying range info
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, kernel-team@fb.com, yhs@fb.com
Date:   Sat, 14 Jan 2023 02:10:07 +0200
In-Reply-To: <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
References: <20230106142214.1040390-1-eddyz87@gmail.com>
         <CAEf4BzYoB8Ut7UM62dw6TquHfBMAzjbKR=aG_c74XaCgYYyikg@mail.gmail.com>
         <e64e8dbea359c1e02b7c38724be72f354257c2f6.camel@gmail.com>
         <CAEf4BzY3e+ZuC6HUa8dCiUovQRg2SzEk7M-dSkqNZyn=xEmnPA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 2023-01-13 at 14:22 -0800, Andrii Nakryiko wrote:
> On Fri, Jan 13, 2023 at 12:02 PM Eduard Zingerman <eddyz87@gmail.com> wro=
te:
> >=20
> > On Wed, 2023-01-11 at 16:24 -0800, Andrii Nakryiko wrote:
> > [...]
> > >=20
> > > I'm wondering if we should consider allowing uninitialized
> > > (STACK_INVALID) reads from stack, in general. It feels like it's
> > > causing more issues than is actually helpful in practice. Common code
> > > pattern is to __builtin_memset() some struct first, and only then
> > > initialize it, basically doing unnecessary work of zeroing out. All
> > > just to avoid verifier to complain about some irrelevant padding not
> > > being initialized. I haven't thought about this much, but it feels
> > > that STACK_MISC (initialized, but unknown scalar value) is basically
> > > equivalent to STACK_INVALID for all intents and purposes. Thoughts?
> >=20
> > Do you have an example of the __builtin_memset() usage?
> > I tried passing partially initialized stack allocated structure to
> > bpf_map_update_elem() and bpf_probe_write_user() and verifier did not
> > complain.
> >=20
> > Regarding STACK_MISC vs STACK_INVALID, I think it's ok to replace
> > STACK_INVALID with STACK_MISC if we are talking about STX/LDX/ALU
> > instructions because after LDX you would get a full range register and
> > you can't do much with a full range value. However, if a structure
> > containing un-initialized fields (e.g. not just padding) is passed to
> > a helper or kfunc is it an error?
>=20
> if we are passing stack as a memory to helper/kfunc (which should be
> the only valid use case with STACK_MISC, right?), then I think we
> expect helper/kfunc to treat it as memory with unknowable contents.
> Not sure if I'm missing something, but MISC says it's some unknown
> value, and the only difference between INVALID and MISC is that MISC's
> value was written by program explicitly, while for INVALID that
> garbage value was there on the stack already (but still unknowable
> scalar), which effectively is the same thing.

I looked through the places where STACK_INVALID is used, here is the list:

- unmark_stack_slots_dynptr()
  Destroy dynptr marks. Suppose STACK_INVALID is replaced by
  STACK_MISC here, in this case a scalar read would be possible from
  such slot, which in turn might lead to pointer leak.
  Might be a problem?

- scrub_spilled_slot()
  mark spill slot STACK_MISC if not STACK_INVALID
  Called from:
  - save_register_state() called from check_stack_write_fixed_off()
    Would mark not all slots only for 32-bit writes.
  - check_stack_write_fixed_off() for insns like `fp[-8] =3D <const>` to
    destroy previous stack marks.
  - check_stack_range_initialized()
    here it always marks all 8 spi slots as STACK_MISC.
  Looks like STACK_MISC instead of STACK_INVALID wouldn't make a
  difference in these cases.

- check_stack_write_fixed_off()
  Mark insn as sanitize_stack_spill if pointer is spilled to a stack
  slot that is marked STACK_INVALID. This one is a bit strange.
  E.g. the program like this:

    ...
    42:  fp[-8] =3D ptr
    ...
   =20
  Will mark insn (42) as sanitize_stack_spill.
  However, the program like this:

    ...
    21:  fp[-8] =3D 22   ;; marks as STACK_MISC
    ...
    42:  fp[-8] =3D ptr
    ...

  Won't mark insn (42) as sanitize_stack_spill, which seems strange.

- stack_write_var_off()
  If !env->allow_ptr_leaks only allow writes if slots are not
  STACK_INVALID. I'm not sure I understand the intention.

- clean_func_state()
  STACK_INVALID is used to mark spi's that are not REG_LIVE_READ as
  such that should not take part in the state comparison. However,
  stacksafe() has REG_LIVE_READ check as well, so this marking might
  be unnecessary.

- stacksafe()
  STACK_INVALID is used as a mark that some bytes of an spi are not
  important in a state cached for state comparison. E.g. a slot in an
  old state might be marked 'mmmm????' and 'mmmmmmmm' or 'mmmm0000' in
  a new state. However other checks in stacksafe() would catch these
  variations.

The conclusion being that some pointer leakage checks might need
adjustment if STACK_INVALID is replaced by STACK_MISC.

>=20
> >=20
> > > Obviously, this is a completely separate change and issue from what
> > > you are addressing in this patch set.
> > >=20
> > > Awesome job on tracking this down and fixing it! For the patch set:
> >=20
> > Thank you for reviewing this issue with me.
> >=20
> > >=20
> > > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > >=20
> > >=20
> > [...]

