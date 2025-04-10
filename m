Return-Path: <bpf+bounces-55651-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE6FA841B6
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 13:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 946AD9E4C3D
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 11:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CE0281539;
	Thu, 10 Apr 2025 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQXjg1JA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7ED204698;
	Thu, 10 Apr 2025 11:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744284444; cv=none; b=qxeke9yWFvcaNp5tDCwahRrk+aYS3ugTeJbMJBzixnruY6kF5nUqKVYVhMADudpg+kJRt41n50KwmjVWBFblan3S7ByaPvJnVCGQFcj+dibyKXaalKRZVqn0wXMcVdBc5lShPV/wlwcSI22Uza13YR6Dx+SsTGoYkpfsBAoAfYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744284444; c=relaxed/simple;
	bh=iOeJThSjXIAklXajxtW/y29/5B/VxQB3sVa22C4RCYg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjJKt0bfU3x2LOeXwzZYqKAjMjvfrmex+dnILfxrDQg+4vl4x0tcXSo3ijidAIS0bwc7/kqpvlw4hFE+xkAazmJOdtL/Htect0bcGuDCt6KzfTu5TRyiRlpOUJVdKZigHl+9lu4D1G4MhAaBZB8NMuzff5qdSz4y427IcJ45rjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQXjg1JA; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5fc447b03f2so174370eaf.0;
        Thu, 10 Apr 2025 04:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744284442; x=1744889242; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4R7kyZbwY0FogE8ujQh6vXsrt4cQhQyP2ou66tXdFPE=;
        b=JQXjg1JAM/2BMV3xmurYWN8iqKCLoBinxcd++JJZP6YoWRcBPv1mgi22helUbtzHvR
         mA0B+6buy2u8BTVtvN19zHb0/fb7RUVUIUOH+mrcI9HQr/adPiNiOyM3kLnZRQBW02dZ
         UYKeMU0o1RogtZG8WCn/iViP/0QVt2g3fV/DXAIwKdcG7FUpqDL60XdBU2UFUgrJI6qv
         5ngoFR+1g25/2pKRgcQnvUlfQKRldahKdBroYs/AB4eC8YdAau4O4kyQ1PiWwOQMEtEy
         RgNd1MdFRzxreFQaNnasWjW5GsRoTzT8mYd9Im4NLQwTNibqZFQk5KPTAyo8mdzxQApD
         Serg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744284442; x=1744889242;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4R7kyZbwY0FogE8ujQh6vXsrt4cQhQyP2ou66tXdFPE=;
        b=EfkJlNueVBsfqn75f853NwxSdUo1Ram2WpuO0tVpvibc4Y2r6+R/oorto812M95GG6
         pvOnfCzuQuv9NdWXhR+EjtLVKPOTxf8LS0keBykpQhpbMoN5cJzDntLUmQTk7AU9MYcZ
         TMjAiDST/gbfnjqx6WVMrWpGNv/LVjNRRQYPNkZ0RJGdIOE3XE8tilz+4IEQPNACfwA+
         ubAgzgvscckLlaYl6ei2yH0udSZoERWz/oJ2Y8lWJdZqn9nCKqoVeoiBGjs/QSkAyOQU
         6JRA7zDukEwWuhbPUB9ZEJCqaQTqqgoH3ZOtQPtcY2LKN1bKtkI0ARLHgMImu1lcqjXZ
         zmsg==
X-Forwarded-Encrypted: i=1; AJvYcCX40l3uLh2hRr9v8ud1cmiPa68nZhGzL02aivnCVCfUT4BNnyGmEcWYwm2mcg3gNx6zODE=@vger.kernel.org, AJvYcCXwPIL+qaOUFIvSGeDPApwVhJFMsbgNjx3urwj5EJ24ck9zqBbAYEoKsz6NC86eSznGplXTMqK5zltF0Kox@vger.kernel.org
X-Gm-Message-State: AOJu0YyWnslnaQAh83GlEjcK+PQIyGRTC7T9sEMNHWouM9MwjbLw9Up1
	w313e46yi6C++n05/HsKp7g64HLAj1xbNZ4ciY57LQJBTHMANCqIY0PnFHidsmoF6ZIOXUVzYoW
	djQZpotV/n0cmkAasIIbBfc6ptWA=
X-Gm-Gg: ASbGncvDVr6K4pMQXEojWKv8G9hXvoj0uvVcOvUan0CEt1u7hMpmE/V3JGJGFhOc8uc
	ry7+bMDMNrS7/7qYyV464dc20lRJhiklu7YTrx13K9UOup0rEWnrdZIH+pLO/4L13qgUvJc2ugg
	x/+HDYE54sYi5/BG9IGLO1XA==
X-Google-Smtp-Source: AGHT+IFN9HBVuVjTv+AO8TZYcDtenFvOQqDAD2RAKHjlcxxhkpamDj/iELdpATIlUT5Nl+xNBTranPBbprWDpEt+L7E=
X-Received: by 2002:a05:6820:220e:b0:603:fada:ac53 with SMTP id
 006d021491bc7-604659361d5mr999274eaf.2.1744284442124; Thu, 10 Apr 2025
 04:27:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410052712.206785-1-yangfeng59949@163.com>
In-Reply-To: <20250410052712.206785-1-yangfeng59949@163.com>
From: Hengqi Chen <hengqi.chen@gmail.com>
Date: Thu, 10 Apr 2025 19:27:10 +0800
X-Gm-Features: ATxdqUG5Q_jAuMEYxEvrGgTJqNW0HF_XXUEMjmmG-cQdg63biMTSW8a0TxtCF_s
Message-ID: <CAEyhmHRZWB-ba_mFhAHQbho9geMHMswiY---dMsGCuE1uDSkwA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix event name too long error
To: Feng Yang <yangfeng59949@163.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Feng,

On Thu, Apr 10, 2025 at 1:30=E2=80=AFPM Feng Yang <yangfeng59949@163.com> w=
rote:
>
> From: Feng Yang <yangfeng@kylinos.cn>
>
> If the event name is too long, it will cause an EINVAL error.
>
> The kernel error path is
> probes_write
>     trace_parse_run_command
>         create_or_delete_trace_uprobe
>             trace_uprobe_create
>                 trace_probe_create
>                     __trace_uprobe_create
>                         traceprobe_parse_event_name
>                             else if (len >=3D MAX_EVENT_NAME_LEN)
> Requires less than 64 bytes.
>

Please don't submit patch in a hurry.
This patch does NOT fix the issue.

> Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> ---
>  tools/lib/bpf/libbpf.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b2591f5cab65..8e48ba99f06c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12227,6 +12227,16 @@ bpf_program__attach_uprobe_multi(const struct bp=
f_program *prog,
>         return libbpf_err_ptr(err);
>  }
>
> +static const char *get_last_part(const char *path)
> +{
> +       const char *last_slash =3D strrchr(path, '/');
> +
> +       if (last_slash !=3D NULL)
> +               return last_slash + 1;
> +       else
> +               return path;
> +}
> +

Use basename(3) instead.

>  LIBBPF_API struct bpf_link *
>  bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pi=
d,
>                                 const char *binary_path, size_t func_offs=
et,
> @@ -12241,7 +12251,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_=
program *prog, pid_t pid,
>         size_t ref_ctr_off;
>         int pfd, err;
>         bool retprobe, legacy;
> -       const char *func_name;
> +       const char *func_name, *binary_name;
>
>         if (!OPTS_VALID(opts, bpf_uprobe_opts))
>                 return libbpf_err_ptr(-EINVAL);
> @@ -12254,6 +12264,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_=
program *prog, pid_t pid,
>         if (!binary_path)
>                 return libbpf_err_ptr(-EINVAL);
>
> +       binary_name =3D get_last_part(binary_path);

What if len(binary_name) >=3D MAX_EVENT_NAME_LEN ?

>         /* Check if "binary_path" refers to an archive. */
>         archive_sep =3D strstr(binary_path, "!/");
>         if (archive_sep) {
> @@ -12318,7 +12329,7 @@ bpf_program__attach_uprobe_opts(const struct bpf_=
program *prog, pid_t pid,
>                         return libbpf_err_ptr(-EINVAL);
>
>                 gen_uprobe_legacy_event_name(probe_name, sizeof(probe_nam=
e),
> -                                            binary_path, func_offset);
> +                                            binary_name, func_offset);
>
>                 legacy_probe =3D strdup(probe_name);
>                 if (!legacy_probe)
> --
> 2.43.0
>
>

FYI, when I mentioned this issue in ([0]), I tested with the following diff=
:
  [0]: https://github.com/iovisor/bcc/pull/5271

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index b2591f5cab65..4087fc3ae62f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11142,10 +11142,10 @@ static void
gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
  static int index =3D 0;
  int i;

- snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offs=
et,
+ snprintf(buf, buf_sz, "libbpf_%u_%.32s_0x%zx_%d", getpid(),
kfunc_name, offset,
  __sync_fetch_and_add(&index, 1));

- /* sanitize binary_path in the probe name */
+ /* sanitize kfunc_name in the probe name */
  for (i =3D 0; buf[i]; i++) {
  if (!isalnum(buf[i]))
  buf[i] =3D '_';
@@ -11270,7 +11270,7 @@ int probe_kern_syscall_wrapper(int token_fd)

  return pfd >=3D 0 ? 1 : 0;
  } else { /* legacy mode */
- char probe_name[128];
+ char probe_name[64];

  gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name), syscall_name=
, 0);
  if (add_kprobe_event_legacy(probe_name, false, syscall_name, 0) < 0)
@@ -11328,7 +11328,7 @@ bpf_program__attach_kprobe_opts(const struct
bpf_program *prog,
      func_name, offset,
      -1 /* pid */, 0 /* ref_ctr_off */);
  } else {
- char probe_name[256];
+ char probe_name[64];

  gen_kprobe_legacy_event_name(probe_name, sizeof(probe_name),
       func_name, offset);
@@ -11880,7 +11880,8 @@ static void gen_uprobe_legacy_event_name(char
*buf, size_t buf_sz,
 {
  int i;

- snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx", getpid(), binary_path,
(size_t)offset);
+ snprintf(buf, buf_sz, "libbpf_%u_%.32s_0x%zx",
+ getpid(), basename((void *)binary_path), (size_t)offset);

  /* sanitize binary_path in the probe name */
  for (i =3D 0; buf[i]; i++) {
@@ -12312,7 +12313,7 @@ bpf_program__attach_uprobe_opts(const struct
bpf_program *prog, pid_t pid,
  pfd =3D perf_event_open_probe(true /* uprobe */, retprobe, binary_path,
      func_offset, pid, ref_ctr_off);
  } else {
- char probe_name[PATH_MAX + 64];
+ char probe_name[64];

  if (ref_ctr_off)
  return libbpf_err_ptr(-EINVAL);
--=20
2.43.0

Cheers,
---
Hengqi

