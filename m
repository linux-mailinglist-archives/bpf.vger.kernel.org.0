Return-Path: <bpf+bounces-72498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C196C12FDB
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 06:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 354F035293B
	for <lists+bpf@lfdr.de>; Tue, 28 Oct 2025 05:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027B27877D;
	Tue, 28 Oct 2025 05:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G0ADjVhp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDBC1662E7
	for <bpf@vger.kernel.org>; Tue, 28 Oct 2025 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761630044; cv=none; b=CaX+SYpfPkhFv3WYVyJ/pzSeGT6IBnFEWhvGOk/Ldt1u2b/01bAGiUKB+0Y64uN/UwzDOysVOpaCSwkjfhoePqRlZsFbOBQUHVdhXE+0zjgHINrLiA3UYBUOpvBVvoqX+BZb2z9Yx3Q2FNjhTInyEqVyaLyH3+/VF9VhXE2R4ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761630044; c=relaxed/simple;
	bh=MBBUGXoG1YUz44tfK9dC7obCvP9yR1LjZ/0B16rOeOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwgZaQa4r+buuCSW5nAcEuqo35cTFJQZQi5KXrfToXm1IQKc8FMSbTHvOE1iFqMr+OrzCJ0pvvmxSAh4u1KRE9WJRV/aouSrr9eUl8zbs0IOesnGwjb+JVDefykO9dsejA0Rf/hniK54Dx9rwjcz7r5QgPaHBEjN1MYwNG6DmXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G0ADjVhp; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-586883eb9fbso6859107e87.1
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1761630041; x=1762234841; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3Wy1ynDaI6taIoYDlBwI1sYFOXKyWHxR4eO6K9jXR3Y=;
        b=G0ADjVhpjlx9iSiWvBM95/bfjyD1ej/fFGo9FyRZDI3VYU2X1Y3LBwch6HMhtqRh6L
         Wf58nustjZ8r3mtmWkqcqQTniOzwk9TednnKWVmzKzdtxgbmhQG5scuS5YyafJ6vk4lR
         hWZCFquxGEv/jO3zKr3bkF3rpPLOzlu7g1HBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761630041; x=1762234841;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3Wy1ynDaI6taIoYDlBwI1sYFOXKyWHxR4eO6K9jXR3Y=;
        b=tvoiSVWVKYZPbIuhFXBLAfdA2BwnfG+4px0WjrUqFbtkP3AGgfgKidi6aHNizWIhUG
         4xtQr25XVu9Y52CVP1XV65ws9ssfz5ntZ6SHVGYru8lDGPHAniP2QnQQtp3OuBMJ8v4e
         fONy5AywOrhoB3FL+ZMNVBj/mcUTYdMyIQqLbuwUFyvZcfUiZF9mtXVIe5vkVs5NIVpN
         w84xDtnUYvAdAS4/6N6DcDqt0fMU3o+Yg2akK4nYoP1qpvFhVN8Z1kYYlxjybnShJ5lV
         SEUQpFZcs8SlxiiPBRjRg0qfajYGD9H25Jwtfu0PubhUbA1jVH+3HgdfOsUzNJSHuUiG
         n7KQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSEju0qGgUWFFQH0ScJSmNEfw1mi6GxsYKxJFiyxIsNbmZRXNWf37+mZOlfSvLK43P35Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY/OdEVmJO7ICvGhwuUsHPqZk61HSyzyFmlbUzMyBkayf747cL
	6dnTYsNrmpKMeNUg1m1J6UX4Zh6ffTCtuSn+pNNao4MrjJw4DYyUrFrWmCkpFWQhgZVjHlCnPTH
	DW5zv3r4fEA==
X-Gm-Gg: ASbGncshO2aPq//Fwrd2Dy71CMpe6tKE8H0RKDsqJIhBvLqghs9YQwXvDKg30oz6JVk
	KinlQtKHcpUQ4f8ph3PMdTmC5y8mH7I9qjFjBw9Uw3mNo+9xzMEQpKa7wU1KPPq1JEYl3DlRKxV
	1CY6BXfayJjtpzPkuQdRgAT5iPlRNjYoumRwCPV0u9vpmIGzfzE0JR6TN9g+rCmFZWFurOlO7gt
	ldQRTSrifqNMguwtR27AxepcojRv2C2Ul2K16v8aGS15WJR5dto6Jaj/daCmxE+z+jwEdYuRIm0
	ZgZ36pIZ1uRgTsgABdLxSJGqdnne9Qn8TuvsS9qG2/sDIaYER7Ybyn/J2ELN9JI+FWDePCtqIpp
	pBFgSxLnb+MHLNyBqLinkjP34CfyxS7UeKgyH+q/5ARl+9FNG1YTtG7RFCdc/5iR5CQcysK8bRB
	FZKnxKy8TOrFDBj6yYcSUyDmTpCN6OtiUScIWv7ywjTsMr66sQEkrCjw==
X-Google-Smtp-Source: AGHT+IEFrKuE/TIviRphIyDDaPxkBae6h58aY9riLV8g2iFtTjO65pz7Gk33skC8qOQcDLAPGPNsgA==
X-Received: by 2002:a05:6512:39ca:b0:592:ef1b:da70 with SMTP id 2adb3069b0e04-5930e9d82b7mr974711e87.49.1761630040751;
        Mon, 27 Oct 2025 22:40:40 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f60dfasm2813690e87.61.2025.10.27.22.40.39
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 22:40:39 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3761e5287c9so64942401fa.2
        for <bpf@vger.kernel.org>; Mon, 27 Oct 2025 22:40:39 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpX6BssfQit1iV7deOKLLBxot7kf0+zp0Wz6XjURekgvoPDOG6fKiacHAXotVH4yj2laE=@vger.kernel.org
X-Received: by 2002:a05:6402:5346:20b0:63c:1e15:b9fb with SMTP id
 4fb4d7f45d1cf-63ed84d11b8mr1725392a12.22.1761629565035; Mon, 27 Oct 2025
 22:32:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028004614.393374-1-viro@zeniv.linux.org.uk>
 <20251028004614.393374-32-viro@zeniv.linux.org.uk> <20251028015553.GM2441659@ZenIV>
In-Reply-To: <20251028015553.GM2441659@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Oct 2025 22:32:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whCnWNXcmZAgxfV9p8rKJfjxcceNzaxia41f675+yEdfA@mail.gmail.com>
X-Gm-Features: AWmQ_bkREqIMu_f1B9dwguEOjRWmmtrQM-BuU5ACiXPx-fVfEkz6aAECfx6yPOQ
Message-ID: <CAHk-=whCnWNXcmZAgxfV9p8rKJfjxcceNzaxia41f675+yEdfA@mail.gmail.com>
Subject: Re: [PATCH v2 31/50] convert autofs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, brauner@kernel.org, jack@suse.cz, 
	raven@themaw.net, miklos@szeredi.hu, neil@brown.name, a.hindborg@kernel.org, 
	linux-mm@kvack.org, linux-efi@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	kees@kernel.org, rostedt@goodmis.org, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, paul@paul-moore.com, casey@schaufler-ca.com, 
	linuxppc-dev@lists.ozlabs.org, john.johansen@canonical.com, 
	selinux@vger.kernel.org, borntraeger@linux.ibm.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Oct 2025 at 18:55, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> BTW, is there any reason why autofs_dir_unlink() does not update
> ctime of the parent directory?

An autofs 'rmdir' is really just an expire, isn't it? It doesn't
really change anything in the parent, and a lookup will just reinstate
the directory.

So I'd go the other way, and say that the strange thing is that it
changes mtime...

That said, exactly *because* it changes mtime, I think the real answer
is that none of this matters, and it's probably just an oversight, and
it could easily go either way.

               Linus

