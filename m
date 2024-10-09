Return-Path: <bpf+bounces-41350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A99995EC9
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 07:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF15B210C5
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2024 05:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB0C14D280;
	Wed,  9 Oct 2024 05:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcGdSQET"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C7836AEC
	for <bpf@vger.kernel.org>; Wed,  9 Oct 2024 05:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728450305; cv=none; b=ME2f8vp917WGJdPJUlBcJw33IG0rFS24DAGrAiTDJk/9pnLYLEjtpZRNBTp/STgbPdTVlKJdTjQMQ3545xkvxy813GtSzESbi/Cj3ctBIpQrmFe8vNOKfgDZWCqHflVHCdvOxw5dNKVoDnXvPvp6zBEPyHi249Z4j/ALlaGdOwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728450305; c=relaxed/simple;
	bh=FcBkiiZhvg4+OZnyifUOLHOn9iR01zAG6pqcObsYGwc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUXTZ3hpP8lHAVgQxfuRIR1F23I5dbjKE0ETj98ZDQhppWcuRZoSLdzszrWSjz+U75c+BkBIw9oU7AoUesfl6cxoWJJfP9UgaLkfMAqJpXcGGGcXnMOUO28TUIUz7Y8xvgX8dyuwi5CbIgxs9yZiu4hhUMEaklBHFCy2AOvjx8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcGdSQET; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71df2de4ed4so344790b3a.0
        for <bpf@vger.kernel.org>; Tue, 08 Oct 2024 22:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728450303; x=1729055103; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Vsoe/UwA61dTg69pJLYXR6vvUTDC+KgSTtrSCrSZbwI=;
        b=CcGdSQET/EE2ce6M1Gt4U3xi8L+io+I/UFfL92oYGfilYoRGh59yVkk0Ixc1DY34co
         8ZMA9ZdMeXEggTBkBMEWQooUvEBnnpgFnlfijweBTYrQvwsefJhJ58pX19iwZ1gMZDZh
         yUU7TgEyR+XJwEqadZMIstYh7sEz0zeOc4Y9IRpR+ftCuYZlwrTX2xrfqlC4tg2m87Je
         k/CZnLBkn/DVLk1qFwPupYP7VB+KnGTGbRGBWgyB2qerHwEFWx8TB1kzDSgZqFi09CdC
         fi5VedtVY0vrebsircw5xNzGP6bK0WYfwtydz3EOyQCj7Ult5tk1DerQvSRqw/NEmlhn
         inkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728450303; x=1729055103;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vsoe/UwA61dTg69pJLYXR6vvUTDC+KgSTtrSCrSZbwI=;
        b=jCFIiEekFsuenSaf4RNUPHCEmRrPukNsusT6PWndOSH5fDQx486gkRZ7MuoTB5L/b+
         VjZSlq7SVLKoZQTOuUAyOPmuXx23P5maC+F95xWlK3tOaSeboa4ZHwPbxr1MxzKKL7yz
         yAMLgbMH+Q71xuKUWsVKYUXM5ZZ9JgD+cbdX6HQTxGein1WnQdrK4zfHSh3oNZ8PXxSu
         2R2JaWkX3wNDxu41GeE8L2zM+jAxtkLJouayfNsxXpdTxXr7jGlvSEXNsV0x4gh7ZGnr
         kz9hbjE2f3YCL9ISZgXY3vjiYgkO+Vuvsrd8KTYkUfS/KV5WPfRNKsWPauhYdr+CCeHn
         F8Ug==
X-Forwarded-Encrypted: i=1; AJvYcCV/v8dHTdWPCxJb+d3XyQqe8HJZwrywyoZ6sM7wRBxs6YyVb32S7Vy/cQqbAx4bxVTK36k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLIQDeoS7AlT3vztJbX2CBpXEMpWab5BZkQY6Qz1OfDwYLfc8B
	9BZnco2aTgZKivScE0gGGzSoVCez11EJeNvP1hKHgQrM2T/yKTTV
X-Google-Smtp-Source: AGHT+IF+/ubQsHQVmC/oeLWq+BVxfL+7vHHLf/BH6ZD7F3/JrBhNTPfr7J0L3WOxgEZbvxE2TO0usw==
X-Received: by 2002:a05:6a00:244e:b0:717:8b4e:a17f with SMTP id d2e1a72fcca58-71e1d646a4fmr2577946b3a.4.1728450303163;
        Tue, 08 Oct 2024 22:05:03 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0cbc4cfsm6971966b3a.38.2024.10.08.22.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 22:05:02 -0700 (PDT)
Message-ID: <e8ca8f6d618a446a3e7ab28f4f36ab7e1e814432.camel@gmail.com>
Subject: Re: [PATCH bpf-next v6 3/3] selftests/bpf: Add cases to test
 tailcall in freplace
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 toke@redhat.com,  martin.lau@kernel.org, yonghong.song@linux.dev,
 puranjay@kernel.org,  xukuohai@huaweicloud.com, iii@linux.ibm.com,
 kernel-patches-bot@fb.com,  lkp@intel.com
Date: Tue, 08 Oct 2024 22:04:57 -0700
In-Reply-To: <20241008161333.33469-4-leon.hwang@linux.dev>
References: <20241008161333.33469-1-leon.hwang@linux.dev>
	 <20241008161333.33469-4-leon.hwang@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-09 at 00:13 +0800, Leon Hwang wrote:
> cd tools/testing/selftests/bpf; ./test_progs -t tailcalls
> 335/27  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_1:OK
> 335/28  tailcalls/tailcall_bpf2bpf_hierarchy_freplace_2:OK
> 335     tailcalls:OK
> Summary: 1/28 PASSED, 0 SKIPPED, 0 FAILED
>=20
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---

Tbh, I don't think these tests are necessary.
Patch #2 already covers changes in patch #1.

[...]


