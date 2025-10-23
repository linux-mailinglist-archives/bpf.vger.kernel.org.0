Return-Path: <bpf+bounces-71971-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB28C03AE4
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 00:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C0B493571E8
	for <lists+bpf@lfdr.de>; Thu, 23 Oct 2025 22:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20562288C24;
	Thu, 23 Oct 2025 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgY4C1gz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CACA276051
	for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 22:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761258742; cv=none; b=eH9YL2fLdaD3x63kv6XGCtXRcx2NUQ8wyoSQT+KN6WanqhyF+Gp1UM+pjVjsobLQtzqkGdT4FXb7NSdyhLIR53RWYcsPBboHl/i7+Y/+Ks+r8SmoBxchUWeF8JdWQAlAYXvw/K5+sMfaVk8AdUudzB/g0+nOwzlCZkQI9W8wW2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761258742; c=relaxed/simple;
	bh=2YC0c6Xws/i0S2TwLIQN8CCfA0JgrahpAJLKzFrWlZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T9lkTD6nlvf8hG9PXbfVMjJnZMUkNY81K6KUIVCPYHnRLqyEgpDkvS+xBjcnHXASRsAInc5xhIpeGLFxaeuG1lUxzkT6/lHos4R9bHJl3DwMPe86GlBKG2RITAa8PTZy70OpyrBy3CW/rdeMTa02URc7g55vBFPJLGre/+xxBsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mgY4C1gz; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-292fd52d527so14990035ad.2
        for <bpf@vger.kernel.org>; Thu, 23 Oct 2025 15:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761258740; x=1761863540; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2nS75RgJLaVp5Zr8KgW1JlD07sZ+i6J5H+Xnl8u2kU4=;
        b=mgY4C1gzRZdFSpXx33uKlKhwVH/rks34L20espHBbhUh5hsI2udEQl27moXyekRgzG
         ARt2ilQyuuAv8doWE6IMGc3YhklOqX38g5WwbOKFPEQZKQgEgew9fjq8kgclR0+r2ezp
         bsQQXKfSmsDPXfhR33oUM7t6B9SDMJfLfF5dC3paDyVaY+b9teub4ed72PJ7hwnjxEvd
         o5/AEKzGadV9VQ7gpNSHvz6gsYE2OfTGLogIpqDmcGurX8Cs8v6tZBJtNiAHqyqY6Ytc
         UhMuduLUwjo8s4lhMHPb0iHNwMV3ZArCKU1X2Ka9Fu8uqyFpRROYtl5Xdp+9qEvJq1qI
         Sbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761258740; x=1761863540;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2nS75RgJLaVp5Zr8KgW1JlD07sZ+i6J5H+Xnl8u2kU4=;
        b=evPycnmZKR/b2JtOWTfPi/YCfaq/HGnCHtD8OEoAC2FDceTzIyDn7qck12j80++NAd
         T9tvH7LUvPAY1G49A1HxoOkCS0Z6SZTdQRXhrIQ8p5cWMkMq0VhvHnEAo0RGKNjUHYqm
         VI7sFKyvXAiZJim2tFBGysMLkeAFbIJoyNWSuuKPHK2Uwh2HuGhVTCDLPoK+Ts1FYJqz
         4h28NdQYVM+IuNLTxxxv5We5Y7heUGEv0uq/lRHNAcx0S9HJ89srFsHPwawH/jbbSawh
         sF0kWzl3O8/K8o5MqOJXgZBUV8fbEGe6B9mBBc1nCfQ8HkvITCW/jCwelLnoOnn/o4Ih
         vxbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIn+KZzQHf9F/6WFPAlTs0BKrKsO9Gp/b5MZOob961oiSLJRODGgscC2LdeG5kp60JxaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoWUCW1wX5eW4CEO7HmiTWuy1QjMuWTdeWJ/zfX5y0Hand53pZ
	z7h5AwSDfT/5dVoGHUB/Lqzdk7wB7XKP/sqpoGmGtMrIQB/Q4K09VRgk
X-Gm-Gg: ASbGnct2TWEgrGUOzxeYiUIzpF48u8uxaKfEVYXSSmWlJ9ScZkry7IP+51q3VCdewt+
	wCr6RfSedhpoGWFl6nFeqR9QYK98JyG6Gpc0ypUGMrZK92rhpA3pgAVlpAveJuKoY9hipfGVMF5
	6bn11EGARd+hlWli4QdcE/BpxgGRIUmZ6+wY1tIRZeLA8U9LniJ4fN/IjOE/aj3t9M7pRUp+WN1
	ytm4bh+oy7MFkJDzaCEXzoSL6TSKkxFI1iB2u7jCJry8q7h7MMzqlrxSRSwCzk4ulT5b89I3aFv
	VKEhXmggvel1ad+aeut8OPeRRJa7oV5ruJHp4mlex0LkblyByokGnYo/dMYRP6CKcPtotuwg4QI
	kyOmyBu8hHrcLZZdiK0J9By3FLfxK2nihfwAbeo005JMj8ctvaryHICjhekU5A+w/Ezp/tKnQ2U
	JyZ+C6J3Uc
X-Google-Smtp-Source: AGHT+IG8Szm+Zl/SEvjwSffMN8YfJXGOYYusIXoJW0RkAX0o7ys3YW4BmMWY7stK2byRMYHalmDEzw==
X-Received: by 2002:a17:903:11c3:b0:273:3f62:6eca with SMTP id d9443c01a7336-2948b976597mr612045ad.18.1761258740469;
        Thu, 23 Oct 2025 15:32:20 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4c053absm3137779a12.14.2025.10.23.15.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 15:32:19 -0700 (PDT)
Message-ID: <580ec956067975acbf18d354564be3459503ed63.camel@gmail.com>
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com, 
	yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	qmo@kernel.org, ihor.solodrai@linux.dev, david.faust@oracle.com, 
	jose.marchesi@oracle.com, bpf@vger.kernel.org
Date: Thu, 23 Oct 2025 15:32:16 -0700
In-Reply-To: <20251008173512.731801-1-alan.maguire@oracle.com>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-10-08 at 18:34 +0100, Alan Maguire wrote:
> The Linux kernel is heavily inlined. As a result, function-focused
> observability means it can be difficult to map from code to system
> behaviour when tracing. A large number of functions effectively
> "disappear" at compile-time; approximately 100,000 are inlined to
> 443,000 sites in the gcc-14-built x86_64 kernel I have been testing
> with for example. This greatly outnumbers the number of available
> functions that were _not_ inlined. This disappearing act has
> traditionally been carried out on static functions but with
> Link-Time Optimization (LTO) non-static functions also become eligible
> for such optimization.

I looked at patches 1-12 and at pahole changes.  Overall the changes
make sense to me, it's great that this is finally moving forward.
Left some minor comments in the thread and on the github.

Could you please post pahole changes to the mailing list,
to facilitate wider discussion?
(I'd like Ihor to take a look at the btf_encoder).

[...]

