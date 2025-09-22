Return-Path: <bpf+bounces-69218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78800B9197B
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 16:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57581901534
	for <lists+bpf@lfdr.de>; Mon, 22 Sep 2025 14:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840B19AD8B;
	Mon, 22 Sep 2025 14:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZz4Dq1m"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984191917FB
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550128; cv=none; b=S0M9EB7QgjYgojLvM5w6lCqlK/sCb9aYu3TFJeutRJApo0cMljXgccBDDYkICIlGeK0XnPAhpMhD2Z4wM8OCBxUapWuaHhG5v9Po/tjKQqA3VcJYJBNEvYQcPNxyVpsBWWHBuFuXdnUzLUx3qmcrOschiOjxJYstDady4Ya/jMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550128; c=relaxed/simple;
	bh=AqRgb0E4nCCx5qJVUaSwW5UejA7JbTCsN0JmEmiQD+U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dKnru/ehPRobTjb5rEHTSiX2ewqpepTxjk+aczzv2zi6qvod4wozPuQ23mky60v+ZNiqX6nfb6buuVDrtUlGHUnAigsziRHdZdRaX07n/awaQ5k0MMEa8kR5KXAlu+ErqvZsMVwv/tQ3HeEd22nyiX6FoeYCKnSOTjevBI3COOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZz4Dq1m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710B2C116D0
	for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 14:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758550128;
	bh=AqRgb0E4nCCx5qJVUaSwW5UejA7JbTCsN0JmEmiQD+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iZz4Dq1mwjxOoVUfpXCjKJvwR9VlVBgylPQv6oF1Zrurwbf/nyxV88VdSnfcvyjDC
	 VJN8uo4cKx9cSAmPwIaTMMTHsX4z16I1v8qd3x1VlA0+Hn5mfcGljg4Tcor6PDZ1nR
	 YIHOi4S1+O7htWmC45J1S/bSFQ9bpaeOAvlvHezLP12TJIrw8Q54zOihP5zRVOaH1o
	 FmfKcQ85qd9lMuaFhFAmISVLptdp+QfAHooBgH1N8LdGQIBfG3T0MFGN+vgbo/aygC
	 sNK0qg3BMQ1el2PuGn/ElYwB7+RoOsphLt2BIdTuwybzmk5+9Eo1p41PUSZjhPceZb
	 6HzeynOs/SRnQ==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7f04816589bso472850385a.3
        for <bpf@vger.kernel.org>; Mon, 22 Sep 2025 07:08:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1KD1WldJt5jDTe8N2kNVvHlVInqf7Bc/HGWzeTHA1BaxqdhKwF590nfIVAAHueTmB2DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMT0DKJtq++ittA/fp/0t7WlGKpL6WgNxrrzLLGV1v3UFwblpO
	W//+AduUBWrXYeB1dbNh9LqxbjSeYMn+gTckD40LEkLikbQeG0lM7yjACvl1f9OpfLs8Z5tpQr2
	o7pSGWau/44371OGfdmDOIR2Q8k5we+M=
X-Google-Smtp-Source: AGHT+IHJF1EyOLoOCEQpplhCV6pTbZ2M9jVJo6pR/QQzXqL/xDsb7nBEy6skoN4kvZVtMKve+xqItYGbKHnz7fdN+Y8=
X-Received: by 2002:a05:620a:a48b:b0:825:a1ff:b19f with SMTP id
 af79cd13be357-83bad7d2bf8mr1397928085a.63.1758550127595; Mon, 22 Sep 2025
 07:08:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250922095705.252519-1-dongml2@chinatelecom.cn>
In-Reply-To: <20250922095705.252519-1-dongml2@chinatelecom.cn>
From: Song Liu <song@kernel.org>
Date: Mon, 22 Sep 2025 16:08:36 +0200
X-Gmail-Original-Message-ID: <CAPhsuW7THs9G+QV5_g+tMvXTAqVJ7jha-m70f675e9phK1Pryg@mail.gmail.com>
X-Gm-Features: AS18NWCilqYOPP6-41Cg6p_2SBGrzKLOJYcXVY81vsjTQmzEIXN6pmyHMEzOV04
Message-ID: <CAPhsuW7THs9G+QV5_g+tMvXTAqVJ7jha-m70f675e9phK1Pryg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf: remove is_return in struct bpf_session_run_ctx
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: jolsa@kernel.org, kpsingh@kernel.org, mattbobrowski@google.com, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	eddyz87@gmail.com, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	sdf@fomichev.me, haoluo@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 11:57=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> The "data" in struct bpf_session_run_ctx is always 8-bytes aligned.
> Therefore, we can store the "is_return" to the last bit of the "data",
> which can make bpf_session_run_ctx 8-bytes aligned and save memory.

Does this really save anything? AFAICT, bpf_session_run_ctx is
only allocated on the stack. Therefore, we don't save any memory
unless there is potential risk of stack overflow.

OTOH, this last-bit logic is confusing and error prone. I would argue
against this type of optimization.

Thanks,
Song

