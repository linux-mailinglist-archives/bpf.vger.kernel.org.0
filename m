Return-Path: <bpf+bounces-5123-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB777569D4
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 19:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B93E42815E3
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 16:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3431FAD;
	Mon, 17 Jul 2023 16:56:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CD515D2
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 16:56:55 +0000 (UTC)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C14103
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:56:53 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2b703caf344so68875991fa.1
        for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 09:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689613011; x=1692205011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oLNYpF7MMoRQWINXOu0Lz7wqKVetVyQHyq7EGPnu31o=;
        b=lqsuEpZ21RQzqD8yEW09jttirLgyEoIIkox5hhfRNgo0Yew/x4kOJDv8X5IEmJKeuy
         cNDVPNYaj8o2U9ChHGuy8XAwtCdew24UqfVLPS08NUvOWQlUDrSIxOpPxaYh9zAaEIrt
         /zdQou9ESTmyrBn8tC119/eqWLv6XyRPR8l6B90qGMX4pMrRQaVjXY406487/LpL8qSF
         q7Ycr5GEo1Uv5WL6v7Y1HZNyIi2kqGwW8n5nJ9cpgAN95lDPmX+aDhe0twji/XiYnC4U
         CJPmFTy7XpGX9LY6IvWXaxqcm9awGXTWrSqiJavJuvzFnrUBYHrY1fbpJJKcvUu4NHeE
         ehPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689613011; x=1692205011;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oLNYpF7MMoRQWINXOu0Lz7wqKVetVyQHyq7EGPnu31o=;
        b=UKwmohWMYG9t5SDAcwGovezgq0BgLBE3/XSKyH7xe2qAfUG+h8pCUMuGgD8fgQcpxQ
         zBV8lg+pIOc4L3zhQlhXleHGKD3HEZAQnNhG2j9baShXxwpjmRouhS0aGtyH8Nw2/fK7
         gjaF4cAFYVGPnrUvgr3WRXKEKy1LC0/BLYyWdfNUztg23h7l0+JgWP4F+EWtp6CQI7th
         zk7H1ht5Vqnj6RBw7CwQ1p3LlPvCB47IYFBEHwj7yuAbdJfSUEeyR5/6QU7lW3in3HfJ
         AaONzwo9nKK54uVLz9jztIyy/loGaPE+LIkJVJogP12ku9eF/6mbMy+24JV+sD8hwZzQ
         F0pg==
X-Gm-Message-State: ABy/qLaYTLq/RC12qAO/LfZoyocB0XNLsgEs5/h3h2/BT+ee2cHPs+NL
	HSKTdDBXZ2iJ7j+UDBNAWC2cz/s3qwuhCfgv6xc=
X-Google-Smtp-Source: APBJJlHYWpHVoxd4kYnWHjf0gpY1QWXTzjDCoaLSEfCy1cz1lo/RR6eS7TOxwLEmnzPdCNWEN6OrVig5vOl/DuK2olI=
X-Received: by 2002:a2e:9245:0:b0:2b6:e2c1:9816 with SMTP id
 v5-20020a2e9245000000b002b6e2c19816mr75251ljg.20.1689613010875; Mon, 17 Jul
 2023 09:56:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230713060718.388258-1-yhs@fb.com> <8b3e804bc23d44ba3a30b9d69e6590bede857ed3.camel@gmail.com>
In-Reply-To: <8b3e804bc23d44ba3a30b9d69e6590bede857ed3.camel@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 17 Jul 2023 09:56:39 -0700
Message-ID: <CAADnVQLTVodyZXJTNcSB98hT25DahFVfVga0d7R8Cb3F5HfTJQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/15] bpf: Support new insns from cpu v4
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Fangrui Song <maskray@google.com>, Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 16, 2023 at 6:39=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
> - I've looked through the usage of BPF_LDX and found that there
>  is a function seccomp.c:seccomp_check_filter(), that directly
>  checks possible CLASS / CODE combinations. Should this function
>  be updated to handle new instructions?

This is classic bpf. Why would it change? What is the concern?

