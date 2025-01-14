Return-Path: <bpf+bounces-48798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16344A10DA5
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 18:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD1F93A222B
	for <lists+bpf@lfdr.de>; Tue, 14 Jan 2025 17:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C978E1FA141;
	Tue, 14 Jan 2025 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHHSpnah"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F9E15623A
	for <bpf@vger.kernel.org>; Tue, 14 Jan 2025 17:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875565; cv=none; b=j+L02alrr66GwK3EZr+Q7vTxUUBTub4m3IjyZKvJwh72ksXuYIHFPsWgtFQnscKE59crDhSlY4g+6pTbhuw6a9c3nkQQ6ss/9ZN5PG9K+bNetgpogB+23XnOfM5Qt1bnZ2gGMaqP1CKQMQNHKQHiAU65mbHGkCoywqz11mQtr60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875565; c=relaxed/simple;
	bh=SLnl86VoFy0CWx+1FAV3kgwVhMS3kbj5VROEq+77B8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/3tJxoBecNyXYBl9z7xmBgA9GQV6RynFhFY/TVV+t4xxE6kUDns5Vi1vPYQm/y91SIzStXStMdjmX6hAolmMXrC2YtlGnh4PgkFNKYqZ9+mcBzczG88aN5bkkjE7eRidOfBb69LNK17ziuhrS+F4QSLNzUsxkhIipxw+Mdwbu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHHSpnah; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736875562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SLnl86VoFy0CWx+1FAV3kgwVhMS3kbj5VROEq+77B8M=;
	b=GHHSpnahDOIgkKADse95xloU2JwjYk/HcbGfBM5YJusWSwDX6Yj7X6+a5zPEuTvP5yFXOA
	MMzz4Hrj56rcNJReG3HRmq082a55o9EDDAL0MAqZAATaI62wxCGlDB6G+I49JqsDxS3aXM
	QFYgCs0LAH+hgJvs28eNMds3QT4jtZw=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471-p1y7tBo5NA216Gitr3y_2A-1; Tue,
 14 Jan 2025 12:25:57 -0500
X-MC-Unique: p1y7tBo5NA216Gitr3y_2A-1
X-Mimecast-MFC-AGG-ID: p1y7tBo5NA216Gitr3y_2A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EC96719560BA;
	Tue, 14 Jan 2025 17:25:53 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.88])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 571B7195608E;
	Tue, 14 Jan 2025 17:25:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 14 Jan 2025 18:25:28 +0100 (CET)
Date: Tue, 14 Jan 2025 18:25:20 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Eyal Birger <eyal.birger@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>,
	mhiramat@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	BPF-dev-list <bpf@vger.kernel.org>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>, peterz@infradead.org,
	tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
	linux-api@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, rafi@rbk.io,
	Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: Crash when attaching uretprobes to processes running in Docker
Message-ID: <20250114172519.GB29305@redhat.com>
References: <CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com>
 <20250110.152323-sassy.torch.lavish.rent-vKX3ul5B3qyi@cyphar.com>
 <Z4K7D10rjuVeRCKq@krava>
 <Z4YszJfOvFEAaKjF@krava>
 <CAHsH6Gst+UGCtiCaNq2ikaknZGghpTq2SFZX7S0A8=uDsXt=Zw@mail.gmail.com>
 <20250114143313.GA29305@redhat.com>
 <Z4Z7OkrtXBauaLcm@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4Z7OkrtXBauaLcm@krava>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On 01/14, Jiri Olsa wrote:
>
> ugh.. could we just 'disable' uretprobe trampoline when seccomp gets enabled?
> overwrite first byte with int3.. and similarly check on seccomp when installing
> uretprobe and switch to int3

Sorry, I don't understand... What exactly we can do? Aside from checking
IS_ENABLED(CONFIG_SECCOMP) in arch_uprobe_trampoline() ?

Oleg.


