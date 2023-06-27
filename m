Return-Path: <bpf+bounces-3607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EA37406F9
	for <lists+bpf@lfdr.de>; Wed, 28 Jun 2023 01:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3600281168
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 23:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65031ACC3;
	Tue, 27 Jun 2023 23:50:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9582C19BBB;
	Tue, 27 Jun 2023 23:50:44 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC3A199E;
	Tue, 27 Jun 2023 16:50:43 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso4065117e87.0;
        Tue, 27 Jun 2023 16:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687909841; x=1690501841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+SArcw9eGhrWMtwgw6NvssSbmXz4ONgTReXtsZYLhA=;
        b=Lpb+KvR+FcFbejqhG+YeOk+cyaytGkC5WDmvfSBx2WpzcXtWnXmGtW31+xof5jkNyQ
         quvhgTp55OBj4YfpYK6bXUWe4tc6Q1WiZmDnC6cFC7YLk9yOfHCorcYRa+tJicV48dbX
         0MVaV3orG5l0PGoiUa2NLnwaeGG0uiEf+Jn9kFYwsbj9+4R8fcCtg7cHmmuD85WxoG38
         FJ9XVWE0xOeGTuBjrFkVBvD+0COFeKK/reLrWCdp4OhmgDGvWy7b5C9bh5lOvATT15/l
         mp9IgMxEqXVqS8kV6RxefAwK2jqXbvk3xHw3Qbc8bzvhechHlyAq8mv4M6xpphAS6M+x
         gK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687909841; x=1690501841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+SArcw9eGhrWMtwgw6NvssSbmXz4ONgTReXtsZYLhA=;
        b=gA0RZh3USQiEGWZbi5lb+xKI85/FvEZ1oirGcMYPmFLbpocNm6BSW9Cf2Zmo8GjsiT
         OliewxqdjLP6PE+dfVBnesKtAz0kK53TtsfW/hyukbJ1fknFGwaF9gCoFACInBsr1CsU
         HY1SWsq0593VKSkB+aPY07dlI2/2PrFLXrs0wQ/OkjPlhzqEut8L3V+DA2xS4riPjgSt
         Eaw3KMfodsHAc8kQExR2kq56Uc6SCSMz8qudert0hQZgkMjiDMsUN7cp40Bv3uqy4/V4
         owuAygRLWVEp4TFiqvQQq7ohzRICnTlGv4IofefrIMjkoTEx2F4QTG3T9wCQ82sDyvaL
         PyyA==
X-Gm-Message-State: AC+VfDz715mKbnjNFD4nEswAdlGOFfj8AfPsq9xs+emK1YhEnMuIy5kc
	zb3ua8G8t+UViGGl4R1afIwMATJTvwPtGndBKz8=
X-Google-Smtp-Source: ACHHUZ4vqeR0CJqToVpTfsC/OYLVbdp6V0x5jn/DMiPp82EZ8994VbSVWMmslayUuAEKBMhDpf9PUZDpX8F/mv8XjjU=
X-Received: by 2002:a2e:a16b:0:b0:2b4:6dbf:e700 with SMTP id
 u11-20020a2ea16b000000b002b46dbfe700mr20395365ljl.38.1687909840905; Tue, 27
 Jun 2023 16:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQ+611dOqVFuoffbM_cnOf62n6h+jaB1LwD2HWxS5if2CA@mail.gmail.com>
 <m2bkh69fcp.fsf@gmail.com> <649637e91a709_7bea820894@john.notmuch>
 <CAADnVQKUVDEg12jOc=5iKmfN-aHvFEtvFKVEDBFsmZizwkXT4w@mail.gmail.com>
 <20230624143834.26c5b5e8@kernel.org> <ZJeUlv/omsyXdO/R@google.com>
 <ZJoExxIaa97JGPqM@google.com> <CAADnVQKePtxk6Nn=M6in6TTKaDNnMZm-g+iYzQ=mPoOh8peoZQ@mail.gmail.com>
 <CAKH8qBv-jU6TUcWrze5VeiVhiJ-HUcpHX7rMJzN5o2tXFkS8kA@mail.gmail.com>
 <649b581ded8c1_75d8a208c@john.notmuch> <ZJtpIpwRGhhRFk8P@google.com> <649b71daaa4fa_7afc420820@john.notmuch>
In-Reply-To: <649b71daaa4fa_7afc420820@john.notmuch>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 27 Jun 2023 16:50:29 -0700
Message-ID: <CAADnVQKNGMiwmodP=6MVFD8OtbQj+OGUmigVYrGDQQ6gi0VODA@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 11/11] net/mlx5e: Support TX timestamp metadata
To: John Fastabend <john.fastabend@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jun 27, 2023 at 4:33=E2=80=AFPM John Fastabend <john.fastabend@gmai=
l.com> wrote:
>
> Yeah I think so and then carry a couple different object files
> for the environment around. We do this already for some things.
> Its not ideal but it works. I think a good end goal would be
>
>  int bpf_devtx_request_timestamp(...)
>  {
>         set_ts =3D dlsym( dl_handle, request-timestamp);
>         return set_ts(...)
>  }
>
> Then we could at attach time take that dlsym and rewrite it.

Sounds like we need polymorphic kfuncs.
Same kfunc name called by bpf prog, but implementation would
change depending on {attach_btf_id, prog_type, etc}.
The existing bpf_xdp_metadata_rx_hash is almost that.
Except it's driver specific.
We should probably generalize this mechanism.

