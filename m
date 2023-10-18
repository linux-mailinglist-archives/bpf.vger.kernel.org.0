Return-Path: <bpf+bounces-12606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C17CE772
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 21:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5A76B212FA
	for <lists+bpf@lfdr.de>; Wed, 18 Oct 2023 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4918F44488;
	Wed, 18 Oct 2023 19:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FFE335CA;
	Wed, 18 Oct 2023 19:12:43 +0000 (UTC)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B72C109;
	Wed, 18 Oct 2023 12:12:42 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-d9ac43d3b71so7809959276.0;
        Wed, 18 Oct 2023 12:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656361; x=1698261161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bm/QitVoXGxf3ERCz3VJAvR9l7hSVdW0OvjmYyP6n1s=;
        b=D3+z/My+TkaEJ83wkraPBqL4quLG4CY8GUcezwYaQfS0CYJnh9g/WB7c9o0lVRh0HE
         HgbhmQBu6G9fW8HUu/FO8fWM3eUA4cBwduiNXqoVYAz/qSv79q9+DKLMJkjy9r+Re0wf
         6zmWSflv6THq+y/ewY7lTc9gvVR3PZIJV7LXb8N6kr+hHIlu70ZW0ZHwD6AxaBG5z8au
         erKVbDWzIJw5OV079YWkajwsheUsau2b59cyR1nJHELa7tKhy4Ydw53p7+thc8fwgf0p
         cDtLAAhAv7o3+G485MDQZtBQI4fNk1c8FQKDeSwCVpBi8zQLQG5Iuz7u+CTvQwH/BOnf
         N8pQ==
X-Gm-Message-State: AOJu0YyN3y6aW+CzJGnxFXLtl7iNUSnYf9Icb21iA6TpDO5ecoQgj/bd
	SSgA+j3T/LjSuxX7MeeExiP8vB0wankJzA==
X-Google-Smtp-Source: AGHT+IG99EISzj7k6T/yx0htRH7EUXaAkURMTiKbUNVYa2lCnKMK5l/f8Vj9mdDXRkTu+CWbTgKGKg==
X-Received: by 2002:a25:50c7:0:b0:d9a:e337:b6a with SMTP id e190-20020a2550c7000000b00d9ae3370b6amr259861ybb.61.1697656361368;
        Wed, 18 Oct 2023 12:12:41 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l12-20020a25bccc000000b00d749a394c87sm1487247ybm.16.2023.10.18.12.12.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 12:12:41 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-d84f18e908aso8157338276.1;
        Wed, 18 Oct 2023 12:12:40 -0700 (PDT)
X-Received: by 2002:a25:d7c7:0:b0:d80:1604:f6e9 with SMTP id
 o190-20020a25d7c7000000b00d801604f6e9mr285943ybg.44.1697656360583; Wed, 18
 Oct 2023 12:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231018182412.80291-1-hamza.mahfooz@amd.com> <CAMuHMdXSzMJe1zyJu1HkxWggTKJj_sxkPOejjbdRjg3FeFTVHQ@mail.gmail.com>
 <d764242f-cde0-47c0-ae2c-f94b199c93df@amd.com>
In-Reply-To: <d764242f-cde0-47c0-ae2c-f94b199c93df@amd.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 18 Oct 2023 21:12:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXYDQi5+x1KxMG0wnjSfa=A547B9tgAbgbHbV42bbRu8Q@mail.gmail.com>
Message-ID: <CAMuHMdXYDQi5+x1KxMG0wnjSfa=A547B9tgAbgbHbV42bbRu8Q@mail.gmail.com>
Subject: Re: [PATCH] lib/Kconfig.debug: disable FRAME_WARN for kasan and kcsan
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Siqueira <rodrigo.siqueira@amd.com>, 
	Harry Wentland <harry.wentland@amd.com>, Alex Deucher <alexander.deucher@amd.com>, 
	Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Nick Terrell <terrelln@fb.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Kees Cook <keescook@chromium.org>, Zhaoyang Huang <zhaoyang.huang@unisoc.com>, 
	Li Hua <hucool.lihua@huawei.com>, Alexander Potapenko <glider@google.com>, Rae Moar <rmoar@google.com>, 
	rust-for-linux@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hamza,

On Wed, Oct 18, 2023 at 8:39=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@amd.co=
m> wrote:
> On 10/18/23 14:29, Geert Uytterhoeven wrote:
> > On Wed, Oct 18, 2023 at 8:24=E2=80=AFPM Hamza Mahfooz <hamza.mahfooz@am=
d.com> wrote:
> >> With every release of LLVM, both of these sanitizers eat up more and
> >> more of the stack. So, set FRAME_WARN to 0 if either of them is enable=
d
> >> for a given build.
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> >
> > Thanks for your patch!
> >
> >> --- a/lib/Kconfig.debug
> >> +++ b/lib/Kconfig.debug
> >> @@ -429,11 +429,10 @@ endif # DEBUG_INFO
> >>   config FRAME_WARN
> >>          int "Warn for stack frames larger than"
> >>          range 0 8192
> >> -       default 0 if KMSAN
> >> +       default 0 if KASAN || KCSAN || KMSAN
> >
> > Are kernels with KASAN || KCSAN || KMSAN enabled supposed to be bootabl=
e?
>
> They are all intended to be used for runtime debugging, so I'd imagine so=
.

Then I strongly suggest putting a nonzero value here.  As you write
that "with every release of LLVM, both of these sanitizers eat up more and =
more
of the stack", don't you want to have at least some canary to detect
when "more and more" is guaranteed to run into problems?

> > Stack overflows do cause crashes.
>
> It is worth noting that FRAME_WARN has been disabled for KMSAN for quite
> a while and as far as I can tell no one has complained.

ROTFL...

> >>          default 2048 if GCC_PLUGIN_LATENT_ENTROPY
> >>          default 2048 if PARISC
> >>          default 1536 if (!64BIT && XTENSA)
> >> -       default 1280 if KASAN && !64BIT
> >>          default 1024 if !64BIT
> >>          default 2048 if 64BIT
> >>          help

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

