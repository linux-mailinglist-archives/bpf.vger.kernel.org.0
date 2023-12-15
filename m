Return-Path: <bpf+bounces-18042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C31F18151DF
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 22:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1342813E7
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F193A47F6A;
	Fri, 15 Dec 2023 21:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRBTZE/a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1676B47F5E
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 21:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-551437d5344so1411634a12.1
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 13:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702675132; x=1703279932; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qhLCyesvidNeII+r693cw+udgFkyL9CFQnmJdZP9Z4=;
        b=fRBTZE/aJToZPq1gqfu5czD6HKU3mEjjPjyDU47hG3k9YuWbap8JBS3Pbp/T4D1nc2
         t5G4lrudo3JwEyQ/rzAUUFEdqjO9QhBU6K8T0FtxzMZs2buMnmtwPrHIQSmIlIU6UVh7
         4mvgoGkkelHnobWcKEw2JkZBn7iE9lonVZMXwVHQsN1Y+m2hIn4oYJYGY2JkYuteYPlG
         KYiObn2A6TtrwPz9Im27eWS7tXSSt7uWAJjG5OibqihLyr5K+v+6Rv1sfdskvTtHV6bj
         RNqN4aKQxLRc3O6mAUnCEBLoxP1bzHQSIqnmFv+tqDEX66kt8WheHK6jKCzvA/AnnFVB
         PWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702675132; x=1703279932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2qhLCyesvidNeII+r693cw+udgFkyL9CFQnmJdZP9Z4=;
        b=Co4tkfpFZUQRzy9LJYUpd1bEojjckKFnaQrLuAbZDvJ+GBQQrN2FIFTlWhwY9Ays2Q
         Hb1HGwJEYvFHetzPGx671aIst5Db9ZhZUtudQWxFNubqbhgzGza6LZVSDd5Upkkm/3wo
         RyKOUztCWu5+WyI0e9hVPhgpQgVKH25ujuUvb7ZxpCULpE6279MQnrjuZlfqi9eP89Uc
         +CKd9x8szxkwBTcDdLM1y6QTGj3YZpI1cKMQ5ADx+btzoUvsUscS1rxBdRPJSV64qe2I
         t8zQnVSiD0PSOIUAKQnlRYTJRJI/y8wEHI40DEC0GqVGHsWhZsTek5jcJpiqIlnDYrvk
         EyEg==
X-Gm-Message-State: AOJu0YzZ/fSQ0jW1v0MWy3l5Sd3dkSS5ks/h0VtHJheDf2Jg1+1MHW+B
	bZyOXkCr/QeVI9dNzY+zRYW42+22xPVK8xZyluw=
X-Google-Smtp-Source: AGHT+IGkVcqRTYPOM93uDwsXWDxTmvtkojGmHgM5YwJWH143MTU8AwhtXPE/f3LZEONenkzyfEkAczowSOoMDSS7SS8=
X-Received: by 2002:a50:d547:0:b0:54c:4837:9aa1 with SMTP id
 f7-20020a50d547000000b0054c48379aa1mr6583364edj.72.1702675131996; Fri, 15 Dec
 2023 13:18:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215091826.2467281-1-jolsa@kernel.org>
In-Reply-To: <20231215091826.2467281-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Dec 2023 13:18:39 -0800
Message-ID: <CAEf4BzZyZBED8cLNBufbQreQa2G+3uD10jpVYT8xjrZKDhy8xQ@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Add missing BPF_LINK_TYPE invocations
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Pengfei Xu <pengfei.xu@intel.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Hou Tao <houtao@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 1:18=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Pengfei Xu reported [1] Syzkaller/KASAN issue found in bpf_link_show_fdin=
fo.
>
> The reason is missing BPF_LINK_TYPE invocation for uprobe multi
> link and for several other links, adding that.
>
> [1] https://lore.kernel.org/bpf/ZXptoKRSLspnk2ie@xpf.sh.intel.com/
>
> Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
> Fixes: e420bed02507 ("bpf: Add fd-based tcx multi-prog infra with link su=
pport")
> Fixes: 84601d6ee68a ("bpf: add bpf_link support for BPF_NETFILTER program=
s")
> Fixes: 35dfaad7188c ("netkit, bpf: Add bpf programmable net device")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/bpf_types.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/include/linux/bpf_types.h b/include/linux/bpf_types.h
> index fc0d6f32c687..38cbdaec6bdf 100644
> --- a/include/linux/bpf_types.h
> +++ b/include/linux/bpf_types.h
> @@ -148,3 +148,7 @@ BPF_LINK_TYPE(BPF_LINK_TYPE_PERF_EVENT, perf)
>  #endif
>  BPF_LINK_TYPE(BPF_LINK_TYPE_KPROBE_MULTI, kprobe_multi)
>  BPF_LINK_TYPE(BPF_LINK_TYPE_STRUCT_OPS, struct_ops)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_NETFILTER, netfilter)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_TCX, tcx)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_UPROBE_MULTI, uprobe_multi)
> +BPF_LINK_TYPE(BPF_LINK_TYPE_NETKIT, netkit)

let's reorder keeping UPROBE_MULTI first or last and then guard TCX,
NETFILTER, and NETKIT with CONFIG_NET? This is based on similar guards
in BPF_LINK_CREATE handling.

> --
> 2.43.0
>

