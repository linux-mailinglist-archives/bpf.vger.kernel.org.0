Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01FB93B77A3
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 20:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhF2SPw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Jun 2021 14:15:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:44578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhF2SPw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Jun 2021 14:15:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0F83261D5D;
        Tue, 29 Jun 2021 18:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624990404;
        bh=aZX4JEQo02GcZ63aLJjvA2B8/bbn7n66bisTKDTPYtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=de9J/O0ZmtNnkt2+s+k4Hq3vxbrJzTbE3P/Wh6oNj1zCUykyCay/isy8kU33jbPZP
         09v09LCsAm8OyNpcqErymAg+MOkY6Mm+TMuHCyv+VZsnngc9LW1nWsxOGkRyvcuJhl
         t7W/q4qyV8nqmaD0sfor+sVevPvW5hoLsRnaNGfA=
Date:   Tue, 29 Jun 2021 20:13:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rumen Telbizov <rumen.telbizov@menlosecurity.com>
Cc:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
        bpf@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <brouer@redhat.com>
Subject: Re: [PATCH 1/3] bpf: Add support for mark with bpf_fib_lookup
Message-ID: <YNtiwhlNPgzhP3uX@kroah.com>
References: <CA+FoirAaqbnYan2NEQVaxZ2s_brPNZ02hRFhW9miyfqn+KVGbA@mail.gmail.com>
 <87wnqc1rvy.fsf@toke.dk>
 <CA+FoirCBPGG=dq6AO39djrrjH82-KL9HoMx=92XZXuKOLA1p=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+FoirCBPGG=dq6AO39djrrjH82-KL9HoMx=92XZXuKOLA1p=A@mail.gmail.com>
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Jun 29, 2021 at 11:06:14AM -0700, Rumen Telbizov wrote:
> Give credit to David Ahern for this patch. Shall we change anything there?

Put him as the From: line like the documentation suggests for stuff like
this.

or use git send-email, it will handle it for you automatically.

thanks,

greg k-h
