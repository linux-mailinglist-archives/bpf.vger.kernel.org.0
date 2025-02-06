Return-Path: <bpf+bounces-50676-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B2DA2AE85
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 18:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 625E43A364F
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 17:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC164C8E;
	Thu,  6 Feb 2025 17:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIYEtTWL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF0A23956B
	for <bpf@vger.kernel.org>; Thu,  6 Feb 2025 17:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738861773; cv=none; b=Roo25FhU9BZC6iLCsdJNu9rvpWhczMDUmODw/8a6pFER+5MPIyKQYLLMX7dZSBUsitbfhNVBs5d5slkPOS/xJBlCnc0DC961A1AEXZJfyc1Aicb53OwPdQZty2HIxXI/yepYGz74nC/Q3sFBfBNiCDk47XEfqTZTF/dvh/AYwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738861773; c=relaxed/simple;
	bh=DIBuUq4HTg+BiUFUP2UjQYYTOGozFETB3MVfh9XRlpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCUkRzZW9QMJDxgSlk0Qr9Y16cCPSpFjjfp9+TXrDspdwjYyb787E7L4jIRJ1dWM46+I7eHUXQj7mzlhgjpEA+hZURM+1zGeu/XVDIsTSod2IPhWwxjFeTt1VZDQ4t0pdCaid5gaSIixpuCmWh3Sg1FKACPVBh4g35bhGBP1U/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIYEtTWL; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2fa1a3c88c5so706428a91.3
        for <bpf@vger.kernel.org>; Thu, 06 Feb 2025 09:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738861770; x=1739466570; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ucj58jv1ouyK6nmH2gLAOIPmpv28AgTSSrxyGaPnA8I=;
        b=SIYEtTWL4TMVRFAK0Bh0aRREs86TqfXUpcZ9hk4noUmtJurAdHnIiWiJymXGrpV894
         QUMb3Xqyq8u2nsUTZhpVLCy5FMcxio2CgniUB4blcJjst8/oryVQ7H2ayHcxmjQRrCot
         pvuGHjPARtNvatUD/85POe1VoDeHyECNyzsiDzg4X1cl5Xxa7PMskpKX7UU6Vf8C5op1
         Dp5PUHbgsU49UOxTRe0u5ig1cP+ilp8sF5zUtQZVJzlm1F7vcxVRgltwrOPoytRkTUFj
         35Db8S8LIYBlMODHsa06gf9y2b9YXy98hf28sjs9DBHFayuBc6/89eWDcjlj+gnbMyIK
         aCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738861770; x=1739466570;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ucj58jv1ouyK6nmH2gLAOIPmpv28AgTSSrxyGaPnA8I=;
        b=EZyCUqtn5bIUTyb4KeYVpVuQKNJcj3V/jRNs8+/DiAaawKvsn2rZGkfZkOnAjclaSp
         QFE0K8Yezl5cXhw4Zc9dZxpJaBPQM6eTgBLk3XoW7eTFHrc6ZAuGFC3LJAwoWBqBszNh
         RG4FsbIzCqZA6mMDuIAgDr+7z7rKQIFPvADoILo5o1QsLBCmWg9G2NYF3r+KJ9k05loD
         aXCsEYgllkzg+wNA62DB866eZ5MWbm/baks6+r8JPPj5UpliP9y0MB+22NS5Xceh2p7D
         OynnNKEuGs7e2fS4v2qZAaJQy7EM5LkDBOSBtbxeXkHm4lvvtooxBzuSg+YDBXLmTIvp
         3Sng==
X-Gm-Message-State: AOJu0YwOS4mCe3lqiIk663n1HUmWZv5ZcgPMj6hxLvHRG5UC8ZnREhmg
	+8TNt3KOrsDhXP/2srP8UZMI0LZpZtUam8oAXjVw94FQ5oL9Havp
X-Gm-Gg: ASbGnct24a6n09hkP8N9tjY7kv3erVyi3f6qzIQlpXYAm3bKfZJ5Hx2ohnQlXBPuiQX
	gybYhoEL5Wrm09GOFgUxsoLiBgxi6WrR/gNCtMlwtz84XnYGrvVk+lLYe5yM98kZipneXkSxdiA
	vDBCzHm3AQ3qMFY4K2USSgi6mUj3Mlab2hiuDBdjU4GgpEelaL1Txe/F6Lq+bhYgm92q9EpjxZU
	aurcyXGfdkdQ5E54xetSTssgpgSLu/BAn7quWjGyVH9UgcpdwJqLa3Ip0IT444tDEiskaBcDrOW
	5H5SRQp0m8jbZgW2ew==
X-Google-Smtp-Source: AGHT+IEekSuqYziqKIgiy+RHRlNkYiLkvkgRzbPXKfOyKzFGMQGwq4C+myVo+q5bBN55ug8qnHAG2g==
X-Received: by 2002:a17:90b:1e4d:b0:2ee:a127:ba96 with SMTP id 98e67ed59e1d1-2f9e080f25bmr9704301a91.23.1738861770396;
        Thu, 06 Feb 2025 09:09:30 -0800 (PST)
Received: from localhost ([2601:647:6881:9060:901:e6b7:65:386b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa0d915e9asm1468198a91.9.2025.02.06.09.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 09:09:29 -0800 (PST)
Date: Thu, 6 Feb 2025 09:09:28 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Aryan Kaushik <aryankaushik666@gmail.com>
Cc: bpf@vger.kernel.org
Subject: Re: Fwd: LSF/MM + BPF ATTEND - Topic 1 for discussion
Message-ID: <Z6TsyIDwfkvsJdsn@pop-os.localdomain>
References: <CAHnJ_vj-bbZhUqoDrf0wXEh8gEUVwq34WMXfHRo5=nx5FAL4OA@mail.gmail.com>
 <CAHnJ_vhEwtqFtjjEX3DN03e1_vKSBu4e2cOAdinzgtrs2aPjUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHnJ_vhEwtqFtjjEX3DN03e1_vKSBu4e2cOAdinzgtrs2aPjUw@mail.gmail.com>

Hi Aryan,

On Tue, Feb 04, 2025 at 02:00:19AM +0000, Aryan Kaushik wrote:
> Hi Team
> 
> Hope this mail find you well.
> 
> Topic 1: Practical Applications of WebAssembly (WASM) in Filesystems,
> Memory Management, and eBPF
> 
> Description: WebAssembly (WASM) is emerging as a powerful technology
> for secure, efficient execution in various computing environments.
> This session will focus on how WASM can be leveraged in filesystems,
> memory management, and eBPF.
> 
> Key discussion points include:
> 
> 1. WASM’s lightweight execution model and its impact on memory efficiency
> 2. How WASM interacts with filesystems and operates within sandboxed
> environments
> 3. Potential synergies between WASM and eBPF for secure, efficient
> execution in cloud-native and kernel-space applications
> 4. Real-world examples of WASM implementations in security and
> performance-critical environments
> 5. Challenges and opportunities in integrating WASM into Linux subsystems

I assume you mean https://github.com/wasmerio/kernel-wasm ?

It is indeed a very interesting topic, we discussed it before internally
as well. IMHO, the major concern would be that we already have a
run-time sandbox for eBPF, so it would be difficult to have another one.
Nevertheless, I think this topic is worth discussion.

Thanks!

