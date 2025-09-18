Return-Path: <bpf+bounces-68870-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1517DB87324
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 00:02:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C33A51B258C1
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 22:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D4323BF9E;
	Thu, 18 Sep 2025 22:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4tqyQqV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF71B4231
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 22:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758232944; cv=none; b=EF28UCVxroIuem6xEECshDpXw57Vsbd8DZQrwvU+uNjRl7VKeHgR3l2xR6+sUz3sy6CcSuw5nqYe+aRDvm7kB3gc56yFRdx9UdgourE1BqiHy30TnNOCcHVXcN+FUXWfF7iSZI7tTE2W26tCOvgQlhclJAq3JC9F+gFphPjvQnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758232944; c=relaxed/simple;
	bh=4PaII8mSeBgMRTnGpoizHfOpKpssAr8S3063zE9D4b8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eXFxfUBUZMK367iIcG6vS4wF36yE4uCyJmuKQVoeEnY3DiUM5DxN+XKlTFxh/Hqx5oNtTwHUFpEmlokvMAJGrbZ7ybRVi7xIO6hFS8vecltgfTdRsJNN5hCRLdcAA27qDShZ+S0ngA8Uw546t1jX1EIhPIWf/lRwH//F2iAAcKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4tqyQqV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so900172a12.1
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758232942; x=1758837742; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4PaII8mSeBgMRTnGpoizHfOpKpssAr8S3063zE9D4b8=;
        b=F4tqyQqVUpeVQ/1UdAn5rN/dt9Y4elfmZiikNjnqhrCz7yJX+qTVdk8sRCKWcjrDNZ
         Qg67cxuuuDlf8fUoZlZj+2qz/Dv8Y45FLQ1w8HbJrGLSGdqPvh12TIEC2yUAixjn1srg
         2QoKq/WiT/32Cn7932PO/Z39IyvJjGuWRWBjlnlK5XPeIwG+PxHMKWTGBjfuY/jRkFof
         RctOfJmwMo7f6hK5omX5+acchdi6XekZFhOrD6Tn0l4ZqK1vuGCOsXjhEJYbQVfRvW1X
         ppo1ryc+BouwIPy8I5AgDDk9NgdBPc+5cGqFpg5tK8/HcZqp4VtBAHzyogYQP/srvcRz
         wWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758232942; x=1758837742;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PaII8mSeBgMRTnGpoizHfOpKpssAr8S3063zE9D4b8=;
        b=JlsUgW0NcM2A0CM+Q0EWP7lJrXK4X/+vt+Xq8M6KlaH3mubUflJyFNRcYBlEBJD5fY
         c6HfxAs6MvkiWDdtLb8NRLKngEiBdltKYyW1ERjFxGtJXUX24B7DQo5sYnsaW+bh77x+
         vipQPJenqWI/+Q5k48txMQEtjWPTN9cEWUhQjG9ijH05IsfUN/Qmri2kDE65ZAKkswTU
         p5e527KPfT6A59y1aO2GtouWHco1VNwkK8jcRFmWR+RKzsrwUhYx40Vi2kfTN7EjlMBZ
         UDwJVYePBruPrO4X/WeGpkax939WG1POW/jJnu2xIvzqNDx/v9RE2Su62rnv+O1s5zMD
         Bd5g==
X-Gm-Message-State: AOJu0YzEhG9hUgyl0/Yj6PpZT3woUzSDCxWJ4nSDxvN3nWs4a7bBhymU
	Bahymm/xPWFC39vvQtFvNoOdRAJEF0hAFD5wGyra6bafCj2W8KZgDaMA
X-Gm-Gg: ASbGnct8RcAPzq+WoC0hwiXfGawELE9GRUuQ0NWKnD5g8NgvPzDM1po3Ry1uZVrk5Vb
	1D6PnnKZ+BDqGRhgjRmFYkXFYUruLzJZwPXGM6NJeRPq0ZT82KnBLbW2i/838YvdvcAGMNjBH9/
	/Hdc3kR85KHL264ObKXzHZ29iTV0XlhuEcWlbgd5WXfsIwoGqxDt9vkTh/8IZPKkr2rvzQWhMFM
	r9y6yRLF/hozy/LpL9ilC0Ha0ktlEnPR8bSqF3CREkwzZoAD7peldoZu/i/QHzb6dADC2He1Saa
	AweUBzeaS4l4Avdv5TWSW161vP0/kELAAGiz/OJjC2OtY9X4CAx/PWlzqY+SEI8MS/Y7vCjVLoL
	iRWemr1m4+YChad8lu3e7KQ45qZoENZ7GtyFatg==
X-Google-Smtp-Source: AGHT+IF5kLq2IbuLk77xAMZ+8HgyCyqcM8AK0bB5eVOmnNw2F8IhF6f9YYG5nETbqxh1LICZQvj3sw==
X-Received: by 2002:a17:903:44ce:b0:24c:6125:390a with SMTP id d9443c01a7336-269ba40dd92mr9940325ad.10.1758232941830;
        Thu, 18 Sep 2025 15:02:21 -0700 (PDT)
Received: from [192.168.28.36] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802df852sm35580005ad.87.2025.09.18.15.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:02:21 -0700 (PDT)
Message-ID: <b9fe943a4094458773b5d323acfc7feb6710b7ea.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Enforce RCU protection for
 KF_RCU_PROTECTED
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Andrea Righi <arighi@nvidia.com>, Alexei
 Starovoitov	 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>,
 Tejun Heo	 <tj@kernel.org>, kkd@meta.com, kernel-team@meta.com
Date: Thu, 18 Sep 2025 15:02:18 -0700
In-Reply-To: <CAP01T74K=s=QJDAxZFNY5LNHwEUq2y+vyVWvy34j65cQm_VJ2g@mail.gmail.com>
References: <20250917032755.4068726-1-memxor@gmail.com>
	 <20250917032755.4068726-2-memxor@gmail.com>
	 <412f49fa12de7c7f5d0461b56fd4e0b6882fa0ad.camel@gmail.com>
	 <CAP01T77Nmwq1ZYpk2rJGLmOZezSBFOa0n8zyZn2gdj3UcE7XvA@mail.gmail.com>
	 <fc6c5494b076a70354b5f45f4e108bb109a092df.camel@gmail.com>
	 <CAP01T74K=s=QJDAxZFNY5LNHwEUq2y+vyVWvy34j65cQm_VJ2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 23:59 +0200, Kumar Kartikeya Dwivedi wrote:

[...]

> > The change I suggest does not invalidate this mechanics.
> > The iterator is still marked with MEM_RCU and this mark is converted
> > to PTR_UNTRUSTED when RCU section exits.
> > The check for PTR_UNTRUSTED happens in process_iter_arg() called
> > from check_kfunc_args().
>=20
> Oh, I see. You mean is_iter_valid_reg_init etc. will complain on
> seeing that PTR_UNTRUSTED?
> Hmm, I guess that might work. I can respin or do it as a follow up,
> whatever works best.

Thank you, followup works for me.

[...]

