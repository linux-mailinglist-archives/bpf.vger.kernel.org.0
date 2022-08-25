Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80D25A1627
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbiHYPyL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiHYPyK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 11:54:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32ED1AF3A
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 08:54:09 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id r22so18261018pgm.5
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc;
        bh=cQilVpz64KznvhP/8doZmFlrCpPKyu329zBOL29B+0k=;
        b=gPXTpS7evo/IyyijWuOsb7fiMkCWftjRvUInXpssmG3LIlHamzgyxJ6wPzOgZnWKH6
         DSGFJM9xiBula3aMtUWj2aUxn5WLUzwCD5B2315uCBtTYVbugG0Og6NP+nbKWaDsu+pu
         YSz2vGDB+8R0oj5StVRG4+PZsuwmEVF7cLerXRwj1NnHGwgxj+0aXPTvmMhyCx1qCYYq
         ixP2QO+L0/QAoc7pg3JrbcrqBCZTBIm4QxqKaO5ydllA4ca3erInu3OqaLaUt0/oYJk9
         Ld7YntyFC0wxlZcvLIV2amgQXS5s9rZyGQJUAjanSXYdCgha26PsVa6dUKYagZnQD0cp
         EtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc;
        bh=cQilVpz64KznvhP/8doZmFlrCpPKyu329zBOL29B+0k=;
        b=jdfc/6m6ZhkGdtMW5R+/FIcdIRTnlaGtmSTZb1cqsTRvfideyWMnrP9uS46GDBnF+c
         khMp0c4YKTxbh0wEsD9JAsXnwtVYpm1pBIEkEWz17ByAFRc6+zf/KpDyGjkPJ5wgYv1A
         TJ/rrurmnr7EnqNsR8fxQt1i3QF9wFKArVz6tGYFmdbE5F3UwJWOCDFMrx4lzzX27IUP
         FwUiz51qGLoJCmzAZxqqPRGuWhdCqk1GQ/xbPDEy01gCWup7ACIR23mXgY81j2OvN9Ap
         Pp2LNVcRO1WhpwrbFXrdBos+ST2SG4QGTs0SxtD4FCfgvYUb+TgMDcTpW6AG/FKi4+oR
         UbfQ==
X-Gm-Message-State: ACgBeo2Hd1udZOPCpKtDKT39fT5nj1BIa0e3es08l6aLUBWqCR/FBoxy
        S9UuqLS0iAZJT7+Rjk+QCcg=
X-Google-Smtp-Source: AA6agR5h+DOtAehwHN2opOgT8DH3+DujjkQO/1vC+/WQJw/UwzHCyafD8jxTBgbucYZ19ELHiCLGQw==
X-Received: by 2002:a65:5889:0:b0:428:90f3:6257 with SMTP id d9-20020a655889000000b0042890f36257mr3897281pgu.590.1661442849400;
        Thu, 25 Aug 2022 08:54:09 -0700 (PDT)
Received: from localhost ([98.97.36.33])
        by smtp.gmail.com with ESMTPSA id o185-20020a625ac2000000b0052b7f0ff197sm15337267pfb.49.2022.08.25.08.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 08:54:08 -0700 (PDT)
Date:   Thu, 25 Aug 2022 08:54:07 -0700
From:   John Fastabend <john.fastabend@gmail.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Lam Thai <lamthai@arista.com>, bpf@vger.kernel.org
Message-ID: <63079b1f19592_12460b208f7@john.notmuch>
In-Reply-To: <e510b3f8-ed6c-55c7-3585-2e065324ae85@isovalent.com>
References: <20220824225859.9038-1-lamthai@arista.com>
 <630716d02ebbe_e1c39208c3@john.notmuch>
 <e510b3f8-ed6c-55c7-3585-2e065324ae85@isovalent.com>
Subject: Re: [PATCH] bpftool: fix a wrong type cast in btf_dumper_int
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Quentin Monnet wrote:
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
> 
> [0] https://github.com/libbpf/bpftool/issues/38

Thanks for the explanation. It would be nice to add the above in the
commit message.

Otherwise though.

Acked-by: John Fastabend <john.fastabend@gmail.com>

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
> >>  					     *(char *)data);
> >>  		break;
> >>  	case BTF_INT_BOOL:
> >> -		jsonw_bool(jw, *(int *)data);
> >> +		jsonw_bool(jw, *(bool *)data);
> 
> Looks good, thanks
> Reviewed-by: Quentin Monnet <quentin@isovalent.com>


