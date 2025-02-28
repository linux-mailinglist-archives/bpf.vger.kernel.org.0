Return-Path: <bpf+bounces-52924-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8B3A4A621
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 23:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE711713EA
	for <lists+bpf@lfdr.de>; Fri, 28 Feb 2025 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA0A1C5F36;
	Fri, 28 Feb 2025 22:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TV0l6QJR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454EC23F372
	for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740782785; cv=none; b=s3yzzMfGJycmHre1nWxeMimgRkomHapcB9qTWUbLC6hWBvsNPU6irI1T4MArChfiRvWycj3InJVPwZpDK4bJRSk1SxM12yCxURvPBRsri4LHeKwYkAmosP9KccbxzlyajiZ7c1/xh/pBaQEjzPXroMYYsKi65K6xtn+Z3kaxYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740782785; c=relaxed/simple;
	bh=eBsGe3tH7N43bHLEGpMeTzJTBzxYRUO99OD0ZGhkl64=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YKTZwH2LihvwusPTIKC+2rJoFaKtCJpaHsSAGqMjjakQKxloRoUP4+YXpmuvc6JguXooYynoPyOoVq5UGtoC1ikFUw4PbWo38qWYpYwgAQcr7X4UU+zbgc8hrEsvU3kQKBjPV883MYw0YfJZ0l8tYtlJYjQ9LR9xRhuu+zT/SAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TV0l6QJR; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-222e8d07dc6so49474925ad.1
        for <bpf@vger.kernel.org>; Fri, 28 Feb 2025 14:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740782783; x=1741387583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=04IoQLtFA7dcU3lfImDFQK1TIz2YNPZDJhad0vJbJKo=;
        b=TV0l6QJR6srqytd3AybeK9/tkfv2jWDb+aGQyHgPn24pOxUYUe7fnUZLqU3EMxEwml
         O3jQOuyQQ9P3ZAMgG/h9u7oQ22lQF1RmBzOPl1+tLMcAsCnyG4msSsNFFMW7oKW9TsbK
         0rNFltPnxP6L93qNVzzYsYXYIckWE8ML9ThdGxEcJUmYrOZ4yHEBywUFyx/IZFq3ou3f
         FHAM+281wZXTxI/hJXftR5j90PqKFifqUG255CUggfyUmnTyyzR4OgJm88P4YxLVjDUl
         qUXRNbGCpRI7+ahSnLzgpfksrUayhcArnSbnaRHjLPiA5D764Rx+yq6gFP4HkvlKoeAe
         UvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740782783; x=1741387583;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=04IoQLtFA7dcU3lfImDFQK1TIz2YNPZDJhad0vJbJKo=;
        b=L6N5K4vW86rNfAJNQzHYaZgosqFCBlJ8C/sic5mQHiyPxJ9pDrVS3IWRsf9JoBGLcu
         vfq8RDUrrfKuaGeUZfwAED1Wx5EsFLT7ELkyILtJU5qvH6+FOmnu8woZZndroXlXmpJM
         aKcCoFSLnkk0IUUV5xOiGHu52Ks0uvrbsTMYOjIo0wfdROK9bCQJbvw4snGF7ys5aGnG
         I9KbbIjD0M1Igp3lnlIXPA/O5pE/p28vX1tEsaWV5ku0+4/2bug3MZtfgCMY7liOJUlf
         mCh51NFeDpBthhcRz4MQMjv/lT1VuCmODOnkUllfVtw9wxoeUqqRr+5MQclrO/BCDGEj
         YaHQ==
X-Gm-Message-State: AOJu0YyvSQ29bCryKIAtBhVezRMMQ4U+xzIBmWhHeUfFks4ALCzUpO9e
	iKKR8PIPo/DP/cg5hgWxitOHmznw5c8wP2eUHaA8I+UUqLnQcHuh
X-Gm-Gg: ASbGncuTihIPiio9rqJxZEVPcjsGnhPNtKOKWNy5nAo0qryqjPiRyrdWA2jkV+s5n9N
	BPh+5Ei3p3EI+SJX/PfcF6N5Y/Ab5R3qTW9++oNVVB7yrQ/ZI5c4DlWgyqgyksYgbrcxeQo9rfc
	QDoHgJNPxLmgq2zuJjDkZAN8AoSrd3I9C2x70xQHMLZYT+iqKsejllZMF2yV4CRVpGItLRR492k
	nVf7gvNS4kKauRer+iMnNELPIEpVRsvoeEblH5xjx9tkqwrq55awtVCluRenlG1IXTAvp5y1keQ
	9awknJQ9G8w83Ju326kXDttbkVkAXnsI7UrgVBJ6tw==
X-Google-Smtp-Source: AGHT+IFJCPTUYaUf9l5P6vCxIjDe7epksknL0drrV0RtaUT47y2yXWALRZdD4c3k1J5GoKoSHmJpug==
X-Received: by 2002:a17:902:d4d2:b0:223:3eed:f680 with SMTP id d9443c01a7336-2234b05ebcamr127358975ad.18.1740782783478;
        Fri, 28 Feb 2025 14:46:23 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7de19d1dsm3966463a12.25.2025.02.28.14.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 14:46:23 -0800 (PST)
Message-ID: <a179f92b973280cc6fa7a27fa4bc822bbc40f025.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] veristat: strerror expects positive
 number (errno)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, 	martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev
Date: Fri, 28 Feb 2025 14:46:18 -0800
In-Reply-To: <CAEf4BzZJGYxQxjjc4p=kmN0aUVNCHeP5xgPtHEBteswjt=K_sA@mail.gmail.com>
References: <20250228191220.1488438-1-eddyz87@gmail.com>
	 <20250228191220.1488438-3-eddyz87@gmail.com>
	 <CAEf4BzZJGYxQxjjc4p=kmN0aUVNCHeP5xgPtHEBteswjt=K_sA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-02-28 at 14:44 -0800, Andrii Nakryiko wrote:

[...]

> > diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/sel=
ftests/bpf/veristat.c
> > index 8bc462299290..7d13b9234d2c 100644
> > --- a/tools/testing/selftests/bpf/veristat.c
> > +++ b/tools/testing/selftests/bpf/veristat.c
> > @@ -660,7 +660,7 @@ static int append_filter_file(const char *path)
> >         f =3D fopen(path, "r");
> >         if (!f) {
> >                 err =3D -errno;
> > -               fprintf(stderr, "Failed to open filters in '%s': %s\n",=
 path, strerror(err));
> > +               fprintf(stderr, "Failed to open filters in '%s': %s\n",=
 path, strerror(errno));
>=20
> errno is fragile, -err would be more robust, IMO

Sure, I'll send v2.

[...]


