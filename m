Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B096C93CF
	for <lists+bpf@lfdr.de>; Sun, 26 Mar 2023 12:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231892AbjCZKvG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 26 Mar 2023 06:51:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjCZKvF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 26 Mar 2023 06:51:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F99C8A76;
        Sun, 26 Mar 2023 03:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C9DDB802C7;
        Sun, 26 Mar 2023 10:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A25C433EF;
        Sun, 26 Mar 2023 10:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679827862;
        bh=FHPeY0bBNjHJIClJXaIFz3XIcVRJuN+5dh1lhnc4TQM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CVxDi74U3iKq4twMK+8kkrCKlvr2M+DtovQIf+m6/MoMI8tV9dNNLn35EescGXA0u
         AbCepbpeoAUxQL32cB2Eu5vNartY3QDi2OnKwy2kjZHLpggdoe8H4XHhRvrd4BkgID
         XmXJg1QSraCmiZPx8iOutdiJfQJ//6j16+JjgxKyab7UBkT6lJukb1vrTv21vG7IPc
         GItopIEq6QerbRDq/nTn63XDRWIyrD7QuMi5r/nyUNum2+GVJ3HkTHtFC2ccVubWlH
         5nADJvrzqpo4GrWK7Kxu3qIYQe0T3pvZ+kvIHHPKMljUbLelPWGJhABszUAPTmZ/Ev
         m/fImHDjMMYng==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 89AE2A22553; Sun, 26 Mar 2023 12:50:58 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [RFC PATCH bpf-next 08/13] bpf: Alloc and free bpf_map id in
 bpf namespace
In-Reply-To: <20230326092208.13613-9-laoar.shao@gmail.com>
References: <20230326092208.13613-1-laoar.shao@gmail.com>
 <20230326092208.13613-9-laoar.shao@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 26 Mar 2023 12:50:58 +0200
Message-ID: <87mt3z7pm5.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Yafang Shao <laoar.shao@gmail.com> writes:

> We only expose the bpf map id under current bpf namespace to user. The
> map->id is still the id in the init bpf namespace.
>
> The result as follows,
>
> Run bpftool in a new bpf namespace
> $ bpftool map show
> 4: array  name kprobe_b.rodata  flags 0x80
>         key 4B  value 37B  max_entries 1  memlock 360B
>         btf_id 159  frozen

The btf_id is identical for all the different objects in this example
output; surely that can't be right? Copy-paste error? Same thing in the
other patches...

-Toke
