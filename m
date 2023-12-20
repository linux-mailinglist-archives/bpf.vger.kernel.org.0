Return-Path: <bpf+bounces-18359-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E79819716
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 04:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CE91F2647A
	for <lists+bpf@lfdr.de>; Wed, 20 Dec 2023 03:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0070F883C;
	Wed, 20 Dec 2023 03:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJ+LlchS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4E156DD
	for <bpf@vger.kernel.org>; Wed, 20 Dec 2023 03:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33678156e27so455451f8f.1
        for <bpf@vger.kernel.org>; Tue, 19 Dec 2023 19:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703042154; x=1703646954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/CrLnxMRSrvlfnjGyC6iy0wIbb6Nuyt+sfPMzhghKE=;
        b=eJ+LlchSAzw0qcXafzH7Q7oA5Mfyl1jrTYaC420ZhXU5c713vZh7alwi+Ta4p2y8hM
         xvnDj4Phca84oRU6s7eE+VGfuLdsEGdfRl+sbDBOa4fZODlvos2ggd+PqNuuG74Ka8Kh
         x68kfiuPcfFp+PorgB5HlRFQCf34wyF/2Czy0aaJAiCWDAdTcGdfqFZe6a8FDjTDfy7s
         2vuffGifAYub7H/WQSTw/rjBNnrRVQF74tbfOyvztL6rR3mUk1Hd90nTRdU5dLkEsfqv
         0B5UPbCej4Rrr78j13YU+S37X1w4iFtTRvrdIwVXRqQpQTLzaNY3fMbfpgYyOSMuARuP
         912A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703042154; x=1703646954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/CrLnxMRSrvlfnjGyC6iy0wIbb6Nuyt+sfPMzhghKE=;
        b=n/QRCNyaxGPJALO41PkqRfiZjS+WogopwMuRhaWI+jlG0SdT7hrzxiUi7yf6cFV0MF
         bEILXXZBX/MsVmnR/LUEcY/T0oW1tlLG3KdV6jp+cySI6lgOhEx0fovFP6R22wixcsHO
         cd/xkko5HnnmOCavW+vc/fXrYTKsjXAaRGCYNS3pu1gAuhFT38ZD71FPShMH/Aanjgr1
         Y3q7CKI88VqPebX/8oLTHjLV2MF5DzFjq4QgSYlgT2Yix00lC8F8H7aYPi2XE8EsU4Ms
         uskfhWw2Rh5QTQVK5LY0e/XQchKSqqyGPqPOl1iHfY9GiFqvqTuTIITVdBilmtr6QKqJ
         IVhw==
X-Gm-Message-State: AOJu0Yy//wDBfYgSyetXjpa0nTjJ7P8/LWL6av/34LdhaIfM1ASArpQu
	zWF2rFzpBRt0zKaNX6g+HCFmTSJIkXNJx2/Qt9c=
X-Google-Smtp-Source: AGHT+IGkzwnTsTL67YampZx1yDCiX3p2+KcS6sn+10w+zwu888uNrQMAo92Gm4sz9VZIJtnzJb49NemM28sLTHQgP+I=
X-Received: by 2002:adf:edc3:0:b0:336:6f9e:fb7f with SMTP id
 v3-20020adfedc3000000b003366f9efb7fmr1396697wro.0.1703042154413; Tue, 19 Dec
 2023 19:15:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67b0a25f-b75b-453c-9dde-17adf527a14a@app.fastmail.com>
In-Reply-To: <67b0a25f-b75b-453c-9dde-17adf527a14a@app.fastmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Dec 2023 19:15:42 -0800
Message-ID: <CAADnVQLYafmCffxbpxcTFf09W6XqgXCRH6V4gpRL+82+OMMVMA@mail.gmail.com>
Subject: Re: Dynamic kfunc discovery
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 9:29=E2=80=AFAM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> Hi,
>
> I was chatting w/ Quentin [0] about how bpftool could:
>
> 1. Support a "feature dump" of all supported kfuncs on running kernel
> 2. Generate vmlinux.h with kfunc prototypes
>
> I had another idea this morning so I thought I'd bounce it around
> on the list in case others had better ones. 3 vague ideas:
>
> 1. Add a BTF type tag annotation in __bpf_kfunc macro. This would
>    let bpftool parse BTF to do discovery. It would be fairly clean and
>    straightforward, except that I don't think GCC supports these type
>    tags. So only clang-built-linux would work.
>
> 2. Do the same thing as above, except rather than tagging src code,
>    teach pahole about the .BTF_ids section in vmlinux. pahole could then
>    construct BTF with the appropriate type tags.

resolve_btfids knows about all of them already.
The best is to teach bpftool about them as well.
It can look for BTF_SET8_START and there it can find btf_ids
of all kfuncs.
From there it can generate them into vmlinux.h

We wanted kfuncs to appear in vmlinux.h for quite some time,
but no one had cycles to do it.
Still an awesome feature to have.

