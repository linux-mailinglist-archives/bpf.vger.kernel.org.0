Return-Path: <bpf+bounces-67143-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA14FB3F57B
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 08:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8238E1A83EE5
	for <lists+bpf@lfdr.de>; Tue,  2 Sep 2025 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7D6202F93;
	Tue,  2 Sep 2025 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hm/j+ZPI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825C51DFFD
	for <bpf@vger.kernel.org>; Tue,  2 Sep 2025 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794651; cv=none; b=pN28z9XxopQLCgjoChbCUBJvf+pFgNzBB9grkqi7tIdgNhToS1uYV6tJ6KErkSpbAMY/MHnukOzXi+ix88N84clpE+/AvliITPxXHoXlkUH/E8GMFFAJ/m6d3PfZjUKtQRQ7Lg3EraO+RDnxlx0K4dSaaxRdvydtwfMyjdtKM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794651; c=relaxed/simple;
	bh=D9SvvLxhC8sBXwDkRNZZa54C22Gh1LKindMZmxdub48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHP/uRItqMPmtdNEuWXIRcyk3rXfwPaonqDodkuDnr/3+Flmklogg5NSZDQbaQRQEBfj1YETSoXd4Wl7Kij4kg5pNhXn8J+q5K3BsN1d0LtJb+U42CtZkFU/4WQQG/LpjSjfgZrCCXy7K3Qaysis/lEHmFFWgjvDteMi54bzc7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hm/j+ZPI; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3d1bf79d758so2260013f8f.1
        for <bpf@vger.kernel.org>; Mon, 01 Sep 2025 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756794648; x=1757399448; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6N+NYG40wPUqq/tk0Bskx4tffwkmz+AUfjeXOIzwbw0=;
        b=Hm/j+ZPIW8o6BwUe+e1owfSWMz4LuHCyb4Go8rEMSs8tj5uzVL8qkj5R9M+iBgebJL
         RrpBf0WdUGxNC/S4zeYBrfTNy14Zjsv5/WhtPyjq436dN1KCquihWOiz39I61/0bso9D
         TsgBQIYA+M0zgKQDnKmAVyv5xmWTZ8bwk5qcuA0ICI4+u4qMiW/J7JDB00AOXkaTJkfd
         MDZeZGuV/633oTKeGyFDLGcI5If6x7mmeH3I7XVQF5UqcNVVbVxgzxwQOXWq7UMLfxii
         kdZWC6wecV53ljQGMPPdQbIY0KDbolPdQvnDp9j0qARe97xU8Un04OqodBO8Zgy0DCM0
         grHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794648; x=1757399448;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6N+NYG40wPUqq/tk0Bskx4tffwkmz+AUfjeXOIzwbw0=;
        b=dDWdc0/HclESM84eJO8A8HjtTdV/sN8JzczzBhfAXfXOLaVm0S7KoONw9Gh1lMbfOD
         2D/AakPft4TCqLWr3RztbYuizpOedKOw/FBp4SGQ1dUA8qD8a+dcu+cs41hT7R9OlmZ0
         CrsS6MZgk5nDiWW60yg52aCyukTiIkOia8zC6abEak8B1PmIPPZZnPGbyi078ZHmkump
         bOB9t/k1dHRbOenggoRzeqW6vzexmoK0FjIvZFE1BQGWAdnv9rZLOXevTP09kS+do3IA
         WGkI9wcFZul03z1Wu66nMLjbANTu/rx1XM/yGy2Z6m38qFCFTPQkgS8b9rbfisnM3PAk
         KsLw==
X-Gm-Message-State: AOJu0Yz4rTQzvqzLWdjL824mYScaIMiCqY7aP/DqKqu1es9JsRaXZlmy
	wIMhPCBTV9NBNAguBCreK/tm7yMN8j5uFz4uCGCzk3Kwq4mPaSHtYNTVjzZ/KftWgOY=
X-Gm-Gg: ASbGncsPkCDak0dvncrHQzkc3fDQljrRkJipZnm4E7qzZ57M+DKCH+4kLWA+sbpjnlh
	mHzTDZM7/FECPzkB+wtgEosqCE4NcJOQ9ZZ2BwiTZVcnB5UR9A851N0p5A+Wdx8CNCvtZLN15Rk
	a7nEoh13EBcAhiHSR2aezL43z8nybogKE5H+IbTzFU5flVP/nqO/2mRIjuRagBDcmqScp0s9k5+
	NCV0aPRNCEQeIcWZcXbtWHPnfkZLCJ35OkhBWX18gXXit1BeVKNMqBmvRoDUtDE0GXfZDBwwHhr
	5jZTz7kv1HNk5UTUGi06+ebuwVu0Df6qZrz66TkaccLeuMOV7lAwIgc7qXSDaLh0RNniW2ZO4c7
	TjmZUsNU4iysrz+9ToF8=
X-Google-Smtp-Source: AGHT+IGGbbeivkL1QlhhYEOAVIduuA4ZjfMvtHd/qtBODmjxbQxMeEG8M4b9459RIrLSPK9v3cENQQ==
X-Received: by 2002:a05:6000:18a3:b0:3cd:b3f7:bb62 with SMTP id ffacd0b85a97d-3d1e01d6734mr8681230f8f.45.1756794647741;
        Mon, 01 Sep 2025 23:30:47 -0700 (PDT)
Received: from u94a ([2401:e180:8d68:174d:687c:db9d:19bb:6954])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329e445d875sm805894a91.11.2025.09.01.23.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:30:47 -0700 (PDT)
Date: Tue, 2 Sep 2025 14:30:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH bpf] MAINTAINERS: add Shung-Hsi as reviewer for BPF CORE
Message-ID: <cbta4qgicer3doijm3qx6ikrdyywsbs7hsl3xecuaubld4mxrn@4qvhsqsd56yu>
References: <20250829074544.104182-1-shung-hsi.yu@suse.com>
 <CAADnVQ+BKx6EjQ=ezqQZGVP3HBkzp53kSspo1dVZKc0NL9Or1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+BKx6EjQ=ezqQZGVP3HBkzp53kSspo1dVZKc0NL9Or1w@mail.gmail.com>

On Sun, Aug 31, 2025 at 06:13:25PM -0700, Alexei Starovoitov wrote:
> On Fri, Aug 29, 2025 at 12:45 AM Shung-Hsi Yu <shung-hsi.yu@suse.com> wrote:
> >
> > Add myself as a reviewer for BPF CORE, focusing mainly on verifier and
> > tnum.
> >
> > Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> > ---
> > Hope getting myself involved in mail loop would be the nudge I need that
> > gets me to do reviews more consistently.
> 
> I'm afraid that will be an abuse of the checkpatch.pl mechanism
> for reminders like this. Your reviews are very much appreciated,

Thanks!

> but please figure out a different way to highlight patches
> in your inbox. For example, gmail can send patches with "tnum"
> content to a different folder, and so on.

Okay. I do have a very crude l2md + local mail filtering setup up, will
try to improve upon it first as suggested.

Shung-Hsi

