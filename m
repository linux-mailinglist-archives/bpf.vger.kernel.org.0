Return-Path: <bpf+bounces-1055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D272970D00D
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 03:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AD21C20C0A
	for <lists+bpf@lfdr.de>; Tue, 23 May 2023 01:05:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3B81860;
	Tue, 23 May 2023 01:05:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8971847
	for <bpf@vger.kernel.org>; Tue, 23 May 2023 01:05:30 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921918E;
	Mon, 22 May 2023 18:05:28 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso2701098e87.1;
        Mon, 22 May 2023 18:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684803926; x=1687395926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cPEvgakMKy8aZ6tk74VpcoeTVjWwOIUcBBI8spB66g=;
        b=Z/NGPFUGaecALydozi/TCKrIYcXcYTVX90l5U9oYzOU924lK3YAa5dgFpxjm8W7qV3
         j8Is69+TGKclTLvyKdbchf1VgCqt5v32vSZgaGXH//7R/hGJXGBeaP38OC7VAA+13S2/
         O2oZLOdb8MbSC38s/tnv2GwmrxCEvWvDhMOfVClYaHgJqkzyU93odXSLp/V0m8jEKahD
         /6b4Wk7DbcrTOOc5bMijNuLCp9Yx++ZGdVnMwp7Ogzij1QedjCOPll7ki8KJR0qNRXAR
         YN4oBLtm2lNos8/dnlm7AOQt+XdXaBMSE5fehJRRaG3tuSNFx/0oVDIydAxIgqdYdiDA
         S8Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684803926; x=1687395926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cPEvgakMKy8aZ6tk74VpcoeTVjWwOIUcBBI8spB66g=;
        b=Yz0oG+BQyJF7qmlALTKJjxoKgsvvlmCbh7gvIp2XVNtB5lwUAcOUTOUyMX7/CpW3wm
         X+LPs/d3vy/MEn/HFnzITPUD3Yarc2h7vECH2UwjQTU504c8WKzeRHx9DL143x6F4t/T
         xdmyi9xwLAdEaKVcNfh8kFe7oaIe1opej1ABeHzF0ieF6rVe1YvazGRirgwTviZ0XVBC
         g3UXssiPadMGae5yIsHjTwWUOwB76C2fqbIUnf1x9aSF0uvoep8CHjLtSAA2/jrpNJhi
         /uY2DMc1I/DlU3kkjpQAwvxu3cWgpVpSsbI20+UDWSiDUavtMLxjBoqIo3LngRcITKKP
         m82A==
X-Gm-Message-State: AC+VfDxOB3QYer9bLxomQ0QmI6AMBuZ7MIIJcwD5cxrGR69LN5Q/ADpT
	7teZjeBXCLiyqltaxpOHU55/3fbmbuK8LwwMd9c=
X-Google-Smtp-Source: ACHHUZ6mQJBgPkb3HqOabQYA1hSLgNPEVq7wPHABwM8ZXFt/fEN3HAKp24zyl96sBhqnI2ns5XA75ApWDn48oFqddPE=
X-Received: by 2002:a19:a402:0:b0:4f4:ba0d:3bbf with SMTP id
 q2-20020a19a402000000b004f4ba0d3bbfmr280781lfc.60.1684803926066; Mon, 22 May
 2023 18:05:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230517125617.931437-1-arnd@kernel.org> <20230517125617.931437-2-arnd@kernel.org>
In-Reply-To: <20230517125617.931437-2-arnd@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 May 2023 18:05:14 -0700
Message-ID: <CAADnVQL+K22KEMu8fkQbsdmDAMcws1Cja3iM=E9zPLhDfDWmqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] bpf: add bpf_probe_read_kernel declaration
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Delyan Kratunov <delyank@fb.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Menglong Dong <imagedong@tencent.com>, 
	Yafang Shao <laoar.shao@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 17, 2023 at 5:56=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> bpf_probe_read_kernel() has a __weak definition in core.c and another
> definition with an incompatible prototype in kernel/trace/bpf_trace.c,
> when CONFIG_BPF_EVENTS is enabled.
>
> Since the two are incompatible, there cannot be a shared declaration
> in a header file, but the lack of a prototype causes a W=3D1 warning:
>
> kernel/bpf/core.c:1638:12: error: no previous prototype for 'bpf_probe_re=
ad_kernel' [-Werror=3Dmissing-prototypes]
>
> Add a prototype directly in front of the function instead to shut
> up the warning. Also, to avoid having an incompatible function override
> the __weak definition, use an #ifdef to ensure that only one of the
> two is ever defined.
>
> I'm not sure what can be done to make the two prototypes match.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/bpf/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 6f5ede31e471..38762a784b86 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1635,11 +1635,14 @@ bool bpf_opcode_in_insntable(u8 code)
>  }
>
>  #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> -u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe=
_ptr)
> +u64 bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr);
> +#ifndef CONFIG_BPF_EVENTS
> +u64 bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
>  {
>         memset(dst, 0, size);
>         return -EFAULT;
>  }

This is not right, but you've spotted a bug.
bpf_probe_read_kernel
It should be BPF_CALL_3(bpf_probe_read_kernel, void *, dst, u32, size,
           const void *, unsafe_ptr)
here in kernel/bpf/core.c as well otherwise bpf prog won't
pass the arguments correctly on 32-bit arches.
The kconfig without CONFIG_BPF_EVENTS and with BPF_SYSCALL is very odd.
I suspect the progs will likely refuse to load,
but still worth fixing it correctly at least to document the calling conven=
tion.

