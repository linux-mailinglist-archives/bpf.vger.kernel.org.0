Return-Path: <bpf+bounces-76343-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BCE8CAF20B
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 08:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0489530274F1
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 07:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18601221554;
	Tue,  9 Dec 2025 07:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hkhkF6Kk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7A628640C
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 07:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765265184; cv=none; b=ofKQ6V6sDJ+GbsRmksAt+GGhcNM9VnKz7EeLcym/dUN8EXQfxqVI8DmlJC77o5Ldb35yAx8GWm3UMHZZHXP2JNFenvxpdxC7UPc0mWMrJG7ToCbg7ujpYuJNffD7aa9b2sYLyAxjjtFSTHOnHpPolJPjQf89r+NlEivMKsoedB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765265184; c=relaxed/simple;
	bh=8nT8939qWUoJYlT2R7sKtRouAfpezWZVT5T0CEHq2FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C8VMuAHSbyuEo0TWu1Q/V98nwIvzDL6803LEX0/JGXpwiuxqaIoHcwKfWQmZHizhxVXmFdZirBcpkrnv4ZwyPkDA82V8NglPb+TqUDZ8USl+8ye6Knb5C0euWmuyIjoa9pvXz2hi46m0JFydQheMeMLtNd2Yjjff/ZwwwQyGvgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hkhkF6Kk; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so9020160a12.3
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 23:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1765265179; x=1765869979; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7QhMUSo0zLDlINi8GAqDQeQHdxTHsyz1r33NHLku5hM=;
        b=hkhkF6KkVkRqoHxiBarbSKqdTbdWT47N4A3eeNVapHSRO29gSPUQFLR6UQ8GS6Zo40
         3MnpuwhRdMXV7IFegg6UO5J0vch6ZYNqy+1rMhGV4DKkfBCaN0iIwdTDlMAHcIWDjPIX
         DmsYfMzvNfcfCqNOd6kVGRFR9covA8hNZxt+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765265179; x=1765869979;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7QhMUSo0zLDlINi8GAqDQeQHdxTHsyz1r33NHLku5hM=;
        b=SxNmsVhfllXeaFUz5WqBpt/mu6/bdBdqPE2jQBVneySaFxiQB+VviaJxEpMIvckN7e
         VcZ4l5w0Ze5LV03y/li/Ik6hYe2FrTzN3MKT5ip7MyHQOKRK57OdtLq47xrp/G7Z3X4c
         BpUksHq4uv4LjmlRgq0rQb/xK6j123tktH1bhR4BdEtbLSEbdkwgzAk9mZv9iVTrTPPO
         PMGzR/+52D3w73VN8lqapnlR1RT5CXTcUmh6kTrKoaQfICDDXNnkf2C/sBxZg+ByJoKE
         vDt6AAxz00+C22KXj0MJhV6pZmYd6FJQp8vXkMGRgPJOqeUmAMWqz8ULfXdK95yiAhhn
         Ncdw==
X-Forwarded-Encrypted: i=1; AJvYcCWcXO1UF8BttHOuEozQzt6YOgD9eLeV2hRT6y5OHbRSieo9Syp/Zs5q5gW/BJ0BZv1hXoE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnD2p/eNkbTCMqgz9jMSrFnl+6Mdam8vv7ZUe3wE7bpQWq5AbE
	+iWnWqaXaWY9iR9wGieWorqXnPf/0Cf8SezdMf4ITsUknl6eYE12w2u2f7EPWDtceizyVexNv/9
	7eXBs5hwkiA==
X-Gm-Gg: ASbGncvstwg/WozM/kCPjL+k+BovyRvYPcy8TR5DPLWx5pvkYo1tU+nwsE4dW6qFFYb
	0RVEgKROtlR/Q2uKIquw3WmwRkdO/hvKTT/Nyb53sak/d/dFSE9zebHnitJ2uGhlFutOv+sX+Fl
	39xpnZBxgvzC7gImZ220/5wvtm4L4KLELV8vT0aLciz4yXPPh+wEO79eSKA8wh7txCEpwKExEYW
	SEMBG352HaN46K58tJPvEJa+9EFKykICECAK8CcM80NcDCc7+JLvg6Ozg7vzeVKnpx7iRB51+uZ
	z/AWRxPXyilMhW7bgJcEf0IcTQIXicb06GJOMCZI7rya54I9ENJFYgF9BBAKLoAPn/ZxUBC968S
	BEpE4/Jn/i/ph2ChFcQyLFnnZn2vi5YYZ+Y/AiJt+hMgdkVLW614ekaWC57WABvar2WPPfHrEkp
	x6zYMGnQHZNdL0s4uXa5WHs43zv96/50V3ZeJnS7BO+vM0Ds/GajCaJJznGMUO
X-Google-Smtp-Source: AGHT+IF3Tkv2ma0Z8wsjaPxcxSj9CMjVVqMeUVweWHV7sEAtwYB9DsS6UOFEqlzkuXnNbL8pLif9Wg==
X-Received: by 2002:a05:6402:27cd:b0:643:e03:db14 with SMTP id 4fb4d7f45d1cf-6491a4300b1mr8734591a12.19.1765265179586;
        Mon, 08 Dec 2025 23:26:19 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b413b590sm12977207a12.35.2025.12.08.23.26.17
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Dec 2025 23:26:18 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6431b0a1948so9020113a12.3
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 23:26:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW25bL0f3gd6GZajAgmoT+obI5a5l44M4kp6UJOotyLcWrB8nB6MMaEjsj2z6viw1i3GVU=@vger.kernel.org
X-Received: by 2002:a05:6402:350b:b0:643:883a:2668 with SMTP id
 4fb4d7f45d1cf-6491a430019mr7384754a12.21.1765265177527; Mon, 08 Dec 2025
 23:26:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208235528.3670800-1-hpa@zytor.com>
In-Reply-To: <20251208235528.3670800-1-hpa@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Dec 2025 16:26:00 +0900
X-Gmail-Original-Message-ID: <CAHk-=wiNMD7tCkYvVQMs1=omU9=J=zw_ryvtZ+A-sNR7MN2iuw@mail.gmail.com>
X-Gm-Features: AQt7F2pU3mtSVlk8xXoOHi4ywQ2NpA8rkmyzrskk-X7c-Gbp__mUx8NnR72v7NM
Message-ID: <CAHk-=wiNMD7tCkYvVQMs1=omU9=J=zw_ryvtZ+A-sNR7MN2iuw@mail.gmail.com>
Subject: Re: [GIT PULL] __auto_type conversion for v6.19-rc1
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
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
	Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
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
	Yufeng Wang <wangyufeng@kylinos.cn>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-sparse@vger.kernel.org, virtualization@lists.linux.dev, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Dec 2025 at 08:57, H. Peter Anvin <hpa@zytor.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/hpa/linux-auto.git
>
> for you to fetch changes up to branch auto-type-for-6.19

Oh, and as I was going to merge this, I noticed it's not signed.

Let's not break our perfect recent record of using proper signed tags.
when I know you have a pgp key and I even have it on my keyring.

Please?

              Linus

