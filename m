Return-Path: <bpf+bounces-33230-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA02391A18E
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 10:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E982845D5
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 08:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E857E131E38;
	Thu, 27 Jun 2024 08:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MDFXzpOA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004B3757EA;
	Thu, 27 Jun 2024 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477157; cv=none; b=oakuCfXApgyRph4K6fvJngVBDfK9AT5Pn8jsWsRavfmcUlJAFF3KBSJs67eLFMUrlIAaLTxVT6uDeLvcVFg0FrS+Wh2JvnZg6UOaciaYG9LCRm6VRs9Vu/E33l0WZmlvChiq33a1N9v/SY8psHg8XfOTintHRx7oB91PPLDnAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477157; c=relaxed/simple;
	bh=+Ifiwjq0KKcI1KIqnb5DKKR2xyy5RnFEGGxZzQsnXzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZwsdRQExBBGnh7ta9RBPsGQeKz6EWV3R5UHjYeusbO+soulon+/ExYp0f0Y2PTeMzyXtOTIUEEwkudiLdKGDF7mknST/sks6BAfT7m4RFzjR/HO6m84OTE5kf8MU+2DIomGKLfLfDl3IolD7e6E/6v41du4m13DggRNmtPnmTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MDFXzpOA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d07673185so1438723a12.1;
        Thu, 27 Jun 2024 01:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719477154; x=1720081954; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NWlJWb3kbLUzg9B1OlrNd7keovxw2bRZ5oxJbQGYIqQ=;
        b=MDFXzpOAiZtBgqLS+rFLQ0rFlY0RFIcLtCHWqel9x3Wv8XqV/iAXEi2dS1sbNgF0cB
         1OQhTVsSiTk5mRsMNDSdPMMDHuN/5vR8HLcCUdC+794ogn+dHAniESF3+OQaSF+RBfES
         mwVXMUrH7R5Y6OEkYrlb9emmyBompQj2MOkmxpOuWv9LFH63TujYL63fRLDNGEaTHCnD
         OSPtlybhkEG5nFjCt/MA6qgApZHU8/uuFkxhEuL0tdrjsqu6qcpzjZoN8HBye9zdhtwn
         7hZvT9drghAq70fyrzkelpiCdvK3e0SW8iC4Bc750So0G3x9YhGDoRQGGYK6PCfb7b5p
         qHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719477154; x=1720081954;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWlJWb3kbLUzg9B1OlrNd7keovxw2bRZ5oxJbQGYIqQ=;
        b=EPoULxUMo3sh7PKKhW/hTcfRdo0MxF52FANjoFbIwubSPDMp2JCrfqDZBcsH8FWQZN
         Fqvu81ns3v5Llo7h+KW0ecfGU+515DYS5QgMk/85lEMKnyuzPXrmQwQaF+C+F1IsWlmv
         Itj+TQ5yMQNiZ50VKg4tnZU87MtPF+s81QIJkuWdTmOtBZ+h0NQuyXNIYlsitQqKn7p4
         CUg9AS/t5GOwq/ovRklW7UPVXH+QuOTjznDqTza/OxwabxCXnm64gVg2oCkVNQwWDlQz
         UuZjVblJg5WiXxlhUfOodlvuYU+1/DMQBAyxIDxS+Gdfdz7VmpxRp3BclWXNcNMkV25k
         tkog==
X-Forwarded-Encrypted: i=1; AJvYcCUYYojSWkYfGLjs2zt7sVI3LH3JGVDW/HygDsL3YLm5YMTmH3XcTSkz2gW+8xbM3Yy3IHwRHBcwWoeH+1fIhGSoghD1qLvXBaWRZBDwzHTrlVzplolfacxICJRmVTIWLtrD
X-Gm-Message-State: AOJu0YxGNVKJPWOo51i7c7mKLgg3HBQTRD3Qf5GioLKhJzzpVdIdAwvJ
	dp4Gx2xkrU5yhVvCpdBHO1S5nMGwcgK2iwIu8dzyR1v5OQQ77cw=
X-Google-Smtp-Source: AGHT+IE/ALZbAcAMvsfFAtdrEGndhCN4Qv+TaQMIEb5Gjwca0gTzTR8esXHgCGvz7pjQILIzrAF3Ig==
X-Received: by 2002:a50:bac3:0:b0:57c:7471:a0dd with SMTP id 4fb4d7f45d1cf-57d4a2815a6mr11921829a12.12.1719477153933;
        Thu, 27 Jun 2024 01:32:33 -0700 (PDT)
Received: from localhost (host-79-55-123-4.retail.telecomitalia.it. [79.55.123.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d2d4f16fsm557362a12.92.2024.06.27.01.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jun 2024 01:32:33 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:32:32 +0200
From: Andrea Righi <righi.andrea@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: torvalds@linux-foundation.org, mingo@redhat.com, peterz@infradead.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	martin.lau@kernel.org, joshdon@google.com, brho@google.com,
	pjt@google.com, derkling@google.com, haoluo@google.com,
	dvernet@meta.com, dschatzberg@meta.com, dskarlat@cs.cmu.edu,
	riel@surriel.com, changwoo@igalia.com, himadrics@inria.fr,
	memxor@gmail.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 09/30] sched_ext: Implement BPF extensible scheduler class
Message-ID: <Zn0joEebAdwjiTyT@gpd>
References: <20240618212056.2833381-1-tj@kernel.org>
 <20240618212056.2833381-10-tj@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618212056.2833381-10-tj@kernel.org>

On Tue, Jun 18, 2024 at 11:17:24AM -1000, Tejun Heo wrote:
...
> +	/**
> +	 * set_weight - Set task weight
> +	 * @p: task to set weight for
> +	 * @weight: new eight [1..10000]

Small nit: eight -> weight

> +	 *
> +	 * Update @p's weight to @weight.
> +	 */
> +	void (*set_weight)(struct task_struct *p, u32 weight);

-Andrea

