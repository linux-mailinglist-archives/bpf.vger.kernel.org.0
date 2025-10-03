Return-Path: <bpf+bounces-70353-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFB9BB8440
	for <lists+bpf@lfdr.de>; Sat, 04 Oct 2025 00:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 186D84E89C1
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 22:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D127426738D;
	Fri,  3 Oct 2025 22:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJcwCzjW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3AC19882B
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 22:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759529838; cv=none; b=bzacQyhG12wLJ/CjAxeq+SEVgNe0BYbuzIXFdIgoMCir+9BcPHDap4OQh9XwT2uWZ0Q+ajFeKK/lBjWTZwlogQH7QZdgdPsUnEiMkYldjkbyUstw/mMSxoxdbH0Va1HQzHiwQsg9y227Tdey10HcQvkfdnuR6rb6x+FL69TyATw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759529838; c=relaxed/simple;
	bh=wrZh7dVGWU5jK/7uReEJmkdzodjTdbvkhofwHGF6Z/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ifHMN2bitiIED5o+cnNBLl/JbuhfoQRNcz97Zjf6zuCaPnyN/36CLArFSiqQL0D/16tp/wFxnN5yV9l+oIQM8nrZYIIguaDnhp1ZlGjT/sjRBUkFs06uiLH7hMt2WGW48ujBkCQBNRcUrXHQmrCb0lV6e/plOoNYxpvJUVqyV8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJcwCzjW; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3383ac4d130so2703531a91.2
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 15:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759529835; x=1760134635; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FBlj0QnDdU4kBlRxPh00CwcsOi4L4XCloVNT9ic17dY=;
        b=FJcwCzjWMghF0wQw61O0ueEB07D450wX49Ing000XuuE8ut9zIXUkO09XNxKFvOTbo
         JPAnFyolYsr+C3H1Tk7OqTL92Y4l8DmQDmDfnKC98vwY9EBNOyUcMrqBeI16SSoeGEwd
         zsQRUCj5g4eF2HZFDUpnaq8Xg+dyORzqRlFBzM9XEeLb8bHIakLapxqyQT6HT7BjgHrk
         cCkNW6kCSf+vhQi/NzEazSZuZou6HIc6vkhmPc0oEaZbdowncYTMALG0YXGTWzu34cLK
         dY9cb/z1nJZltvXxarhzO4+BKXbWrz8HL4DOdhDuvjgnhl5glW3OxUzoEVq2jVvQJIzB
         QIyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759529835; x=1760134635;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FBlj0QnDdU4kBlRxPh00CwcsOi4L4XCloVNT9ic17dY=;
        b=MCvmQggaQH20GuYfLD9781OLa2hrkQrmSenJlMExnBM8M4Yx65IA0XoNhqW1r7JL06
         yChuIHyBR2oAR86I48lqiVZscaf8hQQNkBeMkXNJmUtvjBxSPl5ggAQW7GGIFdRnhZyY
         hiEsYIBv7U+OcPVGz59MRpWKrHEGrQTdBBeayenyB/CBdVYFP4J61dtJyRO0t7oO8i9C
         AifyJZHRPjF3xzRZ/+wTTaCAyDfqEwyCQ2VtGHQM44HsT07M1mGlygo9S0TwN3jNwuds
         NnSBz98E2PNVqWwxcjmRHKVQ8eNI0Lxo49+OBwt420/IdLMrZtBRqvBOLxcCJlT1zsCw
         n7sw==
X-Forwarded-Encrypted: i=1; AJvYcCVQuKbfWahnAhlTuaOEEl+TGbhjx+cRa/TbNY3nZDIn4g6AV99NK+T0SjVkMwS7S8qtjLo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFfZrGMVIEAoZgRmhkI22uqJt43WCi9ZdlEkD1EPY4pAsUDAB0
	ULt0fBibnFLGDXj3x/PKetlMx0gNIA/yKlvrc9VDXA+pW1RTjxy/0WVl
X-Gm-Gg: ASbGnctlN4eZmzwTGjFfHwAqiPXBUqg4Tx/GKZfmqOfPGYTsIhBGxkKxC8JF9ZWAO+5
	iGQqI+/1hVNeF73NN5SF5GPIEIBbjyyO74mZeN1MBlbqWRAL8X+zaVT+D5XLyLrSagwDejE9Vxl
	VUCthomCjWGoLfEKCHNJFk62DaDSGWFfQ1moSwBRPkMda0zO4wdh4shE8F8Yu/e4ARFVtDf5D6G
	W2w8bzfevLxPXZ9Xxfh9MD+UtuXHtPggZP22qW1SiM+V3cCooXlJNqtD62tQxuz4QWCIo2kWfZi
	g53lJuJNaJMNXFy+6vDNLDd8yxiqQuxpg+hjS1y+ecGk1oe5FDzi5RGbPhrh1H5hSRi5vEHJ1tL
	fKabtLXCBcSjRwP+Sfj+NAdwpDVM9htV6y0q+KJ2mYbS/yOSvPCrSugwgzOms+O7UWg5cjeLL
X-Google-Smtp-Source: AGHT+IHhmrO53/U93+pykIiacyAG1dNue28+u4RD2ROEBZV9BVODNjVKnwef/3adQ3LTEW7gqyPFrg==
X-Received: by 2002:a17:90b:1845:b0:32e:32f8:bf9f with SMTP id 98e67ed59e1d1-339c27d2ec8mr4972554a91.30.1759529835241;
        Fri, 03 Oct 2025 15:17:15 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:2a3b:74c8:31da:d808? ([2620:10d:c090:500::4:e149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b62e121e0afsm1949188a12.25.2025.10.03.15.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 15:17:14 -0700 (PDT)
Message-ID: <8e1e6e4e3ae2eb9454a37613f30d883d3f4a7270.camel@gmail.com>
Subject: Re: [RFC PATCH v1 09/10] bpf: dispatch to sleepable file dynptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com, memxor@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 03 Oct 2025 15:17:13 -0700
In-Reply-To: <20251003160416.585080-10-mykyta.yatsenko5@gmail.com>
References: <20251003160416.585080-1-mykyta.yatsenko5@gmail.com>
	 <20251003160416.585080-10-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-10-03 at 17:04 +0100, Mykyta Yatsenko wrote:

[...]

>  /* bpf_type_flag contains a set of flags that are applicable to the valu=
es of
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 4c497e839526..6078d5e9b535 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -581,6 +581,8 @@ struct bpf_insn_aux_data {
>  	u32 scc;
>  	/* registers alive before this instruction. */
>  	u16 live_regs_before;
> +	/* kfunc is called in sleepable context */
> +	bool kfunc_in_sleepable_ctx;

This is a subprog level property, so I'd track it in bpf_subprog_info.
Note that there is bpf_subprog_info->might_sleep flag already,
but it is not exactly what you want.

>  };
> =20
>  #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF prog=
ram */

[...]

