Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCAAEDE048
	for <lists+bpf@lfdr.de>; Sun, 20 Oct 2019 21:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725938AbfJTTx0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 20 Oct 2019 15:53:26 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21591 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfJTTx0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 20 Oct 2019 15:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571601204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/RoTulD9MOFa0djSkZWXs2Pa14XJ8IT9sFb5LBl9c74=;
        b=FUKRrDoaLTLKY3Jfoe2fClKQBoUI1XuVN+CHQLxiSTitkYy1o6I4AzlpsspMK/H7/K05he
        KjUOEJAZmKmZJ0Xst9jZGDNU6zR1Sf3TNfWTVyNr3lc8ie8RtG5Hgy4q0YwRx26R0Z6JBc
        UX82OTlL2mxK4hTgFfG01W1ORL1DaTo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-J2uCy1woMs2j_cqUGAPD1w-1; Sun, 20 Oct 2019 15:53:23 -0400
Received: by mail-lj1-f200.google.com with SMTP id z20so2091838ljz.0
        for <bpf@vger.kernel.org>; Sun, 20 Oct 2019 12:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/RoTulD9MOFa0djSkZWXs2Pa14XJ8IT9sFb5LBl9c74=;
        b=CfdU+K07jPqfgP8PR+CMKhJFY6XFbcRsruinzUdWP0lGPVv8y3EVeL4lLhKfX/cdgL
         XUL3hL/Tv0darsRHbxR7DlXMrQragE/gLHE02/mXD9S32/R9Eit+Da5ITCCRM5ZTu2OY
         hzzFonJTB0TI/3IpLOtvYGh8fkmb404Xc1Hxl/aQR6+BEJcMSeVDtAG5IhICcZEOBDxi
         HISfG/myLunsBEsEjRo6CjE0lufu/Uh303zmYr9fxPDAGk4TMDsuYkg0GvMRZTWvZdv/
         Sp99hzzn37DMr0SprWVI8sBxpppPjjTofmAPa2i3RPW1t3F81baD6R8QhhMODZaH4G/I
         UzmQ==
X-Gm-Message-State: APjAAAXKqAZQ4rNJQSYail/G4sn5LsXdpg3i9VY0y9pySajQz9vXpvdg
        4QTfGtg1LPVM299Ta1/8SeGTHV0x2FXHLzqpenUH/2hnJ5/q5CrXCyQDrWpf1Z7oT7gzq8dMbyn
        BT0iCsO2Z+KTv
X-Received: by 2002:a2e:b010:: with SMTP id y16mr12754070ljk.147.1571601202073;
        Sun, 20 Oct 2019 12:53:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx4ufgaRtQlS1mi37PhH0ZYcQojIe7K50PX7Ic+eL6f7Tms3i7R8zmzNBStFWmMLp8JKE/W+w==
X-Received: by 2002:a2e:b010:: with SMTP id y16mr12754058ljk.147.1571601201789;
        Sun, 20 Oct 2019 12:53:21 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id f28sm5937387lfp.28.2019.10.20.12.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2019 12:53:20 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 24BE7180321; Sun, 20 Oct 2019 21:53:19 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@intel.com>,
        bpf@vger.kernel.org, magnus.karlsson@gmail.com,
        magnus.karlsson@intel.com, sridhar.samudrala@intel.com
Subject: Re: [PATCH bpf-next] libbpf: remove explicit XSKMAP lookup from AF_XDP XDP program
In-Reply-To: <20191020170711.22082-1-bjorn.topel@gmail.com>
References: <20191020170711.22082-1-bjorn.topel@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Sun, 20 Oct 2019 21:53:19 +0200
Message-ID: <87pnirb3dc.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: J2uCy1woMs2j_cqUGAPD1w-1
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
> not needed.
>
> This commit removes the map lookup, which simplifies the BPF code and
> improves the performance for the "rx_drop" [1] scenario with ~4%.

Nice, 4% is pretty good!

I wonder if the program needs to be backwards-compatible (with pre-5.3
kernels), though?

You can do that by something like this:

ret =3D bpf_redirect_map(&xsks_map, index, XDP_PASS);
if (ret > 0)
  return ret;

if (bpf_map_lookup_elem(&xsks_map, &index))
   return bpf_redirect_map(&xsks_map, index, 0);
return XDP_PASS;


This works because bpf_redirect_map() prior to 43e74c0267a3 will return
XDP_ABORTED on a non-0 flags value.

-Toke

