Return-Path: <bpf+bounces-60668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C05DEAD9FC4
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 22:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439A917660B
	for <lists+bpf@lfdr.de>; Sat, 14 Jun 2025 20:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2F42E7F1E;
	Sat, 14 Jun 2025 20:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iz+CjjiL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543BA78F2B;
	Sat, 14 Jun 2025 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749933649; cv=none; b=ci5sNp1VU6ontIX2KHYJ5kaZuaqNRBuvf3av6dL8n4ogIJY2dVrQ/70l/IudPfVdcnFC9Ee3CRes+vRTPGa0+xoSnNyZh+BWZal9M+8f7Pgq1rZQ55ZkSVD9XIlGqCj2WunGEOQLdMF4f3MuiNDSmdB4/KnMyeYMXbK5fP8BC8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749933649; c=relaxed/simple;
	bh=Ax85jcqZ/jyVchftvff81IQk1pa6W4aIgegRl2Cn004=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nB1ecVKB6Yb13EzgFC8Bqza6g3POPMYyHbx8XoI9TYM+uO2DBiZ4Q48Kjis+svSD1uA9TjShxKx6moOahRN80T9LUA3Fqt5pphdC8inXvRfrT1tyYnGXOlDm9gMiN4kV3bTlwHDt8GA6xg4vSjv0fysDLzcPF8VZyUkHTzNnqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iz+CjjiL; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-748764d8540so2930322b3a.0;
        Sat, 14 Jun 2025 13:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749933647; x=1750538447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTlkYKHNNbkrNpkDfXuKI7LdPcN9fZ6NGt2sNIKi0Tk=;
        b=Iz+CjjiL9J/lfWNWOFO7tvSrzoqdByoueOoLoAA1U5c5J4QbzX4fzUXxnaA6dslxxS
         odCfMYD6lzBjQrnToCrFYtzDFeuTpAmoc2oJJNH/lPtogozpnoi6RTQ5pYP7tRpZe5Ab
         RkPXm1EV0u0GLyHIw+XguDHd26RtkWSDuCAcJ4lxOI9tTiNkkzO3jpxtxXUQCNJAjhZT
         zWQ7KGQDt3UpR0J9GpMaSn9GljYZOlaNq0cP0lUfUFFp+7Zlgl8HwP45D5wx1gI98Xuu
         avHl4vAqMuykFem3zhYTSr8ame66KaTUnof4/j/3tMCHL43Czy05Gvg7IQpmH6oF3DGO
         4VYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749933647; x=1750538447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTlkYKHNNbkrNpkDfXuKI7LdPcN9fZ6NGt2sNIKi0Tk=;
        b=Rm244H7EgEQty7kIyc/6x8M9lwu2YXqZCAGi8zIrOg0ClW1CRatOOBcEMRYxubzyqf
         mHJLnt+hcU9x+g15WRL7e8jZA38IREWYNlEmPzaTiF1rvGj31LPpP3bhEjeq7/jtfgIB
         NQOan1+YAvuOH4lTK0mU3RWqin0/n1E634cUKKOgQ+yVaA+l9yHLIiHAvNqQs1wlsBR3
         ea2qqcxXGVE99ilNMH/W8RUHGqnFaoHGq1rc7FJOXO2MUikgENH74d+Ct06GkndsTcmD
         tEKvNm3Vz5sF8ivivGjKRyHn+L8K/ykqBU+ewNZiN7luk/YWO0daUhNfPfi+ioC2U4U/
         UUfQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3j5S43VBiAKVp98XGIDYSSjtWTR5jp+KGk1xdlTH+1OJCoMPgjNIG3s+oEhD43g5uI9Qvi/z/sg==@vger.kernel.org, AJvYcCWXoHaCH9swxKcTM97IRPRhZbnpHH13CqwWHAJCm3PImBpka6GNDb9kd4Kx3KUXX2KjyF8wwn66@vger.kernel.org, AJvYcCWvJTnY/uc04FiziWdQjYqj4j85fAP1OhsLF4rtVVNsnIca66YPdE+CbprEOOSCL6I8DpSrzTW8Ib2YNdS7//srpOzVOcS6@vger.kernel.org, AJvYcCXVENSLB0iAQk/teQHuM2UxFTQNWAFR0bdbjiyok0H+rJg4+amiSXpYXiGoquxHuI9X0KY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLpUVlF1pcHtGnYD7YTR5B0J2OfbCfObWH8/E+x+INv63sBzGT
	e6ckmlP7qjmxW6Wc3v5muyB1RUPD6U05yQqdZLxPidoAFzoaai5CmFc=
X-Gm-Gg: ASbGncth94XsdDIhRXlOgtPnmNwMlfKTCZN0S8+QGgZu9oqr/ASPM8I+FzUaAeen8V+
	R5siB0ODk/VP2ZDPS40kLcgwcpAX2Lge1SOWL5zH5xVSjsy4IXhO3HKLg9dl129DOUmgq1Btstm
	7U5U0A+a2qyLk1PFeUnPp5sA5/fo0xRTZuPm2q4RRZQj4HvPqpUAFvCgqaIn+jrBsNF/fGXhqQn
	UJoMwQRmt/t2A+fkr7F+kTQGAMX5u45B3+Y8vUzCn4DSfkEFDBAhmG27xE/QrKUwECIFkA24VK0
	WOlgRuKl2YJ9iCuD16MiodSo/E3FqsIRlYg1Iy0=
X-Google-Smtp-Source: AGHT+IEEfYBkfMvnd2ejMHCgcqw1lGIeuzdai2oQkNeRPlhWZdHmPJQTYFVmN/54ormHyqsjTnDGoQ==
X-Received: by 2002:a05:6a00:2e11:b0:746:3040:4da2 with SMTP id d2e1a72fcca58-7489cf726c8mr6670373b3a.8.1749933647448;
        Sat, 14 Jun 2025 13:40:47 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083fafsm3744908b3a.76.2025.06.14.13.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 13:40:46 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: paul@paul-moore.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	casey@schaufler-ca.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	gnoack@google.com,
	haoluo@google.com,
	jmorris@namei.org,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	linux-security-module@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	mic@digikod.net,
	netdev@vger.kernel.org,
	omosnace@redhat.com,
	sdf@fomichev.me,
	selinux@vger.kernel.org,
	serge@hallyn.com,
	song@kernel.org,
	stephen.smalley.work@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 0/4] af_unix: Allow BPF LSM to filter SCM_RIGHTS at sendmsg().
Date: Sat, 14 Jun 2025 13:40:04 -0700
Message-ID: <20250614204044.2190213-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <1976e40bd50.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
References: <1976e40bd50.28a7.85c95baa4474aabc7814e68940a78392@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul Moore <paul@paul-moore.com>
Date: Sat, 14 Jun 2025 07:43:46 -0400
> On June 13, 2025 6:24:15 PM Kuniyuki Iwashima <kuni1840@gmail.com> wrote:
> > From: Kuniyuki Iwashima <kuniyu@google.com>
> >
> > Since commit 77cbe1a6d873 ("af_unix: Introduce SO_PASSRIGHTS."),
> > we can disable SCM_RIGHTS per socket, but it's not flexible.
> >
> > This series allows us to implement more fine-grained filtering for
> > SCM_RIGHTS with BPF LSM.
> 
> My ability to review this over the weekend is limited due to device and 
> network access, but I'll take a look next week.
> 
> That said, it would be good if you could clarify the "filtering" aspect of 
> your comments; it may be obvious when I'm able to look at the full patchset

I meant to mention that just below the quoted part :)

---8<---
Changes:
  v2: Remove SCM_RIGHTS fd scrubbing functionality
---8<---

> in context, but the commit descriptions worry me that perhaps you are still 
> intending on using the LSM framework to cut SCM_RIGHTS payloads from 
> individual messages?  Blocking messages at send time if they contain 
> SCM_RIGHTS is likely okay (pending proper implementation review), but 
> modifying packets in flight in the LSM framework is not.
> 
> Also, a quick administrative note, I see you have marked this as 
> "bpf-next", however given the diffstat of the proposed changes this 
> patchset should go to Linus via the LSM tree and not the BPF tree.

This was to kick the BPF CI for the selftest patch, and the __nullable
arg suffix in patch 3 is BPF specific stuff, but I don't have preference
here and whichever is fine to me.

