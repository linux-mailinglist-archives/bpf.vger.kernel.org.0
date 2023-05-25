Return-Path: <bpf+bounces-1232-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FFF7111A2
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 19:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F34D28100B
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 17:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C511D2C3;
	Thu, 25 May 2023 17:05:07 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2091D2A3
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 17:05:07 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876F6194
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:05:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f8d485ef3so139624166b.0
        for <bpf@vger.kernel.org>; Thu, 25 May 2023 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685034303; x=1687626303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5696Xw82qMGj/H4NVcM8xXdbN2ppjHna+8jGqBB5/o8=;
        b=pFApMNfXvZPRUQbTEwd9PmLkDYMUdHCZYpCT7a+AbSSEqFdT6FubEL3Jc0d10Pyrjz
         VtfaYdAl7V9/4k4gE1vlTAA9W62bpjO/nqO2KsO+3r9kLTY8QpCd7KonOAFdZ7Agv+7c
         MLVZTQzn/FbJ0F/EDnQ3G5smuUdg+iid8hBRnkYd2q/LAXonw9C4xQgk+CUpftHhBYSu
         wfydFMepvJU7b4ls9g/001AxxRUQznKIrecquCrOe74797bqi08YJRM9X8fBq8iHI38k
         Ueiuie12ejMghsAjQcqc/C6qae1C3aStQyu0Pv2CEUSb9Gk6XgtIsDimn/+WfQG57p4f
         3XSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685034303; x=1687626303;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5696Xw82qMGj/H4NVcM8xXdbN2ppjHna+8jGqBB5/o8=;
        b=jMkkZSeQSH4tYbccL026P0X/NZYAOLuVG/PID8kMK7CIKqI1Hc6KrVx81K7NtK9EIu
         0MfSofTawdj2dPCciwjUhH01oHv1PZIchHo42sJ7udeuloB/FK59LJrPEKWpxy0864dz
         vO7NT48a5/celFm0uD/RF/8+QFk7AF4PJe3r6PwmrrKjCiW+pn/edEdOa9ZVeiWdqk/1
         6qW+JqRwmqPJkmhV1wE6EcJQfK0EZwP0G4IWBYXgFFg60wRLevLHQivuLohiNL7vlIEX
         YBBEz2UHhasBgbYuCr+WAOUDwcZspuX1hSoHBKr0VLdqmamXSK6KlFsa08kDKlsqMDTR
         /82w==
X-Gm-Message-State: AC+VfDxVEglrBYS6ni3CtkW+L2n8fmR88mwdYE6lRvZ+FkVn888GXDY3
	yMHJxPkLXm9UD5egKgWx8FE3UivPTEjnEmHSWOg=
X-Google-Smtp-Source: ACHHUZ5Omnj0wzsjblVPuTkKEJufzEjMYRCfTC6NsK/+iGm+LmLJ1WFsuK72pipsWL9RVh7YJm+jq6NqakRV06vqmcA=
X-Received: by 2002:a17:907:a41:b0:973:7071:9b30 with SMTP id
 be1-20020a1709070a4100b0097370719b30mr2123509ejc.51.1685034302787; Thu, 25
 May 2023 10:05:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230524225421.1587859-1-andrii@kernel.org> <20230524225421.1587859-3-andrii@kernel.org>
 <CAADnVQJ1UEDVH6L=CEjbAudgKmDbp26=-3AfU0sFA_j92Dhn7Q@mail.gmail.com>
In-Reply-To: <CAADnVQJ1UEDVH6L=CEjbAudgKmDbp26=-3AfU0sFA_j92Dhn7Q@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 25 May 2023 10:04:50 -0700
Message-ID: <CAEf4BzZNfj1M5NcmUEQLudH0DjiexaR9UZPQ_U+xvbtviXGtAA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] bpf: don't require CAP_SYS_ADMIN for getting NEXT_ID
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, May 24, 2023 at 8:23=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, May 24, 2023 at 3:55=E2=80=AFPM Andrii Nakryiko <andrii@kernel.or=
g> wrote:
> >
> > Getting ID of map/prog/btf/link doesn't give any access to underlying
> > BPF objects, so there is no point in requiring CAP_SYS_ADMIN for these
> > commands.
>
> I don't think it's a good idea to allow unpriv to figure out
> all prog/map/btf/link IDs.
> Since unpriv is typically disabled it's not a security issue,
> but rather a concern over abuse of IDR logic and potential
> for exploits in *get_next_id() code.
> At least CAP_BPF is needed.

Ok, sounds good. I was just trying to minimize the number of commands
that would need token_fd.

BPF_MAP_FREEZE is the one I care about the most, if that one looks
good, should we land that single patch?

