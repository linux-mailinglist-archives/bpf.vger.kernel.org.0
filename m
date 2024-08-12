Return-Path: <bpf+bounces-36908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D4D894F54C
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 18:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76E81B26EA1
	for <lists+bpf@lfdr.de>; Mon, 12 Aug 2024 16:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A0D18757C;
	Mon, 12 Aug 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bivMigPw"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A8C1836E2;
	Mon, 12 Aug 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723481489; cv=none; b=LbXgzjenSLC9BXY6OihMpL8ApbHwTuM61a0EUdOmcm1BgRt70K98iw2jVTGtdbpzd6qHlQ+aPyJYZNqK7zqmD1M0HcNrQYNBXEUNv0/DgqQ6dK62+87QFZtL5k/2hX2uVbyTrQ/aYHXX96TeKRj3TfR8DQWge8AqjImE0kXPoQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723481489; c=relaxed/simple;
	bh=LGTlsEWy9JCGyazAemGTJCuuwrCAe2BvnYB/olyIPXU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GNDOc2uNYUgs4HVApBQiIOh2UBJ9Dk3VzL1EJy0/SGpBwy2y32u4WNV7NFlgDGuw0w/WdfDG3JtlxYy5iBa0Ik/Ul9gAdtDVVzsLWgXsNAvz8VT8pbn5FzINWD51xToAaxHaX6Y9DzGOfArCY28NuYreJOtnqH1USJqS2Lxj0tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bivMigPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28675C32782;
	Mon, 12 Aug 2024 16:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723481489;
	bh=LGTlsEWy9JCGyazAemGTJCuuwrCAe2BvnYB/olyIPXU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bivMigPwThXLkTGwe6eS7CAyYRKGSG8saGAE2CUUHcNuiJqIv+JXbLGyTMhKpBl3l
	 +Z2jAX9lLzuvjlUWQyRjfqsHneXKrP3VJX+IiObEcORL+wCZdZ1ZYwW9AbQSwmZSIQ
	 B9AMXMH2vMnDvZLP4BxGQ1GvBMTKI5IznbuDIfUwqR+Dnqn8bxnK2fB1EGSyewHcdj
	 q4oUaAB8RtV7HHdcHogbbl6+S87CVooVAeE61XzqDxcMDsAqTZEcodwylKhuBbOlnf
	 V7G7BFgpvSgQqeDBBV9yIDcn5YxxuG+5YRAY+chc0EnsO0Xcvpsaf0wICjlc0LQ0w3
	 pGuB3qZmJn8Og==
Message-ID: <c0a0266cbb46694318e5eeb5248216779cb68442.camel@kernel.org>
Subject: Re: [PATCH] btrfs: update target inode's ctime on unlink
From: Jeff Layton <jlayton@kernel.org>
To: dsterba@suse.cz
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David
 Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org,  bpf@vger.kernel.org
Date: Mon, 12 Aug 2024 12:51:21 -0400
In-Reply-To: <20240812164220.GK25962@twin.jikos.cz>
References: <20240812-btrfs-unlink-v1-1-ee5c2ef538eb@kernel.org>
	 <20240812164220.GK25962@twin.jikos.cz>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=mQINBE6V0TwBEADXhJg7s8wFDwBMEvn0qyhAnzFLTOCHooMZyx7XO7dAiIhDSi7G1NPxw
 n8jdFUQMCR/GlpozMFlSFiZXiObE7sef9rTtM68ukUyZM4pJ9l0KjQNgDJ6Fr342Htkjxu/kFV1Wv
 egyjnSsFt7EGoDjdKqr1TS9syJYFjagYtvWk/UfHlW09X+jOh4vYtfX7iYSx/NfqV3W1D7EDi0PqV
 T2h6v8i8YqsATFPwO4nuiTmL6I40ZofxVd+9wdRI4Db8yUNA4ZSP2nqLcLtFjClYRBoJvRWvsv4lm
 0OX6MYPtv76hka8lW4mnRmZqqx3UtfHX/hF/zH24Gj7A6sYKYLCU3YrI2Ogiu7/ksKcl7goQjpvtV
 YrOOI5VGLHge0awt7bhMCTM9KAfPc+xL/ZxAMVWd3NCk5SamL2cE99UWgtvNOIYU8m6EjTLhsj8sn
 VluJH0/RcxEeFbnSaswVChNSGa7mXJrTR22lRL6ZPjdMgS2Km90haWPRc8Wolcz07Y2se0xpGVLEQ
 cDEsvv5IMmeMe1/qLZ6NaVkNuL3WOXvxaVT9USW1+/SGipO2IpKJjeDZfehlB/kpfF24+RrK+seQf
 CBYyUE8QJpvTZyfUHNYldXlrjO6n5MdOempLqWpfOmcGkwnyNRBR46g/jf8KnPRwXs509yAqDB6sE
 LZH+yWr9LQZEwARAQABtCBKZWZmIExheXRvbiA8amxheXRvbkBrZXJuZWwub3JnPokCOAQTAQIAIg
 UCWe8u6AIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQAA5oQRlWghUuCg/+Lb/xGxZD2Q1
 oJVAE37uW308UpVSD2tAMJUvFTdDbfe3zKlPDTuVsyNsALBGclPLagJ5ZTP+Vp2irAN9uwBuacBOT
 tmOdz4ZN2tdvNgozzuxp4CHBDVzAslUi2idy+xpsp47DWPxYFIRP3M8QG/aNW052LaPc0cedYxp8+
 9eiVUNpxF4SiU4i9JDfX/sn9XcfoVZIxMpCRE750zvJvcCUz9HojsrMQ1NFc7MFT1z3MOW2/RlzPc
 og7xvR5ENPH19ojRDCHqumUHRry+RF0lH00clzX/W8OrQJZtoBPXv9ahka/Vp7kEulcBJr1cH5Wz/
 WprhsIM7U9pse1f1gYy9YbXtWctUz8uvDR7shsQxAhX3qO7DilMtuGo1v97I/Kx4gXQ52syh/w6EB
 ny71CZrOgD6kJwPVVAaM1LRC28muq91WCFhs/nzHozpbzcheyGtMUI2Ao4K6mnY+3zIuXPygZMFr9
 KXE6fF7HzKxKuZMJOaEZCiDOq0anx6FmOzs5E6Jqdpo/mtI8beK+BE7Va6ni7YrQlnT0i3vaTVMTi
 CThbqsB20VrbMjlhpf8lfK1XVNbRq/R7GZ9zHESlsa35ha60yd/j3pu5hT2xyy8krV8vGhHvnJ1XR
 MJBAB/UYb6FyC7S+mQZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-08-12 at 18:42 +0200, David Sterba wrote:
> On Mon, Aug 12, 2024 at 12:30:52PM -0400, Jeff Layton wrote:
> > Unlink changes the link count on the target inode. POSIX mandates that
> > the ctime must also change when this occurs.
>=20
> Right, thanks. According to https://pubs.opengroup.org/onlinepubs/9699919=
799/functions/unlink.html:
>=20
> Upon successful completion, unlink() shall mark for update the last data
> modification and last file status change timestamps of the parent
> directory. Also, if the file's link count is not 0, the last file status
> change timestamp of the file shall be marked for update.
>=20

Weird way to phrase to that. IMO, we still want to stamp the inode's
ctime even if the link count goes to 0. That's what Linux generally
does, anyway. Oh well..
=20
>=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
>=20
> Reviewed-by: David Sterba <dsterba@suse.com>


FWIW, this should probably go in via the btrfs tree.=20
--=20
Jeff Layton <jlayton@kernel.org>

