Return-Path: <bpf+bounces-27603-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC88E8AFD50
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 02:27:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90B9283195
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D75B800;
	Wed, 24 Apr 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/bCLvdW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A2B23CB
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 00:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713918440; cv=none; b=DE+mudZ9MPfQtck7V8CJXUvI4uqGScBaXNyzt2vEdALQrh9U85O2ofT4PTf4xEP26q+lwvoUkX162hFLle+EYqtpWbQvq8a3rvhc+SO8R1epYtR8kU6OROvUwgJlp+SJgOsMojxUyWe+MlqizS/w6a7X4dTAXDSFihz6CmWWz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713918440; c=relaxed/simple;
	bh=KIIlHR10xaKGX0lG5L+ZSVwWB3MojYa1I4qDma784bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYb46OyruDK49i1n49SOAiPxU7zR+H5SiJ3Dmc9AGix01C4Ii628kAS8prpW3mKGTc7G9TBEiObEHd/e4v79dN+PaDQg/RMKksFnwHcAzionajFe5l+15RVjto5221279YPBNFlThLK3RlSFwZYXsgo4fueBsBJkz6NiBuHCTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/bCLvdW; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6edb76d83d0so5243737b3a.0
        for <bpf@vger.kernel.org>; Tue, 23 Apr 2024 17:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713918439; x=1714523239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6DMm3FMadz06Dg4wBl0jNHB2Ygfdm4Y4Er7B7o3Bzc=;
        b=b/bCLvdWpdMAU0UL2WiT05Xl5Mftbm3XZshFquNB2iBXSLnE2h+zlckIu/8VoATXSZ
         NAdsNH+JspDFYdYNz89VgQhV53h5c2Js0Kbr86qO94PNPmXVgIpCi9kbMlC/arkfH3JC
         c7w+3vNTuxTdBlWaPM5Jjm7JHaP0a1STLAUSWT6jJ1w1KainfwSFh1LnHcLslEVMSa0i
         a7iakb3gGO9wV5W65DnxbQOWlJPEUr2xYOW9i0LCxh2N0NtS2yg7cHAHp6/bb7OplVTG
         4Hb5tANaLiWOFF1nk5u6vqK8eN/2HX5F1AMcCcyXxp8sX8QWh/7pliSSICpQ2bwQYOcp
         HSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713918439; x=1714523239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6DMm3FMadz06Dg4wBl0jNHB2Ygfdm4Y4Er7B7o3Bzc=;
        b=Ldu9mT8FYwJ7Dn0pRgMidljRnBuDUGbOHvlCVi6o/HKMYIRfPYdD+86jj5/rdy/3BL
         vQw06dkBgF+9mkTXbVMcoa9tITrmPZMhTKu+XWgC7sXyJsUc8XUTsYchApKzDZlrUBEs
         Y/G0pnIVyUmxTCyyqSpjruazvYZ1TesaIrwJiValcMyn0UyPC3wEt2CvPl7gOIViIWy9
         3uPXhVL/tSZasscw+I3EHiV+26xykYTjewPfyCzN2nZeY8sklUyTiei8JMeE6L4BStBW
         ReDwy5Iv/M0RaSiuo+VxBMZkybxG6ELaMCxpilG1cvXV2dVQsC/cQJYalSdfsexAKEg7
         /B6A==
X-Forwarded-Encrypted: i=1; AJvYcCUA9u2/4OJdewhGOTG3+B4jh15VthNyTV9G5oBM5Bu8cW/hycmczP1Li3dboF+0uOXNbO/8D/P/jTYBB1ZyCdHVdU95
X-Gm-Message-State: AOJu0YwWoAKGgLVFj0x9RlzbwpA9fIjxIy1ogp8ahdqE33c2zI/RQmyo
	9NttM3vTD3a6bjblSxU7TlwQ989S8SNayKl0I06RZ8yX78XctWPxo1iyfthUZq3t2FC1a/jZG/e
	LX0Nsd6YlwR3NxMn8fjtBElLLZ8Q=
X-Google-Smtp-Source: AGHT+IErPE1OWTreaicXA/cH/NOb7pFUSVqpjgTPf5jbXhyoyEnK+9AC29K+3g9dNPXtoz70x1ZSszU2Fkfh+RitCOs=
X-Received: by 2002:a05:6a20:9498:b0:1a7:7358:f111 with SMTP id
 hs24-20020a056a20949800b001a77358f111mr933272pzb.31.1713918438898; Tue, 23
 Apr 2024 17:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422121241.1307168-1-jolsa@kernel.org> <20240422121241.1307168-6-jolsa@kernel.org>
In-Reply-To: <20240422121241.1307168-6-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 23 Apr 2024 17:27:06 -0700
Message-ID: <CAEf4BzaAM90Sq6uuJAO+x-mgpqxdZ-3iqYaJCi-wegkJ8YmvbA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/7] libbpf: Add kprobe session attach type name
 to attach_type_name
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Viktor Malik <vmalik@redhat.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 5:13=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding kprobe session attach type name to attach_type_name,
> so libbpf_bpf_attach_type_str returns proper string name for
> BPF_TRACE_KPROBE_MULTI_SESSION attach type.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index ca605240205f..9bf6cccb3443 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -132,6 +132,7 @@ static const char * const attach_type_name[] =3D {
>         [BPF_TRACE_UPROBE_MULTI]        =3D "trace_uprobe_multi",
>         [BPF_NETKIT_PRIMARY]            =3D "netkit_primary",
>         [BPF_NETKIT_PEER]               =3D "netkit_peer",
> +       [BPF_TRACE_KPROBE_MULTI_SESSION]        =3D "trace_kprobe_multi_s=
ession",

we got to shorten this to just BPF_TRACE_KPROBE_SESSION :)


>  };
>
>  static const char * const link_type_name[] =3D {
> --
> 2.44.0
>

