Return-Path: <bpf+bounces-3110-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 641FD7396C2
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 07:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94FE31C21035
	for <lists+bpf@lfdr.de>; Thu, 22 Jun 2023 05:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B402101;
	Thu, 22 Jun 2023 05:18:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80DFF17E0;
	Thu, 22 Jun 2023 05:18:05 +0000 (UTC)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9DC118;
	Wed, 21 Jun 2023 22:18:04 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b466066950so83012991fa.2;
        Wed, 21 Jun 2023 22:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687411082; x=1690003082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YH+itf89CwvST+f/T4agpD7Eh/cEsCLfz+LVE0WQbzU=;
        b=ecXsf6WmJEXWJKeko1mZk+osx+NxAT6SngeugBD2LxrMom7pRjAqsq78x/t++IWCo5
         Wrn9kJNBtV6joh4H1BBoxsZLg++JKnvNylqEJgxy65eEnxkJoe0QsSgsSFiDE+r/iwfr
         UzSdJHBaAw8/6ejgIN8wrhm8aif7dyZpdbYhoF0w6e6hHFyH+ejRxDR7AzpyT79oo5wt
         x9z3xxmTPrsHntUE4sdLK7Jfyw2wo2rv65UcFqmCMmnWWsxkQzRmU4WZSPGfIA4YlBj1
         mgxVQNzoz0Czx7S4EOpjKzXJCERUpjhlWFNG07dVJrCImW0UppD1A1RKqYBnfLQf21Ka
         chCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687411082; x=1690003082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YH+itf89CwvST+f/T4agpD7Eh/cEsCLfz+LVE0WQbzU=;
        b=DI9fXvPz9R4e2oGj8swt42/g/LPvUI+hQditjqlwL9i8CeVILeqnUGUTCnkhDJX1rS
         fyGDZNYxC5XgP+JCGkcMoAPTQUt4fpICDYAhS11Q1j+rVzoVZrsQw9FW4MNDg2lkC3OK
         MVHFPCU37CAqCoVkf71WlLL+AeRG7ydT3IOb1XSr7TST9AN4BUuk3a7/SS2+nJU+Krqs
         FzvIWgJ45eEObK8sLkUpcW1Y2Knqeqeapg08fw5PSkIJpEI9X7qwMsIRc1GZXlmaQ4Qt
         1WE0LBeDmNRSRtJis2114n7N1TqeaipQTJETNIl6wCzU+5I1+no7/zoUfarYaHSF4TZi
         lxZg==
X-Gm-Message-State: AC+VfDwxjqYBHXGv1PAADLqySSKhb3e0UEs/F/SR2Uu3sEw7aJA1Ht2n
	NsGngLLNz1JcKb2dWx7avL05AyW1dsAQTYvgo3M=
X-Google-Smtp-Source: ACHHUZ4EYsgOEby5hZNVlaLOCOB1xpDA25t4bIPPmK6KOCbXY0Xo1j1pX95Y2l2aTSEutxrJYOYwQerWiilGDwKGSQc=
X-Received: by 2002:a2e:914b:0:b0:2b4:7256:f9c3 with SMTP id
 q11-20020a2e914b000000b002b47256f9c3mr8048007ljg.13.1687411081888; Wed, 21
 Jun 2023 22:18:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230621170244.1283336-1-sdf@google.com> <20230621170244.1283336-3-sdf@google.com>
In-Reply-To: <20230621170244.1283336-3-sdf@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 21 Jun 2023 22:17:50 -0700
Message-ID: <CAADnVQ+QKnFrAFUYcV3XAVVFuosdhi+6K8z0TbwFXbU=euJEDg@mail.gmail.com>
Subject: Re: [RFC bpf-next v2 02/11] bpf: Resolve single typedef when walking structs
To: Stanislav Fomichev <sdf@google.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jun 21, 2023 at 10:02=E2=80=AFAM Stanislav Fomichev <sdf@google.com=
> wrote:
>
> It is impossible to use skb_frag_t in the tracing program. So let's
> resolve a single typedef when walking the struct.
>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Stanislav Fomichev <sdf@google.com>

Pls send this one separately without RFC, but with a selftest,
so we can land it soon.

