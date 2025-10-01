Return-Path: <bpf+bounces-70142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B86ABB19AA
	for <lists+bpf@lfdr.de>; Wed, 01 Oct 2025 21:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66E3A7A9216
	for <lists+bpf@lfdr.de>; Wed,  1 Oct 2025 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6A7283FDD;
	Wed,  1 Oct 2025 19:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxhiL04T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FE126F2B2
	for <bpf@vger.kernel.org>; Wed,  1 Oct 2025 19:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759347136; cv=none; b=KMCZAthc3s54dXWlGdnW07VCJfc97413dJ4O8UuF6grxGEuDMxPY7M3kld8ztosXekulMfTIpdVGx2ds3C4ChY7q/lXt2+7YVBgHKpf9Jiyg1eY07NZvv51dL7yO8kaMJCKvGUAMuZb+CJjB6WTaI/7hYwiaqxHUnK29FljBK7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759347136; c=relaxed/simple;
	bh=AB+3ZU/r4mmFjziMeNnrw8jJOTXW21ulNp4jswpIkxE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gi2iOL40J7bXbxJtcyXeNEh316DqII5O6G9tNYzpUi2XxaVHQOxb6nRcKGmBzmTv11yhbFMflzcL39uIqw/m1Q5M/O3W+L3bznZyBGKECnLOr9C8U1kQrvuUi6rAf1zbSkZdIAmK1/q4NpDwgUBr+ut+xGbuFvGP1z7GHsXKDGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxhiL04T; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27edcbbe7bfso2153305ad.0
        for <bpf@vger.kernel.org>; Wed, 01 Oct 2025 12:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759347134; x=1759951934; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AB+3ZU/r4mmFjziMeNnrw8jJOTXW21ulNp4jswpIkxE=;
        b=UxhiL04TXY+Prdg5H4W3+SwtG/ecdB0PH4eI8q1wQSF9nwG7BXAmn1TIf3Zh3otTej
         a+XvkGpQY5uUH+2M7J3Da1rvroLpPo/PRs8cerHZfEx8HVGK1Q++H/AVLqzu3S1rnP5y
         iEP9MOpV2QThMj3C8Dq0/qZn2PL8nzq0W+QA2kfcD3vNbp9UcfnJgJlehnGvGyOu1r1T
         XHG1V7Yjy/siexR2dpaCzVSg+ikp3uVaMEjcWI56gt19aAjm5aizP5fDdivPyUKPzQ88
         KqLGVYUcXlrE7XPgzx+yKnDPVYU1f/3u57htCmMOqfdmYP8COJ5P/0/oWPye20d7o2mV
         wNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759347134; x=1759951934;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AB+3ZU/r4mmFjziMeNnrw8jJOTXW21ulNp4jswpIkxE=;
        b=ZPHI/0XuqmGFAbILIZY1F0YdM/B+jh+PymHVuyxlW10hJ8vC18HR9MyazF/ITwoRNt
         pIBAFVN3aq9ydNynRHxBF41kz4I5pJqSXF3wbCea7f9PNSFGdwqMw8gbgYLd+x4pHeVg
         EkFpu1rJcTXdfNmsyIvUOxvJzIkehHvrCeRQYbI0MX9PQTzPIfBmtY+rMDSsNReYZhgt
         JCLuAbtghvgV0jQA1SPkkzVXYZNmMFDyuc/5YHbLMbvul0ewUYjJjkJMZdgfyPc8bRZc
         QFrcxFn44zjsFUPVZXfxqQbrvxDs0NGxukb8IFWlvKyyNtfmJpmZ0dM7VIAUs6yrjm+U
         rhSg==
X-Forwarded-Encrypted: i=1; AJvYcCV5KcUPn281/dQnWwHeVyueUxzZlVQv+9R+Xt7rYC6i5jTZXQcBlFhX/Kqy64Fw/dAr5Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YytPXLhBIJSEtCgGn++y0iZ3u+3TPnoPzc7guuIQigdw0R3Ylt7
	E/9L6PQLrBZMcAms3u9/baQ5MEiw57Rao0iFAXvt8Fdm7HhXFKqP8TGi
X-Gm-Gg: ASbGncsh5VDHmQW1Q2FBvGadUO4tLKOuBp347xaagaFKiubMGyHyIF/YSnCJDo24cjt
	HwyUCF24jEtLZQj53i9BE04lBIoGXGR0kTRVHObr7pqM6YXekRwDtPoDRPdTelVs8U/yDm03b3i
	jsjLRsJlY8P4766igtW3apaEEd71GlukB0xYQg6Q8nv95LXsRP5no9lMXCCUWBPSYPZ/Knl7/Ov
	cDrMVfR3dXNL4XwvDJxm0nF7s5sfw1GNMhxfpLO1VkxXytWiNXlSoRQWHLJTaNVZo5rrPiXfZb3
	AdCn3j5i9D7QmSiH1MBeqgyi/F8bsLZAhNbVaB8T4pPs94NkLsa7hPZT0djGFKh4FDLmRQEr2PR
	2X6GjnpuWOtbVawlyl5aYIyK7kXyGV88ZmHRTVIo0g8kDtvB0Pk1TcbPYcRvW+QXVcU3HtvI=
X-Google-Smtp-Source: AGHT+IHm8zVw7hCRgUCJVA4l51+UFyZtdxO/eRTnE+8iXurYGow9Z2GDIKZPCQDTJV3ZwB4QbFulhw==
X-Received: by 2002:a17:902:e74c:b0:269:b6c8:4a4b with SMTP id d9443c01a7336-28e7f2a11f7mr61532815ad.6.1759347134292;
        Wed, 01 Oct 2025 12:32:14 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:1ed4:e17:bedc:abbb? ([2620:10d:c090:500::6:420a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1d95bdsm3640625ad.119.2025.10.01.12.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 12:32:13 -0700 (PDT)
Message-ID: <8f72a29f419377ac9e3ddd7ae56bc1e0826058c6.camel@gmail.com>
Subject: Re: [PATCH v4 1/2] bpf: Skip scalar adjustment for BPF_NEG if dst
 is a pointer
From: Eduard Zingerman <eddyz87@gmail.com>
To: Brahmajit Das <listout@listout.xyz>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@linux.dev, sdf@fomichev.me, 	song@kernel.org,
 syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, yonghong.song@linux.dev, KaFai Wan	
 <kafai.wan@linux.dev>
Date: Wed, 01 Oct 2025 12:32:11 -0700
In-Reply-To: <20251001191739.2323644-2-listout@listout.xyz>
References: <20250923164144.1573636-1-listout@listout.xyz>
	 <20251001191739.2323644-1-listout@listout.xyz>
	 <20251001191739.2323644-2-listout@listout.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-02 at 00:47 +0530, Brahmajit Das wrote:
> In check_alu_op(), the verifier currently calls check_reg_arg() and
> adjust_scalar_min_max_vals() unconditionally for BPF_NEG operations.
> However, if the destination register holds a pointer, these scalar
> adjustments are unnecessary and potentially incorrect.
>=20
> This patch adds a check to skip the adjustment logic when the destination
> register contains a pointer.
>=20
> Reported-by: syzbot+d36d5ae81e1b0a53ef58@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dd36d5ae81e1b0a53ef58
> Fixes: aced132599b3 ("bpf: Add range tracking for BPF_NEG")
> Suggested-by: KaFai Wan <kafai.wan@linux.dev>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Brahmajit Das <listout@listout.xyz>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

