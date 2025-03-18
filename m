Return-Path: <bpf+bounces-54283-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF60A66EA6
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 09:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D8397ABA3C
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 08:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 064E71F8758;
	Tue, 18 Mar 2025 08:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzhzZ6vs"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B3946F
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287350; cv=none; b=QV+KS4+T76W5nuMbMnBkoDFjBDyv/PcPeIK1vbfqSwEXjIxEmYjfNJuwL/n2jDX07yzlTUuMiwtXw9xGdGPbl54mWJ0wpbRPINne+v5nSPB+hNTtxLubRtr+wDk2Yqvod0N6/zaAeRSyMYOZsVFrhxk4TyeOdQ/VddFkZQKIpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287350; c=relaxed/simple;
	bh=ItI8ZxLJfUZ05BJCakPQRRPtMO8OcjwuFiRZBPHPWno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMImV4fJMcnkTlTUL41LZ0R3rFZRtyLPjhF7ydMAt0AMG0cWYeB7SaxcVKU4xT3htvwm4Q7G5ry4EcSw2lOReso6nEReMg46ND5drItVz7BwbGzsTkmFqWFYNgim/9wa16YXpoI6iLcSH5AigNsSqJ/51y/91c23GodyibO5fRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GzhzZ6vs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742287347;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ItI8ZxLJfUZ05BJCakPQRRPtMO8OcjwuFiRZBPHPWno=;
	b=GzhzZ6vsAStmVEA5QM7IJn1YXTkCVg3yCB1vz1C2fjGy7Wg5lCb8Ik0YnzblhgIVPGsnrK
	OUlNIy1SpyDOEyqE5S7ylZ9C1LWAOKMXuAYE3JXSapANGRGxRsqUYEP30ulhk/5Dgjo9AK
	SMujYlozzjEpcxMIFPxpICOjjTsz1z0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-N_XAhHmyPMSxJbDEfezgBg-1; Tue, 18 Mar 2025 04:42:26 -0400
X-MC-Unique: N_XAhHmyPMSxJbDEfezgBg-1
X-Mimecast-MFC-AGG-ID: N_XAhHmyPMSxJbDEfezgBg_1742287345
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so3466028f8f.0
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 01:42:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742287345; x=1742892145;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ItI8ZxLJfUZ05BJCakPQRRPtMO8OcjwuFiRZBPHPWno=;
        b=V6Bt3UU2n4pfuDNi57Hj0+Oaf62SioPvHyAOJqGS+kqF6NugrTeR9lO3CkE+g3+rjW
         4blaZGVGLxTYCOAwLZpp0FBtVWInjqKshrbh+JIMKBT+GC8D/UVL5WlqKeSV5dByhaKr
         wRQdkAiVAKTckE3yeGtJoQeSvC5bkqgf/o3OinNRRpROjKSVW1ql0L4JlKaEHQv4pGrM
         CO49B2E3kqZttE031V+rJ31MjAjQxyFpiXibt3Ilq5rfTPzu52qf6Z85rIK/qr5CZOPY
         hjB+1O0UDi5Ke2hC2FVynXtZJ540eEVQb/NizmFtOQduvRGj4Ogvb0Xe6pK2m+XR2ZdU
         Jrcg==
X-Forwarded-Encrypted: i=1; AJvYcCU7/Zmw4A5laERWMCHkcot2naB3C1pt+zG5oClv4O2VgKYnvFrp2jFbR8OXAeW2BkJBefo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygiv+W+DZ4ytyOLy3V5FJbQRDfQ6vfbEJxCU6bzRgfKe+sQjE6
	OKhNGkecyc4broQfPYL8nxk0cTz6ssYuV1njhO5YN0enGAjD2Q/GrbZHuKKEsGVwutQ5CyfFoKb
	GzHOqppU9Nlnsz7J+bqx5YQEmM2xZX7chCklrKNX7tOVkOLDgXg==
X-Gm-Gg: ASbGncvX4a/xs7kNMD6ZNc1iW+Al4r9Ux7DpWuJJj0xfr+qgxJBPQ/iJB/mDKKCjkOX
	QQJsQoDqT+dcspv9lI/N2+E/AcABGj7YLhCMXDD9X6wKSD77Ys5rHNWKdRYg9kaZd4EHAMFrtcV
	/S2drS/CNqY/NoTjZW4dC5UaL9SUd9Dm+9opf1UaSJX7+WrzD4SFp+9Kqh/is/SWqnMO9hUCp5J
	HpZ6XVIfDXEd7r9BL2/wRWB7hJUx0NqziiNwRgoiY2DteYwZY5HjONunA7aN01mW5P27M0gShE+
	8fD+O0U2Ryb/wW+pAg==
X-Received: by 2002:a05:6000:1fa7:b0:391:47f2:8d90 with SMTP id ffacd0b85a97d-3971d2399f7mr13243001f8f.20.1742287345155;
        Tue, 18 Mar 2025 01:42:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhzzf67mUvz/FcN47bVjgtNi8OCE+41icTw+PdJofM1i+tw0XCUVzzh2OjwceAbkj8Ddci4g==
X-Received: by 2002:a05:6000:1fa7:b0:391:47f2:8d90 with SMTP id ffacd0b85a97d-3971d2399f7mr13242988f8f.20.1742287344846;
        Tue, 18 Mar 2025 01:42:24 -0700 (PDT)
Received: from leonardi-redhat ([151.29.33.62])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395c83b6a32sm17733812f8f.33.2025.03.18.01.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 01:42:24 -0700 (PDT)
Date: Tue, 18 Mar 2025 09:42:22 +0100
From: Luigi Leonardi <leonardi@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] vsock/bpf: Handle EINTR connect() racing against
 sockmap update
Message-ID: <3obwl27u7cmgl254v7wdvy7zm35t6vluh4vn7zrtjbz4dp7vc4@sonxoa3mwdjx>
References: <20250307-vsock-trans-signal-race-v1-1-3aca3f771fbd@rbox.co>
 <a96febaf-1d32-47d4-ad18-ce5d689b7bdb@rbox.co>
 <vhda4sdbp725w7mkhha72u2nt3xpgyv2i4dphdr6lw7745qpuu@7c3lrl4tbomv>
 <032764f5-e462-4f42-bfdc-8e31b25ada27@rbox.co>
 <4pvmvfviu6jnljfigf4u7vjrktn3jub2sdw2c524vopgkjj7od@dmrjmx3pzgyq>
 <90a758f2-e079-4148-8d47-ad2ec9161a13@rbox.co>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <90a758f2-e079-4148-8d47-ad2ec9161a13@rbox.co>

Hi Michal,

On Fri, Mar 14, 2025 at 04:22:20PM +0100, Michal Luczaj wrote:
>Perhaps my wording was unclear: by "wait for you to finish" I've meant
>"wait for you to get your work merged".
>
>Sorry for confusion,
>Michal
>

Don't worry :) feel free to leave comments or test that patch!

Cheers,
Luigi


