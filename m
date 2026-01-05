Return-Path: <bpf+bounces-77853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD74CF4D48
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 17:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D85823033990
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 16:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA90309EE3;
	Mon,  5 Jan 2026 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzqAr25g";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfTT5jWW"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7A2FBF0
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767631438; cv=none; b=OtnD33nu0adUTZ8thWD2YD+m0Y1GrwweTGcVgvGembFooFGQzqn2t3rYks7qgeWnK9J87SkQ7OnQ5nai/yT2ftNcAPYHuZNmbecfvhLgCC8wjq/CiJ4WvSPNCg3WN0zNby2CGiUMfH1XowYEcGXVKpOFq6ltutw7EsDvcCM8WeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767631438; c=relaxed/simple;
	bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ehsjrorg3WjlHXDcgrAsmXKVR4O0xO3FzSZ0+JgSdbnsgDrJHVq+ePexEIRGHemk4y9ahUWxpUk8gPcDhEQFpuSPlzA0zONTgMU6T2IsAXTLzzNo0EQtm7F1gZuRRmoio79vn3asO0NdNVm8mRvZx+VWULKULMzkGrzwRyxlaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gzqAr25g; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfTT5jWW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767631436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
	b=gzqAr25gSiIvsTcESOb4KHt+147RJpuJxZ86SUrYVUtM2ef97Mca98OgrAYQigUvpoq2la
	d45AE0MNLBH5AjZYrl0i0b67taJTCYKOjfJd0KPdZrxamIFBVtw3Js37SITDY8PBNETaLw
	EwSBHvtVERarPEF3XZMR1pOkd5B1Qpg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-YFAxtkgDMbG0QEeTn32uCA-1; Mon, 05 Jan 2026 11:43:53 -0500
X-MC-Unique: YFAxtkgDMbG0QEeTn32uCA-1
X-Mimecast-MFC-AGG-ID: YFAxtkgDMbG0QEeTn32uCA_1767631432
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64d1982d980so93988a12.2
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 08:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767631432; x=1768236232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
        b=BfTT5jWWW9XcWvj2mHWxy95/dLJmljmH225nTzmf9u01uoo+9HWhIKFHWalLCZq+Oo
         XXcCsC3sMvGWfXDw1G3idF6qakzRnpWdKQn7MszfbcmtxleLFQVdi359RqvqUmtqOWeM
         Zdmn5A9D/SZKOYilVIQWPq4Y+tzG6GtgU0+/OFC5dN6efNxIuXhLEopShYsuDXWUqwJB
         kaRjDqLsHMx7CK41m8C7oa2wLcez1cYUFD1nqeG3pmjGCi46tanzzjphD3bXCqvsfqNt
         udlNwWdAiOVT35KkUM0bus6VfS9XUXeL+u0u0dpkKKOegkhFVnUhuWrki729FpconX2d
         7HjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767631432; x=1768236232;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V2RcMFWNxHXpx7Cbk1wLqeq5HUPDZY2CLps3fwdMAtY=;
        b=lJF3gSZU+BnqDZkSjypBIk20OwhDoLYv8bkILKbSqK1yk0/3GMUDPXk3u2hxQ+6878
         SdnMpJXgYU5/qBl8PNxTAF34MYKPA7tszR4dhfBpFbn0gP+MI3LNlT5LbM7AQjq5OBdT
         rpLyPxgGMc7IM85w3Csl1nwpDm7l9tFDjsuVqujMOP4oKY9nzbrj0mOBoSWUZ9b02Nsl
         1YonUWaNOjwM6OAI79JETreajtNddGCWfuSSgTeXT2ls1CtIhegKyde4SNjYvWlOftJB
         o79JBGR/BnlndW0e5anquO9oLBvGPrZ2KnlyavENmYhr3wztotJezN90527mTUv/1I/o
         Nd1A==
X-Forwarded-Encrypted: i=1; AJvYcCXFhKmQp4avWkv2IMTbO5UARksnx9635OogGmOZyvsNJ8MnakambdwoeRjaA/1iqRpj2sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG6S+07IMwTpkly5YDilCrdNdg+vhBah5dx0FOgST0lmkfQ8pn
	DI1YjvO6nq2NdPG5DoK4ScIAR3rk80OH8G7n+fjh2j4Bl53elldtWDhCOh1uffdO/0D6atVz7xH
	2vFp+3RDSv4BQct1Bf8aHX7mSfwRGMP4A7R7U77AaxneJ2nXXXwg1xg==
X-Gm-Gg: AY/fxX5i1BQkJHXdyATMGCUg5QMCuYHUTDi00OxO2S6dcXdC/0AOxkp9gkc0a6e4TIG
	uSipcU1wwXiD2s9WXntty8cnw/FxpsTCrNjUvkqdz6G44/c9PVK9oCg2jAbzzpmLNMlr1NVS+Zg
	erC0d52WzMoOy0xHIuhmNd6MqjSBBFfPcWyyG50fwKaj+w+eGAOWAJockBFwW/YpWzF5xxiyI3l
	/JBlDofdPSqrxCjxyCnbaLTY/7nSS3kD1ANvBMBHNtDsWEsp6ppjI+/PgAJnd2XUZnNYwg29OA5
	u/StcGoKuA2GTy1Ynfe4b4MaQQSiw1/zgGO0KOtfb8Ehu96LbVSy+hLriEQwilu6AtjmB5OXfRm
	AiSNOPUETxW3wqPbQ8M7946MTF+iuBb9pkJFW
X-Received: by 2002:a05:6402:4414:b0:64b:ea6b:a884 with SMTP id 4fb4d7f45d1cf-65079561d9amr39806a12.17.1767631431873;
        Mon, 05 Jan 2026 08:43:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5+CYTAwrLc8azSOHqieZ/AYKr+pOh1WCTsnwOkUqmz4srueS6d/oRRO9LBMmPRJORe96YbQ==
X-Received: by 2002:a05:6402:4414:b0:64b:ea6b:a884 with SMTP id 4fb4d7f45d1cf-65079561d9amr39766a12.17.1767631431378;
        Mon, 05 Jan 2026 08:43:51 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507618cc31sm222081a12.24.2026.01.05.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:43:50 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 18D1C407EDE; Mon, 05 Jan 2026 17:43:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, shuah@kernel.org,
 aleksander.lobakin@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan Mei <M202472210@hust.edu.cn>,
 Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Fix user-memory-access
 vulnerability for LIVE_FRAMES
In-Reply-To: <38dd70d77f8207395206564063b0a1a07dd1c6e7.camel@linux.dev>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
 <20260104162350.347403-1-kafai.wan@linux.dev>
 <20260104162350.347403-2-kafai.wan@linux.dev> <87y0mc5obp.fsf@toke.dk>
 <38dd70d77f8207395206564063b0a1a07dd1c6e7.camel@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 Jan 2026 17:43:50 +0100
Message-ID: <87ms2s57sp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

KaFai Wan <kafai.wan@linux.dev> writes:

> On Mon, 2026-01-05 at 11:46 +0100, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> KaFai Wan <kafai.wan@linux.dev> writes:
>>=20
>> > This fix reverts to the original version and ensures data_hard_start
>> > correctly points to the xdp_frame structure, eliminating the security
>> > risk.
>>=20
>> This is wrong. We should just be checking the meta_len on input to
>> account for the size of xdp_frame. I'll send a patch.
>
> Current version the actual limit of the max input meta_len for live frame=
s is=20
> XDP_PACKET_HEADROOM - sizeof(struct xdp_frame), not
> XDP_PACKET_HEADROOM.

By "current version", you mean the patch I sent[0], right?

If so, that was deliberate: the stack limits the maximum data_meta size
to XDP_PACKET_HEADROOM - sizeof(struct xdp_frame), so there's no reason
not to do the same for bpf_prog_run(). And some chance that diverging
here will end up surfacing other bugs down the line.

-Toke

[0] https://lore.kernel.org/r/20260105114747.1358750-1-toke@redhat.com


