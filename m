Return-Path: <bpf+bounces-22330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE1985C2C6
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 18:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17D9DB23567
	for <lists+bpf@lfdr.de>; Tue, 20 Feb 2024 17:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13F6077652;
	Tue, 20 Feb 2024 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MYR/rB3z"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616F74E0C
	for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450495; cv=none; b=NytWVTVUd6cUm8cW6wiNN5v4HbkU6xzhoQVnZVVQBnmbWU5gPUY5/0MvBJwwPsrpGc4fu/diLS01SijVrVGzXHPoap2qDqClLjPKFAOzo5+LszuRM0OKuDbfG6jH553riroHYepJm2ED7kYJBQcfVHdg23rMUKbSH5686k0uwBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450495; c=relaxed/simple;
	bh=4qRz/QG9QpmT914D9ePj/lTEpLRxLcOn7JpymBEX5O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gu4Ms7VhWUDoa2FMitQ9KIenBwY6NRc2p9b9x0lZ/dgLpgEwRW7XYtcwfxMvRRO046zAQtsQFkHkNXe6TrN3haiKnbxKWAIebFzA3RiChK3gz7K1nf3VThgmyihzwiiA03dl/mxhCeqd4fEO3gFmikaIJKxI2CERHWHaejdNc14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MYR/rB3z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3394bec856fso3896298f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 09:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708450492; x=1709055292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qRz/QG9QpmT914D9ePj/lTEpLRxLcOn7JpymBEX5O4=;
        b=MYR/rB3zIWmWNUVn+HnbWt601kJnV9uV3PELRFfXKXLQuF/jetZkAQDeceV88kwzXF
         6AqJooP9/Xis1aIx6uyQVwCXknnIAvHaYjmMU7H4zWQ8AZ12o+v/1ijrXQK9tPF0CyX/
         I4vsAAsSzWy+PVq0ZCr888IG46H7BDvZyCcH0mtqbnW3sxCTVkQaAr8IZS4PWthkQqjM
         gBXxI0bQkcNQlvupBeOMYRlCG1PMkPRSPQ8eYhROi3fP/LNyupIx2dUUnm/Wyd/TSdUI
         8A3S6ezjYoTj/HEMbG5k/OlB3r85TMlYtMG/fHoqvZhsJFglzENgZEzpDs98+iUHcUPw
         oGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450492; x=1709055292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qRz/QG9QpmT914D9ePj/lTEpLRxLcOn7JpymBEX5O4=;
        b=FN31ku/2ko2tw/qzdhwH7nVDAPrdE9yH5aEs/ARTXv5MJG12W3KkEqKJNLP1Aevovu
         qGZv8bru9itCkOrgFcpt93fNxv3LydTRVHryyRSPuprLLWnCNws73VRZkN0sx6sKQd8S
         FtycbnfGiwOCsPbClI2+iqkhGrPoB/j4LbJGbYKoQBnxqsUKNQk8ynHA+N4a6xz15hRg
         L7kpqLEf2tykNsU/b7RcB7kvgFRwoZOxdwqT8inHq0VUFAlTZPtRjbF0gMf8WFkyfC0x
         41cvCzVb+9aU2d/SHy718zm6TxzFUc/FhUbbhEf50bCfd+CCE/rUdJ+Ad6/5RlZNrXKY
         RRDQ==
X-Gm-Message-State: AOJu0YxbI4zts4ZObJwWPrQTRQPw5cg/QwyVYJISk8SLt8lclAFYMtrs
	yZh/RZAbpMkQhrggdFxlKLDlx5ue4I21yEQ/+7GwgKrY+4frFTwRulFA9ok6l6LRtxzhSSsoYu+
	+f0gHATKRNqqr2Cqk1FpwBALOEI0=
X-Google-Smtp-Source: AGHT+IEb4ee78N9y8IW5u6T2BYJlHOAXCg2qoiQnA+YgARwpipQ7+vPm2BffF7fU+PbBf1Khk3k+kGqlibU5EKQAnO8=
X-Received: by 2002:a5d:570b:0:b0:33d:47c6:24fe with SMTP id
 a11-20020a5d570b000000b0033d47c624femr5317130wrv.12.1708450492498; Tue, 20
 Feb 2024 09:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104142226.87869-1-hffilwlqm@gmail.com> <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <7af3f9c6-d25a-4ca5-9e15-c1699adcf7ab@gmail.com> <CAADnVQLOswL3BY1s0B28wRZH1PU675S6_2=XknjZKNgyJ=yDxw@mail.gmail.com>
 <81607ab3-a7f5-4ad1-98c2-771c73bfb55c@gmail.com> <CAADnVQJVC21dh9igQ7w=iMamx-M=U2H+Vt7fJE-9tB4qR4tHsQ@mail.gmail.com>
 <98557e73-1fdf-453d-b5d0-7d0e2b471a8b@gmail.com> <d298b319-d8a0-4a34-a865-d2f1b7b28305@gmail.com>
In-Reply-To: <d298b319-d8a0-4a34-a865-d2f1b7b28305@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 20 Feb 2024 09:34:41 -0800
Message-ID: <CAADnVQLrbAhf_Mwhtckv7o5pAcXbz2etX69m8nVGRsR1v=4cuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 9:14=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wr=
ote:
>
>
> May I add "Suggested-by: Alexei Starovoitov <ast@kernel.org>" at PATCH
> v2? Because the key idea, percpu tail_call_cnt, is suggested by you.

No need for such attribution.

