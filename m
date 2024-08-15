Return-Path: <bpf+bounces-37323-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D26AA953D34
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DBAA285AEB
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0038F1547EE;
	Thu, 15 Aug 2024 22:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSZeo2l8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5279F24211
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723760015; cv=none; b=h1F1PAcQyQG1fK8vRwXslureFRHythaqhjPvALWVpSgEwNeEjy/NBAq7HzFoBDk+Aj4/QcObYLLhfWnY6R8TOqqcg+eNzVIp0aZ/koRBELPJ6Zs0o0sajT3s21O4B053v8gTwjORg1awxkHoFNOT27/7hN3gRaN73Wk9+yNUYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723760015; c=relaxed/simple;
	bh=7FESxG7HPIVC4QAHfzsTIjfmgAUtF4SRF50XYJCxTdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GHZA1vNDrZRKo6vVtOyoGHz3w9nB/GVN8pOyClyebdpHK0XZF51Q6Nh7bXHHTpJkm8+dtEN1+v9hi/3GHMT5HZTdxdhuxy6AxPjph2oXeL5OUJ1vmLPLy31bYdZcLtH6LR8CGZg+LVAl1IwyAFPrWqoxFUKuudziZRDUW78wtWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fSZeo2l8; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fc60c3ead4so13418635ad.0
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723760013; x=1724364813; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7FESxG7HPIVC4QAHfzsTIjfmgAUtF4SRF50XYJCxTdQ=;
        b=fSZeo2l8Z09UB2ugFl+fKkceb/z/OugVQKQUEfnqfmnMPh34WZRxGQrfCbDokS+MZB
         pRCjyy4ayiNT/d0M62g2QcYBXZpOP/fs0XFC4cMgfyGkF5fF7maR0uA0KOnGUFzEUR+I
         uqQp85I7IpsZbrkZzF9ZI5igExS2xdVh52KlbJQ3UMvoeuaag/o6KQa/CMCG48AgTFcW
         IcIhKl4Y9L+zmj5Sj3DxztK38AU4zYNeHyWqyE55kJOBc/jFMaHRqpAV7/5OnwX6yZkD
         iAAtwZsA2lwU8SD2w5iHOsIriATTiBLDUeajAd6ZP3ioltBs8U1gxEF8SnNTyEKCYA66
         GSvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723760013; x=1724364813;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7FESxG7HPIVC4QAHfzsTIjfmgAUtF4SRF50XYJCxTdQ=;
        b=AkjAg+jwVGpfztxFEpoNuqd6V9CPgVBs8fAwbn7hLpTC/m0cltM/voVQQva7nSwfXM
         3D4E/MqAVc3Bo/4fwnFNhilUwwJIX2sgz2NuMg+34Y5UtemEubJiAhaY3Ewzif5HGBCy
         684DIOSVwl4Xf0xwhEtpDarEuSKGatqfDsIVr6CgC04dmxHlVhSPe5d9r/rH+UG3ajP5
         20ioWdItxlaHybcEMpKuTedCQYYkZjAn8AAMhJa7AH+elPktf2m5+AM7WYOQRtBrdyy0
         Po4qyIWsJpo44r/PNRu+g6eBQ8L0Q1Ps1JOAURSwfwrGRmcovna2DvbOe1eh7BW+S00a
         ShzA==
X-Gm-Message-State: AOJu0YwEVamD4OAfA828Cg5W/AeC3GqjihyxmHNhPlvRXID+vMWu60rP
	9mRosd9CUxPgQRYYBJEw/5oDQ+5GX60Jx+Dvb38ISyPv11qZ6K/Q
X-Google-Smtp-Source: AGHT+IFrZxYUwQpg839XxwYXNwsM7uQG68DNQJJKsyQX3aXQAZYhzRvGhQCbo6K8QlYnzNPD3U3DXg==
X-Received: by 2002:a17:902:e88f:b0:201:df0b:2b72 with SMTP id d9443c01a7336-20203f4205amr17430245ad.44.1723760013395;
        Thu, 15 Aug 2024 15:13:33 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f02fa50fsm14688815ad.4.2024.08.15.15.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 15:13:32 -0700 (PDT)
Message-ID: <5d726519a30c9e1c8e5e3250ec8d51af988bedea.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 2/4] selftests/bpf: utility function to get
 program disassembly after jit
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  hffilwlqm@gmail.com
Date: Thu, 15 Aug 2024 15:13:28 -0700
In-Reply-To: <CAEf4BzZdf4JRrvm71hTKUii4REpBQRHb=KWsm8ku+8gLdxjbjg@mail.gmail.com>
References: <20240815205449.242556-1-eddyz87@gmail.com>
	 <20240815205449.242556-3-eddyz87@gmail.com>
	 <CAEf4BzZ2Z3P+m+ptHbMMwLhR=KvJZsd-w9z56=hGTCvbTzGhtQ@mail.gmail.com>
	 <5f79465fb172c3a6d8d706ee9adc7ae80437524d.camel@gmail.com>
	 <CAEf4BzZdf4JRrvm71hTKUii4REpBQRHb=KWsm8ku+8gLdxjbjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-08-15 at 15:10 -0700, Andrii Nakryiko wrote:

[...]

> > For the block above the lines are indented using two spaces and four sp=
aces.
> > This is not a rule body, so should not be a problem afaik.
> > What's not working on your side?
> >=20
>=20
> oh, it's just for consistency with the rest of Makefile. We use tabs
> for indentation, so let's stay consistent.

Ok, will change

[...]


