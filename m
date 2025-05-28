Return-Path: <bpf+bounces-59190-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301D0AC70A6
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 20:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B88A16B9DA
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 18:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A70A28E590;
	Wed, 28 May 2025 18:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YOBtY8lZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997128DF51
	for <bpf@vger.kernel.org>; Wed, 28 May 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748455362; cv=none; b=hAb6E8tbgwolwKpERB24MzriH0v3n0e3J8NJDoNghaCBKkAHsksp0z+KAbcHJ40YH/QsMxLyqC6ouCmoUoNOjIzIk/sFPyt49sKWU/gRPVg9ac6sUyi9/M3bd5f5RmHTp6pov7LoU3auFhvS+0/5PfpT++Pef9XwcDjTV9QNgdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748455362; c=relaxed/simple;
	bh=ISADO/sjcgAzQby3PNtrJJJvMvpngyHdHu9GZBVoMeE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fjt55dV8WQooGJhge5vaw/KpfgVGlxrWQyxLjsPbK6aT4af4uwUwRi194+GYXHAFpkNkaZqdHOARsh2SbUBwLt/q0Z2BouR2DzzTl+4yIV5eZ5QDZoQt2Xdlc79AhgHIfaHT51G6rE8hQSfTDhqeFWlwtvXxZrX/j5L3Qlvug2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YOBtY8lZ; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3dd7a95d19eso810405ab.0
        for <bpf@vger.kernel.org>; Wed, 28 May 2025 11:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748455360; x=1749060160; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XqbJJnxAmc6+8xYJyIsNoSDkzYNy+aZxHaN1MI1Y5qU=;
        b=YOBtY8lZtV3i+etfsE/OVpaADBz865CtTSgHyBezVt7LMRQyP5pyHj1mOA+WkyuyWc
         h1zyjVl/SaezhfWmQoTJtAUSYLpLYG5zkeVHKYA7Flm3u3Oej097wv9IpMk+jVC8XNhO
         zISGy8eSvX3ip1+JCsv/hqqux95hkw8IS7Zn93wc17NCcBagiZU/rDRmRqnYtVdMwFPF
         K0WQHY0RrN8zD1veausV31RQtRJKv1bKsAqC52LkA18pU7E/wQ6hl8G+GVC+xMcpv+ev
         ThzYDTjTeD3U7PsfLWseNQ8rYM7xig16n2LXIgatREIeHBjHUionMZhOiyMjAx6eG9qm
         VeCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748455360; x=1749060160;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqbJJnxAmc6+8xYJyIsNoSDkzYNy+aZxHaN1MI1Y5qU=;
        b=Wb3MtvuaWcRVfL1yEXAt1Hu3JbRc+P4TX9G+LrR0WgaQbq3foTFcL4x1jpRZK23Nhh
         DDEigCDhUbSdTen64v0X6pg3G9hMKFC5c4QaBlQ13oTz72vcRnAjuVa0CMvB7jF+ucEo
         Wtb95n1jvv7rUufuD9gKvTH0r2dwUlE7zfIs0cuSVDZ1C0lzI1vTG+KJdkm2KyAXzXXD
         rBekTiTsgKObOvS/Iyeqf2Li911dFKRV5uBsvK8S6m/8lrYWe4FK6i21ofAuDJ5oCFdz
         t0MfIrPuyUwJHtSCH6toFGxwLwikKPtujQuLOyJjEUyWGSMPbRh5NGAgF9HR/wbyv8sO
         8i7Q==
X-Gm-Message-State: AOJu0YyBFtD6QqYNiGg91cynDIOIh7t9V3mEc2tTMsLGzeAe4mANzNLv
	rFjE+5xKc0fI+kaPj8x1kyGyW7CRzFs31SadAu610rlpS/mKOS5C6qiamlYcnyMv
X-Gm-Gg: ASbGnctwJQmj5FPr+qH1uMhtcKbVfBW8qryz4CeaDQmjYYEAhTNckCz1krt6vQ8qKnd
	x1elpSCk00NvwsfxCm/bJwcUju8q9iz1NPuxxD79sV7poCt1JC/Uxzlt/tg+3Sa0UM9Bl13r5M9
	s0hxWJ0z/A8jY7t7U9tE6tOr5cbpqe+DrIi7dBSIW6N59Lt+qXArgkuYKCdMTH/zKRROZcEQpy8
	wCy4VhU39f88UaTVZluWn87PqTeWAr54cVX4uwBQ1RwS1Upt+WcADBthD+xbioOdPGe98bA1UYR
	CZD3Z1sQ0c5ViPLlpdOXOfHxCS8108yxo2Jm7ykHJtki8B4ZEAWo2cQ=
X-Google-Smtp-Source: AGHT+IG6ifgvOoy1YDnD/ENIYoZ8y2ZIMpFrahGPWJw+EcIbZpYqPl0qhHt0VGG/QpE5BuRxHYHbgw==
X-Received: by 2002:a17:902:c94c:b0:234:986c:66ed with SMTP id d9443c01a7336-234986c6d05mr105359735ad.9.1748455349772;
        Wed, 28 May 2025 11:02:29 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::4:d651])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d2fd43c6sm14847805ad.18.2025.05.28.11.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 11:02:29 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>,  kkd@meta.com,  kernel-team@meta.com
Subject: Re: [PATCH bpf-next v2 09/11] libbpf: Introduce
 bpf_prog_stream_read() API
In-Reply-To: <20250524011849.681425-10-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Fri, 23 May 2025 18:18:47 -0700")
References: <20250524011849.681425-1-memxor@gmail.com>
	<20250524011849.681425-10-memxor@gmail.com>
Date: Wed, 28 May 2025 11:02:26 -0700
Message-ID: <m2o6vc1uml.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> Introduce a libbpf API so that users can read data from a given BPF
> stream for a BPF prog fd. For now, only the low-level syscall wrapper
> is provided, we can add a bpf_program__* accessor as a follow up if
> needed.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> +int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *stream_buf, __u32 stream_buf_len)

Note: many of such utility functions have _opts parameter for future
      extensibility. Imo in this case it would hinder usability a bit.
      If need be bpf_prog_stream_read_opts can be added later.

[...]

