Return-Path: <bpf+bounces-39156-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DEC96FC6A
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:56:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432E51F26635
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 19:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2C51D54EE;
	Fri,  6 Sep 2024 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMpsrnvP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13EC1E86F
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 19:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725652606; cv=none; b=DlCGadQuEA8buN/JXuMKlm9dOXK0kZ5CBLHgF1erBAU/l25uIkTSkJZ19V+RMQzaJG/GKfVSrDEr+LQsDMseGGX11tUOWo+nfuvofl2mwaJnKTWG93ZyhzWg1QBPkdcQqNGyjqN6FSFSwxpxk9oep6xRc96ikHxVQYAJFEXI7bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725652606; c=relaxed/simple;
	bh=4a6fzlyNQcN3//Xr4KTDqRo2CjoNpZHyxBjErcFS5PU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVXxoAeLWsIy9gcMUgPOcmlU3abNyFa/0nmQVDKj3rbpWjMThi14z654gwizZTc7Fm9gOh94T7pl8ON+/nx74IkIZ7X/Ti/97RxCtRpd6aIaMmCej/bvcbP1C0DrGCU4J6qjtNx/YkcdIicJ4BNydl5robV6qib176rxrcIS400=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMpsrnvP; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-206bd1c6ccdso24278845ad.3
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 12:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725652604; x=1726257404; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C3JOH2UmDgLh3B+/82FGOD7xOVuQVXh+D+aRA8G/qgw=;
        b=cMpsrnvPgvIXb2N0zXxAY7c6pgob21cIbcCDK1nTLT9hgqwg00JHpviJHphKa3KYUh
         HCMgnXg/hiqTtBVmhvfiOc2mYKORKBJgF9y2VKkhjou4HYNWE5ECclkCGuHOeano59FB
         rL3EjHybVv5BdSlLKabwYqS8qz8vCbsiuZTkZzJO/sUqX4gSVgBWiPWpgBnRQLnkTHif
         hc7BeNMfFn3xcuL+Ay5bFDmW0Zf51VybgXPQKh4QuAzw9tas0HH7EMrPILTwitYbAy5p
         N4QdQbgb1ix6rgyNYUxT25ijpp3iRc0Fh5U/b66lMxqoPVliQvn64D2qbsOZryxuYOuB
         6YEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725652604; x=1726257404;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C3JOH2UmDgLh3B+/82FGOD7xOVuQVXh+D+aRA8G/qgw=;
        b=Qftxmb/qdDGXjRiXEuB4fS0188Wb+urkTgCfAzaeycBZB1w0VVgQaQcSjbtJ3RVL+G
         rh8M/51K5Nj40A1hJfwKc5jS8WowZSwXR/73FuFIxkDm5jCmv6qO6Lzwjmf021Ph4smj
         E36vXAnKw0jXmh/IZfOrMfiL66NQRltsaYLxNyNEtOPBkqBj3NkROQpgHglS0HEoMji2
         XEnpX2BAju7TNF0EnYEEWbfIlOmceHDOUVuFd/f0rWpZ5ptYpGG+HU7uMXVgn6Xy9mI3
         H2GqbrrwDpHZ6NIt7c2mxu6xggzSlkDkTLdHibtNAYucZCrN+KEWAKUofTKsFzlJDBVb
         eovQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz/NLuEyvMAWydRxqU5VxTqJTxwIZlxGRYbJ8R4oeNPkQc4OecuauiVrijXuIUQgcrydI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwN7UbV672UdOXxGYgsC0jdRUjMy5Mo0R2POYeT8TQCO7MUqRjG
	pSOy/gOfQFSB4KmQYRxVrt1GkqhLZB6D2z2GL27z6oqKBy+Mb8M5
X-Google-Smtp-Source: AGHT+IEM6uNAT3/YYUaFZLUwEGC2c0LXZLuPSb9slmYX1VIlQaLFA3cVsmRnxpbHqwPAQxj7tM08gw==
X-Received: by 2002:a17:902:d2d2:b0:206:b79e:5780 with SMTP id d9443c01a7336-206f0507dc6mr46303305ad.24.1725652603910;
        Fri, 06 Sep 2024 12:56:43 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206aea55d42sm46375145ad.204.2024.09.06.12.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 12:56:43 -0700 (PDT)
Message-ID: <6e88208543c2bf9d75d9418f304d624f542503c6.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: improve btf c dump sorting
 stability
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, 
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Date: Fri, 06 Sep 2024 12:56:38 -0700
In-Reply-To: <20240906132453.146085-1-mykyta.yatsenko5@gmail.com>
References: <20240906132453.146085-1-mykyta.yatsenko5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-09-06 at 14:24 +0100, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
>=20
> Existing algorithm for BTF C dump sorting uses only types and names of
> the structs and unions for ordering. As dump contains structs with the
> same names but different contents, relative to each other ordering of
> those structs will be accidental.
> This patch addresses this problem by introducing a new sorting field
> that contains hash of the struct/union field names and types to
> disambiguate comparison of the non-unique named structs.
>=20
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---

Note, this is still not fully stable, e.g.:

$ for i in $(seq 1 10); \
  do touch ./kernel/bpf/verifier.c && \
     ccache-kernel-make.sh -j23 && \
     ./tools/bpf/bpftool/bpftool btf dump file vmlinux format c > ~/work/tm=
p/vmlinux.h.$i; \
  done
  ...
$ md5sum ~/work/tmp/vmlinux.h.* | sort -k1
76c9b22274c4aa6253ffaafa33ceffd3  /home/eddy/work/tmp/vmlinux.h.2
76c9b22274c4aa6253ffaafa33ceffd3  /home/eddy/work/tmp/vmlinux.h.4
a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.1
a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.10
a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.3
a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.5
a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.6
a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.7
a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.8
a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.9

[...]


