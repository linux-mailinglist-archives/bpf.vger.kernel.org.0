Return-Path: <bpf+bounces-64909-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7B9B18568
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 18:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB81517F076
	for <lists+bpf@lfdr.de>; Fri,  1 Aug 2025 16:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0416128C5BE;
	Fri,  1 Aug 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSWeQlVi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FA426C39B;
	Fri,  1 Aug 2025 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064414; cv=none; b=DtX1fp0aW3Eg9VmmLCX/c2Hz63XR+F5XVuLqURjCLhtMMbU7aQdeZZFYmXNP0uwey19rtw6HHEbLp+YkKUV5n8QA9iWfxFeStNAWrBopFLcPY0NP8TeOMsMtppSUOAUYS/VG1gle/+DpsfEVsdjmOwg4OvOS26+9DkTct0Qxt1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064414; c=relaxed/simple;
	bh=BLBbGDOgRCwdneiecp/lgqL24quNqRqqK+Dryg8GYHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iyeKvzeQOReoMLwMr1UpPXOOiekMyVNsO4BoPflUp83RvKguRBB931ouQLm4i7a8ujGkWnWZnquHsj45P8l70pgySQGtZyguwL8gjCHEJaw8O7cYn4RpzQr79fTAj8tyE62EXrmGYXCUtYz/3L68eaLZJC3TucipUfIh+dTq/+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSWeQlVi; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-320dfa8cfa3so1646786a91.3;
        Fri, 01 Aug 2025 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754064412; x=1754669212; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BLBbGDOgRCwdneiecp/lgqL24quNqRqqK+Dryg8GYHQ=;
        b=YSWeQlViz1fZZPFSf5iT/BrLFgmxukSzEsJbS61cFL7YrpaJbD0A6sNm3zxlrI/9L5
         6Lp5riL0LdfVCRBO8WGe5NYI5uHCOnLYanDsPp0TkWa3CPQ8bt/I3cVlyicXdW/fA4bc
         AOj5RJhurZlOwHldmqBktX82irL3bOXk17NyhzcepsSX9nuNINSh57bpg27QuKgItD4+
         p4xP2xpKYyCbT9P+CXnn92xtqBvPADiEdTwFx1/CAOkIY9v5yjIC9jnpcGYY3FAmlQkx
         p0tFeKIU9xXGHETPys5kgsWils+zEVMD8VILzGWN8TLVmeTZOshz0Q/yJzpdTT0Tq6oP
         TUYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754064412; x=1754669212;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BLBbGDOgRCwdneiecp/lgqL24quNqRqqK+Dryg8GYHQ=;
        b=Ov0fWBMiZCvvRcFHNojhwCv4IIVU0+bA20ZCYOgcuasq71gn5xKViYu2+gb7DAFyGO
         Dr/HWs9Z3OEne8CcfXzKWk2IwG0F0pd3QtUr6SQzVytIkS3zL9bmhZgMYcUGA5+JuB85
         P8m9qzw+V3hqfSP3koVcoHhl30VqzolKmLY5TdEf+sbPOmAt3+qykIaa9axXQnDYxZbw
         LSFMibwQgi5u1vBXoI5B+CXqUI2AXHQGI70FLPvy4DZ8ur7VJ9cNZoYvWIvWlXkqqwv1
         w51FQywFMDjlu1htLZRJh92tpy4pJdyDLx2dDrC6xa1MrmQBirQkRd3snwE4XNhoU8cI
         maTw==
X-Forwarded-Encrypted: i=1; AJvYcCX9PXMdIQS7Km1f3C9zm3BU/PjHJHDRsTQcxxQ5/vNQB3hn9Zqs4Viaj2I3f35qGIm7FDc=@vger.kernel.org, AJvYcCXvKL1osI3oxw0ZFA6t0bF2KqMblAypHgiv+/kJWdtMaCVMPjrMqG2AbFEy6/+GyVf8wMhluO5ojhASFpQj2dPd@vger.kernel.org
X-Gm-Message-State: AOJu0YxRFDmPFCGeDNzrn+SPknYYY5U8khJLG7P9Oy/5BNIn7opU2kvV
	uz30eWSr2NV7Nj0lX6ebcGvsev8G7sCGes6RrBkOMzcH5KvgiVFnu2OK
X-Gm-Gg: ASbGncs9ZHQUOF+hlVDvHmoUVbInxwLC4VAIud2+/OFXilZcYm0YW0RrFKb2PRN8Ux/
	Zu27koM/evwyDniOU+VkgpPNT3AYIt9hCJOvVLgiyZqVHuD8Jl+zOubbvrL2lXUNiOhnSn+rX7q
	E3SUyIrH0x0Co9B+GCS+kxA+QitB8orJSs7kSjCsqR6gWPoz5tayLg64mVJnRXcRzih+mn8gUND
	1N8MLsodiAb0n2eW7vlKFRR6kB+TkhYM9m5TVrxY3pLQ2W7B6u63g3y8vouI8I1eaNFLLhxtlDx
	/JhE2/Vz0YTvYbKzBKL9PKlGyu5tD//buyMvUIlPx49pHNdai1xEsOo+IQAP/zJirhXhqVUitQ6
	YFGxAW0sXeEncU7jofYyyJniw9UNxhw==
X-Google-Smtp-Source: AGHT+IE5SK5KHSlfLB8JD7zCHmB/5KNe8gE6VFfLbNuBWEgWobeTX2hE4Dljm07wtgCeA3VeQqkSaA==
X-Received: by 2002:a17:90b:1c10:b0:31e:d643:6cb9 with SMTP id 98e67ed59e1d1-321161dd4d0mr346222a91.1.1754064412260;
        Fri, 01 Aug 2025 09:06:52 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63f0b04dsm7843547a91.25.2025.08.01.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:06:51 -0700 (PDT)
Message-ID: <772b48dcee4b6daaa0b7156b1a2d73e67cd08ee5.camel@gmail.com>
Subject: Re: [PATCH bpf 2/4] bpf: Check netfilter ctx accesses are aligned
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, netfilter-devel@vger.kernel.org,  Pablo Neira
 Ayuso <pablo@netfilter.org>, Jozsef Kadlecsik <kadlec@netfilter.org>, Petar
 Penkov <ppenkov@google.com>,  Florian Westphal	 <fw@strlen.de>
Date: Fri, 01 Aug 2025 09:06:48 -0700
In-Reply-To: <853ae9ed5edaa5196e8472ff0f1bb1cc24059214.1754039605.git.paul.chaignon@gmail.com>
References: 
	<cc1b036be484c99be45eddf48bd78cc6f72839b1.1754039605.git.paul.chaignon@gmail.com>
	 <853ae9ed5edaa5196e8472ff0f1bb1cc24059214.1754039605.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-01 at 11:48 +0200, Paul Chaignon wrote:
> Similarly to the previous patch fixing the flow_dissector ctx accesses,
> nf_is_valid_access also doesn't check that ctx accesses are aligned.
> Contrary to flow_dissector programs, netfilter programs don't have
> context conversion. The unaligned ctx accesses are therefore allowed by
> the verifier.
>=20
> Fixes: fd9c663b9ad6 ("bpf: minimal support for programs hooked into netfi=
lter framework")
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

