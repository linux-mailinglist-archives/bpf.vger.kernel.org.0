Return-Path: <bpf+bounces-31863-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBDA9042D3
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 19:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 219D2B23C5F
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 17:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F42D5A0E0;
	Tue, 11 Jun 2024 17:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZISUCu2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A2A3D388;
	Tue, 11 Jun 2024 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718128425; cv=none; b=OohIT36kY+4TQA81OcfBX7X2ctCXwSGct/yT2vqSUJwj9t9tXtUZrUKD1rsr/sFRMdRSQutr3HdC3W/Eau5JH8qRLLjnRIlkR7fzare7yHOxyQ/UmMVSr0/c5nQkQSjje/Y7xQEo/j8mwzlRElI1oLGudEXHrjY/83VGeKXHWSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718128425; c=relaxed/simple;
	bh=X7/u/q/3KuPQRjSxGThfpcrAuuuMS+Zsou0nbZM/xlk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExwU3xW+9XlW3glI08YCLOIqCHX7AZpFEb7sqnvqjwdOs+BUQGzAQF16oeCz+Zk/i2XNnB+EBwZ/9euwxBrGs+jvha/btbEj+PfPkuLw2kTfY7OZPerZ1oCctN/pyTuIysIx+sMJMkS5tg2OvqH9R0eK784XEsEFQA2857QIroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZISUCu2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92202C2BD10;
	Tue, 11 Jun 2024 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718128424;
	bh=X7/u/q/3KuPQRjSxGThfpcrAuuuMS+Zsou0nbZM/xlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fZISUCu2uzGjZMTIolH7wDwHr6OKBjdR9PXV4KFBtu4114n19fKH1G0mtc7foUK76
	 JmOaqL2W1/9IzTK/2ftmtXgLML4EUBfc4ET+D8AqRi9rXUVudJBNG2d5+OSgu71pDh
	 tJ1rjI5MYCrtMCUK8n73i0cg+Fx3vT3grqe2PcnNdLeuA6m31l/yH2O8ijAhcn3474
	 iJhRlC+AlIkmr4j431ioxNtrF1VnohdFE5Uh9qGsqXiVAsSW9G4r3Vlc2ceG3dsJjs
	 9zoJ2YmOIzDxbtcLjKxs32OFmVrPO3QB1lcIxv0DkkJH9WLB+Vay4ZU7SbVZ08vC8t
	 BgpaWvLmylDrw==
Date: Tue, 11 Jun 2024 10:53:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
 anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
 mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
 jiri@resnulli.us, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, vladbu@nvidia.com,
 horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, victor@mojatatu.com,
 pctammela@mojatatu.com, Vipin.Jain@amd.com, dan.daly@intel.com,
 andy.fingerhut@gmail.com, chris.sommers@keysight.com, mattyk@nvidia.com,
 bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, Oz Shlomo
 <ozsh@nvidia.com>
Subject: Re: [PATCH net-next v16 00/15] Introducing P4TC (series 1)
Message-ID: <20240611105342.02805498@kernel.org>
In-Reply-To: <CAM0EoMkgxXX4sFJ98n_UTLLFjP3KHx00aaq76t4zJJsO9zNO4A@mail.gmail.com>
References: <20240410140141.495384-1-jhs@mojatatu.com>
	<20240611072107.5a4d4594@kernel.org>
	<CAM0EoMkAQH+zNp3mJMfiszmcpwR3NHnEVr8SN_ysZhukc=vt8A@mail.gmail.com>
	<20240611083312.3f3522dd@kernel.org>
	<CAM0EoMkgxXX4sFJ98n_UTLLFjP3KHx00aaq76t4zJJsO9zNO4A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 11:53:28 -0400 Jamal Hadi Salim wrote:
> > For me it's very much not "about P4". I don't care what DSL user prefers
> > and whether the device the offloads targets is built by a P4 vendor.
> 
> I think it is an important detail though.
> You wouldnt say PSP shouldnt start small by first taking care of TLS
> or IPSec because it is not the target.

I really don't see any parallel with PSP. And it _is_ small, 4kLoC.

First you complain that community is "political" and doesn't give you
technical feedback, and then when you get technical feedback you attack
the work of the maintainer helping you.

Do you not see how these kind of retaliatory responses are exactly 
the reason why people were afraid to give you clear feedback earlier?
Maybe one of the upcoming conferences should give out mirrors instead
of t-shirts as swag.

