Return-Path: <bpf+bounces-6384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208876868B
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 18:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D88B28161F
	for <lists+bpf@lfdr.de>; Sun, 30 Jul 2023 16:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B24100AC;
	Sun, 30 Jul 2023 16:54:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29933D8A
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 16:54:10 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B37F1720
	for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 09:54:04 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b703a0453fso54802281fa.3
        for <bpf@vger.kernel.org>; Sun, 30 Jul 2023 09:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690736043; x=1691340843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlpQO3eqc+n1ZddAq3p1ZMss7FwpLSAsmK75j0/szpc=;
        b=V0ha3JwV+I5cPLHceC3x+agRApVm2VvLwxdhKr7zKQ12a6BlffWt/I/Rd0yGtWk/Is
         OUOgQGUibBJ7tA42NP3F8dd+iduCdaMPOP5DmCTOj5FgX/aWaWzErM/KQH8Cg8plJCzN
         7ahkhEKpz+34GRrTgQ+kNC2l/G+0nlx4jRk017qWQxHoqGFrGbsPxIKjFojtvTl3bxIP
         3V0hmEby99E9hMl5rSQnTIJAV2/Q6p+d4NQiCDjUAeQZD3K9J2vArieVzTr22ef8uSZ3
         CmvksCfHXJfzbwfhQBqX1erpXDu476yXhAYmJWCWKazGWdsg77HhZN5RUNmQ28ZsYjwk
         i60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690736043; x=1691340843;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hlpQO3eqc+n1ZddAq3p1ZMss7FwpLSAsmK75j0/szpc=;
        b=bFTOeyyWN7flKOB4XgtZpBeSngYHjaCd8veztgzfbBgfFuyfHHqkq96Bxf9IUKsUeX
         M7CVjnbmWPdlbooEraIjism8dWh/Yr72JLDUSiM4JkAU6TnQruNaYkifg3M0bj+cmRR6
         TzBEtkCOenTRANGuzAxF2e5rsbxQTNNPA5iV2U6FaoHlMJ4fPuBWqG1qM8MdlQstrhRp
         pmU3ym8mX0eCvtd2z/39NUfx0NwPltZxn4zpMsuXiDO+SRbtpV7P34/+26t1zPUs2HFs
         REcX+MM66dJBTn32ltGjdp5vD6RQfhYLULViS9UfmSxNiyoy0FDLNxGOONIuYwx4XQK7
         QAzA==
X-Gm-Message-State: ABy/qLaQyCmyGr9aO9k3mlcYO1dy/yvE7XE8wyoEFx0FRfBOBDUQcg09
	VlbQIDq+WyQR85nCnvMOU1o2w6BnGhkgNpmg2Tk535IHW0Y=
X-Google-Smtp-Source: APBJJlEvq0FwMRvHCjnqx+kkl5Amj1cR8hpO57MKG4sUnJBOJB9fTPO7klhPKyypWuOUr2o3ds0CXpBBx9ZBo0FUVNw=
X-Received: by 2002:a2e:9e97:0:b0:2b9:d05a:3dd0 with SMTP id
 f23-20020a2e9e97000000b002b9d05a3dd0mr4143203ljk.33.1690736042514; Sun, 30
 Jul 2023 09:54:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <878rb0yonc.fsf@oracle.com> <13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
 <87v8e4x7cr.fsf@oracle.com> <87pm4bykxw.fsf@oracle.com> <CAADnVQLaZrqq232fxts0GmymaaG=fpvRbSZaBkfNnKFuy0LM8A@mail.gmail.com>
 <87jzujnms6.fsf@oracle.com> <CAADnVQ+2mHqRc2EBCKe+NHHPQ+FqaNt2PmD6t9DN6GwPnu1RQg@mail.gmail.com>
 <87edkqm257.fsf@oracle.com>
In-Reply-To: <87edkqm257.fsf@oracle.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 30 Jul 2023 09:53:51 -0700
Message-ID: <CAADnVQ+gLXpeY-kOJ_cEAuoXkrQeeD+KL6jsFfyDXcm+rk-xmg@mail.gmail.com>
Subject: Re: GCC and binutils support for BPF V4 instructions
To: "Jose E. Marchesi" <jose.marchesi@oracle.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 9:54=E2=80=AFPM Jose E. Marchesi
<jose.marchesi@oracle.com> wrote:
>
> The individual flags... I am not sure, other arches have them, but maybe
> having them in BPF doesn't make much sense and it is not worth the extra
> complication and wasted bits in e_flags.  How realistic is to expect
> that some kernel may support a particular version of the BPF ISA, and
> also have support for some particular instruction from a later ISA as
> the result of a backport or something?  Not for me to judge... I was
> already bitten by my utter ignorance on kernel business when I added
> that silly useless -mkernel=3DVERSION option to GCC 8-)
>
> What I am pretty sure is that we will need something like EF_BPF_CPUVER
> if we are ever gonna support relaxation in any linker external to
> libbpf, and also to detect (and error/warn) when several objects with
> different BPF versions are linked together.

Ok. Let's start with EF_BPF_CPUVER 0xF
and not waste bits on individual instructions, as you said.
When kernel backports are done the patches are sent together.
It wouldn't be wise to backport SDIV without JMP32, for example.
git history will get screwed up and further backports will be a pain.
The risk of untested combinations increases, etc.
I think it's safe to assume that a given kernel will support either v3 or v=
4.
The kernel version doesn't matter, of course :)

