Return-Path: <bpf+bounces-74435-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6058FC59BDB
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 20:26:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BE594E7C2B
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 19:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0B6E31B10B;
	Thu, 13 Nov 2025 19:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggaObx1e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7231A7EF
	for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763061700; cv=none; b=Ti43GouDbw/pLRD3GmzDo/f1JP1KLz4Ty4ygzp3dlRyb2LrBT7wdBNYYNE6sCdNlcsa+6RvRxT0uC9Wv4iuZQDV3tFxJk4SKeKrUVgxEuxei4HZNW70yRymabqCUbyObbnXR/2Iq//P0wmYqcDG4+K3wY6mwTaPIIMPUd/XFRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763061700; c=relaxed/simple;
	bh=AYtztYVup5T03MHn4c8xhs3DR93dO970wpen2NEDUfU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OnFotjUkc/FVBQgCkBh1ydmlrStHF1MuE3xRTUZWYDMmBHskg5qVAPru9VzRn2ydcEgVVGPOsCE7Rni09ARtWYZZ/VkUPLRt1ChNJlvQBzcIi3OilxTvnJ+wWadlzKj75MkEn3YtwHhCelQm5Pbv0UgvNcjoQViNm3peQPRD26g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggaObx1e; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so915805b3a.1
        for <bpf@vger.kernel.org>; Thu, 13 Nov 2025 11:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763061697; x=1763666497; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TJ6F75cdyKPn7EP37WUo29NbKa0V6/VXv3lYpIW9bQY=;
        b=ggaObx1e+Dnm3LeQ+DxSUVEucD1A+2f75lQ5Qo6Yjl7CGbcnXvJYMWtAKbi4MFKEsr
         s9pN/uW8tWUWQMNkS486HYxUtjgWDsSAOoJ+bDs4X1S0lsafMXXfVCayQghsjLWJaxxe
         QsVU1nfE8gnKcO18DK95IQ4XxcJz/qOYo+F7g88RX9r7S8ZMzhiYSERMl9k7LskogFq/
         gkO5J3WxfXdCN1lInW+mYL4rt8pj/FZPrnacnGxnCkSPdlhaXRi8BYglZ1TNvNCvQsp8
         D7qw+ghSKRuELPOgM1izSHe0bYSP+9Z3XTiZR8IHSyw4O+NRAM5jlutf+JYZbjWeL8pG
         qt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763061697; x=1763666497;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ6F75cdyKPn7EP37WUo29NbKa0V6/VXv3lYpIW9bQY=;
        b=f4U1QQ/mKYLbqd9p4zopzvktlnXSfkeybTEoTE1zgdHee7ISoAu6M6mgYqzPwTG7Z8
         b1Z9VJZLhSjA24jmKUauf5tnyy6jG7dijYEzp8zQE9r5jFw2X11g2tdabOg8064INIVG
         M6JjNCa0BtZ+w+PZea3EGwGPf2Y14wPCMQNKhSasNQRxaG/3hApouWy5IgsEg0zwJZf1
         oQDz7FxgohqVVVJXNupYX10VfU1eetx6NjMd4UOd6AOmxJ/CwDu0XnzcAdCZ5Ik+xIPj
         MiDcrAFJOCUIYvLBEz230AB3oV3a7sPPAUOUGzYX2VZjt87gM5qxHJzxRTjgU65iuWdS
         H8jg==
X-Forwarded-Encrypted: i=1; AJvYcCWVv1mQD9nyv+0F4QREbRnVBt1AbObVfOXEruB89EgW8WcdbePe2CADItq9hBQv2lh0Ki8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+xZp9CrPt8+gEOel7llITcvpZ69wj5pWezxSm/3BPz0D7H3pa
	xlPgj8JVuztyS2a9+34ewMKmNg87YH3/ui2hetZeQyVpZumVeY7IZHp0
X-Gm-Gg: ASbGncsHAg7gYYGOYJXOIjv3MvQqc391gtj3SxZU4npMlmzmZZg1AKXcXLNN7A2AGJO
	LLv2Xgr5E4kiqCj4plLxznazoPUSN2aKFis7qqAy7VK6pc0jXkh7/WymSwgLmunA9/i8Ehsqfss
	gJcuCW3AieZb94Bu9KLeJ5xJ3AmSrAZSSzIoNUt11zPB6SwVW2g9dOxmdUCac3i9PzlhUDQiLnR
	F701NKAuIugRunI1NtAgs+XVDkbyE7gQ4y87UfIHY2jUsmSXCOvoMWl6aNZBBrUWnntUrQHiZ/V
	QDD9S9jSQPhTbAYIy0qAjezh/mnHL+hLdx0kQs4anNpPhqaYO2dGLVK5z+WH6B4EDjFpBVBVUew
	n/cRcVCYjE/Ea59ijDK4ck5W5YF8f0It0iTUSBw+NEuls6wfFxqhowoKdLShlQd2BX9gxkoqL5v
	VH2mG4S/8I
X-Google-Smtp-Source: AGHT+IErLkIL9gN4gIwgNJG1OhCmBNwlAbpLnKJJ9UX1z6We9W1weijWSJmhBdP/H/gc1C/6rybrkw==
X-Received: by 2002:a05:6a20:9144:b0:341:c255:7148 with SMTP id adf61e73a8af0-35ba1d9c626mr927853637.28.1763061697417;
        Thu, 13 Nov 2025 11:21:37 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc375177be4sm2870160a12.19.2025.11.13.11.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 11:21:37 -0800 (PST)
Message-ID: <b092107702eeb245424e56907ebe9e830ce198d8.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] selftests/bpf: add BTF dedup tests for recursive
 typedef definitions
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Martin Horth <martin.horth@telecom-sudparis.eu>, Ouail Derghal	
 <ouail.derghal@imt-atlantique.fr>, Guilhem Jazeron
 <guilhem.jazeron@inria.fr>,  Ludovic Paillat <ludovic.paillat@inria.fr>,
 Robin Theveniaut <robin.theveniaut@irit.fr>, Tristan d'Audibert	
 <tristan.daudibert@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau	 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song	 <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh	 <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo	 <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,  Paul Houssel
 <paul.houssel@orange.com>
Date: Thu, 13 Nov 2025 11:21:34 -0800
In-Reply-To: <9fac2f744089f6090257d4c881914b79f6cd6c6a.1763037045.git.paul.houssel@orange.com>
References: <cover.1763037045.git.paul.houssel@orange.com>
	 <9fac2f744089f6090257d4c881914b79f6cd6c6a.1763037045.git.paul.houssel@orange.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-11-13 at 13:39 +0100, Paul Houssel wrote:
> Add several ./test_progs tests:
>     1.  btf/dedup:recursive typedef ensures that deduplication no
> 	longer fails on recursive typedefs.
>     2.  btf/dedup:typedef ensures that typedefs are deduplicated correctl=
y
> 	just as they were before this patch.
>=20
> Signed-off-by: Paul Houssel <paul.houssel@orange.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

