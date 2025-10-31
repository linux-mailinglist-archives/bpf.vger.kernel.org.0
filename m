Return-Path: <bpf+bounces-73162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0AC25959
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 15:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 029B84E95A5
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 14:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685D434B667;
	Fri, 31 Oct 2025 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekBb1BvP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B40434402C
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921097; cv=none; b=XlO4P1Br3MnbTHPXMRuI/ArH2mIPnq23uICv4f7Yj/rimfNeLev57soYDgan+zaq035+h6MLsBUq5paILCji77M3AdzAAh7Zw8KUwuXT73wAaIs4B1CQazEIW2mT3aJKOJncadZXIcxjlIP/SxSqkqd7SEOstpdV5+vdVZ1l7XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921097; c=relaxed/simple;
	bh=ncGbPazCZYRVMKM/k7v7Zi9/MqF67N4ANYFa0XpW/Ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UE9ztvv+sOhctONSIYpMEFrQICoBi0sYEJ2uwTDawXNCFdjz0/JTvdJLp7ttRoem+F6PzHRGPqDw5WEi1BHuOICdlQw3SN8baCa55EuhSTu5M2L9WqPVtR6Y/HUL3qukVocLljJ1J4AYxbqdZucP89JRTUXEFGZeDiCyILhjaik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekBb1BvP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429b85c3880so2186500f8f.2
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 07:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761921093; x=1762525893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncGbPazCZYRVMKM/k7v7Zi9/MqF67N4ANYFa0XpW/Ig=;
        b=ekBb1BvPk/4XQppwL89S83+HVcOJ44UixxLR+znuxNZCQciqRLvtDAlTxyjBl2eXeU
         8Z+remJhUfWN7gOxlsge3E5CymQXh7CnDymgA6jo2jjyfFf8ekO3UoLxYNiXrll4CnO7
         A0Xnsaj0CMp1tLz2rSzP2IpFU/vvEw4hpK0JkeZ6+LthfwW9967Z+tIksS14pfVJ4NtM
         1Ra4jaMRNp9WhpmV/7riXahV4qhZqvCuIaj6hqbRC68Go/9b/XDrh00v7t7dPDOGgjdc
         1fHEt80IepOHRuGMNpR/pOuOinbTWY3kovV6LHNnhxZqSHKNXXZTHg9dzvwNKUOBTav3
         JVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921093; x=1762525893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ncGbPazCZYRVMKM/k7v7Zi9/MqF67N4ANYFa0XpW/Ig=;
        b=fm0o3EB2tdWriBGb+n8wJC9vH/kNzFvX2ZYuryOFaeFix+XhA7CtWROfuoPEg+FF9Q
         NWnIccja1y/5HBFWWMw9CMRSITJurzE665VBM9xGE1iOCt7JlWT69y5/kJkILDzs4N4r
         iB1scCcVW1/qxFZE+8BDVATFjkZzO5ns7pm1O4d+kt/oQj3Z4BEeGdBW2FrtfjPAbRPI
         zdkMvbvowihxGNdqqx7IQXgbEEytrkG/XE5CinT8z3kI9YhA6L29S36oU30T+a2cMIf/
         7QOybmSE92uKqXqZnBiKWTPavq1SNywDn7nIyv620wHp1GtR6ARVrLpVt8CUm6Slbgb0
         nieA==
X-Forwarded-Encrypted: i=1; AJvYcCW0lvQDhU4lRoKzPhliLLmjcGy+EFWb8JHjSzy/vPVPN/YFFffwR53fZQ+5fivCPMI+iPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOY/nNU5fbHqFKm3J/AubWFfWrmp5d9FtA5kRkV2PbZAWwmxZ+
	iUKUhpPL5y+9yg0KEzwTNWXlOfMfhN7LQS5H4dMLP9inFrpjvEqOEiy6lJocuWz3LqpDdIlc/z/
	gyQ5FXXS6D/H2w6+h9maJ/hFg71+SbRU=
X-Gm-Gg: ASbGncu8L7yKaVt2imA/WK3oELLh2eXd4l9vlube1Zp96ylA6b6GQR8hFDx7REbfgnx
	8aOAgkG4vGhLZX9DZQIUpwW1D+4yIxBGK2Vzw3ZG23MGXuq7Iy7AueqTcWC6d1GN/NPgcxGgiNk
	8YgL6RS25A4V78XmUq3Plbqfm0Q20onLkemT387eUwmnyt52UKLN18CoEs3in4ZDrnceU5z4Vfv
	1hVrMcw50+YTejTmXipGl5yiy1dDGtVKrd4+hgdh1A5m9lfbY2+lM1HS5V5QjucetJYuFhBYZND
	yxQZy2nxLPeni8czUw==
X-Google-Smtp-Source: AGHT+IFiAqK/+Syn9mgwZcO28zXvwpfW9s7eMblmTPyk4lo2e6ZewS1h/5hEgaWteHfEGFYUaGs6VLJABfpETB39Bsk=
X-Received: by 2002:a05:6000:4211:b0:401:70eb:eec7 with SMTP id
 ffacd0b85a97d-429bd6add28mr3046896f8f.43.1761921093400; Fri, 31 Oct 2025
 07:31:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031075908.1472249-1-jianyungao89@gmail.com>
In-Reply-To: <20251031075908.1472249-1-jianyungao89@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 07:31:22 -0700
X-Gm-Features: AWmQ_bnkIg3K0cArYapCkNQ22ELaPjdwF2hB_Pz-BAsAugJn3W59knHozn2meJc
Message-ID: <CAADnVQLR2R6N8HvuCKk696xkSZV06QJA3_d9Q6BSrf3MHv-WuA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] libbpf: add Doxygen docs for public LIBBPF_API APIs
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, "open list:BPF [LIBRARY] (libbpf)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 12:59=E2=80=AFAM Jianyun Gao <jianyungao89@gmail.co=
m> wrote:
>
> Hi,
>
> Background:
> While consulting libbpf's online documentation at https://libbpf.readthed=
ocs.io/
> I noticed that many public LIBBPF_API helpers in tools/lib/bpf/bpf.h eith=
er

stop this spam.

pw-bot: cr

