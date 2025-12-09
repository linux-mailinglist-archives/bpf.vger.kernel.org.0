Return-Path: <bpf+bounces-76339-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A16CAED13
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 04:33:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61338302177A
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 03:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1EF3009D2;
	Tue,  9 Dec 2025 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LyfNVDpw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD327239E9D
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 03:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765251232; cv=none; b=O7yaa/x1GT0I/w+KCuxMeEqnv/u59y1wLNmM1AUMDEXQDvvh0OLstpafrckHDXu9dK3qiK+RULHJXSdecMc9nDiAK8Nk/rbBemYsW8ZsjgiUPmUN5TSYZNfMA+kKYQM3Mh5LNs7+k/ku7+8xYOds1WmBKzkUmiAAlpkEK/7YRHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765251232; c=relaxed/simple;
	bh=mArw2vAL0D2NHk8zLQ2Ijxxx1bFuIg9r7rH/hnyrq/A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BUFbGtMLryIyLWBmKCd3h2uv8vYxbRWlg+ASLMmhYid2O9Fk1blhFB2A8UpKCWIkyKKeHSN2u/3tzdjjTJ04613uNtf3vGeBXhAtFdztWZ8wMwUbnyxwS0elIQQB4NkHU7r4WaRow5Ia+O8cWSilCfKckCaHfGpvGTWGNNDwEYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LyfNVDpw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6492e7891d2so2339026a12.2
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 19:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765251229; x=1765856029; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ve41G5hMhFJfqXtFvhXu3GnjjOI5g5mevMdggrYlYVI=;
        b=LyfNVDpw8Suzm2RQ6eMIQNP9LJUiem6QKlvIaa5p7naZ9C7nmjnymAhdf9s2uZoRDO
         tlHCV4jbY+giT0xzGNWRhkV0pYKZGNauVzN+JY4NCJXQU2C1XGEbkYnaNeWZJxPz6hy7
         0SX+n/sC7nHlMhbMG4xFcpNghxGzowZ6G/KVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765251229; x=1765856029;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ve41G5hMhFJfqXtFvhXu3GnjjOI5g5mevMdggrYlYVI=;
        b=j8fStu03H/WB36m7HV+jG0ki6gPEymnX7HWMMTYdvfTY9oSebbcUVUtjzTRGyUVsvH
         FezuEpGBk27TeNA8mMtXj3sauNiB7vJKepbamrKivarBBPC3dqLLzoZeant0O4glnCpi
         aM2Hw1DZeXKP8RAN8rxkAHjSP99hiRr6jWMRn5fNc0/6G31YnZbGapSmN/E3oq0H7q0U
         zhZEL19Yr9O8r+fPE1Fwf6hYnbYsfSM+qTvV8N+O/ZBJhkoJXq3Lu9P9FyWtXbV7EL1m
         a0eSDL1nBTHYbPcCxHoNqKVMt0kgohzcoy4pFNknc7VqfdSjP0fZDvNh+n3cmD6MauSF
         SBrA==
X-Forwarded-Encrypted: i=1; AJvYcCXHu0/8QY8mV2esYy9yKTedYaEpVYhGVf6JD7Z4NzlnSHW+hvEWfxh2DbRSpHBCh5VBvp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+xg3pj96aklqxZl+WnF+PqLyVYUoYUX+NPP0l1DPr0GM9oYW
	s8LpBjmiGISv02wDbbmLN0X1qmuXV3qUcKzXufld5Ud7qxm4OgbAk9GM7a3swu9s+nkgsvqPlqZ
	wjLukvwyByw==
X-Gm-Gg: ASbGncv3eprRgiCpEeHAzODSgYZ4ADkdbryxOcQhZMOFKfwGejl0u5AjahorcI9p8ry
	Y2Nxkw5j6DBG5vm9eD36Elqq8cCKM1I6pec6+xewTrgrX0lyxhgemVMKTzVXe0KQajANTehJCql
	EO0CSR8iRpqZpkQ5EmomL2FNASLwCn/CswyJUg8/C0z772V6+u/SvOjLgfpuqwLfeyhqZwufAG9
	ra1dIoJlRLzZV+/pq6TR2LdXnA2RjSc5MNNhxdwaT3Yo3Nz2DMDWcHYhBffO5JBIn33olA1bPhL
	vTHklqAXxmP1slle+/j32ooIJZMM4ahvJfLmw3xdC2CL2+dDFjswf97dh9rvQfd1C9VCKgoRRjf
	7JSrsAT77/6UAgaiiXuQ5bzN5tEongtngU6D/8NHj/Cm8YKjMEzCdc8hNz0uhtnLnWDGt6lfLfv
	wNS9VgGccVlQqyUu/x6NdX1DSwZGdDyVYRVsyfGJ/C3oTVxiRVcIcdmHCCVzrO
X-Google-Smtp-Source: AGHT+IG91Jw2abti1FSaV1dDd91Oq/U87kkjdQmtRl4FadjAO8MwAiJ+95JNjMvW/c5C98FsUZhqQQ==
X-Received: by 2002:a05:6402:34c8:b0:640:c3c4:45f3 with SMTP id 4fb4d7f45d1cf-6491a3dec62mr8680870a12.6.1765251229051;
        Mon, 08 Dec 2025 19:33:49 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2ec3003sm12476204a12.6.2025.12.08.19.33.42
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 19:33:45 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64149f78c0dso7556775a12.3
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 19:33:42 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXyfEfLOQdjjBg4MnxvsiwSZO0daC/oXFSxF7mmGC+uyWaFH9GuhRVOC7bDK4shSFSp5z4=@vger.kernel.org
X-Received: by 2002:a05:6402:d0d:b0:647:5e6c:3220 with SMTP id
 4fb4d7f45d1cf-6491aded554mr6980906a12.21.1765251222388; Mon, 08 Dec 2025
 19:33:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com> <176523908321.3343091.17738363732550848005.pr-tracker-bot@kernel.org>
 <CAHk-=wi0RqQPHME0xgrAZBQijKuos97cQO05N4f176DkH7msbg@mail.gmail.com> <ee693efe-5b7b-4d38-a12c-3cea6681f610@zytor.com>
In-Reply-To: <ee693efe-5b7b-4d38-a12c-3cea6681f610@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 12:33:26 +0900
X-Gmail-Original-Message-ID: <CAHk-=wghm5NFZQcfObuNQHMMsNQ_Of+H7jpoMTZJDrFscxrSCw@mail.gmail.com>
X-Gm-Features: AQt7F2ofRIAXVmCzZb3EAMnphwigz_H3r18InwGDDrhalL1GL85PEFWZ4uBTknk
Message-ID: <CAHk-=wghm5NFZQcfObuNQHMMsNQ_Of+H7jpoMTZJDrFscxrSCw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: pr-tracker-bot@kernel.org, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Dan Williams <dan.j.williams@intel.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Laight <David.Laight@aculab.com>, David Lechner <dlechner@baylibre.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Gatlin Newhouse <gatlin.newhouse@gmail.com>, Hao Luo <haoluo@google.com>, 
	Ingo Molnar <mingo@redhat.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jir i Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Marc Herbert <Marc.Herbert@linux.intel.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Mateusz Guzik <mjguzik@gmail.com>, Michal Luczaj <mhal@rbox.co>, 
	Miguel Ojeda <ojeda@kernel.org>, Mykola Lysenko <mykolal@fb.com>, NeilBrown <neil@brown.name>, 
	Peter Zijlstra <peterz@infradead.org>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sami Tolvanen <samitolvanen@google.com>, Shuah Khan <shuah@kernel.org>, Song Liu <song@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Thomas Gleixner <tglx@linutronix.de>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Uros Bizjak <ubizjak@gmail.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ye Bin <yebin10@huawei.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Yu feng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 09:24, H. Peter Anvin <hpa@zytor.com> wrote:
>
> Yeah, it commented on the master branch, which is of course ... yours.

Ahh. It's because you didn't use the standard pull request format, and
instead did the branch name elsewhere.

Which btw also messes with my "just cut and paste the address" thing,
because now I'll cut-and-paste two different things.

"Poor Linus - all the pain he has to go through".

          Linus "think of all those extra clicks" Torvalds

