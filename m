Return-Path: <bpf+bounces-37946-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CB395CC4D
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CC42286B80
	for <lists+bpf@lfdr.de>; Fri, 23 Aug 2024 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7C2185935;
	Fri, 23 Aug 2024 12:27:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3BFA14B95F
	for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724416065; cv=none; b=Tpfnnt/AxEImUDNWXsCrleXRLLx31UUpPe1Va6OVBkgNxUeIUrSAbmxJgj8/01IvImkdH3ICLXJKuhWCS7N9/2/ff8ctktSaDUj5QsLFFr7rAEVRXlADCjuglrNasdR56A77XTj7y9y3Bnq/ojhSqEGuLfMuvFfZCQFKvsJ1JYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724416065; c=relaxed/simple;
	bh=+anBVflAS+EyUgB5Jx3MX+wjMBLOPPIN30HjrYZlQQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxjkwblr+sgUPuaNu9abJrZDzKawmLRxCnYPninkEieZzVCJTkay31+ndMfCCVnBBfZoNxvtJPyCEbZV8Ck8w0elYeJ92yit4VSgeXnSWzt8baG+oBXyIykihUVM7fQf6F1UB69IHWUdLIf7wzjNaL5sJ1J7as4J/+gUMlkK1cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37198a6da58so1216415f8f.0
        for <bpf@vger.kernel.org>; Fri, 23 Aug 2024 05:27:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724416062; x=1725020862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chB0owpsq9sw//xNJWYdz6zFuEk/Aq+g4dlEn51eAXw=;
        b=K2/I+CrjEnlpxqcUL7xYAt1LFVXxMZetoBHf9iqLzwzwmWX97NJz4P5tlFBNGu/MJ0
         tlGuNn+b2AMJre+v2X+huMSuZRz9AfhARlRbgAufbfpSdPaByvan3PfyEb3dynVdzbDl
         WQDBk2e/jLM/JojzcYo8p+uBDAg1w1jK9rxluBXijsmOS7ydinw2F1xNl8ckCuotRbf2
         i0heYw/V0F8QLhpaaWZEtAJ7QHaVpgPAL5H6F9YeAG7o3dESV6RKwFIBqeXoWvO8GnOM
         tcvZm0vxMjr+cmA16z6LqG+Dej/XBOPBhwAJxt3mh3ktDm7EQe/74WveKEurG4nfLxf2
         uudA==
X-Forwarded-Encrypted: i=1; AJvYcCVhxHYKV8Zm9fXeseSarg1g9vsP3DMIBCaH3q0qsLjGAdcr2WxvuEDs7ViRmcJkg7cnIPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKrD7AryRazGZnUj0jN6+MR8EmMLXDzOM3MFqmmVdbkw3Rus9K
	aXjNRN8VMQ48pZZ11E0Z0KsTmPeaNVoP/tKgZXaHbquwqS3nnrCU
X-Google-Smtp-Source: AGHT+IHD/mLAKuT6+CfBULZBaZlC+8OP3mSyrKx4a/waomvFnjAzxpKIrs/yiFa9J5nDdWwzwINAQA==
X-Received: by 2002:adf:f001:0:b0:371:7c68:7cd7 with SMTP id ffacd0b85a97d-373118e33d2mr1555448f8f.56.1724416061467;
        Fri, 23 Aug 2024 05:27:41 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f2b0765sm252877666b.75.2024.08.23.05.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 05:27:40 -0700 (PDT)
Date: Fri, 23 Aug 2024 05:27:38 -0700
From: Breno Leitao <leitao@debian.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kafai@fb.com, bpf@vger.kernel.org,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: Re: [PATCH bpf-next] netkit: Disable netpoll support
Message-ID: <ZsiAOkE47+WSx/az@gmail.com>
References: <eab2d69ba2f4c260aef62e4ff0d803e9f60c2c5d.1724414250.git.daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab2d69ba2f4c260aef62e4ff0d803e9f60c2c5d.1724414250.git.daniel@iogearbox.net>

On Fri, Aug 23, 2024 at 02:00:53PM +0200, Daniel Borkmann wrote:
> Follow-up to 45160cebd6ac ("net: veth: Disable netpoll support") to
> also disable netpoll for netkit interfaces. Same conditions apply
> here as well.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Breno Leitao <leitao@debian.org>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>

Reviewed-by: Breno Leitao <leitao@debian.org>

