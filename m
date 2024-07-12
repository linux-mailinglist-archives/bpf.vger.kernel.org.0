Return-Path: <bpf+bounces-34660-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B435692FE01
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7763B281DBF
	for <lists+bpf@lfdr.de>; Fri, 12 Jul 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3606C1741F1;
	Fri, 12 Jul 2024 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpPnGe68"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519F712B171
	for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 15:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799876; cv=none; b=awgRH6blbkL1Tc+u+sDxAJXuDBdPcV8Mc9DY33IQi+5xLnzlp0jenM7ptS3Ta5mCTc9TcG9ClLBN43ohKB31YStRO5sXDVVnfL/lh/x7SZy1VU3/iHXbNJc6mGaTvaG9c89GeeYjsS6uyTarqSBki0ixv40oopwM+Ml75xtpJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799876; c=relaxed/simple;
	bh=ydrIsRpPM+rcYgi4udGvQNmTCmC/lNFwmdFl/HIKKtk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMcTeQt4w1b3fk1vjG9yFeDzUrMkT36Thu6x6i3vyXsVzQaJt7/FKvSPMIok6Q/INztVjVFA0d+F3aKZneUNRYdGKL7JLQaoH5MTGSF/0S48Mrkj4IH224ReBzQe2VWS7U339CUrc+rpgfU0XHjTKa8f4JlTMA04kOxliGUrNQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kpPnGe68; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-367940c57ddso1324854f8f.3
        for <bpf@vger.kernel.org>; Fri, 12 Jul 2024 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720799874; x=1721404674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydrIsRpPM+rcYgi4udGvQNmTCmC/lNFwmdFl/HIKKtk=;
        b=kpPnGe68HS0Ds4KZvdgq5l+WbNFQT8S89Wbc6zhmf8DfxrI7L6xeLcwFVFM8NKrsdu
         RC3QqlrIms59pGOlB33eZ8cIvNM1rn6IK9NPxYyGBfCDtARzas1jzgw4aC74ATgdoduA
         W8idpqJ0qacZXiOnF+gUyTRUWykEHtL+IFQsJcyIKmt0MEC1wVyU8EvnPGE8/pTOUGS9
         3or3EL7CYNwWljRoVEVyhKuQ75C668ZYT06OuwQg0f4zuAwB6M1Id+SimqzD7HKTmq/r
         KnHQNBXV7HKHBl3NsVezZ9BR4Gzh68uKRFLTVDb6vw8SXLLr7SqzQtZAirhiiwhwxPLd
         i1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720799874; x=1721404674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ydrIsRpPM+rcYgi4udGvQNmTCmC/lNFwmdFl/HIKKtk=;
        b=X1+Jv37lXl5fmJnho6yLxWVbo+gyUWonEbCrEbkH75qtu0Wq2cwvndC8+tQXEyQMRA
         iRjxy3DBRCpVfEPv6KWgyTVTzT9xzxkPsDGTvUHr2zarC7UWFX4XO1YnDwHLeaiXgk01
         sYO2GRXG/9eFFz8GQ4BrvXgwWMuqxgYaM6nq64wvnGww3DMuwQjsjSLDO4JkTGMoSU0I
         wX/P6OLmbETGLo7X7qRQ2yD4xJe/qwb0moZW445DqKFXMZ4OefI4DZYetD2yAQiafXE/
         72WbNqEEuah+jxGEOeEkoHPZO/JnkpZYlEugcUAjk/ir7kkU2Oq8scqXbIHwI6PkVKF3
         cSYg==
X-Forwarded-Encrypted: i=1; AJvYcCXMwQDdTzZuxYR436lMYoTskA2xC5gR4PNTIQDjHXvoN/0os9uE6Cb75jcXvb5uB/G9Pm/tCClRZ7l9RbymnysILm00
X-Gm-Message-State: AOJu0YwFO+yVXcNolOLZupoRmc991HUQR0N0PysaRMw24SPqR+8FOZUB
	HXqxeMZJqp/a805YvmjuIKudwK3oK35fYOMHB+O+5kg7ZxOC5kPmFNlek7eqrV/QugjmsVM8OZ4
	G+3SAy/pi/iBK/bIodwMHP6owj3g=
X-Google-Smtp-Source: AGHT+IE2wedoZplNVnE+RJ0HBGX8HsWOkyVTHpndi4ThdKEuZwnHs6wogyOjJvPa+X4Y5BR+q+36W8qA4UoBlOmjONM=
X-Received: by 2002:a5d:6345:0:b0:367:4154:c430 with SMTP id
 ffacd0b85a97d-367cea965cfmr7810456f8f.38.1720799873421; Fri, 12 Jul 2024
 08:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1720778831.git.tanggeliang@kylinos.cn> <2437275bb988da5c187b4d0223e5c0c9843fdc76.1720778831.git.tanggeliang@kylinos.cn>
 <83163d7e8162988e5235cca5d79ef3dba2d54565.camel@kernel.org>
In-Reply-To: <83163d7e8162988e5235cca5d79ef3dba2d54565.camel@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jul 2024 08:57:42 -0700
Message-ID: <CAADnVQKyBqWJNJKQ5xkMSo8CpWkdrcbHVOzqJxmia2QKb95rxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] libbpf: handle ENOTSUPP in libbpf_strerror_r
To: Geliang Tang <geliang@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Geliang Tang <tanggeliang@kylinos.cn>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 12, 2024 at 7:20=E2=80=AFAM Geliang Tang <geliang@kernel.org> w=
rote:
>
> Changes Requested.
>
> Will send a v2 soon.

Do NOT. Stop this spam of patches.

