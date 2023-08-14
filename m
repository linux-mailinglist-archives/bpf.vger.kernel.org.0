Return-Path: <bpf+bounces-7738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6008F77BE99
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 19:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC53F2810B5
	for <lists+bpf@lfdr.de>; Mon, 14 Aug 2023 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAEA2C8D2;
	Mon, 14 Aug 2023 17:03:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B474C2D9
	for <bpf@vger.kernel.org>; Mon, 14 Aug 2023 17:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC698C433C8;
	Mon, 14 Aug 2023 17:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692032590;
	bh=I/QrwZvW/F2dBANd2wDS+DNx6z+LPkRNA/j6IGl1lD0=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eiP/TIONq3bJEm8ASI9bjWQ49wyxLtzqmuzoqXhA1gWbkG2PoitnYAxUpD8+GaH4k
	 T41cTc8pfOvNIJb26S4XeqdAe6a5l07cDbjmdO8g0WiljTyrPIRuAX21iKjhtw0hu+
	 BmwbdZMTcVmkhQsOH7/c3TAQYfafjM0Z7nl30YbHXyf/rHqRYuI2zAO7BkbXUqXkMN
	 03FeOMc0DlxICStPkDMwWwe+ePaQJCl+c304p9QqCyQylQOyL0yP3hKBxZkTGW1uLV
	 tXopdfXGh/aShdb3rjSyGq8BJ4gEO0wJjqfxEmiLiSJnPOSPGjsYiwKpTU0VoNHJgz
	 +3e37TtXPhgcg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Aug 2023 20:03:04 +0300
Message-Id: <CUSFHQGJ3I8F.WBL3ZYT3U5FB@suppilovahvero>
Cc: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <bpf@vger.kernel.org>, <pbrobinson@gmail.com>, <zbyszek@in.waw.pl>,
 <hch@lst.de>, <mjg59@srcf.ucam.org>, <pmatilai@redhat.com>,
 <jannh@google.com>, "Roberto Sassu" <roberto.sassu@huawei.com>
Subject: Re: [RFC][PATCH v2 02/13] integrity: Introduce a digest cache
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, <corbet@lwn.net>,
 <zohar@linux.ibm.com>, <dmitry.kasatkin@gmail.com>, <paul@paul-moore.com>,
 <jmorris@namei.org>, <serge@hallyn.com>
X-Mailer: aerc 0.14.0
References: <20230812104616.2190095-1-roberto.sassu@huaweicloud.com>
 <20230812104616.2190095-3-roberto.sassu@huaweicloud.com>
In-Reply-To: <20230812104616.2190095-3-roberto.sassu@huaweicloud.com>

On Sat Aug 12, 2023 at 1:46 PM EEST, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>
> Introduce the digest cache, a structure holding a hash table of digests,
> extracted from a digest list. Its pointer is stored in the iint of the

What is iint? I honestly don't know what it is. I first thought that it
was "int" typoed.

BR, Jarkko

