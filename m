Return-Path: <bpf+bounces-47282-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331159F709E
	for <lists+bpf@lfdr.de>; Thu, 19 Dec 2024 00:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60B6816C5AD
	for <lists+bpf@lfdr.de>; Wed, 18 Dec 2024 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EC91FC7E4;
	Wed, 18 Dec 2024 23:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b="RMZ12D8e"
X-Original-To: bpf@vger.kernel.org
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7901990DD
	for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 23:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734563850; cv=none; b=u2OUCKlYVC1QZM06EOTWiUDnhx2bOgivzCCN0N3KFrqMzW7G0k/hXQdNYRSIQcxaFuzwWw5bl48uCxVM14ceR0HkTLyMuLMijKGhg6YjfL84vpU3slNOorV1FLljkoQ5IhkhFNnf3EQnP7c52GtPGPAkqgWFaI4mNqqAB5Yg+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734563850; c=relaxed/simple;
	bh=YKNOgC26n64Y1C6SBvhs8M4biCUXh9IIl16wTR9DMhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnEbccz/bRmyBT3Chq5s3OO1OSKDO3XFVQ6pWvWBfHP26GijJC1Rd3EW59KiZXq9zULjWHnVzAXEGN/AkEaM1unsQk9y37veLZjat8nkr5S60PJ3HvthZrvtUzVTWm+9tb51jIEyVwwJ7he7fiLhEpazwHmxUqNd47B3K9I5oE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=jordanrome.com; dkim=pass (2048-bit key) header.d=jordanrome.com header.i=linux@jordanrome.com header.b=RMZ12D8e; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jordanrome.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jordanrome.com;
	s=s1-ionos; t=1734563845; x=1735168645; i=linux@jordanrome.com;
	bh=TReCDCiPkbGbkNpgUbFVsEjE7u8CNNTrT4py08jMJAw=;
	h=X-UI-Sender-Class:MIME-Version:References:In-Reply-To:From:Date:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=RMZ12D8e9/rggkQDk0zwMidcFv/D/ESq/0XRTifkTRsYjXemCXXY70hbIKbfkdHb
	 5lav1F3DEDRt7A2gv6nvFkvgHf0MLUe1IfBcjKJJRGIm1c8L1MRlaqk01x9TWDM0G
	 +L9DekBdYvlB50xEVQtVPJAFtRxeqV3RZC7OdhQz67k2qtcxUNOk/pPFS44gVWEkt
	 z1vKepEDnbIFcwxbMkgoO95+zMPtD4ac2eAVMoxITkkEWve2Ll+0fMooFTeldWoax
	 h8M0wTsRukfx2WJZ1rErM1JFwCIcbcnqJ+Vd1M1YrX4wk+grt6LLw3TMOY++lb1Xq
	 nkkg354Uz2x7ghShWQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from mail-il1-f171.google.com ([209.85.166.171]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1Mz9AN-1tjH3s2ABH-00rmWP for <bpf@vger.kernel.org>; Thu, 19 Dec 2024 00:12:15
 +0100
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ab29214f45so614575ab.0
        for <bpf@vger.kernel.org>; Wed, 18 Dec 2024 15:12:15 -0800 (PST)
X-Gm-Message-State: AOJu0Yz4KpyBu38VdfhQQczidXWhnBVpR89iO1MOLMPDKQNGP6nf3L3X
	NOTMG8n6fmyEFUu5P+LZhKOFGtIG2/KMEolMKcgXZb92Ct3aCkjGp8Gwh4JAPNUkUWVApA8ibfi
	+iobTWDGdGy5yjaxLVsa+j9Ist2w=
X-Google-Smtp-Source: AGHT+IEyM5950UedIoVlAp9XlyViJYMHADEDmm5S1JahFx8PRIVbpXIxCS4R2Umw26XpzjOmbRZzf90UGfWNTlw1Cs0=
X-Received: by 2002:a05:6e02:144b:b0:3a6:b445:dc92 with SMTP id
 e9e14a558f8ab-3bdc0bc819cmr42862685ab.10.1734563535068; Wed, 18 Dec 2024
 15:12:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218225246.3170300-1-yonghong.song@linux.dev>
In-Reply-To: <20241218225246.3170300-1-yonghong.song@linux.dev>
From: Jordan Rome <linux@jordanrome.com>
Date: Wed, 18 Dec 2024 18:12:03 -0500
X-Gmail-Original-Message-ID: <CA+QiOd7hA4gXtAgQt_6cQx0OA3c0Gi15tTkAyV1wQ8+_Fu195g@mail.gmail.com>
Message-ID: <CA+QiOd7hA4gXtAgQt_6cQx0OA3c0Gi15tTkAyV1wQ8+_Fu195g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: Add unique_match option for multi kprobe
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:S69TN5MSJJ5se/i+/upOJgydB/h3o3FGlKf5ynbNfEyQrNhKR4i
 UnLMV/RtZLh2W4LaJEFzpB9/q/oZ64MChAVN8kdavpFmZzd7JkCbUjvNdoZ4o5WIEZcOyQM
 ImECjTAiwEsWuPvpYqnDBGzcpIBeVw1+3H2ce3jG/l+D5e6uJhqgqe/5Q4h6fJ94bVc6aCC
 miUJHaKI2wXrdB8XeroGQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:y5P47LXAiCQ=;toUzq88pArXtW1m81Uy3CQBbRIe
 H9TCGzPIKMAhPgXMJCrCbUSo4QJIqOXE9p48U6LMwBJifrDaJ3bwbw1TeBh2JtGPQOsmrPeqm
 K/syuDiP6Az/2sQrinxcAsdt6XMYx0DF2uqFb5AWendNh4b38BaPQsXeqDCiIXWF/tadevGVH
 5hyMdrgMCRin+biwoDLlkJ7C0ltZ+SkizdZVag2E5kbF6kR5K80ym+NZU4JOs8LXJ+F59WEfW
 /EHSPcvPgnxW5PxHQsf4tvKU3Id12oqbXU5LAelE+YlKnXoO3RB6w8yj4/VjyI1jgCxeN+tlw
 kYEo0gzb4q2MyTa5zkgBIyaReR7SHFwoTINVj96zzoGDzb5jJls8VBI9byRKA0unnpIKsAGew
 vN+Vn7roobqw46gmFi5pjzVOAFuCPgHfyBhDuKi4INPQdkA+09k1jOr1iju1AQXnwaHYFjn3D
 um8WEK89Im/LmT2qHSxLppp/eozZYDygVPYe2Fo274rB6/CrbUFsmUgnyt65kKyBob5sfH8lk
 WrIuehSMTYFXrMTd/qdRQvQbQZT9jUU5PniypXU+RLgERF+H8qeHuDN81MNHBsRxBvDLUBEKA
 127P5kaojOMfsXQjr0C2GLAUsuCP1kT3kb3vkjBbbeT9Wvi4DRXB/X9oVsMP1RnNteEkkdlhQ
 kT1oJF2q9eNFQ5Ko9SI2f2NxV9alpa4qjEtotWBF3CN+ApdLMHMFyLWK13P2VftJCemr0lk2V
 WxZuMlKCAUyWALY+umSF+n3Tzfz8qw8q7FCRBLZZ2/p2eqW456UhjKa/VmsUAjkITEO0xK+HJ
 feFVH9nbMP1xtIQzc2Bj0Thoekz97Qekpdf8fvhFNTpsMhqagQYJP3VPMSQEVxtVxS69RWDt8
 sMvd4wbfjqV2oT4+Gz5bAelnja9HjBEfqqZi526cDJMslt2Pf0niRx5mglDhrps8iQWHZV/tb
 su3ou5FwFruJUboGyRWtVjC19Et3zAlTiCmumrPBnlVn/yqEA72Z5erg9d46bo25gaGsNa3eY
 uz65JMCjeGV779AC5uhiTCRyLwR5IIIPfypAn3O

On Wed, Dec 18, 2024 at 5:53=E2=80=AFPM Yonghong Song <yonghong.song@linux.=
dev> wrote:
>
> Jordan reported an issue in Meta production environment where func
> try_to_wake_up() is renamed to try_to_wake_up.llvm.<hash>() by clang
> compiler at lto mode. The original 'kprobe/try_to_wake_up' does not
> work any more since try_to_wake_up() does not match the actual func
> name in /proc/kallsyms.
>
> There are a couple of ways to resolve this issue. For example, in
> attach_kprobe(), we could do lookup in /proc/kallsyms so try_to_wake_up()
> can be replaced by try_to_wake_up.llvm.<hach>(). Or we can force users
> to use bpf_program__attach_kprobe() where they need to lookup
> /proc/kallsyms to find out try_to_wake_up.llvm.<hach>(). But these two
> approaches requires extra work by either libbpf or user.
>
> Luckily, suggested by Andrii, multi kprobe already supports wildcard ('*'=
)
> for symbol matching. In the above example, 'try_to_wake_up*' can match
> to try_to_wake_up() or try_to_wake_up.llvm.<hash>() and this allows
> bpf prog works for different kernels as some kernels may have
> try_to_wake_up() and some others may have try_to_wake_up.llvm.<hash>().
>
> The original intention is to kprobe try_to_wake_up() only, so an optional
> field unique_match is added to struct bpf_kprobe_multi_opts. If the
> field is set to true, the number of matched functions must be one.
> Otherwise, the attachment will fail. In the above case, multi kprobe
> with 'try_to_wake_up*' and unique_match preserves user functionality.
>
> Reported-by: Jordan Rome <linux@jordanrome.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  tools/lib/bpf/libbpf.c | 10 +++++++++-
>  tools/lib/bpf/libbpf.h |  4 +++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 66173ddb5a2d..649c6e92972a 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11522,7 +11522,7 @@ bpf_program__attach_kprobe_multi_opts(const struc=
t bpf_program *prog,
>         struct bpf_link *link =3D NULL;
>         const unsigned long *addrs;
>         int err, link_fd, prog_fd;
> -       bool retprobe, session;
> +       bool retprobe, session, unique_match;
>         const __u64 *cookies;
>         const char **syms;
>         size_t cnt;
> @@ -11558,6 +11558,14 @@ bpf_program__attach_kprobe_multi_opts(const stru=
ct bpf_program *prog,
>                         err =3D libbpf_available_kallsyms_parse(&res);
>                 if (err)
>                         goto error;
> +
> +               unique_match =3D OPTS_GET(opts, unique_match, false);
> +               if (unique_match && res.cnt !=3D 1) {
> +                       pr_warn("prog '%s': failed to find unique match: =
cnt %lu\n",
> +                               prog->name, res.cnt);

nit: "failed to find a unique match. Num matches: %lu\n"
or "Failed to find a unique match for %s'. Num matches: %lu\n"

> +                       return libbpf_err_ptr(-EINVAL);
> +               }
> +
>                 addrs =3D res.addrs;
>                 cnt =3D res.cnt;
>         }
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index d45807103565..3020ee45303a 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -552,10 +552,12 @@ struct bpf_kprobe_multi_opts {
>         bool retprobe;
>         /* create session kprobes */
>         bool session;
> +       /* enforce unique match */
> +       bool unique_match;
>         size_t :0;
>  };
>
> -#define bpf_kprobe_multi_opts__last_field session
> +#define bpf_kprobe_multi_opts__last_field unique_match
>
>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
> --
> 2.43.5
>

Ack. Thanks for the quick work, Yonghong!

