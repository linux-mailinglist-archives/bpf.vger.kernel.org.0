Return-Path: <bpf+bounces-39873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4ADB978C09
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 02:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BF4D284B3C
	for <lists+bpf@lfdr.de>; Sat, 14 Sep 2024 00:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638F32564;
	Sat, 14 Sep 2024 00:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlBtulml"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DB79DC;
	Sat, 14 Sep 2024 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726272138; cv=none; b=nYYCcath8rJ1s4lLfgLZIR1dSoLD4IGTfexhLYgYxvwTtSJ/FHf8X7ilF5qCpIhLsg119D5FqgxCHQRcBQyAGKxdwX3IXHfqEvsRZhQ27vpnNUW3D8ppf/5IuxPNzEeqcvB+zYeQs+Qc4aklBxNs0RUWEusGMHj6so1vuBrsj+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726272138; c=relaxed/simple;
	bh=EQnAXd9EotjYoYlNyiAMNzEMGoNMlAbitn51cd8vaUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/O2unTKybhyKAt6g8FQllJqbCJKXDqY3wmREvMeHuwU5ziYVcNXYfHKaTXf/DYbnfKxvFrefc1X3anT+PeMszQXHg7+vFsi5mVn/zbaZgYf0PKqf8evM09Gw/GW5l0I/ERpq9rnSSp5evFpeUSjJ2s1hbPPcOZOjgP1eb+WKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlBtulml; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-374c326c638so973572f8f.2;
        Fri, 13 Sep 2024 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726272135; x=1726876935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXX8mzgSJjoBnbX4xJ/wcXQ868Ptyga4WSAsSgAvq8Y=;
        b=nlBtulmlAmJ9tvjiZTCtkpP32toaht6bOPEj3ZVXHRgctSU1JRBkjBCBGU0wXZuCEB
         JmZneZb72coWvNVUi4W7JIWMX8VdxnKsquygw+baKzHJwMFHt03kXsvIrvzpI7b07xGX
         y8zH/rBpUXCD6K69zKozY9YGiHK0BXJZgQU59AcfaQ3rin+M2g/x1ZoJpG7fqkXQ3XJm
         IQgC6EeoZAz99RoPYAi7Z7bA4G/MI1bPmppxRtiiJBwJj/VGccDW5u0203HtjDIk8OG4
         zQfiJ3J7cY/ROVdskyG3Ny7DlqWHHMugaJ+CFJ+DQRuo8rezlHrxrqPKRa6fSx68Bk9C
         jXMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726272135; x=1726876935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXX8mzgSJjoBnbX4xJ/wcXQ868Ptyga4WSAsSgAvq8Y=;
        b=q2qqYtm3BvaGUyhmSV7PBE0Yf+ZhcD11JTqE6xlMI1hYH4zRFlbJz20Et3JRUyFqJM
         qF2m+EYPSCDpbZrUluyTUZFDIkI8Rd6WSeoU4dtOwEhb51v4lFoJHwaEjaMxO4H02yWg
         9SJMxOFL5gBnpgPHG1tFugh8V+jeaefAIRGRNDnrVGkMGK2RQgCT6c7WzGKVT0MzTGhR
         J60QoiaUQHacCDXoIWl1TwkXhGBzlKWAcBNz9Y0b6OmuKZwJQMCiI3wDyoW0Cw7GgBQv
         c12kZHWjEoYlmw8+y7SKBGApYI6Aep27Cee92lRJJOtjq8+avswQ/igsu3JSGXaQhONv
         D8+A==
X-Forwarded-Encrypted: i=1; AJvYcCUKNUbS47Kx48erFrNwdV6Qrnh0RB42an3sgzS1mNE4PCX5C8vrPbWfDbeJzmHdwbP4Ym6px/w6oTvGCpBH@vger.kernel.org, AJvYcCW6C9ydvMmUV3Hlaf5o8kiVFU4EwhEWvQBz4JEr+QQymADrNhVUBCGmpd0ewUph+1ULZp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlhWzuaM8M1gU7JumefUDSBUOZt+nVpgUUkof2c826Lppf4Fe+
	ByxzH9wzZ10gXRSMlQaucvCRPvHxVUV+EBaxI+b5lpMvsnDf8UNVohn/v1RdPT5F2sXjwJ8OGID
	GS+uElICHslLSJ1QXKhl3to9W+anXTAej
X-Google-Smtp-Source: AGHT+IFF9KWopyjRufo4m/UyfPVjYIhmHIokSx4pmGbJIqezYQhgeQi+coTfVC9V8/fRc9QYjkqoLTcQkKgI64Q6wm0=
X-Received: by 2002:a05:6000:c89:b0:374:b9a0:ddee with SMTP id
 ffacd0b85a97d-378d625a9d0mr2247305f8f.56.1726272135011; Fri, 13 Sep 2024
 17:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912081730.22094-1-zhangjiao2@cmss.chinamobile.com>
In-Reply-To: <20240912081730.22094-1-zhangjiao2@cmss.chinamobile.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Sep 2024 17:02:03 -0700
Message-ID: <CAADnVQJbzjt0w158Ww2PBJvrzwVbUeCq7O_HHyVfKvZa3UC4_g@mail.gmail.com>
Subject: Re: [PATCH] tools/bpf: Add missing fclose.
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 1:58=E2=80=AFAM zhangjiao2
<zhangjiao2@cmss.chinamobile.com> wrote:
>
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
>
> Cppcheck find a error as below:
>         bpf_dbg.c:1397:2: error: Resource leak: fin [resourceLeak]
> Add fclose to rm this error.
>
> Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> ---
>  tools/bpf/bpf_dbg.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/tools/bpf/bpf_dbg.c b/tools/bpf/bpf_dbg.c
> index 00e560a17baf..5fb17fa0ace8 100644
> --- a/tools/bpf/bpf_dbg.c
> +++ b/tools/bpf/bpf_dbg.c
> @@ -1394,5 +1394,11 @@ int main(int argc, char **argv)
>         if (argc >=3D 3)
>                 fout =3D fopen(argv[2], "w");
>
> -       return run_shell_loop(fin ? : stdin, fout ? : stdout);
> +       run_shell_loop(fin ? : stdin, fout ? : stdout);
> +
> +       if (fin)
> +               fclose(fin);
> +       if (fout)
> +               fclose(fout);
> +       return 0;

main() is about to exit. There is really no need to close it explicitly.

pw-bot: cr

Daniel,

is this debugger still useful?
Should we remove it?
and bpf_jit_disasm.c too ?

