Return-Path: <bpf+bounces-70244-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9EFBB5705
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 23:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7EE5192664A
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 21:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202481A76BB;
	Thu,  2 Oct 2025 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKkH+OOC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C8F1863E
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 21:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759439278; cv=none; b=gnxqQeX2rsheBQaC4fKvjHjEYGAueo9WFDZji/QUJQdwj1/W5KUCeF+JGp7Rz+/BQXTpWdCf8WkgD5Dn9qpdE2ZZuqT1gGsJjRmHipR40HMJiOxID/m5yqPIhP1wp0TwM6vlJraQPfabDuYirguGeEVvBRJS2rgQlCH2U2UQLLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759439278; c=relaxed/simple;
	bh=Ww6ML/qXXU301+95LJHlinUqETFTayveSb1j0BrRUOs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X3RQWpbZCgbgSriwATv36V4vCI+ZP1Zg4sk8dTcO7A7bz1TfqW3S+1hr6YJCcHZnMKDprP5geh0cWUJ4uN68I3GjFS76qvoNa6mfHIL00sHPoWBb1/X6OSRmmhvnuT3i+QxAy6XhJnryMFCOEJRxPLj2vdo7ljyQyj8bUIiZX+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKkH+OOC; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b5516ee0b0bso1090917a12.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 14:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759439276; x=1760044076; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww6ML/qXXU301+95LJHlinUqETFTayveSb1j0BrRUOs=;
        b=BKkH+OOCbskCSWA6nRNGRegIs4irxyIA1rCc8Fqhyi6kBNUM3gQe/kYEFeUxZAhCKP
         n8poyOisifHXs/GvpWB+ZUvopNJOTlzzGkpK+wTU2PcBgMPIXhl8LkX15/QvzrUPZBwe
         m7Y/5vGWm54vj4tmQf7PpClYhW+viU+j1N6bIK3zdcwyZ69U3ybvj3z5cQXxr/FMO+mR
         JA4Z4UMmqaylkBnSgKbskOCEq9hc0DW7oqpUXQ02V1pJwE3qeuSjkvjgo+q262jHB5ml
         UHTexvZ4knTfcqt0d/06axT2IhYxQqKhNcFvStKQCs1b6i6QKdHQT9n6y6HtANJ+ZCMI
         2bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759439276; x=1760044076;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ww6ML/qXXU301+95LJHlinUqETFTayveSb1j0BrRUOs=;
        b=NEK2CqKgqlji4rLDT998WXn7ovEQyeQWGRv8E7VT2SUZBKTTtnUPNmfedRyg2be40M
         lNlOOfCPGRSdEo/3OJEFxFxiIWS+FWKQ5iR6n0HWcSJ4hoEwjEAqt0X2sjsgWW7b+/UH
         AmDUbk1cQfufXkq6PoveqoQ6RhuisOvkC6K5BUGlMB7y76kV30xuwc84vJrUacHIrTwR
         chHdzAah7O6rRjg36W8wKJp2ctUcIlHs2dHnImvA4SNU6Jleto08uOKoXRZKt/RZhZc6
         h2lDUj6QlT1nXUnyUOpWzMarcwjmXQJYCqtvgGMeRGCh0oJqVb2o5ctXR2F/s8M+PPbt
         veRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwpsjCRX3+ET63KexYrXWWIpHS2f2dWTRN90HOPBG87du4W0YSoBLZIBoSkhZ30X5x+2k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW9rUJo2QpCpy63Q17808ZDXW76BdIAWnMjbHHt4w7vgKrhVj9
	9o/dW0n5IBAJV/R2/ec1lHsl3/O8RV3YXO2B6AAoPayippIfilBHo3t0
X-Gm-Gg: ASbGncucsMuVo2/9E5c/Bdrw5Gc36/YXVxQw2evZMfQ09Cc0JxBrbQUtAn7Kv8pQx98
	w5hM7Mf/f1rpPhvE6iwEwzV87KNsQvLG2PcqbO6gPullRFmu5PnH1VrTsWgV1LZMa/U8w9w6/hX
	Zu9+AmzftwEhRlUiIA/thC4vpbnuHYSeiCA95v0OexwmQp4fr9jo/QtrD56BS0N453xXONIx31J
	LHebBZjNryBAUGyty0x5VqLKC4z8LHxJrXq0JI0eXMqmfsiAUCQ15ONclo3YgraU6f1Obq2nxhn
	VBtaQUHEywizqBD0ofCxXwTWxt9ppXKadB2KDclM6kgFueR5ApgirdrqbmJXaEC/7qwv3I2EjDp
	LRLraGH8n+EqJZgVljcD1wPXaGeLZVR4ti0HvdzJIp5rV
X-Google-Smtp-Source: AGHT+IF9/4ASN4Cgltpg+tUAfUCOlBCij+rkLdEHlHEPujQvNRT+0atY3hIRU5QebEw84FpP/V2hsA==
X-Received: by 2002:a17:903:3c70:b0:269:ae5a:e32b with SMTP id d9443c01a7336-28e9a5668e1mr7783735ad.13.1759439276528;
        Thu, 02 Oct 2025 14:07:56 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339b4f3cf33sm3288102a91.15.2025.10.02.14.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:07:56 -0700 (PDT)
Message-ID: <193001218286e9b833d44e3ecc2f7e3cee0b4011.camel@gmail.com>
Subject: Re: [PATCH v5 bpf-next 15/15] selftests/bpf: add selftests for
 indirect jumps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Anton Protopopov <a.s.protopopov@gmail.com>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Anton
 Protopopov <aspsk@isovalent.com>,  Daniel Borkmann <daniel@iogearbox.net>,
 Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Date: Thu, 02 Oct 2025 14:07:53 -0700
In-Reply-To: <20250930125111.1269861-16-a.s.protopopov@gmail.com>
References: <20250930125111.1269861-1-a.s.protopopov@gmail.com>
	 <20250930125111.1269861-16-a.s.protopopov@gmail.com>
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
> Add selftests for indirect jumps. All the indirect jumps are
> generated from C switch statements, so, if compiled by a compiler
> which doesn't support indirect jumps, then should pass as well.
>=20
> Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
> ---

Could you please add proper unit tests in the next revision?
The way I commented in v3:
https://lore.kernel.org/bpf/8f529733004eed937b92cc7afab25a6f288b29aa.camel@=
gmail.com/

[...]

