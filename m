Return-Path: <bpf+bounces-35067-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 304D69374F9
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 10:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DB9B1C2129E
	for <lists+bpf@lfdr.de>; Fri, 19 Jul 2024 08:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7678E762EF;
	Fri, 19 Jul 2024 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BauxjBLa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA256EB7D
	for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 08:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721377407; cv=none; b=eEsg8wGvPe64MkXcSA/Hos0y4CSMxzKubiD7fV34Uz8+1+t1UJFKEqDNZ7Rn1oD9cwAtc0pmoXLsXoUadwFFHPCVbPSg6cn3lQbZ4TcVDD6Hx/IAbCLs3ld3Zo1jnQBkgi6mcTGcll07m2qiWH7fF7NC2X8lql82ubQn+d+23xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721377407; c=relaxed/simple;
	bh=nPqK5jk06xhbXftOpXQxNALaTxu6Tm//WB3okCjQOuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q43BjFi5l2pnkQu3s6BIDJ9LYVVLt78aNmsClZkKzI/6B6kwqfPTMC9akLrB3DhrGAZRb1pk2FgXx7VwoX+3YiJ4aa9POsC95m7PBjRPvy+KMOT5ZlacaAelNq1w8yzxsiI0BaSD7WLvq6/lnjNx0+1IJzLc46EaWXR0ltfbZm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BauxjBLa; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ee91d9cb71so19800091fa.0
        for <bpf@vger.kernel.org>; Fri, 19 Jul 2024 01:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1721377403; x=1721982203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLs1Em6yWpOViKIdjAmzp2EHbUSxrWl+eIs4kQSeqSU=;
        b=BauxjBLaqEBDXO1hz5cw7Yhml76VAAa8YBa4akth7Qa7Pculw5mCAEXyVkj/Et0wPB
         OfenML0VGvZ93pjMouqyhoOdzrcYzQnmMlh0KSTlMthLkiPu74Vg62wbM3wAp641YrCP
         JbBskMqIq+zrjHJtBDQLB6s3Km9MrpKbciNvpFUOT+LGshO6H+JkDaGGan3LCUlf+aZ5
         +LyhzAp21hHUUoSMT9uBaVh2bVUFRYeLyYq3m9+lZ6JBjK+xSn2RsIoAL2pOYoxq6hN3
         v9ttBFViozbKaQ6xuCGZh9HehIB2pwhtC5A6itMhTM49DsiAaytrZAIL1646RHaAxnVG
         XaiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721377403; x=1721982203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLs1Em6yWpOViKIdjAmzp2EHbUSxrWl+eIs4kQSeqSU=;
        b=rVtTEHINty/UPJmiyaZa5qf/QXhZ0SnBOzgEdzprU8p4tPkUGgXJkeGyj7/+c7qfUw
         fYFD6jpwpz4xHxnD3odqM6ol07sxHFMGeCdpkUmOaBYKiz7SaoxPYML6TUfZVXil9Gd6
         nJ0qauAC/q5Eoe/sqN8KUp5VvCEXsMUUTUFYlSLGNbA0vP2FjCG7W5cZ+KvyyefXjiQZ
         oKTh3DyTyv+0VXPK8FYQKxAOz/V+vncWwOntK+1KiScWKShOUNUmkBxKjM3qbHsq3o8y
         FhmbW3MUlwTfbdNseQatgo1Vbr7PoVAdgq8rhlraY4gpDr9ber+wk1gDMy/SITy0c5ou
         WfEQ==
X-Gm-Message-State: AOJu0Yw2Gv4FZdYt49mZSNgrwnI4aU4S66mPfgN2IUfTaDzNCrFJcfwb
	QOjVd5oQgnqO1tJkT9Khm7XpUGkDC44AQBA7ZeQmvaRBiL4nZqTEGFWGAoC/Qf0=
X-Google-Smtp-Source: AGHT+IFsBhIolO7+GRHI4dCTaNHoBUCns5rPt61TwyPih3yE3YG0+vBqChIBNRw8/OSbT6zRl0SdAg==
X-Received: by 2002:a2e:7c04:0:b0:2ee:854f:45be with SMTP id 38308e7fff4ca-2ef05c78cd2mr31780181fa.12.1721377403242;
        Fri, 19 Jul 2024 01:23:23 -0700 (PDT)
Received: from u94a ([2401:e180:8852:770b:e576:e894:caae:7245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd64d73631sm8573915ad.304.2024.07.19.01.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 01:23:22 -0700 (PDT)
Date: Fri, 19 Jul 2024 16:23:15 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	KP Singh <kpsingh@kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, "Jose E . Marchesi" <jose.marchesi@oracle.com>, 
	James Morris <jamorris@linux.microsoft.com>, Kees Cook <kees@kernel.org>, 
	Brendan Jackman <jackmanb@google.com>, Florent Revest <revest@google.com>
Subject: Re: [PATCH bpf-next v1 5/9] bpf, verifier: improve signed ranges
 inference for BPF_AND
Message-ID: <onr3unastba5zd22wfkgotnrwcipuhznw2k6ip6f2mhlreyu3b@xdbae6cx5ds3>
References: <20240719081749.769748-1-xukuohai@huaweicloud.com>
 <20240719081749.769748-6-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240719081749.769748-6-xukuohai@huaweicloud.com>

On Fri, Jul 19, 2024 at 04:17:45PM GMT, Xu Kuohai wrote:
> From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
> 
> This commit teach the BPF verifier how to infer signed ranges directly
> from signed ranges of the operands to prevent verifier rejection, which
> is needed for the following BPF program's no-alu32 version, as shown by
> Xu Kuohai:
> 
[...]

Ah, I just sent and updated version of this patch[1] about the same time
as you, sorry about not communicating this clearer. Could you use the
update version instead?

Thanks,
Shung-Hsi

0: https://lore.kernel.org/bpf/20240719081702.137173-1-shung-hsi.yu@suse.com/

