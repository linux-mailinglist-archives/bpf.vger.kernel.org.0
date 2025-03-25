Return-Path: <bpf+bounces-54687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B421FA704A0
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 16:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEB793AD941
	for <lists+bpf@lfdr.de>; Tue, 25 Mar 2025 15:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB0525BACB;
	Tue, 25 Mar 2025 15:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hr9QCkwX"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493325B671
	for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 15:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915369; cv=none; b=KuHng0D0fHnU1XPUVxDyVlFILd38rWGuiYf7bzfU7gWoMPwwxabOiZxfSdTEV5WM6RZ2pdDsa/OE0zn5XZtQWf0Hf86/Dbzj1dqSEOLq5t9muqVnyUrMun7giX4xjvmh1UBbcqZZUYnYHKf6vu7va0zsbTDv17cfEFJL134nOk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915369; c=relaxed/simple;
	bh=XN1UHaGDDAyR/HBjdq/nPcvza0hCo9xY6Kb/vT4i1gA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aRELu2UAwNkNNyiAxMtBj6GEhsaFHoBgeFtQTVKVn0S4X67QBBm/DH87+Oh7izP4zlVxPAFl+Nky4fR9CkuMWNluLu+fvUabAIg5V0noEIbCtrfdC5mZOZtXLg3aO2oQ5PQBzDvskF0yH6jmanlny0jIz2tIG/jhjqRHG2U+NLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hr9QCkwX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742915366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XN1UHaGDDAyR/HBjdq/nPcvza0hCo9xY6Kb/vT4i1gA=;
	b=hr9QCkwXFvZXyleUQseEPd9hvN4yXTq/Ns+TKOXeRvs6corY3aV0nnkYsCEGeG7c7rSOAw
	tBFrnFocLfBH5JCGm3cQ98UCQ4tc0UXfvuz8Mz1l8Jt3qF9QiVY4SPjLz0XcoLj6EXI6YH
	Rcn2FC5+nHYbJ2jTJmWDkIAffr4LDDQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-0YspsYa8NkWCbWezRINCPA-1; Tue, 25 Mar 2025 11:09:20 -0400
X-MC-Unique: 0YspsYa8NkWCbWezRINCPA-1
X-Mimecast-MFC-AGG-ID: 0YspsYa8NkWCbWezRINCPA_1742915360
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac3c219371bso494075266b.0
        for <bpf@vger.kernel.org>; Tue, 25 Mar 2025 08:09:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742915359; x=1743520159;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XN1UHaGDDAyR/HBjdq/nPcvza0hCo9xY6Kb/vT4i1gA=;
        b=dUqJfQWWGEAhaKdn/NMry/99fwe4iBYFLZ1nhClpcUm8IEOywoqD+WAY0xKXHrGGgJ
         Un7CpLWcIp6XGbhYO8HKZ3U2mL6ZUUfu5jMmCJ1LzExe795BMWmDfBG7hVkRoisPtp0n
         tjrCkZzAvpu/Uhhqj9DaGZUlPW3cJRl8Wct/PYSNaarKCi3zU2J2ohGSlzUQs36e+9od
         AkRPz/vq6LHnFlzgP57NASsZYJkD9oZ1YxjoCpg5omm+y9/H6jAQK8DvinKfKB+T0kGk
         SpqMEQxorfnLzivBNHO4athEJPKyxyJTc6ig8ssqYbHCHMDkJw4R3Qch7+nRyTGCfGsx
         lf1w==
X-Forwarded-Encrypted: i=1; AJvYcCXteNwiEB4Y+R/ZsLoDlUs7VlXtZtcT7/gu8bteGx0eYbafycCSDiUxHyzrzU1QBvOj/y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXnG20RuOPXKmGwMxiJWf7o/8dMbsoCb5HUlcSh/EeIoigNXsR
	doo+PH7dl0Ox/q17o0EhFG+z/+DGst64NEUs79Uks+DNDer2Qp+AbVtdqdIvnMkdHsH9p8cwmLZ
	kKABx8gwrCgYx6VsAFpn1463OzXy1nolyMhDAku1fbNf5ZLLS9BCKM8LBnc8Fg9OCq5LEId7a2K
	MN1rCYIAxfKOCbYjqFQ8QQI3QO
X-Gm-Gg: ASbGncvviUBiqVXNyxZVsOQIVrhuRpCa5d+KOkcBuiazT9lvV678rDHUJ90fwaUC1jB
	k1NHmlwECrT3ialgfbKcb+ZG90r0Z7Te6Mu6aw3ycuj6ypSDooLK4ABO5W1KMe8/zsJLPN4H2aQ
	==
X-Received: by 2002:a17:907:d58c:b0:ac3:c05d:3083 with SMTP id a640c23a62f3a-ac3f24d6f4cmr1790851666b.35.1742915359490;
        Tue, 25 Mar 2025 08:09:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExOgId1LbZrltLHsKUY+negeAOdt/Yk2MPT6GyUunWZ6asILy7XQaITr0IFU8wCmrZepcUKYZwGDue8tgRpLI=
X-Received: by 2002:a17:907:d58c:b0:ac3:c05d:3083 with SMTP id
 a640c23a62f3a-ac3f24d6f4cmr1790848166b.35.1742915359148; Tue, 25 Mar 2025
 08:09:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5df6968a-2e5f-468e-b457-fc201535dd4c@linux.ibm.com>
 <8b0b2a41-203d-41f8-888d-2273afb877d0@qmon.net> <Z+KXN0KjyHlQPLUj@linux.ibm.com>
 <15370998-6a91-464d-b680-931074889bc1@kernel.org> <CAP4=nvQ23pcQQ+bf6ddVWXd4zAXfUTqQxDrimqhsrB-sBXL_ew@mail.gmail.com>
In-Reply-To: <CAP4=nvQ23pcQQ+bf6ddVWXd4zAXfUTqQxDrimqhsrB-sBXL_ew@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 25 Mar 2025 16:09:06 +0100
X-Gm-Features: AQ5f1Jrov1J0eHJ3t_FcdYu58nUqygB6AReV9HABcjx4wZEyM_z1SfPdGpJnZKI
Message-ID: <CAP4=nvTUWvnZvcBhn0dcUQueZNuOFY1XqTeU5N3FEjNmj4yHDA@mail.gmail.com>
Subject: Re: [linux-next-20250324]/tool/bpf/bpftool fails to complie on linux-next-20250324
To: Quentin Monnet <qmo@kernel.org>
Cc: Saket Kumar Bhaskar <skb99@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, 
	Hari Bathini <hbathini@linux.ibm.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	jkacur@redhat.com, lgoncalv@redhat.com, gmonaco@redhat.com, 
	williams@redhat.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 25. 3. 2025 v 15:59 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
> Shouldn't the selftests always test the in-tree bpftool instead of the
> system one? Let's say there is a stray BPFTOOL environmental variable.
> In that case, the tests will give incorrect, possibly false negative
> results, if the user is expecting selftests to test what is in the
> kernel tree. If it is intended to also be able to test with another
> version of bpftool, we can work around the problem by removing the
> BPFTOOL definition from tools/scripts/Makefile.include and exporting
> it from the rtla Makefiles instead, to make sure the feature tests see
> it. The problem with that is, obviously, that future users of the
> bpftool feature check would have to do the same, or they would always
> fail, unless the user sets BPFTOOL as an environment variable
> themselves.

Or the selftests and other users could use another variable, like
BPFTOOL_TEST or BPFTOOL_INTERNAL. Not sure what you BPF folks think
about that. I believe assuming BPFTOOL refers to the system bpftool
(just like it does for all the other tools) is quite reasonable.

Tomas


