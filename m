Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B424A58B2BD
	for <lists+bpf@lfdr.de>; Sat,  6 Aug 2022 01:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241449AbiHEXZ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 5 Aug 2022 19:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238141AbiHEXZ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 5 Aug 2022 19:25:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18F963D1
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 16:25:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00E54B82A2A
        for <bpf@vger.kernel.org>; Fri,  5 Aug 2022 23:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A322C433D7;
        Fri,  5 Aug 2022 23:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659741921;
        bh=unWqnAss6bR3toE5s7SqfXgDg+pVMbIMwb+CWTsmwq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lJmd5+3/PrNCW4OtsHKwY2hM+QHJlw8dXviHTTjpz3RJWgECFUkbCjNLw92QGXwn/
         xMFM7GYP9gcabxylN+mc+tzocQEv41eteJSZbMrDt3JnGH/64zWmsYAcWrYBJMQIzI
         /fU1WP+3y7LL1djom1LfMCgpzXtY498vFi8F/0N9qT0Z6sIc3Ef25QgXZyT4xugt2s
         wcWKSAFvoGCcIx1+wyES1E4eEMLd9CLMIhHcuJx0NTvJF6O86GM0rViwaX44Jq1Phb
         bPlbruxzbhwb8BZjXF71Nd0W/MaLmQrzDP3mfF6JQnUT8hXx6pvJLyrUKDj1L58A0k
         2QBjyul6HHbDA==
Date:   Fri, 5 Aug 2022 16:25:20 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Joanne Koong <joannelkoong@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v1 1/3] bpf: Add skb dynptrs
Message-ID: <20220805162520.4841078e@kernel.org>
In-Reply-To: <CAP01T764J7YR5CLfg0wxRFD+O9EQGUU=BkKk0tVme9HX3pomrg@mail.gmail.com>
References: <20220726184706.954822-1-joannelkoong@gmail.com>
        <20220726184706.954822-2-joannelkoong@gmail.com>
        <20220728233936.hjj2smwey447zqyy@kafai-mbp.dhcp.thefacebook.com>
        <CAJnrk1b2WoHV=iE3j4n_4=2NBP3GaoeD=v-Zt+p-M9N=LApsuQ@mail.gmail.com>
        <20220729213919.e7x6acvqnwqwfnzu@kafai-mbp.dhcp.thefacebook.com>
        <CAJnrk1ZDzM5ir0rpf2kQdW_G4+-woMhULUufdz28DfiB_rqR-A@mail.gmail.com>
        <20220803162540.19d31294@kernel.org>
        <CAP01T764J7YR5CLfg0wxRFD+O9EQGUU=BkKk0tVme9HX3pomrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 5 Aug 2022 00:58:01 +0200 Kumar Kartikeya Dwivedi wrote:
> When I worked on [0], I actually did it a bit like you described in
> the original discussion under the xdp multi-buff thread, but I left
> the other case (where data to be read resides across frag boundaries)
> up to the user to handle, instead of automatically passing in pointer
> to stack and doing the copy for them, so in my case
> xdp_load_bytes/xdp_store_bytes is the fallback if you can't get a
> bpf_packet_pointer for a ctx, offset, len which you can directly
> access. But this was only for XDP, not for skb.
> 
> The advantage with a dynptr is that len for the slice from
> bpf_packet_pointer style helper doesn't have to be a constant, it can
> be a runtime value and since it is checked at runtime anyway, the
> helper's code is the same but access can be done for slices whose
> length is unknown to the verifier in a safe manner. The dynptr is very
> useful as the return value of such a helper.

I see.

> The suggested usage was like this:
> 
>     int err = 0;
>     char buf[N];
> 
>     off &= 0xffff;
>     ptr = bpf_packet_pointer(ctx, off, sizeof(buf), &err);
>     if (unlikely(!ptr)) {
>         if (err < 0)
>             return XDP_ABORTED;
>         err = bpf_xdp_load_bytes(ctx, off, buf, sizeof(buf));
>         if (err < 0)
>             return XDP_ABORTED;
>         ptr = buf;
>     }
>     ...
>     // Do some stores and loads in [ptr, ptr + N) region
>     ...
>     if (unlikely(ptr == buf)) {
>         err = bpf_xdp_store_bytes(ctx, off, buf, sizeof(buf));
>         if (err < 0)
>             return XDP_ABORTED;
>     }
> 
> So the idea was the same, there is still a "flush" (in that unlikely
> branch), but it is done explicitly by the user (which I found less
> confusing than it being done automagically or a by a new flush helper
> which will do the same thing we do here, but YMMV).

Ack, the flush is awkward to create an API for. I presume that's 
the main reason the xdp mbuf discussion wasn't fruitful.
