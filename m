Return-Path: <bpf+bounces-45397-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6879D5237
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 19:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879D728160A
	for <lists+bpf@lfdr.de>; Thu, 21 Nov 2024 18:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EA71BC9ED;
	Thu, 21 Nov 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcY1n91+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743221BD4EB
	for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732212012; cv=none; b=Ow3XMeGatM6LJQpUb1qnKyY1msK+W74V6tkOwkpuLwge57s3fjuiEU0txJUYtCOTDRnSQ8MH4OpPxIpo6G3FmGvWZDjWgP9ZTCTbqwtElO1CP9pmDtNv0TsF2vMKMQGZAfl6mCy20ch9nRFZgOiej4nPoHyyA3rhsSLlvHeo2Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732212012; c=relaxed/simple;
	bh=7HR/2BMyKl47Rw1GdnJXddKHZ3SzAucF8BgtUpnG/D4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o+9v+N1mJJl6IBiqaAXSrEr0wHww9DPvzriE27e6m/azrxwMuBtPes7rG6MsAq5QYWQX7Jc7oL5ZsuIxUrQAjJZIKyO9r5Q29+IC/gFTNjd005EinhHjgPq3DgdZcwkPB/Sr9gLPthbdqKaIOXwZfpKk03buTB6B8C9ypkwUJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcY1n91+; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2126408cf52so10146455ad.1
        for <bpf@vger.kernel.org>; Thu, 21 Nov 2024 10:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732212010; x=1732816810; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7HR/2BMyKl47Rw1GdnJXddKHZ3SzAucF8BgtUpnG/D4=;
        b=dcY1n91+I0DrmDtqGE69fQQIsl69Vi0bqT0YIXLQYI3nnkdi2jGvJFqRUO+N5bsTDM
         sfLG2+iyLu91DAEhwfTwiGkFKcn8S4ZxXeMaGO+wbJOgT3dJ+KVVFQSzbUWhd6ZHIAYJ
         G4y+Jm7BFIyWjFKIt6AeqIZrsOzooKHXRkqFp8y7EO6OFxwQ6TC0ck0hz3MNPCZSEJb6
         ct9ASTD5vCNxT8w56Lw2ce3p4MaWHYNUeGXSC2roX2nTsTmRN/JvwPDOyPwM56SchsSA
         ulIJpmEdgc5nyurZIuTmq0GV/XNdwRsk+F+lTRke/UMf/s6jRPbXny3j/5EGAQxaMfnP
         Ehow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732212010; x=1732816810;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HR/2BMyKl47Rw1GdnJXddKHZ3SzAucF8BgtUpnG/D4=;
        b=JxxIAOpv6548ixXmh03aVm9eHmQZF2FG6tt0u1AnxU6DZyflccU9glV3+CSxqTGoeh
         FBKBA8IO5fjCB7bpv1btLXd9iozRwEB2Gp6dTldHS3JRynM/y90cwqG49tY9MxqMc/3C
         Fg15L8gNrq85Q7h6Q7KH9/MUSMq+ordZ2CwV3VeM50ZG5Nrt68lb/75pQR3ckFNK+saQ
         hffmKbraRMY3rZzJgDmluBboSEOC4x7ivYKmceDuPRSAI+BliGS+oPk67lAf/VbaRIj/
         LXZEh386a3eaBVKXvIhSGvPGAxAKpt+o+xb4K5i1OZEx2a1LGvdiSYF7+ecFVjY96X/+
         eAdA==
X-Forwarded-Encrypted: i=1; AJvYcCVHE1ClKbYlQLa2B5sm/6ihJkWyS3zxMklHn7A5NdhElkvy6MHV27eEp3aS+tjit4Xj9xo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDoGEyxEct9+3DkW9t7yItlfx+n4cYC9AlOXnO7V7/O2C8QD9q
	EYUIqRxjCvzHGnD1tDYanzGhM7iM8nLTaeGabxAw+alrV2dN6FNv
X-Gm-Gg: ASbGncu2WxDunhgo2KkZFujYyst1QAr4GVpwRJKiNWmQUPgVfl50Wk/BabQzuHANDsJ
	4cSF5T9MB+rF7e3iNlOCl9Z+VoWRYV0y07e6tEvvUckB6fKofGzZGxIb6tpkvlFDqwbE+qHvg7s
	FLfvvr8lmEpygdSu5f3TA8x7kq+OHQQaqgy6joeD/QF/3z+wmGAp4fOwi7tm2Nw+zisAB+MQXag
	qROq/Lj5OLhX8M+scqWlERecC5drT9YgYayVcBT8GFkz98=
X-Google-Smtp-Source: AGHT+IHO7Ivb1h151r3mOS47Us2sgB9LvIwVwgacDGMs1LvimZHT6G2zCd4hGgnDbdvVLm1EbTcAcg==
X-Received: by 2002:a17:902:db07:b0:212:fa3:f627 with SMTP id d9443c01a7336-2129f22d2ecmr158105ad.16.1732212009343;
        Thu, 21 Nov 2024 10:00:09 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba5a7esm1144745ad.83.2024.11.21.10.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 10:00:08 -0800 (PST)
Message-ID: <deb87ec8b5fef8b9c2be2a5168fa8aba750378e7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/7] bpf: Refactor mark_{dynptr,iter}_read
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: kkd@meta.com, Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@fb.com
Date: Thu, 21 Nov 2024 10:00:03 -0800
In-Reply-To: <20241121005329.408873-5-memxor@gmail.com>
References: <20241121005329.408873-1-memxor@gmail.com>
	 <20241121005329.408873-5-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-20 at 16:53 -0800, Kumar Kartikeya Dwivedi wrote:
> There is possibility of sharing code between mark_dynptr_read and
> mark_iter_read for updating liveness information of their stack slots.
> Consolidate common logic into mark_stack_slot_obj_read function in
> preparation for the next patch which needs the same logic for its own
> stack slots.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>


