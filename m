Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570E94CB2FF
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 00:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiCBXtl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 18:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiCBXth (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 18:49:37 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F9012E140
        for <bpf@vger.kernel.org>; Wed,  2 Mar 2022 15:48:45 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id w37so2989879pga.7
        for <bpf@vger.kernel.org>; Wed, 02 Mar 2022 15:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oYlfaNa0Seitg9T4VDI81l0LbRv14ezy5c9yD4odAYU=;
        b=iYs1Th1vs5t85JhmNZu8Xlixb26h5jitdS+k9YyBzIhOESYpPSEE4nYQU1fZym5Zs7
         9O5YDGFs22bpXsp5m1UgY1aKGXayAZ5ZrXsWR+h5eqQ2QHzqVe0QdqUj2gukN6sL3qEW
         JRlUF31ggJRaACkrXwswybwhLvAeqQQ4h40LcpfRKzW5zQtxNhoqU4lsb05pe4vzAcRa
         LuXI27v1dL6ncYoxruvKaJkcwamK+iZL6pjDZT8H2hzhqKUU1tZYkPuaLTar8ZI/djnu
         +SNRyx9TYmXnYaPrKE4EKzY/BPwbV39OzONsMVKOQyuaVBAXECcFOGEbCwxFUNL28fPZ
         AahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oYlfaNa0Seitg9T4VDI81l0LbRv14ezy5c9yD4odAYU=;
        b=2Rt0DDbM4RP5/Di8RKMKFY++Ril/EyugGXV+WzbjB4xJjqlOc/IcFZJcsDoPE1sYzJ
         hrs7v+oH3V/526MiI3pPu2J6QrjyCInZiWCcDiwoQQ/q4LO1yTsogGxciF06ahB/WRg+
         SLaAyXYwxvc5tpPD+z2V/uuncSpNTH5+xS19rvuaon+hvken5F5Qh01DveIPa5xn34HC
         lwhmu55lbQ+1oSa3pgbf6e21e2aDRvEtb6ybTH9Jsj1znWKEGli9i3gcKfZWXNX6qlbw
         ZgQDR5FqRSRzGgzqaNX145ND35ezCZtDMHua83O417FtZam8Gw4XJmGOtNZ6TkXHVhsJ
         VwOw==
X-Gm-Message-State: AOAM531mN702ehxW2iM9mRMtxChI+LuZTSgKOR+fsaNBoIapaoSUtzVW
        /Yq0gMRlJ3FZtKj0F1uqqEJsqEIROAnlPmbTYzHIxdr9WCg=
X-Google-Smtp-Source: ABdhPJwJMFA/ILZz+wlcWISCP6dD2XIX/oXtqjm7HZPjBbpiJsZHTu60KPQBuRgURVN/6m0rpC6AAiC1iRKNsKbwZl8=
X-Received: by 2002:a05:6a00:809:b0:4f1:14bb:40b1 with SMTP id
 m9-20020a056a00080900b004f114bb40b1mr35668681pfk.69.1646264386132; Wed, 02
 Mar 2022 15:39:46 -0800 (PST)
MIME-Version: 1.0
References: <20220301065745.1634848-1-memxor@gmail.com> <20220301065745.1634848-5-memxor@gmail.com>
 <20220302032024.knhf2wyfiscjy73p@kafai-mbp> <20220302094218.5gov4mdmyiqfrt6p@apollo.legion>
 <20220302215640.2thsbd4blxbfd7tk@kafai-mbp> <20220302223020.3vmwknct24pplzzr@apollo.legion>
 <20220302224418.5ph7nkzx2qmcy36n@ast-mbp.dhcp.thefacebook.com>
 <20220302230047.7xjekpuivrbno5cp@apollo.legion> <CAADnVQLPpCLLTQZdeXWfx_Ey-4mrs_=yuL48dVpi839hq9No+A@mail.gmail.com>
 <20220302232952.2p7nn5bzqaflftev@apollo.legion>
In-Reply-To: <20220302232952.2p7nn5bzqaflftev@apollo.legion>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 2 Mar 2022 15:39:35 -0800
Message-ID: <CAADnVQ+VpaBy4bcKBwmhyGT70LU+EhvE_o3KOba4NzE7QA=K-A@mail.gmail.com>
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

On Wed, Mar 2, 2022 at 3:29 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> On Thu, Mar 03, 2022 at 04:47:59AM IST, Alexei Starovoitov wrote:
> > On Wed, Mar 2, 2022 at 3:00 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> > > >
> > > > fwiw I like patches 1-3.
> > > > I think extra check here for release func is justified on its own.
> > > > Converting it into:
> > > >   fixed_off_ok = false;
> > > >   if (type == PTR_TO_BTF_ID && (!is_release_func || !reg->ref_obj_id))
> > > >           fixed_off_ok = true;
> > > > obfuscates the check to me.
> > >
> > > I was talking of putting this inside check_func_arg_reg_off. I think we should
> > > do the same check for BPF helpers as well (rn only one supports releasing
> > > PTR_TO_BTF_ID, soon we may have others). Just passing a bool to
> > > check_func_arg_reg_off to indicate we are checking for release func (helper or
> > > kfunc have same rules here) would allow putting this check inside it.
> >
> > Hmm. check_func_arg() is called before we call
> > is_release_function(func_id).
> > Are you proposing to call it before and pass
> > another boolean into check_func_arg() or store the flag in meta?
>
> We save meta.func_id before calling check_func_arg. Inside it we can do:
> err = check_func_arg_reg_off(env, reg, regno, arg_type, is_release_function(meta->func_id));
>
> I actually tried open coding it for BPF helpers, and it was more complicated. If
> we delay this check until is_release_function call after check_func_arg, we need
> to remember if reg for whom meta->ref_obj_id had off > 0 and type PTR_TO_BTF_ID.
> If we put it inside check_reg_type or check_func_arg, you need to call
> is_release_function anyway there.
>
> Compared to these two options, doing it in check_func_arg_reg_off looks better
> to me, but ymmv.

I see. Yeah. You're right.
check_func_arg_reg_off(env, reg, regno, arg_type,
  is_release_function(meta->func_id))
is indeed cleaner.
