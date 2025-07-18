Return-Path: <bpf+bounces-63769-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEEAB0ABC7
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 23:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE96916EDDE
	for <lists+bpf@lfdr.de>; Fri, 18 Jul 2025 21:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8030922126D;
	Fri, 18 Jul 2025 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="c9c3CSZZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E2F21FF4E
	for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752875880; cv=none; b=VNZcvw4f3RYwHUHFLq/j6DSRu+GjQlkyFDfGY8x3ToWIlYS2vRn5Kf/37nGeIBC9iEXJksGT6tLSY4N0qXJ4AaAkSkY8SppP72WHfyH18e3CKWxpCHsBlKWAy3Vq6A6jV6yzVtly6Qs65ToNU4EyPN3dJENs0nB5Y4dM63bNOwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752875880; c=relaxed/simple;
	bh=ltKlX/6V8eiGzqwSGoa5gPUbAJICZza9LmiBT1RB0UM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=te9hm9MIfATgvIo4BxBsnHVWa/BmUPvj6K8wAL7p39FBuNKloSEIDmvp9gdo+mbABeRRH2xi1tpYyDKNACf0pfM65W88cJxEIED7i4pYprBnDfSHXKRZDyg7g6YGZM5v6X3oFnJ6VINX7G5vVcabEANpBR7xdAIWQZATTJ7ZE+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=c9c3CSZZ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so5548799a12.0
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 14:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1752875876; x=1753480676; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=c9c3CSZZqC6nRssmaZSzbezi1ZTSCKHYZiiKS5pLD50rfA7dZqU9qEz8EqvRyROduC
         SCnfxxz1ztyCYDDN3yNuEj8EsJxjfkJpb7cJAFrVwrbuM5dEy6GUJO8gyCRFdRba6s03
         qdefM6hYIIs/54VmchHyQBGNPYi76uGKvte0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752875876; x=1753480676;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fXvc2xA25r+Dun5T9AdGpnAPv49cA2nPvvpwJnVhZbM=;
        b=FsmBQ1olxiu+Ms3yI86/lCoa3QaGNE7nfy/zQeQ4LWogUQMlPlzocPXqm/EwAeyPdu
         j1FixGkjf8apO9F92xyNojNl28AZo4M1i9+rnQAbh/ClYCuWbQcqD8FNco0XeTfN/2es
         uHczk3gK3eubT2lCAtX7YTDkpI2c+40OF1Ze9Hv9QEq+uzRa2oE0DfE8ZikrcDoprgwx
         oLx+FPJ/L7oPSSrwpMVPponFxvIK3VRpPdFaIimmSdyu8P0Cgy7TIjTz3kVFTJn7D+eo
         IIUkWhVYEfscHaNXwOu02ECUkz6w8yRLMZ+L1dPKgjDGn+vMa4qcee8Fkt0qViX0hbSm
         Oz3w==
X-Forwarded-Encrypted: i=1; AJvYcCW3OCy30zHo8URfT2W1ZRT9bmRwRdLADA1T6Biyk/TjCED6+pchKqhWPwzv9TghVeUDIto=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd67k2Rawj+mWQVqrkNLUvO4Efpf3pSsuOtW1MZUxnUmZf0/p0
	Mr9M0tPcC8uP5L1yYW4slSpaJOmg0tQzTxNqZNJQIW65A7dRllSbydkkvlE8nCQHSMh8kI76VJX
	AqZ4XuZw=
X-Gm-Gg: ASbGncuXmo1pYNNF8Co5OXsYNYe3IRVsx8Jgsry5kStFdmduV2+cr6+nM9F6x9EsPZu
	FoddtCCHeiJ1PQCrPi06tLK494VkxUy96aUz4HE4OdRK3piU0VvlPs7SezlVQBJ7/BZTWALfFDO
	nzyYr0uAhPxu0kr4pRfLHkOYkpMBuz/uvKrCOh0UOgCAA2WW2c+vClppMA2RjiVJkhnddZRgAl6
	PSicoz20bsyunFfKyLV0wOT2+z+mxv0hu5PkX5I63pa4/6/kybMtV9qAoaZAqju4ZZPFcBdaB1A
	yKgasf3aAHMfjAurLvr1rm21KMM1YHzLfuL42s5KXeAVsZvO7RUY3sooM3Y3TKAX1zyZ/gBsA7r
	QLwVkRU0EizQoAtXtJAeo88id43gJggf6+9jFBCCGyWfRVgeS+23nghZVxNqD+02wuLXAVn5cNm
	4Zd84acwc=
X-Google-Smtp-Source: AGHT+IEhVClzD5kH+QIQYN88m3xLGv4OvdHgCx9IJBH7qAVT2WIcAPEhxId98mFCkGz4aZFgoY1kjA==
X-Received: by 2002:a05:6402:13c2:b0:60c:3ecd:5140 with SMTP id 4fb4d7f45d1cf-612c0091a9amr4333698a12.0.1752875875894;
        Fri, 18 Jul 2025 14:57:55 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f37026sm1588919a12.25.2025.07.18.14.57.54
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:57:54 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-60c01b983b6so5548724a12.0
        for <bpf@vger.kernel.org>; Fri, 18 Jul 2025 14:57:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXydbF5B0ddwoKLYFpPlR0QN6B4XDaWxFLlp2m0i6jqyejOtyx5mnkY06XacjYkJG8wTGY=@vger.kernel.org
X-Received: by 2002:a05:6402:13c2:b0:60c:3ecd:5140 with SMTP id
 4fb4d7f45d1cf-612c0091a9amr4324302a12.0.1752875399525; Fri, 18 Jul 2025
 14:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718213252.2384177-1-hpa@zytor.com> <20250718213252.2384177-5-hpa@zytor.com>
In-Reply-To: <20250718213252.2384177-5-hpa@zytor.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 18 Jul 2025 14:49:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
X-Gm-Features: Ac12FXwcle_QXTMWRdj0MWMkwuJCKrti8An2oscUa99HJ5SDjVBQa7FesoFMBkk
Message-ID: <CAHk-=whGcopJ_wewAtzfTS7=cG1yvpC90Y-xz5t-1Aw0ew682w@mail.gmail.com>
Subject: Re: [PATCH 4/7] arch/nios: replace "__auto_type" with "auto"
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Alexei Starovoitov <ast@kernel.org>, Alexey Dobriyan <adobriyan@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Arnd Bergmann <arnd@kernel.org>, Borislav Petkov <bp@alien8.de>, Cong Wang <cong.wang@bytedance.com>, 
	Dan Williams <dan.j.williams@intel.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Laight <David.Laight@aculab.com>, 
	David Lechner <dlechner@baylibre.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Gatlin Newhouse <gatlin.newhouse@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ingo Molnar <mingo@redhat.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, Jan Hendrik Farr <kernel@jfarr.cc>, Jason Wang <jasowang@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <kees@kernel.org>, 
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

On Fri, 18 Jul 2025 at 14:34, H. Peter Anvin <hpa@zytor.com> wrote:
>
> -       __auto_type __pu_ptr = (ptr);                                   \
> +       auto __pu_ptr = (ptr);                                  \
>         typeof(*__pu_ptr) __pu_val = (typeof(*__pu_ptr))(x);            \

Side note: I think some coccinelle (or sed) script that replaces that
older form of

       typeof(x) Y = (typeof(x))(Z);

or

        typeof(Z) Y = Z;


with just

        auto Y = Z;

is also worthwhile at some point.

We have more of those, because that's the really traditional gcc way
to do things that predates __auto_type.

And the patterns are a bit more complicated, so they need care: not
all of the "typeof (x) Z = Y" patterns have the same type in the
assignment.

So it's not the universal case, but it's the _common_ case, I think.

For example, it's obviously the case in the above, where we use the
exact same "typeof" on both sides, but in other uaccess.h files we
also have patterns like

        __typeof__(*(ptr)) __x = (x); /* eval x once */
        __typeof__(ptr) __ptr = (ptr); /* eval ptr once */

where that *first* case very much needs to use that "__typeof__"
model, because 'x' typically does not necessarily have the same type
as '*(ptr)' (and we absolutely do not want to use a cast: we want
integer types to convert naturally, but we very much want warnings if
somebody were to mix types wrong).

But that second case obviously is exactly the "auto type" case, just
written using __typeof__.

               Linus

