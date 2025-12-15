Return-Path: <bpf+bounces-76628-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A8CBFA98
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 21:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 15770301C3D6
	for <lists+bpf@lfdr.de>; Mon, 15 Dec 2025 20:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829C52BD58C;
	Mon, 15 Dec 2025 20:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms5xzuqq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FEA2749E6
	for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 20:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765829158; cv=none; b=YcxuMG6Aiv+hUq/xbEFP21OdvEAlS3/gfz5Haa9MZt7fHbBdjVMb9ElLmLOYTMWCC5/UWuIAS2mt3EdDH8Wg0tQG9huLoDLlA9nlayaGGGP8RcN/eu/PnrVLhE92k2dWFjf74nsyyGo7vWvm7Mj725WCV5jDEm5bsVRRoGtWp44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765829158; c=relaxed/simple;
	bh=jTZ+GOK1AXHqHxfqhKVaxFzeDljy1eJFATlIdx5pAFI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UzKoa3WvGTWAm4O03bbyEGvb416SkmA8Kn6SuwrRr5AI/2pEbyHgo0A3dS5RCRT8/MTuw1YfKx1/5O+ZYmdYLqlnqVoGvU8fg8/SFF/u1+Vve2XMVjVvhKsO+f/+KvydHAsBGkcIvnxmBv4qAoAxeNx+GnqPNRFU0cofylvvmBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ms5xzuqq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a099233e8dso19558575ad.3
        for <bpf@vger.kernel.org>; Mon, 15 Dec 2025 12:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765829156; x=1766433956; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jTZ+GOK1AXHqHxfqhKVaxFzeDljy1eJFATlIdx5pAFI=;
        b=Ms5xzuqqAue7MQAEDMrjrZdYuT2R8T/bpIWcYOM76AZTs/943t7gufucoCb0hJ3zKk
         i5cb0H0cuZqWBYK1vmloZnhGTqlhphzdhsETc6xnWrD77AT7igXE2pR0WSgU69p7xW+s
         +Kabdvr+bQE02U6gi0NEIymoRlhSL+Ygz+fNTYLLkB36Dk0WhmUAdJtymIHZd0VtQPP5
         JDk6bDasqUhNR8jj3cVLouE/B7gP2lQGUN2KO106sjhXVFjQCOBd5oW7mrvO9dKiUqHH
         g1yH55sZ267Z3nUxgKxoKzG6glNd0kgAdzXv3Vc73xAmfr8AkNazFzHuahBpu8XdbV/s
         CBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765829156; x=1766433956;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jTZ+GOK1AXHqHxfqhKVaxFzeDljy1eJFATlIdx5pAFI=;
        b=drtUDa8POIyIlmdntRmGU+syJ+KEKKJvqJtWiEahHNatvsiTH69FqcHWcKrJfvT9MC
         YMDn6sxd5Kr+byFvG4YvP3zEYtR+FpaZzEgzvox46W1eqvKr20WZOei0bBciH2Us2ttJ
         UyZ0mkAjwAZ9BwvEXBsVI/TGe7LrBOwnBqT62HkfyChBfmNFf+C5I3QhB7EsaCYMZcIX
         ApuYez85eDnSrYZ3CjQGsGtQuvWBRTgmD85yvRKKirq1bLN4m5W8SsSsfdT9WVktWDGm
         eltwrmnOfyG1qV10IG2XGIIcetngXzxRrT5dxKPtaTrsyBG4O2z7bunu67vb5PnrR631
         ntcg==
X-Forwarded-Encrypted: i=1; AJvYcCU/wxxBg69uztYYn2eIOifrnRmpsnzCmCM7Rj095+/Gvh/zZp+ilORqID3SqUPcUNhBpV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHxvYV7GxsEjDP6Q/jDNkwlqwjowOi7HkEsa2/E6FCTfg5lX92
	BWjyNMO0Nw0rfzoWpOvsU45mBg2gp+NHjOTOvlTDl2SFtPIvB3prpZmB
X-Gm-Gg: AY/fxX7xmA9OU7mg1/VY8XXmj/Ur/QO07UMs7tKSvQIv5yawjCkKo9A7zhcKBy60aQc
	hzTz4hfawd3t/aL6UQ/Psfv5eZ5OdhHYhouWOOkcCpX/8f8NqMiG+kYqhvpU9Xxi4xPl/hDPPTN
	AxMM0aUYY48BSmx3SZV43fH75CzFtG2W7S2Zf4h/Y3fGTu82FLfrvuNiR+ylaBNpjNC+pr/ifFM
	PVvqDERCQZlXZeGnXSRMoS8CdVvq1fD7LY0nDkc+bWh56TCWNTi+lBBidqYh9XLUh12ztCWHq8Z
	8qejbNF6+Si9lYl2JeB9ecD98loqDnwH+hgNsLck515jOXJCdzWwSTLkazflQ50NlSMScayPw+m
	UV/EpRgolcrUQyvC4sXsAviEMv1Q9a+ru5OePFWLu/k3S9MjMo5oyG+jJhFL06RlIWD2OJtaBbT
	N/bV/KL0G8
X-Google-Smtp-Source: AGHT+IFv2ADfVa0s54Gq03CyI47pO23WZTYDa5VSrrRXAKim+mVwNkJguN1X8DyYZo+W8czt8hGxmg==
X-Received: by 2002:a17:903:18c:b0:2a0:97d2:a264 with SMTP id d9443c01a7336-2a097d2a4eemr90332945ad.37.1765829155774;
        Mon, 15 Dec 2025 12:05:55 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29ee9d50f9fsm139959095ad.44.2025.12.15.12.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 12:05:55 -0800 (PST)
Message-ID: <048ca46153394d9ef555e7a5303d7ba74f237166.camel@gmail.com>
Subject: Re: [PATCH v3 3/5] libbpf: turn relo_core->sym_off unsigned
From: Eduard Zingerman <eddyz87@gmail.com>
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, memxor@gmail.com, yonghong.song@linux.dev
Date: Mon, 15 Dec 2025 12:05:52 -0800
In-Reply-To: <20251215161313.10120-4-emil@etsalapatis.com>
References: <20251215161313.10120-1-emil@etsalapatis.com>
	 <20251215161313.10120-4-emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-15 at 11:13 -0500, Emil Tsalapatis wrote:
> The symbols' relocation offsets in BPF are stored in an int field,
> but cannot actually be negative. When in the next patch libbpf relocates
> globals to the end of the arena, it is also possible to have valid
> offsets > 2GiB that are used to calculate the final relo offsets.
> Avoid accidentally interpreting large offsets as negative by turning
> the sym_off field unsigned.
>=20
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---

(But agree with the nit from LLM, create_jt_map() should be updated
 for consistency).

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

