Return-Path: <bpf+bounces-50324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7A8A262FD
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 19:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B4737A4196
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 18:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D567C1C5F37;
	Mon,  3 Feb 2025 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVataTR5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107E715383A;
	Mon,  3 Feb 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738608579; cv=none; b=h+UhSOYnB6JL05RnpRyR3TeXIwXCEdxlzxz5zcMhwLjCXsbsRwmT4U2ZHmBaFQgg8dJk+fmMuTTho2e7PNKvNZHq8nBU/iF1cfWv9wFUANEbvzQ1RY9aPrD7qNQUU3QOOSVIvPHrNMve/GWfAd7V3Ju4XPZfFbN1+Kx40wmmhXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738608579; c=relaxed/simple;
	bh=qgGONtHPC/Ty6jUwVsHq7zYhNRjj0Ao6gDdxoXvb+bE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oU1jZ0OLckKKIdlhDWxNN1UNbHgbC8jL9SBqUX/8RShxMp33EL2gkpixecCcjWihZhhLOl3xQFhNwQL5DcsaJ68hUCXTbBFP2Bu2olry9E4wOlHLiyrEvPe9WIGTHDkGiv3xyzd5f/rhbjyCQVIR7wCq9oG7o/ks84NHXxZmStA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVataTR5; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2166651f752so95865035ad.3;
        Mon, 03 Feb 2025 10:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738608577; x=1739213377; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qgGONtHPC/Ty6jUwVsHq7zYhNRjj0Ao6gDdxoXvb+bE=;
        b=FVataTR54D5x+JOMEY5gzzfRskFuLYu9/lt2nrA6CK9xBfQQwm4cVm4z/WM6lqQ7OI
         zc+1WEpOdyJfe3sR/WnAZRDd9Sw/7Xdz1LgU239821IulJiESIrBYfDwPavmb1o72KMK
         Wy0oUOGbTsgf/+N1sdX3ZHlO0hQFswYuJBvbUtdgW/mgdsETI3RDqdnp3HJXD+88vqUN
         oeE5L1VLCXKgjr0/iK+C0spp/dXlWpAzweD99Lqt6J0GGrXOePDQm9QQjutm+rMJsFI3
         iNVAGrjZEyHbZ/6GffHPfugiyh4/OkNy+VRjNajmEoh7LyyLfJDHgsNjquDBYlBIBnbQ
         8Ymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738608577; x=1739213377;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qgGONtHPC/Ty6jUwVsHq7zYhNRjj0Ao6gDdxoXvb+bE=;
        b=OK0TZEenIFz1Gb7pQjS7l6CTIIgx6mxKxIV0ldD1tZqlHJMiFhdX0+uDwmkFBMua76
         znds3I7R4SM4rpFcapWWHJL2eaPj4WDlLH9EDnrjUC+qJbgGOpKiC64r9OC9faEvIEzU
         OXnA2ktNbJupLNJCz0xkV3CbvGJLowSNr35dsKkfIJfk+4wjLEP6NFHek2i+ddcVQ7Or
         O0pV8o+vLnvvhCvus81U2WsbU5vBF0ta9sUu7Jn3TzADoFtJ+DNza4U2eP8RXa718MTv
         I1p8hAHzYyZGAl64GJjzbzhEuqGu8kErMAe2qT3RimP7oa464w3qiJZ/so1D1dKUzNEw
         9NwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkQHSZjJq41orIpmvn+o6tioVwj9PeU+uTe3gMPLYLjYBk2NXek8UpRjonCLaZqwxg6HA=@vger.kernel.org, AJvYcCVyCdEkrtBAbAbIwl6vQyOldf9zxVgJu6J7soW6uqcBTye7+2Uz3im68DBu/B4pPac58E+3kBf6Cg+f2Vqi@vger.kernel.org
X-Gm-Message-State: AOJu0YzhVvOERh9ngXR9MSaxnyNGJWu16Hkyft4ZbwlJ6/ajQCNsbgCs
	yvOqywcXW/IgF8sVxWRl+9E75dNhALb2TJYfqeofdSp3N3YGKaaM
X-Gm-Gg: ASbGncvXsvvQH0cktRdpZ38o/QeL8mbqakAngQ8MSnXSufxGLlpOexgu/neZXJE/XBx
	pe2o25uP6BHDYLWpsEId16K//ZDCKmQYGJVPOMTblVFXLE4Y1CEvrGHD3hYLBJqvniHPMLLDs5w
	B8ugKYJ07t4YDxG1y4ZiHababHU8v6xWtS8eZ1r4//bm04ZZkxLkeKsazwhyA8eUJgwuEISln1e
	djX+zRRDkr3cC9BrVZ7o15eP0HoGtD5zA/iBoeLcagqOKlF3Phib6vIpbqWV5CdJfP78OamI4cD
	Nvmjs6J8LTGN
X-Google-Smtp-Source: AGHT+IEe90exmdsZBFOBpeg803N01nxZF/OlJ6R3+R5xB0+5Q6Qa/ZM33LE8v2QjhqzRwV2bt70cmA==
X-Received: by 2002:a17:903:90d:b0:216:4016:5aea with SMTP id d9443c01a7336-21dd7d7bb8emr371801875ad.29.1738608577230;
        Mon, 03 Feb 2025 10:49:37 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f83bd0ce4dsm11703247a91.27.2025.02.03.10.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 10:49:36 -0800 (PST)
Message-ID: <3f392f10e29f651836bf28e342150a6169e6e0d9.camel@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: verifier: Disambiguate
 get_constant_map_key() errors
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Xu <dxu@dxuuu.xyz>, daniel@iogearbox.net, andrii@kernel.org, 
	ast@kernel.org
Cc: john.fastabend@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, 	jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, 	mhartmay@linux.ibm.com, iii@linux.ibm.com
Date: Mon, 03 Feb 2025 10:49:32 -0800
In-Reply-To: <91d84512b4082e5eb095b31e5536944a3d53f0eb.1738439839.git.dxu@dxuuu.xyz>
References: <cover.1738439839.git.dxu@dxuuu.xyz>
	 <91d84512b4082e5eb095b31e5536944a3d53f0eb.1738439839.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2025-02-01 at 12:58 -0700, Daniel Xu wrote:
> Refactor get_constant_map_key() to disambiguate the constant key
> value from potential error values. In the case that the key is
> negative, it could be confused for an error.
>=20
> It's not currently an issue, as the verifier seems to track s32 spills
> as u32. So even if the program wrongly uses a negative value for an
> arraymap key, the verifier just thinks it's an impossibly high value
> which gets correctly discarded.
>=20
> Refactor anyways to make things cleaner and prevent potential future
> issues.
>=20
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]


