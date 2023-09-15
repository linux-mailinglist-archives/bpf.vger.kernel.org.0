Return-Path: <bpf+bounces-10167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 794F57A24E3
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 19:35:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31126282238
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 17:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F6415EAA;
	Fri, 15 Sep 2023 17:35:18 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938FCA6F
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 17:35:16 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CCA3AA1
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:34:07 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76de9c23e5cso154037285a.3
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 10:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694799246; x=1695404046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0w0jftHrCKOLI2sub5u/VeO/32jPwYn8o9L7rrDhT8=;
        b=C3YzfpQnPRTWEN7YloNioiOpM10fq1DthdYTNZZ0GNMh/ulir/zHT00Fg6QNfrT3sn
         /eswteh+WFfHjQx5ww8hPcY+XbjR/2OfxI4ytHJTwllf0OwqslAPmzN/Vh3YvYDnyXNO
         pE9bqrY3ausXGLEwyt+821845V6vigVY4JpkedDbFCNMLqxkFj2J8bKZJCPM0iUyMz88
         2mq2cOwuSLRkxpdV4SvPKTfkiu3LLdJ27PODERWkoax51UatP+4ZwmqpoC8tTSz0KyxN
         LgYqX8nXLJV3fMYLgcoCctPXktq3ngzuXP5RvDNvkF5R2jOWehV9ZjVvwGh/q3kIyyHb
         a5Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694799246; x=1695404046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0w0jftHrCKOLI2sub5u/VeO/32jPwYn8o9L7rrDhT8=;
        b=CPwj82RGcjGdnesjS9HXzi9VY9GoIzDe6+pVRQGaI8AAKhhEJ/skN7L0mqWmHuieiT
         ZUnsfSwXhotQELtboa2IsO10e/4rze8fXkkwwGulPJJWEpnAPslyFogAU38Qo/Xu4QQF
         8OqM9v/9MHzL/cBEf1IUC9ATMl11b3Y6bRx7DHj45kmKRKCtj4p9p8Ifq8rOdiWQTrIs
         4dz0GzctDuAoqPoPU4kjRDO+DyDDlcAwb/wWFTB7KW7fW7w3hM6DpealDAaDJHhqat+3
         HbIcdCVx7ZGRHpQKfv7kF04WRUQadlVhjNyYwLM/VcyR6i5NgLB7sp/lROtHRWRgUPf8
         qUgA==
X-Gm-Message-State: AOJu0YyDf5lIyKuA2wLvFL4dYAPEQsO05rPdEfTk9aCOM0lIUQ65Fthy
	7ii1hbJvZ+DfoHVxW9vwA4AkrJbgravtgaV1i/ig0LIDLiFjrBQaadoeBw==
X-Google-Smtp-Source: AGHT+IEZ/WDxzF/O9gB4A+40qEo3bPuHJhEt/xOjx6Re1kZpnRTINetruNrbaRwq/pC5z/EudhBlcPg80BxynPtATiE=
X-Received: by 2002:a0c:e094:0:b0:653:5961:f005 with SMTP id
 l20-20020a0ce094000000b006535961f005mr2596649qvk.26.1694799246336; Fri, 15
 Sep 2023 10:34:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915-bpf_collision-v2-1-027670d38bdf@google.com>
 <20230915171814.GA1721473@dev-arch.thelio-3990X> <CAADnVQJVL7yo5ZrBZ99xO-MWHHg8L-SuSJrCTf-eUd-k5UO75g@mail.gmail.com>
 <CAKwvOdkbqHFTvRNWG==0FjOPHgnA-zqE2Gn_nB4ys6qvKR2+HA@mail.gmail.com>
 <CAADnVQLfdMuxWVGKSF+COp8Q7DnKxYL0w5crN19vPkSd0Gh7mg@mail.gmail.com> <CAADnVQKJbTM-1n8YKvpC9XN7=tZuJi9mhnmmZSTVFOeBDv+SGA@mail.gmail.com>
In-Reply-To: <CAADnVQKJbTM-1n8YKvpC9XN7=tZuJi9mhnmmZSTVFOeBDv+SGA@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 15 Sep 2023 10:33:54 -0700
Message-ID: <CAKwvOd=1X+2m2ZRUft9y+j8H0WBLWbM=VEiS+O0FfywnfpRYyA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: Fix BTF_ID symbol generation collision
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, stable <stable@vger.kernel.org>, 
	Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>, Marcus Seyfarth <m.seyfarth@gmail.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 10:28=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> And please use [PATCH bpf v3] in subject, so that BPF CI can test it prop=
erly.

Testing `b4 prep --set-prefixes "PATCH bpf "`

--=20
Thanks,
~Nick Desaulniers

