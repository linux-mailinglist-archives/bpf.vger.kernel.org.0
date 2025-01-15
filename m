Return-Path: <bpf+bounces-48887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B435A1163C
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 01:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B96CC7A0738
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 00:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421171F5E6;
	Wed, 15 Jan 2025 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcBd49YZ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BF235945
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 00:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736902258; cv=none; b=Y0/ARFU4T2WPdg7xVK7DFhAPUFQNHZY9ccjw6y5RUS3rcaX1+vu4Mrc4LrTTsZlffHNENi9keEQ0iBSJS0pd8i47f6noR2ZSoOoF4Lbu+SEAuTGbP2vCC8TZupCaHPPmGKDqEuxVT5njdhYXqIC4+Xul8ISG2YIFZcvipYTirBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736902258; c=relaxed/simple;
	bh=ExRFbCkC66JXTmR5t4uS0YuvlcT4DV8859zahWbmb3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lxz28B0jSNXGv7ygMMwLO3MrMrGUvdM8YO6sHXis3OXO4I0tQBC3MuEHld23cKbKetvSA9/LBIWzhqNoK5Q5c0OcRQvsc8nA8xnS6EMDApsa5S2Kzo+NHobNF91Cf2GrG/KhNVo8KFndoJzT9xLPREkIS5SHSP3B92e8Gtfyvdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gcBd49YZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736902256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ExRFbCkC66JXTmR5t4uS0YuvlcT4DV8859zahWbmb3Q=;
	b=gcBd49YZp9SQXmqVuVbKZsbKo5Pdm6vYnJITC26rNTlRzD+/o/Exav1f+PKdlk27mp1CIO
	ePYDA1n84zTjio/9UCsoSBvCeZ+v+8tF9v4CBuAdjUBf8vOAeuQMn3Yquge2raRMbkmf0I
	MePs6P6o+uZH+TFjA15S5Fusud9I+yU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-v-8OZov1Pka9KE66gwYUBg-1; Tue,
 14 Jan 2025 19:50:50 -0500
X-MC-Unique: v-8OZov1Pka9KE66gwYUBg-1
X-Mimecast-MFC-AGG-ID: v-8OZov1Pka9KE66gwYUBg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E664019560A1;
	Wed, 15 Jan 2025 00:50:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.12])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 5190E19560AA;
	Wed, 15 Jan 2025 00:50:39 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 15 Jan 2025 01:50:22 +0100 (CET)
Date: Wed, 15 Jan 2025 01:50:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>, Sarai Aleksa <cyphar@cyphar.com>,
	mhiramat@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
	rafi@rbk.io, Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250115005012.GA10946@redhat.com>
References: <CAEf4BzZquQBW1DuEmfhUTicoyHOeEpT6FG7VBR-kG35f7Rb5Zw@mail.gmail.com>
 <EBE7D529-5418-4BD6-B9B5-64BE0FBE8569@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <EBE7D529-5418-4BD6-B9B5-64BE0FBE8569@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

On 01/14, Eyal Birger wrote:
>
> Its software, that’s working fine in previous kernel versions and upon
> upgrade starts creating crashes in other processes.
>
> IMHO demanding that other software (e.g docker) be upgraded in order to
> run on a newer kernel is not what Linux formerly guaranteed.

Agreed.

Oleg.


