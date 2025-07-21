Return-Path: <bpf+bounces-63963-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC57B0CD4B
	for <lists+bpf@lfdr.de>; Tue, 22 Jul 2025 00:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20C6F7AFE37
	for <lists+bpf@lfdr.de>; Mon, 21 Jul 2025 22:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C77F242902;
	Mon, 21 Jul 2025 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1o0xnaW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457731D63E8;
	Mon, 21 Jul 2025 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753137162; cv=none; b=MuVm2L5dw0R6arRhqhVaPqnwOwK091cLCoTKIHvpAL6qV9sQILbqbXokStUt0p0ewg7joG0rtg8EI1ejpM8qAXIVBhoJ7fk4zpSWnlLPxNVz4ktP5q2Kbou/5sbsOKIMbFcu1GLr7aa9fw34OPVraJxWqRFDeeN+zdDGVbgweK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753137162; c=relaxed/simple;
	bh=ELPl9lWbCPvMx9ROUix88btEknHVjfc7IpFHv1NZmk0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOHL6d7jK2WLs0noyyILn0P8H9HvMXjxkk4OnlxUXrdwVLQz/g6R0Xp+hzzNXcGRGoZTvJfpVgMd4oXFwJXMvUIivPHWlnfb+Xg9uGa9uVjmVUnbmI8VTm609eD3weaoq3W/RyFDAwcg+mIufCbNloQaJpXHoBygsb0kZ5ZKw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1o0xnaW; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23f8d8928efso124105ad.0;
        Mon, 21 Jul 2025 15:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753137160; x=1753741960; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VyDfV7rrZC5dmrjBy7MCe0nD1X8oWEIwHRrOY9MYlZc=;
        b=W1o0xnaW4eZxtKC0HEvZDZ87KqcG693m7ewupGW/oFKPc8QCunolmCvCaUkKSKEAQA
         nD2GuUqFU0cJFVlXcpmuMa0E7vZYBxAtpn3YtDrELoP+29omrqnMYNxAk8VcAtubC+Rs
         c7yDua551obZjUv/hmQ0BKqY2uyQBP5Hqk3xkdCpZa6+6Ce9BG8kh0+YwVTSYWb2uhn0
         6UCje6V1Ho9W3krFuwTDLTKGv0d2LLgiAqOcm8zkZYuFQUPvyE7zCEXErDvzrNB9+M2y
         DfdhqA06IBgQQPB+74G5JIoCOSsuUbF4i++3e4BDpmdF/SguQOo1pbaRF8/LEBJjImWG
         JcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753137160; x=1753741960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VyDfV7rrZC5dmrjBy7MCe0nD1X8oWEIwHRrOY9MYlZc=;
        b=cw0Fp2oswvKAtqp56CkyzQqmynH1+RWYorJEYE49qTA5DSMmqMQ3h2Mp5RsiT/DK9S
         Bi3VbxcvdbE1dZM0QTJ46Dw8lxBaY2KXCIF7vk6gqcYghvlHxFtD+hRucQkEnU1gBUwe
         iafGZUclxhGHvZ50WhpuNDVHWyh660/lU0GE20p7jjPdM/GcATp0YUBMjGhglbiOcyVZ
         LszXW1Fl6AlHYV0kc7bmYkasDLadRcWnoMr1n/z6JlXBDkA6JXiVJYwV77clYfgdmqOo
         AwQ1+rPK0iuD1ShYyagTvXSD8wbk6cpoIWYvON45UqJp2ojq5yq0GFevoN6O+y65GQXl
         ZfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1yoW5BDvHCVd6YHwJyftVGtLm9oqqeYULHI8qvUPz8FwXBOiblRxa49tYC/cwhSiOCrz0HzZ1ViIB4g3Q0EKrSg==@vger.kernel.org, AJvYcCU4NDHM/DbUI29abunDmc3x7nuRqP1rFBh0JR2ZS55ah36nTn6773UU4bapF+Cr+7j4l+ynODMJGAlvH/o6NC5CJ/5H@vger.kernel.org, AJvYcCUoZCv+uSLdYniGm1kdtANbigluRMp4cVMm8UawYlsjueBVMejar7r2r8AnUirnfdJoH68=@vger.kernel.org, AJvYcCWWXywy/70OEikAQM68NQB4t2VikYcKQjAO3jpOMrZUSlXJ2vvWOSvHqxZwmoloepkhGHvnVUZ1Pm1XSmQ5@vger.kernel.org
X-Gm-Message-State: AOJu0YzkN2aO8JzgRNNVB4BWidv0nFCVAre16+rM2zVzjm+t6oxWPX9E
	A1WLhJKuQ2KePt3Xgkcj5tGoNsAFi4pFKBzwfLD0Xylya2iQnc/FBbaN
X-Gm-Gg: ASbGncthaDAVPvSsCFMZTCKNJb0UGVczxqIYCgHokjKjsrnbeh+e+Cmsfm/2ZKUeBfk
	2JieeEB4X4htgzx1mRpQ/za301J+gzt0u8qiWCrilTfW5XqlKID3anClF7lmfreAwvCbnUaQXqm
	x+X7vEC/sp/SNRrIkN5NZ24UAGmSKNMuRbheGi/z9iLTZFJtPLxzehI85mjE1dA6ks0OEXoPE0B
	tfOxR9v1Yiaj7dMQiaF9g/61qMDOPIMZfDWCDKTukn9sA6Oblj3FpGsIDq0ovX9nO98WfJRqINa
	CAkPvfu9eZaNdQIryWpe5vMFW34pFy/tSC+u/YoXwajTJNoDRNmIMwOjZ6uwMMlPRd0iAviyTs+
	B2aKqOQc6dSr94axAMVhgaVICe1tm
X-Google-Smtp-Source: AGHT+IFxy0rmgZAbiSXgvLRGw/zEKapICvB3xXkOxn8uTPeRFBUpotCA5y8fyW59jrPG+IccPl/FbA==
X-Received: by 2002:a17:902:dac1:b0:235:ecf2:393 with SMTP id d9443c01a7336-23e257a3b70mr339054145ad.53.1753137160347;
        Mon, 21 Jul 2025 15:32:40 -0700 (PDT)
Received: from ?IPv6:2620:10d:c096:14a::281? ([2620:10d:c090:600::1:7203])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31cc3e5b439sm6639389a91.14.2025.07.21.15.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 15:32:39 -0700 (PDT)
Message-ID: <3790244e9b6f5508ef54eb799ed5b6e6a9d72b3a.camel@gmail.com>
Subject: Re: [PATCH v1 2/7] bpf: Add bpf_perf_event_aux_pause kfunc
From: Eduard Zingerman <eddyz87@gmail.com>
To: Leo Yan <leo.yan@arm.com>, Yonghong Song <yonghong.song@linux.dev>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Adrian Hunter	
 <adrian.hunter@intel.com>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa	
 <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, James Clark	
 <james.clark@linaro.org>, "Liang, Kan" <kan.liang@linux.intel.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,  Matt Bobrowski
 <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu	 <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, 	linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, 	bpf@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Suzuki K Poulose	
 <suzuki.poulose@arm.com>, Mike Leach <mike.leach@linaro.org>
Date: Mon, 21 Jul 2025 15:32:31 -0700
In-Reply-To: <20250718153801.GB3137075@e132581.arm.com>
References: <20241215193436.275278-1-leo.yan@arm.com>
	 <20241215193436.275278-3-leo.yan@arm.com>
	 <80f412f1-a060-463b-9034-3128906e6929@linux.dev>
	 <20250714174505.GA3020098@e132581.arm.com>
	 <ba5c04f4-a33d-4d7f-9272-eee4a4389def@linux.dev>
	 <20250718153801.GB3137075@e132581.arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-07-18 at 16:38 +0100, Leo Yan wrote:

[...]

> Just clarify one thing, I defined the kfunc in new patch:
>=20
>   int bpf_perf_event_aux_pause(void *p__map, u64 flags, u32 pause)
>=20
> Unlike your suggestion, I defined the first parameter as "void
> *p__map" (I refers to bpf_arena_alloc_pages()) rather than
> "struct bpf_map *map". This is because the BPF program will pass a
> variable from the map section, rather than passing a map pointer.

This is correct,
see commit 8d94f1357c00 ("bpf: Recognize '__map' suffix in kfunc arguments"=
)

[...]

