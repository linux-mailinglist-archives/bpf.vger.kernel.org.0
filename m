Return-Path: <bpf+bounces-79360-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4314D38CDA
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 07:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AF723030DAE
	for <lists+bpf@lfdr.de>; Sat, 17 Jan 2026 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BF532B9A9;
	Sat, 17 Jan 2026 06:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4ohDpWg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C236876025
	for <bpf@vger.kernel.org>; Sat, 17 Jan 2026 06:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768631068; cv=none; b=TgAzvMxmN/9o+GDX/CtFnzKG+J+4gtLg9kliov5kpqYJp6/qMHzAfMXc/BY+Wpc7C7014pK69M9BF/UfPnLFhsfTgDIOd9x5kSumumGcw9pX6UsbrsnvZI7yY+xYedAqezvbuFnDNimVfecNBaEAFWSinmCOxOYuTJKA018emPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768631068; c=relaxed/simple;
	bh=CdIcDz7RhOWA+GvyW5fkuiWxaIE1eJFMfhkZSNRiswE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9PGnk2STnfJMyaXQHMDypnqGrE7MowKjZZ/LlSNyzWFsQ6Q8PB5BZI23myWp07IQBUuMv6QzGU7xTycPUOhmCBP+IfGrP5LpFgnRk3onQ1nbKm9KJfgUbtVVHs6Q9JhPEe9K3SKoVNWSh3xa6w56BQoZwpXteUW+DXuGge7+PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4ohDpWg; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4801bc328easo19380685e9.3
        for <bpf@vger.kernel.org>; Fri, 16 Jan 2026 22:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768631065; x=1769235865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CdIcDz7RhOWA+GvyW5fkuiWxaIE1eJFMfhkZSNRiswE=;
        b=e4ohDpWg6xdIagZQZCEAwiRMxasRUv1KGbi1uPfVcjDh8Bji5vqeKG3SDPxSpnpCpT
         QytLOfp7OsTbkE9d+TNI3CGfh1xYbdmvKYH2pGOG5ABGN8HIXHAU+J1IVLy76Qlp1ifN
         wzwDC+2xA4T+/tO8oBgg/HyGWvkEaErceSAk+WMuy+aW2sn9DthgMRcDvvnxJqBdN+xH
         8syC+JYvpWPATbXwkASdOC2xSj3RH0Q99wl19zJQX3u7E+mUPvSAygjO6+QBRrcsHoKC
         VzPfHIz8R5moKY2j9I0kFjE+VA1TA4YJu4FvxtrjWyxMltIN4YTkz0AhgjP6Tt48iX9s
         lLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768631065; x=1769235865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CdIcDz7RhOWA+GvyW5fkuiWxaIE1eJFMfhkZSNRiswE=;
        b=g39AnZkk91tTiPaCBtB5neOX8fSsbudGvx/8mWaVPwg1NaBKam34mTdMY4yubcpKnL
         rZ81T5xOwj53ux/wAkiBpewHP/6ebIeFtLYlYNSUyqcxyOiuU/Z5LlVjnPcIolJ64XuR
         0FHddA7c0w5Eok2y8fVcmNL1Qy/C3AZntWB0XI9m5RG2VUGxH1ECnT52/GAW0X65p6Mi
         schcVRkxEclRkGIJcmUf1V/H3W1XPAzRZFP/ws/3S+2Q1VdPUhMxnAEZPbaC5zDFcgIX
         O222eP5ebPbNeYwjUdviXLnXGgqHNhwiEH38wWC0FeNjxmXAOeIaAUqp78clKto+yDso
         LCoA==
X-Forwarded-Encrypted: i=1; AJvYcCWyqFnlZ+ipkbkL3NckgqUwt/6V6OcMCUvetTimY2+FxgrHbvKM05OMbKcRsC5JOnK5oRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW2bMSLcBd1h1116tDyjQiRaLNlO17wcrgrTLa1inGxK0TtLxD
	Xu7L3tUyJsxgiUnV8qcflScc803lZcruYfONx8J7UareNqCvI6977yHBpckY4RDA0OXoaD/GedS
	NIu/iKTZSGq561IOMoTjjDEkk9N0P1N4=
X-Gm-Gg: AY/fxX61o7gMqSXIbKlhW3gkF9HllzUO/dMOArBGzIs+LbJ5uOr+U1lGTpDyAw6OzyN
	QmRdlFgYPui+kpAYyTEmSP37ts1g+WfylPf65cpmWbYZTk7s0RJCgemnJDWH79ldoz2JscopVVW
	WoTNrnJQN1Pi2UFzT1ILIUMfkHyveqyQCu3Q1e3aZketZpYBkDjvhrGxhxJehxsqZv33F1YhA/x
	LW7R83+3qisPLQQDpMyoDxDg7RckiEe8aDio7DBz1zdxiuyt2VSd0cO1KSD6URjlxpS9Aeh33Io
	1CQDuwOaVreDDv/7C/7836LVywIcWvatA1JUm4FgGFPMicgTrmuMLRg=
X-Received: by 2002:a05:600c:4447:b0:477:a219:cdb7 with SMTP id
 5b1f17b1804b1-4801ea2a21fmr61041275e9.0.1768631064993; Fri, 16 Jan 2026
 22:24:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <14011562.uLZWGnKmhe@7950hx> <20260117032612.10008-1-yuanql9@chinatelecom.cn>
In-Reply-To: <20260117032612.10008-1-yuanql9@chinatelecom.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 16 Jan 2026 22:24:13 -0800
X-Gm-Features: AZwV_Qj1ro0vsA5I361ENFAZW8cbr-122bfiy43JigsyrXExmJVSux4vWrYmbMU
Message-ID: <CAADnVQKNp8FEdiLfTSs-o+HKE4bArj82R78uQZKJkGfDvWZxHA@mail.gmail.com>
Subject: Re: [PATCH v2] bpf/verifier: implement slab cache for verifier state list
To: Qiliang Yuan <realwujing@gmail.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, wujing <realwujing@qq.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, yuanql9@chinatelecom.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 16, 2026 at 7:26=E2=80=AFPM Qiliang Yuan <realwujing@gmail.com>=
 wrote:
>
> >
> > This patch is a little mess. First, don't send a new version by replyin=
g to
> > your previous version.
>
> Hi Menglong,
>
> Congratulations on obtaining your @linux.dev email! It is great to see yo=
ur
> contribution to the community being recognized.

It is definitely recognized. Menglong is doing great work.

