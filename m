Return-Path: <bpf+bounces-3336-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8FA73C5A8
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 03:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075551C21358
	for <lists+bpf@lfdr.de>; Sat, 24 Jun 2023 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F5A385;
	Sat, 24 Jun 2023 01:00:20 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D953378
	for <bpf@vger.kernel.org>; Sat, 24 Jun 2023 01:00:20 +0000 (UTC)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002FC26B8
	for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 18:00:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-51be5e18cb4so1298540a12.0
        for <bpf@vger.kernel.org>; Fri, 23 Jun 2023 18:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687568417; x=1690160417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lb3Ucdi3S52+btdQwqp0fKE/+kYG54ZzrFvPfaINd4o=;
        b=LdEGpFG3HUp+wmtVjezxwIMyY53408Uh3xjsA0VzMElvq/4dhN3P3I2iW7UvsgXtBR
         QQHZmt4qo+TOgLfzxSPyd3eBY2vmxuzxc0/r180FY71Y7Mrszfr1Cid2Ql25APeHg/hm
         3qYZfQItPOdCygLo28r0tfzwGrx5EWPguDafasbiNGw5XKM5v0/z6dVrG0jht2yE0ljr
         63R5hEKdfb2p2tx02TYexPZIzfsj77euP7crMAj44DVZhPhAIzeUY2vQ+lgFt0oY/FF7
         kzQpbEoY6RW2r9AhdIZ9FyfzpTIiSuPR6EvpcpOy51+LAB96+Nzxsog+XpLmHwmsSxg8
         lzKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687568417; x=1690160417;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lb3Ucdi3S52+btdQwqp0fKE/+kYG54ZzrFvPfaINd4o=;
        b=CjnoqNXL+Wm8/Tk3bkfFSZl63QBbogkLfA/nXCIMxwPpCXnZHajiCuM/SGdgisCp90
         tW4LgjfaAQL4LKy7pRxpIGhXQPIhjdlaEHG9AKJR7bUs0xG1VyucVUffMhBGP5huKCwL
         08WbibXZ3NQ1eO5dL0utcPqqLkwi9ApsV43hlxh+9uit5C5q7f9bX/qVGW3T8jTMRqKX
         cwYalSUAqXmqLaXS5Yo2kHqfU5nuNMaaGwckhGCSm1wAFQuPLIH3cpy/ELlSN+lBvd8M
         no+fLPBZiTbHVK+T2JpBJv+jZ6fYDCR09HiicdgED80noCeDY3O3nOlfOnUStHzCurJX
         LkZg==
X-Gm-Message-State: AC+VfDzCjw2KKY0bT3cLGHsdYER/QAxrwnkaWfYDc81Y//nPhK8cRtWp
	SsK253ZCerFyTsLsgPwmHbZlCtvNwYCVYiTvRzinQJk9
X-Google-Smtp-Source: ACHHUZ5eib2l5zZ6wpLEPp6GpYUHF+zykA6M69bqpVuUvTzkahw/Ppg2PTPrIsZoRVVU+PsWu8Kmx6fjPuTIAQT7cfk=
X-Received: by 2002:aa7:cf19:0:b0:51a:313c:4407 with SMTP id
 a25-20020aa7cf19000000b0051a313c4407mr15476397edy.6.1687568417198; Fri, 23
 Jun 2023 18:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGQdkDvYU_e=_NX+6DRkL_-TeH3p+QtsdZwHkmH0w3Fuzw0C4w@mail.gmail.com>
 <CAEf4BzZWWjhrpGpbkU+qy5+ZoPVDHnhp9grQcFoxf11B9Lq1Ow@mail.gmail.com>
In-Reply-To: <CAEf4BzZWWjhrpGpbkU+qy5+ZoPVDHnhp9grQcFoxf11B9Lq1Ow@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Jun 2023 18:00:06 -0700
Message-ID: <CAADnVQ+d9fM_p+ZA8Mfe+m1oLCorYTZtFwo9aKb5C8_MiWw=NA@mail.gmail.com>
Subject: Re: [QUESTION] Check weird behavior with CO-RE relocations
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: andrea terzolo <andreaterzolo3@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 1:54=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> > If we use CAP_SYS_ADMIN all seems to work fine. The issue seems
> > related to the fact that during the relocation libbpf is not able
> > to find `audit_task_info` in the running kernel BTF, since we are not
> > running on COS system, and for this reason, it searches for it in
> > modules BTF, but in order to do that we need CAP_SYS_ADMIN[1].
> > Is this the intended behavior?
>
> Not really, though it is unfortunate that we need CAP_SYS_ADMIN just
> to find kernel module's BTF. cc Alexei, maybe we can relax some rules
> at least for BTFs?

Good point. Since BTF_LOAD is guarded by CAP_BPF there is no need
to restrict iteration and get_fd_by_id of BTFs with CAP_SYS_ADMIN.
Both can be CAP_BPF.
We can consider relaxing btf load, iter, get_fd_by_id to unpriv,
but let's start with cap_bpf if it addresses the problem.

