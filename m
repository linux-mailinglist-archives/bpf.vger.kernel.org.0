Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442F3608187
	for <lists+bpf@lfdr.de>; Sat, 22 Oct 2022 00:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJUW3z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Oct 2022 18:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiJUW3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Oct 2022 18:29:51 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7D931EC8
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:29:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id u21so10966544edi.9
        for <bpf@vger.kernel.org>; Fri, 21 Oct 2022 15:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MsyPtgx7zZvXEMDoZAmrImxhxViF2jHtOTZdnE143eE=;
        b=bD6gWUFoorc6nSYI2YYxH1D9ddNkbO6ktGboW2RTqFH8KBy4WcFf7+Jkq63LeQCXYo
         XR5KZQLVSB2Ql5RmKmiE+qhCRCELnz7sc4ocYuRJsHkAv2iL+/1Z4PZ/MjJhV24iEWBt
         7wPPxtbISecs7DfvslG/d2q0eelcyM69/sHxqSxnwnggiBaQFaruS0YJbLt0Pb1z1TkI
         AP+jslrEZuEPE/UC/o6QLIs+Y/6CHPmkhhGlTzB4yfLTQac4FhVZeb//bl2TkwPWnAhH
         /HZXo2/m3T3r+o+IM+XNsoXlUkW+EhC7qvyEpvthXBkGGAclgIGrCCmZXliO+R3p5S9P
         XlyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsyPtgx7zZvXEMDoZAmrImxhxViF2jHtOTZdnE143eE=;
        b=UBIigeySxhsI7/CH6EmWrtYU+dt7XeFA/BxZVx9WKTtYlRHrNOiBYXUW8SwzuTq5lV
         g3pvuXUgbKTxA3g5R02gAyXXPgdo40bH5y9TyZ9BBUbtcD6dRrckntnC8D/u4kOgwCRa
         sHRAj9eaSoJzsOFG3DVAS/K4l8D4hp7kIry8CNw/uSxpADQniwevOX75es2z65Oo5gsf
         b8jfU5iowZ5rARB2bK1kpF1b5qgWvK0M8I1CJ4r86AVsWtmUbLeOQQUWx44c5uzYaLvM
         W2zPuQjJ6Xzvkp/qHXPN+kfOb0ICR6I/GTfNSIZCZmTIS2Sj8KBEub7ihGLjkT9Q4hva
         iGbw==
X-Gm-Message-State: ACrzQf1cNdn5K2aOWpqoa9ki+hEa0gQg9TUD+Zu35GqARaP0MOxD2mCt
        ejEZ5b0xntZ0lX1rufrdB6gWx0DzCFlKOR4rvso=
X-Google-Smtp-Source: AMsMyM5IioBTdh+w1a6poGvPGbni6dR5WSEygmC4wc1mawG5KgyT8Yqq2l4ZVM1z5B7Wpvs5TcktJ27q8Xk4y3MsDQQ=
X-Received: by 2002:a17:907:75e6:b0:7a1:848:20cb with SMTP id
 jz6-20020a17090775e600b007a1084820cbmr26753ejc.745.1666391385707; Fri, 21 Oct
 2022 15:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <1666389364-27963-1-git-send-email-alan.maguire@oracle.com>
In-Reply-To: <1666389364-27963-1-git-send-email-alan.maguire@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 21 Oct 2022 15:29:33 -0700
Message-ID: <CAEf4BzZuK+9T3wYcxJVOhYSTwghzGDEEU9SZDvVo3J2u4xXaGA@mail.gmail.com>
Subject: Re: [RFC bpf-next] libbpf: btf dedup identical struct test needs
 check for nested structs/arrays
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     andrii@kernel.org, jolsa@kernel.org, acme@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Oct 21, 2022 at 2:56 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> When examining module BTF, we often see core kernel structures
> such as sk_buff, net_device duplicated in the module.  After adding
> debug messaging to BTF it turned out that much of the problem
> was down to the identical struct test failing during deduplication;
> sometimes compilation units contain identical structs.  However
> it turns out sometimes that type ids of identical struct members
> can also differ, even when the containing structs are still identical.
>
> To take an example, for struct sk_buff, debug messaging revealed
> that the identical struct matching was failing for the anon
> struct "headers"; specifically for the first field:
>
>         __u8       __pkt_type_offset[0]; /*   128     0 */
>
> Looking at the code in BTF deduplication, we have code that guards
> against the possibility of identical struct definitions, down to
> type ids, and identical array definitions.  However in this case
> we have a struct which is being defined twice but does not have
> identical type ids since each duplicate struct has separate type
> ids for the above array member.  A similar problem (though not
> observed) could potentially occur for a struct-in-a-struct.
>
> The solution is to make the "identical struct" test check members
> not just for matching ids, but to also check if they in turn are
> identical structs or arrays.
>
> The results of doing this are quite dramatic (for some modules
> at least); I see the number of type ids drop from around 10000
> to just over 1000 in one module for example, and kernel
> module types are no longer duplicated.
>
> For testing with latest pahole, applying [1] is required,
> otherwise dedups can fail for the reasons described there.
>
> All BTF-related selftests passed with this change.
>
> RFC for bpf-next rather than patch for bpf tree because while
> this resolves dedup issues for me using gcc 9 and 11,
> these things seem to be quite compiler-sensitive, so would
> be good to ensure it works for others too.  Presuming it
> does, should probably specify:
>
> Fixes: efdd3eb8015e ("libbpf: Accommodate DWARF/compiler bug with duplicated structs")
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>
> [1] https://lore.kernel.org/bpf/1666364523-9648-1-git-send-email-alan.maguire@oracle.com/
> ---
>  tools/lib/bpf/btf.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index d88647d..b7d7f19 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -3918,8 +3918,11 @@ static bool btf_dedup_identical_structs(struct btf_dedup *d, __u32 id1, __u32 id
>         m1 = btf_members(t1);
>         m2 = btf_members(t2);
>         for (i = 0, n = btf_vlen(t1); i < n; i++, m1++, m2++) {
> -               if (m1->type != m2->type)
> -                       return false;
> +               if (m1->type == m2->type ||
> +                   btf_dedup_identical_structs(d, m1->type, m2->type) ||
> +                   btf_dedup_identical_arrays(d, m1->type, m2->type))
> +                       continue;
> +               return false;

this makes a lot of sense and I don't see why this would be incorrect.
Please submit this as non-RFC patch. I'd just keep the overall "return
false on mismatch" approach:

if (m1->type != m2->type &&
    !btf_dedup_identical_arrays(d, m1->type, m2->type) &&
    !btf_dedup_identical_structs(d, m1->type, m2->type))
    return;


oh, can you please also change btf_dedup_identical_arrays() signature
to return bool, no idea why it returns int (0 or 1).


>         }
>         return true;
>  }
> --
> 1.8.3.1
>
