Return-Path: <bpf+bounces-45567-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638059D825A
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 10:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 227B4282127
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 09:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55249192B69;
	Mon, 25 Nov 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edZZUv3u"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176611922F5;
	Mon, 25 Nov 2024 09:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527211; cv=none; b=EjuYirpUcz9kewLnVM8NOMGWeK6s3r/MeDJMBdSYML21PiXOPjdmwZJ2x62H5ukfXXGMm3vw0q6NGMyzvFCipI59GOUSHUlXpU24eLPXTtvPOCbraM7veYE6DCE8ZC4OhIBPe4u42R6r8nUfrrtZklQ0VGmwGib+HhHQ5bQTexs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527211; c=relaxed/simple;
	bh=X81NZt9qx3DE0gbvEotrk8pcmoWkcatWmTjsILlbnbI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYJUSXGNJEXojpjgBCvtqHiUUp0z46NO4oDLX0uVci1sKXIuN9d/MGtzqf2tk6bW8VC7f6+mdDJx0P/sGYSVgWXTiwqZmVMWmq/A5SC7JnHjsnlibWg/51sjbf49WOapqXFsijNVnlH3AxXziu/YglzK8ufBmD4rGAFJLloLmwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edZZUv3u; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ffb0bbe9c8so20462561fa.0;
        Mon, 25 Nov 2024 01:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732527208; x=1733132008; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CJd7YmDRIf/qZZRuIn1RRwsg87hhLA4wTR2jmGGoM0I=;
        b=edZZUv3u7CuTJxhvRxwEwMA1jdaaD94Gafw/mM/pTJaiZR3H0AL547Uh48NTgITxej
         R1OYhaoM37VOLFczBNQor8xXrlaS09PQD8Q0B3ErRMBBTdbaq40bxkeSV3U1sPd/Dsx5
         PVUx9I7cxBcGaElQRcthKEUI+wJoj9GioNjBYFeNsFAgi1jYZ7AsuE/WLkKRw1RTsKhP
         788k/QqI5/x2uKzyk1L7ZkWNCLYSr7rtjPevHQfQmof42TdDm5JR+mzDn7BZEOljV5Sa
         N+dHg939o1u6+y434V3TQwyqMQdE5EYNN/f2PLS27iBs25/C9JYyURhmX8S5sBE/lGB/
         qddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732527208; x=1733132008;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJd7YmDRIf/qZZRuIn1RRwsg87hhLA4wTR2jmGGoM0I=;
        b=kxcmQM7Hd5x5wo8iPYC57eP3lDIIvyCJ/KWEZ8XuoGdfgVOOpyVL6fjpy2Dkx3IwwB
         VKFEP8PvT3nC2NHlrrojur2uZSZZowr8zfE1t1e8FAJObMOdCaRcftk5BkS6MWs3y3qo
         P1lp2+YYN50yAsVwkcL/QiQZxjTp3sniem4Jftol4h03v2Ige5WoI+DOn3KcD4LApVmg
         IHQn2QdxDtFkT3WzPEeQXIJ1Ej32IivfTFTIzGAaMdUYNb2j4r8d7O/c5PlCXCR7nZal
         f5tW/A1brRvQ/Rid32uQFB88uvUERkHt3lDxstct5WjDnuis8TSYqAzB/YbhzmRxFNgH
         tAeA==
X-Forwarded-Encrypted: i=1; AJvYcCUnHSQQGTfuOXTvvOkLzLjSA5mqG2M9/DqolI7YRf75u0D3Jrafgn69FDkmflW8PLb821Y=@vger.kernel.org, AJvYcCUwJIoaLcFosdUS0zjvC9BEX1B9ThPhkN2rYiNSahE1CM3aUnvwzQTk3OugC3Lq8vqGIJ4J4FuC/QqgdV/X@vger.kernel.org, AJvYcCVcJc7Pp4RdIxgcf2rTcfxodOU183Jw5MoGAhIyxEfSiuYeABdr8Hu3QMzNoqi+3dYHTy0MPXWynCQl2JSZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ydYdXt+bCq86ETyAxLpkRh7tvhy+tMeaDFD/51PQI94GPlte
	DYC8WfKnY1HjxQUbFtQtBD/KtrDKbYpPvND04FwkJsKiq7nJNkHn
X-Gm-Gg: ASbGncscHW0a1Q+1l3fysxeqFyqpcCbSL/2cVrrfRchxDecZu1+JkkUtEVcGliiNMiN
	ikGQ5+9Oj2buCUlq5KAfl3aEWlydU8gn7EmFBrdRc1FG6jdla/q2vmxdtOqGBUEzvi2Cfc+4PmV
	MU8dt6BzcZDqnhDKjK1+BS6ODo67ihftm4zoarOSk49s5FjFgSry5k0a34rXvk7XT5gSy6gccj6
	ev88qjkr1jAw7Hedpufp6vQr3e/XKYn/36k2VlKzLfwO18VG+kkbRWki8PXdwW8NTrPnrVN/gZI
	yS6zZBzHAzJ9UpfgXd6ZAL8=
X-Google-Smtp-Source: AGHT+IFmsgLuuEjHvCGS6xK+KSUkxEbyq3M3cWUJah1M0laeKP1YjZJc3hl5ShQC/nZ44R6jc79QJg==
X-Received: by 2002:a2e:b8d4:0:b0:2ff:557e:b418 with SMTP id 38308e7fff4ca-2ffa71bc397mr57943991fa.36.1732527207876;
        Mon, 25 Nov 2024 01:33:27 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4349e80e51esm40436105e9.33.2024.11.25.01.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2024 01:33:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 25 Nov 2024 10:33:25 +0100
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 3/3] kbuild: propagate CONFIG_WERROR to resolve_btfids
Message-ID: <Z0REZczFIfGHtjsQ@krava>
References: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net>
 <20241123-resolve_btfids-v1-3-927700b641d1@weissschuh.net>
 <CAADnVQL4_8-Y0O3Gar-+q7XKMU6_tY8atEddWB2KsR+DCUZ7WQ@mail.gmail.com>
 <f7764e9b-6254-42af-94b8-41562a18b58b@t-8ch.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7764e9b-6254-42af-94b8-41562a18b58b@t-8ch.de>

On Mon, Nov 25, 2024 at 09:20:37AM +0100, Thomas Weißschuh wrote:
> On 2024-11-24 15:38:40-0800, Alexei Starovoitov wrote:
> > On Sat, Nov 23, 2024 at 5:33 AM Thomas Weißschuh <linux@weissschuh.net> wrote:
> > >
> > > Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
> > > Allow the CI bots to prevent the introduction of new warnings.
> > >
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > >  scripts/link-vmlinux.sh | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> > > index a9b3f34a78d2cd4514e73a728f1a784eee891768..61f1f670291351a276221153146d66001eca556c 100755
> > > --- a/scripts/link-vmlinux.sh
> > > +++ b/scripts/link-vmlinux.sh
> > > @@ -274,7 +274,11 @@ vmlinux_link vmlinux
> > >  # fill in BTF IDs
> > >  if is_enabled CONFIG_DEBUG_INFO_BTF; then
> > >         info BTFIDS vmlinux
> > > -       ${RESOLVE_BTFIDS} vmlinux
> > > +       RESOLVE_BTFIDS_ARGS=""
> > > +       if is_enabled CONFIG_WERROR; then
> > > +               RESOLVE_BTFIDS_ARGS=" --fatal-warnings "
> > > +       fi
> > > +       ${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} vmlinux
> > 
> > I'm not convinced we need to fail the build when functions are renamed.
> > These warns are eventually found and fixed.
> 
> The same could be said for most other build warnings.
> CONFIG_WERROR is a well-known opt-in switch for exactly this behavior.
> 
> Fixing these warnings before they hit mainline has various
> advantages. The author introducing the warning knows about the full
> impact of their change, discussions can be had when everybody still
> has the topic fresh on their mind and other unrelated people don't get
> confused, like me or [0].
> 
> The "eventually fixed" part seems to have been me the last two times :-)
> 
> Given the fairly simple implementation, in my opinion this is worth doing.
> 
> Please note that I have two fairly trivial changes for a v2 and would
> also like to get some feedback from Masahiro, especially for patch 1.

ok, I think it's fine to fail for CONFIG_WERROR option, for patchset:

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> 
> Thomas
> 
> [0] https://lore.kernel.org/lkml/20241113093703.9936-1-laura.nao@collabora.com/

