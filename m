Return-Path: <bpf+bounces-37389-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 109E995512E
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 21:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA311F23BC6
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 19:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317121C3F16;
	Fri, 16 Aug 2024 19:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="eExozbHz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B467824BB
	for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723835032; cv=none; b=gMhoq+d+1mTqvCUrbZHRIOvIywGnLrl63eBZYANz05d+/eotCpqYV8EOclsE/Q2edytP+Re3ZEdT3pi8GM0t73ukWDF++X15J6Cw4n1RQJ5ggHN8L5PqFTh4u9teV6L0OyJ3by85BSOCWlaN2jmP05IJ2iQ1RPX9BPComrxttlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723835032; c=relaxed/simple;
	bh=Mc4T9iIXjOcQFUOiud3CnyHPyMK9EQB6qvuWeFQkTig=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=odV4FVFaZzbf91Wjjm++FsP+WRv+8UnLPvfVmRYynl3Z3j1HU6A/2+0Xll7b2I91znG+lIcE1sQ3dFqcQyRKaqKBcKbD1gTIaPqFGnZr9fhefDwTgTEy7QoRBN6bMnjYjZNKCpPUYid8+KewVfpD1YN+1DiwER/JMT8UJ4QLOwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=eExozbHz; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5b5b67d0024so2884659a12.0
        for <bpf@vger.kernel.org>; Fri, 16 Aug 2024 12:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723835029; x=1724439829; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BrBxZgECaC7/1MG5XVHMQd0NOSd+rm2Uh6YDq8DhIA8=;
        b=eExozbHzfoIDwtFw3j6aQjiB4h/wU0i4MBQCXDtWSsky7eFOtV4032DzXhnrgzVNCg
         8P43bjgTxKj+SOcLKXRzHVlYkyQTdY5luJs/nkFc+L/evg5VmOra1/auX6BlizUKyKZE
         EgzyGCX18VOMDx1yV0GOYPctAHc4eG8DyRiJbnV7Jbr42VvDTME4ynTIQYKs93FAr0AG
         Yll0tLK9NObr0inJYMK368Ie5TpnHB09q6009n+PXjIeBkNliPRtvBkECKgHvYurV2ZM
         KRE031Ym15fZlUVKBZbj6DFtURTYVEF371ONMMiFNVtAXJvMSCBmesBTnrFjXrCivOnW
         AxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723835029; x=1724439829;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BrBxZgECaC7/1MG5XVHMQd0NOSd+rm2Uh6YDq8DhIA8=;
        b=lyXwTgsgeOqhGQxCafPp58A/FzQuSQcB+fkmmCZOnkS+6ADxh8jtIeoI1WKvl98vA3
         JdPccE2pB1jlSwiu5RcOc1PugXer59jTwYwM48aKdYze71SsslSsVAggbNxZDmWZ/NXO
         ko/wYmXGi1t8C1dLtik4J1TUxeViOTZnYPaInjyng/03tVv6zO5gXpds4GWnEwDCC/8q
         HTPjMXWXsbnIItCn4NIZUS4aC1fyFijlSo6G9jauwTTKXCNf5D8AIsyM+FBaKEkyGKXk
         Pskqxpvus5WvJISqXhD1t43FlJ49R4i2SzpsU9bI1fH1hkjinAz8fOtoY0TJGWkSLhGB
         U0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUIxzxB8yr691eS4S8UXYUnYnaPZPc0u8mzWk4jVR5oIi6AvMoan38aRYq819iog6Pb74uLKm0OWQCPUlwKsl8ZsVgM
X-Gm-Message-State: AOJu0YwOzCL9P1QRIO1vzFLzA8auSJIDjIqN3sYm5A5Iq9cElriQ1zd1
	nJ1IiZmOwQqY0HLQC78hGMavFJcbGpnOm7Za3oCEHWaxMAJYmOaiK7YMeTUCq6s=
X-Google-Smtp-Source: AGHT+IGl5+6tEP5wmb8EU87stkIU+j/Z2sdmdIPv5B1ko18jC6BAETYUa9tR1wBvVnp8+UoFJbraUg==
X-Received: by 2002:a17:907:c7dc:b0:a6f:8265:8f2 with SMTP id a640c23a62f3a-a8392955fcemr321176066b.37.1723835028599;
        Fri, 16 Aug 2024 12:03:48 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfd5esm293566766b.78.2024.08.16.12.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 12:03:47 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Michal Luczaj <mhal@rbox.co>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,  Mykola Lysenko <mykolal@fb.com>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  John Fastabend <john.fastabend@gmail.com>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related
 fixes
In-Reply-To: <42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co> (Michal Luczaj's
	message of "Wed, 14 Aug 2024 18:14:56 +0200")
References: <20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co>
	<87y159yi5m.fsf@cloudflare.com>
	<249a7dc3-34e2-4579-aae7-8b38b145e4bb@rbox.co>
	<87ttfxy28s.fsf@cloudflare.com>
	<42939687-20f9-4a45-b7c2-342a0e11a014@rbox.co>
User-Agent: mu4e 1.12.4; emacs 29.1
Date: Fri, 16 Aug 2024 21:03:46 +0200
Message-ID: <871q2o5lyl.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 14, 2024 at 06:14 PM +02, Michal Luczaj wrote:
> On 8/6/24 19:45, Jakub Sitnicki wrote:
>> On Tue, Aug 06, 2024 at 07:18 PM +02, Michal Luczaj wrote:
>>> Great, thanks for the review. With this completed, I guess we can unwind
>>> the (mail) stack to [1]. Is that ingress-to-local et al. something you
>>> wanted to take care of yourself or can I give it a try?
>>> [1] https://lore.kernel.org/netdev/87msmqn9ws.fsf@cloudflare.com/
>> 
>> I haven't stated any work on. You're welcome to tackle that.
>> 
>> All I have is a toy test that I've used to generate the redirect matrix.
>> Perhaps it can serve as inspiration:
>> 
>> https://github.com/jsitnicki/sockmap-redir-matrix
>
> All right, please let me know if this is more or less what you meant and
> I'll post the whole series for a review (+patch to purge sockmap_listen of
> redir tests, fix misnomers). Mostly I've just copypasted your code
> (mangling it terribly along the way), so I feel silly claiming the
> authorship. Should I assign you as an author?

Don't worry about it. I appreciate the help.

I will take a look at the redirect tests this weekend.

> Note that the patches are based on [2], which has not reached bpf-next
> (patchwork says: "Needs ACK").
>
> [2] [PATCH bpf-next v2 0/6] selftests/bpf: Various sockmap-related fixes
>     https://lore.kernel.org/bpf/20240731-selftest-sockmap-fixes-v2-0-08a0c73abed2@rbox.co/

Might have slipped throught the cracks...


Andrii, Martin,

The patch set still applies cleanly to bpf-next.

Would you be able to a look at this series? Anything we need to do?

Thanks,
(the other) Jakub

