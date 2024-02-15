Return-Path: <bpf+bounces-22095-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FAD1856980
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 17:25:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B9B1C21867
	for <lists+bpf@lfdr.de>; Thu, 15 Feb 2024 16:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6545A13473A;
	Thu, 15 Feb 2024 16:25:51 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD1129A9D
	for <bpf@vger.kernel.org>; Thu, 15 Feb 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708014351; cv=none; b=quCWppXHncgvpIpnfGxU++/doT8I0VTfh37092XQM9jWBllF1+KJAE4u8srHVUyVR/YMzLP9CrgsJANbG8EkOKtLe5L0doBIykHYsVV5T0hP9GA7CuGssyJ/AIe1pbxJANnQ5gowqBGSHAQjKSS0tAYsaUAGeGuya40TVLL5n3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708014351; c=relaxed/simple;
	bh=BFQaw/4XIyBrKC2uUCTt8tZzMhNjsNgOGjnn8HpMqOY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5OvNmsrsNfOtpKQDm0pF1t+eddK8cEsZjFvLVSzqFLx7iuciceDsryDu0YqUNDzDogTc25bqYSnhrw6CdgiPBAWAlbNVTS4ova5EPwFawX8iD6QoKeY8icBZyzBLWjHJXx4rOpZI6Q1yunsfT39S49Q3EGah3skBAW52t9W4jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D26F2C433C7;
	Thu, 15 Feb 2024 16:25:48 +0000 (UTC)
Date: Thu, 15 Feb 2024 11:27:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, John
 Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH RFC bpf-next 0/4] bpf: Add support to attach return prog
 in kprobe multi
Message-ID: <20240215112722.2120471e@gandalf.local.home>
In-Reply-To: <Zc0op6a3ZrI7JD9z@krava>
References: <20240207153550.856536-1-jolsa@kernel.org>
	<CAEf4BzZdPJWUiu9yNMsecB-tq0tHCLhrSF47b=w23fPevg=EWg@mail.gmail.com>
	<ZceWuIgsmiLYyCxQ@krava>
	<CAEf4Bzb6sPXAtDVke=CtCXev0mxhfgEG_O-xUA-e9-8NnbBtJQ@mail.gmail.com>
	<ZctcEpz3fHK4RqUX@krava>
	<CAEf4BzY_UBNe4ONqKGg5VtA-nY-ozgpQ=Du1+8ipQNnZ+JKCew@mail.gmail.com>
	<ZcvadcwSA37sfDk4@krava>
	<Zc0op6a3ZrI7JD9z@krava>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 14 Feb 2024 21:55:03 +0100
Jiri Olsa <olsajiri@gmail.com> wrote:


> Masami,
> we recently discussed the possibility to store data between entry/return probe,
> IIUC your current patchset [0] allows that, but it seems to be shared across all
> the tracers for the given function (__ftrace_return_to_handler).. is the plan to
> make the shadow stack per tracer and function? /cc Steven

The shadow stack is per task, but it saves unique data per tracer per function.

It allows up to 16 different tracers attached to function graph tracing at
a time, as there is a limited shadow stack size, which all the attached
tracers use. Now you can create your own shadow stack per user (bpf
program?) and have a single registered function graph user that will demux
the data coming in and out of the function.

-- Steve



