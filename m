Return-Path: <bpf+bounces-1181-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6E70FE02
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 20:48:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67FF31C20DFC
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C48119BD8;
	Wed, 24 May 2023 18:48:33 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D37C13A
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 18:48:33 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9C4198
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 11:48:30 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-510e419d701so2919565a12.1
        for <bpf@vger.kernel.org>; Wed, 24 May 2023 11:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684954109; x=1687546109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YeBQ8BKZKTkuj3WAWIBwJUYNST+qJ28Y3Dw6dyJXVY0=;
        b=LsO8bP0vCA+A7mXDCSMB1/PKKkPBUkbBKZPfmhz6QDenSSeiV25baoyGwfpUdxVbFA
         wRNqPWxsMtF44Mg+mONarSkyMakmeScYFE4kOkxi9XsyRCyOu0HFqVbVScTP/DXYxo+F
         noyOPFmqqvNqGj7EJdew2x0j+xWNlWzhKbGh++nSSAESaLKo0LAvR6SSCdmEWmB5GlvV
         9C+XYrqCD/P2MrzICouP2iD1tRTOp76E7Am7lbabXOrPCwsPJ0qhOJWzyqjAj2iiHIp5
         l20U3B3IRHb4iK91lH4YqQ5N5t+n7DTyaAnoIR0wAusowXEBudNqLlWuP5C8bV1VDHk6
         uq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684954109; x=1687546109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YeBQ8BKZKTkuj3WAWIBwJUYNST+qJ28Y3Dw6dyJXVY0=;
        b=Yt9JlQwp5hW6qhhxTjEfHh4Wi+OMBnyg+53vOHR6+qV2pc52LfFg8gQEWPnEbrmu61
         cfhLgwJIFHZJCJacXxr8/k0JWNWBkIX3sqOrV159tDH5hMsgdLadTbce8Evt0VKlF83A
         OZRuRp1TXoEubg7+f1FFUylINzCNvkGjmZCzFNY1ZDH6BpxXFC4OP6TGnqhNxagSGXk+
         1t/vnWqymqdITtqdn4NWAHx87ZFveMmv98dxkF5tneYtYruzF+UwgqHjcarHc+7xreux
         NKdJ8XwVCl6o3UIriKSqzwM3BnJ/RwvngaqH+lblz1ex+ByN62H/FxPq86TdbvedyZKT
         6Qww==
X-Gm-Message-State: AC+VfDyj/QFnOH0Q5Zhols2OdpFhX/QhH4ljGkVohOuqsuVkUxWkvbWX
	wR+SQgncZMkXa1wHp/ttLypHhKqF2k8bYVSWAAs=
X-Google-Smtp-Source: ACHHUZ5+v0881MSb4i7c/wKk1xPvYTMpySCOp5/ffQDjcTq3X0U6FPYcafPvpLRVoK/PCwCYxMQ+Zj4zMCFI/gmobbI=
X-Received: by 2002:a17:907:3e9f:b0:96f:e7cf:5015 with SMTP id
 hs31-20020a1709073e9f00b0096fe7cf5015mr12121496ejc.17.1684954108587; Wed, 24
 May 2023 11:48:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230524004537.18614-1-inwardvessel@gmail.com>
In-Reply-To: <20230524004537.18614-1-inwardvessel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 24 May 2023 11:48:16 -0700
Message-ID: <CAEf4BzbTPUzVf0F7FffP3+C+osiDVZPFfzVJTGtPrtf09AXHMw@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 0/2] libbpf: capability for resizing datasec maps
To: JP Kobryn <inwardvessel@gmail.com>
Cc: bpf@vger.kernel.org, andrii@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, May 23, 2023 at 5:45=E2=80=AFPM JP Kobryn <inwardvessel@gmail.com> =
wrote:
>
> Due to the way the datasec maps like bss, data, rodata are memory
> mapped, they cannot be resized with bpf_map__set_value_size() like
> non-datasec maps can. This series offers a way to allow the resizing of
> datasec maps, by having the mapped regions resized as needed and also
> adjusting associated BTF info if possible.
>
> The thought behind this is to allow for use cases where a given datasec
> needs to scale to for example the number of CPU's present. A bpf program
> can have a global array in a data section with an initial length and
> before loading the bpf program, the array length could be extended to
> match the CPU count. The selftests included in this series perform this
> scaling to an arbitrary value to demonstrate how it can work.
>
> JP Kobryn (2):
>   add capability for resizing datasec maps
>   selftests for resizing datasec maps
>
>  tools/lib/bpf/libbpf.c                        | 130 ++++++++++
>  tools/lib/bpf/libbpf.h                        |  17 +-
>  .../bpf/prog_tests/global_map_resize.c        | 236 ++++++++++++++++++
>  .../bpf/progs/test_global_map_resize.c        |  58 +++++
>  4 files changed, 440 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/global_map_res=
ize.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_map_res=
ize.c
>
> --
> 2.40.0
>

Thanks, it's a great feature! I did some formatting and cosmetic
adjustments before applying. I also rolled into the first patch a
change to make bpf_map__initial_value() return non-const pointer, as
const pointer doesn't make much sense (this is backwards compatible
change). Applied to bpf-next, thanks!

