Return-Path: <bpf+bounces-37059-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6146950A3D
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 18:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70352283587
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6981A2557;
	Tue, 13 Aug 2024 16:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jj60vpv6"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92071A08BB
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723566854; cv=none; b=LbG2Yj3NDHhyuqCbRh6uxJO8annd/nQhB5IGYIhLr2gi96wU8LC8S4nLk0mmBd7M4Aorsl6e3LU2EqkpfB+KxooNt9WVjZjZ1pHJsac9H9YnqejTQt/RhXlnfXykEFdfp/CQmXmwjlUdj+YnVYWXMjyXfqj29TmW8cPnU/lqBtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723566854; c=relaxed/simple;
	bh=s9FhjpgJBV7aZ0bh7A229jvkNpOcRXx9yhDFIcvqw0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKONWcb42xhLDOiWeAzQnjAfuaC3FoSLI35V3Wi9LarFEhq/+MPhn5uTHtr/NAJJMuEAgRtslXu+TWxj/CGCC+gthNPA9Qip5ds77gx+9i0MBoQj2NjQDx6Y6YPaSWt2X+fY9OL+1GVjAWSsPOfdj3QO84gG536PgJaP7d1ALeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jj60vpv6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723566851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nq8/RpUOFyMdFBwvGw/awyKLLWWIuDz647gTnyiHsrc=;
	b=Jj60vpv6QBFNEErqYdC9Obvgikb2AKtdv+NfLBKiCwdcewqYIqps4FIUANzYM7sv62WBym
	1Se52Elwuf0+SCsZ2+far6igBbNUlz1k+gVZgqeEKtgQqMZNEWhjWsUULgaPnHkGpys5gN
	AHPp8J3YjoHQapikwJ5KfySODTH72fc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-g2DMM72jOnSloMrjUOyFGg-1; Tue,
 13 Aug 2024 12:34:06 -0400
X-MC-Unique: g2DMM72jOnSloMrjUOyFGg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D605F18EA948;
	Tue, 13 Aug 2024 16:34:01 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.18])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8E0D419560AA;
	Tue, 13 Aug 2024 16:33:51 +0000 (UTC)
Date: Tue, 13 Aug 2024 18:33:48 +0200
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
Message-ID: <20240813163348.GA30739@asgard.redhat.com>
References: <20240812165650.GA5102@asgard.redhat.com>
 <3667e585-ecaa-4664-9e6e-75dc9de928e8@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3667e585-ecaa-4664-9e6e-75dc9de928e8@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Mon, Aug 12, 2024 at 05:03:45PM -0600, Shuah Khan wrote:
> On 8/12/24 10:56, Eugene Syromiatnikov wrote:
> >The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
> >relative to current working directory and not the executable directory,
> >which will lead in incorrect resolution when the test executables are run
> >from elsewhere.  Changing it to $ORIGIN makes it resolve relative
> >to the directory in which the executables reside, which is supposedly
> >the desired behaviour.  This patch also moves these CFLAGS to lib.mk,
> >so the RPATH is provided for all selftest binaries, which is arguably
> >a useful default.
> 
> Can you elaborate on the erros you would see if this isn't fixed? I understand
> that check-rpaths tool - howebver I would like to know how it manifests and

One would be unable to execute the test binaries that require additional
locally built dynamic libraries outside the directories in which they reside:

    [build@builder selftests]$ alsa/mixer-test
    alsa/mixer-test: error while loading shared libraries: libatest.so: cannot open shared object file: No such file or directory

> how would you reproduce this problem while running selftests?

This usually doesn't come up in a regular selftests usage so far, as they
are usually run via make, and make descends into specific test directories
to execute make the respective make targets there, triggering the execution
of the specific test bineries.


