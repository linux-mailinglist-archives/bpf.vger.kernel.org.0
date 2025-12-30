Return-Path: <bpf+bounces-77529-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CCDCEA5DE
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 18:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E92EC301E937
	for <lists+bpf@lfdr.de>; Tue, 30 Dec 2025 17:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FB631A556;
	Tue, 30 Dec 2025 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jn78wesL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBA31CEAC2
	for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767117204; cv=none; b=YQDZQgSaTxbqCKSbOlVaDzxg9RBxV0Xlt0ncukFc6+3nTu7K7Q6rwtw2m3u9mej74q2qxoLERRimckpL4hfwFo/fmXqbWuKL+wz/QY6AuaYepIsQL0FPVzNlrqqn4zpTZdBeFlAVjPnOj2VFMcJSwQHx62Dh1v1DFQnXxDHbEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767117204; c=relaxed/simple;
	bh=xTUe9YD0KWGbZ9h18wpQtntcy8YWx9upNm+V40yXqyc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HrdLclz0stDAe/JFfxyk5KIeMdPZS7i/zfUrOB5J++VSmv7WFhRC3VywiKDpnRPbgL9Keu1CZQcho34eIl5eZyG3ZVzn8XXzU4VvqYjaUCJk3VEQK76hfdxJFhm68fgQhge7hWPXwdQZfxh0UMbN6XVy/9sLNps6EeY8nCXwrBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jn78wesL; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0d0788adaso91265105ad.3
        for <bpf@vger.kernel.org>; Tue, 30 Dec 2025 09:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767117202; x=1767722002; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xTUe9YD0KWGbZ9h18wpQtntcy8YWx9upNm+V40yXqyc=;
        b=Jn78wesLOMIoPDF0EAyBYU+Aoh3uwtlqB5zitDYTylRFob9AKy9KqXzYnjDhzrmWaa
         yTVloHnkxDXTEsyjDwURvNcQwG2x0lAoC7b3EYU/u/MOXHP+m79x6Z85xjQZL/DY6rZf
         ukiOw0YxaZGHRmp+vV9IOzzqUBBoNhREg1NW71PQMX8GX3pYnAM2B4FjHVV5M3ox/CwA
         k3JbUkjZy+43vhC6q3UVWx3HI4ebdZWxnFclZJTe/clUZ0hM+1wczsEBUoskV7yEG8G+
         7IMbKXROIX3J7Kg3gAWrQ7Ck7f2OGeIvxACjmxBglRqmArQq+bE1anHNlfOYC2SLRHYJ
         ZPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767117202; x=1767722002;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTUe9YD0KWGbZ9h18wpQtntcy8YWx9upNm+V40yXqyc=;
        b=hInbCD2c4apwIKLZdgVeIw/8orCJqia1NoDQVkd8OfH56Bsj6MFCygZArboJvyqcye
         0+ANCSyueE94dAzQ1uZMp0mUtp9sBAr61nj31DXTlv1krxXsfVWuicNCKU27Z78lI1Vf
         mNIaqVAa00+/eJb54twUPB1uFLK0xQMY0/91HlN1GGvSlJSiUBfnfezaQXBOjpY0CK5s
         OzFXrKd8uLlZgIsOtp1kTNtvcyctA9Sdxvxyx2gnD2o80hGTj2ZLxZVI/9oC9OJom5iA
         8h8bM090dKZd7u08OCxw+HXSmuhFb4JEJNVRVmdn0I+9LOQcJZgM3KRlsAw34wD2j3QI
         MAyg==
X-Gm-Message-State: AOJu0YzmfA0c8Nr3YTKHWTk9cKOJsWZfP5fz8JRuEboWC6T0I/Ecm2qO
	uRet4ihSA1FMIAPhDzdw4te3Sc3IfiTXO3cmg2diP9yUCeauyWU8nbu4PVCvek/9fHxoJg==
X-Gm-Gg: AY/fxX7QLPY20Z6kcGwIoFqlsIhFylR0BHlWyvFa+CvWszsko64Tv1PpXFyoXCJks/N
	iog7gPsij3HpwD9PKHLrH19CE1Z/WtVYZu+k5HjaasPbJZmQC9nUIDkCTkEAODtMPv93xnPUVdE
	UcgcwdLHE2OoOIW0qWUdtRX2wbREx4oXXTgO+Th0zj8lNlKpUSTZ6PM9NynSrllzNx2hafULDCq
	fkuGTBKyi5UXGQ6xqpzH1fk+WyeCLf3HRlYQFzj4EE26GmaHc+V9yhVLl2zsZ+iW6aJCRDbipRF
	pkYMWVFQ7qbl6HqwToDtyxbF8msX4ZInGRgK4yOpbWdJnoOn/xzn7QgIGNwQljJLNjKpDDFnEcV
	tXt2S0P1EqG1bARUVXinnhTufaKU+vZZC1wD63XA0IL+srZMLljLxG6OCYMHnQn5wNtA1eqw0RZ
	OBwBUR0Ccl
X-Google-Smtp-Source: AGHT+IGQzTtVADPW7QuoEgTF4c6/LLxrDhFtQZdpXk4Df0kv7Ur8BiOoKxgLz5BKTIGGnTHJadYugQ==
X-Received: by 2002:a17:902:e5c2:b0:296:2b7a:90cd with SMTP id d9443c01a7336-2a2f28369e2mr331416625ad.32.1767117201974;
        Tue, 30 Dec 2025 09:53:21 -0800 (PST)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3da7dabsm303555785ad.25.2025.12.30.09.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 09:53:21 -0800 (PST)
Message-ID: <6f1e0708d302c8a4b92b17da54f9bbdb949bf953.camel@gmail.com>
Subject: Re: [PATCH 0/2] bpf: calls to bpf_loop() should have an SCC and
 accumulate backedges
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org
Cc: daniel@iogearbox.net, martin.lau@linux.dev, kernel-team@fb.com, 
	yonghong.song@linux.dev
Date: Tue, 30 Dec 2025 09:53:19 -0800
In-Reply-To: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
References: <20251229-scc-for-callbacks-v1-0-ceadfe679900@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-12-29 at 23:13 -0800, Eduard Zingerman wrote:
> This is a correctness fix for the verification of BPF programs that
> work with callback-calling functions. The problem is the same as the
> issue fixed by series [1] for iterator-based loops: some of the states
> created while processing the callback function body might have
> incomplete read or precision marks.

I did not apply proper bpf-next tag to the patch-set.
Will wait a few days for comments and resend,
so that patchworks can pick this up.

