Return-Path: <bpf+bounces-77801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF64CF30C8
	for <lists+bpf@lfdr.de>; Mon, 05 Jan 2026 11:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D179B304154D
	for <lists+bpf@lfdr.de>; Mon,  5 Jan 2026 10:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECA93161BA;
	Mon,  5 Jan 2026 10:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CdsLPFoZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqIJNU23"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F1930FC37
	for <bpf@vger.kernel.org>; Mon,  5 Jan 2026 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610018; cv=none; b=a7tG6XqcUlUeh2LbwYBPXPakVyHumAFQObIkvTUDSamQFrmpPZxelXyPR2GQualjYhSVAHdq4YnOVZAVQaEjKFTWjzMa2ukjXBNoJ0ek7u8YEZM1CU1xDwtG/EBnGvHsP8ImDpj+Km6UfQcGQGd+UEpz24Do7pXe9tods7pvP9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610018; c=relaxed/simple;
	bh=R92sfuFN6VXvFyeKVBFJ2uVf3HN5zZU1eiBvYWPC9Mc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LlF0zqRH6saz22kfMfsSiBGenQLMM+yEVCMvYIcJZorFO3fOcl3m2gryNqtLTVsbavFh3yOIQCP2ywpj/f9gu3+ZeO1b/qUvQAVVqWowIyoNXUBgGOPeHX0ooWIWeYFvWTz0llR6YRgzKGnuaIB+/fX0jT54w4XgVTzl3HxkZkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CdsLPFoZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AqIJNU23; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767610014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R92sfuFN6VXvFyeKVBFJ2uVf3HN5zZU1eiBvYWPC9Mc=;
	b=CdsLPFoZHpoTGZJYzD67bMgLkJTiDsYGOqV1dO1kyq7SL6h3r5RKQUWRR5ILbVrxmyYHbf
	YdXfYEZTwbh2ka8d7VOwiDEO4rKHcGwCKP5yHoH83kE4dPU/+bL8uDbNp387mU9QsfGLks
	CrevTWoAcF878gVob2kdwVh7pnXqngk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-QpmKMWVdPbW5pZEMSGxXGw-1; Mon, 05 Jan 2026 05:46:53 -0500
X-MC-Unique: QpmKMWVdPbW5pZEMSGxXGw-1
X-Mimecast-MFC-AGG-ID: QpmKMWVdPbW5pZEMSGxXGw_1767610013
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b801784f406so1423157266b.0
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 02:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767610012; x=1768214812; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=R92sfuFN6VXvFyeKVBFJ2uVf3HN5zZU1eiBvYWPC9Mc=;
        b=AqIJNU23+cyvHoACgS/1MqPnLi3XCNDBs3HjzrHQy0oHyrfMla3/tyDkuwtPEnWzqB
         l5LcQ1ITM2SZecvKD3bGR63m7z/nzyoc6mEskdEMjb12G22RljestrxmVZdKPqW5OcTw
         Sg6AH91AbmaUT/vT9MooPLTqifFfWyeH+Z9TKqlKSHGnwjTH1Eca5BUz9R+qYB+w0ruf
         DwKe0LyRatFFjoKKY2GxrVTCCU18tp78Jtzecssp3uhQQX1BrN8QSKGqCnxPP6rTSQTe
         +kXeWTVc9cR+LmvLxL/+6vzMYF9ECRGk64qBMD3DzUaSXOXEX4yWgy9yJd7BqBRRxkGM
         XtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767610012; x=1768214812;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R92sfuFN6VXvFyeKVBFJ2uVf3HN5zZU1eiBvYWPC9Mc=;
        b=tgwfj9PpRc+COgQW6ulo+AwJv1re9X7L4PdO12szAAFpQwn8QQVSBMa43ZbvlbCXAJ
         ZWwYJsC0RVSkxVoJ0S16npYzVPW8x8YasBfba9M5dkIGf0i7mxJLO259tSAoRh8VtHV5
         ycbAM/e1jANiVWyQxxI+pSm8K2l5j+9EPULxMh1V6C8B+fsdJTtpqAVpZjV/s+6KpNqv
         qAP41K5k5kPXwORsWlUztnUp2He7K/vdP/HXtDsVaGEC3Y+1L3NlcGFRXc3koDpuasJ8
         eMiOzswdf9cmuS+3BAwfKdPPH/+0FVMAb43QKdPTd5UX2qnPGiFO7I3MKAbCpfJR7sYi
         Pv6w==
X-Forwarded-Encrypted: i=1; AJvYcCUmrWCmspeYLGrJp0cPBOB8pyhudaQbq48QrjVo6sw47z5Zp9h89PsxkewxoaFBPjObqqg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvXa6pLhKUy5TZ8sfazr072TEWpRo6/UpuFuFGytaNiQuYjin6
	QhKY6Dc4qYl+bOrwfVWMubAGCyjPV/p39Paip9UkzTS7gptHgJ0WLxy8+dNxoGNc/HymenghrEv
	clrlTf7A9b20SxuHDiuHfoQT65ua9ZZPQCcSb4Al6FTScHpN8T5NBQQ==
X-Gm-Gg: AY/fxX76VhRRoEYA2fyL0uvvQCNL9I7GPW9Y1wsLVckW9QpWe63/PWNKmWziGAlzTlf
	sYoB51bVlTg9Vg7GD75oCP0q6Bci1//oTgN6kgX0krSfkkMtwEMI2JXdIiYaWc1d63V0adpFQeS
	XPvSgOM45S8da3IEarLd6uqVqxAOCpwepxuBdxGl478e30TZjb5+s5zNDhCLf17N0NAcJifLE7W
	Edg0TOWFUVJQjJKx8A9Yg+w95SaD9Y7TQPRtmvb7ANKyW72X0OYrhXbdjpxK24beQEa5ONiCt8H
	hNJcE3So1uBSkJqKfhyEiu4wpkGeMmyylntKznjZ4l5IzxF/BeqUdSCr74AcyRP58s+OqH7noEi
	rTdBZbcKn2zThJ70GY6QE8ECt0C7kQeooT7ec
X-Received: by 2002:a17:907:7fa8:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b8036fac50amr5432251266b.28.1767610012531;
        Mon, 05 Jan 2026 02:46:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxo3GoSY0pg7482wScLoSxSpKHDG2VZ6RLjUNgrk7dLDD62D65GmPP+NwI+HG9Zc8LUzQ0vg==
X-Received: by 2002:a17:907:7fa8:b0:b73:572d:3b07 with SMTP id a640c23a62f3a-b8036fac50amr5432246466b.28.1767610012006;
        Mon, 05 Jan 2026 02:46:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037f0b12dsm5538526566b.48.2026.01.05.02.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 02:46:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 56B2D407E63; Mon, 05 Jan 2026 11:46:50 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: KaFai Wan <kafai.wan@linux.dev>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org, shuah@kernel.org,
 aleksander.lobakin@intel.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>, Yinhao Hu <dddddd@hust.edu.cn>, Kaiyan
 Mei <M202472210@hust.edu.cn>, Dongliang Mu <dzm91@hust.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf, test_run: Fix user-memory-access
 vulnerability for LIVE_FRAMES
In-Reply-To: <20260104162350.347403-2-kafai.wan@linux.dev>
References: <fa2be179-bad7-4ee3-8668-4903d1853461@hust.edu.cn>
 <20260104162350.347403-1-kafai.wan@linux.dev>
 <20260104162350.347403-2-kafai.wan@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Mon, 05 Jan 2026 11:46:50 +0100
Message-ID: <87y0mc5obp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

KaFai Wan <kafai.wan@linux.dev> writes:

> This fix reverts to the original version and ensures data_hard_start
> correctly points to the xdp_frame structure, eliminating the security
> risk.

This is wrong. We should just be checking the meta_len on input to
account for the size of xdp_frame. I'll send a patch.

-Toke


