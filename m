Return-Path: <bpf+bounces-77360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F24CD8CD6
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 11:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C75304E579
	for <lists+bpf@lfdr.de>; Tue, 23 Dec 2025 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570F735F8B1;
	Tue, 23 Dec 2025 10:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcXR/eLR";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bqcg7kit"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C9C30C615
	for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766485675; cv=none; b=BdNOKtYteraBtHVwJT0cshL5AbOlbgvQ06X0/MK23lH9KCq0znpOe1y6eCqgrBbw2U3RyyrFFJfY8omU0FSUYkV9q9naLKrYRwLZVXaBiCxUiFs8lEGadaRm2lgVYiYfQx71z5fI9PMMmXs+kyxKu639ofePUjBvZqKlnt5+/bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766485675; c=relaxed/simple;
	bh=sCTEwrWLKqtVrl6SpFKxM5QRhYCfIEKH2rZHvlkAm68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mwfgx5y+GhTvc52247IUcZJ/0B9CBXucaUAqCk0vnfSDBXYN0Fc880HpGYLUBxNAC1A9h5C505cWlGm7Jh6SBkQby9s1XVAa4W4Nl9HFufcsmupbanTKgi3A1rTyvnFLMk5UtN37cavIjYTl1TIbX9MoW0JEtRRGMaJp2ni+8Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcXR/eLR; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bqcg7kit; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766485673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gW6Az7Odb7vsxG49M4eWTPA9mVwU0/De6Xv1KzqFvrI=;
	b=LcXR/eLRL64RelzDt1diQcxoegmKMhOGOgbGF6O/gxCIHvA0nK+4BTf3ZdWrQFMZzPZ+L5
	92S29XyTGNlARz1TA6k1YijYmZYF8tnd/KWg+MS8lAuC2Dlq5ULOjL0PcPgjLWQZPaUUMG
	Yrp+hkraZq7bQ5M90yOc+TpaJDRNepk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-70SruCqfMvOnByqRy5R3Vw-1; Tue, 23 Dec 2025 05:27:50 -0500
X-MC-Unique: 70SruCqfMvOnByqRy5R3Vw-1
X-Mimecast-MFC-AGG-ID: 70SruCqfMvOnByqRy5R3Vw_1766485669
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47918084ac1so41502545e9.2
        for <bpf@vger.kernel.org>; Tue, 23 Dec 2025 02:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766485669; x=1767090469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gW6Az7Odb7vsxG49M4eWTPA9mVwU0/De6Xv1KzqFvrI=;
        b=bqcg7kit4SPNxtT6Shz6e0/2aarOYR9Dx+ymdnT2/dEtFihNB09r9aOiYDH06qDsT7
         TAWMXP+PCc8Z50mOUG0HhcPy3VqttKDFFdbMlf/kf/Urbt1xDVWpFsx5Wg3gr2NIQoBj
         WyYtHJ/iozu1BKXRGoXKeXmhc2CSlefkHghKQ8FPQPV+c0jLnG3/spyiohk676h0pk3y
         J+cesC092ZrsNlR42VQXVppWMjhoBpFs5sna7A2k+A+noNbQkFYcS/CZw2JJa2syOdM6
         kintmu0ow3+8qeyCYmaGe6wnkahhYQpKgGIUqLhjp7dr5w+XsglnunHc9UMU2zRcB0Ae
         mkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766485669; x=1767090469;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gW6Az7Odb7vsxG49M4eWTPA9mVwU0/De6Xv1KzqFvrI=;
        b=KwsfZqj9rINQAUXkS5dXoBvpueum5x1wNs9L29wtayd7bSa4hCdL9t81t26veCKHWP
         IzA8kJNG3CEZYU7o898Z8RD+JIK1pgGLO3VdbZG7/1oITBvN1o3X/YVUeQMXv25W101i
         9Bxje/grYZnfuAtWvLIubR835fqfu9VZUTClSx5nYoFqVt6t0RYydtnLFXHkBUXRoShg
         5kTp9g2/ZmTrHUKKTte+4Q4CRPlR2C/FyjMZNX8/5uPTCrjlhAI8GVIf7nFNpTS0NGYL
         cSnwdMGmxX08emIeSIkTSFyfPg6J7c8ad5vaboUZc2J5+rb28JNimAQhz42gZkUGcjkL
         Srug==
X-Forwarded-Encrypted: i=1; AJvYcCXlUN6b55Judle/orZd7jlFeIePTHswLeOYCjE7u2n8YoMmOwZI4i4x7p9zPrBpgmbvv7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWnhG4Pa4+0DhGTvV4f8fVrgGJUMruuI9HoCMCCbVybIG7hp4
	SAOhfwZBAN8b/9U67PyTFpg2PYeCTpdUc/Uk4fWB1n1XJhTcvVsRQsQCi/erRJY9U6k5lTi2I8J
	8vZjJM1fhtI9VDG35ryGZv1++aLE3pO6OJue1PcYJMe1YOAknQJhe+g==
X-Gm-Gg: AY/fxX6Db0ayLMUh/qWZ1DtUskFsuwJ6/oWg6X/swvkylow7BIFXQyGbejr6tBmmTfM
	zNHfZM0F0BRqeFzQ6EHHhArGDvwiSW6RRdj0eTG/68xwkOs4hVD2xjw8iEz6F2QsVKCmgiT0PEN
	YHVzCLF/9ojaJbLiS70fGiWlDX8cXvwGAX5UnMQygnfd8wUTfKYbLYorQ1eVccLh10dHbeiQmPq
	+f9N4rn0ZEXVZ+EVPzR4cebfsLo3UmvTshBouiVgJfN+xj4v5mRLaTmi5GAIn0x4+wWIZ0BjQyn
	r7FjuAGY+7MHT8/z1WZTMVMiSPKmw7nxZAY6uFXVVKvTCBINgSp9yJKbpkNuINBXtaA8T4SxCqq
	QRBM6J2UHNtMI
X-Received: by 2002:a05:600c:350b:b0:477:aed0:f403 with SMTP id 5b1f17b1804b1-47d19549a95mr128307505e9.8.1766485669504;
        Tue, 23 Dec 2025 02:27:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEo2375ubP3NGR4G/066i7ZpeEj+Z0OlHm2MPrvB8YlHkxm/CeEdo9o2skjUY6UCqpZioUlDA==
X-Received: by 2002:a05:600c:350b:b0:477:aed0:f403 with SMTP id 5b1f17b1804b1-47d19549a95mr128307235e9.8.1766485669030;
        Tue, 23 Dec 2025 02:27:49 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.164])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830f3sm26613687f8f.22.2025.12.23.02.27.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Dec 2025 02:27:48 -0800 (PST)
Message-ID: <a10a9239-ea4b-4a78-a5e6-d38d6ba749a9@redhat.com>
Date: Tue, 23 Dec 2025 11:27:45 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] finalize removing the page pool members in struct
 page
To: Byungchul Park <byungchul@sk.com>, Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel_team@skhynix.com, harry.yoo@oracle.com,
 ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
 andrew+netdev@lunn.ch, edumazet@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, rppt@kernel.org,
 surenb@google.com, mhocko@suse.com, horms@kernel.org, jackmanb@google.com,
 hannes@cmpxchg.org, ziy@nvidia.com, ilias.apalodimas@linaro.org,
 willy@infradead.org, brauner@kernel.org, kas@kernel.org, yuzhao@google.com,
 usamaarif642@gmail.com, baolin.wang@linux.alibaba.com,
 almasrymina@google.com, toke@redhat.com, asml.silence@gmail.com,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, sfr@canb.auug.org.au,
 dw@davidwei.uk, ap420073@gmail.com, dtatulea@nvidia.com
References: <20251216030314.29728-1-byungchul@sk.com>
 <776b0429-d5ae-4b00-ba83-e25f6d877c0a@suse.cz>
 <20251218001749.GA15390@system.software.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251218001749.GA15390@system.software.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 1:17 AM, Byungchul Park wrote:
> On Wed, Dec 17, 2025 at 02:43:07PM +0100, Vlastimil Babka wrote:
>> On 12/16/25 04:03, Byungchul Park wrote:
>>> Since this patch requires to use newly introduced APIs in net tree, I've
>>> been waiting for those to be ready in mm tree.  Now that mm tree has
>>> been rebased so as to include the APIs, this patch can be merged to mm
>>> tree.
>>>
>>> This patch has been carried out in a separate thread so far for the
>>> reviews [1]:
>>>
>>>  [1] https://lore.kernel.org/all/20251119012709.35895-1-byungchul@sk.com/
>>> ---
>>> Changes from v1:
>>>       1. Drop the finalizing patch removing the pp fields of struct
>>>          page since I found that there is still code accessing a pp
>>>          field via struct page.  I will retry the finalizing patch
>>>          after resolving the issue.
>>
>> Could we just make that necessary change of
>> drivers/net/ethernet/intel/ice/ice_ethtool.c part of this series and do it
>> all at once? We're changing both mm and net anyway.
> 
> Yes.  That's what I think it'd better do.  1/2 can be merged separately
> and Andrew took it.  I'd like to re-post 'ice fix' + 2/2 in a series if
> it's allowed.
> 
>> Also which tree will carry the series? I assume net will want to, as the
> 
> I'm trying to apply changes focused on mm to mm tree, and changes
> focused on net to net tree.  However, yeah, it'd make things simpler if
> I can go with a single series for mm tree.

I *think* that the ice patch should go via the net-next tree (and
ideally via the iwl tree first). Also it looks like both patches could
cause quite a bit of conflicts, as the page pool code and the ice driver
are touched frequently.

Perhaps the easier/cleaner way to handle this is publishing a stable
branch somewhere based on the most recent common ancestor and let both
the mm and the net-next tree pull from it? Other opinions welcome!

Anyway the net-next tree is and will be closed up to Jan 2.

Cheers,

Paolo



