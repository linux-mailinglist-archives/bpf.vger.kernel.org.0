Return-Path: <bpf+bounces-75313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 33123C7F09D
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 07:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66F864E29B2
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 06:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E8B2BE64A;
	Mon, 24 Nov 2025 06:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b="NMaVJ26f"
X-Original-To: bpf@vger.kernel.org
Received: from sg-1-40.ptr.blmpb.com (sg-1-40.ptr.blmpb.com [118.26.132.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B851F1F03EF
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763965581; cv=none; b=OGCQ5F2nadCEq3ELT97WcGgBolUI/KoPpe3SubLQF7LNcGohgRBnMDx6JinnTRD4I/Hsjthu4IASqGI9rgjDIDhi8dT2x6XbyD4pPLJFAdbs4oFg1XGWNRkGweIP6OMA4uAz6g7RMZIxTuK6V8jmSAkuhMs2fFtu5YgbvLn+hTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763965581; c=relaxed/simple;
	bh=SkPUzCbU4UnrkhLYBJ4h/u7HrneVKqozjrS7SNDhhFk=;
	h=Date:Content-Type:In-Reply-To:Subject:Mime-Version:References:To:
	 Cc:From:Message-Id; b=Rhtf9cRQsDawI+JEZmXhbuCMsHssLNC4bmDV8DumJFO95e1oYyv27eMYujOIIBCm/1Op6k6BLBZ/CKOiLA8Zl8TFoo+rlVlgnKURhICfWkY/wE2Z4L2SY/GUO+u0MmnYKdbN8/9qM6Xn/9Blo93XCed1ezGczraCCYMoa9G6b64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com; spf=pass smtp.mailfrom=fnnas.com; dkim=pass (2048-bit key) header.d=fnnas-com.20200927.dkim.feishu.cn header.i=@fnnas-com.20200927.dkim.feishu.cn header.b=NMaVJ26f; arc=none smtp.client-ip=118.26.132.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fnnas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fnnas.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fnnas-com.20200927.dkim.feishu.cn; t=1763965451;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=1v8DjKDZXbkovGdNkFJdKNL/RGUBInSERiXq+wqH6GE=;
 b=NMaVJ26f6wCqj655OfZfLoFV8HUO5KA8eptMOPpNT59Q0VF84NED7z1T9jKNzaCerL0OU0
 Nt/skt4isLqE30nJINFcU89+VLzIkhsy1BzaJsFBA0qqUYfBYajIQk4uURYvp+hQkIQTXr
 wSXtzcxprblu4RivsUKndN7uQ7Hn3jwdNGx799dULSVIrM8/uTiR8NUwabxO5bWgt9WU8L
 5ccydH+OW7RoA9qXDY2udcI1niox7gGrCs0jN5CUMUYikBhxik8r4PkILp8Q6aIrP7Wt9C
 LDAIOg8YNaiOXZ9ZuFngyDKzRBhLWoyBSvEb8AQmiXL+rT2BvUX85HSJIZM/Jw==
Date: Mon, 24 Nov 2025 14:24:05 +0800
X-Original-From: Yu Kuai <yukuai@fnnas.com>
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20251124025737.203571-3-ckulkarnilinux@gmail.com>
Subject: Re: [PATCH V2 2/5] dm: ignore discard return value
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251124025737.203571-1-ckulkarnilinux@gmail.com> <20251124025737.203571-3-ckulkarnilinux@gmail.com>
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.153]) by smtp.feishu.cn with ESMTPS; Mon, 24 Nov 2025 14:24:08 +0800
Reply-To: yukuai@fnnas.com
To: "Chaitanya Kulkarni" <ckulkarnilinux@gmail.com>, <axboe@kernel.dk>, 
	<agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>, 
	<song@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <kch@nvidia.com>, 
	<jaegeuk@kernel.org>, <chao@kernel.org>, <cem@kernel.org>, 
	"Yu Kuai" <yukuai@fnnas.com>
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<dm-devel@lists.linux.dev>, <linux-raid@vger.kernel.org>, 
	<linux-nvme@lists.infradead.org>, 
	<linux-f2fs-devel@lists.sourceforge.net>, <linux-xfs@vger.kernel.org>, 
	<bpf@vger.kernel.org>
From: "Yu Kuai" <yukuai@fnnas.com>
Message-Id: <d86b820a-46c9-43b6-9fe2-dbd991b76520@fnnas.com>
Content-Language: en-US
X-Lms-Return-Path: <lba+26923fa09+05a557+vger.kernel.org+yukuai@fnnas.com>
Content-Transfer-Encoding: quoted-printable

Hi,

=E5=9C=A8 2025/11/24 10:57, Chaitanya Kulkarni =E5=86=99=E9=81=93:
> __blkdev_issue_discard() always returns 0, making all error checking
> at call sites dead code.
>
> For dm-thin change issue_discard() return type to void, in
> passdown_double_checking_shared_status() remove the r assignment from
> return value of the issue_discard(), for end_discard() hardcod value
> of r to 0 that matches only value returned from
> __blkdev_issue_discard().
>
> md part is simplified to only check !discard_bio by ignoring the
> __blkdev_issue_discard() value.
>
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>   drivers/md/dm-thin.c | 12 +++++-------
>   drivers/md/md.c      |  4 ++--
>   2 files changed, 7 insertions(+), 9 deletions(-)

mdraid and dm are different drivers, please split them.

>
> diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
> index c84149ba4e38..77c76f75c85f 100644
> --- a/drivers/md/dm-thin.c
> +++ b/drivers/md/dm-thin.c
> @@ -395,13 +395,13 @@ static void begin_discard(struct discard_op *op, st=
ruct thin_c *tc, struct bio *
>   	op->bio =3D NULL;
>   }
>  =20
> -static int issue_discard(struct discard_op *op, dm_block_t data_b, dm_bl=
ock_t data_e)
> +static void issue_discard(struct discard_op *op, dm_block_t data_b, dm_b=
lock_t data_e)
>   {
>   	struct thin_c *tc =3D op->tc;
>   	sector_t s =3D block_to_sectors(tc->pool, data_b);
>   	sector_t len =3D block_to_sectors(tc->pool, data_e - data_b);
>  =20
> -	return __blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op=
->bio);
> +	__blkdev_issue_discard(tc->pool_dev->bdev, s, len, GFP_NOIO, &op->bio);
>   }
>  =20
>   static void end_discard(struct discard_op *op, int r)
> @@ -1113,9 +1113,7 @@ static void passdown_double_checking_shared_status(=
struct dm_thin_new_mapping *m
>   				break;
>   		}
>  =20
> -		r =3D issue_discard(&op, b, e);
> -		if (r)
> -			goto out;
> +		issue_discard(&op, b, e);
>  =20
>   		b =3D e;
>   	}
> @@ -1188,8 +1186,8 @@ static void process_prepared_discard_passdown_pt1(s=
truct dm_thin_new_mapping *m)
>   		struct discard_op op;
>  =20
>   		begin_discard(&op, tc, discard_parent);
> -		r =3D issue_discard(&op, m->data_block, data_end);
> -		end_discard(&op, r);
> +		issue_discard(&op, m->data_block, data_end);
> +		end_discard(&op, 0);
>   	}
>   }
>  =20
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 7b5c5967568f..aeb62df39828 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -9132,8 +9132,8 @@ void md_submit_discard_bio(struct mddev *mddev, str=
uct md_rdev *rdev,
>   {
>   	struct bio *discard_bio =3D NULL;
>  =20
> -	if (__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO,
> -			&discard_bio) || !discard_bio)
> +	__blkdev_issue_discard(rdev->bdev, start, size, GFP_NOIO, &discard_bio)=
;
> +	if (!discard_bio)
>   		return;
>  =20
>   	bio_chain(discard_bio, bio);

--=20
Thanks
Kuai

