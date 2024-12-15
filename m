Return-Path: <bpf+bounces-46999-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 993039F24D5
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 17:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184681885F0C
	for <lists+bpf@lfdr.de>; Sun, 15 Dec 2024 16:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C3A18FDA3;
	Sun, 15 Dec 2024 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANls4kyt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49288320E
	for <bpf@vger.kernel.org>; Sun, 15 Dec 2024 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734281478; cv=none; b=AFwFsEcRqyN2UV6M9P8khP9oXhi/0kJ5ssCinYh9lAF1gQy5NwaETVI5S3mhQqZdOAZDwL6/bkr/W3E7So9wek2P+h5bmLDDWXJoRwI3DxnrkqxRplCrV9m2RzMDSIUQdMczu+D1vcu1YWP5+pn2Gkh8Ne7Z/ZRpT20DW5Ax8tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734281478; c=relaxed/simple;
	bh=GE4D28+gEBrZt3wmOef4cb8Ukx935RQzRrJZNQ5YHGg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RBDIOSg7URTAkgy690NsF0PyFnfGzMBWJdRwj9dMRh52S5RvkauSWl4igh1MV/6Uq5PtmcIWEd6q+LxaJn4e1nnFObJcuvjkMOiJoMF+UNl+4gJDSF1Nw7uXZOIdD6T36bx/ytkjLpYGZDK+05soCI2+MxY6DPSix+0qsfTIOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ANls4kyt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734281475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GE4D28+gEBrZt3wmOef4cb8Ukx935RQzRrJZNQ5YHGg=;
	b=ANls4kytQoqeYLIGJoVhwUpjcyXcu+H/lej33APMMz5QkoTGzDFrreAWynRo7tKybL1xDH
	TPFr2NrqmOuXwpGWDc0t+5BeqR27D9hF5oatCSJpsIvaPhSUNnEcKUQ8/dgjzmZ6GICqSS
	IHwM89agOgDjqIQtk7O0mqTZBKP2b1E=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-eqZHElqwNfu_9fUicT3Ltg-1; Sun, 15 Dec 2024 11:51:12 -0500
X-MC-Unique: eqZHElqwNfu_9fUicT3Ltg-1
X-Mimecast-MFC-AGG-ID: eqZHElqwNfu_9fUicT3Ltg
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-3022741859eso17793811fa.2
        for <bpf@vger.kernel.org>; Sun, 15 Dec 2024 08:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734281471; x=1734886271;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GE4D28+gEBrZt3wmOef4cb8Ukx935RQzRrJZNQ5YHGg=;
        b=pDTvOKLT4iBIUMJrojQjXEESqpeaYC3T68wuT00XsmP49fuK/Mk7zzSQ1iR5XUWoLR
         wDmMup3/mxKYnK8N2odYNolSPIrNhhmlkp2HidNmT7nRUIKGlBRmnBT6dQaN90pIFpHm
         8c+XQbYhxeUXKsAZj8Kmmvtgb9R/Eb0BUzYNbJEC+LS8Gbn22gIxEBUs1Js5xl2P7Q+K
         6M4iFm596vVpgFWZi4bj5SnhPbj3qSBCfBU03HZyFffqf8WmyjfCh4QNhWHmVmnhrCoc
         A7KewU1AweZfUABEXxsbSvT7QV0ZFXJ7CmmWt1Jkf7xrevSt+Fu9oxBsiCLDWZaFx6wR
         KKnw==
X-Gm-Message-State: AOJu0Ywy3jrCvgF4O7sLxthPoQK5yg30S+ZwnHgjzJtvd4T98YN0nw7G
	ClcEBiUk8HZuUDRuCTfvZYyJe+nbW6GcKKhWaigRoabhXCpLLImmoD+8SmFJha6z+gqg2/4TK8i
	l306bCmJXm5apfeG5acWe7+D1p68Cli7Y8CPMCUBMhiUQOsxxWg==
X-Gm-Gg: ASbGncuB/sawB0PMrUr2hT27NUg3grLBB8feq/TCxkbwnu/F8SOh9xbADw/OGkLoikm
	lumo79O8YnYawIdm7rEsa6laaQcwQB12ArsEsBwHcxlpNsfeMePhrmbDY+QUC6NrTeOQf73GigU
	fEfS3FpO2PWP1cgzz1vAkLkL9/HmYRGqb4zoflS7UBQ/ecZiZHJj+dnit5eU1tQQOWL9ml+CVU7
	kRArLYrLeHdEZEIJg1QYz/NVLyJMFc36rmFrhWCPfgy67HNhl5agg==
X-Received: by 2002:a2e:be07:0:b0:302:5391:3faf with SMTP id 38308e7fff4ca-30254460e49mr28498641fa.17.1734281471319;
        Sun, 15 Dec 2024 08:51:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3gkCh2RlxpyDiu9jq4K7lYj1olyjRgqS6uKmZrjw8FOWxlHVQj6K6N9Njy1X738249EfPFQ==
X-Received: by 2002:a2e:be07:0:b0:302:5391:3faf with SMTP id 38308e7fff4ca-30254460e49mr28498521fa.17.1734281470923;
        Sun, 15 Dec 2024 08:51:10 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-303441d3d6asm6662881fa.120.2024.12.15.08.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 08:51:09 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E47AE16F990B; Sun, 15 Dec 2024 17:51:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Hou Tao <houtao@huaweicloud.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, Yonghong Song
 <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri
 Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner
 <tglx@linutronix.de>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <linux@weissschuh.net>, Hou Tao
 <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Subject: Re: [PATCH bpf v2 7/9] bpf: Use raw_spinlock_t for LPM trie
In-Reply-To: <23c8dc9b-4a4d-0fa1-8362-770ffd6aea35@huaweicloud.com>
References: <20241127004641.1118269-1-houtao@huaweicloud.com>
 <20241127004641.1118269-8-houtao@huaweicloud.com> <87frnai67q.fsf@toke.dk>
 <CAADnVQLD+m_L-K0GiFsZ3SO94o3vvdi6dT3cWM=HPuTQ2_AUAQ@mail.gmail.com>
 <fede4cf9-60df-ce3a-9290-18d371622d3b@huaweicloud.com>
 <878qsua2b5.fsf@toke.dk>
 <23c8dc9b-4a4d-0fa1-8362-770ffd6aea35@huaweicloud.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Sun, 15 Dec 2024 17:51:06 +0100
Message-ID: <87ttb4khz9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hou Tao <houtao@huaweicloud.com> writes:

> Hi,
>
> On 12/5/2024 5:47 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Hou Tao <houtao@huaweicloud.com> writes:
>>
>>> Hi,
>>>
>>> On 12/3/2024 9:42 AM, Alexei Starovoitov wrote:
>>>> On Fri, Nov 29, 2024 at 4:18=E2=80=AFAM Toke H=C3=B8iland-J=C3=B8rgens=
en <toke@redhat.com> wrote:
>>>>> Hou Tao <houtao@huaweicloud.com> writes:
>>>>>
>>>>>> From: Hou Tao <houtao1@huawei.com>
>>>>>>
>>>>>> After switching from kmalloc() to the bpf memory allocator, there wi=
ll be
>>>>>> no blocking operation during the update of LPM trie. Therefore, chan=
ge
>>>>>> trie->lock from spinlock_t to raw_spinlock_t to make LPM trie usable=
 in
>>>>>> atomic context, even on RT kernels.
>>>>>>
>>>>>> The max value of prefixlen is 2048. Therefore, update or deletion
>>>>>> operations will find the target after at most 2048 comparisons.
>>>>>> Constructing a test case which updates an element after 2048 compari=
sons
>>>>>> under a 8 CPU VM, and the average time and the maximal time for such
>>>>>> update operation is about 210us and 900us.
>>>>> That is... quite a long time? I'm not sure we have any guidance on wh=
at
>>>>> the maximum acceptable time is (perhaps the RT folks can weigh in
>>>>> here?), but stalling for almost a millisecond seems long.
>>>>>
>>>>> Especially doing this unconditionally seems a bit risky; this means t=
hat
>>>>> even a networking program using the lpm map in the data path can stall
>>>>> the system for that long, even if it would have been perfectly happy =
to
>>>>> be preempted.
>>>> I don't share this concern.
>>>> 2048 comparisons is an extreme case.
>>>> I'm sure there are a million other ways to stall bpf prog for that lon=
g.
>>> 2048 is indeed an extreme case. I would do some test to check how much
>>> time is used for the normal cases with prefixlen=3D32 or prefixlen=3D12=
8.
>> That would be awesome, thanks!
>
> Sorry for the long delay. After apply patch set v3, the avg and max time
> for prefixlen =3D 32 and prefix =3D128 is about 2.3/4, 7.7/11 us respecti=
vely.

Ah, excellent. With those numbers, my worries about this introducing
accidental latency spikes are much assuaged. Thanks for following up! :)

-Toke


