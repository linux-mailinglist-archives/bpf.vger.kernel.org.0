Return-Path: <bpf+bounces-30730-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABF28D1C1E
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 15:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F8C21C231B6
	for <lists+bpf@lfdr.de>; Tue, 28 May 2024 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6922016E89B;
	Tue, 28 May 2024 13:03:57 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C104517E8F0;
	Tue, 28 May 2024 13:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716901437; cv=none; b=pioXJEaxYJS54dbYhHsUQmi+lDz26rZLtxhRmkY6T7vZN7pbrFel+WqGqdKeb6JH9NzVoQ8ZLrc6phLtefisijxIGP5adkF9zrhKeF1iGLXuaNa+Ony91ebGGxnurmANqLCIpG2/BaqqQg+caYlhwGVSZpPrlG2d3EzUVRExrh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716901437; c=relaxed/simple;
	bh=jGiPawFhnCveytE5oBKxLPZgwqkR8QL97W/Ti//959g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KVVXIjR89aus3rXZwZV4FEwPZ/0eDb7GwSC4XRZbUr64KiZdoVeO3dnQpxzt48bO5NwhdExmlIaey8GILhdzQy2pDXErWDwq3n1VOnwsouZeA0QaX9inEzyd4U6ZG20BUI0n70iPdhOktqY5FwFmuR9ym52BVzUHU8CB66B4kLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-df7812c4526so836519276.1;
        Tue, 28 May 2024 06:03:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716901433; x=1717506233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0lSqiBjQcxkHXiQzsly+X7nKXmBLlE2qDF43dcrCRLw=;
        b=EFXjF2Drg8lWxhoWdlMOg123HQN3gKx+WapnVjvCDjqDi027Msm78afPpJv/6EXyEj
         kmdoVCBNYz830KHGbZwP94BvUO7uIirBtHtjxdt4s2N389jNmM2qLvO2wFz0uLyusEIC
         J2qMnt/ylrP5SpAQTYLjgEQxU6PPRJPZc1UCOKizJZmVlwI213VuS5BwLx77Quyaxu1z
         Rw15Tw7SvwC0GdnjEDMENORuDeg9y60I2TfUzu8R2t8WIAsvekalVc9bD8IaVdLSOdd6
         4XFw5Zm8CP+fbAnlkrAJQj4cIeijvq082LQrtGxF1sFfMMGT5Uk/iQNKOcIyxHlRJ+QL
         GWQg==
X-Forwarded-Encrypted: i=1; AJvYcCXUdaP5+UhNuLVpK4yki73k6k3C582kXqxp2Hic2JPHfPEsbfiNjCsTqANFkpO2EU6dIc5RGdaaEbA1CGa4niBkpgySWAMkxn69EHtYLHSz68CCOOWBMAt7/ESGmao1ZZkbafDovBUAv4jwl1mJvsIHJ79Kmguekzk+cYHIdrwQanOaQZZyBzc17Ru39TY/dejTsZ4f7vIDY0r/CpMHRkxMmiWGnA==
X-Gm-Message-State: AOJu0Yy+a2EHP2zinbaQCcEITYVSEOCEinadyc1GrhD+81HjYDBjyty7
	nSYCYcD6VjxZXy07lO1WBt5D4s3fSxcp07J9GYmzN7ERE9IFBauq7boTwu4Z
X-Google-Smtp-Source: AGHT+IE+RfB2qX5DkAkK1Ooo6FHIkG3gvZtT8LETr34SL5JN5btlVmV3qDUPqUzWpJAMjj+YV9erfQ==
X-Received: by 2002:a25:b31d:0:b0:df7:955f:9b99 with SMTP id 3f1490d57ef6-df7955fa50amr6987968276.47.1716901432415;
        Tue, 28 May 2024 06:03:52 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-df774677ff8sm1161309276.11.2024.05.28.06.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 06:03:51 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-df771b45e13so783051276.2;
        Tue, 28 May 2024 06:03:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZvk/s02SV9WLuGPgBVEd9ZuJWbB6eXaVxsPiGIMs69B1jwAo8c21F6aq9Usp6IbLx6+ho7wi8XFteQBbJuohi1btI5PVVrwYY5+UyVwQB+M8mTU+P1sDj0u/YocfVRmDhd4KVKCtSfn1MRkQy24/RytRGdXPow/eQwgAHK+Nl2pG6bbGzOwRM+1DAVqkefZwRT8f8B9s0vKjbBM74IhAUsazf6g==
X-Received: by 2002:a25:874d:0:b0:df7:c087:57a1 with SMTP id
 3f1490d57ef6-df7c0876661mr2996466276.51.1716901431685; Tue, 28 May 2024
 06:03:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404143424.3279752-1-arnd@kernel.org>
In-Reply-To: <20240404143424.3279752-1-arnd@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 May 2024 15:03:40 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWSaQrsx5CtyVQ4A74Qt1FxNitNAUJ+YwoNMpS7xxv2zA@mail.gmail.com>
Message-ID: <CAMuHMdWSaQrsx5CtyVQ4A74Qt1FxNitNAUJ+YwoNMpS7xxv2zA@mail.gmail.com>
Subject: Re: [PATCH] [v5] kallsyms: rework symbol lookup return codes
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Puranjay Mohan <puranjay12@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Kees Cook <keescook@chromium.org>, Zhen Lei <thunder.leizhen@huawei.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

On Thu, Apr 4, 2024 at 4:52=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:
> From: Arnd Bergmann <arnd@arndb.de>
>
> Building with W=3D1 in some configurations produces a false positive
> warning for kallsyms:
>
> kernel/kallsyms.c: In function '__sprint_symbol.isra':
> kernel/kallsyms.c:503:17: error: 'strcpy' source argument is the same as =
destination [-Werror=3Drestrict]
>   503 |                 strcpy(buffer, name);
>       |                 ^~~~~~~~~~~~~~~~~~~~
>
> This originally showed up while building with -O3, but later started
> happening in other configurations as well, depending on inlining
> decisions. The underlying issue is that the local 'name' variable is
> always initialized to the be the same as 'buffer' in the called functions
> that fill the buffer, which gcc notices while inlining, though it could
> see that the address check always skips the copy.
>
> The calling conventions here are rather unusual, as all of the internal
> lookup functions (bpf_address_lookup, ftrace_mod_address_lookup,
> ftrace_func_address_lookup, module_address_lookup and
> kallsyms_lookup_buildid) already use the provided buffer and either retur=
n
> the address of that buffer to indicate success, or NULL for failure,
> but the callers are written to also expect an arbitrary other buffer
> to be returned.
>
> Rework the calling conventions to return the length of the filled buffer
> instead of its address, which is simpler and easier to follow as well
> as avoiding the warning. Leave only the kallsyms_lookup() calling convent=
ions
> unchanged, since that is called from 16 different functions and
> adapting this would be a much bigger change.
>
> Link: https://lore.kernel.org/all/20200107214042.855757-1-arnd@arndb.de/
> Link: https://lore.kernel.org/lkml/20240326130647.7bfb1d92@gandalf.local.=
home/
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v5: fix ftrace_mod_address_lookup return value,
>     rebased on top of 2e114248e086 ("bpf: Replace deprecated strncpy with=
 strscpy")
> v4: fix string length
> v3: use strscpy() instead of strlcpy()
> v2: complete rewrite after the first patch was rejected (in 2020). This
>     is now one of only two warnings that are in the way of enabling
>     -Wextra/-Wrestrict by default.

Aha, commit 06bb7fc0feee32d9 ("kbuild: turn on -Wrestrict by default")
still made v6.10-rc1, without this one...

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks, this fixes

    kernel/kallsyms.c: In function =E2=80=98__sprint_symbol.constprop=E2=80=
=99:
    kernel/kallsyms.c:492:17: warning: =E2=80=98strcpy=E2=80=99 source argu=
ment is the
same as destination [-Werror=3Drestrict]
      492 |                 strcpy(buffer, name);
          |                 ^~~~~~~~~~~~~~~~~~~~

I am seeing with shmobile_defconfig and gcc version 11.4.0 (Ubuntu
11.4.0-1ubuntu1~22.04).

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

