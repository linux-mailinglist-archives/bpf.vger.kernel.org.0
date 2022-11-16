Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFCE762C8D7
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 20:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbiKPTSO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 14:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiKPTSN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 14:18:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7C553EF6
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 11:18:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9D9C9B81E86
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 19:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CEAC4314B
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668626289;
        bh=FWxV5cOhm3yOOlmNt1Kx1v7jIiHG6J6Wyzkt+Su/K0U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XZLkMROXqq0DqoUmuUMyorNGjz09RV32m3SFoYg1FViWvtgupf36lHbLUL06Lm2Ba
         fOJxWwPBzsOPScKghVN4eXkyIUm3L5EmBY9jGZht+Fp/WL82UX8ysvdmibGPVIBNPw
         nw4V/h3mDzsChRJQA8qm3tuKeMqCEvE/Xj25rLWl1NVlZq4TaenuLgaBZJncMfe1HQ
         ZmXBT5BjtDuvJ+FR7Pp4+jt5GLuzgEtOO5KNcf7EC+eBqo9BbyJmtqE/iVRFCmnUbG
         /mchCv4a0rvtsVMk7+g3wgiwJ9HdSUQqLsuKP9KntoSKFgCr66nMErMl5xqOGFYR/5
         s0qGWPgY2cwew==
Received: by mail-lj1-f180.google.com with SMTP id h12so23118110ljg.9
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 11:18:09 -0800 (PST)
X-Gm-Message-State: ANoB5pkYWIg6Af5uBFAWPYZmnu7QemkPZfaXP1EqODBJ2NLI0MNxmxAg
        Rl6cAenFZ6sY2jg/Qfhcef5fkppA1+3rUMaUh13KjA==
X-Google-Smtp-Source: AA0mqf7PG0dBZO8iorKSEIMF0hXEjFNMGwElj5QH9Zt3D/JxRv5uBgb2JAvG2OWvxypTy7vE24n3ktmivq0WZ65txLI=
X-Received: by 2002:a2e:3606:0:b0:277:b84:81b6 with SMTP id
 d6-20020a2e3606000000b002770b8481b6mr7831300lja.425.1668626287137; Wed, 16
 Nov 2022 11:18:07 -0800 (PST)
MIME-Version: 1.0
References: <20221115175652.3836811-1-roberto.sassu@huaweicloud.com>
 <20221115175652.3836811-2-roberto.sassu@huaweicloud.com> <CAHC9VhQjnwbFgAoFgTaLQP7YnNDNyP1i0i8H++HZWj930pW=-A@mail.gmail.com>
 <18e375adfe53f8ce5fb38a6a146ad06eaec71a5e.camel@huaweicloud.com>
In-Reply-To: <18e375adfe53f8ce5fb38a6a146ad06eaec71a5e.camel@huaweicloud.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Wed, 16 Nov 2022 20:17:56 +0100
X-Gmail-Original-Message-ID: <CACYkzJ43UZARCkWp6wOQuuEDpOnf33JwAJ=CeZVuW0hffQrmeQ@mail.gmail.com>
Message-ID: <CACYkzJ43UZARCkWp6wOQuuEDpOnf33JwAJ=CeZVuW0hffQrmeQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] lsm: Clarify documentation of vm_enough_memory hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     Paul Moore <paul@paul-moore.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        revest@chromium.org, jackmanb@chromium.org, jmorris@namei.org,
        serge@hallyn.com, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Nov 16, 2022 at 9:06 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2022-11-15 at 21:11 -0500, Paul Moore wrote:
> > On Tue, Nov 15, 2022 at 12:57 PM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > include/linux/lsm_hooks.h reports the result of the LSM infrastructure to
> > > the callers, not what LSMs should return to the LSM infrastructure.
> > >
> > > Clarify that and add that returning 1 from the LSMs means calling
> > > __vm_enough_memory() with cap_sys_admin set, 0 without.
> > >
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > Reviewed-by: KP Singh <kpsingh@kernel.org>
> > > ---
> > >  include/linux/lsm_hooks.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
> > > index 4ec80b96c22e..f40b82ca91e7 100644
> > > --- a/include/linux/lsm_hooks.h
> > > +++ b/include/linux/lsm_hooks.h
> > > @@ -1411,7 +1411,9 @@
> > >   *     Check permissions for allocating a new virtual mapping.
> > >   *     @mm contains the mm struct it is being added to.
> > >   *     @pages contains the number of pages.
> > > - *     Return 0 if permission is granted.
> > > + *     Return 0 if permission is granted by LSMs to the caller. LSMs should
> > > + *     return 1 if __vm_enough_memory() should be called with
> > > + *     cap_sys_admin set, 0 if not.
> >
> > I think this is a nice addition, but according to the code, any value
> > greater than zero will trigger the caller-should-have-CAP_SYS_ADMIN
> > behavior, not just 1.  I suggest updating the comment.
>
> Ok, yes. Thanks.

Also, this is an unrelated patch and you can probably send it
independently, especially
since the other changes will now land mostly via BPF.

>
> Roberto
>
