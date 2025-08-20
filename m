Return-Path: <bpf+bounces-66105-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1833EB2E5B5
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 21:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C712EAA13BB
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 19:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594FB284B33;
	Wed, 20 Aug 2025 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9QaIsjD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E9284881
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755718670; cv=none; b=i797U2grpLf7vgr3jYpzW2+EYzCKLwbtw1gJ7xVJGRPef5ElQvLPV2tb7hwQHnireliA8Oz6yvh9FOWEprCI5kKzf7yRDuw83bXnul/u+jBuk1pbGgslivZUbghMWEetaGXFMnCakm995AKzcd72+L6syx7D/uvV1wgnvcReNzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755718670; c=relaxed/simple;
	bh=BUM2rK0xOxORB1dKeU1g6C2tjv6DCOl/j122K9iH2r4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BgO4P46Cn/Cv+IbMjXIqVV7fqzqrHLNSj8iS9wOksvl4IOlgrutxvjsjmukEU2RZGHhjoXJMMFkNk+6GUhIjG+uGGCRAE+91Yta0xASGS5vA0aL1IGsTcfXevMYi6Dlaz5LYNS4qDCyXHPshKn9PXwmYvsghwXQKpiph/Dee3Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9QaIsjD; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76e34c4ce54so294887b3a.0
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 12:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755718669; x=1756323469; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BUM2rK0xOxORB1dKeU1g6C2tjv6DCOl/j122K9iH2r4=;
        b=W9QaIsjD4iGafrqIXtqDDTanyA6Fo0XXSBXkGmcFwo37UF73vYus5bUbNIUvT4hBUp
         kEalFd+hO0ncDnbL4I4h+Oa9pwBCO+V0z0LtsDVDTRBW1Rkhj5ud1a8nHWXgBLd1w1Fy
         EuRgIzg4mbCgaYH9EOk/LBZfkC39Nc2mlQGYbCzPPUFn+GlNy+Jlv3l/35iTnwht05AE
         doPH6rxwHhnUWEt5pBU6QR6SHXNPnCNAHLpgUHIdfYsTYMFXuCJ3HlhKYkyjjNpP7SSC
         +Ms5oGdYIJfJfORisSgHYINhPk7nx+NjlOEhELHhu4lTCkhT9tsRL9wb0PSlOODod2Kj
         /wng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755718669; x=1756323469;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BUM2rK0xOxORB1dKeU1g6C2tjv6DCOl/j122K9iH2r4=;
        b=IYg0fOiUhdQSrsYUlki/5xd2Ejv6sLxoqx8ShUn5kEGiLCRka6H5amOUYQrwS96uvU
         M/tl7ZD0McalfS5DsjgxQPpwifK2kzLD9egMAPhZXRWWIeS7zeImayhcYoUDqp3ShBsd
         GTqU35m6zyIslmEdb66p3+y0/12VMh2vcIUQ9MIn5T7+qnYIhajk6bhl+rknVyh0n9hB
         iTWwDx89VkcVMaJ9NeHlTLNVueB1ETkOE4bTzEvqHC5zbcBvuPNeweU2UuuLRAHH42v6
         yCKdRLoknXx47ghj8I3eKcPc2ZlSmzxaaE4NZGi1E6syuyUUPG+bheNRm/je8yi4N6TM
         lLVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUpjW9LrWwVU/6bNcIqpoFyiUh20AHyr47C1nND+JDXGtJkoruxWXxmtlFJizzSNLVXn2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWKMg2vxmNCE5R7OAExuD1CqEuLEM6lckhskXuRBhjQIjsewxj
	DpBgRpgBeVqE/A6v+5mb1MXNhtOncjDnd0TopXxCh9QTHkAh2EjbFAMrKa1S/BqN
X-Gm-Gg: ASbGnctfUWm+SVG8vL0meOPRK2+Ia/uLW5XIQHP5KKhx1QomQbAivxeremQu66J9bCT
	jFvUnxJ5cATj/1TEuvAJi+x0N/7QgKnVsNdQqQvXlrekVwv/LDCDljYcFIER90aWxAQmCqByl3/
	0blDzHGTfzMRMGJK/OyFoOPi/kqeu7B/yATIRYnegmXR3bKGjzQQk4ehymnrPWzc7GhcY8RAHCT
	xWdnBaldPD51iUQCyud3DDm0PXi1u862jybjrSxjhZbzDPXw+Mxp/ZJ20XHD3mVuuyk5XASDb9M
	uXn/7jJvrDwDaXK8ug1lpTzHP0Y0nzHt8g0Kt2M8VrUxf7lORbyBXfp4Iv+4+5XKnvDu/jl0UB1
	/9iDUley+395lseQ6e6Ry42BHV7ad
X-Google-Smtp-Source: AGHT+IEgcqxQXp0DtQiZzjrKj3RNca/SxPqPpD87Z2MPAvBr195OBZlxFJVCjwkb4fbbV7O+pyP/Ew==
X-Received: by 2002:a05:6a00:188c:b0:76e:7aba:cb44 with SMTP id d2e1a72fcca58-76ea0091dfbmr989496b3a.16.1755718668546;
        Wed, 20 Aug 2025 12:37:48 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::8c7? ([2620:10d:c090:600::1:f668])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4fa74asm5959100b3a.56.2025.08.20.12.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 12:37:48 -0700 (PDT)
Message-ID: <6d172613960339eff4b3a9261ef61a2c50f69dae.camel@gmail.com>
Subject: Re: [syzbot ci] Re: bpf: Use tnums for JEQ/JNE is_branch_taken logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, syzbot ci
	 <syzbot+ci59254af1cb47328a@syzkaller.appspotmail.com>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	shung-hsi.yu@suse.com, yonghong.song@linux.dev,
 syzbot@lists.linux.dev, 	syzkaller-bugs@googlegroups.com
Date: Wed, 20 Aug 2025 12:37:46 -0700
In-Reply-To: <aKWytdZ8mRegBE0H@mail.gmail.com>
References: 
	<ba9baf9f73d51d9bce9ef13778bd39408d67db79.1755098817.git.paul.chaignon@gmail.com>
	 <689eeec8.050a0220.e29e5.000f.GAE@google.com>
	 <aKWytdZ8mRegBE0H@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-08-20 at 13:34 +0200, Paul Chaignon wrote:

[...]

> I have a patch to potentially fix this, but I'm still testing it and
> would prefer to send it separately as it doesn't really relate to my
> current patchset.

I'd like to bring this point again: this is a cat-and-mouse game.
is_scalar_branch_taken() and regs_refine_cond_op() are essentially
same operation and should be treated as such: produce register states
for both branches and prune those that result in an impossible state.
There is nothing wrong with this logically and we haven't got a single
real bug from the invariant violations check if I remember correctly.

Comparing the two functions, it looks like tricky cases are BPF_JE/JNE
and BPF_JSET/JSET|BPF_X. However, given that regs_refine_cond_op() is
called for a false branch with opcode reversed it looks like there is
no issues with these cases.

I'll give this a try.

[...]

