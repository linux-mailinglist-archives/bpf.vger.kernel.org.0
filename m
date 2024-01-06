Return-Path: <bpf+bounces-19161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4953F825E1C
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 04:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA76D285315
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 03:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067B15C4;
	Sat,  6 Jan 2024 03:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vctkttwl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD72015AB
	for <bpf@vger.kernel.org>; Sat,  6 Jan 2024 03:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso1885885e9.3
        for <bpf@vger.kernel.org>; Fri, 05 Jan 2024 19:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704512100; x=1705116900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=te0CnrQLglvB8nG5/CVLEfs4bBdeDRGnPW/1CZ3GQh4=;
        b=VctkttwlRYIz7KrTacfGHPggdwFlwDIouE2R/+bZvibt2MqTJXpStjI12Qnz81XaNZ
         OQcJOFR16jSNehaoZWGa1rwWJL0cLmclcaMc3HRYo487xTa0lQoj0CLO7mrNxdKRcLFq
         o3ljOB6K08m0e3eT5i0YWfFG266FeHhpwSmXT3Df64ImDQmRMcD+IJwC0BLIxwsHLsKw
         joBNSVO+SsTzAhu/MTOyK4fhD9pWgMRddL7PLoN2hc7txdRPB2luuJ/2W6OHaTi1sR/l
         Ym6IKzgflQvitNFWCNsa1TY4c6oClSIpUPIq7sgWj/n+GsZVnoE+9IGHIVfNUB4vadud
         JB4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704512100; x=1705116900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=te0CnrQLglvB8nG5/CVLEfs4bBdeDRGnPW/1CZ3GQh4=;
        b=H41D4Qo1KKkjjc0o3TrhKXHZjzYIbZ16n2WsqOFys0Yswh5PTFCEvshxJYK2RiGHma
         bhJZEowUjUowwVcPcOfNtZJO6Q67esK20xNvIN/oTMk16l/ytdDIAOYRvkTIVtFZqNkn
         18+kKO58uNXQm4i1WmLygXBDAWTziGELIpnCqeWAgQzZbUyoag+WENgoQ6zzqHOTGNlV
         aB+Wo7UFNm6+QPHnS7KT/Q/zWq7Z3iAvKxc+IYTRjrJKKlWrqKJsid0Dpe9R9HTi6X9w
         r7QqYc+UUX9H2Mw9qtTiTK44i6ofG9Otcv9F92U/L6xoS11Zglk/ApfIYTLr4pNEH/pt
         ZG/w==
X-Gm-Message-State: AOJu0YzvP+IfS5i4QbfRTdu2dEUegZGQK6t5WO4veQNUSgq9S2TAmnAF
	IcFpPds0a41or3p8YPfqms3b9WeGJmd8ecg7Qnc=
X-Google-Smtp-Source: AGHT+IFoTjgx3j5Bo0h4oGeE5GUpHbtJB7WLmG270XgF21aVZLzRYmPC3DdkI55feuaLVTDGfp053pcNciDYjeeOlOQ=
X-Received: by 2002:a05:600c:3103:b0:40e:39bc:816d with SMTP id
 g3-20020a05600c310300b0040e39bc816dmr182778wmo.152.1704512099669; Fri, 05 Jan
 2024 19:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104142226.87869-1-hffilwlqm@gmail.com> <20240104142226.87869-3-hffilwlqm@gmail.com>
 <CAADnVQJ1szry9P00wweVDu4d0AQoM_49qT-_ueirvggAiCZrpw@mail.gmail.com>
 <b2f808ba-56c9-4104-939a-4eed36159bd4@gmail.com> <CAADnVQ+qh0KFJkmRo5NxhfHS2othCJU=q=jcPrr2pNUGSUvR6Q@mail.gmail.com>
 <955156f4-6b0c-48c5-9167-1cf466e8cd35@gmail.com>
In-Reply-To: <955156f4-6b0c-48c5-9167-1cf466e8cd35@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 5 Jan 2024 19:34:48 -0800
Message-ID: <CAADnVQLJn6pk0+L2tWxGwwuTBnej=oYsY9F7VW04AjnovTd2hw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf, x64: Fix tailcall hierarchy
To: Leon Hwang <hffilwlqm@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>, Jakub Sitnicki <jakub@cloudflare.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Hengqi Chen <hengqi.chen@gmail.com>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 6:33=E2=80=AFPM Leon Hwang <hffilwlqm@gmail.com> wro=
te:
>
>
> > We allow BPF_MAX_LOOPS =3D 8 * 1024 * 1024 in bpf_loop,
> > so many calls to subprog(skb); is not an issue
> > as long as they don't stall cpu and don't increase stack size.
>
> What if there are BPF_MAX_LOOPS subprog(skb) and there are BPF_MAX_LOOPS
> loops in the tail-callee bpf prog?

It's fine. Every bpf_loop is capped individually.
We're working on generic "cancelling" of bpf progs
when they consume too much cpu time.
There is no way to do run-time counters.

PS pls trim your replies.

