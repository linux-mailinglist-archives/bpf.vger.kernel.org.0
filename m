Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B275FCB2F
	for <lists+bpf@lfdr.de>; Wed, 12 Oct 2022 20:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiJLS5t (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 12 Oct 2022 14:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJLS5s (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Oct 2022 14:57:48 -0400
X-Greylist: delayed 219 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 12 Oct 2022 11:57:46 PDT
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C773AD;
        Wed, 12 Oct 2022 11:57:45 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6AD551551EE;
        Wed, 12 Oct 2022 14:54:05 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=ocnc+2r0vxqNuyxVHePXxoUh1gWAZCMQYekr3k
        sGhDo=; b=DibnxC3UKNnsAlNgebz3YPB2R6yF2VAhQsDyP67brysCvirgGEdpG6
        N2+uEvnO11hoaqA5yHpd2mv5Hz8seaJ9I2P2IJz1X0mbhnR9/RurZI/oLt/DWcNt
        KtvkyCWxK4FFktsEtLnUkI84RVXcnnkls950GnFdLViShtKGMxOBY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 603FF1551ED;
        Wed, 12 Oct 2022 14:54:05 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=81lGIyVyMpAU5HDAaXAdVFPBsmczXQLcnAYTitfm3/U=; b=Gl7MxQiaAyFnzvFaaJiexzUcJdrSC+LQMlOBFbw4eSrc/DeuczqmhDPiL4Ls9nLDZweTc3X60O09SsAsVO7K9LABGEKqellAyhfLsX8vTvOm59xf5mLIq0I8EZ10UieB/jdy17gFnwfHxzcGOgrAXalfGttXjOf9r1s4s+9v1b0=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BF4D31551EC;
        Wed, 12 Oct 2022 14:54:04 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 6D50E47DF06;
        Wed, 12 Oct 2022 14:54:03 -0400 (EDT)
Date:   Wed, 12 Oct 2022 14:54:03 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
cc:     Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH] fs/cramfs: Convert kmap() to kmap_local_data()
In-Reply-To: <20221012091356.16632-1-fmdefrancesco@gmail.com>
Message-ID: <87672pr-o821-qns6-11rp-902sp1s34r3@syhkavp.arg>
References: <20221012091356.16632-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1044884447-1665600843=:1258"
X-Pobox-Relay-ID: 3E6DE3A0-4A5F-11ED-8611-2AEEC5D8090B-78420484!pb-smtp1.pobox.com
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

--8323328-1044884447-1665600843=:1258
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Oct 2022, Fabio M. De Francesco wrote:

> The use of kmap() is being deprecated in favor of kmap_local_page().
>=20
> There are two main problems with kmap(): (1) It comes with an overhead =
as
> the mapping space is restricted and protected by a global lock for
> synchronization and (2) it also requires global TLB invalidation when t=
he
> kmap=E2=80=99s pool wraps and it might block when the mapping space is =
fully
> utilized until a slot becomes available.
>=20
> With kmap_local_page() the mappings are per thread, CPU local, can take
> page faults, and can be called from any context (including interrupts).
> It is faster than kmap() in kernels with HIGHMEM enabled. Furthermore,
> the tasks can be preempted and, when they are scheduled to run again, t=
he
> kernel virtual addresses are restored and still valid.
>=20
> Since its use in fs/cramfs is safe everywhere, it should be preferred.
>=20
> Therefore, replace kmap() with kmap_local_page() in fs/cramfs. Instead
> of open-coding kmap_local_page() + memcpy(), use memcpy_from_page().
>=20
> Cc: "Venkataramanan, Anirudh" <anirudh.venkataramanan@intel.com>
> Suggested-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Reviewed-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  fs/cramfs/inode.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
> index 61ccf7722fc3..c17cbba5d45e 100644
> --- a/fs/cramfs/inode.c
> +++ b/fs/cramfs/inode.c
> @@ -238,8 +238,7 @@ static void *cramfs_blkdev_read(struct super_block =
*sb, unsigned int offset,
>  		struct page *page =3D pages[i];
> =20
>  		if (page) {
> -			memcpy(data, kmap(page), PAGE_SIZE);
> -			kunmap(page);
> +			memcpy_from_page(data, page, 0, PAGE_SIZE);
>  			put_page(page);
>  		} else
>  			memset(data, 0, PAGE_SIZE);
> @@ -815,7 +814,7 @@ static int cramfs_read_folio(struct file *file, str=
uct folio *folio)
> =20
>  	maxblock =3D (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	bytes_filled =3D 0;
> -	pgdata =3D kmap(page);
> +	pgdata =3D kmap_local_page(page);
> =20
>  	if (page->index < maxblock) {
>  		struct super_block *sb =3D inode->i_sb;
> @@ -903,13 +902,13 @@ static int cramfs_read_folio(struct file *file, s=
truct folio *folio)
> =20
>  	memset(pgdata + bytes_filled, 0, PAGE_SIZE - bytes_filled);
>  	flush_dcache_page(page);
> -	kunmap(page);
> +	kunmap_local(pgdata);
>  	SetPageUptodate(page);
>  	unlock_page(page);
>  	return 0;
> =20
>  err:
> -	kunmap(page);
> +	kunmap_local(pgdata);
>  	ClearPageUptodate(page);
>  	SetPageError(page);
>  	unlock_page(page);
> --=20
> 2.37.3
>=20
>=20
--8323328-1044884447-1665600843=:1258--
