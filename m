Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A440B58E43D
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 02:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbiHJAw1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 20:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHJAw0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 20:52:26 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4EDD7E817
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 17:52:25 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id r6so7472338ilc.12
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 17:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=p2o2JFNFjx5j8Ih+4dyhgoDXa69sErXd7ppWCeTc9mM=;
        b=d1ZS5SmlPxZTVErtqNtFRKQFQpzYxbKV7/s9I7R4U4iio2swzWXabaRS/pJPnnchJX
         fkjUxrBEqtfABbx9zBiGzWxfrWRn6Do7NEbjH6fy6W4qKLBoFh9bGXJgKBsYUMmkC3ey
         AzUOuXVKJ1B4Zc9qJwBzYjvHvV28OsB6Sxm/Sr38aEmXoNqMtT4Zv20uT1CVyrbldhV5
         B3wFfaAMhjuYN8I/sd9vNdlQzX5aWzaBg0ugdZTAKNREHaP3ZqHzq0pMlFIsjpW7t8JP
         pprNhhL1jmNuRAjoCBsHcpw/+Go5pHrwDSm2EM/sbBekOBOJLZUAb5M4nKJhLJ4zJ9Hg
         ctzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=p2o2JFNFjx5j8Ih+4dyhgoDXa69sErXd7ppWCeTc9mM=;
        b=dSxmIlO1oUMDu31TdbivleaB6eQ4cCEwOFAr6kZdNvp2Ni2EBux7EjKZk38qk/yG77
         JgdmWXOZm6Rb4b3FpkRP0w5vWkvV1AV9eHdboEuuApUwYFtP/QHDk3cDmMSief0k+E4l
         GVCWPpfkB02tNpf0O1oTUIu+xSapuiC1f41H6jemlH+jyL1Dp0IlQlGSdi7ePR5XkKOw
         cxKr39rBizFiKfU3kss9fIEqv3pBxw5+6cesmW/DygT0iNck8AFgbIp25Y1MJ+9QB81G
         yjL/Rd0OOuAN7hsXwijNy/ea/U77Iy6QstQUoMqpcY0Sdhldl/uNfOQApyU0BsgxK0qb
         gbYA==
X-Gm-Message-State: ACgBeo3g2MG0kQUk87xBl6cvernRDglY1T3JlcSlzwspx1RW+N+D4Bws
        SG76/B5N3bbxdDZLb+RpV4u8W8CBLetXcXaH/4A=
X-Google-Smtp-Source: AA6agR4MmEhYTR8zxjqUrDKHLnJ7sb0/kOGASIPIclhj9kBnk4lFDtNE6uTTDfqU0+HSvEsCBdKrtpVF1VGmdbJ1MMw=
X-Received: by 2002:a92:d606:0:b0:2dc:e2d1:b75b with SMTP id
 w6-20020a92d606000000b002dce2d1b75bmr11841898ilm.91.1660092744832; Tue, 09
 Aug 2022 17:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220809213033.24147-1-memxor@gmail.com> <20220809213033.24147-3-memxor@gmail.com>
 <20220809222908.hmy4pz3ai6howqhm@kafai-mbp> <CAADnVQ+X3qxf2ksRSLT0ZK792Pz4LA5xc3G+EPL8cAQEUS=tGA@mail.gmail.com>
In-Reply-To: <CAADnVQ+X3qxf2ksRSLT0ZK792Pz4LA5xc3G+EPL8cAQEUS=tGA@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Wed, 10 Aug 2022 02:51:49 +0200
Message-ID: <CAP01T742w_xbDU6muUbPjT11noVgL8ofR5m-7wbjaH-FxXRi3w@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/3] bpf: Don't reinit map value in prealloc_lru_pop
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Martin KaFai Lau <kafai@fb.com>, bpf <bpf@vger.kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Wed, 10 Aug 2022 at 02:50, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Aug 9, 2022 at 3:29 PM Martin KaFai Lau <kafai@fb.com> wrote:
> >
> > On Tue, Aug 09, 2022 at 11:30:32PM +0200, Kumar Kartikeya Dwivedi wrote:
> > > The LRU map that is preallocated may have its elements reused while
> > > another program holds a pointer to it from bpf_map_lookup_elem. Hence,
> > > only check_and_free_fields is appropriate when the element is being
> > > deleted, as it ensures proper synchronization against concurrent access
> > > of the map value. After that, we cannot call check_and_init_map_value
> > > again as it may rewrite bpf_spin_lock, bpf_timer, and kptr fields while
> > > they can be concurrently accessed from a BPF program.
> > >
> > > This is safe to do as when the map entry is deleted, concurrent access
> > > is protected against by check_and_free_fields, i.e. an existing timer
> > > would be freed, and any existing kptr will be released by it. The
> > > program can create further timers and kptrs after check_and_free_fields,
> > > but they will eventually be released once the preallocated items are
> > > freed on map destruction, even if the item is never reused again. Hence,
> > > the deleted item sitting in the free list can still have resources
> > > attached to it, and they would never leak.
> > >
> > > With spin_lock, we never touch the field at all on delete or update, as
> > > we may end up modifying the state of the lock. Since the verifier
> > > ensures that a bpf_spin_lock call is always paired with bpf_spin_unlock
> > > call, the program will eventually release the lock so that on reuse the
> > > new user of the value can take the lock.
> > The bpf_spin_lock's verifier description makes sense.  Note that
> > the lru map does not support spin lock for now.
>
> ahh. then it's not a bpf tree material.
> It's a minor cleanup for bpf-next?
>

I was just describing what we do for each of the three types in the
commit log. It still affects timers and kptrs, which lru map supports.

> > >
> > > Essentially, for the preallocated case, we must assume that the map
> > > value may always be in use by the program, even when it is sitting in
> > > the freelist, and handle things accordingly, i.e. use proper
> > > synchronization inside check_and_free_fields, and never reinitialize the
> > > special fields when it is reused on update.
> > Acked-by: Martin KaFai Lau <kafai@fb.com>
