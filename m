Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538FE4CB2ED
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 00:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiCBXvT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 18:51:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiCBXvQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 18:51:16 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33ABA46672
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 15:50:29 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id f14so3925899ioz.1
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 15:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VprcUlYkh4qNnwRdfggCY6VNlda8CF6E/I9Upd2r4JI=;
        b=BuGRfWzeSpmAa/+IRUfyJUEa3fDUciVFeHaFUUlYY0dGVCYs5UmPxjg5bw90f+Kykm
         m3QQYeCEsM7eVlRkQvx8yx0xYyUMMdoozAD20MkjYmLXEZ7KAssURldcz/7UbW33NGRd
         7eZ1aORvDEJprQpq3T9nLWTTXud1tDC2zXxplrTEiZMks93slvyzf71Y8LuQf59zc7SO
         lzP13PsUgQWX5BvusCg1FXmbj8hPUChFzzVShqe9jave2LdXt0tgSLLB/gqlyzWe9yU3
         UocKPZfcFacFUv9Y/BA3ELiI75dJ2v0aYJr17EP4lTJHSSAjrJojgKGjVrVhLA+exISy
         P2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VprcUlYkh4qNnwRdfggCY6VNlda8CF6E/I9Upd2r4JI=;
        b=JASa0cBX/504TFGJe2m/UUpoo9u6oJKWyCKviTrQbUp10Vaq2SDmuLi9tk9QKlW6KK
         WLiiCJvCLVe5bWO23ehmPp7GWGOEySxaSImOu5xz4glb+oBsVFagWk6ZbafgbakiR+Hl
         BF4RqAJ/Ws0wppoQWCMXfXMOjkFCxTJZFRkORnlDXHplpQaN23jdo+jn+wcI/oDgdrEN
         Vw8x/8EuDi0+49sU9Rb1YMU0VwcsjUH2LlKx3nQjDEikSzNysOf5KK+zBUDN2Db2glDh
         SHgynTL2jncfyG+Lodu8qI45mS3GIovOAQNi08cc9TCbR7mqR1JHgcAYcPQgyUXamtBf
         1P5g==
X-Gm-Message-State: AOAM532dSrCCXeRDlrIhUC57hwEtbK2z/rFJXTmD+JnE6pdl8vScxjG5
        XbFvHckVMEctsAtI5HY1XWze2+rhpLIVfnLvO95izdgkA7I=
X-Google-Smtp-Source: ABdhPJxvfmWlHnLzPuilL4agSr4TAsCc+J9VBz7Sgsf7gQ5q6tbFtNka+PBK85p90ZM+PPLnrZIXqnwFmp5rXHiBmbE=
X-Received: by 2002:a63:3481:0:b0:372:f3e7:6f8c with SMTP id
 b123-20020a633481000000b00372f3e76f8cmr28112361pga.336.1646263090531; Wed, 02
 Mar 2022 15:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20220301065745.1634848-1-memxor@gmail.com> <20220301065745.1634848-5-memxor@gmail.com>
 <20220302032024.knhf2wyfiscjy73p@kafai-mbp> <20220302094218.5gov4mdmyiqfrt6p@apollo.legion>
 <20220302215640.2thsbd4blxbfd7tk@kafai-mbp> <20220302223020.3vmwknct24pplzzr@apollo.legion>
 <20220302224418.5ph7nkzx2qmcy36n@ast-mbp.dhcp.thefacebook.com> <20220302230047.7xjekpuivrbno5cp@apollo.legion>
In-Reply-To: <20220302230047.7xjekpuivrbno5cp@apollo.legion>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Mar 2022 15:17:59 -0800
Message-ID: <CAADnVQLPpCLLTQZdeXWfx_Ey-4mrs_=yuL48dVpi839hq9No+A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 4/6] bpf: Harden register offset checks for
 release kfunc
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Wed, Mar 2, 2022 at 3:00 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> >
> > fwiw I like patches 1-3.
> > I think extra check here for release func is justified on its own.
> > Converting it into:
> >   fixed_off_ok = false;
> >   if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
> >           fixed_off_ok = true;
> > obfuscates the check to me.
>
> I was talking of putting this inside check_func_arg_reg_off. I think we should
> do the same check for BPF helpers as well (rn only one supports releasing
> PTR_TO_BTF_ID, soon we may have others). Just passing a bool to
> check_func_arg_reg_off to indicate we are checking for release func (helper or
> kfunc have same rules here) would allow putting this check inside it.

Hmm. check_func_arg() is called before we call
is_release_function(func_id).
Are you proposing to call it before and pass
another boolean into check_func_arg() or store the flag in meta?
Sounds ugly.
imo reg->off is a simple enough check to keep it open coded
where necessary.
