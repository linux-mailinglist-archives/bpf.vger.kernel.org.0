Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32C065A6FC
	for <lists+bpf@lfdr.de>; Sat, 31 Dec 2022 21:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbiLaU6z (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 31 Dec 2022 15:58:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLaU6y (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 31 Dec 2022 15:58:54 -0500
X-Greylist: delayed 206 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 31 Dec 2022 12:58:52 PST
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7559D60C2;
        Sat, 31 Dec 2022 12:58:52 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B1B1D1CA00A;
        Sat, 31 Dec 2022 15:55:23 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=l5Z6dWQdVQtlKEa4pcVNXiCPG5nnUO1ELWb6oA
        mN25Y=; b=DbA1SqeOyu/rIvgnr8isbow2nAXsNzTMiW4UXpmzx84FkDWsMSlpw8
        rY4IeIYosnTU7KS363hwRXxaKiH+qrPgS7tSZx6oS2S4tjkLGFM0gctqLqBenBI9
        6vmhd2ZdneAY/k+tW5lwvSL7gFbGkP1dQw4ApL4mUQ3WVNzeE9KrI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 95FA31CA009;
        Sat, 31 Dec 2022 15:55:23 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=1YCJGrbLB6EsdiwWd9H2pjqwOeUMAIqYiajipI4nVNU=; b=kh4Ni2jHIBm6HrzX7bqXNcoWzNii3GTVw+uP21Tu9Tm0vxHMwJ5K5Gyy/vnmiI7MFZFiQUsYvhBWcdKQtK6aBBPvF+nbHi5xZlj5eVORRPDZ5par82PI9c/PuhogFbIw4VfgQlMKZU/XkRF48Ie78YxOeQoe5O5XUWYJlmttQi8=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1EEAC1CA007;
        Sat, 31 Dec 2022 15:55:20 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 017705A6C9C;
        Sat, 31 Dec 2022 15:55:17 -0500 (EST)
Date:   Sat, 31 Dec 2022 15:55:17 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ira Weiny <ira.weiny@intel.com>
cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
Subject: Re: [PATCH] fs/cramfs: Convert kmap() to kmap_local_data()
In-Reply-To: <Y69mtbmmbDcXhiln@iweiny-desk3>
Message-ID: <210n4959-p557-894p-20qp-r595540r0827@syhkavp.arg>
References: <20221012091356.16632-1-fmdefrancesco@gmail.com> <Y69mtbmmbDcXhiln@iweiny-desk3>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1989546398-1672520118=:4092182"
X-Pobox-Relay-ID: 6FE98D26-894D-11ED-A70A-C2DA088D43B2-78420484!pb-smtp20.pobox.com
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1989546398-1672520118=:4092182
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Dec 2022, Ira Weiny wrote:

> On Wed, Oct 12, 2022 at 11:13:56AM +0200, Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page().
> >=20
> > There are two main problems with kmap(): (1) It comes with an overhea=
d as
> > the mapping space is restricted and protected by a global lock for
> > synchronization and (2) it also requires global TLB invalidation when=
 the
> > kmap=E2=80=99s pool wraps and it might block when the mapping space i=
s fully
> > utilized until a slot becomes available.
> >=20
> > With kmap_local_page() the mappings are per thread, CPU local, can ta=
ke
> > page faults, and can be called from any context (including interrupts=
).
> > It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore=
,
> > the tasks can be preempted and, when they are scheduled to run again,=
 the
> > kernel virtual addresses are restored and still valid.
> >=20
> > Since its use in fs/cramfs is safe everywhere, it should be preferred=
.
> >=20
> > Therefore, replace kmap() with kmap_local_page() in fs/cramfs. Instea=
d
> > of open-coding kmap_local_page() + memcpy(), use memcpy_from_page().
> >=20
> > Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> > Suggested-by: Ira Weiny <ira.weiny@intel.com>
>=20
> Nicolas, I was auditing the kmap conversion status and I see you review=
ed this
> but did not merge it.  Are you still the maintainer for fs/cramfs?  Sho=
uld
> Fabio send this to someone else?

Please send it to Al Viro with my reviewed-by.


Nicolas
--8323328-1989546398-1672520118=:4092182--
