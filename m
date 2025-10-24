Return-Path: <bpf+bounces-72130-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 381C5C075CE
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 18:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B2F32353E53
	for <lists+bpf@lfdr.de>; Fri, 24 Oct 2025 16:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBE82D979D;
	Fri, 24 Oct 2025 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FTJ9IHeO"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E26B27F017
	for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 16:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761324160; cv=none; b=mnw5M7zYnadkHHbjnLbVGU9o5N8LRJTpWJsISHqWcPpNNvviBimtXxj2BsEhYTnGakwMS0PEBERuDaWS2xsF4N+OXCS64sFMCt4LLN9DPhersMMP4yfMGG1Tfxzx12DfsBQBrLOMZqAdxKGHH0KZ5FE9dV0bVkZddjktXq8iQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761324160; c=relaxed/simple;
	bh=yXM/YRks1kc3xYPDJ+DL5Ms/ov6faB3xqdY7FQmVqBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYs18BWczZWhX/tCGxo11Dajq4Az4VK0pV+ZF/ujFxTw7pYgHMwt7ZpvmBfAs6xSegc6JtiiTl3ePo9JSY8iaXjSg2WNVf9yQcH8nzKwycfGBXBdmz8PHOfemIpeUVrvHRuVDm1wiiPtOw4H/flwNPSrZjW7gtKA/ZaWDF1hcJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FTJ9IHeO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so1761442f8f.0
        for <bpf@vger.kernel.org>; Fri, 24 Oct 2025 09:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761324156; x=1761928956; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yXM/YRks1kc3xYPDJ+DL5Ms/ov6faB3xqdY7FQmVqBA=;
        b=FTJ9IHeOdrrjFXhEgu/jP19ViNTj0qu4lU3N7INJt65B4WivWHh8m6B15oJX03GQse
         ZVGUJNuXHgmD8+VvRHM9p+WcUvcFRb3HNXJNXzf6MJjF5K1nFsETUpzl3sWBPMGCK70s
         kVEO1uGMT5nGQlTWnaOMKDmamsZeSV6juvBBCTdP7cKeP8ufRvs61/ymJxae+MAZK/dV
         BkGjrSad8pGjYOgrkYl2vND8bMnjSnfXKvnnqeR7ysQceHGJUcHEQdtZrE8qdhDpU20k
         G+PWm9HNwH0AEUW2LI93UTaE+5SfTNGgxSFL7HIc4Db9jKjrfVpEdW55cvKz+VHmV6vu
         dppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761324156; x=1761928956;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yXM/YRks1kc3xYPDJ+DL5Ms/ov6faB3xqdY7FQmVqBA=;
        b=rFcRhk59dFge9tF1JI1374xUMriTs9hMzjD0Ponl0WrNuaZLiDzIV+pa4+kiWwrahr
         eg1dV7zR3L4GKaXYxbWxONaxn4rQGi1Mj7EN/Ul8gAPuoQ9OuefozoVQ/nkUehGS+asT
         8duN4PzIhUQfA5XZzcTS5tm7IZm8gsayHB6kDO9HW7uuU/P+FSIbV684AcZ4+IcpJG5O
         +6nKNr9EYeB+/oxfDr+kwK6ZKAm+8QUAam4f/BpHPg+MRrrB0iQARgdFvL23AbQCZsEh
         8LiI946BODEGS12S2sYyVWeUfeqpJXkLiVZhyTC374vyHr7/oZtpm+C0xfVb4xUIy5rM
         RaeQ==
X-Gm-Message-State: AOJu0Yw5NYwNFflDteyy73DTVcHyRLIYXosrFJCBzhjOASLw0xsvyX/7
	G78JmSeeQzW5Xkb0M9m+rH+PYOnjQPTp7xUko4B2ScJJangsO7TJstmRV9JAaRUW6/kNHwuQge8
	PhV155vkZSC08FaTYi3tVQELvzaafang=
X-Gm-Gg: ASbGnctaD419BZ4zdvPUwT+uBbyZWpWTM5QK58bUE4Hd7N7VMO8uysW6/bxLGUjDaUN
	KFWx1Cv3//Xj8qWllM841R24DBV8QLJBOL0xBLgCKbCUlyPECar8ulu+NkTJfD5ofQEOamo02q9
	sNzr49JgzCkeAPyNmZt/TILuHhvIemPDEw/7eyi11ZaC23aEBsvuKhzc6LUJMDs/DfnIrY4lO9y
	RG4AuC/fVTEASnkkgYNUKhkRVxrPEJAj+H3w9vg72d/x0S+niD7wujnEEE0qYh95mmnCEVV10ig
	68yPsaRmxBWNI2j5zQ==
X-Google-Smtp-Source: AGHT+IH5nqX51vYu1IexzHdkNZ0afoJ1pJcMt9JtXykhaYOJDMZrIHUFWcskwHmjhcu8uYAf0gEL402Nx2zXqhGVX2Q=
X-Received: by 2002:a05:6000:26d2:b0:429:8a81:3f4d with SMTP id
 ffacd0b85a97d-4299075ca93mr2745229f8f.63.1761324156212; Fri, 24 Oct 2025
 09:42:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251024071257.3956031-1-song@kernel.org>
In-Reply-To: <20251024071257.3956031-1-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 24 Oct 2025 09:42:24 -0700
X-Gm-Features: AWmQ_bmjZ0ZCnr-m8vmqb1yEUfyIazFF0Pj2kGjJ8zWuivBt4mpAdBnhmJLj6R4
Message-ID: <CAADnVQ+fJZAHKBz6aVRBLjMyxbF2wZusEfD+AihN+9RWvrBwtg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/3] Fix ftrace for livepatch + BPF fexit programs
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, live-patching@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:13=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> livepatch and BPF trampoline are two special users of ftrace. livepatch
> uses ftrace with IPMODIFY flag and BPF trampoline uses ftrace direct
> functions. When livepatch and BPF trampoline with fexit programs attach t=
o
> the same kernel function, BPF trampoline needs to call into the patched
> version of the kernel function.

This sounds serious. Pls target bpf tree in respin after addressing
the comments.

pw-bot: cr

