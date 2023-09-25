Return-Path: <bpf+bounces-10813-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 944777AE221
	for <lists+bpf@lfdr.de>; Tue, 26 Sep 2023 01:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 44A5A281680
	for <lists+bpf@lfdr.de>; Mon, 25 Sep 2023 23:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 846A526294;
	Mon, 25 Sep 2023 23:15:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF415E91
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 23:15:52 +0000 (UTC)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37040139
	for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:15:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2bff776fe0bso126215221fa.0
        for <bpf@vger.kernel.org>; Mon, 25 Sep 2023 16:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695683749; x=1696288549; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6UrUsb8kUVmGxE/Vr0fCkoXNnXe6eSFd17zxm7Z1Gw=;
        b=HRTUnSd4+NlmxRGrqkr69vDqKWztTaOkOTrA/ROdhDW3j0uLLL9i2BWUWoViK2aCa2
         hmS2NUYMKNbOc6kImVvhprzOTtKtTzDLL9ENKecThYnEotj0LA+i0HoY78AV8CSqPHIW
         u1C1qFLARynSAQBlfuBmaP6PVrg9D5p53cwF6yTkptbk3Q9ZrNki/q8yugk+slw9atSo
         U9UJkHDcAPnGLalWTu1VZePyR01HcBeBu7yHVBwtyvQOfSRjWHJtOTc6qkPWhDvR257J
         ulsEzFG4waJwLLH7W1xN5iP+VBotqbx/kCLOMLeBD12m+0YnV9BkijTDWaZ9Y3RLGgxl
         b83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695683749; x=1696288549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6UrUsb8kUVmGxE/Vr0fCkoXNnXe6eSFd17zxm7Z1Gw=;
        b=pw5aA9MIpQEX+dVZGlBFs2L9L6FfZOZSrYIJ37Bgak7bJoprFmWD4376NaeYtPwPj+
         pQI4x00A0K1Z102So4gq493PObmwlE16juAlXuKc9GhRuQaOfMkdO3McEZv2cPa4xYv9
         A3HgHuQClraH43T/BRW8AqV16iZvSaUqNgXUUOR/BU7vWc7ZL355h/ZDet6mdpp2HFtH
         O3kTz2XDQUpPE7B19ICzGMcYAixygaty1LeQnUdwC3dnXg1PVuQOZp1X8+JRjXsKUyKL
         7AmXKmfVrEQ23x4s8z5tfHRxLb/dK+QnXLpsKEkStc++rbttzto9jf1N3Ir1j7VgoqiF
         uVNw==
X-Gm-Message-State: AOJu0Yx3QYQOIXl1Sv45PLK5LEBJg3Gs2z8byXhrX/clE9/AtENOLPqy
	4/bJeKL13hosLncGPdjsweXyC3TDe3QxyeaCk+A=
X-Google-Smtp-Source: AGHT+IEFDqwSa7bi2oUzYp3GZ1w9yHaC154MCTVZF8BFK3djSDa0Iz9D7W1Xpbku0HKSl4oSz+/T6BTQvGddw2/2+ys=
X-Received: by 2002:a2e:95c7:0:b0:2b6:a804:4cc with SMTP id
 y7-20020a2e95c7000000b002b6a80404ccmr6315674ljh.53.1695683749079; Mon, 25 Sep
 2023 16:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230925025722.46580-1-hengqi.chen@gmail.com>
In-Reply-To: <20230925025722.46580-1-hengqi.chen@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 25 Sep 2023 16:15:37 -0700
Message-ID: <CAEf4BzYXwJcT0Ofetjw1qxKkXspqwcwaRkR=8xitJARirTrQgw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Allow Golang symbols in uprobe secdef
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Sep 24, 2023 at 8:19=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com>=
 wrote:
>
> Golang symbols in ELF files are different from C/C++
> which contains special characters like '*', '(' and ')'.
> With generics, things get more complicated, there are
> symbols like:
>
>   github.com/cilium/ebpf/internal.(*Deque[go.shape.interface {
>    Format(fmt.State, int32); TypeName() string;
>   github.com/cilium/ebpf/btf.copy() github.com/cilium/ebpf/btf.Type
>   }]).Grow
>
> Add " ()*,-/;[]{}" (in alphabetical order) to support matching
> against such symbols. Note that ']' and '-' should be the first
> and last characters in the %m range as sscanf required.
>
> A working example can be found at this repo ([0]).
>
>   [0]: https://github.com/chenhengqi/libbpf-go-symbols
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b4758e54a815..de0e068195ab 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11630,7 +11630,7 @@ static int attach_uprobe(const struct bpf_program=
 *prog, long cookie, struct bpf
>
>         *link =3D NULL;
>
> -       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[a-zA-Z0-9_.@]+%li"=
,
> +       n =3D sscanf(prog->sec_name, "%m[^/]/%m[^:]:%m[]a-zA-Z0-9 ()*,./;=
@[_{}-]+%li",

This is almost incomprehensible now... wouldn't it be clearer to just
have a catch-all %ms at the end, and then internally checking if we
have '+%li'? I.e., once we match everything after
"uprobe/<path-to-binary>:", we can strchr('+'), if found, try
sscanf("%li") on the remaining suffix. If that doesn't parse properly,
then we have a choice -- either error out, or just assume that
`+<something>` part is just a part of ELF symbol name?

That way we don't hard-code any fixes set of symbols and avoid any
future crazy adjustments.

WDYT?

>                    &probe_type, &binary_path, &func_name, &offset);
>         switch (n) {
>         case 1:
> --
> 2.34.1
>

