Return-Path: <bpf+bounces-39054-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7281A96E2BF
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 21:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C5381F21622
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 19:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B03018CBF6;
	Thu,  5 Sep 2024 19:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BNgLQUUg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE37D188017;
	Thu,  5 Sep 2024 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563337; cv=none; b=RKM3AB4sfDjfvY8vB0f+nJPQJMpkFGFR6iIhTeqTV5+xaY0xSk+HVp+ywJhThWb268O/zel5+PH+bHdq1Es6lQjXWdGoGKZAIn8cKWILe1UC0PVngpHW5tZDfY9fFfNsegGFJZ8R9ClGTaoWAiWpCWef5JebhQpXO03UdocpERA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563337; c=relaxed/simple;
	bh=q1Fy017CFb6Bbpx7ghXm1lRoJCLBeFToPzSL430Hgh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EmHUEV2c6IkMQB+ks3lkbC/GAntVcd0L95N6LbbDgj+8GpmtS02QV5Qks0FzUVGnfl8MrfPjQH6iDpL5LDD046ggmPxcQ5XReXF1nIi85B2V1RXxclxCcUhC9Rkd43/Q6vKcSGu1Df7p08e2A1nU/VrrZ5aOq2v7V+3M0w0goDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BNgLQUUg; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71798a15ce5so433411b3a.0;
        Thu, 05 Sep 2024 12:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725563335; x=1726168135; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ktRJzR4qJmV7Uc7ETcluo4W/n/wNjkmgtnZv3eXOJQY=;
        b=BNgLQUUgMykdAH+yHdY22gyRgVRhpHvZzsCpd33J3ktZGne5H+tqkN1wlCBfCzlyyj
         +BGzx2Ed6waxNLa+wYAUiqlElX8pc48V6c7xsjbdVe/C6KHhQY3jQDGcy3vrZUq63bEq
         MfIwnSMDwejeGHXS/rqMqo97R2ldAlBpBsaBDeXG+UaoVpP/ISu0F5qGNJiwBw3jS2gO
         nOatRncG96Kkt8iB93JsMMqWHpAfZ2a+w0RDD96uYUgJslPE6Q+b1fJCaxZ+BGT5BzGv
         bYwSRDFG6VxLbz5e8YFbXKuG9vyTtP161NaFQrQrMuOL52c5v6ISefSz37kpK/7bts6F
         wcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725563335; x=1726168135;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ktRJzR4qJmV7Uc7ETcluo4W/n/wNjkmgtnZv3eXOJQY=;
        b=oua8XunWQlN1FOgvtdcvUjuSEDmctK1WgyU7hrDftD6U7eP86AjEVdZOEknims1YhJ
         vdWcSTD+IwMvdTT/JG5x98qxS1mlDG8nTBE8Q3NEwLnM3hsjeZrBflk/PMgz6QTyoVzy
         R3wL7lBrN+mSu7MD6F/4Ac/bT5L7iIs3oThIMgJ6c3Dv0babFSEYekvzJvDMMbERMHxq
         CtSrebc2Cb1Zoop2ANTQQ7gsrHALaF5lIfmm8kENXfEu6t9nXbdKUeACFE51L/HQahgR
         yMKDhoMI6pxMDMBHqCLcJkGu0gAqmp0qKhV/EB+1lYGTUmssmfozS40PYhQ8YAq3UeLe
         P8KA==
X-Forwarded-Encrypted: i=1; AJvYcCUiw7vM/Lh5XZ84/BONuQmrybM1UO5eml6r9EyCrE+IM9D9K1lPegEv8jZpXqE/c3G+0Q4ShIYL+ZNGfDDf@vger.kernel.org, AJvYcCUpvil8UdS1IWJXvNUCt3cSc6OlkRbt2gUlBNB1gtIc2KqSXEERLnr/mIAAqu7cfBa3HQM=@vger.kernel.org, AJvYcCVjNARCdcNAQCojYYsSwqbuqy28d0U8B12vXQ2TlSnoH8Ys8R7wJesc3ep9V7mHBr+7xpHUETJN@vger.kernel.org
X-Gm-Message-State: AOJu0YzVt7HS0NAbMoUXbPEjZjkOUqpIyDBIYcEt4eLxjVXwHwEE+5Mm
	+y19ls+nYkL2ohEg4cEFZ/297G/n0b9rc4734exyTgWbveAqGw+5
X-Google-Smtp-Source: AGHT+IEK2QM0fU2Xp+jErQWrjhElHAJPMpe2WJ+fM2XLXEzFeC3RWFMokRzrCOQpIrJAmH10hvhRcQ==
X-Received: by 2002:a05:6a20:b096:b0:1c0:f114:100c with SMTP id adf61e73a8af0-1cf1c1090d2mr404005637.17.1725563334805;
        Thu, 05 Sep 2024 12:08:54 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71797f6f668sm584658b3a.47.2024.09.05.12.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 12:08:54 -0700 (PDT)
Message-ID: <2911a33d8c9f408cc8d5863c54ea0ad1eba5de38.camel@gmail.com>
Subject: Re: [PATCH bpf-next] bpf: use type_may_be_null() helper for
 nullable-param check
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Vernet
 <void@manifault.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
  kernel test robot <lkp@intel.com>
Date: Thu, 05 Sep 2024 12:08:49 -0700
In-Reply-To: <20240905055233.70203-1-shung-hsi.yu@suse.com>
References: <20240905055233.70203-1-shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 13:52 +0800, Shung-Hsi Yu wrote:
> Commit 980ca8ceeae6 ("bpf: check bpf_dummy_struct_ops program params for
> test runs") does bitwise AND between reg_type and PTR_MAYBE_NULL, which
> is correct, but due to type difference the compiler complains:
>=20
>   net/bpf/bpf_dummy_struct_ops.c:118:31: warning: bitwise operation betwe=
en different enumeration types ('const enum bpf_reg_type' and 'enum bpf_typ=
e_flag') [-Wenum-enum-conversion]
>     118 |                 if (info && (info->reg_type & PTR_MAYBE_NULL))
>         |                              ~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~~
>=20
> Workaround the warning by moving the type_may_be_null() helper from
> verifier.c into bpf_verifier.h, and reuse it here to check whether param
> is nullable.
>=20
> Fixes: 980ca8ceeae6 ("bpf: check bpf_dummy_struct_ops program params for =
test runs")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202404241956.HEiRYwWq-lkp@i=
ntel.com/
> Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> ---

Thank you for this fix.
Replacing other uses of PTR_MAYBE_NULL suggested by Matt seems like a
good idea, but it does not preclude merge for this patch.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


