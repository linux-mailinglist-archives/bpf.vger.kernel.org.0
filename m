Return-Path: <bpf+bounces-34874-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8071931E93
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 03:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57D63B21861
	for <lists+bpf@lfdr.de>; Tue, 16 Jul 2024 01:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE3F4428;
	Tue, 16 Jul 2024 01:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A8JwA9Dp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD754405
	for <bpf@vger.kernel.org>; Tue, 16 Jul 2024 01:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721094698; cv=none; b=M5AdfNUt4TwcWGHX5/avuRi3IKr4xq0kroyUZtT8sqFvoRvh5vt25Cxqcc9pa1pW040Snr5IxbzO+Fp0PIH1VYMYsP/Db67ipzKEk4YHDdI3dUCP3IHTJgUHidq1wDUHvnn3I5Z7cbg6PkY9+mJ/nE/E4LwGd3t7fmNsrtj497c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721094698; c=relaxed/simple;
	bh=YnVfLrp/Y2zfR/ffbPM4Ktyuap1fAQcXGYruMZcsAtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d066AQ09t6I3UJo6SByorbSXkElOguUgng5Khm7V21POxnViMjy+LJJzz99dhEf6Yyy5XQHm7O9h2/Qs1g+DJbHgFLesS5sBmVuZlwK3YrgM109HXLwHow4zl/zsQsB0Z1ILS92snfS/mZkaSQt9Qq4y3uv3xn4yEzMwRDxWBq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A8JwA9Dp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-367993463b8so2792310f8f.2
        for <bpf@vger.kernel.org>; Mon, 15 Jul 2024 18:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721094695; x=1721699495; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jUi+Irsn7XMcPpG/scsUgxMwFi5kUPCqhp4Mo69Trw=;
        b=A8JwA9DpEWtCbmx8/ZVHjQGU+0Qx8BS4ZjYGMkiukjTfncyEXOh64A9FblTY1HAf+n
         Pmmwp9iNxLH6b/L1XXMC4JXLBwwusqV+PIhkgA2/jQox4SJvHJhJeseeCDi2zoXZ+hZ5
         lVw3qO6SjlU+LBssDB3ajS2C/8C4kniHOxejUxJmIDBzNmC+MCw+r6dCwNlyoa1WvqK4
         F1ieJ8eYXyXhrSTo5yY7wsJMd47DdDMhIgZnMheBZgq4+AG8pFeJZh/Aq8JiZe2e9YjF
         7ED+6fvqpht3DqCG/Jc8Sss92HgF8sbjnSn6QMVzAYcizrc4wIrc35Pg8mv7bkSDWlA0
         Q6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721094695; x=1721699495;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jUi+Irsn7XMcPpG/scsUgxMwFi5kUPCqhp4Mo69Trw=;
        b=VrRLuY4v97/kreVaH49oxgn2702eOuOr/0XGW06dsqVu4RdfjS8S+5gCzHnmQ42ucA
         Pv3YmGTsQ4MCXGbHLwQt3PuK1pdmM0GZT2xywNiBfzhcNUl0GUfh3G94Eh7jYY5fWjh4
         wypoPsS9kdhTUT3LNNZuK8MOXvdEIqxPfvn3nIOUFqkomRAEymcO4+JAbGCo0AlpF676
         ZPVoHYyMWLWMusedlWxQCx3/AZL1//fvUTl/R533mgcDX33FGOv1xH0n4YRpwvFzwikq
         /oTBqpPE97OY07YrnB6Q6HNIkB9EEooAGqSh3zhR5HFdsVNbFfzHSvBuOOHhP3Ttudp1
         GAiw==
X-Gm-Message-State: AOJu0YxVhf8SKzVVoWi81Zzyi1AKD/AGs23t/ah6Zx2UV3S3u3LN4rsG
	v2nqklDgTMqW73M5Km4YKZaBrF3jLp+jX9hfXmALwSyj/OeXDidy1sOolsFjmX4XN+VeltNF0AT
	kptEhTYFv4+Tytc3FNfPjaTt3Bxo=
X-Google-Smtp-Source: AGHT+IFAtDUN9lHuPN02mfJnzfadPTB4OoFB0TkWLkvIGO8Z/mQMD5rixuMBDjJO1IJMuJylU0h/xVc7cbLvntwlcVY=
X-Received: by 2002:a5d:4210:0:b0:367:89d5:e440 with SMTP id
 ffacd0b85a97d-368260fdfaemr266019f8f.20.1721094694772; Mon, 15 Jul 2024
 18:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715230201.3901423-1-eddyz87@gmail.com> <20240715230201.3901423-3-eddyz87@gmail.com>
In-Reply-To: <20240715230201.3901423-3-eddyz87@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 15 Jul 2024 18:51:23 -0700
Message-ID: <CAADnVQJ7MAtt-EZLorjuyhoOFijyff7tNDy4-up0L6pjnrZHvg@mail.gmail.com>
Subject: Re: [bpf-next v3 02/12] bpf: no_caller_saved_registers attribute for
 helper calls
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Kernel Team <kernel-team@fb.com>, 
	Yonghong Song <yonghong.song@linux.dev>, "Jose E. Marchesi" <jose.marchesi@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 4:02=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> @@ -21771,6 +22058,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_=
attr *attr, bpfptr_t uattr, __u3
>         if (ret =3D=3D 0)
>                 ret =3D check_max_stack_depth(env);
>
> +       /* might decrease stack depth, keep it before passes that
> +        * allocate additional slots.
> +        */
> +       if (ret =3D=3D 0)
> +               ret =3D remove_nocsr_spills_fills(env);

Probably should be before check_max_stack_depth() above :)

