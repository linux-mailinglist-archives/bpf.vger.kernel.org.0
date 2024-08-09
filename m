Return-Path: <bpf+bounces-36803-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9424E94D8BD
	for <lists+bpf@lfdr.de>; Sat, 10 Aug 2024 00:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA7DA1C222B0
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 22:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B74616728B;
	Fri,  9 Aug 2024 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G4NqDJVL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434F62233B
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 22:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723242621; cv=none; b=niUIH9CDXtQjxlrkdNLk5Qd9LM6ievO1anwxcq085OjjQnPShaodz6CXUiiskqR7x666XF77iktYRca6VLPhCbv5ZyNdIWhx/BaasVwXx+WT8LncSEKFuOAmLqIHvJayJqhCA9Rres3FHmlbYR3QpQzQtEIVISrpDq3TeD5Gi+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723242621; c=relaxed/simple;
	bh=EtzFbuVPHZlkrKR27ilarX1ZeBzMxQMrE/87iU94YjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XWROx+Mbu2+1C5n2abNQMZmLfXnDKBDB3GkvGJ1LGTEGtyjXK9CkHffGdD73E5XO0XKrC9k+QMdHVTL4fMmzIa31OXRyNiR+RJaiAh+bo1QVILfU4cPJR6iPhpyrZjzC4sI3epkdrCeZOolNegsgcA3PrK6G5WiUtuHq1e6SlG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G4NqDJVL; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fd7509397bso57935ad.0
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2024 15:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723242620; x=1723847420; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EtzFbuVPHZlkrKR27ilarX1ZeBzMxQMrE/87iU94YjY=;
        b=G4NqDJVL9zb/3+sLRcfjfn0ErqsoqbMV507EwS7DRtmz0aPqamB5hzsoBgUVtaJi+0
         wZZCb2AU9XRFYYFyLlBfIIJPTz4mmPKBjXgfoBOwONJ+R64EMddBu0RKjF0/7m11hLFV
         v/2YImLuIBMr+Zr3G7dQSD5xwITnLlX9nGfpReaqDiyMqAGaEu9k5j8gzd6T8de2TwFG
         G9cQbGkFoDhh8nV22lodSQ8jH5V3w12x1DpWe0v6Du1Re9VS/dt/5TvSav0vxEBWtjI6
         ksjTg7nYmNHqww2xlO9KCAFMJScBfhPMDt1CpKiVkj4hsRHcQ0kVdu7xUSy+gjzakQYr
         o8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723242620; x=1723847420;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtzFbuVPHZlkrKR27ilarX1ZeBzMxQMrE/87iU94YjY=;
        b=YgQfxCu2oeFfSoaejbJ4iBtxvE5MNavQrQ6IahNterQNFh2EGmpI6oIMvdY1Hyopm3
         N7epx1gBTxX9jXMhHzxcQppcVQIsvdt+LNFEVGUNVRLYG8udZhNAaUtX6QhiPmLzQqe1
         o+Ahf4Y8b1UMdvN6DuFscDcIpitasQkI8AcPSuHaMy/xKVzq7+JC6xa/9eu8fcVLPJPf
         d6zJF7QxRO7mxRyFISsQWx2DX72qkpzdPQ7cZZrox8+1wSzY22d5oTyGgadJE+ugO3Nm
         wmvYvLIRBKjgzT+xauxlApO3DqfPQ0pSfPiRurZvehKY8WEJJK2LfFqINAVZUEM6TVbE
         RKkw==
X-Forwarded-Encrypted: i=1; AJvYcCWnisNC+9QpuzXU+2L7yO5FixW6wdTl459gZ9NscZEhVqO4o0D5YHzl1K8OwX3ump+d+ORptutYhoUpPrM8+cu+uMdp
X-Gm-Message-State: AOJu0Yzxuq+eS+hBYt8iadIEfxhBamCfKbRiqf5QYeQyVSTqqIYNoRf2
	mZjy1X90Qnd+SytdPMep8DAyqQcYQrZ46RlaBj1RfpYP4lpeyMGgY975Zw0O9Q==
X-Google-Smtp-Source: AGHT+IGhV/jymXpMk0NJArHdW5dY79xsVBdr7aAI+QtWzjWWjA+9DMYLKnIWUHkJY8gotZ+mlgLD3g==
X-Received: by 2002:a17:902:c782:b0:1f9:d111:8a1e with SMTP id d9443c01a7336-200bbe3ff34mr909825ad.26.1723242619139;
        Fri, 09 Aug 2024 15:30:19 -0700 (PDT)
Received: from google.com (99.34.197.35.bc.googleusercontent.com. [35.197.34.99])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5ac36f7sm234052b3a.212.2024.08.09.15.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 15:30:18 -0700 (PDT)
Date: Fri, 9 Aug 2024 22:30:13 +0000
From: Neill Kapron <nkapron@google.com>
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org,
	yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, mcgrof@kernel.org, masahiroy@kernel.org,
	nathan@kernel.org, mykolal@fb.com, dxu@dxuuu.xyz,
	bpf@vger.kernel.org
Subject: Re: [PATCH v6 bpf-next 3/9] libbpf: split BTF relocation
Message-ID: <ZraYdV9NjDd0w3oO@google.com>
References: <20240613095014.357981-1-alan.maguire@oracle.com>
 <20240613095014.357981-4-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240613095014.357981-4-alan.maguire@oracle.com>

On Thu, Jun 13, 2024 at 10:50:08AM +0100, Alan Maguire wrote:

[...]

> diff --git a/tools/lib/bpf/btf_relocate.c b/tools/lib/bpf/btf_relocate.c
> new file mode 100644
> index 000000000000..eabb8755f662
> --- /dev/null
> +++ b/tools/lib/bpf/btf_relocate.c
> @@ -0,0 +1,506 @@
> +// SPDX-License-Identifier: GPL-2.0
Did you mean to license this GPL-2.0? [1] states the code should
licensed BSD-2-Clause OR LGPL-2.1

[...]

[1] https://github.com/libbpf/libbpf?tab=readme-ov-file#license

