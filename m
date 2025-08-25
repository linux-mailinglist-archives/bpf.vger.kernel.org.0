Return-Path: <bpf+bounces-66401-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21FBB3464E
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 17:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D73F11A88195
	for <lists+bpf@lfdr.de>; Mon, 25 Aug 2025 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70F32E7F0A;
	Mon, 25 Aug 2025 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/h56Dpj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B719066B
	for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 15:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137104; cv=none; b=rG8R6N+nd2dmfjHjfUFQvxbamjmN7r2KYOobPajgAr1qpuHzV3rBLXvVqMHgxoFoSF7IhX1bYr/TuSwKEFRoHPRUb0aR4AHU+0xTvm10vusNVxOOJ4yd4mFBcg0arzedrrLyGYj+GBF4RinFpxn1K7PyzHyscmnAiN3BuHh74Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137104; c=relaxed/simple;
	bh=pk7MZD8oFChF9fXO47sJ395MTefbYn55n1Rk4YX+qiU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H9kelfdrJcxkqlxRR6caju1jrTarzS0URq720CcvLkXH4FM9l1R4RAojsuGcCjBy0T/5ck0jkdI3P6/SvIjMBy56MlViGgZwh92Iw+O97F2mRmEBoN2nBxIPnPZWWdcO6pDww5LPeOgQvP95yVwUanTjsEQgOe96Dr1bk5SVWGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/h56Dpj; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3258cdb7253so1530644a91.3
        for <bpf@vger.kernel.org>; Mon, 25 Aug 2025 08:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756137102; x=1756741902; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pk7MZD8oFChF9fXO47sJ395MTefbYn55n1Rk4YX+qiU=;
        b=j/h56DpjTsp3TKl7NXhia/KQFGeBVt+Uvjptet1u/Odicunutk7H6e6lujrP7fKbs+
         37FhyhNMSzzlAsmbrRIG0YkhOo9R9Cf0pJfdHIvZpzgJvd04t1KBHRAQwEi93M4viB/m
         VVjD/3IiUMddgf2TNHTjgvyh7WaPJ1aplcRGD76tc7b+3jbT08jOXAyOmzGIaOu5zttC
         uu8Yuv6n1dD2GaKeQJNsNFi3o8hcbNqvYTdWSyBSok5TWSuSliIA7b0Dc/wjfFs4UZxQ
         REVQTKEZc4PneDftYZdA2PuUnnTmAQULJ6Hgdirl+PNFahbN/m8FbgsLz+Enx3jHuG9l
         OPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756137102; x=1756741902;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pk7MZD8oFChF9fXO47sJ395MTefbYn55n1Rk4YX+qiU=;
        b=H6f+SRletmYEOUc38yuN9uvqrFZ+ijFvihzXEAbAjCGuJHZ+t3cZOfCzWUt+S6wpGT
         5NqCaIl6n7hbHgYOQNuDIPf9Z8O9xmb+q+C9euh7j5aiAe3QNgwthM/S1ljPc9JPlF9o
         3kTED/RK7x5OjbElvHmGN2+N92HbCUHuc28Vl8msGAMS9bXs5UguE89AAomQ5NjnMkLC
         TokHZgpb9uarIFikB/6nqHE0pqyFGTfzQ9f4ph2aygHSl9bP0Le+sVvkKafROxsqZFtD
         hprGL+LZ5MoI6TfraJMEfN45b0hqseACwwKyunDlIcLBfrpwjbPvYCSlfatpWWxvkQWi
         c1dA==
X-Gm-Message-State: AOJu0YwWklZd4zgfXefL7N27k7+E6Y8IDqEzKcki3uPVHg3tApMUc0zR
	vuDuYxfx4aF9lvbXOL7thxrPRMZ59r2a9bBrx9nEK7rOReiSws1XwWb7
X-Gm-Gg: ASbGncsivFZBT7N6RURSZgfLCHawbsgqrLHTGSK8GvePM+4opRXHnRYTPFvRm0iuaup
	x/Sa47bazWuO5OykpWufPxD67oiec9VoHWkpHvQxSUaCbY1zbbZ5zwZIc5j//HdW95lnNgC2f6Y
	FkCLjB+TkdONffXa+Ca+dL+s2pojYRITcnsTzhsuLANlWG6IwHyjIuBCSSkbrhKszEmgSTccfBJ
	MCPiI5PY4Xh6dqK+XzQTK4zXoIRNmf5FamPiZDXnpISrrGMMMguazOaF57UC16Sitp+nPZ8JPCn
	mMjVCS8xBx9R8LjFSodvWDfzVwOMXVNkODxyh77mWXbNkQgnVC7nGS5CLLkUro4n4gRyq6FCGSU
	rpn1j2FxW8evqC3yUzlDDFURGszIO
X-Google-Smtp-Source: AGHT+IFxGHaydtrjvsWsf0RyZWCVsQfFMCI4lK2fB7stFAzvlPzc491ID77WqKdXhybeBDCydh6KBg==
X-Received: by 2002:a17:90b:258c:b0:321:2407:3cec with SMTP id 98e67ed59e1d1-32515efa504mr19181382a91.16.1756137102275;
        Mon, 25 Aug 2025 08:51:42 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::247? ([2620:10d:c090:600::1:283a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3254af5f24asm7383435a91.21.2025.08.25.08.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 08:51:41 -0700 (PDT)
Message-ID: <1c293ea48cfb4a0852570517b9daf155a2a3bde4.camel@gmail.com>
Subject: Re: [PATCH v4 bpf-next 1/2] bpf: improve the general precision of
 tnum_mul
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nandakumar Edamana <nandakumar@nandakumar.co.in>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Jakub Sitnicki	 <jakub@cloudflare.com>, Harishankar Vishwanathan	
 <harishankar.vishwanathan@gmail.com>
Date: Mon, 25 Aug 2025 08:51:39 -0700
In-Reply-To: <0ed1ad1d73d2c4468b3a02b3034b7dfd6e693d66.camel@gmail.com>
References: <20250822170821.2053848-1-nandakumar@nandakumar.co.in>
		 <8834d8df16f050ec9e906a850c894b481dfa022c.camel@gmail.com>
		 <116ef3d2-51a5-444c-ad51-126043649226@nandakumar.co.in>
	 <0ed1ad1d73d2c4468b3a02b3034b7dfd6e693d66.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-08-22 at 16:56 -0700, Eduard Zingerman wrote:
> On Sat, 2025-08-23 at 05:18 +0530, Nandakumar Edamana wrote:
>=20
> [...]
>=20
> > I personally don't think `best(a*b, b*a)` is ugly. What about
> > `best(oldprod, newprod)`, where oldprod and newprod are each found
> > like this, using the old tnum_mul and the new tnum_mul respectively?
>=20
> Hm, given that both are correct if we go for a hybrid approach we can
> peek known bits from both.

Thinking it over the weekend, I tend to agree with Harishankar.
Few percent improvement does not merit complications with best part
selection or maintaining two algorithms for multiplication.
I'd stick with the new algorithm as in the current patch.

