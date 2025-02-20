Return-Path: <bpf+bounces-52086-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C281A3DED5
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 16:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF607A6E2A
	for <lists+bpf@lfdr.de>; Thu, 20 Feb 2025 15:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B558D1DE891;
	Thu, 20 Feb 2025 15:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfrK9M8p"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006B1D5AA0;
	Thu, 20 Feb 2025 15:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065552; cv=none; b=IBWTvhhU+a13hHbsmuIgWmlFsu7A716w4Sf2wBBZYmt02YluBpHPjNv6GbWeUnsjCaofZ6XSXtGoRmEDuu8ZKg0BzxB6VRqODmR/OP1ELQBN03EdyUaiWKNUTa1HIrY12bR1I1Fb7MfJXgysh73eafRIGT/X36bBufHuSW3Q9Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065552; c=relaxed/simple;
	bh=LxQbT2IcW8wsEUc/h6Y0YBKTOXVVPnIGZdV2ZvTjlWk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fBhdpb4B0vpxrhACN8qP+VuNHt4zAkARwEI+RJQzkx66pXPusTD4+/AzQdOcxIZnhPxAEICLQpCwEE+Lz4W44dIO2hsp0rVk1vpd+pC3Usm8R6MqH7ohf/JA3T14i/AJ5sMWdcF1EeFm8iiWyh51aDR+p1N9ZJCDocBVbSjnpV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfrK9M8p; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4721aede532so6488281cf.2;
        Thu, 20 Feb 2025 07:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740065550; x=1740670350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZ9Qni1DgNO9I9LlVWUyoOW+78luBCpmnW322IlPwuU=;
        b=hfrK9M8p8bjXoZSb72gvOxL5qxDvbnE1LEoX9xfHGJVRNLOgMwVwJyFlOYG0OckAjs
         bEnVh6IeScmx5olO1vljYj1KZWC/WjGlldJH6hyFig7NqG4Kcpf+UFr1ARUN82HgUEcR
         m/7MgJj1B6o4CuPPIkBcJ/fTWfWzrHefT/5KWATVaBnZ3QVfpVEEmHBLoac9JuPtSFVm
         YCCEzkS3A9at0FZH/t7Yv1b0zZVVAUeOBHftbB6JCRC4Hbr+bnqT6tXRGJLuLUMY9Cpd
         aF7v5wX0PsU/SHvT48uFESju4X+D9T+yRPOKfDTKZAq0jjCmjpcm/sSsjIU7hSuEbWxK
         AH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740065550; x=1740670350;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rZ9Qni1DgNO9I9LlVWUyoOW+78luBCpmnW322IlPwuU=;
        b=OAE6eF63zUXYn94lalqabKThxcDJvoap66mkmcwD0x7XHKyMVelE8cdH0AFVHI1xcR
         sz15N1aIY7UJvg9kWOiqBqOLAWIAcdJpRlKbd/lmg1YZgGnn6KMVQHrRU/BX4tGmVKT4
         M2jD4vZTAfBWwVah9KSqSLyI3La0D071gFF8lD0sd1EnbPaNYd0roGp3jRx2QBSyB3op
         l03QerH065wn009zOyRh1GqKuN4SHeiv3vvr2ozFAHAxt+oYR8m1DJM6AaxraZpGGjWO
         WGGgGSZsQnY/e8Zrlo3pBljTChKf/u0DsIoMPxVxsDN0opfcJe22NJip16B4e+P8HW2X
         YJBA==
X-Forwarded-Encrypted: i=1; AJvYcCWy3mDvwE7OTOn6+GOl2VCAMhYxSZ3q4sHD+cVtxM17FokdpOSm+JbNngnIB8qzSzxr7XFE1iA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywecc+ZPTMxGyVNahzZar5cmGXmztcKiF2Mx4q3IfbhNt57GJky
	hxqbOiqDCR9pH39fj2tYfMqn6oyQExziXXQ4oB1Y6OcU+pfq0iLn
X-Gm-Gg: ASbGnctcBqDfOl/KLr6TkGvFP+9KLL5lCt6dZ6Nfc2nlXZ4o/oTKAjEM3GxbNwuTbeT
	ScWHmobIFSuKanhkUfJVtU0eizwkLv1Fuq7rTPcZXUM3NJeqqQh38C+BRoSRuat1KG41G/j4TMH
	G08zF2mBqGTF1FesCGT1VlamBIX7TM9aciRk9+/JDVIKG+IcZ+Yt0fnHlbt8pV8o1cCLPsJ7ODa
	rFjSqSwWdcghFXme8eRG0vpENt9+ykJ7OcnPemSqiZzGhJzdVZAkj0DFEzy5tl61hGky0KRLFR8
	zli09G/wQetJooDlYzU/0NxkVUsvF+JVfRtGSNvzOGnzXBcX2j+2E0sQyTZmH+I=
X-Google-Smtp-Source: AGHT+IFm7OjWeQ+FKEd+LS+AnmOLOP5QysFrqZsTlCQ9OpzWqiDse2HwCuRtvtJC5vJpsPGFaMMxcQ==
X-Received: by 2002:a05:6214:19e1:b0:6d9:3016:d0e7 with SMTP id 6a1803df08f44-6e66ccf058cmr304702346d6.29.1740065549609;
        Thu, 20 Feb 2025 07:32:29 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65d9f31c1sm86485876d6.72.2025.02.20.07.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 07:32:29 -0800 (PST)
Date: Thu, 20 Feb 2025 10:32:28 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 dsahern@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 willemb@google.com, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 andrii@kernel.org, 
 martin.lau@linux.dev, 
 eddyz87@gmail.com, 
 song@kernel.org, 
 yonghong.song@linux.dev, 
 john.fastabend@gmail.com, 
 kpsingh@kernel.org, 
 sdf@fomichev.me, 
 haoluo@google.com, 
 jolsa@kernel.org, 
 shuah@kernel.org, 
 ykolal@fb.com
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kerneljasonxing@gmail.com>
Message-ID: <67b74b0ca099e_261ab62945f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250220072940.99994-1-kerneljasonxing@gmail.com>
References: <20250220072940.99994-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH bpf-next v13 00/12] net-timestamp: bpf extension to equip
 applications transparently
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jason Xing wrote:
> "Timestamping is key to debugging network stack latency. With
> SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> network issues can be attributed to the kernel." This is extracted
> from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> addressed by Willem de Bruijn at netdevconf 0x17).
> 
> There are a few areas that need optimization with the consideration of
> easier use and less performance impact, which I highlighted and mainly
> discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
> uAPI compatibility, extra system call overhead, and the need for
> application modification. I initially managed to solve these issues
> by writing a kernel module that hooks various key functions. However,
> this approach is not suitable for the next kernel release. Therefore,
> a BPF extension was proposed. During recent period, Martin KaFai Lau
> provides invaluable suggestions about BPF along the way. Many thanks
> here!
> 
> This series adds the BPF networking timestamping infrastructure through
> reusing most of the tx timestamping callback that is currently enabled
> by the SO_TIMESTAMPING.. This series also adds TX timestamping support
> for TCP. The RX timestamping and UDP support will be added in the future.

This series addresses all my feedback.

The timestamping patches all have my Reviewed-by.

The BPF parts I am less qualified to review. They LGTM, but I defer
to Martin as the expert reviewer.

