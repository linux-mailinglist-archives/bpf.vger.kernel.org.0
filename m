Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64973DEB5C
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2019 13:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbfJULuc (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Oct 2019 07:50:32 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22146 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727953AbfJULub (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Oct 2019 07:50:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571658630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KqIaXqYJJipGxJgDMyra1M7Qq5CfHgA1rX/304TpjYk=;
        b=EoUoSkZVfqamItgQl8EMn/p4QAACbKxmO5r5fab59lGlkPNKp0SmO8Tb7pJ/9P/jhAin+k
        rkbF6jQipetwfCk5eG9tW0as5rIcU8kSemg/TLdjCSfouaVNGWFcYUIrDygiP1JVodeKa8
        RqABqCLUCnjA4Sp108qSR/UvWOtuChc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-3BnmQRYyPWu65JTIaDDH8Q-1; Mon, 21 Oct 2019 07:50:29 -0400
Received: by mail-lj1-f198.google.com with SMTP id y12so2369362ljc.8
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2019 04:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=22ZzJtSLeFV5RwYke/b5z8aSCd1uaqRWmq4dpdrIb2M=;
        b=GmRflb7TlPBhmxuJGaU8sbB/JgKa6Z78XG/TtrxrAAoggRmYfO/NivwWLAuZ/r+vhX
         S8ncisDBU4DH7vs9HDOUW9UWc9pTjSGs0ShYt+WTnICHrTpix8NpHJXbpXId23LKWcD1
         ajPIcxe5+/JfgKgViavrCJGkipo3GdqxJcs49VNRUFV4R629dCnoXQtwPOuk905G0mTR
         bAel1uLclbwEwlxLJBULjaRJC3VabuPZOXAzParcV5cLYruTqROcZqNumNBVHacouids
         xd8Fj9XkFmVL7JRFqqPpBr46Ij7L9xstiNP/vypvX27kBFvb9+SARAFRqrq0i/U6t0P0
         R3ww==
X-Gm-Message-State: APjAAAWyqrLRcLEYKdA+M3Q04vh7yArLj0yS/iadyhB/xy/AA5nj6E1x
        NFWzNuYWtwOoSbGFueYC+mbL3roUXLzursxYPj0lNqohdViJU3q/KVNtY3lvuXsAl0Pvfxtxpwt
        h0vgR9l636CPe
X-Received: by 2002:a2e:865a:: with SMTP id i26mr14860441ljj.107.1571658627586;
        Mon, 21 Oct 2019 04:50:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNczjPonFjwpYZEXU76pQodFUabDK3alh7XWG+A3KOjFrGCFb7YhbDPkAD+/RGXwYq7udr6A==
X-Received: by 2002:a2e:865a:: with SMTP id i26mr14860419ljj.107.1571658627321;
        Mon, 21 Oct 2019 04:50:27 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id w18sm9033946ljd.99.2019.10.21.04.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 04:50:26 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A7CC01800E9; Mon, 21 Oct 2019 13:50:25 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, sridhar.samudrala@intel.com
Subject: Re: [PATCH bpf-next v2] libbpf: use implicit XSKMAP lookup from AF_XDP XDP program
In-Reply-To: <20191021105938.11820-1-bjorn.topel@gmail.com>
References: <20191021105938.11820-1-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Mon, 21 Oct 2019 13:50:25 +0200
Message-ID: <87h842qpvi.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 3BnmQRYyPWu65JTIaDDH8Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com> writes:

> From: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
>
> In commit 43e74c0267a3 ("bpf_xdp_redirect_map: Perform map lookup in
> eBPF helper") the bpf_redirect_map() helper learned to do map lookup,
> which means that the explicit lookup in the XDP program for AF_XDP is
> not needed for post-5.3 kernels.
>
> This commit adds the implicit map lookup with default action, which
> improves the performance for the "rx_drop" [1] scenario with ~4%.
>
> For pre-5.3 kernels, the bpf_redirect_map() returns XDP_ABORTED, and a
> fallback path for backward compatibility is entered, where explicit
> lookup is still performed. This means a slight regression for older
> kernels (an additional bpf_redirect_map() call), but I consider that a
> fair punishment for users not upgrading their kernels. ;-)
>
> v1->v2: Backward compatibility (Toke) [2]
>
> [1] # xdpsock -i eth0 -z -r
> [2] https://lore.kernel.org/bpf/87pnirb3dc.fsf@toke.dk/
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@intel.com>
> ---
>  tools/lib/bpf/xsk.c | 45 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)
>
> diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
> index b0f532544c91..391a126b3fd8 100644
> --- a/tools/lib/bpf/xsk.c
> +++ b/tools/lib/bpf/xsk.c
> @@ -274,33 +274,58 @@ static int xsk_load_xdp_prog(struct xsk_socket *xsk=
)
>  =09/* This is the C-program:
>  =09 * SEC("xdp_sock") int xdp_sock_prog(struct xdp_md *ctx)
>  =09 * {
> -=09 *     int index =3D ctx->rx_queue_index;
> +=09 *     int ret, index =3D ctx->rx_queue_index;
>  =09 *
>  =09 *     // A set entry here means that the correspnding queue_id
>  =09 *     // has an active AF_XDP socket bound to it.
> +=09 *     ret =3D bpf_redirect_map(&xsks_map, index, XDP_PASS);
> +=09 *     ret &=3D XDP_PASS | XDP_REDIRECT;

Why the masking? Looks a bit weird (XDP return codes are not defined as
bitmask values), and it's not really needed, is it?

-Toke

