Return-Path: <bpf+bounces-18286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731A8188CB
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 14:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B19091F22B15
	for <lists+bpf@lfdr.de>; Tue, 19 Dec 2023 13:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED84A19BCA;
	Tue, 19 Dec 2023 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g6D0Qy0h"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7217F199AD;
	Tue, 19 Dec 2023 13:44:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62D88C433C8;
	Tue, 19 Dec 2023 13:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702993442;
	bh=85MC7cgpkPCUWh0/C8WDuOGLM+4AcByal2VMdxrQAf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g6D0Qy0hJsH5qNmaB5hjpTpOng9pk2ajAjDXQIE1fZrJ61OPW3n3K6uK4Ie9Zst+P
	 BaIDxQtmvsIaDm7M90FXjJaXBDBw3MXjONSNwJTMB1qwT2Ccc/6VqWNS19KaDI7fjm
	 Kzpsb+yO2mvUrJtvf0Wwce68JIliTG5gNGF+UyBY0Uloi+pJhOXDxOQwNXu5PaU8aL
	 KpnA5Gh0VS4WoakXZxKYH+HBv5aIxU4kIU9lLXkp9saf9D+e2agt2Att0iwqd92bMS
	 NXDVXq2mO9S8g8NSi6tLYNuPfIfmFKPMQtA9UbdqecqsPHvg9GAFNiOLd05Oh+sreB
	 92hv7+lSTSQOQ==
Date: Tue, 19 Dec 2023 14:43:53 +0100
From: Christian Brauner <brauner@kernel.org>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: Michael =?utf-8?B?V2Vpw58=?= <michael.weiss@aisec.fraunhofer.de>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Quentin Monnet <quentin@isovalent.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org, gyroidos@aisec.fraunhofer.de
Subject: Re: [RFC PATCH v3 3/3] devguard: added device guard for mknod in
 non-initial userns
Message-ID: <20231219-gebaggert-felgen-279a8e8716a8@brauner>
References: <20231213143813.6818-1-michael.weiss@aisec.fraunhofer.de>
 <20231213143813.6818-4-michael.weiss@aisec.fraunhofer.de>
 <20231215-golfanlage-beirren-f304f9dafaca@brauner>
 <61b39199-022d-4fd8-a7bf-158ee37b3c08@aisec.fraunhofer.de>
 <20231215-kubikmeter-aufsagen-62bf8d4e3d75@brauner>
 <20231215-eiern-drucken-69cf4780d942@brauner>
 <20231218170916.cd319dbcf83f2dd7da24e48f@canonical.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218170916.cd319dbcf83f2dd7da24e48f@canonical.com>

> The only thing that is not clear to me about the sb_device_access hook is, what we can check inside it practically?
> Yes, we have an access to struct super_block, but at this point this structure is not filled with anything useful. We only
> can determine a filesystem type and that's all. It means that we can use this hook as a flag that says "ok, we do care about device permissions,
> kernel, please do not set SB_I_NODEV for us". Am I correct?

What the the LSM needs to definitely know is what filesystem type and
what user namespace are relevant. Because this whole thing is mostly
interesting for the != init_user_ns case here.

And both things are already present at that point in time (Technically,
kernfs stuff can be a bit different but kernfs stuff does have
SB_I_NODEV unconditionally so it really doesn't matter.).The thing is
though that you want device access settled as soon as possible when the
superblock isn't yet exposed anywhere. And for that alloc_super() is
pretty convenient. Then you don't have to put much thought into it.

But we can always move the hook to another place. It's also feasible to
do this in vfs_get_tree() for example and provide the fs_context but
again. I don't see why we need to do this now.

