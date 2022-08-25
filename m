Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4EBA5A18F2
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 20:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbiHYSpB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 14:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiHYSo7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 14:44:59 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0F3E03B
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 11:44:58 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id z8so6628789edb.0
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 11:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Voh9Mbu15A7EuF5S/qfbvVMJNleJCtPSP2BLw4qeU20=;
        b=Pdv2pqf0IAKFeMfq32HD9aYUQZneulpWc1zGM0GauK08xlic/HGmX0/FS0QmTLnrzo
         o5jZyWrMdUFrHHaJKRWCWmbtek1s7QE8ZmiQahAUF8dIJUc7BL9pI7iBxHI8nqsoazrO
         TFEsrVdkJlMh3Ck8d6m7a4/UJekOMUpNOHFFI4+cIoFAX/gVZUc9U08eVCuNjMRzYOHL
         CU+0LAa/Dsbql4wGv+Y6JEh/ILRiCBj/b3P+uuCHVrgdAySR9WR/ajiyxuBj3/lpx13L
         +Etvj5mo3thtcNjeQxIK+o+dvNAt+VnBULTtaZP0TtCk4nmgt/geFK41nZkXA9Ks9XtN
         L2zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Voh9Mbu15A7EuF5S/qfbvVMJNleJCtPSP2BLw4qeU20=;
        b=HN/kDPxL/nH3P0c/TLBqSdZJUJSLSgVXoTklw3z480FgbyUNGTwa6GB2kYsViRD9J9
         VQlsWoqAvoCLLVuPGbNyHdX0OH5skn9AuqpsMxU5MARF6IhN2rpTH/17VRGOfXN6yT/C
         wZjun3R/PocmhMjahqRiigp9XtWHyHhZ1truKRVAF/91TJaLkcmfroPqHj5m4zYbntzS
         Y/xsya3DJjdOGBdrXd8/DXVSfAdMScxy6o0F1mfOe3FntWqcHueqMOo0TOF2Jcbyvw1h
         Mtym7bRyYfr+fyqRbtY0QhH5/tTgF6MkVTtSR3Y8Z/l2VN2OG4CZDlWJdwgHjrjtATVs
         9xog==
X-Gm-Message-State: ACgBeo3BZ1NcL9ii6CLpnr0rC6kwPOz/DEU71tmGhZVi8G87wEJyf/rT
        49kVmuXSLXS588dbaCFVjXzDtDja+3JwAYr5kxE=
X-Google-Smtp-Source: AA6agR5osXE4/l+Mr/G3AMdQBZB1U+FaPF72t5w+SEw40VIkXMc+qqAuPOk2id0I6FWewMakqzOp+bVmKDxMVLnO78w=
X-Received: by 2002:a05:6402:1704:b0:447:811f:1eef with SMTP id
 y4-20020a056402170400b00447811f1eefmr4318041edu.14.1661453097155; Thu, 25 Aug
 2022 11:44:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220824225859.9038-1-lamthai@arista.com> <630716d02ebbe_e1c39208c3@john.notmuch>
 <e510b3f8-ed6c-55c7-3585-2e065324ae85@isovalent.com>
In-Reply-To: <e510b3f8-ed6c-55c7-3585-2e065324ae85@isovalent.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 11:44:45 -0700
Message-ID: <CAEf4BzZpyjUY8iMy09DdcO6xtxCbE-5Qr62-Wb7R05uaauHmgg@mail.gmail.com>
Subject: Re: [PATCH] bpftool: fix a wrong type cast in btf_dumper_int
To:     Quentin Monnet <quentin@isovalent.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        Lam Thai <lamthai@arista.com>, bpf@vger.kernel.org
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

On Thu, Aug 25, 2022 at 1:57 AM Quentin Monnet <quentin@isovalent.com> wrote:
>
> On 25/08/2022 07:29, John Fastabend wrote:
> > Lam Thai wrote:
> >> When `data` points to a boolean value, casting it to `int *` is problematic
> >> and could lead to a wrong value being passed to `jsonw_bool`. Change the
> >> cast to `bool *` instead.
> >
> > How is it problematic? Its from BTF_KIND_INT by my quick reading.
>
> Hi John, it's an INT but it also has a size of 1:
>
>     struct map_value {
>        int a;
>        int b;
>        short c;
>        bool d;
>     };
>
>     # bpftool btf dump id 1107
>     [...]
>     [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>     [...]
>     [12] STRUCT 'map_value' size=12 vlen=4
>             'a' type_id=2 bits_offset=0
>             'b' type_id=2 bits_offset=32
>             'c' type_id=13 bits_offset=64
>             'd' type_id=14 bits_offset=80
>     [13] INT 'short' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
>     [14] INT '_Bool' size=1 bits_offset=0 nr_bits=8 encoding=BOOL
>     [...]
>
> And Lam reported [0] that the pretty-print for the map does not display
> the correct boolean value, because it reads too many bytes from this
> *(int *)data.
>
>     # bpftool map dump name my_map --pretty
>     [{
>             "key": ["0x00","0x00","0x00","0x00"
>             ],
>             "value":
> ["0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00","0x00"
>             ],
>             "formatted": {
>                 "key": 0,
>                 "value": {
>                     "a": 0,
>                     "b": 0,
>                     "c": 0,
>                     "d": true
>                 }
>             }
>         }
>     ]
>
> The above is before the map gets any update. The bytes in "value" look
> correct, but "d" says "true" when it should be "false". So bpf tree
> would make sense to me.

That code is back from 2018. Alexei recently clarified that bpf is for
hi-pri and urgent fixes. I don't think this one classifies as such.
Plus bpftool itself should be packaged from github mirror, so this fix
will make it there fast. Applied to bpf-next.

>
> [0] https://github.com/libbpf/bpftool/issues/38
>
> >
> >>
> >> Fixes: b12d6ec09730 ("bpf: btf: add btf print functionality")
> >> Signed-off-by: Lam Thai <lamthai@arista.com>
> >> ---
> >
> > for bpf-next looks like a nice cleanup, I don't think its needed for bpf
> > tree?
> >
> >>  tools/bpf/bpftool/btf_dumper.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
> >> index 125798b0bc5d..19924b6ce796 100644
> >> --- a/tools/bpf/bpftool/btf_dumper.c
> >> +++ b/tools/bpf/bpftool/btf_dumper.c
> >> @@ -452,7 +452,7 @@ static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
> >>                                           *(char *)data);
> >>              break;
> >>      case BTF_INT_BOOL:
> >> -            jsonw_bool(jw, *(int *)data);
> >> +            jsonw_bool(jw, *(bool *)data);
>
> Looks good, thanks
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>
