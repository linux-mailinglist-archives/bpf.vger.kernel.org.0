Return-Path: <bpf+bounces-32856-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69050913DCC
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 21:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99F631C21445
	for <lists+bpf@lfdr.de>; Sun, 23 Jun 2024 19:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D09D18411E;
	Sun, 23 Jun 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKjUeWgY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7B13BBE2
	for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 19:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719172406; cv=none; b=d/PL1c84HEbQO777qhg4+dKpeZ6QM7L9ISGiKR+q1RcJ9uWkdzAojP/SMLHEGuRIBq/KvA78f/lPBbcDN3KUKOmImJwL9X4HNLKfZ2ugJ8yQjEKMWl8MNwX+4q5Ljidv09qCCSs/0pzxNVZZMINRCffhwMvhCUuNfAqkW1fSpnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719172406; c=relaxed/simple;
	bh=PVBGK/hSxUbHfl98NLcz0qu8flIaeo3iWY5FdSIl6KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7zE/X3Fm+u8t760ed2ElW3mrloubII72OifQubneIYiafYes5izOxEVlFfLbYJwMRnKE8CHCK9l8fHv5UoOwt72YWIzkFTrOGojRDNzWZhdu1G5zvjJdzVVYyQ0xRTBRaTZUlvHTiFY4xeZTNFSMdFC32hGdytTFf79dJs+vTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKjUeWgY; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-36532d177a0so2197873f8f.2
        for <bpf@vger.kernel.org>; Sun, 23 Jun 2024 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719172403; x=1719777203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PVBGK/hSxUbHfl98NLcz0qu8flIaeo3iWY5FdSIl6KI=;
        b=CKjUeWgYd8tFc6yaMOx5k89j2/Tm0PXwWcNRz6Y5hxSwoQHSW8v5mf7shXzMdwKoUS
         WD6rpzQ8sPTLtO5jLAEIO0GqsR96BZ211ex7NzB+xcBPVWRbgx9eSelPFLCvFMONmB+o
         H366TlrkMAsUggukqw9LlERRpmfpq5wpIrWGe7vOZN4SdHo9w2/uuwJj44IPDinqunSr
         eXudRp7u6XRUh7JxJoba7QrkzoRtIWV/pd58qSGWKlZdEki6E8zx1J6woNc1Ofv/pfN/
         VktSnvFmWIaIm5we2AgFXWkcINa9VCK7WG4FRdGPrKOAwUuQcgxVKz6oKmz1eDOeMFQs
         gJew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719172403; x=1719777203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PVBGK/hSxUbHfl98NLcz0qu8flIaeo3iWY5FdSIl6KI=;
        b=Pb/GNgb6XGrzBsonhiF3S2VgxPmtik4StnQl42HlaBG9YG8E6ipK5tTpWzzA7O1Hn7
         4sZAHjDLMUes+buyjRsAeDCd5/65hUvPCyRIDXb0C2nZRsOKnOKnu2jPxYoZ9MNNjrGJ
         7MgChgBygj0fOzjQUtEERUYg7jwhKdbOebHcRcm1w9PiFlkUarOO15Mo1jzOwQH/0dPr
         upjedoTA1IWUgSmtmjSZlwHLvNKfROIQdrW+TQwVdqMCDZv43AIlHghcQPQHY7I77bf4
         Fc9t8+QSjUr9M/DCy5JpsB8lEykSxHDhZ8IdaBNCR/UAFlRjdti6B3hVvzbNRjqNR+Sa
         O+Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXUY+M64R6Y03vYTftM+X7U3rBYWCti7g/N7B7nWutL+Nnp597NsUnCYJe/OBiVXdM+l3PhNzgExkZhWnoseVuVTAUB
X-Gm-Message-State: AOJu0Yy1cabFOA1P7IDWbeZDP0fdJ4wx/1m+FkUquApOKRO0SiH5xT4E
	OebZtPfdG6PRbPU9irGv8BnCWxeWcWnP4teDx9RVpYGn1ysCk+JN5Ept3fyEArt+kdI4X5mu03U
	3ovfzZzaKx/ZUtkv/TMBaTbunNp0=
X-Google-Smtp-Source: AGHT+IEIH3vzdv276VOGMK4jKQMS41EX7eA76wmzhWf1X+7Cv40nsEX2RGWQ0k1firH7xKXETyp9nFXvWiUkSnlYme0=
X-Received: by 2002:a5d:598a:0:b0:366:eeea:c4d1 with SMTP id
 ffacd0b85a97d-366eeeb3980mr1142341f8f.35.1719172402445; Sun, 23 Jun 2024
 12:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240623135224.27981-1-alan.maguire@oracle.com>
 <CAADnVQJ_s3FyRo3J3cNTETd3ZSFsFdTvxWy+HnRDzT9LuKrSSA@mail.gmail.com> <9cfd00b0-8a7d-4c38-9eaf-3a529ffa5ca1@oracle.com>
In-Reply-To: <9cfd00b0-8a7d-4c38-9eaf-3a529ffa5ca1@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 23 Jun 2024 12:53:11 -0700
Message-ID: <CAADnVQ+-FZrQgtFHhBFWU_Ux++2KCtM+hO0uJXPHrkV3VjXErg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: fix build when CONFIG_DEBUG_INFO_BTF[_MODULES]
 is undefined
To: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jiri Olsa <jolsa@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	"Luis R. Rodriguez" <mcgrof@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Kui-Feng Lee <thinker.li@gmail.com>, 
	Benjamin Tissoires <bentiss@kernel.org>, Geliang Tang <tanggeliang@kylinos.cn>, bpf <bpf@vger.kernel.org>, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 12:04=E2=80=AFPM Alan Maguire <alan.maguire@oracle.=
com> wrote:
> I've been trying to reproduce this with no success I'm afraid. I may be
> misreading but it appears that the diff from baseline to new build is
> actually telling us the btf_relocate_id() issues went away
>
> https://netdev.bots.linux.dev/static/nipa/864622/13708618/build_clang/std=
err
>
> shows (note the "-" in the diffs preceding the btf_relocate_id()
> complaints):

Ahh. Makes sense. Applied.

> I did find another issue in tools/lib/bpf/btf_relocate.c when compiling
> with clang that I'll send a patch for, and there's an existing issue in
> btf.c that generates a warning:

Thanks!

