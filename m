Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCAA65A3583
	for <lists+bpf@lfdr.de>; Sat, 27 Aug 2022 09:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiH0HT6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 27 Aug 2022 03:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbiH0HT5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 27 Aug 2022 03:19:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A10220D9;
        Sat, 27 Aug 2022 00:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A40260B3F;
        Sat, 27 Aug 2022 07:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA56C433C1;
        Sat, 27 Aug 2022 07:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661584793;
        bh=YgbBYTSHjSokRb2qHtjrG0P3cBnZxmrktBYWXk9PcSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T5W9lm89KHu34/aeb/BIifUQ7e1v8enARGT5+iFLAf3MNpFB58efC53Cbr81jGwtE
         HiOgRY/+U+PPLN12wRCe/S7GeLIOlFuZHYGP5Ah7ovKEbVYtUcDQWd4JAWulnKlb1y
         m6beUzU+SjNY/WrGMadPSmnHa0wBxMNUQMXZ1ChU=
Date:   Sat, 27 Aug 2022 09:20:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "G. Branden Robinson" <g.branden.robinson@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>,
        Quentin Monnet <quentin@isovalent.com>,
        bpf <bpf@vger.kernel.org>, linux-man <linux-man@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH] Fit line in 80 columns
Message-ID: <YwnFp9BKmpi7UXUX@kroah.com>
References: <20220825175653.131125-1-alx.manpages@gmail.com>
 <CAADnVQ+yM_R4vuCLxtNJb0sp61ar=grJh9KmLWVGhXA7Lhpmvw@mail.gmail.com>
 <20220825225425.hp2ylp5rxq453ewl@illithid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825225425.hp2ylp5rxq453ewl@illithid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 25, 2022 at 05:54:25PM -0500, G. Branden Robinson wrote:
> [sorry for the big CC]
> 
> At 2022-08-25T11:06:55-0700, Alexei Starovoitov wrote:
> > Nack.
> > 
> > We don't follow 80 char limit and are not going to because of man
> > pages.
> 
> If someone got a contract with O'Reilly or No Starch Press to write a
> book on BPF and how revolutionarily awesome it is, it's conceivable they
> would be faced with exposing some BPF-related function declarations in
> the text.  In cases like the following, what would you have them do?
> 
> int bpf_map_update_elem(struct bpf_map *map, const void *key, const void *value, u64 flags)
> 
> Be aware that the author may not have infinite flexibility; publishers
> generally impose a "house style" which restricts selection of typeface
> (so they can't necessarily print at a smaller type size or with the
> kerning reduced beyond a certain point to squeeze the text onto the
> line).

As someone who has written a book for one of those publishers you
mention above, this is totally not an issue at all.  Authors and
typesetters know how to properly wrap and handle stuff like this
automatically, it's what they do and has nothing to do with how kernel
header files are layed out.

But even then, if it was an issue, we don't write kernel code for "some
potential commercial entity that can't handle long lines", you know
better than this :)

greg k-h
