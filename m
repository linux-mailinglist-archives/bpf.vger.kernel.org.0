Return-Path: <bpf+bounces-71648-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 065C2BF932C
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 01:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B967B4E88CC
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 23:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094EA2BE7C0;
	Tue, 21 Oct 2025 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="gjvg272/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pXr/+K2y"
X-Original-To: bpf@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC4728CF66;
	Tue, 21 Oct 2025 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088736; cv=none; b=NcAz6YSlWvLhUgwc+EHH7w9ouJ6U8Nle/Myj7jzQ0PcbwEjjsFU9uZ50K3sFhQrD8ifVLMMXgWI4h+4GLRT7XJLpZ1LjqGZEwnuwPvg1vem+LquuTYhkLEnPxvM+tv86gkuQdJq4V0Ar580rmSseM/kOXI5Lr5sxsZPjR3vfDJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088736; c=relaxed/simple;
	bh=B4HDYUTcgrI28lCumPPrBJUSwFQspl6U9kC4EaeO0tQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUwAXoMTVi/KBN9IT8tigXT6HZad97ZRPsQ/LlYV5lrpwIxIFPTO/PdJOEdK2DDmDm8047kdRNxicHFl9IqO/yca1dBAlcTEUrwAqrm/lc7NxmEmNb2DlKekQ4Qq2jVXis5hONIc/bhXMWh947CJl9/vBQRpVZ4PXFqqekRmqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=gjvg272/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pXr/+K2y; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 17C92EC0176;
	Tue, 21 Oct 2025 19:18:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 21 Oct 2025 19:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761088733;
	 x=1761175133; bh=nT/d7pA+6mCx8029HxB41nfMMHiCmLKVqxIlm2Vg1OQ=; b=
	gjvg272/lNHVY04Oe45OJeFgkqIchxjL1xzxELT+IOV/tJJRjRLgM4NDsE9Ga0UT
	26jnW0xpPIKo17EJq3RMeTGEJislwrHF315aHaY4Qf9O5miEb0d3LTlupldkTSo0
	hVo2EvDVmJGQS7hl//0VPXQCIZgomba1aSGnYyh1m9Ab1KIm24/8kZCrUOWS+Wj2
	yI+pObyjcvHTTi0DKV68HPOGH4uAdEX2eGAs54EV9f0s8LefypNh3VaY+I8/xPAx
	PAgVPm4SydXU+uzfFm7NqHvQJ4dQyl5LfPvfFWSB0Ex48dd9udP5ZtyBkc2Bb+cs
	EwkYehLTf+pkMr6NgCT8Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761088733; x=
	1761175133; bh=nT/d7pA+6mCx8029HxB41nfMMHiCmLKVqxIlm2Vg1OQ=; b=p
	Xr/+K2yYksXd3xjVTjEty0773VJPCDKaKtZ7yWJpnG3rU6A0icrBrjERq7EPXR2p
	G03jsBl0qfGzQjtKCFEXNZpE2K9uyw96GVuHv3NcEasQbEkOJyXuv/7GCAxQvGwY
	SvW76OEK3G0fkC9qlSdNhBUyWgp3iZW2+WhKamAFKj3y3/fVd8yYbfrUST2AuiPa
	Mf04qnc6Qo2y9fiduKOtLJviCsg93hofO9tghqS4xi6Duevvjr7mFiOugPaRWfGc
	KTLdob0vF1sPaJwf2aXsae9S9ZPhNEC4bbNqENZWHiAML8nsxvevwd++85DYSeSH
	xzVZrdUPn1pWS2pKLUpFQ==
X-ME-Sender: <xms:3BT4aGRJd6wzKiLbDtaagdl2Ez54QQQlamJGeESZMkTnON0hHJpR5Q>
    <xme:3BT4aByP7NNHNvTDjcQrXBn2nMNPZPR4YFyEMlbeQF9vEvhuvtZr1lTVb_4dVTyZ7
    ubwOrfm4PhzyNIlKkBREmAN5g2611P4fdDLgl5L8IkS-4nKLUU2LpA>
X-ME-Received: <xmr:3BT4aOp_3I3iz5T-DOA9TNy5_v_cn_1__JPMR7PwLlJybwZ31H9EGICDe508sxirH4w7vn9vmdsXqH1ZPbDPKVb_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepff
    ffveffieethfdviedthfdvjefhueeiffffheffvdegheeggedvudfggeehgedunecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehmsehmrghofihtmhdrohhrghdpnhgspghrtghpthhtohep
    uddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshhmrgguvghushestghoug
    gvfihrvggtkhdrohhrghdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheprghnughrihhirdhnrghkrhihihhkohesghhmrghilhdrtghomhdprhgtph
    htthhopegvrhhitghvhheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhutghhohes
    ihhonhhkohhvrdhnvghtpdhrtghpthhtoheplhhinhhugigpohhsshestghruhguvggshi
    htvgdrtghomhdprhgtphhtthhopegrshhtsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehvlehfsheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:3BT4aE3D-BsIhBJPZrnDFI_3ggSd8eVuI6-iIaW62Vnio5Ogu72QFw>
    <xmx:3BT4aOwX2cIEaCk0B8Rhmrx-DX6R8wvBm6uS2xr7A74lqhLt5QZMWA>
    <xmx:3BT4aIi99RnHZE-mU8WvOfZ_pcprTEdQXF0cSdOKwhvW5KVWXzrIwA>
    <xmx:3BT4aJommHZNQrYPDn1Y3PB0Mvvmo5PXUjpKRQLpYGp_E0F0swczww>
    <xmx:3RT4aGsqBYVmjgNNAjWybr8aYj5Zu6v4-HDstFaUXQHkRlTbrUJmH0WS>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 19:18:51 -0400 (EDT)
Message-ID: <6c74ad63-3afc-4549-9ac6-494b9a63e839@maowtm.org>
Date: Wed, 22 Oct 2025 00:18:48 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/9p: don't use cached metadata in revalidate for
 cache=mmap
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Song Liu <song@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Eric Van Hensbergen <ericvh@kernel.org>, Latchesar Ionkov
 <lucho@ionkov.net>, Christian Schoenebeck <linux_oss@crudebyte.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org,
 v9fs@lists.linux.dev, bpf@vger.kernel.org
References: <20251022-mmap-regression-v1-1-980365ee524e@codewreck.org>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20251022-mmap-regression-v1-1-980365ee524e@codewreck.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

I do apologize for missing this initially... (I wonder if it would have
been caught by xfstests in cache=mmap mode)

On 10/21/25 23:09, Dominique Martinet via B4 Relay wrote:
> From: Dominique Martinet <asmadeus@codewreck.org>
> 
> cache=mmap is a mode that doesn't cache metadata, but still has
> writeback cache.
> In commit 290434474c33 ("fs/9p: Refresh metadata in d_revalidate
> for uncached mode too") we considered metadata cache to be enough to
> not look at the server, but in writeback cache too looking at the server
> size would make the vfs consider the file has been truncated before the
> data has been flushed out, making the following repro fail (nothing is
> ever read back, the resulting file ends up with no data written)
> 
> ---
> I was suspecting cache=mmap when I saw vmtest used that, and it's
> confirmed with Song's reproducer...
> This makes the repro work, would one of you be able to confirm this?
> Once confirmed I'll send this to Linus directly
> 
> Thanks again and sorry for lack of cache=mmap tests :/
> 
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
> #include <fcntl.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <unistd.h>
> 
> char buf[4096];
> 
> int main(int argc, char *argv[])
> {
>         int ret, i;
>         int fdw, fdr;
> 
>         if (argc < 2)
>                 return 1;
> 
>         fdw = openat(AT_FDCWD, argv[1], O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC, 0600);
>         if (fdw < 0) {
>                 fprintf(stderr, "cannot open fdw\n");
>                 return 1;
>         }
>         write(fdw, buf, sizeof(buf));
> 
>         fdr = openat(AT_FDCWD, argv[1], O_RDONLY|O_CLOEXEC);
> 
>         if (fdr < 0) {
>                 fprintf(stderr, "cannot open fdr\n");
>                 close(fdw);
>                 return 1;
>         }
> 
>         for (i = 0; i < 10; i++) {
>                 ret = read(fdr, buf, sizeof(buf));
>                 fprintf(stderr, "i: %d, read returns %d\n", i, ret);
>         }
> 
>         close(fdr);
>         close(fdw);
>         return 0;
> }
> ---
> 
> Reported-by: Song Liu <song@kernel.org>
> Link: https://lkml.kernel.org/r/CAHzjS_u_SYdt5=2gYO_dxzMKXzGMt-TfdE_ueowg-Hq5tRCAiw@mail.gmail.com
> Reported-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Link: https://lore.kernel.org/bpf/CAEf4BzZbCE4tLoDZyUf_aASpgAGFj75QMfSXX4a4dLYixnOiLg@mail.gmail.com/
> Fixes: 290434474c33 ("fs/9p: Refresh metadata in d_revalidate for uncached mode too")
> Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
> ---
>  fs/9p/vfs_dentry.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/9p/vfs_dentry.c b/fs/9p/vfs_dentry.c
> index f3248a3e54023489054337bf98e87a1d7b1fbafc..2f3654bf6275ffa802dc25b9a84bd61a62d5723c 100644
> --- a/fs/9p/vfs_dentry.c
> +++ b/fs/9p/vfs_dentry.c
> @@ -78,7 +78,11 @@ static int __v9fs_lookup_revalidate(struct dentry *dentry, unsigned int flags)
>  	v9inode = V9FS_I(inode);
>  	struct v9fs_session_info *v9ses = v9fs_inode2v9ses(inode);
>  
> -	cached = v9ses->cache & (CACHE_META | CACHE_LOOSE);
> +	/* We also don't want to refresh attr here in writeback cache mode,
> +	 * otherwise a write that hasn't been propagated to server would
> +	 * incorrectly get the old size back and truncate the file before
> +	 * the write happens */
> +	cached = v9ses->cache & (CACHE_META | CACHE_WRITEBACK | CACHE_LOOSE);

This makes sense, but I was also wondering about this bit in
v9fs_refresh_inode / ..._dotl:

	flags = (v9ses->cache & CACHE_LOOSE) ?
		V9FS_STAT2INODE_KEEP_ISIZE : 0;

I do wonder what else can cause us to end up mistakenly updating the
i_size, since the condition below would also pass if
v9inode->cache_validity & V9FS_INO_INVALID_ATTR is true, even in cached
mode:

>  
>  	if (!cached || v9inode->cache_validity & V9FS_INO_INVALID_ATTR) {
>  		int retval;

One instances where we set this invalid flag is in v9fs_vfs_rename.  With
the program pasted below, which adds an additional renaming of the file
written before reading, this seems to still cause truncation, even with
this fix:

#define _GNU_SOURCE
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/stat.h>

char buf[4096];

int main(int argc, char *argv[])
{
	int ret, i;
	int fdw, fdr;
	struct stat statbuf;

	if (argc < 3)
		return 1;

	fdw = openat(AT_FDCWD, argv[1], O_RDWR | O_CREAT | O_EXCL | O_CLOEXEC,
		     0600);
	if (fdw < 0) {
		fprintf(stderr, "cannot open fdw\n");
		return 1;
	}
	ret = write(fdw, buf, sizeof(buf));
	if (ret < 0) {
		fprintf(stderr, "write failed\n");
		return 1;
	}

	ret = renameat(AT_FDCWD, argv[1], AT_FDCWD, argv[2]);
	if (ret < 0) {
		fprintf(stderr, "renameat failed\n");
		return 1;
	}

	fdr = openat(AT_FDCWD, argv[2], O_RDONLY | O_CLOEXEC);

	if (fdr < 0) {
		fprintf(stderr, "cannot open fdr\n");
		return 1;
	}

	ret = read(fdr, buf, sizeof(buf));
	fprintf(stderr, "read returns %d\n", ret);

	ret = fstat(fdr, &statbuf);
	if (ret < 0) {
		fprintf(stderr, "fstat failed\n");
		return 1;
	}
	fprintf(stderr, "fstat: size = %lld\n", statbuf.st_size);

	close(fdr);
	unlink(argv[1]);
	unlink(argv[2]);
	return 0;
}

Output:

    root@v6.18-rc2:/# ./reproducer /tmp/9p/a /tmp/9p/b
    read returns 0
    fstat: size = 0

    root@v6.18-rc2:/# ./reproducer.orig /tmp/9p/a /tmp/9p/b # the original reproducer does work
    i: 0, read returns 4096
    i: 1, read returns 0
    ...

Before the "Refresh metadata in d_revalidate for uncached mode too" patch
series, it happened that in cache=mmap, v9fs_lookup_revalidate would not
be called at all, since it's not used for "uncached" mode, where uncached
is defined as !(CACHE_META|CACHE_LOOSE) in v9fs_mount.  Therefore this is
probably still a regression introduced by that series :(

The below change fixes both reproducer:

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 69f378a83775..316fc41513d7 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -1352,7 +1352,7 @@ int v9fs_refresh_inode(struct p9_fid *fid, struct inode *inode)
 	 * We don't want to refresh inode->i_size,
 	 * because we may have cached data
 	 */
-	flags = (v9ses->cache & CACHE_LOOSE) ?
+	flags = (v9ses->cache & (CACHE_LOOSE | CACHE_WRITEBACK)) ?
 		V9FS_STAT2INODE_KEEP_ISIZE : 0;
 	v9fs_stat2inode(st, inode, inode->i_sb, flags);
 out:
@@ -1399,4 +1399,3 @@ static const struct inode_operations v9fs_symlink_inode_operations = {
 	.getattr = v9fs_vfs_getattr,
 	.setattr = v9fs_vfs_setattr,
 };
-
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 0b404e8484d2..500d8e922f07 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -910,7 +910,7 @@ int v9fs_refresh_inode_dotl(struct p9_fid *fid, struct inode *inode)
 	 * We don't want to refresh inode->i_size,
 	 * because we may have cached data
 	 */
-	flags = (v9ses->cache & CACHE_LOOSE) ?
+	flags = (v9ses->cache & (CACHE_LOOSE | CACHE_WRITEBACK)) ?
 		V9FS_STAT2INODE_KEEP_ISIZE : 0;
 	v9fs_stat2inode_dotl(st, inode, flags);
 out:

Should we change this too?  (Well, in fact, the change above alone makes
both issue disappear, but I'm not 100% sure about the implication of
updating metadata aside from i_size for inodes with cached data)


Kind regards,
Tingmao

