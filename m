Return-Path: <bpf+bounces-50240-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A84A24385
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 20:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F20E11888340
	for <lists+bpf@lfdr.de>; Fri, 31 Jan 2025 19:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B101F2C33;
	Fri, 31 Jan 2025 19:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVvbMHpU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697321547E4;
	Fri, 31 Jan 2025 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738352603; cv=none; b=F5q2MaVY4Mtyl7aFdZOKK6Mll3/x93NH4gL9efrr23rVrbOojaL/v2+UHOoEC3JQgmUHIG3wl9PhseqdGTZVpZ+I1hK8ksI3J4YfGsOU0tOLGI9SCDRP+H0R7cIDM4YUF/Dr+I4F+6aq+AZUTvO835cjl/PFRof1z40o6ETXrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738352603; c=relaxed/simple;
	bh=337HH7+vJoKIUO+OpQbcynXUqqyJYIq5z0C6e83MzDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdhbFiDoKWQah8ET3yJCnQHDeIOhb5hpJIrEL5oOy3hzVINjDtCkD0i3HwYpxbGprius4KY/D9kU0SIAzA43qBLTF7ZKJYszeAZiKU4OfBfoqSN6qyjl4aIFMxjD/RLKfcuMPh1UiWebSSiZO4HbT1SIlilep8VZUgX7vTi2qTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVvbMHpU; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-71e36b27b53so1300741a34.1;
        Fri, 31 Jan 2025 11:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738352600; x=1738957400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LnQU5Rr0/pPs4UY8wE2SbKUww8KifTKoqqzsIGrrKzQ=;
        b=cVvbMHpUEBAh6zYil3AofT6nutWvi4EMoOpmTddmyINNVHMrldZgszrIthO2cS8OBc
         3a0zGE8JT/yexEFiCqX1X06yIqPHZUeq82XdMNiOr5aukjGm6a0UoVzfESMpL/ocAb25
         kGUzLSlL/7hooQKOsUElSam0JkzlNnokeZC4uY0Eq2D7JLZG3RE0QfJUmpvhFDNeyAPT
         3n7jnu9se8KS/Y6qpEQylb/2JDQCWOl4Fooohb2AbevOo1UTQSVh72ibM0XFBVwkcIS/
         ObZN7KQcKomqVKBLeYn8QzBvq0K1tvHR46yCF4vCDWEIM0bw2dpu7lcYY4MScB7An6iS
         HpsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738352600; x=1738957400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LnQU5Rr0/pPs4UY8wE2SbKUww8KifTKoqqzsIGrrKzQ=;
        b=azYkC0yvTvn4RYR7uwbBL1qjwycPs8iQ/vA5xoQEG0qyXAL8+H7ikEAkCJFVEpvdXO
         yGFHXRcNQO9nwmr/QZ0SezuwMfVRE0DSkqjpszQyOkSU7r1BJCnij/B/zfZyyFdf9hMR
         1qaizuM4J2cP/+fNVduM0xJyMNTJHtNs/viBs+o20VGQuI9lW2Y3zNokYIQFuSWhOfLK
         UK51uebjAq8QGtmDxESDxCWUodtsF7X44JudObXjlfR8AZWJE5Ri7cuOr0p/gep4Z9xr
         TMLiH1cjBZ2hFTVpEFf514X67VltGOxljdlz0TG+0XBcHRlhRKPvYK/akAIz/nq+lTLM
         ZX/w==
X-Forwarded-Encrypted: i=1; AJvYcCUvL3ZMgDmpHMRwmkHyrkKuE5lDZlevIn8XT8Qi2lGaN89Iy7JNiSBK9hQOKCSKG7ADZsR67+S1V2r0oqLrQB5q6awb@vger.kernel.org, AJvYcCV5WQLXuTvBF4StySTknmEW5p77T4QPb41mMQhhdXGP2bcPYvp6ZjWMxCGnJtcEevycesBMdqMoX03K@vger.kernel.org, AJvYcCVyMtVDbBouBEFB3lYL3Bh/5EMz2/bBa/2xe2/AmyB9/isUE5/gTQBjc7fP5rTAscc/qqmOVfIj@vger.kernel.org, AJvYcCX1u7vS7snut7Pr2zijG+fZ8BVTkyF1OEbXbO+rwklM4E0RQpyV9p4+kpQbmC93GxNheqGS2Ge83a+r+V3Q@vger.kernel.org, AJvYcCXmAd9+RWkGQrYgN4FLZ+Q/zCcBBz3tlscabZyHx+m+sErKPJIxZfmfNzntHceK294rYTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycw4UJz0+sbT7rizqZWfL4F7Y1WvKWOiSQtJRNcBJz51DGVitb
	d4vwaa1LVGuy50I2IcE8QRJ4v2aZBAobOuQhbPgaHJbyNY6ykIaviAxOIFOXbm0SDgATh4bQxwh
	MEtzGHDWekJ3IkDZEpfTUVCdP5ks=
X-Gm-Gg: ASbGncu0Dmjn8/E2IEfluu7T8ci/QTSR2vJ13lIc155FmcSBIjSJ4ZQZvh1ScOYy6wh
	Vvoh4r7zitgljcAhA+QdFWXwoUaJl2mR2iw6/0VwgI5G7ZZQWIGZmIBhWYYfstlHFZTPbltrw
X-Google-Smtp-Source: AGHT+IGuglKKu0Vj5KQ/a29Sd5LGjr6yBzimjsJ35ZemORPyvNkDias8l1Y0tRb/6HuBtFVnWBy223HrmE+yQva7CVM=
X-Received: by 2002:a05:6830:498e:b0:71e:1ff9:e91b with SMTP id
 46e09a7af769-726568fa816mr10533632a34.27.1738352600319; Fri, 31 Jan 2025
 11:43:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250128145806.1849977-1-eyal.birger@gmail.com> <202501281634.7F398CEA87@keescook>
In-Reply-To: <202501281634.7F398CEA87@keescook>
From: Eyal Birger <eyal.birger@gmail.com>
Date: Fri, 31 Jan 2025 11:43:08 -0800
X-Gm-Features: AWEUYZmphJNzS8wDK_GnqcgmWuSZHukqLJ0pLgRgiK0wdkywYJy6YSyYJHeFJxE
Message-ID: <CAHsH6Gsaq0678cUZxM80uMaA+G_G6=w9RbD3YGrxG110Fna4ww@mail.gmail.com>
Subject: Re: [PATCH v2] seccomp: passthrough uretprobe systemcall without filtering
To: Kees Cook <kees@kernel.org>
Cc: luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000003ca82d062d05c16b"

--0000000000003ca82d062d05c16b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kees,

On Tue, Jan 28, 2025 at 5:41=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> [...]
> Also please add a KUnit tests to cover this in
> tools/testing/selftests/seccomp/seccomp_bpf.c
> With at least these cases combinations below. Check each of:
>
>         - not using uretprobe passes
>         - using uretprobe passes (and validates that uretprobe did work)
>
> in each of the following conditions:
>
>         - default-allow filter
>         - default-block filter
>         - filter explicitly blocking __NR_uretprobe and nothing else
>         - filter explicitly allowing __NR_uretprobe (and only other
>           required syscalls)

In order to validate my understanding of the required test cases,
I've attached a small bash script which validates them.
As expected, the script fails without the suggested change.

If there are gaps in my understanding of the required scope, please
let me know.
I plan to port these test cases to use the kselftests infrastructure as
requested.

To my understanding, the other issues with regards to the proposed patch
are resolved, i.e. there aren't plans to support a 32 bit or mips flavor
of this syscall, and the suggested patch fails closed if they are added.

As such, is it possible to merge the suggested patch so it could be back
merged? I'm suggesting this in the interest of time, as for example Ubuntu
LTS is going to be using kernel 6.11 soon [1] and other distributions
are probably going to as well, and I believe the coding/review process
for the testing code will take a while and probably won't be backmerged
anyway.

Thanks!
Eyal.

[1] https://www.omgubuntu.co.uk/2025/01/ubuntu-24-04-2-release-date

--0000000000003ca82d062d05c16b
Content-Type: text/x-sh; charset="US-ASCII"; name="u.sh"
Content-Disposition: attachment; filename="u.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_m6l67jpa0>
X-Attachment-Id: f_m6l67jpa0

IyEvYmluL2Jhc2ggLWUKCmJ0PS91c3IvYmluL2JwZnRyYWNlCgpkZWZhdWx0X2FsbG93X2ZpbHRl
cj0kKGNhdCA8PCBFT0YKewogICAgCXNjbXBfZmlsdGVyX2N0eCBjdHg7CiAgICAKICAgIAljdHgg
PSBzZWNjb21wX2luaXQoU0NNUF9BQ1RfQUxMT1cpOwogICAgCXNlY2NvbXBfbG9hZChjdHgpOwog
ICAgCXNlY2NvbXBfcmVsZWFzZShjdHgpOwp9CkVPRgopCgpkZWZhdWx0X2Jsb2NrX2ZpbHRlcj0k
KGNhdCA8PCBFT0YKewogICAgCXNjbXBfZmlsdGVyX2N0eCBjdHg7CiAgICAKICAgIAljdHggPSBz
ZWNjb21wX2luaXQoU0NNUF9BQ1RfS0lMTCk7CiAgICAJZm9yIChpbnQgaSA9IDA7IGkgPCBudW1f
c3lzY2FsbHM7IGkrKykgewogICAgCQlzZWNjb21wX3J1bGVfYWRkKGN0eCwgU0NNUF9BQ1RfQUxM
T1csCiAgICAJCQkJIHNlY2NvbXBfc3lzY2FsbF9yZXNvbHZlX25hbWUoc3lzY2FsbHNbaV0pLCAw
KTsKICAgIAl9CiAgICAJc2VjY29tcF9sb2FkKGN0eCk7CiAgICAJc2VjY29tcF9yZWxlYXNlKGN0
eCk7Cn0KRU9GCikKCmFsbG93X3VyZXRwcm9iZV9maWx0ZXI9JChjYXQgPDwgRU9GCnsKICAgIAlz
Y21wX2ZpbHRlcl9jdHggY3R4OwogICAgCiAgICAJY3R4ID0gc2VjY29tcF9pbml0KFNDTVBfQUNU
X0tJTEwpOwogICAgCWZvciAoaW50IGkgPSAwOyBpIDwgbnVtX3N5c2NhbGxzOyBpKyspIHsKICAg
IAkJc2VjY29tcF9ydWxlX2FkZChjdHgsIFNDTVBfQUNUX0FMTE9XLAogICAgCQkJCSBzZWNjb21w
X3N5c2NhbGxfcmVzb2x2ZV9uYW1lKHN5c2NhbGxzW2ldKSwgMCk7CiAgICAJfQogICAgCXNlY2Nv
bXBfcnVsZV9hZGQoY3R4LCBTQ01QX0FDVF9BTExPVywgMzM1LCAwKTsKICAgIAlzZWNjb21wX2xv
YWQoY3R4KTsKICAgIAlzZWNjb21wX3JlbGVhc2UoY3R4KTsKfQpFT0YKKQoKYmxvY2tfdXJldHBy
b2JlX2ZpbHRlcj0kKGNhdCA8PCBFT0YKewogICAgCXNjbXBfZmlsdGVyX2N0eCBjdHg7CiAgICAK
ICAgIAljdHggPSBzZWNjb21wX2luaXQoU0NNUF9BQ1RfQUxMT1cpOwogICAgCXNlY2NvbXBfcnVs
ZV9hZGQoY3R4LCBTQ01QX0FDVF9LSUxMLCAzMzUsIDApOwogICAgCXNlY2NvbXBfbG9hZChjdHgp
OwogICAgCXNlY2NvbXBfcmVsZWFzZShjdHgpOwp9CkVPRgopCgp0KCkKewogICAgd2l0aF91cmV0
cHJvYmU9JDE7CiAgICBmaWx0ZXJfbmFtZT0kMjsKICAgIGZpbHRlcj0keyFmaWx0ZXJfbmFtZX07
CgogICAgZWNobyAiVGVzdDogdXJldHByb2JlICR3aXRoX3VyZXRwcm9iZSwgZmlsdGVyICRmaWx0
ZXJfbmFtZSIKCiAgICBjYXQgPiAvdG1wL3guYyA8PCBFT0YKICAgICNpbmNsdWRlIDxzdGRpby5o
PgogICAgI2luY2x1ZGUgPHNlY2NvbXAuaD4KICAgIAogICAgY2hhciAqc3lzY2FsbHNbXSA9IHsK
ICAgIAkiZXhpdF9ncm91cCIsCiAgICB9OwogICAgCiAgICBfX2F0dHJpYnV0ZV9fKChub2lubGlu
ZSkpIGludCBwcm9iZWQodm9pZCkKICAgIHsKICAgIAlyZXR1cm4gMTsKICAgIH0KICAgIAogICAg
dm9pZCBhcHBseV9zZWNjb21wX2ZpbHRlcihjaGFyICoqc3lzY2FsbHMsIGludCBudW1fc3lzY2Fs
bHMpCgkkZmlsdGVyCiAgICAKICAgIGludCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAg
ICB7CiAgICAJaW50IG51bV9zeXNjYWxscyA9IHNpemVvZihzeXNjYWxscykgLyBzaXplb2Yoc3lz
Y2FsbHNbMF0pOwogICAgCiAgICAJYXBwbHlfc2VjY29tcF9maWx0ZXIoc3lzY2FsbHMsIG51bV9z
eXNjYWxscyk7CiAgICAKICAgIAlwcm9iZWQoKTsKICAgIAogICAgCXJldHVybiAwOwogICAgfQpF
T0YKICAgIAogICAgY2F0ID4gL3RtcC90cmFjZS5idCA8PCBFT0YKICAgIHVyZXRwcm9iZTovdG1w
L3g6cHJvYmVkCiAgICB7CiAgICAgICAgcHJpbnRmKCJyZXQ9JWRcbiIsIHJldHZhbCk7CiAgICB9
CkVPRgogICAgCiAgICBnY2MgLW8gL3RtcC94IC90bXAveC5jIC1sc2VjY29tcAogICAgCiAgICAk
d2l0aF91cmV0cHJvYmUgJiYgewoJJGJ0IC90bXAvdHJhY2UuYnQgJgoJYnRwaWQ9JCEKICAgICAg
ICBzbGVlcCA1ICMgd2FpdCBmb3IgdXJldHByb2JlIGF0dGFjaAogICAgfQogICAgCiAgICAvdG1w
L3gKICAgIAogICAgJHdpdGhfdXJldHByb2JlICYmIGtpbGwgJGJ0cGlkCiAgICAKICAgIHJtIC90
bXAveCAvdG1wL3guYyAvdG1wL3RyYWNlLmJ0Cn0KCnQgZmFsc2UgImRlZmF1bHRfYWxsb3dfZmls
dGVyIgp0IHRydWUgImRlZmF1bHRfYWxsb3dfZmlsdGVyIgp0IGZhbHNlICJkZWZhdWx0X2Jsb2Nr
X2ZpbHRlciIKdCB0cnVlICJkZWZhdWx0X2Jsb2NrX2ZpbHRlciIKdCBmYWxzZSAiYWxsb3dfdXJl
dHByb2JlX2ZpbHRlciIKdCB0cnVlICJhbGxvd191cmV0cHJvYmVfZmlsdGVyIgp0IGZhbHNlICJi
bG9ja191cmV0cHJvYmVfZmlsdGVyIgp0IHRydWUgImJsb2NrX3VyZXRwcm9iZV9maWx0ZXIiCg==
--0000000000003ca82d062d05c16b--

