Return-Path: <bpf+bounces-21516-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EF084E6FC
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 18:44:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A47C282FCC
	for <lists+bpf@lfdr.de>; Thu,  8 Feb 2024 17:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F083CBA;
	Thu,  8 Feb 2024 17:44:21 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4857776416;
	Thu,  8 Feb 2024 17:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414261; cv=none; b=ijTfFOOBNF4tp4Rnck1abbY23N5YQRP/i0yzK2noJauRsnkiiSrffWDHhX/HaxsETik9raPIhJeQrCJvLgAXoPy5nWlqMSBNeOT1VoAIDFnzToENqQfEOzlHMX2MVYRgXcYDQ7Tw7T0GPclwOwPN23PaVt84uoHHnxlTudhqm7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414261; c=relaxed/simple;
	bh=5Hk8XS79Tvu+EaVRYexZemcqZTK+oRUJLjtcrvj0EDk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzneRsPDMHLpDETc5cSNkDK86qUWqfRt0uJhueZqn2sYDE1z4A54XXLqCUM1f2I/apLvsxe2qLw6FO9GXHq4lRK65s+b2mTZdZBkJ8vLoPXNcZkiL31N2FurecFczDk2BLlnyLuJ7JZPcHT4PpcxHpSVjErK6o0/WZ6rh2u6F1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-290d59df3f0so56570a91.2;
        Thu, 08 Feb 2024 09:44:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707414259; x=1708019059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dfwEo5ig3aDCkVExP91yh1w0Yn3JnDCOxLSJevvADSI=;
        b=KIyix9krphxGnr9gZZEjHFISZzSZ0opvEg3FBKN9GSbPL4pPAhokuYMqmvH4/fsaiS
         GZYDrLw9wxeFOlTRrrGWUVrqKx5SsiCxU7ERadXTnwlEaNlEiNm3QhfXMkvzDPH+5lNY
         fAdBsfGQCT5AB9bZTJQn1ZUAzJcZok35OWA6qVEC9vOAOJUtzt5xV6c08w6w63tucpFU
         YrFSu9dsHCREZ++CRFzM9UzF77zFzwcwTd7gYWdoOtlAxJkf6eAoHNZftrZHMDY6EFK8
         ZbMU27H6TQK7g52ww9eHwvXEhEFRdPFlinYVd1O12EyCKj7veXoA2I2QMe9WXHC6HkZr
         DwzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJgzNRYOHm7wRFnlJwAN8W9zyKDc+24kqOw2hEx6NrRq3aQwz4enNU2waYooBx8nScwnXeb6YxEUpXa0TfcPnmgoGnns77mJ+ZN7deSUv6DJKZC4ZS2LFYsKvJinV1IGLtlM1JnP1y9tsSlvSsS3jmAQ5xbErylx9BFpG41QKHYvmtHw==
X-Gm-Message-State: AOJu0YzZxrZaLATsn47EkTbd15pcykVnsNs6X3gPETfOctZZY0bchvKa
	lmXoxseXNoglNy0U0+xxoJGqauJTj42Y83RRrmxpMMXsdqAHWw4Zy5rTMpBc3f61h7ikEyx0Zf2
	NmxafqvnB3ZGsctclrZFTBJHRR9Q=
X-Google-Smtp-Source: AGHT+IFniQ63mPXn5L5xgsHEHUVulxSZPZ3eaI2CqrNzSLvdsKnD2NBAOgn/pxnehcTAak/ymVEN2S9elx06C3NrYAA=
X-Received: by 2002:a17:90b:1bc2:b0:296:a746:67f5 with SMTP id
 oa2-20020a17090b1bc200b00296a74667f5mr6272038pjb.44.1707414259351; Thu, 08
 Feb 2024 09:44:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207223639.3139601-1-irogers@google.com>
In-Reply-To: <20240207223639.3139601-1-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 8 Feb 2024 09:44:07 -0800
Message-ID: <CAM9d7chBixXozCQztM2WKGbfs_8C70vy6ROzKpwLSqq-upz5iQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] maps memory improvements and fixes
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Song Liu <song@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Liam Howlett <liam.howlett@oracle.com>, 
	Colin Ian King <colin.i.king@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Artem Savkov <asavkov@redhat.com>, Changbin Du <changbin.du@huawei.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	James Clark <james.clark@arm.com>, Leo Yan <leo.yan@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Wed, Feb 7, 2024 at 2:37=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> First 6 patches from:
> https://lore.kernel.org/lkml/20240202061532.1939474-1-irogers@google.com/
>
> v2. Fix NO_LIBUNWIND=3D1 build issue.
>
> Ian Rogers (6):
>   perf maps: Switch from rbtree to lazily sorted array for addresses
>   perf maps: Get map before returning in maps__find
>   perf maps: Get map before returning in maps__find_by_name
>   perf maps: Get map before returning in maps__find_next_entry
>   perf maps: Hide maps internals
>   perf maps: Locking tidy up of nr_maps

Now I see a perf test failure on the vmlinux test:

$ sudo ./perf test -v vmlinux
  1: vmlinux symtab matches kallsyms                                 :
--- start ---
test child forked, pid 4164115
/proc/{kallsyms,modules} inconsistency while looking for
"[__builtin__kprobes]" module!
/proc/{kallsyms,modules} inconsistency while looking for
"[__builtin__kprobes]" module!
/proc/{kallsyms,modules} inconsistency while looking for
"[__builtin__ftrace]" module!
Looking at the vmlinux_path (8 entries long)
Using /usr/lib/debug/boot/vmlinux-6.5.13-1rodete2-amd64 for symbols
perf: Segmentation fault
Obtained 16 stack frames.
./perf(+0x1b7dcd) [0x55c40be97dcd]
./perf(+0x1b7eb7) [0x55c40be97eb7]
/lib/x86_64-linux-gnu/libc.so.6(+0x3c510) [0x7f33d7a5a510]
./perf(+0x1c2e9c) [0x55c40bea2e9c]
./perf(+0x1c43f6) [0x55c40bea43f6]
./perf(+0x1c4649) [0x55c40bea4649]
./perf(+0x1c46d3) [0x55c40bea46d3]
./perf(+0x1c7303) [0x55c40bea7303]
./perf(+0x1c70b5) [0x55c40bea70b5]
./perf(+0x1c73e6) [0x55c40bea73e6]
./perf(+0x11833e) [0x55c40bdf833e]
./perf(+0x118f78) [0x55c40bdf8f78]
./perf(+0x103d49) [0x55c40bde3d49]
./perf(+0x103e75) [0x55c40bde3e75]
./perf(+0x1044c0) [0x55c40bde44c0]
./perf(+0x104de0) [0x55c40bde4de0]
test child interrupted
---- end ----
vmlinux symtab matches kallsyms: FAILED!


Thanks,
Namhyung

