Return-Path: <bpf+bounces-12816-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 799AA7D1061
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 15:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAC401C20F8E
	for <lists+bpf@lfdr.de>; Fri, 20 Oct 2023 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1C91BDDA;
	Fri, 20 Oct 2023 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="KUOW6tHo"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B500E1A728
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 13:18:46 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C241A4
	for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:18:44 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9becde9ea7bso414922766b.0
        for <bpf@vger.kernel.org>; Fri, 20 Oct 2023 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1697807922; x=1698412722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RjDLc0f7CsZ3ZAhf+7oO+KfDgSRyr9/BS+BP5jxyc4=;
        b=KUOW6tHoH0YoRWmfTiYARPJh3y1s6CDX5alQWBN3z01Pox70KX1YmMeO4X8gmj80tz
         K4RAjFE7F6eu6sKWA8DNl5+VOzXiOhmW2Purw1TYWmojIpSfMpme5ITPOvFlXJW6gkOs
         RUxubMSHkKeGzfJUt/vfeX5Uvqu3tle5S0pJ1kJxeDkH9ty7a5MtTh6X0UWOjNkr/NSy
         GR2ERAP5mG5IONJh4g0dqFblVKeR620s2ZyBbRuOvXXt+WPG/xWFf1UHvocjUakUUMWV
         Sy7YWU6fCNmb4JC58tx/qKchZHrcWyHiJcH9jxYAOKOnVZzjUG9M47GXWwKI/rtndEKX
         BwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697807922; x=1698412722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/RjDLc0f7CsZ3ZAhf+7oO+KfDgSRyr9/BS+BP5jxyc4=;
        b=lTqHdCIoU2wssdSTXuLaM8MGCmObDnpx0BPWn4SG2NL+KCMJ9zgPfQ5DHWAeCm3NTX
         IEIGAtzbhrdn8Ok7486h1GW0Cm7Ct+qlLviFt72tQ6QdpbKzcNMcUE+JwXfClxc7GYb8
         hGJ7Lj77BGTg95RYHKtvvtao7S5dB4QiJQREvHs+G8xT1Cglp7fuyGv+iaE3rdY+nOsO
         5x6gR3jywQlrsAvwyytNFSl+oryxUa/f0to914rC5Y6IiAER6oN8j10tS+tj19hTosVa
         HLoWh3XPyAScHG+uPlPTCPU4NCSlN73xkCDWK0KeU3mYACYYKUWt0kDu2jjpyJPezW/l
         PQcg==
X-Gm-Message-State: AOJu0Yze/PPB7aajX2ZxiKIhJqJUd05M6xZZulklIowbADVep4dlmZ2n
	15WRjHFT6UfTp7vxvgnLQsTLlrBlZqmO+XtzNsY2rA==
X-Google-Smtp-Source: AGHT+IHJ0YVjts5wXBN5Jqp31pQ7zOyCplhCxmKRWiIG/OBUb9hPTVLkywcsxvesYEBUsruBmhSCSDcUubMxrq+Mqbc=
X-Received: by 2002:a17:907:7f2a:b0:9ae:659f:4d2f with SMTP id
 qf42-20020a1709077f2a00b009ae659f4d2fmr1364024ejc.26.1697807922329; Fri, 20
 Oct 2023 06:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231016180220.3866105-1-andrii@kernel.org>
In-Reply-To: <20231016180220.3866105-1-andrii@kernel.org>
From: Lorenz Bauer <lorenz.bauer@isovalent.com>
Date: Fri, 20 Oct 2023 14:18:31 +0100
Message-ID: <CAN+4W8hu+zWiWejWtc72WwQb6ydL3U3LXvaFBdc0o826JKzoAQ@mail.gmail.com>
Subject: Re: [PATCH v8 bpf-next 00/18] BPF token and BPF FS-based delegation
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, keescook@chromium.org, 
	brauner@kernel.org, lennart@poettering.net, kernel-team@meta.com, 
	sargun@sargun.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 7:03=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
...
> This patch set adds a basic minimum of functionality to make BPF token id=
ea
> useful and to discuss API and functionality. Currently only low-level lib=
bpf
> APIs support creating and passing BPF token around, allowing to test kern=
el
> functionality, but for the most part is not sufficient for real-world
> applications, which typically use high-level libbpf APIs based on `struct
> bpf_object` type. This was done with the intent to limit the size of patc=
h set
> and concentrate on mostly kernel-side changes. All the necessary plumbing=
 for
> libbpf will be sent as a separate follow up patch set kernel support make=
s it
> upstream.
>
> Another part that should happen once kernel-side BPF token is established=
, is
> a set of conventions between applications (e.g., systemd), tools (e.g.,
> bpftool), and libraries (e.g., libbpf) on exposing delegatable BPF FS
> instance(s) at well-defined locations to allow applications take advantag=
e of
> this in automatic fashion without explicit code changes on BPF applicatio=
n's
> side. But I'd like to postpone this discussion to after BPF token concept
> lands.

In the patch set you've extended MAP_CREATE, PROG_LOAD and BTF_LOAD to
accept an additional token_fd. How many more commands will need a
token as a context like this? It would cause a lot of churn to support
many BPF commands like this, since every command will have token_fd at
a different offset in bpf_attr. This means we need to write extra code
for each new command, both in kernel as well as user space.

Could we pass the token in a way that is uniform across commands?
Something like additional arg to the syscall or similar.

Lorenz

