Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DE258D058
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 00:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244515AbiHHWwx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Aug 2022 18:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243759AbiHHWww (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 8 Aug 2022 18:52:52 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA62A1B7B0;
        Mon,  8 Aug 2022 15:52:51 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gk3so19193288ejb.8;
        Mon, 08 Aug 2022 15:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=5MzS0ymbK6z+9bEYlEj5XGn10tCDKLANgFiZTHjqE/8=;
        b=AVhKObQXg9qDZUW/OmZuC1pay7fHqyY0YdybXSESFbXj41GHFPH9+MGv1cx0g0Fci0
         mmqhjwB+Ymjq+USV8gf2i0/fCpG4p+aiDUtPDcMN/OGOjo0bZTxHOkToQqkOvsD0EYZt
         GeddoqJYQLo6Tv/oR4rrbtiXet+9olJRfhBocCbQ6aZP3aAbb/zVb0fBmPW/kY385t60
         J251kyQSpzQiRfcQl1TaBcYPcEpmaM8gy3M3Cgqq9Pl6hxM6sr3xfs9pjDHk2StTLjeR
         5COuVaV3Kdqth/PPL6zisZKBm3esrNyYlpCCetuBtwjbPMa1urectduiJS7r+5Z3P6Tn
         W8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=5MzS0ymbK6z+9bEYlEj5XGn10tCDKLANgFiZTHjqE/8=;
        b=BlmUaNdGnY5htiktYr+t2RHQPdEIqGRsAKoIf1m/l+uPB2ry42+FmuiYxZ3dYDJwMy
         KM89cpHUXhCKR6aBEhBMMGvdpwlQq8iwGqGLYu9oD5jt/isET6GA5HbsmRahDvrpyQ7o
         IwgGA/zohoOT/jfGIt49bx2GbIWaOBQlNmydF822OzPKIURRlDJHXHhl1UqGpotQAcV2
         5WXnrRa5imWRmN251VkJl9OMpVzmJDKIwnbhTcVmnrbDMpQr91SVEzabD2wd+gQFR8kp
         CTGqhbu2xYXgmILe1l/M5ThiOmoWIQJos324GcuXZtQG9x6/C7wbu/OoKFLtr/iLpNMR
         Cn/Q==
X-Gm-Message-State: ACgBeo3/dXqaOEYYouxIwpxKluKcZm+YTKYNJo2cCefgV0sZERM3F5GG
        pDTkLc9/2EbfutvIhY7j9ff6zSI0WY/z3xHMPaOWjipSnQ4=
X-Google-Smtp-Source: AA6agR5dOPw9KwBg8ihjp/sKtkCfChRG1yMn/aEHAOsn/0vGLUEEWdYp1zPa5NhOlmkZv1c2vAqemwypGp0kLjORU2s=
X-Received: by 2002:a17:907:3d90:b0:730:a937:fb04 with SMTP id
 he16-20020a1709073d9000b00730a937fb04mr15493183ejc.176.1659999170480; Mon, 08
 Aug 2022 15:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220807175309.4186342-1-yhs@fb.com> <CAEf4BzZJdqxOS_8VLX73z94GCUBVW4k6hKo3WGHyv4n-jQ-niQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZJdqxOS_8VLX73z94GCUBVW4k6hKo3WGHyv4n-jQ-niQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 8 Aug 2022 15:52:38 -0700
Message-ID: <CAEf4BzYaWboRjHqewen71QZhvQyvtkeE5N43y=NvE+igw4RXYw@mail.gmail.com>
Subject: Re: [PATCH dwarves] dwarf_loader: encode char type as signed
To:     Yonghong Song <yhs@fb.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        dwarves@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
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

On Mon, Aug 8, 2022 at 3:52 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Sun, Aug 7, 2022 at 10:53 AM Yonghong Song <yhs@fb.com> wrote:
> >
> > Currently, the pahole treats 'char' or 'signed char' type
> > as unsigned in BTF generation. The following is an example,
> >   $ cat t.c
> >   signed char a;
> >   char b;
> >   $ clang -O2 -g -c t.c
> >   $ pahole -JV t.o
> >   ...
> >   [1] INT signed char size=1 nr_bits=8 encoding=(none)
> >   [2] INT char size=1 nr_bits=8 encoding=(none)
> > In the above encoding '(none)' implies unsigned type.
> >
> > But if the same program is compiled with bpf target,
> >   $ clang -target bpf -O2 -g -c t.c
> >   $ bpftool btf dump file t.o
> >   [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> >   [2] VAR 'a' type_id=1, linkage=global
> >   [3] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
> >   [4] VAR 'b' type_id=3, linkage=global
> >   [5] DATASEC '.bss' size=0 vlen=2
> >           type_id=2 offset=0 size=1 (VAR 'a')
> >           type_id=4 offset=0 size=1 (VAR 'b')
> > the 'char' and 'signed char' are encoded as SIGNED integers.
> >
> > Encode 'char' and 'signed char' as SIGNED should be a right to
> > do and it will be consistent with bpf implementation.
> >
> > With this patch,
> >   $ pahole -JV t.o
> >   ...
> >   [1] INT signed char size=1 nr_bits=8 encoding=SIGNED
> >   [2] INT char size=1 nr_bits=8 encoding=SIGNED
> >
> > Signed-off-by: Yonghong Song <yhs@fb.com>
> > ---
>
> LGTM.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>
> Is there a plan to also add CHAR encoding bit?
>
>
> >  dwarf_loader.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/dwarf_loader.c b/dwarf_loader.c
> > index d892bc3..c2ad2a0 100644
> > --- a/dwarf_loader.c
> > +++ b/dwarf_loader.c
> > @@ -560,7 +560,7 @@ static struct base_type *base_type__new(Dwarf_Die *die, struct cu *cu, struct co
> >                 bt->bit_size = attr_numeric(die, DW_AT_byte_size) * 8;
> >                 uint64_t encoding = attr_numeric(die, DW_AT_encoding);
> >                 bt->is_bool = encoding == DW_ATE_boolean;
> > -               bt->is_signed = encoding == DW_ATE_signed;
> > +               bt->is_signed = (encoding == DW_ATE_signed) || (encoding == DW_ATE_signed_char);
> >                 bt->is_varargs = false;
> >                 bt->name_has_encoding = true;
> >                 bt->float_type = encoding_to_float_type(encoding);
> > --
> > 2.30.2
> >
