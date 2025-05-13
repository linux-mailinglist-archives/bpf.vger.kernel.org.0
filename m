Return-Path: <bpf+bounces-58126-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D21CAB5962
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 18:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A86741B60B72
	for <lists+bpf@lfdr.de>; Tue, 13 May 2025 16:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690AE2BEC3F;
	Tue, 13 May 2025 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZiK1IRO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB852BE7D0;
	Tue, 13 May 2025 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747152524; cv=none; b=IyRzkfNHgWEYH2Z02CDQh9KI0/Z6zxjR3d1IoG1o6DXQLKWiMCQXC7vNGLX7VZU+sRnhYf+YyHudD0PWoQ/M7twabuTNureN2HW3D9H/Um2wZ04MHDqpsq/6bwLA31AfQuU0Vm0VhB4suf0Pfqj1ArbkaK46B1/NmGyctN4HIV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747152524; c=relaxed/simple;
	bh=DevxbzaJdGN4aEHsLK3sy+B/hj7f8G4W1VdIOq0UMi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GA1ToDugrO7CLTkyEENOWDjxyW0clkGHKFA8+bIKsaZwb2zF3BvjETz/RQPHmN003+g4Uaj1qO1VYOx3ovEjE0hmuw150tC4VarH/p1mtggFPsMIjToyaOMFdWkpVYGSDRCgPT2f5TWvhvR5XG52eAH7UGlV5JJVmVLydSPatrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZiK1IRO; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-30c5478017dso3608572a91.2;
        Tue, 13 May 2025 09:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747152522; x=1747757322; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y50vnImwC+LxpdUfSXW6OdKZgsUczIq8Ez5/V5gG6c0=;
        b=mZiK1IROSr/Cq+Wn3tBFvWBIJf+5mAdkNhzY7oTewIpzMTLTwNvTVDvb6Q3cOAt4Dm
         9+lY5oyC/1WXCbOZWUi/isImOdVG4xuOeQ9qx5UoWbERKtM6E/xRZ4k+VotRfGG16zEZ
         SQCGXtffvkT9o4sJ87WqgjVdVVEIFEWuiJAhia4hdBUkteoQoi/UcJM3sFkv/wLlxDRx
         HbK9rcyMalDVu00NKZ0SEOF2MRzHhQ2UURvrCf1AZ7KJhg/ZJ1TUKE9yp6YgvrxBs2Bi
         66JEZEgtSyzLsjdHX2aG7K0ANWBEiMybkmm8DGPgUiUAnx7VKlouAO2c7I/58fHqMHnm
         ueog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747152522; x=1747757322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y50vnImwC+LxpdUfSXW6OdKZgsUczIq8Ez5/V5gG6c0=;
        b=Ecb/1zb8GuHxnnmu94/zeQUywX2Su8oQCE0kYYnqdohA+kvCIKodB2UYRGK0k9xg+o
         WUWceLLRa91ZY3ATfBAwhIes+CcUiVSIf/H30J840bkGWe1+BoqJgQIpYJBfP6+vgpvD
         /QF+JtsE9Q0p7Rk6mR8NzAhv37jQUQIihz8shJjI3MFbJSv5WjLx8gF1hskl5F6yZ0nQ
         iObpC7PPfyj7Czc8V2khxVM/MQmb1h6U0gVsPB3KCKevNTeJOr8N8O8p6/gDqm6GGwiD
         x/2UzQPfVz/J857PZa20RBdnk86bs9kRiTiLLpzmiWbHsrXFlX8IRU3V4rWr4NU6vv7h
         7uNA==
X-Forwarded-Encrypted: i=1; AJvYcCUN7KSE/0hha+KnKF6W01PeCyS5tEu35YVTW64nvsChrRlsKUnG9clCFrdEr2mNT4RQqTt8JX8Gz2gl/g==@vger.kernel.org, AJvYcCURTzRK2Utw8KlOtbiN4T/npJW/CzVlC00oNMi8Cnj7vi3y5YVt/Q6YiuTMQPMU7HdbPeA=@vger.kernel.org, AJvYcCW1A5nHA+JhInlvKLwFCZgXvlN/KOsprLHaN3ZU9VedlSZ2E8UrbJfrPayhaG3Iv4JfTueYgyeM@vger.kernel.org, AJvYcCWaYoXP3/zm9ShLPyqQsTHzqrsaE8+HSEbWo53zxHroScVMdru3GA1xmuYlaq7Y60lFtAbM5XMCRNS3e1Ka@vger.kernel.org
X-Gm-Message-State: AOJu0YyX+d4ZfGytKxoTHKSCeFpaz715z9vOFQ7bkvxfJp8E3aze/Pi4
	nU+xfwETEoUGGCs2uI4VW+7jGN7ku7DIgmO2pdo32a/Q+g4yD8Vg7+Q5wyePXW3BstgAiYA+yHP
	26Ou836Ndf8daD0baUtWpCoWkC6DkKNMXXVQ=
X-Gm-Gg: ASbGnct7mSkGrwvDpdtS8QbVIsplzy3rY0YmzqlFUXIGSIJaz/UN6rjiGTEB9vN7s1P
	BOG3sQ1EslUTo6AW/9ioI1vxr8AgbZ/3QM/KtmJellCDDmKXFgOd8H3uMbNWOxh4Mdajt3VTMWm
	nc6MrgJqld3eMT7NXw1qsdRp7hM99mNIsBqtlXlUPx46wsAnXi
X-Google-Smtp-Source: AGHT+IGbymYnp+gH17n9X9N0PwR1T+xJNDOc/dcNR1jYpXmTu6RMYWMzXJRBYe0vfvuNdoIKoP4r+OVCOMkpgA7xsjk=
X-Received: by 2002:a17:90b:4a:b0:2ff:7b28:a51a with SMTP id
 98e67ed59e1d1-30e2e5d1acbmr234752a91.17.1747152522395; Tue, 13 May 2025
 09:08:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512184935.03464094@canb.auug.org.au>
In-Reply-To: <20250512184935.03464094@canb.auug.org.au>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 May 2025 09:08:29 -0700
X-Gm-Features: AX0GCFsrUtW7GLAQddVYSfJKgmTr6qJto8K9tjjBMIu_QrjzdpvtvV997lT4IPE
Message-ID: <CAEf4BzaavLFXysuKrr6EJwKuGh6US+gprd71Mv1WraphpgGYaA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the bpf-next tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 1:49=E2=80=AFAM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> After merging the bpf-next tree, today's linux-next build (htmldocs)
> produced this warning:
>
> Documentation/bpf/bpf_iterators.rst:55: WARNING: Bullet list ends without=
 a blank line; unexpected unindent. [docutils]
>
> Introduced by commit
>
>   7220eabff8cb ("bpf, docs: document open-coded BPF iterators")

Thanks for the heads up! This was fixed by Khaled in [0].

  [0] https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/comm=
it/?id=3D79af71c5fe44f3973c666bab3e9e5845812d3b8b

>
> --
> Cheers,
> Stephen Rothwell

