Return-Path: <bpf+bounces-9636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F02B79A7F4
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 14:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF2F2810B6
	for <lists+bpf@lfdr.de>; Mon, 11 Sep 2023 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBB4C8C0;
	Mon, 11 Sep 2023 12:35:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34194432
	for <bpf@vger.kernel.org>; Mon, 11 Sep 2023 12:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174C7C433C7;
	Mon, 11 Sep 2023 12:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694435726;
	bh=P2X5HQVGLxoGcauLnK65kalfLdiRnwUpcJ4JOMx8SDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDGOEY8n+o4nUr3QOuEV25GHkRhk6CpylfXgLn6xWNr10ZrRwAR1taHVxwVGczTN0
	 6ESL6Aq+u7FlnD2LzuBZIU4ORq82xWOYcF1hiJbDmr9JjFmp2KxXMDQeGwcN6XyLX5
	 pgkOYENb8sLyV3Z0gfXYLW+4FR3VJqUKSpFTX5GglujnStzQDM1smoSCO1ASZEeGJi
	 o0lipQxL7OhONqByvQfmWGzxZ5AGPS3FaTZTXrc4lRJ5TqhttSae9kEPzVPPVd1i8e
	 9AjujS95uFldbPm08DUgkltv6LxDdRmJyDpHPuHh+lnocLft9ITJmwdNfK2dJVP2rm
	 ZLxi4u32tpVmg==
Date: Mon, 11 Sep 2023 14:35:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	gyroidos@aisec.fraunhofer.de, paul@paul-moore.com,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH RFC 1/4] bpf: add cgroup device guard to flag a cgroup
 device prog
Message-ID: <20230911-leerstand-letztendlich-043fab663451@brauner>
References: <20230814-devcg_guard-v1-0-654971ab88b1@aisec.fraunhofer.de>
 <20230814-devcg_guard-v1-1-654971ab88b1@aisec.fraunhofer.de>
 <20230815-feigling-kopfsache-56c2d31275bd@brauner>
 <20230817221102.6hexih3uki3jf6w3@macbook-pro-8.dhcp.thefacebook.com>
 <CAJqdLrpx4v4To=XSK0gyM4Ks2+c=Jrni2ttw4ZViKv-jK=tJKQ@mail.gmail.com>
 <20230904-harfe-haargenau-4c6cb31c304a@brauner>
 <c0a32db6-b798-4430-476d-dc74e9f79766@aisec.fraunhofer.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c0a32db6-b798-4430-476d-dc74e9f79766@aisec.fraunhofer.de>

> So are OK with the checks here?

I'm ok with figuring out whether we can do this nicely, yes.

> > Because right now device access management seems its own form of
> > mandatory access control.
> 
> I'm currently testing an updated version which has incorporated the locking
> changes already mention by Alex and the change which avoids setting SB_I_NODEV
> in fs/super.c.

Not having to hack around SB_I_NODEV would be pretty crucial imho. It's
a core security assumption so we need to integrate with it nicely.

