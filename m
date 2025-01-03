Return-Path: <bpf+bounces-47848-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119CCA00AB6
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 15:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 332C97A236C
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E31FA8E3;
	Fri,  3 Jan 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwbIovr4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270901FA8E4
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735915179; cv=none; b=YmRObVJ8t8Yx1/8WpS374vGihfGpgdSQwbIokbJKmdm2XcXQFJXVX2YgI3SeknHOBJBaAg1kAo9cyH3AmKiey711Mvu+jSBEK2mejoBXIlYK6LpB3wDyqUYwHAt/sSOZf3TVQYq8KaVEmlycdXxEl9NasdpHIrgxVneRr58lgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735915179; c=relaxed/simple;
	bh=yJXFXXRKSA0NqHzuV6j+IkygOpCkviArad2f9/NfyBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PMs53b64dFZ8NAZGpBxOks6xI8mRU2s8JxykCe7SaJlo/EfCycBcWiuP56HduPDdMk96Y7AKf1yIiWgDggFeqNbzP0u5URsMiHF7Bani8y6GzCzDPCiytxthncb33CU28PwLci3ES+k/pNbtpcqOSjv3z26KNHF5XYqMluC9Tns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OwbIovr4; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d3cfdc7e4fso8287a12.0
        for <bpf@vger.kernel.org>; Fri, 03 Jan 2025 06:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735915175; x=1736519975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yJXFXXRKSA0NqHzuV6j+IkygOpCkviArad2f9/NfyBU=;
        b=OwbIovr4W5OWUQitUQ0ecZ0sWfmjnf8D9RZWol6VxvTNcLQxigmE85cebr69e6WFK2
         jxXbYDIVtfxQmW9Q5+xXmgbNOJCGftC35twuoaoCai3dV7xLMYG/PlpzTftff68EX+VF
         /k/pt0cnHkwbdquyHUoyy6sLJ70Q2tLaANMv6rvrGS6MraCfOjpdKkaarhto8nEKtGWE
         TqsDlIxuVjbJEm/qbCaT/UENOt3VlGUHBQZRCXT8SQQKrViduK6VfNNedJ7LkQOmOKpz
         nvFhl4KRuLVJUNFiqWjgDB1KVRKwP2+2GrAIGeVIrK8X81c59oD6oahIkl5GaTnNFQaa
         CS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735915175; x=1736519975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJXFXXRKSA0NqHzuV6j+IkygOpCkviArad2f9/NfyBU=;
        b=tvnW92w1oAjJTFAoie4J+zlQCBEIJo6hfckakgY+A3uK76hd4viUysQeaelZcSsV9C
         9dmImJMfCrBFyCWr1JoX8sQ5k58hxYupx16jCxOJ3WfBHPyUoAb9mh2AbuMa8sOg3ft3
         wb8GjDD/fg729F3h/8ONg1qlQYXHDVJwZVNl5zBYXZuFxdKsjL6cOnVYBBJ20zS6YtBB
         bprOaXvTwONgwKJSfFD112e6Ga1XnouFk9LLa2Ex4+ejBJKAtLiF2/r/SUXZYCsF98Ur
         +ICH8D8W0cyVTELTLTd7bd08Ok3dBQYjuZ4OqUOLDpn1TD1X0drT7/WldYrx1bv/edg5
         KSJA==
X-Gm-Message-State: AOJu0YxDm2OIxuaJLSz82YxJhBaRmxbv5vFAXfOWwXyFnaQWG4x0/oWm
	Jmt83HmVsIj5ZoXq9BLTFH7wu9SR1FihlgCTZf1PTlnzgWZlzyxmMhfVdu0HJkzzuTTsLeNE3C/
	4g40Tyqx3ZIBYAQOkSwFoye3gzdrC0+pNy1NzzlgArT7C3yt7S67p
X-Gm-Gg: ASbGncukzfB2ZIw5G4FBKdWTjbFsXUUeVoVGWwM5eCs16ZTouHFMHN/sXlw7yBtUyuG
	HqKBVvrEFOA+Xy9LGgYjoxZAFyvrg1ehj99BePCcF8dimGXNW/l6IPWF58eyQk/ZTxQ==
X-Google-Smtp-Source: AGHT+IFnNs0CQ7ACj2YDTUdl8Ky4km9WON1U9kYx4TvRCFt2Fp5QN3i3rsM7PmmF20q4AXpV/3Msju8Oyt4tPznrIP8=
X-Received: by 2002:aa7:dcd9:0:b0:5d0:eb21:264d with SMTP id
 4fb4d7f45d1cf-5d9178759cdmr35113a12.1.1735915174792; Fri, 03 Jan 2025
 06:39:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241231033509.349277-1-pulehui@huaweicloud.com>
In-Reply-To: <20241231033509.349277-1-pulehui@huaweicloud.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 3 Jan 2025 15:38:58 +0100
X-Gm-Features: AbW1kvaVcfHnqyJAfCYjuCoU4OnUnEIDgqjjOvKECyoeYcauZ4IzUFPsh3TocJU
Message-ID: <CAG48ez1Wjorxwk98wQFjyCVOt6D72816DZzetbzzhVi6idCiNw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: Move out synchronize_rcu_tasks_trace from
 mutex CS
To: Pu Lehui <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Pu Lehui <pulehui@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2024 at 4:32=E2=80=AFAM Pu Lehui <pulehui@huaweicloud.com> =
wrote:
> Commit ef1b808e3b7c ("bpf: Fix UAF via mismatching bpf_prog/attachment
> RCU flavors") resolved a possible UAF issue in uprobes that attach
> non-sleepable bpf prog by explicitly waiting for a tasks-trace-RCU grace
> period. But, in the current implementation, synchronize_rcu_tasks_trace
> is included within the mutex critical section, which increases the
> length of the critical section and may affect performance. So let's move
> out synchronize_rcu_tasks_trace from mutex CS.
>
> Signed-off-by: Pu Lehui <pulehui@huawei.com>

This change looks good to me (though I don't know this area particularly we=
ll).

