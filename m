Return-Path: <bpf+bounces-56071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A30A90EC6
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 00:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1657443D0D
	for <lists+bpf@lfdr.de>; Wed, 16 Apr 2025 22:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 985502417D6;
	Wed, 16 Apr 2025 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b="WscGazvc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC0B24167D
	for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 22:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843494; cv=none; b=nokve/8yDMC0cXwXFuwKw+HgiXjU5m43Hueb/2pXFVpBA8ubNjZxkC4l1avvG9O9xe0c2+/gXsHd7RKDwStMlMc2VLV0FCYlMQ+qtmrcupjky21DglWqh+JBfDLg8nQ9F9/n9WLn/rZTFKHXDMt6+epUbZd3xGez0YvxCQ31IoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843494; c=relaxed/simple;
	bh=lWtRiDK4GuYnL50ftDSWuuwiDWAbUTxdlZJqd7w5VfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcuHwGB7ea7fQ1nChncZ/EfE6x6ZsY5ZkOlhf+ynas4naOPKvCGENVCe4mnIt9AwAPhmbj/kfUUtJUzufpUPb+EOYd/SsK/5t2C0EF3s3bdHSh4muOFbO41tsWxVw3jag4a7d/EaSBSrBd8jYRGVRlzGxNRN+h3Vacbnldy555s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com; spf=pass smtp.mailfrom=riotgames.com; dkim=pass (1024-bit key) header.d=riotgames.com header.i=@riotgames.com header.b=WscGazvc; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=riotgames.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riotgames.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22435603572so2018815ad.1
        for <bpf@vger.kernel.org>; Wed, 16 Apr 2025 15:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames; t=1744843492; x=1745448292; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWtRiDK4GuYnL50ftDSWuuwiDWAbUTxdlZJqd7w5VfM=;
        b=WscGazvc6226NbOTAwwf/iqesoetTwKZgLuK/IZjo6xW+YPKX9tYTqT4jAYcoacPfv
         Wc+0PtgxY8iIXbE2KSlVic/hrFzNCDROkvG7D2CIhB0bwPa8AKuFiXIpNnetnYzQ3LqM
         ORKJnN77DIY4Y+Rt2iPSHfeqlJGYWJhTK5H7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843492; x=1745448292;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWtRiDK4GuYnL50ftDSWuuwiDWAbUTxdlZJqd7w5VfM=;
        b=Ym6KjiQatPr741AjKi2hsXXLAf3KYLE/wwd9fIKblAAZYkjUm2cBUSNN7whlE8atkv
         jxbzahHy5+9KQqnJWJcqaqv6bRaPn/n+WtfUY9/9y3EaI9F/5MggohloCWs8eqpwTP8J
         4tOqurImI0ytuBRRKkfJtHafB6fKnIJFU6R62lVK1sbJNKCX/cYamYnM0jZHOsZyLvRs
         E7BuBlnGu/nXhZ+XXi4kym8ip5zX8RU83dtq9QMJeoYq2aBjL6wC0eMH3yfe0oe18PnY
         Jxra95x1rThEw1eNv4ZXsB8SM4Y8H7/S0R5sCkD593XyWTosQyqK9O578G2Bu7/xlfPY
         y7zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyg3ORqEgdHEVlhI61JKFanen9ge6p78XtcLYLDhDY1F7kIKDGrgALJkABheNj6ZV5chs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzaf7w/a66lcab6KzT8awww11X/oci+uMikw8FMpLPujVO/UD9C
	5PPbUqKcte7SqEnf4Ue3WDS7otl3cdpbdIXJHkinNkihIh+Cn6hr11V3/u4pI/NTAiZqYOkUiwQ
	KDqpwalH6XE2KyWK5pzNo+pY5buS6KRoNyzYnXQ==
X-Gm-Gg: ASbGncs6aTj7c9b23eigUtTtkCePL1ftx8idbFkx96cwaBV2xP83hEtRdvgP/4ZrBHY
	Czjt2mg7yjvthfjXiAhk8E8vv6JyP9Sp14YRJJzpoOC9R8VnfH7WPdZsIpvrjxCm3bhR/CPUi4t
	muNTGzw8VzvQ8qcALmqfp7wA==
X-Google-Smtp-Source: AGHT+IF23yy1W1N8zHOh8gMq28w4MIjirJjRJMlSeq4g96UbuxXrOBHR1of087MhejUrgDtRSKU0t9qMRW/fnb3fU80=
X-Received: by 2002:a17:902:ef0c:b0:220:e362:9b1a with SMTP id
 d9443c01a7336-22c358e8abemr62582075ad.25.1744843491748; Wed, 16 Apr 2025
 15:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410070258.276759-1-yangfeng59949@163.com> <CAEf4Bzai7NL-3=1SVi4-WWYWEY6Lzrb8GBfKnt6FG8sNm2OMRQ@mail.gmail.com>
In-Reply-To: <CAEf4Bzai7NL-3=1SVi4-WWYWEY6Lzrb8GBfKnt6FG8sNm2OMRQ@mail.gmail.com>
From: Zvi Effron <zeffron@riotgames.com>
Date: Wed, 16 Apr 2025 15:44:40 -0700
X-Gm-Features: ATxdqUHbv-kzDAdKa3Vm_JbgIrOUv70g1P-9Qv64STJdsSN05EUNDYmZMxFRFuY
Message-ID: <CAC1LvL2SOKojrXPx92J46fFEi3T9TAWb3mC1XKtYzwU=pzTEbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Remove redundant checks
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	mattbobrowski@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 2:56=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Apr 10, 2025 at 12:03=E2=80=AFAM Feng Yang <yangfeng59949@163.com=
> wrote:
> >
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > Many conditional checks in switch-case are redundant
> > with bpf_base_func_proto and should be removed.
> >
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > Acked-by: Song Liu <song@kernel.org>
> > ---
> > Changes in v3:
> > - Only modify patch description information.
> > - Link to v2: https://lore.kernel.org/all/20250408071151.229329-1-yangf=
eng59949@163.com/
> >
> > Changes in v2:
> > - Only modify patch description information.
> > - Link to v1: https://lore.kernel.org/all/20250320032258.116156-1-yangf=
eng59949@163.com/
> > ---
> > kernel/trace/bpf_trace.c | 72 ----------------------------------------
> > 1 file changed, 72 deletions(-)
> >
>
> All this looks good, I checked that those functions indeed are allowed
> in bpf_base_func_proto. The only (minor) differences are capabilities,
> bpf_base_func_proto() correctly guards some of the helpers with
> CAP_BPF and/or CAP_PERFMON checks, while bpf_tracing_func_proto()
> doesn't seem to bother (which is either a bug or any tracing prog
> implies CAP_BPF and CAP_PERFMON, I'm not sure, didn't check).
>
> But I think we can take it further and remove even more stuff from
> bpf_tracing_func_proto and/or add more stuff into bpf_base_func_proto
> (perhaps as a few patches in a series, so it's easier to review and
> validate).
>
> Basically, except for a few custom implementations that depend on
> tracing program type (like get_stack and others like that), if
> something is OK to call from a tracing program it should be ok to call
> from any program type. And as such it can (should?) be added to
> bpf_base_func_proto, IMO.

Is this true? Does it make sense? (See below.)

> P.S. I'd name the patch/series as "bpf: streamline allowed helpers
> between tracing and base sets" or something like that to make the
> purpose clearer
>
> [...]
>
> > case BPF_FUNC_get_current_uid_gid:
> > return &bpf_get_current_uid_gid_proto;
> > case BPF_FUNC_get_current_comm:
> > return &bpf_get_current_comm_proto;
>
> I'm surprised these two are not part of bpf_base_func_proto, tbh...
> maybe let's move them there while we are cleaning all this up?

Do these make sense in all BPF program types such that they belong in
bpf_base_func_proto? For example, XDP programs don't have a current uid and
gid, do they?

> pw-bot: cr
>
> > - case BPF_FUNC_trace_printk:
> > - return bpf_get_trace_printk_proto();
> > case BPF_FUNC_get_smp_processor_id:
> > return &bpf_get_smp_processor_id_proto;
>
> this one should be cleaned up as well and
> bpf_get_smp_processor_id_proto removed. All BPF programs either
> disable CPU preemption or CPU migration, so bpf_base_func_proto's
> implementation should work just fine (but please do it as a separate
> patch)
>
> > - case BPF_FUNC_get_numa_node_id:
> > - return &bpf_get_numa_node_id_proto;
> > case BPF_FUNC_perf_event_read:
> > return &bpf_perf_event_read_proto;
>
> [...]
>

