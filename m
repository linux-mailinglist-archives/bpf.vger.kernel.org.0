Return-Path: <bpf+bounces-15390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E27F1C34
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 19:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E58511F25880
	for <lists+bpf@lfdr.de>; Mon, 20 Nov 2023 18:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B547D30667;
	Mon, 20 Nov 2023 18:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA0A3uMg"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BE11F19B;
	Mon, 20 Nov 2023 18:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205C2C43391;
	Mon, 20 Nov 2023 18:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700504448;
	bh=5WM+zXnPGVEUlM/ODYB/AVlub+QRpW4QdPXZj85OpQw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FA0A3uMg/EOpWD/7UJSVoTMFdLyhi8tMCLt9XmTH8FBpLWOyVRtg/afZxfaSymxuG
	 8dhYllmAzEDCxxd9fQ3WF5EpKilracrwY5uk/3E9EbBobSfmQkcxNtGQPYjwTqxHwN
	 ST5a4vXUvcEWHc8nRN7YT82TFDfWRcJZD6+cWT/QVkF6h871bDUJgnIDdeRWSSAE7V
	 MkCw2K/YGqSdxnuJUhfUUZBS0NTcG6u2+9SbFOGlBdUKSAuMRBkNqncmWt4LU9MljC
	 YNwjdpyN3SxtRRcV96xPWnACwHriLtvgTxvQi5/TRRrSbcnp4j+dCnpS1QTe0F5hRy
	 voJk2KC+Fzh0w==
Message-ID: <bdbaa38c-5dd1-4060-b787-014daa2a0abe@kernel.org>
Date: Mon, 20 Nov 2023 10:20:46 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 09/15] p4tc: add template pipeline create,
 get, update, delete
To: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com,
 anjali.singhai@intel.com, namrata.limaye@intel.com, tom@sipanda.io,
 mleitner@redhat.com, Mahesh.Shirshyad@amd.com, tomasz.osinski@intel.com,
 xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
 daniel@iogearbox.net, bpf@vger.kernel.org, khalidm@nvidia.com,
 toke@redhat.com, mattyk@nvidia.com, David Ahern <dsahern@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20231116145948.203001-1-jhs@mojatatu.com>
 <20231116145948.203001-10-jhs@mojatatu.com> <ZVY/GBIC4ckerGSc@nanopsycho>
 <CAM0EoMkdOnvzK3J1caSeKzVj+h-XrkLPfsfwRCS_udHem-C29g@mail.gmail.com>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAM0EoMkdOnvzK3J1caSeKzVj+h-XrkLPfsfwRCS_udHem-C29g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/23 4:09 AM, Jamal Hadi Salim wrote:
>>> diff --git a/include/uapi/linux/p4tc.h b/include/uapi/linux/p4tc.h
>>> index ba32dba66..4d33f44c1 100644
>>> --- a/include/uapi/linux/p4tc.h
>>> +++ b/include/uapi/linux/p4tc.h
>>> @@ -2,8 +2,71 @@
>>> #ifndef __LINUX_P4TC_H
>>> #define __LINUX_P4TC_H
>>>
>>> +#include <linux/types.h>
>>> +#include <linux/pkt_sched.h>
>>> +
>>> +/* pipeline header */
>>> +struct p4tcmsg {
>>> +      __u32 pipeid;
>>> +      __u32 obj;
>>> +};
>>
>> I don't follow. Is there any sane reason to use header instead of normal
>> netlink attribute? Moveover, you extend the existing RT netlink with
>> a huge amout of p4 things. Isn't this the good time to finally introduce
>> generic netlink TC family with proper yaml spec with all the benefits it
>> brings and implement p4 tc uapi there? Please?
>>

There is precedence (new netdev APIs) to move new infra to genl, but it
is not clear to me if extending existing functionality should fall into
that required conversion.

> 
> Several reasons:
> a) We are similar to current tc messaging with the subheader being
> there for multiplexing.
> b) Where does this leave iproute2? +Cc David and Stephen. Do other
> generic netlink conversions get contributed back to iproute2?
> c) note: Our API is CRUD-ish instead of RPC(per generic netlink)
> based. i.e you have:
>  COMMAND <PATH/TO/OBJECT> [optional data]  so we can support arbitrary
> P4 programs from the control plane.
> d) we have spent many hours optimizing the control to the kernel so i
> am not sure what it would buy us to switch to generic netlink..
> 


