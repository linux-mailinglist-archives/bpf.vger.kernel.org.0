Return-Path: <bpf+bounces-75886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DD9C9BD52
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 15:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8B2033479A5
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 14:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D27D23D7DC;
	Tue,  2 Dec 2025 14:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NfH7SuVM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LYDfZlca"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27566221F1F
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764686654; cv=none; b=dg2bzaFpg40GraxlLxfkr/PI2yWCog3U5anQmmza3kfWDiS6AI2WUfuk3Gg0ZbXCSqcivXx/NMtst6bfqQMTOjFdmM1u6R2pFRtbANYCfFG8oG1PmeY6Th5/3iikcddpNMnlRmvXSbXsx3N9HRGNRLzdc+QvV0gS9gXi2PDkdOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764686654; c=relaxed/simple;
	bh=NZj4/NW55RYoRrLPZhkJUjtKoD9IgR8bd7QKEau5f4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bAoUmYD6+NOCEeZmG/RePTTAIGrQflRXcFChCV3acE0oil7mWj8R7FKvzlfqkQq9b9D2lyDmnBHQYCLgm/nEnlFRna5phqO6GsiYEX56Cb538m4Fj3ZKSkG9FLRqiLO8F1i1V6u+oqSs+fzEBBHB2Q5O36ao4IWfqTUxFK537Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NfH7SuVM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LYDfZlca; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764686652;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjNiAor2TkYqFzHs2B3P/P9B9Xp/a4exT6Ioq6XTaKs=;
	b=NfH7SuVMUGEWIYxv7XNfD63uKm3yKh1QHj+Y1Z2HgobeY2/IPkvAme2uYn2MjsaEpv2RwB
	sR/KC3F63df/wgGK+so7yj1qAIKCEpunp7RF38X9N0y+8VWxCQTeEULDs4o4ajKwziyv0+
	n7bRmhxSu6v/5flmzfNeqtHhQtS7aA0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-slyYn4KbP_-AKcC5wcefRg-1; Tue, 02 Dec 2025 09:44:10 -0500
X-MC-Unique: slyYn4KbP_-AKcC5wcefRg-1
X-Mimecast-MFC-AGG-ID: slyYn4KbP_-AKcC5wcefRg_1764686649
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b352355a1so3328967f8f.1
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 06:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764686649; x=1765291449; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mjNiAor2TkYqFzHs2B3P/P9B9Xp/a4exT6Ioq6XTaKs=;
        b=LYDfZlca5UbF4aaOnf0jOqD4gg9ZQkqctRFArK/5FouFONoeAo94rbHM1t/OU2KwY+
         hycZiTPSTurfPFte4blWcmr/f+kZy1z3SKrxrO17YnGeCJebx+Vem03AA+Vh5RlNoJze
         WU1sqqQUX4lH4Ohexgr2nYhWCEznqHj21dk+RrNUhGy/ou5Y1zXJVOvw9XRwdminCHfn
         CoeFHkSpVpahVaFfyR0g//mTg4ztJ39XLUVP9Pvv4d4OBKQm35kQgkHHlwFzowdRE2TU
         xwIguekhSVyyqLtJic+Sp5CI631PEDcIFsdO9tzkTpQHohXMkUgc3zD1rGhK2H3Lmofe
         U4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764686649; x=1765291449;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mjNiAor2TkYqFzHs2B3P/P9B9Xp/a4exT6Ioq6XTaKs=;
        b=rx34IZSkfrX/r5IGR3XdOd6bPVMbU1fhdVlQXzSCASOgHQbX7CkYhJys/Y+iffaoe2
         pW6G+hNuINfGr9qZXQ8Dvh/QuqB1HDg47MPmCOwwycVFooiw/X1U3SdoxunbCs5ArPew
         W6kxqb1Y5RaLn7DE/lhIzd12basDVsHgEOmurW1aQpaFrI+2gQ95nuUtMjCi64oAboGi
         yHxTYjVr048aVJBy8wt/fTFmRUaHFVmFI1VUD6rrweWzxevB1GHzs6tDypzgghr4/Q7/
         anARrjFWEvcmlvVMu9XY0EcJFxOSoaX972vNDswfceLmp5eZf0zTY0z9dYWXFie2E9nV
         Xi/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIWMzOdIELsULNN8cETtEhNlOx7RfvVh41u3E0/s6t8fyMWMyrSvralKKqJqDc+7eS+vE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoMbqCo2O5yiDc1Ty3RXbbT0e1Fy9fWRb6s/FPRuPRSi+jw3/9
	I2Cq4Jh5C1suChjKDGh630fulQaogOf4t66kdZlJso6XqaZEYHdVAM9h/okx+soR9+Vp0QngGO/
	8tpRb5sururYtR6O3WBDdxmkzPG3OB+pBAtAOzNrjgguG7bb+F7sHLQ==
X-Gm-Gg: ASbGncvYicy3NZc/BJ/YoXXIn0yC6BaR8pWt4jH1mXkKkdbX1TlUbfhw6M7e9PFs6Ya
	19ASgO+7l+J9FR5pnZ10jDNT6xFpOEybldL8UDKZdYqDI3ARibgTDDN5+25rbhSNo0i7zQNc3Qg
	T9x7zIkJ+mV6Wk7QJKs7MTaLhSVSiQ8dwLaNgRX83IDHtWK5StpXEElQIw5CAQcneOi20VV0NNl
	tW4uMxyArbXicY3Dz7tTDlKunCLG85yEfvDXomy6ks1NkEdZ9Gvo6NLTAWZukaFaz/xePYUakKF
	knXgChZU2tfzLuMocIUjno5SBJa8XjTuxHSBLUuRrlvwxMgbQEIIFvyMSp/yimShsI1i7JxLQOc
	TWMPQCIqdiwmf8A==
X-Received: by 2002:a05:600c:190b:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47926f99134mr29819915e9.10.1764686649241;
        Tue, 02 Dec 2025 06:44:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1rSpvcyj7MIWwm/bcqJ3Gqt/h4Kwl1pmES70ih45QAJCy1rFgmux40sFPF3KzuExq8RZOQg==
X-Received: by 2002:a05:600c:190b:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-47926f99134mr29819585e9.10.1764686648788;
        Tue, 02 Dec 2025 06:44:08 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790b0c3a1dsm380823035e9.10.2025.12.02.06.44.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Dec 2025 06:44:08 -0800 (PST)
Message-ID: <743e8c49-8683-46b7-8a8f-38b5ec36906a@redhat.com>
Date: Tue, 2 Dec 2025 15:44:06 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 0/9] Add support for providers with large rx
 buffer
To: Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Shuah Khan
 <shuah@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Yue Haibing <yuehaibing@huawei.com>,
 David Wei <dw@davidwei.uk>, Haiyue Wang <haiyuewa@163.com>,
 Jens Axboe <axboe@kernel.dk>, Joe Damato <jdamato@fastly.com>,
 Simon Horman <horms@kernel.org>, Vishwanath Seshagiri <vishs@fb.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 io-uring@vger.kernel.org, dtatulea@nvidia.com
References: <cover.1764542851.git.asml.silence@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <cover.1764542851.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/1/25 12:35 AM, Pavel Begunkov wrote:
> Note: it's net/ only bits and doesn't include changes, which shoulf be
> merged separately and are posted separately. The full branch for
> convenience is at [1], and the patch is here:
> 
> https://lore.kernel.org/io-uring/7486ab32e99be1f614b3ef8d0e9bc77015b173f7.1764265323.git.asml.silence@gmail.com
> 
> Many modern NICs support configurable receive buffer lengths, and zcrx and
> memory providers can use buffers larger than 4K/PAGE_SIZE on x86 to improve
> performance. When paired with hw-gro larger rx buffer sizes can drastically
> reduce the number of buffers traversing the stack and save a lot of processing
> time. It also allows to give to users larger contiguous chunks of data. The
> idea was first floated around by Saeed during netdev conf 2024 and was
> asked about by a few folks.
> 
> Single stream benchmarks showed up to ~30% CPU util improvement.
> E.g. comparison for 4K vs 32K buffers using a 200Gbit NIC:
> 
> packets=23987040 (MB=2745098), rps=199559 (MB/s=22837)
> CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
>   0    1.53    0.00   27.78    2.72    1.31   66.45    0.22
> packets=24078368 (MB=2755550), rps=200319 (MB/s=22924)
> CPU    %usr   %nice    %sys %iowait    %irq   %soft   %idle
>   0    0.69    0.00    8.26   31.65    1.83   57.00    0.57
> 
> This series adds net infrastructure for memory providers configuring
> the size and implements it for bnxt. It's an opt-in feature for drivers,
> they should advertise support for the parameter in the qops and must check
> if the hardware supports the given size. It's limited to memory providers
> as it drastically simplifies implementation. It doesn't affect the fast
> path zcrx uAPI, and the sizes is defined in zcrx terms, which allows it
> to be flexible and adjusted in the future, see Patch 8 for details.
> 
> A liburing example can be found at [2]
> 
> full branch:
> [1] https://github.com/isilence/linux.git zcrx/large-buffers-v7
> Liburing example:
> [2] https://github.com/isilence/liburing.git zcrx/rx-buf-len

Dump question, hoping someone could answer in a very short time...

Differently from previous revisions, this is not a PR, just a plain
patch series - that in turn may cause duplicate commits when applied on
different trees.

Is the above intentional? why?

Thanks,

Paolo


