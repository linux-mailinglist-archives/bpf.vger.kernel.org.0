Return-Path: <bpf+bounces-39167-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72DC96FD0A
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 23:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 185DDB246EA
	for <lists+bpf@lfdr.de>; Fri,  6 Sep 2024 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0081D6DA0;
	Fri,  6 Sep 2024 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+NIBc4W"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792921D6792
	for <bpf@vger.kernel.org>; Fri,  6 Sep 2024 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725656864; cv=none; b=pwpg6cGbi1V1Cszot5GEIqDPYXEPv5S/WFFfdxCCIxNxUwBbmseTp7PY2kFndg7IOVxpBgYkD5LrYemAgW0pT1QqXB39541WCjPN+dGQ9ABR/er8kVSEYRt4y4a5s9n3PNHQCVIGOvdaooCkTOb66sQd5+oDF0Rp1N7xJo9tCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725656864; c=relaxed/simple;
	bh=xRgLmX8suNsE8Gz0OicAsOsvAg1cvIrdCFJeQD6F5eI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFB67tB26VkmWUZPmk2FZ+RREnE7g2YqrzNgAK4ZwUEpV2OgIXZ3yOer2wUGBI/VhW4sRG0s5WCLOWK5yOciSBgLB/1lXAIV+S3TTnMkLBUyMZakVkMnRes0U6l/wOfHgn8wyghrpBc3vFB8Xuz3LnrXeCJmYe7hxtxZdqRw/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+NIBc4W; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7cd9cfe4748so2056158a12.2
        for <bpf@vger.kernel.org>; Fri, 06 Sep 2024 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725656863; x=1726261663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R98eadDn3bu5YIppWd5lXPtONyCTav3SDWqeFfa4gxU=;
        b=g+NIBc4Wg+JznfPh22+vcC+MHbBZ4x3jXSd9zKb1VWNmC+RaCa4gHIwSwFbiqUQAyt
         loin86pQtZBL4tFU7qMJQ5uBRcJMplai+XM7VrdCa+hRJ1UFq9vilq3jGrl3JAtQVoPC
         e2tnKSr7/BK/+N8U0EKJlp886I7Npq/lUdoX5CdsOSqJW3GFxQtKCqAjYbbEvabPKILv
         GsXMaNpxpj2v8LBEuNuvJezmh4VeRxGI4eZN0Iwseoo0RWUGbBAZ/Z4GnQ2vmNeLV/1l
         mT6MwPhTEJ3NMa//ue6gfnaB7n303CwnvM82zq3/PrawonZdq5Xd2HFEQWvuDnvcI6pW
         Vhjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725656863; x=1726261663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R98eadDn3bu5YIppWd5lXPtONyCTav3SDWqeFfa4gxU=;
        b=Se0V6RpSBQxg079mSh6D0lzq8zsSf3Ah2H/oftekhOLfV95weHLym7We7D/ZZkc4dr
         05MiirtkDM14rq5NRkjUg+j/ak2D0LGzjZDYlnBatXTivYCYHP+ARxFINVKYTvYUbloQ
         XjYG+v4ZsYd5Nk8mAI4z31SQg5adATid2L96a2Hbkjq6+yedu7h6YIVc7PGBSQj4PXBV
         yi7/l/O3Vm9GtCLkYNLTXr679Svsyo+runOlnBZkjw0IPDA8O7c793byAJD3wwjWcGV7
         Q9tTc1muIjCDrgrXfdrp4FGRrqA4kKfn+s3ox7PELjiktPT1b6RDpUBtaUUBhP91z1kK
         3Csw==
X-Forwarded-Encrypted: i=1; AJvYcCWguLpk0UWZLCY4wl3FJHPu2Wkn7m7smBQ2lIH8Lf3syVx7oWQdg9E7lw51Cxv3nFQSpUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn1l7EcS79yrj9M2cV3HrVVODtlqck/RlH4lRkaCxC0IvDoWLM
	yAiS9OpM5WyFPrjE/kZZKrCFnf0c00wBpOyUXhiyigcqleOjfyFzu26jXT3tBzlPcVaBn/4vH6m
	8iPepN37P1BTa8qSa61FpBsIW/F0=
X-Google-Smtp-Source: AGHT+IG61/V2r2KdTERpJjFSq+sUAycCLAxXgTUxA4TJsWrw3gHzpSEcei6DiCyi0PWNAkHrs9omLVwYAp6E8K0Rb/4=
X-Received: by 2002:a17:90b:ec6:b0:2d8:d58b:52c8 with SMTP id
 98e67ed59e1d1-2dad505d5a0mr4496348a91.19.1725656862604; Fri, 06 Sep 2024
 14:07:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906132453.146085-1-mykyta.yatsenko5@gmail.com> <6e88208543c2bf9d75d9418f304d624f542503c6.camel@gmail.com>
In-Reply-To: <6e88208543c2bf9d75d9418f304d624f542503c6.camel@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 6 Sep 2024 14:07:30 -0700
Message-ID: <CAEf4BzavhpFDcNgk1a0+V3+pHHMw6y2Rw_VMWEOJXWNaJQC+Ew@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpftool: improve btf c dump sorting stability
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 12:56=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2024-09-06 at 14:24 +0100, Mykyta Yatsenko wrote:
> > From: Mykyta Yatsenko <yatsenko@meta.com>
> >
> > Existing algorithm for BTF C dump sorting uses only types and names of
> > the structs and unions for ordering. As dump contains structs with the
> > same names but different contents, relative to each other ordering of
> > those structs will be accidental.
> > This patch addresses this problem by introducing a new sorting field
> > that contains hash of the struct/union field names and types to
> > disambiguate comparison of the non-unique named structs.
> >
> > Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> > ---
>
> Note, this is still not fully stable, e.g.:
>
> $ for i in $(seq 1 10); \
>   do touch ./kernel/bpf/verifier.c && \
>      ccache-kernel-make.sh -j23 && \
>      ./tools/bpf/bpftool/bpftool btf dump file vmlinux format c > ~/work/=
tmp/vmlinux.h.$i; \
>   done
>   ...
> $ md5sum ~/work/tmp/vmlinux.h.* | sort -k1
> 76c9b22274c4aa6253ffaafa33ceffd3  /home/eddy/work/tmp/vmlinux.h.2
> 76c9b22274c4aa6253ffaafa33ceffd3  /home/eddy/work/tmp/vmlinux.h.4
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.1
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.10
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.3
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.5
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.6
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.7
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.8
> a1c90a62e6cca59869a9cdffbaa3c4de  /home/eddy/work/tmp/vmlinux.h.9

Still, quite stable, compared to what it is right now. I think the
second part is more consistent ordering between CUs inside the pahole
to keep it even more stable.

Applied to bpf-next, thanks!

>
> [...]
>

