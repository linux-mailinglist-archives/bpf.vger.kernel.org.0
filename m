Return-Path: <bpf+bounces-15521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 494047F2DF3
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 14:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDDF1B21AD4
	for <lists+bpf@lfdr.de>; Tue, 21 Nov 2023 13:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E14B495C0;
	Tue, 21 Nov 2023 13:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="K8GWQFme"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBA4D52
	for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 05:06:15 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5431614d90eso8022127a12.1
        for <bpf@vger.kernel.org>; Tue, 21 Nov 2023 05:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700571974; x=1701176774; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y2L9KOytSsQ31orcl2WVBjfUqjOvZ0HGzMhofqTHw+8=;
        b=K8GWQFmefEjHCvuGv/xD4eq0eNV4PoVHknKkNMvtaPz27yMIEGVy3hhC/3r62oTQ9k
         ivmhNFGMfohjlhT2QoxNYPzdt3L+g3wmKRsjwjH4uf887a6pEVlYrxZUsQz2ntGSVrJB
         rjCWb41MDY7nkUUKkL6d8BjkS8Z5ph4wC0wHuasH5ns2KUJy9i/L2DArYg+UXPb0wnLI
         txPLDhUhAmtlCVAOSRTTZPm5z9K4AFBFrrdRrDt0lm1PrWsJuxbh+7YhD0rVseJzv+mK
         UrfigtGRrghWfSGoxJ0/SLgSBoddFC8kMuycTckB00uQNgRRBJMUhDB5VxCGVbxFn3fz
         P80g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700571974; x=1701176774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2L9KOytSsQ31orcl2WVBjfUqjOvZ0HGzMhofqTHw+8=;
        b=D3V9LsqOlt5jnlz4doDFzhXszu57npCE/T1i47oXnNhcrXaUtyi095mA6ZVN8UsvZh
         LXJuhIZLM8RDrWBInxkuvrXYnWF8px7uHe7RQeKUXDBD8TaVsBj4dl05h65dM1BKO6n1
         XYPg8FrS+ZA1KE9QaQRniJddIR4kKRGxWK/RuLPefYrj5ONY5pJ4wpzYNYjY9FDolyET
         n+/wLA/X1y7HgBHidNs5Rx67DQUJy0VMeHkG/2nSeMNg9YA6nuyOiZvWzq0J7BaVlPS9
         L0oGF68nWw/J+72WBBeCYL0lAfBZ+dvW69kpKfndrUSTryzVtdtoOqoROXSamNAeH/Ia
         PZlA==
X-Gm-Message-State: AOJu0YxXzc7qOFeTaF3LTkFgMyrUC9xdVTFZp17ZYoaBdZSqmIhDAhdM
	TqkGt+uGtspqOX9Et2B6UD7YQw==
X-Google-Smtp-Source: AGHT+IFWplWTH5fBhOp3UJDJWhV3XT33T/mNKKAbhn7xM+QHfELAtk0TyrY7TE/5crP/cfX6HGOLsg==
X-Received: by 2002:a17:906:51d8:b0:a02:a2cc:66b5 with SMTP id v24-20020a17090651d800b00a02a2cc66b5mr854806ejk.76.1700571974326;
        Tue, 21 Nov 2023 05:06:14 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906155700b009c921a8aae2sm5162781ejd.7.2023.11.21.05.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 05:06:13 -0800 (PST)
Date: Tue, 21 Nov 2023 14:06:12 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	deb.chatterjee@intel.com, anjali.singhai@intel.com,
	Vipin.Jain@amd.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org,
	bpf@vger.kernel.org, khalidm@nvidia.com, toke@redhat.com,
	mattyk@nvidia.com, dan.daly@intel.com, chris.sommers@keysight.com,
	john.andy.fingerhut@intel.com
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
Message-ID: <ZVyrRFDrVqluD9k/@nanopsycho>
References: <655707db8d55e_55d7320812@john.notmuch>
 <CAM0EoM=vbyKD9+t=UQ73AyLZtE2xP9i9RKCVMqeXwEh+j-nyjQ@mail.gmail.com>
 <6557b2e5f3489_5ada920871@john.notmuch>
 <CAM0EoMkrb4kv+bjQqrFKFo9mxGFs6tjQtq4D-FtcemBV_WYNUQ@mail.gmail.com>
 <ZVspOBmzrwm8isiD@nanopsycho>
 <CAM0EoMm3whh6xaAdKcT=a9FcSE4EMn=xJxkXY5ked=nwGaGFeQ@mail.gmail.com>
 <ZVuhBlYRwi8eGiSF@nanopsycho>
 <CAM0EoMknA01gmGX-XLH4fT_yW9H82bN3iNYEvFRypvTwARiNqg@mail.gmail.com>
 <2a7d6f27-3464-c57b-b09d-55c03bc5eae6@iogearbox.net>
 <CAM0EoMkBHqRU9tprJ-SK3tKMfcGsnydp0UA9cH2ALjpSNyJhig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMkBHqRU9tprJ-SK3tKMfcGsnydp0UA9cH2ALjpSNyJhig@mail.gmail.com>

Mon, Nov 20, 2023 at 11:56:50PM CET, jhs@mojatatu.com wrote:
>On Mon, Nov 20, 2023 at 4:49 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>>
>> On 11/20/23 8:56 PM, Jamal Hadi Salim wrote:
>> > On Mon, Nov 20, 2023 at 1:10 PM Jiri Pirko <jiri@resnulli.us> wrote:
>> >> Mon, Nov 20, 2023 at 03:23:59PM CET, jhs@mojatatu.com wrote:

[...]

>
>> tc BPF and XDP already have widely used infrastructure and can be developed
>> against libbpf or other user space libraries for a user space control plane.
>> With 'control plane' you refer here to the tc / netlink shim you've built,
>> but looking at the tc command line examples, this doesn't really provide a
>> good user experience (you call it p4 but people load bpf obj files). If the
>> expectation is that an operator should run tc commands, then neither it's
>> a nice experience for p4 nor for BPF folks. From a BPF PoV, we moved over
>> to bpf_mprog and plan to also extend this for XDP to have a common look and
>> feel wrt networking for developers. Why can't this be reused?
>
>The filter loading which loads the program is considered pipeline
>instantiation - consider it as "provisioning" more than "control"
>which runs at runtime. "control" is purely netlink based. The iproute2
>code we use links libbpf for example for the filter. If we can achieve
>the same with bpf_mprog then sure - we just dont want to loose
>functionality though.  off top of my head, some sample space:
>- we could have multiple pipelines with different priorities (which tc
>provides to us) - and each pipeline may have its own logic with many
>tables etc (and the choice to iterate the next one is essentially
>encoded in the tc action codes)
>- we use tc block to map groups of ports (which i dont think bpf has
>internal access of)
>
>In regards to usability: no i dont expect someone doing things at
>scale to use command line tc. The APIs are via netlink. But the tc cli
>is must for the rest of the masses per our traditions. Also i really

I don't follow. You repeatedly mention "the must of the traditional tc
cli", but what of the existing traditional cli you use for p4tc?
If I look at the examples, pretty much everything looks new to me.
Example:

  tc p4ctrl create myprog/table/mytable dstAddr 10.0.1.2/32 \
    action send_to_port param port eno1

This is just TC/RTnetlink used as a channel to pass new things over. If
that is the case, what's traditional here?


>didnt even want to use ebpf at all for operator experience reasons -
>it requires a compilation of the code and an extra loading compared to
>what our original u32/pedit code offered.
>
>> I don't quite follow why not most of this could be implemented entirely in
>> user space without the detour of this and you would provide a developer
>> library which could then be integrated into a p4 runtime/frontend? This
>> way users never interface with ebpf parts nor tc given they also shouldn't
>> have to - it's an implementation detail. This is what John was also pointing
>> out earlier.
>>
>
>Netlink is the API. We will provide a library for object manipulation
>which abstracts away the need to know netlink. Someone who for their
>own reasons wants to use p4runtime or TDI could write on top of this.
>I would not design a kernel interface to just meet p4runtime (we
>already have TDI which came later which does things differently). So i
>expect us to support both those two. And if i was to do something on
>SDN that was more robust i would write my own that still uses these
>netlink interfaces.

Actually, what Daniel says about the p4 library used as a backend to p4
frontend is pretty much aligned what I claimed on the p4 calls couple of
times. If you have this p4 userspace tooling, it is easy for offloads to
replace the backed by vendor-specific library which allows p4 offload
suitable for all vendors (your plan of p4tc offload does not work well
for our hw, as we repeatedly claimed).

As I also said on the p4 call couple of times, I don't see the kernel
as the correct place to do the p4 abstractions. Why don't you do it in
userspace and give vendors possiblity to have p4 backends with compilers,
runtime optimizations etc in userspace, talking to the HW in the
vendor-suitable way too. Then the SW implementation could be easily eBPF
and the main reason (I believe) why you need to have this is TC
(offload) is then void.

The "everyone wants to use TC/netlink" claim does not seem correct
to me. Why not to have one Linux p4 solution that fits everyones needs?

[...]

