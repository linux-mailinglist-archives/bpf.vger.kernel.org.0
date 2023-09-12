Return-Path: <bpf+bounces-9744-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A579D122
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 14:32:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFBE3281DEF
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 12:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E51803D;
	Tue, 12 Sep 2023 12:32:03 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8218A182D9;
	Tue, 12 Sep 2023 12:32:03 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B049F;
	Tue, 12 Sep 2023 05:32:02 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99bcc0adab4so705067366b.2;
        Tue, 12 Sep 2023 05:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694521921; x=1695126721; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8ERi9ZEqlVNb76qS6B065bS/ZA5gp+8icppp5yNtWP4=;
        b=raIrzv34SyoIr/LyC+6YsNgqekIaNwgkTAjLoUmX1HAVmQtCYrAILxreebFL6Zjbqv
         ijFgMxPtkyhr0xn/9e7jvLT7P/o9ME6iWQbjsXsgqHYUr2X7UsMF/oKUeB97f2D/ty99
         ntttGu+oEQjI/GipBAWwbaUlgpwEBZMqO73JWb+TPFAEnO+1LM1kK9ENfUN+r5UECumo
         JYdL4jwEIqw9LfCPZgXPkOzMZnWX5CyQthilA3KRtxDi+5XgFf9ERdvXEkyGY1srbJQH
         pecPxCTtDrzPwZsYuY5Vxy0gp6KRMeKj08kU/eiToB9tS/Q0/cTA7kIV1QVQaI1Oa7Kb
         AwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694521921; x=1695126721;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8ERi9ZEqlVNb76qS6B065bS/ZA5gp+8icppp5yNtWP4=;
        b=a6vlQU9lNbEyMwOR8baGmciPM19ibPVG9zc1DinwCmu4E5BWVXVZ9vAg9SVl/IiykX
         kEIlFGFbwwoheyjCoABID+1YgmZEV5UwOr5NP5iARIIg9hTJLo4y0D4qee/5HgW/CXwe
         oNWPk1Hgur5czy+ikEWkY98ISmRHewG3GVxSaT5ZeLLraGCDC0L/gDcWC1tdrrdHVJxv
         IOvaCdTO8z4lZquh/T9qZLoMC+oYGRMwG+MOL2LL/paG+NxoQMY6gOJo2T2TbCZ85bec
         4kMIl8qTbUHDlzLZrdYX1HKan8gUWQqgw7/GvMNx5EEV7YyYI0sERp73rfBFNAcF5rHK
         xRug==
X-Gm-Message-State: AOJu0YzriyVW6O565Zwjese+iwrbMdBe51FwA0xXmHxxavAIyDf5n56F
	AODSum3vp7FvU1AJY9juUsc=
X-Google-Smtp-Source: AGHT+IGB7afqvpyBcDwWomzYxfehxeng9Uc8V1ljrC0i+tDk9aruANZMk6CVpkcU/b0Y9VRUCVYxKA==
X-Received: by 2002:a17:906:74db:b0:9a3:b0c9:81fe with SMTP id z27-20020a17090674db00b009a3b0c981femr10767244ejl.57.1694521920609;
        Tue, 12 Sep 2023 05:32:00 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id mt28-20020a170907619c00b009ad8acac02asm781970ejc.172.2023.09.12.05.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 05:32:00 -0700 (PDT)
Message-ID: <3f91e97d95e2d8cf667071d18b4552fe13fd2b95.camel@gmail.com>
Subject: Re: [PATCH bpf] selftests/bpf: fix unpriv_disabled check in
 test_verifier
From: Eduard Zingerman <eddyz87@gmail.com>
To: Artem Savkov <asavkov@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org,  netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Date: Tue, 12 Sep 2023 15:31:58 +0300
In-Reply-To: <20230912120631.213139-1-asavkov@redhat.com>
References: <20230912120631.213139-1-asavkov@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-09-12 at 14:06 +0200, Artem Savkov wrote:
> Commit 1d56ade032a49 changed the function get_unpriv_disabled() to
> return its results as a bool instead of updating a global variable, but
> test_verifier was not updated to keep in line with these changes. Thus
> unpriv_disabled is always false in test_verifier and unprivileged tests
> are not properly skipped on systems with unprivileged bpf disabled.
>=20
> Fixes: 1d56ade032a49 ("selftests/bpf: Unprivileged tests for test_loader.=
c")
> Signed-off-by: Artem Savkov <asavkov@redhat.com>

Yep, my bad, without this patch test_verifier fails when
/proc/sys/kernel/unprivileged_bpf_disabled is set to 1.
Thank you for fixing it.
Acked-by: Eduard Zingerman <eddyz87@gmail.com>

> ---
>  tools/testing/selftests/bpf/test_verifier.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/=
selftests/bpf/test_verifier.c
> index 31f1c935cd07d..98107e0452d33 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -1880,7 +1880,7 @@ int main(int argc, char **argv)
>  		}
>  	}
> =20
> -	get_unpriv_disabled();
> +	unpriv_disabled =3D get_unpriv_disabled();
>  	if (unpriv && unpriv_disabled) {
>  		printf("Cannot run as unprivileged user with sysctl %s.\n",
>  		       UNPRIV_SYSCTL);


