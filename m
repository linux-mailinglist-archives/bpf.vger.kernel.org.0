Return-Path: <bpf+bounces-35654-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 432DD93C79E
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 19:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B19A1C21C39
	for <lists+bpf@lfdr.de>; Thu, 25 Jul 2024 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9936919DF59;
	Thu, 25 Jul 2024 17:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J/aYfna4"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC581197A76
	for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928046; cv=none; b=rgXxCsaaqMSW3auKYaf9S17toGZqm271VkaRZX+QiWh+b48Nbb7wrksGkhpdTKFMReGQlzIvpFwPwzcgJcqGBeuEAEvx+8+XJfb+jwceqcXsmuBXYiLQPiviqVCpHwUjJFBrprjLlYDf/DupGQ64drFdzprLbB0/HwCnA87OSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928046; c=relaxed/simple;
	bh=4I+3zw4nPrxCvYHnZHsMySHPIa24EjWVhK/uHj/xWVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q18pt3WVcbZtDVvMbWjBLJGF+iLMxcm72raMjsBgWRKcQ9PBb/MbyBRQQ64y+Nn+/3VnSpjlstedb3i1kndeCb7s7s/Y9fTyKOcApwle0uVWb5QIrDC0HQbI5rMG5/YVw0U9n5fKV2SecaGNL9FMUSIerG0RuMVteIcrKUf47c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J/aYfna4; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1fc4fcbb131so10764005ad.3
        for <bpf@vger.kernel.org>; Thu, 25 Jul 2024 10:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721928044; x=1722532844; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4I+3zw4nPrxCvYHnZHsMySHPIa24EjWVhK/uHj/xWVY=;
        b=J/aYfna4MN3HOvlRl+azVx6hDxYH9vLM0AhijFAUw0X46P5Ax3uI7mxc14KoeE7XzG
         vbePL+kJuMnYkyDLqHI6KCdGNTY6t0FA8W6HGMVj+jm/V4YqAx1PWju3tsELjDjbBfkm
         SsgWCCv0C9F6xkqwi3vhtJ4idSPoVce8tGoOhLOgjpjtXJjaUgMCAgdkTwhjN+pRLXzS
         rZQQ62Cs+wxifqPlpmjc79Q4HSD1tyA/zQMQgzEU9IKCoPmLHYTPCiEBUdPI151vOpUf
         ghXBZuJ2M0H1d3BlPk0E9lxzPS85DDRHQQPohd7W88d2w8tff3LmUOvrCo/evirGsBwS
         6dZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721928044; x=1722532844;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4I+3zw4nPrxCvYHnZHsMySHPIa24EjWVhK/uHj/xWVY=;
        b=ugN7oQh3/RdwJAv2rO3JfRq/wRupZfN5QFHpuFDsNdUTeRcmcIfaJ4NlKb7CQb/oTD
         JfZYHLkzJ0V64lotYMrmPgHRBol64LY09KSt93UHRs3bB6HjhkkA8ysY8w6RPdNoc79m
         wK04AMLv5ufvHk+imsmkfMtFJkrNDDKmyHlE1c8E8mPlwNtYzKHrKr1q3+H2WohTb0ba
         nGhvImoyNqRIo5193mASeuOAfWjC+taN+vrhcj9f7mmci4ZkhGnCwBaev51m3d6qiiVb
         hhy5sy358aWU6LiBfhPJKgPJZ+bOovxvGwtTMymmpJnFPdrp9vN9jz2UhH7Ia17pXEiD
         YkuA==
X-Gm-Message-State: AOJu0YxE5puNdz7JZ205PJgrIrtCDZnNLd5SpolKs4fFPEnvduv+v0TW
	z2WguytSL9JyMx2r0aNHtHR3NV0eGwCl/ABDrNSwjC6XcNR65+Rj
X-Google-Smtp-Source: AGHT+IGITsMNnFQDnZAIn3FzICEmg3gilWw8zZIysA9srKRCjTdt4IktyTEZx5r0QqzXDVF2l8r7kA==
X-Received: by 2002:a17:902:d4d1:b0:1fd:93d2:fb76 with SMTP id d9443c01a7336-1fed929d4edmr28911705ad.31.1721928044084;
        Thu, 25 Jul 2024 10:20:44 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a:6c56:4735:86f4:a114? ([2620:10d:c090:600::1:15d1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fe7556sm16613315ad.291.2024.07.25.10.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 10:20:43 -0700 (PDT)
Message-ID: <b739a10f5613c1d6fbcb2afeda66f415852bcf7f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/2] bpf: Support private stack for bpf progs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Yonghong Song
	 <yonghong.song@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Kernel Team <kernel-team@fb.com>,  Martin KaFai Lau <martin.lau@kernel.org>
Date: Thu, 25 Jul 2024 10:20:41 -0700
In-Reply-To: <CAADnVQJGPvMTakVH6hwngzetab+RYDO37ZpV7n8+szeDskTzZQ@mail.gmail.com>
References: <20240718205158.3651529-1-yonghong.song@linux.dev>
	 <86b7ae7ea24239db646ba6d6b4988b4a5c8b30cd.camel@gmail.com>
	 <f0706fd3-7665-4983-b7ca-ab410c83bf57@linux.dev>
	 <CAADnVQJGPvMTakVH6hwngzetab+RYDO37ZpV7n8+szeDskTzZQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-07-24 at 21:55 -0700, Alexei Starovoitov wrote:

[...]

> So we can enable such feature in selftests,
> but it would have to skip the tests if bpftool is not built
> with the right disasm library, hence the value of such
> tests will be small.
>=20
> It's probably better to make test_progs use
> LLVMDisasm* directly and converge on that disasm style
> assuming distros have this lib easily available.

I agree that the differences in the disassembly are too big.
As Yonghong suggested, I checked why bpftool has two disassemblers,
this is explained in the commit [0]:

> ... To disassemble instructions for JIT-ed programs, bpftool has
> relied on the libbfd library. This has been problematic in the past:
> libbfd's interface is not meant to be stable and has changed several
> times ...

I'll update the disassembly patch to use LLVM library
(or skip the test if library is not available).

[0] eb9d1acf634b ("bpftool: Add LLVM as default library for disassembling J=
IT-ed programs")

