Return-Path: <bpf+bounces-44934-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E859CDA7B
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 09:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C61B23D75
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 08:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04CD18BC2F;
	Fri, 15 Nov 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pv1JLZjw"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9CE18B47D
	for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731659429; cv=none; b=BCK+rdWqlA9EEA/CNSjCOrXW4rRI6TtT7yXb3GFvdX+45xW1ui4Gwyk4hakT9zGNKPH1bh2xCp0ImFDSQAvcXOYfyfQKnoWbPVTMB9vMwuB2WPcdWfS2hGtQxX+mVdrM+O2EjRZ66ncGVCWlZLtvh7vB+wiRZ5XjxlKHoHLx7F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731659429; c=relaxed/simple;
	bh=F7p+3X+4VoSFd/eVUZAT2go6PmoUpKiqGyEMRI1Nq3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RBNVXmM5r6aS4moZBW+pKKCw3wXfstz0QsR7SMCNY66+EN+xYg21OhsAh8OOrrvgfrf7DTP9fy3wd+p6byAV8krri2z6Ce8jNqZwhrbNmQqYulUbvIUzGIDd9FVQALFRGsLFEMV3D7V5pkeOud1zT8P1cos+FULLX2JtWtkVq0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pv1JLZjw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731659426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ki9GkaqHf/o8pR6HrBIn/RlG65f6MEkcplNrdxjltdw=;
	b=Pv1JLZjwAXSbCZSf+lvikCFfRgTDdm8kl1vUaN07FD03ApDxsiykdvvi4M+ZISP7YErsPo
	FYYPZebUivdIR3U6lt+TNtYZEftq66r+/a9gbc0AqzWHzjw2w5s0asLzZziyqgWtks8zQI
	WEIawBO0tZHUOqF3cSLJ2veb4QG3jk0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-TMerkJZSMv-hc0XSgbN27A-1; Fri, 15 Nov 2024 03:30:24 -0500
X-MC-Unique: TMerkJZSMv-hc0XSgbN27A-1
X-Mimecast-MFC-AGG-ID: TMerkJZSMv-hc0XSgbN27A
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-382171e3c4bso953310f8f.0
        for <bpf@vger.kernel.org>; Fri, 15 Nov 2024 00:30:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731659423; x=1732264223;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ki9GkaqHf/o8pR6HrBIn/RlG65f6MEkcplNrdxjltdw=;
        b=vlkjcpqyrB+MjY0BW/+mjRC2fMiSEI9JXN7yKr2GVQjW+GcsTlMd5B+mNCR7Cz1ibJ
         615/nuGaRL69j1/gOllsnVNE6Qk0xXv5rmlItqA6t/AbQ86vhFfKegznsh9YKgWfEqMW
         +Byo6PbcSHpV2YiqVmZipT+lTy0wDpIj9fpbbOU164jJup3218etytgthYoJqn5EL9BQ
         HoqnaMVjbctEWaQZio9lxY/CHU82nv5z+60CJnOROpmwE3LNBpWLuhw+otOdUN2wbAvo
         pxMbtLq8MnDXaEO2VmHyxF2HHraUpgOpZQ7BDqPVEdcp2YvQmjAaBnahlMEGkq4S22ZV
         NS9A==
X-Gm-Message-State: AOJu0YyjjbZ8QBb+gTit3ggukYrBDpVDEUda3eb8iAihAq83rtIjlXLH
	ll+twXQNKitt648jAUF/A8KEhzv9hxJjYGQKPv2BH/w2WDvq5r/RgBY/rupRO/EIMQGj0Tqj7se
	FLVFhb2/QyLLtr1BBoc36XCH4SIq6OHCLf4G+1u4EhpDvGB9U
X-Received: by 2002:a05:6000:18a7:b0:37e:d6b9:a398 with SMTP id ffacd0b85a97d-38213fff9dfmr5428000f8f.9.1731659423460;
        Fri, 15 Nov 2024 00:30:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGA14qsT3t+5JxrPVLeKk0pwuHMb0u146amqorCpi766Vzz9wCulLZ1teDrBZs/8WcgN2dkEQ==
X-Received: by 2002:a05:6000:18a7:b0:37e:d6b9:a398 with SMTP id ffacd0b85a97d-38213fff9dfmr5427966f8f.9.1731659423045;
        Fri, 15 Nov 2024 00:30:23 -0800 (PST)
Received: from [192.168.0.101] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3821ae160fdsm3795980f8f.84.2024.11.15.00.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2024 00:30:22 -0800 (PST)
Message-ID: <19e6921b-f44f-4b31-b72e-95a7c9afef91@redhat.com>
Date: Fri, 15 Nov 2024 09:30:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] Soft lockup on powerpc when running arena selftests
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
References: <4afdcb50-13f2-4772-8db1-3fd02bd985b3@redhat.com>
 <CAADnVQKj-XBs=4nq-cmUKcJLJXPUZzjNV19OhBRjG9-UrS02Cw@mail.gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <CAADnVQKj-XBs=4nq-cmUKcJLJXPUZzjNV19OhBRjG9-UrS02Cw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/7/24 16:46, Alexei Starovoitov wrote:
> On Thu, Nov 7, 2024 at 4:38 AM Viktor Malik <vmalik@redhat.com> wrote:
>>
>> Hi,
>>
>> I'm getting soft lockups when running the BPF arena selftests on powerpc
>> (ppcle64). The issue is 100% reproducible on the latest bpf-next with
>> `./test_progs -t arena`.
>>
>> A console snippet for one CPU lockup looks like this:
>>
>> [ 1124.671746] watchdog: BUG: soft lockup - CPU#1 stuck for 23s! [kworker/u34:0:58]
>> [ 1124.675554] CPU#1 Utilization every 4s during lockup:
>> [ 1124.675584]  #1: 100% system,          0% softirq,     0% hardirq,     0% idle
>> [ 1124.675621]  #2: 101% system,          0% softirq,     0% hardirq,     0% idle
>> [ 1124.675659]  #3: 100% system,          0% softirq,     0% hardirq,     0% idle
>> [ 1124.675696]  #4: 100% system,          0% softirq,     0% hardirq,     0% idle
>> [ 1124.675733]  #5: 101% system,          0% softirq,     0% hardirq,     0% idle
>> [ 1124.675770] Modules linked in: bpf_testmod(OE) bonding tls rfkill virtio_net net_failover vmx_crypto failover virtio_balloon crct10dif_vpmsum fuse loop nfnetlink zram vsock_loopback vmw_vsock_virtio_transport_common vsock virtio_blk crc32c_vpmsum virtio_console
>> [ 1124.675921] CPU: 1 UID: 0 PID: 58 Comm: kworker/u34:0 Tainted: G           OE      6.12.0-rc4+ #1
>> [ 1124.675975] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
>> [ 1124.676005] Hardware name: IBM pSeries (emulated by qemu) POWER8E (raw) 0x4b0201 of:SLOF,HEAD hv:linux,kvm pSeries
>> [ 1124.676063] Workqueue: events_unbound bpf_map_free_deferred
>> [ 1124.676101] NIP:  c000000000551d3c LR: c000000000551c30 CTR: c0000000004733b0
>> [ 1124.676145] REGS: c000000008a37a20 TRAP: 0900   Tainted: G           OE       (6.12.0-rc4+)
>> [ 1124.676189] MSR:  800000000280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE>  CR: 44082828  XER: 00000000
>> [ 1124.676251] CFAR: 0000000000000000 IRQMASK: 0
>> [ 1124.676251] GPR00: c000000000551c30 c000000008a37cc0 c00000000214f800 0000000000000000
>> [ 1124.676251] GPR04: 000000000000003b c00c00000044e3c8 0000000000000000 0000000000000000
>> [ 1124.676251] GPR08: 0000000000000000 0000000000000000 0000000058006001 0000000024082828
>> [ 1124.676251] GPR12: c0000000004733b0 c00000003ffff480 c0000000043cb7c0 c0000000043b1028
>> [ 1124.676251] GPR16: c008000305f78000 0000000000000000 0000000000000001 0000000000000000
>> [ 1124.676251] GPR20: fffffffffffffe7f c008000305f77fff c000000003cbe780 c000000001b26120
>> [ 1124.676251] GPR24: c000000003da0380 ff7fffffffffefbf c000000003cbe780 0000000000000001
>> [ 1124.676251] GPR28: c008000206000000 0000000000000000 c0000000004733b0 c00bf073759e8000
>> [ 1124.676627] NIP [c000000000551d3c] __apply_to_page_range+0x55c/0xea0
>> [ 1124.676667] LR [c000000000551c30] __apply_to_page_range+0x450/0xea0
>> [ 1124.676706] Call Trace:
>> [ 1124.676730] [c000000008a37cc0] [c000000000551c30] __apply_to_page_range+0x450/0xea0 (unreliable)
>> [ 1124.676784] [c000000008a37de0] [c000000000473360] arena_map_free+0x70/0xc0
> 
> Thanks for the report.
> I have no idea what's wrong with apply_to_page_range on ppc.
> Don't have any ppc to test and no debugging experience there.
> Unless ppc experts chime in there only option to ignore or disable.
> 

Thanks.

Disabling sounds better to me as we can still conveniently run
test_progs on ppc. Since some arena tests are quite hard to disable, the
easiest approach is to disable arena allocation on unsupported arches.

I sent the patch [1].

Viktor

[1]
https://lore.kernel.org/bpf/20241115082548.74972-1-vmalik@redhat.com/T/#u


