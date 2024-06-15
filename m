Return-Path: <bpf+bounces-32234-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFCB390998D
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 20:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896B01F214FE
	for <lists+bpf@lfdr.de>; Sat, 15 Jun 2024 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98BA5427E;
	Sat, 15 Jun 2024 18:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZifoUHgn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C4C26ACD;
	Sat, 15 Jun 2024 18:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718475680; cv=none; b=YDrRPNaIENauplJ9h/jmZRZjIxHLM9VHRlBSF2Q6wL5OzD4PuVccOwlQr6ofbPRr5++DAAP+VUsM10CQo5xTohYVhsaxM11R8BPOyngLVmzi4iHr38yVqh0NIDqppWAvWU1axCnxWcCCfR7jPXViRsYaY4KNIdnuqHpr3itov4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718475680; c=relaxed/simple;
	bh=HKWuDfKil28zRuVMFVAefYdXoOj25os20co3lhFIjbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gdi2Oqa+kVO/QeA94bYnu6/SvH452l/wuwkBZDYgvP4qu1ZUzbCfbIryK8reEcEXyuPk18RVmu5NzLaUiR8mCv6TbyNB+L70I052OZl6PQO6URoibZvTu89r478Ee1lFHQ9zDY4ecfVuiNg2ZoptAYv3wUprD62KkLxP4AAHXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZifoUHgn; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-35f1e35156cso2858452f8f.1;
        Sat, 15 Jun 2024 11:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718475677; x=1719080477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HKWuDfKil28zRuVMFVAefYdXoOj25os20co3lhFIjbA=;
        b=ZifoUHgnPd0gwhU16Wb+DDQos6SfJDWQh/SzSvRPz/oXFLDPt+IXnhmX5H2vWOgjf9
         mK1vEw8sUUU6kPDX6BGq030tTEMrQ6FeyahFRKUh6oc8J5Wk/kUNAlPGV585vEc/muaG
         nVR9W7Rho7D4Kb7AIxefL7AORI8EqpjeN1Sdfi0Osi51atS5gETabh6hLLuMxbR9WVHs
         ZLnykedaDzY8LiiGSiVuUsNG1u8x6hm8JLuIAyT9+XiSLm4Hbw38BbHT8dyDvWkbNVW6
         Vb588/CxRqOLcIp8SDY4lFqIZfUY8ANtiY4mxk9m384g1RES/vUY9MltMU6/5O2mbX7d
         RbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718475677; x=1719080477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HKWuDfKil28zRuVMFVAefYdXoOj25os20co3lhFIjbA=;
        b=jY98cvK2lblerdPorSIPCBJsJmKIk7x8fjvwuqFsnv+s7KuAkMjgxKu+GZnzvdjDGO
         1NjV3EHPqajg/urFIvr30C/R/VWutSDHMnHmv0pID4cv1Isoi+NlBjswrCg+IVahVbZG
         c1BRMZzKbHsoRiO0MBJcXubuvSF4Tj2GTgUDQa42uEJbnrtORqzTSM3G92Rb/U3MrbOO
         kOJ4p8eZqOTPUBrIFrUA/e5u8s40ux5dy5bW+jbhboVYTA9OJhBwnBmVwsz0y3f2L6/b
         H7eBRgjj1OyBo2kZkyba1F39k8vWuyV5hC5xYhbJhpAszgmMAo6H1ZPYs6xJRpb9KNIj
         qxzA==
X-Forwarded-Encrypted: i=1; AJvYcCVaHYLoR27AB77Ac5cf1ySCPdahajrLrQfNZyLPaM5GkQYTE9F2BEeTRHB4K12K8Zu9C2D9ugKPt7yJP9r5RTLRrxSOikorm28LPIJ15OIzNeGksHooJ0KlhN5onPc5IF9I
X-Gm-Message-State: AOJu0YwxwSmioR4T3AWtHRhYk6O2GUtaaYJTfkA68bBGy9ttSKQf5K8x
	oXpxpuX5ohPpn41A9YAGP5tavTbPYTDJ9lB9+9WA/rvL+wGotuOYDj436mP70LNMR8etHkFzpwM
	ZdFS6PRdGi2VssKmCBuJYyyZ/HTI=
X-Google-Smtp-Source: AGHT+IGDxTtwvZgv3TLBgzcprVxFpiBVz03jsMf+kjeibE6FlpeOlQrysgE1gBLzNcHRZNGYauuMYUz2Ra1agTa/k0I=
X-Received: by 2002:adf:e84b:0:b0:35f:1ed8:37ee with SMTP id
 ffacd0b85a97d-3607a7b0fd6mr4034396f8f.9.1718475677022; Sat, 15 Jun 2024
 11:21:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zmuw29IhgyPNKnIM@xpf.sh.intel.com>
In-Reply-To: <Zmuw29IhgyPNKnIM@xpf.sh.intel.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 15 Jun 2024 11:21:05 -0700
Message-ID: <CAADnVQLf1P=qfA7CBxwB_0ecm9edBg=QrN1PS2QnfP7xJhDWNQ@mail.gmail.com>
Subject: Re: [Syzkaller & bisect] There is KASAN: slab-use-after-free Read in
 arena_vm_close in v6.10-rc3 kernel
To: Pengfei Xu <pengfei.xu@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Barret Rhoden <brho@google.com>, 
	kbuild test robot <lkp@intel.com>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 7:54=E2=80=AFPM Pengfei Xu <pengfei.xu@intel.com> w=
rote:
>
> Hi Alexei Starovoitov and bpf expert,
>
> Greeting!
>
> There is KASAN: slab-use-after-free Read in arena_vm_close in v6.10-rc3 k=
ernel.

Thanks for the report.
Please test the fix:
https://lore.kernel.org/bpf/20240615181935.76049-1-alexei.starovoitov@gmail=
.com/

