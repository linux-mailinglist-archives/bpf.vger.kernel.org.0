Return-Path: <bpf+bounces-13885-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E16427DEB2D
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 04:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 802191F22337
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 03:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CBB1855;
	Thu,  2 Nov 2023 03:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYd9cZhO"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1001849;
	Thu,  2 Nov 2023 03:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB859C433C8;
	Thu,  2 Nov 2023 03:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698894666;
	bh=kAPcSMt8OUh/dCTT2VwfzkumHtVdA53H4OZtTBBAJ4E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYd9cZhO/uq1fz7S4G6zxzoa+9BM3HfxA/tyWTojAPbC+AZjUJyy5YNrR7PBC9Zm5
	 GZemJ6jwQXaGvySwkA93PNOdYbLjyX3Q+kZguTm5bMMRTcu7wLpmkgR+Xl4jE1L02g
	 my7CWM5PVLxpw5wGzapOxorc/PFkZq5IvyuzBXyuYxC94+szN4C2b5jhgS2z1AKSr6
	 q6hj0SY3/tD23zAkgUKNYzjcKJ0hZ3ubHxYGnvyZ19qF5fkQnaDu72D8C+SzIvrlk9
	 FpGjMsMDaMpIox4wPZq+6qFwj2iWRvkfsBHjyrtHRVh2JfrXQEKJbtBK/6nkwlRCor
	 u0h5WfRUFG+aA==
Date: Wed, 1 Nov 2023 20:11:04 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, fsverity@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
	kernel-team@meta.com, tytso@mit.edu, roberto.sassu@huaweicloud.com
Subject: Re: [PATCH v6 bpf-next 5/9] bpf, fsverity: Add kfunc
 bpf_get_fsverity_digest
Message-ID: <20231102031104.GB1498@sol.localdomain>
References: <20231024235551.2769174-1-song@kernel.org>
 <20231024235551.2769174-6-song@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024235551.2769174-6-song@kernel.org>

On Tue, Oct 24, 2023 at 04:55:47PM -0700, Song Liu wrote:
> fsverity provides fast and reliable hash of files, namely fsverity_digest.
> The digest can be used by security solutions to verify file contents.
> 
> Add new kfunc bpf_get_fsverity_digest() so that we can access fsverity from
> BPF LSM programs. This kfunc is added to fs/verity/measure.c because some
> data structure used in the function is private to fsverity
> (fs/verity/fsverity_private.h).
> 
> To avoid recursion, bpf_get_fsverity_digest is only allowed in BPF LSM
> programs.
> 
> Signed-off-by: Song Liu <song@kernel.org>

Acked-by: Eric Biggers <ebiggers@google.com>

- Eric

