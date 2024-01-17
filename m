Return-Path: <bpf+bounces-19716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F06883028D
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 10:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E3911F212CA
	for <lists+bpf@lfdr.de>; Wed, 17 Jan 2024 09:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C1E14019;
	Wed, 17 Jan 2024 09:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGeP6NWt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6558F13FF9;
	Wed, 17 Jan 2024 09:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484584; cv=none; b=NnKSdHR/94HgUGE5fGzLCBZ3D5aAfT+IgrEvUW9uwcpoaD0+vnhB7tzyT/EIdk2HH94/yUsG6T3wZQgW9WcWQOqKee3OyAWO9Tfb0o+tg5LXFkS7V7m7pfFFgskjHMNGXtILCs+LXDLQQYYe/KBla4moqnTt8LuxlqZ8Ukiz+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484584; c=relaxed/simple;
	bh=1HGpAcr+TReo+8xuEK9BrlhmH+ENa6qJUYnqdZLjux0=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=qwAlj1v6pDuyKv7COie1moP/MnTPng7P36HG0waIn2wEd8sq/gnqGfEruPSzm3DYDYjyhaJBPVg4w7baiKnQ0yksFYV5p3bvi+zSEYP12szOwuv4NiFuxIXu9YjaS+c3TCYSIYVLtYLAGg5TLezb1b+y0K0FBgVUffTq6lhtIVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGeP6NWt; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc2276e7176so1365966276.2;
        Wed, 17 Jan 2024 01:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705484582; x=1706089382; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5flkVV4v4QllZCyX8quSfFdcgNw55yiflJqxfEiOHFU=;
        b=MGeP6NWtHZ85DXa+20G6s0PKoXmUmckpVnwLVaoAGFVmkrvLgg8MxrdLkAsneZ9NMK
         wD/OOG4U4RZ/2RV4dzNaMAFrfI+Ukr4/8oZLHsj/ngCcjco4fLaCQ8pYcXizZaaXSw8H
         IWJcIF0e8aFzkdC+r8s5MAjKyGmBoSldnfqFl4xxbJMLXcWm/36i1cO/MHZB+4xvBEPz
         83aK1GE1F2y1qzVs4wP4yDkp7WAPs7CA/y+8HUCddsm1FnrQi16IiJ2YaSg8h4T8lBpt
         xz871ed5kuIOwQVHEnqx+AhZe1EWr1Zab9c456CPFtXStcPyHllFD9ijtTnsXzjfjt6V
         5VoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705484582; x=1706089382;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5flkVV4v4QllZCyX8quSfFdcgNw55yiflJqxfEiOHFU=;
        b=q5ynxqkdqlxWLL3NIB0nQDjaLE4zQcrz4wgZkO7YnOAcdngwIjyR2Dc4szJvsZxHD6
         ONnzkjD7EGULH1orhhELPjb7ur8YOYVPvqzgn/8gqKASOrFFO0StMISD3uRNuNjEbnyD
         dkmYGu2vGqCv2rTyFV9RSBx0dJeq/EUNAC0FkG0lAz9LAVcfXgCqocJ5cpWnUxnE7Ygj
         NwO1OE4qnQeuCIxactI1jCQ3PNJ+faR5OQ/5u+aWsgZrxDngaZ0Lk81IRMH3IqNGmQjv
         +yJd1h0iLmH/XtnVwKMv5C5IauppiTCrCM67GP8K9IYkhv9kDpgk9or9uNETEGtWWpg4
         cXHQ==
X-Gm-Message-State: AOJu0Yyan/TYlJa+KIa/mv+7fdegTF73UfvHyYhtFbm5GGACpaHd4iAT
	EdbLKURnICwPh2Pz56IZh9h0uz4jmds2NKXl0gpHyTI=
X-Google-Smtp-Source: AGHT+IGHqFDVFbhJYBTCVFE8UVI9UjiwQ5SgebdHzr9cL5W/HlLlCqm9JL7lmFD7YWysTijXgvn3WZGawDWgXvcxwAU=
X-Received: by 2002:a25:684c:0:b0:dc2:2b41:c8e7 with SMTP id
 d73-20020a25684c000000b00dc22b41c8e7mr1490428ybc.127.1705484582005; Wed, 17
 Jan 2024 01:43:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240117094012.36798-1-sunhao.th@gmail.com>
In-Reply-To: <20240117094012.36798-1-sunhao.th@gmail.com>
From: Hao Sun <sunhao.th@gmail.com>
Date: Wed, 17 Jan 2024 10:42:51 +0100
Message-ID: <CACkBjsZFmYK-j=JDbCLhNEzYELQits5NB79uNa4p3iHmoKwh5w@mail.gmail.com>
Subject: Re: [PATCH] bpf: Refactor ptr alu checking rules to allow alu explicitly
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 10:40=E2=80=AFAM Hao Sun <sunhao.th@gmail.com> wrot=
e:
>
> Current checking rules are structured to disallow alu on particular ptr
> types explicitly, so default cases are allowed implicitly. This may lead
> to newly added ptr types being allowed unexpectedly. So restruture it to
> allow alu explicitly. The tradeoff is mainly a bit more cases added in
> the switch. The following table from Eduard summarizes the rules:
>
>         | Pointer type        | Arithmetics allowed |
>         |---------------------+---------------------|
>         | PTR_TO_CTX          | yes                 |
>         | CONST_PTR_TO_MAP    | conditionally       |
>         | PTR_TO_MAP_VALUE    | yes                 |
>         | PTR_TO_MAP_KEY      | yes                 |
>         | PTR_TO_STACK        | yes                 |
>         | PTR_TO_PACKET_META  | yes                 |
>         | PTR_TO_PACKET       | yes                 |
>         | PTR_TO_PACKET_END   | no                  |
>         | PTR_TO_FLOW_KEYS    | conditionally       |
>         | PTR_TO_SOCKET       | no                  |
>         | PTR_TO_SOCK_COMMON  | no                  |
>         | PTR_TO_TCP_SOCK     | no                  |
>         | PTR_TO_TP_BUFFER    | yes                 |
>         | PTR_TO_XDP_SOCK     | no                  |
>         | PTR_TO_BTF_ID       | yes                 |
>         | PTR_TO_MEM          | yes                 |
>         | PTR_TO_BUF          | yes                 |
>         | PTR_TO_FUNC         | yes                 |
>         | CONST_PTR_TO_DYNPTR | yes                 |
>
> The refactored rules are equivalent to the original one. Note that
> PTR_TO_FUNC and CONST_PTR_TO_DYNPTR are not reject here because: (1)
> check_mem_access() rejects load/store on those ptrs, and those ptrs
> with offset passing to calls are rejected check_func_arg_reg_off();
> (2) someone may rely on the verifier not rejecting programs earily.
>
> Signed-off-by: Hao Sun <sunhao.th@gmail.com>
> ---

Not specifying bpf-next as the target repo as my previous patch is not
in it yet.

