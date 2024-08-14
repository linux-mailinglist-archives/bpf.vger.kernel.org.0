Return-Path: <bpf+bounces-37174-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E25EF951AC6
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 14:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 512DDB22F1A
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 12:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BAF1B0118;
	Wed, 14 Aug 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmfav6lY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCAD1A00F3
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 12:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723638338; cv=none; b=TIKi/oyEWIdhPu2kvLSzmxm8ddURUjRMaCSebtHHfL5g1V04g2w8dx6C+641VAZ0W++JHY/f7EYMtfMXQsDGrvzkqBcGYpr4QRN8NGylo5oBVtgrB7YDeN+WgJdp6qpe9ov/p+HJkk/QxqMBd4FDXECB1GM4WkM1dLQFbpTnGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723638338; c=relaxed/simple;
	bh=fX0oLWQmmDLVQc37rhgERLHDmug4NM7ThPA89I0mRAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RdZ+WFeyMFMWnGzUr/GG4LTHz1S38BHNq80hWmX3np91GdyMIVoQghwV2bCTlTuik5uoL7heADEKHJ4Ex9+i3ZlnDOdSYGrSjtP9U+eOi7KA9SUv6JsdWEpa9yMCnvyk2lf7JEwvUcsO+m8yk8TlvB7yHlmMDHH+E/te3jdI5HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hmfav6lY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723638335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svBUuEs8/JFesMl5FGn0p7w8fnS4q4NfMpbFkx3+AVA=;
	b=hmfav6lY/v7h+ZJf7oyERCMbCbZ9Ra8hj/xmuasgVU9MfYiz+p0XEE9Mi9kwYPDc63sisj
	2EXjFnaP1K8ztdC1Zu8fZZMxUaymdigsmaT3fUoTemAaCqc0872LB/xNUo91QxPYGF6/Y+
	gxwOp26ufhd6UIbqjVOB9W5+PlruKqo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-GFhNPb5-Pr2UdJg0tYyZRw-1; Wed,
 14 Aug 2024 08:25:33 -0400
X-MC-Unique: GFhNPb5-Pr2UdJg0tYyZRw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BD18C197702C;
	Wed, 14 Aug 2024 12:25:28 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 38E991955F66;
	Wed, 14 Aug 2024 12:25:17 +0000 (UTC)
Date: Wed, 14 Aug 2024 14:25:13 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Mykola Lysenko <mykolal@fb.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Artem Savkov <asavkov@redhat.com>
Subject: Re: [PATCH v2] selftests: fix relative rpath usage
Message-ID: <20240814122513.GA18728@asgard.redhat.com>
References: <20240812165650.GA5102@asgard.redhat.com>
 <3667e585-ecaa-4664-9e6e-75dc9de928e8@linuxfoundation.org>
 <20240813163348.GA30739@asgard.redhat.com>
 <c946c5c4-366a-4772-81d9-dc5984777cfd@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c946c5c4-366a-4772-81d9-dc5984777cfd@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Wed, Aug 14, 2024 at 05:14:08AM -0600, Shuah Khan wrote:
> On 8/13/24 10:33, Eugene Syromiatnikov wrote:
> >On Mon, Aug 12, 2024 at 05:03:45PM -0600, Shuah Khan wrote:
> >>On 8/12/24 10:56, Eugene Syromiatnikov wrote:
> >>>The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
> >>>relative to current working directory and not the executable directory,
> >>>which will lead in incorrect resolution when the test executables are run
> >>>from elsewhere.  Changing it to $ORIGIN makes it resolve relative
> >>>to the directory in which the executables reside, which is supposedly
> >>>the desired behaviour.  This patch also moves these CFLAGS to lib.mk,
> >>>so the RPATH is provided for all selftest binaries, which is arguably
> >>>a useful default.
> >>
> >>Can you elaborate on the erros you would see if this isn't fixed? I understand
> >>that check-rpaths tool - howebver I would like to know how it manifests and
> >
> >One would be unable to execute the test binaries that require additional
> >locally built dynamic libraries outside the directories in which they reside:
> >
> >     [build@builder selftests]$ alsa/mixer-test
> >     alsa/mixer-test: error while loading shared libraries: libatest.so: cannot open shared object file: No such file or directory
> >
> >>how would you reproduce this problem while running selftests?
> >
> >This usually doesn't come up in a regular selftests usage so far, as they
> >are usually run via make, and make descends into specific test directories
> >to execute make the respective make targets there, triggering the execution
> >of the specific test bineries.
> >
> 
> Right. selftests are run usually via make and when they are installed run through
> a script which descends into specific test directories where the tests are installed.
> 
> Unless we see the problem using kselftest use-case, there is no reason the make changes.

The reason has been outlined in the commit message: relative paths in
RPATH/RUNPATH are incorrect and ought to be fixed.

> Sorry I am not going be taking these patches.

I see, by the same token, kernel maintainers reject any patches that fix
compilation/build warnings, I guess.

> thanks,
> -- Shuah


