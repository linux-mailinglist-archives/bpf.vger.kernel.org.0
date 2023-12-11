Return-Path: <bpf+bounces-17415-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1A180CF89
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 16:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D796B1C21296
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 15:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9424B5AE;
	Mon, 11 Dec 2023 15:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LnKrCZ0g"
X-Original-To: bpf@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58113DF
	for <bpf@vger.kernel.org>; Mon, 11 Dec 2023 07:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=xtpAJix96/GOUDgaDcZE8uGL59MYPz1hGx+0XWzMB4s=; b=LnKrCZ0gwL5gFljYMTk0VNJ+SC
	fnH2bdFb4Z13k2IexJjQv9vmaOcFWgiZmqRHUvPFVmrBydlut8LmrT0YIHvqWf6fCSytnvHa8vRK4
	spgmrs2/Ho8C07yjqQ9UMyoZb0IoMuCTac1VzfN5FqtC4vI3FeSf1IMmwN4J3eEltIHQukNlyk+i9
	5kCxLKam3ysgs5wIUGDkPMEA+QdgcRrAST7njD5K9lpvvbiefAkybFozL0pIaC4wH9LUg/cDRdkmV
	hk+Slbe/bAm+EgyeXm7W6j4K+GmLmN2DjRfXSKI+GdxjdpfRAHm+XOYRsny/VBFZuvmhd2cowBSRc
	OchuVJbw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1rCiES-0006sc-00; Mon, 11 Dec 2023 16:30:08 +0100
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1rCiER-000TdL-L7; Mon, 11 Dec 2023 16:30:07 +0100
Subject: Re: [PATCH bpf-next v3] bpf: Support uid and gid when mounting bpffs
To: Christian Brauner <brauner@kernel.org>
Cc: Jie Jiang <jiejiang@chromium.org>, bpf@vger.kernel.org,
 vapier@chromium.org, andrii@kernel.org, ast@kernel.org
References: <20231207035706.2797103-1-jiejiang@chromium.org>
 <c9a98edc-f8cb-e52d-e9e6-53834193aee8@iogearbox.net>
 <20231211-beide-golden-84ecb9d596c1@brauner>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3ab06f4c-48df-0255-d852-d71dce3fe1a3@iogearbox.net>
Date: Mon, 11 Dec 2023 16:30:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231211-beide-golden-84ecb9d596c1@brauner>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27120/Mon Dec 11 10:44:34 2023)

On 12/11/23 4:21 PM, Christian Brauner wrote:
> On Mon, Dec 11, 2023 at 03:26:12PM +0100, Daniel Borkmann wrote:
>> On 12/7/23 4:57 AM, Jie Jiang wrote:
>>> Parse uid and gid in bpf_parse_param() so that they can be passed in as
>>> the `data` parameter when mount() bpffs. This will be useful when we
>>> want to control which user/group has the control to the mounted bpffs,
>>> otherwise a separate chown() call will be needed.
>>>
>>> Signed-off-by: Jie Jiang <jiejiang@chromium.org>
>>> Acked-by: Mike Frysinger <vapier@chromium.org>
>>> Acked-by: Christian Brauner <brauner@kernel.org>
>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>> v2 -> v3: Rebase to resolve conflicts.
>>> v1 -> v2: Add additional validation in bpf_parse_param() for if the
>>>     requested uid/gid is representable in the fs's idmapping.
>>>
>>>    include/linux/bpf.h |  2 ++
>>>    kernel/bpf/inode.c  | 48 ++++++++++++++++++++++++++++++++++++++++++++-
>>>    2 files changed, 49 insertions(+), 1 deletion(-)
>>
>> Looks good, for clarity, should this be folded into the patch?
>>
>> Thanks,
>> Daniel
>>
>> diff --git a/kernel/bpf/inode.c b/kernel/bpf/inode.c
>> index 273d7e0cfbde..f5ca533c62af 100644
>> --- a/kernel/bpf/inode.c
>> +++ b/kernel/bpf/inode.c
>> @@ -889,6 +889,8 @@ static int bpf_init_fs_context(struct fs_context *fc)
>>                  return -ENOMEM;
>>
>>          opts->mode = S_IRWXUGO;
>> +       opts->uid = GLOBAL_ROOT_UID;
>> +       opts->gid = GLOBAL_ROOT_GID;
> 
> I think you want
> 
> opt->uid = current_fsuid();
> opt->gid = current_fsgid();
> 
> because bpf_init_fs_context() is called from fsopen() which may be
> called inside a user namespace. Then you can just transfer
> 
> s_fs_info->uid = opts->uid;
> s_fs_info->gid = opts->gid;
> 
> and then always use:
> 
> inode->i_uid = s_fs_info->uid;
> inode->i_gid = s_fs_info->gid;
> 
> when initializing inodes. Otherwise looks good.

Indeed, good point, thanks for the explanation! .. then waiting for
a v4 to arrive.

