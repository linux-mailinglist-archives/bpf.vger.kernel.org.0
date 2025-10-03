Return-Path: <bpf+bounces-70291-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C9B7BB6454
	for <lists+bpf@lfdr.de>; Fri, 03 Oct 2025 11:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25FED19C2F33
	for <lists+bpf@lfdr.de>; Fri,  3 Oct 2025 09:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754127A90A;
	Fri,  3 Oct 2025 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gIEqTe7/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748717A2EA
	for <bpf@vger.kernel.org>; Fri,  3 Oct 2025 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759482031; cv=none; b=Ke/P7T7F8P8FrDojFDk+VGXnkIHK1+M/oaOtHYme+DH8dbXvJpG1Ok3yx1V4gSsZVq/oMsyaEIU5wwzCAnLTEobY8JA4v9LHI6S+MIuBFf/IRPZqQZjelp+CsLp5O5WiQwdcG0GfVA38JhaTFaT9UtmpiS+ZOjZ+YswNoFPUXYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759482031; c=relaxed/simple;
	bh=FMyA/cPXUzSsFCE+4qVZUtrDLz65JJ0Ymx0QC+iBma4=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kblbqzugwBWqe1BVUM9aEvWLlkHt1YMmNlxHy4+/K1AA4xCrzKhvXKfu4oR3Y7/JnLjUX59qrMTPA6vmI9ZTOnYNsEWSok8pkmnaF21wakaTQAuMBZZfhZZh6qU6eqn+eKR7yY2O2ki4ROhOb/uuPKrWWR2Q/0lQTdK8VXFwUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gIEqTe7/; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f5d497692so2802160b3a.1
        for <bpf@vger.kernel.org>; Fri, 03 Oct 2025 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759482027; x=1760086827; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMyA/cPXUzSsFCE+4qVZUtrDLz65JJ0Ymx0QC+iBma4=;
        b=gIEqTe7/Pd+6ic3oTFgMWVz187wTswx10QQkCq8s+haPE0EtmfUXfB+hUmGaFAFort
         KOihGs4Uy+MH+/cqFfFulUXEO/U56XEMKLHJJelOqzsTtHcfQZ9VvJqXxBWA/4lRqyGL
         v687EMFtHANO1oWZP32ahvuydBWZHXH4ZD4TFffXmnT3O+oxt3D4xKLZp2R5n/WSjatD
         e2DRBmGxsTn4pI5OYBEy4hwBTjBxBQhN0E8jfsdOL5iGj7WdnqiXoj26Y/tl/qY8ROgo
         CwH5CERlIsTQcV2uWOVJ/x7JAk0RbKXZnhxbKd3iPiAOfoOiFr2otCeNv3NhvBmNkd5Z
         VnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759482027; x=1760086827;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FMyA/cPXUzSsFCE+4qVZUtrDLz65JJ0Ymx0QC+iBma4=;
        b=JTGCnW0jnuWol60pJDYzQOQNUmDuBLJ3jGT/Jsg032OUOb2KAMfeewCzPtcoKzON1Y
         mVvJPaKJaOp53pOa4e8kEkqUcPkyTsxJwU4Uxz+t2VGbeFEQ4CtIr+BW6NoZKe8+iy00
         2w6UvTVc8Xdu3w5JC6bJoF1VxGgASrm3xX/qY44EPMb3KHmssDns8zP2ARvkHZDXMgtk
         8iC3RnBKDC52ZDzAoTnPmevXZmqcT2lE7tRvhTrz51TzH+qCr5E4etKZadQJ4ZiPibbT
         2lT3p6AgTcBXYZDm0ncU+I1YB31oQp2fM99Upx/gCb42t0aSF76yBlAm5lFYdgRn/e3t
         riyA==
X-Forwarded-Encrypted: i=1; AJvYcCWKTdfucoYBjA6y49FcniEPDkjyhSZU1W1EXJZJR7sVMZRNt/3b+EoXNnBNQ/D+stZWIq8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8QPq8GR1+rvoWVxUlK6FYoNS8PpkYes5zgybLGtH48XmbIacc
	+NcFC5pQzChV1f1jSM19rhCCb3O5CHspQULnGYu+NcF+IUx7diltLjse
X-Gm-Gg: ASbGncuAESqAUEpTNBC7ShDy6+nY4ZJksBBN+IdjC6LkSZQFdZ3Untu3kIUevDygdce
	VkN+RtwLOD6q1ymrGXwuwl7UPtKUX5aGgRNKICNUZGW1BrbREEQn1QOlZ2c3Uaf3fFAer7ridAW
	rs2mHRneFWvy4ZJsrZMjfelCz0p1rPFO13D3EHY9DSQH9Pupf+T72UljFDZlHPs7AXYH6g3ap0c
	XRL43qGos6/SMH6lPpAojhtc1Qk6TAqkhobETTrlJLubp9bSWb8Dze5LUcJUlZe398tfnRZIZB3
	UJSoYVv4X9eFNZhWw5gcZmQoPK5SxWTaFO2N/C56B0+ecTvMhsdWWLYRnM/ngJq0n/J4J/AAuYH
	6wRFwKUvZR3alqMuqjiQb4BaHgC2Ajjk5aVq76Fb4URziiabKyfbWXZA=
X-Google-Smtp-Source: AGHT+IHbrijn4fswDMZvJQv6fFHCqrxrsGOpkDRKt88jYea6Z60ytXF6etQkmpGez/qykS9D0tZtcg==
X-Received: by 2002:a17:90b:4a46:b0:332:906a:85cd with SMTP id 98e67ed59e1d1-339c27878f5mr2931889a91.19.1759482027264;
        Fri, 03 Oct 2025 02:00:27 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6e9d2d4sm7600458a91.2.2025.10.03.02.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 02:00:26 -0700 (PDT)
Message-ID: <09c6e78004ee0a50330bf6117f9115e2be661d37.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 07/15] selftests/bpf: test instructions
 arrays with blinding
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Fri, 03 Oct 2025 02:00:24 -0700
In-Reply-To: <20250930125111.1269861-8-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-8-a.s.protopopov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-09-30 at 12:51 +0000, Anton Protopopov wrote:
> Add a specific test for instructions arrays with blinding enabled.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

