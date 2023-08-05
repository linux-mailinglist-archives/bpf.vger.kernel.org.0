Return-Path: <bpf+bounces-7062-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37762770CA5
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 02:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 689AB1C216CA
	for <lists+bpf@lfdr.de>; Sat,  5 Aug 2023 00:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03B15B5;
	Sat,  5 Aug 2023 00:23:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7719D15A3
	for <bpf@vger.kernel.org>; Sat,  5 Aug 2023 00:23:48 +0000 (UTC)
Received: from out-77.mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460A34EDE
	for <bpf@vger.kernel.org>; Fri,  4 Aug 2023 17:23:45 -0700 (PDT)
Message-ID: <8b706f66-2afa-b3d0-a13a-11f1ffb452fe@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691195024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eUPA7Rbj5jk/MQgWgg+tKqw5KVGmICrIzOFj3UTUAGM=;
	b=FMHWlSfzy1ema2iNWXS3cVRO55vunCyX23YpRCcUf0/fa1sl2w6jsF7fSBZwDCRpY8O/D/
	5rP/MpM2zW1gjLe3Tz2hWCPiehr5qwYBnHJysFDtQgOo4Y6t6HPHYVjqdEbz9hyzVcknx6
	GC0H0RtkOPxfj0cMf2/v1V6Oje/VOlo=
Date: Fri, 4 Aug 2023 17:23:32 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 2/5] selftests/bpf: Use random netns name for
 mptcp
Content-Language: en-US
To: Geliang Tang <geliang.tang@suse.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Florent Revest <revest@chromium.org>, Brendan Jackman
 <jackmanb@chromium.org>, Matthieu Baerts <matthieu.baerts@tessares.net>,
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
References: <cover.1691125344.git.geliang.tang@suse.com>
 <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <15d7646940fcbb8477b1be1aa11a5d5485d10b48.1691125344.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/3/23 10:07 PM, Geliang Tang wrote:
> Use rand() to generate a random netns name instead of using the fixed
> name "mptcp_ns" for every test.
> 
> By doing that, we can re-launch the test even if there was an issue
> removing the previous netns or if by accident, a netns with this generic
> name already existed on the system.
> 
> Note that using a different name each will also help adding more
> subtests in future commits.

I run test_progs repeatedly without rebooting qemu to save time. If there is a 
test did not clean up its netns, I would rather uncover it earlier and fix it 
instead. Randomizing the name is hiding the issue and does not help to uncover 
the broken test sooner. Although this change is to mptcp test alone, this could 
be referred in other future tests.

afaik, I don't remember bpf CI ever run into a test failure because the picked 
name had already been used by the system. It seems you ran into this issue a lot 
with the mptcp test in your setup. Could you explain a little more?

