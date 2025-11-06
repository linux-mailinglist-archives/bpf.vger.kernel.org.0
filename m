Return-Path: <bpf+bounces-73874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB70C3CA87
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7717135259D
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 16:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AEE33CEBD;
	Thu,  6 Nov 2025 16:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntUFrd7m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD5826E6E1
	for <bpf@vger.kernel.org>; Thu,  6 Nov 2025 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762448341; cv=none; b=Ukf538aobzAJofjkkLJckI/WZl/9aWJLnRY3qNX/H66Ujh1iz+kAud6olGT0qISqDHYUBxFL+hPzGXQTiH8KJTTFV7qqmewWE0f0PNNxeHVVGOr+9WaesPKsNPQx9jtaJBrraqIjqq0NkRyxbY8LXcC4uewmcUjHmHAYfYPpEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762448341; c=relaxed/simple;
	bh=xqqgssZ4oWteTyyLuvBKoFZSAaLAnMVLLgm1B4hykyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZjRyepvrxPy6FXOjh7vHp0g3UkAue5sJdey4AtRLP3E7471nXwzvRIjozpUxep3kKgYtUKMmbCUHRKh9D7p2IeKlsIFTBso73j+GCjuuaKIMQDJn+A5s0lpbipTe2Ka/UnW/qLBnHe+0UkMVVuq2NBxTqw75V/aQXHSOOKVwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ntUFrd7m; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-4298b49f103so507213f8f.2
        for <bpf@vger.kernel.org>; Thu, 06 Nov 2025 08:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762448338; x=1763053138; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T1ykEgnEQMa67i2dn4lX8qtHALq32RtmFj5ElokQYKM=;
        b=ntUFrd7m5PFqw5WIhK4Qzhr/Y0z5+lqQ0Z6SyUlkKQLSxg4VJUxk8N85g3/s+v4kyb
         CKqS9MeFi2QWKnxD8VOZmytE+bwRJrv9YS5v1GHmh3L4/iP/iv7uCIsO31auCr3GHpeZ
         DiER9CuPf4rLUlmlKkN25eDUYORAvrjfbdE/T6JbpleRHAV20n9YTyUwAGbTzP6Ys/mo
         hEDhixAkUnGUnkB+Su4hHbb+pmACBteSCRan7Vk5wgdJ1MjZNgQSlALHYJlRAF3OUmXR
         tlgXB7HDT2GrQU+22fm9Z5t3ymeKaqu6zDggyUoT7brrHVRBqKotwC4zN94ildWmP6vP
         uQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762448338; x=1763053138;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T1ykEgnEQMa67i2dn4lX8qtHALq32RtmFj5ElokQYKM=;
        b=U45oTncMVDbRGN4UFMs/Q6lIEJugFdwkPsYYCm1/9AKBhqSbBbxMw13YpszDhSvXCS
         iGzHmu3qIrh/e3iSYme0gk74jBL/5GZUkSupPgan1vFfm/a1iRmxtBAeofhOQ5oyK5eP
         BNLDHis6Lcba0j9r7JYA/ifQ884MtWLhIYmSuSmzg7ItiPS5Rm9NwlSjeBkDn0NcdOf8
         wXw5ulVsfvi0npVpvfS15CrKMjzLdahaSWta8LhDMbAJsDOgOBG7vBoLu0x4GjWuNDU8
         9nqHGT2iXmzcmRlL+NbyRbL/+vPGqaDXpGooYRzbpDd1hpcOWbiX61IZdobb5sz4lYPM
         nOXg==
X-Gm-Message-State: AOJu0YyivRtfBZOcU/aokzNR7Ghisj4miESHnyIf7Vyr/77KlzsoLNo+
	oaF6xauQmP9zVHo/ZgZJ8uvX4gyGt81zH047IK+ctdOJhE82m5yWR9PlNWWQueYXKGia257Ncx7
	MgIQEpJsERknl5vF+F0YWrUsAsoCqzmE=
X-Gm-Gg: ASbGncvj2CiQI477YywZ4a9TM7QHF2jEz6+K/YwqokDDWvlBMFlksZ8SC5j5C6tfRrU
	QMiFpOr4XCLaDeHLwDvGjtvRrbg9yqCXuYHoER8YldZxrDwTeI3cCyyCIRPGQKxiNKRvv3KGhd+
	tMIJ8P+Mglctek7eK3Yu3jYfPqqdiR0pIW2C3nHo11L8k8xf7oQOC/oBaUFFqfO3GbRLPdzeKBN
	een7H/4iWm6A3alEqHGlfYL/eVuANdjIBriJnstYZrZbnvsLrzbz00Vi9HBnpXqF0rTYTL3VSpn
	bmyo0xZm66d4YHM9j0FqoQpyMPtIPhaew3OSbsOPN1HHcvnZuA==
X-Google-Smtp-Source: AGHT+IHsfjs6XbmxDIzAbJMQ922alGN+dX6PD2PCqd4bJxnjbQryi8f66Vro7SUMmN8AgCqde/C+NofOD3DZrcnHYGI=
X-Received: by 2002:a05:6000:200b:b0:429:c774:dc00 with SMTP id
 ffacd0b85a97d-429e330d579mr6837266f8f.52.1762448337805; Thu, 06 Nov 2025
 08:58:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-timer_nolock-v2-0-32698db08bfa@meta.com> <20251105-timer_nolock-v2-3-32698db08bfa@meta.com>
In-Reply-To: <20251105-timer_nolock-v2-3-32698db08bfa@meta.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 6 Nov 2025 17:58:21 +0100
X-Gm-Features: AWmQ_bk8pDeHXWAoqTXNxoyALmclAgsJN2RnfUhbyCWwIUod4Cxj0_Py02xNcc4
Message-ID: <CAP01T77fUJgFxVuPbTqdcQgzNwkZFhMGmYut4R0sB97rVSkp0g@mail.gmail.com>
Subject: Re: [PATCH RFC v2 3/5] bpf: factor out timer deletion helper
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 5 Nov 2025 at 16:59, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Move the timer deletion logic into a dedicated bpf_timer_delete()
> helper so it can be reused by later patches.
>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

>  [...]

