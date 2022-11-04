Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0D86192AD
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 09:22:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKDIWl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 04:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiKDIWk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 04:22:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E982657A
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 01:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7537462102
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 08:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325B3C433C1;
        Fri,  4 Nov 2022 08:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667550157;
        bh=ro//EeDKCdKxzssy85BEqNq4vazlbafQHh9yaicVW94=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=V8StmH3xMBhPIQbUjMjf4soHkHPsUwgK5p09nWndeRqRpByEO7RWLSBFveggyqgMj
         cH+rD/e9HUOY7sO6qiKLqdj2kgn1XXcHlIaEwmK27mc6LcSMXY80GPj9lQhsrcG+rQ
         qd+y1K0IBrl40t9+qqMFy1LS8YLfah+uex5u3rNPdriGsKO+QB0LD9+Fk/v817JGdb
         hyfZ3F40DBj9vJ7HE0Wnl81eA0e9rttqOk0I7EH8tP/JBCvit5OjWoCA6Nuc+ydycy
         zk0M681L0pJ2Oa933bLQGQy2MevQnqK5aRRYl39Qs8r9a8K7EaEtFATPdd14tzdOhV
         Kto4Z4lOSvLVw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: Re: [PATCH bpf-next] xsk: fix destination buffer address when
 copying with metadata
In-Reply-To: <20221104032311.1606050-1-sdf@google.com>
References: <20221104032311.1606050-1-sdf@google.com>
Date:   Fri, 04 Nov 2022 09:22:34 +0100
Message-ID: <87leori0xh.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Stanislav Fomichev <sdf@google.com> writes:

> While working on a simplified test for [0] it occurred to me that
> the following looks fishy:
>
> 	data =3D xsk_umem__get_data(xsk->umem_area, rx_desc->addr);
> 	data_meta =3D data - sizeof(my metadata);
>
> Since the data points to umem frame at addr X, data_mem points to
> the end of umem frame X-1.
>
> I don't think it's by design?

It is by design. :-)

> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 9f0561b67c12..0547fe37ba7e 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -163,7 +163,7 @@ static void xsk_copy_xdp(struct xdp_buff *to, struct =
xdp_buff *from, u32 len)
>  	} else {
>  		from_buf =3D from->data_meta;
>  		metalen =3D from->data - from->data_meta;
> -		to_buf =3D to->data - metalen;

This is to include the XDP meta data in the receive buffer. Note that
AF_XDP descriptor that you get back on the RX ring points to the *data*
not the metadata.

For the unaligned mode you can pass any address (umem offset) into the
fill ring, and the kernel will simply mask it and setup headroom
accordingly.

The buffer allocator guarantees that there's XDP_PACKET_HEADROOM
available.

IOW your example userland code above is correct.


Bj=C3=B6rn


