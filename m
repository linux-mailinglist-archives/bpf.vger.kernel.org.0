Return-Path: <bpf+bounces-15804-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 155B67F71AD
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 11:40:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98071B212E5
	for <lists+bpf@lfdr.de>; Fri, 24 Nov 2023 10:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842D91A5A2;
	Fri, 24 Nov 2023 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DYcv1TwT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00BA518E
	for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 02:39:51 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5441305cbd1so2358162a12.2
        for <bpf@vger.kernel.org>; Fri, 24 Nov 2023 02:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1700822390; x=1701427190; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E3CbeSPBGv/93N4a58P9G5/aucfGqzwYdA8+uNojSvY=;
        b=DYcv1TwT5fs8XfXra8ZEiJCyb+l2cmBxN70cbKCLxIWKC34jBcN6SeAAus/IF+W9VO
         TuFuMNOR4uWeKHKCEEqy6ULlxfY8gcTeJr4GTdkJprtwz//mTRttXSKBHy97TaZ+oIRV
         8f6myOv0kbiZLL+HK93CAtzHu8F3SZ3YBkutaaApqvOmNLM95DLuyHjehIZ326Z36bFW
         TrLd6Dm4EdEhc/kQ65/dDlS8XpJK1x0Wkz/uyA1UosIBTVnZ1iKNZAb7m+tYsAWIPiJm
         Jx95XcJlHwdRDzjPLH11mnwkvTp676EvG9GZoM6BpyfbCUzT4DcefXK9NMadHlNbmNUo
         hXNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700822390; x=1701427190;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3CbeSPBGv/93N4a58P9G5/aucfGqzwYdA8+uNojSvY=;
        b=IZUXAYdJLX2kdeWRu2iLLLxnh2gQdNOz5eWed2cL6W6XwwzCpJvdc8tSn7ozpdMrmg
         4axNjFQTZDK3vtd7tNzDqoOVNXYKBonM3njk+lBbVxD+7UR/EbHKVSnIulksZb1O+9dn
         dWMWmLMuCA+BsTz2YNimHYtbjMhuK8rQ9zZ+M2LTAVUJvh+dS0sACUzmTuP6ZBi7bRC5
         qi4l/ORIvZGZNaENFeUKYpFYAciUSO6pBIaS6KmjqKNFCSvI5AIduUJPxDI3JLbFyZbs
         DkSUFVk3Ebk26tB7u3vN8pmDGS26r9ygBYM7NtBZXZEe6L/PvKZN4y5XKZLxFO4u01fi
         MyKQ==
X-Gm-Message-State: AOJu0YzU0/5GlwoVXGlkF0l0Ta9tH94Yk8yhCrz4wlrqAEN6ootJUaNM
	Zc7gjnY5fqtyqbWOG4CQy2ECVg==
X-Google-Smtp-Source: AGHT+IHBQS9u0x8xZRIF1tYnmQbgx7Tl8spe3HLfZnEj6pYZl4ExuWUKfoudSxw3WaKk/G1xMy0J/w==
X-Received: by 2002:a50:9312:0:b0:53e:3b8f:8a58 with SMTP id m18-20020a509312000000b0053e3b8f8a58mr1968390eda.11.1700822390310;
        Fri, 24 Nov 2023 02:39:50 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i12-20020a056402054c00b00548851486d8sm1638589edx.44.2023.11.24.02.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Nov 2023 02:39:49 -0800 (PST)
Date: Fri, 24 Nov 2023 11:39:48 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	deb.chatterjee@intel.com, anjali.singhai@intel.com,
	Vipin.Jain@amd.com, namrata.limaye@intel.com, tom@sipanda.io,
	mleitner@redhat.com, Mahesh.Shirshyad@amd.com,
	tomasz.osinski@intel.com, xiyou.wangcong@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	vladbu@nvidia.com, horms@kernel.org, bpf@vger.kernel.org,
	khalidm@nvidia.com, toke@redhat.com, mattyk@nvidia.com,
	dan.daly@intel.com, chris.sommers@keysight.com,
	john.andy.fingerhut@intel.com
Subject: Re: [PATCH net-next v8 00/15] Introducing P4TC
Message-ID: <ZWB9dF8/Uk2iP2uy@nanopsycho>
References: <ZV7y9JG0d4id8GeG@nanopsycho>
 <CAM0EoMkOvEnPmw=0qye9gWAqgbZjaTYZhiho=qmG1x4WiQxkxA@mail.gmail.com>
 <ZV9U+zsMM5YqL8Cx@nanopsycho>
 <CAM0EoMnFB0hgcVFj3=QN4114HiQy46uvYJKqa7=p2VqJTwqBsg@mail.gmail.com>
 <ZV9csgFAurzm+j3/@nanopsycho>
 <CAM0EoMkgD10dFvgtueDn7wjJTFTQX6_mkA4Kwr04Dnwp+S-u-A@mail.gmail.com>
 <ZV9vfYy42G0Fk6m4@nanopsycho>
 <CAM0EoMkC6+hJ0fb9zCU8bcKDjpnz5M0kbKZ=4GGAMmXH4_W8rg@mail.gmail.com>
 <0d1d37f9-1ef1-4622-409e-a976c8061a41@gmail.com>
 <20231123105305.7edeab94@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123105305.7edeab94@kernel.org>

Thu, Nov 23, 2023 at 07:53:05PM CET, kuba@kernel.org wrote:
>On Thu, 23 Nov 2023 17:53:42 +0000 Edward Cree wrote:
>> The kernel doesn't like to trust offload blobs from a userspace compiler,
>>  because it has no way to be sure that what comes out of the compiler
>>  matches the rules/tables/whatever it has in the SW datapath.
>> It's also a support nightmare because it's basically like each user
>>  compiling their own device firmware.  
>
>Practically speaking every high speed NIC runs a huge binary blob of FW.
>First, let's acknowledge that as reality.

True, but I believe we need to diferenciate:
1) vendor created, versioned, signed binary fw blob
2) user compiled on demand, blob

I look at 2) as on "a configuration" of some sort.


>
>Second, there is no equivalent for arbitrary packet parsing in the
>kernel proper. Offload means take something form the host and put it
>on the device. If there's nothing in the kernel, we can't consider
>the new functionality an offload.
>
>I understand that "we offload SW functionality" is our general policy,
>but we should remember why this policy is in place, and not
>automatically jump to the conclusion.

It is in place to have well defined SW definition of what devices
offloads.


>
>>  At least normally with device firmware the driver side is talking to
>>  something with narrow/fixed semantics and went through upstream
>>  review, even if the firmware side is still a black box.
>
>We should be buildings things which are useful and open (as in
>extensible by people "from the street"). With that in mind, to me,
>a more practical approach would be to try to figure out a common
>and rigid FW interface for expressing the parsing graph.

Hmm, could you elaborate a bit more on this one please?

>
>But that's an interface going from the binary blob to the kernel.
>
>> Just to prove I'm not playing favourites: this is *also* a problem with
>>  eBPF offloads like Nanotubes, and I'm not convinced we have a viable
>>  solution yet.
>
>BPF offloads are actual offloads. Config/state is in the kernel,
>you need to pop it out to user space, then prove that it's what
>user intended.

