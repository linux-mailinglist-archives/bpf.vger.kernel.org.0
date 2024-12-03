Return-Path: <bpf+bounces-46030-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CCC9E2E0E
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 22:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DAE1283BE4
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 21:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99395204F77;
	Tue,  3 Dec 2024 21:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOdYvAq0"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7293189F3F
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 21:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733261178; cv=none; b=oXvr2az9ftu6/8J87pBxYZdea4NqxHoZwyJO1oq/jAYa6e5Rl31cvNhaKSez44774VSJWtfc5+vIeNITqcuratC9ZR3/TBAX6TyAGdFV5dAd/5wqFHPokYfBwz0wxE+AY8u2xU4lSPenCgPwU+Ila50QdT0fK9/eh0FW8HIxBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733261178; c=relaxed/simple;
	bh=iG8gpw1i2o/JLyXmdpwvAFLcgApnATw2TNuo5bcYw9A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWJ2arj+dYmxdeHKjmSTGnlRS3mrTm4KHV50HOieOI96NQKonxqcyGzPgW7c7CocNbxbFv1FQ6nHNIpjKPjGxywfp13KcGeSLVmARf7t+ro347sCRabz7le/88UxFuJgGotEf3xK66PYgu3loq5opebTL3V6fqNgJKsApbRn7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JOdYvAq0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7251331e756so5775301b3a.3
        for <bpf@vger.kernel.org>; Tue, 03 Dec 2024 13:26:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733261176; x=1733865976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y7eFtfE076bzhWOVEcN7XJjxR6JNY5En7dNtiD5geYk=;
        b=JOdYvAq0K+0omiaekTJBKNUOoqrQv/Gf3t6M2TQvsI+SDLGcRwF6JB9T5NH8tRJ31d
         bNDhWDxqJaulwpPD6uk67GnsU70wZqHnA/so7QTUGfVRWtnM+4Q/vBUBTj9o1v86Bt1H
         6VIIutYNZRMRFtY443IMxm0dVG2UZlcaSdSIIcg+Wb5Dr0VepJmjMamo+uZRSmaSKl4d
         eNEXb0CtZwV1GM1wxwoxNb2yNWrK9QV6F7EpUPpZAMsxZHgfNrWDfgaCduBA8mjZGQ3n
         qLui3Ve/H+Bybya8ZAmfdMreKcYJeObXr1eeE8r0ZKiV2P1iu/N7OEi7WXP1sjH3aluU
         EeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733261176; x=1733865976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y7eFtfE076bzhWOVEcN7XJjxR6JNY5En7dNtiD5geYk=;
        b=ibmcdvCf5TDIRFqWSOC97YZkRcURYf5DTLhfSwWRX7lVAB9QubBT6vHuWEYMtGeQqk
         9PIAiEyDeV68H/0bjd+Gm2ZgS8g6CF1LJANwP9MqbA7oYepf78UV+Xnww3QU0tGvrYpo
         VQCwI1PjAs0MSISQsmwF9EIxQwPIaj5OFASdIDkqdIZPDgtscEcLrpWenWBrtWBYxv8P
         JeTDVx45mPfOX/YQJcWf4JRfI+0KV7GvDChAvjxKdE5wevZEyTcdK5qPTmJ8ysoHPFcW
         IRMp7p9LcPH+4682OnAuNHA2a5fqQ8fUWVWk1khYocgyElnQZsCjdqwY2Z+L78JwAT/I
         1uqA==
X-Gm-Message-State: AOJu0Ywshh5KEwUzVBvHX8onLJURJrIz/iuqzCLMOhrOGn67TODr1AVr
	p7fjneGGpa2nabrP5gkCrHFhxjQPAQ1uQFUB8+qoQ1jRMcCQ29VrZlTwxrADJzsjHMA5poTLhuF
	ZMVPGMJ6KIVIh/CC7erVIpYmBbeTp7Q==
X-Gm-Gg: ASbGnctyc3yE+HdBw/QdVKPJyGjq3A5ZA3MQbiXrUQmE2LsY9mw1rSwuuAMPuWyk3Mb
	zuBJL2Es9yYGI8w6evmcG1BhnJDRzkk/e9syycYxELETLQuQ=
X-Google-Smtp-Source: AGHT+IHvUhy0tG4a5P1XnqpV34e0KfsiAYO9f0GrUquQzV7iVTOzXwWtiuCYRIqs2TU18aNVfS6DFuz8Wj5Bewzdr1E=
X-Received: by 2002:a17:90b:46:b0:2ee:c9dd:b7ea with SMTP id
 98e67ed59e1d1-2ef0124f700mr5430208a91.24.1733261176203; Tue, 03 Dec 2024
 13:26:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203135052.3380721-1-aspsk@isovalent.com> <20241203135052.3380721-5-aspsk@isovalent.com>
In-Reply-To: <20241203135052.3380721-5-aspsk@isovalent.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 3 Dec 2024 13:26:01 -0800
Message-ID: <CAEf4BzYMNrAuwiHuSEPoorkY9=7tGTLhqorq7YjyfyaqJY78WQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 4/7] libbpf: prog load: allow to use fd_array_cnt
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 5:48=E2=80=AFAM Anton Protopopov <aspsk@isovalent.co=
m> wrote:
>
> Add new fd_array_cnt field to bpf_prog_load_opts
> and pass it in bpf_attr, if set.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  tools/lib/bpf/bpf.c | 3 ++-
>  tools/lib/bpf/bpf.h | 5 ++++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>


[...]

