Return-Path: <bpf+bounces-17758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F58E81244A
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 02:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 220B91F21913
	for <lists+bpf@lfdr.de>; Thu, 14 Dec 2023 01:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94F4644;
	Thu, 14 Dec 2023 01:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KurGwGmc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EDFD0
	for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 17:06:17 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6ce6d926f76so87617b3a.1
        for <bpf@vger.kernel.org>; Wed, 13 Dec 2023 17:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702515977; x=1703120777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6eSwhwRS90Ow0w7Gr7uYtwE8Rb7u7aAHKQrb7CCJQ8=;
        b=KurGwGmcJgRL1+mBQfxIPHrMfBu34mjtZJT0nxn3ojyAwDAAa8nYv6GcSB0poXvVXC
         +eHep4e7Zi3uXla84OtDnFKTqKaI8oyeZopq2fQ6plFRNoyrmg3Sv0AGjQUN0dC0eMoR
         ZWbiL6E0mbIq3ag3DjDjAPqnwBWlBaHIzicVg0FUYMJYzl1F2OMuCOIoF5knKQ0srpgW
         NdIIqMDyVOmKhWPDtwdXrQoyz+R81KQn1d1GhPKLAMebqVy9hs4vHauQYROKQ5PaiHgT
         v2+9JX1cn3vT7xpmsrmKRsTASdPyg153KbEmK4IOg6JdaqEFOCKfSw0+b+SvAyNUXotM
         pLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702515977; x=1703120777;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X6eSwhwRS90Ow0w7Gr7uYtwE8Rb7u7aAHKQrb7CCJQ8=;
        b=KBC8GmLYn2FIKzHVC31tt++JHP1mmLpy4jqyFH8+SwMLYecWitrv/ksOfg1c4uhrGZ
         y02DSI4oajyOcc8x8Gip/WoBdqObpVTkQ2oYNQDGRy4pU+LGW849Qka3sOfVswHl6mwR
         hiYXgxUcpuEFQJ2He1g2h+hc0WA6agL8psqPXUdEdXUPu5Nf1NiCZdCZX4IdTUZQeW5G
         MVlOPV0+Vg4Wl8U3TmS86k9WrbEK4t4v2lqnJ5Yz2NOgfyO+uF9TeGDl+Adxzf6gAYAC
         JgNjBiGTQqjhQ5+WNM8cxjqZ7eQkF8Ukmb4U1tnSGv0uWiSiuwNN1qRBUphpsxHPJldW
         pYuQ==
X-Gm-Message-State: AOJu0Yxeo030b6P7jUGXHoWNG+YopSyyx4qZZetw+HGtXV5c/dobwP5D
	zAVCvFM5VTDWOPfTh1MFHgM=
X-Google-Smtp-Source: AGHT+IHZIkJP6dzDsQy9mW2jnqaMDyuAisb+xNNXSNoazTT3wVK+H8zfNORjXLDCPjIA9zJL0XVrjg==
X-Received: by 2002:a05:6a21:9810:b0:18f:ef9d:d41 with SMTP id ue16-20020a056a21981000b0018fef9d0d41mr8213012pzb.45.1702515977036;
        Wed, 13 Dec 2023 17:06:17 -0800 (PST)
Received: from localhost ([98.97.32.4])
        by smtp.gmail.com with ESMTPSA id fm21-20020a056a002f9500b006cea0fd9afdsm10873104pfb.92.2023.12.13.17.06.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 17:06:16 -0800 (PST)
Date: Wed, 13 Dec 2023 17:06:15 -0800
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <657a55074a3a5_4415620849@john.notmuch>
In-Reply-To: <20231213222327.934981-3-andrii@kernel.org>
References: <20231213222327.934981-1-andrii@kernel.org>
 <20231213222327.934981-3-andrii@kernel.org>
Subject: RE: [PATCH bpf-next 2/2] selftests/bpf: utilize string values for
 delegate_xxx mount options
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Andrii Nakryiko wrote:
> Use both hex-based and string-based way to specify delegate mount
> options for BPF FS.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>

