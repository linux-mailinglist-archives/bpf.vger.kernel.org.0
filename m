Return-Path: <bpf+bounces-45173-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78DCD9D251C
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 12:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D2752812EE
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2024 11:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC881CACE4;
	Tue, 19 Nov 2024 11:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XLUKMU59"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5391C8773
	for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732016701; cv=none; b=OJ9xNLksBb1jDigKrcwAdyDlFkEAu0F9R2PcIjgWBgHHtiPxBsoN+WiCJ7rlnrUAMjBYz7EK467EEbY5DhMyfM9umZkFxig+AZoU/JXR3C02iZUyLJPNhiiul9npSeFln8gik5Oy0BH2AEu3QTa18IigKjx27U3ihE1C1Aq9kwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732016701; c=relaxed/simple;
	bh=XnBObvtN6Y1NDGYs7n89tQZ/qhBxqxQoIfYEWQ3K8S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SrLlzrW+MXeHAgyN/e/jNX7meiBaNoXap2lnOQbkqR2PN5QkZwDXf2pAzpgHdUL6dSlHg9lffLs5bjNn6xp2thJaeX4+A8TSF5mxs4VxWHysQysgOripgrgiclCSwVCY9D0RsuyIJDNt+ybV2S2Fzfum3ij+bULMOwxb1q11EaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XLUKMU59; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-539f76a6f0dso4068898e87.1
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 03:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732016698; x=1732621498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5puBiZg+NhuD8XHmKyLDgXicbLou9/m7OP/vf5a+09Y=;
        b=XLUKMU59xLKNPmR+/GMbsd1x3hw2G+fRaBSjXmzk5t3dGVEayE4EKa9wndlAVek+ET
         OafNkLHhKqQpFbzjTRB57mj0eUKrenqwC1981jmPlbMZ2xHnsoT42M7nSVF0GSTSWVaV
         B2Y4oCeXlf68OZVQWXwmIDaxjCMLgviC0MZ3gyBhcZ+yHYBkO8Ke+71b/9PsmV/JUyMy
         uWHpHbJfEjK/QCRNryZ5C1PADWKfC+Xc48paeYJhAVrtWdLj1FzBYVF4fuc/k02NmGZB
         oqmcHjluomCER8r3TjSTfwb7jFqA5aJC+dt/e93thldVZIm1oJjhBt1cnn/L0HHIihVE
         y0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732016698; x=1732621498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5puBiZg+NhuD8XHmKyLDgXicbLou9/m7OP/vf5a+09Y=;
        b=TFlUqMHxcYk3styQpUqK8oldnqyPzISsdq5oMbGdMzD1w5YjCE+geoCCn6sj7QnWbF
         jqxfFvH55kAK2kWE94JrOFexgzwuYQ7bp6VlNySsZ4JwwJTtmwv/yNrMppQGI7KlVxjd
         oFDKhZMiKGPhPTOuH9B8uLe6IcpRJovJXt4qfTE3xh+C7e7f+yTkXvB3XjbqnWy3Wh1P
         q/w9F30bsPgyn2xyTT65LwK9Vb8kfApXsVTkVjCy+WnBpIaZFBYvyZ81TlE+H6GneaUV
         SqgDmFPdqkwrP9BkyXFyiruPKtCfXS6I1A6rC/8A+q4nITsHVUsRYkaDDSNGvGP7rWwu
         cfug==
X-Gm-Message-State: AOJu0YyrmJibhnVHY0LhmlaKAaIZzrQCHXAjCMu8AJfxiCxbWGwYvXBe
	RHnN+o0rh3/W/UJ/H/BLeTisoZMso8eHW2qu/nW3J0NuUh6DUBvORQ6rtrHf1BUZgydtPh5Hfa7
	03WyS1w==
X-Google-Smtp-Source: AGHT+IFYNfgQBZjOV0+mzSrcl/AWzNvKuTP0LmK1UgWi5efVCRsW/F56aAhuZOyIZmtRvtq3Yws/Sw==
X-Received: by 2002:a05:6512:31ca:b0:539:ea49:d163 with SMTP id 2adb3069b0e04-53dab2a2e20mr6074601e87.21.1732016697856;
        Tue, 19 Nov 2024 03:44:57 -0800 (PST)
Received: from u94a (2001-b011-fa04-f863-b2dc-efff-fee8-7e7a.dynamic-ip6.hinet.net. [2001:b011:fa04:f863:b2dc:efff:fee8:7e7a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211f1c5ecc3sm55526585ad.228.2024.11.19.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 03:44:57 -0800 (PST)
Date: Tue, 19 Nov 2024 19:44:52 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: bpf@vger.kernel.org
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
	Edward Cree <ecree.xilinx@gmail.com>, Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [RFC bpf-next v2 3/3] selftests/bpf: add more verifier tests for
 signed range deduction of BPF_AND
Message-ID: <fdn3o7fqr7glob6hfllodlruczsctf6kbavv6z5ugnqkmwb3qc@yghjmuxwljba>
References: <20241119114023.397450-1-shung-hsi.yu@suse.com>
 <20241119114023.397450-4-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119114023.397450-4-shung-hsi.yu@suse.com>

On Tue, Nov 19, 2024 at 07:40:21PM GMT, Shung-Hsi Yu wrote:
> Add more specific test cases into verifier_and.c to test against signed
> range deduction.
> 
> WIP, Test failing.
> ---
> The GitHub action is at https://github.com/kernel-patches/bpf/actions/runs/11909088689/
> 
> For and_mixed_range_vs_neg_const()
> 
>   Error: #432/8 verifier_and/[-1,0] range vs negative constant @unpriv
>   ...
>   VERIFIER LOG:
>   =============
>   0: R1=ctx() R10=fp0
>   0: (85) call bpf_get_prandom_u32#7    ; R0_w=Pscalar()
>   1: (67) r0 <<= 63                     ; R0_w=Pscalar(smax=smax32=umax32=0,umax=0x8000000000000000,smin32=0,var_off=(0x0; 0x8000000000000000))
>   2: (c7) r0 s>>= 63                    ; R0_w=Pscalar(smin=smin32=-1,smax=smax32=0)
>   3: (b7) r1 = -13                      ; R1_w=P-13
>   4: (5f) r0 &= r1                      ; R0_w=Pscalar(smin=smin32=-16,smax=smax32=0,umax=0xfffffffffffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3)) R1_w=P-13
>   5: (b7) r2 = 0                        ; R2_w=P0
>   6: (6d) if r0 s> r2 goto pc+4         ; R0_w=Pscalar(smin=smin32=-16,smax=smax32=0,umax=0xfffffffffffffff3,umax32=0xfffffff3,var_off=(0x0; 0xfffffffffffffff3)) R2_w=P0
>   7: (b7) r2 = -16                      ; R2=P-16
>   8: (cd) if r0 s< r2 goto pc+2 11: R0=Pscalar() R1=P-13 R2=Pscalar() R10=fp0
> 
> 	Somehow despite the verifier knows that r0's smin=-16 and smax=0,
> 	and r2's smin=-16 and smax=-16, it does determine that
                                typo here  ^ 
                                          not
> 	[-16, 0] s< -16 is always false.
> 
>   11: (61) r1 = *(u32 *)(r1 +0)
>   R1 invalid mem access 'scalar'
> 
> Felt like this is something obvious, but I just couldn't see where the
> problem lies.
...

