Return-Path: <bpf+bounces-29431-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF618C1C7B
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 04:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8C1E1F21BEF
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE23013AA59;
	Fri, 10 May 2024 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHtoXYiJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9953308A
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 02:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715308681; cv=none; b=rIQZjXs/3UtkcEg89EdECVRufjOHkkBo+IwhGjOOzh76TgwIttKKo7JtJlLatXfU+3/PICn6VatpqW5IDUPO80c1Set4YQD/yQoQUraHMxCDkSOFbaKZoC0pO8KKBaddUZKlbPoFBJ0M0p2oV/syTZGJym8yCc+8QjVPz4EbEKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715308681; c=relaxed/simple;
	bh=YXw9iFbAtL0hKC/QpJkLnCKyJxztnZXxvSjvfGtVyc0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WJVJuHYH7+N+9RVO+7OOS9HIIsOMbEwVFZe0x3dGR7D0sLisujhLnMG13T9l4Nf5PrsWZaF4TfP9SEERaX1k3npmFtEwI9OibqCkIx3ryey+s+/gqnHGZx+Zt8YhmzZzSmguEB85N+0EHbcu9zlvSBGqqKqmpzXSZTkQq1SfWMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHtoXYiJ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso918548a12.3
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 19:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715308679; x=1715913479; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YXw9iFbAtL0hKC/QpJkLnCKyJxztnZXxvSjvfGtVyc0=;
        b=CHtoXYiJv+CGjcL/OGEYZ6tgkoXZvVPn63RH9yJGaxDhzwLWN4rIkhXwAr3O3y2AoD
         bLL7tTvmD01u5XiFWbmttrFo3prUp5pitgJIIV+6mHwnBSeyJShnqddeQu7xZ/gse/7i
         9EeKvTriD6l5wXkNNHrLsF1a+vJJij7W8QA2RU5LmXmJhd6LxRKfxf7E2eMh4TzZKxpX
         PH+gMHpDq71L4se2OUIfcEVu/TV414/G1v+CTdzCeNQiSS1ziS6JA/eudcrzX9ikqC0H
         DQc6CQE1bWQBUo9+czq84O4nF3CQURVqEsO2Vjfw6Lpd9E5jIqEfTnzE3fP1yv+v2jHE
         8+yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715308679; x=1715913479;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YXw9iFbAtL0hKC/QpJkLnCKyJxztnZXxvSjvfGtVyc0=;
        b=smoDib4gU5BaRxNN5WkXAZHULjoPHyFHnf5kKA7hznBnKbUVK5phPFHGEbo/5kMPSB
         F9nyAyogpSqtXzdM9/aGpr9PuaozSaISTb1tVqCdL1aNjmIp5bVeTqL8C34YCjRyecRi
         y5PvvxPurNoB5DD79XcbSnrooxnXpsPfUSAy+V08b8elJy5040CEIoT7RAD/LqHOFQtg
         Ugk2wG7tVI1ZSDxQNFBwP9UOguLW0qFaNx2Qw3gmcHWV/8E1EPBD9KMVWCCRGaI5MN+l
         R5FJvBA2BbxW0dj/xiYmeCoi28O065oCskA4FnOXqbXSmk1I7e13sVibu+ZBKEjx+o2z
         G5Yw==
X-Forwarded-Encrypted: i=1; AJvYcCUhYQVo2jtkAlbJuFDPuxE0Tmkye4idn8t+6raKHOrjGO6TGfmwIDLCGX1yQwOvao1tuoYGpfr52LIn2k2aj0DGX2/U
X-Gm-Message-State: AOJu0YxHds7iZwPVRA2yzjLUfwugP+7XgdGLbLSICxZZskCDKyxZCebf
	uleHUIygtk8cY3rAJrymLfxClR2VMPUptZCU1us4zDO6NXfutU0+
X-Google-Smtp-Source: AGHT+IFrVudD463zpC5KGvRYfXyky8ar6AS505b/F+lmi/Jw4izSS6BCBHUUgTCjoWVmHXEgRRKYHg==
X-Received: by 2002:a05:6a20:9190:b0:1af:d51a:1ba9 with SMTP id adf61e73a8af0-1afde07ccb1mr2093242637.3.1715308679512;
        Thu, 09 May 2024 19:37:59 -0700 (PDT)
Received: from ?IPv6:2604:3d08:6979:1160::3424? ([2604:3d08:6979:1160::3424])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b62886d069sm4062314a91.25.2024.05.09.19.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 19:37:59 -0700 (PDT)
Message-ID: <f30f9a81798cc108699c2d2f2349d3a42db0d290.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 6/9] bpf: limit the number of levels of a
 nested struct type.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org,
 ast@kernel.org,  martin.lau@linux.dev, song@kernel.org,
 kernel-team@meta.com, andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com
Date: Thu, 09 May 2024 19:37:58 -0700
In-Reply-To: <20240510011312.1488046-7-thinker.li@gmail.com>
References: <20240510011312.1488046-1-thinker.li@gmail.com>
	 <20240510011312.1488046-7-thinker.li@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-05-09 at 18:13 -0700, Kui-Feng Lee wrote:
> Limit the number of levels looking into struct types to avoid running out
> of stack space.
>=20
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

