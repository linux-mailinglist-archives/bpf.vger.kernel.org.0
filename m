Return-Path: <bpf+bounces-31867-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 130329043B0
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 20:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FECB21A68
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 18:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9414C7174F;
	Tue, 11 Jun 2024 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyyPCIDR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37BA2628D
	for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 18:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718130573; cv=none; b=YGImQhlKFgKTqtwktu3phIMiw7fKAU+9IXc/PSzQxO7deMtebpM9GRFh5iqA1ZqJDAj94ku+dxCx+0pWbcVUYqa+OJ30Uosh4pz+2W+GTzzClqhjaY6CVztDQZctTKJInGsKaDy/h71j0AVUYlU+nzEv55r9AeT1iWXFWwMnpJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718130573; c=relaxed/simple;
	bh=SL4vxGDXnNRktwNKtmFbKrwNWyLjXYnd6FR5FY7N5RE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KRSMhgB51zb4HZqbOCbFS7CX+XQBhMd4Hl9/NkD3TcYmbBb5oHy4AQZzkFV3VkdW+N3erSaP3ujn35fmWP4X1hXWKDRk6rlL7rv3gNub3ey5AUokntk97xAbce/RrBqu4664vtYEtbyM15DHm4DJ7o0aiTxmso4IvKDHupMr6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyyPCIDR; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c2ecbc109fso2636363a91.1
        for <bpf@vger.kernel.org>; Tue, 11 Jun 2024 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718130571; x=1718735371; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d7P/0PJyuP41GgG2yShPUwNWkz6PVk4dLBNGYjOFw00=;
        b=KyyPCIDREP7xzyCiKhQYY8NMk3+LFkqMMI4foxaRnY/pxzJjwAju16YQvSVI4D1HLQ
         6iGAZnYIVTukc1btySSRpro7fy0oXemjIlpl55ly0Ur30rIbqwjWZ4L3Udq036o3te6j
         1lwlF+RFvzxaj+BLPC6yAJ0Ul9olLHqZ1XzISER7Ahjmtw6KwjuphG0vRiYui238jK5q
         gyPNX+fxrf2q34nCMI6lsnOP/sNZTmU8y2RDpCnVv8Jga07snm0W2Wg67kB/zW8scZeE
         MHXVNs9w3aNZgMd7LNnF4K/9fhQSPdPG7hLA+9iYELQ8I8cRxDYSuUmyF/MI1rOw0zOk
         /B1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718130571; x=1718735371;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d7P/0PJyuP41GgG2yShPUwNWkz6PVk4dLBNGYjOFw00=;
        b=TYY0iCpXSi1HFTjSA9rmOysSVcuOS3Tv30MC4a7f1bktrBbGQ6EOcGyR0IP1iMJqLm
         LEqLI3C7kSPbFbDgqRVy71M6LJAbmddHeysoE6fcK5gm3P2ChYFWRhMt1Tv7NtV6Q9w9
         Ao2hwYbr8sJhEoujOvAC10xPGTDDy3z36YAxsKnoNth2dqRcy1rlJ/scCXASrV629gcx
         KgZ+brsy57vkHB8e08CCwzMkDllIO8ll5UsIlWjyIkbwb1FfR6ps71p/b0zD8jd7Fs/X
         JafRNRmdTwKNvxsnvwHQt7ePRRZFQSZZ4V7fefD3LgDeuqkBiza4paijxCQgPuLSCSkg
         DeNA==
X-Forwarded-Encrypted: i=1; AJvYcCWm68FNT/USC8Padz5iOk2Ku14fNYTq7x+VaAbWWDVNvnJsrPSjBHI/ZIyk4pZTkop2zUluYv36DXNQjXAMb9QID/dw
X-Gm-Message-State: AOJu0YwIrimQ08eXDpkkzE6QBpY6PIyK6faxeXepKvjg66SsBSFp0ERB
	hNhrJA0Y22GqQSkv3OVzMvUxrBvYFisWpRCJVjmdUndb+ykjfo/j
X-Google-Smtp-Source: AGHT+IGWC1qkAPvmp0oas/5V5fYAyNzEODKCmiK2KlGCbc4Nd9QO2vksFDpXS/r5KT7b9BzqL/Gn+g==
X-Received: by 2002:a17:90a:fb93:b0:2c2:d8d8:7632 with SMTP id 98e67ed59e1d1-2c2d8d876c5mr9351193a91.38.1718130570822;
        Tue, 11 Jun 2024 11:29:30 -0700 (PDT)
Received: from [192.168.0.31] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c32bab4783sm2319117a91.43.2024.06.11.11.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:29:30 -0700 (PDT)
Message-ID: <fb6519efc3e0aea38f9a4315144493b4eddbe3ef.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] selftests/bpf: Support checks against a
 regular expression.
From: Eduard Zingerman <eddyz87@gmail.com>
To: Cupertino Miranda <cupertino.miranda@oracle.com>, bpf@vger.kernel.org
Cc: jose.marchesi@oracle.com, david.faust@oracle.com, Yonghong Song
	 <yonghong.song@linux.dev>, Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 11 Jun 2024 11:29:25 -0700
In-Reply-To: <20240611174056.349620-2-cupertino.miranda@oracle.com>
References: <20240611174056.349620-1-cupertino.miranda@oracle.com>
	 <20240611174056.349620-2-cupertino.miranda@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-11 at 18:40 +0100, Cupertino Miranda wrote:
> Add support for __regex and __regex_unpriv macros to check the test
> execution output against a regular expression. This is similar to __msg
> and __msg_unpriv, however those expect full text matching.
>=20
> Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
> Cc: jose.marchesi@oracle.com
> Cc: david.faust@oracle.com
> Cc: Yonghong Song <yonghong.song@linux.dev>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> ---

Overall looks good, could you please fix a few things noted below and respi=
n?
Please add my ack on the respin.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> @@ -89,6 +98,16 @@ void test_loader_fini(struct test_loader *tester)
> =20
>  static void free_test_spec(struct test_spec *spec)
>  {
> +	int i;
> +
> +	/* Deallocate expect_msgs arrays. */
> +	for (i =3D 0; i < spec->priv.expect_msg_cnt; i++)
> +		if (spec->priv.expect_msgs && spec->priv.expect_msgs[i].regex_str)

I don't think situation when spec->priv.expect_msg_cnt > 0 and
spec->priv.expect_msgs =3D=3D NULL is possible, conditions above and below
could be simplified to just "if (spec->[un]priv.expect_msgs[i].regex_str)"

> +			regfree(&spec->priv.expect_msgs[i].regex);
> +	for (i =3D 0; i < spec->unpriv.expect_msg_cnt; i++)
> +		if (spec->unpriv.expect_msgs && spec->unpriv.expect_msgs[i].regex_str)
> +			regfree(&spec->unpriv.expect_msgs[i].regex);
> +
>  	free(spec->priv.name);
>  	free(spec->unpriv.name);
>  	free(spec->priv.expect_msgs);
> @@ -100,17 +119,38 @@ static void free_test_spec(struct test_spec *spec)
>  	spec->unpriv.expect_msgs =3D NULL;
>  }
> =20
> -static int push_msg(const char *msg, struct test_subspec *subspec)
> +static int push_msg(const char *substr, const char *regex_str, struct te=
st_subspec *subspec)
>  {
>  	void *tmp;
> +	int regcomp_res;
> +	char error_msg[100];
> +	struct expect_msg *msg;
> =20
> -	tmp =3D realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cnt) * s=
izeof(void *));
> +	tmp =3D realloc(subspec->expect_msgs,
> +		      (1 + subspec->expect_msg_cnt) * sizeof(struct expect_msg));
>  	if (!tmp) {
>  		ASSERT_FAIL("failed to realloc memory for messages\n");
>  		return -ENOMEM;
>  	}
>  	subspec->expect_msgs =3D tmp;
> -	subspec->expect_msgs[subspec->expect_msg_cnt++] =3D msg;
> +	msg =3D &subspec->expect_msgs[subspec->expect_msg_cnt];
> +	subspec->expect_msg_cnt +=3D 1;
> +
> +	if (substr) {
> +		msg->substr =3D substr;
> +		msg->regex_str =3D NULL;
> +	} else {
> +		msg->regex_str =3D regex_str;
> +		msg->substr =3D NULL;
> +		regcomp_res =3D regcomp(&msg->regex, regex_str, REG_EXTENDED|REG_NEWLI=
NE);
> +		if (regcomp_res !=3D 0) {
> +			regerror(regcomp_res, &msg->regex, error_msg, 100);
                                                                      ^^^^
Nit:                                                      sizeof(error_msg)

> +			fprintf(stderr, "Regexp compilation error in '%s': '%s'\n",
> +				regex_str, error_msg);
> +			ASSERT_FAIL("failed to compile regex\n");

Nit:                    these two calls could be combined as a single PRINT=
_FAIL().

> +			return -EINVAL;
> +		}
> +	}
> =20
>  	return 0;
>  }

[...]

> @@ -337,16 +389,11 @@ static int parse_test_spec(struct test_loader *test=
er,
>  		}
> =20
>  		if (!spec->unpriv.expect_msgs) {
> -			size_t sz =3D spec->priv.expect_msg_cnt * sizeof(void *);
> +			for (i =3D 0; i < spec->priv.expect_msg_cnt; i++) {
> +				struct expect_msg *msg =3D &spec->priv.expect_msgs[i];
> =20
> -			spec->unpriv.expect_msgs =3D malloc(sz);
> -			if (!spec->unpriv.expect_msgs) {
> -				PRINT_FAIL("failed to allocate memory for unpriv.expect_msgs\n");
> -				err =3D -ENOMEM;
> -				goto cleanup;
> +				push_msg(msg->substr, msg->regex_str, &spec->unpriv);

Need to check push_msg() return value.

>  			}
> -			memcpy(spec->unpriv.expect_msgs, spec->priv.expect_msgs, sz);
> -			spec->unpriv.expect_msg_cnt =3D spec->priv.expect_msg_cnt;
>  		}
>  	}
> =20

[...]

