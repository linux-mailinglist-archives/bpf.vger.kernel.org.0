Return-Path: <bpf+bounces-54255-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B21BA665C9
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 02:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3F223A37A2
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9C014EC60;
	Tue, 18 Mar 2025 01:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VI+q1jtz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7AC13D62B
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742262895; cv=none; b=A8aW6jiSngLytk8ggLqGBa6ISs7enTCBtObt6A2+xVKuj5a0kYfLzN1NfxqVikXBYECNQzW1druicAeX32J1Nvh3NJCSSqNrY0Z0PBq5Egl7i+IiVDSCpV74i5HE9xZF+JwM2hXF4jGCDSbPQQur+MBTpTG6Nb/In8efMqGiqIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742262895; c=relaxed/simple;
	bh=HHDsJ7rpH2zxQeiFQn8AZmUWf+UTn4BJBbezG7K+Mbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UMOcwQoiXGxpC+FIf9YK+SFVCUW2HNVY1n+cYiBKhWi0v/1V11ea4ZBCMRpR6IK5uoCbuqbr3zxPY/4aTyxYU1DZmDyZ5ywCIgBZIAgU/zEcF8Z+NWNG9i9ISaVmo4k/bor2cMp20e1T7JtxpZ0fWOiEd/oP7PJ0r9Tg5GCGBjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VI+q1jtz; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so4027a12.0
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742262892; x=1742867692; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HHDsJ7rpH2zxQeiFQn8AZmUWf+UTn4BJBbezG7K+Mbg=;
        b=VI+q1jtzhvKmoyh7hBXwUEeTaydPuQj5XzasNDhXFPhVjFIn/r81sgewbsN1oZDgfX
         BPey053m0oKWodnCcetlG516U52Nf9YqjaN368PSM2BbvfhKOjs8SvgrbOH7ACxjr96g
         qLAoyhw85BMCie/9InpP/2krrRHEs/atjVX1hC+sgLzusMv9+wliUYM9iJuwN2f9jyWd
         IMhOF9b7CRyA48gTh6Hj0ZyukezuuYaonARc4kMiSHtZvt8iRnNHfzmhnRFLK81Yf7Uu
         NESV/0v2hGczctOpqODSGF9HtPbLbBA//0VjLEmY19sJuzdCHXvQyTlE7sj0PhguYd5F
         NgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742262892; x=1742867692;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHDsJ7rpH2zxQeiFQn8AZmUWf+UTn4BJBbezG7K+Mbg=;
        b=Dz3WpxSG6UK9NSgoUrQnavosUW+/PezQtVvXKI+Giqmzq/50tosp/87QHIo4N733Hn
         yVjqKOTB63YMIVUhHZ08UooQV165NK9Flv2tw52AAmB/0dpFSMLKEZhrbe9468vSVV5Z
         NzpULVX8hTHJnNH0YYRCyoALCoKc//sUhNsGHmFEkypLeRkp4Iqa8UJXGBS2K/0H2OQa
         vMBTlUliK1hQ5espj1XUPGFFBFyXQPfa1Rqdo44/w5YHCwhLHjMmYiPtrLq4Cp+LOaIP
         VPSem2I8D349cZcDmQNHK05CSVLfQ5A5++84/es2Wk4+ER2wdCaojZoyR5mB4ugvw/9k
         qfZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVKYmtWxNC+oB/jd4LQ11kR+55m8dQOR6yk4TmrrOjyPcuSms3h0nu4bJLEGN1VL6KrAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEqOE6mR2Woon1i59xZ4IVcvoOr9C9xOC71Am+V74xWV/mvVQw
	nhnRMA+W2X5cH2nG8nbrI66IC5eyPWHhdVkeZGsghUtMZkoGrUwewz7dWtTHLoFKuq9hEx92Qkw
	UJTNzjjjBoC9xiSyc1ihBH5dqMOSfr69ym1CQPKG6gXwXgWNUUpqt
X-Gm-Gg: ASbGncvpXo0+wFU712pkbwIoSv8eatnyrN7SYDg8dtpgnUP7Vgi7nIlbN/6GaQFGMHY
	HLbVbZcH7eEks6CuyXi5J05xpeqhA9g+kt5C55GBPN64uNbU068qqfIaKkNFKXdynAHiVRk5U+y
	D6VFhQQs/f/edDK06jvCIP2k5BdIwiXspd+RMBH4ZAk2/nrAYg3JGvatPY4hI=
X-Google-Smtp-Source: AGHT+IHuugh5dIyFjTjpZ1QrK19v1S72Gk6SUbtmNwSwV8IeEV0H5viiTr47wENUDKVL66goMUI5eVuX6pKUk8AFR9w=
X-Received: by 2002:a50:ab14:0:b0:5e5:ba42:80a9 with SMTP id
 4fb4d7f45d1cf-5eb3c17c749mr8928a12.1.1742262891986; Mon, 17 Mar 2025 18:54:51
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313233615.2329869-1-jrife@google.com> <20250313233615.2329869-2-jrife@google.com>
 <67d860665588c_32b524294cf@willemb.c.googlers.com.notmuch>
In-Reply-To: <67d860665588c_32b524294cf@willemb.c.googlers.com.notmuch>
From: Jordan Rife <jrife@google.com>
Date: Mon, 17 Mar 2025 18:54:40 -0700
X-Gm-Features: AQ5f1Jo3kmEJCxxxNAevGijG8_5YJ0Zw_XIXYlp5TsoBEKE2NP_Ah8F2Hl82ulc
Message-ID: <CADKFtnThR8gTbn7023cRihQz5D=G=z7AqbB-ZnJ4pkvE6PAtUw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 1/3] bpf: udp: Avoid socket skips during iteration
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Aditi Ghag <aditi.ghag@isovalent.com>
Content-Type: text/plain; charset="UTF-8"

Hi Willem,

> Can this BPF feature be fixed without adding extra complexity and cost
> to the normal protocol paths?

Martin had discussed some alternatives in the cover letter thread, so
I'll see where that discussion leads.

-Jordan

