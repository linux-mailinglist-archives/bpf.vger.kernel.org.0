Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D79E23B776A
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 19:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhF2Rwy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 13:52:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:39084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234228AbhF2Rwy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 13:52:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 313E461DF4;
        Tue, 29 Jun 2021 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624989026;
        bh=lAf8j8yIkP2KSO4wVrI684+ykxwJb39q26u8Ixe/L24=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UqJx2tMLKBlqr5PMJY1/Datp+gmhAvmzTDbzM1uBliVstCVqp1p6cs3YdK74MzA5J
         g6B/0yEK4GiwzBuokN4VPAWnXQ/uU8wjmd9yfinoOa3pHSodd/vXK1as8nMsnExCKu
         PLVYxWZX85Y9C4cYyE9UWLryVSVYcW810yFRnAC4=
Date:   Tue, 29 Jun 2021 19:50:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     bpf@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
Message-ID: <YNtdYESlf558ONT9@kroah.com>
References: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 29, 2021 at 10:37:34AM -0700, Rumen Telbizov wrote:
> Add support for policy routing via marks to the bpf_fib_lookup
> helper. The bpf_fib_lookup struct is constrained to 64B for
> performance. Since the smac and dmac entries are used only for
> output, put them in an anonymous struct and then add a union
> around a second struct that contains the mark to use in the FIB
> lookup.
> 
> Signed-off-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Rumen Telbizov <telbizov@gmail.com>
> ---
>  include/uapi/linux/bpf.h | 16 ++++++++++++++--
>  net/core/filter.c        |  4 ++--
>  2 files changed, 16 insertions(+), 4 deletions(-)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index ec6d85a81744..6c78cc9c3c75 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5925,8 +5925,20 @@ struct bpf_fib_lookup {
>   /* output */
>   __be16 h_vlan_proto;
>   __be16 h_vlan_TCI;
> - __u8 smac[6];     /* ETH_ALEN */
> - __u8 dmac[6];     /* ETH_ALEN */
> +
> + union {
> + /* input */
> + struct {
> + __u32 mark;   /* fwmark for policy routing */
> + /* 2 4-byte holes for input */
> + };

Tabs seem to be eaten and spit back out with spaces from your email
client :(

