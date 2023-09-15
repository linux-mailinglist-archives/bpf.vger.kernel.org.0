Return-Path: <bpf+bounces-10155-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06377A238F
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 18:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57C8228284B
	for <lists+bpf@lfdr.de>; Fri, 15 Sep 2023 16:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FF3125CA;
	Fri, 15 Sep 2023 16:25:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DE8125A1
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 16:25:40 +0000 (UTC)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA6F19A9
	for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:25:37 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-65636f2d3e0so4107206d6.2
        for <bpf@vger.kernel.org>; Fri, 15 Sep 2023 09:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1694795137; x=1695399937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmftETAXOQrZAO1rbJ1A5lHyYUbxUNroqKw/rpculKQ=;
        b=0iQgBrU88xqIgezB+btyd5BLMYaukyiKqFNpsZ2MpGE/tHpBzOYYraF99wiGXQboqt
         go8LUudxPp7SwcFxZVwi/8K2MFBisTt+xMo5LetsM5ZBTkuKdcDbrvBFJnTU/11cEgK/
         X0jwpzePdOHikr37IeJHGbWjby+QXcDR68YsSi7Ya47sx7Ns0oxAlWYVnAUhFPE5PW7M
         +aGQS/akw4tKENrVIYEfOTPkgOctzG/Ntc8tdKx4ZLQkcm7zf8FzeXrLHg4Lnc0HNtPb
         k8tD9xTMdBuAze7Ni2Veuq4mhTrnH2TQ3tf5o07znTuzxOiGpH6dYfweXbfkRDfyDbWJ
         uGpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694795137; x=1695399937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmftETAXOQrZAO1rbJ1A5lHyYUbxUNroqKw/rpculKQ=;
        b=w+9REX5cou+RVwXaYDr8tmn1XOlBsBYKre9z/rHNUhT1UvIX6VjauN5WLEI3odDwPd
         Ot8lYOwGeUhUqAiI9Pz0zyLfYiqUJ/kjGugD0dpRMP2A3XnFoFME4pQWSYhmI3Uiuvp1
         1/ppz0owC5hbQGPw8CT4Rm4p+lQ6WmtkPA3PEOcQSKawJRYdyZCh2yo3V5cCW0tYHoCe
         VkvtIunNSapLxXycwCDAPZy5orhm4fBEr/WE6htZvuVOEzcn94O3AVMcC7jVHG9Rck5M
         mFg0QzyrygXYwQIuoxlMqDMEyX+v6XsldGBimjJJYFYPPm2WDVwY3O7niDq+fcU71lBz
         3O6A==
X-Gm-Message-State: AOJu0YxJus8dJida0zL/cIRVqeQ5IQrPDme+DirwvcyCLbKC62ASSkwZ
	MGGcWZvUbcimo0g9mEIfO2dsi8+nmX2OUG53ZAvNuw==
X-Google-Smtp-Source: AGHT+IFSlpiBrrslnQtcAsY86Zqf4x+VuwwA1FtPHuxOjlhsbPWhuLwH5Vc03N7/PycF4/6pv5HdmU8Sp8zlWyUqlT4=
X-Received: by 2002:ad4:430b:0:b0:635:e0dd:db4b with SMTP id
 c11-20020ad4430b000000b00635e0dddb4bmr2211158qvs.37.1694795136747; Fri, 15
 Sep 2023 09:25:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230915103228.1196234-1-jolsa@kernel.org>
In-Reply-To: <20230915103228.1196234-1-jolsa@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Fri, 15 Sep 2023 09:25:22 -0700
Message-ID: <CAKwvOd=XXry=gbaUCUqprPqxeSnFKbe2drPygFU8SDFw=HwuXw@mail.gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix BTF_ID symbol generation
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Marcus Seyfarth <m.seyfarth@gmail.com>, bpf@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 3:32=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Marcus and Nick reported issue where BTF_ID macro generates same
> symbol in separate objects and that breaks final vmlinux link.
>
> Adding __LINE__ number suffix to make BTF_ID symbol more unique,
> which is not real fix, but it would help for now and meanwhile
> we can work on better solution as suggested by Andrii in [2].
>
> [1] https://github.com/ClangBuiltLinux/linux/issues/1913
> [2] https://lore.kernel.org/bpf/ZQQVr35crUtN1quS@krava/T/#m64d7c29c407d6a=
df0e7b420359958b3aafa7bf69
> Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/btf_ids.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index a3462a9b8e18..a9cb10b0e2e9 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -49,7 +49,7 @@ word                                                  \
>         ____BTF_ID(symbol, word)
>
>  #define __ID(prefix) \
> -       __PASTE(prefix, __COUNTER__)
> +       __PASTE(__PASTE(prefix, __COUNTER__), __LINE__)

I think __COUNTER__ and __LINE__ both expand to string literals; you
can avoid another expansion via __PASTE by just putting them adjacent,
like so:
https://github.com/ClangBuiltLinux/linux/issues/1913#issuecomment-171079431=
9
I'll send that as a v2 and link back to your v1.

>
>  /*
>   * The BTF_ID defines unique symbol for each ID pointing
> --
> 2.41.0
>


--=20
Thanks,
~Nick Desaulniers

