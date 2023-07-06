Return-Path: <bpf+bounces-4289-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADBED74A365
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 19:46:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ADB128133A
	for <lists+bpf@lfdr.de>; Thu,  6 Jul 2023 17:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBBFC155;
	Thu,  6 Jul 2023 17:46:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68620C136
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 17:46:31 +0000 (UTC)
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A245310EA
	for <bpf@vger.kernel.org>; Thu,  6 Jul 2023 10:46:29 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b8c8b97679so6786365ad.3
        for <bpf@vger.kernel.org>; Thu, 06 Jul 2023 10:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688665589; x=1691257589;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iYwswXlV1/1qc1QMb8XdbUm0VHdqMuEGHLDmXeCI7tw=;
        b=JADhELCXVgoD7i7cWTwhQRh73F5YhFYDBv94oM/8VxQQoeG0PhxyPIPeAt5smzYLDQ
         2VFXs6FDTv58B0PombJgnTJb6SyHVgNKljVNLKJw3EBZa3IM+rDpks3+Z8C/xYtcpoxb
         LbU/vFpSAvnQ+5Dl4V1lvy11cPRh6gO9C/KaYNRuo5YkMRA5ChZ+B6QR3eNwDAJNHhEv
         28/VzsSQuyF3hQ7p9xa/+eE3S/Swa0foXq4eOKi4DtfGVPSsoyFlkW+OKOkQEV9Hjwha
         r2lQN4ScFg+aAQmNbKsoXLuiVXMfbKyZj9wiemASlejBWpa5SFm0+xS1wTFJAhLizRvw
         VrwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688665589; x=1691257589;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iYwswXlV1/1qc1QMb8XdbUm0VHdqMuEGHLDmXeCI7tw=;
        b=NjSPohC3fTsfLIxKjqE5q/LNIBAQ3xHVOZenePwg/nJHxyPBNPGVR4NOz+/LhzXIFb
         hEDExKAFaFaf76kpJI0KfFqIJgt0VY0H/BeyV52rFsOSCKiSUU/kwGkqe3QJEM8xARGo
         xYjvyzFsAZx/hpj9VwuIXK65D5VRKgh3+pXMUIuupzkqeRWqB+q6yFqtlc95txOxBAZF
         s6N+j1yrxynawU7bA6+p0PdjQSM6HfSL9Fn5oQIKiFGx3dAlJ76dpfGdEiSkJ+tMl4Cz
         FBmGE1CfYopcwIypejyfaSqUtuljF+7uVFL3tKcGIon5C1gFBVCLY4M0OSxNCdt1//2z
         IgEQ==
X-Gm-Message-State: ABy/qLacnDPK3BSeiY6KAOmhuZzueMOeOdDSoRAkA0gKBL/Sdaf/divH
	N0QtLClNVxglT97wCmD7DfvlNYo=
X-Google-Smtp-Source: APBJJlFpjvWRD+oH7cEr3v6mp6VT3nmUJ2yl68awyDOvDt3JNKrMgENCDlaLreMNh3hWPwDXBQWJuWE=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:7085:b0:1b7:eecd:9dae with SMTP id
 z5-20020a170902708500b001b7eecd9daemr1936538plk.9.1688665589079; Thu, 06 Jul
 2023 10:46:29 -0700 (PDT)
Date: Thu, 6 Jul 2023 10:46:27 -0700
In-Reply-To: <20230706142228.1128452-1-bjorn@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230706142228.1128452-1-bjorn@kernel.org>
Message-ID: <ZKb986L59CTFITjP@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Bump and validate MAX_SYMS
From: Stanislav Fomichev <sdf@google.com>
To: "=?utf-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@kernel.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, Mykola Lysenko <mykolal@fb.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, "=?utf-8?B?QmrDtnJuIFTDtnBlbA==?=" <bjorn@rivosinc.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 07/06, Bj=C3=B6rn T=C3=B6pel wrote:
> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>=20
> BPF tests that load /proc/kallsyms, e.g. bpf_cookie, will perform a
> buffer overrun if the number of syms on the system is larger than
> MAX_SYMS.
>=20
> Bump the MAX_SYMS to 400000, and add a runtime check that bails out if
> the maximum is reached.
>=20
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>

Acked-by: Stanislav Fomichev <sdf@google.com>

OTOH, should be easy to convert this to malloc/realloc? That should fix
it once and for all and avoid future need to bump the limit?

> ---
>  tools/testing/selftests/bpf/trace_helpers.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index 9b070cdf44ac..f83d9f65c65b 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c
> @@ -18,7 +18,7 @@
>  #define TRACEFS_PIPE	"/sys/kernel/tracing/trace_pipe"
>  #define DEBUGFS_PIPE	"/sys/kernel/debug/tracing/trace_pipe"
> =20
> -#define MAX_SYMS 300000
> +#define MAX_SYMS 400000
>  static struct ksym syms[MAX_SYMS];
>  static int sym_cnt;
> =20
> @@ -46,6 +46,9 @@ int load_kallsyms_refresh(void)
>  			break;
>  		if (!addr)
>  			continue;
> +		if (i >=3D MAX_SYMS)
> +			return -EFBIG;
> +
>  		syms[i].addr =3D (long) addr;
>  		syms[i].name =3D strdup(func);
>  		i++;
>=20
> base-commit: fd283ab196a867f8f65f36913e0fadd031fcb823
> --=20
> 2.39.2
>=20

