Return-Path: <bpf+bounces-71030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 339C0BDFA19
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 18:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FF53E6CE8
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43F3376A1;
	Wed, 15 Oct 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+MZwFiW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C843A337698
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760545238; cv=none; b=qdOq1JcidRVEnp14uNwJcnIZXp6HLQ6PJEYON1Gaqpp914IogDYCMKsu55v5eQui8NGGJTcPCg4j6K3Hf521FO6dTPqKX+/zPjnlzF9ZF1V9pzI/z4X+RJTcAEfmPag65F84nTBs1nB/H78l0mmrcWsTgxCVhuNTVTceqq0daYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760545238; c=relaxed/simple;
	bh=Gs9UY0YuEQiolj2RWvFOFKuPpxPzqSUVE2WCQdLjqD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PGxJ+CyiCpnoc28EglEdbkOcWJwoSrzFlDuoie+MED+asgq+ypZMhoSiOfD1xiuZftKjFY4F2IhCjiv25o+lHdpzEycYCjWjK8Ze74KZ6lNQBkomdyPkC1mMqq+Ut3pNzZaB02brVOP9h9ma7dgTgqdUn7FzN4PvGUrBP7S9lhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+MZwFiW; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33ba37b3ff7so23076a91.1
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 09:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760545236; x=1761150036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHGSwS0Xh4/8TJwqWSM9bFZLIgvx9uKhHHt/eivAx1M=;
        b=F+MZwFiWyY4UfEOr70HkRaIDtVvUMTMF11/7OTN2wb97RyI8vHh9RTRug+AyzHMnj2
         bvZypRNhAd7LP9H72Jq77PydDUw2CqxgQR/nXo0YZ6FTNs+KwIcAXu4mWTidwPh8ZSwm
         KmrC8rzhCW/6SM2EO4XejNPsWorVTSnCzlV0/yWDfROIMSRzwOOirHt68SG1UckibVoW
         5XUiBM+34yz9hlo4n7CpXZwbWqV27P0G58GQpLb2nnQA8xZrcL8nnq4r9TYFH84MQz4p
         PpvH6jcfncwiI7PKIGMD0if1TyajZ4rSg+64rpoAh+6NG5YY5/eUvP+lo2ivBX2YMW20
         82Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760545236; x=1761150036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHGSwS0Xh4/8TJwqWSM9bFZLIgvx9uKhHHt/eivAx1M=;
        b=IG+W+l2XPRMAl4AxKrkptYYEY0jpcfchKosTf0wAZXmAAQF/TMCcKA4t3t4RbQxz+Q
         lVQ1pifOhrk7vcXSh82G0w/gs4hIsHsm1LzOH+0hc9kX4XsQsGzz3+YmP4PALZsrSuAN
         5zDx1GiDBs6ClBOMAGzuDHkhYTIIEL+8Lj6eiT9c5Gia58iy0gy4IJcred8iNYAOYY/U
         KU95tIyszj4NvbC81F2xolyJg2CiABu0zli2llt8cgXu+19unQWP/h3JmXcApAtgg9fX
         XbQFbnHP/nNrRPl6U+a1ds3ay4TXqXXXYCPAhtYA/PlJmRXlxSnDeLIbSkR2IdsY4knk
         WwMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3dGqU6oeaYjmWTPpMIUHlRFPaaNUYByZI0/NRt92Br9zmRPA301M2/ER3Mr4Q4gqWnag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwIMpIOKOm7KUt2x/Onyz76ZP7DV5GeOc/+ZrzX2uE+XbE4e2L
	FOCBu3LkXqXl1TzfKWrDIJ5qxiLtkVroxslOAtFWHOrav6XXSgYyjQa1RsAMfdV6gO1PUe30W0V
	4V8rsuPWm5fqwI8xJInmFZbl1BlPz0PcMdQ==
X-Gm-Gg: ASbGnctbcr5g7Vw+bwLKDfvMbBIiWjx8/gz5G4Ealoa7hkDR4uk0w7uZf6XigRDZDeD
	K8GsJN+wzqiJ9Na1AcIdWlFlkUckdUOqZO7cd8rJ2bF7hh5dVimIelUvZIgaHu8U+63c1jAOJ/8
	LaezWzmFvWn18cUjodFU3GmxAjYR5ywh8+GdlPHwdxJpGb0x5wKvFA6SbYdkoXUc6VpDTW26qWp
	R0sdp+vbH57cZRrzB1iHK2wg7m4By+CFjlZanl06A==
X-Google-Smtp-Source: AGHT+IHqKSz2T6vLqe50EeG6NNQDYgrh2/3DUCJdBvbaM86Uyx3+L01Pu02giGtw7uajrs+6n+n8/i2P86ak/kvV/JM=
X-Received: by 2002:a17:90b:3ecc:b0:31c:39c2:b027 with SMTP id
 98e67ed59e1d1-33b9e0aad14mr851728a91.7.1760545235753; Wed, 15 Oct 2025
 09:20:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQL8PWAqzfdaSYwn0JyX4_TBPWZmCunMn8ZRKJYwgb2KAQ@mail.gmail.com>
 <20251015025049.9492-1-higuoxing@gmail.com>
In-Reply-To: <20251015025049.9492-1-higuoxing@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 15 Oct 2025 09:20:23 -0700
X-Gm-Features: AS18NWCmBAM6uGJhV48egdtOpUmZlLPITi22bcUgUZZmcHX1pul8b9w2NCJ-HpQ
Message-ID: <CAEf4BzaSPbsWGw9XiFq7qt7P0m0Yoquuxca39QrvorKFeS+LAg@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: arg_parsing: Ensure data is flushed to disk
 before reading.
To: Xing Guo <higuoxing@gmail.com>
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, olsajiri@gmail.com, 
	sveiss@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 14, 2025 at 7:50=E2=80=AFPM Xing Guo <higuoxing@gmail.com> wrot=
e:
>
> Recently, I noticed a selftest failure in my local environment. The
> test_parse_test_list_file writes some data to
> /tmp/bpf_arg_parsing_test.XXXXXX and parse_test_list_file() will read
> the data back.  However, after writing data to that file, we forget to
> call fsync() and it's causing testing failure in my laptop.  This patch
> helps fix it by adding the missing fsync() call.
>
> Signed-off-by: Xing Guo <higuoxing@gmail.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/arg_parsing.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>

I accidentally applied it to bpf-next tree and had to drop it from there.

It actually doesn't apply to bpf tree cleanly, so please rebase and resend.

But first, did you validate that fclose() actually fixes the issue for
you? Because I don't think fclose() will call fsync(), will it?
fclose() will basically do the same thing as should be done with
fflush() anyways, so I have my doubts.

Furthermore, your commit message doesn't correspond to your patch.
There is no fsync() call here, please fix that as well.

> diff --git a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c b/tools=
/testing/selftests/bpf/prog_tests/arg_parsing.c
> index bb143de68875..0f99f06116ea 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arg_parsing.c
> @@ -140,9 +140,11 @@ static void test_parse_test_list_file(void)
>         fprintf(fp, "testA/subtest2\n");
>         fprintf(fp, "testC_no_eof_newline");
>         fflush(fp);
> -
> -       if (!ASSERT_OK(ferror(fp), "prepare tmp"))
> -               goto out_fclose;
> +       if (!ASSERT_OK(ferror(fp), "prepare tmp")) {
> +               fclose(fp);
> +               goto out_remove;
> +       }
> +       fclose(fp);
>
>         init_test_filter_set(&set);
>
> @@ -160,8 +162,6 @@ static void test_parse_test_list_file(void)
>
>         free_test_filter_set(&set);
>
> -out_fclose:
> -       fclose(fp);
>  out_remove:
>         remove(tmpfile);
>  }
> --
> 2.51.0
>

