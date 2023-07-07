Return-Path: <bpf+bounces-4496-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A5A74B8AE
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 23:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39A8A1C210D6
	for <lists+bpf@lfdr.de>; Fri,  7 Jul 2023 21:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFF217ABE;
	Fri,  7 Jul 2023 21:31:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3951C10977
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 21:31:37 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00721FC6
	for <bpf@vger.kernel.org>; Fri,  7 Jul 2023 14:31:36 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5704991ea05so28182857b3.1
        for <bpf@vger.kernel.org>; Fri, 07 Jul 2023 14:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688765496; x=1691357496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ0V6nTCT3uhCFN1topUMvhFZXj9rVKOhLzdkHpftz0=;
        b=24sULn6kf5C5W/Bkr7e9WCPY9mGtl2MjHFjUDcCRFUrhvghKimVrn1gGOTr1IpP2Bv
         2WZbXfeAPhw/k3UZ1dUQX3PjIWoNugj4R1w8I93otGCSXaIoxtpIRgsu1rbRcwEmSfUz
         8cEaPn2mwvCruzA73/wXx/mxeX+g/uBRdsGdgYaaljW/xCYBcCeptqLaAYt43oZUO97r
         +/HWCa0mM7OYEqTvNJZ+r2CvguxYW5tFub3lAAPUXehDHqexmytnyC6AHyPebVBAT1DU
         EYEFx6YoWLvfCEEQt1SAJSW3m9CbSiChdoZQJVv5hK8cOPi1CnLStzfBeEMkir+ej57B
         GYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688765496; x=1691357496;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OJ0V6nTCT3uhCFN1topUMvhFZXj9rVKOhLzdkHpftz0=;
        b=I1o1tk7KgetUi9i/L0FopbWR0k2VAz7Ko48+jyAPYkGPaQNmnHiO/xSGniKL4Qy68o
         QHLT10pH9Q1Tt6YIoJSlsKGldz3VmbKQ3hJ8R0Vdc5YPqoaPi9rMwtgdoXy37EPIG/JI
         EETeXyfUN1uPqTIKGLnoniJ+/qw3RsHVhU+KyWcijx30PjhlbzGrrk0KcBWZ/YwdhhKB
         Xa8RTHO9HFMd/rwx7nMsvkxOLwX3fa1WR+MXr/2qE3JQX4fv3BEbb8KpbuABIv0ZDz9q
         x2C2DzKd0M7RgPupRydjnQ8fRnEUdS+M18CoJ9h24yayIeTNi+ZpYewirBLrTMxWL/P4
         pwlA==
X-Gm-Message-State: ABy/qLagETuAvMVAhHr1hsUoCqX7OCRnCfIMfP9oqLskMNvZjFy/jtWY
	yb5CU0OGOaMOLxO7bJ6EBbQzK1w=
X-Google-Smtp-Source: APBJJlFd3Qc3wQdr2oOvoo3uIQJmzqQOXvUZpIs44I78A48eurS/bLtmO1mVOhJ+R3Bcyc8Oi4qw1wE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:bb08:0:b0:bff:4ed0:63f6 with SMTP id
 z8-20020a25bb08000000b00bff4ed063f6mr63264ybg.7.1688765495890; Fri, 07 Jul
 2023 14:31:35 -0700 (PDT)
Date: Fri, 7 Jul 2023 14:31:34 -0700
In-Reply-To: <20230707172455.7634-7-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230707172455.7634-1-daniel@iogearbox.net> <20230707172455.7634-7-daniel@iogearbox.net>
Message-ID: <ZKiENoYiElPyQqrL@google.com>
Subject: Re: [PATCH bpf-next v3 6/8] bpftool: Extend net dump with tcx progs
From: Stanislav Fomichev <sdf@google.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev, 
	razor@blackwall.org, john.fastabend@gmail.com, kuba@kernel.org, dxu@dxuuu.xyz, 
	joe@cilium.io, toke@kernel.org, davem@davemloft.net, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/07, Daniel Borkmann wrote:
> Add support to dump fd-based attach types via bpftool. This includes both
> the tc BPF link and attach ops programs. Dumped information contain the
> attach location, function entry name, program ID and link ID when applicable.
> 
> Example with tc BPF link:
> 
>   # ./bpftool net
>   xdp:
> 
>   tc:
>   bond0(4) bpf/ingress cil_from_netdev prog id 784 link id 10
>   bond0(4) bpf/egress cil_to_netdev prog id 804 link id 11
> 
>   flow_dissector:
> 
>   netfilter:
> 
> Example with tc BPF attach ops:
> 
>   # ./bpftool net
>   xdp:
> 
>   tc:
>   bond0(4) bpf/ingress cil_from_netdev prog id 654
>   bond0(4) bpf/egress cil_to_netdev prog id 672
> 
>   flow_dissector:
> 
>   netfilter:
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/bpf/bpftool/net.c | 86 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
> index 26a49965bf71..1ef1e880de61 100644
> --- a/tools/bpf/bpftool/net.c
> +++ b/tools/bpf/bpftool/net.c
> @@ -76,6 +76,11 @@ static const char * const attach_type_strings[] = {
>  	[NET_ATTACH_TYPE_XDP_OFFLOAD]	= "xdpoffload",
>  };
>  
> +static const char * const attach_loc_strings[] = {
> +	[BPF_TCX_INGRESS]		= "bpf/ingress",
> +	[BPF_TCX_EGRESS]		= "bpf/egress",

Any reason we are not doing tcx/ingress & egress? To match the section
names.

