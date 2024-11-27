Return-Path: <bpf+bounces-45725-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75BDE9DAB3B
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 875EF165FFF
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 15:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C558820013C;
	Wed, 27 Nov 2024 15:58:02 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07110200127;
	Wed, 27 Nov 2024 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732723082; cv=none; b=KFnKAMg3kgReQvKx5Shxd74K2ktw2DVN+wx+GqZG1cY8vvYMPbLocTjJseBW0kxFIifo1tzPEfCtWgAPWZ0FaZ+o2vYV0zTDCZ5sDGqLh3IHqY9U4XQOCS4/4faF55aBCQ0gV3zEkat5nmficimlfHKp+9uBrrE5CGiSGGSGtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732723082; c=relaxed/simple;
	bh=WLaj8Mili5XLkily00vB+aPjJXbRsughMjY1++2Z0e0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KqQqQLRH17ltvlG5S66kvUeRCP63xRUzzMszyMWxsu8c0rdoCjviVgUdj99sYpRWadkxRyWOMpCtKoZJ3ChNw/hlK84NDUGC8vqJrBsFtFHbtXx32PvFuvQR4K18UqRCE7htA8FkibjRbNZpnmA45YNadhb3raQmJZD390wRkh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Xz3TD0Bs1z9v7J5;
	Wed, 27 Nov 2024 23:36:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id A7C9E1403D2;
	Wed, 27 Nov 2024 23:57:42 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwB36TlsQUdnTGRlAg--.61578S2;
	Wed, 27 Nov 2024 16:57:42 +0100 (CET)
Message-ID: <9c8979adb9b575d2f938043f61e2be82c898632a.camel@huaweicloud.com>
Subject: Re: [PATCH 1/3] ima: Remove inode lock
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Shu Han <ebpqwerty472123@gmail.com>
Cc: zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com,  paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 27 Nov 2024 16:57:27 +0100
In-Reply-To: <CAHQche-W2VxB+EJQRHUAWr4=850sX1ZfzzZUFJChUx8j6dW9Hw@mail.gmail.com>
References: <20241008165732.2603647-1-roberto.sassu@huaweicloud.com>
	 <CAHQche-W2VxB+EJQRHUAWr4=850sX1ZfzzZUFJChUx8j6dW9Hw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwB36TlsQUdnTGRlAg--.61578S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Jr1xur1UGw15Gw18Aw43Wrg_yoWDtwbEgF
	90v34vyw18Xan5Wa1vkrs3GFZ3ta1rWw18CFZrArW0vw15Jrs8XFWruryfZrWrJasxtrs0
	kFWSg348K34q9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbx8YFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AK
	xVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFyl
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UAwI
	DUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABGdGg7UGkwAAsH

On Wed, 2024-10-09 at 23:59 +0800, Shu Han wrote:
> > Finally, expand the critical region in process_measurement()
> > guarded by
> > iint->mutex up to where the inode was locked, use only one iint
> > lock in
> > __ima_inode_hash(), since the mutex is now in the inode security
> > blob, and
> > replace the inode_lock()/inode_unlock() calls in
> > ima_check_last_writer().
>=20
> I am not familiar with this, so the following statement may be
> inaccurate:
>=20
> I suspect that modifying the `i_flags` field through
> `inode->i_flags |=3D S_IMA;` in `ima_inode_get` may cause a
> race, as this patch removes the write lock for inodes in
> process_measurement().
>=20
> For example, swapon() adds the S_SWAPFILE tag under inode write
> lock's
> protection.
>=20
> Perhaps this initialization tag(`S_IMA`) can also be moved into
> inode's
> security blob.

It would not even be necessary, since after making IMA as a regular LSM
the S_IMA check can be replaced by testing whether or not the pointer
of inode integrity metadata in the security blob is NULL.

Will remove S_IMA.

Thanks

Roberto


