Return-Path: <bpf+bounces-32593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D37910571
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 15:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70060287EC2
	for <lists+bpf@lfdr.de>; Thu, 20 Jun 2024 13:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D0B1AE082;
	Thu, 20 Jun 2024 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtR4B2rg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1591AD9E6
	for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 13:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888684; cv=none; b=ieBrPJzgNFvuAinjD3PM2OeW3Ofp/3DfmEkJHH0Tz6R5R0Zy5xnb8oPnw5MXOfsO6EJ+n3+APTTcP7W46HZxvMYFvmP1hnuU/Wbg8sOk8aKlFT5ZBse6DTZmBcicXq4IzigbCn3jfgQE0JO6zjBRzm0Kmd5g6HSoQJtAzhL9/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888684; c=relaxed/simple;
	bh=jTBkYVvflE78iVlF7JPjOoPCZAhFsmDgtmuoFkGJqks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MWX8MMDfp1KUfgcK3pJT0Jc+Z7OW8Ckhen4ljtLaHp4dgZW7RCk9VSmux/1ewHJTfHW13nXeNBh0su0nUMUCMyxOhDhB56rVWnxQLyak0t7ubZAiL+O2sUYPP8aSfVDjGa+ZRbqb+qBWukgZSdkj7hgt2oAaAXXXgjs+7XLh+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtR4B2rg; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-705bf368037so779833b3a.0
        for <bpf@vger.kernel.org>; Thu, 20 Jun 2024 06:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718888682; x=1719493482; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jTBkYVvflE78iVlF7JPjOoPCZAhFsmDgtmuoFkGJqks=;
        b=DtR4B2rgO9/3zieYOMI1wL/6I26Gx5jR3hvhooy9U7RYNyJ+gf4AG/N4O1uXbVMqFz
         lcXrwhsMD7QAQxfYG8PTV/CiWsvxXVXwUkSj7jd3u+m8/QFQOGh3Cvynx7j6HHOpNrQI
         1yqizxWDZKJh3MryvBMZLOl4Mwj56pHv+RSr96J/zXlKl/yhi5tC9N0i8ju2lyKlBcxk
         ueTgjDVYzIMl5QKIL0xAHl+VQjiDF30PVIlC/jMqEdWgc7oA1ceSMmCp4z9mbJ+tSDiW
         l6rEaLl3i9qEOu0FUxovHXCPTOBV9xjDGCOWew1cKcOI68+42lmqDTafFVKbMd9I8ZwE
         +QEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718888682; x=1719493482;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jTBkYVvflE78iVlF7JPjOoPCZAhFsmDgtmuoFkGJqks=;
        b=GGn5a5SoQhAgD2twO5WZVTjNEibZsq/jfNNp9b+SnkrUldRpEnvDEoxR3l5ILActXx
         SVkCx8/bl0X+JmUnDJbqkY34c90jTevF469/0/pXrOgrwh7si7HzcGtJ5qA+4wPRVd8O
         HEKI6M6k5AlZjh5RhVWjB5VOdnlJRqDKj2eefVglPJcljAAvw+8n3Mou5kaaQ6d7hjSA
         ZsYocuQxaeUoeD8Alad7pYUcWKCmwOX51rq/sJGFk2UcQcBdI3fuJY/ltV5HBsbG10eK
         zMlrsC2iLj8GNG/vNhnqnqZqC113P2Q+04zISdzaFsFN0I4/4w2WzGWocV31EaEsnFyj
         oUCg==
X-Forwarded-Encrypted: i=1; AJvYcCXnUXbTsTTLwS3m25KqjcKrw2Th0/DqkuF/VsByGJAthVtwgt7qtO2kN3HgOkyPS84G7UY1XWdA7TmDmWhYqetx3X1l
X-Gm-Message-State: AOJu0YwsuzCoTdaN5zhhHvlUKSIUYbT9A8nQ4FEK3yr/LQR/GBLSqQRS
	5qBcovgxR/+BOhci+YzvdctrZxA0wC94i7StPeOPmrkyphCvhaM9
X-Google-Smtp-Source: AGHT+IHLIFrLJ5N25poxkffoQvZyzRG0WKqW+fKJozXY+21VTMJVbflmizQOfywupLsZEET6wW87+g==
X-Received: by 2002:a05:6a00:4d07:b0:703:ecde:fbff with SMTP id d2e1a72fcca58-70629c1f61dmr4219523b3a.3.1718888682203;
        Thu, 20 Jun 2024 06:04:42 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705cc96aee8sm12291527b3a.73.2024.06.20.06.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 06:04:41 -0700 (PDT)
Message-ID: <280f9311c9fc2be36fd4ca63b3bb27bca71ad202.camel@gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Fix may_goto with negative offset.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com, zacecob@protonmail.com, kernel-team@fb.com
Date: Thu, 20 Jun 2024 06:04:36 -0700
In-Reply-To: <20240619235355.85031-1-alexei.starovoitov@gmail.com>
References: <20240619235355.85031-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-19 at 16:53 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> Zac's syzbot crafted a bpf prog that exposed two bugs in may_goto.
> The 1st bug is the way may_goto is patched. When offset is negative
> it should be patched differently.
> The 2nd bug is in the verifier:
> when current state may_goto_depth is equal to visited state may_goto_dept=
h
> it means there is an actual infinite loop. It's not correct to prune
> exploration of the program at this point.
> Note, that this check doesn't limit the program to only one may_goto insn=
,
> since 2nd and any further may_goto will increment may_goto_depth only
> in the queued state pushed for future exploration. The current state
> will have may_goto_depth =3D=3D 0 regardless of number of may_goto insns
> and the verifier has to explore the program until bpf_exit.
>=20
> Reported-by: Zac Ecob <zacecob@protonmail.com>
> Closes: https://lore.kernel.org/bpf/CAADnVQL-15aNp04-cyHRn47Yv61NXfYyhopy=
ZtUyxNojUZUXpA@mail.gmail.com/
> Fixes: 011832b97b31 ("bpf: Introduce may_goto instruction")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Took me a while to figure out why we don't need this for iterators.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

