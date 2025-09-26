Return-Path: <bpf+bounces-69838-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80145BA38E3
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 13:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62323BE9E1
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 11:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E0B2EA720;
	Fri, 26 Sep 2025 11:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ddhV/jJm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBDB2580F2
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 11:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758887898; cv=none; b=QGIiWB9s7cwtRTx/JWe238rqfmlG21kO/j7bqvmPHp7JOhCdJTfj+FzUP14T0M62ZuP9OQdqukYJ1Y4//xiiEzoGgp501Ws4JlpEbeQsFx5eYk1OG/zoD4T3Wad4raWcXZiVhFdc5mlNpXv6nTCYZs9uHcV6lWsGucS/f4t62wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758887898; c=relaxed/simple;
	bh=xIhQOuVBHhRrhPOJUNG0MQ+SgG8wSIu/wFNQKygjXgI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=N51LrQFhhjacY29jyaAbuhEM6iLptKNnhWPpVJQM3cOVH91vPY4lmqbOqxQlYFfk7e/DR9HfZL7XTPgLN53x3FwMhPodMBO+r3YhtY60z+UGsb2iuOyZzu37f7xTFHpFSa/ai2CWapbHc72uKK5r3vuu7n4FqzYSwiYtjTtgXAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ddhV/jJm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-63491fc16c3so3582101a12.2
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 04:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758887895; x=1759492695; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=NhLI8ivMsRQl48fjRfQzFPxYaKc+TpjybY+SoQT+bt8=;
        b=ddhV/jJmPEeCVd4tYodRg4ZLGJySfQIIMR4QkPymrCjaw79xS/b4wUjThSTuQcCFxG
         HLd8I2RLrMaWYPxLNAl+qOB13ZKlfCTUl+KKhilMyDq0gWne4xxtnk61lBqK5hdb9LjW
         NpqSxJxORdlbSiRCZ2gzr9ZknaXB1KeLEDuyc37RoBBXg2o1wYjIqoj3AsyQ8jFxt6c1
         wRSeVECyWac6heFhdpa49267QlD0Szrh6BcrR0Rcmw6XsGSoEEOcLR//kj1+4AQ9MeBE
         vnhtQOZrH3mSQT64xRW7FPqVpU0MujhVqAFykpBf4E2HA/204IreKS1vf55EtRg1/4id
         9Nag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758887895; x=1759492695;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NhLI8ivMsRQl48fjRfQzFPxYaKc+TpjybY+SoQT+bt8=;
        b=KGdSfqAfNva+w1hZP+9I0lDGer8UQKSRX8lmYYi+30KgvtD22OFFUK5bZ6Ax29v55q
         IsYTl6sVZFAwciLprL8kqgXLxdTwsD9tQPQclb7o99HDKXNT07EVPVIi/e8TiuDmkF6m
         zGjQcpffCvjgVHEFXFegiobVsEK9TW++mY6VKbn2GvkLh86uGYel+3n9yrcKE/mjQRws
         u4B46IXoFHvEk2L1/eWRxNV5VtU4cVBl8xTXd3qt/inK8JQqsMl/NKuRr8unAFtMcYtg
         i0kNtJss0nyAr03oimz0BeXvE3Zqy7VjQ4QwAkh5FzSx5BUMBoKd3hqRt0gdca2uo95P
         SiFw==
X-Forwarded-Encrypted: i=1; AJvYcCVTOyjzqSv5t93/yl0hc2zajRjpwINs5kFZ4KWt3gpu0TdI5AMgZpko0BnkX0PI/ZnnUGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmPckYPFpuoefC880hrikD8uSJ7wFsw2ekPje3+Q5XH3fIwqcY
	VG9MpQDHAeZhGKZyFe4UJVmi22xozW+A3oIcooBQa1yba82qSOcbEzjxAcGLB5F7Tv4=
X-Gm-Gg: ASbGncubvhlGsirjfhXcQLNz5EgOiYS6Q3e4jEoPuawZZu5et4UapZWA5ogd5Y02Ism
	lvgYW54DHrV48sZUhNLAvPwKJMfkv1MK8xbEYi/yJMP/hfvFrYQNsVekSkiF6eQ/InNFTVkhvjg
	uydLeZwv/I+gmHdU0o+Mu2p+jDvyT1ID+NR+a6IDhaw/bZNf3sM/L9tMrjIVNkPZRnfEJKBtnRN
	byDf5ZxAKY3YKruzvzgI6XCR92J/Qjs53O9r7+MDk9Vw+QB3EgDxoIHgYPwZpiKsYgx2VKcAIM4
	RIYS9GvpepRsR7f/5QSOQcuQM57pGN4z7aSFW2nwo2KkgK8kHzG4xouuzS56xAb/Dpa4gG1a4QX
	+kuLHWb4BjCOfWFSUyaWO4wMCEEMml5K9RwOk
X-Google-Smtp-Source: AGHT+IE0bLaqZdtQDLm/EmSUUSAQEnVG+IpP4KDEPB31YjhAVBRnkD0HRDZydO+g+SV5KeYq1VqP2g==
X-Received: by 2002:a05:6402:68f:b0:632:930c:ed60 with SMTP id 4fb4d7f45d1cf-6349fa95a69mr4361644a12.30.1758887895005;
        Fri, 26 Sep 2025 04:58:15 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac6:d677:2432::39b:a2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a3af53basm2838609a12.41.2025.09.26.04.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 04:58:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,  Donald Hunter
 <donald.hunter@gmail.com>,  Jakub Kicinski <kuba@kernel.org>,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  John Fastabend <john.fastabend@gmail.com>,  Stanislav Fomichev
 <sdf@fomichev.me>,  Andrew Lunn <andrew+netdev@lunn.ch>,  Tony Nguyen
 <anthony.l.nguyen@intel.com>,  Przemek Kitszel
 <przemyslaw.kitszel@intel.com>,  Alexander Lobakin
 <aleksander.lobakin@intel.com>,  Andrii Nakryiko <andrii@kernel.org>,
  Martin KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman
 <eddyz87@gmail.com>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  KP Singh <kpsingh@kernel.org>,  Hao Luo
 <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  intel-wired-lan@lists.osuosl.org,  linux-kselftest@vger.kernel.org,
  kernel-team <kernel-team@cloudflare.com>
Subject: Re: [PATCH RFC bpf-next v2 0/5] Add the the capability to load HW
 RX checsum in eBPF programs
In-Reply-To: <fdb8a364-a12d-4c1f-9591-9dac3e27b321@kernel.org> (Jesper
	Dangaard Brouer's message of "Fri, 26 Sep 2025 13:45:29 +0200")
References: <20250925-bpf-xdp-meta-rxcksum-v2-0-6b3fe987ce91@kernel.org>
	<87bjmy508n.fsf@cloudflare.com> <aNUb2rB8QAJj-aUX@lore-desk>
	<87tt0q3ik9.fsf@cloudflare.com>
	<fdb8a364-a12d-4c1f-9591-9dac3e27b321@kernel.org>
Date: Fri, 26 Sep 2025 13:58:13 +0200
Message-ID: <87ldm12zoq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 26, 2025 at 01:45 PM +02, Jesper Dangaard Brouer wrote:
> On 25/09/2025 12.58, Jakub Sitnicki wrote:
>> On Thu, Sep 25, 2025 at 12:39 PM +02, Lorenzo Bianconi wrote:
>>>> On Thu, Sep 25, 2025 at 11:30 AM +02, Lorenzo Bianconi wrote:
>>>>> Introduce bpf_xdp_metadata_rx_checksum() kfunc in order to load the HW
>>>>> RX cheksum results in the eBPF program binded to the NIC.
>>>>> Implement xmo_rx_checksum callback for veth and ice drivers.
>>>>
>>>> What are going to do with HW RX checksum once XDP prog can access it?
>>>
>>> I guess there are multiple use-cases for bpf_xdp_metadata_rx_checksum()
>>> kfunc. The first the I have in mind is when packets are received by an af_xdp
>>> application. In this case I think we currently do not have any way to check if
>>> the packet checksum is correct, right?
>>> I think Jesper has other use-cases in mind, I will let him comment
>>> here.
>> Can you share more details on what the AF_XDP application would that
>> info?
>
> Today the AF_XDP application need to verify the packet checksum, as it
> gets raw xdp_frame packets directly from hardware (no layer in-between
> checked this).  Getting the RX-checksum validation from hardware info
> will be very useful for AF_XDP, as it can avoid doing this in software.
>
>
>> Regarding the use cases that Jesper is trying to unlock, as things stand
>> we don't have a way, or an agreement on how to inject/propagate even the
>> already existing NIC hints back into the network stack.
>> 
>
> This patchset have its own merits and shouldn't be connected with my
> use-case of (optionally) including hardware offloads in the xdp_frame.
> Sure, I obviously also want this RX-checksum added, but this patchset is
> useful on it's own.
>
>> Hence my question - why do we want to expose another NIC hint to XDP
>> that we can't consume in any useful way yet?
>> 
>
> Well here *are* useful ways to use this RX-checksum info on its own.
> See my explanation of the DDoS use-case here[1] in other email.
>
> Cloudflare actually also have a concrete use-case for needing this.
> Our XDP based Unimog[2] load-balancer (and DDoS) encapsulate all
> packets when they are XDP_TX forwarded. The encap receiving NIC lacking
> inner-packet checksum validation make us loose this hardware offload.
> This would allow us to save some checksum validation or even just DDOS drop
> based on hardware checksum validation prior to encap (as in [1]).

Thanks for filling in the blanks, Jesper. That's the context that I was
missing.

Lorenzo, this motivaton seems worth including in the cover letter.

