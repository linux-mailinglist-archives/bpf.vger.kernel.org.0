Return-Path: <bpf+bounces-28190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EC08B64E0
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:47:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 289D8B20E2A
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C133184120;
	Mon, 29 Apr 2024 21:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CiLuNX/a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3761836F9
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714427248; cv=none; b=qx6q5LabxSXnDOPnm7JRix6m1+omNJqJLVR4ud2iYw9mc6KQVQ6hWQpxQs4PtWy1tJIPSX8cr/V1JZnMvJtuke3VGWKGq8aoZqdrJ8JEZCErcpBW74Jwrmb/yCkp+RZn6S8sQnJpSPF/O43CapUJFRYbHRrfAFBcjgTvBhNs0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714427248; c=relaxed/simple;
	bh=nvWVsA4kqf93VlOY0JVMXTkhKyr9KHpD3f+UpJXTh00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QOqvo/wdnTSSUgKf42sryfzUPegLKft9aoQM0dM7w1xtBgx+Z+ZuU4vxZL/Badj+PU1I4zEtbA+T1NBp3ivAp1YmgC6I98w8d27dEy4pxsYAQtjo51kAGJkdHureDPTLM1//sCFv9Zc2BI8YVrS/DCcTHBvweIvZ5O53PUqmXsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CiLuNX/a; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b782405d5so39471125e9.2
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714427245; x=1715032045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nvWVsA4kqf93VlOY0JVMXTkhKyr9KHpD3f+UpJXTh00=;
        b=CiLuNX/a1iYPvpX+ygaurrfVB3kd4seuP3g/bJoHzcBkTQIZNDcJDshUqXq0UYN/dU
         E5yBwuwfTJz5P0BZwGlAhDiHFjC3f+IiQWRWQdpPJsmjXIU9Hocen5IyE11lc8/89roe
         TX8sUk0HTqfyqw6N7V10oOj/0Ulr/RoGWRKlTEeAJ5qhnWZdnRX2vgAnt94dOSik+9DV
         UyxK+nnpQs636eClEefJcnV4pd8kaXWUy8JzlEVCsBKep1hynkteSNE8T+skx4S4IP3n
         sPdc+9bhZww6YBZH9lRvuNyxuc4j2JFRAd2IS51zUcfzzfEgNZYwtDSyXLpcfNEmxrGp
         GX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714427245; x=1715032045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nvWVsA4kqf93VlOY0JVMXTkhKyr9KHpD3f+UpJXTh00=;
        b=D+jWkPXQ1xBg6/BsPZNCC+bYelVR5AbYL/DkeDa74NK6L28rR8yItoMrBHQyeYj8i3
         VzkvWrf8Sh9/Ugi/v/hFYy2u+XUvo++FWtzlk4UVs9IQqrOaO63cvgvapVOlmxYWGdLq
         rXwgRbZEUx1sffDNmqq5iDufD4kEJ8Rj5miNpuucgjQqRr7k9WMqFnAzo8x9K8Jc5IXV
         SeskSiv2B2HK1OP92usjsDVoyrmPoWOBlGop5ao56CUU0TnON/zTmP0QHkTwhXnL0ATu
         h5/nj4p9BDMV2bQnA/jrkmTQuDij/QKeMwMXWUmdPR+MVB6iOo8OI+usBLOqCzPhgYE/
         BbVA==
X-Gm-Message-State: AOJu0YyokTP9Dm+VB8KZNJyBDQBqo2+MB2VCiKyRJIjrRz3vkgTHl+Y/
	IrELftmLQrdDArW6f26CbIFbNNicmsXQ0cmz6FRZyNTs1hw0nSfABIt4ISPofh+9aLRRoxql+la
	dLFrlO3c/+1FbN7do1hgOsf4pT9wNOIB6IPKG
X-Google-Smtp-Source: AGHT+IEpwUtgMberJuMKdrPb2la4z0f44OcmC72rw61Te/hHaAbvg7MQQHuTdZEenF5qteBTKS7bdCPpgHfbBd/eZO8=
X-Received: by 2002:a5d:49c4:0:b0:34a:6eb5:c36 with SMTP id
 t4-20020a5d49c4000000b0034a6eb50c36mr9128004wrs.22.1714427244799; Mon, 29 Apr
 2024 14:47:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com> <20240412165230.2009746-5-jrife@google.com>
 <3df13496-a644-4a3a-9f9b-96ccc070f2a3@linux.dev> <CADKFtnQDJbSFRS4oyEsn3ZBDAN7T6EvxXUNdrz1kU3Bnhzfgug@mail.gmail.com>
 <f164369a-2b6b-45e0-8e3e-aa0035038cb6@linux.dev> <CADKFtnQHy0MFeDNg6x2gzUJpuyaF6ELLyMg3tTxze3XV28qo7w@mail.gmail.com>
 <8c9e51b2-5401-4d58-a319-ed620fadcc63@linux.dev> <CADKFtnQ7L_CSq+CzAOt3PM_Jz2mboGe+Si2TPByt=DuL5Nu=1g@mail.gmail.com>
 <62e430de-46ff-4eac-b8ba-408cb8eefac7@linux.dev>
In-Reply-To: <62e430de-46ff-4eac-b8ba-408cb8eefac7@linux.dev>
From: Jordan Rife <jrife@google.com>
Date: Mon, 29 Apr 2024 14:47:11 -0700
Message-ID: <CADKFtnRiO4VkB7zP3ZdwAgtxOxeQD5eYGM4LF15WsA6hRC1cdg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] selftests/bpf: Add IPv4 and IPv6 sockaddr
 test cases
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> For the tests that moved to sock_addr.c, please also remove them from
> test_sock_addr.c.

Done in v3 (https://lore.kernel.org/bpf/20240429214529.2644801-1-jrife@google.com/T/#m560606260cda41652a7f305a0acff7fc8975d10a).

-Jordan

