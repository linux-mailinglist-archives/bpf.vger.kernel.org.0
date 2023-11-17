Return-Path: <bpf+bounces-15274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C39687EFAF3
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 22:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6838428132E
	for <lists+bpf@lfdr.de>; Fri, 17 Nov 2023 21:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409BA199BE;
	Fri, 17 Nov 2023 21:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOfCOflu"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A08FB4
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:38:21 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-32ded3eb835so1783213f8f.0
        for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 13:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700257099; x=1700861899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnQBG22kioteX6ZJySJyfSl6M22cisJWPPx+CaN7Dxg=;
        b=KOfCOfluWXG+UGxMQzIgTdwBGdhD1CCzq2s+tEwQQEMX+e2nXtuS22/2/E5JGT8Qr4
         YdoqDPGux0ozQrme8wyab/93AZsZ3RYaXvIzs+/kto+a9zny8/ZkIEEvw3XGn4qFOuC6
         s4Xnrdv+8SXCgDbQZemiGyhLlEd4jFaSgcAKqf0WQY4AvLP/oOLeoDYdFBYKVvad+2ZS
         BpXcPAgwWltsT7UaskHsWRKC0fang4SizWBLLEXxKllydqiFiJ6eJxMssullUsypclxM
         pzKocvdwRS0QNHtn5mOIJ0Gg6gUIbn8+XEfQNZQ+dPm6Exr+YEh5mi5LLMvKl7ydo+6U
         7WvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700257099; x=1700861899;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SnQBG22kioteX6ZJySJyfSl6M22cisJWPPx+CaN7Dxg=;
        b=ZU2gZ5zeLeJR4w8jfvPkYlrBJjYNKjUdnzVhc5ugECXkcx+49lOyApLa179efY6FvD
         eR+3aOAhlAErE4b9Vi1kKP5a9xR2ke+A3AGu2PN8Lcfn8P45BzZ1IIegG+D1T495zlA6
         Afn8JtwBJQCUmubatOCZCscjQZsZMpZd+wIxiXZbVpTl29U+hSoVygQmdP3n0v7AodgD
         MEwHANvxXr97LqHEvIF/vk+PtkDdPmpIpjQ9x5Ba0s4XArMgAdzCTPiHgLj8lmN3geGy
         h/mKFBhiI/9utgJRYPjhWQkp1uRRthWPHjZbLuDo+AvXgxc5ZhBUd4xFFN/IDwooXIbE
         NoXw==
X-Gm-Message-State: AOJu0Yz/dGTCBVWQW2x6aL0vQhwY1YTJhKqwQEkFa/G0cJcdSlZep+5u
	2g3NNbnrmjZrAGgBOEP1DYYmWVxuhl6K8REmaVQ=
X-Google-Smtp-Source: AGHT+IEq8WjEsWmWkaJPgMDlww07kiHSqMAa6AXsjWW1GXg7PINxL1gBR0lL3FwvByHIssT5TaNS1Uo8ZKjj3r9e530=
X-Received: by 2002:a5d:598a:0:b0:323:1d6a:3952 with SMTP id
 n10-20020a5d598a000000b003231d6a3952mr198649wri.4.1700257099461; Fri, 17 Nov
 2023 13:38:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231116021803.9982-1-eddyz87@gmail.com> <20231116021803.9982-4-eddyz87@gmail.com>
In-Reply-To: <20231116021803.9982-4-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 17 Nov 2023 13:38:08 -0800
Message-ID: <CAADnVQKr+OwMKY6OofP8JiJjrEF9wmSF0+68h0o4yeNXCFvEhg@mail.gmail.com>
Subject: Re: [PATCH bpf 03/12] selftests/bpf: fix bpf_loop_bench for new
 callback verification scheme
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Werner <awerner32@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 6:18=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> The patch a few patches from this one changes logic for callbacks
> handling.

That's a wordsmith level 10. I'm far below this level.
Could you please rephrase it? 'The next patch changes ...' or something?

