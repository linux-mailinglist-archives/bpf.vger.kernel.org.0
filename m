Return-Path: <bpf+bounces-66259-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68161B308A5
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 23:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F5221D03D5A
	for <lists+bpf@lfdr.de>; Thu, 21 Aug 2025 21:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EBE2E92D0;
	Thu, 21 Aug 2025 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vOrqbFbp"
X-Original-To: bpf@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E1F2580CF
	for <bpf@vger.kernel.org>; Thu, 21 Aug 2025 21:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812951; cv=none; b=WAqXDcXse4WX/4fS3vG+LQmu/C7RoMgSM3DoSh6NuJ9pCodt2Fd4OD+hMEVW7w/FkO5GO6/Xyf/g7kGbDUq4YeZN7kn85HWXtqXN4vDQqjJcnVPYd5VBgXMHHLxNCsG+TrK3y3wN8EmJFR5AMT1KXoKA/9ujVreMwd8a2ji/iRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812951; c=relaxed/simple;
	bh=HqM5XDu0iiew9jRxvCXQQtl9xZD9ZCsgol4tJ6pbScY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZUFccw700ozXbcTZtaKtsTxdgCDg+TxGNso5wUqzzvFZLc3sHTgqsunz1i57zjTHWjF5FTxhk+6wfYsA1CarwjdZcz3HpQxwdRv/35Fhjvk0tsKcBiYoX5M2fj2EC+SrEi51NTEmrwGYzaQrsqPqYmXcjulTXuCbKhLiZS5bZWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vOrqbFbp; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a3d437ce-c91d-47c6-9590-88b716fb6690@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755812947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C4cFJbpQNFTwV50kiFAuGphrqAUZV8+ER0tPmM4e7u8=;
	b=vOrqbFbp2U6+4Lv4vvKFyZzygPCihHn3FE9erEwiEeRRToOEonKYCJ/e83Rw09Ibl8Nhw9
	DJ8rELk3KsoF5fGTP/vGcydpz7RVf1nwdgVHznCZWstwbIKbarpPkgHDTon5p33de40qFy
	WfXiu+EHiM0ArhNbhO8cXn6+fwii+tM=
Date: Thu, 21 Aug 2025 14:48:53 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: hashtab - allow
 BPF_MAP_LOOKUP{,_AND_DELETE}_BATCH with NULL keys/values.
Content-Language: en-GB
To: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Linux Network Development Mailing List <netdev@vger.kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 BPF Mailing List <bpf@vger.kernel.org>, Stanislav Fomichev <sdf@fomichev.me>
References: <20250813073955.1775315-1-maze@google.com>
 <6df59861-8334-49ac-8dca-2b0bac82f2d7@linux.dev>
 <CANP3RGcJ06uRUBF=RR6bjqNnxdaSdpBpynGzNTSms0jA-ZpW6w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CANP3RGcJ06uRUBF=RR6bjqNnxdaSdpBpynGzNTSms0jA-ZpW6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/20/25 7:23 PM, Maciej Żenczykowski wrote:
> On Mon, Aug 18, 2025 at 1:58 PM Yonghong Song 
> <yonghong.song@linux.dev> wrote:
> > On 8/13/25 12:39 AM, Maciej Żenczykowski wrote:
> > > BPF_MAP_LOOKUP_AND_DELETE_BATCH keys & values == NULL
> > > seems like a nice way to simply quickly clear a map.
> >
> > This will change existing API as users will expect
> > some error (e.g., -EFAULT) return when keys or values is NULL.
>
> No reasonable user will call the current api with NULLs.

I do agree it is really unlikely users will have NULL keys or values.

>
> This is a similar API change to adding a new system call
> (where previously it returned -ENOSYS) - which *is* also a UAPI 
> change, but obviously allowed.
>
> Or adding support for a new address family / protocol (where 
> previously it -EAFNOSUPPORT)
> Or adding support for a new flag (where previously it returned -EINVAL)
>
> Consider why userspace would ever pass in NULL, two possibilities:
> (a) explicit NULL - you'd never do this since it would (till now) 
> always -EFAULT,
>   so this would only possibly show up in a very thorough test suite
> (b) you're using dynamically allocated memory and it failed allocation.
>   that's already a program bug, you should catch that before you call 
> bpf().

Okay. What you describes make sense.
Could you add a selftest for this?
Could you add some comments in below uapi bpf.h header to new functionality?

>
> > We have a 'flags' field in uapi header in
> >
> >          struct { /* struct used by BPF_MAP_*_BATCH commands */
> >                  __aligned_u64   in_batch;       /* start batch,
> >                                                   * NULL to start 
> from beginning
> >                                                   */
> >                  __aligned_u64   out_batch;      /* output: next 
> start batch */
> >                  __aligned_u64   keys;
> >                  __aligned_u64   values;
> >                  __u32           count;          /* input/output:
> >                                                   * input: # of 
> key/value
> >                                                   * elements
> >                                                   * output: # of 
> filled elements
> >                                                   */
> >                  __u32           map_fd;
> >                  __u64           elem_flags;
> >                  __u64           flags;
> >          } batch;
> >
> > we can add a flag in 'flags' like BPF_F_CLEAR_MAP_IF_KV_NULL with a 
> comment
> > that if keys or values is NULL, the batched elements will be cleared.
>
> I just don't see what value this provides.
>
> > > BPF_MAP_LOOKUP keys/values == NULL might be useful if we just want
> > > the values/keys and don't want to bother copying the keys/values...
> > >
> > > BPF_MAP_LOOKUP keys & values == NULL might be useful to count
> > > the number of populated entries.
> >
> > bpf_map_lookup_elem() does not have flags field, so we probably 
> should not
> > change existins semantics.
>
> This is unrelated to this patch, since this only touches 'batch' 
> operation.
> (unless I'm missing something)
>
> > > Cc: Alexei Starovoitov <ast@kernel.org>
> > > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > > Cc: Stanislav Fomichev <sdf@fomichev.me>
> > > Signed-off-by: Maciej Żenczykowski <maze@google.com>
> > > ---
> > >   kernel/bpf/hashtab.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
> > > index 5001131598e5..8fbdd000d9e0 100644
> > > --- a/kernel/bpf/hashtab.c
> > > +++ b/kernel/bpf/hashtab.c
> > > @@ -1873,9 +1873,9 @@ __htab_map_lookup_and_delete_batch(struct 
> bpf_map *map,
> > >
> > >       rcu_read_unlock();
> > >       bpf_enable_instrumentation();
> > > -     if (bucket_cnt && (copy_to_user(ukeys + total * key_size, keys,
> > > +     if (bucket_cnt && (ukeys && copy_to_user(ukeys + total * 
> key_size, keys,
> > >           key_size * bucket_cnt) ||
> > > -         copy_to_user(uvalues + total * value_size, values,
> > > +         uvalues && copy_to_user(uvalues + total * value_size, 
> values,
> > >           value_size * bucket_cnt))) {
> > >               ret = -EFAULT;
> > >               goto after_loop;
> >
>
>
> --
> Maciej Żenczykowski, Kernel Networking Developer @ Google


