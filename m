Return-Path: <bpf+bounces-45550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B93799D7925
	for <lists+bpf@lfdr.de>; Mon, 25 Nov 2024 00:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A06F162A0B
	for <lists+bpf@lfdr.de>; Sun, 24 Nov 2024 23:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D267F17F4F2;
	Sun, 24 Nov 2024 23:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ugu0aKRE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8006163;
	Sun, 24 Nov 2024 23:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732491535; cv=none; b=I/v+ZAj82//CA8dt3UGxn31Z0x6+yyKz9a9hoP6BFLHdGZrEzjq0NI8vu0hgHwsBMvPoTVcN0Yy+utvmtZjsWY7w6dkAjo2QWczdYdY81SFXHQGbZrPUIQnmg+DuJYgFZ1M6VeY8UXtcmab+i6HQc/oghSFZaaVxdY2Ei7Bqgt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732491535; c=relaxed/simple;
	bh=8SQ+J63HVShrnXhCtUVH9qR8rYn1uSBrX3T1jMaSO8s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OBRGEI6Syoa9flyvSCane/ihiSmAmIQxVrbIDl4mrLJNcIjLUGiKN5GmirVhYP5bH94910AdHZcqAPGkehE38PX9nCSJwNclWmc6bPx95fSJuRaf1rq5sSwz9ypGLpHEXHQvm/ow9Y2I2vXtb28yLCeLMoi4clvaMNQOaxaylZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ugu0aKRE; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-382433611d0so3339306f8f.3;
        Sun, 24 Nov 2024 15:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732491532; x=1733096332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHh0v4A1wHYmeUIn0vQbLQPh165dOpBe10O5Rhogzjs=;
        b=Ugu0aKRExBHifKqxC9LQhBecFmgp9RndalZVONQdaESAxktfSRtqryUFM03eGTIV92
         FnVqiLCZCHc/Vf82h1LkvZZ51yAl/S1/F/WtxSDshYHZ8CquTJ962P8xFESZHTYFDLHH
         gtc3CqMulYjLJsrMX6Q0+dgTpOkeHKrHD6NGI45+sfNhRAdQVXHJArpzNElQH9F0M0GZ
         gze104YODT7+3kThIYVk4VOJuIFKF/9OMtSKqLVZIX7+lFvRrrQsQKj2vRMTby7zwsrL
         PywXF6nPU88W/sY5blczb3oQDWFVrodTeQpHERfzHAQNFPt2RyA/Subh8lVTUOEgmaXZ
         kmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732491532; x=1733096332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHh0v4A1wHYmeUIn0vQbLQPh165dOpBe10O5Rhogzjs=;
        b=Soa/xGuLAuPqz1z1ujCuld6Mkh7A9dRyI7vIrfRSi53ju34b/s8nJwVgotOj8vSYMv
         vsO1Y4oVwIqos12ma9QIupdHpkMErFn8LxrDLVpezkDtBsC4U+f6YBKpVLKvMuLrjC2I
         sDNKiMdqqOty9TO6FftRX41+/8mNDFH4VCCyA3xM3melhU+M7BtE2aAnMTLxBCUEU3a4
         GKW2wFmA16lLMrD7BUS8QZV0aomqTLb5jKvD6HdUPKQd1IB8YZ0rCoK15K4VIRnMpXYz
         tPeoCSQB9q6p+Nxap+gY2eVmAI7QvPzmUmL69wGOl55LVXd35TK+SpVe8D2U0MwW8yTY
         mXvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/p/kXj6GB9HJ9RRGHchrTp0WhV7eHS/RVH8IKxNaiXQYwZXFY+isrHdIbMKvH3JhP7ul536RlI3FYOTd8@vger.kernel.org, AJvYcCX1QMwZG1kHoZufWNOVqdJz8WuISvwQBRdzExeXyVGMWfpkftzL4Y52HfOoahQ42B637M/r9Twnmcb5nhsb@vger.kernel.org, AJvYcCXp1+dp2sIa1h/qS6EY8SueNdH37WZXFT7huiQYkP14vUFkORk4dXfnfP0mrfC7Br7vTjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YygpB7FOS6zYG+BOpcFl5Od0elC0Jv74nmBD+EqjKgW8YrrgyGf
	XlEkhipAOqFzsEj0Tooz03NSHaZ2FW70CwNqgpp5Ga9ONOA7052yPzW9r0AJO6WZrbGGV4xx8+I
	WO3IAjJG9rvmwxUEG3JqO8XxtcJE=
X-Gm-Gg: ASbGncuV+Jz0bFb5oPTO+bLM6n4RCroLRJbt0wvIY3+tsj2ZJQIKGYoQTo6fX4vuBOL
	ibDNFe7b6UOI2TSfOngySeF418Woz/7+nC56PrHCOp1vx0Kw=
X-Google-Smtp-Source: AGHT+IFtzmY/vNk6izlROvLojAbhliQ4PUaKj+9+Fj+xXtS4EYMty6kwNiebBqq174/NdLndEPvCRkoDHwD6TvipVZU=
X-Received: by 2002:a05:6000:2d06:b0:382:4fee:c263 with SMTP id
 ffacd0b85a97d-38260b5385emr8512087f8f.20.1732491531829; Sun, 24 Nov 2024
 15:38:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-resolve_btfids-v1-0-927700b641d1@weissschuh.net> <20241123-resolve_btfids-v1-3-927700b641d1@weissschuh.net>
In-Reply-To: <20241123-resolve_btfids-v1-3-927700b641d1@weissschuh.net>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 24 Nov 2024 15:38:40 -0800
Message-ID: <CAADnVQL4_8-Y0O3Gar-+q7XKMU6_tY8atEddWB2KsR+DCUZ7WQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] kbuild: propagate CONFIG_WERROR to resolve_btfids
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas@fjasle.eu>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 5:33=E2=80=AFAM Thomas Wei=C3=9Fschuh <linux@weisss=
chuh.net> wrote:
>
> Use CONFIG_WERROR to also fail on warnings emitted by resolve_btfids.
> Allow the CI bots to prevent the introduction of new warnings.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <linux@weissschuh.net>
> ---
>  scripts/link-vmlinux.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index a9b3f34a78d2cd4514e73a728f1a784eee891768..61f1f670291351a2762211531=
46d66001eca556c 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -274,7 +274,11 @@ vmlinux_link vmlinux
>  # fill in BTF IDs
>  if is_enabled CONFIG_DEBUG_INFO_BTF; then
>         info BTFIDS vmlinux
> -       ${RESOLVE_BTFIDS} vmlinux
> +       RESOLVE_BTFIDS_ARGS=3D""
> +       if is_enabled CONFIG_WERROR; then
> +               RESOLVE_BTFIDS_ARGS=3D" --fatal-warnings "
> +       fi
> +       ${RESOLVE_BTFIDS} ${RESOLVE_BTFIDS_ARGS} vmlinux

I'm not convinced we need to fail the build when functions are renamed.
These warns are eventually found and fixed.

