Return-Path: <bpf+bounces-9177-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046B2791552
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 11:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA271280FC1
	for <lists+bpf@lfdr.de>; Mon,  4 Sep 2023 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8A51C2D;
	Mon,  4 Sep 2023 09:57:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE32D7E;
	Mon,  4 Sep 2023 09:57:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2861AC433CA;
	Mon,  4 Sep 2023 09:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693821459;
	bh=3nBALREBe4uYOQysxhL3FnVqTkdR7jMiX68zU5wvxQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pEztgc4TUkd2yfcHxcboc+zDXAcA4KHCmIGSB/gsRgCo9DGA1rLyRBmfivPzAjnOB
	 KKw5j1sjO7veroFTPAfq4w/Dw21tYljOg8WM+sB6xZikYv2ILFdOD928dMMu6jaMTA
	 hsFmv7Cbjvf4C2EEf3kIjrkFy7uHmWrX1TbMwxUdVWRcMpkNca5fPpStkr+O9O9AVs
	 oGtWlPEvUt+phBNKXuy5CCjefBQ9+fHhCcNVb2HuJp7/pDdC8MPGp01mLBBiMVtugi
	 LQHGEf2o9T+0sCa9DBGt1latLMv6pIa/RLJn+fTPda2hnB4Yrxv5cYlj5KyxA/vFa0
	 BGrzmLYXagYqw==
Date: Mon, 4 Sep 2023 11:57:30 +0200
From: Christian Brauner <brauner@kernel.org>
To: Hao Xu <hao.xu@linux.dev>
Cc: io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-cachefs@redhat.com,
	ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org, codalist@coda.cs.cmu.edu,
	linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
	linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
	devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
	Wanpeng Li <wanpengli@tencent.com>
Subject: Re: [PATCH v6 00/11] io_uring getdents
Message-ID: <20230904-butterbrot-aufraffen-db483c53eab5@brauner>
References: <20230827132835.1373581-1-hao.xu@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230827132835.1373581-1-hao.xu@linux.dev>

On Sun, Aug 27, 2023 at 09:28:24PM +0800, Hao Xu wrote:

For the future it would be helpful to hold of on sending larger series
that like this until a stable tag is out.

Right now this series is generating a bunch of merge conflicts because
of all the changes to relevant codepaths that got merged. So either we
have to resolve them to see whether things still make sense within the
context of all the changed code or risk that stuff we comment is outdated.

