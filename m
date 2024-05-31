Return-Path: <bpf+bounces-31011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA1D8D5FD9
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 12:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE5611F2465D
	for <lists+bpf@lfdr.de>; Fri, 31 May 2024 10:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18FB515624D;
	Fri, 31 May 2024 10:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4TxLzZQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6DA13D63E
	for <bpf@vger.kernel.org>; Fri, 31 May 2024 10:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717152169; cv=none; b=RqU7TqC18d9a1DgYprUPnifT/7xc3UdcGkp++B2JXSBjqkPSd7DwUfH81FsEKJMuPS69B6gTX+sbHYqQ4q/rOaUAzKJ3BG6TLW9xzN+k8BgM8zl6t4hZn/lEFY81+ek12Ol2o+aYTkFIeam2LohbS4xl/VBenCG5djq914fWYWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717152169; c=relaxed/simple;
	bh=S77JcoxOf+HuTFhqWQ5sp9fc9KLfUJT+c30D6Xs3Lbg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOLnhJkYmwQeWLRfQFzswdozSw6C3eF3YBFRWBoTUwrhD3Syp+1J5wn7L94mdD1oW9LkHpsjLNMi8b9/eCKBQnbvPDxsv+U+Vm9q0HtWxm/7JHD5z4awCyt+W4PPEtsXTZO5pfrZ+1EuBLVH1fPw4ceJS1XlFtcabfwRDAmZze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4TxLzZQ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6341cf2c99so197287166b.0
        for <bpf@vger.kernel.org>; Fri, 31 May 2024 03:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717152166; x=1717756966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cRKdLBqrm+ic90w2ID2UFM9ByMbMQI7PPG+asxOcmII=;
        b=B4TxLzZQ3YMVuDnLgvXBOdP/mF5Tb1SyS45XdY2ttXxF5Rcxmsipiz8y0aXNRBkeLf
         u7UwJkA4TbE+d5IhnSDeTU57ZbN6Lt03svkgJwk9oMN2OFhLF8Xht0OZnlQDuakpMaLt
         96qdrXTVnS5ecSXa+kG7NGjumk09V8N6xRoaDmTEhjcPR8Y0yK6d/rzCugIWmQHmYtFX
         2b1NsLV/c97q4/pz0caPi55IDi4LeeXb+1Jk7UHjdyWZWczzACgdZVd2MuPpSy3HCe1o
         JER7pZyVJE5EdCOsHn/biSPTb7cBf5a8qKQBwo9BJhtVrBnK9D8PQcLQxsofu+tJTCCI
         +i4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717152166; x=1717756966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cRKdLBqrm+ic90w2ID2UFM9ByMbMQI7PPG+asxOcmII=;
        b=LqfoyfWU0R7EPMRT6FKGGg0SZMztdVOIFRPpMAcN+ejKD7YJYFp+cMhP9FI0TxgP5p
         RSY3JCZ3UEZPfd3BTWOGrxDk55MBIE6nAGMZpZ8lpSLbuUN0p/bp/VvbbgphM6025+iU
         DsednZACpSxpQAz1Nz8eBhc6ssZgK+dKxizjhOiioxixLNPnNWo9AGD0XhNSIDp8GHlD
         IAQ7QnV8hqI8sV8XezOnXFhZmsmTPWtNzYV7P+JttY8zrc4wx3aYLSy8f3qPn1Kb9PCB
         JwjMrQ33st17xMSo0pBwQsh7PxXGamBpR79fKTwKC55iKZA1GcfSI5AtKDmeDxsQws0o
         OZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSyScTxbbR9vHfSMvsCN6wbZcfTBmOng0uPw+mOqQ2B7zCzDKSLajauk/fOMvikRF+j1oRAe4PRM71HrmKQGsPwYQn
X-Gm-Message-State: AOJu0YyK/EN/e5h1PZ6aEpfCiaDaFi/nCPQyQtRzjAoVSWAm1Eg8cwpc
	B0TXIpN4R5Rnd+odAOguOz3gl8og3mGYik86PoVo6XhZU2RKyUvA
X-Google-Smtp-Source: AGHT+IFAaAdoUbNaGOpHravxTNSRbN71uEyMtsee8c72hLZAw7sMIgeX3lJbcHnXvp1Y/u2y43ATRA==
X-Received: by 2002:a17:906:7c47:b0:a68:8c38:3f2 with SMTP id a640c23a62f3a-a688c380422mr51621666b.69.1717152166219;
        Fri, 31 May 2024 03:42:46 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67e73ee5a8sm72825166b.46.2024.05.31.03.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 03:42:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 31 May 2024 12:42:41 +0200
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf] bpf: Make session kfuncs global
Message-ID: <ZlmpoWed0NmeZblH@krava>
References: <20240531101550.2768801-1-jolsa@kernel.org>
 <20240531103931.p4f3YsBZ@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531103931.p4f3YsBZ@linutronix.de>

On Fri, May 31, 2024 at 12:39:31PM +0200, Sebastian Andrzej Siewior wrote:
> On 2024-05-31 12:15:50 [+0200], Jiri Olsa wrote:
> > The bpf_session_cookie is unavailable for !CONFIG_FPROBE as reported
> > by Sebastian [1].
> > 
> > Instead of adding more ifdefs, making the session kfuncs globally
> > available as suggested by Alexei. It's still allowed only for
> > session programs, but it won't fail the build.
> 
> but this relies on CONFIG_UPROBE_EVENTS=y
> What about CONFIG_UPROBE_EVENTS=n?

hum, I can't see that.. also I tested it with CONFIG_UPROBE_EVENTS=n,
the CONFIG_UPROBES ifdef is ended right above this code..

jirka

> 
> Sebastian

