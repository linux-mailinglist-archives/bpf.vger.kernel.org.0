Return-Path: <bpf+bounces-7935-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A2277EADA
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 22:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F40711C211CB
	for <lists+bpf@lfdr.de>; Wed, 16 Aug 2023 20:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E60817AC5;
	Wed, 16 Aug 2023 20:39:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4128E17E9
	for <bpf@vger.kernel.org>; Wed, 16 Aug 2023 20:39:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ABAC433CB;
	Wed, 16 Aug 2023 20:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692218391;
	bh=pmS072dZEXt7YatJuOVq8UqswY8UVjXioO/Tl6j94hI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Ndp5yslugLgNMsZ3gI1USpmyqKuTZmSCb0FOq8KYq51JzeLxWEGnvnPN9a7FkbXNL
	 5oQExC/vjCdeFNyRRTxK09I52JFBXMO7ONerYunqggyERKaT6ZtJcSiijFZr72C4Eu
	 aq68W3f7OM9SDRQWAaiOicn8HfDNEKPkl2GL89u4f8RznR0YlkrOkLbhWWu0rGzv1R
	 C7LkLJqNRI4lvEy+NKi2W9BYVqBugJxx7JTo2aTk3Ak2X61QL8TVcTY4hjFdKfikWi
	 LlFavGGdogSNgJJxRX/gBhK/4iJssplcZ2ZCawGPllvM9uxJdJd8CWAYq0I43DE9eR
	 pi1Z3/I3ao5TA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Aug 2023 23:39:46 +0300
Message-Id: <CUU9CQLZO8CU.2HZ1AA137CA2E@suppilovahvero>
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
 <CUSFHQGJ3I8F.WBL3ZYT3U5FB@suppilovahvero>
 <84159dc8-d2e5-4c10-9910-b329500862e0@huaweicloud.com>
In-Reply-To: <84159dc8-d2e5-4c10-9910-b329500862e0@huaweicloud.com>

On Wed Aug 16, 2023 at 11:21 AM EEST, Roberto Sassu wrote:
> On 8/14/2023 7:03 PM, Jarkko Sakkinen wrote:
> > On Sat Aug 12, 2023 at 1:46 PM EEST, Roberto Sassu wrote:
> >> From: Roberto Sassu <roberto.sassu@huawei.com>
> >>
> >> Introduce the digest cache, a structure holding a hash table of digest=
s,
> >> extracted from a digest list. Its pointer is stored in the iint of the
> >=20
> > What is iint? I honestly don't know what it is. I first thought that it
> > was "int" typoed.
>
> Ops. It is the integrity_iint_cache structure, to retain the=20
> integrity-specific state of an inode. Will explain that in the next versi=
on.

OK, cool!

> Thanks
>
> Roberto

BR, Jarkko


