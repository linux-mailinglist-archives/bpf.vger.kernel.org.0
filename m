Return-Path: <bpf+bounces-41815-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B41899B677
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 19:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22447B2222E
	for <lists+bpf@lfdr.de>; Sat, 12 Oct 2024 17:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA5683CD2;
	Sat, 12 Oct 2024 17:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlmSeiLk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DEE1B969;
	Sat, 12 Oct 2024 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728755325; cv=none; b=T5HlGwCh3N4e6M0X7+Ucr6JpXKRdqdqSHNxa6juTNu3S//aXjnPvAuFSLIW94nJLKyOlru8RS6CQR7P8gU9HhCplvQ3fcQmMpCmLhVIV0oR2hl2vPBhp0AYEHz0CObSjwybNWKDGT8xY+x9Jr9VPc/uBuq/9b13fej30ZttXL6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728755325; c=relaxed/simple;
	bh=VTfx7Uk9PaF7UtcttPlgvvk1DYt1FLeAGPgqQXgkIxI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ef92/GYszoywbP2zMdh3/Ym4508fFBhmLkXX68oEd3I/pQ/nZQmMr3hyyp5Ms06/wVA2cFfzs+ZTF3RfLKU2JaN6pHRcsdRSuIEHsVsxGyi80n/HUSQvqMPqHkCMRUHjiIDU+pIhFZLJn7SQzdMU7q8cONRNYB4xxkB1QeN31os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlmSeiLk; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6cbd00dd21cso19518286d6.3;
        Sat, 12 Oct 2024 10:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728755322; x=1729360122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lCemlVGHWxeIwUi+jORfMBc/BsMvf5hfU/geTs8i18c=;
        b=RlmSeiLkcAb7xsb+mJVJoviXsgRF4qBGaLBcRnwGEiYMPZ1WzFH/yoR10UGvzWCqVs
         9KJW/qlKuM1qVeuxD0EoUivC1NSBJGM77ueUV1Qk/GNi1TWM1taXmkbh3/26iKBgiHxT
         oK9jcHhJ6BA9dQ1rJSqhlCbyX6Sx+oCp5mhgOkcQkiElUmIQEGXmW/0yKlmY2OlDWxUb
         3dgJbUpjm+foHOTEZDL3Nc6nrhUC7avKwk+rjUcCRKPHOVR9DqX8/fl88NTkNWhfWK0V
         DNNXzzprDEFCq3tFGporQLmYU8E2rp+kJxQWFp7NdKms4vmF+yR540vvqDALHG9niWHB
         3Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728755322; x=1729360122;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lCemlVGHWxeIwUi+jORfMBc/BsMvf5hfU/geTs8i18c=;
        b=hqAruD+MevKWojHteSq8jvd5s7Ql/jZBZFjWMczB/imgPWTZG6fh+Yj4xxRXQlqKpi
         4Q5kRiJw/RifXtMRkHfDFUCjnyYaDAagx6ve1Nb3qUwT0kwPBrfxYXTPiKffnc7nYWiw
         f2Ygf5bCcQOBc/0kWY/dAlgkFx6qfGN4lkF/w7bvx0CO1vAnRN/lPCCa3vm+NItOYfS+
         NOE6lbjTXWzUwWMbTtM8m5pp410Xj3K4oa1kHrVKUeUi5+BfZtArBN/jQvXggS+pUAKE
         MmeHjTSUI4SpfB8qbeuNmZDENDxLG0fUnb/kgRQT/rSsmO5FUOdqYQ4Ds5MvGZUjz1cu
         pdew==
X-Forwarded-Encrypted: i=1; AJvYcCV3hmzN3p6T9m+BSMrXjfaK2vUVWNXzK+F1XuunWUj2M2rJNmeg44nPAZBjYT6Lkv+6mJy1EiY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyge8uemGfdp+cgb3TipQX3UcxnRZ02sj12cwVz03EftowUY3LI
	6gDtUtSgQE2JHjPN9b4pALOMnvS+elyh2OVfQO3BqyLqvF4v07LB
X-Google-Smtp-Source: AGHT+IGACFl+mZBgLlxYveWQnVc0uH8W6TyWf2/bRKnBU4yLLVRsn6mmCbTTyhEf4n7IqDNgZq5GoA==
X-Received: by 2002:a05:6214:3d8d:b0:6cb:f744:e3f1 with SMTP id 6a1803df08f44-6cbf744e729mr53158716d6.4.1728755322264;
        Sat, 12 Oct 2024 10:48:42 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6cbe8608d68sm27045746d6.94.2024.10.12.10.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 10:48:41 -0700 (PDT)
Date: Sat, 12 Oct 2024 13:48:41 -0400
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
 jolsa@kernel.org
Cc: bpf@vger.kernel.org, 
 netdev@vger.kernel.org, 
 Jason Xing <kernelxing@tencent.com>
Message-ID: <670ab67920184_2737bf29465@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241012040651.95616-1-kerneljasonxing@gmail.com>
References: <20241012040651.95616-1-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net-next v2 00/12] net-timestamp: bpf extension to equip
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
> From: Jason Xing <kernelxing@tencent.com>
> 
> A few weeks ago, I planned to extend SO_TIMESTMAMPING feature by using
> tracepoint to print information (say, tstamp) so that we can
> transparently equip applications with this feature and require no
> modification in user side.
> 
> Later, we discussed at netconf and agreed that we can use bpf for better
> extension, which is mainly suggested by John Fastabend and Willem de
> Bruijn. Many thanks here! So I post this series to see if we have a
> better solution to extend. My feeling is BPF is a good place to provide
> a way to add timestamping by administrators, without having to rebuild
> applications. 
> 
> This approach mostly relies on existing SO_TIMESTAMPING feature, users
> only needs to pass certain flags through bpf_setsocktop() to a separate
> tsflags. For TX timestamps, they will be printed during generation
> phase. For RX timestamps, we will wait for the moment when recvmsg() is
> called.
> 
> After this series, we could step by step implement more advanced
> functions/flags already in SO_TIMESTAMPING feature for bpf extension.
> 
> In this series, I only support TCP protocol which is widely used in
> SO_TIMESTAMPING feature.
> 
> ---
> V2
> Link: https://lore.kernel.org/all/20241008095109.99918-1-kerneljasonxing@gmail.com/
> 1. Introduce tsflag requestors so that we are able to extend more in the
> future. Besides, it enables TX flags for bpf extension feature separately
> without breaking users. It is suggested by Vadim Fedorenko.
> 2. introduce a static key to control the whole feature. (Willem)
> 3. Open the gate of bpf_setsockopt for the SO_TIMESTAMPING feature in
> some TX/RX cases, not all the cases.
> 
> Note:
> The main concern we've discussion in V1 thread is how to deal with the
> applications using SO_TIMESTAMPING feature? In this series, I allow both
> cases to happen at the same time, which indicates that even one
> applications setting SO_TIMESTAMPING can still be traced through BPF
> program. Please see patch [04/12].

This revision does not address the main concern.

An administrator installed BPF program can affect results of a process
using SO_TIMESTAMPING in ways that break it.

My halfway suggestion was to only enable this if the process has not
enabled timestamping on a socket, and to hard fail the application if
it does enable it while BPF timestamping is active. You pushed back,
entirely reasonably. But if anything we need a stronger method of
isolation, not just ignore the issue.

