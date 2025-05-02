Return-Path: <bpf+bounces-57239-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95A2AA76CB
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 18:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88DA7986F79
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 16:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB772609CE;
	Fri,  2 May 2025 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="A/cmgzMJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB3525F98B
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746202230; cv=none; b=fOkCWN47jz0sPnu0t2SrnZStdT7Dk5GYjxFNUIUHz1xj8OGT/5pEJ9mNXz1tT+cg9flftZ5bAzL+pKSajiVl+8Knge4LYc+Y9KRuzqo8W84gZEXrNaz0zElMgnVAgjkukc3iWB55wNVOCPcmyZhwskO/TCtv5DyYQ6gymujkIdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746202230; c=relaxed/simple;
	bh=STzdz//9G0dhNLiISy2sFQP89uqRGd0K01sEhFygNOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2L83KheUgd9WxFA89d9Z7gg96iuvMhCjG1QhHYzzZ1x486rzuyhscIHnFcgohmd2+7chxAP5VS80Q5xlpfFbN1VR14M0coU6OcAfwsQJNCy67EahuN+wjzS4LU2fKYUQVFE3bRD7dwjaqJP1kUZpg/NEhAUWFUTL5VzzTGEk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=A/cmgzMJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-227e29b6c55so3977985ad.1
        for <bpf@vger.kernel.org>; Fri, 02 May 2025 09:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1746202228; x=1746807028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NPigxL25T4qIBNGnTF7GwUQLswGW01oEgqaPa7QHo8=;
        b=A/cmgzMJOsA30uhsoKqxozIIuqHp/h/Y3fsVn1nYZQT9HHEwEhvzNpdpHPhdL3jBl4
         35+GvHmIJ9aLB88apjXmX+hqAQGUIy8+22+few2IMr0Sp+qyH14agiV0lPa81PW4aEpT
         hwZKNVs8ozggKm/irOMgDWTaKN7FFVnNlRMU/ptXda+ZDywi34NA7zUZdswHZogFWS1F
         yCsF9koy7THmeMMzRNEsl5SkCVyV1xsocOTfsvGOaolad4qZIML1THrkoEHIoYpqCDL6
         0SMEIMUG1gMenmY6m5WLEHr0ZGpOMlKHdASXkxaf3aKPLVA5mnqj5Qpme5WhlybBZyQE
         aNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746202228; x=1746807028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NPigxL25T4qIBNGnTF7GwUQLswGW01oEgqaPa7QHo8=;
        b=VntvCyQtqZjPW2rMnwoyIspurrMRfrYZwKhOm/MocDbLCowV2lL2eYM6Huo+O2Nbwc
         Krz17Qbo/v9SeZjgL6uVf8zNMhXFKQ0Sl/p4wXU7ubJ6vFPV/PW0DRYpi3d3JynDDEBO
         HwhLZydu6hUmy/iYHB43sl6EF2EOYTFIrj0VwnAc18ptaqZGC0HLAczVDZBo7ETCH9+t
         10L4KhJl3DHMM1lra2EzjOjKPPy9ag/nalOZXGk2AOdPdhrVgOhDC9/RNBQwiozFb8P3
         wkCaGUhY0n196pFfhue4TD3VlVf33FDd/ArQYYwnFNPbMP9URlqxEFjkQlteafrQVgMk
         g27Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgwshZS6R82QrQprrZbBnSsTCCHiZPD5ER4mIVp5xhlc2UQFm6THNv0UGOjKZw14smQ2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhxDXece+UBogUnbSx/5Ds+OCsHXktqrbRacGq47yBJy8VAe7Q
	e8L35tBLMlO8GfoOcDBQQ3f+NvmFclK3kBc3cPzV8l5IICPd/0cdZtk25CsXFpo=
X-Gm-Gg: ASbGncuQX1zYS39f9xihsT3D8xyf9Y413GljwiXLOQcjOimQJGRHAoIt2sJrciLo6OY
	QToCsSfcKSevWNkZBMKQg0yyEigHS0SO1+BJfJtK3V64jc9yQ9DL3/n+dmvnWtz2oJsFE175nt1
	9aL+zRyEiPMV4yTMfQOkpFXtnl1euut4cSsF0NEG0lPEFjUP3P96Rf4pApC3uNI3mEqaZA/tJo5
	MO2MXq7ov+yXPZeDi3tlTMZ6TWFxREv+s43pfC17CNB+UKPCha020mRuy8JfhNbhJZUC6heaJ7k
	oob5nIJW3GPnPVAsgx5mh3cSGmA=
X-Google-Smtp-Source: AGHT+IHnLthcyFMTGW20+a70VHCf9+KwUYGvIpkxMpmE/YRgWNmaM9vmqqg0PaVXJdiPh6WURr7Oyg==
X-Received: by 2002:a17:902:f68f:b0:212:48f0:5b6f with SMTP id d9443c01a7336-22e10327483mr18231135ad.9.1746202227961;
        Fri, 02 May 2025 09:10:27 -0700 (PDT)
Received: from t14 ([2001:5a8:4528:b100:7676:294c:90a5:2828])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e152291eesm9284455ad.192.2025.05.02.09.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:10:27 -0700 (PDT)
Date: Fri, 2 May 2025 09:10:24 -0700
From: Jordan Rife <jordan@jrife.io>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Aditi Ghag <aditi.ghag@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v6 bpf-next 5/7] bpf: udp: Avoid socket skips and repeats
 during iteration
Message-ID: <t4r7dunrdv43bkq56nz4kl4igjstcfzg5kkauygocxbxpzeynb@druey6eb4bco>
References: <20250428180036.369192-1-jordan@jrife.io>
 <20250428180036.369192-6-jordan@jrife.io>
 <44fa2bcd-d35e-44bc-b782-ed1b9a8ba8b9@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44fa2bcd-d35e-44bc-b782-ed1b9a8ba8b9@linux.dev>

> > @@ -3895,6 +3922,8 @@ static int bpf_iter_init_udp(void *priv_data, struct bpf_iter_aux_info *aux)
> >   	if (ret)
> >   		bpf_iter_fini_seq_net(priv_data);
> > +	iter->state.bucket = -1;
> 
> ah. I think this can be moved to patch 3.
> 
> > +
> >   	return ret;
> >   }
> 

Good point, I will move this change there.

Jordan

