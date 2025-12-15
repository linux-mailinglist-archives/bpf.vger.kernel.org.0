Return-Path: <bpf+bounces-76623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C11BBCBF485
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 18:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8E0C30146D0
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D0DE2E5D32;
	Mon, 15 Dec 2025 17:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbVecw4j"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5313C3F2
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 17:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765820760; cv=none; b=eOHhfQHGeE4sTkPDfJuosK+BdPj+p6mXr1bj7qxYBXwUUGkkdqCJ0SYSbjuIsCA8iTDz/vMPM6/t1GBguSP0R+ryyT6vd8lxx15xmE4ydeECG66h0FbHvEV8+0KtpcYoN48KdIpWGtmpq74WkLKIfCKPlQnAYp4onXbxv9YNLp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765820760; c=relaxed/simple;
	bh=aYrTt9D8MKq+zjjyW0pVCKBpgOeDzFVAhdtV7GIBWxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BASrpxN/R83ArpHf7mWxrk/xm3/xzHPh2nwuaVwX/QQK6Mh4JsXQTXspHXA3ahTFcKnF4azlH/U4IqZLcgpmy2B1JKnQ/6vcXuyfIt36NNbxiHqXXzYEdRHOGQBqyyCnkvg/5HH5bUBS6hAwio8Ejbf3baqA+zVHm2oZnF7pqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbVecw4j; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-34ca40c1213so690800a91.0
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 09:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765820758; x=1766425558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B8gAlOJLXsZJ6S8BYRXwAkXE7FMVUf7e3keU7azU8fg=;
        b=nbVecw4jf7m2ycZSAB48mj+E1aNwnwnkyWemYVGI5adJ3pW+xRh5nlFTadKLKLF5CD
         JUbi0027akMnnBIuAmb0KH5gIRqcKTa4kSSU50FN+knL4X8iEiRS8EqdzjN4mI+7KsoG
         0S6TyBAAdQqY0BuukbVgX/5MLrt2rkRJbwqhzAm7lpSrCDlpUTbS1diYp0WtUjCMz9sR
         uouKg71q21g70VsXqVtxDKX3/CLrEwPlO/WJnD+FSBzPa1dqRqrvSihjY8S8YOWdONG+
         IXz4b1VdqrZNlILxYenesdk60QnlDTEgqnAy8PVYicff272tSZCtEt0QD+YpLDRqlLzk
         XI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765820758; x=1766425558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B8gAlOJLXsZJ6S8BYRXwAkXE7FMVUf7e3keU7azU8fg=;
        b=PA91u8NhNY0jBH9N5YJF7c5QzzRkVWuN0IeKFTyv2JCIqxjjTW8PpEpKJ64AoWIDhs
         AokuhjtXMMXJ0Sfok2pIsf90UYZnYZp0mYOsHfdWYxQbVXv2U0AWy+VZ7d3T9wjVHioP
         HgEAl2ZSBSAkYEeoXQj1Cr9wSOdkEqCn+GwBmFC7TSJf1eP+g+mW2pY3bl5kYJ9MGQ8s
         UAylfhjeMoQ/60rSkZtUHqoz0uY8W2LvRRok8vYcXlYuw4mde51r/tIgOk4FfR2TZMwn
         uRZM93/TO/u9TLwiMXdDAM09E0UKdsOZ1+8tGudcMocX4jZycCa6dY5DwOQWQBwzd3Bf
         KCtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9AKQ1H6rEErBz4og2bJwL3Ye/rHJl6bOeWwVbdaOLZZ2dYi6Pk7N3zjX5F7cI0ZvY7dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYnwd7bB7ZC+HABaPvkpLypkbr218zkZ/RNuzZCZq3CZvnWjtg
	10zHaSyZ1WgRlxJaBrHS/qGDl5QcFf0/plJXO38mQuPIbGAmbLtvZ3R+
X-Gm-Gg: AY/fxX5r+Bv2FdwQYXyuNMkM/wrR4GaeXQO65NCBgZCQ4ptZw/QX2rpkxjme+xI18Pp
	I62QLyyplTS42MiyWOU84z9KshVR/gN8FFggii8Sm10JH2MuSVOQ/8pQ1u8J8wdfB9MaSBKWhSa
	Rm3exixEdTeZj0//B5Z+bkry2gdG1zg8G/kOz58SWlu+PNH1gcAdswRpmJnwdi471v5f+/kFnxc
	0hEk4hZ9j1TW6gQSK3j5v/m4xrEMLKnyQc/g2dNfmZaOB34IforVYvqUwjBBdrk2ZUW3lmwediO
	Q23qqZ7+sdCcFxkPOZIKhxFDEYwpWNdqeM6w4cs2sYlwAxD/aW6sfEAUlD8vPM1dpncJvPQKPdX
	cl7/maqBukT18eafmrYelTKmu5K7NVtwnNyp3YXzorG5cIJveFy85gDLfR/250KIHN1N71ZGpVd
	JiFH2fNeJ2uZvHB1SPPLgpudy2sk0PzktzWZkKk1YvLVjKd8IhGIhnFfwNRDkxRPpuFGrusWwaL
	WXQjqU=
X-Google-Smtp-Source: AGHT+IFmt3L3m0vzaclxKT/EjpoHTKVzh/8Nr2SELf/F1FfzF8lXdwvt3LIRhMP3R/xg30Kdhr/n1g==
X-Received: by 2002:a17:90b:3949:b0:32e:a10b:ce33 with SMTP id 98e67ed59e1d1-34abe478148mr9761921a91.21.1765820757864;
        Mon, 15 Dec 2025 09:45:57 -0800 (PST)
Received: from kailas.hsd1.or.comcast.net ([2601:1c2:982:6040:274f:618c:1657:f235])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe200077sm9623156a91.3.2025.12.15.09.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 09:45:57 -0800 (PST)
From: Ryan Foster <foster.ryan.r@gmail.com>
To: bboscaccy@linux.microsoft.com
Cc: James.Bottomley@HansenPartnership.com,
	akpm@linux-foundation.org,
	bpf@vger.kernel.org,
	corbet@lwn.net,
	dhowells@redhat.com,
	gnoack@google.com,
	jmorris@namei.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux@treblig.org,
	mic@digikod.net,
	paul@paul-moore.com,
	serge@hallyn.com,
	Ryan <foster.ryan.r@gmail.com>
Subject: Re: [RFC 00/11] Reintroduce Hornet LSM
Date: Mon, 15 Dec 2025 09:45:50 -0800
Message-ID: <20251215174550.19519-1-foster.ryan.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
References: <20251211021257.1208712-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ryan <foster.ryan.r@gmail.com>

Hi all,

I want to confirm I understand the current semantics, and specific issues this series is addressing.  

In the signed BPF two step flow, the LSM makes decisions using what is known at the time of run hooks.  At load time, the only clear fact is "the loader is signed".  However, if we really want integrity for "the final program that will execute after relocation, and any inputs as part of the contract, matches what was signed".  The fact exists after loader runs, so the kernel could end up allowing and auditing based on the signed loader, even though it cannot yet truthfully say the runnable payload has been verified.

If this is the right understanding, perhaps we could consider a design that moves enforcement to the moment the program becomes effective. E.g.  Load can create a program object, but it is inert by default.  The kernel should only allow attach or link creation if the kernel has already recorded a verified record of the final relocated instruction stream plus referenced state for inputs, is included in the "integrity contract".  

If the referenced state is mutable, then either state must be frozen before the contract is verified, or any mutation must invalidate verified and force re-verification and a new policy decision. Otherwise the state is susceptible to TOCTOU issues.

Is this the semantic goal Hornet is aiming for, and is attach or link creation the intended enforcement point for the "cannot become effective until verified" rule, instead of trying to make a load time hook represent final payload verification? 

Thanks,
Ryan

